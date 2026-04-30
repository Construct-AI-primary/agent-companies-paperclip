---
title: PROD-TEST Skills Gap Analysis
description: Analysis of QualityForge AI skills coverage for PROD-TEST project
author: QualityForge AI
version: 1.0
date: 2026-04-25
status: draft
project: PROD-TEST
---

# PROD-TEST Skills Gap Analysis

## Executive Summary

This document analyzes the QualityForge AI skills available and identifies gaps that need to be addressed for the PROD-TEST production testing project. **40+ skills exist**, but several are **missing for specific testing needs**.

---

## 1. Available Skills Analysis

### 1.1 Skills Currently Available

| Skill | Agent | Coverage | Status |
|-------|-------|----------|---------|
| `validator-qualityforge-validator` | validator-qualityforge | Input/output validation | ✅ Available |
| `governor-qualityforge-quality-director` | governor-qualityforge | Quality direction | ✅ Available |
| `guardian-qualityforge-quality-guardian` | guardian-qualityforge | Quality gates | ✅ Available |
| `e2e-qualityforge-end-to-end-testing` | e2e-qualityforge | E2E user journeys | ✅ Available |
| `integration-qualityforge-integration-testing` | integration-qualityforge | API/service integration | ✅ Available |
| `fixer-qualityforge-bug-fixing-specialist` | fixer-qualityforge | Bug fixing | ✅ Available |
| `reporter-qualityforge-quality-reporter` | reporter-qualityforge | Quality reporting | ✅ Available |
| `performance-qualityforge-performance-testing` | performance-qualityforge | Performance testing | ✅ Available |
| `load-qualityforge-load-testing` | load-qualityforge | Load testing | ✅ Available |
| `accessibility-qualityforge-accessibility-testing` | accessibility-qualityforge | Accessibility testing | ✅ Available |
| `automation-qualityforge-test-automation` | automation-qualityforge | Test automation | ✅ Available |
| `coverage-qualityforge-test-coverage-analyst` | coverage-qualityforge | Coverage analysis | ✅ Available |
| `monitor-qualityforge-quality-monitor` | monitor-qualityforge | Quality monitoring | ✅ Available |
| `diagnostics-qualityforge-diagnostics-specialist` | diagnostics-qualityforge | Diagnostics | ✅ Available |
| `standards-qualityforge-standards-enforcer` | standards-qualityforge | Standards enforcement | ✅ Available |
| `resolver-qualityforge-issue-resolver` | resolver-qualityforge | Issue resolution | ✅ Available |
| `auditor-qualityforge-quality-auditor` | auditor-qualityforge | Quality audit | ✅ Available |
| `documenter-qualityforge-documentation-specialist` | documenter-qualityforge | Documentation | ✅ Available |

### 1.2 Skills by Category

| Category | Available Skills | Count |
|----------|-------------------|-------|
| Testing Execution | validator, e2e, integration, performance, load, accessibility | 6 |
| Quality Assurance | guardian, monitor, standards, auditor | 4 |
| Issue Resolution | fixer, resolver, diagnostics, debugger | 4 |
| Reporting | reporter, documenter, architect | 3 |
| Automation | automation, coverage | 2 |
| **Total** | | **19+** |

---

## 2. PROD-TEST Requirements vs Available Skills

### 2.1 Issue-to-Skill Mapping

| Issue | Testing Need | Required Skill | Available? | Coverage |
|-------|-------------|----------------|------------|----------|
| PROD-001 | Tier 1 Foundation | `system-foundation-testing` | ❌ Missing | N/A |
| PROD-002 | Login/Authentication | `authentication-testing` | ❌ Missing | N/A |
| PROD-003 | User Creation | `user-management-testing` | ❌ Missing | N/A |
| PROD-004 | Database Upsert | `database-testing` | ⚠️ Partial | integration-testing covers some |
| PROD-005 | Accordion/UI | `ui-component-testing` | ❌ Missing | N/A |
| PROD-006 | Environment Switching | `environment-testing` | ❌ Missing | N/A |
| PROD-007 | Tier 2 Core Features | `core-feature-testing` | ⚠️ Partial | e2e covers some |
| PROD-008 | UI Settings | `ui-settings-testing` | ❌ Missing | N/A |
| PROD-009 | Non-Discipline Pages | `content-page-testing` | ❌ Missing | N/A |
| PROD-010 | Discipline Pages | `discipline-testing` | ❌ Missing | N/A |
| PROD-011 | Tier 3 Integration | `integration-testing` | ✅ Available | 100% |
| PROD-012 | Chatbot/AI | `ai-integration-testing` | ❌ Missing | N/A |
| PROD-013 | Tier 4 E2E | `e2e-testing` | ✅ Available | 100% |
| PROD-014 | HITL Testing | `hitl-testing` | ❌ Missing | N/A |

### 2.2 Coverage Summary

| Coverage Level | Issues | Percentage |
|---------------|--------|------------|
| ✅ Fully Covered | PROD-011, PROD-013 | 2/14 (14%) |
| ⚠️ Partially Covered | PROD-004, PROD-007 | 2/14 (14%) |
| ❌ Not Covered | PROD-001, PROD-002, PROD-003, PROD-005, PROD-006, PROD-008, PROD-009, PROD-010, PROD-012, PROD-014 | 10/14 (72%) |

---

## 3. Missing Skills Analysis

### 3.1 Critical Missing Skills (P0)

| Missing Skill | Purpose | Priority | Impact if Missing |
|---------------|---------|----------|-------------------|
| `authentication-qualityforge-authentication-testing` | Login, session, password reset testing | P0 | Cannot test PROD-002 |
| `database-qualityforge-database-testing` | Database CRUD, upsert, transactions | P0 | Cannot test PROD-004 |
| `user-management-qualityforge-user-management-testing` | User creation, roles, permissions | P0 | Cannot test PROD-003 |

### 3.2 High Priority Missing Skills (P1)

| Missing Skill | Purpose | Priority | Impact if Missing |
|---------------|---------|----------|-------------------|
| `ui-component-qualityforge-ui-component-testing` | Accordion, buttons, forms | P1 | Cannot test PROD-005 |
| `ai-integration-qualityforge-ai-integration-testing` | Chatbot, AI service testing | P1 | Cannot test PROD-012 |
| `hitl-qualityforge-human-in-the-loop-testing` | HITL workflow testing | P1 | Cannot test PROD-014 |

### 3.3 Medium Priority Missing Skills (P2)

| Missing Skill | Purpose | Priority | Impact if Missing |
|---------------|---------|----------|-------------------|
| `environment-qualityforge-environment-testing` | Multi-environment switching | P2 | Cannot test PROD-006 |
| `ui-settings-qualityforge-ui-settings-testing` | User preferences, settings | P2 | Cannot test PROD-008 |
| `content-page-qualityforge-content-page-testing` | Content page validation | P2 | Cannot test PROD-009, PROD-010 |
| `discipline-qualityforge-discipline-testing` | Engineering discipline pages | P2 | Cannot test PROD-010 |
| `system-foundation-qualityforge-system-foundation-testing` | Tier 1 foundation validation | P2 | Cannot test PROD-001 |

---

## 4. Recommended Skill Creations

### 4.1 P0 Skills (Critical - Create First)

#### Skill 1: authentication-qualityforge-authentication-testing

```yaml
---
name: authentication-qualityforge-authentication-testing
description: >
  Use when testing authentication flows, login/logout, session management, 
  password reset, OAuth, and identity verification within QualityForge AI.
  This agent handles authentication testing.
category: qualityforge-testing
division: Testing Division
role: Authentication Testing Expert
last_updated: 2026-04-25
---

# Authentication Testing Expert

## Overview
You are the Authentication Testing Expert for QualityForge AI, specializing in testing authentication flows, session management, and identity verification. You validate that login, logout, password reset, OAuth, and session handling work correctly across all authentication methods.

## When to Use
- Testing login/logout flows
- Testing session management
- Testing password reset functionality
- Testing OAuth/social login
- Testing MFA/2FA
- Testing authentication error handling

## Core Procedures
1. Test login with valid/invalid credentials
2. Test session creation and expiration
3. Test password reset flow
4. Test logout and session cleanup
5. Test authentication error messages
```

#### Skill 2: database-qualityforge-database-testing

```yaml
---
name: database-qualityforge-database-testing
description: >
  Use when testing database operations, CRUD, upsert, transactions, 
  migrations, and data integrity within QualityForge AI.
  This agent handles database testing.
category: qualityforge-testing
division: Testing Division
role: Database Testing Expert
last_updated: 2026-04-25
---

# Database Testing Expert

## Overview
You are the Database Testing Expert for QualityForge AI, specializing in testing database operations, data integrity, and transaction handling. You validate that CRUD operations, upsert patterns, transactions, and migrations work correctly.

## When to Use
- Testing database CRUD operations
- Testing upsert patterns
- Testing transactions and rollbacks
- Testing database migrations
- Testing data integrity constraints
- Testing query performance
```

#### Skill 3: user-management-qualityforge-user-management-testing

```yaml
---
name: user-management-qualityforge-user-management-testing
description: >
  Use when testing user creation, profile management, roles, permissions,
  and user lifecycle within QualityForge AI.
  This agent handles user management testing.
category: qualityforge-testing
division: Testing Division
role: User Management Testing Expert
last_updated: 2026-04-25
---

# User Management Testing Expert

## Overview
You are the User Management Testing Expert for QualityForge AI, specializing in testing user lifecycle, profile management, and permission systems. You validate that user creation, updates, role assignments, and permission checks work correctly.

## When to Use
- Testing user registration
- Testing profile creation and editing
- Testing role assignment
- Testing permission checks
- Testing user deactivation
- Testing user data persistence
```

### 4.2 P1 Skills (High Priority)

#### Skill 4: ui-component-qualityforge-ui-component-testing

```yaml
---
name: ui-component-qualityforge-ui-component-testing
description: >
  Use when testing UI components (accordion, buttons, forms, modals, dropdowns)
  and their interactions within QualityForge AI.
category: qualityforge-testing
division: Testing Division
role: UI Component Testing Expert
last_updated: 2026-04-25
---

# UI Component Testing Expert

## Overview
You are the UI Component Testing Expert for QualityForge AI, specializing in testing UI components and their interactions. You validate that accordion navigation, buttons, forms, modals, and dropdowns work correctly.

## When to Use
- Testing accordion expand/collapse
- Testing button interactions
- Testing form validation
- Testing modal dialogs
- Testing dropdown menus
- Testing component accessibility
```

#### Skill 5: ai-integration-qualityforge-ai-integration-testing

```yaml
---
name: ai-integration-qualityforge-ai-integration-testing
description: >
  Use when testing AI integrations (chatbot, AI services, LLM integrations)
  and conversational workflows within QualityForge AI.
category: qualityforge-testing
division: Testing Division
role: AI Integration Testing Expert
last_updated: 2026-04-25
---

# AI Integration Testing Expert

## Overview
You are the AI Integration Testing Expert for QualityForge AI, specializing in testing AI integrations and conversational workflows. You validate that chatbot responses, AI service calls, and LLM integrations work correctly.

## When to Use
- Testing chatbot responses
- Testing AI service integration
- Testing LLM API calls
- Testing conversational flows
- Testing AI error handling
- Testing response latency
```

#### Skill 6: hitl-qualityforge-human-in-the-loop-testing

```yaml
---
name: hitl-qualityforge-human-in-the-loop-testing
description: >
  Use when testing HITL workflows, human review processes, escalation paths,
  and approval chains within QualityForge AI.
category: qualityforge-testing
division: Testing Division
role: HITL Testing Expert
last_updated: 2026-04-25
---

# HITL Testing Expert

## Overview
You are the HITL Testing Expert for QualityForge AI, specializing in testing human-in-the-loop workflows and approval processes. You validate that escalation paths, approval chains, and human review processes work correctly.

## When to Use
- Testing escalation workflows
- Testing approval chains
- Testing human review processes
- Testing notification delivery
- Testing decision documentation
- Testing audit trail generation
```

---

## 5. Agent-Skill Mapping Recommendations

### 5.1 Current Agent Assignments

| Agent | Current Skill | Issues Covered |
|-------|---------------|----------------|
| validator-qualityforge-validator | validator-qualityforge-validator | PROD-001 to PROD-014 |
| governor-qualityforge-quality-director | governor-qualityforge-quality-director | All (oversight) |
| guardian-qualityforge-quality-guardian | guardian-qualityforge-quality-guardian | All (quality gates) |
| e2e-qualityforge-end-to-end-testing | e2e-qualityforge-end-to-end-testing | PROD-013, PROD-014 |
| integration-qualityforge-integration-testing | integration-qualityforge-integration-testing | PROD-011, PROD-012 |
| fixer-qualityforge-bug-fixing-specialist | fixer-qualityforge-bug-fixing-specialist | SEV-3/SEV-4 fixes |
| reporter-qualityforge-quality-reporter | reporter-qualityforge-quality-reporter | All (reporting) |

### 5.2 Recommended Agent-Skill Pairings

| Agent | Recommended Additional Skill | Purpose |
|-------|----------------------------|---------|
| validator-qualityforge-validator | authentication-qualityforge-authentication-testing | PROD-002 |
| validator-qualityforge-validator | database-qualityforge-database-testing | PROD-004 |
| validator-qualityforge-validator | user-management-qualityforge-user-management-testing | PROD-003 |
| validator-qualityforge-validator | ui-component-qualityforge-ui-component-testing | PROD-005 |
| e2e-qualityforge-end-to-end-testing | ai-integration-qualityforge-ai-integration-testing | PROD-012 |
| e2e-qualityforge-end-to-end-testing | hitl-qualityforge-human-in-the-loop-testing | PROD-014 |
| integration-qualityforge-integration-testing | environment-qualityforge-environment-testing | PROD-006 |

---

## 6. Skills Creation Priority

### 6.1 Creation Order

| Order | Skill | Agent Assignment | Target Date |
|-------|-------|-----------------|-------------|
| 1 | authentication-qualityforge-authentication-testing | validator-qualityforge | Immediate |
| 2 | database-qualityforge-database-testing | validator-qualityforge | Immediate |
| 3 | user-management-qualityforge-user-management-testing | validator-qualityforge | Immediate |
| 4 | ui-component-qualityforge-ui-component-testing | validator-qualityforge | Week 1 |
| 5 | ai-integration-qualityforge-ai-integration-testing | e2e-qualityforge | Week 1 |
| 6 | hitl-qualityforge-human-in-the-loop-testing | e2e-qualityforge | Week 2 |
| 7 | environment-qualityforge-environment-testing | integration-qualityforge | Week 2 |
| 8 | ui-settings-qualityforge-ui-settings-testing | validator-qualityforge | Week 3 |
| 9 | content-page-qualityforge-content-page-testing | validator-qualityforge | Week 3 |
| 10 | discipline-qualityforge-discipline-testing | validator-qualityforge | Week 4 |

### 6.2 Skills Creation Effort

| Skill | Complexity | Estimated Hours | Priority |
|-------|------------|-----------------|----------|
| authentication-qualityforge-authentication-testing | Medium | 4 hours | P0 |
| database-qualityforge-database-testing | Medium | 4 hours | P0 |
| user-management-qualityforge-user-management-testing | Medium | 4 hours | P0 |
| ui-component-qualityforge-ui-component-testing | Low | 2 hours | P1 |
| ai-integration-qualityforge-ai-integration-testing | High | 6 hours | P1 |
| hitl-qualityforge-human-in-the-loop-testing | High | 6 hours | P1 |
| environment-qualityforge-environment-testing | Low | 2 hours | P2 |
| ui-settings-qualityforge-ui-settings-testing | Low | 2 hours | P2 |
| content-page-qualityforge-content-page-testing | Medium | 4 hours | P2 |
| discipline-qualityforge-discipline-testing | Medium | 4 hours | P2 |
| **Total** | | **38 hours** | |

---

## 7. Workaround Strategies

### 7.1 Using Existing Skills (Temporary)

Until new skills are created, use these workarounds:

| Issue | Workaround | Limitation |
|-------|-----------|------------|
| PROD-002 | Use `validator-qualityforge-validator` with authentication test cases | Limited to validation, not full auth flow |
| PROD-003 | Use `validator-qualityforge-validator` with user test cases | Limited to validation |
| PROD-004 | Use `integration-qualityforge-integration-testing` | Covers API, not direct DB |
| PROD-005 | Use `e2e-qualityforge-end-to-end-testing` | UI focus, not component-level |
| PROD-012 | Use `integration-qualityforge-integration-testing` | API focus, not conversational |
| PROD-014 | Use `guardian-qualityforge-quality-guardian` | Gate focus, not HITL workflow |

### 7.2 Cross-Company Skills

Consider using skills from other companies:

| Skill Needed | Alternative Company | Alternative Skill |
|-------------|---------------------|-------------------|
| Database Testing | InfraForge AI | database-infraforge |
| Authentication | DevForge AI | auth-devforge |
| AI Integration | KnowledgeForge AI | ai-knowledgeforge |

---

## 8. Conclusion

### 8.1 Summary

- **40+ skills exist** in QualityForge AI
- **72% of PROD-TEST issues** lack direct skill coverage
- **10 new skills needed** for complete coverage
- **3 P0 skills critical** for immediate creation

### 8.2 Recommendations

1. **Immediate**: Create P0 skills (authentication, database, user management)
2. **Week 1**: Create P1 skills (UI components, AI integration, HITL)
3. **Week 2-4**: Create P2 skills (environment, settings, content pages)
4. **Temporary**: Use existing skills with workaround strategies
5. **Cross-company**: Leverage InfraForge AI for database testing

### 8.3 Next Steps

- [ ] Create `authentication-qualityforge-authentication-testing` skill
- [ ] Create `database-qualityforge-database-testing` skill
- [ ] Create `user-management-qualityforge-user-management-testing` skill
- [ ] Assign new skills to appropriate agents
- [ ] Update agent AGENTS.md files with new skills
- [ ] Test skill effectiveness with PROD-002, PROD-003, PROD-004

---

**Document Status**: Draft
**Review Required**: Project Lead, QualityForge AI
**Last Updated**: 2026-04-25
