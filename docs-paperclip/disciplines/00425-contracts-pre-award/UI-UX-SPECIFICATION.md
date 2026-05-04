---
title: "00425 Contracts Pre-Award UI/UX Specification"
description: "Complete UI/UX specification for the 00425 Contracts Pre-Award discipline page — bid/tender management system with three-state navigation, tender creation, supplier pre-qualification, evaluation scoring, and award recommendation workflows"
author: "DomainForge AI — Contracts Pre-Award Domain"
date: "2026-05-03"
version: "1.0"
status: "active"
tags: contracts, pre-award, ui-ux, specification, tender-management, bid-evaluation, procurement
related_docs:
  - docs-paperclip/disciplines/00400-contracts/UI-UX-SPECIFICATION.md
  - docs-paperclip/templates/mermaid/bid-tender-pipeline.yaml
  - docs-paperclip/templates/mermaid/approval-matrix.yaml
  - orchestration/INTEGRATION-REGISTRY.md
---

# 00425 Contracts Pre-Award UI/UX Specification

## 1. Overview

The 00425 Contracts Pre-Award discipline page manages the complete pre-award lifecycle from procurement handoff through award recommendation. It enables users to create tender packages, manage supplier pre-qualification, conduct bid evaluations with scoring matrices, and generate award recommendations for contract creation.

### 1.1 Key Capabilities
- Tender package creation from procurement requirements (INT-001)
- Supplier pre-qualification and shortlisting
- Bid solicitation and submission management
- Evaluation criteria definition and scoring matrix
- Comparative analysis and award recommendation
- Integration with 00400 Contracts for contract generation (INT-002)

### 1.2 Integration Points
- **INT-001**: Receives from 01900 Procurement (Requirements → Tender)
- **INT-002**: Sends to 00400 Contracts (Award → Contract)

## 2. User Roles & Permissions

| Role | Permissions | Description |
|------|------------|-------------|
| Tender Admin | CRUD all tenders, manage evaluation panels, approve awards | Full pre-award lifecycle |
| Procurement Officer | Create tenders from procurement requirements, manage submissions | Day-to-day tender management |
| Evaluator | Score bids, submit evaluations, add comments | Bid evaluation panel member |
| Compliance Reviewer | Verify pre-qualification, check compliance requirements | Compliance gate |
| Viewer | Read-only access to tender data | Audit and reporting |

## 3. Page Architecture

### 3.1 Three-State Navigation

```
┌─────────────────────────────────────────────────┐
│  [Agents]  [Upsert]  [Workspace]                │
├─────────────────────────────────────────────────┤
│                                                   │
│  Content area based on selected state             │
│                                                   │
└─────────────────────────────────────────────────┘
```

#### Agents State
- AI-powered tender drafting assistant
- Bid evaluation summarization agent
- Supplier risk assessment agent
- Compliance checking agent

#### Upsert State
- Tender creation form (from procurement requirements or blank)
- Pre-qualification criteria form
- Evaluation criteria and scoring matrix form
- Award recommendation form

#### Workspace State
- Tender list with filters (status, type, value, deadline)
- Tender detail view with tabs (Overview, Submissions, Evaluation, Timeline)
- Evaluation dashboard with scoring overview
- Award recommendation workspace

### 3.2 Bid/Tender Pipeline Flow

```mermaid
flowchart TD
    PREQUAL[Pre-Qualification] -->|shortlist| SOLICIT[Bid Solicitation]
    SOLICIT -->|issue| CLARIFY[Clarification Period]
    CLARIFY -->|respond| SUBMIT[Bid Submission]
    SUBMIT -->|open| EVAL{Bid Evaluation}
    EVAL -->|criteria| SCORE[Scoring Matrix]
    SCORE -->|weighted| COMPARE[Comparative Analysis]
    COMPARE -->|rank| RECOMMEND[Award Recommendation]
    RECOMMEND -->|approve| APPROVE[Approval Routing]
    APPROVE -->|finalize| AWARD[Award Decision]
    AWARD -->|handoff| CONTRACT[Contract Creation - 00400]

    classDef prequal fill:#e3f2fd,stroke:#1976d2
    classDef solicit fill:#f3e5f5,stroke:#7b1fa2
    classDef eval fill:#fff3e0,stroke:#f57c00
    classDef award fill:#e8f5e8,stroke:#388e3c
    classDef handoff fill:#fce4ec,stroke:#c2185b

    class PREQUAL prequal
    class SOLICIT,CLARIFY,SUBMIT solicit
    class EVAL,SCORE,COMPARE eval
    class RECOMMEND,APPROVE,AWARD award
    class CONTRACT handoff
```

### 3.3 Pre-Qualification Workflow

```mermaid
flowchart LR
    CRITERIA[Define Criteria] --> PUBLISH[Publish RFQ]
    PUBLISH --> RESPOND[Supplier Responses]
    RESPOND --> REVIEW[Review Submissions]
    REVIEW --> CHECK{Compliance Check}
    CHECK -->|pass| SHORTLIST[Shortlist]
    CHECK -->|fail| REJECT[Reject]
    CHECK -->|clarify| CLARIFY_REQ[Request Clarification]
    CLARIFY_REQ -->|respond| REVIEW
    SHORTLIST --> APPROVED_LIST[Approved Bidders List]
    REJECT --> NOTIFY[Notify Rejected]

    classDef define fill:#e3f2fd,stroke:#1976d2
    classDef process fill:#f3e5f5,stroke:#7b1fa2
    classDef check fill:#fff3e0,stroke:#f57c00
    classDef result fill:#e8f5e8,stroke:#388e3c

    class CRITERIA,PUBLISH define
    class RESPOND,REVIEW,CLARIFY_REQ process
    class CHECK check
    class SHORTLIST,REJECT,APPROVED_LIST,NOTIFY result
```

### 3.4 Bid Evaluation & Scoring Matrix

```mermaid
flowchart TD
    CRITERIA[Define Evaluation Criteria] --> WEIGHT[Assign Weights]
    WEIGHT -->|Price 40%| PRICE[Price Score]
    WEIGHT -->|Technical 30%| TECH[Technical Score]
    WEIGHT -->|Experience 15%| EXP[Experience Score]
    WEIGHT -->|Compliance 10%| COMP[Compliance Score]
    WEIGHT -->|Innovation 5%| INNOV[Innovation Score]
    PRICE --> CALC[Weighted Score Calculation]
    TECH --> CALC
    EXP --> CALC
    COMP --> CALC
    INNOV --> CALC
    CALC --> RANK[Rank Bidders]
    RANK --> REVIEW_EVAL[Review Results]
    REVIEW_EVAL -->|approve| FINAL_SCORE[Final Scores]
    REVIEW_EVAL -->|recalibrate| WEIGHT

    classDef criteria fill:#e3f2fd,stroke:#1976d2
    classDef weight fill:#f3e5f5,stroke:#7b1fa2
    classDef score fill:#fff3e0,stroke:#f57c00
    classDef result fill:#e8f5e8,stroke:#388e3c

    class CRITERIA criteria
    class WEIGHT,PRICE,TECH,EXP,COMP,INNOV weight
    class CALC,RANK,REVIEW_EVAL score
    class FINAL_SCORE result
```

### 3.5 Award Recommendation Flow

```mermaid
flowchart TD
    FINAL[Final Evaluation Results] --> PREP[Prepare Recommendation]
    PREP --> JUSTIFY[Justification Document]
    JUSTIFY --> REVIEW_REC[Review Recommendation]
    REVIEW_REC -->|approve| ROUTE{Approval Route}
    REVIEW_REC -->|revise| PREP
    ROUTE -->|Value < $50K| MGR[Manager Approval]
    ROUTE -->|$50K - $500K| DIR[Director Approval]
    ROUTE -->|> $500K| EXEC[Executive Approval]
    MGR -->|approve| AWARD_REC[Award Recommendation Issued]
    DIR -->|approve| AWARD_REC
    EXEC -->|approve| AWARD_REC
    MGR -->|reject| REVISE[Return for Revision]
    DIR -->|reject| REVISE
    EXEC -->|reject| REVISE
    AWARD_REC -->|handoff| CONTRACT[00400 Contract Creation]

    classDef final fill:#e3f2fd,stroke:#1976d2
    classDef prep fill:#f3e5f5,stroke:#7b1fa2
    classDef route fill:#fff3e0,stroke:#f57c00
    classDef award fill:#e8f5e8,stroke:#388e3c
    classDef handoff fill:#fce4ec,stroke:#c2185b

    class FINAL final
    class PREP,JUSTIFY,REVIEW_REC,REVISE prep
    class ROUTE,MGR,DIR,EXEC route
    class AWARD_REC award
    class CONTRACT handoff
```

## 4. State Management

### 4.1 Loading States
- **Tender List**: Skeleton cards with tender status badges
- **Evaluation Dashboard**: Progressive loading of score components
- **Bid Submission**: Upload progress indicator

### 4.2 Empty States
- **No Tenders**: "No active tenders. Create a tender from procurement requirements."
- **No Submissions**: "No bids received yet. The submission deadline is [date]."
- **No Evaluations**: "Evaluation not started. Define criteria and assign evaluators."

### 4.3 Error States
- **Submission Upload Failure**: "Bid document upload failed. Retry or contact support."
- **Scoring Calculation Error**: "Score calculation error. Verify criteria weights sum to 100%."
- **Integration Failure**: "Unable to sync with Procurement system. Data may be stale."

### 4.4 Edge Cases
- **Late Submissions**: Configurable late submission policy (accept/reject with penalty)
- **Tied Scores**: Tie-breaking rules (price preference, local content, random selection)
- **Withdrawn Bids**: Bid withdrawal handling and notification
- **Amended Tenders**: Tender amendment process with re-notification

## 5. API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/tenders` | List tenders with filters |
| GET | `/api/v1/tenders/:id` | Get tender detail |
| POST | `/api/v1/tenders` | Create tender |
| PUT | `/api/v1/tenders/:id` | Update tender |
| POST | `/api/v1/tenders/:id/publish` | Publish tender |
| GET | `/api/v1/tenders/:id/submissions` | List submissions |
| POST | `/api/v1/tenders/:id/submissions` | Submit bid |
| GET | `/api/v1/tenders/:id/evaluations` | Get evaluations |
| POST | `/api/v1/tenders/:id/evaluations` | Submit evaluation score |
| GET | `/api/v1/tenders/:id/scoring` | Get scoring matrix |
| POST | `/api/v1/tenders/:id/award` | Issue award recommendation |
| GET | `/api/v1/pre-qualification` | List pre-qualifications |
| POST | `/api/v1/pre-qualification` | Submit pre-qualification |

## 6. Database Schema References

### Core Tables
- `a_00425_preaward_tenders` — Tender records
- `a_00425_preaward_submissions` — Bid submissions
- `a_00425_preaward_evaluations` — Evaluation scores
- `a_00425_preaward_scoring_matrix` — Scoring criteria and weights
- `a_00425_preaward_awards` — Award recommendations
- `a_00425_preaward_pre_qualifications` — Supplier pre-qualifications

### Integration Tables
- `a_01900_procurement_orders` — Source for tender requirements (INT-001)
- `a_00400_contracts` — Target for award handoff (INT-002)

## 7. Mobile & Responsive Considerations

- **Tender List**: Card-based layout with status indicators
- **Bid Submission**: Document upload with camera capture option
- **Evaluation**: Simplified scoring input for mobile reviewers
- **Notifications**: Deadline reminders, submission alerts, evaluation assignments

## 8. Integration Details

### INT-001: Procurement → Pre-Award
- **Trigger**: Procurement requirements finalized in 01900
- **Data Flow**: Requirements spec → Tender package → Solicitation documents
- **Validation**: Requirements must be in "Approved" status
- **Error Handling**: Failed tender creation returns requirements to "Pending Tender" status

### INT-002: Pre-Award → Contracts
- **Trigger**: Award recommendation approved
- **Data Flow**: Evaluation results → Selected bidder → Contract terms → Draft contract
- **Validation**: Award must have completed compliance check
- **Error Handling**: Failed contract creation returns award to "Pending Contract" status