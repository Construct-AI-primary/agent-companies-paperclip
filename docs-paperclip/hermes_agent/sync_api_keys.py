#!/usr/bin/env python3
"""
Sync API keys from Supabase to local SQLite database for Paperclip integration.

This script performs one-way synchronization of API key data from Supabase
to the local Hermes SQLite database. It should be run periodically to keep
the local database in sync with the authoritative Supabase source.

Usage:
    python sync_api_keys.py

Environment Variables:
    SUPABASE_URL: Your Supabase project URL
    SUPABASE_ANON_KEY: Your Supabase anon/public key
    SUPABASE_SERVICE_ROLE_KEY: Your Supabase service role key (for full access)

The script will use SUPABASE_SERVICE_ROLE_KEY if available, otherwise SUPABASE_ANON_KEY.
"""

import os
import sys
import time
from datetime import datetime
from typing import Dict, List, Optional

try:
    from supabase import create_client, Client
except ImportError:
    print("Error: supabase-py not installed. Install with: pip install supabase")
    print("Or add to requirements.txt: supabase")
    sys.exit(1)

# Load environment variables from .env file
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass  # python-dotenv not available, rely on system env vars

from hermes_state import SessionDB


def get_supabase_client() -> Client:
    """Create and return Supabase client."""
    url = os.getenv('SUPABASE_URL')
    anon_key = os.getenv('SUPABASE_ANON_KEY')
    service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')

    if not url:
        raise ValueError("SUPABASE_URL environment variable is required")

    # Use service role key if available (full access), otherwise anon key
    key = service_key or anon_key
    if not key:
        raise ValueError("Either SUPABASE_ANON_KEY or SUPABASE_SERVICE_ROLE_KEY is required")

    return create_client(url, key)


def parse_timestamp(ts_str: Optional[str]) -> Optional[float]:
    """Convert PostgreSQL timestamp string to Unix timestamp."""
    if not ts_str:
        return None

    try:
        # Parse ISO format timestamp (e.g., "2024-01-01T12:00:00Z")
        dt = datetime.fromisoformat(ts_str.replace('Z', '+00:00'))
        return dt.timestamp()
    except (ValueError, AttributeError):
        print(f"Warning: Could not parse timestamp '{ts_str}', using None")
        return None


def sync_api_keys_from_supabase(db: SessionDB, supabase: Client) -> Dict[str, int]:
    """Sync all API keys from Supabase to local database.

    Returns a dict with sync statistics.
    """
    print("Fetching API keys from Supabase...")

    try:
        # Query all API keys from Supabase
        response = supabase.table('agent_api_keys').select('*').execute()
        supabase_keys = response.data

        print(f"Found {len(supabase_keys)} API keys in Supabase")

        synced = 0
        skipped = 0
        errors = 0

        for key_data in supabase_keys:
            try:
                # Transform Supabase data to our format
                sync_data = {
                    'id': key_data['id'],
                    'agent_id': key_data['agent_id'],
                    'company_id': key_data['company_id'],
                    'name': key_data['name'],
                    'key_hash': key_data['api_key'],  # api_key column contains the actual key
                    'created_at': parse_timestamp(key_data['created_at']),
                    'last_used_at': parse_timestamp(key_data['last_used_at']),
                    'revoked_at': parse_timestamp(key_data['revoked_at']),
                }

                # Validate required fields
                if not all([sync_data['id'], sync_data['agent_id'], sync_data['company_id'],
                           sync_data['name'], sync_data['key_hash'], sync_data['created_at']]):
                    print(f"Warning: Skipping incomplete key data: {key_data.get('id', 'unknown')}")
                    skipped += 1
                    continue

                # Sync to local database
                db.sync_api_key_from_supabase(**sync_data)
                synced += 1

                if synced % 10 == 0:
                    print(f"Synced {synced} keys...")

            except Exception as e:
                print(f"Error syncing key {key_data.get('id', 'unknown')}: {e}")
                errors += 1

        return {
            'synced': synced,
            'skipped': skipped,
            'errors': errors,
            'total': len(supabase_keys)
        }

    except Exception as e:
        raise Exception(f"Failed to fetch data from Supabase: {e}")


def main():
    """Main sync function."""
    print("Starting API key synchronization from Supabase to local database...")

    try:
        # Initialize databases
        db = SessionDB()
        supabase = get_supabase_client()

        # Perform sync
        stats = sync_api_keys_from_supabase(db, supabase)

        # Print results
        print("\n" + "="*50)
        print("SYNC COMPLETE")
        print("="*50)
        print(f"Total keys in Supabase: {stats['total']}")
        print(f"Successfully synced: {stats['synced']}")
        print(f"Skipped (incomplete): {stats['skipped']}")
        print(f"Errors: {stats['errors']}")
        print("="*50)

        if stats['errors'] > 0:
            print(f"Warning: {stats['errors']} keys had sync errors")
            sys.exit(1)

        print("API key synchronization completed successfully!")

    except Exception as e:
        print(f"Error during synchronization: {e}")
        sys.exit(1)

    finally:
        if 'db' in locals():
            db.close()


if __name__ == '__main__':
    main()