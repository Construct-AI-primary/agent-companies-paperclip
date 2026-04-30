#!/usr/bin/env python3
"""
PROC-TRACK Issue Generator

This script generates issue files for the Order Tracking & Expediting Workflow project.

Usage:
    python generate-issues.py --type <issue_type> --title <title> --description <description>
"""

import argparse
import os
from datetime import datetime
from pathlib import Path

# Issue type configurations
ISSUE_TYPES = {
    "foundation": {
        "prefix": "TRACK-FOUND",
        "description": "Foundation and infrastructure issues"
    },
    "development": {
        "prefix": "TRACK-DEV",
        "description": "Core development issues"
    },
    "expediting": {
        "prefix": "TRACK-EXP",
        "description": "Expediting workflow issues"
    },
    "testing": {
        "prefix": "TRACK-TEST",
        "description": "Testing and validation issues"
    },
    "integration": {
        "prefix": "TRACK-INT",
        "description": "Integration issues"
    }
}

# Issue template
ISSUE_TEMPLATE = """---
title: "{title}"
description: "{description}"
author: Paperclip Orchestration System
date: {date}
project_code: PROC-TRACK
issue_number: {issue_number}
issue_type: {issue_type}
status: pending
---

# {title}

## Issue Overview

**Issue Number**: {issue_number}
**Type**: {issue_type}
**Status**: Pending
**Created**: {date}

## Description

{description}

## Acceptance Criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Dependencies

- None

## Notes

Additional notes and context for this issue.

---

**Issue Version**: 1.0
**Last Updated**: {date}
"""


def generate_issue_number(prefix, existing_issues_path):
    """Generate next issue number for a given prefix."""
    if not existing_issues_path.exists():
        return f"{prefix}-001"
    
    existing_files = list(existing_issues_path.glob(f"{prefix}-*.md"))
    if not existing_files:
        return f"{prefix}-001"
    
    # Extract existing numbers and find next
    numbers = []
    for f in existing_files:
        try:
            num_str = f.stem.split("-")[-1]
            numbers.append(int(num_str))
        except ValueError:
            continue
    
    next_num = max(numbers) + 1 if numbers else 1
    return f"{prefix}-{next_num:03d}"


def generate_issue_file(output_dir, issue_type, title, description):
    """Generate an issue file."""
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Ensure 'issues' subdirectory exists
    issues_dir = output_dir / "issues"
    issues_dir.mkdir(parents=True, exist_ok=True)
    
    # Get configuration for issue type
    config = ISSUE_TYPES.get(issue_type, ISSUE_TYPES["development"])
    prefix = config["prefix"]
    
    # Generate issue number
    issue_number = generate_issue_number(prefix, issues_dir)
    
    # Generate filename
    filename = f"{issue_number}.md"
    filepath = issues_dir / filename
    
    # Get current date
    date = datetime.now().strftime("%Y-%m-%d")
    
    # Generate content
    content = ISSUE_TEMPLATE.format(
        title=title,
        description=description,
        date=date,
        issue_number=issue_number,
        issue_type=issue_type
    )
    
    # Write file
    with open(filepath, "w") as f:
        f.write(content)
    
    print(f"Generated: {filepath}")
    return filepath


def main():
    parser = argparse.ArgumentParser(
        description="Generate PROC-TRACK issue files"
    )
    parser.add_argument(
        "--type",
        choices=list(ISSUE_TYPES.keys()),
        default="development",
        help="Issue type"
    )
    parser.add_argument(
        "--title",
        required=True,
        help="Issue title"
    )
    parser.add_argument(
        "--description",
        required=True,
        help="Issue description"
    )
    parser.add_argument(
        "--output",
        default=".",
        help="Output directory"
    )
    
    args = parser.parse_args()
    
    output_dir = Path(args.output)
    generate_issue_file(output_dir, args.type, args.title, args.description)


if __name__ == "__main__":
    main()
