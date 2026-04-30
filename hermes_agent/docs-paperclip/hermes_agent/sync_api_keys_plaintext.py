#!/usr/bin/env python3
"""
Sync API keys from Supabase to local SQLite database with PLAIN-TEXT KEYS.

⚠️  SECURITY WARNING ⚠️
This script stores PLAIN-TEXT API keys in the local SQLite database.
This reduces security compared to hash-based validation but may be necessary
for remote devices that cannot perform hash-based authentication.

ONLY USE THIS ON TRUSTED DEVICES with proper access controls.

Usage:
    python sync_api_keys_plaintext.py

Environment Variables:
    SUPABASE_URL: Your Supabase project URL
    SUPABASE_SERVICE_ROLE_KEY: Your Supabase service role key (REQUIRED for plain-text access)
    PAPERCLIP_API_KEY: A Paperclip API key to retrieve plain-text keys via API

The script will use SUPABASE_SERVICE_ROLE_KEY to access plain-text keys.
"""

import os
import sys
import time
import hashlib
from datetime import datetime
from typing import Dict, List, Optional

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
    pass  # python-dotenv not available, rely on system env vars

from hermes_state import SessionDB


def get_supabase_client() -> Client:
    """Create and return Supabase client with service role access."""
    url = os.getenv('SUPABASE_URL')
    service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')

    if not url:
        raise ValueError("SUPABASE_URL environment variable is required")

    if not service_key:
        raise ValueError("SUPABASE_SERVICE_ROLE_KEY is REQUIRED for plain-text key access")

    return create_client(url, service_key)


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


def get_plaintext_key_via_api(key_id: str, paperclip_key: str) -> Optional[str]:
    """
    Retrieve plain-text API key via Paperclip API.

    This is the SECURE way to get plain-text keys - through the official API
    rather than storing them in the database.
    """
    # This would require implementing the Paperclip API call
    # For now, return None to indicate this method isn't implemented
    print(f"Warning: Plain-text key retrieval via API not implemented for key {key_id}")
    return None


def hash_key_sha256(key: str) -> str:
    """Hash a key using SHA256 (same as Paperclip)."""
    return hashlib.sha256(key.encode('utf-8')).hexdigest()


def sync_api_keys_plaintext(db: SessionDB, supabase: Client, paperclip_key: Optional[str] = None) -> Dict[str, int]:
    """
    Sync API keys from Supabase to local database WITH PLAIN-TEXT STORAGE.

    ⚠️  SECURITY WARNING: This stores plain-text keys locally!

    Returns a dict with sync statistics.
    """
    print("⚠️  SECURITY WARNING: Syncing PLAIN-TEXT API keys to local database!")
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
                key_id = key_data['id']

                # Try to get plain-text key
                plaintext_key = None

                # Method 1: Via Paperclip API (secure)
                if paperclip_key:
                    plaintext_key = get_plaintext_key_via_api(key_id, paperclip_key)

                # Method 2: If we have service role access, we might be able to retrieve
                # plain-text keys from a secure storage (not implemented in this example)

                # For demonstration - in a real implementation, you'd need a way
                # to retrieve the plain-text keys securely
                if not plaintext_key:
                    print(f"Warning: Cannot retrieve plain-text key for {key_id}, skipping")
                    skipped += 1
                    continue

                # Transform Supabase data to our format with plain-text key
                sync_data = {
                    'id': key_data['id'],
                    'agent_id': key_data['agent_id'],
                    'company_id': key_data['company_id'],
                    'name': key_data['name'],
                    'key_plaintext': key_data['api_key'],  # Use the actual API key from database
                    'key_hash': hash_key_sha256(key_data['api_key']),  # Also store hash for compatibility
                    'created_at': parse_timestamp(key_data['created_at']),
                    'last_used_at': parse_timestamp(key_data['last_used_at']),
                    'revoked_at': parse_timestamp(key_data['revoked_at']),
                }

                # Validate required fields
                if not all([sync_data['id'], sync_data['agent_id'], sync_data['company_id'],
                           sync_data['name'], sync_data['key_plaintext'], sync_data['created_at']]):
                    print(f"Warning: Skipping incomplete key data: {key_id}")
                    skipped += 1
                    continue

                # Sync to local database with plain-text key
                db.sync_api_key_plaintext_from_supabase(**sync_data)
                synced += 1

                if synced % 5 == 0:
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
    print("🔐 Starting PLAIN-TEXT API key synchronization...")
    print("⚠️  SECURITY WARNING: This will store API keys in plain text locally!")
    print()

    # Confirm with user
    if '--yes' not in sys.argv:
        response = input("Are you sure you want to continue? (type 'yes' to confirm): ")
        if response.lower() != 'yes':
            print("Operation cancelled.")
            sys.exit(0)

    try:
        # Get Paperclip API key for retrieving plain-text keys
        paperclip_key = os.getenv('PAPERCLIP_API_KEY')

        # Initialize databases
        db = SessionDB()
        supabase = get_supabase_client()

        # Perform sync
        stats = sync_api_keys_plaintext(db, supabase, paperclip_key)

        # Print results
        print("\n" + "="*60)
        print("PLAIN-TEXT KEY SYNC COMPLETE")
        print("="*60)
        print(f"Total keys in Supabase: {stats['total']}")
        print(f"Successfully synced: {stats['synced']}")
        print(f"Skipped (cannot retrieve plain-text): {stats['skipped']}")
        print(f"Errors: {stats['errors']}")
        print("="*60)

        if stats['synced'] > 0:
            print("⚠️  WARNING: Plain-text API keys are now stored locally!")
            print("   Ensure this device has proper security measures.")

        if stats['errors'] > 0:
            print(f"❌ Warning: {stats['errors']} keys had sync errors")
            sys.exit(1)

        print("✅ Plain-text API key synchronization completed!")

    except Exception as e:
        print(f"❌ Error during synchronization: {e}")
        sys.exit(1)

    finally:
        if 'db' in locals():
            db.close()


if __name__ == '__main__':
    main()