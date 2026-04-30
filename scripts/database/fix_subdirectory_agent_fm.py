#!/usr/bin/env python3
"""
Fix AGENTS.md frontmatter for agents in subdirectories that were missed by Phase 1.

Two categories of issues:
1. YAML frontmatter exists but is malformed (bare unkeyed scalar values) — 54 files
2. YAML frontmatter valid but missing 'slug' key — 4 files

Fix strategy:
- Remove bare/unkeyed scalar lines from frontmatter
- Ensure 'name' key is populated (use slug value if name is empty)
- Ensure 'slug' key exists (derive from folder name if missing)
"""
import os
import re
import yaml

base = 'docs-paperclip/companies'

def kebab(s):
    """Convert PascalCase or spaces to kebab-case."""
    s = re.sub(r'([a-z])([A-Z])', r'\1-\2', s)
    s = re.sub(r'[\s_]+', '-', s)
    return s.lower().strip('-')

def fix_frontmatter_block(fm_text, folder_name):
    """
    Fix a YAML frontmatter text block.
    Returns (fixed_text, report_line).
    """
    lines = fm_text.strip().split('\n')
    fixed_lines = []
    bare_values = []
    seen_keys = set()
    actions = []

    for line in lines:
        # Check if this line has a key: value structure
        kv_match = re.match(r'^(\s*)([a-zA-Z_][a-zA-Z0-9_]*)\s*:\s*(.*)', line)
        if kv_match:
            indent, key, value = kv_match.groups()
            seen_keys.add(key)
            fixed_lines.append(line)
        elif line.strip() == '':
            fixed_lines.append(line)
        else:
            # Bare scalar value — capture and remove
            bare_values.append(line.strip())

    # Now determine name and slug
    # Find 'name' value in the fixed lines
    has_name = 'name' in seen_keys
    has_slug = 'slug' in seen_keys

    # Find current values
    name_val = None
    slug_val = None
    for line in fixed_lines:
        m = re.match(r'^name\s*:\s*(.*)', line)
        if m:
            name_val = m.group(1).strip()
        m = re.match(r'^slug\s*:\s*(.*)', line)
        if m:
            slug_val = m.group(1).strip()

    # Derive slug from folder name (PascalCase → kebab-case)
    derived_slug = kebab(folder_name)

    # Decide what slug should be
    if has_slug and slug_val:
        final_slug = slug_val  # Keep existing
    elif bare_values:
        # Use the first bare value as slug
        final_slug = bare_values[0]
    else:
        final_slug = derived_slug

    # Decide what name should be
    if has_name and name_val:
        final_name = name_val  # Keep existing
    else:
        final_name = final_slug  # Use slug as name

    # Build the new frontmatter
    new_lines = []
    has_added_name = False
    has_added_slug = False

    for line in fixed_lines:
        m_name = re.match(r'^name\s*:.*', line)
        m_slug = re.match(r'^slug\s*:.*', line)

        if m_name:
            new_lines.append(f'name: {final_name}')
            has_added_name = True
            if name_val != final_name:
                actions.append(f'name: "{name_val}" → "{final_name}"')
        elif m_slug:
            new_lines.append(f'slug: {final_slug}')
            has_added_slug = True
            if slug_val != final_slug:
                actions.append(f'slug: "{slug_val}" → "{final_slug}"')
        else:
            new_lines.append(line)

    if not has_added_name:
        # Insert name after first --- line? Actually add at top of frontmatter
        new_lines.insert(0, f'name: {final_name}')
        actions.append(f'+ name: {final_name}')

    if not has_added_slug:
        new_lines.insert(1, f'slug: {final_slug}')
        actions.append(f'+ slug: {final_slug}')

    if bare_values:
        actions.append(f'removed bare: {bare_values}')

    return '\n'.join(new_lines), actions


def fix_file(filepath):
    """Read, fix frontmatter, and write back an AGENTS.md file."""
    with open(filepath, 'r') as f:
        content = f.read()

    # Extract frontmatter block
    fm_match = re.match(r'^---\s*\n(.*?)\n---', content, re.DOTALL)
    if not fm_match:
        # No frontmatter at all — check if file starts with heading
        # Derive name from folder
        folder_name = os.path.basename(os.path.dirname(filepath))
        derived_slug = kebab(folder_name)
        new_fm = f'---\nname: {derived_slug}\nslug: {derived_slug}\n---\n'
        new_content = new_fm + content
        rel = os.path.relpath(filepath, base)
        return f'CREATED FM: {rel} → name/slug: {derived_slug}', new_content

    fm_text = fm_match.group(1)
    body = content[fm_match.end():]

    # Can we parse the YAML successfully?
    try:
        yaml.safe_load(fm_text)
        # YAML parses fine — check if slug is present
        if 'slug:' not in fm_text:
            folder_name = os.path.basename(os.path.dirname(filepath))
            fixed_fm, actions = fix_frontmatter_block(fm_text, folder_name)
            new_content = f'---\n{fixed_fm}\n---\n{body}'
            rel = os.path.relpath(filepath, base)
            return f'FIXED (missing slug): {rel} — {actions}', new_content
        else:
            return None, None  # File is fine
    except yaml.YAMLError:
        pass
    except Exception:
        pass

    # YAML is malformed — fix it
    folder_name = os.path.basename(os.path.dirname(filepath))
    fixed_fm, actions = fix_frontmatter_block(fm_text, folder_name)
    new_content = f'---\n{fixed_fm}\n---\n{body}'
    rel = os.path.relpath(filepath, base)
    return f'FIXED (malformed): {rel} — {actions}', new_content


def main():
    reports = []
    fixed_count = 0

    for company in sorted(os.listdir(base)):
        agents_dir = os.path.join(base, company, 'agents')
        if not os.path.isdir(agents_dir):
            continue

        for root, dirs, files in os.walk(agents_dir):
            for f in files:
                if f == 'AGENTS.md':
                    filepath = os.path.join(root, f)
                    report, new_content = fix_file(filepath)
                    if report and new_content:
                        with open(filepath, 'w') as fh:
                            fh.write(new_content)
                        reports.append(report)
                        fixed_count += 1

    print(f'\n=== FIXED {fixed_count} FILES ===')
    for r in reports:
        print(f'  {r}')

    print(f'\nTotal: {fixed_count} files fixed.')


if __name__ == '__main__':
    main()