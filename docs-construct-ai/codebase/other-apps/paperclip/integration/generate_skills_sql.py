#!/usr/bin/env python3
"""
Generate SQL files for Supabase with full customized skill content.
Reads all SKILL.md files and generates INSERT statements with complete markdown.
"""

import os
import re
import json
from datetime import datetime

# Script is at: construct-ai-docs/codebase/other-apps/paperclip/integration/generate_skills_sql.py
# Skills are at: construct-ai-docs/skills/
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
# Go up 4 levels to construct-ai-docs root
CONSTRUCT_AI_DOCS = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(SCRIPT_DIR))))
SKILLS_DIR = os.path.join(CONSTRUCT_AI_DOCS, "skills")
OUTPUT_DIR = os.path.dirname(os.path.abspath(__file__))

# Company ID mapping (from actual Supabase companies table)
COMPANY_IDS = {
    "devforge-ai": "f97b30e8-b022-4350-b4b0-30d43e2ebcf4",
    "promptforge-ai": "9ec4c0ec-d8f1-48ab-b473-ec164b584129",
    "qualityforge-ai": "f535f9bc-00be-4b6d-9f53-c53abfacacef",
    "domainforge-ai": "2d7d9c60-c02f-42a7-8f6a-7db86ecc879d",
    "loopy-ai": "0a40625e-78f9-4b0a-82e4-169a8befa021",
    "infraforge-ai": "09f438a3-4041-46f2-b3cc-96fc9446e666",
}

COMPANY_NAMES = {
    "devforge-ai": "DevForge AI",
    "promptforge-ai": "PromptForge AI",
    "qualityforge-ai": "QualityForge AI",
    "domainforge-ai": "DomainForge AI",
    "loopy-ai": "Loopy AI",
    "infraforge-ai": "InfraForge AI",
}

def escape_sql_string(s):
    """Escape single quotes for SQL."""
    return s.replace("'", "''")

def read_skill_file(filepath):
    """Read a SKILL.md file and return its content."""
    try:
        with open(filepath, 'r') as f:
            return f.read()
    except Exception as e:
        print(f"  Warning: Could not read {filepath}: {e}")
        return None

def parse_frontmatter(content):
    """Parse YAML frontmatter from markdown content."""
    match = re.match(r'^---\n(.*?)\n---\n(.*)', content, re.DOTALL)
    if match:
        frontmatter = match.group(1)
        body = match.group(2).strip()
        # Simple parsing
        name = ""
        description = ""
        for line in frontmatter.split('\n'):
            if line.startswith('name:'):
                name = line.split(':', 1)[1].strip()
            elif line.startswith('description:'):
                description = line.split(':', 1)[1].strip()
        return name, description, body
    return "", "", content

def generate_insert_statement(company_id, key, slug, name, description, markdown, relative_path):
    """Generate a SQL INSERT statement."""
    escaped_markdown = escape_sql_string(markdown)
    escaped_description = escape_sql_string(description)
    escaped_name = escape_sql_string(name)
    
    return f"""INSERT INTO company_skills (id, company_id, key, slug, name, description, markdown, source_type, source_locator, trust_level, compatibility, file_inventory, created_at, updated_at) VALUES
(gen_random_uuid(), '{company_id}', '{key}', '{slug}', '{escaped_name}', '{escaped_description}', '{escaped_markdown}', 'local_path', '{relative_path}', 'markdown_only', 'compatible', '[]'::jsonb, NOW(), NOW()) ON CONFLICT (company_id, key) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description, markdown = EXCLUDED.markdown, updated_at = NOW();
"""

def collect_skills():
    """Collect all skills from the skills directory."""
    all_skills = {}  # company_folder -> [(key, slug, name, description, markdown, relative_path)]
    
    for company_folder in sorted(os.listdir(SKILLS_DIR)):
        company_path = os.path.join(SKILLS_DIR, company_folder)
        if not os.path.isdir(company_path):
            continue
        
        if company_folder not in COMPANY_IDS and company_folder != "shared":
            continue
        
        skills = []
        for skill_dir in sorted(os.listdir(company_path)):
            skill_path = os.path.join(company_path, skill_dir)
            skill_file = os.path.join(skill_path, "SKILL.md")
            
            if not os.path.isfile(skill_file):
                continue
            
            content = read_skill_file(skill_file)
            if content is None:
                continue
            
            name, description, body = parse_frontmatter(content)
            
            # Use the directory name as key/slug if frontmatter name is empty
            key = skill_dir
            slug = skill_dir
            if name:
                key = name
                slug = name
            
            # Use full markdown content
            markdown = content
            
            relative_path = f"/skills/{company_folder}/{skill_dir}/SKILL.md"
            
            skills.append((key, slug, name, description, markdown, relative_path))
        
        if skills:
            all_skills[company_folder] = skills
    
    return all_skills

def generate_all_company_skills(all_skills):
    """Generate ALL_COMPANY_SKILLS.sql with full content."""
    output_path = os.path.join(OUTPUT_DIR, "ALL_COMPANY_SKILLS.sql")
    
    total_skills = sum(len(s) for s in all_skills.values())
    
    with open(output_path, 'w') as f:
        f.write(f"-- =====================================================\n")
        f.write(f"-- Auto-generated: All Company Skills for Supabase\n")
        f.write(f"-- Generated: {datetime.now().isoformat()}\n")
        f.write(f"-- Total: {total_skills} skills across {len(all_skills)} companies\n")
        f.write(f"-- NOTE: Contains FULL customized markdown content\n")
        f.write(f"-- =====================================================\n\n")
        
        for company_folder, skills in all_skills.items():
            if company_folder == "shared":
                continue
            
            company_id = COMPANY_IDS.get(company_folder, "")
            company_name = COMPANY_NAMES.get(company_folder, company_folder)
            
            f.write(f"-- {company_name} Skills ({len(skills)} skills)\n\n")
            
            for key, slug, name, description, markdown, relative_path in skills:
                stmt = generate_insert_statement(company_id, key, slug, name, description, markdown, relative_path)
                f.write(stmt)
                f.write("\n")
            
            f.write("\n")
    
    print(f"Generated {output_path} with {total_skills - len(all_skills.get('shared', []))} skills")

def generate_all_skills(all_skills):
    """Generate ALL_SKILLS.sql including shared skills."""
    output_path = os.path.join(OUTPUT_DIR, "ALL_SKILLS.sql")
    
    total_skills = sum(len(s) for s in all_skills.values())
    
    with open(output_path, 'w') as f:
        f.write(f"-- =====================================================\n")
        f.write(f"-- Auto-generated: All Skills for Supabase (Companies + Shared)\n")
        f.write(f"-- Generated: {datetime.now().isoformat()}\n")
        f.write(f"-- Total: {total_skills} skills\n")
        f.write(f"-- NOTE: Contains FULL customized markdown content\n")
        f.write(f"-- =====================================================\n\n")
        
        # Company skills
        for company_folder, skills in all_skills.items():
            if company_folder == "shared":
                continue
            
            company_id = COMPANY_IDS.get(company_folder, "")
            company_name = COMPANY_NAMES.get(company_folder, company_folder)
            
            f.write(f"-- {company_name} Skills ({len(skills)} skills)\n\n")
            
            for key, slug, name, description, markdown, relative_path in skills:
                stmt = generate_insert_statement(company_id, key, slug, name, description, markdown, relative_path)
                f.write(stmt)
                f.write("\n")
            
            f.write("\n")
        
        # Shared skills
        if "shared" in all_skills:
            f.write(f"-- Shared Skills ({len(all_skills['shared'])} skills)\n\n")
            for key, slug, name, description, markdown, relative_path in all_skills["shared"]:
                stmt = generate_insert_statement("", key, slug, name, description, markdown, relative_path)
                # Shared skills don't have company_id
                stmt = stmt.replace("('', '", "(gen_random_uuid(), '', ")
                f.write(stmt)
                f.write("\n")
    
    print(f"Generated {output_path} with {total_skills} skills")

def generate_skill_registry(all_skills):
    """Generate SKILL_REGISTRY.md with summary."""
    output_path = os.path.join(OUTPUT_DIR, "SKILL_REGISTRY.md")
    
    with open(output_path, 'w') as f:
        f.write(f"# Skill Registry\n\n")
        f.write(f"Generated: {datetime.now().isoformat()}\n\n")
        f.write(f"## Summary\n\n")
        
        total = sum(len(s) for s in all_skills.values())
        f.write(f"| Company | Skills |\n")
        f.write(f"|---------|--------|\n")
        
        for company_folder, skills in sorted(all_skills.items()):
            company_name = COMPANY_NAMES.get(company_folder, company_folder.title())
            f.write(f"| {company_name} | {len(skills)} |\n")
        
        f.write(f"| **TOTAL** | **{total}** |\n")
        
        f.write(f"\n## SQL Files\n\n")
        f.write(f"- `ALL_COMPANY_SKILLS.sql` - Company-specific skills with full markdown\n")
        f.write(f"- `ALL_SKILLS.sql` - All skills including shared\n")
        f.write(f"- `DOMAIN_SKILLS.sql` - DomainForge engineering skills\n")
    
    print(f"Generated {output_path}")

def main():
    print("Collecting skills from markdown files...")
    all_skills = collect_skills()
    
    total = sum(len(s) for s in all_skills.values())
    print(f"Found {total} skills across {len(all_skills)} directories")
    
    print("\nGenerating SQL files with full customized content...")
    generate_all_company_skills(all_skills)
    generate_all_skills(all_skills)
    generate_skill_registry(all_skills)
    
    print("\nDone! SQL files ready for Supabase.")

if __name__ == "__main__":
    main()