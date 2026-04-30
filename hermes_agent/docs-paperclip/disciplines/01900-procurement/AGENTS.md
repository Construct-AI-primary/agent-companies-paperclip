# Procurement Discipline - Agent Documentation

## Overview

This file contains agent-specific instructions and configurations for the Procurement discipline within the Paperclip ecosystem.

## Agent Assignments

### Primary Agents

| Agent | Role | Primary Skills |
|-------|------|----------------|
| devcore-devforge | Core infrastructure & architecture | Database design, API development, system architecture |
| interface-devforge | User interfaces & integration | Frontend development, API integration, UX design |
| codesmith-devforge | Business logic & compliance | Business rules, compliance validation, testing |
| guardian-qualityforge | Quality assurance & validation | Testing frameworks, quality metrics, validation |

### Project-Specific Agent Mapping

| Project | Core Agent | Supporting Agents |
|---------|-----------|-------------------|
| PROC-ORDER | interface-devforge | devcore-devforge, codesmith-devforge, guardian-qualityforge |
| PROC-AMEND | devcore-devforge | codesmith-devforge, guardian-qualityforge |
| PROC-ANALYTICS | codesmith-devforge | devcore-devforge, interface-devforge |
| PROC-AUDIT | guardian-qualityforge | devcore-devforge, codesmith-devforge |
| PROC-BUDGET | devcore-devforge | codesmith-devforge, interface-devforge |
| PROC-EMERG | devcore-devforge | guardian-qualityforge, codesmith-devforge |
| PROC-INTEL | codesmith-devforge | devcore-devforge, interface-devforge |
| PROC-INV | devcore-devforge | codesmith-devforge, guardian-qualityforge |
| PROC-LONG | devcore-devforge | codesmith-devforge, interface-devforge |
| PROC-NCR | devcore-devforge | codesmith-devforge, guardian-qualityforge |
| PROC-SERVICE | codesmith-devforge | devcore-devforge, interface-devforge |
| PROC-SUPP | devcore-devforge | codesmith-devforge, guardian-qualityforge |
| PROC-TRACK | devcore-devforge | codesmith-devforge, interface-devforge |
| PROC-VOICE | codesmith-devforge | devcore-devforge, interface-devforge |

## Skill Requirements

### Core Skills for Procurement

| Skill | Level | Required Agents |
|-------|-------|-----------------|
| API Development | Expert | interface-devforge, devcore-devforge |
| Database Design | Expert | devcore-devforge |
| Business Logic | Advanced | codesmith-devforge |
| Compliance Validation | Advanced | codesmith-devforge, guardian-qualityforge |
| Testing Frameworks | Advanced | guardian-qualityforge |
| Integration Testing | Advanced | interface-devforge, codesmith-devforge |
| System Architecture | Expert | devcore-devforge |
| UX Design | Advanced | interface-devforge |

## Development Guidelines

### Agent Collaboration

1. **Single Source of Truth**: Each project has one primary agent responsible for architecture decisions
2. **Cross-Review**: All code changes require review from at least one agent from a different skill set
3. **Knowledge Transfer**: Weekly knowledge sharing sessions between agents

### Code Standards

- All code must follow Paperclip's established coding standards
- Documentation must be updated alongside code changes
- All changes must be linked to specific issues in the project tracking system

### Quality Gates

- **Pre-commit**: Code review by assigned agent
- **Pre-merge**: Cross-functional review (minimum 2 agents)
- **Post-merge**: Automated testing and validation

## Communication Protocols

### Daily Standups
- Each agent reports on progress against assigned issues
- Blockers are escalated immediately
- Cross-team coordination discussed

### Weekly Reviews
- Progress review against project milestones
- Risk assessment and mitigation planning
- Knowledge sharing sessions

### Emergency Procedures
- Critical issues trigger immediate agent coordination
- Escalation path defined per project
- Rollback procedures documented per project