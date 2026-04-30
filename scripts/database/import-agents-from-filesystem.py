#!/usr/bin/env python3
"""
Import Agents from File System to Supabase Database
Reads agent files from docs-paperclip/companies/*/agents/*/AGENTS.md
and imports them into the database with correct company assignments.
"""

import os
import sys
import glob
import yaml
import uuid
import secrets
from pathlib import Path
from typing import Dict, List, Optional

try:
    from supabase import create_client, Client
except ImportError:
    print("Error: supabase-py not installed. Install with: pip install supabase")
    sys.exit(1)

# Load environment variables
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass


def get_supabase_client() -> Client:
    """Create and return Supabase client."""
    url = os.getenv('SUPABASE_URL')
    service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')

    if not url or not service_key:
        raise ValueError("SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY required")

    return create_client(url, service_key)


def parse_agent_file(file_path: str) -> Optional[Dict]:
    """Parse agent YAML frontmatter from file."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Extract YAML frontmatter (between --- markers)
        if content.startswith('---'):
            parts = content.split('---', 2)
            if len(parts) >= 3:
                yaml_content = parts[1].strip()
                metadata = yaml.safe_load(yaml_content)
                return metadata
    except Exception as e:
        print(f"Error parsing {file_path}: {e}")

    return None


def get_company_id_mapping(supabase: Client) -> Dict[str, str]:
    """Get mapping of company slug to company ID."""
    companies = supabase.table('companies').select('id, name').execute()
    mapping = {}

    for company in companies.data:
        name = company['name']
        # Handle different naming conventions
        if name == 'Learning Forge AI':
            mapping['learningforge-ai'] = company['id']
        elif name == 'PaperclipForge AI':
            mapping['paperclipforge-ai'] = company['id']
        elif name == 'Loopy AI':
            mapping['loopy-ai'] = company['id']
        # Add more mappings as needed
        # Convert to slug format
        slug = name.lower().replace(' ', '').replace('-', '').replace('ai', '-ai')
        mapping[slug] = company['id']

    return mapping


def extract_agent_info_from_path(file_path: str) -> tuple[str, str]:
    """Extract company slug and agent name from file path."""
    path = Path(file_path)
    # Path format: docs-paperclip/companies/{company}/agents/{agent}/AGENTS.md
    parts = path.parts
    company_slug = parts[-4]  # companies/{company}/agents/{agent}/AGENTS.md
    agent_dir = parts[-2]     # {agent}
    return company_slug, agent_dir


def create_agent_in_db(supabase: Client, agent_data: Dict, company_id: str) -> Optional[str]:
    """Create agent in database and return agent ID."""
    try:
        # Prepare agent data
        agent_record = {
            'id': str(uuid.uuid4()),
            'name': agent_data.get('name') or agent_data.get('slug', 'Unknown Agent'),
            'company_id': company_id,
            'status': 'active',
            'created_at': 'now()',
            'updated_at': 'now()'
        }

        # Insert agent
        result = supabase.table('agents').insert(agent_record).execute()

        if result.data:
            agent_id = result.data[0]['id']
            print(f"✅ Created agent: {agent_record['name']} (ID: {agent_id})")

            # Generate API key
            api_key = f"pcp_{secrets.token_hex(24)}"

            # Create API key record
            supabase.table('agent_api_keys').insert({
                'agent_id': agent_id,
                'company_id': company_id,
                'name': 'default',
                'api_key': api_key
            }).execute()

            print(f"   API Key: {api_key}")
            return agent_id

    except Exception as e:
        print(f"❌ Error creating agent {agent_data.get('name', 'Unknown')}: {e}")

    return None


def main():
    """Main import function."""
    print("🚀 Agent Import from File System to Database")
    print("This will import agents from docs-paperclip/companies/*/agents/*/AGENTS.md")
    print()

    # Confirm
    if '--yes' not in sys.argv:
        response = input("Import agents from file system? (type 'yes' to confirm): ")
        if response.lower() != 'yes':
            print("Operation cancelled.")
            sys.exit(0)

    try:
        supabase = get_supabase_client()
        print("✅ Connected to Supabase")

        # Get company ID mapping
        company_mapping = get_company_id_mapping(supabase)
        print(f"📋 Found {len(company_mapping)} companies in database")

        # Find all agent files
        agent_files = glob.glob('docs-paperclip/companies/*/agents/*/AGENTS.md')
        print(f"📁 Found {len(agent_files)} agent files in file system")

        # Track results
        imported = 0
        skipped = 0
        errors = 0

        for file_path in agent_files:
            print(f"\n🔍 Processing: {file_path}")

            # Extract company and agent info from path
            company_slug, agent_dir = extract_agent_info_from_path(file_path)
            print(f"   Company: {company_slug}, Agent: {agent_dir}")

            # Check if company exists in mapping
            if company_slug not in company_mapping:
                print(f"   ❌ Company '{company_slug}' not found in database - skipping")
                errors += 1
                continue

            company_id = company_mapping[company_slug]

            # Parse agent file
            agent_data = parse_agent_file(file_path)
            if not agent_data:
                print(f"   ❌ Could not parse agent file - skipping")
                errors += 1
                continue

            # Check if agent already exists
            existing = supabase.table('agents').select('id').eq('name', agent_data.get('name') or agent_data.get('slug')).execute()
            if existing.data:
                print(f"   ⚠️  Agent already exists - skipping")
                skipped += 1
                continue

            # Create agent
            agent_id = create_agent_in_db(supabase, agent_data, company_id)
            if agent_id:
                imported += 1
            else:
                errors += 1

        # Summary
        print(f"\n📊 Import Summary:")
        print(f"   ✅ Imported: {imported} agents")
        print(f"   ⚠️  Skipped: {skipped} agents (already exist)")
        print(f"   ❌ Errors: {errors} agents")

        # Verify final counts
        final_count = supabase.table('agents').select('id', {count: 'exact'}).execute()
        print(f"   📈 Total agents in database: {final_count.count}")

        if imported > 0:
            print("\n🎉 Import completed successfully!")
            print("   Next steps:")
            print("   1. Test agent functionality")
            print("   2. Update cross-reference documentation")
            print("   3. Move any misplaced agent files")

    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)


if __name__ == '__main__':
    main()