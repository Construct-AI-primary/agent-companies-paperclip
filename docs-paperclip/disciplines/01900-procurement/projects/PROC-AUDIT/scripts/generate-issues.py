#!/usr/bin/env python3
"""
PROC-AUDIT Issue Generation Script

This script generates Paperclip-compatible issue files for the PROC-AUDIT
(Procurement Audit) project based on the project charter and implementation plan.

Usage:
    python generate-issues.py [--phase PHASE] [--dry-run]

Author: Paperclip Orchestration System
Version: 1.0
Date: 2026-04-08
"""

import os
import json
import argparse
from datetime import datetime
from typing import Dict, List, Optional

# Issue templates
ISSUE_TEMPLATES = {
    "phase_0": {
        "id_format": "PROC-AUDIT-00{number}",
        "issues": [
            {
                "number": "0",
                "title": "Project Foundation & Setup",
                "description": "Initialize project foundation, setup agent assignments, and establish orchestration framework.",
                "priority": "critical",
                "agents": ["paperclipforge-ai-project-maestro", "interface-devforge"],
                "dependencies": [],
                "blocks": ["PROC-AUDIT-001", "PROC-AUDIT-002", "PROC-AUDIT-010"],
                "effort": "medium",
                "hours": "8-12"
            }
        ]
    },
    "phase_1": {
        "id_format": "PROC-AUDIT-{number}",
        "issues": [
            {
                "number": "001",
                "title": "Audit Trail Requirements Specification",
                "description": "Define comprehensive audit trail requirements including event capture, storage, validation, and reporting.",
                "priority": "high",
                "agents": ["interface-devforge", "domain-devforge"],
                "dependencies": ["PROC-AUDIT-000"],
                "blocks": ["PROC-AUDIT-010", "PROC-AUDIT-011"],
                "effort": "medium",
                "hours": "6-8"
            },
            {
                "number": "002",
                "title": "System Architecture Design",
                "description": "Design the system architecture for audit trail, compliance assessment, and regulatory reporting.",
                "priority": "high",
                "agents": ["devcore-devforge"],
                "dependencies": ["PROC-AUDIT-000"],
                "blocks": ["PROC-AUDIT-012", "PROC-AUDIT-020"],
                "effort": "medium",
                "hours": "8-10"
            },
            {
                "number": "003",
                "title": "Compliance Framework Setup",
                "description": "Set up the compliance framework with configurable rules, exception handling, and violation tracking.",
                "priority": "high",
                "agents": ["codesmith-devforge", "domain-devforge"],
                "dependencies": ["PROC-AUDIT-001"],
                "blocks": ["PROC-AUDIT-013", "PROC-AUDIT-021"],
                "effort": "medium",
                "hours": "6-8"
            }
        ]
    },
    "phase_2": {
        "id_format": "PROC-AUDIT-{number}",
        "issues": [
            {
                "number": "010",
                "title": "Audit Trail Capture Implementation",
                "description": "Implement the audit trail capture system for real-time event capture across all procurement workflows.",
                "priority": "critical",
                "agents": ["interface-devforge"],
                "dependencies": ["PROC-AUDIT-001", "PROC-AUDIT-002"],
                "blocks": ["PROC-AUDIT-020", "PROC-AUDIT-030"],
                "effort": "high",
                "hours": "12-16"
            },
            {
                "number": "011",
                "title": "Audit Trail Storage Implementation",
                "description": "Implement secure storage for audit records with compression, retention policies, and backup.",
                "priority": "high",
                "agents": ["devcore-devforge"],
                "dependencies": ["PROC-AUDIT-010"],
                "blocks": ["PROC-AUDIT-022", "PROC-AUDIT-031"],
                "effort": "medium",
                "hours": "8-10"
            },
            {
                "number": "012",
                "title": "Audit Trail Query Interface",
                "description": "Build the query interface with filtering, search, and export capabilities.",
                "priority": "medium",
                "agents": ["interface-devforge"],
                "dependencies": ["PROC-AUDIT-011"],
                "blocks": ["PROC-AUDIT-023", "PROC-AUDIT-032"],
                "effort": "medium",
                "hours": "6-8"
            },
            {
                "number": "013",
                "title": "Compliance Assessment Engine",
                "description": "Implement the compliance assessment engine with rule evaluation and exception handling.",
                "priority": "critical",
                "agents": ["codesmith-devforge"],
                "dependencies": ["PROC-AUDIT-003"],
                "blocks": ["PROC-AUDIT-020", "PROC-AUDIT-033"],
                "effort": "high",
                "hours": "10-14"
            }
        ]
    },
    "phase_3": {
        "id_format": "PROC-AUDIT-{number}",
        "issues": [
            {
                "number": "020",
                "title": "Control Review System Implementation",
                "description": "Implement the control review system with testing, effectiveness assessment, and remediation tracking.",
                "priority": "high",
                "agents": ["codesmith-devforge", "guardian-qualityforge"],
                "dependencies": ["PROC-AUDIT-010", "PROC-AUDIT-013"],
                "blocks": ["PROC-AUDIT-040"],
                "effort": "high",
                "hours": "10-12"
            },
            {
                "number": "021",
                "title": "Regulatory Reporting Automation",
                "description": "Automate regulatory report generation and submission workflows.",
                "priority": "high",
                "agents": ["interface-devforge"],
                "dependencies": ["PROC-AUDIT-003", "PROC-AUDIT-012"],
                "blocks": ["PROC-AUDIT-041"],
                "effort": "medium",
                "hours": "8-10"
            },
            {
                "number": "022",
                "title": "Desktop Audit Dashboard",
                "description": "Build the desktop audit dashboard with native features, advanced filtering, and export tools.",
                "priority": "medium",
                "agents": ["interface-devforge"],
                "dependencies": ["PROC-AUDIT-011"],
                "blocks": ["PROC-AUDIT-042"],
                "effort": "medium",
                "hours": "6-8"
            },
            {
                "number": "023",
                "title": "Mobile Audit Application",
                "description": "Build the mobile audit application with offline support and sync capabilities.",
                "priority": "medium",
                "agents": ["interface-devforge"],
                "dependencies": ["PROC-AUDIT-011"],
                "blocks": ["PROC-AUDIT-043"],
                "effort": "medium",
                "hours": "8-10"
            }
        ]
    },
    "phase_4": {
        "id_format": "PROC-AUDIT-{number}",
        "issues": [
            {
                "number": "030",
                "title": "Web Audit Interface",
                "description": "Build the web-based audit interface with real-time compliance monitoring.",
                "priority": "high",
                "agents": ["interface-devforge"],
                "dependencies": ["PROC-AUDIT-010"],
                "blocks": ["PROC-AUDIT-040"],
                "effort": "medium",
                "hours": "8-10"
            },
            {
                "number": "031",
                "title": "Cross-Platform Integration",
                "description": "Implement cross-platform integration for audit trail and compliance data.",
                "priority": "high",
                "agents": ["devcore-devforge", "interface-devforge"],
                "dependencies": ["PROC-AUDIT-011", "PROC-AUDIT-030"],
                "blocks": ["PROC-AUDIT-041"],
                "effort": "high",
                "hours": "12-16"
            },
            {
                "number": "032",
                "title": "Integration with PROC-ORDER",
                "description": "Integrate audit and compliance with PROC-ORDER workflows.",
                "priority": "high",
                "agents": ["codesmith-devforge"],
                "dependencies": ["PROC-AUDIT-012"],
                "blocks": ["PROC-AUDIT-042"],
                "effort": "medium",
                "hours": "6-8"
            },
            {
                "number": "033",
                "title": "KnowledgeForge Indexing",
                "description": "Index audit and compliance knowledge in KnowledgeForge for cross-project reference.",
                "priority": "medium",
                "agents": ["knowledgeforge-ai-doc-analyzer"],
                "dependencies": ["PROC-AUDIT-020"],
                "blocks": [],
                "effort": "low",
                "hours": "4-6"
            }
        ]
    },
    "phase_5": {
        "id_format": "PROC-AUDIT-{number}",
        "issues": [
            {
                "number": "040",
                "title": "System Testing & Validation",
                "description": "Comprehensive testing of all audit, compliance, and reporting components.",
                "priority": "critical",
                "agents": ["guardian-qualityforge"],
                "dependencies": ["PROC-AUDIT-020", "PROC-AUDIT-030", "PROC-AUDIT-031"],
                "blocks": ["PROC-AUDIT-050"],
                "effort": "high",
                "hours": "12-16"
            },
            {
                "number": "041",
                "title": "Production Deployment",
                "description": "Deploy audit and compliance system to production across all platforms.",
                "priority": "critical",
                "agents": ["interface-devforge", "devcore-devforge"],
                "dependencies": ["PROC-AUDIT-040"],
                "blocks": ["PROC-AUDIT-051"],
                "effort": "medium",
                "hours": "8-10"
            },
            {
                "number": "042",
                "title": "Documentation Completion",
                "description": "Complete all technical documentation, user guides, and training materials.",
                "priority": "medium",
                "agents": ["knowledgeforge-ai-doc-analyzer"],
                "dependencies": ["PROC-AUDIT-041"],
                "blocks": [],
                "effort": "medium",
                "hours": "6-8"
            },
            {
                "number": "043",
                "title": "User Training & Handover",
                "description": "Conduct user training and complete project handover.",
                "priority": "medium",
                "agents": ["interface-devforge", "domain-devforge"],
                "dependencies": ["PROC-AUDIT-042"],
                "blocks": [],
                "effort": "low",
                "hours": "4-6"
            }
        ]
    }
}

def generate_frontmatter(issue: Dict, phase_name: str) -> str:
    """Generate YAML frontmatter for an issue."""
    return f"""---
id: {issue['id']}
title: {issue['title']}
phase: {phase_name}
status: backlog
priority: {issue['priority']}
assigneeAgentId: {issue['agents'][0]}
project: PROC-AUDIT
---

# {issue['id']}: {issue['title']}

## Description

{issue['description']}

## Acceptance Criteria
- [ ] Implementation completed
- [ ] Testing passed
- [ ] Documentation updated
- [ ] Production ready

## Assigned Company & Agent
- **Company:** DevForge AI
- **Agent:** {issue['agents'][0]}

## Working Directory & Repository
- **Local Repository:** /Users/_test-20260416/paperclip-render
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Primary Repository:** https://github.com/Construct-AI-primary/construct_ai.git

## Required Skills
- procurement-workflow-implementation (DomainForge AI)
- audit-trail-automation (DevForge AI)

## Dependencies
- BLOCKED BY: {', '.join(issue['dependencies']) if issue['dependencies'] else 'None'}
- BLOCKS: {', '.join(issue['blocks']) if issue['blocks'] else 'None'}

## Estimated Effort
- **Complexity:** {issue['effort']}
- **Estimated Hours:** {issue['hours']}

## Success Validation
1. Code implemented according to specifications
2. Unit tests passing
3. Integration tests passing
4. Documentation complete

---

**Created**: {datetime.now().strftime('%Y-%m-%d')}
**Updated**: {datetime.now().strftime('%Y-%m-%d')}
"""

def generate_issue_file(issue: Dict, output_dir: str, phase_name: str) -> str:
    """Generate an issue file and return its path."""
    # Determine ID format based on phase
    if issue['number'].startswith('0'):
        issue_id = f"PROC-AUDIT-{issue['number']}"
    else:
        issue_id = f"PROC-AUDIT-{issue['number']}"
    
    issue['id'] = issue_id
    
    filename = f"{issue_id}-{issue['title'].lower().replace(' ', '-').replace('_', '-')}.md"
    filepath = os.path.join(output_dir, filename)
    
    with open(filepath, 'w') as f:
        f.write(generate_frontmatter(issue, phase_name))
    
    return filepath

def main():
    parser = argparse.ArgumentParser(description='Generate PROC-AUDIT issues')
    parser.add_argument('--phase', type=str, help='Generate issues for specific phase (0-5)')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be generated')
    args = parser.parse_args()
    
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    issues_dir = os.path.join(base_dir, 'issues')
    os.makedirs(issues_dir, exist_ok=True)
    
    phase_names = {
        '0': '0 — Foundation',
        '1': '1 — Requirements & Architecture',
        '2': '2 — Core Implementation',
        '3': '3 — Enhancement',
        '4': '4 — Integration',
        '5': '5 — Deployment & Validation'
    }
    
    generated = []
    
    phases = ISSUE_TEMPLATES.keys() if not args.phase else [f'phase_{args.phase}']
    
    for phase_key in phases:
        if phase_key not in ISSUE_TEMPLATES:
            print(f"Unknown phase: {phase_key}")
            continue
            
        template = ISSUE_TEMPLATES[phase_key]
        phase_num = phase_key.split('_')[1]
        phase_name = phase_names.get(phase_num, phase_key)
        
        for issue in template['issues']:
            if args.dry_run:
                print(f"Would generate: {issue['id'] if 'id' in issue else template['id_format'].format(number=issue['number'])} - {issue['title']}")
            else:
                filepath = generate_issue_file(issue, issues_dir, phase_name)
                generated.append(filepath)
                print(f"Generated: {filepath}")
    
    if not args.dry_run:
        print(f"\nGenerated {len(generated)} issues")
        print(f"Issues directory: {issues_dir}")

if __name__ == '__main__':
    main()
