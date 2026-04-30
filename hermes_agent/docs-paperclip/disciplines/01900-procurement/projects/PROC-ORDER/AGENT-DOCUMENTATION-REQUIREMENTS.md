---
title: PROC-ORDER Agent Documentation Requirements
description: Comprehensive documentation requirements for Paperclip agents working on the PROC-ORDER project
author: Paperclip Documentation System
date: 2026-04-14
version: 1.0
status: active
project_code: PROC-ORDER
discipline: 01900-procurement
---

# PROC-ORDER Agent Documentation Requirements

## Overview

This document specifies what documentation must be provided to Paperclip agents working on the PROC-ORDER (Procurement Order Creation Workflow) project, based on Paperclip's agent execution model, project structure standards, and multi-company orchestration requirements.

**Purpose**: Ensure all agents (DevForge AI, DomainForge AI, QualityForge AI, KnowledgeForge AI, InfraForge AI) have complete, properly formatted documentation to execute their assigned work effectively.

**Reference Standards**:
- `/Users/_Hermes/paperclip-render/docs-paperclip/procedures/projects/project-structure-standardization-procedure.md`
- `/Users/_Hermes/paperclip-render/docs-paperclip/guides/agent-developer/how-agents-work.md`
- `/Users/_Hermes/paperclip-render/server/dist/onboarding-assets/`

---

## Part 1: Agent Onboarding Assets (Runtime Injection)

### 1.1 Required Onboarding Files

These files are injected into the agent's runtime environment at startup and define their fundamental operating instructions.

#### Standard Agent Assets (All Agents)

**Location**: `server/dist/onboarding-assets/default/`

1. **AGENTS.md** (Base Instructions)
```markdown
You are an agent at Paperclip company.

Keep the work moving until it's done. If you need QA to review it, ask them. 
If you need your boss to review it, ask them. If someone needs to unblock you, 
assign them the ticket with a comment asking for what you need. Don't let work 
just sit here. You must always update your task with a comment.
```

**Purpose**: Basic operational guidelines for all agents
**Content Requirements**:
- Work continuation mandate
- Escalation procedures
- Communication requirements
- Task update obligations

#### CEO-Specific Assets (Company Leadership)

**Location**: `server/dist/onboarding-assets/ceo/`

1. **AGENTS.md** (CEO Role Definition)
   - Delegation mandate (MUST delegate, not execute)
   - Routing rules (Code → CTO, Design → UXDesigner, etc.)
   - Strategic responsibilities
   - Hiring authority
   - Cross-functional coordination

2. **HEARTBEAT.md** (Execution Checklist)
   - Identity and context verification
   - Assignment retrieval workflow
   - Checkout procedures
   - Delegation patterns
   - Fact extraction requirements
   - Exit protocols

3. **SOUL.md** (Identity and Personality)
   - Company culture alignment
   - Decision-making principles
   - Communication style
   - Values and priorities

4. **TOOLS.md** (Available Tools Reference)
   - Paperclip API capabilities
   - Skill system documentation
   - External integrations
   - Tool usage guidelines

### 1.2 Environment Variables (Runtime Context)

**Always Injected**:
- `PAPERCLIP_AGENT_ID` — Agent's unique identifier
- `PAPERCLIP_COMPANY_ID` — Company membership
- `PAPERCLIP_API_URL` — API endpoint
- `PAPERCLIP_API_KEY` — Authentication token
- `PAPERCLIP_RUN_ID` — Current heartbeat identifier

**Trigger-Specific**:
- `PAPERCLIP_TASK_ID` — Assigned issue ID
- `PAPERCLIP_WAKE_REASON` — Wake trigger (issue_assigned, comment_mentioned, etc.)
- `PAPERCLIP_WAKE_COMMENT_ID` — Specific comment reference
- `PAPERCLIP_APPROVAL_ID` — Approval request reference
- `PAPERCLIP_APPROVAL_STATUS` — Approval decision (approved/rejected)

---

## Part 2: Project-Level Documentation

### 2.1 Required Project Files

**Location**: `/Users/_Hermes/paperclip-render/docs-paperclip/disciplines/01900-procurement/projects/desktop/PROC-ORDER/`

#### 1. project.md (Project Charter)

**Purpose**: High-level project context, objectives, and team structure
**Required Content**:
- Project overview and business criticality
- Scope definition (in-scope / out-of-scope)
- Success criteria (measurable outcomes)
- Team structure and company assignments
- Development repositories (GitHub URLs)
- Timeline and milestones
- Risk assessment
- Success metrics

**Why Agents Need This**:
- Understand project context and business value
- Know which companies are involved
- Identify correct repositories for code changes
- Understand success criteria for validation
- Assess risk factors affecting their work

**Current PROC-ORDER Status**: ✅ Complete
**File**: `project.md` (121 lines)

#### 2. plan.md (Implementation Plan)

**Purpose**: Detailed technical implementation roadmap
**Required Content**:
- Executive summary with strategic objectives
- Current state analysis
- Phased implementation approach
- Technical architecture details
- Multi-company integration points
- Success metrics and KPIs
- Risk management strategies
- Timeline with weekly breakdown
- Dependencies and prerequisites

**Why Agents Need This**:
- Understand implementation phases and sequencing
- Know technical approach and architecture
- Identify dependencies and prerequisites
- Understand their work within broader context
- Plan work according to project timeline

**Current PROC-ORDER Status**: ✅ Complete
**File**: `plan.md` (297 lines, 4-phase implementation)

#### 3. knowledge/PAGE-KNOWLEDGE.md (Architectural Knowledge)

**Purpose**: Comprehensive technical knowledge base
**Required Content**:
- System architecture overview
- Database schema and data models
- Multi-company orchestration patterns
- Compliance automation architecture
- Audit trail implementation
- Approval matrix integration
- State management patterns
- Testing and QA frameworks
- Performance optimization strategies
- Security considerations
- Code examples and interfaces

**Why Agents Need This**:
- Understand system architecture deeply
- Access reference implementations
- Follow established patterns
- Integrate with existing systems
- Maintain architectural consistency
- Implement compliance requirements
- Build audit-compliant features

**Current PROC-ORDER Status**: ✅ Complete
**File**: `knowledge/PAGE-KNOWLEDGE.md` (959 lines, comprehensive technical reference)

---

## Part 3: Issue-Level Documentation

### 3.1 Paperclip-Compatible Issue Files

**Location**: `/Users/_Hermes/paperclip-render/docs-paperclip/disciplines/01900-procurement/projects/desktop/PROC-ORDER/issues/`

#### Required Issue Format

Each issue file must follow this structure:

```markdown
---
id: {PROJECT-CODE}-{NUMBER}
title: {Clear, actionable title}
phase: {Phase Number} — {Phase Name}
status: {backlog|todo|in_progress|in_review|done|blocked}
priority: {critical|high|medium|low}
assigneeAgentId: {agent-slug}
parent: {parent-issue-id}
project: {PROJECT-CODE}
---

# {PROJECT-CODE}-{NUMBER}: {Title}

## Description
{Detailed description with context, objectives, and scope}

## Acceptance Criteria
- [ ] {Specific, measurable criterion 1}
- [ ] {Specific, measurable criterion 2}
- [ ] {Testing requirement}

## Assigned Company & Agent
- **Company:** {company-slug}
- **Agent:** {agent-slug} ({agent-name})

## Working Directory & Repository
- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Primary Repository:** `https://github.com/Construct-AI-primary/construct_ai.git`
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
- **Target Files:**
  - `{path/to/file.ext}`

## Required Skills
- `{skill-name}` ({company-slug})

## Dependencies
- BLOCKED BY: [{ISSUE-ID}] ({Description})
- BLOCKS: [{ISSUE-ID}] ({Description})

## Estimated Effort
- **Complexity**: {simple|medium|complex}
- **Estimated Hours**: {X-Y hours}
- **Timeline**: {X days}

## Success Validation
**How to verify completion**:
1. {Validation step 1}
2. {Validation step 2}

---

**Created**: {YYYY-MM-DD}
**Updated**: {YYYY-MM-DD}
```

#### Why Agents Need Complete Issue Files

1. **Clear Assignment**: Know exactly what work is assigned to them
2. **Repository Guidance**: No ambiguity about where to write code
3. **Acceptance Criteria**: Understand definition of done
4. **Dependencies**: Know blockers and downstream impacts
5. **Context**: Understand why this work matters
6. **Skills Validation**: Confirm they have required capabilities
7. **Success Validation**: Know how to verify completion

**Current PROC-ORDER Status**: ✅ 25+ issues created with complete frontmatter and content

### 3.2 Issue Status Lifecycle Compliance

All issues must follow Paperclip's status workflow:

```
backlog → todo → in_progress → in_review → done
                        ↓
                    blocked → (todo / in_progress)
```

**Agent Responsibilities**:
- Update status when starting work (`todo` → `in_progress`)
- Update status when requesting review (`in_progress` → `in_review`)
- Update status when blocked (include blocker reason)
- Update status when complete (`in_review` → `done`)
- Add comment with status changes explaining reason

---

## Part 4: Orchestration Documentation (Multi-Company Projects)

### 4.1 Required Orchestration Files

**Location**: `/Users/_Hermes/paperclip-render/docs-paperclip/disciplines/01900-procurement/projects/desktop/PROC-ORDER/orchestration/`

#### 1. OVERVIEW.md
**Purpose**: Multi-company coordination overview
**Content**:
- Project participants and roles
- Communication protocols
- Workflow dependencies
- Integration points
- Escalation procedures

#### 2. LEARNING-INTEGRATION.md
**Purpose**: Cross-company knowledge sharing
**Content**:
- Knowledge transfer protocols
- LearningForge AI integration
- Training requirements
- Documentation standards
- Best practices sharing

#### 3. EXECUTION-TRACKER.md
**Purpose**: Real-time execution status
**Content**:
- Phase completion status
- Active issues by company
- Blockers and dependencies
- Timeline adherence
- Risk status

#### 4. RISK-TRACKER.md
**Purpose**: Risk monitoring and mitigation
**Content**:
- Identified risks
- Mitigation strategies
- Risk owners
- Status updates
- Escalation thresholds

**Why Agents Need Orchestration Docs**:
- Understand multi-company dependencies
- Know communication protocols
- Follow knowledge sharing procedures
- Monitor risks affecting their work
- Coordinate with other companies

**Current PROC-ORDER Status**: ✅ All 4 orchestration files present

---

## Part 5: Knowledge System Integration

### 5.1 KnowledgeForge 3-Layer Memory Model

**Layer 1: Reference Layer (Durable Knowledge)**
- **Location**: `knowledge/PAGE-KNOWLEDGE.md`
- **Content**: Read-only technical architecture and patterns
- **Access**: All agents read this for technical guidance
- **Update Policy**: Only KnowledgeForge AI updates

**Layer 2: Working Layer (Active Project Knowledge)**
- **Location**: Project issues, orchestration docs, plan.md
- **Content**: Active project state, decisions, progress
- **Access**: All agents read and write
- **Update Policy**: Agents update as work progresses

**Layer 3: Session Layer (Daily Memory)**
- **Location**: `memory/YYYY-MM-DD.md` (agent-specific)
- **Content**: Daily findings, context, progress notes
- **Access**: Agent-private, CEO may access
- **Update Policy**: Agent maintains during heartbeats

### 5.2 PARA Method Integration

**Projects** (Active Work):
- Current PROC-ORDER implementation
- Issue files and work-in-progress

**Areas** (Ongoing Responsibilities):
- Procurement domain knowledge
- Company-specific expertise

**Resources** (Reference Material):
- PAGE-KNOWLEDGE.md
- Procedure documents
- Workflow specifications

**Archive** (Historical Data):
- Completed project documentation
- Lessons learned
- Historical decisions

---

## Part 6: Skills and Procedures

### 6.1 Required Skills Documentation

Agents need access to their assigned skills, which provide specialized capabilities:

**Location**: `docs-paperclip/companies/{company-slug}/skills/`

**Common Skills for PROC-ORDER**:
- `procurement-workflow-implementation` (DomainForge AI)
- `react-frontend-development` (DevForge AI)
- `database-schema-design` (InfraForge AI)
- `automated-testing` (QualityForge AI)
- `knowledge-indexing` (KnowledgeForge AI)

**Skill Documentation Requirements**:
```markdown
---
name: {skill-name}
description: {Clear routing decision logic}
---

# {Skill Name}

## Purpose
{What this skill enables}

## Usage
{When and how to use this skill}

## Examples
{Concrete usage examples}

## Integration
{How this integrates with other systems}
```

### 6.2 Required Procedures

Agents need access to relevant procedures for consistent execution:

**Key Procedures for PROC-ORDER**:
- `procedures/projects/project-structure-standardization-procedure.md`
- `procedures/projects/project-and-issue-generation-procedure.md`
- `procedures/agents/agent-model-assignment-procedure.md`
- `procedures/agents/agent-naming-procedure.md`
- `procedures/workflows/universal-workflow-implementation-audit-trail.md`

---

## Part 7: Repository and Working Directory Guidance

### 7.1 Repository Structure

**All issues MUST specify**:
```markdown
## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Primary Repository:** `https://github.com/Construct-AI-primary/construct_ai.git`
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
  - **Documentation Repository:** `https://github.com/Construct-AI-primary/docs-paperclip.git`
  - **Construct AI Docs Repository:** `https://github.com/Construct-AI-primary/construct_ai_docs.git`
```

**Why This Matters**:
- Agents know exactly where to clone/pull code
- No ambiguity about working directory
- Clear GitHub repository targets
- Proper multi-repo coordination

### 7.2 Target Files Specification

Issues should specify exact files to modify:

```markdown
- **Target Files:**
  - `src/web/features/procurement/PurchaseOrderScreen.tsx`
  - `src/web/store/slices/procurementSlice.ts`
  - `packages/db/src/schema/procurement.ts`
```

**Benefits**:
- Focused work scope
- Reduced context searching
- Faster task completion
- Clear testing targets

---

## Part 8: Communication and Collaboration

### 8.1 Issue Comments and Updates

**Required Comment Format**:
```markdown
## Status Update

**Current Status**: {status}
**Progress**: {brief summary}

### Completed
- {item 1}
- {item 2}

### In Progress
- {item 3}

### Blockers
- {blocker description with reference to blocking issue}

### Next Steps
- {planned action 1}
- {planned action 2}

**References**: #{linked-issue-id}, @{mentioned-agent}
```

### 8.2 Cross-Company Communication

**Mention Syntax**:
- `@{agent-slug}` — Direct agent mention
- `#{issue-id}` — Issue reference
- `@{company-slug}/CEO` — Company leadership escalation

**Communication Protocols**:
1. Comment on issues for progress updates
2. Mention relevant agents for handoffs
3. Update orchestration docs for cross-company changes
4. Use LearningForge integration for knowledge sharing

---

## Part 9: Documentation Validation Checklist

### 9.1 Pre-Assignment Validation

Before assigning work to an agent, verify:

- [ ] Issue file exists with complete frontmatter
- [ ] project.md provides project context
- [ ] plan.md shows implementation roadmap
- [ ] knowledge/PAGE-KNOWLEDGE.md contains technical architecture
- [ ] Working directory and repository specified
- [ ] Target files identified
- [ ] Acceptance criteria defined
- [ ] Dependencies documented
- [ ] Required skills listed
- [ ] Success validation steps provided

### 9.2 Documentation Completeness Score

**Minimum Viable Documentation** (60%):
- ✅ Issue file with frontmatter
- ✅ Basic project.md
- ✅ Repository specification
- ✅ Acceptance criteria

**Standard Documentation** (80%):
- ✅ All Minimum Viable items
- ✅ Complete plan.md
- ✅ Basic PAGE-KNOWLEDGE.md
- ✅ Dependencies documented
- ✅ Target files specified

**Comprehensive Documentation** (100%):
- ✅ All Standard items
- ✅ Detailed PAGE-KNOWLEDGE.md
- ✅ Orchestration documentation
- ✅ Skills and procedures linked
- ✅ Learning integration specified
- ✅ Risk tracking in place

**Current PROC-ORDER Score**: ✅ 100% (Comprehensive)

---

## Part 10: Summary of Required Documentation

### 10.1 Documentation Layers

**Layer 1: Runtime Injection** (Onboarding Assets)
- ✅ `server/dist/onboarding-assets/default/AGENTS.md`
- ✅ `server/dist/onboarding-assets/ceo/AGENTS.md`
- ✅ `server/dist/onboarding-assets/ceo/HEARTBEAT.md`
- ✅ `server/dist/onboarding-assets/ceo/SOUL.md`
- ✅ `server/dist/onboarding-assets/ceo/TOOLS.md`

**Layer 2: Project Context**
- ✅ `project.md` — Project charter and objectives
- ✅ `plan.md` — Implementation roadmap
- ✅ `knowledge/PAGE-KNOWLEDGE.md` — Technical architecture

**Layer 3: Task Assignment**
- ✅ `issues/{PROJECT-CODE}-{NUMBER}-{slug}.md` — Individual task files
- ✅ Complete frontmatter with status, assignee, dependencies
- ✅ Repository and working directory specification
- ✅ Target files and acceptance criteria

**Layer 4: Orchestration** (Complex Projects)
- ✅ `orchestration/OVERVIEW.md` — Multi-company coordination
- ✅ `orchestration/LEARNING-INTEGRATION.md` — Knowledge sharing
- ✅ `orchestration/EXECUTION-TRACKER.md` — Progress monitoring
- ✅ `orchestration/RISK-TRACKER.md` — Risk management

**Layer 5: Supporting Documentation**
- ✅ Skills documentation in company directories
- ✅ Procedures in `docs-paperclip/procedures/`
- ✅ API documentation in `docs-paperclip/api/`
- ✅ Schema documentation in `docs-paperclip/schema/`

### 10.2 Agent-Specific Requirements

**All Agents**:
- Default AGENTS.md
- Assigned issue files
- project.md and plan.md
- PAGE-KNOWLEDGE.md
- Repository specifications

**CEO Agents**:
- CEO-specific AGENTS.md
- HEARTBEAT.md (execution checklist)
- SOUL.md (identity)
- TOOLS.md (capabilities)
- Cross-company orchestration docs

**Technical Agents** (DevForge, InfraForge):
- Technical skills documentation
- Database schema references
- API documentation
- Code examples in PAGE-KNOWLEDGE.md

**Domain Agents** (DomainForge):
- Domain-specific procedures
- Compliance documentation
- Business rules and workflows
- Approval matrix specifications

**Quality Agents** (QualityForge):
- Testing procedures
- Quality metrics
- Test scenarios and expectations
- Validation frameworks

**Knowledge Agents** (KnowledgeForge):
- Knowledge indexing procedures
- PARA system documentation
- Memory layer specifications
- Documentation standards

---

## Part 11: Implementation Recommendations

### 11.1 Documentation Generation Workflow

**For New Projects**:
1. Create project structure using standardization procedure
2. Populate project.md with charter
3. Create detailed plan.md
4. Build PAGE-KNOWLEDGE.md with technical architecture
5. Generate issue files with complete frontmatter
6. Add orchestration docs for complex projects
7. Link relevant skills and procedures
8. Validate documentation completeness (target 100%)

**For PROC-ORDER Specifically**:
✅ All required documentation already exists
✅ Documentation completeness: 100%
✅ Ready for agent assignment

### 11.2 Documentation Maintenance

**Weekly**:
- Update EXECUTION-TRACKER.md with progress
- Review and update RISK-TRACKER.md
- Update issue statuses and comments
- Sync PAGE-KNOWLEDGE.md with implementation changes

**Monthly**:
- Review project.md for scope changes
- Update plan.md for timeline adjustments
- Archive completed issues
- Update success metrics

**Project Completion**:
- Archive all project documentation
- Extract lessons learned
- Update procedure templates
- Publish to knowledge base

---

## Part 12: Quality Assurance

### 12.1 Documentation Quality Metrics

**Completeness**:
- All required files present: ✅
- All frontmatter fields populated: ✅
- Repository specifications complete: ✅
- Dependencies documented: ✅

**Clarity**:
- Clear, actionable language: ✅
- Concrete examples provided: ✅
- Technical details sufficient: ✅
- Success criteria measurable: ✅

**Accessibility**:
- Files in correct locations: ✅
- Naming conventions followed: ✅
- Cross-references working: ✅
- Search-friendly structure: ✅

**Maintainability**:
- Version control in place: ✅
- Update procedures defined: ✅
- Ownership assigned: ✅
- Review cycles established: ✅

### 12.2 Agent Success Indicators

**Documentation enables agent success when**:
- ✅ Agents can start work without clarification requests
- ✅ Agents understand project context and business value
- ✅ Agents know exactly where to write code
- ✅ Agents have clear acceptance criteria
- ✅ Agents can validate their work independently
- ✅ Agents understand dependencies and coordination needs
- ✅ Agents follow established patterns and architectures
- ✅ Agents communicate effectively with other companies

---

## Conclusion

### PROC-ORDER Documentation Status: ✅ COMPLETE

All required documentation for Paperclip agents working on the PROC-ORDER project is in place:

1. ✅ **Onboarding Assets**: Standard and CEO-specific runtime documentation
2. ✅ **Project Context**: project.md (121 lines), plan.md (297 lines)
3. ✅ **Technical Knowledge**: PAGE-KNOWLEDGE.md (959 lines)
4. ✅ **Task Assignments**: 25+ complete issue files
5. ✅ **Orchestration**: 4 coordination documents
6. ✅ **Supporting Docs**: Skills, procedures, schemas

### Documentation Completeness Score: 100%

The PROC-ORDER project meets all documentation requirements for agent execution. Agents from DevForge AI, DomainForge AI, QualityForge AI, KnowledgeForge AI, and InfraForge AI have complete context to execute their assigned work effectively.

### Next Steps

1. **Assign Issues**: Issues are ready for agent assignment
2. **Monitor Progress**: Use EXECUTION-TRACKER.md for monitoring
3. **Update Documentation**: Maintain as implementation progresses
4. **Extract Learnings**: Document patterns for future projects

---

**Document Control**
- **Version**: 1.0
- **Date**: 2026-04-14
- **Author**: Paperclip Documentation System
- **Status**: Active
- **Review Cycle**: Weekly during active development
- **Next Review**: 2026-04-21

**Related Documents**
- `project-structure-standardization-procedure.md`: Project structure standards
- `how-agents-work.md`: Agent execution model
- `project.md`: PROC-ORDER charter
- `plan.md`: Implementation plan
- `knowledge/PAGE-KNOWLEDGE.md`: Technical architecture
