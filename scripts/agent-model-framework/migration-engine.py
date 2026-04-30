#!/usr/bin/env python3
"""
Migration Engine for Intelligent Model Assignment Framework

This script migrates existing model assignments to the new intelligent framework:
1. Updates temperatures for coding agents to 0.3
2. Replaces deepseek-r1 assignments with GLM-4-Plus
3. Replaces claude-3.5-sonnet assignments with GLM-5.1
4. Applies company-specific overrides
"""

import os
import sys
from typing import Dict, List, Any
import yaml

try:
    from supabase import create_client, Client
except ImportError:
    print("Error: supabase-py not installed. Install with: pip install supabase")
    sys.exit(1)

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

def get_supabase_client() -> Client:
    """Create and return Supabase client with service role access."""
    url = os.getenv('SUPABASE_URL')
    service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')

    if not url:
        raise ValueError("SUPABASE_URL environment variable is required")

    if not service_key:
        raise ValueError("SUPABASE_SERVICE_ROLE_KEY is REQUIRED")

    return create_client(url, service_key)

def load_mapping_config() -> Dict[str, Any]:
    """Load the skill-capability mapping configuration."""
    config_path = os.path.join(os.path.dirname(__file__), 'skill-capability-mapping.yaml')
    with open(config_path, 'r') as f:
        return yaml.safe_load(f)

def identify_coding_agents(supabase: Client) -> List[str]:
    """Identify agents that are coding-focused based on their roles and titles."""
    # Get agents with coding-related roles/titles
    coding_keywords = [
        'code', 'developer', 'engineer', 'programmer', 'software',
        'backend', 'frontend', 'architect', 'tech', 'dev'
    ]

    response = supabase.table('agents').select('id,name,role,title,capabilities').eq('is_active', True).execute()

    coding_agent_ids = []
    for agent in response.data:
        name = agent['name'].lower()
        role = (agent.get('role') or '').lower()
        title = (agent.get('title') or '').lower()
        capabilities = (agent.get('capabilities') or '').lower()

        # Check if any coding keywords appear in name, role, title, or capabilities
        text_to_check = f"{name} {role} {title} {capabilities}"
        if any(keyword in text_to_check for keyword in coding_keywords):
            coding_agent_ids.append(agent['id'])

    return coding_agent_ids

def update_coding_agent_temperatures(supabase: Client, coding_agent_ids: List[str]) -> int:
    """Update temperature to 0.3 for coding agents currently using higher temperatures."""
    print(f"Updating temperatures for {len(coding_agent_ids)} coding agents...")

    # Update agent_models where agent_id is in coding list and temperature > 0.3
    updates = supabase.table('agent_models').update({
        'temperature': 0.3,
        'updated_at': 'NOW()'
    }).in_('agent_id', coding_agent_ids).gt('temperature', 0.3).eq('is_active', True).execute()

    updated_count = len(updates.data) if updates.data else 0
    print(f"Updated temperature for {updated_count} coding agent model assignments")
    return updated_count

def migrate_deepseek_r1_to_glm5(supabase: Client) -> int:
    """Replace deepseek-r1 assignments with GLM-5.1."""
    print("Migrating deepseek-r1 assignments to GLM-5.1...")

    # Update all active deepseek-r1 assignments to GLM-5.1
    updates = supabase.table('agent_models').update({
        'model_id': 'GLM-5.1',
        'updated_at': 'NOW()'
    }).eq('model_id', 'deepseek/deepseek-r1').eq('is_active', True).execute()

    updated_count = len(updates.data) if updates.data else 0
    print(f"Migrated {updated_count} deepseek-r1 assignments to GLM-5.1")
    return updated_count

def migrate_haiku_to_glm3_turbo(supabase: Client) -> int:
    """Replace claude-3-haiku assignments with GLM-3-Turbo (Chinese equivalent)."""
    print("Migrating claude-3-haiku assignments to GLM-3-Turbo...")

    # Update all active claude-3-haiku assignments to GLM-3-Turbo
    updates = supabase.table('agent_models').update({
        'model_id': 'GLM-3-Turbo',
        'updated_at': 'NOW()'
    }).eq('model_id', 'anthropic/claude-3-haiku').eq('is_active', True).execute()

    updated_count = len(updates.data) if updates.data else 0
    print(f"Migrated {updated_count} claude-3-haiku assignments to GLM-3-Turbo")
    return updated_count

def migrate_sonnet_to_glm5(supabase: Client) -> int:
    """Replace claude-3.5-sonnet assignments with GLM-5.1."""
    print("Migrating claude-3.5-sonnet assignments to GLM-5.1...")

    # Update all active claude-3.5-sonnet assignments to GLM-5.1
    updates = supabase.table('agent_models').update({
        'model_id': 'GLM-5.1',
        'updated_at': 'NOW()'
    }).eq('model_id', 'anthropic/claude-3.5-sonnet').eq('is_active', True).execute()

    updated_count = len(updates.data) if updates.data else 0
    print(f"Migrated {updated_count} claude-3.5-sonnet assignments to GLM-5.1")
    return updated_count

def apply_company_overrides(supabase: Client, config: Dict[str, Any]) -> Dict[str, int]:
    """Apply company-specific temperature overrides."""
    print("Applying company-specific overrides...")

    overrides = config.get('company_overrides', {})
    results = {}

    for company_slug, settings in overrides.items():
        print(f"Applying overrides for {company_slug}...")

        # Get company ID
        company_response = supabase.table('companies').select('id').eq('name', company_slug.replace('-', ' ').title()).execute()

        if not company_response.data:
            print(f"  Company {company_slug} not found, skipping...")
            continue

        company_id = company_response.data[0]['id']

        # Apply temperature adjustments
        if 'temperature_reduction' in settings:
            reduction = settings['temperature_reduction']
            print(f"  Reducing temperature by {reduction} for {company_slug} agents")

            # Update temperatures for this company's agents
            updates = supabase.table('agent_models').update({
                'temperature': supabase.raw('GREATEST(0.1, temperature - ?)', [reduction]),
                'updated_at': 'NOW()'
            }).eq('company_id', company_id).eq('is_active', True).execute()

            results[f"{company_slug}_temp"] = len(updates.data) if updates.data else 0

        if 'temperature_increase' in settings:
            increase = settings['temperature_increase']
            print(f"  Increasing temperature by {increase} for {company_slug} agents")

            updates = supabase.table('agent_models').update({
                'temperature': supabase.raw('LEAST(1.0, temperature + ?)', [increase]),
                'updated_at': 'NOW()'
            }).eq('company_id', company_id).eq('is_active', True).execute()

            results[f"{company_slug}_temp"] = len(updates.data) if updates.data else 0

    return results

def validate_migration(supabase: Client) -> Dict[str, Any]:
    """Validate the migration results."""
    print("Validating migration results...")

    # Check for remaining high temperatures on coding agents
    coding_agents = identify_coding_agents(supabase)

    if coding_agents:
        high_temp_response = supabase.table('agent_models').select('id').in_('agent_id', coding_agents).gt('temperature', 0.3).eq('is_active', True).execute()
        high_temp_count = len(high_temp_response.data) if high_temp_response.data else 0
    else:
        high_temp_count = 0

    # Check for remaining deepseek-r1 assignments
    deepseek_response = supabase.table('agent_models').select('id').eq('model_id', 'deepseek/deepseek-r1').eq('is_active', True).execute()
    deepseek_count = len(deepseek_response.data) if deepseek_response.data else 0

    # Get current model distribution
    model_dist_response = supabase.table('agent_models').select('model_id').eq('is_active', True).execute()

    model_counts = {}
    if model_dist_response.data:
        for record in model_dist_response.data:
            model_id = record['model_id']
            model_counts[model_id] = model_counts.get(model_id, 0) + 1

    return {
        'coding_agents_high_temp': high_temp_count,
        'remaining_deepseek_r1': deepseek_count,
        'model_distribution': model_counts
    }

def main():
    """Main migration execution."""
    print("🚀 Starting Intelligent Model Assignment Migration")
    print("=" * 60)

    # Load configuration
    try:
        config = load_mapping_config()
        print("✅ Loaded mapping configuration")
    except Exception as e:
        print(f"❌ Failed to load configuration: {e}")
        sys.exit(1)

    # Connect to Supabase
    try:
        supabase = get_supabase_client()
        print("✅ Connected to Supabase")
    except Exception as e:
        print(f"❌ Failed to connect to Supabase: {e}")
        sys.exit(1)

    # Step 1: Identify coding agents
    print("\n📊 Step 1: Identifying coding agents...")
    coding_agent_ids = identify_coding_agents(supabase)
    print(f"Found {len(coding_agent_ids)} coding agents")

    # Step 2: Update coding agent temperatures
    print("\n🌡️ Step 2: Updating coding agent temperatures...")
    temp_updates = update_coding_agent_temperatures(supabase, coding_agent_ids)

    # Step 3: Migrate deepseek-r1 to GLM-5.1
    print("\n🔄 Step 3: Migrating deepseek-r1 to GLM-5.1...")
    model_updates_r1 = migrate_deepseek_r1_to_glm5(supabase)

    # Step 4: Migrate claude-3-haiku to GLM-3-Turbo
    print("\n🔄 Step 4: Migrating claude-3-haiku to GLM-3-Turbo...")
    model_updates_haiku = migrate_haiku_to_glm3_turbo(supabase)

    # Step 5: Apply company overrides
    print("\n🏢 Step 5: Applying company-specific overrides...")
    override_results = apply_company_overrides(supabase, config)

    # Step 5: Validate results
    print("\n✅ Step 5: Validating migration...")
    validation = validate_migration(supabase)

    # Summary
    print("\n" + "=" * 60)
    print("🎉 MIGRATION COMPLETE")
    print("=" * 60)
    print(f"Temperature updates: {temp_updates}")
    print(f"deepseek-r1 → GLM-5.1 migrations: {model_updates_r1}")
    print(f"claude-3-haiku → GLM-3-Turbo migrations: {model_updates_haiku}")
    print(f"Total model migrations: {model_updates_r1 + model_updates_haiku}")
    print(f"Company overrides: {sum(override_results.values())}")
    print(f"Remaining high-temp coding agents: {validation['coding_agents_high_temp']}")
    print(f"Remaining deepseek-r1 assignments: {validation['remaining_deepseek_r1']}")

    print("\n📈 New Model Distribution:")
    for model, count in sorted(validation['model_distribution'].items(), key=lambda x: x[1], reverse=True):
        print(f"  {model}: {count} assignments")

    if validation['coding_agents_high_temp'] == 0 and validation['remaining_deepseek_r1'] == 0:
        print("\n✅ Migration successful! All targets achieved.")
    else:
        print(f"\n⚠️ Migration completed with {validation['coding_agents_high_temp'] + validation['remaining_deepseek_r1']} remaining issues.")

if __name__ == "__main__":
    main()