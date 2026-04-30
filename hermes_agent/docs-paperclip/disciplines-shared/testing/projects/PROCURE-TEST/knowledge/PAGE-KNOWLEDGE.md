---
title: 01900 Procurement Page — Component Knowledge
description: Complete page architecture, component inventory, and 8-field metadata for the 01900 procurement discipline page
author: QualityForge AI / KnowledgeForge AI
date: 2026-04-28
version: 1.0
memory_layer: working_knowledge
para_section: testing/projects/PROCURE-TEST/knowledge
---

# 01900 Procurement Page — Component Knowledge

## Page Overview

- **Page ID**: `01900-procurement`
- **Discipline Code**: `01900`
- **File Path**: `client/src/pages/01900-procurement/components/01900-procurement-page.js`
- **Background Image**: `getThemedImagePath("01900.png")` — EPCM-standard cover
- **Chatbot**: `ProcurementChatbot` — orange theme (#FF8C00/#FFA500), HITL confidence=0.7
- **Nav Container**: `A-01900-navigation-container` — fixed bottom center
- **Button Container**: `A-01900-button-container` — fixed viewport center, CSS Grid
- **Logout**: Fixed bottom-left, `window.handleLogout()`

## 8-Field Metadata — All Components

### State Navigation Buttons

```json
[
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "state-button-agents",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "agents-button",
      "class": "state-button",
      "action": "setState('agents')",
      "target_state": "agents"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders with class 'state-button'",
      "Button label matches 'Agents'",
      "Click handler sets currentState to 'agents'",
      "Button container visibility toggles on click"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "state-button-upserts",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "upserts-button",
      "class": "state-button",
      "action": "setState('upserts')",
      "target_state": "upserts"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders with class 'state-button'",
      "Button label matches 'Upserts'",
      "Click handler sets currentState to 'upserts'"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "state-button-workspace",
    "template_score": 0.95,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "workspace-button",
      "class": "state-button",
      "action": "setState('workspace')",
      "target_state": "workspace"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders with class 'state-button'",
      "Button label matches 'Workspace'",
      "Click handler sets currentState to 'workspace'"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Agents State Modals (2 buttons)

```json
[
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-correspondence-reply",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "correspondence-reply-button",
      "class": "modal-trigger-button",
      "action": "openModal('01900-CorrespondenceReplyModal')",
      "target": "01900-CorrespondenceReplyModal"
    },
    "supabase_schema": {
      "table": "correspondence",
      "columns": ["id", "category", "message", "reply", "created_at", "updated_at"],
      "indexes": ["primary_key"]
    },
    "qc_checklist": [
      "Button renders in Agents state",
      "Modal opens: 01900-CorrespondenceReplyModal",
      "Category context is passed to modal",
      "Reply submission persists to correspondence table",
      "Modal closes properly"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-create-procurement-order",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "create-procurement-order-button",
      "class": "modal-trigger-button",
      "action": "openModal('01900-ProcurementInputAgentModal')",
      "target": "01900-ProcurementInputAgentModal"
    },
    "supabase_schema": {
      "table": "procurement_orders",
      "columns": ["id", "order_number", "supplier", "type", "amount", "status", "created_at"],
      "indexes": ["primary_key", "order_number_idx"]
    },
    "qc_checklist": [
      "Button renders in Agents state",
      "Modal opens: 01900-ProcurementInputAgentModal",
      "Order form fields match procurement_orders schema",
      "Order creation persists to database",
      "Multi-step flow works (wizard pattern)"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Upserts State Modals (3 buttons)

```json
[
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-cloud-upsert",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "cloud-upsert-button",
      "class": "modal-trigger-button",
      "action": "openModal('01900-UpsertCloudModal')",
      "target": "01900-UpsertCloudModal"
    },
    "supabase_schema": {
      "table": "vectors",
      "columns": ["id", "embedding", "metadata", "discipline"],
      "indexes": ["primary_key", "hnsw"]
    },
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 01900-UpsertCloudModal",
      "Data insertion to supabase_vectors succeeds",
      "Error handling for malformed data"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-upsert-from-url",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "upsert-url-button",
      "class": "modal-trigger-button",
      "action": "openModal('01900-UpsertUrlModal')",
      "target": "01900-UpsertUrlModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 01900-UpsertUrlModal",
      "URL fetch operation succeeds",
      "Data insertion succeeds after fetch"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-upsert-files",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "upsert-files-button",
      "class": "modal-trigger-button",
      "action": "openModal('01900-UpsertFileModal')",
      "target": "01900-UpsertFileModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Upserts state",
      "Modal opens: 01900-UpsertFileModal",
      "File upload and parse succeeds",
      "Parsed data inserted to database"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Workspace State Modals (7 buttons)

```json
[
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-timesheet",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "timesheet-button",
      "class": "modal-trigger-button",
      "action": "openModal('TimesheetModal')",
      "target": "TimesheetModal"
    },
    "supabase_schema": {
      "table": "timesheets",
      "columns": ["employee_id", "date", "hours", "project_id", "verified"],
      "indexes": ["primary_key"]
    },
    "qc_checklist": [
      "Button renders in Workspace state",
      "Timesheet modal opens",
      "Hours validation (<=24 per day)",
      "Employee ID exists validation",
      "Submission persists to timesheets table"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-access-permissions",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "access-permissions-button",
      "class": "modal-trigger-button",
      "action": "openModal('AccessPermissionVisualizerModal')",
      "target": "AccessPermissionVisualizerModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Workspace state",
      "AccessPermissionVisualizerModal opens",
      "Permission matrix renders correctly"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-contact-scraper",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "contact-scraper-button",
      "class": "modal-trigger-button",
      "action": "openModal('01900-ContactScraperModal')",
      "target": "01900-ContactScraperModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Workspace state",
      "01900-ContactScraperModal opens",
      "Contact extraction succeeds",
      "Extracted data saves correctly"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-cross-discipline-sharing",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "cross-discipline-sharing-button",
      "class": "modal-trigger-button",
      "action": "openModal('DisciplinePermissionMatrixModal')",
      "target": "DisciplinePermissionMatrixModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Workspace state",
      "DisciplinePermissionMatrixModal opens",
      "Permission matrix displays correctly"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-manage-workspaces",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "manage-workspaces-button",
      "class": "modal-trigger-button",
      "action": "openModal('WorkspaceManagementModal')",
      "target": "WorkspaceManagementModal"
    },
    "supabase_schema": null,
    "qc_checklist": [
      "Button renders in Workspace state",
      "WorkspaceManagementModal opens",
      "Workspace CRUD operations work"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-supplier-setup",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "supplier-setup-button",
      "class": "modal-trigger-button",
      "action": "openModal('01900-SupplierSetupModal')",
      "target": "01900-SupplierSetupModal"
    },
    "supabase_schema": {
      "table": "suppliers",
      "columns": ["id", "name", "type", "contact", "status", "rating"],
      "indexes": ["primary_key", "name_idx"]
    },
    "qc_checklist": [
      "Button renders in Workspace state",
      "01900-SupplierSetupModal opens",
      "Supplier CRUD operations persist",
      "Supplier card JSONs (STEELCO, CONCRETECO, ELECTRICO) render"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "01900-procurement",
    "discipline": "01900",
    "component": "modal-vector-data-manager",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/01900/",
    "ui_buttons": {
      "id": "vector-data-manager-button",
      "class": "modal-trigger-button",
      "action": "openModal('VectorDataManagerModal')",
      "target": "VectorDataManagerModal"
    },
    "supabase_schema": {
      "table": "vectors",
      "columns": ["id", "embedding", "metadata", "discipline"],
      "indexes": ["primary_key", "hnsw"]
    },
    "qc_checklist": [
      "Button renders in Workspace state",
      "VectorDataManagerModal opens",
      "Vector insert succeeds",
      "hnsw query returns results"
    ],
    "last_updated": "2026-04-28"
  }
]
```

## Page-Level QC Checklist

- [ ] 3 state buttons render (Agents, Upserts, Workspace)
- [ ] 12 modal trigger buttons render across all states
- [ ] Buttons sorted alphabetically via `sortButtonsAlphabetically()`
- [ ] Grid layout calculated via `calculateGridLayout()`
- [ ] Background image loads: `01900.png`
- [ ] Navigation container: fixed bottom center
- [ ] Button container: fixed viewport center, CSS Grid
- [ ] Animation: fade-in effect with `isButtonContainerVisible`
- [ ] Logout: fixed bottom-left, `window.handleLogout()` works
- [ ] Chatbot: orange theme, HITL confidence=0.7
- [ ] CSS classes: `procurement-page`, `page-background`, `A-01900-*` prefix
- [ ] Initial state: `null` (prevents flash on load)
- [ ] State values: `"agents"`, `"suppliers"`, `"vetting"` (per code, but page docs say "groups", "upserts", "workspace")
  - ⚠ **Potential discrepancy**: Verify actual state values against code

## Existing Testing Resources Consolidated

The following existing test documents from the 01900 discipline should be referenced during execution:

| Document | Focus | Used In |
|----------|-------|---------|
| `testing/1900_TESTING_GUIDE_PROCUREMENT_ORDER_MODAL.MD` | Order modal testing | PROCURE-003, PROCURE-008 |
| `testing/1900_TESTING_GUIDE_HANDOFF_SYSTEM.MD` | 01900→CDC→01700 handoff | PROCURE-011 |
| `testing/1900_LANGUAGE_TESTING_PLAN.MD` | i18n, WCAG, performance | PROCURE-012 |
| `testing/1900_PROCUREMENT_SYSTEM_TEST_REPORT.MD` | Previous test results (100% pass) | PROCURE-014 (baseline) |
| `testing/1900_PROCUREMENT_WORKFLOW_TROUBLESHOOTING.MD` | Workflow debugging | PROCURE-007 |
| `testing/1900_PROCUREMENT_READINESS_DASHBOARD.MD` | Dashboard structure | PROCURE-013a |
| `testing/1900_PROCUREMENT_SKILLS_VALIDATION_REPORT.MD` | Skills assessment | PROCURE-013 |

---

**Version**: 1.0
**Last Updated**: 2026-04-28
**Author**: KnowledgeForge AI / QualityForge AI