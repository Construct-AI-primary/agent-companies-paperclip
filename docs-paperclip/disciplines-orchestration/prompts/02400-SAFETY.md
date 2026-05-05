# SAFETY — Dispatch Prompts

**Project**: SAFETY-INCIDENTS
**Discipline**: 02400 — Safety
**Server**: SAFETY
**Issues**: 15 (SAFETY-001 through SAFETY-015)
**Phases**: 5
**Integration Chains**: INT-007, INT-010

---

## Phase 1 — Foundation (100% pass threshold, 0 critical allowed)

**Dispatch command (in #ai-work on SAFETY server):**
```
@agent work on SAFETY-001,SAFETY-002,SAFETY-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| SAFETY-001 | 02400 Page Foundation — Login, Navigation & Logout | domainforge-ai | DomainForge AI | #domainforge-safety-foundation |
| SAFETY-002 | 02400 Database & API Connectivity | infraforge-ai | InfraForge AI | #infraforge-safety-database |
| SAFETY-003 | 02400 Page Layout & Navigation | devforge-ai | DevForge AI | #devforge-safety-layout |

**Phase Gate 1**: 100% pass rate, 0 critical issues → DomainForge AI

---

## Phase 2 — Incident Management (>95% pass threshold, 0 critical allowed)

**After Phase Gate 1 passes:**
```
@agent work on SAFETY-004,SAFETY-005,SAFETY-006 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| SAFETY-004 | Agents State — Incident List & Detail | domainforge-ai | DomainForge AI | #domainforge-safety-agents |
| SAFETY-005 | Upsert State — Incident Reporting | devforge-ai | DevForge AI | #devforge-safety-upserts |
| SAFETY-006 | Workspace State — Investigation Tools | devforge-ai | DevForge AI | #devforge-safety-workspace |

**Phase Gate 2**: >95% pass rate, 0 critical issues → DomainForge AI

---

## Phase 3 — Workflow Integration (>90% pass threshold, ≤1 critical allowed)

**After Phase Gate 2 passes:**
```
@agent work on SAFETY-007,SAFETY-008,SAFETY-009 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| SAFETY-007 | Governance Policy Integration (INT-007) | domainforge-ai | DomainForge AI | #domainforge-safety-governance-int |
| SAFETY-008 | Incident Classification & Triage | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-safety-classification |
| SAFETY-009 | Corrective Actions & Tracking | devforge-ai | DevForge AI | #devforge-safety-corrective |

**Phase Gate 3**: >90% pass rate, ≤1 critical issue → DomainForge AI

---

## Phase 4 — Compliance (>85% pass threshold, ≤2 critical allowed)

**After Phase Gate 3 passes:**
```
@agent work on SAFETY-010,SAFETY-011,SAFETY-012 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| SAFETY-010 | Investigation Workflow & Root Cause | domainforge-ai | DomainForge AI | #domainforge-safety-investigation |
| SAFETY-011 | Safety Alerts & Broadcast | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-safety-alerts |
| SAFETY-012 | Training Records & Competency | devforge-ai | DevForge AI | #devforge-safety-training |

**Phase Gate 4**: >85% pass rate, ≤2 critical issues → DomainForge AI

---

## Phase 5 — Sign-off (Go/no-go)

**After Phase Gate 4 passes:**
```
@agent work on SAFETY-013,SAFETY-014,SAFETY-015 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| SAFETY-013 | Regulatory Reporting & Compliance | devforge-ai | DevForge AI | #devforge-safety-regulatory |
| SAFETY-014 | Trend Analysis & Dashboards | measureforge-ai | MeasureForge AI | #measureforge-safety-trends |
| SAFETY-015 | Audit Trail & Sign-off | validator-qualityforge + ALL | QualityForge AI + ALL | #devforge-safety-signoff |

**Phase Gate 5**: Go/no-go recommendation → CEO

---

## Integration Chain Touchpoints

| Chain ID | Trigger Point | Data Flow | Status |
|----------|---------------|-----------|--------|
| INT-007 | After SAFETY-007 | 01300 Governance → 02400 Safety (Policy → Safety Workflow) | 🔴 Pending Wave 3 |
| INT-010 | After SAFETY-001 | 02400 Safety → 01900 Procurement (Safety → Supplier) | 🔴 Pending Wave 3 |

---

## Related Documents

- `../disciplines/02400-safety/projects/SAFETY-INCIDENTS/`
- `../../orchestration/EXECUTION-TRACKER.md`
- `../../orchestration/INTEGRATION-REGISTRY.md`