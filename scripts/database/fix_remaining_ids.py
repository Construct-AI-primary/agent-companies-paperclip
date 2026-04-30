#!/usr/bin/env python3
import csv
import os
from pathlib import Path

def load_agent_data(csv_file):
    """Load agent data from CSV file"""
    agents = {}
    with open(csv_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            # Use the agent_id field as key
            agent_id = row.get('agent_id', '').strip()
            if agent_id:
                agents[agent_id] = row
    return agents

def update_schema_file(schema_file, agents):
    """Update a single schema file with agent IDs"""
    print(f"Processing {schema_file}")

    with open(schema_file, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    updated_lines = []
    i = 0
    while i < len(lines):
        line = lines[i].strip()

        # Look for empty ID field pattern: "- **ID**: "
        if line == '- **ID**: ':
            # Check if next line has Title
            if i + 1 < len(lines) and lines[i + 1].strip().startswith('- **Title**: '):
                # Extract title to find matching agent
                title_line = lines[i + 1].strip()
                title_start = title_line.find('**Title**: ') + len('**Title**: ')
                agent_name = title_line[title_start:].strip()

                # Find the agent with this title
                matching_agent = None
                for agent_id, agent_data in agents.items():
                    if agent_data.get('title', '').strip() == agent_name:
                        matching_agent = agent_id
                        break

                if matching_agent:
                    # Replace the empty ID line
                    updated_lines.append(f'- **ID**: {matching_agent}')
                    i += 1  # Skip the next line since we processed it
                    continue
                else:
                    print(f"  Warning: Could not find agent with title '{agent_name}'")
                    # Debug: show what titles we do have
                    available_titles = [agent_data.get('title', '').strip() for agent_data in agents.values() if agent_data.get('title', '').strip()]
                    print(f"  Available titles: {available_titles[:10]}...")  # Show first 10
            else:
                print(f"  Warning: Empty ID field not followed by Title at line {i+1}")

        # Add the current line
        updated_lines.append(lines[i])
        i += 1

    # Write back the updated file
    with open(schema_file, 'w', encoding='utf-8') as f:
        f.writelines(updated_lines)

    print(f"  Updated {schema_file}")

def main():
    csv_file = 'docs-paperclip/schema/tables/Agent all - Configuration.csv'
    schema_dir = Path('docs-paperclip/schema/tables')

    if not Path(csv_file).exists():
        print(f"Error: CSV file {csv_file} not found")
        return

    agents = load_agent_data(csv_file)
    print(f"Loaded {len(agents)} agents from CSV")

    # Process all schema files
    schema_files = [
        'contentforge-ai-agents.md',
        'devforge-ai-agents.md',
        'domainforge-ai-agents.md',
        'execforge-ai-agents.md',
        'infraforge-ai-agents.md',
        'integrateforge-ai-agents.md',
        'knowledgeforge-ai-agents.md',
        'loopy-ai-agents.md',
        'mobileforge-ai-agents.md',
        'paperclipforge-ai-agents.md',
        'promptforge-ai-agents.md',
        'qualityforge-ai-agents.md',
        'saasforge-ai-agents.md',
        'voiceforge-ai-agents.md'
    ]

    for schema_file in schema_files:
        schema_path = schema_dir / schema_file
        if schema_path.exists():
            update_schema_file(schema_path, agents)
        else:
            print(f"Warning: {schema_path} not found")

    print("All schema files updated!")

if __name__ == '__main__':
    main()