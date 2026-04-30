#!/usr/bin/env python3
"""
Extract detailed information for DevForge AI agents to diagnose display and org chart issues
"""

import os
import sys
import sqlite3
import json
from pathlib import Path

def get_db_path():
    """Find the database file"""
    db_url = os.getenv('DATABASE_URL')
    if db_url and db_url.startswith('sqlite:'):
        db_path = db_url.replace('sqlite:', '')
    else:
        # Look for common database locations
        possible_paths = [
            'data/pglite/paperclip.db',
            'paperclip.db',
            '../data/pglite/paperclip.db'
        ]
        for path in possible_paths:
            if os.path.exists(path):
                db_path = path
                break
        else:
            print("Could not find database file. Please set DATABASE_URL or ensure database exists.")
            sys.exit(1)

    return db_path

def extract_devforge_agents(db_path):
    """Extract all DevForge AI agents with full details"""
    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()

        # Get DevForge AI company ID
        cursor.execute("SELECT id FROM companies WHERE name = 'DevForge AI' LIMIT 1")
        devforge_result = cursor.fetchone()
        if not devforge_result:
            print("DevForge AI company not found!")
            return None

        devforge_id = devforge_result[0]
        print(f"DevForge AI company ID: {devforge_id}")

        # Get all columns from agents table
        cursor.execute("PRAGMA table_info(agents)")
        agent_columns = [col[1] for col in cursor.fetchall()]

        # Extract all DevForge agents with full details
        cursor.execute(f"""
            SELECT * FROM agents
            WHERE company_id = ?
            ORDER BY name
        """, (devforge_id,))

        agents_data = []
        for row in cursor.fetchall():
            agent_dict = dict(zip(agent_columns, row))
            agents_data.append(agent_dict)

        # Get org_chart_hierarchy data for DevForge
        cursor.execute("""
            SELECT * FROM org_chart_hierarchy
            WHERE company_name = 'DevForge AI'
            ORDER BY agent_name
        """)

        # Get column names for org_chart_hierarchy
        cursor.execute("PRAGMA table_info(org_chart_hierarchy)")
        org_columns = [col[1] for col in cursor.fetchall()]

        org_data = []
        for row in cursor.fetchall():
            org_dict = dict(zip(org_columns, row))
            org_data.append(org_dict)

        # Get company details
        cursor.execute("SELECT * FROM companies WHERE id = ?", (devforge_id,))
        company_columns = [desc[0] for desc in cursor.description]
        company_data = dict(zip(company_columns, cursor.fetchone()))

        conn.close()

        return {
            'company': company_data,
            'agents_columns': agent_columns,
            'agents': agents_data,
            'org_chart_columns': org_columns,
            'org_chart_hierarchy': org_data,
            'summary': {
                'total_agents': len(agents_data),
                'active_agents': len([a for a in agents_data if a.get('status') == 'active']),
                'terminated_agents': len([a for a in agents_data if a.get('status') == 'terminated']),
                'error_agents': len([a for a in agents_data if a.get('status') == 'error']),
                'ceo_count': len([a for a in agents_data if a.get('role') == 'ceo']),
                'org_chart_entries': len(org_data),
                'org_chart_ceos': len([o for o in org_data if o.get('is_ceo')])
            }
        }

    except Exception as e:
        print(f"Error extracting DevForge data: {e}")
        return None

def save_devforge_data(data, output_dir):
    """Save DevForge data to JSON file"""
    if data is None:
        return

    os.makedirs(output_dir, exist_ok=True)

    filename = "devforge-ai-detailed-analysis.json"
    filepath = os.path.join(output_dir, filename)

    with open(filepath, 'w') as f:
        json.dump(data, f, indent=2, default=str)

    print(f"Saved detailed DevForge analysis to {filepath}")

    # Print summary
    summary = data['summary']
    print("\n=== DEVFORGE AI SUMMARY ===")
    print(f"Total agents in database: {summary['total_agents']}")
    print(f"Active agents: {summary['active_agents']}")
    print(f"Terminated agents: {summary['terminated_agents']}")
    print(f"Error agents: {summary['error_agents']}")
    print(f"CEO agents: {summary['ceo_count']}")
    print(f"Org chart entries: {summary['org_chart_entries']}")
    print(f"Org chart CEOs: {summary['org_chart_ceos']}")

    print("\n=== AGENTS BY STATUS ===")
    for agent in data['agents']:
        status = agent.get('status', 'unknown')
        role = agent.get('role', 'unknown')
        name = agent.get('name', 'unnamed')
        print(f"  {name}: status={status}, role={role}")

    print("\n=== ORG CHART HIERARCHY ===")
    for entry in data['org_chart_hierarchy']:
        name = entry.get('agent_name', 'unnamed')
        is_ceo = entry.get('is_ceo', False)
        print(f"  {name}: is_ceo={is_ceo}")

def main():
    db_path = get_db_path()
    print(f"Using database: {db_path}")

    output_dir = "docs-paperclip/schema/contents"
    print(f"Output directory: {output_dir}")

    print("Extracting detailed DevForge AI data...")
    data = extract_devforge_agents(db_path)
    if data:
        save_devforge_data(data, output_dir)
    else:
        print("Failed to extract DevForge data")

    print("Extraction complete!")

if __name__ == "__main__":
    main()