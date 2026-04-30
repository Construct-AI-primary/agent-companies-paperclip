#!/usr/bin/env python3
import csv
import json
import sys

def load_agent_mapping(backup_file):
    """Load agent name to UUID mapping from backup file"""
    with open(backup_file, 'r') as f:
        agents = json.load(f)

    name_to_uuid = {}
    for agent in agents:
        name = agent.get('name', '').strip()
        uuid = agent.get('id', '').strip()
        if name and uuid:
            name_to_uuid[name] = uuid

    return name_to_uuid

def fix_csv_agent_ids(csv_file, mapping):
    """Fix agent_id column in CSV file"""
    with open(csv_file, 'r') as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    fixed_count = 0
    not_found = set()

    for row in rows:
        agent_id = row['agent_id'].strip()
        if agent_id in mapping:
            row['agent_id'] = mapping[agent_id]
            fixed_count += 1
        elif agent_id not in mapping and (' ' in agent_id or len(agent_id) < 36):
            not_found.add(agent_id)

    # Write back the fixed CSV
    fieldnames = reader.fieldnames
    with open(csv_file, 'w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    return fixed_count, not_found

def main():
    backup_file = 'supabase_backup_20260415_081559/agents.json'
    csv_file = '/Users/alistairtennant/Downloads/agent_models_rows.csv'

    print("Loading agent mapping from backup...")
    mapping = load_agent_mapping(backup_file)
    print(f"Loaded {len(mapping)} agent mappings")

    print("Fixing CSV agent_id values...")
    fixed_count, not_found = fix_csv_agent_ids(csv_file, mapping)

    print(f"Fixed {fixed_count} agent_id entries")

    if not_found:
        print(f"\nWarning: {len(not_found)} agent names not found in backup:")
        for name in sorted(not_found):
            print(f"  {name}")
    else:
        print("All agent names successfully mapped to UUIDs!")

if __name__ == '__main__':
    main()