# PREAWARD — Dispatch Prompts

**Project**: PREAWARD-BID
**Discipline**: 00425 — Contracts Pre-Award
**Server**: PROCUREMENT-BIDDING
**Issues**: 15 (PREAWARD-001 through PREAWARD-015)
**Phases**: 5
**Integration Chains**: INT-001, INT-002

---

## Phase 1 — Foundation (100% pass threshold, 0 critical allowed)

**Dispatch command (in #ai-work on PROCUREMENT-BIDDING server):**
```
@agent work on PREAWARD-001,PREAWARD-002,PREAWARD-003 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| PREAWARD-001 | 00425 Page Foundation — Login, Navigation & Logout | domainforge-ai | DomainForge AI | #domainforge-preaward-foundation |
| PREAWARD-002 | 00425 Database & API Connectivity | infraforge-ai | InfraForge AI | #infraforge-preaward-database |
| PREAWARD-003 | 00425 Page Layout & Navigation | devforge-ai | DevForge AI | #devforge-preaward-layout |

**Phase Gate 1**: 100% pass rate, 0 critical issues → DomainForge AI

---

## Phase 2 — Bid Solicitation (>95% pass threshold, 0 critical allowed)

**After Phase Gate 1 passes:**
```
@agent work on PREAWARD-004,PREAWARD-005,PREAWARD-006 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| PREAWARD-004 | Bid Solicitation & RFQ Management | domainforge-ai | DomainForge AI | #domainforge-preaward-bid |
| PREAWARD-005 | Bidder Qualification & Shortlisting | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-preaward-qualification |
| PREAWARD-006 | Bid Document Management | paperclipforge-ai | PaperclipForge AI | #paperclipforge-preaward-documents |

**Phase Gate 2**: >95% pass rate, 0 critical issues → DomainForge AI

---

## Phase 3 — Bid Evaluation (>90% pass threshold, ≤1 critical allowed)

**After Phase Gate 2 passes:**
```
@agent work on PREAWARD-007,PREAWARD-008,PREAWARD-009 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| PREAWARD-007 | Bid Evaluation & Scoring (INT-001) | domainforge-ai | DomainForge AI | #domainforge-preaward-evaluation |
| PREAWARD-008 | Technical & Commercial Assessment | measureforge-ai | MeasureForge AI | #measureforge-preaward-assessment |
| PREAWARD-009 | Clarification & Negotiation Workflow | devforge-ai | DevForge AI | #devforge-preaward-negotiation |

**Phase Gate 3**: >90% pass rate, ≤1 critical issue → DomainForge AI

---

## Phase 4 — Award Recommendation (>85% pass threshold, ≤2 critical allowed)

**After Phase Gate 3 passes:**
```
@agent work on PREAWARD-010,PREAWARD-011,PREAWARD-012 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| PREAWARD-010 | Award Recommendation & Approval | domainforge-ai | DomainForge AI | #domainforge-preaward-award |
| PREAWARD-011 | Contract Award Handoff (INT-002) | paperclipforge-ai | PaperclipForge AI | #paperclipforge-preaward-handoff |
| PREAWARD-012 | Unsuccessful Bidder Notification | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-preaward-notification |

**Phase Gate 4**: >85% pass rate, ≤2 critical issues → DomainForge AI

---

## Phase 5 — Sign-off (Go/no-go)

**After Phase Gate 4 passes:**
```
@agent work on PREAWARD-013,PREAWARD-014,PREAWARD-015 in #ai-work
```

| Issue | Title | Assignee | Agent | Channel |
|-------|-------|----------|-------|---------|
| PREAWARD-013 | Compliance & Audit Trail | devforge-ai | DevForge AI | #devforge-preaward-compliance |
| PREAWARD-014 | Lessons Learned & Process Improvement | knowledgeforge-ai | KnowledgeForge AI | #knowledgeforge-preaward-lessons |
| PREAWARD-015 | Production Readiness Sign-off | validator-qualityforge + ALL | QualityForge AI + ALL | #devforge-preaward-signoff |

**Phase Gate 5**: Go/no-go recommendation → CEO

---

## Integration Chain Touchpoints

| Chain ID | Trigger Point | Data Flow | Status |
|----------|---------------|-----------|--------|
| INT-001 | After PREAWARD-007 | 01900 Procurement → 00425 Pre-Award (Bid Solicitation) | 🔴 Pending Wave 2 |
| INT-002 | After PREAWARD-011 | 00425 Pre-Award → 00400 Contracts (Award Handoff) | 🔴 Pending Wave 2 |

---

## Related Documents

- `../disciplines/00425-contracts-pre-award/projects/PREAWARD-BID/`
- `../../orchestration/EXECUTION-TRACKER.md`
- `../../orchestration/INTEGRATION-REGISTRY.md`