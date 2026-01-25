#!/usr/bin/env python3
"""Extract WorldMapArea.dbc from WoW MPQ files and parse it."""

import struct
import os
from pathlib import Path

# Try to import mpyq
try:
    import mpyq
except ImportError:
    print("Error: mpyq not installed. Run: pip install mpyq")
    exit(1)

# Path to game data
GAME_DATA_DIR = Path(r"E:\Program Files (x86)\twmoa_1180\Data")

def extract_from_mpq(mpq_path: Path, file_path: str) -> bytes | None:
    """Extract a file from an MPQ archive."""
    try:
        archive = mpyq.MPQArchive(str(mpq_path))
        data = archive.read_file(file_path)
        return data
    except Exception as e:
        return None

def find_and_extract_dbc(filename: str) -> bytes | None:
    """Search for a DBC file in all MPQ archives."""
    # MPQ files to search (in order of priority)
    mpq_files = [
        "dbc.MPQ",
        "patch.MPQ",
        "patch-2.MPQ",
        "patch-3.mpq",
        "patch-4.mpq",
        "patch-5.mpq",
        "patch-6.mpq",
        "patch-7.mpq",
        "patch-8.mpq",
        "patch-9.mpq",
        "Patch-Z.mpq",
    ]
    
    # Try each MPQ
    for mpq_name in mpq_files:
        mpq_path = GAME_DATA_DIR / mpq_name
        if mpq_path.exists():
            # Try different path formats
            paths_to_try = [
                f"DBFilesClient\\{filename}",
                f"DBFilesClient/{filename}",
                filename,
            ]
            for file_path in paths_to_try:
                data = extract_from_mpq(mpq_path, file_path)
                if data:
                    print(f"Found {filename} in {mpq_name}")
                    return data
    
    return None

def parse_worldmaparea_dbc(data: bytes) -> list:
    """Parse WorldMapArea.dbc for vanilla WoW 1.12.1.
    
    Structure:
    - Header: 'WDBC', record_count, field_count, record_size, string_block_size
    - Records: ID, mapID, areaID, areaName_offset, locLeft, locRight, locTop, locBottom
    - String block
    """
    if len(data) < 20:
        print("Error: DBC file too small")
        return []
    
    # Parse header
    magic = data[0:4]
    if magic != b'WDBC':
        print(f"Error: Invalid DBC magic: {magic}")
        return []
    
    record_count, field_count, record_size, string_block_size = struct.unpack('<IIII', data[4:20])
    print(f"DBC Header: {record_count} records, {field_count} fields, {record_size} bytes/record")
    
    # Calculate offsets
    header_size = 20
    records_start = header_size
    string_block_start = header_size + (record_count * record_size)
    string_block = data[string_block_start:]
    
    # Parse records
    # Format for 1.12.1: ID(I), mapID(I), areaID(I), areaName(I), locLeft(f), locRight(f), locTop(f), locBottom(f)
    results = []
    
    for i in range(record_count):
        offset = records_start + (i * record_size)
        
        if record_size == 32:  # 8 fields * 4 bytes
            fields = struct.unpack('<IIIIffff', data[offset:offset+32])
            id_, map_id, area_id, name_offset, loc_left, loc_right, loc_top, loc_bottom = fields
        elif record_size == 28:  # 7 fields (no string)
            fields = struct.unpack('<IIIffff', data[offset:offset+28])
            id_, map_id, area_id, loc_left, loc_right, loc_top, loc_bottom = fields
            name_offset = 0
        else:
            print(f"Warning: Unexpected record size {record_size}")
            continue
        
        # Get area name from string block
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

def main():
    print("=" * 60)
    print("WorldMapArea.dbc Extractor")
    print("=" * 60)
    
    # Find and extract
    print(f"\nSearching in: {GAME_DATA_DIR}")
    data = find_and_extract_dbc("WorldMapArea.dbc")
    
    if not data:
        print("Error: Could not find WorldMapArea.dbc in any MPQ file")
        return
    
    print(f"Extracted {len(data)} bytes")
    
    # Parse
    print("\nParsing DBC...")
    areas = parse_worldmaparea_dbc(data)
    
    if not areas:
        print("Error: Failed to parse DBC")
        return
    
    print(f"Found {len(areas)} areas")
    
    # Output as Python dictionary for use in converter
    print("\n" + "=" * 60)
    print("WORLDMAPAREA_BOUNDS = {")
    print("    # mapAreaId: (locLeft, locRight, locTop, locBottom)")
    for area in areas:
        if area['locLeft'] != 0 or area['locRight'] != 0:
            print(f"    {area['id']}: ({area['locLeft']:.6f}, {area['locRight']:.6f}, {area['locTop']:.6f}, {area['locBottom']:.6f}),  # {area['areaName']} (mapID={area['mapID']}, areaID={area['areaID']})")
    print("}")
    
    # Also save to file
    output_path = Path(__file__).parent / "worldmaparea_bounds.py"
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("# WorldMapArea.dbc bounds extracted from WoW 1.12.1\n")
        f.write("# Format: mapAreaId: (locLeft, locRight, locTop, locBottom)\n")
        f.write("# locLeft/locRight = Y-axis boundaries\n")
        f.write("# locTop/locBottom = X-axis boundaries\n")
        f.write("# Conversion: mapX = (worldY - locLeft) / (locRight - locLeft)\n")
        f.write("#             mapY = (worldX - locTop) / (locBottom - locTop)\n\n")
        f.write("WORLDMAPAREA_BOUNDS = {\n")
        for area in areas:
            if area['locLeft'] != 0 or area['locRight'] != 0:
                f.write(f"    {area['id']}: ({area['locLeft']:.6f}, {area['locRight']:.6f}, {area['locTop']:.6f}, {area['locBottom']:.6f}),  # {area['areaName']}\n")
        f.write("}\n")
    
    print(f"\nSaved to: {output_path}")

if __name__ == "__main__":
    main()
