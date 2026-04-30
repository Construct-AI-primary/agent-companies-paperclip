#!/usr/bin/env python3
"""
Query agent_models table to extract current model assignments
"""

import os
import sys
from typing import Dict, List, Any

try:
    from supabase import create_client, Client
except ImportError:
    print("Error: supabase-py not installed. Install with: pip install supabase")
    sys.exit(1)

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass  # python-dotenv not available, rely on system env vars

def get_supabase_client() -> Client:
    """Create and return Supabase client with service role access."""
    url = os.getenv('SUPABASE_URL')
    service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')

    if not url:
        raise ValueError("SUPABASE_URL environment variable is required")

    if not service_key:
        raise ValueError("SUPABASE_SERVICE_ROLE_KEY is REQUIRED")

    return create_client(url, service_key)

def query_agent_models():
    """Query and display current model assignments from agent_models table."""
    supabase = get_supabase_client()

    print("Querying agent_models table...")

    try:
        # Query to get current models being used
        response = supabase.table('agent_models').select('*').eq('is_active', True).execute()

        if not response.data:
            print("No active model assignments found.")
            return

        # Group by model_id and assignment_type
        model_stats = {}
        agent_assignments = {}

        for row in response.data:
            model_id = row['model_id']
            assignment_type = row['assignment_type']
            agent_id = row['agent_id']

            key = (model_id, assignment_type)
            if key not in model_stats:
                model_stats[key] = {
                    'count': 0,
                    'agents': set(),
                    'temperatures': [],
                    'max_tokens': []
                }

            model_stats[key]['count'] += 1
            model_stats[key]['agents'].add(agent_id)

            if row.get('temperature'):
                model_stats[key]['temperatures'].append(row['temperature'])
            if row.get('max_tokens'):
                model_stats[key]['max_tokens'].append(row['max_tokens'])

            # Track per agent
            if agent_id not in agent_assignments:
                agent_assignments[agent_id] = []
            agent_assignments[agent_id].append(row)

        # Get total agent count
        agents_response = supabase.table('agents').select('id,name').eq('is_active', True).execute()
        total_agents = len(agents_response.data) if agents_response.data else 0

        # Display results
        print("\nCurrent Models in agent_models table:")
        print("=" * 80)
        print("Model ID".ljust(40), "Type".ljust(12), "Count".ljust(8), "Agents".ljust(8), "Avg Temp".ljust(10), "Avg Tokens")
        print("=" * 80)

        for (model_id, assignment_type), stats in sorted(model_stats.items()):
            avg_temp = sum(stats['temperatures']) / len(stats['temperatures']) if stats['temperatures'] else None
            avg_tokens = sum(stats['max_tokens']) / len(stats['max_tokens']) if stats['max_tokens'] else None

            print(
                model_id.ljust(40),
                assignment_type.ljust(12),
                str(stats['count']).ljust(8),
                str(len(stats['agents'])).ljust(8),
                f"{avg_temp:.2f}" if avg_temp else "N/A".ljust(10),
                str(int(avg_tokens)) if avg_tokens else "N/A"
            )

        # Summary
        total_assignments = sum(stats['count'] for stats in model_stats.values())
        agents_with_models = len(agent_assignments)

        print("\nSummary:")
        print(f"Total agents with model assignments: {agents_with_models}")
        print(f"Total model assignments: {total_assignments}")
        print(f"Total active agents: {total_agents}")

        if agents_with_models != total_agents:
            print(f"\n⚠️  MISALIGNMENT DETECTED: {abs(agents_with_models - total_agents)} agents {'missing' if agents_with_models < total_agents else 'have extra'} model assignments!")

        # Show agents without models
        if agents_with_models < total_agents:
            agents_with_models_set = set(agent_assignments.keys())
            all_agent_names = {agent['name'] for agent in agents_response.data} if agents_response.data else set()

            agents_without_models = all_agent_names - agents_with_models_set
            if agents_without_models:
                print(f"\nAgents without model assignments ({len(agents_without_models)}):")
                for agent_name in sorted(agents_without_models):
                    print(f"  - {agent_name}")

    except Exception as e:
        print(f"Query failed: {e}")
        sys.exit(1)

def query_deepseek_r1_agents():
    """Query agents using deepseek-r1 and their roles/categories."""
    supabase = get_supabase_client()

    print("\nQuerying agents assigned to deepseek-r1...")

    try:
        # Get agents using deepseek-r1
        response = supabase.table('agent_models').select('agent_id').eq('model_id', 'deepseek/deepseek-r1').eq('is_active', True).execute()

        if not response.data:
            print("No agents found using deepseek-r1.")
            return

        agent_names = [row['agent_id'] for row in response.data]
        print(f"Found {len(agent_names)} agents using deepseek-r1: {agent_names[:5]}{'...' if len(agent_names) > 5 else ''}")

        # Get agent details - agent_id in agent_models references agents.id (UUID), not agents.name
        agents_response = supabase.table('agents').select('id,name,role,title,capabilities').in_('id', agent_names).execute()

        print(f"Agent details query returned {len(agents_response.data) if agents_response.data else 0} results")

        if not agents_response.data:
            print("No agent details found.")
            return

        # Categorize agents by their roles/titles
        categories = {
            'coding': [],
            'research': [],
            'writing': [],
            'analysis': [],
            'management': [],
            'specialized': [],
            'other': []
        }

        print(f"\nAgents using deepseek-r1 ({len(agents_response.data)} total):")
        print("=" * 100)
        print("Agent Name".ljust(30), "Role".ljust(15), "Title".ljust(30), "Category")
        print("=" * 100)

        for agent in agents_response.data:
            name = agent['name']
            role = agent['role'] or 'unknown'
            title = agent['title'] or ''
            capabilities = agent.get('capabilities', '')

            # Categorize based on role, title, and capabilities
            category = 'other'
            title_lower = title.lower()
            role_lower = role.lower()
            cap_lower = capabilities.lower() if capabilities else ''

            if any(keyword in title_lower or keyword in role_lower or keyword in cap_lower
                   for keyword in ['code', 'developer', 'engineer', 'programmer', 'software']):
                category = 'coding'
            elif any(keyword in title_lower or keyword in role_lower or keyword in cap_lower
                     for keyword in ['research', 'analyst', 'scientist', 'academic']):
                category = 'research'
            elif any(keyword in title_lower or keyword in role_lower or keyword in cap_lower
                     for keyword in ['writer', 'content', 'editor', 'author', 'documentation']):
                category = 'writing'
            elif any(keyword in title_lower or keyword in role_lower or keyword in cap_lower
                     for keyword in ['analyst', 'analysis', 'data', 'insights']):
                category = 'analysis'
            elif any(keyword in title_lower or keyword in role_lower or keyword in cap_lower
                     for keyword in ['manager', 'lead', 'director', 'ceo', 'coordinator']):
                category = 'management'
            elif any(keyword in title_lower or keyword in role_lower or keyword in cap_lower
                     for keyword in ['architect', 'designer', 'specialist', 'expert']):
                category = 'specialized'

            categories[category].append(agent)

            print(
                name.ljust(30),
                role.ljust(15),
                title.ljust(30),
                category
            )

        # Summary by category
        print(f"\nCategory Breakdown:")
        print("=" * 50)
        for category, agents in categories.items():
            if agents:
                print(f"{category.capitalize()}: {len(agents)} agents")
                if len(agents) <= 5:  # Show names if not too many
                    names = [a['name'] for a in agents]
                    print(f"  Agents: {', '.join(names)}")

    except Exception as e:
        print(f"Query failed: {e}")
        sys.exit(1)

def query_agent_skill_assignments():
    """Query agent_skill_assignments table to understand assignment methodology."""
    supabase = get_supabase_client()

    print("\nQuerying agent_skill_assignments table...")

    try:
        # Get total count
        count_response = supabase.table('agent_skill_assignments').select('*', count='exact').execute()
        total_count = count_response.count if hasattr(count_response, 'count') else len(count_response.data)

        print(f"Total agent_skill_assignments records: {total_count}")

        # Get sample of assignments to understand structure
        sample_response = supabase.table('agent_skill_assignments').select('*').limit(10).execute()

        if sample_response.data:
            print("\nSample agent_skill_assignments records:")
            for i, record in enumerate(sample_response.data[:5]):
                print(f"  Record {i+1}: {record}")

        # Analyze assignment patterns
        pattern_response = supabase.table('agent_skill_assignments').select('agent_id, skill_id').execute()

        if pattern_response.data:
            # Count assignments per agent
            agent_counts = {}
            skill_counts = {}

            for record in pattern_response.data:
                agent_id = record.get('agent_id')
                skill_id = record.get('skill_id')

                if agent_id:
                    agent_counts[agent_id] = agent_counts.get(agent_id, 0) + 1
                if skill_id:
                    skill_counts[skill_id] = skill_counts.get(skill_id, 0) + 1

            # Show top agents by assignment count
            top_agents = sorted(agent_counts.items(), key=lambda x: x[1], reverse=True)[:10]
            print(f"\nTop 10 agents by skill assignment count:")
            for agent_id, count in top_agents:
                print(f"  {agent_id}: {count} skills")

            # Show top skills by assignment count
            top_skills = sorted(skill_counts.items(), key=lambda x: x[1], reverse=True)[:10]
            print(f"\nTop 10 skills by assignment count:")
            for skill_id, count in top_skills:
                print(f"  {skill_id}: assigned to {count} agents")

    except Exception as e:
        print(f"Query failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    query_agent_models()
    query_deepseek_r1_agents()
    query_agent_skill_assignments()
