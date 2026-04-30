#!/usr/bin/env python3
"""
PROC-001 Issue Generation Script

This script generates standardized issue files for the Standard Procurement Workflow project.
"""

import os
import sys
from datetime import datetime, timedelta
from typing import Dict, List, Optional

PROJECT_CODE = "PROC-001"
PROJECT_DIR = "/Users/_test-20260416/paperclip-render/docs-paperclip/disciplines/01900-procurement/projects/PROC-001"
ISSUES_DIR = os.path.join(PROJECT_DIR, "issues")

# Issue templates
ISSUE_TEMPLATES = {
    "order-creation": {
        "prefix": "001",
        "title": "Order Creation Workflow",
        "description": "Implement procurement order creation and validation system",
        "priority": "high",
        "phase": 1
    },
    "supplier-integration": {
        "prefix": "002",
        "title": "Supplier Integration",
        "description": "Build supplier selection and engagement system",
        "priority": "high",
        "phase": 2
    },
    "approval-workflow": {
        "prefix": "003",
        "title": "Approval Workflow",
        "description": "Implement multi-level approval routing",
        "priority": "high",
        "phase": 2
    },
    "contract-generation": {
        "prefix": "004",
        "title": "Contract Generation",
        "description": "Build purchase order generation system",
        "priority": "medium",
        "phase": 3
    },
    "tracking-system": {
        "prefix": "005",
        "title": "Order Tracking System",
        "description": "Implement real-time order tracking and status updates",
        "priority": "high",
        "phase": 3
    },
    "testing-validation": {
        "prefix": "006",
        "title": "Testing and Validation",
        "description": "Comprehensive testing of procurement workflows",
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
