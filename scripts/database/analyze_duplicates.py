#!/usr/bin/env python3
"""
Script to analyze the agents CSV file and identify potential duplicates.
"""

import csv
import sys
from collections import defaultdict

def analyze_duplicates(csv_file):
    """Analyze CSV file for potential duplicates."""
    agents = []

    # Read CSV file
    with open(csv_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            agents.append(row)

    print(f"Total agents: {len(agents)}")
    print()

    # Check for duplicate IDs
    id_counts = defaultdict(int)
    for agent in agents:
        id_counts[agent['id']] += 1

    duplicate_ids = {k: v for k, v in id_counts.items() if v > 1}
    if duplicate_ids:
        print("DUPLICATE IDs found:")
        for agent_id, count in duplicate_ids.items():
            print(f"  ID {agent_id}: appears {count} times")
        print()
    else:
        print("✓ No duplicate IDs found")
        print()

    # Check for duplicate name + company_id combinations
    name_company_counts = defaultdict(int)
    name_company_agents = defaultdict(list)

    for agent in agents:
        key = (agent['name'], agent['company_id'])
        name_company_counts[key] += 1
        name_company_agents[key].append(agent)

    duplicate_name_company = {k: v for k, v in name_company_counts.items() if v > 1}
    if duplicate_name_company:
        print("POTENTIAL DUPLICATES (same name + company_id):")
        for (name, company_id), count in duplicate_name_company.items():
            print(f"  Name: '{name}', Company: '{company_id}' - appears {count} times")
            for agent in name_company_agents[(name, company_id)]:
                print(f"    ID: {agent['id']}, Status: {agent['status']}, Created: {agent['created_at']}")
        print()
    else:
        print("✓ No duplicate name + company_id combinations found")
        print()

    # Check for agents with same name across different companies (might be intentional)
    name_counts = defaultdict(int)
    for agent in agents:
        name_counts[agent['name']] += 1

    common_names = {k: v for k, v in name_counts.items() if v > 1}
    if common_names:
        print("AGENTS WITH SAME NAME (across companies - may be intentional):")
        for name, count in sorted(common_names.items())[:20]:  # Show first 20
            print(f"  '{name}': appears {count} times")
        if len(common_names) > 20:
            print(f"  ... and {len(common_names) - 20} more")
        print()

    # Check for terminated/duplicate agents
    terminated_count = sum(1 for agent in agents if agent['status'] == 'terminated')
    error_count = sum(1 for agent in agents if agent['status'] == 'error')

    print(f"Agent status summary:")
    print(f"  Active: {sum(1 for agent in agents if agent['status'] == 'active')}")
    print(f"  Idle: {sum(1 for agent in agents if agent['status'] == 'idle')}")
    print(f"  Terminated: {terminated_count}")
    print(f"  Error: {error_count}")
    print(f"  Other: {sum(1 for agent in agents if agent['status'] not in ['active', 'idle', 'terminated', 'error'])}")
    print()

    # Check for agents with same adapter_config (might indicate copied configs)
    adapter_counts = defaultdict(int)
    for agent in agents:
        adapter_counts[agent['adapter_config']] += 1

    duplicate_configs = {k: v for k, v in adapter_counts.items() if v > 1 and k}  # Exclude empty configs
    if duplicate_configs:
        print("DUPLICATE ADAPTER CONFIGS (may indicate copied configurations):")
        for config, count in sorted(duplicate_configs.items(), key=lambda x: x[1], reverse=True)[:10]:  # Top 10
            print(f"  Config appears {count} times: {config[:100]}...")
        print()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python analyze_duplicates.py <csv_file>")
        sys.exit(1)

    csv_file = sys.argv[1]
    analyze_duplicates(csv_file)