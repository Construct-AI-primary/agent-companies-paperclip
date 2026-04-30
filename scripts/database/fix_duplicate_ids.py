#!/usr/bin/env python3
"""
Fix duplicate agent IDs in populate_agents_supabase.sql
This script finds all duplicate IDs and replaces them with unique sequential IDs
"""

import re

def fix_duplicate_ids(sql_file_path):
    # Read the SQL file
    with open(sql_file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Find all agent INSERT VALUE blocks
    # Pattern to match with potential line breaks: (\n  'UUID',\n  'company-id',\n  'name',
    pattern = r"\(\s*'([a-f0-9\-]+)',\s*'([a-f0-9\-]+)',\s*'([^']+)',"
    
    # Track IDs and their occurrences
    id_tracker = {}
    id_counter = 0
    
    def replace_id(match):
        nonlocal id_counter
        current_id = match.group(1)
        company_id = match.group(2)
        agent_name = match.group(3)
        
        # Track this ID
        if current_id not in id_tracker:
            id_tracker[current_id] = []
        id_tracker[current_id].append(agent_name)
        
        # If this ID has been seen before, generate a new unique one
        if len(id_tracker[current_id]) > 1:
            # Generate new unique ID
            new_id = f'a1b2c3d4-e5f6-7890-abcd-{id_counter:012x}'
            id_counter += 1
            print(f"Replacing duplicate ID {current_id} for agent '{agent_name}' with {new_id}")
            return f"('{new_id}', '{company_id}', '{agent_name}',"
        
        return match.group(0)
    
    # First pass: identify all IDs
    matches = list(re.finditer(pattern, content))
    print(f"Found {len(matches)} agent entries")
    
    # Count duplicates
    id_counts = {}
    for match in matches:
        agent_id = match.group(1)
        id_counts[agent_id] = id_counts.get(agent_id, 0) + 1
    
    print("\nDuplicate IDs found:")
    for agent_id, count in id_counts.items():
        if count > 1:
            print(f"  {agent_id}: {count} times")
    
    # Second pass: replace duplicates
    print("\nReplacing duplicates...")
    id_tracker = {}
    id_counter = 0x46  # Start from 0x46 since we already have IDs up to 0x45
    
    new_content = re.sub(pattern, replace_id, content)
    
    # Write the fixed content back
    with open(sql_file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print(f"\n✓ Fixed duplicate IDs in {sql_file_path}")
    print(f"✓ Generated {id_counter - 0x46} new unique IDs")

if __name__ == '__main__':
    sql_file = '/Users/_Hermes/paperclip-render/scripts/database/populate_agents_supabase.sql'
    fix_duplicate_ids(sql_file)
