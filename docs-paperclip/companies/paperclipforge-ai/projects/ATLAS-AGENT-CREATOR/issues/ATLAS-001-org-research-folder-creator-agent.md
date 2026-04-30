---
issue_id: ATLAS-001
title: Create org-research-folder-creator Agent
description: Create a new agent for automated organisation research, folder structure creation, and project/issue generation
status: backlog
priority: high
created: 2026-04-20
owner: paperclipforge-ai-atlas-agent-creator
tags:
  - agent-creation
  - organisation-research
  - automation
  - folder-structure
---

# ATLAS-001: Create org-research-folder-creator Agent

## Overview

Create a new PaperclipForge AI agent called `org-research-folder-creator` that specializes in AI-powered organisation research, automated folder structure creation, and intelligent project/issue generation.

## Agent Specification

### Agent Details

| Field | Value |
|-------|-------|
| **Agent Name** | paperclipforge-ai-org-research-folder-creator |
| **Company** | PaperclipForge AI |
| **Team** | Operations |
| **Reports To** | paperclipforge-ai-operations-director |
| **Role** | Automated Organisation Research & Documentation Specialist |

### Skills Required

- `org-research-folder-creator` (to be created)
- `issue-generator`
- `workflow-automator`
- `knowledge-integrator`

### Capabilities

1. **Web Research**: Automated company research via web search, public records, industry databases
2. **Documentation Generation**: Creation of comprehensive organisation-knowledge documentation
3. **Folder Structure Automation**: Auto-generation of standard folder structures following templates
4. **Project Generation**: Creation of discipline-specific projects based on research
5. **Issue Creation**: Intelligent issue generation from identified opportunities
6. **Cross-Reference Management**: Linking organisation knowledge to relevant disciplines

## Files to Create

### 1. Agent Definition

**Path:** `docs-paperclip/companies/paperclipforge-ai/agents/paperclipforge-ai-org-research-folder-creator/AGENTS.md`

**Content:** (Already created - see existing file)

### 2. Skill Definition

**Path:** `docs-paperclip/companies/paperclipforge-ai/skills/org-research-folder-creator/SKILL.md`

**Content:** (Already created - see existing file)

## Folder Structure Template

The agent should create the following structure for any researched organisation:

```
docs-paperclip/organisation-knowledge/{slug}/
├── COMPANY.md                              ← Main company definition (AgentCompanies v1 schema)
└── knowledge/
    ├── industry-context/
    │   ├── company-profile.md            ← Detailed company profile
    │   ├── market-analysis.md            ← Target market and positioning
    │   └── competitor-analysis.md         ← Competitive landscape
    └── workflows/
        ├── core-workflows.md              ← Primary operational workflows
        └── ai-agents-suitability.md       ← Recommended AI agents
```

## Example Use Case

When researching "Zama Traffic Signals":

1. **Research Phase**: Gather company info (established 2005, 100% black-owned, Durban North)
2. **Documentation Phase**: Create 6 markdown files in `organisation-knowledge/zama/`
3. **Project Phase**: Link to `disciplines-sector-specific-details/00002-traffic-signals/`
4. **Issue Phase**: Generate issues for identified opportunities

## Success Metrics

- Research completeness: ≥90% of key information captured
- Folder structure accuracy: 100% compliance with templates
- Cross-reference accuracy: ≥95% links functional
- Issue generation quality: ≥85% issues approved without modification
- Processing speed: <2 hours for standard organisation research

## Acceptance Criteria

- [ ] Agent definition created in `agents/paperclipforge-ai-org-research-folder-creator/AGENTS.md`
- [ ] Skill definition created in `skills/org-research-folder-creator/SKILL.md`
- [ ] Agent can be routed to via the skill
- [ ] Agent follows the 4-phase workflow (Research → Documentation → Project Generation → Integration)
- [ ] Agent creates standard folder structures following templates
- [ ] Agent links organisation knowledge to relevant disciplines
- [ ] Agent generates appropriate projects and issues

## Related Issues

- Related to existing traffic-signals discipline structure
- Complements `issue-generator` and `workflow-automator` agents
