#!/usr/bin/env python3
"""
Execute Reconciliation SQL Fixes
================================
Executes the generated SQL fixes against Supabase.
This script reads the reconciliation_fixes.sql file and executes it.
"""

import os
import sys
import json
import requests
from typing import List, Dict, Any

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass


def get_supabase_headers() -> Dict[str, str]:
    """Get Supabase headers for API requests."""
    service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')
    if not service_key:
        raise ValueError("SUPABASE_SERVICE_ROLE_KEY is required")
    
    return {
        'Authorization': f'Bearer {service_key}',
        'apikey': service_key,
        'Content-Type': 'application/json',
        'Prefer': 'return=minimal'
    }


def execute_sql_via_rest(url: str, headers: Dict[str, str], sql: str) -> Dict[str, Any]:
    """Execute SQL via Supabase REST API using pg_execute."""
    response = requests.post(
        f"{url}/rest/v1/rpc/pg_execute",
        headers=headers,
        json={'sql': sql}
    )
    return {'status': response.status_code, 'body': response.text}


def execute_sql_via_postgrest(url: str, headers: Dict[str, str], sql: str) -> Dict[str, Any]:
    """Execute SQL via PostgREST with raw SQL."""
    # Try direct SQL execution via REST
    response = requests.post(
        f"{url}/rest/v1/",
        headers={**headers, 'Content-Type': 'text/plain'},
        data=sql
    )
    return {'status': response.status_code, 'body': response.text[:500]}


def main():
    """Main execution function."""
    print("=" * 80)
    print("EXECUTING RECONCILIATION SQL FIXES")
    print("=" * 80)
    
    url = os.getenv('SUPABASE_URL')
    if not url:
        raise ValueError("SUPABASE_URL is required")
    
    headers = get_supabase_headers()
    
    # Read the SQL file
    sql_file = "reconciliation_fixes.sql"
    try:
        with open(sql_file, 'r') as f:
            sql_content = f.read()
    except FileNotFoundError:
        print(f"❌ SQL file not found: {sql_file}")
        print("   Run reconciliation_agent.py first to generate the SQL fixes.")
        sys.exit(1)
    
    # Split into individual statements
    statements = []
    current_statement = []
    in_comment = False
    
    for line in sql_content.split('\n'):
        stripped = line.strip()
        
        # Skip comments and empty lines for statement building
        if stripped.startswith('--'):
            continue
        if not stripped:
            if current_statement:
                statements.append('\n'.join(current_statement))
                current_statement = []
            continue
        
        current_statement.append(line)
    
    if current_statement:
        statements.append('\n'.join(current_statement))
    
    # Filter out empty statements
    statements = [s.strip() for s in statements if s.strip()]
    
    print(f"\n📋 Found {len(statements)} SQL statements to execute")
    print("\n⚠️  WARNING: This will modify your database!")
    print("   The following operations will be performed:")
    print("   - INSERT new agents from filesystem")
    print("   - INSERT API keys for agents without them")
    print("   - INSERT model assignments for agents without them")
    print("   - UPDATE invalid agent names (>= 23 chars)")
    print()
    
    response = input("Do you want to proceed? (type 'yes' to confirm): ")
    if response.lower() != 'yes':
        print("Operation cancelled.")
        sys.exit(0)
    
    print("\n🔄 Executing SQL statements...")
    
    success_count = 0
    error_count = 0
    errors = []
    
    for i, statement in enumerate(statements, 1):
        if i % 50 == 0:
            print(f"  Progress: {i}/{len(statements)} statements executed...")
        
        try:
            result = execute_sql_via_rest(url, headers, statement)
            if result['status'] in [200, 201, 204]:
                success_count += 1
            else:
                # Check if it's a "not found" error for the RPC
                if 'not found' in result['body'].lower() or 'does not exist' in result['body'].lower():
                    # RPC doesn't exist, try alternative approach
                    print(f"\n⚠️  RPC pg_execute not available")
                    print("   Please run the SQL manually in Supabase SQL Editor or via psql")
                    print(f"\n   SQL file location: {os.path.abspath(sql_file)}")
                    print("\n   Alternative: Use the Supabase dashboard SQL Editor")
                    break
                else:
                    error_count += 1
                    if len(errors) < 10:
                        errors.append(f"Statement {i}: {result['body'][:100]}")
        except Exception as e:
            error_count += 1
            if len(errors) < 10:
                errors.append(f"Statement {i}: {str(e)[:100]}")
    
    print("\n" + "=" * 80)
    print("EXECUTION SUMMARY")
    print("=" * 80)
    print(f"  ✅ Successful: {success_count}")
    print(f"  ❌ Errors: {error_count}")
    
    if errors:
        print("\n⚠️  First few errors:")
        for error in errors:
            print(f"  - {error}")
    
    if error_count == 0 and success_count > 0:
        print("\n🎉 All SQL statements executed successfully!")
    elif success_count > 0:
        print(f"\n⚠️  {success_count} statements executed, {error_count} failed")
        print("   Please review the errors and run remaining statements manually")
    else:
        print("\n❌ No statements could be executed")
        print("   Please run the SQL manually in Supabase SQL Editor")
        print(f"\n   SQL file location: {os.path.abspath(sql_file)}")


if __name__ == '__main__':
    main()
