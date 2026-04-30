#!/usr/bin/env python3
"""
Fix agent adapter configurations by changing HTTP adapters to hermes_local.
This resolves the issue where agents are configured to use external webhooks
that aren't properly set up.
"""

import os
import json
from pathlib import Path

def load_agents_from_backup():
    """Load agent configurations from the backup file."""
    backup_file = Path("supabase_backup_20260413_163846/agents.json")
    if not backup_file.exists():
        print(f"❌ Backup file not found: {backup_file}")
        return None

    with open(backup_file, 'r') as f:
        agents = json.load(f)

    return agents

def create_adapter_fix_sql(agents):
    """Create SQL to fix agent adapter configurations."""
    sql_statements = []

    # Add header
    sql_statements.append("-- Fix agent adapter configurations")
    sql_statements.append("-- Change HTTP adapters to hermes_local to avoid webhook issues")
    sql_statements.append("")

    for agent in agents:
        agent_id = agent['id']
        adapter_type = agent.get('adapter_type')
        name = agent['name']

        if adapter_type == 'http':
            # Change to hermes_local adapter
            new_adapter_config = {
                "model": agent.get('adapter_config', {}).get('model', 'anthropic/claude-sonnet-4-5'),
                "maxIterations": agent.get('adapter_config', {}).get('maxIterations', 50),
                "persistSession": agent.get('adapter_config', {}).get('persistSession', True)
            }

            # Escape single quotes in JSON
            config_json = json.dumps(new_adapter_config).replace("'", "''")

            sql_statements.append(f"-- Fix agent: {name} ({agent_id[:8]}...)")
            sql_statements.append("UPDATE agents")
            sql_statements.append(f"SET adapter_type = 'hermes_local',")
            sql_statements.append(f"    adapter_config = '{config_json}'")
            sql_statements.append(f"WHERE id = '{agent_id}';")
            sql_statements.append("")

    return sql_statements

def main():
    """Main function."""
    print("🔧 Fixing agent adapter configurations")
    print("📝 Changing HTTP adapters to hermes_local to resolve webhook issues")
    print()

    # Load agents
    agents = load_agents_from_backup()
    if not agents:
        return

    # Count HTTP adapters
    http_agents = [agent for agent in agents if agent.get('adapter_type') == 'http']
    print(f"📊 Found {len(http_agents)} agents using HTTP adapter")

    if len(http_agents) == 0:
        print("✅ No agents need fixing - all are already using appropriate adapters")
        return

    # Create SQL fix
    sql_statements = create_adapter_fix_sql(http_agents)

    # Write to file
    output_file = "fix_agent_adapters.sql"
    with open(output_file, 'w') as f:
        f.write('\n'.join(sql_statements))

    print(f"✅ Generated SQL fix file: {output_file}")
    print(f"📝 Contains {len(sql_statements) // 4} agent fixes")  # Rough estimate
    print()
    print("🚀 To apply the fixes:")
    print("1. Connect to your Supabase database")
    print(f"2. Run the SQL commands in {output_file}")
    print("3. Restart Paperclip to pick up the changes")
    print()
    print("💡 This will change agents from using external webhooks to using")
    print("   the local Hermes adapter, which should resolve the 500 errors.")

if __name__ == '__main__':
    main()