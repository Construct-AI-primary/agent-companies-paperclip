#!/usr/bin/env python3
"""
PROC-ANALYTICS Issue Generator

This script generates issue files for the PROC-ANALYTICS project based on the
implementation plan phases.

Usage:
    python generate-issues.py [--phase PHASE] [--all]

Options:
    --phase PHASE    Generate issues for specific phase (1-4)
    --all           Generate all issues for all phases
    --dry-run       Show what would be generated without creating files
"""

import os
import sys
import argparse
from datetime import datetime, timedelta
from pathlib import Path
from typing import List, Dict, Any

# Project configuration
PROJECT_CODE = "PROC-ANALYTICS"
DISCIPLINE = "01900-procurement"
PROJECT_DIR = Path(__file__).parent.parent
ISSUES_DIR = PROJECT_DIR / "issues"

# Issue templates by phase
ISSUE_TEMPLATES = {
    1: [  # Foundation Phase
        {
            "id": f"{PROJECT_CODE}-001",
            "title": "KPI Framework Design",
            "description": "Design comprehensive KPI taxonomy and framework for procurement analytics",
            "priority": "high",
            "status": "backlog",
            "assignee": "devcore-devforge",
            "estimated_hours": "16-24",
            "timeline": "Week 1"
        },
        {
            "id": f"{PROJECT_CODE}-002",
            "title": "Analytics Database Schema",
            "description": "Design and implement analytics database schema for KPI storage",
            "priority": "high",
            "status": "backlog",
            "assignee": "devcore-devforge",
            "estimated_hours": "24-32",
            "timeline": "Week 2"
        },
        {
            "id": f"{PROJECT_CODE}-003",
            "title": "Infrastructure Setup",
            "description": "Set up analytics infrastructure including caching and data pipelines",
            "priority": "medium",
            "status": "backlog",
            "assignee": "infra-devforge",
            "estimated_hours": "16-24",
            "timeline": "Week 2"
        }
    ],
    2: [  # Core Development Phase
        {
            "id": f"{PROJECT_CODE}-010",
            "title": "KPI Calculation Engine",
            "description": "Implement KPI calculation engine with support for multiple aggregation methods",
            "priority": "high",
            "status": "backlog",
            "assignee": "codesmith-devforge",
            "estimated_hours": "32-40",
            "timeline": "Week 3"
        },
        {
            "id": f"{PROJECT_CODE}-011",
            "title": "Dashboard UI Components",
            "description": "Develop dashboard UI components for KPI visualization",
            "priority": "high",
            "status": "backlog",
            "assignee": "interface-devforge",
            "estimated_hours": "24-32",
            "timeline": "Week 4"
        },
        {
            "id": f"{PROJECT_CODE}-012",
            "title": "Data Aggregation Pipeline",
            "description": "Build data aggregation pipeline for real-time KPI updates",
            "priority": "high",
            "status": "backlog",
            "assignee": "codesmith-devforge",
            "estimated_hours": "24-32",
            "timeline": "Week 4"
        },
        {
            "id": f"{PROJECT_CODE}-013",
            "title": "Dashboard Service API",
            "description": "Implement dashboard service API for frontend integration",
            "priority": "medium",
            "status": "backlog",
            "assignee": "interface-devforge",
            "estimated_hours": "16-24",
            "timeline": "Week 4"
        }
    ],
    3: [  # Analytics Features Phase
        {
            "id": f"{PROJECT_CODE}-020",
            "title": "Trend Analysis Engine",
            "description": "Implement trend analysis engine with pattern detection",
            "priority": "high",
            "status": "backlog",
            "assignee": "codesmith-devforge",
            "estimated_hours": "32-40",
            "timeline": "Week 5"
        },
        {
            "id": f"{PROJECT_CODE}-021",
            "title": "Forecasting Models",
            "description": "Develop forecasting models for procurement metrics",
            "priority": "high",
            "status": "backlog",
            "assignee": "codesmith-devforge",
            "estimated_hours": "32-40",
            "timeline": "Week 5"
        },
        {
            "id": f"{PROJECT_CODE}-022",
            "title": "Benchmarking Framework",
            "description": "Build benchmarking framework for industry comparison",
            "priority": "medium",
            "status": "backlog",
            "assignee": "codesmith-devforge",
            "estimated_hours": "24-32",
            "timeline": "Week 6"
        },
        {
            "id": f"{PROJECT_CODE}-023",
            "title": "Anomaly Detection",
            "description": "Implement anomaly detection for KPI values",
            "priority": "medium",
            "status": "backlog",
            "assignee": "codesmith-devforge",
            "estimated_hours": "24-32",
            "timeline": "Week 6"
        }
    ],
    4: [  # Reporting & Deployment Phase
        {
            "id": f"{PROJECT_CODE}-030",
            "title": "Executive Report Templates",
            "description": "Create executive report templates for various audiences",
            "priority": "high",
            "status": "backlog",
            "assignee": "interface-devforge",
            "estimated_hours": "24-32",
            "timeline": "Week 7"
        },
        {
            "id": f"{PROJECT_CODE}-031",
            "title": "Report Generation Service",
            "description": "Implement automated report generation service",
            "priority": "high",
            "status": "backlog",
            "assignee": "interface-devforge",
            "estimated_hours": "24-32",
            "timeline": "Week 7"
        },
        {
            "id": f"{PROJECT_CODE}-032",
            "title": "Integration Testing",
            "description": "Complete integration testing for all analytics workflows",
            "priority": "high",
            "status": "backlog",
            "assignee": "guardian-qualityforge",
            "estimated_hours": "24-32",
            "timeline": "Week 7"
        },
        {
            "id": f"{PROJECT_CODE}-033",
            "title": "Production Deployment",
            "description": "Deploy PROC-ANALYTICS to production environment",
            "priority": "high",
            "status": "backlog",
            "assignee": "interface-devforge",
            "estimated_hours": "16-24",
            "timeline": "Week 7"
        }
    ]
}

def generate_issue_content(issue: Dict[str, Any]) -> str:
    """Generate markdown content for an issue file."""
    today = datetime.now().strftime("%Y-%m-%d")
    
    content = f"""---
id: {issue['id']}
title: {issue['title']}
phase: Phase {(issue['id'].split('-')[1] if len(issue['id'].split('-')) > 1 else '1')} — Implementation
status: {issue['status']}
priority: {issue['priority']}
assigneeAgentId: {issue['assignee']}
project: {PROJECT_CODE}
---

# {issue['id']}: {issue['title']}

## Description

{issue['description']}

## Acceptance Criteria

- [ ] Component implemented according to specifications
- [ ] Unit tests passing with >90% coverage
- [ ] Integration with existing systems verified
- [ ] Documentation updated
- [ ] Performance benchmarks met

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** {issue['assignee']}

## Working Directory & Repository

- **Local Repository:** `/Users/_test-20260416/paperclip-render`
- **Working Directory:** `/Users/_test-20260416/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Primary Repository:** `https://github.com/Construct-AI-primary/construct_ai.git`
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`

## Required Skills

- `analytics-development` (DevForge AI)
- `database-schema-design` (InfraForge AI)

## Dependencies

- BLOCKED BY: [{PROJECT_CODE}-001]({PROJECT_CODE}-001-kpi-framework-design.md) (Foundation phase completion)
- BLOCKS: [{PROJECT_CODE}-040]({PROJECT_CODE}-040-full-simulation.md) (Final testing)

## Estimated Effort

- **Complexity:** medium
- **Estimated Hours:** {issue['estimated_hours']}
- **Timeline:** {issue['timeline']}

## Success Validation

**How to verify completion:**

1. Component implemented and tested
2. Code review completed
3. Documentation updated
4. Performance validated

---

**Created**: {today}
**Updated**: {today}
"""
    return content

def create_issue_file(issue: Dict[str, Any], dry_run: bool = False) -> bool:
    """Create an issue file."""
    filename = f"{issue['id']}-{issue['title'].lower().replace(' ', '-')}.md"
    filepath = ISSUES_DIR / filename
    
    if dry_run:
        print(f"[DRY RUN] Would create: {filepath}")
        return True
    
    try:
        content = generate_issue_content(issue)
        with open(filepath, 'w') as f:
            f.write(content)
        print(f"✓ Created: {filename}")
        return True
    except Exception as e:
        print(f"✗ Error creating {filename}: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description="Generate PROC-ANALYTICS issues")
    parser.add_argument("--phase", type=int, choices=[1, 2, 3, 4], 
                        help="Generate issues for specific phase (1-4)")
    parser.add_argument("--all", action="store_true", 
                        help="Generate all issues for all phases")
    parser.add_argument("--dry-run", action="store_true", 
                        help="Show what would be generated without creating files")
    
    args = parser.parse_args()
    
    # Ensure issues directory exists
    ISSUES_DIR.mkdir(parents=True, exist_ok=True)
    
    # Determine which phases to process
    if args.all:
        phases = [1, 2, 3, 4]
    elif args.phase:
        phases = [args.phase]
    else:
        print("Please specify --phase or --all")
        parser.print_help()
        sys.exit(1)
    
    # Generate issues
    total_created = 0
    for phase in phases:
        print(f"\n=== Phase {phase} Issues ===")
        issues = ISSUE_TEMPLATES.get(phase, [])
        for issue in issues:
            if create_issue_file(issue, args.dry_run):
                total_created += 1
    
    print(f"\n{'[DRY RUN] ' if args.dry_run else ''}Generated {total_created} issue files")

if __name__ == "__main__":
    main()
