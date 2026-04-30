---
title: 02400 Safety Contractor Management — Page & Component Knowledge
description: Complete page architecture, component inventory, and metadata for the 02400 safety contractor management discipline
author: QualityForge AI / KnowledgeForge AI
date: 2026-04-28
version: 1.0
memory_layer: working_knowledge
para_section: safety/projects/SAFETY-CONTRACTOR/knowledge
---

# 02400 Safety Contractor Management — Page & Component Knowledge

## Page Overview

- **Page ID**: `02400-safety-contractor`
- **Discipline Code**: `02400`
- **File Path**: `ui/src/pages/safety/safetycontractor/`
- **Platforms**: Desktop (command center) + Mobile (field operations)
- **Primary Agent**: `guardian-qualityforge`
- **Supporting Agents**: `domainforge-ai-architectural-integration`, `safety-domainforge`, `infraforge-ai-integration-specialist`

## Desktop Platform Components

### Core Dashboard & Workflow Engine (SAFETY-CONTRACTOR-001)

The desktop dashboard serves as the command center for contractor safety management operations. Safety managers need comprehensive visibility into workflow status, compliance metrics, and operational data.

```json
[
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "dashboard-kpi-panel",
    "template_score": 0.90,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": null,
    "qc_checklist": [
      "Dashboard displays real-time KPIs for contractor safety management",
      "Core workflow engine processes contractor safety lifecycle events",
      "Navigation framework supports all planned modules",
      "Data grids support sorting, filtering, and pagination",
      "Dashboard responsive across 1280px+ resolutions"
    ],
    "last_updated": "2026-04-28"
  },
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "navigation-framework",
    "template_score": 0.90,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": null,
    "qc_checklist": [
      "Navigation menu displays all safety modules",
      "Active state highlights current module",
      "Nav persists across all sub-modules"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Data Model & API Layer (SAFETY-CONTRACTOR-002)

The database schema and REST API layer supporting the full workflow lifecycle with company-scoped access patterns.

**Expected Supabase Tables**:

| Table | Purpose | Key Columns |
|-------|---------|-------------|
| `safety_contractors` | Contractor registry and prequalification | `id`, `company_id`, `name`, `qualification_status`, `expiry_date` |
| `safety_requirements` | Safety requirement communication | `id`, `contractor_id`, `requirement_type`, `acknowledged`, `agreement_date` |
| `safety_incidents` | Incident reporting tied to contractors | `id`, `contractor_id`, `severity`, `reported_by`, `resolution_status` |
| `safety_inspections` | Site inspection records | `id`, `contractor_id`, `inspector_id`, `score`, `pass_status` |
| `safety_training` | Training records and coordination | `id`, `contractor_id`, `training_type`, `completed_date`, `certificate_ref` |
| `safety_alerts` | Notification and escalation records | `id`, `contractor_id`, `alert_type`, `severity`, `acknowledged` |
| `vectors` | Vector embeddings for document search | `id`, `embedding`, `metadata`, `discipline` |

```json
[
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "data-model-schema",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": {
      "tables": ["safety_contractors", "safety_requirements", "safety_incidents", "safety_inspections", "safety_training", "safety_alerts"],
      "scoped_by": "company_id",
      "indexes": ["primary_key", "company_id_idx", "contractor_id_idx"]
    },
    "qc_checklist": [
      "Drizzle schema defines all contractor safety entities",
      "API endpoints follow /api/companies/:companyId/safety/ pattern",
      "Shared types in packages/shared with Zod validators",
      "Company-scoped access enforced on all endpoints",
      "Activity logging for all mutating operations"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Reporting & Analytics Module (SAFETY-CONTRACTOR-003)

Analytics dashboard with safety metrics, trend analysis, and exportable reports.

```json
[
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "analytics-dashboard",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": null,
    "qc_checklist": [
      "Analytics dashboard renders contractor safety trend charts",
      "Reports exportable as PDF and CSV",
      "Compliance monitoring widgets show real-time status",
      "Date-range filtering applies across all analytics views",
      "Charts render correctly on standard desktop browsers"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Record Management & Form System (SAFETY-CONTRACTOR-004)

Structured forms for creating, reviewing, and managing contractor safety management records.

```json
[
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "record-form-system",
    "template_score": 0.88,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": null,
    "qc_checklist": [
      "Create/edit forms for all contractor safety record types",
      "Form validation enforces required fields and business rules",
      "Approval workflow UI shows status transitions and history",
      "Search and filtering across all record fields",
      "Bulk operations for common management tasks",
      "Complete audit trail for all record changes"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### System Integration & Notifications (SAFETY-CONTRACTOR-005)

Cross-module integration with related safety projects and real-time alerts.

```json
[
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "integration-notification-system",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": null,
    "qc_checklist": [
      "Integration endpoints connect to related safety project APIs",
      "Notification system delivers real-time alerts for safety events",
      "Email templates for key workflow state changes",
      "Notification center in dashboard with read/unread tracking",
      "User-configurable notification preferences"
    ],
    "last_updated": "2026-04-28"
  }
]
```

## Mobile Platform Components

### Field Data Capture (SAFETY-CONTRACTOR-001)

Touch-optimized forms for field workers to capture contractor safety data from construction sites.

```json
[
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "mobile-field-capture",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": null,
    "qc_checklist": [
      "Mobile forms optimized for glove-friendly touch interaction",
      "Camera integration captures and attaches photos to records",
      "GPS location automatically captured and associated with field records",
      "Quick-action buttons for top 5 field tasks from home screen",
      "Forms functional on 5-inch+ screens in portrait and landscape"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Offline Synchronization (SAFETY-CONTRACTOR-002)

Offline data sync for construction sites with poor connectivity.

```json
[
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "mobile-offline-sync",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": null,
    "qc_checklist": [
      "Full CRUD operations work without network connectivity",
      "Local data store persists across app restarts",
      "Sync engine resolves conflicts with server-wins and last-write-wins",
      "Visual indicators show sync status, pending items, and conflicts",
      "Automatic sync triggers when connectivity is restored",
      "No data loss during offline-to-online transitions"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### Push Notifications & Alerts (SAFETY-CONTRACTOR-003)

Real-time alerts for contractor safety events, deadlines, and escalations.

```json
[
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "mobile-push-notifications",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": null,
    "qc_checklist": [
      "Push notifications delivered for key contractor safety events",
      "Notification tap navigates to relevant record or action",
      "In-app notification center shows history with read/unread status",
      "User-configurable notification preferences and quiet hours",
      "Notifications respect battery optimization on both iOS and Android"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### List & Detail Views (SAFETY-CONTRACTOR-004)

Searchable, filterable list and detail views optimized for one-handed mobile use.

```json
[
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "mobile-list-detail-views",
    "template_score": 0.85,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": null,
    "qc_checklist": [
      "List view displays contractor safety records with key summary info",
      "Search and filter bar accessible from list header",
      "Detail view shows comprehensive record info in tabbed layout",
      "Swipe gestures for quick actions work reliably",
      "Pull-to-refresh updates list from server",
      "Infinite scroll loads additional records without visible lag"
    ],
    "last_updated": "2026-04-28"
  }
]
```

### UX Polish & Accessibility (SAFETY-CONTRACTOR-005)

High-visibility, construction-site-optimized UX with accessibility compliance.

```json
[
  {
    "page_id": "02400-safety-contractor",
    "discipline": "02400",
    "component": "mobile-ux-accessibility",
    "template_score": 0.82,
    "vector_store": "supabase_vectors/02400/",
    "ui_buttons": null,
    "supabase_schema": null,
    "qc_checklist": [
      "High-contrast outdoor mode toggleable from app settings",
      "All interactive elements meet 48dp minimum touch target",
      "VoiceOver/TalkBack announces all labels and states correctly",
      "Haptic feedback confirms critical actions (submit, approve, flag)",
      "WCAG 2.1 Level AA compliance for contrast ratios",
      "App usable in direct sunlight on standard mobile displays"
    ],
    "last_updated": "2026-04-28"
  }
]
```

## Page-Level QC Checklist

### Desktop

- [ ] Dashboard KPI panel renders real-time safety metrics
- [ ] Navigation framework supports all safety modules
- [ ] Data grids support sorting, filtering, pagination
- [ ] Form validation enforces safety business rules
- [ ] Approval workflow UI shows status transitions
- [ ] Analytics charts render correctly (1280px+)
- [ ] Reports exportable as PDF and CSV
- [ ] Notifications deliver real-time safety alerts
- [ ] Integration endpoints connect to related safety projects
- [ ] CSS classes follow `02400-safety-*` prefix convention

### Mobile

- [ ] Touch-optimized forms (48dp minimum touch targets)
- [ ] Camera integration captures and attaches photos
- [ ] GPS location captured for field records
- [ ] Full CRUD works offline
- [ ] Sync engine handles conflict resolution
- [ ] Push notifications delivered for key events
- [ ] List/detail views optimized for one-handed use
- [ ] High-contrast outdoor mode toggleable
- [ ] WCAG 2.1 Level AA compliance
- [ ] Haptic feedback for critical confirmations

## Integration Points

| Integration | Module | Endpoint Pattern |
|-------------|--------|------------------|
| Safety Incidents | 02400-incidents | `/api/companies/:companyId/safety/incidents/` |
| Safety Inspections | 02400-inspections | `/api/companies/:companyId/safety/inspections/` |
| Safety Training | 02400-training | `/api/companies/:companyId/safety/training/` |
| Safety Alerts | 02400-alerts | `/api/companies/:companyId/safety/alerts/` |
| Vector Database | Shared | `/api/companies/:companyId/vectors/` |

## Related Safety Projects

| Project | Relationship | Dependency |
|---------|-------------|------------|
| SAFETY-INCIDENTS | Incident reporting | Consulted (cross-module data) |
| SAFETY-INSPECTIONS | Site inspections | Consulted (cross-module data) |
| SAFETY-TRAINING | Training coordination | Consulted (cross-module data) |
| SAFETY-ALERTS | Alert/notification system | Shared notification infrastructure |

---

**Version**: 1.0
**Last Updated**: 2026-04-28
**Author**: KnowledgeForge AI / QualityForge AI