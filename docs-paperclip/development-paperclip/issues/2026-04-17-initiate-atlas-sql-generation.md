---
id: INITIATE-ATLAS-2026-04-17
title: Initiate Atlas SQL Generation for IntegrateForge AI Agents
phase: Implementation
status: open
priority: high
assigneeAgentId: Atlas
parent: DESIGN-WORKFLOW
project: DESIGN-WORKFLOW
created: 2026-04-17
updated: 2026-04-17
---

# INITIATE-ATLAS-2026-04-17: Initiate Atlas SQL Generation for IntegrateForge AI Agents

## Description

**Atlas** (DevForge AI — Product Team) must immediately begin work on generating the Supabase SQL migration scripts for the new IntegrateForge AI company and all associated agents as specified in task `ATLAS-SQL-2026-04-17`.

## Context

The DESIGN-WORKFLOW agent integration implementation is complete and ready for database deployment. Atlas has been assigned the critical task of generating the SQL scripts that will add 24 new agents to the Supabase database.

## Requirements

### Immediate Actions Required

1. **Review Task Specifications**: Read and understand `docs-paperclip/development-paperclip/tasks/2026-04-17-atlas-sql-generation-task.md`

2. **Access Database Schema**: Obtain current Supabase database schema documentation

3. **Generate SQL Scripts**: Create complete migration scripts for:
   - IntegrateForge AI company record
   - 24 agent records with GLM 5.1 model assignments
   - Team associations and skill linkages
   - SaaSForge deployment configurations

4. **Validation Testing**: Ensure SQL syntax correctness and logical consistency

5. **Documentation**: Provide rollback procedures and validation queries

## Agent Details to Include

### Company
- **IntegrateForge AI** (`integrateforge-ai`)
- CEO: `ziggy-orchestrator`
- Industry: AI-Powered Software Integration

### Domain Agents (3)
- **Zara** (`zara-architectural`) - DomainForge AI, Engineering team
- **Finn** (`finn-clash`) - KnowledgeForge AI, Knowledge Engineering team
- **Luna** (`luna-collaboration`) - LearningForge AI, Learning Operations team

### IntegrateForge AI Agents (21)
- **Ziggy** (`ziggy-orchestrator`) - CEO, Integration Leadership team
- **Pixel** (`pixel-bim360`) - BIM 360 Connector
- **Nova** (`nova-navisworks`) - Navisworks Connector
- **Rex** (`rex-revit`) - Revit Connector
- **Ada** (`ada-autocad`) - AutoCAD Connector
- **Terra** (`terra-civil3d`) - Civil 3D Connector
- **Phoenix** (`phoenix-p6`) - P6 Connector
- **Max** (`max-msproject`) - MS Project Connector
- **Astro** (`astro-asta`) - Asta Connector
- **Cash** (`cash-costx`) - CostX Connector
- **Coco** (`coco-candy`) - Candy Connector
- **Corey** (`corey-procore`) - Procore Connector
- **Blake** (`blake-buildsoft`) - Buildsoft Connector
- **Ace** (`ace-aconex`) - Aconex Connector
- **Sasha** (`sasha-sharepoint`) - SharePoint Connector
- **Wiley** (`wiley-projectwise`) - ProjectWise Connector
- **Trix** (`trix-trimble`) - Trimble Connector
- **Stan** (`stan-staad`) - STAAD Connector
- **Eli** (`eli-etabs`) - ETABS Connector
- **Hazel** (`hazel-hecras`) - HEC-RAS Connector
- **Storm** (`storm-swmm`) - SWMM Connector

## Model Assignments

**All agents must use GLM 5.1 model with:**
- Context Window: 131,072 tokens
- Temperature: 0.7
- Max Tokens: 4000-6000 (based on agent complexity)

## Deliverables

1. **Migration Script**: `integrateforge-ai-migration-2026-04-17.sql`
2. **Validation Queries**: Scripts to verify correct implementation
3. **Rollback Procedures**: Safe rollback SQL if needed
4. **Documentation**: Implementation notes and testing procedures

## Acceptance Criteria

- [ ] SQL scripts execute without syntax errors
- [ ] All 24 agents created with correct metadata
- [ ] GLM 5.1 model properly assigned to all agents
- [ ] Team associations and skill linkages functional
- [ ] SaaSForge deployment templates configured
- [ ] Data integrity constraints validated

## Dependencies

- Task `ATLAS-SQL-2026-04-17` specifications
- Access to Supabase database schema
- GLM 5.1 model availability in the system

## Timeline

- **Start**: Immediate (2026-04-17)
- **Deadline**: 2026-04-18 (24 hours)
- **Priority**: High - Blocks SaaSForge deployment

## Success Validation

1. **SQL Execution**: Scripts run successfully in test environment
2. **Data Verification**: All agents appear with correct configurations
3. **Model Testing**: Agents can be instantiated with GLM 5.1 models
4. **Integration Testing**: SaaSForge can reference new agent templates

---

**Assigned**: Atlas (DevForge AI — Product Team)
**Priority**: High
**Status**: Open
**Created**: 2026-04-17
**Dependencies**: DESIGN-004 through DESIGN-007 completion