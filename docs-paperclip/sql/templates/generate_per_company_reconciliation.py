#!/usr/bin/env python3
"""
Generate per-company reconciliation SQL files from AGENTS.md frontmatter.

This script reads all AGENTS.md files from docs-paperclip/companies/*/agents/*/
and generates separate SQL files per company with correct human-readable names.

Usage: python3 generate_per_company_reconciliation.py
Output: docs-paperclip/sql/per-company/*.sql
"""

import os
import re
import yaml
import json
from pathlib import Path

BASE_DIR = Path("/Users/_A_QA of code/paperclip-render")
COMPANIES_DIR = BASE_DIR / "docs-paperclip" / "companies"
OUTPUT_DIR = BASE_DIR / "docs-paperclip" / "sql" / "per-company"

# Company ID mappings (from the existing SQL template)
COMPANY_IDS = {
    "contentforge-ai": "550e8400-e29b-41d4-a716-446655440008",
    "devforge-ai": "f97b30e8-b022-4350-b4b0-30d43e2ebcf4",
    "domainforge-ai": "2d7d9c60-c02f-42a7-8f6a-7db86ecc879d",
    "execforge-ai": "550e8400-e29b-41d4-a716-446655440010",
    "infraforge-ai": "09f438a3-4041-46f2-b3cc-96fc9446e666",
    "integrateforge-ai": "550e8400-e29b-41d4-a716-446655440000",
    "knowledgeforge-ai": "c4d52645-a0ea-4a26-b381-baf0b3042f34",
    "learningforge-ai": "2bda2da6-dfa7-4709-b5d1-ea865f14072a",
    "loopy-ai": "0a40625e-78f9-4b0a-82e4-169a8befa021",
    "measureforge-ai": "550e8400-e29b-41d4-a716-446655440013",
    "mobileforge-ai": "550e8400-e29b-41d4-a716-446655440009",
    "paperclipforge-ai": "550e8400-e29b-41d4-a716-446655440014",
    "promptforge-ai": "f02b83a8-e0db-4332-b507-22f85e71ebf5",
    "qualityforge-ai": "f535f9bc-00be-4b6d-9f53-c53abfacacef",
    "saasforge-ai": "550e8400-e29b-41d4-a716-446655440011",
    "voiceforge-ai": "550e8400-e29b-41d4-a716-446655440012",
    "construct-ai": None,  # No company ID found
}

def parse_yaml_frontmatter(filepath):
    """Parse YAML frontmatter from an AGENTS.md file."""
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Extract YAML frontmatter between --- markers
    match = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
    if not match:
        return {}
    
    yaml_content = match.group(1)
    try:
        data = yaml.safe_load(yaml_content)
        return data if data else {}
    except yaml.YAMLError as e:
        print(f"  WARNING: YAML parse error in {filepath}: {e}")
        return {}

def extract_agents_from_company(company_slug):
    """Extract all agents from a company directory."""
    company_dir = COMPANIES_DIR / company_slug / "agents"
    if not company_dir.exists():
        print(f"  SKIP: {company_dir} does not exist")
        return []
    
    agents = []
    for agent_dir in sorted(company_dir.iterdir()):
        if not agent_dir.is_dir():
            continue
        agents_md = agent_dir / "AGENTS.md"
        if not agents_md.exists():
            print(f"  SKIP: {agents_md} does not exist")
            continue
        
        data = parse_yaml_frontmatter(agents_md)
        if not data:
            print(f"  WARNING: No frontmatter in {agents_md}")
            continue
        
        name = data.get("name", "")
        slug = data.get("slug", "")
        title = data.get("title", slug)
        
        if not name:
            # Fall back to folder name
            name = agent_dir.name.replace(f"{company_slug}-", "").replace("-", " ").title()
        
        if not slug:
            slug = agent_dir.name.lower()
        
        agents.append({
            "name": name,
            "slug": slug,
            "title": title,
            "folder": agent_dir.name,
        })
    
    return agents

def generate_company_sql(company_slug, company_id, agents):
    """Generate SQL for a single company."""
    if not company_id:
        return f"-- SKIPPED: No company ID for {company_slug}\n"
    
    lines = []
    lines.append(f"-- ============================================================")
    lines.append(f"-- RECONCILIATION SQL FOR: {company_slug}")
    lines.append(f"-- Company ID: {company_id}")
    lines.append(f"-- Generated: {os.path.basename(__file__)}")
    lines.append(f"-- ============================================================")
    lines.append("")
    lines.append("BEGIN;")
    lines.append("")
    
    # Phase 1: Delete existing agents for this company
    lines.append(f"-- Phase 1: Delete existing agents for {company_slug}")
    lines.append(f"DELETE FROM agent_api_keys WHERE company_id = '{company_id}';")
    lines.append(f"DELETE FROM agent_task_sessions WHERE agent_id IN (SELECT id FROM agents WHERE company_id = '{company_id}');")
    lines.append(f"DELETE FROM agent_runtime_state WHERE agent_id IN (SELECT id FROM agents WHERE company_id = '{company_id}');")
    lines.append(f"DELETE FROM agent_wakeup_requests WHERE agent_id IN (SELECT id FROM agents WHERE company_id = '{company_id}');")
    lines.append(f"DELETE FROM agent_skill_assignments WHERE agent_id IN (SELECT id FROM agents WHERE company_id = '{company_id}');")
    lines.append(f"DELETE FROM agents WHERE company_id = '{company_id}';")
    lines.append("")
    
    # Phase 2: Insert agents with correct names
    lines.append(f"-- Phase 2: Insert agents for {company_slug}")
    lines.append("")
    
    for agent in agents:
        name = agent["name"].replace("'", "''")
        slug = agent["slug"]
        title = agent["title"].replace("'", "''") if agent["title"] else slug
        
        lines.append(f"-- Agent: {name} ({slug})")
        lines.append(f"-- Folder: {agent['folder']}")
        lines.append(f"INSERT INTO agents (id, company_id, name, role, title, status, capabilities, adapter_type, adapter_config, runtime_config, created_at, updated_at)")
        lines.append(f"VALUES (")
        lines.append(f"    gen_random_uuid(),")
        lines.append(f"    '{company_id}',")
        lines.append(f"    '{name}',")
        lines.append(f"    'general',")
        lines.append(f"    '{slug}',")
        lines.append(f"    'idle',")
        lines.append(f"    '[\"task_execution\", \"communication\", \"analysis\"]',")
        lines.append(f"    'hermes_local',")
        lines.append(f"    '{{\"adapter\": \"hermes_local\", \"model\": \"deepseek/deepseek-v4-flash\"}}'::jsonb,")
        lines.append(f"    '{{}}'::jsonb,")
        lines.append(f"    NOW(),")
        lines.append(f"    NOW()")
        lines.append(f");")
        lines.append("")
    
    lines.append("COMMIT;")
    lines.append("")
    
    return "\n".join(lines)

def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    # Get all company directories
    company_dirs = sorted([d.name for d in COMPANIES_DIR.iterdir() if d.is_dir() and d.name not in ("shared", "README.md")])
    
    for company_slug in company_dirs:
        company_id = COMPANY_IDS.get(company_slug)
        print(f"\nProcessing: {company_slug} (ID: {company_id})")
        
        agents = extract_agents_from_company(company_slug)
        print(f"  Found {len(agents)} agents")
        
        if not agents:
            print(f"  SKIP: No agents found")
            continue
        
        sql = generate_company_sql(company_slug, company_id, agents)
        
        output_file = OUTPUT_DIR / f"{company_slug}.sql"
        with open(output_file, 'w') as f:
            f.write(sql)
        print(f"  Wrote: {output_file}")
    
    print(f"\nDone! Generated SQL files in {OUTPUT_DIR}")

if __name__ == "__main__":
    main()