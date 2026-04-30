---
id: ATLAS-SQL-2026-04-17
title: Generate Supabase SQL for IntegrateForge AI Company & Agents
phase: Implementation
status: pending
priority: high
assigneeAgentId: Atlas
parent: DESIGN-WORKFLOW
project: DESIGN-WORKFLOW
created: 2026-04-17
updated: 2026-04-17
---

# ATLAS-SQL-2026-04-17: Generate Supabase SQL for IntegrateForge AI Company & Agents

## Description

**Atlas** (DevForge AI — Product Team) must generate comprehensive SQL migration scripts to add the new IntegrateForge AI company and all associated agents to the Supabase database. This includes proper model assignments, team associations, and data integrity constraints.

## Context

Following the completion of DESIGN-004 through DESIGN-007 workflow specifications and the creation of IntegrateForge AI company documentation, the database needs to be updated to support these new agents in production.

## Requirements

### 1. Company Creation
```sql
INSERT INTO companies (id, name, slug, status, ceo_agent_id, founded, industry, headquarters)
VALUES ('integrateforge-ai', 'IntegrateForge AI', 'integrateforge-ai', 'active', 'integration-orchestrator', '2026-04-17', 'AI-Powered Software Integration', 'Global');
```

### 2. Agent Creation with GLM 5.1 Model Assignments

#### DomainForge AI Agents
```sql
INSERT INTO agents (id, name, company_id, team_id, status, model_id, context_window, temperature, max_tokens) VALUES
('zara-architectural', 'Zara', 'domainforge-ai', 'engineering', 'active', 'glm-5.1', 131072, 0.7, 6000);
```

#### KnowledgeForge AI Agents
```sql
INSERT INTO agents (id, name, company_id, team_id, status, model_id, context_window, temperature, max_tokens) VALUES
('finn-clash', 'Finn', 'knowledgeforge-ai', 'knowledge-engineering', 'active', 'glm-5.1', 131072, 0.7, 6000);
```

#### LearningForge AI Agents
```sql
INSERT INTO agents (id, name, company_id, team_id, status, model_id, context_window, temperature, max_tokens) VALUES
('luna-collaboration', 'Luna', 'learningforge-ai', 'learning-operations', 'active', 'glm-5.1', 131072, 0.7, 6000);
```

#### IntegrateForge AI Agents (21 total)
```sql
-- CEO
INSERT INTO agents (id, name, company_id, team_id, status, model_id, context_window, temperature, max_tokens) VALUES
('ziggy-orchestrator', 'Ziggy', 'integrateforge-ai', 'integration-leadership', 'active', 'glm-5.1', 131072, 0.7, 6000);

-- Design & BIM Team (5 agents)
INSERT INTO agents (id, name, company_id, team_id, status, model_id, context_window, temperature, max_tokens) VALUES
('pixel-bim360', 'Pixel', 'integrateforge-ai', 'design-bim-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('nova-navisworks', 'Nova', 'integrateforge-ai', 'design-bim-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('rex-revit', 'Rex', 'integrateforge-ai', 'design-bim-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('ada-autocad', 'Ada', 'integrateforge-ai', 'design-bim-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('terra-civil3d', 'Terra', 'integrateforge-ai', 'design-bim-integration', 'active', 'glm-5.1', 131072, 0.7, 4000);

-- Project Controls Team (7 agents - expanded with QS packages)
INSERT INTO agents (id, name, company_id, team_id, status, model_id, context_window, temperature, max_tokens) VALUES
('phoenix-p6', 'Phoenix', 'integrateforge-ai', 'project-controls-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('max-msproject', 'Max', 'integrateforge-ai', 'project-controls-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('astro-asta', 'Astro', 'integrateforge-ai', 'project-controls-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('cash-costx', 'Cash', 'integrateforge-ai', 'project-controls-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('coco-candy', 'Coco', 'integrateforge-ai', 'project-controls-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('corey-procore', 'Corey', 'integrateforge-ai', 'project-controls-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('blake-buildsoft', 'Blake', 'integrateforge-ai', 'project-controls-integration', 'active', 'glm-5.1', 131072, 0.7, 4000);

-- Document Management Team (4 agents)
INSERT INTO agents (id, name, company_id, team_id, status, model_id, context_window, temperature, max_tokens) VALUES
('ace-aconex', 'Ace', 'integrateforge-ai', 'document-management-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('sasha-sharepoint', 'Sasha', 'integrateforge-ai', 'document-management-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('wiley-projectwise', 'Wiley', 'integrateforge-ai', 'document-management-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('trix-trimble', 'Trix', 'integrateforge-ai', 'document-management-integration', 'active', 'glm-5.1', 131072, 0.7, 4000);

-- Analysis Tools Team (4 agents)
INSERT INTO agents (id, name, company_id, team_id, status, model_id, context_window, temperature, max_tokens) VALUES
('stan-staad', 'Stan', 'integrateforge-ai', 'analysis-tools-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('eli-etabs', 'Eli', 'integrateforge-ai', 'analysis-tools-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('hazel-hecras', 'Hazel', 'integrateforge-ai', 'analysis-tools-integration', 'active', 'glm-5.1', 131072, 0.7, 4000),
('storm-swmm', 'Storm', 'integrateforge-ai', 'analysis-tools-integration', 'active', 'glm-5.1', 131072, 0.7, 4000);
```

### 3. Team and Skill Associations
- Link all agents to their respective teams
- Associate agents with required skills
- Set up proper reporting hierarchies

### 4. SaaSForge Deployment Templates
- Configure agent templates for multi-tenant deployment
- Set up credential management for third-party integrations
- Establish monitoring and scaling configurations

## Deliverables

1. **Complete SQL Migration Script**: `integrateforge-ai-migration-2026-04-17.sql`
2. **Model Validation Queries**: Scripts to verify correct GLM 5.1 assignments
3. **Data Integrity Checks**: Foreign key and constraint validation
4. **Rollback Procedures**: Safe rollback scripts if needed

## Acceptance Criteria

- [ ] All 24 agents (3 domain + 21 integration) created with correct metadata
- [ ] GLM 5.1 model assigned to all agents with appropriate parameters
- [ ] Team associations and skill linkages properly configured
- [ ] SaaSForge deployment templates configured
- [ ] SQL scripts tested for syntax and logical correctness
- [ ] Data integrity constraints and validation rules included

## Dependencies

- Completion of IntegrateForge AI company documentation
- Availability of GLM 5.1 model in the system
- Access to Supabase database schema documentation

## Success Validation

1. **SQL Execution**: Scripts run successfully without errors
2. **Data Verification**: All agents appear in database with correct configurations
3. **Model Testing**: Agents can be instantiated with GLM 5.1 models
4. **Integration Testing**: SaaSForge can deploy agent templates correctly

---

**Assigned**: Atlas (DevForge AI — Product Team)
**Priority**: High
**Deadline**: 2026-04-18
**Dependencies**: DESIGN-004 through DESIGN-007 completion