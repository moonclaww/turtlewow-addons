#!/usr/bin/env python3
"""
TurtleWoW Zone Data Extraction Script

Extracts zone/map data from existing pfQuest data files and generates:
- astrolabe_turtle_data.lua: WorldMapSize extensions for TurtleWoW zones
- babble_zone_turtle.lua: Missing zone translations (if any)
- tourist_turtle_zones.lua: Zone metadata for Tourist-2.0
- zone_turtle_data.lua: QuestieZones extensions

Data sources:
- pfQuest/toolbox/client-data.sql: WorldMapArea_turtle table
- pfQuest-turtle/db/zhCN/zones-turtle.lua: Zone name translations
"""

import re
import os
from dataclasses import dataclass
from typing import Dict, List, Optional, Tuple

# Paths relative to script location
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SQL_PATH = os.path.join(SCRIPT_DIR, "pfQuest", "toolbox", "client-data.sql")
ZONES_TURTLE_PATH = os.path.join(SCRIPT_DIR, "pfQuest-turtle", "db", "zhCN", "zones-turtle.lua")
OUTPUT_DIR = os.path.dirname(SCRIPT_DIR)  # !Questie folder

# Continent mapIDs
KALIMDOR_MAP_ID = 1
EASTERN_KINGDOMS_MAP_ID = 0

# Continent boundaries from WorldMapArea_turtle
# Kalimdor: INSERT INTO `WorldMapArea_turtle` VALUES (13, 1, 0, "Kalimdor", -11733.299805, -19733.210938, 12799.900391, 17066.599609);
# Azeroth: INSERT INTO `WorldMapArea_turtle` VALUES (14, 0, 0, "Azeroth", -16000.000000, -19199.900391, 7466.600098, 16000.000000);
CONTINENT_BOUNDS = {
    1: {"name": "Kalimdor", "x_min": -11733.299805, "y_min": -19733.210938, "x_max": 12799.900391, "y_max": 17066.599609},
    0: {"name": "Azeroth", "x_min": -16000.0, "y_min": -19199.900391, "x_max": 7466.600098, "y_max": 16000.0},
}


@dataclass
class WorldMapArea:
    """Represents a WorldMapArea entry from client-data.sql"""
    zone_id: int
    map_id: int
    area_table_id: int
    name: str
    x_min: float
    y_min: float
    x_max: float
    y_max: float

    @property
    def width(self) -> float:
        return abs(self.x_max - self.x_min)

    @property
    def height(self) -> float:
        return abs(self.y_max - self.y_min)

    def get_offset(self, continent_bounds: dict) -> Tuple[float, float]:
        """Calculate zone offset relative to continent"""
        x_offset = self.x_min - continent_bounds["x_min"]
        y_offset = self.y_min - continent_bounds["y_min"]
        return x_offset, y_offset


def parse_world_map_area_turtle(sql_path: str) -> Dict[int, WorldMapArea]:
    """Parse WorldMapArea_turtle entries from client-data.sql"""
    areas = {}
    
    # Pattern to match INSERT statements
    pattern = re.compile(
        r'INSERT INTO `WorldMapArea_turtle` VALUES '
        r'\((\d+),\s*(\d+),\s*(\d+),\s*"([^"]*)",\s*'
        r'(-?[\d.]+),\s*(-?[\d.]+),\s*(-?[\d.]+),\s*(-?[\d.]+)\);'
    )
    
    with open(sql_path, 'r', encoding='utf-8') as f:
        for line in f:
            match = pattern.search(line)
            if match:
                area = WorldMapArea(
                    zone_id=int(match.group(1)),
                    map_id=int(match.group(2)),
                    area_table_id=int(match.group(3)),
                    name=match.group(4),
                    x_min=float(match.group(5)),
                    y_min=float(match.group(6)),
                    x_max=float(match.group(7)),
                    y_max=float(match.group(8)),
                )
                areas[area.zone_id] = area
    
    return areas


def parse_zones_turtle_lua(lua_path: str) -> Dict[int, str]:
    """Parse zone names from zones-turtle.lua"""
    zones = {}
    
    # Pattern to match [id] = "name" entries
    pattern = re.compile(r'\[(\d+)\]\s*=\s*"([^"]+)"')
    
    with open(lua_path, 'r', encoding='utf-8') as f:
        for line in f:
            match = pattern.search(line)
            if match:
                area_id = int(match.group(1))
                name = match.group(2)
                zones[area_id] = name
    
    return zones


def identify_turtle_zones(areas: Dict[int, WorldMapArea]) -> Dict[int, WorldMapArea]:
    """Identify TurtleWoW-specific zones (area_table_id >= 5000 or known custom zones)"""
    turtle_zones = {}
    
    # TurtleWoW custom zones typically have area_table_id >= 5000
    # Also include some known TurtleWoW zones with lower IDs
    known_turtle_ids = {
        876,    # GM Island
        2040,   # Alsarath / Quel'Thalas
        4012,   # Scarlet Enclave
    }
    
    for zone_id, area in areas.items():
        if area.area_table_id >= 5000 or area.area_table_id in known_turtle_ids:
            turtle_zones[zone_id] = area
    
    return turtle_zones


def get_parent_continent(map_id: int) -> Optional[int]:
    """Get the parent continent for a map"""
    # MapID to continent mapping for common instances and zones
    # 0 = Eastern Kingdoms, 1 = Kalimdor
    # Instance mapIDs have their own parent continents
    
    # Eastern Kingdoms instances and zones
    ek_maps = {
        0, 33, 34, 35, 36, 47, 70, 90, 109, 129, 189, 229, 230, 249, 269, 289, 
        309, 329, 349, 369, 429, 469, 489, 509, 531, 532, 533, 800, 801, 814, 
        815, 816, 818
    }
    
    # Kalimdor instances and zones
    kalimdor_maps = {
        1, 27, 30, 31, 43, 48, 209, 389, 409, 802, 807, 808, 813
    }
    
    if map_id in ek_maps:
        return 0  # Eastern Kingdoms
    elif map_id in kalimdor_maps:
        return 1  # Kalimdor
    else:
        return None  # Unknown


def generate_astrolabe_data(areas: Dict[int, WorldMapArea], zones_zhcn: Dict[int, str]) -> str:
    """Generate Lua code for Astrolabe WorldMapSize extensions"""
    
    lines = [
        "-- TurtleWoW Zone Data for Astrolabe",
        "-- Auto-generated by extract_turtle_zones.py",
        "-- DO NOT EDIT MANUALLY",
        "",
        "if not QuestieIsTurtleWoW then return end",
        "",
        "-- Extend WorldMapSize with TurtleWoW-specific zones",
        "local function ExtendAstrolabeData()",
        "    if not WorldMapSize then return end",
        "",
    ]
    
    # Group zones by continent/map
    by_map = {}
    for zone_id, area in areas.items():
        if area.map_id not in by_map:
            by_map[area.map_id] = []
        by_map[area.map_id].append((zone_id, area))
    
    # Generate data for outdoor TurtleWoW zones on main continents
    for map_id in [0, 1]:  # Eastern Kingdoms, Kalimdor
        continent_name = "Eastern Kingdoms" if map_id == 0 else "Kalimdor"
        continent_id = 2 if map_id == 0 else 1  # Astrolabe uses 1=Kalimdor, 2=EK
        
        if map_id not in by_map:
            continue
            
        continent_bounds = CONTINENT_BOUNDS.get(map_id)
        if not continent_bounds:
            continue
        
        lines.append(f"    -- {continent_name} TurtleWoW Zones")
        lines.append(f"    if WorldMapSize[{continent_id}] and WorldMapSize[{continent_id}].zoneData then")
        
        for zone_id, area in sorted(by_map[map_id], key=lambda x: x[1].name):
            # Skip continent entries themselves and empty names
            if area.area_table_id == 0 or not area.name:
                continue
            
            # Skip if not a TurtleWoW-specific zone
            if area.area_table_id < 5000 and area.area_table_id not in {876, 2040, 4012}:
                continue
            
            x_offset, y_offset = area.get_offset(continent_bounds)
            zone_name = area.name
            zhcn_name = zones_zhcn.get(area.area_table_id, "")
            
            lines.append(f"        -- {zone_name} ({zhcn_name}) [AreaTableID: {area.area_table_id}]")
            lines.append(f"        if not WorldMapSize[{continent_id}].zoneData.{zone_name} then")
            lines.append(f"            WorldMapSize[{continent_id}].zoneData.{zone_name} = {{")
            lines.append(f"                height = {area.height},")
            lines.append(f"                width = {area.width},")
            lines.append(f"                xOffset = {x_offset},")
            lines.append(f"                yOffset = {y_offset},")
            lines.append(f"            }}")
            lines.append(f"        end")
        
        lines.append(f"    end")
        lines.append("")
    
    # Generate data for TurtleWoW instances (separate maps)
    instance_maps = {}
    for zone_id, area in areas.items():
        if area.map_id not in [0, 1] and area.area_table_id >= 5000:
            if area.map_id not in instance_maps:
                instance_maps[area.map_id] = []
            instance_maps[area.map_id].append((zone_id, area))
    
    if instance_maps:
        lines.append("    -- TurtleWoW Instance Maps")
        for map_id, zones in sorted(instance_maps.items()):
            parent = get_parent_continent(map_id)
            if parent is None:
                parent = 0  # Default to Eastern Kingdoms
            
            for zone_id, area in zones:
                if not area.name or area.width == 0 or area.height == 0:
                    continue
                    
                zhcn_name = zones_zhcn.get(area.area_table_id, "")
                
                # Create instance map entry
                lines.append(f"    -- Instance: {area.name} ({zhcn_name}) [MapID: {map_id}, AreaTableID: {area.area_table_id}]")
                lines.append(f"    if not WorldMapSize[{zone_id}] then")
                lines.append(f"        WorldMapSize[{zone_id}] = {{")
                lines.append(f"            parentContinent = {parent},")
                lines.append(f"            height = {area.height},")
                lines.append(f"            width = {area.width},")
                lines.append(f"            xOffset = 0,")
                lines.append(f"            yOffset = 0,")
                lines.append(f"        }}")
                lines.append(f"    end")
        lines.append("")
    
    lines.extend([
        "end",
        "",
        "-- Register to run after Astrolabe initializes",
        "if Astrolabe and Astrolabe.RegisterCallback then",
        "    Astrolabe:RegisterCallback('Initialize', ExtendAstrolabeData)",
        "else",
        "    -- Fallback: run immediately after a short delay",
        "    local frame = CreateFrame('Frame')",
        "    frame:SetScript('OnUpdate', function()",
        "        this:SetScript('OnUpdate', nil)",
        "        ExtendAstrolabeData()",
        "    end)",
        "end",
    ])
    
    return "\n".join(lines)


def generate_babble_zone_data(areas: Dict[int, WorldMapArea], zones_zhcn: Dict[int, str]) -> str:
    """Generate Lua code for Babble-Zone-2.2 extensions"""
    
    # English to zhCN mappings for TurtleWoW zones
    zone_translations = {}
    
    for zone_id, area in areas.items():
        if area.area_table_id >= 5000 or area.area_table_id in {876, 2040, 4012}:
            if area.name and area.area_table_id in zones_zhcn:
                # Convert internal name to display name
                display_name = area.name
                # Handle some common transformations
                if display_name == "Icepoint":
                    display_name = "Frostpoint"
                elif display_name == "TelAbim":
                    display_name = "Telabim"
                elif display_name == "GrimReaches":
                    display_name = "Cold Coast"
                    
                zone_translations[display_name] = zones_zhcn[area.area_table_id]
    
    lines = [
        "-- TurtleWoW Zone Translations for Babble-Zone-2.2",
        "-- Auto-generated by extract_turtle_zones.py",
        "-- DO NOT EDIT MANUALLY",
        "",
        "if not QuestieIsTurtleWoW then return end",
        "",
        "-- Register additional TurtleWoW zone translations",
        "local BabbleZone = AceLibrary('Babble-Zone-2.2')",
        "if not BabbleZone then return end",
        "",
        "-- These zones may already exist in Babble-Zone-2.2",
        "-- This file ensures completeness for all TurtleWoW custom zones",
        "BabbleZone:RegisterTranslations('zhCN', function()",
        "    return {",
    ]
    
    for name, zhcn in sorted(zone_translations.items()):
        lines.append(f'        ["{name}"] = "{zhcn}",')
    
    lines.extend([
        "    }",
        "end)",
    ])
    
    return "\n".join(lines)


def generate_tourist_data(areas: Dict[int, WorldMapArea], zones_zhcn: Dict[int, str]) -> str:
    """Generate Lua code for Tourist-2.0 extensions"""
    
    # TurtleWoW zone metadata (level ranges, types, factions)
    # This is manually curated based on TurtleWoW wiki/documentation
    turtle_zone_meta = {
        # Outdoor Zones - Kalimdor
        "GMIsland": {"low": 1, "high": 60, "continent": "Kalimdor", "faction": "Contested"},
        "Icepoint": {"low": 50, "high": 60, "continent": "Kalimdor", "faction": "Contested", "alias": "Frostpoint"},
        "TelAbim": {"low": 35, "high": 45, "continent": "Kalimdor", "faction": "Contested", "alias": "Telabim"},
        "BlackstoneIsland": {"low": 45, "high": 55, "continent": "Kalimdor", "faction": "Contested"},
        "Hyjal": {"low": 55, "high": 60, "continent": "Kalimdor", "faction": "Contested"},
        "Sunnyglade": {"low": 1, "high": 10, "continent": "Kalimdor", "faction": "Alliance"},
        
        # Outdoor Zones - Eastern Kingdoms
        "Gilneas": {"low": 18, "high": 30, "continent": "Eastern Kingdoms", "faction": "Contested"},
        "ThalassianHighlands": {"low": 50, "high": 60, "continent": "Eastern Kingdoms", "faction": "Contested", "alias": "Salas Highlands"},
        "Balor": {"low": 35, "high": 45, "continent": "Eastern Kingdoms", "faction": "Contested"},
        "Northwind": {"low": 40, "high": 50, "continent": "Eastern Kingdoms", "faction": "Contested"},
        "GrimReaches": {"low": 55, "high": 60, "continent": "Eastern Kingdoms", "faction": "Contested", "alias": "Cold Coast"},
        "ScarletEnclave": {"low": 55, "high": 60, "continent": "Eastern Kingdoms", "faction": "Contested"},
        "AlahThalas": {"low": 50, "high": 60, "continent": "Eastern Kingdoms", "faction": "Contested", "alias": "Alsarath"},
        "Gillijim": {"low": 30, "high": 40, "continent": "Eastern Kingdoms", "faction": "Contested", "alias": "Gillijim's Isle"},
        "Lapidis": {"low": 35, "high": 45, "continent": "Eastern Kingdoms", "faction": "Contested", "alias": "Lapidis Isle"},
        
        # Instances
        "CrescentGrove": {"low": 25, "high": 35, "continent": "Kalimdor", "instance": True, "group": 5},
        "KarazhanCrypt": {"low": 55, "high": 60, "continent": "Eastern Kingdoms", "instance": True, "group": 5},
        "StormwindVault": {"low": 55, "high": 60, "continent": "Eastern Kingdoms", "instance": True, "group": 5},
        "EmeraldSanctum": {"low": 60, "high": 60, "continent": "Kalimdor", "instance": True, "group": 40},
        "HateforgeQuarry": {"low": 50, "high": 60, "continent": "Eastern Kingdoms", "instance": True, "group": 5},
        "WinterVeilVale": {"low": 1, "high": 60, "continent": "Eastern Kingdoms", "instance": True, "group": 5},
        "GilneasCity": {"low": 25, "high": 35, "continent": "Eastern Kingdoms", "instance": True, "group": 5},
        "DragonmawRetreat": {"low": 55, "high": 60, "continent": "Eastern Kingdoms", "instance": True, "group": 5},
        "UpperKarazhan": {"low": 60, "high": 60, "continent": "Eastern Kingdoms", "instance": True, "group": 10},
    }
    
    lines = [
        "-- TurtleWoW Zone Metadata for Tourist-2.0",
        "-- Auto-generated by extract_turtle_zones.py",
        "-- DO NOT EDIT MANUALLY",
        "",
        "if not QuestieIsTurtleWoW then return end",
        "",
        "local Tourist = AceLibrary('Tourist-2.0')",
        "if not Tourist then return end",
        "",
        "-- Extend Tourist with TurtleWoW zone data",
        "local function ExtendTouristData()",
        "    local BabbleZone = AceLibrary('Babble-Zone-2.2')",
        "    if not BabbleZone then return end",
        "    local Z = BabbleZone",
        "",
        "    -- TurtleWoW Zone Level Ranges",
        "    local turtleLows = {",
    ]
    
    for name, meta in sorted(turtle_zone_meta.items()):
        display = meta.get("alias", name)
        lines.append(f'        [Z["{display}"]] = {meta["low"]},')
    
    lines.append("    }")
    lines.append("")
    lines.append("    local turtleHighs = {")
    
    for name, meta in sorted(turtle_zone_meta.items()):
        display = meta.get("alias", name)
        lines.append(f'        [Z["{display}"]] = {meta["high"]},')
    
    lines.append("    }")
    lines.append("")
    lines.append("    local turtleContinents = {")
    
    for name, meta in sorted(turtle_zone_meta.items()):
        display = meta.get("alias", name)
        lines.append(f'        [Z["{display}"]] = Z["{meta["continent"]}"],')
    
    lines.append("    }")
    lines.append("")
    lines.append("    local turtleInstances = {")
    
    for name, meta in sorted(turtle_zone_meta.items()):
        if meta.get("instance"):
            display = meta.get("alias", name)
            lines.append(f'        [Z["{display}"]] = true,')
    
    lines.append("    }")
    lines.append("")
    lines.append("    local turtleGroupSizes = {")
    
    for name, meta in sorted(turtle_zone_meta.items()):
        if meta.get("group"):
            display = meta.get("alias", name)
            lines.append(f'        [Z["{display}"]] = {meta["group"]},')
    
    lines.extend([
        "    }",
        "",
        "    -- Merge into Tourist's tables",
        "    for zone, level in pairs(turtleLows) do",
        "        if zone and not Tourist.lows[zone] then",
        "            Tourist.lows[zone] = level",
        "        end",
        "    end",
        "    for zone, level in pairs(turtleHighs) do",
        "        if zone and not Tourist.highs[zone] then",
        "            Tourist.highs[zone] = level",
        "        end",
        "    end",
        "    for zone, cont in pairs(turtleContinents) do",
        "        if zone and not Tourist.continents[zone] then",
        "            Tourist.continents[zone] = cont",
        "        end",
        "    end",
        "    for zone, _ in pairs(turtleInstances) do",
        "        if zone and not Tourist.instances[zone] then",
        "            Tourist.instances[zone] = true",
        "        end",
        "    end",
        "    for zone, size in pairs(turtleGroupSizes) do",
        "        if zone and not Tourist.groupSizes[zone] then",
        "            Tourist.groupSizes[zone] = size",
        "        end",
        "    end",
        "end",
        "",
        "-- Run after Tourist initializes",
        "local frame = CreateFrame('Frame')",
        "frame:SetScript('OnUpdate', function()",
        "    this:SetScript('OnUpdate', nil)",
        "    ExtendTouristData()",
        "end)",
    ])
    
    return "\n".join(lines)


def generate_questie_zones_data(areas: Dict[int, WorldMapArea], zones_zhcn: Dict[int, str]) -> str:
    """Generate Lua code for QuestieZones extensions"""
    
    # This would extend the QuestieZones table with additional TurtleWoW zones
    # The existing zone.lua already has most zones, this adds any missing ones
    
    lines = [
        "-- TurtleWoW Zone ID Extensions for Questie",
        "-- Auto-generated by extract_turtle_zones.py",
        "-- DO NOT EDIT MANUALLY",
        "",
        "if not QuestieIsTurtleWoW then return end",
        "",
        "-- Extend QuestieZones with additional TurtleWoW zones",
        "-- Format: {mapID, BCContinent, BCZone, VanillaC, VanillaZ, TurtleC, TurtleZ}",
        "local additionalZones = {",
    ]
    
    # Map internal names to QuestieZones keys and zone indices
    # This maps area_table_id to (key, turtleC, turtleZ)
    turtle_zone_mapping = {
        # Kalimdor TurtleWoW zones
        876: ("GMIsland", 1, 1),
        5024: ("Frostpoint", 1, 3),
        5121: ("Telabim", 1, 17),
        5536: ("BlackrockIsle", 1, 31),
        616: ("MountHyjal", 1, 19),
        
        # Eastern Kingdoms TurtleWoW zones  
        5179: ("Gilneas", 2, 7),
        5225: ("SalasHighlands", 2, 26),
        5561: ("Balo", 2, 10),
        5581: ("NorthwindCleft", 2, 5),
        5602: ("ColdCoast", 2, 4),
        4012: ("ScarletEnclave", 2, 2),
        2040: ("Alsarath", 2, 37),
        408: ("GillijimsIsle", 2, 6),
        409: ("LapidisIsle", 2, 14),
        
        # Instances (use zone_id as mapID stand-in)
        5077: ("CrescentGrove", 1, -1),
        5086: ("KarazhanCrypt", 2, -1),
        5087: ("StormwindVault", 2, -1),
        5097: ("EmeraldSanctum", 1, -1),
        5103: ("HateforgeQuarry", 2, -1),
        5130: ("WinterVeilVale", 2, -1),
        5208: ("GilneasCity", 2, -1),
        5601: ("DragonmawRetreat", 2, -1),
    }
    
    for area_table_id, (key, turtle_c, turtle_z) in sorted(turtle_zone_mapping.items()):
        zhcn_name = zones_zhcn.get(area_table_id, "")
        lines.append(f'    -- {key} ({zhcn_name}) [AreaTableID: {area_table_id}]')
        lines.append(f'    ["{key}"] = {{{turtle_c}, {turtle_z}}},')
    
    lines.extend([
        "}",
        "",
        "-- Merge additional zones into QuestieZones",
        "for key, data in pairs(additionalZones) do",
        "    if QuestieZones[key] then",
        "        -- Update TurtleWoW indices if zone exists",
        "        QuestieZones[key][6] = data[1]  -- TurtleC",
        "        QuestieZones[key][7] = data[2]  -- TurtleZ",
        "    end",
        "end",
    ])
    
    return "\n".join(lines)


def main():
    print("TurtleWoW Zone Data Extraction")
    print("=" * 50)
    
    # Check input files exist
    if not os.path.exists(SQL_PATH):
        print(f"ERROR: SQL file not found: {SQL_PATH}")
        return
    
    if not os.path.exists(ZONES_TURTLE_PATH):
        print(f"ERROR: Zones file not found: {ZONES_TURTLE_PATH}")
        return
    
    # Parse data
    print(f"Parsing WorldMapArea_turtle from: {SQL_PATH}")
    areas = parse_world_map_area_turtle(SQL_PATH)
    print(f"  Found {len(areas)} WorldMapArea entries")
    
    print(f"Parsing zone names from: {ZONES_TURTLE_PATH}")
    zones_zhcn = parse_zones_turtle_lua(ZONES_TURTLE_PATH)
    print(f"  Found {len(zones_zhcn)} zone translations")
    
    # Identify TurtleWoW-specific zones
    turtle_zones = identify_turtle_zones(areas)
    print(f"  Identified {len(turtle_zones)} TurtleWoW-specific zones")
    
    # Generate output files
    print("\nGenerating output files...")
    
    # Astrolabe data
    astrolabe_path = os.path.join(OUTPUT_DIR, "astrolabe", "astrolabe_turtle_data.lua")
    os.makedirs(os.path.dirname(astrolabe_path), exist_ok=True)
    astrolabe_data = generate_astrolabe_data(turtle_zones, zones_zhcn)
    with open(astrolabe_path, 'w', encoding='utf-8') as f:
        f.write(astrolabe_data)
    print(f"  Created: {astrolabe_path}")
    
    # Babble-Zone data
    babble_path = os.path.join(OUTPUT_DIR, "Database", "turtle", "babble_zone_turtle.lua")
    os.makedirs(os.path.dirname(babble_path), exist_ok=True)
    babble_data = generate_babble_zone_data(turtle_zones, zones_zhcn)
    with open(babble_path, 'w', encoding='utf-8') as f:
        f.write(babble_data)
    print(f"  Created: {babble_path}")
    
    # Tourist data
    tourist_path = os.path.join(OUTPUT_DIR, "Database", "turtle", "tourist_turtle_zones.lua")
    tourist_data = generate_tourist_data(turtle_zones, zones_zhcn)
    with open(tourist_path, 'w', encoding='utf-8') as f:
        f.write(tourist_data)
    print(f"  Created: {tourist_path}")
    
    # QuestieZones data
    questie_zones_path = os.path.join(OUTPUT_DIR, "Database", "turtle", "zone_turtle_data.lua")
    questie_zones_data = generate_questie_zones_data(turtle_zones, zones_zhcn)
    with open(questie_zones_path, 'w', encoding='utf-8') as f:
        f.write(questie_zones_data)
    print(f"  Created: {questie_zones_path}")
    
    print("\nDone!")
    print("\nNext steps:")
    print("1. Add the generated files to the respective addon .toc files")
    print("2. Test in-game to verify the data is loaded correctly")


if __name__ == "__main__":
    main()
