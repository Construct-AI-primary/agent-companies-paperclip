---
memory_layer: durable_knowledge
para_section: pages/documentation/paperclip-integration
gigabrain_tags: paperclip, hitl-approval, knowledge-enhancement, openclaw, domain-expert-review
openstinger_context: hitl-workflow-implementation
last_updated: 2026-04-04
related_docs:
  - /construct-ai-docs/codebase/other-apps/paperclip/integration/GOLD_STAR_ENTERPRISE_IMPLEMENTATION_PLAN.md
  - /construct-ai-docs/codebase/other-apps/paperclip/integration/PHASE_4_CROSS_TEAM_COLLABORATION.md
  - /construct-ai-docs/adapters/openclaw-gateway.md
---

# HITL Approval Workflows for Knowledge Enhancement

## Overview

This document defines the Human-In-The-Loop (HITL) approval workflows for knowledge enhancement in the Gold Star Enterprise. All domain knowledge enhancements must be approved by designated domain specialists before integration into the construct-ai knowledge base.

---

## HITL Architecture

### Workflow Flow
```
Task Request → OpenClaw Gateway → Research Agent → HITL Queue → Domain Expert Review → [Approved/Rejected] → Integration
```

### HITL Components
1. **OpenClaw Gateway**: Orchestrates research tasks and manages HITL queue
2. **Research Agent**: Explorer, Scholar, or Enhancer agent performs knowledge research
3. **HITL Queue**: Stores pending approval requests with context
4. **Domain Expert**: Human specialist reviews and approves/rejects findings
5. **Integration Process**: Incorporates approved knowledge into construct-ai

---

## Domain Expert Approval Matrices

### Civil Engineering (00850)
| Topic | Primary Expert | Backup Expert | Approval Criteria |
|-------|---------------|---------------|-------------------|
| Structural design | structural-engineer-lead | civil-engineer-senior | Code compliance, safety factors |
| Site assessment | geotechnical-engineer-lead | civil-engineer-senior | Accuracy, completeness |
| Environmental impact | environmental-engineer | civil-engineer-senior | Regulatory compliance |
| Construction methods | construction-manager | civil-engineer-senior | Practicality, safety |

### Commercial (00250)
| Topic | Primary Expert | Backup Expert | Approval Criteria |
|-------|---------------|---------------|-------------------|
| Cost estimation | commercial-manager-senior | quantity-surveyor-lead | Accuracy, market alignment |
| Contract terms | contracts-manager-lead | legal-advisor | Legal compliance, risk |
| Risk assessment | risk-manager | commercial-manager-senior | Completeness, mitigation |
| Market analysis | market-analyst | commercial-manager-senior | Data quality, relevance |

### Contracts (00400, 00425, 00435)
| Topic | Primary Expert | Backup Expert | Approval Criteria |
|-------|---------------|---------------|-------------------|
| Contract drafting | contracts-manager-lead | legal-advisor | Legal compliance, clarity |
| Claims management | claims-manager | contracts-manager-lead | Validity, documentation |
| Dispute resolution | dispute-resolution-lead | legal-advisor | Fairness, precedent |

### Electrical Engineering (00860)
| Topic | Primary Expert | Backup Expert | Approval Criteria |
|-------|---------------|---------------|-------------------|
| Power systems | electrical-engineer-lead | protection-engineer | Standards compliance |
| Protection design | protection-engineer | electrical-engineer-lead | Safety, reliability |

### Mechanical Engineering (00870)
| Topic | Primary Expert | Backup Expert | Approval Criteria |
|-------|---------------|---------------|-------------------|
| HVAC design | mechanical-engineer-lead | hvac-specialist | Efficiency, code compliance |
| Piping design | piping-engineer | mechanical-engineer-lead | Material suitability, code |

### Process Engineering (00871)
| Topic | Primary Expert | Backup Expert | Approval Criteria |
|-------|---------------|---------------|-------------------|
| Process design | process-engineer-lead | chemical-engineer | Safety, efficiency |
| HAZOP studies | hazop-lead | process-engineer-lead | Completeness, risk identification |

### IT (02050)
| Topic | Primary Expert | Backup Expert | Approval Criteria |
|-------|---------------|---------------|-------------------|
| AI/LLM integration | it-architect-lead | ml-engineer | Security, scalability |
| Data pipelines | data-engineer-lead | it-architect-lead | Performance, reliability |

### Safety (02400)
| Topic | Primary Expert | Backup Expert | Approval Criteria |
|-------|---------------|---------------|-------------------|
| Risk assessments | safety-manager-lead | hse-director | Completeness, compliance |
| Incident procedures | hse-director | safety-manager-lead | Regulatory compliance |

---

## HITL Workflow States

### State Machine
```
PENDING → [IN_REVIEW] → [APPROVED | REJECTED] → [INTEGRATED | RESUBMITTED]
```

| State | Description | Duration |
|-------|-------------|----------|
| PENDING | Awaiting expert assignment | <1 hour |
| IN_REVIEW | Under expert review | <48 hours |
| APPROVED | Expert approved | <1 hour |
| REJECTED | Expert rejected with comments | <1 hour |
| INTEGRATED | Incorporated into knowledge base | - |
| RESUBMITTED | Modified and resubmitted | <48 hours |

---

## Approval Request Format

### Request Structure
```json
{
  "requestId": "hitl-{timestamp}-{uuid}",
  "domain": "civil-engineering",
  "disciplineCode": "00850",
  "topic": "foundation-design-high-rise",
  "researchAgent": "explorer-promptforge-new-techniques",
  "researchResults": {
    "summary": "Research findings summary",
    "sources": ["source1", "source2"],
    "confidence": 0.85,
    "detailedFindings": "Full research content"
  },
  "requestedBy": "sage-promptforge-chief-architect",
  "requestedAt": "2026-04-04T05:30:00Z",
  "requiredExpert": "structural-engineer-lead",
  "approvalCriteria": {
    "codeCompliance": "required",
    "safetyFactors": "required",
    "peerReview": "recommended"
  },
  "timeoutHours": 48,
  "escalationPath": ["engineering-director", "ceo"]
}
```

### Response Format
```json
{
  "requestId": "hitl-{timestamp}-{uuid}",
  "action": "approved | rejected",
  "reviewedBy": "structural-engineer-lead",
  "reviewedAt": "2026-04-04T06:00:00Z",
  "comments": "Detailed review comments",
  "rejectionReason": "If rejected, reason with specifics",
  "suggestedModifications": "If rejected, suggested changes",
  "approvalConfidence": 0.9
}
```

---

## HITL Queue Management

### Queue Priorities
| Priority | Domain | SLA | Escalation |
|----------|--------|-----|------------|
| Critical | Safety, Legal | 4 hours | 8 hours → Director |
| High | Engineering, IT | 12 hours | 24 hours → Director |
| Medium | Commercial, Contracts | 24 hours | 48 hours → Director |
| Low | Administrative | 48 hours | 72 hours → Manager |

### Queue Operations
1. **Enqueue**: Add approval request with priority
2. **Assign**: Route to appropriate domain expert
3. **Review**: Expert reviews with full context
4. **Decide**: Approve, reject, or request modifications
5. **Notify**: Send result to requesting agent
6. **Integrate**: If approved, update knowledge base
7. **Resubmit**: If rejected, modify and re-enqueue

---

## Integration with OpenClaw

### OpenClaw HITL Configuration
```json
{
  "adapterType": "openclaw_gateway",
  "adapterConfig": {
    "gatewayUrl": "http://localhost:18789",
    "apiToken": "your-gateway-token",
    "hitlEnabled": true,
    "hitlConfig": {
      "queueUrl": "http://paperclip-api/hitl/queue",
      "approvalWebhook": "http://paperclip-api/hitl/approval",
      "defaultTimeoutHours": 48,
      "autoRejectOnTimeout": false,
      "expertRegistry": "http://paperclip-api/experts"
    }
  }
}
```

### Agent Routing with HITL

When an agent performs research that may result in knowledge enhancement:

1. **Detection**: Agent identifies knowledge gap
2. **Research**: Agent performs research via OpenClaw
3. **Validation**: Agent validates findings internally
4. **HITL Trigger**: If confidence < threshold, trigger HITL
5. **Queue**: Request enters HITL queue
6. **Expert Review**: Domain expert reviews
7. **Decision**: Expert approves or rejects
8. **Integration**: If approved, update construct-ai knowledge

---

## Error Handling

### HITL Errors
| Error | Response | Recovery |
|-------|----------|----------|
| Expert unavailable | Reassign to backup expert | <1 hour |
| Timeout expired | Escalate to next level | Per priority matrix |
| Rejection with modifications | Agent modifies and resubmits | <48 hours |
| System error | Retry with new request | <1 hour |

### Rejection Recovery
1. Agent receives rejection with comments
2. Agent addresses expert concerns
3. Agent resubmits with modifications
4. Original expert reviews resubmitted content
5. Auto-approve if all concerns addressed
6. Final escalation if still rejected

---

## Audit Trail

### HITL Log Format
```json
{
  "logId": "audit-{timestamp}-{uuid}",
  "requestId": "hitl-{timestamp}-{uuid}",
  "domain": "civil-engineering",
  "topic": "foundation-design",
  "researchAgent": "explorer-promptforge-new-techniques",
  "expert": "structural-engineer-lead",
  "action": "approved",
  "timestamp": "2026-04-04T06:00:00Z",
  "reviewDuration": "1.5h",
  "confidence": 0.9
}
```

### Retention
- HITL logs retained for 7 years
- Approval decisions permanent
- Rejection reasons permanent
- Modification suggestions retained for 5 years

---

## Monitoring and Metrics

### HITL Metrics
| Metric | Target | Measurement |
|--------|--------|-------------|
| Approval time (avg) | <12 hours | Queue timestamp to decision |
| First-pass approval rate | >80% | Approved on first submission |
| Timeout rate | <5% | Requests exceeding SLA |
| Escalation rate | <2% | Requests requiring escalation |
| Integration rate | >90% | Approved requests integrated |

### Dashboard Integration
- Real-time HITL queue status
- Expert workload distribution
- Approval time trends
- Rejection reason analytics
- Knowledge base update tracking

---

*HITL Approval Workflows - Ready for implementation*