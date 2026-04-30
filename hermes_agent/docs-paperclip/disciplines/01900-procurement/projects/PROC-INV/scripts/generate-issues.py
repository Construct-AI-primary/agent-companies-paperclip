#!/usr/bin/env python3
"""
PROC-INV Issue Generation Script

This script generates project issues for the Invoice Processing & 3-Way Match Workflow project.
It creates standardized issue files based on project requirements and milestones.

Usage:
    python generate-issues.py [--project PROJECT_CODE] [--phase PHASE]

Author: Paperclip Orchestration System
Date: 2026-04-08
Version: 1.0
"""

import os
import sys
import argparse
from datetime import datetime
from pathlib import Path

# Configuration
PROJECT_CODE = "PROC-INV"
DISCIPLINE = "01900-procurement"
ISSUES_DIR = Path(__file__).parent.parent / "issues"

# Issue Templates
ISSUE_TEMPLATES = {
    "analysis": {
        "title": "Analysis & Design Phase - {description}",
        "priority": "high",
        "phase": 1,
        "milestone": "Design Complete"
    },
    "core": {
        "title": "Core Development Phase - {description}",
        "priority": "high",
        "phase": 2,
        "milestone": "Core Development Complete"
    },
    "integration": {
        "title": "Integration Phase - {description}",
        "priority": "medium",
        "phase": 3,
        "milestone": "Integration Complete"
    },
    "testing": {
        "title": "Testing Phase - {description}",
        "priority": "medium",
        "phase": 3,
        "milestone": "Testing & Validation"
    }
}

# Predefined Issues
PREDEFINED_ISSUES = [
    {
        "id": "PROC-INV-001",
        "title": "Invoice Receipt and Capture System",
        "phase": "core",
        "description": "Implement invoice receipt and capture system with data extraction"
    },
    {
        "id": "PROC-INV-002",
        "title": "3-Way Matching Algorithm",
        "phase": "core",
        "description": "Implement 3-way matching algorithm for PO, receipt, and invoice"
    },
    {
        "id": "PROC-INV-003",
        "title": "Invoice Validation Engine",
        "phase": "core",
        "description": "Develop invoice validation engine with business rules"
    },
    {
        "id": "PROC-INV-004",
        "title": "Approval Workflow Development",
        "phase": "core",
        "description": "Implement invoice approval workflow with routing"
    },
    {
        "id": "PROC-INV-005",
        "title": "Exception Handling Framework",
        "phase": "core",
        "description": "Develop exception handling and dispute resolution framework"
    },
    {
        "id": "PROC-INV-006",
        "title": "Payment Processing Integration",
        "phase": "integration",
        "description": "Integrate payment processing and scheduling system"
    },
    {
        "id": "PROC-INV-007",
        "title": "Integration Testing",
        "phase": "testing",
        "description": "Comprehensive integration testing for all workflows"
    },
    {
        "id": "PROC-INV-008",
        "title": "Performance Testing",
        "phase": "testing",
        "description": "Performance testing for invoice processing throughput"
    }
]


def generate_issue_markdown(issue_id: str, title: str, phase: str, description: str) -> str:
    """Generate markdown content for an issue file."""
    template = ISSUE_TEMPLATES.get(phase, ISSUE_TEMPLATES["analysis"])
    
    today = datetime.now().strftime("%Y-%m-%d")
    
    return f"""---
title: {issue_id} - {title}
description: {description}
author: Paperclip Orchestration System
date: {today}
version: 1.0
status: pending
project_code: {PROJECT_CODE}
discipline: {DISCIPLINE}
issue_id: {issue_id}
phase: {template['phase']}
priority: {template['priority']}
milestone: {template['milestone']}
---

# {issue_id}: {title}

## Overview

{description}

## Requirements

### Functional Requirements
- [ ] Requirement 1
- [ ] Requirement 2
- [ ] Requirement 3

### Non-Functional Requirements
- Performance: <2 hours processing time
- Accuracy: >99.5% matching accuracy
- Reliability: 99.9% uptime

## Implementation Details

### Phase
- **Phase**: {template['phase']}
- **Milestone**: {template['milestone']}

### Platform Considerations
- Desktop: Native UI components
- Mobile: Touch-optimized interface
- Web: Responsive design

## Acceptance Criteria

- [ ] Feature implemented and tested
- [ ] Documentation updated
- [ ] Quality metrics met
- [ ] Stakeholder approval obtained

## Dependencies

- {PROJECT_CODE}-000: Project automation

## Notes

Additional notes and context for this issue.

---

**Document Version**: 1.0
**Last Updated**: {today}
"""


def create_issue_file(issue_id: str, title: str, phase: str, description: str) -> Path:
    """Create an issue markdown file."""
    ISSUES_DIR.mkdir(parents=True, exist_ok=True)
    
    filename = f"{issue_id}.md"
    filepath = ISSUES_DIR / filename
    
    content = generate_issue_markdown(issue_id, title, phase, description)
    
    with open(filepath, 'w') as f:
        f.write(content)
    
    return filepath


def generate_all_issues() -> list:
    """Generate all predefined issues."""
    created_files = []
    
    for issue in PREDEFINED_ISSUES:
        filepath = create_issue_file(
            issue["id"],
            issue["title"],
            issue["phase"],
            issue["description"]
        )
        created_files.append(filepath)
        print(f"Created: {filepath}")
    
    return created_files


def main():
    """Main entry point for the issue generation script."""
    parser = argparse.ArgumentParser(
        description="Generate PROC-INV project issues"
    )
    parser.add_argument(
        "--project",
        default=PROJECT_CODE,
        help="Project code"
    )
    parser.add_argument(
        "--phase",
        choices=["analysis", "core", "integration", "testing"],
        help="Filter by phase"
    )
    parser.add_argument(
        "--list",
        action="store_true",
        help="List predefined issues"
    )
    
    args = parser.parse_args()
    
    if args.list:
        print(f"Predefined issues for {PROJECT_CODE}:")
        for issue in PREDEFINED_ISSUES:
            print(f"  - {issue['id']}: {issue['title']}")
        return 0
    
    print(f"Generating issues for {PROJECT_CODE}...")
    created = generate_all_issues()
    print(f"\nSuccessfully created {len(created)} issue files.")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
