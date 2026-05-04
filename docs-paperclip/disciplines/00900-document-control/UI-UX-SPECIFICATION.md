---
title: "00900 Document Control UI/UX Specification"
description: "Complete UI/UX specification for the 00900 Document Control discipline page — document lifecycle management with three-state navigation, document numbering, version control, approval routing, and governance form conversion"
author: "DomainForge AI — Document Control Domain"
date: "2026-05-03"
version: "1.0"
status: "active"
tags: document-control, ui-ux, specification, document-lifecycle, version-control, approval, governance
related_docs:
  - docs-paperclip/templates/mermaid/document-control-lifecycle.yaml
  - docs-paperclip/templates/mermaid/three-state-navigation.yaml
  - docs-paperclip/templates/mermaid/approval-matrix.yaml
  - orchestration/INTEGRATION-REGISTRY.md
---

# 00900 Document Control UI/UX Specification

## 1. Overview

The 00900 Document Control discipline page provides a comprehensive document lifecycle management system. It manages document creation, numbering, version control, approval routing, and governance form conversion. The system integrates with Logistics (01700) for field document capture and Governance (01300) for form-based approval pipelines.

### 1.1 Key Capabilities
- Document creation and numbering sub-process
- Version control with branching and revision history
- Approval routing with configurable gates
- Governance form conversion for approval pipelines
- Document search and retrieval
- Integration with field capture and governance systems

### 1.2 Integration Points
- **INT-005**: Receives from 01700 Logistics (Field → Document)
- **INT-006**: Sends to 01300 Governance (Document → Form)

## 2. User Roles & Permissions

| Role | Permissions | Description |
|------|------------|-------------|
| Document Controller | Full lifecycle management, numbering, approval routing | Document control operations |
| Document Author | Create/edit documents, submit for review | Content creation |
| Reviewer | Review documents, approve/reject, add comments | Review gates |
| Governance Officer | Convert documents to governance forms | Governance integration |
| Viewer | Read-only access | Audit and retrieval |

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
- Document summarization agent
- Content analysis agent
- Version comparison agent
- Compliance checking agent

#### Upsert State
- Document creation form
- Document upload form
- Revision submission form
- Governance form conversion form

#### Workspace State
- Document registry with filters (type, status, date, discipline)
- Document detail view with tabs (Content, Versions, Approvals, Governance)
- Approval queue
- Version history tree

### 3.2 Document Lifecycle

```mermaid
flowchart TD
    CREATE[Document Creation] --> NUMBER[Document Numbering]
    NUMBER --> DRAFT[Draft Version]
    DRAFT --> REVIEW[Peer Review]
    REVIEW --> APPROVE{Approval Routing}
    APPROVE -->|approved| APPROVED[Approved]
    APPROVE -->|rejected| DRAFT
    APPROVED --> PUBLISH[Publish]
    PUBLISH --> DISTRIBUTE[Distribute]
    DISTRIBUTE --> VERSION{Version Update?}
    VERSION -->|yes| REVISE[Revision]
    VERSION -->|no| ARCHIVE[Archive]
    REVISE --> DRAFT
    ARCHIVE --> FINAL[Final Archive]

    classDef create fill:#e3f2fd,stroke:#1976d2
    classDef draft fill:#f3e5f5,stroke:#7b1fa2
    classDef review fill:#fff3e0,stroke:#f57c00
    classDef publish fill:#e8f5e8,stroke:#388e3c
    classDef archive fill:#fce4ec,stroke:#c2185b

    class CREATE,NUMBER create
    class DRAFT,REVISE draft
    class REVIEW,APPROVE,APPROVED review
    class PUBLISH,DISTRIBUTE,VERSION publish
    class ARCHIVE,FINAL archive
```

### 3.3 Document Numbering Sub-Process

```mermaid
flowchart LR
    DISCIPLINE[Discipline Code] --> CATEGORY[Category Code]
    CATEGORY --> SEQUENCE[Sequence Number]
    SEQUENCE --> VERSION_NUM[Version Number]
    VERSION_NUM --> FORMAT[Format: DISC-CAT-SEQ-VER]
    FORMAT --> CHECK{Unique Check}
    CHECK -->|unique| ASSIGN[Assign Number]
    CHECK -->|duplicate| RESEQUENCE[Resequence]
    RESEQUENCE --> SEQUENCE
    ASSIGN --> REGISTER_DOC[Register Document]

    classDef code fill:#e3f2fd,stroke:#1976d2
    classDef format fill:#f3e5f5,stroke:#7b1fa2
    classDef check fill:#fff3e0,stroke:#f57c00
    classDef assign fill:#e8f5e8,stroke:#388e3c

    class DISCIPLINE,CATEGORY,SEQUENCE,VERSION_NUM code
    class FORMAT format
    class CHECK,RESEQUENCE check
    class ASSIGN,REGISTER_DOC assign
```

### 3.4 Version Control Branching

```mermaid
flowchart TD
    V1[Version 1.0] --> V2[Version 1.1]
    V2 --> V3[Version 1.2]
    V3 --> BRANCH{Branch?}
    BRANCH -->|minor| V4[Version 1.3]
    BRANCH -->|major| MAJOR[Version 2.0]
    BRANCH -->|parallel| PARALLEL[Parallel Branch]
    PARALLEL --> P1[Branch A]
    PARALLEL --> P2[Branch B]
    P1 --> MERGE{Merge?}
    P2 --> MERGE
    MERGE -->|merge| MERGED[Merged Version]
    MERGED --> V4
    V4 --> CURRENT[Current Version]
    MAJOR --> CURRENT

    classDef versions fill:#e3f2fd,stroke:#1976d2
    classDef branch fill:#fff3e0,stroke:#f57c00
    classDef parallel fill:#f3e5f5,stroke:#7b1fa2
    classDef current fill:#e8f5e8,stroke:#388e3c

    class V1,V2,V3,V4,MAJOR versions
    class BRANCH,MERGE,MERGED branch
    class PARALLEL,P1,P2 parallel
    class CURRENT current
```

### 3.5 Approval Routing

```mermaid
flowchart TD
    SUBMIT[Submit for Approval] --> ROUTE{Determine Route}
    ROUTE -->|Standard| STANDARD[Standard Route]
    ROUTE -->|Compliance| COMPLIANCE[Compliance Route]
    ROUTE -->|Governance| GOVERNANCE[Governance Route]
    STANDARD --> AUTHOR[Author Review]
    AUTHOR --> PEER[Peer Review]
    PEER --> MANAGER[Manager Approval]
    COMPLIANCE --> AUTHOR
    COMPLIANCE --> COMP_REVIEW[Compliance Review]
    COMP_REVIEW --> MANAGER
    GOVERNANCE --> AUTHOR
    GOVERNANCE --> GOV_REVIEW[Governance Review]
    GOV_REVIEW -->|convert| FORM_CONVERT[Form Conversion]
    FORM_CONVERT -->|send| GOVERNANCE_SYSTEM[01300 Governance]
    MANAGER -->|approve| PUBLISH_APPROVED[Publish]
    MANAGER -->|reject| REVISE_DOC[Revise]

    classDef submit fill:#e3f2fd,stroke:#1976d2
    classDef route fill:#fff3e0,stroke:#f57c00
    classDef review fill:#f3e5f5,stroke:#7b1fa2
    classDef approve fill:#e8f5e8,stroke:#388e3c
    classDef governance fill:#fce4ec,stroke:#c2185b

    class SUBMIT submit
    class ROUTE,STANDARD,COMPLIANCE,GOVERNANCE route
    class AUTHOR,PEER,COMP_REVIEW,GOV_REVIEW review
    class MANAGER,PUBLISH_APPROVED approve
    class FORM_CONVERT,GOVERNANCE_SYSTEM governance
    class REVISE_DOC review
```

### 3.6 Governance Form Conversion

```mermaid
flowchart LR
    DOC[Approved Document] --> EXTRACT[Extract Fields]
    EXTRACT --> MAP[Map to Form Template]
    MAP --> VALIDATE_FORM{Validate}
    VALIDATE_FORM -->|valid| CONVERT[Convert to Form]
    VALIDATE_FORM -->|invalid| FIX[Fix Mapping]
    FIX --> MAP
    CONVERT --> SUBMIT_FORM[Submit to Governance]
    SUBMIT_FORM -->|send| GOVERNANCE[01300 Governance Pipeline]

    classDef doc fill:#e3f2fd,stroke:#1976d2
    classDef process fill:#f3e5f5,stroke:#7b1fa2
    classDef validate fill:#fff3e0,stroke:#f57c00
    classDef submit fill:#e8f5e8,stroke:#388e3c

    class DOC doc
    class EXTRACT,MAP process
    class VALIDATE_FORM,FIX validate
    class CONVERT,SUBMIT_FORM,GOVERNANCE submit
```

## 4. State Management

### 4.1 Loading States
- **Document Registry**: Skeleton table with document type icons
- **Document Detail**: Progressive loading — metadata first, then content
- **Version History**: Tree view loading with version nodes

### 4.2 Empty States
- **No Documents**: "No documents in registry. Create or upload a document."
- **No Versions**: "Only one version exists. No revision history yet."
- **No Approvals Pending**: "No documents pending approval."

### 4.3 Error States
- **Document Load Failure**: "Unable to load document. File may be corrupted."
- **Version Conflict**: "Version conflict detected. Latest version has been updated."
- **Numbering Collision**: "Document number collision. Auto-resequencing."

### 4.4 Edge Cases
- **Concurrent Editing**: Lock mechanism with version conflict detection
- **Document Withdrawal**: Withdraw document from approval pipeline
- **Bulk Operations**: Batch document numbering and approval
- **Cross-Discipline Documents**: Documents shared across multiple disciplines

## 5. API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/documents` | List documents with filters |
| GET | `/api/v1/documents/:id` | Get document detail |
| POST | `/api/v1/documents` | Create document |
| PUT | `/api/v1/documents/:id` | Update document |
| DELETE | `/api/v1/documents/:id` | Delete document (draft only) |
| POST | `/api/v1/documents/:id/submit` | Submit for approval |
| POST | `/api/v1/documents/:id/approve` | Approve document |
| POST | `/api/v1/documents/:id/reject` | Reject document |
| GET | `/api/v1/documents/:id/versions` | List versions |
| POST | `/api/v1/documents/:id/versions` | Create new version |
| POST | `/api/v1/documents/:id/convert` | Convert to governance form |
| GET | `/api/v1/documents/:id/numbering` | Get document number |

## 6. Database Schema References

### Core Tables
- `a_00900_doccontrol_documents` — Document records
- `a_00900_doccontrol_document_versions` — Version history
- `a_00900_doccontrol_data` — Document metadata
- `a_00900_doccontrol_approvals` — Approval records
- `a_00900_doccontrol_numbering` — Numbering sequence registry

### Integration Tables
- `a_01700_logistics_transactions` — Source for field documents (INT-005)
- `a_01300_governance_forms` — Target for form conversion (INT-006)

## 7. Mobile & Responsive Considerations

- **Document List**: Card-based layout with document type badges
- **Document Viewing**: Native PDF viewer with annotation
- **Approval Actions**: Swipe-to-approve/reject on mobile
- **Document Upload**: Camera capture and file upload options
- **Offline Access**: Cache recently viewed documents

## 8. Integration Details

### INT-005: Logistics → Document Control
- **Trigger**: Field transaction completed in 01700
- **Data Flow**: Transaction record → Document generation → Numbering → Registry
- **Validation**: Transaction must be in "Completed" status
- **Error Handling**: Failed document creation queues for retry

### INT-006: Document Control → Governance
- **Trigger**: Document approved and ready for governance
- **Data Flow**: Document → Field extraction → Form mapping → Governance submission
- **Validation**: Document must be in "Approved" status
- **Error Handling**: Failed form conversion returns document to "Pending Conversion" status