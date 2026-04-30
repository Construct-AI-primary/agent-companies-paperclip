---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/ui-frontend
gigabrain_tags: procedures, ui-frontend, codebase
documentation
openstinger_context: operational-procedures, ui-frontend-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# UI Configuration Validation Interactive Interface Procedure

## Overview

This document specifies the implementation of an interactive UI Configuration Validation interface within the Agent Operations Center (http://localhost:3060/#/agent-operations-center). The interface mimics the existing chatbot pattern but is dedicated to UI configuration validation with a structured workflow.

## Current Architecture

### Existing Components:
1. **Agent Operations Center Page**: `client/src/pages/agent-operations-center/agent-operations-center-page.js`
2. **ChatbotBase**: `client/src/components/chatbots/base/ChatbotBase.js`
3. **Test Type Dropdown**: Already includes "🎯 UI Configuration Validation" option
4. **UI Configuration Validator Agent**: `deep-agents/deep_agents/agents/shared/it_specialists/a_0000_ui_configuration_validator_refactored.py`

---

## Output Hierarchy

The validation output MUST be grouped as:

```
DISCIPLINE (e.g., 01900 Procurement)
├── BUTTON #1 (e.g., Correspondence Reply)
│   ├── State: Agent / Upsert / Workspace
│   ├── Label & Emoji
│   ├── Modal ID & Modal Title
│   ├── Trigger Status (present/missing/invalid)
│   ├── File Path & Line Number
│   └──关联 → MODAL (if triggered)
│       ├── Modal File Path
│       ├── CSS File Path
│       ├── Purpose (Create/Update/View)
│       ├── Database Operations
│       ├── Form Fields
│       │   ├── Text Fields
│       │   ├── Select/Dropdown Fields ← Focus here
│       │   │   ├── Field Name
│       │   │   ├── Source (database table / hardcoded)
│       │   │   ├── Table Name
│       │   │   ├── Column Name
│       │   │   └── Status (bound/unbound)
│       │   ├── File Fields
│       │   └── Date Fields
│       └── Issues
├── BUTTON #2
│   └── ...
├── BUTTON #3
│   └── ...
└── THEME/CSS Analysis
```

---

## Step 2: Display Current State (Hierarchical by Discipline → Button → Modal → Dropdowns)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  🎯 UI CONFIGURATION VALIDATION - FULL REPORT                               │
├─────────────────────────────────────────────────────────────────────────────┤
│  REPORT DATE: 2026-02-13 12:00:00                                          │
│  SCOPE: All Disciplines (47)                                                │
│  TOTAL ISSUES: 23                                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  📊 DISCIPLINE: 01900 - PROCUREMENT                                        │
│  ═══════════════════════════════════════════════════════════════════════    │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ 🔘 BUTTON: Correspondence Reply                                     │    │
│  │ ─────────────────────────────────────────────────────────────────  │    │
│  │ STATE: Agent          INDEX: 3                                     │    │
│  │                                                                         │    │
│  │ Label:     ✉️ Correspondence Reply                                  │    │
│  │ Emoji:     ✉️                                                        │    │
│  │ Modal ID:  CorrespondenceReplyModal                                 │    │
│  │ Modal Title: Correspondence Reply                                   │    │
│  │ Trigger:   ⚠️ MISSING (data-modal-trigger)                        │    │
│  │                                                                         │    │
│  │ File:     client/src/pages/01900-procurement/components/           │    │
│  │            01900-procurement-page.js                                │    │
│  │ Line:     142                                                        │    │
│  │                                                                         │    │
│  │ →关联→ MODAL: CorrespondenceReplyModal                             │    │
│  │   ├─ File:     .../modals/01900-03-CorrespondenceReplyModal.js   │    │
│  │   ├─ CSS:      .../modals/css/01900-procurement-agent-modal.css  │    │
│  │   ├─ Purpose:  UPDATE (reply to correspondence)                   │    │
│  │   ├─ Database: correspondence table                               │    │
│  │   │                                                                     │    │
│  │   ├─ FORM FIELDS:                                                  │    │
│  │   │   ├─ subject (text, required)                                 │    │
│  │   │   ├─ reference_number (text, required)                        │    │
│  │   │   ├─ project_id (select, required)                            │    │
│  │   │   │   └─ SOURCE: projects table ✅ BOUND                     │    │
│  │   │   ├─ status (select, required)                                │    │
│  │   │   │   └─ SOURCE: HARDCODED ⚠️ UNBOUND                       │    │
│  │   │   ├─ response_text (textarea, required)                        │    │
│  │   │   ├─ attachment (file, optional)                             │    │
│  │   │   ├─ priority (select, optional)                             │    │
│  │   │   │   └─ SOURCE: priorities table ✅ BOUND                   │    │
│  │   │   └─ due_date (date, optional)                               │    │
│  │   │                                                                     │    │
│  │   └─ ISSUES: 1 (Hardcoded dropdown: status)                      │    │
│  │                                                                     │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ 🔘 BUTTON: Create Tender                                           │    │
│  │ ─────────────────────────────────────────────────────────────────  │    │
│  │ STATE: Agent          INDEX: 4                                     │    │
│  │                                                                         │    │
│  │ Label:     📝 Create Tender                                         │    │
│  │ Modal ID:  AddTenderModal                                           │    │
│  │ Trigger:   ✅ PRESENT (data-modal-trigger="AddTenderModal")         │    │
│  │                                                                         │    │
│  │ →关联→ MODAL: AddTenderModal                                      │    │
│  │   ├─ Purpose:  INSERT (new tender)                                │    │
│  │   ├─ Database: tenders table                                      │    │
│  │   │                                                                     │    │
│  │   ├─ FORM FIELDS:                                                  │    │
│  │   │   ├─ tender_name (text, required)                             │    │
│  │   │   ├─ project_id (select, required)                           │    │
│  │   │   │   └─ SOURCE: projects table ✅ BOUND                     │    │
│  │   │   ├─ closing_date (date, required)                           │    │
│  │   │   └─ budget (number, optional)                                │    │
│  │   │                                                                     │    │
│  │   └─ ISSUES: None ✅ VALID                                        │    │
│  │                                                                     │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ 🔘 BUTTON: Add Procurement Order                                   │    │
│  │ ─────────────────────────────────────────────────────────────────  │    │
│  │ STATE: Upsert         INDEX: 0                                     │    │
│  │                                                                         │    │
│  │ Label:     ➕ Add Procurement Order                                 │    │
│  │ Modal ID:  AddProcurementOrderModal                                │    │
│  │ Trigger:   ✅ PRESENT                                              │    │
│  │                                                                         │    │
│  │ →关联→ MODAL: AddProcurementOrderModal                           │    │
│  │   ├─ Purpose:  INSERT                                              │    │
│  │   ├─ Database: procurement_orders table                           │    │
│  │   │                                                                     │    │
│  │   ├─ FORM FIELDS:                                                  │    │
│  │   │   ├─ order_number (text, required)                           │    │
│  │   │   ├─ supplier_id (select, required)                          │    │
│  │   │   │   └─ SOURCE: suppliers table ✅ BOUND                   │    │
│  │   │   ├─ items (array, required)                                 │    │
│  │   │   └─ total_amount (number, required)                         │    │
│  │   │                                                                     │    │
│  │   └─ ISSUES: None ✅ VALID                                        │    │
│  │                                                                     │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│  📊 DISCIPLINE: 02025 - QUANTITY SURVEYING                                │
│  ═══════════════════════════════════════════════════════════════════════    │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │ 🔘 BUTTON: Cost Estimation                                        │    │
│  │ ─────────────────────────────────────────────────────────────────  │    │
│  │ STATE: Agent                                                       │    │
│  │ →关联→ MODAL: CostEstimationModal                                 │    │
│  │   ├─ Purpose:  READ (view calculations)                           │    │
│  │   └─ ISSUES: None ✅ VALID                                        │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  [EXPORT: 📄 TXT] [📃 PDF] [📋 JSON] [🌐 HTML]                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Sample Export (TXT Format)

```
================================================================================
                    UI CONFIGURATION VALIDATION REPORT
================================================================================

Report Date: 2026-02-13 12:00:00
Scope: 01900 - Procurement
Total Buttons: 11
Total Issues: 4

================================================================================
DISCIPLINE: 01900 - PROCUREMENT
================================================================================

--------------------------------------------------------------------------------
BUTTON: Correspondence Reply
--------------------------------------------------------------------------------
  State:           Agent
  Index:          3
  Label:          ✉️ Correspondence Reply
  Modal ID:       CorrespondenceReplyModal
  Trigger:        ⚠️ MISSING (data-modal-trigger)
  File:           client/src/pages/01900-procurement/components/01900-procurement-page.js
  Line:           142

  →关联→ MODAL: CorrespondenceReplyModal
      Purpose:    UPDATE (reply to correspondence)
      Database:   correspondence table

      FORM FIELDS:
      ├── subject (text, required)
      ├── reference_number (text, required)
      ├── project_id (select, required)
      │   └── SOURCE: projects table ✅ BOUND
      ├── status (select, required)
      │   └── SOURCE: HARDCODED ⚠️ UNBOUND ← ISSUE
      ├── response_text (textarea, required)
      ├── attachment (file, optional)
      ├── priority (select, optional)
      │   └── SOURCE: priorities table ✅ BOUND
      └── due_date (date, optional)

      ISSUES: 1
      └── Hardcoded dropdown: status field not bound to database

--------------------------------------------------------------------------------
BUTTON: Create Tender
--------------------------------------------------------------------------------
  State:          Agent
  Label:          📝 Create Tender
  Modal ID:       AddTenderModal
  Trigger:        ✅ PRESENT (data-modal-trigger="AddTenderModal")

  →关联→ MODAL: AddTenderModal
      Purpose:    INSERT (new tender)
      Database:   tenders table

      FORM FIELDS:
      ├── tender_name (text, required)
      ├── project_id (select, required)
      │   └── SOURCE: projects table ✅ BOUND
      ├── closing_date (date, required)
      └── budget (number, optional)

      ISSUES: None ✅ VALID

================================================================================
                              END OF REPORT
================================================================================
```

---

## Implementation - Building the Modal Component

### 1. Create: UIConfigurationValidationModal.js

Location: `client/src/components/modals/UIConfigurationValidationModal.js`
