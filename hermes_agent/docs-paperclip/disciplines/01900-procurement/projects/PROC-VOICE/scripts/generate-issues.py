#!/usr/bin/env python3
"""
PROC-VOICE Issue Generation Script

This script generates project issues for the Voice Communication for Procurement project.
It creates standardized issue files based on project requirements and milestones.

Usage:
    python generate-issues.py [--project PROJECT_CODE] [--phase PHASE]

Author: Paperclip Orchestration System
Date: 2026-04-16
Version: 1.0
"""

import os
import sys
import argparse
from datetime import datetime
from pathlib import Path

# Configuration
PROJECT_CODE = "PROC-VOICE"
DISCIPLINE = "01900-procurement"
ISSUES_DIR = Path(__file__).parent.parent / "issues"

# Issue Templates
ISSUE_TEMPLATES = {
    "foundation": {
        "title": "Foundation Phase - {description}",
        "priority": "high",
        "phase": 1,
        "milestone": "Foundation Complete"
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
        "id": "PROC-VOICE-001",
        "title": "Voice Command Processing Engine",
        "phase": "core",
        "description": "Develop the voice command processing engine with speech recognition integration"
    },
    {
        "id": "PROC-VOICE-002",
        "title": "Voice-Activated Order Workflow",
        "phase": "core",
        "description": "Implement voice-activated order creation, modification, and query workflows"
    },
    {
        "id": "PROC-VOICE-003",
        "title": "Voice-Guided Approval Workflow",
        "phase": "core",
        "description": "Develop voice-guided approval workflows with voice confirmation"
    },
    {
        "id": "PROC-VOICE-004",
        "title": "Voice Communication System",
        "phase": "core",
        "description": "Implement real-time voice communication between procurement team members"
    },
    {
        "id": "PROC-VOICE-005",
        "title": "Voice Transcription and Logging",
        "phase": "integration",
        "description": "Implement voice transcription and audit logging system"
    },
    {
        "id": "PROC-VOICE-006",
        "title": "Multi-Language Voice Support",
        "phase": "integration",
        "description": "Implement multi-language voice support and localization"
    },
    {
        "id": "PROC-VOICE-007",
        "title": "Voice Analytics and Reporting",
        "phase": "integration",
        "description": "Implement voice analytics and performance reporting"
    },
    {
        "id": "PROC-VOICE-008",
        "title": "Voice Recognition Accuracy Testing",
        "phase": "testing",
        "description": "Comprehensive voice recognition accuracy testing"
    },
    {
        "id": "PROC-VOICE-009",
        "title": "Voice Workflow Integration Testing",
        "phase": "testing",
        "description": "Integration testing for all voice workflows"
    },
    {
        "id": "PROC-VOICE-010",
        "title": "Voice Communication Performance Testing",
        "phase": "testing",
        "description": "Performance testing for voice communication latency"
    }
]


def generate_issue_markdown(issue_id: str, title: str, phase: str, description: str) -> str:
    """Generate markdown content for an issue file."""
    template = ISSUE_TEMPLATES.get(phase, ISSUE_TEMPLATES["foundation"])
    
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
- Voice Recognition Accuracy: >95%
- Voice Workflow Completion: >90%
- Voice Communication Latency: <500ms
- Voice Transcription Accuracy: >98%

## Implementation Details

### Phase
- **Phase**: {template['phase']}
- **Milestone**: {template['milestone']}

### Platform Considerations
- Desktop: Native voice integration
- Mobile: Touch-optimized voice interface
- Web: Web Speech API integration

## Acceptance Criteria

- [ ] Feature implemented and tested
- [ ] Voice recognition accuracy validated
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
        description="Generate PROC-VOICE project issues"
    )
    parser.add_argument(
        "--project",
        default=PROJECT_CODE,
        help="Project code"
    )
    parser.add_argument(
        "--phase",
        choices=["foundation", "core", "integration", "testing"],
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
