#!/usr/bin/env python3
"""
Apply Agent Company Assignment Fixes to Supabase
Run this script to fix the agent company assignment issues identified in the investigation.
"""

import os
import sys

try:
    from supabase import create_client, Client
except ImportError:
    print("Error: supabase-py not installed. Install with: pip install supabase")
    sys.exit(1)

# Load environment variables
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass


def get_supabase_client() -> Client:
    """Create and return Supabase client."""
    url = os.getenv('SUPABASE_URL')
    service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')

    if not url or not service_key:
        raise ValueError("SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY required")

    return create_client(url, service_key)


def apply_learningforge_fixes(supabase: Client) -> None:
    """Fix LearningForge AI agent assignments."""
    print("🔧 Fixing LearningForge AI agent assignments...")

    learningforge_agent_names = [
        'learningforge-ai-assessment-mastery',
        'learningforge-ai-audit-by-path',
        'learningforge-ai-audit-explainability',
        'learningforge-ai-autoresearch-gap-analyzer',
        'learningforge-ai-autoresearch-literature-scanner',
        'learningforge-ai-autoresearch-skills-enhancer',
        'learningforge-ai-ceo',
        'learningforge-ai-compliance-guard',
        'learningforge-ai-construction-law-research',
        'learningforge-ai-contracts-agent',
        'learningforge-ai-curriculum-planner',
        'learningforge-ai-defect-pattern-research',
        'learningforge-ai-doc-gap-detector',
        'learningforge-ai-doc-usage-analyzer',
        'learningforge-ai-electrical-engineering-agent',
        'learningforge-ai-equipment-innovation-research',
        'learningforge-ai-equipment-inspection',
        'learningforge-ai-feedback-synthesis',
        'learningforge-ai-field-safety-inspector',
        'learningforge-ai-from-doc-to-lesson-generator',
        'learningforge-ai-goal-alignment-budget',
        'learningforge-ai-hazard-pattern-analyst',
        'learningforge-ai-hermes-research',
        'learningforge-ai-interaction-pattern-coach',
        'learningforge-ai-knowledge-flow-agent',
        'learningforge-ai-knowledge-flow-division-lead',
        'learningforge-ai-knowledge-hygiene',
        'learningforge-ai-knowledge-provenance',
        'learningforge-ai-knowledge-transparency',
        'learningforge-ai-langchain-runner',
        'learningforge-ai-learning-division-lead',
        'learningforge-ai-logistics-agent',
        'learningforge-ai-material-defect-tracker',
        'learningforge-ai-micro-lesson-generator',
        'learningforge-ai-priority-disciplines-lead',
        'learningforge-ai-procurement-agent',
        'learningforge-ai-quality-learning',
        'learningforge-ai-research-compliance-division-lead',
        'learningforge-ai-research-scheduler',
        'learningforge-ai-safety-quality-division-lead',
        'learningforge-ai-safety-regulation-research',
        'learningforge-ai-safety-training-compliance',
        'learningforge-ai-safety-workflow-agent',
        'learningforge-ai-user-behavior-analyst',
        'learningforge-ai-vfs-markdown-tracker',
        'learningforge-ai-vfs-watcher',
        'learningforge-ai-workflow-coach'
    ]

    # Update agents
    result = supabase.table('agents').update({
        'company_id': '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
    }).in_('name', learningforge_agent_names).execute()

    print(f"✅ Updated {len(result.data)} LearningForge AI agents")

    # Update API keys
    supabase.table('agent_api_keys').update({
        'company_id': '2bda2da6-dfa7-4709-b5d1-ea865f14072a'
    }).in_('agent_id', [agent['id'] for agent in result.data]).execute()

    print("✅ Updated corresponding API keys")


def apply_loopy_fixes(supabase: Client) -> None:
    """Fix misplaced Loopy AI agents."""
    print("🔧 Fixing misplaced Loopy AI agents...")

    loopy_agent_names = ['maya-loopy-content-strategist', 'vision-loopy-ceo']

    # Update agents
    result = supabase.table('agents').update({
        'company_id': '0a40625e-78f9-4b0a-82e4-169a8befa021'
    }).in_('name', loopy_agent_names).execute()

    print(f"✅ Moved {len(result.data)} Loopy AI agents to correct company")

    # Update API keys
    supabase.table('agent_api_keys').update({
        'company_id': '0a40625e-78f9-4b0a-82e4-169a8befa021'
    }).in_('agent_id', [agent['id'] for agent in result.data]).execute()

    print("✅ Updated corresponding API keys")


def verify_fixes(supabase: Client) -> None:
    """Verify that the fixes were applied correctly."""
    print("\n🔍 Verifying fixes...")

    # Check Learning Forge AI
    learning_result = supabase.table('agents').select('id', 'name').eq('company_id', '2bda2da6-dfa7-4709-b5d1-ea865f14072a').execute()
    print(f"✅ Learning Forge AI now has {len(learning_result.data)} agents")

    # Check Loopy AI
    loopy_result = supabase.table('agents').select('id', 'name').eq('company_id', '0a40625e-78f9-4b0a-82e4-169a8befa021').execute()
    print(f"✅ Loopy AI now has {len(loopy_result.data)} agents")

    # Check for misplaced Loopy agents
    misplaced = supabase.table('agents').select('name').ilike('name', '%loopy%').neq('company_id', '0a40625e-78f9-4b0a-82e4-169a8befa021').execute()
    if misplaced.data:
        print(f"⚠️  Warning: {len(misplaced.data)} Loopy agents still misplaced")
    else:
        print("✅ No misplaced Loopy AI agents found")


def main():
    """Main function."""
    print("🛠️  Agent Company Assignment Fix Tool")
    print("This will correct agent assignments based on file system structure.\n")

    # Confirm
    if '--yes' not in sys.argv:
        response = input("Apply fixes to Supabase? (type 'yes' to confirm): ")
        if response.lower() != 'yes':
            print("Operation cancelled.")
            sys.exit(0)

    try:
        supabase = get_supabase_client()
        print("✅ Connected to Supabase")

        apply_learningforge_fixes(supabase)
        apply_loopy_fixes(supabase)
        verify_fixes(supabase)

        print("\n🎉 All fixes applied successfully!")
        print("\n📋 Next Steps:")
        print("1. Move agent files in file system to match new assignments")
        print("2. Update cross-reference documentation")
        print("3. Test agent functionality")

    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)


if __name__ == '__main__':
    main()