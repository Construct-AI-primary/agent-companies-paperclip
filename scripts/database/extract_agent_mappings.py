#!/usr/bin/env python3
import os
import re
import csv
from pathlib import Path

def extract_agent_info_from_file(file_path):
    """Extract agent name and ID from an AGENTS.md file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Extract agent name from title or first heading
        name_match = re.search(r'^#\s+(.+)$', content, re.MULTILINE)
        if not name_match:
            return None

        agent_name = name_match.group(1).strip()

        # Extract Agent ID
        id_match = re.search(r'\*\*Agent ID\*\*:\s*`?([^`\n]+)`?', content)
        if not id_match:
            # Try alternative format
            id_match = re.search(r'\*\*Agent ID\*\*:\s*(.+)', content)

        agent_id = id_match.group(1).strip() if id_match else None

        # Extract company
        company_match = re.search(r'\*\*Company\*\*:\s*(.+)', content)
        company = company_match.group(1).strip() if company_match else None

        return {
            'file_path': str(file_path),
            'agent_name': agent_name,
            'agent_id': agent_id,
            'company': company
        }
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return None

def find_all_agent_files():
    """Find all AGENTS.md files in the companies directory"""
    companies_dir = Path('docs-paperclip/companies')
    agent_files = []

    if companies_dir.exists():
        for agent_file in companies_dir.rglob('AGENTS.md'):
            agent_files.append(agent_file)

    return agent_files

def load_unmapped_agents():
    """Load the unmapped agent names from the CSV"""
    unmapped = set()
    with open('/Users/alistairtennant/Downloads/agent_models_rows.csv', 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            agent_id = row['agent_id'].strip()
            if (' ' in agent_id or len(agent_id) < 36) and not agent_id.replace('-', '').replace('0123456789abcdef', '').strip() == '':
                unmapped.add(agent_id)
    return unmapped

def main():
    print("Finding all agent documentation files...")
    agent_files = find_all_agent_files()
    print(f"Found {len(agent_files)} agent files")

    print("\nExtracting agent information...")
    agents_info = []
    for file_path in agent_files:
        info = extract_agent_info_from_file(file_path)
        if info:
            agents_info.append(info)

    print(f"Successfully extracted info from {len(agents_info)} files")

    # Load unmapped agents
    unmapped_agents = load_unmapped_agents()
    print(f"\nUnmapped agents from CSV: {len(unmapped_agents)}")

    # Try to find matches
    exact_matches = []
    partial_matches = []

    for agent_info in agents_info:
        doc_name = agent_info['agent_name']
        doc_id = agent_info['agent_id']

        # Check for exact matches
        if doc_name in unmapped_agents:
            exact_matches.append({
                'csv_name': doc_name,
                'doc_name': doc_name,
                'doc_id': doc_id,
                'company': agent_info['company'],
                'file_path': agent_info['file_path']
            })

        # Check for partial matches (case-insensitive)
        for unmapped in unmapped_agents:
            if (doc_name.lower() == unmapped.lower() or
                unmapped.lower() in doc_name.lower() or
                doc_name.lower() in unmapped.lower()):
                if not any(m['csv_name'] == unmapped and m['doc_name'] == doc_name for m in partial_matches):
                    partial_matches.append({
                        'csv_name': unmapped,
                        'doc_name': doc_name,
                        'doc_id': doc_id,
                        'company': agent_info['company'],
                        'file_path': agent_info['file_path']
                    })

    print(f"\n=== RESULTS ===")
    print(f"Exact matches found: {len(exact_matches)}")
    print(f"Partial matches found: {len(partial_matches)}")

    if exact_matches:
        print(f"\n=== EXACT MATCHES ===")
        for match in exact_matches:
            print(f"CSV: '{match['csv_name']}' -> Doc: '{match['doc_name']}' (ID: {match['doc_id']})")

    if partial_matches:
        print(f"\n=== PARTIAL MATCHES (first 20) ===")
        for match in partial_matches[:20]:
            print(f"CSV: '{match['csv_name']}' ~ Doc: '{match['doc_name']}' (ID: {match['doc_id']})")

    # Show some examples of what we have
    print(f"\n=== SAMPLE AGENT INFO ===")
    for info in agents_info[:5]:
        print(f"Name: '{info['agent_name']}', ID: {info['agent_id']}, Company: {info['company']}")

if __name__ == '__main__':
    main()