#!/usr/bin/env python3
"""
pfQuest-turtle to Questie Database Converter

Generates TurtleWoW overlay data from pfQuest-turtle and writes the
ID-based overlay files consumed by Questie at runtime.

Now includes:
- Monster/NPC locations
- Object locations
- Item sources including drops, containers, and vendors
- Quest data including starters, finishers, objectives, prerequisites, and skill requirements

References infrastructure from: questie_zhcn_turtlewow_support_d56142ec.plan.md

Usage:
    python convert_pfquest_turtle.py

Output:
    Writes:
    - Database/turtle/data/units.lua
    - Database/turtle/data/objects.lua
    - Database/turtle/data/items.lua
    - Database/turtle/data/quests.lua
    - Database/turtle/locale/enUS/names.lua
    - Database/turtle/locale/zhCN/names.lua
"""

import re
import sys
from pathlib import Path
from datetime import datetime

# Configuration - Use local files
SCRIPT_DIR = Path(__file__).parent
QUESTIE_DIR = SCRIPT_DIR.parent
DATABASE_DIR = QUESTIE_DIR / "Database"
TURTLE_DIR = DATABASE_DIR / "turtle"

# Local data directories
PFQUEST_TURTLE_DIR = SCRIPT_DIR / "pfQuest-turtle" / "db"

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
    
    # Subzones (map to parent zone)
    42: 31,     # Darkshire → Duskwood
    
    # Additional instances/areas
    2159: 64,   # Onyxia's Lair (alternate ID)
    1941: 8,    # Caverns of Time → Tanaris
    2257: 78,   # Deeprun Tram
    
    # Battlegrounds (map to nearby zones for quest location purposes)
    2597: 26,   # Alterac Valley → Alterac Mountains
    3277: 2,    # Warsong Gulch → Ashenvale
    3358: 39,   # Arathi Basin → Arathi Highlands
    
    # Outdoor event areas
    3478: 5,    # Gates of Ahn'Qiraj → Silithus
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
    
    # ==================== TURTLEWOW CUSTOM SUBZONES ====================
    # These are TurtleWoW-specific subzones without direct world map presence
    # Mapped to the most appropriate nearby continent/zone combination
    5023: (1, 1),     # Sunnyglade Valley → Kalimdor (placeholder)
    5144: (40, 1),    # Deeprun Tram (TurtleWoW) → C40 (special instance)
    5557: (1, 1),     # Rock of Desolation → Kalimdor (high-level content)
    5628: (2, 1),     # Stormwrought Ruins → Eastern Kingdoms (placeholder)
}

CANONICAL_TURTLE_MAPIDS = {
    25: 1030,
    408: 1019,
    409: 1023,
    616: 1029,
    718: 1006,
    721: 1028,
    796: 1026,
    876: 1021,
    1337: 1021,
    1581: 1024,
    2100: 1014,
    2557: 1005,
    4012: 1027,
    5024: 1004,
    5077: 1033,
    5086: 1035,
    5087: 1036,
    5097: 1037,
    5103: 1034,
    5121: 1012,
    5130: 1031,
    5135: 1026,
    5136: 1026,
    5153: 1026,
    5163: 1026,
    5179: 1020,
    5208: 1032,
    5225: 1025,
    5536: 1016,
    5561: 1022,
    5581: 1018,
    5602: 1017,
    5601: 1038,
}

# Track unmapped zones for reporting
unmapped_zones = set()


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


def extract_named_table(entry_content: str, key: str) -> str | None:
    """Extract the raw contents of a keyed Lua table using balanced braces."""
    key_match = re.search(rf'\["{re.escape(key)}"\]\s*=\s*\{{', entry_content)
    if not key_match:
        return None

    brace_start = key_match.end() - 1
    depth = 1
    pos = brace_start + 1
    while pos < len(entry_content) and depth > 0:
        if entry_content[pos] == '{':
            depth += 1
        elif entry_content[pos] == '}':
            depth -= 1
        pos += 1

    if depth != 0:
        return None

    return entry_content[brace_start + 1:pos - 1]


def parse_items_data_table(content: str) -> dict:
    """Parse pfQuest items data table."""
    result = {}
    
    table_pattern = 'pfDB["items"]["data-turtle"]'
    start_idx = content.find(table_pattern)
    if start_idx == -1:
        return result
    
    brace_idx = content.find('{', start_idx)
    if brace_idx == -1:
        return result
    
    # Find matching closing brace
    depth = 1
    pos = brace_idx + 1
    while pos < len(content) and depth > 0:
        if content[pos] == '{':
            depth += 1
        elif content[pos] == '}':
            depth -= 1
        pos += 1
    
    table_content = content[brace_idx+1:pos-1]
    
    # Parse each item entry: [item_id] = { ... }
    item_pattern = re.compile(r'\[(\d+)\]\s*=\s*\{')
    for match in item_pattern.finditer(table_content):
        item_id = int(match.group(1))
        entry_start = match.end()
        
        # Find the matching closing brace for this entry
        depth = 1
        entry_pos = entry_start
        while entry_pos < len(table_content) and depth > 0:
            c = table_content[entry_pos]
            if c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
            entry_pos += 1
        
        entry_content = table_content[entry_start:entry_pos-1]
        
        # Skip empty entries
        if not entry_content.strip():
            continue
        
        entry = {}
        
        # Parse ["U"] = { [unit_id] = rate, ... } (units that drop item)
        u_match = re.search(r'\["U"\]\s*=\s*\{([^}]*)\}', entry_content)
        if u_match:
            units = {}
            for unit_match in re.finditer(r'\[(\d+)\]\s*=\s*([\d.]+)', u_match.group(1)):
                unit_id = int(unit_match.group(1))
                rate = float(unit_match.group(2))
                units[unit_id] = rate
            if units:
                entry["U"] = units
        
        # Parse ["O"] = { [obj_id] = rate, ... } (objects that contain item)
        o_match = re.search(r'\["O"\]\s*=\s*\{([^}]*)\}', entry_content)
        if o_match:
            objects = {}
            for obj_match in re.finditer(r'\[(\d+)\]\s*=\s*([\d.]+)', o_match.group(1)):
                obj_id = int(obj_match.group(1))
                rate = float(obj_match.group(2))
                objects[obj_id] = rate
            if objects:
                entry["O"] = objects

        # Parse ["V"] = { [vendor_id] = price, ... } (vendors that sell item)
        v_match = re.search(r'\["V"\]\s*=\s*\{([^}]*)\}', entry_content)
        if v_match:
            vendors = {}
            for vendor_match in re.finditer(r'\[(\d+)\]\s*=\s*([\d.]+)', v_match.group(1)):
                vendor_id = int(vendor_match.group(1))
                vendors[vendor_id] = 1
            if vendors:
                entry["V"] = vendors

        if entry:
            result[item_id] = entry
    
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

        # Parse profession / skill requirement
        skill_match = re.search(r'\["skill"\]\s*=\s*(\d+)', entry_content)
        if skill_match:
            quest["skill"] = int(skill_match.group(1))
        
        # Parse start (quest giver)
        start_content = extract_named_table(entry_content, "start")
        if start_content:
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
        end_content = extract_named_table(entry_content, "end")
        if end_content:
            quest["end"] = {}
            u_match = re.search(r'\["U"\]\s*=\s*\{\s*(\d+)', end_content)
            if u_match:
                quest["end"]["U"] = int(u_match.group(1))
            o_match = re.search(r'\["O"\]\s*=\s*\{\s*(\d+)', end_content)
            if o_match:
                quest["end"]["O"] = int(o_match.group(1))

        # Parse objectives
        obj_content = extract_named_table(entry_content, "obj")
        if obj_content:
            quest["obj"] = {}
            u_match = re.search(r'\["U"\]\s*=\s*\{([^}]*)\}', obj_content)
            if u_match:
                units = [int(x) for x in re.findall(r'(\d+)', u_match.group(1))]
                if units:
                    quest["obj"]["U"] = units
            i_match = re.search(r'\["I"\]\s*=\s*\{([^}]*)\}', obj_content)
            if i_match:
                items = [int(x) for x in re.findall(r'(\d+)', i_match.group(1))]
                if items:
                    quest["obj"]["I"] = items
            o_match = re.search(r'\["O"\]\s*=\s*\{([^}]*)\}', obj_content)
            if o_match:
                objects = [int(x) for x in re.findall(r'(\d+)', o_match.group(1))]
                if objects:
                    quest["obj"]["O"] = objects
            if not quest["obj"]:
                del quest["obj"]

        # Parse prerequisites
        pre_match = re.search(r'\["pre"\]\s*=\s*\{([^}]*)\}', entry_content)
        if pre_match:
            pre_quests = [int(x) for x in re.findall(r'(\d+)', pre_match.group(1))]
            if pre_quests:
                quest["pre"] = pre_quests

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


# NEW ID-BASED GENERATION FUNCTIONS
# ============================================================================

def escape_lua_string(s: str) -> str:
    """Escape a string for Lua."""
    if not s:
        return ""
    return s.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '')


def generate_turtle_units_data(units_data: dict) -> str:
    """Generate Database/turtle/data/units.lua content."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    lines = [
        '-- TurtleWoW Unit Data Overlay (ID-based)',
        f'-- Auto-generated by convert_pfquest_turtle.py on {timestamp}',
        '-- Source: pfQuest-turtle database',
        '',
        'QuestieUnitDataTurtle = {',
    ]
    
    for unit_id in sorted(units_data.keys()):
        data = units_data[unit_id]
        coords = data.get("coords", [])
        if not coords:
            continue
        
        locations = []
        for x, y, zone in coords:
            qx = x / 100.0
            qy = y / 100.0
            
            if zone in AREATABLE_TO_MAPID:
                map_id = AREATABLE_TO_MAPID[zone]
                locations.append(('old', map_id, qx, qy))
            elif zone in CANONICAL_TURTLE_MAPIDS:
                map_id = CANONICAL_TURTLE_MAPIDS[zone]
                locations.append(('old', map_id, qx, qy))
            elif zone in TURTLEWOW_ZONES:
                continent, turtle_zone = TURTLEWOW_ZONES[zone]
                locations.append(('new', continent, turtle_zone, qx, qy))
            else:
                unmapped_zones.add(zone)
                continue
        
        if not locations:
            continue
        
        lines.append(f'  [{unit_id}] = {{')
        lines.append('    locations = {')
        for i, loc in enumerate(locations[:50], 1):
            if loc[0] == 'old':
                _, map_id, x, y = loc
                lines.append(f'      [{i}] = {{{map_id}, {x:.4f}, {y:.4f}}},')
            else:
                _, continent, turtle_zone, x, y = loc
                lines.append(f'      [{i}] = {{{continent}, {turtle_zone}, {x:.4f}, {y:.4f}}},')
        lines.append('    },')
        lines.append('  },')
    
    lines.append('}')
    return '\n'.join(lines)


def generate_turtle_objects_data(objects_data: dict) -> str:
    """Generate Database/turtle/data/objects.lua content."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    lines = [
        '-- TurtleWoW Object Data Overlay (ID-based)',
        f'-- Auto-generated by convert_pfquest_turtle.py on {timestamp}',
        '-- Source: pfQuest-turtle database',
        '',
        'QuestieObjectDataTurtle = {',
    ]
    
    for obj_id in sorted(objects_data.keys()):
        data = objects_data[obj_id]
        coords = data.get("coords", [])
        if not coords:
            continue
        
        locations = []
        for x, y, zone in coords:
            qx = x / 100.0
            qy = y / 100.0
            
            if zone in AREATABLE_TO_MAPID:
                map_id = AREATABLE_TO_MAPID[zone]
                locations.append(('old', map_id, qx, qy))
            elif zone in CANONICAL_TURTLE_MAPIDS:
                map_id = CANONICAL_TURTLE_MAPIDS[zone]
                locations.append(('old', map_id, qx, qy))
            elif zone in TURTLEWOW_ZONES:
                continent, turtle_zone = TURTLEWOW_ZONES[zone]
                locations.append(('new', continent, turtle_zone, qx, qy))
            else:
                unmapped_zones.add(zone)
                continue
        
        if not locations:
            continue
        
        lines.append(f'  [{obj_id}] = {{')
        lines.append('    locations = {')
        for i, loc in enumerate(locations[:50], 1):
            if loc[0] == 'old':
                _, map_id, x, y = loc
                lines.append(f'      [{i}] = {{{map_id}, {x:.4f}, {y:.4f}}},')
            else:
                _, continent, turtle_zone, x, y = loc
                lines.append(f'      [{i}] = {{{continent}, {turtle_zone}, {x:.4f}, {y:.4f}}},')
        lines.append('    },')
        lines.append('  },')
    
    lines.append('}')
    return '\n'.join(lines)


def generate_turtle_items_data(items_data: dict) -> str:
    """Generate Database/turtle/data/items.lua content."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    lines = [
        '-- TurtleWoW Item Data Overlay (ID-based)',
        f'-- Auto-generated by convert_pfquest_turtle.py on {timestamp}',
        '-- Source: pfQuest-turtle database',
        '',
        'QuestieItemDataTurtle = {',
    ]
    
    for item_id in sorted(items_data.keys()):
        data = items_data[item_id]
        
        drop_units = list(data.get("U", {}).keys())
        contained_objects = list(data.get("O", {}).keys())
        vendor_units = list(data.get("V", {}).keys())
        
        if not drop_units and not contained_objects and not vendor_units:
            continue
        
        lines.append(f'  [{item_id}] = {{')
        
        if drop_units:
            units_str = ', '.join(str(u) for u in sorted(drop_units))
            lines.append(f'    dropUnits = {{{units_str}}},')
        
        if contained_objects:
            objs_str = ', '.join(str(o) for o in sorted(contained_objects))
            lines.append(f'    containedObjects = {{{objs_str}}},')

        if vendor_units:
            vendors_str = ', '.join(str(v) for v in sorted(vendor_units))
            lines.append(f'    vendorUnits = {{{vendors_str}}},')
        
        lines.append('  },')
    
    lines.append('}')
    return '\n'.join(lines)


def generate_turtle_quests_data(quest_data: dict) -> str:
    """Generate Database/turtle/data/quests.lua content."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    lines = [
        '-- TurtleWoW Quest Data Overlay (ID-based)',
        f'-- Auto-generated by convert_pfquest_turtle.py on {timestamp}',
        '-- Source: pfQuest-turtle database',
        '',
        'QuestieQuestDataTurtle = {',
    ]
    
    for quest_id in sorted(quest_data.keys()):
        data = quest_data[quest_id]
        
        lines.append(f'  [{quest_id}] = {{')
        
        if "lvl" in data:
            lines.append(f'    level = {data["lvl"]},')
        if "min" in data:
            lines.append(f'    minLevel = {data["min"]},')
        if "race" in data:
            lines.append(f'    race = {data["race"]},')
        if "class" in data:
            lines.append(f'    class = {data["class"]},')
        if "skill" in data:
            lines.append(f'    skill = {data["skill"]},')
        
        if "start" in data:
            if "U" in data["start"]:
                lines.append(f'    startUnit = {data["start"]["U"]},')
            if "I" in data["start"]:
                lines.append(f'    startItem = {data["start"]["I"]},')
            if "O" in data["start"]:
                lines.append(f'    startObject = {data["start"]["O"]},')
        
        if "end" in data:
            if "U" in data["end"]:
                lines.append(f'    endUnit = {data["end"]["U"]},')
            if "O" in data["end"]:
                lines.append(f'    endObject = {data["end"]["O"]},')

        if "obj" in data:
            if "U" in data["obj"]:
                units_str = ', '.join(str(u) for u in data["obj"]["U"])
                lines.append(f'    objectiveUnits = {{{units_str}}},')
            if "I" in data["obj"]:
                items_str = ', '.join(str(i) for i in data["obj"]["I"])
                lines.append(f'    objectiveItems = {{{items_str}}},')
            if "O" in data["obj"]:
                objs_str = ', '.join(str(o) for o in data["obj"]["O"])
                lines.append(f'    objectiveObjects = {{{objs_str}}},')

        if "pre" in data:
            pre_str = ', '.join(str(p) for p in data["pre"])
            lines.append(f'    preQuests = {{{pre_str}}},')
        
        lines.append('  },')
    
    lines.append('}')
    return '\n'.join(lines)


def generate_turtle_names_lua(unit_names: dict, object_names: dict, item_names: dict,
                              quest_locale: dict, locale: str) -> str:
    """Generate TurtleWoW locale names.lua content."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    if locale == "enUS":
        header = [
            '-- TurtleWoW Name Mappings Overlay (English)',
            f'-- Auto-generated by convert_pfquest_turtle.py on {timestamp}',
            '-- Source: pfQuest-turtle database',
        ]
    else:
        header = [
            '-- TurtleWoW Name Mappings Overlay (Simplified Chinese)',
            '-- TurtleWoW 名称映射表覆盖层（简体中文）',
            f'-- Auto-generated by convert_pfquest_turtle.py on {timestamp}',
            '-- Source: pfQuest-turtle database',
        ]
    
    lines = header + ['']
    
    # Unit names
    lines.append('QuestieUnitNamesTurtle = {')
    for unit_id in sorted(unit_names.keys()):
        name = escape_lua_string(unit_names[unit_id])
        lines.append(f'  [{unit_id}] = "{name}",')
    lines.append('}')
    lines.append('')
    
    # Object names
    lines.append('QuestieObjectNamesTurtle = {')
    for obj_id in sorted(object_names.keys()):
        name = escape_lua_string(object_names[obj_id])
        lines.append(f'  [{obj_id}] = "{name}",')
    lines.append('}')
    lines.append('')
    
    # Item names
    lines.append('QuestieItemNamesTurtle = {')
    for item_id in sorted(item_names.keys()):
        name = escape_lua_string(item_names[item_id])
        lines.append(f'  [{item_id}] = "{name}",')
    lines.append('}')
    lines.append('')
    
    # Quest names
    lines.append('QuestieQuestNamesTurtle = {')
    for quest_id in sorted(quest_locale.keys()):
        info = quest_locale[quest_id]
        title = escape_lua_string(info.get("T", ""))
        objectives = escape_lua_string(info.get("O", ""))
        if title:
            lines.append(f'  [{quest_id}] = {{')
            lines.append(f'    title = "{title}",')
            lines.append(f'    objectives = "{objectives}",')
            lines.append('  },')
    lines.append('}')
    
    return '\n'.join(lines)


def merge_name_tables(base: dict, additional: dict, source_name: str) -> int:
    """Merge additional names into base table."""
    added = 0
    for key, value in additional.items():
        if key not in base:
            base[key] = value
            added += 1
    return added


def turtle_zone_to_canonical_map_id(zone_id: int):
    """Resolve a Turtle zone id to a canonical Questie map id when available."""
    if zone_id in AREATABLE_TO_MAPID:
        return AREATABLE_TO_MAPID[zone_id]
    if zone_id in CANONICAL_TURTLE_MAPIDS:
        return CANONICAL_TURTLE_MAPIDS[zone_id]
    return None


def turtle_zone_has_legacy_mapping(zone_id: int) -> bool:
    """Return True when a zone can still be emitted in legacy continent/zone tuple form."""
    return zone_id in TURTLEWOW_ZONES


def has_turtle_entity_locations(entity_data: dict, entity_id: int) -> bool:
    """Return True when an entity has at least one canonical or legacy Turtle location."""
    entry = entity_data.get(entity_id)
    if not entry:
        return False

    for _, _, zone_id in entry.get("coords", []):
        if turtle_zone_to_canonical_map_id(zone_id) is not None or turtle_zone_has_legacy_mapping(zone_id):
            return True

    return False


def item_has_turtle_locations(item_id: int, items_data: dict, units_data: dict, objects_data: dict) -> bool:
    """Return True when an item starter/source can be resolved through canonical locations."""
    item_data = items_data.get(item_id)
    if not item_data:
        return False

    for unit_id in item_data.get("U", {}).keys():
        if has_turtle_entity_locations(units_data, unit_id):
            return True

    for object_id in item_data.get("O", {}).keys():
        if has_turtle_entity_locations(objects_data, object_id):
            return True

    for vendor_id in item_data.get("V", {}).keys():
        if has_turtle_entity_locations(units_data, vendor_id):
            return True

    return False


def collect_noncanonical_turtle_zones(*entity_tables: dict) -> set:
    """Collect zone ids that would require legacy continent/zone tuple output."""
    missing = set()

    for entity_table in entity_tables:
        for entry in entity_table.values():
            for _, _, zone_id in entry.get("coords", []):
                if turtle_zone_to_canonical_map_id(zone_id) is None and turtle_zone_has_legacy_mapping(zone_id):
                    missing.add(zone_id)

    return missing


def validate_turtle_structured_quest_db(quest_data: dict, units_data: dict, objects_data: dict, items_data: dict) -> None:
    """Report unresolved Turtle quest/entity links without aborting generation."""
    issues = []

    def add_issue(quest_id: int, message: str) -> None:
        issues.append(f"quest {quest_id}: {message}")

    noncanonical_zones = collect_noncanonical_turtle_zones(units_data, objects_data)
    if noncanonical_zones:
        print("\nWARNING: Turtle canonical map validation found legacy tuple zones.")
        for zone_id in sorted(noncanonical_zones):
            print(f"  - zone {zone_id} will remain in legacy continent/zone tuple form")

    for quest_id in sorted(quest_data.keys()):
        quest = quest_data[quest_id]
        start = quest.get("start", {})
        end = quest.get("end", {})

        if "U" in start and not has_turtle_entity_locations(units_data, start["U"]):
            add_issue(quest_id, f"startUnit {start['U']} has no canonical locations")
        if "O" in start and not has_turtle_entity_locations(objects_data, start["O"]):
            add_issue(quest_id, f"startObject {start['O']} has no canonical locations")
        if "I" in start and not item_has_turtle_locations(start["I"], items_data, units_data, objects_data):
            add_issue(quest_id, f"startItem {start['I']} has no canonical sources")

        if "U" in end and not has_turtle_entity_locations(units_data, end["U"]):
            add_issue(quest_id, f"endUnit {end['U']} has no canonical locations")
        if "O" in end and not has_turtle_entity_locations(objects_data, end["O"]):
            add_issue(quest_id, f"endObject {end['O']} has no canonical locations")

    if issues:
        print("\nWARNING: Turtle structured quest validation found unresolved links.")
        for issue in issues[:50]:
            print(f"  - {issue}")
        if len(issues) > 50:
            print(f"  - ... and {len(issues) - 50} more")
        print("  Generation will continue; unresolved quests may lack starter/finisher markers.")


def main():
    print("=" * 70)
    print("pfQuest-turtle to Questie Database Converter")
    print("Structured Turtle overlay generation from pfQuest-turtle")
    print("=" * 70)
    
    # Verify existing infrastructure
    print("\nVerifying existing infrastructure...")
    
    if not TURTLE_DIR.exists():
        print(f"ERROR: {TURTLE_DIR} does not exist!")
        sys.exit(1)
    
    print(f"  Found: {TURTLE_DIR}")
    
    # =========================================================================
    # PHASE 1: Load all data from local files
    # =========================================================================
    print("\n" + "-" * 70)
    print("PHASE 1: Loading data from local pfQuest-turtle files")
    print("-" * 70)
    
    def read_local_file(path):
        """Read content from local file."""
        try:
            with open(path, 'r', encoding='utf-8') as f:
                return f.read()
        except FileNotFoundError:
            print(f"    Warning: File not found: {path}")
            return ""
        except Exception as e:
            print(f"    Error reading {path}: {e}")
            return ""
    
    # Coordinate data
    print("\n  Loading coordinate data...")
    units_data_content = read_local_file(PFQUEST_TURTLE_DIR / "units-turtle.lua")
    objects_data_content = read_local_file(PFQUEST_TURTLE_DIR / "objects-turtle.lua")
    items_data_content = read_local_file(PFQUEST_TURTLE_DIR / "items-turtle.lua")
    
    # Quest data
    print("\n  Loading quest data...")
    quests_data_content = read_local_file(PFQUEST_TURTLE_DIR / "quests-turtle.lua")
    
    # English names
    print("\n  Loading English locale...")
    units_en_content = read_local_file(PFQUEST_TURTLE_DIR / "enUS" / "units-turtle.lua")
    items_en_content = read_local_file(PFQUEST_TURTLE_DIR / "enUS" / "items-turtle.lua")
    objects_en_content = read_local_file(PFQUEST_TURTLE_DIR / "enUS" / "objects-turtle.lua")
    quests_en_content = read_local_file(PFQUEST_TURTLE_DIR / "enUS" / "quests-turtle.lua")
    
    # Chinese names (official)
    print("\n  Loading Chinese locale...")
    units_zh_content = read_local_file(PFQUEST_TURTLE_DIR / "zhCN" / "units-turtle.lua")
    items_zh_content = read_local_file(PFQUEST_TURTLE_DIR / "zhCN" / "items-turtle.lua")
    objects_zh_content = read_local_file(PFQUEST_TURTLE_DIR / "zhCN" / "objects-turtle.lua")
    quests_zh_content = read_local_file(PFQUEST_TURTLE_DIR / "zhCN" / "quests-turtle.lua")
    
    # NineTears translations (skip if not available locally)
    print("\n  Loading NineTears translations (if available)...")
    units_zh_nt = ""
    items_zh_nt = ""
    objects_zh_nt = ""
    quests_zh_nt = ""
    
    # =========================================================================
    # PHASE 2: Parse data
    # =========================================================================
    print("\n" + "-" * 70)
    print("PHASE 2: Parsing data")
    print("-" * 70)
    
    print("\n  Parsing coordinate data...")
    units_data = parse_data_table(units_data_content, "units")
    objects_data = parse_data_table(objects_data_content, "objects")
    items_data = parse_items_data_table(items_data_content)
    print(f"    Units: {len(units_data)}, Objects: {len(objects_data)}, Items: {len(items_data)}")
    
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
    
    validate_turtle_structured_quest_db(quest_data, units_data, objects_data, items_data)
    
    # =========================================================================
    # PHASE 3: Generate ID-based output files (NEW FORMAT)
    # =========================================================================
    print("\n" + "-" * 70)
    print("PHASE 3: Generating ID-based TurtleWoW overlay files")
    print("-" * 70)
    
    # Create output directories
    turtle_data_dir = DATABASE_DIR / "turtle" / "data"
    turtle_locale_enus_dir = DATABASE_DIR / "turtle" / "locale" / "enUS"
    turtle_locale_zhcn_dir = DATABASE_DIR / "turtle" / "locale" / "zhCN"
    
    turtle_data_dir.mkdir(parents=True, exist_ok=True)
    turtle_locale_enus_dir.mkdir(parents=True, exist_ok=True)
    turtle_locale_zhcn_dir.mkdir(parents=True, exist_ok=True)
    
    # Generate data files
    print("\n  Generating TurtleWoW data files...")
    
    units_lua = generate_turtle_units_data(units_data)
    (turtle_data_dir / "units.lua").write_text(units_lua, encoding='utf-8')
    print(f"    {turtle_data_dir / 'units.lua'}")
    
    objects_lua = generate_turtle_objects_data(objects_data)
    (turtle_data_dir / "objects.lua").write_text(objects_lua, encoding='utf-8')
    print(f"    {turtle_data_dir / 'objects.lua'}")
    
    items_lua = generate_turtle_items_data(items_data)
    (turtle_data_dir / "items.lua").write_text(items_lua, encoding='utf-8')
    print(f"    {turtle_data_dir / 'items.lua'}")
    
    quests_lua = generate_turtle_quests_data(quest_data)
    (turtle_data_dir / "quests.lua").write_text(quests_lua, encoding='utf-8')
    print(f"    {turtle_data_dir / 'quests.lua'}")
    
    # Generate English locale file
    print("\n  Generating TurtleWoW English names...")
    names_enus_lua = generate_turtle_names_lua(units_names_en, objects_names_en, items_names_en, quests_locale_en, "enUS")
    (turtle_locale_enus_dir / "names.lua").write_text(names_enus_lua, encoding='utf-8')
    print(f"    {turtle_locale_enus_dir / 'names.lua'}")
    
    # Generate Chinese locale file
    print("\n  Generating TurtleWoW Chinese names...")
    names_zhcn_lua = generate_turtle_names_lua(units_names_zh, objects_names_zh, items_names_zh, quests_locale_zh, "zhCN")
    (turtle_locale_zhcn_dir / "names.lua").write_text(names_zhcn_lua, encoding='utf-8')
    print(f"    {turtle_locale_zhcn_dir / 'names.lua'}")
    
    # =========================================================================
    # Summary
    # =========================================================================
    print("\n" + "=" * 70)
    print("CONVERSION COMPLETE!")
    print("=" * 70)
    print(f"\nGenerated ID-based files:")
    print(f"  - {turtle_data_dir / 'units.lua'}")
    print(f"  - {turtle_data_dir / 'objects.lua'}")
    print(f"  - {turtle_data_dir / 'items.lua'}")
    print(f"  - {turtle_data_dir / 'quests.lua'}")
    print(f"  - {turtle_locale_enus_dir / 'names.lua'}")
    print(f"  - {turtle_locale_zhcn_dir / 'names.lua'}")
    print(f"\nNow includes:")
    print(f"  - Monster/NPC locations (ID-based)")
    print(f"  - World object locations (ID-based)")
    print(f"  - Item sources including vendors (ID-based)")
    print(f"  - Quest starters, finishers, objectives, prerequisites, and skill requirements")
    print(f"\nQuestie questId metadata is built at runtime from these ID-based overlay tables.")
    
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
