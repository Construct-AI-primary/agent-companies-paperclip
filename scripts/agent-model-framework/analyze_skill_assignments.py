#!/usr/bin/env python3
"""
Analyze the 10,306 agent_skill_assignments records to understand assignment patterns
"""

import os
import sys
from typing import Dict, List, Any
from collections import defaultdict, Counter

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

def analyze_skill_assignments():
    """Comprehensive analysis of agent_skill_assignments table."""
    supabase = get_supabase_client()

    print("🔍 Analyzing 10,306 agent_skill_assignments records...")
    print("=" * 80)

    # Get all skill assignments
    response = supabase.table('agent_skill_assignments').select('*').execute()

    if not response.data:
        print("No skill assignments found.")
        return

    records = response.data
    total_records = len(records)

    print(f"✅ Retrieved {total_records} skill assignment records")

    # Analysis 1: Timestamp distribution
    print("\n📅 Timestamp Analysis:")
    timestamps = [record['created_at'] for record in records]
    unique_timestamps = set(timestamps)

    print(f"  Total records: {total_records}")
    print(f"  Unique timestamps: {len(unique_timestamps)}")

    if len(unique_timestamps) <= 5:
        print("  Timestamps:")
        for ts in sorted(unique_timestamps):
            count = timestamps.count(ts)
            percentage = (count / total_records) * 100
            print(f"    {ts}: {count} records ({percentage:.1f}%)")

    # Analysis 2: Source distribution
    print("\n🔗 Source Analysis:")
    sources = [record.get('source', 'unknown') for record in records]
    source_counts = Counter(sources)

    for source, count in source_counts.most_common():
        percentage = (count / total_records) * 100
        print(f"  {source}: {count} records ({percentage:.1f}%)")

    # Analysis 3: Company distribution
    print("\n🏢 Company Distribution:")
    companies = [record.get('company_id') for record in records]
    company_counts = Counter(companies)

    # Get company names for better readability
    company_names = {}
    try:
        company_response = supabase.table('companies').select('id,name').execute()
        if company_response.data:
            company_names = {c['id']: c['name'] for c in company_response.data}
    except:
        pass  # Continue without company names

    for company_id, count in company_counts.most_common(10):  # Top 10
        company_name = company_names.get(company_id, company_id)
        percentage = (count / total_records) * 100
        print(f"  {company_name}: {count} records ({percentage:.1f}%)")

    # Analysis 4: Skill key patterns
    print("\n🎯 Skill Key Analysis:")
    skill_keys = [record.get('skill_key', '') for record in records]

    # Extract company prefixes from skill keys
    company_prefixes = []
    for skill_key in skill_keys:
        if skill_key and '-' in skill_key:
            prefix = skill_key.split('-')[0]
            company_prefixes.append(prefix)

    prefix_counts = Counter(company_prefixes)
    print(f"  Total skill keys: {len(skill_keys)}")
    print(f"  Unique skill keys: {len(set(skill_keys))}")
    print(f"  Company prefixes found: {len(prefix_counts)}")

    print("  Top company prefixes in skill keys:")
    for prefix, count in prefix_counts.most_common(10):
        percentage = (count / total_records) * 100
        print(f"    {prefix}: {count} records ({percentage:.1f}%)")

    # Analysis 5: Agent assignment distribution
    print("\n👥 Agent Assignment Distribution:")
    agent_ids = [record.get('agent_id') for record in records]
    agent_counts = Counter(agent_ids)

    print(f"  Total agents with skill assignments: {len(agent_counts)}")
    print(f"  Average skills per agent: {total_records / len(agent_counts):.1f}")

    # Show distribution of assignments per agent
    assignment_counts = Counter(agent_counts.values())
    print("  Skills per agent distribution:")
    for num_skills, num_agents in sorted(assignment_counts.items()):
        percentage = (num_agents / len(agent_counts)) * 100
        print(f"    {num_skills} skills: {num_agents} agents ({percentage:.1f}%)")

    # Analysis 6: Most/least assigned skills
    print("\n📊 Skill Popularity Analysis:")
    skill_popularity = Counter(skill_keys)

    print("  Most assigned skills:")
    for skill, count in skill_popularity.most_common(10):
        percentage = (count / total_records) * 100
        print(f"    {skill}: {count} assignments ({percentage:.2f}%)")

    print("  Least assigned skills (bottom 10):")
    least_assigned = skill_popularity.most_common()[-10:]
    for skill, count in least_assigned:
        percentage = (count / total_records) * 100
        print(f"    {skill}: {count} assignments ({percentage:.3f}%)")

    # Analysis 7: Bulk assignment detection
    print("\n🔍 Bulk Assignment Detection:")

    # Check if assignments are evenly distributed or concentrated
    if len(unique_timestamps) == 1:
        print("  ⚠️  ALL assignments created at the same timestamp - clear bulk assignment!")
        print("     This indicates no individual agent assessment was performed.")

    # Check for power law distribution (few skills assigned to many agents)
    top_skill_percentage = sum(count for _, count in skill_popularity.most_common(10)) / total_records * 100
    print(f"  Top 10 skills represent: {top_skill_percentage:.1f}% of all assignments")

    # Check for uniform distribution
    avg_assignments = total_records / len(skill_popularity)
    uniform_threshold = avg_assignments * 0.5  # Skills with < 50% of average are rare

    rare_skills = sum(1 for count in skill_popularity.values() if count < uniform_threshold)
    rare_percentage = (rare_skills / len(skill_popularity)) * 100

    print(f"  Skills with <50% of average assignments: {rare_percentage:.1f}%")
    # Summary
    print("\n" + "=" * 80)
    print("📋 ANALYSIS SUMMARY")
    print("=" * 80)

    print("🔴 PROBLEMS IDENTIFIED:")
    if len(unique_timestamps) == 1:
        print("  • Bulk assignment detected - no individual agent evaluation")
    if top_skill_percentage > 50:
        print("  • Uneven skill distribution - few skills dominate assignments")
    if rare_percentage > 50:
        print("  • Many skills rarely used - potential over-granular skill taxonomy")

    print("\n📈 KEY STATISTICS:")
    print(f"  • Total skill assignments: {total_records:,}")
    print(f"  • Unique agents: {len(agent_counts):,}")
    print(f"  • Unique skills: {len(skill_popularity):,}")
    print(f"  • Skills per agent: {total_records / len(agent_counts):.1f}")
    print(f"  • Agents per skill: {total_records / len(skill_popularity):.1f}")

    print("\n💡 RECOMMENDATIONS:")
    print("  • Implement task-based skill assignment instead of bulk assignment")
    print("  • Consolidate over-granular skills into capability categories")
    print("  • Add agent capability assessment before skill assignment")
    print("  • Use the Intelligent Model Assignment Framework for future assignments")

if __name__ == "__main__":
    analyze_skill_assignments()