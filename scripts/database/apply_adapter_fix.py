#!/usr/bin/env python3
"""
Apply agent adapter configuration fixes through Supabase API.
This updates agents from HTTP adapter to hermes_local adapter.
"""

import os
import json
from pathlib import Path
from supabase import create_client
from dotenv import load_dotenv

def load_backup_agents():
    """Load agent configurations from backup."""
    backup_file = Path("supabase_backup_20260413_163846/agents.json")
    if not backup_file.exists():
        print(f"❌ Backup file not found: {backup_file}")
        return None

    with open(backup_file, 'r') as f:
        agents = json.load(f)

    return agents

def apply_adapter_fixes():
    """Apply adapter configuration fixes to all HTTP agents."""
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

    # Filter HTTP agents
    http_agents = [agent for agent in agents if agent.get('adapter_type') == 'http']

    print(f"📊 Found {len(http_agents)} agents to fix")
    print()

    # Confirm
    response = input(f"Apply adapter fixes to {len(http_agents)} agents? (yes/no): ")
    if response.lower() != 'yes':
        print("Operation cancelled.")
        return

    # Apply fixes
    fixed_count = 0
    error_count = 0

    for agent in http_agents:
        agent_id = agent['id']
        agent_name = agent['name']

        # New configuration
        new_adapter_config = {
            "model": agent.get('adapter_config', {}).get('model', 'anthropic/claude-sonnet-4-5'),
            "maxIterations": agent.get('adapter_config', {}).get('maxIterations', 50),
            "persistSession": agent.get('adapter_config', {}).get('persistSession', True)
        }

        try:
            # Update agent
            result = supabase.table('agents').update({
                'adapter_type': 'hermes_local',
                'adapter_config': new_adapter_config
            }).eq('id', agent_id).execute()

            if result.data:
                print(f"✅ Fixed: {agent_name}")
                fixed_count += 1
            else:
                print(f"❌ No data returned for: {agent_name}")
                error_count += 1

        except Exception as e:
            print(f"❌ Error fixing {agent_name}: {e}")
            error_count += 1

        # Progress update
        total_processed = fixed_count + error_count
        if total_processed % 25 == 0:
            print(f"📝 Progress: {total_processed}/{len(http_agents)} agents processed")

    print()
    print("🎉 FIX COMPLETE!")
    print(f"✅ Successfully fixed: {fixed_count} agents")
    print(f"❌ Errors: {error_count} agents")
    print()
    print("🔄 Restart Paperclip server to apply changes")

if __name__ == '__main__':
    apply_adapter_fixes()