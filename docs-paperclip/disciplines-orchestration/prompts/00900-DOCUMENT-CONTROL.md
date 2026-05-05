# DOCUMENT-CONTROL — Dispatch Prompts

**Project**: DOCUMENT-REGISTRY
**Discipline**: 00900 — Document Control
**Server**: ENGINEERING
**Issues**: 15 (DOCUMENT-001 through DOCUMENT-015)
**Phases**: 5
**Integration Chains**: INT-005, INT-006, INT-008

---

## Phase 1 — Foundation (100% pass threshold, 0 critical allowed)

**Dispatch command (in #ai-work on ENGINEERING server):**
```
@agent work on DOCUMENT-001,DOCUMENT-002,DOCUMENT-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| DOCUMENT-001 | 00900 Page Foundation — Login, Navigation & Logout | domainforge-ai | DomainForge AI | #domainforge-document-foundation |
| DOCUMENT-002 | 00900 Database & API Connectivity | infraforge-ai | InfraForge AI | #infraforge-document-database |
| DOCUMENT-003 | 00900 Page Layout & Navigation | devforge-ai | DevForge AI | #devforge-document-layout |

**Phase Gate 1**: 100% pass rate, 0 critical issues → DomainForge AI

---

## Phase 2 — Document Lifecycle (>95% pass threshold, 0 critical allowed)

**After Phase Gate 1 passes:**
```
@agent work on DOCUMENT-004,DOCUMENT-005,DOCUMENT-006 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| DOCUMENT-004 | Agents State — Document Registry & Detail | domainforge-ai | DomainForge AI | #domainforge-document-agents |
| DOCUMENT-005 | Upsert State — Document Upload & Metadata | devforge-ai | DevForge AI | #devforge-document-upserts |
| DOCUMENT-006 | Workspace State — Version Control | devforge-ai | DevForge AI | #devforge-document-workspace |

**Phase Gate 2**: >95% pass rate, 0 critical issues → DomainForge AI

---

## Phase 3 — Integration (>90% pass threshold, ≤1 critical allowed)

**After Phase Gate 2 passes:**
```
@agent work on DOCUMENT-007,DOCUMENT-008,DOCUMENT-009 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| DOCUMENT-007 | Logistics Document Integration (INT-005) | domainforge-ai | DomainForge AI | #domainforge-document-logistics-int |
| DOCUMENT-008 | Governance Form Integration (INT-006) | domainforge-ai | DomainForge AI | #domainforge-document-governance-int |
| DOCUMENT-009 | Document Numbering & Classification | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-document-numbering |

**Phase Gate 3**: >90% pass rate, ≤1 critical issue → DomainForge AI

---

## Phase 4 — Compliance (>85% pass threshold, ≤2 critical allowed)

**After Phase Gate 3 passes:**
```
@agent work on DOCUMENT-010,DOCUMENT-011,DOCUMENT-012 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| DOCUMENT-010 | Version Control & Revision History | devforge-ai | DevForge AI | #devforge-document-versioning |
| DOCUMENT-011 | Approval Routing & Workflow | domainforge-ai | DomainForge AI | #domainforge-document-approval |
| DOCUMENT-012 | Document Withdrawal & Supersession | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-document-withdrawal |

**Phase Gate 4**: >85% pass rate, ≤2 critical issues → DomainForge AI

---

## Phase 5 — Sign-off (Go/no-go)

**After Phase Gate 4 passes:**
```
@agent work on DOCUMENT-013,DOCUMENT-014,DOCUMENT-015 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| DOCUMENT-013 | Governance Form Conversion | domainforge-ai | DomainForge AI | #domainforge-document-conversion |
| DOCUMENT-014 | Cross-Discipline Document Sharing | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-document-sharing |
| DOCUMENT-015 | Audit Trail & Sign-off | validator-qualityforge + ALL | QualityForge AI + ALL | #devforge-document-signoff |

**Phase Gate 5**: Go/no-go recommendation → CEO

---

## Integration Chain Touchpoints

| Chain ID | Trigger Point | Data Flow | Status |
|----------|---------------|-----------|--------|
| INT-005 | After DOCUMENT-007 | 01700 Logistics → 00900 Document Control (Field Documents) | 🔴 Pending Wave 3 |
| INT-006 | After DOCUMENT-008 | 00900 Document Control → 01300 Governance (Document Approval) | 🔴 Pending Wave 3 |
| INT-008 | After DOCUMENT-001 | 00860 Electrical → 00900 Document Control (Design Docs) | 🔴 Pending Wave 3 |

---

## Related Documents

- `../disciplines/00900-document-control/projects/DOCUMENT-REGISTRY/`
- `../../orchestration/EXECUTION-TRACKER.md`
- `../../orchestration/INTEGRATION-REGISTRY.md`