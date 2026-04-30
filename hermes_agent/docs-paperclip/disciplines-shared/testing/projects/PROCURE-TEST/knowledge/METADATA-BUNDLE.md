---
title: 01900 Procurement — Complete Metadata Bundle
description: Single JSON bundle of all 8-field metadata for 01900 page components, ready for upload to QC-ROOT issue
author: KnowledgeForge AI
date: 2026-04-28
version: 1.0
---

# 01900 Procurement — Complete Metadata Bundle

## Bundle Summary

| Metric | Value |
|--------|-------|
| Total page components | 22 (3 state buttons + 12 modal triggers + 7 supporting) |
| Template pages scored | 15 (all state buttons & modal triggers) |
| Operational pages scored | 7 (chatbot, workflow orchestrator, templates, suppliers, tenders, integrations, agent delegation) |
| Supabase tables referenced | 6 (correspondence, procurement_orders, vectors, timesheets, suppliers, tenders) |
| Extraction date | 2026-04-28 |
| Upload target | QC-ROOT-PROCUREMENT-2026 issue Documents |

## Full Bundle Structure

```json
{
  "project": "PROCURE-TEST",
  "discipline": "01900-procurement",
  "extraction_date": "2026-04-28",
  "total_components": 22,
  "template_pages": [
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "state-button-agents",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/01900/",
      "ui_buttons": {"id": "agents-button", "class": "state-button", "action": "setState('agents')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Agents'"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "state-button-upserts",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/01900/",
      "ui_buttons": {"id": "upserts-button", "class": "state-button", "action": "setState('upserts')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Upserts'"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "state-button-workspace",
      "template_score": 0.95,
      "vector_store": "supabase_vectors/01900/",
      "ui_buttons": {"id": "workspace-button", "class": "state-button", "action": "setState('workspace')"},
      "supabase_schema": null,
      "qc_checklist": ["Button renders with class 'state-button'", "Label matches 'Workspace'"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-correspondence-reply",
      "template_score": 0.88,
      "supabase_schema": {"table": "correspondence", "columns": ["id","category","message","reply","created_at","updated_at"], "indexes": ["primary_key"]},
      "qc_checklist": ["Button renders in Agents state", "Modal opens: 01900-CorrespondenceReplyModal", "Category context passed", "Reply persists", "Modal closes"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-create-procurement-order",
      "template_score": 0.88,
      "supabase_schema": {"table": "procurement_orders", "columns": ["id","order_number","supplier","type","amount","status","created_at"], "indexes": ["primary_key","order_number_idx"]},
      "qc_checklist": ["Button renders in Agents state", "Modal opens: 01900-ProcurementInputAgentModal", "Order form fields match schema", "Order persists", "Multi-step flow works"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-cloud-upsert",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 01900-UpsertCloudModal", "Insert succeeds", "Error handling works"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-upsert-url",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 01900-UpsertUrlModal", "URL fetch succeeds", "Data insert succeeds"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-upsert-files",
      "template_score": 0.85,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Upserts state", "Modal opens: 01900-UpsertFileModal", "File upload/parse succeeds", "Data insert succeeds"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-timesheet",
      "template_score": 0.82,
      "supabase_schema": {"table": "timesheets", "columns": ["employee_id","date","hours","project_id","verified"], "indexes": ["primary_key"]},
      "qc_checklist": ["Button renders in Workspace state", "Modal opens: TimesheetModal", "Hours <= 24 validated", "Employee ID validated", "Persists"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-access-permissions",
      "template_score": 0.82,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "AccessPermissionVisualizerModal opens", "Permission matrix renders"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-contact-scraper",
      "template_score": 0.82,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "01900-ContactScraperModal opens", "Contact extraction succeeds", "Data saves"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-cross-discipline-sharing",
      "template_score": 0.82,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "DisciplinePermissionMatrixModal opens", "Matrix displays correctly"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-manage-workspaces",
      "template_score": 0.82,
      "supabase_schema": null,
      "qc_checklist": ["Button renders in Workspace state", "WorkspaceManagementModal opens", "CRUD works"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-supplier-setup",
      "template_score": 0.88,
      "supabase_schema": {"table": "suppliers", "columns": ["id","name","type","contact","status","rating"], "indexes": ["primary_key","name_idx"]},
      "qc_checklist": ["Button renders in Workspace state", "01900-SupplierSetupModal opens", "Supplier CRUD persists", "Card JSONs render"],
      "last_updated": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "discipline": "01900",
      "component": "modal-vector-data-manager",
      "template_score": 0.82,
      "supabase_schema": {"table": "vectors", "columns": ["id","embedding","metadata","discipline"], "indexes": ["primary_key","hnsw"]},
      "qc_checklist": ["Button renders in Workspace state", "VectorDataManagerModal opens", "Vector insert succeeds", "hnsw query returns results"],
      "last_updated": "2026-04-28"
    }
  ],
  "operational_pages": [
    {
      "page_id": "01900-procurement",
      "page_type": "chatbot",
      "discipline": "01900",
      "primary_metric": "HITL confidence threshold",
      "critical_buttons": [{"id": "chatbot-toggle", "action": "open_chatbot"}],
      "business_rules": ["Confidence threshold >= 0.7 triggers HITL", "Citations enabled", "Document count enabled", "History persists per session"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "page_type": "workflow-orchestrator",
      "discipline": "01900",
      "primary_metric": "End-to-end order completion",
      "business_rules": ["Approval chain must complete", "Order status transitions valid", "SOW workflow generates document"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "page_type": "templates",
      "discipline": "01900",
      "primary_metric": "Template population accuracy",
      "critical_buttons": [{"id": "generate-template", "action": "populate_template"}],
      "business_rules": ["Purchase order template populates correctly", "Service order template validates", "Work order template renders", "SOW has all 6 appendices", "Compliance rules applied"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "page_type": "suppliers",
      "discipline": "01900",
      "primary_metric": "Supplier count and status accuracy",
      "critical_buttons": [{"id": "supplier-setup", "action": "open_supplier_modal"}, {"id": "contact-scraper", "action": "scrape_contacts"}],
      "business_rules": ["Supplier CRUD operations persist", "Card JSONs (STEELCO, CONCRETECO, ELECTRICO) load", "Contact scraping extracts valid data"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "page_type": "tenders",
      "discipline": "01900",
      "primary_metric": "Search result accuracy",
      "critical_buttons": [{"id": "create-tender", "action": "create_tender"}, {"id": "search-tender", "action": "search_tenders"}],
      "business_rules": ["Tender creation persists", "Search returns results matching query", "Filters work correctly", "Documents load with tenders"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "page_type": "integrations",
      "discipline": "01900",
      "primary_metric": "Vector query response time",
      "business_rules": ["Vector insert → hnsw query returns correct results", "Cross-discipline sharing permissions enforced", "Document retrieval returns docs by discipline filter"],
      "last_tested": "2026-04-28"
    },
    {
      "page_id": "01900-procurement",
      "page_type": "agent-delegation",
      "discipline": "01900",
      "primary_metric": "Delegation success rate",
      "business_rules": ["CEO creates root goal", "Heartbeat assigns sub-tasks via assigneeAgentId + parentId", "Status propagates up the hierarchy", "Approval requests route correctly"],
      "last_tested": "2026-04-28"
    }
  ],
  "summary": {
    "total_components": 22,
    "template_pages": 15,
    "operational_pages": 7,
    "phases": 5,
    "issues": 15,
    "companies_involved": 4,
    "agents_assigned": 9,
    "supabase_tables": 6,
    "extraction_date": "2026-04-28",
    "ready_for_qc": true
  }
}
```

## Upload Instructions

To make this knowledge available to all sub-agents:

1. Upload this bundle to the **QC-ROOT-PROCUREMENT-2026** issue's Documents tab
2. Document key: `"full-page-metadata"`
3. All sub-agents inherit automatically via `parentId`
4. Agents query: `Documents.full-page-metadata.template_pages` or `.operational_pages`

---

**Version**: 1.0
**Last Updated**: 2026-04-28
**Author**: KnowledgeForge AI