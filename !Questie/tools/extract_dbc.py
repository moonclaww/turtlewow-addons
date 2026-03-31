#!/usr/bin/env python3
"""Extract WorldMapArea.dbc from WoW MPQ files and generate Astrolabe zone data.

Auto-creates a .venv in the script directory and installs dependencies on first run.
No global package installation required.

Usage:
    python extract_dbc.py
    # or with explicit Python path:
    "D:\\Program Files\\Python311\\python.exe" extract_dbc.py

Outputs:
    worldmaparea_bounds.py                        - Raw DBC data as Python dict
    astrolabe_zone_data.lua                       - Reference Astrolabe data dump
    ..\..\!!!Libs\Astrolabe-0.2\GeneratedZoneData.lua - Runtime override loaded by addon
"""

import os
import sys
import struct
import subprocess
import argparse
from pathlib import Path

from mapregistry_versioning import generate_versioned_mapregistry

SCRIPT_DIR = Path(__file__).parent.resolve()
VENV_DIR = SCRIPT_DIR / ".venv"
REQUIREMENTS = SCRIPT_DIR / "requirements.txt"
ADDONS_DIR = SCRIPT_DIR.parent.parent
RUNTIME_LUA_OUTPUT = ADDONS_DIR / "!!!Libs" / "Astrolabe-0.2" / "GeneratedZoneData.lua"

# Path to game data
GAME_DATA_DIR = Path(r"E:\Program Files (x86)\twmoa_1180\Data")

# Continent DBC mapIDs and their Astrolabe continent indices
# DBC mapID 1 = Kalimdor -> Astrolabe continent 1
# DBC mapID 0 = Eastern Kingdoms -> Astrolabe continent 2
CONTINENT_MAP = {
    1: {"astrolabe_id": 1, "name": "Kalimdor"},
    0: {"astrolabe_id": 2, "name": "Eastern Kingdoms"},
}

# Continent WorldMapArea IDs (these entries represent the full continent bounds)
CONTINENT_WMA_IDS = {
    13: 1,   # Kalimdor continent -> mapID 1
    14: 0,   # Azeroth (Eastern Kingdoms) continent -> mapID 0
}


# ---------------------------------------------------------------------------
# Auto-venv bootstrap
# ---------------------------------------------------------------------------
def ensure_venv():
    """Create venv and install dependencies if needed, then re-exec under venv Python."""
    if sys.prefix != sys.base_prefix:
        return  # Already running inside a venv

    venv_python = VENV_DIR / ("Scripts" if os.name == "nt" else "bin") / ("python.exe" if os.name == "nt" else "python")

    if not venv_python.exists():
        print(f"Creating virtual environment in {VENV_DIR} ...")
        # Try the running Python first; fall back to known path
        python_exe = sys.executable
        if not python_exe or not Path(python_exe).exists():
            python_exe = r"D:\Program Files\Python311\python.exe"
        subprocess.check_call([python_exe, "-m", "venv", str(VENV_DIR)])
        print("Installing dependencies ...")
        pip = VENV_DIR / ("Scripts" if os.name == "nt" else "bin") / ("pip.exe" if os.name == "nt" else "pip")
        subprocess.check_call([str(pip), "install", "-r", str(REQUIREMENTS)])

    # Re-exec under venv Python
    os.execv(str(venv_python), [str(venv_python), str(Path(__file__).resolve())] + sys.argv[1:])


# ---------------------------------------------------------------------------
# MPQ / DBC extraction
# ---------------------------------------------------------------------------
def extract_from_mpq(mpq_path: Path, file_path: str):
    """Extract a file from an MPQ archive."""
    import mpyq
    try:
        archive = mpyq.MPQArchive(str(mpq_path))
        data = archive.read_file(file_path)
        return data
    except Exception:
        return None


def find_and_extract_dbc(filename: str):
    """Search for a DBC file across all MPQ archives in priority order."""
    mpq_files = [
        "dbc.MPQ",
        "patch.MPQ", "patch-2.MPQ", "patch-3.mpq",
        "patch-4.mpq", "patch-5.mpq", "patch-6.mpq",
        "patch-7.mpq", "patch-8.mpq", "patch-9.mpq",
        "Patch-Z.mpq",
    ]

    for mpq_name in mpq_files:
        mpq_path = GAME_DATA_DIR / mpq_name
        if mpq_path.exists():
            for file_path in [f"DBFilesClient\\{filename}", f"DBFilesClient/{filename}", filename]:
                data = extract_from_mpq(mpq_path, file_path)
                if data:
                    print(f"  Found {filename} in {mpq_name}")
                    return data
    return None


def parse_worldmaparea_dbc(data: bytes) -> list:
    """Parse WorldMapArea.dbc.

    Record structure (vanilla 1.12):
      ID(uint32), mapID(uint32), areaID(uint32), areaName_offset(uint32),
      locLeft(float), locRight(float), locTop(float), locBottom(float)
    """
    if len(data) < 20:
        print("Error: DBC file too small")
        return []

    magic = data[0:4]
    if magic != b'WDBC':
        print(f"Error: Invalid DBC magic: {magic}")
        return []

    record_count, field_count, record_size, string_block_size = struct.unpack('<IIII', data[4:20])
    print(f"  DBC: {record_count} records, {field_count} fields, {record_size} bytes/record")

    header_size = 20
    string_block_start = header_size + (record_count * record_size)
    string_block = data[string_block_start:]

    results = []
    for i in range(record_count):
        offset = header_size + (i * record_size)

        if record_size == 32:  # 8 fields * 4 bytes
            fields = struct.unpack('<IIIIffff', data[offset:offset + 32])
            id_, map_id, area_id, name_offset, loc_left, loc_right, loc_top, loc_bottom = fields
        elif record_size == 28:  # 7 fields (no string)
            fields = struct.unpack('<IIIffff', data[offset:offset + 28])
            id_, map_id, area_id, loc_left, loc_right, loc_top, loc_bottom = fields
            name_offset = 0
        else:
            print(f"  Warning: Unexpected record size {record_size}, skipping")
            return []

        area_name = ""
        if name_offset > 0 and name_offset < len(string_block):
            end = string_block.find(b'\x00', name_offset)
            if end != -1:
                area_name = string_block[name_offset:end].decode('utf-8', errors='replace')

        results.append({
            'id': id_,
            'mapID': map_id,
            'areaID': area_id,
            'areaName': area_name,
            'locLeft': loc_left,
            'locRight': loc_right,
            'locTop': loc_top,
            'locBottom': loc_bottom,
        })

    return results


# ---------------------------------------------------------------------------
# Output: Python bounds file
# ---------------------------------------------------------------------------
def write_bounds_py(areas: list, output_path: Path):
    """Write worldmaparea_bounds.py with raw DBC data."""
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("# WorldMapArea.dbc bounds extracted from WoW client\n")
        f.write("# Format: mapAreaId: (locLeft, locRight, locTop, locBottom)\n")
        f.write("# locLeft/locRight = Y-axis boundaries (positive = north)\n")
        f.write("# locTop/locBottom = X-axis boundaries (positive = west)\n")
        f.write("# Conversion: mapX = (worldY - locLeft) / (locRight - locLeft)\n")
        f.write("#             mapY = (worldX - locTop) / (locBottom - locTop)\n\n")
        f.write("WORLDMAPAREA_BOUNDS = {\n")
        for area in areas:
            if area['locLeft'] != 0 or area['locRight'] != 0:
                f.write(f"    {area['id']}: ({area['locLeft']:.6f}, {area['locRight']:.6f}, "
                        f"{area['locTop']:.6f}, {area['locBottom']:.6f}),  # {area['areaName']}\n")
        f.write("}\n")
    print(f"  Wrote: {output_path}")


# ---------------------------------------------------------------------------
# Output: Astrolabe Lua zone data
# ---------------------------------------------------------------------------
def compute_astrolabe_zone(area: dict, continent_area: dict) -> dict | None:
    """Convert DBC WorldMapArea bounds to Astrolabe zone data (game yards).

    DBC stores:
      locLeft, locRight = Y-axis world coordinates (north/south)
      locTop, locBottom = X-axis world coordinates (west/east)

    Astrolabe stores:
      height = zone north/south span in game yards
      width  = zone east/west span in game yards
      xOffset = offset from the continent's northern boundary
      yOffset = offset from the continent's western boundary
    """
    # Match Astrolabe's existing orientation:
    #   height comes from locTop/locBottom
    #   width  comes from locLeft/locRight
    height = abs(area['locTop'] - area['locBottom'])
    width = abs(area['locLeft'] - area['locRight'])

    if height == 0 or width == 0:
        return None

    # Continent dimensions
    cont_left = continent_area['locLeft']
    cont_top = continent_area['locTop']

    # Astrolabe stores positive offsets away from the continent's origin.
    x_offset = cont_left - area['locLeft']
    y_offset = cont_top - area['locTop']

    return {
        'height': height,
        'width': width,
        'xOffset': x_offset,
        'yOffset': y_offset,
    }


def write_astrolabe_lua(areas: list, output_path: Path):
    """Generate Astrolabe WorldMapSize zone data in Lua format."""
    # Index areas by WMA ID for continent lookup
    areas_by_id = {a['id']: a for a in areas}

    # Find continent bounds
    continent_bounds = {}  # mapID -> area dict
    for wma_id, map_id in CONTINENT_WMA_IDS.items():
        if wma_id in areas_by_id:
            continent_bounds[map_id] = areas_by_id[wma_id]

    # Group zones by continent mapID
    zones_by_continent = {}  # mapID -> [(area, astrolabe_data)]
    for area in areas:
        map_id = area['mapID']
        if map_id not in CONTINENT_MAP:
            continue
        if area['id'] in CONTINENT_WMA_IDS:
            continue  # Skip continent entries themselves
        if area['locLeft'] == 0 and area['locRight'] == 0:
            continue

        cont_area = continent_bounds.get(map_id)
        if not cont_area:
            continue

        zone_data = compute_astrolabe_zone(area, cont_area)
        if zone_data:
            zones_by_continent.setdefault(map_id, []).append((area, zone_data))

    # Write Lua
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("-- Astrolabe WorldMapSize zone data extracted from WorldMapArea.dbc\n")
        f.write("-- Auto-generated by extract_dbc.py — DO NOT EDIT MANUALLY\n")
        f.write("--\n")
        f.write("-- This file shows the expected zone data for reference and verification.\n")
        f.write("-- The actual Astrolabe.lua already contains this data inline.\n")
        f.write("-- Use this to verify correctness or update after DBC changes.\n")
        f.write("--\n")
        f.write("-- Format: WorldMapSize[continentID].zoneData.ZoneName = {\n")
        f.write("--     height = <yards>,  width = <yards>,\n")
        f.write("--     xOffset = <yards>, yOffset = <yards>,\n")
        f.write("-- }\n\n")

        for map_id in [1, 0]:  # Kalimdor first, then EK
            info = CONTINENT_MAP[map_id]
            astrolabe_id = info['astrolabe_id']
            cont_name = info['name']

            cont_area = continent_bounds.get(map_id)
            if cont_area:
                cont_h = abs(cont_area['locTop'] - cont_area['locBottom'])
                cont_w = abs(cont_area['locLeft'] - cont_area['locRight'])
                f.write(f"-- Continent {astrolabe_id}: {cont_name}\n")
                f.write(f"-- WorldMapSize[{astrolabe_id}] = {{ height = {cont_h:.6f}, width = {cont_w:.6f} }}\n\n")

            zones = zones_by_continent.get(map_id, [])
            zones.sort(key=lambda x: x[0]['areaName'])

            for area, zd in zones:
                name = area['areaName']
                if not name:
                    name = f"Unknown_WMA{area['id']}"
                f.write(f"-- WorldMapSize[{astrolabe_id}].zoneData.{name} = {{\n")
                f.write(f"--     height = {zd['height']:.6f},\n")
                f.write(f"--     width = {zd['width']:.6f},\n")
                f.write(f"--     xOffset = {zd['xOffset']:.6f},\n")
                f.write(f"--     yOffset = {zd['yOffset']:.6f},\n")
                f.write(f"-- }}  -- WMA ID: {area['id']}, AreaID: {area['areaID']}\n\n")

    print(f"  Wrote: {output_path}")


def write_runtime_override_lua(areas: list, output_path: Path):
    """Generate a Lua file that patches Astrolabe's WorldMapSize at runtime."""
    areas_by_id = {a['id']: a for a in areas}

    continent_bounds = {}
    for wma_id, map_id in CONTINENT_WMA_IDS.items():
        if wma_id in areas_by_id:
            continent_bounds[map_id] = areas_by_id[wma_id]

    zones_by_continent = {}
    for area in areas:
        map_id = area['mapID']
        if map_id not in CONTINENT_MAP:
            continue
        if area['id'] in CONTINENT_WMA_IDS:
            continue
        if area['locLeft'] == 0 and area['locRight'] == 0:
            continue

        cont_area = continent_bounds.get(map_id)
        if not cont_area:
            continue

        zone_data = compute_astrolabe_zone(area, cont_area)
        if zone_data:
            zones_by_continent.setdefault(map_id, []).append((area, zone_data))

    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("-- Auto-generated from WorldMapArea.dbc by !Questie/tools/extract_dbc.py\n")
        f.write("-- Loaded after Astrolabe.lua to override continent/zone bounds with client data.\n")
        f.write("-- DO NOT EDIT MANUALLY.\n\n")
        f.write("local override = {\n")

        for map_id in [1, 0]:
            info = CONTINENT_MAP[map_id]
            astrolabe_id = info['astrolabe_id']
            cont_area = continent_bounds.get(map_id)
            if not cont_area:
                continue

            cont_h = abs(cont_area['locTop'] - cont_area['locBottom'])
            cont_w = abs(cont_area['locLeft'] - cont_area['locRight'])
            f.write(f"    [{astrolabe_id}] = {{\n")
            f.write(f"        height = {cont_h:.6f},\n")
            f.write(f"        width = {cont_w:.6f},\n")
            f.write("        zoneData = {\n")

            zones = zones_by_continent.get(map_id, [])
            zones.sort(key=lambda x: x[0]['areaName'])
            for area, zd in zones:
                name = area['areaName'] or f"Unknown_WMA{area['id']}"
                f.write(f"            {name} = {{\n")
                f.write(f"                height = {zd['height']:.6f},\n")
                f.write(f"                width = {zd['width']:.6f},\n")
                f.write(f"                xOffset = {zd['xOffset']:.6f},\n")
                f.write(f"                yOffset = {zd['yOffset']:.6f},\n")
                f.write("            },\n")

            f.write("        },\n")
            f.write("    },\n")

        f.write("}\n\n")
        f.write("if not WorldMapSize then\n")
        f.write("    WorldMapSize = {}\n")
        f.write("end\n\n")
        f.write("for continent, continentData in pairs(override) do\n")
        f.write("    local mapData = WorldMapSize[continent]\n")
        f.write("    if not mapData then\n")
        f.write("        mapData = {}\n")
        f.write("        WorldMapSize[continent] = mapData\n")
        f.write("    end\n")
        f.write("    if continentData.height then mapData.height = continentData.height end\n")
        f.write("    if continentData.width then mapData.width = continentData.width end\n")
        f.write("    if continentData.xOffset then mapData.xOffset = continentData.xOffset end\n")
        f.write("    if continentData.yOffset then mapData.yOffset = continentData.yOffset end\n")
        f.write("    if continentData.zoneData then\n")
        f.write("        if not mapData.zoneData then mapData.zoneData = {} end\n")
        f.write("        for zoneName, zoneData in pairs(continentData.zoneData) do\n")
        f.write("            mapData.zoneData[zoneName] = zoneData\n")
        f.write("        end\n")
        f.write("    end\n")
        f.write("end\n")

    print(f"  Wrote: {output_path}")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
def main():
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument("--turtle-version", help="Exact TurtleWoW build string such as 1.18.1")
    parser.add_argument("--replace", action="store_true", help="Replace an existing output for the same Turtle version")
    args = parser.parse_args()

    print("=" * 60)
    print("WorldMapArea.dbc Extractor + Astrolabe Data Generator")
    print("=" * 60)

    print(f"\nSearching in: {GAME_DATA_DIR}")
    if not GAME_DATA_DIR.exists():
        print(f"Error: Game data directory not found: {GAME_DATA_DIR}")
        return

    data = find_and_extract_dbc("WorldMapArea.dbc")
    if not data:
        print("Error: Could not find WorldMapArea.dbc in any MPQ file")
        return

    print(f"  Extracted {len(data)} bytes")

    print("\nParsing DBC ...")
    areas = parse_worldmaparea_dbc(data)
    if not areas:
        print("Error: Failed to parse DBC")
        return

    print(f"  Found {len(areas)} WorldMapArea entries")

    # Write outputs
    print("\nGenerating outputs ...")
    write_bounds_py(areas, SCRIPT_DIR / "worldmaparea_bounds.py")
    write_astrolabe_lua(areas, SCRIPT_DIR / "astrolabe_zone_data.lua")
    write_runtime_override_lua(areas, RUNTIME_LUA_OUTPUT)

    if args.turtle_version:
        print(f"\nGenerating versioned Turtle MapRegistry dataset for {args.turtle_version} ...")
        version_output = generate_versioned_mapregistry(args.turtle_version, args.replace)
        print(f"  Wrote: {version_output}")

    # Summary
    print("\n" + "=" * 60)
    print("Done!")
    print("\nGenerated both reference output and the runtime override loaded by")
    print("!!!Libs/Astrolabe-0.2/GeneratedZoneData.lua.")


if __name__ == "__main__":
    ensure_venv()
    main()
