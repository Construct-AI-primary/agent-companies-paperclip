#!/usr/bin/env python3
"""
Sync agent configurations from Supabase backup to remote Hermes agent.
This sends agent configurations to the remote webhook endpoint so it can handle requests.
"""

import os
import json
import requests
from pathlib import Path

def get_backup_file():
    """Find the most recent backup file."""
    backup_dir = Path("supabase_backup_20260413_163846")  # Use the latest backup
    agents_file = backup_dir / "agents.json"

    if not agents_file.exists():
        print(f"❌ Backup file not found: {agents_file}")
        return None

    return agents_file

def get_webhook_url():
    """Get the webhook URL from agent configurations."""
    backup_file = get_backup_file()
    if not backup_file:
        return None

    with open(backup_file, 'r') as f:
        agents = json.load(f)

    # Find a sample agent with http adapter to get the URL
    for agent in agents:
        if agent.get('adapter_type') == 'http':
            config = agent.get('adapter_config', {})
            url = config.get('url')
            if url:
                return url

    return None

def sync_agent_to_remote(agent_data, webhook_url):
    """Sync a single agent configuration to the remote Hermes agent."""
    agent_id = agent_data['id']
    agent_name = agent_data['name']

    # Prepare the payload for the remote agent
    payload = {
        'action': 'register_agent',
        'agent': {
            'id': agent_id,
            'name': agent_name,
            'company_id': agent_data['company_id'],
            'capabilities': agent_data.get('capabilities', ''),
            'adapter_config': agent_data.get('adapter_config', {}),
            'status': agent_data.get('status', 'active'),
            'reports_to': agent_data.get('reports_to'),
        }
    }

    try:
        response = requests.post(
            f"{webhook_url}/register",
            json=payload,
            headers={'Content-Type': 'application/json'},
            timeout=30
        )

        if response.status_code == 200:
            result = response.json()
            if result.get('success'):
                print(f"✅ Synced agent: {agent_name} ({agent_id[:8]}...)")
                return True
            else:
                print(f"❌ Failed to sync agent {agent_name}: {result.get('error', 'Unknown error')}")
                return False
        else:
            print(f"❌ HTTP {response.status_code} for agent {agent_name}: {response.text}")
            return False

    except Exception as e:
        print(f"❌ Error syncing agent {agent_name}: {e}")
        return False

def main():
    """Main function."""
    print("🔄 Syncing agent configurations to remote Hermes agent")
    print()

    # Get backup file
    backup_file = get_backup_file()
    if not backup_file:
        print("❌ No backup file found.")
        return

    # Get webhook URL
    webhook_url = get_webhook_url()
    if not webhook_url:
        print("❌ Could not find webhook URL in agent configurations.")
        return

    print(f"📡 Remote webhook URL: {webhook_url}")

    # Read agent configurations
    with open(backup_file, 'r') as f:
        agents = json.load(f)

    # Filter for HTTP adapter agents
    http_agents = [agent for agent in agents if agent.get('adapter_type') == 'http']

    print(f"📊 Found {len(http_agents)} HTTP adapter agents to sync")
    print()

    # Confirm with user
    response = input(f"Are you sure you want to sync {len(http_agents)} agents to the remote Hermes agent? (type 'yes' to confirm): ")
    if response.lower() != 'yes':
        print("Operation cancelled.")
        return

    # Sync agents
    synced_count = 0
    failed_count = 0

    for agent in http_agents:
        if sync_agent_to_remote(agent, webhook_url):
            synced_count += 1
        else:
            failed_count += 1

        # Progress update
        if (synced_count + failed_count) % 10 == 0:
            print(f"📝 Progress: {synced_count + failed_count}/{len(http_agents)} agents processed")

    print()
    print("🎉 SYNC COMPLETE!")
    print(f"✅ Successfully synced: {synced_count} agents")
    print(f"❌ Failed to sync: {failed_count} agents")
    print(f"📍 Remote webhook: {webhook_url}")

    if synced_count > 0:
        print("\n🚀 Remote Hermes agent should now be able to handle Paperclip requests!")
    else:
        print("\n❌ No agents were synced. Check the error messages above.")

if __name__ == '__main__':
    main()