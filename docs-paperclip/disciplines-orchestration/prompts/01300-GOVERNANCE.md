# GOVERNANCE — Dispatch Prompts

**Project**: GOVERNANCE-FORMS
**Discipline**: 01300 — Governance
**Server**: ENGINEERING
**Issues**: 15 (GOVERNANCE-001 through GOVERNANCE-015)
**Phases**: 5
**Integration Chains**: INT-006, INT-007

---

## Phase 1 — Foundation (100% pass threshold, 0 critical allowed)

**Dispatch command (in #ai-work on ENGINEERING server):**
```
@agent work on GOVERNANCE-001,GOVERNANCE-002,GOVERNANCE-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| GOVERNANCE-001 | 01300 Page Foundation — Login, Navigation & Logout | domainforge-ai | DomainForge AI | #domainforge-governance-foundation |
| GOVERNANCE-002 | 01300 Database & API Connectivity | infraforge-ai | InfraForge AI | #infraforge-governance-database |
| GOVERNANCE-003 | 01300 Page Layout & Navigation | devforge-ai | DevForge AI | #devforge-governance-layout |

**Phase Gate 1**: 100% pass rate, 0 critical issues → DomainForge AI

---

## Phase 2 — Policy Management (>95% pass threshold, 0 critical allowed)

**After Phase Gate 1 passes:**
```
@agent work on GOVERNANCE-004,GOVERNANCE-005,GOVERNANCE-006 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| GOVERNANCE-004 | Agents State — Form Queue & Detail | domainforge-ai | DomainForge AI | #domainforge-governance-agents |
| GOVERNANCE-005 | Upsert State — Form Submission & Edit | devforge-ai | DevForge AI | #devforge-governance-upserts |
| GOVERNANCE-006 | Workspace State — Template Management | devforge-ai | DevForge AI | #devforge-governance-workspace |

**Phase Gate 2**: >95% pass rate, 0 critical issues → DomainForge AI

---

## Phase 3 — Approval Pipeline (>90% pass threshold, ≤1 critical allowed)

**After Phase Gate 2 passes:**
```
@agent work on GOVERNANCE-007,GOVERNANCE-008,GOVERNANCE-009 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| GOVERNANCE-007 | Document Control Integration (INT-006) | domainforge-ai | DomainForge AI | #domainforge-governance-doc-int |
| GOVERNANCE-008 | Multi-Level Approval Workflow | domainforge-ai | DomainForge AI | #domainforge-governance-approval |
| GOVERNANCE-009 | Compliance Enforcement & Rules | devforge-ai | DevForge AI | #devforge-governance-compliance |

**Phase Gate 3**: >90% pass rate, ≤1 critical issue → DomainForge AI

---

## Phase 4 — Compliance (>85% pass threshold, ≤2 critical allowed)

**After Phase Gate 3 passes:**
```
@agent work on GOVERNANCE-010,GOVERNANCE-011,GOVERNANCE-012 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| GOVERNANCE-010 | Escalation Handling & Override | domainforge-ai | DomainForge AI | #domainforge-governance-escalation |
| GOVERNANCE-011 | Form Withdrawal & Amendment | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-governance-withdrawal |
| GOVERNANCE-012 | Rejected Resubmission Workflow | devforge-ai | DevForge AI | #devforge-governance-resubmission |

**Phase Gate 4**: >85% pass rate, ≤2 critical issues → DomainForge AI

---

## Phase 5 — Sign-off (Go/no-go)

**After Phase Gate 4 passes:**
```
@agent work on GOVERNANCE-013,GOVERNANCE-014,GOVERNANCE-015 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| GOVERNANCE-013 | Audit Trail & History | devforge-ai | DevForge AI | #devforge-governance-audit |
| GOVERNANCE-014 | Compliance Reporting & Dashboards | measureforge-ai | MeasureForge AI | #measureforge-governance-reporting |
| GOVERNANCE-015 | Template Management & Sign-off | validator-qualityforge + ALL | QualityForge AI + ALL | #devforge-governance-signoff |

**Phase Gate 5**: Go/no-go recommendation → CEO

---

## Integration Chain Touchpoints

| Chain ID | Trigger Point | Data Flow | Status |
|----------|---------------|-----------|--------|
| INT-006 | After GOVERNANCE-007 | 00900 Document Control → 01300 Governance (Document Approval) | 🔴 Pending Wave 3 |
| INT-007 | After GOVERNANCE-009 | 01300 Governance → 02400 Safety (Policy → Safety Workflow) | 🔴 Pending Wave 3 |

---

## Related Documents

- `../disciplines/01300-governance/projects/GOVERNANCE-FORMS/`
- `../../orchestration/EXECUTION-TRACKER.md`
- `../../orchestration/INTEGRATION-REGISTRY.md`