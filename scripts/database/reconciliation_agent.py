#!/usr/bin/env python3
"""
Paperclip Agent Reconciliation Agent
=====================================
This agent performs comprehensive reconciliation between:
1. Filesystem state (docs-paperclip/companies/{company}/agents/)
2. Database state (agents, agent_api_keys, agent_models tables)

It identifies gaps and generates SQL fixes for:
- Missing company registrations
- Missing agent registrations
- Missing API keys
- Missing model assignments
- Invalid hierarchy references
- Naming convention violations
"""

import os
import sys
import json
import re
import secrets
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, field
from collections import defaultdict

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
    
    def validate_name(self) -> Tuple[bool, str]:
        """Validate that the name is a valid funky human name < 23 chars."""
        if not self.name:
            return False, "Name is empty"
        
        if len(self.name) >= 23:
            return False, f"Name '{self.name}' is >= 23 characters ({len(self.name)})"
        
        # Check for valid funky human name pattern (letters, numbers, hyphens, spaces allowed)
        if not re.match(r'^[a-zA-Z0-9\s\-_]+$', self.name):
            return False, f"Name '{self.name}' contains invalid characters"
        
        return True, "Valid"
    
    def generate_funky_name(self) -> str:
        """Generate a funky human name from the slug if needed."""
        if self.funky_human_name:
            return self.funky_human_name
        
        # Convert slug to funky name
        # e.g., "nexus-devforge-ceo" -> "Nexus Devforge CEO"
        name = self.slug.replace('-', ' ').replace('_', ' ')
        # Capitalize each word
        name = ' '.join(word.capitalize() for word in name.split())
        
        # Truncate if too long
        if len(name) >= 23:
            # Take first letters of each word or truncate
            words = name.split()
            if len(words) > 1:
                # Take first 3 letters of each word
                name = ''.join(w[:3] for w in words)
            else:
                name = name[:22]
        
        return name


@dataclass
class DatabaseAgent:
    """Represents an agent from the database."""
    id: str
    name: str
    company_id: str
    role: str
    title: Optional[str]
    reports_to: Optional[str]
    status: str


@dataclass
class DatabaseCompany:
    """Represents a company from the database."""
    id: str
    name: str
    slug: str


@dataclass
class ReconciliationReport:
    """Comprehensive reconciliation report."""
    companies_in_filesystem: List[str] = field(default_factory=list)
    companies_in_database: List[str] = field(default_factory=list)
    agents_in_filesystem: List[AgentDefinition] = field(default_factory=list)
    agents_in_database: List[DatabaseAgent] = field(default_factory=list)
    
    missing_companies: List[str] = field(default_factory=list)
    missing_agents: List[AgentDefinition] = field(default_factory=list)
    extra_agents_in_database: List[DatabaseAgent] = field(default_factory=list)  # Agents in DB but not in filesystem
    agents_without_api_keys: List[DatabaseAgent] = field(default_factory=list)
    agents_without_models: List[DatabaseAgent] = field(default_factory=list)
    broken_hierarchies: List[Tuple[str, str, str]] = field(default_factory=list)
    invalid_names: List[Tuple[str, str]] = field(default_factory=list)
    naming_convention_issues: List[str] = field(default_factory=list)
    
    sql_statements: List[str] = field(default_factory=list)
    
    def summary(self) -> str:
        """Generate a summary report."""
        lines = [
            "=" * 80,
            "PAPERCLIP AGENT RECONCILIATION REPORT",
            "=" * 80,
            "",
            "COMPANIES:",
            f"  - In filesystem: {len(self.companies_in_filesystem)}",
            f"  - In database: {len(self.companies_in_database)}",
            f"  - Missing in database: {len(self.missing_companies)}",
            "",
            "AGENTS:",
            f"  - In filesystem: {len(self.agents_in_filesystem)}",
            f"  - In database: {len(self.agents_in_database)}",
            f"  - Extra in database (no filesystem): {len(self.extra_agents_in_database)}",
            f"  - Missing in database (need to add): {len(self.missing_agents)}",
            f"  - Without API keys: {len(self.agents_without_api_keys)}",
            f"  - Without model assignments: {len(self.agents_without_models)}",
            "",
            "MATH CHECK:",
            f"  - DB agents: {len(self.agents_in_database)}",
            f"  - FS agents: {len(self.agents_in_filesystem)}",
            f"  - Difference: {len(self.agents_in_database) - len(self.agents_in_filesystem)}",
            f"  - Extra in DB: {len(self.extra_agents_in_database)}",
            f"  - Missing from DB: {len(self.missing_agents)}",
            "",
            "VALIDATION ISSUES:",
            f"  - Broken hierarchies: {len(self.broken_hierarchies)}",
            f"  - Invalid names: {len(self.invalid_names)}",
            f"  - Naming convention issues: {len(self.naming_convention_issues)}",
            "",
            "SQL STATEMENTS GENERATED:",
            f"  - {len(self.sql_statements)} statements",
            "=" * 80,
        ]
        return '\n'.join(lines)


class ReconciliationAgent:
    """Main reconciliation agent class."""
    
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
        self.report = ReconciliationReport()
        self.company_slug_to_id: Dict[str, str] = {}
        self.agent_name_to_id: Dict[str, str] = {}
        self.agent_id_to_name: Dict[str, str] = {}
        
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
                print(f"  ⚠️  No agents directory for {company_slug}")
                continue
            
            self.report.companies_in_filesystem.append(company_slug)
            
            # Recursively find all AGENTS.md files
            for agents_md_path in company_path.rglob("AGENTS.md"):
                agent_def = self._parse_agent_file(agents_md_path, company_slug)
                if agent_def:
                    self.report.agents_in_filesystem.append(agent_def)
        
        print(f"  ✅ Found {len(self.report.agents_in_filesystem)} agents in filesystem")
        print(f"  ✅ Found {len(self.report.companies_in_filesystem)} companies in filesystem")
    
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
            
            # Parse frontmatter
            for line in frontmatter_lines:
                if ':' in line:
                    key, value = line.split(':', 1)
                    frontmatter[key.strip()] = value.strip()
            
            # Extract agent info
            name = frontmatter.get('name', '')
            slug = frontmatter.get('slug', '')
            reports_to = frontmatter.get('reportsTo')
            skills_str = frontmatter.get('skills', '[]')
            
            # Parse skills list
            skills = []
            if skills_str.startswith('['):
                skills = [s.strip().strip("'\"") for s in skills_str[1:-1].split(',')]
            
            # Get funky human name from content (first heading after frontmatter)
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
            print(f"  ⚠️  Error parsing {file_path}: {e}")
            return None
    
    def query_database(self) -> None:
        """Query database for current state."""
        print("\n📊 Querying database for current state...")
        
        # Get companies
        response = self.supabase.table('companies').select('id, name').execute()
        for row in response.data:
            self.report.companies_in_database.append(row['name'])
            # Map by name and slug
            for slug, config in self.COMPANIES_CONFIG.items():
                if config['name'] == row['name']:
                    config['id'] = row['id']
                    self.company_slug_to_id[slug] = row['id']
        
        print(f"  ✅ Found {len(self.report.companies_in_database)} companies in database")
        
        # Get agents
        response = self.supabase.table('agents').select('*').execute()
        for row in response.data:
            agent = DatabaseAgent(
                id=row['id'],
                name=row['name'],
                company_id=row['company_id'],
                role=row['role'],
                title=row.get('title'),
                reports_to=row.get('reports_to'),
                status=row['status']
            )
            self.report.agents_in_database.append(agent)
            self.agent_name_to_id[agent.name] = agent.id
            self.agent_id_to_name[agent.id] = agent.name
        
        print(f"  ✅ Found {len(self.report.agents_in_database)} agents in database")
        
        # Get API keys
        response = self.supabase.table('agent_api_keys').select('agent_id').execute()
        agents_with_keys = {row['agent_id'] for row in response.data}
        
        # Get model assignments
        response = self.supabase.table('agent_models').select('agent_id').eq('is_active', True).execute()
        agents_with_models = {row['agent_id'] for row in response.data}
        
        # Identify agents without API keys or models
        for agent in self.report.agents_in_database:
            if agent.status not in ['pending_approval', 'terminated']:
                if agent.id not in agents_with_keys:
                    self.report.agents_without_api_keys.append(agent)
                if agent.id not in agents_with_models:
                    self.report.agents_without_models.append(agent)
        
        print(f"  ✅ Found {len(agents_with_keys)} agents with API keys")
        print(f"  ✅ Found {len(agents_with_models)} agents with model assignments")
    
    def analyze_reconciliation(self) -> None:
        """Analyze reconciliation between filesystem and database."""
        print("\n🔍 Analyzing reconciliation...")
        
        # Find missing companies
        for slug in self.COMPANIES_CONFIG.keys():
            if slug not in self.report.companies_in_filesystem:
                continue
            config = self.COMPANIES_CONFIG[slug]
            if config['name'] not in self.report.companies_in_database:
                self.report.missing_companies.append(slug)
        
        print(f"  ⚠️  Missing companies: {len(self.report.missing_companies)}")
        
        # Build a proper mapping between filesystem agents and database agents
        # Filesystem: name field contains slug (e.g., "nexus-devforge-ceo")
        # Database: name field contains human name (e.g., "Nexus"), title contains slug
        db_title_to_agent = {}
        db_name_to_agent = {}
        for agent in self.report.agents_in_database:
            db_name_to_agent[agent.name.lower()] = agent
            if agent.title:
                db_title_to_agent[agent.title.lower()] = agent
        
        # Find missing agents by matching slug to title or name
        matched_count = 0
        matched_db_agents = set()  # Track which DB agents have been matched
        
        for fs_agent in self.report.agents_in_filesystem:
            slug_lower = fs_agent.name.lower()
            title_lower = fs_agent.slug.lower() if fs_agent.slug else None
            
            # Try to match by title (slug) first
            if title_lower and title_lower in db_title_to_agent:
                matched_count += 1
                matched_db_agents.add(db_title_to_agent[title_lower].id)
                continue
            
            # Try to match by name (slug) directly
            if slug_lower in db_name_to_agent:
                matched_count += 1
                matched_db_agents.add(db_name_to_agent[slug_lower].id)
                continue
            
            # Try to match by converting slug to human name
            # e.g., "nexus-devforge-ceo" -> check if "nexus" or "nexus devforge ceo" matches
            human_name = fs_agent.generate_funky_name().lower()
            if human_name in db_name_to_agent:
                matched_count += 1
                matched_db_agents.add(db_name_to_agent[human_name].id)
                continue
            
            # Not found - this is a missing agent
            self.report.missing_agents.append(fs_agent)
        
        print(f"  ✅ Agents matched to database: {matched_count}")
        print(f"  ⚠️  Missing agents (in FS but not DB): {len(self.report.missing_agents)}")
        
        # Find extra agents in database (in DB but not in filesystem)
        for db_agent in self.report.agents_in_database:
            if db_agent.id not in matched_db_agents:
                self.report.extra_agents_in_database.append(db_agent)
        
        print(f"  ⚠️  Extra agents in database (in DB but not FS): {len(self.report.extra_agents_in_database)}")
        
        # Math check
        diff = len(self.report.agents_in_database) - len(self.report.agents_in_filesystem)
        print(f"  📊 Math check: DB({len(self.report.agents_in_database)}) - FS({len(self.report.agents_in_filesystem)}) = {diff}")
        print(f"     Extra in DB: {len(self.report.extra_agents_in_database)}, Missing from DB: {len(self.report.missing_agents)}")
        
        # Find broken hierarchies
        for agent in self.report.agents_in_database:
            if agent.reports_to:
                if agent.reports_to not in self.agent_id_to_name:
                    self.report.broken_hierarchies.append((
                        agent.name,
                        agent.reports_to,
                        "Reports to non-existent agent"
                    ))
        
        print(f"  ⚠️  Broken hierarchies: {len(self.report.broken_hierarchies)}")
        
        # Find invalid names
        for agent in self.report.agents_in_database:
            if len(agent.name) >= 23:
                self.report.invalid_names.append((agent.name, f"Name >= 23 chars ({len(agent.name)})"))
        
        print(f"  ⚠️  Invalid names: {len(self.report.invalid_names)}")
        
        # Check naming conventions for filesystem
        for fs_agent in self.report.agents_in_filesystem:
            # Check directory naming
            dir_name = Path(fs_agent.file_path).parent.name
            expected_prefix = f"{fs_agent.company_slug}-"
            if not dir_name.startswith(expected_prefix) and not dir_name.startswith('Interface'):
                self.report.naming_convention_issues.append(
                    f"Directory '{dir_name}' should start with '{expected_prefix}'"
                )
        
        print(f"  ⚠️  Naming convention issues: {len(self.report.naming_convention_issues)}")
    
    def generate_sql_fixes(self) -> None:
        """Generate SQL statements to fix reconciliation issues."""
        print("\n🔧 Generating SQL fixes...")
        
        sql = []
        
        # 1. Insert missing companies
        for slug in self.report.missing_companies:
            config = self.COMPANIES_CONFIG[slug]
            sql.append(f"""
-- Insert missing company: {config['name']}
INSERT INTO companies (id, name, status, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    '{config['name']}',
    'active',
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE name = '{config['name']}');
""")
        
        # 2. Insert missing agents
        for fs_agent in self.report.missing_agents:
            company_id = self.company_slug_to_id.get(fs_agent.company_slug)
            if not company_id:
                # Get company ID from database
                for slug, config in self.COMPANIES_CONFIG.items():
                    if config['name'] == fs_agent.company_name and config['id']:
                        company_id = config['id']
                        break
            
            if not company_id:
                sql.append(f"-- ERROR: Cannot find company_id for {fs_agent.company_name}")
                continue
            
            # Generate funky human name
            funky_name = fs_agent.generate_funky_name()
            
            sql.append(f"""
-- Insert missing agent: {fs_agent.name} ({funky_name})
INSERT INTO agents (id, company_id, name, role, title, status, reports_to, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM companies WHERE name = '{fs_agent.company_name}' LIMIT 1),
    '{funky_name}',
    'general',
    '{fs_agent.slug}',
    'idle',
    NULL,
    '["task_execution", "communication", "analysis"]',
    'hermes_local',
    '{{"adapter": "hermes_local", "model": "anthropic/claude-opus-4.6"}}'::jsonb,
    '{{}}'::jsonb,
    NOW(),
    NOW()
WHERE NOT EXISTS (SELECT 1 FROM agents WHERE name = '{funky_name}');
""")
        
        # 3. Generate API keys for agents without them
        for agent in self.report.agents_without_api_keys:
            api_key = f"pcp_{secrets.token_hex(24)}"
            company_id = None
            for db_agent in self.report.agents_in_database:
                if db_agent.id == agent.id:
                    company_id = db_agent.company_id
                    break
            
            sql.append(f"""
-- Generate API key for agent: {agent.name}
INSERT INTO agent_api_keys (id, agent_id, company_id, name, api_key, created_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = '{agent.name}' LIMIT 1),
    '{company_id}',
    'default',
    '{api_key}',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_api_keys 
    WHERE agent_id = (SELECT id FROM agents WHERE name = '{agent.name}' LIMIT 1)
);
""")
        
        # 4. Generate model assignments for agents without them
        for agent in self.report.agents_without_models:
            sql.append(f"""
-- Create model assignment for agent: {agent.name}
INSERT INTO agent_models (id, agent_id, model_id, assignment_type, temperature, max_tokens, is_active, created_at, updated_at)
SELECT 
    gen_random_uuid(),
    (SELECT id FROM agents WHERE name = '{agent.name}' LIMIT 1),
    'anthropic/claude-opus-4.6',
    'default',
    0.7,
    8192,
    true,
    NOW(),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM agent_models 
    WHERE agent_id = (SELECT id FROM agents WHERE name = '{agent.name}' LIMIT 1)
    AND is_active = true
);
""")
        
        # 5. Fix broken hierarchies
        for agent_name, reports_to, issue in self.report.broken_hierarchies:
            sql.append(f"""
-- Fix broken hierarchy: {agent_name} reports to {reports_to}
-- {issue}
-- TODO: Update reports_to to valid agent ID or NULL
""")
        
        # 6. Fix invalid names (names >= 23 chars)
        for name, issue in self.report.invalid_names:
            # Generate shorter name
            shorter_name = name[:22] if len(name) > 22 else name
            sql.append(f"""
-- Fix invalid name: {name} ({issue})
-- UPDATE agents SET name = '{shorter_name}' WHERE name = '{name}';
""")
        
        self.report.sql_statements = sql
        print(f"  ✅ Generated {len(sql)} SQL statements")
    
    def run(self) -> ReconciliationReport:
        """Run the full reconciliation process."""
        print("=" * 80)
        print("PAPERCLIP AGENT RECONCILIATION AGENT")
        print("=" * 80)
        
        self.connect()
        self.scan_filesystem()
        self.query_database()
        self.analyze_reconciliation()
        self.generate_sql_fixes()
        
        return self.report
    
    def save_sql_fixes(self, output_path: str = "reconciliation_fixes.sql") -> None:
        """Save generated SQL to a file."""
        with open(output_path, 'w') as f:
            f.write("-- ============================================================\n")
            f.write("-- PAPERCLIP AGENT RECONCILIATION FIXES\n")
            f.write(f"-- Generated: {Path(__file__).resolve()}\n")
            f.write("-- ============================================================\n\n")
            
            for sql in self.report.sql_statements:
                f.write(sql)
                f.write("\n")
        
        print(f"\n💾 SQL fixes saved to: {output_path}")
    
    def save_report(self, output_path: str = "reconciliation_report.json") -> None:
        """Save reconciliation report to JSON."""
        report_data = {
            'companies_in_filesystem': self.report.companies_in_filesystem,
            'companies_in_database': self.report.companies_in_database,
            'missing_companies': self.report.missing_companies,
            'missing_agents': [
                {
                    'name': a.name,
                    'slug': a.slug,
                    'company': a.company_name,
                    'file_path': a.file_path
                }
                for a in self.report.missing_agents
            ],
            'extra_agents_in_database': [
                {'id': a.id, 'name': a.name, 'title': a.title}
                for a in self.report.extra_agents_in_database
            ],
            'agents_without_api_keys': [
                {'id': a.id, 'name': a.name}
                for a in self.report.agents_without_api_keys
            ],
            'agents_without_models': [
                {'id': a.id, 'name': a.name}
                for a in self.report.agents_without_models
            ],
            'broken_hierarchies': self.report.broken_hierarchies,
            'invalid_names': self.report.invalid_names,
            'naming_convention_issues': self.report.naming_convention_issues,
            'sql_count': len(self.report.sql_statements)
        }
        
        with open(output_path, 'w') as f:
            json.dump(report_data, f, indent=2)
        
        print(f"💾 Report saved to: {output_path}")
    
    def generate_company_summary(self) -> str:
        """Generate a summary of reconciliation by company."""
        lines = [
            "=" * 80,
            "RECONCILIATION SUMMARY BY COMPANY",
            "=" * 80,
            "",
        ]
        
        # Group agents by company
        fs_by_company = defaultdict(list)
        for fs_agent in self.report.agents_in_filesystem:
            fs_by_company[fs_agent.company_name].append(fs_agent)
        
        db_by_company = defaultdict(list)
        for db_agent in self.report.agents_in_database:
            # Find company name from config
            for slug, config in self.COMPANIES_CONFIG.items():
                if config['id'] == db_agent.company_id:
                    db_by_company[config['name']].append(db_agent)
                    break
        
        missing_by_company = defaultdict(list)
        for fs_agent in self.report.missing_agents:
            missing_by_company[fs_agent.company_name].append(fs_agent)
        
        extra_by_company = defaultdict(list)
        for db_agent in self.report.extra_agents_in_database:
            for slug, config in self.COMPANIES_CONFIG.items():
                if config['id'] == db_agent.company_id:
                    extra_by_company[config['name']].append(db_agent)
                    break
        
        # Print summary for each company
        for company_name in sorted(self.COMPANIES_CONFIG.keys()):
            config = self.COMPANIES_CONFIG[company_name]
            display_name = config['name']
            
            fs_count = len(fs_by_company[display_name])
            db_count = len(db_by_company[display_name])
            missing_count = len(missing_by_company[display_name])
            extra_count = len(extra_by_company[display_name])
            
            lines.append(f"### {display_name}")
            lines.append(f"| Metric | Count |")
            lines.append(f"|--------|-------|")
            lines.append(f"| Filesystem agents | {fs_count} |")
            lines.append(f"| Database agents | {db_count} |")
            lines.append(f"| Missing (need to add) | {missing_count} |")
            lines.append(f"| Extra (in DB only) | {extra_count} |")
            
            if missing_count > 0:
                lines.append(f"|")
                lines.append(f"| **Missing agents:** |")
                for agent in missing_by_company[display_name][:10]:  # Show first 10
                    lines.append(f"| - {agent.name} |")
                if missing_count > 10:
                    lines.append(f"| ... and {missing_count - 10} more |")
            
            lines.append("")
        
        # Totals
        lines.append("=" * 80)
        lines.append("TOTALS")
        lines.append("=" * 80)
        lines.append(f"| Company | FS | DB | Missing | Extra |")
        lines.append(f"|---------|----|----|---------|-------|")
        
        total_fs = 0
        total_db = 0
        total_missing = 0
        total_extra = 0
        
        for company_name in sorted(self.COMPANIES_CONFIG.keys()):
            config = self.COMPANIES_CONFIG[company_name]
            display_name = config['name']
            
            fs_count = len(fs_by_company[display_name])
            db_count = len(db_by_company[display_name])
            missing_count = len(missing_by_company[display_name])
            extra_count = len(extra_by_company[display_name])
            
            total_fs += fs_count
            total_db += db_count
            total_missing += missing_count
            total_extra += extra_count
            
            lines.append(f"| {display_name} | {fs_count} | {db_count} | {missing_count} | {extra_count} |")
        
        lines.append(f"| **TOTAL** | **{total_fs}** | **{total_db}** | **{total_missing}** | **{total_extra}** |")
        lines.append("")
        
        return '\n'.join(lines)


def main():
    """Main entry point."""
    agent = ReconciliationAgent()
    
    try:
        report = agent.run()
        print("\n" + report.summary())
        
        # Print company summary
        print("\n" + agent.generate_company_summary())
        
        # Save outputs
        agent.save_sql_fixes()
        agent.save_report()
        
        print("\n📋 Next steps:")
        print("1. Review the generated SQL in reconciliation_fixes.sql")
        print("2. Run the SQL against your Supabase database")
        print("3. Re-run this script to verify fixes")
        
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == '__main__':
    main()
