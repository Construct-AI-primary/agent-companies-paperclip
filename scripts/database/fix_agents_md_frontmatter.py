#!/usr/bin/env python3
"""
Fix AGENTS.md frontmatter for a given company.
- Populates empty `name:` field from `human_name:` or directory name
- Ensures `slug:` field exists (from directory name)
- Fixes malformed frontmatter (bare strings without keys, missing role)
- Validates `name:` < 23 characters

Usage: python3 fix_agents_md_frontmatter.py <company-slug> [--dry-run]
Example: python3 fix_agents_md_frontmatter.py contentforge-ai
"""

import os
import sys
import re
import glob
from pathlib import Path

# Maximum allowed length for funky human name
MAX_NAME_LENGTH = 22  # < 23


def parse_frontmatter(content):
    """Extract YAML frontmatter between first pair of --- markers."""
    pattern = r'^---\s*\n(.*?)\n---'
    match = re.search(pattern, content, re.DOTALL)
    if not match:
        return None, content, 0, 0
    return match.group(1), content, match.start(), match.end()


def parse_human_name(fm_text):
    """Extract human_name value from frontmatter text."""
    # Match: human_name: Some Name
    match = re.search(r'^human_name:\s*(.+)$', fm_text, re.MULTILINE)
    if match:
        return match.group(1).strip()
    return None


def parse_name(fm_text):
    """Extract name value from frontmatter text."""
    match = re.search(r'^name:[^\S\n]*(.*)$', fm_text, re.MULTILINE)
    if match:
        val = match.group(1).strip()
        return val if val else None  # None if empty
    return None


def parse_slug(fm_text):
    """Extract slug value from frontmatter text."""
    match = re.search(r'^slug:\s*(.+)$', fm_text, re.MULTILINE)
    if match:
        return match.group(1).strip()
    return None


def parse_role(fm_text):
    """Extract role value from frontmatter text."""
    match = re.search(r'^role:\s*(.+)$', fm_text, re.MULTILINE)
    if match:
        return match.group(1).strip()
    return None


def parse_reports_to(fm_text):
    """Extract reportsTo value from frontmatter text."""
    match = re.search(r'^reportsTo:\s*(.+)$', fm_text, re.MULTILINE)
    if match:
        return match.group(1).strip()
    return None


def parse_team(fm_text):
    """Extract team value from frontmatter text."""
    match = re.search(r'^team:\s*(.+)$', fm_text, re.MULTILINE)
    if match:
        return match.group(1).strip()
    return None


def parse_description(fm_text):
    """Extract description value from frontmatter text (can be multiline with >)."""
    # Match description with > for multiline
    match = re.search(r'^description:\s*>\s*\n((?:\s{2}.+\n?)*)', fm_text, re.MULTILINE)
    if match:
        return match.group(0).strip()
    # Match single-line description
    match = re.search(r'^description:\s*(.+)$', fm_text, re.MULTILINE)
    if match:
        return match.group(0).strip()
    return None


def parse_skills(fm_text):
    """Extract skills list from frontmatter text."""
    in_skills = False
    skills_lines = []
    for line in fm_text.split('\n'):
        if line.startswith('skills:'):
            in_skills = True
            # Check if inline list
            rest = line[7:].strip()
            if rest:
                skills_lines.append(line)
                in_skills = False
            continue
        if in_skills:
            if line.startswith('  - '):
                skills_lines.append(line)
            else:
                in_skills = False
    return '\n'.join(skills_lines) if skills_lines else None


def find_existing_fields(fm_text):
    """Find all existing top-level field names in frontmatter."""
    fields = set()
    for line in fm_text.split('\n'):
        # Match simple key: value
        match = re.match(r'^(\w[\w-]*)\s*:', line)
        if match:
            fields.add(match.group(1))
    return fields


def find_bare_strings(fm_text):
    """Find lines that are bare strings (no key: value format) in frontmatter.
    Returns list of (line_content, line_index_in_fm)."""
    bare = []
    for i, line in enumerate(fm_text.split('\n')):
        stripped = line.strip()
        if not stripped:
            continue
        # Skip lines with key: value format
        if re.match(r'^\w[\w-]*\s*:', line):
            continue
        # Skip list items
        if line.startswith('  - '):
            continue
        # Skip description continuation lines (indented after >)
        if line.startswith('  ') and not line.startswith('  - '):
            continue
        # This is a bare string
        bare.append((stripped, i))
    return bare


def derive_name_from_slug(dir_name, company_slug):
    """Derive a human-readable name from directory name.
    e.g. contentforge-ai-BlogArchitect -> Blog Architect"""
    # Strip company prefix
    prefix = company_slug + '-'
    if dir_name.startswith(prefix):
        name_part = dir_name[len(prefix):]
    else:
        name_part = dir_name

    # Convert PascalCase or kebab-case to words
    # Insert spaces before capitals
    name = re.sub(r'([A-Z])', r' \1', name_part).strip()
    # Replace hyphens with spaces
    name = name.replace('-', ' ')
    # Clean up multiple spaces
    name = re.sub(r'\s+', ' ', name).strip()
    return name


def derive_role_from_title(content):
    """Extract role/title from body content if available."""
    # Try to find **Role:** or **Title:** patterns
    match = re.search(r'\*\*Role:\*\*\s*(.+?)(?:\n|$)', content)
    if match:
        return match.group(1).strip()
    match = re.search(r'\*\*Title:\*\*\s*(.+?)(?:\n|$)', content)
    if match:
        return match.group(1).strip()
    return None


def truncate_name(name, max_len=MAX_NAME_LENGTH):
    """Truncate name to max_len characters, preserving words."""
    if len(name) <= max_len:
        return name
    # Try to truncate at word boundary
    truncated = name[:max_len]
    # Find last space
    last_space = truncated.rfind(' ')
    if last_space > max_len // 2:
        return name[:last_space]
    return truncated


def rebuild_frontmatter(fm_lines, fields_to_set):
    """Rebuild frontmatter lines with fixed fields.
    fields_to_set: list of (field_name, value) tuples in desired order."""
    # Get existing lines as a dict
    existing = {}
    skills_lines = []
    desc_lines = []
    other_lines = []
    in_skills = False
    in_desc = False

    for line in fm_lines:
        stripped = line.strip()
        if not stripped:
            other_lines.append(line)
            continue

        # Check for skills block
        if line.startswith('skills:'):
            in_skills = True
            other_lines.append(line)
            continue
        if in_skills and line.startswith('  - '):
            skills_lines.append(line)
            continue
        if in_skills:
            in_skills = False

        # Check for description block
        if line.startswith('description:'):
            in_desc = True
            other_lines.append(line)
            continue
        if in_desc and line.startswith('  '):
            desc_lines.append(line)
            continue
        if in_desc:
            in_desc = False

        # Check for key: value
        match = re.match(r'^(\w[\w-]*)\s*:(.*)$', line)
        if match:
            key = match.group(1)
            if key not in fields_to_set:  # Don't overwrite fields we're fixing
                existing[key] = line
        elif not line.startswith('  - '):
            # Bare string - skip it
            continue
        else:
            other_lines.append(line)

    # Build new frontmatter
    result_lines = []
    seen_keys = set()

    for field_name, value in fields_to_set:
        if field_name == 'skills':
            result_lines.append(f'skills:')
            for skill in value:
                result_lines.append(f'  - {skill}')
        elif field_name == 'description':
            # Handle multiline description
            if '\n' in value:
                result_lines.append(value)
            else:
                result_lines.append(f'{field_name}: {value}')
        else:
            result_lines.append(f'{field_name}: {value}')
        seen_keys.add(field_name)

    # Add remaining existing fields (not already set)
    for key, line in existing.items():
        if key not in seen_keys:
            result_lines.append(line)

    return '\n'.join(result_lines)


def fix_file(filepath, company_slug, dry_run=False):
    """Fix a single AGENTS.md file."""
    dir_name = os.path.basename(os.path.dirname(filepath))

    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    fm_text, _, fm_start, fm_end = parse_frontmatter(content)
    if fm_text is None:
        print(f"  SKIP: No frontmatter found")
        return {'file': filepath, 'status': 'no_frontmatter', 'changes': []}

    fm_lines = fm_text.split('\n')
    changes = []

    # 1. Check and fix name
    current_name = parse_name(fm_text)
    human_name = parse_human_name(fm_text)

    if current_name is None or current_name == '':
        # Name is missing or empty
        new_name = None
        if human_name:
            new_name = human_name
        else:
            new_name = derive_name_from_slug(dir_name, company_slug)

        if new_name:
            new_name = truncate_name(new_name)
            changes.append(('name', '', new_name))

    # 2. Check slug
    current_slug = parse_slug(fm_text)
    expected_slug = dir_name.lower()
    if current_slug is None:
        changes.append(('slug', None, expected_slug))

    # 3. Check role
    current_role = parse_role(fm_text)
    if current_role is None:
        derived_role = derive_role_from_title(content)
        if derived_role:
            changes.append(('role', None, derived_role))

    # 4. Check for bare strings (malformed entries)
    bare_strings = find_bare_strings(fm_text)
    if bare_strings:
        for bare, idx in bare_strings:
            # If it looks like a slug (lowercase with hyphens), treat as slug
            if re.match(r'^[a-z][a-z0-9-]*[a-z0-9]$', bare) and current_slug is None:
                pass  # Already handled by slug fix above
            changes.append(('bare_string_removed', bare, None))

    if not changes:
        print(f"  OK: No changes needed")
        return {'file': filepath, 'status': 'ok', 'changes': []}

    # Build new frontmatter
    if dry_run:
        for change in changes:
            if change[0] == 'bare_string_removed':
                print(f"  DRY-RUN: Remove bare string '{change[1]}'")
            else:
                print(f"  DRY-RUN: Set {change[0]} = '{change[2]}'")
        return {'file': filepath, 'status': 'would_fix', 'changes': changes}

    # Apply fixes - rebuild frontmatter
    # We need to actually modify fm_text and put it back
    new_fm_lines = []
    in_skills = False

    for line in fm_lines:
        stripped = line.strip()

        # Handle name: replacement
        if re.match(r'^name:\s*$', line) or re.match(r'^name:\s*', line):
            name_fix = [c for c in changes if c[0] == 'name']
            if name_fix:
                new_fm_lines.append(f'name: {name_fix[0][2]}')
                continue

        # Handle slug: replacement
        if line.startswith('slug:'):
            slug_fix = [c for c in changes if c[0] == 'slug']
            if slug_fix:
                new_fm_lines.append(f'slug: {slug_fix[0][2]}')
                continue

        # Handle missing slug - add it after name
        if line.startswith('human_name:') or line.startswith('name:'):
            new_fm_lines.append(line)
            # Check if slug needs to be inserted here
            slug_needed = any(c[0] == 'slug' and c[1] is None for c in changes)
            if slug_needed and 'slug_inserted' not in [c[0] for c in changes]:
                slug_fix = [c for c in changes if c[0] == 'slug']
                new_fm_lines.append(f'slug: {slug_fix[0][2]}')
                changes.append(('slug_inserted', None, None))
            continue

        # Handle role: replacement
        if line.startswith('role:'):
            role_fix = [c for c in changes if c[0] == 'role']
            if role_fix:
                new_fm_lines.append(f'role: {role_fix[0][2]}')
                continue

        # Skip bare strings
        is_bare = stripped and not re.match(r'^\w[\w-]*\s*:', line) and not line.startswith('  ')
        if is_bare:
            continue

        new_fm_lines.append(line)

    new_fm = '\n'.join(new_fm_lines)
    new_content = '---\n' + new_fm + '\n---' + content[fm_end:]

    # Write back
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)

    desc = ', '.join(f"{c[0]}={c[2]}" for c in changes if c[0] != 'slug_inserted')
    print(f"  FIXED: {desc}")
    return {'file': filepath, 'status': 'fixed', 'changes': changes}


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 fix_agents_md_frontmatter.py <company-slug> [--dry-run]")
        print("Example: python3 fix_agents_md_frontmatter.py contentforge-ai")
        sys.exit(1)

    company_slug = sys.argv[1]
    dry_run = '--dry-run' in sys.argv

    company_dir = f'docs-paperclip/companies/{company_slug}'
    agents_dir = f'{company_dir}/agents'

    if not os.path.isdir(agents_dir):
        print(f"ERROR: Directory not found: {agents_dir}")
        sys.exit(1)

    print(f"{'[DRY RUN] ' if dry_run else ''}Fixing AGENTS.md files for: {company_slug}")
    print(f"Directory: {agents_dir}")
    print()

    # Find all AGENTS.md files
    pattern = os.path.join(agents_dir, '*', 'AGENTS.md')
    files = sorted(glob.glob(pattern))

    if not files:
        print("No AGENTS.md files found!")
        sys.exit(1)

    print(f"Found {len(files)} agent files\n")

    results = []
    for filepath in files:
        agent_dir = os.path.basename(os.path.dirname(filepath))
        print(f"{agent_dir}/AGENTS.md:")
        result = fix_file(filepath, company_slug, dry_run)
        results.append(result)
        print()

    # Summary
    ok_count = sum(1 for r in results if r['status'] == 'ok')
    fixed_count = sum(1 for r in results if r['status'] in ('fixed', 'would_fix'))
    skip_count = sum(1 for r in results if r['status'] == 'no_frontmatter')

    print("=" * 60)
    print(f"SUMMARY ({'DRY RUN - ' if dry_run else ''}{company_slug}):")
    print(f"  OK:        {ok_count}")
    print(f"  {'Would fix' if dry_run else 'Fixed'}:  {fixed_count}")
    print(f"  Skipped:   {skip_count}")
    print(f"  Total:     {len(results)}")
    print()

    if not dry_run and fixed_count > 0:
        print(f"Run validation:")
        print(f"  python3 fix_agents_md_frontmatter.py {company_slug} --dry-run")
        print(f"  # Should show 0 files to fix if all corrections applied correctly")


if __name__ == '__main__':
    main()