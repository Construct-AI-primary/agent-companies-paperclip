#!/usr/bin/env python3
"""
Revert agent adapter configurations from hermes_local back to HTTP.
Updates agents to use HTTP adapter with their original ngrok webhook URLs.
"""

import os
import json
from pathlib import Path
from supabase import create_client
from dotenv import load_dotenv

def load_backup_agents():
    """Load agent configurations from the backup file."""
    backup_file = Path("supabase_backup_20260413_163846/agents.json")
    if not backup_file.exists():
        print(f"❌ Backup file not found: {backup_file}")
        return None

    with open(backup_file, 'r') as f:
        agents = json.load(f)

    return agents

def revert_adapter_fixes(skip_confirm=False):
    """Revert HTTP agents back from hermes_local adapter."""
    load_dotenv()

    # Initialize Supabase client
    supabase = create_client(
        os.getenv('SUPABASE_URL'),
        os.getenv('SUPABASE_SERVICE_ROLE_KEY')
    )

    # Load agents from backup
    agents = load_backup_agents()
    if agents is None:
        return

    # Filter agents that need HTTP adapter (originally HTTP, changed to hermes_local)
    http_agents = [agent for agent in agents if agent.get('adapter_type') == 'http']

    print(f"📊 Found {len(http_agents)} agents to revert to HTTP adapter")
    print()

    # Summary of what will happen
    print("📋 Summary of changes:")
    print(f"   • adapter_type: hermes_local → http")
    print(f"   • adapter_config: Will restore original URL and config")
    print()

    # Confirm (skip if flag set or --batch mode)
    import sys
    if not skip_confirm and '--batch' not in sys.argv:
        response = input(f"Revert {len(http_agents)} agents to HTTP adapter? (yes/no): ")
        if response.lower() != 'yes':
            print("Operation cancelled.")
            return

    # Apply reverts
    fixed_count = 0
    error_count = 0
    skipped_count = 0

    for agent in http_agents:
        agent_id = agent['id']
        agent_name = agent['name']
        original_url = agent.get('adapter_config', {}).get('url', '')
        original_model = agent.get('adapter_config', {}).get('model', 'anthropic/claude-sonnet-4-5')
        original_max_iterations = agent.get('adapter_config', {}).get('maxIterations', 50)
        original_persist_session = agent.get('adapter_config', {}).get('persistSession', True)

        # New configuration (reverted to HTTP)
        new_adapter_config = {
            "url": original_url,
            "model": original_model,
            "maxIterations": original_max_iterations,
            "persistSession": original_persist_session
        }

        if not original_url:
            print(f"⚠️  Skipped: {agent_name} (no original URL found)")
            skipped_count += 1
            continue

        try:
            # Update agent
            result = supabase.table('agents').update({
                'adapter_type': 'http',
                'adapter_config': new_adapter_config
            }).eq('id', agent_id).execute()

            if result.data:
                print(f"✅ Reverted: {agent_name}")
                print(f"   URL: {original_url}")
                fixed_count += 1
            else:
                print(f"❌ No data returned for: {agent_name}")
                error_count += 1

        except Exception as e:
            print(f"❌ Error reverting {agent_name}: {e}")
            error_count += 1

        # Progress update
        total_processed = fixed_count + error_count + skipped_count
        if total_processed % 25 == 0 and total_processed > 0:
            print(f"📝 Progress: {total_processed}/{len(http_agents)} agents processed")
            print()

    print()
    print("🎉 REVERT COMPLETE!")
    print(f"✅ Successfully reverted: {fixed_count} agents")
    print(f"❌ Errors: {error_count} agents")
    print(f"⚠️  Skipped (no URL): {skipped_count} agents")
    print()
    print("🔄 Next steps:")
    print("1. Restart Paperclip server on Render")
    print("2. Ensure ngrok tunnel is running on your Windows machine")
    print("3. Test agent execution with OpenRouter models")

if __name__ == '__main__':
    revert_adapter_fixes()