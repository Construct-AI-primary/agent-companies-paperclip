#!/usr/bin/env python3
import os
import re
from pathlib import Path

def extract_agent_info(agent_file_path):
    """Extract agent information from an individual AGENTS.md file"""
    try:
        with open(agent_file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Try to extract from YAML frontmatter first (domainforge-ai format)
        yaml_match = re.search(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
        if yaml_match:
            yaml_content = yaml_match.group(1)
            # Extract from YAML
            name_match = re.search(r'name:\s*([^\n]+)', yaml_content)
            slug_match = re.search(r'slug:\s*([^\n]+)', yaml_content)
            reports_to_match = re.search(r'reportsTo:\s*([^\n]+)', yaml_content)

            if name_match and slug_match:
                name = name_match.group(1).strip()
                agent_id = slug_match.group(1).strip()
                # Extract company from file path
                company = str(agent_file_path).split('/')[-4]  # companies/company-name/agents/agent-name/AGENTS.md
                company = company.replace('-ai', ' AI').replace('-forge', 'Forge').replace('-', ' ')

                return {
                    'agent_id': agent_id,
                    'name': name,
                    'company': company,
                    'role': None,
                    'file_path': agent_file_path
                }

        # Try to extract from **Name**: format (contentforge-ai format)
        agent_id_match = re.search(r'\*\*Agent ID\*\*: ([^\n]+)', content)
        agent_id = agent_id_match.group(1).strip() if agent_id_match else None

        name_match = re.search(r'\*\*Name\*\*: ([^\n]+)', content)
        name = name_match.group(1).strip() if name_match else None

        company_match = re.search(r'\*\*Company\*\*: ([^\n]+)', content)
        company = company_match.group(1).strip() if company_match else None

        role_match = re.search(r'\*\*Role\*\*: ([^\n]+)', content)
        role = role_match.group(1).strip() if role_match else None

        if agent_id and name and company:
            return {
                'agent_id': agent_id,
                'name': name,
                'company': company,
                'role': role,
                'file_path': agent_file_path
            }
        else:
            print(f"Warning: Missing required fields in {agent_file_path}")
            print(f"  Agent ID: {agent_id}, Name: {name}, Company: {company}")
            return None

    except Exception as e:
        print(f"Error reading {agent_file_path}: {e}")
        return None

def load_all_agents(base_path):
    """Load all agent information from individual AGENTS.md files"""
    agents = {}

    # Get all company directories
    companies_path = Path(base_path) / 'docs-paperclip' / 'companies'
    if not companies_path.exists():
        print(f"Error: Companies path {companies_path} not found")
        return agents

    for company_dir in companies_path.iterdir():
        if company_dir.is_dir() and not company_dir.name.startswith('.'):
            agents_path = company_dir / 'agents'
            if agents_path.exists():
                print(f"Scanning {company_dir.name} agents...")

                for agent_dir in agents_path.iterdir():
                    if agent_dir.is_dir():
                        agent_file = agent_dir / 'AGENTS.md'
                        if agent_file.exists():
                            agent_info = extract_agent_info(agent_file)
                            if agent_info:
                                # Use name as key for easier lookup
                                agents[agent_info['name']] = agent_info
                                print(f"  Found agent: {agent_info['name']} (ID: {agent_info['agent_id']})")

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

                # Find the agent with this name
                matching_agent = None
                for name, agent_data in agents.items():
                    if name == agent_name:
                        matching_agent = agent_data
                        break

                if matching_agent:
                    # Replace the empty ID line
                    updated_lines.append(f'- **ID**: {matching_agent["agent_id"]}')
                    i += 1  # Skip the next line since we processed it
                    print(f"  Updated: {agent_name} -> {matching_agent['agent_id']}")
                    continue
                else:
                    print(f"  Warning: Could not find agent with name '{agent_name}'")
                    # Debug: show what agent names we do have
                    available_names = list(agents.keys())[:10]  # Show first 10
                    print(f"  Available agent names: {available_names}")
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
    base_path = '/Users/_test-20260416/paperclip-render'

    # Load all agent data from individual files
    agents = load_all_agents(base_path)
    print(f"\nLoaded {len(agents)} agents from individual AGENTS.md files")

    # Process all schema files
    schema_dir = Path(base_path) / 'docs-paperclip' / 'schema' / 'tables'
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

    print("\nAll schema files updated using individual agent files as source of truth!")

if __name__ == '__main__':
    main()