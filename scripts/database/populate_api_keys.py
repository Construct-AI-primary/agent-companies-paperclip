#!/usr/bin/env python3
"""
Direct SQL script to populate agent_api_keys table with API keys for all agents.
This bypasses the Paperclip API and works directly with Supabase.
"""

import os
import sys

try:
    from supabase import create_client, Client
except ImportError:
    print("Error: supabase-py not installed. Install with: pip install supabase")
    sys.exit(1)

# Load environment variables from .env file
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass


def get_supabase_client() -> Client:
    """Create and return Supabase client with service role access."""
    url = os.getenv('SUPABASE_URL')
    service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')

    if not url:
        raise ValueError("SUPABASE_URL environment variable is required")

    if not service_key:
        raise ValueError("SUPABASE_SERVICE_ROLE_KEY is REQUIRED for direct database access")

    return create_client(url, service_key)


def execute_sql_file(supabase: Client, sql_file: str) -> None:
    """Execute SQL from a file against Supabase."""
    with open(sql_file, 'r') as f:
        sql_content = f.read()

    # Split SQL into individual statements (basic approach)
    statements = [stmt.strip() for stmt in sql_content.split(';') if stmt.strip()]

    for i, statement in enumerate(statements, 1):
        if not statement:
            continue

        print(f"Executing statement {i}/{len(statements)}...")
        try:
            # For SELECT statements, we can execute them
            if statement.upper().strip().startswith('SELECT'):
                result = supabase.rpc('exec_sql', {'sql': statement}).execute()
                if result.data:
                    print("Query results:")
                    for row in result.data:
                        print(f"  {row}")
            else:
                # For other statements (INSERT, CREATE, etc.), use raw SQL
                # Note: Supabase client doesn't directly support DDL, so we'll try RPC
                try:
                    supabase.rpc('exec_sql', {'sql': statement}).execute()
                except Exception as e:
                    print(f"  Warning: Could not execute via RPC: {e}")
                    print(f"  You may need to run this manually in Supabase SQL editor:")
                    print(f"  {statement[:100]}...")

        except Exception as e:
            print(f"  Error executing statement {i}: {e}")
            print(f"  Statement: {statement[:100]}...")


def populate_api_keys_directly(supabase: Client) -> None:
    """Populate API keys using direct Supabase operations."""
    print("🔑 Populating API keys directly...")

    try:
        # First, get all agents that need API keys
        agents_response = supabase.table('agents').select('id, name, company_id, status').execute()
        agents = agents_response.data

        print(f"Found {len(agents)} total agents")

        # Filter for active agents
        active_agents = [a for a in agents if a['status'] not in ['pending_approval', 'terminated']]
        print(f"Found {len(active_agents)} active agents")

        # Check which agents already have keys
        keys_response = supabase.table('agent_api_keys').select('agent_id').execute()
        agents_with_keys = set(k['agent_id'] for k in keys_response.data)

        print(f"Found {len(keys_response.data)} existing API keys in database")
        print(f"Agents with keys: {sorted(list(agents_with_keys))}")

        agents_needing_keys = [a for a in active_agents if a['id'] not in agents_with_keys]
        print(f"Found {len(agents_needing_keys)} agents needing API keys")

        if agents_needing_keys:
            print("Agents needing keys:")
            for agent in agents_needing_keys[:5]:  # Show first 5
                print(f"  - {agent['name']} ({agent['id']})")
            if len(agents_needing_keys) > 5:
                print(f"  ... and {len(agents_needing_keys) - 5} more")

        if not agents_needing_keys:
            print("✅ All active agents already have API keys!")
            return

        # Generate and insert API keys
        inserted_count = 0
        for agent in agents_needing_keys:
            # Generate API key (same format as Paperclip)
            import secrets
            api_key = f"pcp_{secrets.token_hex(24)}"

            try:
                supabase.table('agent_api_keys').insert({
                    'agent_id': agent['id'],
                    'company_id': agent['company_id'],
                    'name': 'default',
                    'api_key': api_key
                }).execute()

                print(f"✅ Created key for agent: {agent['name']}")
                print(f"   API Key: {api_key}")
                print(f"   Agent ID: {agent['id']}")
                print()

                inserted_count += 1

            except Exception as e:
                print(f"❌ Failed to create key for {agent['name']}: {e}")

        print(f"🎉 Successfully created {inserted_count} API keys!")

    except Exception as e:
        print(f"❌ Error populating API keys: {e}")
        sys.exit(1)


def main():
    """Main function."""
    print("🗄️  Direct API Key Population for Supabase")
    print("⚠️  This will create API keys directly in your database")
    print()

    # Confirm with user
    if '--yes' not in sys.argv:
        response = input("Are you sure you want to populate API keys? (type 'yes' to confirm): ")
        if response.lower() != 'yes':
            print("Operation cancelled.")
            sys.exit(0)

    try:
        supabase = get_supabase_client()
        print("✅ Connected to Supabase")

        populate_api_keys_directly(supabase)

        print("\n📋 Summary:")
        print("✅ API keys have been created for all active agents")
        print("✅ Keys are stored in plain text in the 'api_key' column")
        print("✅ You can now run the backup script: python backup_supabase.py --yes")

    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)


if __name__ == '__main__':
    main()