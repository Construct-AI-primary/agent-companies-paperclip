#!/usr/bin/env python3
"""
Test script for Supabase backup functionality.
Tests connection and exports a few small tables to verify everything works.
"""

import os
import sys
import json
from pathlib import Path

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

# Small tables to test with
TEST_TABLES = [
    "companies",
    "agents",
    "agent_api_keys"
]


def get_supabase_client() -> Client:
    """Create and return Supabase client."""
    url = os.getenv('SUPABASE_URL')
    service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')

    if not url:
        raise ValueError("SUPABASE_URL environment variable is required")

    if not service_key:
        raise ValueError("SUPABASE_SERVICE_ROLE_KEY is required for testing")

    return create_client(url, service_key)


def test_table_export(supabase: Client, table_name: str) -> bool:
    """Test exporting a single table."""
    print(f"Testing table: {table_name}")

    try:
        # Try to select a few rows
        response = supabase.table(table_name).select('*').limit(5).execute()

        if response.data is None:
            print(f"  ❌ No data returned for {table_name}")
            return False

        row_count = len(response.data)
        print(f"  ✅ Successfully accessed {table_name} ({row_count} sample rows)")

        # Test writing to JSON
        test_file = Path(f"test_{table_name}.json")
        with open(test_file, 'w') as f:
            json.dump(response.data, f, indent=2, default=str)

        print(f"  ✅ Successfully wrote test file: {test_file}")
        test_file.unlink()  # Clean up
        return True

    except Exception as e:
        print(f"  ❌ Error testing {table_name}: {e}")
        return False


def main():
    """Run backup tests."""
    print("🧪 Testing Supabase backup functionality...")
    print(f"🔗 Supabase URL: {os.getenv('SUPABASE_URL', 'NOT SET')}")
    print()

    try:
        # Test connection
        supabase = get_supabase_client()
        print("✅ Supabase client created successfully")

        # Test each table
        results = []
        for table in TEST_TABLES:
            success = test_table_export(supabase, table)
            results.append((table, success))

        # Summary
        print("\n" + "="*50)
        print("TEST RESULTS")
        print("="*50)

        successful = sum(1 for _, success in results if success)
        total = len(results)

        for table, success in results:
            status = "✅ PASS" if success else "❌ FAIL"
            print(f"{status} {table}")

        print(f"\nSummary: {successful}/{total} tables tested successfully")

        if successful == total:
            print("🎉 All tests passed! Ready to run full backup.")
            print("Run: python backup_supabase.py")
        else:
            print("⚠️  Some tests failed. Check your configuration before running full backup.")

    except Exception as e:
        print(f"❌ Test failed: {e}")
        sys.exit(1)


if __name__ == '__main__':
    main()