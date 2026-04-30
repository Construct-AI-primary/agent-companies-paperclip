#!/usr/bin/env python3
"""
PROC-SUPP Issue Generator

This script generates issue files for the Supplier Qualification & Performance Monitoring Workflow project.
"""

import os
from datetime import datetime
from pathlib import Path

# Project configuration
PROJECT_CODE = "PROC-SUPP"
DISCIPLINE = "01900-procurement"
PROJECT_DIR = Path(__file__).parent.parent
ISSUES_DIR = PROJECT_DIR / "issues"

# Issue templates
ISSUE_TEMPLATES = {
    "PROC-SUPP-001": {
        "title": "Supplier Registration Module",
        "phase": "Phase 2",
        "priority": "high",
        "assignee": "interface-devforge",
        "description": "Implement supplier registration and profile creation functionality",
        "acceptance": [
            "Supplier registration form implemented",
            "Profile creation system functional",
            "Document upload capability working",
            "Unit tests passing"
        ]
    },
    "PROC-SUPP-002": {
        "title": "Pre-Qualification Workflow",
        "phase": "Phase 3",
        "priority": "high",
        "assignee": "codesmith-devforge",
        "description": "Implement pre-qualification workflow and capability assessment",
        "acceptance": [
            "Pre-qualification workflow engine implemented",
            "Document review system functional",
            "Capability assessment tools working",
            "Integration tests passing"
        ]
    },
    "PROC-SUPP-003": {
        "title": "Performance Monitoring System",
        "phase": "Phase 4",
        "priority": "high",
        "assignee": "interface-devforge",
        "description": "Implement performance monitoring and scoring system",
        "acceptance": [
            "Performance score calculation engine implemented",
            "KPI tracking dashboard functional",
            "Performance review system working",
            "Performance tests passing"
        ]
    },
    "PROC-SUPP-004": {
        "title": "Quality Incident Management",
        "phase": "Phase 4",
        "priority": "high",
        "assignee": "codesmith-devforge",
        "description": "Implement quality incident reporting and resolution workflow",
        "acceptance": [
            "Incident reporting system implemented",
            "Investigation workflow functional",
            "Corrective action tracking working",
            "Resolution time < 48 hours"
        ]
    },
    "PROC-SUPP-005": {
        "title": "Compliance Assessment Module",
        "phase": "Phase 3",
        "priority": "high",
        "assignee": "codesmith-devforge",
        "description": "Implement compliance assessment and certification system",
        "acceptance": [
            "Compliance checklist system implemented",
            "Verification workflow functional",
            "Audit management working",
            "Certification system operational"
        ]
    },
    "PROC-SUPP-006": {
        "title": "Supplier Development Plans",
        "phase": "Phase 4",
        "priority": "medium",
        "assignee": "interface-devforge",
        "description": "Implement supplier development planning and tracking",
        "acceptance": [
            "Development plan creation implemented",
            "Training coordination functional",
            "Improvement tracking working",
            "Development assessment operational"
        ]
    },
    "PROC-SUPP-007": {
        "title": "Integration Testing",
        "phase": "Phase 4",
        "priority": "high",
        "assignee": "guardian-qualityforge",
        "description": "Comprehensive integration testing for all supplier workflows",
        "acceptance": [
            "All integration tests passing",
            "Cross-platform compatibility verified",
            "Performance benchmarks met",
            "Security validation complete"
        ]
    },
    "PROC-SUPP-008": {
        "title": "Production Deployment",
        "phase": "Phase 4",
        "priority": "high",
        "assignee": "devcore-devforge",
        "description": "Production deployment preparation and validation",
        "acceptance": [
            "Deployment package ready",
            "Data migration validated",
            "User documentation complete",
            "Production deployment successful"
        ]
    }
}

def generate_issue(issue_id: str, template: dict) -> str:
    """Generate issue markdown content."""
    today = datetime.now().strftime("%Y-%m-%d")
    
    return f"""---
id: {issue_id}
title: {template['title']}
phase: {template['phase']}
status: backlog
priority: {template['priority']}
assigneeAgentId: {template['assignee']}
parent: PROC-SUPP-000
project: {PROJECT_CODE}
---

# {issue_id}: {template['title']}

## Description

{template['description']}

## Acceptance Criteria

{"".join([f"- [ ] {criteria}" for criteria in template['acceptance']])}

## Assigned Company & Agent

- **Company:** devforge-ai
- **Agent:** {template['assignee']}

## Working Directory & Repository

- **Local Repository:** `/Users/_test-20260416/paperclip-render`
- **Working Directory:** `/Users/_test-20260416/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Primary Repository:** `https://github.com/Construct-AI-primary/construct_ai.git`
  - **Documentation Repository:** `https://github.com/Construct-AI-primary/docs-paperclip.git`

## Required Skills

- `procurement-workflow-implementation` (devforge-ai)
- `react-frontend-development` (devforge-ai)
- `database-schema-design` (devforge-ai)

## Dependencies

- BLOCKED BY: [PROC-SUPP-000] (Project initialization)
- BLOCKS: [PROC-SUPP-XXX] (Production deployment)

## Estimated Effort

- **Complexity**: medium
- **Estimated Hours**: 40-80 hours
- **Timeline**: 2 weeks

## Success Validation

**How to verify completion**:

1. All acceptance criteria met
2. Unit tests passing
3. Integration tests passing
4. Code review approved

---

**Created**: {today}
**Updated**: {today}
"""

def main():
    """Generate all issue files."""
    # Ensure issues directory exists
    ISSUES_DIR.mkdir(parents=True, exist_ok=True)
    
    # Generate each issue
    for issue_id, template in ISSUE_TEMPLATES.items():
        issue_file = ISSUES_DIR / f"{issue_id}-{template['title'].lower().replace(' ', '-')}.md"
        content = generate_issue(issue_id, template)
        
        with open(issue_file, 'w') as f:
            f.write(content)
        
        print(f"Generated: {issue_file}")
    
    print(f"\nTotal issues generated: {len(ISSUE_TEMPLATES)}")

if __name__ == "__main__":
    main()
