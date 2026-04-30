---
title: 02400 Contractor Safety Management — Complete Metadata Bundle
description: Single JSON bundle of metadata for 02400 safety contractor management page components, ready for upload to QC-ROOT issue
author: KnowledgeForge AI
date: 2026-04-28
version: 1.0
---

# 02400 Contractor Safety Management — Complete Metadata Bundle

## Bundle Summary

| Metric | Value |
|--------|-------|
| Total desktop components | 6 (dashboard, navigation, API layer, analytics, forms, notifications) |
| Total mobile components | 5 (field capture, offline sync, push notifications, list/detail views, UX/accessibility) |
| Total components (all platforms) | 11 |
| Supabase tables referenced | 7 (safety_contractors, safety_requirements, safety_incidents, safety_inspections, safety_training, safety_alerts, vectors) |
| Companies involved | 4 (QualityForge AI, DomainForge AI, InfraForge AI, KnowledgeForge AI) |
| Agents assigned | 5 (guardian-qualityforge, infraforge-ai-integration-specialist, domainforge-ai-architectural-integration, safety-domainforge, knowledge-manager) |
| Extraction date | 2026-04-28 |
| Upload target | QC-ROOT-SAFETY-CONTRACTOR-2026 issue Documents |

## Full Bundle Structure

```json
{
  "project": "SAFETY-CONTRACTOR",
  "discipline": "02400-safety",
  "extraction_date": "2026-04-28",
  "total_components": 11,
  "platforms": ["desktop", "mobile"],
  "desktop_components": [
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "desktop",
      "component": "dashboard-kpi-panel",
      "template_score": 0.90,
      "vector_store": "supabase_vectors/02400/",
      "supabase_schema": null,
      "qc_checklist": [
        "Dashboard displays real-time KPIs for contractor safety management",
        "Core workflow engine processes contractor safety lifecycle events",
        "Navigation framework supports all planned modules",
        "Data grids support sorting, filtering, and pagination",
        "Dashboard responsive across 1280px+ resolutions"
      ],
      "issue_ref": "SAFETY-CONTRACTOR-001 (Desktop)",
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "desktop",
      "component": "navigation-framework",
      "template_score": 0.90,
      "vector_store": "supabase_vectors/02400/",
      "supabase_schema": null,
      "qc_checklist": [
        "Navigation menu displays all safety modules",
        "Active state highlights current module",
        "Nav persists across all sub-modules"
      ],
      "issue_ref": "SAFETY-CONTRACTOR-001 (Desktop)",
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "desktop",
      "component": "data-model-schema",
      "template_score": 0.88,
      "vector_store": "supabase_vectors/02400/",
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
      "issue_ref": "SAFETY-CONTRACTOR-002 (Desktop)",
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "desktop",
      "component": "analytics-dashboard",
      "template_score": 0.85,
      "vector_store": "supabase_vectors/02400/",
      "supabase_schema": null,
      "qc_checklist": [
        "Analytics dashboard renders contractor safety trend charts",
        "Reports exportable as PDF and CSV",
        "Compliance monitoring widgets show real-time status",
        "Date-range filtering applies across all analytics views",
        "Charts render correctly on standard desktop browsers"
      ],
      "issue_ref": "SAFETY-CONTRACTOR-003 (Desktop)",
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "desktop",
      "component": "record-form-system",
      "template_score": 0.88,
      "vector_store": "supabase_vectors/02400/",
      "supabase_schema": null,
      "qc_checklist": [
        "Create/edit forms for all contractor safety record types",
        "Form validation enforces required fields and business rules",
        "Approval workflow UI shows status transitions and history",
        "Search and filtering across all record fields",
        "Bulk operations for common management tasks",
        "Complete audit trail for all record changes"
      ],
      "issue_ref": "SAFETY-CONTRACTOR-004 (Desktop)",
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "desktop",
      "component": "integration-notification-system",
      "template_score": 0.85,
      "vector_store": "supabase_vectors/02400/",
      "supabase_schema": null,
      "qc_checklist": [
        "Integration endpoints connect to related safety project APIs",
        "Notification system delivers real-time alerts for safety events",
        "Email templates for key workflow state changes",
        "Notification center in dashboard with read/unread tracking",
        "User-configurable notification preferences"
      ],
      "issue_ref": "SAFETY-CONTRACTOR-005 (Desktop)",
      "last_updated": "2026-04-28"
    }
  ],
  "mobile_components": [
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "mobile",
      "component": "mobile-field-capture",
      "template_score": 0.85,
      "vector_store": "supabase_vectors/02400/",
      "supabase_schema": null,
      "qc_checklist": [
        "Mobile forms optimized for glove-friendly touch interaction",
        "Camera integration captures and attaches photos to records",
        "GPS location automatically captured and associated with field records",
        "Quick-action buttons for top 5 field tasks from home screen",
        "Forms functional on 5-inch+ screens in portrait and landscape"
      ],
      "issue_ref": "SAFETY-CONTRACTOR-001 (Mobile)",
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "mobile",
      "component": "mobile-offline-sync",
      "template_score": 0.82,
      "vector_store": "supabase_vectors/02400/",
      "supabase_schema": null,
      "qc_checklist": [
        "Full CRUD operations work without network connectivity",
        "Local data store persists across app restarts",
        "Sync engine resolves conflicts with server-wins and last-write-wins",
        "Visual indicators show sync status, pending items, and conflicts",
        "Automatic sync triggers when connectivity is restored",
        "No data loss during offline-to-online transitions"
      ],
      "issue_ref": "SAFETY-CONTRACTOR-002 (Mobile)",
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "mobile",
      "component": "mobile-push-notifications",
      "template_score": 0.85,
      "vector_store": "supabase_vectors/02400/",
      "supabase_schema": null,
      "qc_checklist": [
        "Push notifications delivered for key contractor safety events",
        "Notification tap navigates to relevant record or action",
        "In-app notification center shows history with read/unread status",
        "User-configurable notification preferences and quiet hours",
        "Notifications respect battery optimization on both iOS and Android"
      ],
      "issue_ref": "SAFETY-CONTRACTOR-003 (Mobile)",
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "mobile",
      "component": "mobile-list-detail-views",
      "template_score": 0.85,
      "vector_store": "supabase_vectors/02400/",
      "supabase_schema": null,
      "qc_checklist": [
        "List view displays contractor safety records with key summary info",
        "Search and filter bar accessible from list header",
        "Detail view shows comprehensive record info in tabbed layout",
        "Swipe gestures for quick actions work reliably",
        "Pull-to-refresh updates list from server",
        "Infinite scroll loads additional records without visible lag"
      ],
      "issue_ref": "SAFETY-CONTRACTOR-004 (Mobile)",
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "02400-safety-contractor",
      "discipline": "02400",
      "platform": "mobile",
      "component": "mobile-ux-accessibility",
      "template_score": 0.82,
      "vector_store": "supabase_vectors/02400/",
      "supabase_schema": null,
      "qc_checklist": [
        "High-contrast outdoor mode toggleable from app settings",
        "All interactive elements meet 48dp minimum touch target",
        "VoiceOver/TalkBack announces all labels and states correctly",
        "Haptic feedback confirms critical actions (submit, approve, flag)",
        "WCAG 2.1 Level AA compliance for contrast ratios",
        "App usable in direct sunlight on standard mobile displays"
      ],
      "issue_ref": "SAFETY-CONTRACTOR-005 (Mobile)",
      "last_updated": "2026-04-28"
    }
  ],
  "summary": {
    "total_components": 11,
    "desktop_components": 6,
    "mobile_components": 5,
    "issues_total": 10,
    "desktop_issues": 5,
    "mobile_issues": 5,
    "platforms": 2,
    "companies_involved": 4,
    "agents_assigned": 5,
    "supabase_tables": 7,
    "extraction_date": "2026-04-28",
    "ready_for_qc": true
  }
}
```

## Upload Instructions

To make this knowledge available to all sub-agents:

1. Upload this bundle to the **QC-ROOT-SAFETY-CONTRACTOR-2026** issue's Documents tab
2. Document key: `"full-page-metadata"`
3. All sub-agents inherit automatically via `parentId`
4. Agents query: `Documents.full-page-metadata.desktop_components` or `.mobile_components`

---

**Version**: 1.0
**Last Updated**: 2026-04-28
**Author**: KnowledgeForge AI