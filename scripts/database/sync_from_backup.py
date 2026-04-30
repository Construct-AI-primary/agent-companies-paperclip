#!/usr/bin/env python3
"""
Sync API keys from the Supabase backup to the local SQLite database.
This reads the plain-text keys from the backup JSON file and stores them locally.
"""

import os
import json
import sqlite3
from pathlib import Path

def get_backup_file():
    """Find the most recent backup file."""
    backup_dir = Path("supabase_backup_20260413_163846")  # Use the latest backup
    api_keys_file = backup_dir / "agent_api_keys.json"

    if not api_keys_file.exists():
        print(f"❌ Backup file not found: {api_keys_file}")
        return None

    return api_keys_file

def create_hermes_db_schema(cursor):
    """Create the necessary tables in the local SQLite database."""
    # Create hermes_state table with plain-text key support
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS hermes_state (
            agent_id TEXT PRIMARY KEY,
            agent_name TEXT,
            company_id TEXT,
            api_key TEXT,
            key_plaintext TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')

    # Create index for faster lookups
    cursor.execute('''
        CREATE INDEX IF NOT EXISTS idx_agent_id ON hermes_state(agent_id)
    ''')

    print("✅ Database schema created/updated")

def sync_api_keys_from_backup(backup_file):
    """Sync API keys from backup file to local database."""
    print(f"📂 Reading backup file: {backup_file}")

    with open(backup_file, 'r') as f:
        api_keys_data = json.load(f)

    print(f"📊 Found {len(api_keys_data)} API keys in backup")

    # Connect to local SQLite database
    db_path = Path("hermes_agent/hermes_agent.db")
    db_path.parent.mkdir(exist_ok=True)

    conn = sqlite3.connect(str(db_path))
    cursor = conn.cursor()

    try:
        # Create/update schema
        create_hermes_db_schema(cursor)

        # Clear existing data
        cursor.execute("DELETE FROM hermes_state")
        print("🧹 Cleared existing data")

        # Insert API keys from backup
        inserted_count = 0
        for key_data in api_keys_data:
            agent_id = key_data['agent_id']
            company_id = key_data['company_id']
            api_key_plaintext = key_data['api_key']
            name = key_data.get('name', 'default')

            # Generate a display name (we'll need to get this from agents table)
            agent_name = f"Agent-{agent_id[:8]}"

            cursor.execute('''
                INSERT INTO hermes_state (agent_id, agent_name, company_id, api_key, key_plaintext)
                VALUES (?, ?, ?, ?, ?)
            ''', (agent_id, agent_name, company_id, api_key_plaintext, api_key_plaintext))

            inserted_count += 1

            if inserted_count % 50 == 0:
                print(f"📝 Synced {inserted_count}/{len(api_keys_data)} keys...")

        conn.commit()
        print(f"✅ Successfully synced {inserted_count} API keys to local database")

        # Verify the sync
        cursor.execute("SELECT COUNT(*) FROM hermes_state")
        count = cursor.fetchone()[0]
        print(f"🔍 Verification: {count} keys in local database")

        # Show a sample
        cursor.execute("SELECT agent_id, agent_name, substr(key_plaintext, 1, 15) || '...' as key_preview FROM hermes_state LIMIT 3")
        samples = cursor.fetchall()
        print("📋 Sample entries:")
        for sample in samples:
            print(f"   {sample[1]} ({sample[0][:8]}...): {sample[2]}")

    except Exception as e:
        print(f"❌ Error during sync: {e}")
        conn.rollback()
        return False
    finally:
        conn.close()

    return True

def main():
    """Main function."""
    print("🔄 Syncing API keys from Supabase backup to local SQLite database")
    print("⚠️  This will store plain-text API keys locally for remote device access")
    print()

    # Find backup file
    backup_file = get_backup_file()
    if not backup_file:
        print("❌ No backup file found. Please run backup_supabase.py first.")
        return

    # Confirm with user
    response = input("Are you sure you want to sync plain-text API keys to local database? (type 'yes' to confirm): ")
    if response.lower() != 'yes':
        print("Operation cancelled.")
        return

    # Perform sync
    if sync_api_keys_from_backup(backup_file):
        print("\n🎉 SUCCESS!")
        print("✅ All API keys have been synced to the local SQLite database")
        print("📍 Database location: hermes_agent/hermes_agent.db")
        print("🔑 Keys are stored in plain text for remote device access")
        print("\n🚀 Your remote device can now access all agent API keys!")
    else:
        print("\n❌ Sync failed. Please check the error messages above.")

if __name__ == '__main__':
    main()