#!/usr/bin/env python3
"""
Fix agent webhook URLs from /webhook to /webhooks/paperclip.
The Hermes webhook adapter listens on /webhooks/{route_name}, not /webhook.
"""

import os
import json
from pathlib import Path
from supabase import create_client
from dotenv import load_dotenv

ROUTE_NAME = "paperclip"

def fix_webhook_urls():
    """Update all agent webhook URLs to use correct path format."""
    load_dotenv()

    supabase = create_client(
        os.getenv('SUPABASE_URL'),
        os.getenv('SUPABASE_SERVICE_ROLE_KEY')
    )

    # Get all HTTP agents
    result = supabase.table('agents').select('id', 'name', 'adapter_type', 'adapter_config').eq('adapter_type', 'http').execute()
    
    if not result.data:
        print("No HTTP agents found.")
        return

    agents = result.data
    print(f"📊 Found {len(agents)} HTTP agents to fix")
    print()

    # Confirm (skip if --batch flag)
    import sys
    if '--batch' not in sys.argv:
        response = input(f"Fix webhook URLs for {len(agents)} agents? (yes/no): ")
        if response.lower() != 'yes':
            print("Operation cancelled.")
            return

    fixed_count = 0
    error_count = 0
    skipped_count = 0

    for agent in agents:
        agent_id = agent['id']
        agent_name = agent['name']
        config = agent.get('adapter_config', {})
        url = config.get('url', '')

        if not url:
            print(f"⚠️  Skipped: {agent_name} (no URL)")
            skipped_count += 1
            continue

        # Fix the URL: replace /webhook with /webhooks/paperclip
        if '/webhook' in url:
            new_url = url.replace('/webhook', f'/webhooks/{ROUTE_NAME}')
        else:
            # If URL doesn't contain /webhook, append the path
            if url.endswith('/'):
                new_url = f"{url}webhooks/{ROUTE_NAME}"
            else:
                new_url = f"{url}/webhooks/{ROUTE_NAME}"

        config['url'] = new_url

        try:
            result = supabase.table('agents').update({
                'adapter_config': config
            }).eq('id', agent_id).execute()

            if result.data:
                print(f"✅ Fixed: {agent_name}")
                print(f"   Old: {url}")
                print(f"   New: {new_url}")
                fixed_count += 1
            else:
                print(f"❌ No data returned for: {agent_name}")
                error_count += 1

        except Exception as e:
            print(f"❌ Error fixing {agent_name}: {e}")
            error_count += 1

        total_processed = fixed_count + error_count + skipped_count
        if total_processed % 25 == 0 and total_processed > 0:
            print(f"📝 Progress: {total_processed}/{len(agents)} agents processed")
            print()

    print()
    print("🎉 URL FIX COMPLETE!")
    print(f"✅ Successfully fixed: {fixed_count} agents")
    print(f"❌ Errors: {error_count} agents")
    print(f"⚠️  Skipped: {skipped_count} agents")
    print()
    print("🔄 Next steps:")
    print("1. Configure webhook platform in Hermes (~/.hermes/config.yaml)")
    print("2. Restart Hermes gateway")
    print("3. Test agent execution")

if __name__ == '__main__':
    fix_webhook_urls()