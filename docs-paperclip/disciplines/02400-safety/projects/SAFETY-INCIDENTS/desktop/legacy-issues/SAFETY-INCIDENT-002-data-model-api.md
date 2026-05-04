---
id: SAFETY-INCIDENT-002
title: Design Incident Investigation and Reporting Data Model and API Layer
phase: Foundation
status: open
priority: high
platform: desktop
---

# SAFETY-INCIDENT-002: Design Incident Investigation and Reporting Data Model and API Layer

## Description

Design and implement the database schema and REST API layer for the Incident Investigation and Reporting system. The data model must support the full workflow lifecycle and enable efficient querying for both desktop and mobile clients.

**Context**: A well-designed data model is critical for the Incident Investigation and Reporting system's reliability and performance. The schema must capture all workflow entities, relationships, and audit trails while supporting company-scoped access patterns.

**Objectives**:
- Design Drizzle ORM schema for all incident investigation and reporting entities
- Implement REST API endpoints with full CRUD operations
- Create shared TypeScript types and validators
- Ensure company-scoped data isolation and access control

## Acceptance Criteria

- [ ] Drizzle schema defines all incident investigation and reporting entities with proper relationships
- [ ] API endpoints follow /api/companies/:companyId/safety/safetyincident pattern
- [ ] Shared types in packages/shared with Zod validators
- [ ] Company-scoped access enforced on all endpoints
- [ ] Activity logging for all mutating operations
- [ ] Migration generated and validated

## Assigned Company & Agent

- **Company:** QualityForge AI
- **Agent:** guardian-qualityforge
- **Supporting:** devforge-ai-workflow-developer, infraforge-ai-integration-specialist

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Primary Repository:** `https://github.com/Construct-AI-primary/construct_ai.git`
  - **Documentation Repository:** `https://github.com/Construct-AI-primary/docs-paperclip.git`
- **Target Files**:
  - `docs-paperclip/disciplines/02400-safety/projects/SAFETY-INCIDENT/desktop/issues/`
  - `packages/shared/src/safety/safetyincident/`
  - `ui/src/pages/safety/safetyincident/`
  - `server/src/routes/safety/safetyincident.ts`

## Required Skills

- Safety domain expertise (QualityForge AI)
- Desktop application development (DevForge AI)
- Database and API design (InfraForge AI)
- Workflow orchestration (QualityForge AI)

## Dependencies

- BLOCKED BY: [SAFETY-INCIDENT project charter approval]
- BLOCKS: [SAFETY-INCIDENT subsequent implementation phases]

## Estimated Effort

- **Complexity**: Complex
- **Estimated Hours**: 32 hours
- **Timeline**: 9 weeks (overall project)

## Paperclip Task Schema

```yaml
company: qualityforge-ai
agent: guardian-qualityforge
toolsets:
  - web_search
  - code_generation
  - database_schema
  - api_development
max_iterations: 80
priority: 8
```

## Technical Notes

**Desktop Platform Considerations**:
- React + Vite frontend with company-scoped routing
- Standard REST API patterns with activity logging
- Dashboard widgets using chart libraries for analytics
- Form validation with shared Zod schemas
- Desktop-first responsive layout (1280px+ viewports)

**Integration Points**:
- Company-scoped API: `/api/companies/:companyId/safety/safetyincident/`
- Shared types: `packages/shared/src/safety/safetyincident/`
- Database schema: `packages/db/src/schema/safetysafetyincident.ts`

## Success Validation

**How to verify completion**:
1. All acceptance criteria items are demonstrably met
2. Desktop interface renders and functions as specified
3. API endpoints respond correctly with company-scoped data
4. Integration with related SAFETY modules verified

**Expected Outcomes**:
- Functional desktop module for incident investigation and reporting operations
- Tested and validated against acceptance criteria
- Documentation updated in project issues directory

---

**Created**: 2026-04-17
**Updated**: 2026-04-17