# ELECTRICAL — Dispatch Prompts

**Project**: ELECTRICAL-INSPECTIONS
**Discipline**: 00860 — Electrical Engineering
**Server**: ELEC-TEST
**Issues**: 15 (ELECTRICAL-001 through ELECTRICAL-015)
**Phases**: 5
**Integration Chains**: INT-008

---

## Phase 1 — Foundation (100% pass threshold, 0 critical allowed)

**Dispatch command (in #ai-work on ELEC-TEST server):**
```
@agent work on ELECTRICAL-001,ELECTRICAL-002,ELECTRICAL-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| ELECTRICAL-001 | 00860 Page Foundation — Login, Navigation & Logout | domainforge-ai | DomainForge AI | #domainforge-electrical-foundation |
| ELECTRICAL-002 | 00860 Database & API Connectivity | infraforge-ai | InfraForge AI | #infraforge-electrical-database |
| ELECTRICAL-003 | 00860 Page Layout & Navigation | devforge-ai | DevForge AI | #devforge-electrical-layout |

**Phase Gate 1**: 100% pass rate, 0 critical issues → DomainForge AI

---

## Phase 2 — Design & Calculations (>95% pass threshold, 0 critical allowed)

**After Phase Gate 1 passes:**
```
@agent work on ELECTRICAL-004,ELECTRICAL-005,ELECTRICAL-006 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| ELECTRICAL-004 | Agents State — Inspection List & Detail | domainforge-ai | DomainForge AI | #domainforge-electrical-agents |
| ELECTRICAL-005 | Upsert State — Inspection Records | devforge-ai | DevForge AI | #devforge-electrical-upserts |
| ELECTRICAL-006 | Workspace State — Equipment Database | devforge-ai | DevForge AI | #devforge-electrical-workspace |

**Phase Gate 2**: >95% pass rate, 0 critical issues → DomainForge AI

---

## Phase 3 — Integration (>90% pass threshold, ≤1 critical allowed)

**After Phase Gate 2 passes:**
```
@agent work on ELECTRICAL-007,ELECTRICAL-008,ELECTRICAL-009 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| ELECTRICAL-007 | Cross-Discipline Integration (INT-008) | domainforge-ai | DomainForge AI | #domainforge-electrical-integration |
| ELECTRICAL-008 | Document Generation & Reporting | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-electrical-docs |
| ELECTRICAL-009 | Equipment Database & Tracking | devforge-ai | DevForge AI | #devforge-electrical-equipment |

**Phase Gate 3**: >90% pass rate, ≤1 critical issue → DomainForge AI

---

## Phase 4 — Compliance (>85% pass threshold, ≤2 critical allowed)

**After Phase Gate 3 passes:**
```
@agent work on ELECTRICAL-010,ELECTRICAL-011,ELECTRICAL-012 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| ELECTRICAL-010 | Inspection Workflow & Scheduling | domainforge-ai | DomainForge AI | #domainforge-electrical-workflow |
| ELECTRICAL-011 | Testing Results Management | measureforge-ai | MeasureForge AI | #measureforge-electrical-testing |
| ELECTRICAL-012 | Schedule Management & Tracking | devforge-ai | DevForge AI | #devforge-electrical-schedule |

**Phase Gate 4**: >85% pass rate, ≤2 critical issues → DomainForge AI

---

## Phase 5 — Sign-off (Go/no-go)

**After Phase Gate 4 passes:**
```
@agent work on ELECTRICAL-013,ELECTRICAL-014,ELECTRICAL-015 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| ELECTRICAL-013 | Compliance Reporting | devforge-ai | DevForge AI | #devforge-electrical-compliance |
| ELECTRICAL-014 | Non-Compliance Tracking | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-electrical-ncr |
| ELECTRICAL-015 | Audit Trail & Sign-off | validator-qualityforge + ALL | QualityForge AI + ALL | #devforge-electrical-signoff |

**Phase Gate 5**: Go/no-go recommendation → CEO

---

## Integration Chain Touchpoints

| Chain ID | Trigger Point | Data Flow | Status |
|----------|---------------|-----------|--------|
| INT-008 | After ELECTRICAL-007 | 00860 Electrical → 00900 Document Control (Design Docs) | 🔴 Pending Wave 3 |

---

## Related Documents

- `../disciplines/00860-electrical-engineering/projects/ELECTRICAL-INSPECTIONS/`
- `../../orchestration/EXECUTION-TRACKER.md`
- `../../orchestration/INTEGRATION-REGISTRY.md`