#!/usr/bin/env python3
"""
Fresh Start Reconciliation Script
================================
This script performs a clean reconciliation:
1. Deletes all existing agents, API keys, and model assignments from database
2. Re-inserts all agents from filesystem definitions with proper funky names
3. Generates API keys for each agent

WARNING: This deletes all existing agent data!
"""

import os
import sys
import json
import re
import secrets
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, field

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


@dataclass
class AgentDefinition:
    """Represents an agent definition from the filesystem."""
    name: str
    slug: str
    reports_to: Optional[str]
    skills: List[str]
    company_slug: str
    company_name: str
    file_path: str
    funky_human_name: Optional[str] = None
    
    def generate_funky_name(self) -> str:
        """Generate a funky human name from the slug (max 22 chars)."""
        if self.funky_human_name:
            name = self.funky_human_name
        elif self.slug:
            # Convert slug to funky name
            name = self.slug.replace('-', ' ').replace('_', ' ')
            name = ' '.join(word.capitalize() for word in name.split())
        else:
            # Use the name field
            name = self.name if self.name else f"Agent_{self.name}"
        
        # Truncate to max 22 chars if needed
        if len(name) > 22:
            # Try to make it fit by abbreviating
            words = name.split()
            if len(words) > 1:
                # Take first letter of each word until it fits
                abbrev = ''.join(w[0] for w in words)
                if len(abbrev) <= 22:
                    name = abbrev
                else:
                    # Just truncate
                    name = name[:22]
            else:
                name = name[:22]
        
        return name


class FreshReconciliationAgent:
    """Fresh reconciliation agent class."""
    
    COMPANIES_DIR = Path("docs-paperclip/companies")
    COMPANIES_CONFIG = {
        'contentforge-ai': {'name': 'ContentForge AI', 'id': None},
        'devforge-ai': {'name': 'DevForge AI', 'id': None},
        'domainforge-ai': {'name': 'DomainForge AI', 'id': None},
        'execforge-ai': {'name': 'ExecForge AI', 'id': None},
        'infraforge-ai': {'name': 'InfraForge AI', 'id': None},
        'integrateforge-ai': {'name': 'IntegrateForge AI', 'id': None},
        'knowledgeforge-ai': {'name': 'KnowledgeForge AI', 'id': None},
        'learningforge-ai': {'name': 'Learning Forge AI', 'id': None},
        'loopy-ai': {'name': 'Loopy AI', 'id': None},
        'measureforge-ai': {'name': 'MeasureForge AI', 'id': None},
        'mobileforge-ai': {'name': 'MobileForge AI', 'id': None},
        'paperclipforge-ai': {'name': 'PaperclipForge AI', 'id': None},
        'promptforge-ai': {'name': 'PromptForge AI', 'id': None},
        'qualityforge-ai': {'name': 'QualityForge AI', 'id': None},
        'saasforge-ai': {'name': 'SaaSForge AI', 'id': None},
        'voiceforge-ai': {'name': 'VoiceForge AI', 'id': None},
    }
    
    def __init__(self):
        self.supabase: Optional[Client] = None
        self.agents: List[AgentDefinition] = []
        self.company_ids: Dict[str, str] = {}
        
    def connect(self) -> None:
        """Connect to Supabase."""
        url = os.getenv('SUPABASE_URL')
        service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')
        
        if not url or not service_key:
            raise ValueError("SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are required")
        
        self.supabase = create_client(url, service_key)
        print("✅ Connected to Supabase")
    
    def scan_filesystem(self) -> None:
        """Scan filesystem for agent definitions."""
        print("\n📂 Scanning filesystem for agent definitions...")
        
        for company_slug in self.COMPANIES_CONFIG.keys():
            company_path = self.COMPANIES_DIR / company_slug / "agents"
            
            if not company_path.exists():
                continue
            
            # Recursively find all AGENTS.md files
            for agents_md_path in company_path.rglob("AGENTS.md"):
                agent_def = self._parse_agent_file(agents_md_path, company_slug)
                if agent_def:
                    self.agents.append(agent_def)
        
        print(f"  ✅ Found {len(self.agents)} agents in filesystem")
    
    def _parse_agent_file(self, file_path: Path, company_slug: str) -> Optional[AgentDefinition]:
        """Parse an AGENTS.md file and extract agent definition."""
        try:
            content = file_path.read_text()
            lines = content.split('\n')
            
            # Parse YAML frontmatter
            frontmatter = {}
            in_frontmatter = False
            frontmatter_lines = []
            
            for line in lines:
                if line.strip() == '---':
                    if not in_frontmatter:
                        in_frontmatter = True
                    else:
                        break
                elif in_frontmatter:
                    frontmatter_lines.append(line)
            
            for line in frontmatter_lines:
                if ':' in line:
                    key, value = line.split(':', 1)
                    frontmatter[key.strip()] = value.strip()
            
            name = frontmatter.get('name', '')
            slug = frontmatter.get('slug', '')
            
            # If name/slug is empty, derive from directory name
            # Directory format: {company}-{AgentName} e.g., contentforge-ai-SEOStrategist
            if not slug and not name:
                # Get parent directory name (the agent folder)
                parent_dir = file_path.parent.name
                # Remove company prefix if present
                if '-' in parent_dir:
                    parts = parent_dir.split('-')
                    # Find where company slug ends (first part that matches a known company)
                    company_slug = None
                    agent_part_start = 0
                    for i, part in enumerate(parts):
                        potential_slug = '-'.join(parts[:i+1])
                        if potential_slug in self.COMPANIES_CONFIG:
                            company_slug = potential_slug
                            agent_part_start = i + 1
                    if company_slug:
                        slug = parent_dir  # Use full slug including company prefix
                    else:
                        slug = parent_dir
                else:
                    slug = parent_dir
            
            reports_to = frontmatter.get('reportsTo')
            skills_str = frontmatter.get('skills', '[]')
            
            skills = []
            if skills_str.startswith('['):
                skills = [s.strip().strip("'\"") for s in skills_str[1:-1].split(',')]
            
            # Get funky human name from content (first heading)
            funky_name = None
            for line in lines:
                if line.startswith('# ') and len(line) > 2:
                    funky_name = line[2:].strip()
                    break
            
            return AgentDefinition(
                name=name,
                slug=slug,
                reports_to=reports_to if reports_to != 'null' else None,
                skills=skills,
                company_slug=company_slug,
                company_name=self.COMPANIES_CONFIG[company_slug]['name'],
                file_path=str(file_path),
                funky_human_name=funky_name
            )
        except Exception as e:
            return None
    
    def get_company_ids(self) -> None:
        """Get company IDs from database."""
        print("\n📊 Getting company IDs from database...")
        
        response = self.supabase.table('companies').select('id, name').execute()
        for row in response.data:
            for slug, config in self.COMPANIES_CONFIG.items():
                if config['name'] == row['name']:
                    config['id'] = row['id']
                    self.company_ids[slug] = row['id']
        
        print(f"  ✅ Found {len(self.company_ids)} companies")
    
    def generate_sql(self) -> List[str]:
        """Generate SQL for fresh start."""
        sql = []
        
        # Header
        sql.append("-- ============================================================")
        sql.append("-- FRESH START RECONCILIATION")
        sql.append("-- This script:")
        sql.append("-- 1. Deletes all existing agents, API keys, and model assignments")
        sql.append("-- 2. Re-inserts all agents from filesystem definitions")
        sql.append("-- 3. Generates API keys for each agent")
        sql.append(f"-- Generated: {Path(__file__).resolve()}")
        sql.append("-- ============================================================")
        sql.append("")
        
        # Step 1: Delete existing records in correct FK order
        sql.append("-- STEP 1: Delete existing records in correct FK order")
        sql.append("-- ============================================================")
        sql.append("-- NOTE: Always cast UUID to TEXT for cross-table comparisons")
        sql.append("BEGIN;")
        sql.append("")
        sql.append("-- 1. Delete heartbeat events (chained via heartbeat_runs)")
        sql.append("DELETE FROM heartbeat_run_events WHERE run_id::text IN (")
        sql.append("    SELECT hr.id::text FROM heartbeat_runs hr")
        sql.append("    WHERE hr.agent_id::text IN (SELECT id::text FROM agents)")
        sql.append(");")
        sql.append("")
        sql.append("-- 2. Delete heartbeat runs")
        sql.append("DELETE FROM heartbeat_runs WHERE agent_id::text IN (SELECT id::text FROM agents);")
        sql.append("")
        sql.append("-- 3. Delete agent task sessions")
        sql.append("DELETE FROM agent_task_sessions WHERE agent_id::text IN (SELECT id::text FROM agents);")
        sql.append("")
        sql.append("-- 4. Delete agent runtime state")
        sql.append("DELETE FROM agent_runtime_state WHERE agent_id::text IN (SELECT id::text FROM agents);")
        sql.append("")
        sql.append("-- 5. Delete agent wakeup requests")
        sql.append("DELETE FROM agent_wakeup_requests WHERE agent_id::text IN (SELECT id::text FROM agents);")
        sql.append("")
        sql.append("-- 6. Delete agent config revisions (both FKs)")
        sql.append("DELETE FROM agent_config_revisions WHERE agent_id::text IN (SELECT id::text FROM agents);")
        sql.append("")
        sql.append("-- 7. Delete agent API keys")
        sql.append("DELETE FROM agent_api_keys WHERE agent_id::text IN (SELECT id::text FROM agents);")
        sql.append("")
        sql.append("-- 8. Clear self-referential nullable FK (set to NULL before deleting parent)")
        sql.append("DO $$ BEGIN")
        sql.append("    UPDATE agents SET reports_to = NULL WHERE reports_to::text IN (SELECT id::text FROM agents);")
        sql.append("EXCEPTION WHEN undefined_column THEN")
        sql.append("    RAISE NOTICE 'Column reports_to does not exist, skipping';")
        sql.append("END $$;")
        sql.append("")
        sql.append("-- 9. Delete the agents")
        sql.append("DELETE FROM agents;")
        sql.append("")
        
        # Step 2: Insert agents
        sql.append("-- STEP 2: Insert agents from filesystem")
        sql.append("-- ============================================================")
        
        for agent in self.agents:
            company_id = self.company_ids.get(agent.company_slug)
            if not company_id:
                continue
            
            # CORRECT MAPPING:
            # - name = human-readable name (e.g., "SEO Strategist")
            # - title = agent slug (e.g., "contentforge-ai-SEOStrategist")
            agent_slug = agent.slug or agent.name
            human_title = agent.generate_funky_name()
            
            # Validate name length (name field max is typically 255 for text)
            if len(agent_slug) >= 255:
                print(f"  ⚠️  WARNING: Agent slug '{agent_slug}' is {len(agent_slug)} chars (max 255)")
            
            sql.append(f"""
-- Agent: {human_title} ({agent_slug})
-- File: {agent.file_path}
INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    '{company_id}',
    '{human_title}',
    'general',
    '{agent_slug}',
    'idle',
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}}'::jsonb,
    '{{}}'::jsonb,
    NOW(),
    NOW()
);""")
        
        sql.append("")
        
        # Step 3: Generate API keys
        sql.append("-- STEP 3: Generate API keys for all agents")
        sql.append("-- ============================================================")
        
        for agent in self.agents:
            # Use agent slug for lookup (title field now contains slug)
            agent_slug = agent.slug or agent.name
            human_title = agent.generate_funky_name()
            api_key = f"pcp_{secrets.token_hex(24)}"
            company_id = self.company_ids.get(agent.company_slug, '')
            
            sql.append(f"""
-- API key for: {human_title} ({agent_slug})
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = '{agent_slug}' LIMIT 1),
    '{company_id}',
    'default',
    '{api_key}',
    NOW()
WHERE EXISTS (SELECT 1 FROM agents WHERE title = '{agent_slug}');
""")
        
        sql.append("")
        
        # Step 4: Create model assignments
        sql.append("-- STEP 4: Create model assignments for all agents")
        sql.append("-- ============================================================")
        
        for agent in self.agents:
            # Use agent slug for lookup (title field now contains slug)
            agent_slug = agent.slug or agent.name
            human_title = agent.generate_funky_name()
            
            sql.append(f"""
-- Model assignment for: {human_title} ({agent_slug})
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE title = '{agent_slug}' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE EXISTS (SELECT 1 FROM agents WHERE title = '{agent_slug}');
""")
        
        sql.append("")
        sql.append("COMMIT;")
        sql.append("")
        sql.append("-- ============================================================")
        sql.append("-- RECONCILIATION COMPLETE")
        sql.append(f"-- Total agents: {len(self.agents)}")
        sql.append("-- ============================================================")
        
        return sql
    
    def save_sql(self, sql: List[str], output_path: str = "fresh_reconciliation.sql") -> None:
        """Save SQL to file."""
        with open(output_path, 'w') as f:
            f.write('\n'.join(sql))
        print(f"\n💾 SQL saved to: {output_path}")
    
    def save_summary(self, output_path: str = "fresh_reconciliation_summary.json") -> None:
        """Save summary of what will be created."""
        summary = {
            'total_agents': len(self.agents),
            'agents_by_company': {},
            'sample_agents': []
        }
        
        for agent in self.agents:
            company = agent.company_name
            if company not in summary['agents_by_company']:
                summary['agents_by_company'][company] = 0
            summary['agents_by_company'][company] += 1
        
        # Add sample of first 20 agents with their funky names
        for agent in self.agents[:20]:
            summary['sample_agents'].append({
                'funky_name': agent.generate_funky_name(),
                'name_length': len(agent.generate_funky_name()),
                'original_slug': agent.slug or agent.name,
                'company': agent.company_name
            })
        
        with open(output_path, 'w') as f:
            json.dump(summary, f, indent=2)
        print(f"💾 Summary saved to: {output_path}")
    
    def run(self) -> None:
        """Run the fresh reconciliation."""
        print("=" * 80)
        print("FRESH START RECONCILIATION")
        print("=" * 80)
        print("\n⚠️  WARNING: This will DELETE all existing agent data!")
        print()
        
        self.connect()
        self.scan_filesystem()
        self.get_company_ids()
        
        print("\n📝 Generating SQL...")
        sql = self.generate_sql()
        self.save_sql(sql)
        self.save_summary()
        
        print("\n" + "=" * 80)
        print("SUMMARY")
        print("=" * 80)
        print(f"  Total agents to create: {len(self.agents)}")
        print(f"  Companies: {len(self.company_ids)}")
        
        # Count by company
        by_company = {}
        for agent in self.agents:
            company = agent.company_name
            by_company[company] = by_company.get(company, 0) + 1
        
        print("\n  By company:")
        for company in sorted(by_company.keys()):
            print(f"    {company}: {by_company[company]}")
        
        print("\n📋 Next steps:")
        print("1. Review fresh_reconciliation.sql")
        print("2. Execute against Supabase (this will DELETE existing data!)")
        print("3. Verify agents were created correctly")
        print("\n✅ The only manual step needed is ensuring API keys are generated.")


def main():
    """Main entry point."""
    agent = FreshReconciliationAgent()
    
    try:
        agent.run()
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == '__main__':
    main()
