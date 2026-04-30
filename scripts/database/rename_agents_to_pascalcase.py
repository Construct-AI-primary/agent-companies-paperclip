#!/usr/bin/env python3
"""
Rename Agent Folders to PascalCase
==================================
Converts all agent folder names from kebab-case to PascalCase.

Example:
- devforge-ai-nexus → devforge-ai-Nexus
- qualityforge-ai-code-analyzer → qualityforge-ai-CodeAnalyzer
- measureforge-ai-cad-measurement-orchestrator → measureforge-ai-CadMeasurementOrchestrator
"""

import os
import re
from pathlib import Path


def to_pascal_case(name: str) -> str:
    """Convert kebab-case to PascalCase."""
    # Split by hyphens and capitalize each word
    words = name.split('-')
    return ''.join(word.capitalize() for word in words)


def process_company(company_path: Path, dry_run: bool = True):
    """Process all agent directories in a company."""
    agents_path = company_path / "agents"
    if not agents_path.exists():
        return []
    
    changes = []
    
    # Find all directories in agents folder (including subdirectories)
    for item in agents_path.rglob("*"):
        if not item.is_dir():
            continue
        
        # Skip the agents folder itself
        if item.name == "agents":
            continue
        
        # Check if this is an agent directory (contains AGENTS.md)
        agents_md = item / "AGENTS.md"
        if not agents_md.exists():
            continue
        
        # Get the directory name and parent path
        dir_name = item.name
        parent_path = item.parent
        
        # Check if it follows the company-slug-name pattern
        # Pattern: {company-slug}-{name}
        company_slug = company_path.name  # e.g., "devforge-ai"
        prefix = f"{company_slug}-"
        
        if not dir_name.startswith(prefix):
            # Not a standard agent directory, skip
            continue
        
        # Extract the name part after the company slug
        name_part = dir_name[len(prefix):]
        
        # Skip if already PascalCase (first letter capitalized, rest lowercase)
        if name_part and name_part[0].isupper():
            continue
        
        # Convert to PascalCase
        new_name = to_pascal_case(name_part)
        new_dir_name = f"{company_slug}-{new_name}"
        
        if new_dir_name == dir_name:
            continue
        
        old_path = item
        new_path = item.parent.parent / new_dir_name if item.parent.name == "agents" else item.parent.parent / new_dir_name
        
        # Recalculate new path properly
        if item.parent == agents_path:
            new_path = agents_path / new_dir_name
        else:
            # It's in a subdirectory
            relative = item.relative_to(agents_path)
            new_path = agents_path / relative.parent / new_dir_name
        
        changes.append((old_path, new_path, dir_name, new_dir_name))
    
    return changes


def main():
    """Main entry point."""
    import sys
    
    companies_dir = Path("docs-paperclip/companies")
    auto_confirm = len(sys.argv) > 1 and sys.argv[1] == '--yes'
    
    all_changes = []
    
    print("Scanning for agent directories to rename...")
    print()
    
    for company_path in sorted(companies_dir.iterdir()):
        if not company_path.is_dir():
            continue
        
        changes = process_company(company_path)
        all_changes.extend(changes)
    
    print(f"Found {len(all_changes)} directories to rename")
    print()
    
    # Show first 20 changes
    print("First 20 changes:")
    for old, new, old_name, new_name in all_changes[:20]:
        print(f"  {old_name}")
        print(f"    → {new_name}")
    print()
    
    if len(all_changes) > 20:
        print(f"  ... and {len(all_changes) - 20} more")
        print()
    
    # Ask for confirmation unless --yes flag is passed
    if not auto_confirm:
        response = input("Proceed with renaming? (y/n): ").strip().lower()
        
        if response != 'y':
            print("Aborted.")
            return
    else:
        print("Auto-confirming (--yes flag passed)")
        print()
    
    # Perform renames
    print()
    print("Renaming directories...")
    
    for old, new, old_name, new_name in all_changes:
        try:
            old.rename(new)
            print(f"  ✓ {old_name} → {new_name}")
        except Exception as e:
            print(f"  ✗ Failed to rename {old_name}: {e}")
    
    print()
    print(f"Renamed {len(all_changes)} directories to PascalCase")


if __name__ == '__main__':
    main()
