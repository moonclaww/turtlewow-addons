#!/usr/bin/env python3
"""
pfQuest-turtle to Questie Database Converter

Fetches TurtleWoW quest data from pfQuest-turtle repository and populates
the existing Questie turtle database placeholder files.

Now includes:
- Monster/NPC locations
- Object locations  
- Quest data (QuestieLevLookup, QuestieHashMap)

References infrastructure from: questie_zhcn_turtlewow_support_d56142ec.plan.md

Usage:
    python convert_pfquest_turtle.py

Output:
    Populates existing files:
    - Database/turtle/init.lua      (enUS TurtleWoW data)
    - Database/turtle_zhCN/init.lua (zhCN TurtleWoW data)
"""

import os
import re
import sys
import urllib.request
import urllib.error
from pathlib import Path
from datetime import datetime

# Configuration - Multiple Sources for Best Coverage
PFQUEST_TURTLE_BASE = "https://raw.githubusercontent.com/shagu/pfQuest-turtle/master/"
NINETEARS_BASE = "https://raw.githubusercontent.com/NineTears/pfQuest-en2cn/main/pfQuest-turtle/"

# Output directories (relative to script location)
SCRIPT_DIR = Path(__file__).parent
QUESTIE_DIR = SCRIPT_DIR.parent
DATABASE_DIR = QUESTIE_DIR / "Database"
TURTLE_DIR = DATABASE_DIR / "turtle"
TURTLE_ZHCN_DIR = DATABASE_DIR / "turtle_zhCN"

# AreaTable ID (pfQuest) → mapID (Questie) conversion table
# pfQuest uses WoW's AreaTable zone IDs in coordinates, but Questie uses its own mapID system
# This mapping is derived from pfQuest's db/enUS/zones.lua and Questie's Database/zone.lua
AREATABLE_TO_MAPID = {
    # Kalimdor
    141: 24,    # Teldrassil
    148: 16,    # Darkshore
    331: 2,     # Ashenvale
    406: 6,     # Stonetalon Mountains
    14: 7,      # Durotar
    17: 11,     # The Barrens
    215: 22,    # Mulgore
    400: 14,    # Thousand Needles
    405: 4,     # Desolace
    15: 10,     # Dustwallow Marsh
    357: 17,    # Feralas
    440: 8,     # Tanaris
    490: 18,    # Un'Goro Crater
    1377: 5,    # Silithus
    618: 19,    # Winterspring
    361: 13,    # Felwood
    16: 15,     # Azshara
    493: 20,    # Moonglade
    1637: 1,    # Orgrimmar
    1638: 23,   # Thunder Bluff
    1657: 21,   # Darnassus
    
    # Eastern Kingdoms
    1: 28,      # Dun Morogh
    12: 37,     # Elwynn Forest
    38: 29,     # Loch Modan
    40: 49,     # Westfall
    44: 30,     # Redridge Mountains
    10: 31,     # Duskwood
    33: 38,     # Stranglethorn Vale
    8: 46,      # Swamp of Sorrows
    4: 33,      # Blasted Lands
    3: 27,      # Badlands
    51: 32,     # Searing Gorge
    46: 40,     # Burning Steppes
    11: 51,     # Wetlands
    267: 48,    # Hillsbrad Foothills
    36: 26,     # Alterac Mountains
    45: 39,     # Arathi Highlands
    47: 42,     # The Hinterlands
    28: 50,     # Western Plaguelands
    139: 34,    # Eastern Plaguelands
    85: 43,     # Tirisfal Glades
    130: 35,    # Silverpine Forest
    41: 47,     # Deadwind Pass
    1519: 36,   # Stormwind City
    1537: 25,   # Ironforge
    1497: 45,   # Undercity
}

# TurtleWoW custom zones: AreaTable ID → (continent, turtleZoneIdx)
# These zones don't exist in vanilla, so we output in new format {continent, zone, x, y}
# Format matches Questie's zone.lua TurtleC and TurtleZ columns
#
# Zone data verified from in-game GetMapZones() output on TurtleWoW
TURTLEWOW_ZONES = {
    # ==================== KALIMDOR WORLD MAP (Continent 1) ====================
    5024: (1, 3),     # Icepoint Rock / Frostpoint (冰点岩)
    5121: (1, 17),    # Tel'Abim / Telabim (泰拉比姆)
    5536: (1, 31),    # Blackstone Island / BlackrockIsle (黑石岛)
    
    # ==================== EASTERN KINGDOMS WORLD MAP (Continent 2) ====================
    409: (2, 14),     # Lapidis Isle (拉匹迪斯之岛)
    408: (2, 6),      # Gillijim's Isle (吉利吉姆之岛)
    5179: (2, 7),     # Gilneas (吉尔尼斯)
    5561: (2, 10),    # Balor / Balo (巴洛)
    5581: (2, 5),     # Northwind / NorthwindCleft (北风领)
    5602: (2, 4),     # Grim Reaches / ColdCoast (冷酷海岸)
    5225: (2, 26),    # Thalassian Highlands / SalasHighlands (萨拉斯高地)
    4012: (2, 2),     # Scarlet Enclave (东瘟疫之地：血色领地)
    25: (2, 39),      # Blackrock Mountain (黑石山)
    616: (2, 37),     # Alsarath (阿尔萨拉斯) - TurtleWoW custom zone
    
    # ==================== VANILLA DUNGEONS (Instance Continents) ====================
    # Verified from in-game GetMapZones(C) output
    2437: (4, 1),     # Ragefire Chasm (怒焰裂谷) → C4
    1176: (5, 1),     # Zul'Farrak (祖尔法拉克) → C5
    1477: (6, 1),     # Sunken Temple / Atal'Hakkar (阿塔哈卡神庙) → C6
    719: (7, 1),      # Blackfathom Deeps (黑暗深渊) → C7
    717: (8, 1),      # The Stockade (监狱) → C8
    721: (9, 1),      # Gnomeregan (诺莫瑞根) → C9
    876: (10, 1),     # Uldaman (奥达曼) → C10
    2717: (11, 1),    # Molten Core (熔火之心) → C11
    1977: (12, 1),    # Zul'Gurub (祖尔格拉布) → C12
    2557: (13, 1),    # Dire Maul (厄运之槌) → C13
    1584: (14, 1),    # Blackrock Depths (黑石深渊) → C14
    3429: (15, 1),    # Ruins of Ahn'Qiraj (安其拉废墟) → C15
    2040: (16, 1),    # Onyxia's Lair (奥妮克希亚的巢穴) → C16
    1583: (17, 1),    # Blackrock Spire (黑石塔) → C17
    718: (18, 1),     # Wailing Caverns (哀嚎洞穴) → C18
    2100: (19, 1),    # Maraudon (玛拉顿) → C19
    2677: (20, 1),    # Blackwing Lair (黑翼之巢) → C20
    1581: (21, 1),    # Deadmines (死亡矿井) → C21
    722: (22, 1),     # Razorfen Downs (剃刀高地) → C22
    491: (23, 1),     # Razorfen Kraul (剃刀沼泽) → C23
    796: (24, 1),     # Scarlet Monastery (血色修道院) → C24
    2057: (25, 1),    # Scholomance (通灵学院) → C25
    209: (26, 1),     # Shadowfang Keep (影牙城堡) → C26
    2017: (27, 1),    # Stratholme (斯坦索姆) → C27
    3428: (28, 1),    # Ahn'Qiraj Temple (安其拉) → C28
    2366: (31, 1),    # The Black Morass (黑色沼泽) → C31
    3456: (33, 1),    # Naxxramas (纳克萨玛斯) → C33
    
    # ==================== SCARLET MONASTERY WINGS ====================
    # C24 has 4 zones for each wing
    5153: (24, 1),    # SM Armory (血色修道院-军械库)
    5135: (24, 2),    # SM Library (血色修道院-图书馆)
    5136: (24, 3),    # SM Graveyard (血色修道院-墓地)
    5163: (24, 4),    # SM Cathedral (血色修道院-大教堂)
    
    # ==================== TURTLEWOW CUSTOM INSTANCES ====================
    5130: (3, 1),     # Winter Veil Vale (冬幕谷) → C3
    5077: (34, 1),    # Crescent Grove (新月林地) → C34
    5103: (35, 1),    # Hateforge Quarry (仇恨熔炉采石场) → C35
    5086: (36, 1),    # Karazhan Crypt (卡拉赞墓穴) → C36
    5087: (37, 1),    # Stormwind Vault (暴风城地牢) → C37
    5097: (38, 1),    # Emerald Sanctum (翡翠圣殿) → C38
    5053: (39, 1),    # Moomoo Grove (奶牛树林) → C39
    5601: (41, 1),    # Dragonmaw Retreat (龙喉居所) → C41
    5208: (32, 1),    # Gilneas City (吉尔尼斯城) → C32
    3457: (29, 1),    # Tower of Karazhan (卡拉赞) → C29
    
    # ==================== DUPLICATE IDs (Vanilla + TurtleWoW variants) ====================
    # Both IDs map to the same destination for compatibility
    1337: (10, 1),    # Uldaman (alternate ID) → same as 876
    5138: (21, 1),    # TurtleWoW Deadmines → same as 1581
    5147: (28, 1),    # TurtleWoW Ahn'Qiraj → same as 3428
    5148: (33, 1),    # Upper Necropolis → Naxxramas area
    5204: (31, 1),    # TurtleWoW Black Morass → same as 2366
    
    # ==================== TODO: UNMAPPED ZONES ====================
    # These zones need in-game verification to determine their continent/zone mapping
    #
    # Subzones (parent zone unknown - not in GetMapZones output):
    #   5023 = Sunnyglade Valley (阳光林地山谷) - 1 coord in pfQuest, parent zone unknown
    #   5557 = Rock of Desolation (荒芜巨岩) - 18 coords, has lvl63 mobs, parent unknown
    #   5628 = Stormwrought Ruins (风暴废墟) - 54 coords, parent zone unknown
    #
    # Battlegrounds (need to enter BG and check GetCurrentMapContinent):
    #   2597 = Alterac Valley
    #
    # Special areas (need in-game verification):
    #   1941 = Caverns of Time entrance area
    #   3478 = Gates of Ahn'Qiraj (outdoor event area in Silithus)
}

# Track unmapped zones for reporting
unmapped_zones = set()


def fetch_url(url: str) -> str:
    """Fetch content from URL, return empty string on failure."""
    print(f"  Fetching: {url}")
    try:
        with urllib.request.urlopen(url, timeout=60) as response:
            return response.read().decode('utf-8')
    except urllib.error.HTTPError as e:
        print(f"    HTTP Error {e.code}")
        return ""
    except urllib.error.URLError as e:
        print(f"    URL Error: {e.reason}")
        return ""
    except Exception as e:
        print(f"    Error: {e}")
        return ""


def adler32_hash(text: str) -> int:
    """Compute Adler-32 hash (same algorithm as Questie:HashString)."""
    a, b = 1, 0
    for char in text:
        a = (a + ord(char)) % 65521
        b = (b + a) % 65521
    return b * 65536 + a


def parse_data_table(content: str, table_name: str) -> dict:
    """Parse pfQuest data table with coordinates."""
    result = {}
    
    table_pattern = f'pfDB["{table_name}"]["data-turtle"]'
    start_idx = content.find(table_pattern)
    if start_idx == -1:
        return result
    
    brace_idx = content.find('{', start_idx)
    if brace_idx == -1:
        return result
    
    pos = brace_idx + 1
    while pos < len(content):
        while pos < len(content) and content[pos] in ' \t\n\r':
            pos += 1
        
        if pos >= len(content) or content[pos] == '}':
            break
        
        id_match = re.match(r'\[(\d+)\]\s*=\s*\{', content[pos:])
        if not id_match:
            pos += 1
            continue
        
        unit_id = int(id_match.group(1))
        entry_start = pos + id_match.end()
        
        depth = 1
        entry_pos = entry_start
        while entry_pos < len(content) and depth > 0:
            c = content[entry_pos]
            if c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
            entry_pos += 1
        
        entry_content = content[entry_start:entry_pos-1]
        
        if '["coords"]' in entry_content or '["lvl"]' in entry_content or '["fac"]' in entry_content:
            entry = {}
            
            coords_match = re.search(r'\["coords"\]\s*=\s*\{', entry_content)
            if coords_match:
                coords_start = coords_match.end()
                depth = 1
                coords_pos = coords_start
                while coords_pos < len(entry_content) and depth > 0:
                    c = entry_content[coords_pos]
                    if c == '{':
                        depth += 1
                    elif c == '}':
                        depth -= 1
                    coords_pos += 1
                
                coords_content = entry_content[coords_start:coords_pos-1]
                coords = []
                for coord_match in re.finditer(r'\[\d+\]\s*=\s*\{\s*([\d.]+)\s*,\s*([\d.]+)\s*,\s*(\d+)\s*,\s*\d+\s*\}', coords_content):
                    x = float(coord_match.group(1))
                    y = float(coord_match.group(2))
                    zone = int(coord_match.group(3))
                    coords.append((x, y, zone))
                entry["coords"] = coords
            
            fac_match = re.search(r'\["fac"\]\s*=\s*"([^"]*)"', entry_content)
            if fac_match:
                entry["fac"] = fac_match.group(1)
            
            lvl_match = re.search(r'\["lvl"\]\s*=\s*"([^"]*)"', entry_content)
            if lvl_match:
                entry["lvl"] = lvl_match.group(1)
            
            result[unit_id] = entry
        
        pos = entry_pos
        while pos < len(content) and content[pos] in ' \t\n\r,':
            pos += 1
    
    return result


def parse_name_table(content: str, table_pattern: str) -> dict:
    """Parse pfQuest name table. Format: [id] = "name" """
    result = {}
    
    pattern = rf'{re.escape(table_pattern)}\s*=\s*\{{'
    match = re.search(pattern, content)
    if not match:
        return result
    
    start = match.end()
    depth = 1
    pos = start
    while pos < len(content) and depth > 0:
        if content[pos] == '{':
            depth += 1
        elif content[pos] == '}':
            depth -= 1
        pos += 1
    
    table_content = content[start:pos-1]
    
    for match in re.finditer(r'\[(\d+)\]\s*=\s*"([^"]*)"', table_content):
        id_val = int(match.group(1))
        name = match.group(2)
        if name and name != "*" and name != "_":
            result[id_val] = name
    
    return result


def parse_quest_data(content: str) -> dict:
    """Parse pfQuest quest data table."""
    result = {}
    
    table_pattern = 'pfDB["quests"]["data-turtle"]'
    start_idx = content.find(table_pattern)
    if start_idx == -1:
        return result
    
    brace_idx = content.find('{', start_idx)
    if brace_idx == -1:
        return result
    
    pos = brace_idx + 1
    while pos < len(content):
        while pos < len(content) and content[pos] in ' \t\n\r':
            pos += 1
        
        if pos >= len(content) or content[pos] == '}':
            break
        
        # Match [questID] = { or [questID] = "_"
        id_match = re.match(r'\[(\d+)\]\s*=\s*(\{|"_")', content[pos:])
        if not id_match:
            pos += 1
            continue
        
        quest_id = int(id_match.group(1))
        
        # Skip placeholder entries
        if id_match.group(2) == '"_"':
            pos += id_match.end()
            while pos < len(content) and content[pos] in ' \t\n\r,':
                pos += 1
            continue
        
        entry_start = pos + id_match.end()
        
        depth = 1
        entry_pos = entry_start
        while entry_pos < len(content) and depth > 0:
            c = content[entry_pos]
            if c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
            entry_pos += 1
        
        entry_content = content[entry_start:entry_pos-1]
        quest = {}
        
        # Parse level
        lvl_match = re.search(r'\["lvl"\]\s*=\s*(\d+)', entry_content)
        if lvl_match:
            quest["lvl"] = int(lvl_match.group(1))
        
        # Parse min level
        min_match = re.search(r'\["min"\]\s*=\s*(\d+)', entry_content)
        if min_match:
            quest["min"] = int(min_match.group(1))
        
        # Parse race requirement
        race_match = re.search(r'\["race"\]\s*=\s*(\d+)', entry_content)
        if race_match:
            quest["race"] = int(race_match.group(1))
        
        # Parse class requirement
        class_match = re.search(r'\["class"\]\s*=\s*(\d+)', entry_content)
        if class_match:
            quest["class"] = int(class_match.group(1))
        
        # Parse start (quest giver)
        start_match = re.search(r'\["start"\]\s*=\s*\{([^}]*(?:\{[^}]*\}[^}]*)*)\}', entry_content)
        if start_match:
            start_content = start_match.group(1)
            quest["start"] = {}
            # Unit starter
            u_match = re.search(r'\["U"\]\s*=\s*\{\s*(\d+)', start_content)
            if u_match:
                quest["start"]["U"] = int(u_match.group(1))
            # Item starter
            i_match = re.search(r'\["I"\]\s*=\s*\{\s*(\d+)', start_content)
            if i_match:
                quest["start"]["I"] = int(i_match.group(1))
            # Object starter
            o_match = re.search(r'\["O"\]\s*=\s*\{\s*(\d+)', start_content)
            if o_match:
                quest["start"]["O"] = int(o_match.group(1))
        
        # Parse end (quest turn-in)
        end_match = re.search(r'\["end"\]\s*=\s*\{([^}]*(?:\{[^}]*\}[^}]*)*)\}', entry_content)
        if end_match:
            end_content = end_match.group(1)
            quest["end"] = {}
            u_match = re.search(r'\["U"\]\s*=\s*\{\s*(\d+)', end_content)
            if u_match:
                quest["end"]["U"] = int(u_match.group(1))
            o_match = re.search(r'\["O"\]\s*=\s*\{\s*(\d+)', end_content)
            if o_match:
                quest["end"]["O"] = int(o_match.group(1))
        
        if quest:
            result[quest_id] = quest
        
        pos = entry_pos
        while pos < len(content) and content[pos] in ' \t\n\r,':
            pos += 1
    
    return result


def parse_quest_locale(content: str, locale: str) -> dict:
    """Parse quest titles and objectives from locale file."""
    result = {}
    
    table_pattern = f'pfDB["quests"]["{locale}-turtle"]'
    start_idx = content.find(table_pattern)
    if start_idx == -1:
        return result
    
    brace_idx = content.find('{', start_idx)
    if brace_idx == -1:
        return result
    
    pos = brace_idx + 1
    while pos < len(content):
        while pos < len(content) and content[pos] in ' \t\n\r':
            pos += 1
        
        if pos >= len(content) or content[pos] == '}':
            break
        
        id_match = re.match(r'\[(\d+)\]\s*=\s*\{', content[pos:])
        if not id_match:
            pos += 1
            continue
        
        quest_id = int(id_match.group(1))
        entry_start = pos + id_match.end()
        
        depth = 1
        entry_pos = entry_start
        while entry_pos < len(content) and depth > 0:
            c = content[entry_pos]
            if c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
            entry_pos += 1
        
        entry_content = content[entry_start:entry_pos-1]
        quest = {}
        
        # Parse title ["T"]
        t_match = re.search(r'\["T"\]\s*=\s*"([^"]*)"', entry_content)
        if t_match:
            quest["T"] = t_match.group(1)
        
        # Parse objectives ["O"]
        o_match = re.search(r'\["O"\]\s*=\s*"([^"]*)"', entry_content)
        if o_match:
            quest["O"] = o_match.group(1)
        
        if quest.get("T"):
            result[quest_id] = quest
        
        pos = entry_pos
        while pos < len(content) and content[pos] in ' \t\n\r,':
            pos += 1
    
    return result


def convert_faction(fac_str: str) -> int:
    """Convert pfQuest faction string to Questie faction number."""
    if not fac_str:
        return 0
    if fac_str == "A":
        return 1
    elif fac_str == "H":
        return 2
    return 0


def race_to_questie_faction(race_bitmask: int) -> int:
    """Convert pfQuest race bitmask to Questie faction code.
    Alliance races: Human(1), Dwarf(4), NightElf(8), Gnome(64) = 77
    Horde races: Orc(2), Undead(16), Tauren(32), Troll(128) = 178
    Both: 255 or similar
    """
    alliance_mask = 1 + 4 + 8 + 64  # 77
    horde_mask = 2 + 16 + 32 + 128  # 178
    
    has_alliance = (race_bitmask & alliance_mask) != 0
    has_horde = (race_bitmask & horde_mask) != 0
    
    if has_alliance and has_horde:
        return 0  # Both
    elif has_alliance:
        return 77  # Alliance
    elif has_horde:
        return 178  # Horde
    return 0


def generate_init_lua(units_data: dict, units_names: dict, 
                      items_data: dict, items_names: dict,
                      objects_data: dict, objects_names: dict,
                      quest_data: dict, quest_locale: dict,
                      locale: str) -> str:
    """Generate the full init.lua content for TurtleWoW database."""
    
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    if locale == "enUS":
        lines = [
            '---------------------------------------------------------------------------------------------------',
            '-- TurtleWoW Custom Content for Questie (English)',
            f'-- Auto-generated by convert_pfquest_turtle.py on {timestamp}',
            '-- Source: https://github.com/shagu/pfQuest-turtle',
            '---------------------------------------------------------------------------------------------------',
            '-- Guard: Only load on TurtleWoW servers with English locale',
            'if not QuestieIsTurtleWoW then return end',
            'if GetLocale() ~= "enUS" then return end',
            '',
        ]
    else:
        lines = [
            '---------------------------------------------------------------------------------------------------',
            '-- TurtleWoW Custom Content for Questie (Simplified Chinese)',
            '-- 乌龟服自定义内容 - 简体中文',
            f'-- Auto-generated by convert_pfquest_turtle.py on {timestamp}',
            '-- Source: https://github.com/shagu/pfQuest-turtle',
            '---------------------------------------------------------------------------------------------------',
            '-- Guard: Only load on TurtleWoW servers with Chinese locale',
            'if not QuestieIsTurtleWoW then return end',
            'if GetLocale() ~= "zhCN" then return end',
            '',
        ]
    
    # Generate monsters section
    monster_count = 0
    lines.append('---------------------------------------------------------------------------------------------------')
    lines.append('-- TurtleWoW Monster/NPC Data')
    lines.append('---------------------------------------------------------------------------------------------------')
    
    for unit_id, unit_data in sorted(units_data.items()):
        name = units_names.get(unit_id)
        if not name:
            continue
        
        coords = unit_data.get("coords", [])
        if not coords:
            continue
        
        faction = convert_faction(unit_data.get("fac", ""))
        
        locations = []
        for x, y, zone in coords:
            qx = x / 100.0
            qy = y / 100.0
            
            # Convert AreaTable ID to Questie format
            if zone in AREATABLE_TO_MAPID:
                # Vanilla zone: use old format {mapID, x, y, 100.0}
                map_id = AREATABLE_TO_MAPID[zone]
                locations.append(('old', map_id, qx, qy))
            elif zone in TURTLEWOW_ZONES:
                # TurtleWoW zone: use new format {continent, turtleZone, x, y}
                continent, turtle_zone = TURTLEWOW_ZONES[zone]
                locations.append(('new', continent, turtle_zone, qx, qy))
            else:
                # Unknown zone - track for warning, skip this location
                unmapped_zones.add(zone)
                continue
        
        if locations:
            monster_count += 1
            escaped_name = name.replace('\\', '\\\\').replace('"', '\\"')
            lines.append(f'if not QuestieMonsters["{escaped_name}"] then')
            lines.append(f'  QuestieMonsters["{escaped_name}"] = {{')
            lines.append('    ["locations"] = {')
            for i, loc in enumerate(locations[:50], 1):
                if loc[0] == 'old':
                    # Old format: {mapID, x, y, 100.0}
                    _, map_id, x, y = loc
                    lines.append(f'      [{i}] = {{{map_id}, {x:.4f}, {y:.4f}, 100.0}},')
                else:
                    # New format: {continent, turtleZone, x, y}
                    _, continent, turtle_zone, x, y = loc
                    lines.append(f'      [{i}] = {{{continent}, {turtle_zone}, {x:.4f}, {y:.4f}}},')
            lines.append('    },')
            lines.append(f'    ["locationCount"] = {min(len(locations), 50)},')
            if faction:
                lines.append(f'    ["faction"] = {faction},')
            lines.append('  }')
            lines.append('end')
    
    lines.append('')
    
    # Generate objects section
    object_count = 0
    lines.append('---------------------------------------------------------------------------------------------------')
    lines.append('-- TurtleWoW World Object Data')
    lines.append('---------------------------------------------------------------------------------------------------')
    
    for obj_id, obj_data in sorted(objects_data.items()):
        name = objects_names.get(obj_id)
        if not name:
            continue
        
        coords = obj_data.get("coords", [])
        if not coords:
            continue
        
        locations = []
        for x, y, zone in coords:
            qx = x / 100.0
            qy = y / 100.0
            
            # Convert AreaTable ID to Questie format
            if zone in AREATABLE_TO_MAPID:
                # Vanilla zone: use old format {mapID, x, y, 100.0}
                map_id = AREATABLE_TO_MAPID[zone]
                locations.append(('old', map_id, qx, qy))
            elif zone in TURTLEWOW_ZONES:
                # TurtleWoW zone: use new format {continent, turtleZone, x, y}
                continent, turtle_zone = TURTLEWOW_ZONES[zone]
                locations.append(('new', continent, turtle_zone, qx, qy))
            else:
                # Unknown zone - track for warning, skip this location
                unmapped_zones.add(zone)
                continue
        
        if locations:
            object_count += 1
            escaped_name = name.replace('\\', '\\\\').replace('"', '\\"')
            lines.append(f'if not QuestieObjects["{escaped_name}"] then')
            lines.append(f'  QuestieObjects["{escaped_name}"] = {{')
            lines.append('    locations = {')
            for i, loc in enumerate(locations[:50], 1):
                if loc[0] == 'old':
                    # Old format: {mapID, x, y, 100.0}
                    _, map_id, x, y = loc
                    lines.append(f'      [{i}] = {{{map_id}, {x:.4f}, {y:.4f}, 100.0}},')
                else:
                    # New format: {continent, turtleZone, x, y}
                    _, continent, turtle_zone, x, y = loc
                    lines.append(f'      [{i}] = {{{continent}, {turtle_zone}, {x:.4f}, {y:.4f}}},')
            lines.append('    },')
            lines.append(f'    locationCount = {min(len(locations), 50)},')
            lines.append('  }')
            lines.append('end')
    
    lines.append('')
    
    # Generate quest data (QuestieLevLookup and QuestieHashMap)
    quest_count = 0
    lines.append('---------------------------------------------------------------------------------------------------')
    lines.append('-- TurtleWoW Quest Data (QuestieLevLookup)')
    lines.append('---------------------------------------------------------------------------------------------------')
    lines.append('-- Initialize tables if not already defined (for loading order safety)')
    lines.append('QuestieLevLookup = QuestieLevLookup or {}')
    lines.append('QuestieHashMap = QuestieHashMap or {}')
    lines.append('')
    
    lev_lookup_entries = []
    hash_map_entries = []
    
    for quest_id, quest_info in sorted(quest_data.items()):
        locale_info = quest_locale.get(quest_id)
        if not locale_info:
            continue
        
        title = locale_info.get("T", "")
        objectives = locale_info.get("O", "")
        
        if not title:
            continue
        
        # Compute hash
        quest_hash = adler32_hash(title + objectives)
        
        # Get quest giver name
        started_by = "unknown"
        started_type = "monster"
        if "start" in quest_info:
            if "U" in quest_info["start"]:
                unit_id = quest_info["start"]["U"]
                started_by = units_names.get(unit_id, f"Unit_{unit_id}")
                started_type = "monster"
            elif "I" in quest_info["start"]:
                item_id = quest_info["start"]["I"]
                started_by = items_names.get(item_id, f"Item_{item_id}")
                started_type = "item"
            elif "O" in quest_info["start"]:
                obj_id = quest_info["start"]["O"]
                started_by = objects_names.get(obj_id, f"Object_{obj_id}")
                started_type = "object"
        
        # Get turn-in NPC name
        finished_by = "unknown"
        finished_type = "monster"
        if "end" in quest_info:
            if "U" in quest_info["end"]:
                unit_id = quest_info["end"]["U"]
                finished_by = units_names.get(unit_id, f"Unit_{unit_id}")
                finished_type = "monster"
            elif "O" in quest_info["end"]:
                obj_id = quest_info["end"]["O"]
                finished_by = objects_names.get(obj_id, f"Object_{obj_id}")
                finished_type = "object"
        
        level = quest_info.get("min", 1)
        quest_level = quest_info.get("lvl", 1)
        race = quest_info.get("race", 0)
        faction = race_to_questie_faction(race) if race else 0
        
        # Escape strings
        esc_title = title.replace('\\', '\\\\').replace('"', '\\"').replace("'", "\\'")
        esc_obj = objectives.replace('\\', '\\\\').replace('"', '\\"').replace("'", "\\'")
        esc_started = started_by.replace('\\', '\\\\').replace('"', '\\"').replace("'", "\\'")
        esc_finished = finished_by.replace('\\', '\\\\').replace('"', '\\"').replace("'", "\\'")
        
        # QuestieLevLookup entry
        lev_lookup_entries.append(f'if not QuestieLevLookup["{esc_title}"] then QuestieLevLookup["{esc_title}"] = {{}} end')
        lev_lookup_entries.append(f'if not QuestieLevLookup["{esc_title}"]["{esc_obj}"] then QuestieLevLookup["{esc_title}"]["{esc_obj}"] = {{{faction}, {quest_hash}}} end')
        
        # QuestieHashMap entry
        hash_map_entries.append(f'if not QuestieHashMap[{quest_hash}] then')
        hash_map_entries.append(f'  QuestieHashMap[{quest_hash}] = {{')
        hash_map_entries.append(f"    ['name'] = \"{esc_title}\",")
        hash_map_entries.append(f"    ['startedType'] = \"{started_type}\",")
        hash_map_entries.append(f"    ['finishedType'] = \"{finished_type}\",")
        hash_map_entries.append(f"    ['startedBy'] = \"{esc_started}\",")
        hash_map_entries.append(f"    ['finishedBy'] = \"{esc_finished}\",")
        hash_map_entries.append(f"    ['level'] = {level},")
        hash_map_entries.append(f"    ['questLevel'] = '{quest_level}',")
        hash_map_entries.append(f"    ['rr'] = {faction},")
        hash_map_entries.append(f"    ['rc'] = 0,")
        hash_map_entries.append('  }')
        hash_map_entries.append('end')
        
        quest_count += 1
    
    lines.extend(lev_lookup_entries)
    lines.append('')
    lines.append('---------------------------------------------------------------------------------------------------')
    lines.append('-- TurtleWoW Quest Data (QuestieHashMap)')
    lines.append('---------------------------------------------------------------------------------------------------')
    lines.extend(hash_map_entries)
    
    lines.append('')
    lines.append('---------------------------------------------------------------------------------------------------')
    lines.append(f'-- Summary: {monster_count} monsters, {object_count} objects, {quest_count} quests')
    if locale == "enUS":
        lines.append('-- TurtleWoW enUS database loaded successfully')
    else:
        lines.append('-- TurtleWoW zhCN database loaded successfully')
    lines.append('---------------------------------------------------------------------------------------------------')
    
    return '\n'.join(lines)


def merge_name_tables(base: dict, additional: dict, source_name: str) -> int:
    """Merge additional names into base table."""
    added = 0
    for key, value in additional.items():
        if key not in base:
            base[key] = value
            added += 1
    return added


def main():
    print("=" * 70)
    print("pfQuest-turtle to Questie Database Converter")
    print("Multi-source synthesis with QUEST DATA support")
    print("=" * 70)
    
    # Verify existing infrastructure
    print("\nVerifying existing infrastructure...")
    
    if not TURTLE_DIR.exists():
        print(f"ERROR: {TURTLE_DIR} does not exist!")
        sys.exit(1)
    
    if not TURTLE_ZHCN_DIR.exists():
        print(f"ERROR: {TURTLE_ZHCN_DIR} does not exist!")
        sys.exit(1)
    
    print(f"  Found: {TURTLE_DIR}")
    print(f"  Found: {TURTLE_ZHCN_DIR}")
    
    # =========================================================================
    # PHASE 1: Fetch all data
    # =========================================================================
    print("\n" + "-" * 70)
    print("PHASE 1: Fetching data from pfQuest-turtle")
    print("-" * 70)
    
    # Coordinate data
    print("\n  Fetching coordinate data...")
    units_data_content = fetch_url(PFQUEST_TURTLE_BASE + "db/units-turtle.lua")
    objects_data_content = fetch_url(PFQUEST_TURTLE_BASE + "db/objects-turtle.lua")
    
    # Quest data
    print("\n  Fetching quest data...")
    quests_data_content = fetch_url(PFQUEST_TURTLE_BASE + "db/quests-turtle.lua")
    
    # English names
    print("\n  Fetching English locale...")
    units_en_content = fetch_url(PFQUEST_TURTLE_BASE + "db/enUS/units-turtle.lua")
    items_en_content = fetch_url(PFQUEST_TURTLE_BASE + "db/enUS/items-turtle.lua")
    objects_en_content = fetch_url(PFQUEST_TURTLE_BASE + "db/enUS/objects-turtle.lua")
    quests_en_content = fetch_url(PFQUEST_TURTLE_BASE + "db/enUS/quests-turtle.lua")
    
    # Chinese names (official)
    print("\n  Fetching Chinese locale (official)...")
    units_zh_content = fetch_url(PFQUEST_TURTLE_BASE + "db/zhCN/units-turtle.lua")
    items_zh_content = fetch_url(PFQUEST_TURTLE_BASE + "db/zhCN/items-turtle.lua")
    objects_zh_content = fetch_url(PFQUEST_TURTLE_BASE + "db/zhCN/objects-turtle.lua")
    quests_zh_content = fetch_url(PFQUEST_TURTLE_BASE + "db/zhCN/quests-turtle.lua")
    
    # Chinese names (NineTears)
    print("\n  Fetching Chinese locale (NineTears)...")
    units_zh_nt = fetch_url(NINETEARS_BASE + "db/zhCN/units-turtle.lua")
    items_zh_nt = fetch_url(NINETEARS_BASE + "db/zhCN/items-turtle.lua")
    objects_zh_nt = fetch_url(NINETEARS_BASE + "db/zhCN/objects-turtle.lua")
    quests_zh_nt = fetch_url(NINETEARS_BASE + "db/zhCN/quests-turtle.lua")
    
    # =========================================================================
    # PHASE 2: Parse data
    # =========================================================================
    print("\n" + "-" * 70)
    print("PHASE 2: Parsing data")
    print("-" * 70)
    
    print("\n  Parsing coordinate data...")
    units_data = parse_data_table(units_data_content, "units")
    objects_data = parse_data_table(objects_data_content, "objects")
    print(f"    Units: {len(units_data)}, Objects: {len(objects_data)}")
    
    print("\n  Parsing quest data...")
    quest_data = parse_quest_data(quests_data_content)
    print(f"    Quests: {len(quest_data)}")
    
    print("\n  Parsing English names...")
    units_names_en = parse_name_table(units_en_content, 'pfDB["units"]["enUS-turtle"]')
    items_names_en = parse_name_table(items_en_content, 'pfDB["items"]["enUS-turtle"]')
    objects_names_en = parse_name_table(objects_en_content, 'pfDB["objects"]["enUS-turtle"]')
    quests_locale_en = parse_quest_locale(quests_en_content, "enUS")
    print(f"    Units: {len(units_names_en)}, Items: {len(items_names_en)}, Objects: {len(objects_names_en)}, Quests: {len(quests_locale_en)}")
    
    print("\n  Parsing Chinese names (merging sources)...")
    units_names_zh = parse_name_table(units_zh_content, 'pfDB["units"]["zhCN-turtle"]')
    items_names_zh = parse_name_table(items_zh_content, 'pfDB["items"]["zhCN-turtle"]')
    objects_names_zh = parse_name_table(objects_zh_content, 'pfDB["objects"]["zhCN-turtle"]')
    quests_locale_zh = parse_quest_locale(quests_zh_content, "zhCN")
    print(f"    Official - Units: {len(units_names_zh)}, Items: {len(items_names_zh)}, Objects: {len(objects_names_zh)}, Quests: {len(quests_locale_zh)}")
    
    # Merge NineTears
    units_nt = parse_name_table(units_zh_nt, 'pfDB["units"]["zhCN-turtle"]')
    items_nt = parse_name_table(items_zh_nt, 'pfDB["items"]["zhCN-turtle"]')
    objects_nt = parse_name_table(objects_zh_nt, 'pfDB["objects"]["zhCN-turtle"]')
    quests_nt = parse_quest_locale(quests_zh_nt, "zhCN")
    
    nt_added = merge_name_tables(units_names_zh, units_nt, "NineTears")
    nt_added += merge_name_tables(items_names_zh, items_nt, "NineTears")
    nt_added += merge_name_tables(objects_names_zh, objects_nt, "NineTears")
    for qid, qinfo in quests_nt.items():
        if qid not in quests_locale_zh:
            quests_locale_zh[qid] = qinfo
            nt_added += 1
    print(f"    NineTears added: +{nt_added} entries")
    print(f"    Final zhCN - Units: {len(units_names_zh)}, Items: {len(items_names_zh)}, Objects: {len(objects_names_zh)}, Quests: {len(quests_locale_zh)}")
    
    # =========================================================================
    # PHASE 3: Generate output
    # =========================================================================
    print("\n" + "-" * 70)
    print("PHASE 3: Generating Questie database files")
    print("-" * 70)
    
    # English file
    print(f"\n  Writing {TURTLE_DIR / 'init.lua'}")
    en_content = generate_init_lua(
        units_data, units_names_en,
        {}, items_names_en,  # items_data is empty (no coords)
        objects_data, objects_names_en,
        quest_data, quests_locale_en,
        "enUS"
    )
    (TURTLE_DIR / "init.lua").write_text(en_content, encoding='utf-8')
    print(f"    Size: {len(en_content):,} bytes")
    
    # Chinese file
    print(f"\n  Writing {TURTLE_ZHCN_DIR / 'init.lua'}")
    zh_content = generate_init_lua(
        units_data, units_names_zh,
        {}, items_names_zh,
        objects_data, objects_names_zh,
        quest_data, quests_locale_zh,
        "zhCN"
    )
    (TURTLE_ZHCN_DIR / "init.lua").write_text(zh_content, encoding='utf-8')
    print(f"    Size: {len(zh_content):,} bytes")
    
    # =========================================================================
    # Summary
    # =========================================================================
    print("\n" + "=" * 70)
    print("CONVERSION COMPLETE!")
    print("=" * 70)
    print(f"\nGenerated files:")
    print(f"  - {TURTLE_DIR / 'init.lua'}")
    print(f"  - {TURTLE_ZHCN_DIR / 'init.lua'}")
    print(f"\nNow includes:")
    print(f"  - Monster/NPC locations")
    print(f"  - World object locations")
    print(f"  - Quest tracking data (QuestieLevLookup + QuestieHashMap)")
    
    # Report unmapped zones
    if unmapped_zones:
        print(f"\n" + "-" * 70)
        print(f"WARNING: {len(unmapped_zones)} unmapped zone ID(s) found!")
        print(f"These locations were SKIPPED and need to be added to the converter:")
        print(f"-" * 70)
        for zone_id in sorted(unmapped_zones):
            print(f"  Zone ID {zone_id}: Add to AREATABLE_TO_MAPID or TURTLEWOW_ZONES")
        print(f"\nTo fix: Look up zone name in pfQuest db/enUS/zones.lua or zones-turtle.lua")
        print(f"Then add mapping to the appropriate table in this converter script.")
    else:
        print(f"\nAll zone IDs successfully mapped!")
    
    print(f"\nTest in TurtleWoW client to verify TurtleWoW-specific quests are now tracked.")


if __name__ == "__main__":
    main()
