#!/usr/bin/env python3
"""
PROC-EMERG Issue Generation Script

This script generates standardized issue files for the Emergency Procurement project.
"""

import os
import sys
from datetime import datetime, timedelta
from typing import Dict, List, Optional

PROJECT_CODE = "PROC-EMERG"
PROJECT_DIR = "/Users/_test-20260416/paperclip-render/docs-paperclip/disciplines/01900-procurement/projects/PROC-EMERG"
ISSUES_DIR = os.path.join(PROJECT_DIR, "issues")

# Issue templates
ISSUE_TEMPLATES = {
    "emergency-validation": {
        "prefix": "EMERG-001",
        "title": "Emergency Validation Framework",
        "description": "Implement emergency classification and rapid validation system",
        "priority": "high",
        "phase": 1
    },
    "justification-system": {
        "prefix": "EMERG-002",
        "title": "Single-Source Justification System",
        "description": "Create justification document generation and validation",
        "priority": "high",
        "phase": 2
    },
    "approval-workflow": {
        "prefix": "EMERG-003",
        "title": "Expedited Approval Workflow",
        "description": "Implement fast-track approval routing for emergencies",
        "priority": "high",
        "phase": 2
    },
    "supplier-integration": {
        "prefix": "EMERG-004",
        "title": "Emergency Supplier Integration",
        "description": "Build supplier identification and engagement system",
        "priority": "medium",
        "phase": 3
    },
    "compliance-documentation": {
        "prefix": "EMERG-005",
        "title": "Compliance Documentation System",
        "description": "Create post-award compliance documentation",
        "priority": "high",
        "phase": 4
    },
    "testing-validation": {
        "prefix": "EMERG-006",
        "title": "Testing and Validation",
        "description": "Comprehensive testing of emergency workflows",
        "priority": "medium",
        "phase": 4
    }
}

def create_issue_file(issue_id: str, title: str, description: str, priority: str, phase: int) -> str:
    """Create an issue markdown file"""
    filename = f"{issue_id}.md"
    filepath = os.path.join(ISSUES_DIR, filename)
    
    content = f"""---
title: {issue_id} - {title}
description: {description}
author: Paperclip Orchestration System
date: {datetime.now().strftime('%Y-%m-%d')}
version: 1.0
status: pending
project_code: {PROJECT_CODE}
priority: {priority}
phase: {phase}
---

# {issue_id}: {title}

## Overview

{description}

## Objectives

- [ ] Define scope and requirements
- [ ] Implement solution
- [ ] Test and validate
- [ ] Document and deploy

## Deliverables

1. Implementation code
2. Test cases
3. Documentation
4. Deployment guide

## Dependencies

- DevForge AI core services
- Supabase database
- Paperclip orchestration system

## Timeline

Phase {phase}: To be completed within project timeline

## Success Criteria

- [ ] All requirements met
- [ ] Tests passing
- [ ] Documentation complete
- [ ] Production ready

---

**Document Version**: 1.0
**Last Updated**: {datetime.now().strftime('%Y-%m-%d')}
"""
    
    return content

def generate_issues():
    """Generate all issue files"""
    os.makedirs(ISSUES_DIR, exist_ok=True)
    
    print(f"Generating issues for {PROJECT_CODE}...")
    print(f"Issues directory: {ISSUES_DIR}")
    
    for issue_type, template in ISSUE_TEMPLATES.items():
        issue_id = f"{PROJECT_CODE}-{template['prefix']}"
        content = create_issue_file(
            issue_id,
            template["title"],
            template["description"],
            template["priority"],
            template["phase"]
        )
        
        filepath = os.path.join(ISSUES_DIR, f"{issue_id}.md")
        with open(filepath, 'w') as f:
            f.write(content)
        
        print(f"  Created: {issue_id}")
    
    print(f"\nGenerated {len(ISSUE_TEMPLATES)} issues successfully!")

if __name__ == "__main__":
    generate_issues()
