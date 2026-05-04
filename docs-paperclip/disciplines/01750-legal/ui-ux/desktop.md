---
title: "01750 Legal — Desktop UI/UX Specification"
description: "Desktop UI/UX specification for the 01750 Legal discipline page — legal management with contract lifecycle, claims dashboard, dispute resolution tracker, compliance monitor, and document manager"
author: "DomainForge AI — Legal Domain"
date: "2026-05-03"
version: "2.0"
status: "active"
platform: desktop
viewport: "1280px+"
tags: legal, ui-ux, desktop, specification, contracts, claims, compliance, governance
parent: "ui-ux/index.md"
related_docs:
  - docs-paperclip/templates/mermaid/legal-contract-lifecycle.yaml
  - docs-paperclip/templates/mermaid/claims-resolution.yaml
  - docs-paperclip/templates/mermaid/compliance-monitoring.yaml
  - orchestration/INTEGRATION-REGISTRY.md
  - docs-paperclip/companies/shared/i18n-translation-management/
---

# 01750 Legal — Desktop UI/UX Specification

> **Parent**: [`ui-ux/index.md`](index.md) — Master Index
> **Platform**: Desktop (1280px+)
> **Language Support**: 9 languages — see [Language Support](index.md#language-support) in master index

## 1. Overview

The 01750 Legal discipline page provides a comprehensive legal management interface. It enables legal professionals to manage contracts, track claims and disputes, monitor regulatory compliance, manage legal documents, and support corporate governance. The system integrates with Contracts (00400), Procurement (01900), Projects, and Governance disciplines.

### 1.1 Key Capabilities
- Contract lifecycle management (FIDIC, NEC, JCT frameworks)
- Claims and dispute resolution tracking (6-step process)
- Regulatory compliance monitoring (labour, environmental, H&S, anti-bribery, data protection)
- Legal document management and governance
- Legal risk assessment and reporting
- Corporate governance support

### 1.2 Integration Points
- **INT-LEGAL-001**: Receives from 00400 Contracts (Contract data → Legal review)
- **INT-LEGAL-002**: Sends to/from Claims (Claim notifications → Resolution tracking)
- **INT-LEGAL-003**: Receives from Compliance (Regulatory updates → Compliance monitoring)
- **INT-LEGAL-004**: Sends to Document Control (Legal documents → Document registry)

## 2. User Roles & Permissions

| Role | Permissions | Description |
|------|------------|-------------|
| Legal Director | Full access, approve legal strategy, manage disputes | Head of legal function |
| Legal Counsel | Create/manage contracts, handle claims, compliance review | Day-to-day legal management |
| Contract Manager | Contract creation, review, obligation tracking | Contract administration |
| Compliance Officer | Monitor compliance, raise alerts, track corrective actions | Regulatory compliance |
| Claims Manager | Claims intake, evaluation, negotiation, resolution | Claims and dispute management |
| Document Controller | Manage legal documents, version control, archiving | Document governance |
| Viewer | Read-only access to legal data | Audit and reporting |

## 3. Page Architecture

### 3.1 Three-State Navigation

The page follows the standard three-state navigation pattern:

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
- AI-powered contract drafting and review assistant
- Claims analysis and evaluation agent
- Compliance risk assessment agent
- Legal document summarization agent
- Regulatory change monitoring agent

#### Upsert State
- Contract creation form (FIDIC, NEC, JCT templates)
- Claims submission form
- Compliance report creation
- Legal document upload and indexing
- Governance record entry

#### Workspace State
- Contract management dashboard
- Claims and dispute resolution tracker
- Compliance monitoring dashboard
- Legal document manager
- Governance and reporting workspace

### 3.2 Layout Structure

```
┌──────────────────────────────────────────────────────────────┐
│  Header: [Logo] [01750 Legal] [Search] [Notifications] [Profile] │
├──────────────────────────────────────────────────────────────┤
│  [Agents]  [Upsert]  [Workspace]                             │
├──────────┬───────────────────────────────────────────────────┤
│          │                                                   │
│  Sidebar │  Main Content Area                                │
│  ─────── │                                                   │
│  Overview│  ┌─────────────────────────────────────────────┐  │
│  Contracts│  │  Module Tabs: [Contracts] [Claims]          │  │
│  Claims   │  │  [Compliance] [Documents] [Governance]     │  │
│  Compliance│  ├─────────────────────────────────────────────┤  │
│  Documents│  │                                               │  │
│  Governance│  │  Module-specific content                     │  │
│  Reports  │  │                                               │  │
│          │  └─────────────────────────────────────────────┘  │
│          │                                                   │
└──────────┴───────────────────────────────────────────────────┘
```

### 3.3 Components

#### LEGAL-ContractManager
- Contract list with filters (status, type, framework, value, date)
- Contract detail view with tabs (Overview, Clauses, Obligations, Variations, Payments, Documents, Timeline)
- Contract creation wizard with template selection (FIDIC Red/Yellow/Silver, NEC4 ECC/PSC/TSC, JCT D&B/SBC/MW)
- Clause library with standard and custom clauses
- Obligation tracking with automated reminders
- Approval routing with multi-level review gates
- Contract comparison and version diff viewer

#### LEGAL-ClaimsDashboard
- Claims overview with status breakdown (Notified, Documenting, Evaluating, Submitted, Negotiating, Resolved)
- Claim detail view with 6-step process tracker
- Claim timeline with key events and milestones
- Quantum and delay analysis tools
- Document attachment and evidence management
- Without-prejudice communication log
- Adjudication/arbitration case tracker

#### LEGAL-DisputeResolutionTracker
- Dispute case list with priority indicators (Dispute Amber)
- Case detail view with party information, dispute type, resolution method
- Step-by-step resolution workflow (Negotiation → Mediation → Adjudication → Arbitration → Litigation)
- Hearing and meeting schedule
- Settlement negotiation tracker
- Cost and fee tracking
- Outcome and lessons learned documentation

#### LEGAL-ComplianceMonitor
- Compliance dashboard with status by regulatory area (Labour, Environmental, H&S, Anti-Bribery, Data Protection)
- Compliance obligation register with mapping to regulations
- Compliance calendar with filing deadlines and review dates
- Automated compliance alerts and notifications
- Corrective action tracking and closure
- Compliance report generation (daily, weekly, monthly, quarterly)
- Regulatory change impact assessment

#### LEGAL-DocumentManager
- Document repository with folder structure (Contracts, Claims, Compliance, Governance, Correspondence)
- Document upload with metadata tagging (type, date, party, status, confidentiality)
- Version control with revision history and comparison
- Document search with full-text and metadata filters
- Document approval and review workflow
- Document retention and archiving policies
- Confidentiality and access control management

## 4. State Management

### 4.1 Loading States
- **Initial Load**: Skeleton loader with Legal Navy shimmer animation
- **Contract Detail**: Progressive loading — header first, then tabs
- **Claims Dashboard**: Loading cards for each claim status category
- **Compliance Monitor**: Loading indicators for each regulatory area
- **Document List**: Progressive loading with document count

### 4.2 Empty States
- **No Contracts**: "No contracts found. Create your first contract using a FIDIC, NEC, or JCT template."
- **No Claims**: "No active claims. All projects currently dispute-free."
- **No Compliance Alerts**: "All compliance checks passed. No regulatory issues detected."
- **No Documents**: "No documents in this folder. Upload legal documents to begin."
- **No Governance Records**: "No governance records found. Create board minutes or policy documents."

### 4.3 Error States
- **Contract Load Failure**: "Unable to load contract data. Retry or contact legal IT support."
- **Claim Submission Failure**: "Failed to submit claim. Your data has been preserved locally."
- **Compliance Check Failure**: "Compliance check failed. Review and address flagged items."
- **Document Upload Failure**: "Document upload failed. Check file size and format requirements."
- **Integration Failure**: "Unable to sync with external legal systems. Data may be stale."

### 4.4 Edge Cases
- **Concurrent Editing**: Lock mechanism prevents simultaneous edits on same contract/clause
- **Contract Amendment Chain**: Track amendment history with version tree and comparison
- **Multi-Jurisdiction Contracts**: Support for governing law and jurisdiction selection
- **Confidentiality Levels**: Document access control based on confidentiality classification
- **Statute of Limitations**: Automated alerts for approaching limitation periods
- **Cross-Border Compliance**: Multi-jurisdiction regulatory requirement mapping

## 5. API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/legal/contracts` | List contracts with filters |
| GET | `/api/v1/legal/contracts/:id` | Get contract detail |
| POST | `/api/v1/legal/contracts` | Create contract |
| PUT | `/api/v1/legal/contracts/:id` | Update contract |
| GET | `/api/v1/legal/contracts/:id/clauses` | List contract clauses |
| GET | `/api/v1/legal/claims` | List claims with filters |
| GET | `/api/v1/legal/claims/:id` | Get claim detail |
| POST | `/api/v1/legal/claims` | Submit claim |
| PUT | `/api/v1/legal/claims/:id` | Update claim |
| GET | `/api/v1/legal/compliance` | Get compliance status |
| GET | `/api/v1/legal/compliance/obligations` | List compliance obligations |
| POST | `/api/v1/legal/compliance/reports` | Generate compliance report |
| GET | `/api/v1/legal/documents` | List legal documents |
| POST | `/api/v1/legal/documents` | Upload document |
| GET | `/api/v1/legal/documents/:id` | Get document detail |
| GET | `/api/v1/legal/governance` | List governance records |
| POST | `/api/v1/legal/governance` | Create governance record |

## 6. Database Schema References

### Core Tables
- `a_01750_legal_contracts` — Legal contract records
- `a_01750_legal_contract_clauses` — Contract clause library
- `a_01750_legal_claims` — Claims and dispute records
- `a_01750_legal_claim_steps` — 6-step resolution process tracking
- `a_01750_legal_compliance` — Compliance monitoring records
- `a_01750_legal_compliance_obligations` — Compliance obligation register
- `a_01750_legal_documents` — Legal document registry
- `a_01750_legal_governance` — Corporate governance records
- `a_01750_legal_audit_log` — Legal audit trail

### Integration Tables
- `a_00400_contracts` — Source for contract data (INT-LEGAL-001)
- `a_01900_procurement_orders` — Source for procurement-related legal review

## 7. Integration Details

### INT-LEGAL-001: Contracts → Legal
- **Trigger**: Contract created or amended in 00400 Contracts
- **Data Flow**: Contract data → Legal review queue → Legal approval/rejection
- **Validation**: Contract must have completed commercial review
- **Error Handling**: Failed legal review returns contract to "Pending Legal Review" status

### INT-LEGAL-002: Legal Claims → External
- **Trigger**: Claim submitted or dispute escalated
- **Data Flow**: Claim details → Resolution tracking → Outcome recording
- **Validation**: Claim must have supporting documentation
- **Error Handling**: Failed submission preserves claim data in draft status

### INT-LEGAL-003: Compliance → Legal
- **Trigger**: Regulatory change or compliance event detected
- **Data Flow**: Compliance data → Legal review → Action plan
- **Validation**: Compliance event must be verified
- **Error Handling**: Unverified events flagged for manual review

### INT-LEGAL-004: Legal Documents → Document Control
- **Trigger**: Legal document finalized or approved
- **Data Flow**: Document metadata → Document registry → Archival
- **Validation**: Document must have required metadata and approvals
- **Error Handling**: Incomplete documents held in pending status

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.0 | 2026-05-03 | Initial desktop UI/UX specification for Legal discipline |
| 1.0 | 2026-05-03 | Initial UI/UX specification |

---

**Document Information**
- **Author**: DomainForge AI — Legal Domain
- **Date**: 2026-05-03
- **Status**: Active
