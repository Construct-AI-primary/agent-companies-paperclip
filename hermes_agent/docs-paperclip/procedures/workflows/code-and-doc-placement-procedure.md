---
title: Code and Documentation Placement Procedure
author: PaperclipForge AI
date: 2026-04-15
version: 1.0
status: active
---

# Code and Documentation Placement Procedure

## Overview

This procedure defines the standardized location for all code and documentation generated within the Paperclip ecosystem. Agents should follow these placement guidelines to ensure consistent organization and easy discoverability across all disciplines and projects.

## Purpose

- **Consistency**: Ensure uniform file organization across all disciplines
- **Discoverability**: Make it easy to find any file in the ecosystem
- **Separation of Concerns**: Keep documentation separate from implementation code
- **Cross-Platform Support**: Standardize platform-specific file organization
- **Maintainability**: Simplify updates and refactoring

---

## Repository Structure

The Paperclip ecosystem uses **two repositories**:

| Repository | URL | Purpose |
|------------|-----|---------|
| **paperclip-render** | `https://github.com/Construct-AI-primary/paperclip-render.git` | Implementation code only |
| **docs-paperclip** | `https://github.com/Construct-AI-primary/docs-paperclip.git` | Documentation, plans, issues, procedures |

### Critical Rule
> ⚠️ **Never put implementation code in docs-paperclip**
> ⚠️ **Never put documentation in paperclip-render**
> ⚠️ **Never put code in docs-paperclip**
> ⚠️ **Never put docs in paperclip-render**

---

## Documentation Placement (docs-paperclip)

e.g. 

```
docs-paperclip/disciplines/{discipline-code}/
├── CODE-AND-DOC-PLACEMENT.md    ← This discipline's placement standards
├── README.md                     ← Discipline overview
│
├── knowledge/                   ← Cross-project domain knowledge
│   └── PAGE-KNOWLEDGE.md        ← Master knowledge base
│
├── projects/                    ← All discipline projects
│   └── {PROJECT-CODE}/
│       ├── README.md            ← Project overview
│       ├── plan.md              ← Project plan
│       ├── AGENTS.md            ← Project-specific agent instructions
│       │
│       ├── trigger/             ← Project automation triggers
│       │   ├── README.md
│       │   └── {PROJECT}-000-project-automation.md
│       │
│       ├── {PROJECT}-workflows-list.md       ← Workflows catalog
│       ├── {PROJECT}-implementation.md       ← Implementation plan
│       ├── discipline_workflow_conversion_procedure.md
│       │
│       ├── research/            ← Research enhancement plans
│       │   └── {PROJECT}-research-enhancement-plan.md
│       │
│       ├── scripts/             ← Generator scripts
│       │   └── generate-issues.py
│       │
│       ├── desktop/             ← Desktop platform
│       │   ├── trigger/         ← Desktop-specific triggers
│       │   │   ├── README.md
│       │   │   └── {PROJECT}-000-project-automation.md
│       │   ├── issues/
│       │   │   ├── {ISSUE-ID}.md
│       │   │   └── ISSUE-GENERATION-STATUS.md
│       │   ├── learning/
│       │   └── orchestration/
│       │
│       ├── mobile/              ← Mobile platform
│       │   ├── trigger/         ← Mobile-specific triggers
│       │   │   ├── README.md
│       │   │   └── {PROJECT}-000-project-automation.md
│       │   ├── issues/
│       │   │   ├── {ISSUE-ID}.md
│       │   │   └── ISSUE-GENERATION-STATUS.md
│       │   ├── learning/
│       │   └── orchestration/
│       │
│       ├── web/                 ← Web platform
│       │   ├── trigger/         ← Web-specific triggers
│       │   │   ├── README.md
│       │   │   └── {PROJECT}-000-project-automation.md
│       │   ├── issues/
│       │   │   ├── {ISSUE-ID}.md
│       │   │   └── ISSUE-GENERATION-STATUS.md
│       │   ├── learning/
│       │   └── orchestration/
│       │
│       ├── shared/              ← Shared across platforms
│       │   ├── api/             ← API contracts
│       │   ├── business-logic/  ← Business logic docs
│       │   └── data-models/     ← Data model docs
│       │
│       └── knowledge/           ← Project-specific knowledge
│           └── PAGE-KNOWLEDGE.md
│
├── trigger/                     ← Discipline automation triggers
│   ├── README.md
│   └── {AUTO-PROJECT}/
│       └── issues/
│           └── {AUTO-PROJECT}-000-discipline-automation.md
│
├── procedures/                  ← Discipline-specific procedures
│   └── *.md
│
└── plans/                       ← Automation plans
    └── YYYY-MM-DD-*-plan.md
```

---

## Implementation Code Placement (paperclip-render)

### Standard Code Structure

```
paperclip-render/
├── server/                      ← Backend API
│   └── src/
│       ├── routes/
│       ├── services/
│       ├── middleware/
│       └── types/
│
├── ui/                         ← Frontend
│   └── src/
│       ├── components/
│       ├── pages/
│       └── hooks/
│
├── packages/
│   ├── db/                     ← Database schemas
│   │   └── src/schema/
│   │
│   ├── shared/                 ← Shared types/constants
│   │   └── src/
│   │
│   └── adapters/               ← Agent adapters
│
└── tests/
    ├── unit/
    ├── integration/
    └── e2e/
```

---

## Placement by File Type

### Documentation Files → docs-paperclip

| File Type | Location |
|-----------|----------|
| Discipline README | `disciplines/{CODE}/README.md` |
| Placement Standards | `disciplines/{CODE}/CODE-AND-DOC-PLACEMENT.md` |
| Master Knowledge | `disciplines/{CODE}/knowledge/PAGE-KNOWLEDGE.md` |
| Project Knowledge | `disciplines/{CODE}/projects/{PROJECT}/knowledge/PAGE-KNOWLEDGE.md` |
| Discipline Automation Issues | `disciplines/{CODE}/trigger/{AUTO}/issues/` |
| Project Issues | `disciplines/{CODE}/projects/{PROJECT}/{platform}/issues/` |
| Automation Plans | `disciplines/{CODE}/plans/` |
| Discipline Procedures | `disciplines/{CODE}/procedures/` |
| Workflow Orchestration | `disciplines/{CODE}/projects/{PROJECT}/{platform}/orchestration/` |

### Implementation Code → paperclip-render

| Code Type | Location |
|-----------|----------|
| Backend Routes | `server/src/routes/` |
| Backend Services | `server/src/services/` |
| Backend Middleware | `server/src/middleware/` |
| Backend Types | `server/src/types/` |
| Frontend Components | `ui/src/components/` |
| Frontend Pages | `ui/src/pages/` |
| Frontend Hooks | `ui/src/hooks/` |
| Database Schemas | `packages/db/src/schema/` |
| Shared Types | `packages/shared/src/` |
| Agent Adapters | `packages/adapters/` |
| Unit Tests | `tests/unit/` |
| Integration Tests | `tests/integration/` |
| E2E Tests | `tests/e2e/` |

---

## Issue File Requirements

Every generated issue MUST include a **"Working Directory & Repository"** section:

```markdown
## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`

### Documentation (docs-paperclip)
- `docs-paperclip/disciplines/02500-security/projects/SECURITY-ASSET/mobile/issues/MOBILE-SEC-001.md`

### Code Implementation (paperclip-render)
- `paperclip-render/server/src/services/security-service.ts`
- `paperclip-render/ui/src/components/security/LoginScreen.tsx`
```

---

## Platform-Specific Guidelines

### Desktop Platform
```
projects/{PROJECT}/desktop/
├── trigger/         ← Desktop-specific triggers
│   ├── README.md
│   └── {PROJECT}-000-project-automation.md
├── issues/          ← Desktop-specific issues
│   ├── {ISSUE-ID}.md
│   └── ISSUE-GENERATION-STATUS.md
├── learning/        ← Desktop learning tracker
└── orchestration/   ← Desktop execution tracking
```

### Mobile Platform
```
projects/{PROJECT}/mobile/
├── trigger/         ← Mobile-specific triggers
│   ├── README.md
│   └── {PROJECT}-000-project-automation.md
├── issues/          ← Mobile-specific issues
│   ├── {ISSUE-ID}.md
│   └── ISSUE-GENERATION-STATUS.md
├── learning/        ← Mobile learning tracker
└── orchestration/   ← Mobile execution tracking
```

### Web Platform
```
projects/{PROJECT}/web/
├── trigger/         ← Web-specific triggers
│   ├── README.md
│   └── {PROJECT}-000-project-automation.md
├── issues/          ← Web-specific issues
│   ├── {ISSUE-ID}.md
│   └── ISSUE-GENERATION-STATUS.md
├── learning/        ← Web learning tracker
└── orchestration/   ← Web execution tracking
```

### Shared Components
```
projects/{PROJECT}/shared/
├── api/             ← API contracts (OpenAPI/Swagger specs)
├── business-logic/  ← Business logic documentation
├── data-models/     ← Data model definitions
└── AUTH.md          ← Authentication implementation details
```

---

## Discipline-Specific Placement Documents

Each discipline MUST have a `CODE-AND-DOC-PLACEMENT.md` file:

**Location**: `docs-paperclip/disciplines/{discipline-code}/CODE-AND-DOC-PLACEMENT.md`

This file should include:
1. Discipline-specific paths (if any)
2. Platform requirements unique to the discipline
3. Security or compliance considerations
4. Integration points specific to the discipline

---

## Procedure Workflow

### Step 1: Identify File Type
Determine if the file is:
- **Documentation** (stays in docs-paperclip)
- **Implementation Code** (goes to paperclip-render)

### Step 2: Determine Platform Scope
- Desktop-only → `desktop/` folder
- Mobile-only → `mobile/` folder
- Web-only → `web/` folder
- Cross-platform → `shared/` folder + all platform folders

### Step 3: Apply Discipline Prefix
All paths include the discipline code:
- `disciplines/02500-security/` - Security discipline
- `disciplines/01900-procurement/` - Procurement discipline
- `disciplines/00850-civil-engineering/` - Civil Engineering discipline

### Step 4: Create Issue Reference
Every code change should have an associated issue in:
`disciplines/{CODE}/projects/{PROJECT}/{platform}/issues/{ISSUE-ID}.md`

### Step 5: HITL Review (MANDATORY)
⚠️ **CRITICAL**: Before submitting issues to Paperclip board, all issues MUST pass Human-in-the-Loop (HITL) review:

**Review Criteria:**
- Completeness: Title, description, assignee, priority, platform, discipline code
- Quality: Clarity, actionability, dependencies, estimates, acceptance criteria
- Alignment: Project fit, company strategy, resource availability, timeline feasibility

**Review Actions:**
| Action | Result |
|--------|--------|
| Approve | Submit to Paperclip |
| Request Changes | Return for modification |
| Reject | Out of scope (provide alternatives) |
| Escalate | Leadership decision required |

**SLA Targets:**
| Priority | Review SLA | Escalation Threshold |
|----------|------------|---------------------|
| Critical | 1 hour | 30 min |
| High | 4 hours | 120 min |
| Medium | 24 hours | 480 min |
| Low | 72 hours | 1440 min |

### Step 6: Paperclip Submission
Only after HITL approval, submit to Paperclip board via API.

### Step 7: Execution & Monitoring
Track progress, handle conflicts, ensure completion through Paperclip.

### Step 8: Learning Integration
Capture learnings and improve future automation runs.

---

## Quality Assurance

### Pre-Commit Checklist
- [ ] Documentation in correct docs-paperclip location
- [ ] Code in correct paperclip-render location
- [ ] No code in docs-paperclip repository
- [ ] No docs in paperclip-render repository
- [ ] Issue references both repositories
- [ ] Platform-specific files in correct folder
- [ ] Shared components documented in shared/ folder
- [ ] PAGE-KNOWLEDGE.md updated if knowledge added

### Common Mistakes to Avoid

| Mistake | Correction |
|---------|------------|
| ❌ Putting code in docs-paperclip | → Code goes to paperclip-render |
| ❌ Putting docs in paperclip-render | → Docs go to docs-paperclip |
| ❌ Mixing platforms | → Use desktop/, mobile/, web/ folders |
| ❌ Forgetting shared/ folder | → Document shared components separately |
| ❌ No issue reference | → Always create issue before code |
| ❌ Wrong discipline code | → Verify discipline prefix |

---

## Cross-Repository Dependencies

When documentation references code:
```markdown
## Implementation

See implementation in:
- `paperclip-render/server/src/services/security-service.ts`
- `paperclip-render/packages/db/src/schema/security.ts`
```

When code references documentation:
```typescript
// See: docs-paperclip/disciplines/02500-security/projects/SECURITY-ASSET/knowledge/PAGE-KNOWLEDGE.md
```

---

## Automation Triggers

Discipline automation issues follow this pattern:
```
disciplines/{CODE}/trigger/{AUTO-PROJECT}/issues/{AUTO-PROJECT}-000-discipline-automation.md
```

Example:
```
disciplines/02500-security/trigger/SECURITY-AUTO/issues/SECURITY-AUTO-000-discipline-automation.md
```

---

## Troubleshooting

### File Not Found?
1. Check if in correct repository (docs-paperclip vs paperclip-render)
2. Verify discipline code prefix
3. Check platform folder (desktop/mobile/web)
4. Confirm file naming convention

### Wrong Location?
1. Identify current location
2. Move file to correct location
3. Update all references to the file
4. Update issue documentation

---

## Related Documents

- [Discipline Automation Orchestration Procedure](../agents/discipline-automation-orchestration-procedure.md)
- [Issue File Generation Procedure](../projects/issue-file-generation-procedure.md)
- [Project and Issue Generation Procedure](../projects/project-and-issue-generation-procedure.md)
- [02500 Security Placement Standards](../../disciplines/02500-security/CODE-AND-DOC-PLACEMENT.md)

---

**Document Version**: 1.0
**Last Updated**: 2026-04-15
**Author**: PaperclipForge AI
**Review Cycle**: Quarterly