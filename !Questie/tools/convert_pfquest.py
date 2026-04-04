#!/usr/bin/env python3
"""
Vanilla Questie ID-Based Database Converter

Generates ID-based database files for Questie from:
- ClassicDB / CMaNGOS SQL (authoritative vanilla quests, items, relations, and names)
- Current vanilla pfQuest extracts (coordinates and remaining data complements)
- pfQuest locale files (fallback text where SQL/locales are incomplete)

Note:
    Vanilla structured data is built from the database first. pfQuest is used
    only to complement missing coordinates or missing text/source coverage that
    is not present in the extracted database inputs.

Output Files:
- Database/data/units.lua      - Unit location data by ID
- Database/data/objects.lua    - Object location data by ID
- Database/data/items.lua      - Item source data by ID
- Database/data/quests.lua     - Quest data by ID
- Database/locale/enUS/names.lua - English name mappings
- Database/locale/zhCN/names.lua - Chinese name mappings

Usage:
    python convert_pfquest.py
"""

import os
import re
import sys
import copy
from pathlib import Path
from collections import defaultdict
from datetime import datetime

# Script paths
SCRIPT_DIR = Path(__file__).parent
QUESTIE_DIR = SCRIPT_DIR.parent
DATABASE_DIR = QUESTIE_DIR / "Database"

# Source data paths
PFQUEST_DIR = SCRIPT_DIR / "pfQuest" / "db"
CMANGOS_DIR = SCRIPT_DIR / "classic-db-master" / "locales" / "Chinese"
CMANGOS_FULLDB_DIR = SCRIPT_DIR / "classic-db-master" / "Full_DB"

# Output paths
DATA_DIR = DATABASE_DIR / "data"
LOCALE_ENUS_DIR = DATABASE_DIR / "locale" / "enUS"
LOCALE_ZHCN_DIR = DATABASE_DIR / "locale" / "zhCN"

# AreaTable ID (pfQuest) → mapID (Questie) conversion table
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
    
    # Instances
    2437: 52,   # Ragefire Chasm
    1176: 53,   # Zul'Farrak
    1477: 54,   # Sunken Temple
    719: 55,    # Blackfathom Deeps
    717: 56,    # The Stockade
    721: 57,    # Gnomeregan
    876: 58,    # Uldaman
    2717: 59,   # Molten Core
    1977: 60,   # Zul'Gurub
    2557: 61,   # Dire Maul
    1584: 62,   # Blackrock Depths
    3429: 63,   # Ruins of Ahn'Qiraj
    2040: 64,   # Onyxia's Lair
    1583: 65,   # Blackrock Spire
    718: 66,    # Wailing Caverns
    2100: 67,   # Maraudon
    2677: 68,   # Blackwing Lair
    1581: 69,   # Deadmines
    722: 70,    # Razorfen Downs
    491: 71,    # Razorfen Kraul
    796: 72,    # Scarlet Monastery
    2057: 73,   # Scholomance
    209: 74,    # Shadowfang Keep
    2017: 75,   # Stratholme
    3428: 76,   # Ahn'Qiraj Temple
    3456: 77,   # Naxxramas
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

# Track unmapped zones
unmapped_zones = set()

# WorldMapArea ID (quest_poi.mapAreaId) → Questie mapID conversion
# Based on WorldMapArea.dbc extraction and zone.lua Questie mapIDs
# Format: WorldMapAreaID: QuestieMapID
WORLDMAPAREA_TO_MAPID = {
    # ==================== KALIMDOR ====================
    4: 7,       # Durotar (WorldMapArea 4 → Questie mapID 7)
    9: 22,      # Mulgore (WorldMapArea 9 → Questie mapID 22)
    11: 11,     # Barrens (WorldMapArea 11 → Questie mapID 11)
    41: 24,     # Teldrassil (WorldMapArea 41 → Questie mapID 24)
    42: 16,     # Darkshore (WorldMapArea 42 → Questie mapID 16)
    43: 2,      # Ashenvale (WorldMapArea 43 → Questie mapID 2)
    61: 14,     # ThousandNeedles (WorldMapArea 61 → Questie mapID 14)
    81: 6,      # StonetalonMountains (WorldMapArea 81 → Questie mapID 6)
    101: 4,     # Desolace (WorldMapArea 101 → Questie mapID 4)
    121: 17,    # Feralas (WorldMapArea 121 → Questie mapID 17)
    141: 10,    # Dustwallow (WorldMapArea 141 → Questie mapID 10)
    161: 8,     # Tanaris (WorldMapArea 161 → Questie mapID 8)
    181: 15,    # Azshara (WorldMapArea 181 → Questie mapID 15)
    182: 13,    # Felwood (WorldMapArea 182 → Questie mapID 13)
    201: 18,    # UngoroCrater (WorldMapArea 201 → Questie mapID 18)
    241: 20,    # Moonglade (WorldMapArea 241 → Questie mapID 20)
    261: 5,     # Silithus (WorldMapArea 261 → Questie mapID 5)
    281: 19,    # Winterspring (WorldMapArea 281 → Questie mapID 19)
    321: 1,     # Orgrimmar (WorldMapArea 321 → Questie mapID 1)
    362: 23,    # ThunderBluff (WorldMapArea 362 → Questie mapID 23)
    381: 21,    # Darnassus (WorldMapArea 381 → Questie mapID 21)
    
    # ==================== EASTERN KINGDOMS ====================
    15: 26,     # Alterac (WorldMapArea 15 → Questie mapID 26)
    16: 39,     # Arathi (WorldMapArea 16 → Questie mapID 39)
    17: 27,     # Badlands (WorldMapArea 17 → Questie mapID 27)
    19: 33,     # BlastedLands (WorldMapArea 19 → Questie mapID 33)
    20: 43,     # Tirisfal (WorldMapArea 20 → Questie mapID 43)
    21: 35,     # Silverpine (WorldMapArea 21 → Questie mapID 35)
    22: 50,     # WesternPlaguelands (WorldMapArea 22 → Questie mapID 50)
    23: 34,     # EasternPlaguelands (WorldMapArea 23 → Questie mapID 34)
    24: 48,     # Hillsbrad (WorldMapArea 24 → Questie mapID 48)
    26: 42,     # Hinterlands (WorldMapArea 26 → Questie mapID 42)
    27: 28,     # DunMorogh (WorldMapArea 27 → Questie mapID 28)
    28: 32,     # SearingGorge (WorldMapArea 28 → Questie mapID 32)
    29: 40,     # BurningSteppes (WorldMapArea 29 → Questie mapID 40)
    30: 37,     # Elwynn (WorldMapArea 30 → Questie mapID 37)
    32: 47,     # DeadwindPass (WorldMapArea 32 → Questie mapID 47)
    34: 31,     # Duskwood (WorldMapArea 34 → Questie mapID 31)
    35: 29,     # LochModan (WorldMapArea 35 → Questie mapID 29)
    36: 30,     # Redridge (WorldMapArea 36 → Questie mapID 30)
    37: 38,     # Stranglethorn (WorldMapArea 37 → Questie mapID 38)
    38: 46,     # SwampOfSorrows (WorldMapArea 38 → Questie mapID 46)
    39: 49,     # Westfall (WorldMapArea 39 → Questie mapID 49)
    40: 51,     # Wetlands (WorldMapArea 40 → Questie mapID 51)
    301: 36,    # Stormwind (WorldMapArea 301 → Questie mapID 36)
    341: 25,    # Ironforge (WorldMapArea 341 → Questie mapID 25)
    382: 45,    # Undercity (WorldMapArea 382 → Questie mapID 45)
    242: 62,    # Blackrock Depths
    247: 63,    # Ruins of Ahn'Qiraj
    248: 64,    # Onyxia's Lair
    250: 65,    # Blackrock Spire
    279: 66,    # Wailing Caverns
    280: 67,    # Maraudon
    287: 68,    # Blackwing Lair
    291: 69,    # Deadmines
    300: 70,    # Razorfen Downs
    302: 71,    # Razorfen Kraul
    310: 72,    # Scarlet Monastery
    311: 73,    # Scholomance
    312: 74,    # Shadowfang Keep
    317: 75,    # Stratholme
    319: 76,    # Ahn'Qiraj Temple
    320: 77,    # Naxxramas
    
    # Battlegrounds
    401: 26,    # Alterac Valley → Alterac Mountains
    443: 2,     # Warsong Gulch → Ashenvale
    461: 39,    # Arathi Basin → Arathi Highlands
}

# Internal map ID (creature/gameobject spawn table) â†’ Questie mapID.
# World maps 0/1 are resolved from world coordinates to specific zones.
INTERNAL_MAP_TO_QUESTIE_MAPID = {
    30: 26,    # Alterac Valley
    33: 74,    # Shadowfang Keep
    34: 56,    # The Stockade
    36: 69,    # Deadmines
    43: 66,    # Wailing Caverns
    47: 71,    # Razorfen Kraul
    48: 55,    # Blackfathom Deeps
    70: 58,    # Uldaman
    90: 57,    # Gnomeregan
    109: 54,   # Sunken Temple
    129: 70,   # Razorfen Downs
    189: 72,   # Scarlet Monastery
    209: 53,   # Zul'Farrak
    229: 65,   # Blackrock Spire
    230: 62,   # Blackrock Depths
    249: 64,   # Onyxia's Lair
    289: 73,   # Scholomance
    309: 60,   # Zul'Gurub
    329: 75,   # Stratholme
    349: 67,   # Maraudon
    369: 78,   # Deeprun Tram
    389: 52,   # Ragefire Chasm
    409: 59,   # Molten Core
    429: 61,   # Dire Maul
    469: 68,   # Blackwing Lair
    489: 2,    # Warsong Gulch â†’ Ashenvale
    509: 63,   # Ruins of Ahn'Qiraj
    529: 39,   # Arathi Basin â†’ Arathi Highlands
    531: 76,   # Ahn'Qiraj Temple
    533: 77,   # Naxxramas
}

WORLD_SPAWN_AREA_EXTENTS = {
    # Kalimdor
    4: (-1962.499878, -7249.999512, 1808.333252, -1716.666626),
    9: (2047.916626, -3089.583252, -272.916656, -3697.916504),
    11: (2622.916504, -7510.416504, 1612.499878, -5143.750000),
    41: (3814.583252, -1277.083252, 11831.250000, 8437.500000),
    42: (2941.666504, -3608.333252, 8333.333008, 3966.666504),
    43: (1699.999878, -4066.666504, 4672.916504, 829.166626),
    61: (-433.333313, -4833.333008, -3966.666504, -6899.999512),
    81: (3245.833252, -1637.499878, 2916.666504, -339.583313),
    101: (4233.333008, -262.500000, 452.083313, -2545.833252),
    121: (5441.666504, -1508.333252, -2366.666504, -6999.999512),
    141: (-974.999939, -6225.000000, -2033.333252, -5533.333008),
    161: (-218.749985, -7118.749512, -5875.000000, -10475.000000),
    181: (-3277.083252, -8347.916016, 5341.666504, 1960.416626),
    182: (1641.666626, -4108.333008, 7133.333008, 3299.999756),
    201: (533.333313, -3166.666504, -5966.666504, -8433.333008),
    241: (-1381.250000, -3689.583252, 8491.666016, 6952.083008),
    261: (4641.666504, -2308.333252, -5800.000000, -10433.333008),
    281: (-316.666656, -7416.666504, 8533.333008, 3799.999756),
    321: (-3680.601074, -5083.205566, 2273.877197, 1338.460571),
    362: (516.666626, -527.083313, -849.999939, -1545.833252),
    381: (2938.362793, 1880.029541, 10238.316406, 9532.586914),
    # Eastern Kingdoms
    15: (783.333313, -2016.666626, 1500.000000, -366.666656),
    16: (-866.666626, -4466.666504, -133.333328, -2533.333252),
    17: (-2079.166504, -4566.666504, -5889.583008, -7547.916504),
    19: (-1241.666626, -4591.666504, -10566.666016, -12800.000000),
    20: (3033.333252, -1485.416626, 3837.499756, 824.999939),
    21: (3449.999756, -750.000000, 1666.666626, -1133.333252),
    22: (416.666656, -3883.333252, 3366.666504, 499.999969),
    23: (-2185.416504, -6056.250000, 3799.999756, 1218.750000),
    24: (1066.666626, -2133.333252, 400.000000, -1733.333252),
    26: (-1575.000000, -5425.000000, 1466.666626, -1100.000000),
    27: (1802.083252, -3122.916504, -3877.083252, -7160.416504),
    28: (-322.916656, -2554.166504, -6100.000000, -7587.499512),
    29: (-266.666656, -3195.833252, -7031.249512, -8983.333008),
    30: (1535.416626, -1935.416626, -7939.583008, -10254.166016),
    32: (-833.333313, -3333.333252, -9866.666016, -11533.333008),
    34: (833.333313, -1866.666626, -9716.666016, -11516.666016),
    35: (-1993.749878, -4752.083008, -4487.500000, -6327.083008),
    36: (-1570.833252, -3741.666504, -8575.000000, -10022.916016),
    37: (2220.833252, -4160.416504, -11168.750000, -15422.916016),
    38: (-2222.916504, -4516.666504, -9620.833008, -11150.000000),
    39: (3016.666504, -483.333313, -9400.000000, -11733.333008),
    40: (-389.583313, -4525.000000, -2147.916504, -4904.166504),
    301: (1380.971436, 36.700630, -8278.850586, -9175.205078),
    341: (-713.591370, -1504.216431, -4569.241211, -5096.845703),
    382: (873.192627, -86.182404, 1877.945312, 1237.841187),
}

WORLD_SPAWN_AREA_IDS_BY_MAP = {
    0: (
        15, 16, 17, 19, 20, 21, 22, 23, 24, 26, 27, 28, 29, 30, 32, 34, 35,
        36, 37, 38, 39, 40, 301, 341, 382,
    ),
    1: (
        4, 9, 11, 41, 42, 43, 61, 81, 101, 121, 141, 161, 181, 182, 201,
        241, 261, 281, 321, 362, 381,
    ),
}


def is_chinese(text: str) -> bool:
    """Check if text contains Chinese characters."""
    if not text:
        return False
    return any('\u4e00' <= c <= '\u9fff' for c in text)


def read_file(path: Path) -> str:
    """Read file content, return empty string if not found."""
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        print(f"  Warning: File not found: {path}")
        return ""
    except Exception as e:
        print(f"  Error reading {path}: {e}")
        return ""


def parse_cmangos_creature(content: str) -> dict:
    """Parse CMaNGOS locales_creature.sql for unit ID → Chinese name mappings."""
    result = {}
    # Process line by line for efficiency
    for line in content.split('\n'):
        if not line.startswith('INSERT INTO'):
            continue
        # Pattern: VALUES (ID, 'NAME', 'SUBTITLE')
        match = re.search(r"VALUES\s*\((\d+),\s*'([^']*)',\s*'[^']*'\)", line)
        if match:
            entry_id = int(match.group(1))
            name = match.group(2).replace("''", "'")
            if name and is_chinese(name):
                result[entry_id] = name
    return result


def parse_cmangos_item(content: str) -> dict:
    """Parse CMaNGOS locales_item.sql for item ID → Chinese name mappings."""
    result = {}
    for line in content.split('\n'):
        if not line.startswith('INSERT INTO'):
            continue
        match = re.search(r"VALUES\s*\((\d+),\s*'([^']*)',\s*'[^']*'\)", line)
        if match:
            entry_id = int(match.group(1))
            name = match.group(2).replace("''", "'")
            if name and is_chinese(name):
                result[entry_id] = name
    return result


def parse_cmangos_gameobject(content: str) -> dict:
    """Parse CMaNGOS locales_gameobject.sql for object ID → Chinese name mappings."""
    result = {}
    for line in content.split('\n'):
        if not line.startswith('INSERT INTO'):
            continue
        match = re.search(r"VALUES\s*\((\d+),\s*'([^']*)'\)", line)
        if match:
            entry_id = int(match.group(1))
            name = match.group(2).replace("''", "'")
            if name and is_chinese(name):
                result[entry_id] = name
    return result


def parse_cmangos_quest(content: str) -> dict:
    """Parse CMaNGOS locales_quest.sql for quest ID → Chinese quest info."""
    result = {}
    for line in content.split('\n'):
        if not line.startswith('INSERT INTO'):
            continue
        # Extract first 3 quoted values: id, title, details, objectives
        match = re.search(r"VALUES\s*\((\d+),\s*'([^']*)',\s*'[^']*',\s*'([^']*)'", line)
        if match:
            quest_id = int(match.group(1))
            title = match.group(2).replace("''", "'")
            objectives = match.group(3).replace("''", "'")
            if title and is_chinese(title):
                result[quest_id] = {
                    "title": title,
                    "objectives": objectives
                }
    return result


def parse_create_table_columns(content: str, table_name: str) -> dict:
    """Parse CREATE TABLE column order and return {column_name: index}."""
    pattern = rf'CREATE TABLE `{re.escape(table_name)}`\s*\((.*?)\)\s*ENGINE='
    match = re.search(pattern, content, re.S)
    if not match:
        return {}

    columns = {}
    for line in match.group(1).splitlines():
        column_match = re.match(r'\s*`([^`]+)`', line)
        if column_match:
            columns[column_match.group(1)] = len(columns)
    return columns


def split_sql_tuple_fields(row_text: str) -> list:
    """Split a SQL VALUES tuple into raw field strings."""
    fields = []
    current = []
    in_string = False
    pos = 0

    while pos < len(row_text):
        char = row_text[pos]
        if char == "'":
            current.append(char)
            if in_string and pos + 1 < len(row_text) and row_text[pos + 1] == "'":
                current.append("'")
                pos += 2
                continue
            in_string = not in_string
        elif char == "," and not in_string:
            fields.append(''.join(current).strip())
            current = []
        else:
            current.append(char)
        pos += 1

    if current or row_text.endswith(","):
        fields.append(''.join(current).strip())

    return fields


def decode_sql_value(raw_value: str):
    """Decode a SQL literal from an INSERT tuple."""
    value = raw_value.strip()
    if value.upper() == "NULL":
        return None
    if len(value) >= 2 and value[0] == "'" and value[-1] == "'":
        return value[1:-1].replace("''", "'")
    if re.match(r'^-?\d+$', value):
        return int(value)
    if re.match(r'^-?\d+\.\d+$', value):
        return float(value)
    return value


def iter_sql_insert_rows(content: str, table_name: str):
    """Yield decoded rows from INSERT INTO `table_name` VALUES (...) statements."""
    pattern = re.compile(rf'INSERT INTO `{re.escape(table_name)}` VALUES\s*(.*?);', re.S)
    for match in pattern.finditer(content):
        values_blob = match.group(1)
        pos = 0
        while pos < len(values_blob):
            if values_blob[pos] != '(':
                pos += 1
                continue

            pos += 1
            row_start = pos
            in_string = False
            while pos < len(values_blob):
                char = values_blob[pos]
                if char == "'":
                    if in_string and pos + 1 < len(values_blob) and values_blob[pos + 1] == "'":
                        pos += 2
                        continue
                    in_string = not in_string
                elif char == ")" and not in_string:
                    break
                pos += 1

            row_text = values_blob[row_start:pos]
            yield [decode_sql_value(field) for field in split_sql_tuple_fields(row_text)]
            pos += 1


def get_sql_field(row: list, columns: dict, column_name: str, default=None):
    """Fetch a parsed SQL field by column name."""
    index = columns.get(column_name)
    if index is None or index >= len(row):
        return default
    return row[index]


def safe_int(value, default=None):
    """Convert parsed SQL/pfQuest values to int when possible."""
    if value is None or value == "":
        return default
    if isinstance(value, int):
        return value
    if isinstance(value, float):
        return int(value)
    try:
        return int(value)
    except (TypeError, ValueError):
        return default


def normalize_location_tuples(locations: list) -> list:
    """Deduplicate canonical Questie location tuples while preserving order."""
    normalized = []
    seen = set()

    for map_id, x, y in locations:
        key = (int(map_id), round(float(x), 4), round(float(y), 4))
        if key not in seen:
            seen.add(key)
            normalized.append(key)

    return normalized


def extract_location_tuples(entry: dict) -> list:
    """Return canonical Questie location tuples from a DB or pfQuest entity entry."""
    if not entry:
        return []
    if entry.get("locations"):
        return normalize_location_tuples(entry["locations"])
    if entry.get("coords"):
        return normalize_location_tuples(convert_coords(entry["coords"]))
    return []


def world_spawn_contains_point(map_area_id: int, world_x: float, world_y: float) -> bool:
    """Return True when a world spawn point falls inside a WorldMapArea bound."""
    bounds = WORLD_SPAWN_AREA_EXTENTS.get(map_area_id)
    if not bounds:
        return False

    loc_left, loc_right, loc_top, loc_bottom = bounds
    min_y = min(loc_left, loc_right)
    max_y = max(loc_left, loc_right)
    min_x = min(loc_top, loc_bottom)
    max_x = max(loc_top, loc_bottom)
    return min_x <= world_x <= max_x and min_y <= world_y <= max_y


def world_spawn_area_size(map_area_id: int) -> float:
    """Calculate WorldMapArea bound size so nested city bounds win over parent zones."""
    loc_left, loc_right, loc_top, loc_bottom = WORLD_SPAWN_AREA_EXTENTS[map_area_id]
    return abs(loc_right - loc_left) * abs(loc_bottom - loc_top)


def resolve_world_spawn_map_area(world_map_id: int, world_x: float, world_y: float):
    """Resolve a world spawn on map 0/1 to the most specific WorldMapArea ID."""
    best_area_id = None
    best_area_size = None

    for map_area_id in WORLD_SPAWN_AREA_IDS_BY_MAP.get(world_map_id, ()):
        if world_spawn_contains_point(map_area_id, world_x, world_y):
            area_size = world_spawn_area_size(map_area_id)
            if best_area_size is None or area_size < best_area_size:
                best_area_id = map_area_id
                best_area_size = area_size

    return best_area_id


def convert_spawn_row_to_location(map_id: int, world_x, world_y):
    """Convert a creature/gameobject spawn row into a canonical Questie location tuple."""
    if world_x is None or world_y is None:
        return None

    if map_id in (0, 1):
        map_area_id = resolve_world_spawn_map_area(map_id, float(world_x), float(world_y))
        if map_area_id is None:
            return None
        questie_map_id = WORLDMAPAREA_TO_MAPID.get(map_area_id)
        if questie_map_id is None:
            return None
        map_x, map_y = convert_world_to_map_coords(float(world_x), float(world_y), map_area_id)
        return (questie_map_id, map_x, map_y)

    questie_map_id = INTERNAL_MAP_TO_QUESTIE_MAPID.get(map_id)
    if questie_map_id is None:
        return None

    return (questie_map_id, 0.5, 0.5)


def normalize_requirement_mask(value) -> int:
    """Normalize DB masks so 0/-1/non-values are treated as unrestricted."""
    normalized = safe_int(value, 0)
    if normalized is None or normalized <= 0:
        return 0
    return normalized


def append_unique_sequence(target: list, values: list) -> None:
    """Append missing values while preserving order."""
    for value in values:
        if value not in target:
            target.append(value)


def build_sql_template_name_table(content: str, table_name: str, id_column: str, name_column: str) -> dict:
    """Build an enUS name table from a SQL template table."""
    columns = parse_create_table_columns(content, table_name)
    result = {}

    for row in iter_sql_insert_rows(content, table_name):
        entry_id = safe_int(get_sql_field(row, columns, id_column))
        name = get_sql_field(row, columns, name_column)
        if entry_id and isinstance(name, str) and name:
            result[entry_id] = name

    return result


def build_sql_quest_names(content: str) -> dict:
    """Build an enUS quest title/objectives table from quest_template."""
    columns = parse_create_table_columns(content, "quest_template")
    result = {}

    for row in iter_sql_insert_rows(content, "quest_template"):
        quest_id = safe_int(get_sql_field(row, columns, "entry"))
        title = get_sql_field(row, columns, "Title") or ""
        objectives = get_sql_field(row, columns, "Objectives") or ""
        if quest_id and title:
            result[quest_id] = {
                "title": title,
                "objectives": objectives,
            }

    return result


def build_sql_spawn_location_data(content: str, table_name: str) -> dict:
    """Build DB-first vanilla unit/object locations from creature/gameobject spawns."""
    columns = parse_create_table_columns(content, table_name)
    result = defaultdict(lambda: {"locations": []})

    for row in iter_sql_insert_rows(content, table_name):
        entity_id = safe_int(get_sql_field(row, columns, "id"))
        map_id = safe_int(get_sql_field(row, columns, "map"))
        world_x = get_sql_field(row, columns, "position_x")
        world_y = get_sql_field(row, columns, "position_y")

        if not entity_id or map_id is None:
            continue

        location = convert_spawn_row_to_location(map_id, world_x, world_y)
        if location is not None:
            result[entity_id]["locations"].append(location)

    normalized_result = {}
    for entity_id, entry in result.items():
        locations = normalize_location_tuples(entry["locations"])
        if locations:
            normalized_result[entity_id] = {"locations": locations}

    return normalized_result


def build_sql_item_data(content: str) -> dict:
    """Build vanilla item sources from the extracted database."""
    creature_template_columns = parse_create_table_columns(content, "creature_template")
    gameobject_template_columns = parse_create_table_columns(content, "gameobject_template")
    creature_loot_columns = parse_create_table_columns(content, "creature_loot_template")
    gameobject_loot_columns = parse_create_table_columns(content, "gameobject_loot_template")
    vendor_columns = parse_create_table_columns(content, "npc_vendor")

    loot_template_to_units = defaultdict(list)
    for row in iter_sql_insert_rows(content, "creature_template"):
        unit_id = safe_int(get_sql_field(row, creature_template_columns, "Entry"))
        loot_id = safe_int(get_sql_field(row, creature_template_columns, "LootId"), 0)
        if unit_id and loot_id and loot_id > 0:
            loot_template_to_units[loot_id].append(unit_id)

    loot_template_to_objects = defaultdict(list)
    for row in iter_sql_insert_rows(content, "gameobject_template"):
        object_id = safe_int(get_sql_field(row, gameobject_template_columns, "entry"))
        object_type = safe_int(get_sql_field(row, gameobject_template_columns, "type"), 0)
        loot_id = safe_int(get_sql_field(row, gameobject_template_columns, "data1"), 0)
        if object_id and object_type in (3, 25) and loot_id and loot_id > 0:
            loot_template_to_objects[loot_id].append(object_id)

    item_sources = defaultdict(lambda: {"U": {}, "O": {}, "V": {}})

    for row in iter_sql_insert_rows(content, "creature_loot_template"):
        loot_id = safe_int(get_sql_field(row, creature_loot_columns, "entry"), 0)
        item_id = safe_int(get_sql_field(row, creature_loot_columns, "item"), 0)
        if not loot_id or not item_id:
            continue
        for unit_id in loot_template_to_units.get(loot_id, ()):
            item_sources[item_id]["U"][unit_id] = 1

    for row in iter_sql_insert_rows(content, "gameobject_loot_template"):
        loot_id = safe_int(get_sql_field(row, gameobject_loot_columns, "entry"), 0)
        item_id = safe_int(get_sql_field(row, gameobject_loot_columns, "item"), 0)
        if not loot_id or not item_id:
            continue
        for object_id in loot_template_to_objects.get(loot_id, ()):
            item_sources[item_id]["O"][object_id] = 1

    for row in iter_sql_insert_rows(content, "npc_vendor"):
        vendor_id = safe_int(get_sql_field(row, vendor_columns, "entry"), 0)
        item_id = safe_int(get_sql_field(row, vendor_columns, "item"), 0)
        if vendor_id and item_id:
            item_sources[item_id]["V"][vendor_id] = 1

    result = {}
    for item_id, sources in item_sources.items():
        entry = {}
        if sources["U"]:
            entry["U"] = dict(sorted(sources["U"].items()))
        if sources["O"]:
            entry["O"] = dict(sorted(sources["O"].items()))
        if sources["V"]:
            entry["V"] = dict(sorted(sources["V"].items()))
        if entry:
            result[item_id] = entry

    return result


def build_sql_quest_data(content: str) -> dict:
    """Build vanilla quest metadata from the extracted database."""
    quest_columns = parse_create_table_columns(content, "quest_template")
    creature_questrelation_columns = parse_create_table_columns(content, "creature_questrelation")
    creature_involvedrelation_columns = parse_create_table_columns(content, "creature_involvedrelation")
    gameobject_questrelation_columns = parse_create_table_columns(content, "gameobject_questrelation")
    gameobject_involvedrelation_columns = parse_create_table_columns(content, "gameobject_involvedrelation")

    creature_starters = defaultdict(list)
    for row in iter_sql_insert_rows(content, "creature_questrelation"):
        unit_id = safe_int(get_sql_field(row, creature_questrelation_columns, "id"))
        quest_id = safe_int(get_sql_field(row, creature_questrelation_columns, "quest"))
        if unit_id and quest_id:
            creature_starters[quest_id].append(unit_id)

    creature_finishers = defaultdict(list)
    for row in iter_sql_insert_rows(content, "creature_involvedrelation"):
        unit_id = safe_int(get_sql_field(row, creature_involvedrelation_columns, "id"))
        quest_id = safe_int(get_sql_field(row, creature_involvedrelation_columns, "quest"))
        if unit_id and quest_id:
            creature_finishers[quest_id].append(unit_id)

    object_starters = defaultdict(list)
    for row in iter_sql_insert_rows(content, "gameobject_questrelation"):
        object_id = safe_int(get_sql_field(row, gameobject_questrelation_columns, "id"))
        quest_id = safe_int(get_sql_field(row, gameobject_questrelation_columns, "quest"))
        if object_id and quest_id:
            object_starters[quest_id].append(object_id)

    object_finishers = defaultdict(list)
    for row in iter_sql_insert_rows(content, "gameobject_involvedrelation"):
        object_id = safe_int(get_sql_field(row, gameobject_involvedrelation_columns, "id"))
        quest_id = safe_int(get_sql_field(row, gameobject_involvedrelation_columns, "quest"))
        if object_id and quest_id:
            object_finishers[quest_id].append(object_id)

    quests = {}
    for row in iter_sql_insert_rows(content, "quest_template"):
        quest_id = safe_int(get_sql_field(row, quest_columns, "entry"))
        if not quest_id:
            continue

        quest = {}
        quest_level = safe_int(get_sql_field(row, quest_columns, "QuestLevel"))
        min_level = safe_int(get_sql_field(row, quest_columns, "MinLevel"))
        race_mask = normalize_requirement_mask(get_sql_field(row, quest_columns, "RequiredRaces"))
        class_mask = normalize_requirement_mask(get_sql_field(row, quest_columns, "RequiredClasses"))
        required_skill = safe_int(get_sql_field(row, quest_columns, "RequiredSkill"), 0)
        prev_quest_id = safe_int(get_sql_field(row, quest_columns, "PrevQuestId"), 0)
        src_item_id = safe_int(get_sql_field(row, quest_columns, "SrcItemId"), 0)

        if quest_level is not None:
            quest["lvl"] = quest_level
        if min_level is not None:
            quest["min"] = min_level
        if race_mask:
            quest["race"] = race_mask
        if class_mask:
            quest["class"] = class_mask
        if required_skill and required_skill > 0:
            quest["skill"] = required_skill
        if prev_quest_id and prev_quest_id > 0:
            quest["pre"] = [prev_quest_id]

        if src_item_id and src_item_id > 0:
            quest["start"] = {"I": src_item_id}
        elif creature_starters.get(quest_id):
            quest["start"] = {"U": min(creature_starters[quest_id])}
        elif object_starters.get(quest_id):
            quest["start"] = {"O": min(object_starters[quest_id])}

        if creature_finishers.get(quest_id):
            quest["end"] = {"U": min(creature_finishers[quest_id])}
        elif object_finishers.get(quest_id):
            quest["end"] = {"O": min(object_finishers[quest_id])}

        objective_units = []
        objective_items = []
        objective_objects = []
        for objective_index in range(1, 5):
            req_item_id = safe_int(get_sql_field(row, quest_columns, f"ReqItemId{objective_index}"), 0)
            req_entity_id = safe_int(get_sql_field(row, quest_columns, f"ReqCreatureOrGOId{objective_index}"), 0)

            if req_item_id and req_item_id > 0:
                append_unique_sequence(objective_items, [req_item_id])
            if req_entity_id and req_entity_id > 0:
                append_unique_sequence(objective_units, [req_entity_id])
            elif req_entity_id and req_entity_id < 0:
                append_unique_sequence(objective_objects, [abs(req_entity_id)])

        if objective_units or objective_items or objective_objects:
            quest["obj"] = {}
            if objective_units:
                quest["obj"]["U"] = objective_units
            if objective_items:
                quest["obj"]["I"] = objective_items
            if objective_objects:
                quest["obj"]["O"] = objective_objects

        if quest:
            quests[quest_id] = quest

    return quests


def merge_name_tables(primary: dict, fallback: dict) -> dict:
    """Merge fallback names into a primary name table without overwriting primary entries."""
    merged = dict(primary)
    for entry_id, value in fallback.items():
        if entry_id not in merged or not merged[entry_id]:
            merged[entry_id] = value
    return merged


def merge_quest_name_tables(primary: dict, fallback: dict) -> dict:
    """Merge quest title/objectives dictionaries with primary data taking precedence."""
    merged = copy.deepcopy(primary)
    for quest_id, info in fallback.items():
        if quest_id not in merged:
            merged[quest_id] = copy.deepcopy(info)
            continue
        if not merged[quest_id].get("title") and info.get("title"):
            merged[quest_id]["title"] = info["title"]
        if not merged[quest_id].get("objectives") and info.get("objectives"):
            merged[quest_id]["objectives"] = info["objectives"]
    return merged


def merge_vanilla_item_data(primary: dict, fallback: dict) -> dict:
    """Merge pfQuest item sources into database-first item data."""
    merged = copy.deepcopy(primary)
    for item_id, item_data in fallback.items():
        if item_id not in merged:
            merged[item_id] = copy.deepcopy(item_data)
            continue
        for source_key in ("U", "O", "V"):
            if source_key not in item_data:
                continue
            if source_key not in merged[item_id] or not merged[item_id][source_key]:
                merged[item_id][source_key] = copy.deepcopy(item_data[source_key])
    return merged


def merge_vanilla_quest_data(primary: dict, fallback: dict) -> dict:
    """Fill quest fields from pfQuest only when the database did not generate them."""
    merged = copy.deepcopy(primary)
    for quest_id, quest_data in fallback.items():
        if quest_id not in merged:
            merged[quest_id] = copy.deepcopy(quest_data)
            continue

        target = merged[quest_id]
        for scalar_key in ("lvl", "min", "race", "class", "skill"):
            if scalar_key not in target and scalar_key in quest_data:
                target[scalar_key] = quest_data[scalar_key]

        if "start" not in target and "start" in quest_data:
            target["start"] = copy.deepcopy(quest_data["start"])
        if "end" not in target and "end" in quest_data:
            target["end"] = copy.deepcopy(quest_data["end"])
        if "pre" not in target and "pre" in quest_data:
            target["pre"] = copy.deepcopy(quest_data["pre"])

        if "obj" not in target and "obj" in quest_data:
            target["obj"] = copy.deepcopy(quest_data["obj"])
        elif "obj" in target and "obj" in quest_data:
            for objective_key, values in quest_data["obj"].items():
                if objective_key not in target["obj"]:
                    target["obj"][objective_key] = copy.deepcopy(values)

    return merged


def merge_vanilla_location_data(primary: dict, fallback: dict) -> dict:
    """Fill missing vanilla entity location tables from pfQuest without overriding DB output."""
    merged = copy.deepcopy(primary)

    for entity_id, entry in fallback.items():
        if entity_id in merged and extract_location_tuples(merged[entity_id]):
            continue

        locations = extract_location_tuples(entry)
        if locations:
            merged[entity_id] = {"locations": locations}

    return merged


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


def parse_quest_poi(content: str) -> dict:
    """Parse CMaNGOS quest_poi table.
    
    Format: (questId, poiId, objIndex, mapId, mapAreaId, floorId, unk3, unk4)
    - objIndex = -1 means turn-in location
    - objIndex >= 0 means objective index
    - objIndex = 4 typically means item objective
    
    Returns: {questId: {objIndex: [mapAreaId, ...]}}
    """
    result = {}
    
    # Find the INSERT statement for quest_poi
    start_marker = "INSERT INTO `quest_poi` VALUES"
    start_idx = content.find(start_marker)
    if start_idx == -1:
        return result
    
    # Find the end of the INSERT statement (next semicolon)
    end_idx = content.find(';', start_idx)
    if end_idx == -1:
        end_idx = len(content)
    
    insert_content = content[start_idx:end_idx]
    
    # Parse each tuple: (questId, poiId, objIndex, mapId, mapAreaId, floorId, unk3, unk4)
    pattern = r'\((\d+),(\d+),(-?\d+),(\d+),(\d+),(\d+),(\d+),(\d+)\)'
    for match in re.finditer(pattern, insert_content):
        quest_id = int(match.group(1))
        poi_id = int(match.group(2))
        obj_index = int(match.group(3))
        map_id = int(match.group(4))
        map_area_id = int(match.group(5))
        
        if quest_id not in result:
            result[quest_id] = {}
        if obj_index not in result[quest_id]:
            result[quest_id][obj_index] = []
        
        result[quest_id][obj_index].append({
            'poiId': poi_id,
            'mapId': map_id,
            'mapAreaId': map_area_id,
        })
    
    return result


def parse_quest_poi_points(content: str) -> dict:
    """Parse CMaNGOS quest_poi_points table.
    
    Format: (questId, poiId, x, y)
    Multiple points with same questId+poiId form a polygon.
    
    Returns: {questId: {poiId: [(x, y), ...]}}
    """
    result = {}
    
    # Find all INSERT statements for quest_poi_points
    start_marker = "INSERT INTO `quest_poi_points` VALUES"
    pos = 0
    
    while True:
        start_idx = content.find(start_marker, pos)
        if start_idx == -1:
            break
        
        # Find the end of the INSERT statement
        end_idx = content.find(';', start_idx)
        if end_idx == -1:
            end_idx = len(content)
        
        insert_content = content[start_idx:end_idx]
        
        # Parse each tuple: (questId, poiId, x, y)
        pattern = r'\((\d+),(\d+),(-?\d+),(-?\d+)\)'
        for match in re.finditer(pattern, insert_content):
            quest_id = int(match.group(1))
            poi_id = int(match.group(2))
            x = int(match.group(3))
            y = int(match.group(4))
            
            if quest_id not in result:
                result[quest_id] = {}
            if poi_id not in result[quest_id]:
                result[quest_id][poi_id] = []
            
            result[quest_id][poi_id].append((x, y))
        
        pos = end_idx
    
    return result


def build_quest_objective_coords(quest_poi: dict, quest_poi_points: dict) -> dict:
    """Build quest objective coordinates from quest_poi and quest_poi_points.
    
    Calculates the centroid of each POI polygon and converts to map coordinates.
    
    Returns: {questId: {objIndex: [(mapAreaId, x, y), ...]}}
    """
    result = {}
    
    for quest_id, objectives in quest_poi.items():
        quest_coords = {}
        
        for obj_index, pois in objectives.items():
            obj_coords = []
            
            for poi_info in pois:
                poi_id = poi_info['poiId']
                map_area_id = poi_info['mapAreaId']
                
                # Get the points for this POI
                if quest_id in quest_poi_points and poi_id in quest_poi_points[quest_id]:
                    points = quest_poi_points[quest_id][poi_id]
                    
                    if points:
                        # Calculate centroid of the polygon
                        sum_x = sum(p[0] for p in points)
                        sum_y = sum(p[1] for p in points)
                        center_x = sum_x / len(points)
                        center_y = sum_y / len(points)
                        
                        obj_coords.append((map_area_id, center_x, center_y))
            
            if obj_coords:
                quest_coords[obj_index] = obj_coords
        
        if quest_coords:
            result[quest_id] = quest_coords
    
    return result


def convert_world_to_map_coords(world_x: float, world_y: float, map_area_id: int) -> tuple:
    """Convert world coordinates to map percentage coordinates (0-1).
    
    Uses WorldMapArea.dbc bounds extracted from game files.
    
    IMPORTANT: In WoW, axes are swapped for map display:
    - mapX (horizontal on map) = calculated from worldY
    - mapY (vertical on map) = calculated from worldX
    
    Formula from wowdev.wiki:
    - mapX = (worldY - locLeft) / (locRight - locLeft)
    - mapY = (worldX - locTop) / (locBottom - locTop)
    """
    # WorldMapArea.dbc bounds extracted from WoW 1.12.1
    # Format: mapAreaId: (locLeft, locRight, locTop, locBottom)
    # locLeft/locRight = Y-axis boundaries
    # locTop/locBottom = X-axis boundaries
    WORLDMAPAREA_BOUNDS = {
        # Kalimdor
        4: (-1962.499878, -7249.999512, 1808.333252, -1716.666626),    # Durotar
        9: (2047.916626, -3089.583252, -272.916656, -3697.916504),     # Mulgore
        11: (2622.916504, -7510.416504, 1612.499878, -5143.750000),    # Barrens
        41: (3814.583252, -1277.083252, 11831.250000, 8437.500000),    # Teldrassil
        42: (2941.666504, -3608.333252, 8333.333008, 3966.666504),     # Darkshore
        43: (1699.999878, -4066.666504, 4672.916504, 829.166626),      # Ashenvale
        61: (-433.333313, -4833.333008, -3966.666504, -6899.999512),   # ThousandNeedles
        81: (3245.833252, -1637.499878, 2916.666504, -339.583313),     # StonetalonMountains
        101: (4233.333008, -262.500000, 452.083313, -2545.833252),     # Desolace
        121: (5441.666504, -1508.333252, -2366.666504, -6999.999512),  # Feralas
        141: (-974.999939, -6225.000000, -2033.333252, -5533.333008),  # Dustwallow
        161: (-218.749985, -7118.749512, -5875.000000, -10475.000000), # Tanaris
        181: (-3277.083252, -8347.916016, 5341.666504, 1960.416626),   # Aszhara
        182: (1641.666626, -4108.333008, 7133.333008, 3299.999756),    # Felwood
        201: (533.333313, -3166.666504, -5966.666504, -8433.333008),   # UngoroCrater
        241: (-1381.250000, -3689.583252, 8491.666016, 6952.083008),   # Moonglade
        261: (4641.666504, -2308.333252, -5800.000000, -10433.333008), # Silithus
        281: (-316.666656, -7416.666504, 8533.333008, 3799.999756),    # Winterspring
        321: (-3680.601074, -5083.205566, 2273.877197, 1338.460571),   # Ogrimmar
        362: (516.666626, -527.083313, -849.999939, -1545.833252),     # ThunderBluff
        381: (2938.362793, 1880.029541, 10238.316406, 9532.586914),    # Darnassis
        
        # Eastern Kingdoms
        15: (783.333313, -2016.666626, 1500.000000, -366.666656),      # Alterac
        16: (-866.666626, -4466.666504, -133.333328, -2533.333252),    # Arathi
        17: (-2079.166504, -4566.666504, -5889.583008, -7547.916504),  # Badlands
        19: (-1241.666626, -4591.666504, -10566.666016, -12800.000000),# BlastedLands
        20: (3033.333252, -1485.416626, 3837.499756, 824.999939),      # Tirisfal
        21: (3449.999756, -750.000000, 1666.666626, -1133.333252),     # Silverpine
        22: (416.666656, -3883.333252, 3366.666504, 499.999969),       # WesternPlaguelands
        23: (-2185.416504, -6056.250000, 3799.999756, 1218.750000),    # EasternPlaguelands
        24: (1066.666626, -2133.333252, 400.000000, -1733.333252),     # Hilsbrad
        26: (-1575.000000, -5425.000000, 1466.666626, -1100.000000),   # Hinterlands
        27: (1802.083252, -3122.916504, -3877.083252, -7160.416504),   # DunMorogh
        28: (-322.916656, -2554.166504, -6100.000000, -7587.499512),   # SearingGorge
        29: (-266.666656, -3195.833252, -7031.249512, -8983.333008),   # BurningSteppes
        30: (1535.416626, -1935.416626, -7939.583008, -10254.166016),  # Elwynn
        32: (-833.333313, -3333.333252, -9866.666016, -11533.333008),  # DeadwindPass
        34: (833.333313, -1866.666626, -9716.666016, -11516.666016),   # Duskwood
        35: (-1993.749878, -4752.083008, -4487.500000, -6327.083008),  # LochModan
        36: (-1570.833252, -3741.666504, -8575.000000, -10022.916016), # Redridge
        37: (2220.833252, -4160.416504, -11168.750000, -15422.916016), # Stranglethorn
        38: (-2222.916504, -4516.666504, -9620.833008, -11150.000000), # SwampOfSorrows
        39: (3016.666504, -483.333313, -9400.000000, -11733.333008),   # Westfall
        40: (-389.583313, -4525.000000, -2147.916504, -4904.166504),   # Wetlands
        301: (1380.971436, 36.700630, -8278.850586, -9175.205078),     # Stormwind
        341: (-713.591370, -1504.216431, -4569.241211, -5096.845703),  # Ironforge
        382: (873.192627, -86.182404, 1877.945312, 1237.841187),       # Undercity
    }
    
    if map_area_id in WORLDMAPAREA_BOUNDS:
        loc_left, loc_right, loc_top, loc_bottom = WORLDMAPAREA_BOUNDS[map_area_id]
        
        # WoW coordinate conversion (axes are swapped!)
        # mapX (horizontal) = from worldY, mapY (vertical) = from worldX
        map_x = (world_y - loc_left) / (loc_right - loc_left) if (loc_right - loc_left) != 0 else 0.5
        map_y = (world_x - loc_top) / (loc_bottom - loc_top) if (loc_bottom - loc_top) != 0 else 0.5
        
        # Clamp to valid range
        map_x = max(0.0, min(1.0, map_x))
        map_y = max(0.0, min(1.0, map_y))
        return (map_x, map_y)
    else:
        # Zone not mapped - return center as fallback
        return (0.5, 0.5)


def parse_pfquest_data_table(content: str, table_name: str) -> dict:
    """Parse pfQuest data table (units, objects) with coordinates."""
    result = {}
    
    table_pattern = f'pfDB["{table_name}"]["data"]'
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
        
        entity_id = int(id_match.group(1))
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
        
        entry = {}
        
        # Parse coords
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
        
        # Parse faction
        fac_match = re.search(r'\["fac"\]\s*=\s*"([^"]*)"', entry_content)
        if fac_match:
            entry["fac"] = fac_match.group(1)
        
        # Parse level
        lvl_match = re.search(r'\["lvl"\]\s*=\s*"([^"]*)"', entry_content)
        if lvl_match:
            entry["lvl"] = lvl_match.group(1)
        
        if entry.get("coords"):
            result[entity_id] = entry
        
        pos = entry_pos
        while pos < len(content) and content[pos] in ' \t\n\r,':
            pos += 1
    
    return result


def parse_pfquest_items_data(content: str) -> dict:
    """Parse pfQuest items data table."""
    result = {}
    
    table_pattern = 'pfDB["items"]["data"]'
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
    
    # Parse each item entry
    item_pattern = re.compile(r'\[(\d+)\]\s*=\s*\{')
    for match in item_pattern.finditer(table_content):
        item_id = int(match.group(1))
        entry_start = match.end()
        
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
        
        if not entry_content.strip():
            continue
        
        entry = {}
        
        # Parse ["U"] = { [unit_id] = rate }
        u_match = re.search(r'\["U"\]\s*=\s*\{([^}]*)\}', entry_content)
        if u_match:
            units = {}
            for unit_match in re.finditer(r'\[(\d+)\]\s*=\s*([\d.]+)', u_match.group(1)):
                unit_id = int(unit_match.group(1))
                rate = float(unit_match.group(2))
                units[unit_id] = rate
            if units:
                entry["U"] = units
        
        # Parse ["O"] = { [obj_id] = rate }
        o_match = re.search(r'\["O"\]\s*=\s*\{([^}]*)\}', entry_content)
        if o_match:
            objects = {}
            for obj_match in re.finditer(r'\[(\d+)\]\s*=\s*([\d.]+)', o_match.group(1)):
                obj_id = int(obj_match.group(1))
                rate = float(obj_match.group(2))
                objects[obj_id] = rate
            if objects:
                entry["O"] = objects
        
        # Parse ["V"] = { [vendor_id] = price }
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


def parse_pfquest_quests_data(content: str) -> dict:
    """Parse pfQuest quests data table."""
    result = {}
    
    table_pattern = 'pfDB["quests"]["data"]'
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
        
        id_match = re.match(r'\[(\d+)\]\s*=\s*(\{|"_")', content[pos:])
        if not id_match:
            pos += 1
            continue
        
        quest_id = int(id_match.group(1))
        
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
        
        # Parse race
        race_match = re.search(r'\["race"\]\s*=\s*(\d+)', entry_content)
        if race_match:
            quest["race"] = int(race_match.group(1))
        
        # Parse class
        class_match = re.search(r'\["class"\]\s*=\s*(\d+)', entry_content)
        if class_match:
            quest["class"] = int(class_match.group(1))
        
        skill_match = re.search(r'\["skill"\]\s*=\s*(\d+)', entry_content)
        if skill_match:
            quest["skill"] = int(skill_match.group(1))

        # Parse start
        start_content = extract_named_table(entry_content, "start")
        if start_content:
            quest["start"] = {}
            u_match = re.search(r'\["U"\]\s*=\s*\{\s*(\d+)', start_content)
            if u_match:
                quest["start"]["U"] = int(u_match.group(1))
            i_match = re.search(r'\["I"\]\s*=\s*\{\s*(\d+)', start_content)
            if i_match:
                quest["start"]["I"] = int(i_match.group(1))
            o_match = re.search(r'\["O"\]\s*=\s*\{\s*(\d+)', start_content)
            if o_match:
                quest["start"]["O"] = int(o_match.group(1))
        
        # Parse end
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
            # Units to kill
            u_match = re.search(r'\["U"\]\s*=\s*\{([^}]*)\}', obj_content)
            if u_match:
                units = [int(x) for x in re.findall(r'(\d+)', u_match.group(1))]
                if units:
                    quest["obj"]["U"] = units
            # Items to collect
            i_match = re.search(r'\["I"\]\s*=\s*\{([^}]*)\}', obj_content)
            if i_match:
                items = [int(x) for x in re.findall(r'(\d+)', i_match.group(1))]
                if items:
                    quest["obj"]["I"] = items
            # Objects to interact
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


def parse_pfquest_names(content: str, table_pattern: str) -> dict:
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


def parse_pfquest_quest_locale(content: str, locale: str) -> dict:
    """Parse pfQuest quest locale table."""
    result = {}
    
    table_pattern = f'pfDB["quests"]["{locale}"]'
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
        
        t_match = re.search(r'\["T"\]\s*=\s*"([^"]*)"', entry_content)
        if t_match:
            quest["title"] = t_match.group(1)
        
        o_match = re.search(r'\["O"\]\s*=\s*"([^"]*)"', entry_content)
        if o_match:
            quest["objectives"] = o_match.group(1)
        
        if quest.get("title"):
            result[quest_id] = quest
        
        pos = entry_pos
        while pos < len(content) and content[pos] in ' \t\n\r,':
            pos += 1
    
    return result


def convert_coords(coords: list) -> list:
    """Convert pfQuest coordinates to Questie format."""
    result = []
    for x, y, zone in coords:
        if zone in AREATABLE_TO_MAPID:
            map_id = AREATABLE_TO_MAPID[zone]
            qx = x / 100.0
            qy = y / 100.0
            result.append((map_id, qx, qy))
        else:
            unmapped_zones.add(zone)
    return result


def escape_lua_string(s: str) -> str:
    """Escape a string for Lua."""
    if not s:
        return ""
    return s.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '')


def generate_units_data(units_data: dict) -> str:
    """Generate Database/data/units.lua content."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    lines = [
        '-- Questie Unit Data (ID-based)',
        f'-- Auto-generated by convert_pfquest.py on {timestamp}',
        '-- Source: ClassicDB / CMaNGOS vanilla database + pfQuest coordinate fallback',
        '',
        'QuestieUnitData = {',
    ]
    
    for unit_id in sorted(units_data.keys()):
        data = units_data[unit_id]
        locations = extract_location_tuples(data)
        if not locations:
            continue
        
        lines.append(f'  [{unit_id}] = {{')
        lines.append('    locations = {')
        for i, (map_id, x, y) in enumerate(locations[:50], 1):
            lines.append(f'      [{i}] = {{{map_id}, {x:.4f}, {y:.4f}}},')
        lines.append('    },')
        lines.append('  },')
    
    lines.append('}')
    return '\n'.join(lines)


def generate_objects_data(objects_data: dict) -> str:
    """Generate Database/data/objects.lua content."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    lines = [
        '-- Questie Object Data (ID-based)',
        f'-- Auto-generated by convert_pfquest.py on {timestamp}',
        '-- Source: ClassicDB / CMaNGOS vanilla database + pfQuest coordinate fallback',
        '',
        'QuestieObjectData = {',
    ]
    
    for obj_id in sorted(objects_data.keys()):
        data = objects_data[obj_id]
        locations = extract_location_tuples(data)
        if not locations:
            continue
        
        lines.append(f'  [{obj_id}] = {{')
        lines.append('    locations = {')
        for i, (map_id, x, y) in enumerate(locations[:50], 1):
            lines.append(f'      [{i}] = {{{map_id}, {x:.4f}, {y:.4f}}},')
        lines.append('    },')
        lines.append('  },')
    
    lines.append('}')
    return '\n'.join(lines)


def generate_items_data(items_data: dict) -> str:
    """Generate Database/data/items.lua content."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    lines = [
        '-- Questie Item Data (ID-based)',
        f'-- Auto-generated by convert_pfquest.py on {timestamp}',
        '-- Source: ClassicDB / CMaNGOS vanilla database + pfQuest source fallback',
        '',
        'QuestieItemData = {',
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


def generate_quests_data(quests_data: dict, quest_objective_coords: dict = None) -> str:
    """Generate Database/data/quests.lua content."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    if quest_objective_coords is None:
        quest_objective_coords = {}
    
    lines = [
        '-- Questie Quest Data (ID-based)',
        f'-- Auto-generated by convert_pfquest.py on {timestamp}',
        '-- Source: ClassicDB / CMaNGOS vanilla database + quest_poi + pfQuest fallback',
        '',
        'QuestieQuestData = {',
    ]
    
    # Collect all quest IDs (from both pfQuest and quest_poi)
    all_quest_ids = set(quests_data.keys()) | set(quest_objective_coords.keys())
    
    for quest_id in sorted(all_quest_ids):
        data = quests_data.get(quest_id, {})
        obj_coords = quest_objective_coords.get(quest_id, {})
        
        # Skip if no data at all
        if not data and not obj_coords:
            continue
        
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
        
        # Start
        if "start" in data:
            if "U" in data["start"]:
                lines.append(f'    startUnit = {data["start"]["U"]},')
            if "I" in data["start"]:
                lines.append(f'    startItem = {data["start"]["I"]},')
            if "O" in data["start"]:
                lines.append(f'    startObject = {data["start"]["O"]},')
        
        # End
        if "end" in data:
            if "U" in data["end"]:
                lines.append(f'    endUnit = {data["end"]["U"]},')
            if "O" in data["end"]:
                lines.append(f'    endObject = {data["end"]["O"]},')
        
        # Objectives
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
        
        # Prerequisites
        if "pre" in data:
            pre_str = ', '.join(str(p) for p in data["pre"])
            lines.append(f'    preQuests = {{{pre_str}}},')
        
        # Objective coordinates from quest_poi
        if obj_coords:
            lines.append('    objectiveCoords = {')
            for obj_index in sorted(obj_coords.keys()):
                coords_list = obj_coords[obj_index]
                coords_entries = []
                for map_area_id, world_x, world_y in coords_list:
                    # Convert mapAreaId to Questie mapId
                    map_id = WORLDMAPAREA_TO_MAPID.get(map_area_id, 0)
                    if map_id == 0:
                        # Try AREATABLE_TO_MAPID as fallback
                        map_id = AREATABLE_TO_MAPID.get(map_area_id, 0)
                    
                    if map_id > 0:
                        # Convert world coordinates to map percentages
                        map_x, map_y = convert_world_to_map_coords(world_x, world_y, map_area_id)
                        coords_entries.append(f'{{{map_id}, {map_x:.4f}, {map_y:.4f}}}')
                
                if coords_entries:
                    coords_str = ', '.join(coords_entries)
                    lines.append(f'      [{obj_index}] = {{{coords_str}}},')
            lines.append('    },')
        
        lines.append('  },')
    
    lines.append('}')
    return '\n'.join(lines)


def generate_names_lua(unit_names: dict, object_names: dict, item_names: dict, 
                       quest_names: dict, locale: str) -> str:
    """Generate locale names.lua content."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    if locale == "enUS":
        header = [
            '-- Questie Name Mappings (English)',
            f'-- Auto-generated by convert_pfquest.py on {timestamp}',
            '-- Source: ClassicDB / CMaNGOS vanilla database + pfQuest fallback',
        ]
    else:
        header = [
            '-- Questie Name Mappings (Simplified Chinese)',
            '-- Questie 名称映射表（简体中文）',
            f'-- Auto-generated by convert_pfquest.py on {timestamp}',
            '-- Source: CMaNGOS ClassicDB locales + pfQuest fallback',
        ]
    
    lines = header + ['']
    
    # Unit names
    lines.append('QuestieUnitNames = {')
    for unit_id in sorted(unit_names.keys()):
        name = escape_lua_string(unit_names[unit_id])
        lines.append(f'  [{unit_id}] = "{name}",')
    lines.append('}')
    lines.append('')
    
    # Object names
    lines.append('QuestieObjectNames = {')
    for obj_id in sorted(object_names.keys()):
        name = escape_lua_string(object_names[obj_id])
        lines.append(f'  [{obj_id}] = "{name}",')
    lines.append('}')
    lines.append('')
    
    # Item names
    lines.append('QuestieItemNames = {')
    for item_id in sorted(item_names.keys()):
        name = escape_lua_string(item_names[item_id])
        lines.append(f'  [{item_id}] = "{name}",')
    lines.append('}')
    lines.append('')
    
    # Quest names
    lines.append('QuestieQuestNames = {')
    for quest_id in sorted(quest_names.keys()):
        info = quest_names[quest_id]
        title = escape_lua_string(info.get("title", ""))
        objectives = escape_lua_string(info.get("objectives", ""))
        lines.append(f'  [{quest_id}] = {{')
        lines.append(f'    title = "{title}",')
        lines.append(f'    objectives = "{objectives}",')
        lines.append('  },')
    lines.append('}')
    
    return '\n'.join(lines)


def ensure_dir(path: Path):
    """Create directory if it doesn't exist."""
    path.mkdir(parents=True, exist_ok=True)


def flush_print(*args, **kwargs):
    """Print with immediate flush."""
    print(*args, **kwargs)
    sys.stdout.flush()


def has_vanilla_entity_locations(entity_data: dict, entity_id: int) -> bool:
    """Return True when an entity has at least one mapped canonical location."""
    entry = entity_data.get(entity_id)
    if not entry:
        return False
    return bool(extract_location_tuples(entry))


def item_has_vanilla_locations(item_id: int, items_data: dict, units_data: dict, objects_data: dict) -> bool:
    """Return True when an item starter/source can be resolved to mapped locations."""
    item_data = items_data.get(item_id)
    if not item_data:
        return False

    for unit_id in item_data.get("U", {}).keys():
        if has_vanilla_entity_locations(units_data, unit_id):
            return True

    for object_id in item_data.get("O", {}).keys():
        if has_vanilla_entity_locations(objects_data, object_id):
            return True

    for vendor_id in item_data.get("V", {}).keys():
        if has_vanilla_entity_locations(units_data, vendor_id):
            return True

    return False


def validate_structured_quest_db(quests_data: dict, units_data: dict, objects_data: dict,
                                 items_data: dict, quest_objective_coords: dict) -> list[str]:
    """Report structured quest references that cannot resolve through ID-based data."""
    issues = []

    def add_issue(quest_id: int, message: str) -> None:
        issues.append(f"quest {quest_id}: {message}")

    for quest_id in sorted(quests_data.keys()):
        quest = quests_data[quest_id]
        start = quest.get("start", {})
        end = quest.get("end", {})

        if "U" in start and not has_vanilla_entity_locations(units_data, start["U"]):
            add_issue(quest_id, f"startUnit {start['U']} has no mapped locations")
        if "O" in start and not has_vanilla_entity_locations(objects_data, start["O"]):
            add_issue(quest_id, f"startObject {start['O']} has no mapped locations")
        if "I" in start and not item_has_vanilla_locations(start["I"], items_data, units_data, objects_data):
            add_issue(quest_id, f"startItem {start['I']} has no mapped sources")

        if "U" in end and not has_vanilla_entity_locations(units_data, end["U"]):
            add_issue(quest_id, f"endUnit {end['U']} has no mapped locations")
        if "O" in end and not has_vanilla_entity_locations(objects_data, end["O"]):
            add_issue(quest_id, f"endObject {end['O']} has no mapped locations")

    for quest_id in sorted(quest_objective_coords.keys()):
        for obj_index, coords in quest_objective_coords[quest_id].items():
            for coord in coords:
                if len(coord) != 3:
                    add_issue(quest_id, f"objectiveCoords[{obj_index}] emitted non-canonical tuple {coord!r}")

    return issues


def main():
    flush_print("=" * 70)
    flush_print("Vanilla Questie ID-Based Database Converter")
    flush_print("=" * 70)
    
    # Check source directories
    if not PFQUEST_DIR.exists():
        print(f"ERROR: pfQuest directory not found: {PFQUEST_DIR}")
        print("Please ensure pfQuest is cloned to tools/pfQuest/")
        return 1
    
    print("\n[1/7] Loading pfQuest vanilla complements...")
    
    # Load pfQuest data files
    units_content = read_file(PFQUEST_DIR / "units.lua")
    objects_content = read_file(PFQUEST_DIR / "objects.lua")
    items_content = read_file(PFQUEST_DIR / "items.lua")
    quests_content = read_file(PFQUEST_DIR / "quests.lua")
    
    # Parse data
    print("  Parsing units data...")
    pfquest_units_data = parse_pfquest_data_table(units_content, "units")
    print(f"    Found {len(pfquest_units_data)} units with coordinate complements")
    
    print("  Parsing objects data...")
    pfquest_objects_data = parse_pfquest_data_table(objects_content, "objects")
    print(f"    Found {len(pfquest_objects_data)} objects with coordinate complements")
    
    print("  Parsing items data...")
    pfquest_items_data = parse_pfquest_items_data(items_content)
    print(f"    Found {len(pfquest_items_data)} items with source complements")
    
    print("  Parsing quests data...")
    pfquest_quests_data = parse_pfquest_quests_data(quests_content)
    print(f"    Found {len(pfquest_quests_data)} quests with fallback metadata")
    
    print("\n[2/7] Loading pfQuest locale files...")
    
    # Load English names
    units_enus_content = read_file(PFQUEST_DIR / "enUS" / "units.lua")
    objects_enus_content = read_file(PFQUEST_DIR / "enUS" / "objects.lua")
    items_enus_content = read_file(PFQUEST_DIR / "enUS" / "items.lua")
    quests_enus_content = read_file(PFQUEST_DIR / "enUS" / "quests.lua")
    
    pfquest_units_names_enus = parse_pfquest_names(units_enus_content, 'pfDB["units"]["enUS"]')
    pfquest_objects_names_enus = parse_pfquest_names(objects_enus_content, 'pfDB["objects"]["enUS"]')
    pfquest_items_names_enus = parse_pfquest_names(items_enus_content, 'pfDB["items"]["enUS"]')
    pfquest_quests_names_enus = parse_pfquest_quest_locale(quests_enus_content, "enUS")
    
    print(f"  English fallback: {len(pfquest_units_names_enus)} units, {len(pfquest_objects_names_enus)} objects, {len(pfquest_items_names_enus)} items, {len(pfquest_quests_names_enus)} quests")
    
    # Load Chinese names from pfQuest (fallback)
    units_zhcn_content = read_file(PFQUEST_DIR / "zhCN" / "units.lua")
    objects_zhcn_content = read_file(PFQUEST_DIR / "zhCN" / "objects.lua")
    items_zhcn_content = read_file(PFQUEST_DIR / "zhCN" / "items.lua")
    quests_zhcn_content = read_file(PFQUEST_DIR / "zhCN" / "quests.lua")
    
    units_names_zhcn_pfquest = parse_pfquest_names(units_zhcn_content, 'pfDB["units"]["zhCN"]')
    objects_names_zhcn_pfquest = parse_pfquest_names(objects_zhcn_content, 'pfDB["objects"]["zhCN"]')
    items_names_zhcn_pfquest = parse_pfquest_names(items_zhcn_content, 'pfDB["items"]["zhCN"]')
    quests_names_zhcn_pfquest = parse_pfquest_quest_locale(quests_zhcn_content, "zhCN")
    
    print(f"  Chinese (pfQuest): {len(units_names_zhcn_pfquest)} units, {len(objects_names_zhcn_pfquest)} objects, {len(items_names_zhcn_pfquest)} items, {len(quests_names_zhcn_pfquest)} quests")
    
    print("\n[3/7] Loading CMaNGOS ClassicDB Chinese translations...")
    
    # Load CMaNGOS SQL (authoritative Chinese names)
    units_names_cmangos = {}
    objects_names_cmangos = {}
    items_names_cmangos = {}
    quests_names_cmangos = {}
    
    if CMANGOS_DIR.exists():
        creature_sql = read_file(CMANGOS_DIR / "locales_creature.sql")
        if creature_sql:
            units_names_cmangos = parse_cmangos_creature(creature_sql)
            print(f"  CMaNGOS creatures: {len(units_names_cmangos)} entries")
        
        gameobject_sql = read_file(CMANGOS_DIR / "locales_gameobject.sql")
        if gameobject_sql:
            objects_names_cmangos = parse_cmangos_gameobject(gameobject_sql)
            print(f"  CMaNGOS gameobjects: {len(objects_names_cmangos)} entries")
        
        item_sql = read_file(CMANGOS_DIR / "locales_item.sql")
        if item_sql:
            items_names_cmangos = parse_cmangos_item(item_sql)
            print(f"  CMaNGOS items: {len(items_names_cmangos)} entries")
        
        quest_sql = read_file(CMANGOS_DIR / "locales_quest.sql")
        if quest_sql:
            quests_names_cmangos = parse_cmangos_quest(quest_sql)
            print(f"  CMaNGOS quests: {len(quests_names_cmangos)} entries")
    else:
        print(f"  WARNING: CMaNGOS directory not found: {CMANGOS_DIR}")
        print("  Will use pfQuest Chinese names only")
    
    print("\n[4/7] Loading ClassicDB Full_DB data...")
    
    quest_objective_coords = {}
    
    # Try to load from extracted SQL first, then compressed
    fulldb_sql_path = CMANGOS_FULLDB_DIR / "ClassicDB_extracted.sql"
    fulldb_gz_path = CMANGOS_FULLDB_DIR / "ClassicDB_1_12_1_z2815.sql.gz"
    
    fulldb_content = ""
    if fulldb_sql_path.exists():
        print(f"  Loading from extracted SQL: {fulldb_sql_path.name}")
        fulldb_content = read_file(fulldb_sql_path)
    elif fulldb_gz_path.exists():
        print(f"  Loading from compressed SQL: {fulldb_gz_path.name}")
        import gzip
        try:
            with gzip.open(fulldb_gz_path, 'rt', encoding='utf-8', errors='replace') as f:
                fulldb_content = f.read()
        except Exception as e:
            print(f"  Warning: Failed to read compressed SQL: {e}")
    
    if not fulldb_content:
        print("  ERROR: No ClassicDB Full_DB SQL found")
        print(f"    Expected: {fulldb_sql_path} or {fulldb_gz_path}")
        return 1

    print("  Parsing SQL-backed vanilla names...")
    sql_units_names_enus = build_sql_template_name_table(fulldb_content, "creature_template", "Entry", "Name")
    sql_objects_names_enus = build_sql_template_name_table(fulldb_content, "gameobject_template", "entry", "name")
    sql_items_names_enus = build_sql_template_name_table(fulldb_content, "item_template", "entry", "name")
    sql_quests_names_enus = build_sql_quest_names(fulldb_content)
    print(f"    SQL names: {len(sql_units_names_enus)} units, {len(sql_objects_names_enus)} objects, {len(sql_items_names_enus)} items, {len(sql_quests_names_enus)} quests")

    print("  Parsing SQL-backed vanilla spawn locations...")
    sql_units_data = build_sql_spawn_location_data(fulldb_content, "creature")
    sql_objects_data = build_sql_spawn_location_data(fulldb_content, "gameobject")
    print(f"    SQL spawns: {len(sql_units_data)} units, {len(sql_objects_data)} objects")

    print("  Parsing SQL-backed vanilla item sources...")
    sql_items_data = build_sql_item_data(fulldb_content)
    print(f"    SQL items: {len(sql_items_data)} entries with sources")

    print("  Parsing SQL-backed vanilla quest metadata...")
    sql_quests_data = build_sql_quest_data(fulldb_content)
    print(f"    SQL quests: {len(sql_quests_data)} entries")

    print("  Parsing quest_poi table...")
    quest_poi = parse_quest_poi(fulldb_content)
    print(f"    Found {len(quest_poi)} quests with POI data")

    print("  Parsing quest_poi_points table...")
    quest_poi_points = parse_quest_poi_points(fulldb_content)
    print(f"    Found {len(quest_poi_points)} quests with POI points")

    print("  Building objective coordinates...")
    quest_objective_coords = build_quest_objective_coords(quest_poi, quest_poi_points)
    print(f"    Built coordinates for {len(quest_objective_coords)} quests")

    print("\n[5/7] Merging database-first vanilla data with pfQuest complements...")

    units_data = merge_vanilla_location_data(sql_units_data, pfquest_units_data)
    objects_data = merge_vanilla_location_data(sql_objects_data, pfquest_objects_data)
    items_data = merge_vanilla_item_data(sql_items_data, pfquest_items_data)
    quests_data = merge_vanilla_quest_data(sql_quests_data, pfquest_quests_data)
    units_names_enus = merge_name_tables(sql_units_names_enus, pfquest_units_names_enus)
    objects_names_enus = merge_name_tables(sql_objects_names_enus, pfquest_objects_names_enus)
    items_names_enus = merge_name_tables(sql_items_names_enus, pfquest_items_names_enus)
    quests_names_enus = merge_quest_name_tables(sql_quests_names_enus, pfquest_quests_names_enus)

    print(f"  Merged vanilla data: {len(units_data)} units, {len(objects_data)} objects, {len(items_data)} items, {len(quests_data)} quests")
    print(f"  Merged enUS names: {len(units_names_enus)} units, {len(objects_names_enus)} objects, {len(items_names_enus)} items, {len(quests_names_enus)} quests")

    print("\n[6/7] Merging Chinese names (CMaNGOS primary, pfQuest fallback)...")
    
    # Merge Chinese names: CMaNGOS takes priority
    units_names_zhcn = {}
    for unit_id in set(units_names_cmangos.keys()) | set(units_names_zhcn_pfquest.keys()):
        if unit_id in units_names_cmangos:
            units_names_zhcn[unit_id] = units_names_cmangos[unit_id]
        elif unit_id in units_names_zhcn_pfquest:
            units_names_zhcn[unit_id] = units_names_zhcn_pfquest[unit_id]
    
    objects_names_zhcn = {}
    for obj_id in set(objects_names_cmangos.keys()) | set(objects_names_zhcn_pfquest.keys()):
        if obj_id in objects_names_cmangos:
            objects_names_zhcn[obj_id] = objects_names_cmangos[obj_id]
        elif obj_id in objects_names_zhcn_pfquest:
            objects_names_zhcn[obj_id] = objects_names_zhcn_pfquest[obj_id]
    
    items_names_zhcn = {}
    for item_id in set(items_names_cmangos.keys()) | set(items_names_zhcn_pfquest.keys()):
        if item_id in items_names_cmangos:
            items_names_zhcn[item_id] = items_names_cmangos[item_id]
        elif item_id in items_names_zhcn_pfquest:
            items_names_zhcn[item_id] = items_names_zhcn_pfquest[item_id]
    
    quests_names_zhcn = {}
    for quest_id in set(quests_names_cmangos.keys()) | set(quests_names_zhcn_pfquest.keys()):
        if quest_id in quests_names_cmangos:
            quests_names_zhcn[quest_id] = quests_names_cmangos[quest_id]
        elif quest_id in quests_names_zhcn_pfquest:
            quests_names_zhcn[quest_id] = quests_names_zhcn_pfquest[quest_id]
    
    print(f"  Merged Chinese: {len(units_names_zhcn)} units, {len(objects_names_zhcn)} objects, {len(items_names_zhcn)} items, {len(quests_names_zhcn)} quests")

    validation_issues = validate_structured_quest_db(quests_data, units_data, objects_data, items_data, quest_objective_coords)
    if validation_issues:
        print("\nWARNING: Vanilla structured quest validation found unresolved links.")
        for issue in validation_issues[:50]:
            print(f"  - {issue}")
        if len(validation_issues) > 50:
            print(f"  - ... and {len(validation_issues) - 50} more")
        print("  Generation will continue; unresolved quests may lack starter/finisher markers.")
    
    print("\n[7/7] Generating output files...")
    
    # Create output directories
    ensure_dir(DATA_DIR)
    ensure_dir(LOCALE_ENUS_DIR)
    ensure_dir(LOCALE_ZHCN_DIR)
    
    # Generate data files
    print("  Generating Database/data/units.lua...")
    units_lua = generate_units_data(units_data)
    with open(DATA_DIR / "units.lua", 'w', encoding='utf-8') as f:
        f.write(units_lua)
    
    print("  Generating Database/data/objects.lua...")
    objects_lua = generate_objects_data(objects_data)
    with open(DATA_DIR / "objects.lua", 'w', encoding='utf-8') as f:
        f.write(objects_lua)
    
    print("  Generating Database/data/items.lua...")
    items_lua = generate_items_data(items_data)
    with open(DATA_DIR / "items.lua", 'w', encoding='utf-8') as f:
        f.write(items_lua)
    
    print("  Generating Database/data/quests.lua...")
    quests_lua = generate_quests_data(quests_data, quest_objective_coords)
    with open(DATA_DIR / "quests.lua", 'w', encoding='utf-8') as f:
        f.write(quests_lua)
    
    # Generate locale files
    print("  Generating Database/locale/enUS/names.lua...")
    names_enus_lua = generate_names_lua(units_names_enus, objects_names_enus, items_names_enus, quests_names_enus, "enUS")
    with open(LOCALE_ENUS_DIR / "names.lua", 'w', encoding='utf-8') as f:
        f.write(names_enus_lua)
    
    print("  Generating Database/locale/zhCN/names.lua...")
    names_zhcn_lua = generate_names_lua(units_names_zhcn, objects_names_zhcn, items_names_zhcn, quests_names_zhcn, "zhCN")
    with open(LOCALE_ZHCN_DIR / "names.lua", 'w', encoding='utf-8') as f:
        f.write(names_zhcn_lua)
    
    print("\nSummary")
    print("=" * 70)
    print(f"  Units:   {len(units_data)} entries with locations")
    print(f"  Objects: {len(objects_data)} entries with locations")
    print(f"  Items:   {len(items_data)} entries with database-first sources")
    print(f"  Quests:  {len(quests_data)} database-first entries")
    print(f"  Quest POI: {len(quest_objective_coords)} quests with objective coordinates")
    print(f"  English names: {len(units_names_enus)} units, {len(objects_names_enus)} objects, {len(items_names_enus)} items")
    print(f"  Chinese names: {len(units_names_zhcn)} units, {len(objects_names_zhcn)} objects, {len(items_names_zhcn)} items")
    
    if unmapped_zones:
        print(f"\n  WARNING: {len(unmapped_zones)} unmapped zone IDs (locations skipped):")
        for zone in sorted(unmapped_zones)[:10]:
            print(f"    Zone {zone}")
        if len(unmapped_zones) > 10:
            print(f"    ... and {len(unmapped_zones) - 10} more")
    
    print("\n  Output files:")
    print(f"    {DATA_DIR / 'units.lua'}")
    print(f"    {DATA_DIR / 'objects.lua'}")
    print(f"    {DATA_DIR / 'items.lua'}")
    print(f"    {DATA_DIR / 'quests.lua'}")
    print(f"    {LOCALE_ENUS_DIR / 'names.lua'}")
    print(f"    {LOCALE_ZHCN_DIR / 'names.lua'}")
    
    print("\nDone!")
    return 0


if __name__ == "__main__":
    sys.exit(main())
