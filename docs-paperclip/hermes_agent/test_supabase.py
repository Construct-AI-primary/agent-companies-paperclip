#!/usr/bin/env python3
import os
from dotenv import load_dotenv
load_dotenv()

print("Testing Supabase connection...")

# Test with service role key first
print("\n1. Testing with SERVICE ROLE key:")
try:
    from supabase import create_client
    supabase = create_client(os.getenv('SUPABASE_URL'), os.getenv('SUPABASE_SERVICE_ROLE_KEY'))
    response = supabase.table('agent_api_keys').select('*').limit(1).execute()
    print("✓ Service role connection successful!")
    print(f"Found data: {len(response.data)} records")

except Exception as e:
    print(f"✗ Service role failed: {e}")

# Test with anon key
print("\n2. Testing with ANON key:")
try:
    supabase = create_client(os.getenv('SUPABASE_URL'), os.getenv('SUPABASE_ANON_KEY'))
    response = supabase.table('agent_api_keys').select('*').limit(1).execute()
    print("✓ Anon key connection successful!")
    print(f"Found data: {len(response.data)} records")

except Exception as e:
    print(f"✗ Anon key failed: {e}")

print("\nDone.")
