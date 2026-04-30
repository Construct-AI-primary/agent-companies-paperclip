#!/usr/bin/env python3
"""
Restore Skill Assignments

This script restores capability-based skill assignments to the empty agent_skill_assignments table.
It creates intelligent skill assignments for all 414 agents based on their roles and capabilities.
"""

import os
import sys
from typing import Dict, List, Any
import yaml
import re
from collections import defaultdict
import uuid

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

def get_all_agents(supabase: Client) -> List[Dict[str, Any]]:
    """Get all agents with their details."""
    print("📊 Gathering all agents...")

    response = supabase.table('agents').select('id,name,role,title,capabilities').eq('is_active', True).execute()

    agents = response.data if response.data else []
    print(f"Found {len(agents)} active agents")

    return agents

def determine_agent_capability(agent: Dict[str, Any], config: Dict[str, Any]) -> str:
    """Determine the primary capability for an agent based on their role/title/capabilities."""
    name = (agent.get('name') or '').lower()
    role = (agent.get('role') or '').lower()
    title = (agent.get('title') or '').lower()
    capabilities = (agent.get('capabilities') or '').lower()

    # Combine all text for pattern matching
    agent_text = f"{name} {role} {title} {capabilities}"

    # Define capability patterns based on agent attributes
    capability_patterns = {
        'strategic_planning': ['ceo', 'director', 'chief', 'strategic', 'planning', 'executive', 'leadership'],
        'code_architecture': ['architect', 'system', 'platform', 'infrastructure', 'technical', 'lead'],
        'code_generation': ['developer', 'engineer', 'programmer', 'software', 'backend', 'frontend', 'full.?stack'],
        'debugging_testing': ['qa', 'quality', 'test', 'debug', 'validation', 'automation'],
        'research_investigation': ['research', 'analyst', 'data', 'science', 'investigate'],
        'content_writing': ['writer', 'content', 'author', 'blog', 'article', 'documentation'],
        'project_management': ['manager', 'coordinator', 'project', 'scrum', 'agile'],
        'team_coordination': ['coordinator', 'facilitator', 'communication', 'collaboration'],
        'infrastructure_operations': ['devops', 'infrastructure', 'operations', 'deployment', 'cloud'],
        'security_compliance': ['security', 'compliance', 'audit', 'risk', 'protect'],
        'creative_design': ['design', 'creative', 'ui', 'ux', 'innovation'],
        'data_analysis': ['analyst', 'data', 'analytics', 'insights', 'reporting']
    }

    # Check for matches
    for capability, keywords in capability_patterns.items():
        if any(keyword in agent_text for keyword in keywords):
            return capability

    # Default to general
    return 'general'

def generate_skill_assignments_for_agent(agent: Dict[str, Any], config: Dict[str, Any]) -> List[Dict[str, Any]]:
    """Generate capability-based skill assignments for a single agent."""
    agent_id = agent['id']
    primary_capability = determine_agent_capability(agent, config)

    # Get company ID (default to DevForge AI)
    company_id = '09f438a3-4041-46f2-b3cc-96fc9446e666'  # DevForge AI

    assignments = []

    # Primary capability skill
    primary_skill_key = f"{primary_capability}-specialist"
    assignments.append({
        'id': str(uuid.uuid4()),
        'agent_id': agent_id,
        'company_id': company_id,
        'skill_key': primary_skill_key,
        'source': 'shared_skills',
        'created_at': 'NOW()'
    })

    # Add secondary capabilities based on agent complexity
    # For agents with complex roles, add additional capabilities
    if primary_capability in ['strategic_planning', 'code_architecture', 'research_investigation']:
        # Add project management for complex roles
        assignments.append({
            'id': str(uuid.uuid4()),
            'agent_id': agent_id,
            'company_id': company_id,
            'skill_key': 'project_management-contributor',
            'source': 'shared_skills',
            'created_at': 'NOW()'
        })

    # For technical roles, add debugging
    if primary_capability in ['code_generation', 'code_architecture']:
        assignments.append({
            'id': str(uuid.uuid4()),
            'agent_id': agent_id,
            'company_id': company_id,
            'skill_key': 'debugging_testing-contributor',
            'source': 'shared_skills',
            'created_at': 'NOW()'
        })

    return assignments

def create_capability_based_assignments(supabase: Client, config: Dict[str, Any]) -> List[Dict[str, Any]]:
    """Create capability-based skill assignments for all agents."""
    print("🎯 Creating capability-based skill assignments for all agents...")

    agents = get_all_agents(supabase)
    all_assignments = []
    capability_summary = defaultdict(int)

    for agent in agents:
        agent_assignments = generate_skill_assignments_for_agent(agent, config)
        all_assignments.extend(agent_assignments)

        # Track primary capability
        if agent_assignments:
            primary_skill = agent_assignments[0]['skill_key']
            if '-specialist' in primary_skill:
                capability = primary_skill.replace('-specialist', '')
                capability_summary[capability] += 1

        print(f"  {agent['name']}: {len(agent_assignments)} skill assignments")

    print(f"\nGenerated {len(all_assignments)} total skill assignments")
    print(f"Capability distribution: {dict(capability_summary)}")

    return all_assignments

def insert_skill_assignments(supabase: Client, assignments: List[Dict[str, Any]]) -> bool:
    """Insert the skill assignments into the database."""
    print("🔄 Inserting skill assignments into database...")

    try:
        # Insert in batches to avoid payload size limits
        batch_size = 100
        for i in range(0, len(assignments), batch_size):
            batch = assignments[i:i + batch_size]
            response = supabase.table('agent_skill_assignments').insert(batch).execute()
            print(f"  Inserted batch {i//batch_size + 1}: {len(batch)} assignments")

        print(f"✅ Successfully inserted {len(assignments)} skill assignments")
        return True

    except Exception as e:
        print(f"❌ Error inserting assignments: {e}")
        return False

def validate_assignments(supabase: Client, expected_count: int) -> bool:
    """Validate that assignments were inserted correctly."""
    print("✅ Validating skill assignments...")

    response = supabase.table('agent_skill_assignments').select('id').execute()
    actual_count = len(response.data) if response.data else 0

    print(f"Expected: {expected_count} assignments")
    print(f"Actual: {actual_count} assignments")

    if actual_count == expected_count:
        print("✅ Validation successful!")
        return True
    else:
        print("❌ Validation failed!")
        return False

def display_summary(supabase: Client):
    """Display a summary of the restored skill assignments."""
    print("\n" + "=" * 80)
    print("🎯 SKILL ASSIGNMENTS RESTORATION SUMMARY")
    print("=" * 80)

    # Get assignment counts by capability
    response = supabase.table('agent_skill_assignments').select('skill_key').execute()

    capability_counts = defaultdict(int)
    for assignment in response.data or []:
        skill_key = assignment['skill_key']
        if '-specialist' in skill_key:
            capability = skill_key.replace('-specialist', '')
            capability_counts[capability] += 1

    print("📊 Capability Distribution:")
    for capability, count in sorted(capability_counts.items(), key=lambda x: x[1], reverse=True):
        print(f"  • {capability}: {count} agents")

    print(f"\n✅ Total skill assignments restored: {len(response.data) if response.data else 0}")
    print("✅ All agents now have capability-based skill assignments")
def main():
    """Main skill assignment restoration."""
    print("🚀 Restoring Capability-Based Skill Assignments")
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

    # Generate assignments
    assignments = create_capability_based_assignments(supabase, config)

    if not assignments:
        print("❌ No assignments generated")
        sys.exit(1)

    # Insert assignments
    if insert_skill_assignments(supabase, assignments):
        # Validate
        if validate_assignments(supabase, len(assignments)):
            # Display summary
            display_summary(supabase)
            print("\n🎉 SUCCESS: Skill assignments restored!")
            print("All 414 agents now have intelligent, capability-based skill assignments.")
        else:
            print("❌ Validation failed")
            sys.exit(1)
    else:
        print("❌ Insertion failed")
        sys.exit(1)

if __name__ == "__main__":
    main()