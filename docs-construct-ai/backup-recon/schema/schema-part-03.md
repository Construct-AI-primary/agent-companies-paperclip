---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# 📊 Schema Part 3: Tables 287-429 (Q-Z alphabetically)

**Database schema documentation for Construct AI - Part 3 of 3.**

## 📋 Overview

This document contains detailed schema information for tables 287-429 (alphabetically ordered).

## 📊 Part Statistics

- **Tables in Part**: 143
- **Total Tables**: 445
- **Generated**: 2026-01-07T04:37:25.062Z

## 📖 Table Documentation

### 287. `performance_alerts`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 12

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| alert_type | string | text | ✗ | - |
| severity | string | text | ✗ | - |
| title | string | text | ✗ | - |
| description | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| is_active | boolean | boolean | ✗ | - |
| discipline_code | string | text | ✓ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| resolved_at | string | timestamp with time zone | ✓ | - |
| resolved_by | string | uuid | ✓ | - |

---

### 288. `performance_metrics`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| metric_type | string | text | ✗ | - |
| value | number | numeric | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| user_id | string | uuid | ✓ | - |
| discipline_code | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 289. `personnel_records`

**Scripts Using This Table:** 2

1. `debug-scope-of-work.js`
2. `test/debug/debug-scope-of-work.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 17

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | - |
| employee_id | string | character varying | ✓ | - |
| department | string | character varying | ✓ | - |
| position | string | character varying | ✓ | - |
| hire_date | string | date | ✓ | - |
| termination_date | string | date | ✓ | - |
| manager_id | string | uuid | ✓ | - |
| salary | number | numeric | ✓ | - |
| employment_type | string | character varying | ✓ | - |
| location | string | character varying | ✓ | - |
| phone | string | character varying | ✓ | - |
| emergency_contact_name | string | character varying | ✓ | - |
| emergency_contact_phone | string | character varying | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 290. `petty_cash`

**Description:** Petty cash reimbursement requests with approval workflow

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 21

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | text | ✗ | Unique identifier for petty cash request

Note:
This is a Primary Key.<pk/> |
| project_id | string | text | ✓ | Associated project identifier |
| user_id | string | uuid | ✓ | User who submitted the request

Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| date | string | date | ✗ | Date when the expense occurred |
| amount | number | numeric | ✗ | Amount in local currency (ZAR) |
| category | string | character varying | ✗ | Expense category for reporting |
| description | string | text | ✗ | Detailed description of the expense |
| receipt_url | string | text | ✓ | URL to uploaded receipt document |
| receipt_filename | string | character varying | ✓ | - |
| status | string | character varying | ✓ | Current approval status of the request |
| submitted_at | string | timestamp with time zone | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| rejected_at | string | timestamp with time zone | ✓ | - |
| approver_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| rejection_reason | string | text | ✓ | Reason provided when request is rejected |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| project_name | string | character varying | ✓ | - |
| user_name | string | character varying | ✓ | - |
| phase_id | string | uuid | ✓ | References project_phases table, defaults to FEED phase when not provided

Note:
This is a Foreign Key to `project_phases.id`.<fk table='project_phases' column='id'/> |
| organization_id | string | uuid | ✓ | - |

---

### 291. `ports`

**Description:** Reference table for ports and terminals

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 21

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| port_code | string | character varying | ✗ | - |
| port_name | string | character varying | ✗ | - |
| country_code | string | character varying | ✓ | - |
| country_name | string | character varying | ✓ | - |
| latitude | number | numeric | ✓ | - |
| longitude | number | numeric | ✓ | - |
| time_zone | string | character varying | ✓ | - |
| port_type | string | character varying | ✓ | - |
| facilities | array | text[] | ✓ | - |
| max_vessel_length | number | numeric | ✓ | - |
| max_vessel_beam | number | numeric | ✓ | - |
| max_draft | number | numeric | ✓ | - |
| working_hours | string | character varying | ✓ | - |
| customs_hours | string | character varying | ✓ | - |
| services | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 292. `processing_statistics`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 9

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| organization_name | string | text | ✓ | - |
| processing_type | string | text | ✓ | - |
| processing_status | string | text | ✓ | - |
| file_type | string | text | ✓ | - |
| total_count | integer | bigint | ✓ | - |
| avg_processing_time | number | numeric | ✓ | - |
| avg_extracted_fields | number | numeric | ✓ | - |
| earliest_entry | string | timestamp with time zone | ✓ | - |
| latest_entry | string | timestamp with time zone | ✓ | - |

---

### 293. `procurement_approvals`

**Scripts Using This Table:** 1

1. `server/scripts/create_procurement_sow_tables.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| procurement_order_id | string | uuid | ✗ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| approver_role | string | character varying | ✗ | - |
| user_id | string | uuid | ✓ | - |
| status | string | character varying | ✓ | - |
| approval_level | integer | integer | ✗ | - |
| comments | string | text | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 294. `procurement_categories`

**Description:** Hierarchical procurement categories system with i18n support (English/French)

**Scripts Using This Table:** 2

1. `populate_categories.js`
2. `server/src/services/procurementTemplateService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 14

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| level1_code | string | character varying | ✓ | Main category code (A-M) as defined in Excel |
| level1_name | string | character varying | ✓ | English name for main category |
| level1_name_fr | string | character varying | ✓ | French translation for main category |
| level2_code | string | character varying | ✓ | Subcategory code (e.g., A00, B01, C06) |
| level2_name | string | character varying | ✓ | English name for subcategory |
| level2_name_fr | string | character varying | ✓ | French translation for subcategory |
| level3_code | string | character varying | ✓ | Detailed category code (e.g., C0601 for Engine Oil) |
| level3_name | string | character varying | ✓ | English name for detailed category |
| level3_name_fr | string | character varying | ✓ | French translation for detailed category |
| is_active | boolean | boolean | ✓ | - |
| display_order | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 295. `procurement_contributions`

**Scripts Using This Table:** 3

1. `server/procurement-sow-api.js`
2. `server/scripts/create_procurement_sow_tables.js`
3. `server/services/document-assembler-service.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| procurement_order_id | string | uuid | ✗ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| appendix_key | string | character varying | ✗ | - |
| discipline_id | string | uuid | ✗ | Note:
This is a Foreign Key to `disciplines.id`.<fk table='disciplines' column='id'/> |
| user_id | string | uuid | ✗ | - |
| content | string | text | ✓ | - |
| status | string | character varying | ✓ | - |
| assigned_at | string | timestamp with time zone | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 296. `procurement_order_documents`

**Scripts Using This Table:** 4

1. `server/check_document_linking_table.js`
2. `server/create_document_linking_table.js`
3. `server/src/services/ProcurementDocumentService.js`
4. `server/src/services/langchainDocumentChatService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 16

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| procurement_order_id | string | uuid | ✗ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| document_id | string | uuid | ✗ | - |
| document_type | string | character varying | ✗ | - |
| reference_type | string | character varying | ✗ | - |
| project_phase | string | character varying | ✓ | - |
| procurement_category | string | character varying | ✓ | - |
| added_at | string | timestamp with time zone | ✓ | - |
| added_by | string | uuid | ✗ | Note:
This is a Foreign Key to `user_profiles.user_id`.<fk table='user_profiles' column='user_id'/> |
| notes | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |
| template_reference_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_templates.id`.<fk table='procurement_templates' column='id'/> |
| appendix_order | integer | integer | ✓ | - |
| generated_html | string | text | ✓ | - |
| version_number | integer | integer | ✓ | - |

---

### 297. `procurement_orders`

**Description:** Dedicated table for actual procurement orders (separate from reusable templates)

**Scripts Using This Table:** 46

1. `camelCase_snakeCase_fix.js`
2. `create_logistics_data_for_test_orders.js`
3. `docs/implementation/test-data/procurement/tables/populate-procurement-orders.js`
4. `docs/implementation/test-data/procurement/tables/test_procurement_data.js`
5. `insert_demo_procurement_order.js`
6. `insert_test_data.js`
7. `populate-commercial-invoices.js`
8. `populate_procurement_test_data.js`
9. `server/create_procurement_orders_migration.js`
10. `server/create_procurement_orders_simple.js`
11. `server/insert_mock_procurement_orders.js`
12. `server/migrate_procurement_orders.js`
13. `server/procurement-sow-api.js`
14. `server/scripts/apply_procurement_sow_integration_migration.js`
15. `server/scripts/create_procurement_sow_tables.js`
16. `server/services/document-assembler-service.js`
17. `server/services/order-template-derivation-service.js`
18. `server/src/controllers/approvalController.js`
19. `server/src/controllers/ganttController.js`
20. `server/src/controllers/procurementController.js`
21. `server/src/routes/logistics-routes.js`
22. `server/src/services/CivilEngineeringDocumentService.js`
23. `server/src/services/SOWGenerationService.js`
24. `server/src/services/TechnicalDisciplineService.js`
25. `server/src/services/TemplateVariationService.js`
26. `server/src/services/dataConsistencyChecker.js`
27. `server/src/services/hitl-assignment-service.js`
28. `server/src/services/realTimeSynchronizationEngine.js`
29. `server/src/services/templateVariationSequencingService.js`
30. `server/src/services/workflowOptimizationService.js`
31. `server/src/tests/phase1-api-endpoints.test.js`
32. `server/src/tests/phase1-database-schema.test.js`
33. `server/src/tests/phase1-technical-training.test.js`
34. `server/src/tests/phase1-template-variation.test.js`
35. `test_procurement_workflow.js`
36. `tests/e2e/complete-procurement-workflow.e2e.test.js`
37. `tests/integration/error-handling-recovery.test.js`
38. `tests/integration/multi-discipline-coordination.test.js`
39. `tests/integration/performance-baseline-establishment.test.js`
40. `tests/integration/procurement-workflow.integration.test.js`
41. `tests/phase3-advanced-testing.js`
42. `tests/unit/approval-workflow-validation.test.js`
43. `tests/unit/procurement-order-creation.test.js`
44. `tests/unit/sow-association-validation.test.js`
45. `tests/unit/task-generation-verification.test.js`
46. `tests/unit/user-assignment-logic.test.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 43

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| order_number | string | character varying | ✓ | Auto-generated unique order number (PO-2025-001, SO-2025-001, WO-2025-001) |
| order_type | string | character varying | ✗ | Type of procurement order: purchase_order, service_order, work_order |
| title | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| department | string | character varying | ✓ | - |
| priority | string | character varying | ✓ | - |
| estimated_value | number | numeric | ✓ | - |
| currency | string | character varying | ✓ | - |
| supplier_name | string | character varying | ✓ | - |
| supplier_contact | string | character varying | ✓ | - |
| project_id | string | uuid | ✓ | Reference to projects table for project context awareness

Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| project_phase | string | character varying | ✓ | Current project phase for document filtering and suggestions |
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_templates.id`.<fk table='procurement_templates' column='id'/> |
| linked_documents | unknown | jsonb | ✓ | JSON array of linked documents with metadata for document integration feature |
| approval_status | string | character varying | ✓ | - |
| delivery_date | string | date | ✓ | - |
| special_requirements | string | text | ✓ | - |
| created_by | string | uuid | ✗ | Note:
This is a Foreign Key to `user_profiles.user_id`.<fk table='user_profiles' column='user_id'/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| sow_id | string | uuid | ✓ | - |
| sow_template_id | string | uuid | ✓ | Reference to the SOW template used for this order

Note:
This is a Foreign Key to `templates.id`.<fk table='templates' column='id'/> |
| appendix_a_content | string | text | ✓ | - |
| appendix_b_content | string | text | ✓ | - |
| appendix_c_content | string | text | ✓ | - |
| appendix_d_content | string | text | ✓ | - |
| appendix_e_content | string | text | ✓ | - |
| appendix_f_content | string | text | ✓ | - |
| approval_cover_content | string | text | ✓ | - |
| main_order_content | string | text | ✓ | - |
| discipline_assignments | unknown | jsonb | ✓ | JSON mapping of disciplines to SOW appendices |
| contribution_status | unknown | jsonb | ✓ | - |
| approval_matrix | unknown | jsonb | ✓ | JSON object defining approval workflow matrix |
| approval_routing_type | string | character varying | ✓ | - |
| approval_config | unknown | jsonb | ✓ | JSON configuration for approval workflow settings |
| user_assignments | unknown | jsonb | ✓ | JSON mapping of users to specific appendix sections |
| task_sequence | unknown | jsonb | ✓ | - |
| template_variation | string | character varying | ✓ | - |
| sequence_override_id | string | uuid | ✓ | - |
| estimated_completion_time | string | interval | ✓ | - |
| sequence_execution_id | string | uuid | ✓ | - |

---

### 298. `procurement_signatures`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 18

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| contract_id | string | uuid | ✓ | - |
| signature_document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `signature_documents.id`.<fk table='signature_documents' column='id'/> |
| procurement_phase | string | character varying | ✗ | - |
| procurement_stage | string | character varying | ✗ | - |
| required_signatories | integer | integer | ✗ | - |
| collected_signatures | integer | integer | ✓ | - |
| deadline | string | timestamp with time zone | ✓ | - |
| status | string | character varying | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| expired_at | string | timestamp with time zone | ✓ | - |
| initiated_by | string | uuid | ✓ | - |
| business_case | string | text | ✓ | - |
| special_conditions | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| created_by | string | uuid | ✓ | - |

---

### 299. `procurement_templates`

**Scripts Using This Table:** 18

1. `add_rbac_columns.js`
2. `migrate_api_routes.js`
3. `migrate_procurement_service.js`
4. `migrate_remaining_services.js`
5. `server/create_mock_templates.js`
6. `server/create_procurement_orders_migration.js`
7. `server/migrate_procurement_orders.js`
8. `server/services/field-attribute-compliance-service.js`
9. `server/services/intelligent-template-selector.js`
10. `server/services/order-template-derivation-service.js`
11. `server/services/template-hierarchy-service.js`
12. `server/src/controllers/procurementController.js`
13. `server/src/routes/scope-prompts-routes.js`
14. `server/src/services/DocumentGenerator.js`
15. `server/src/tests/procurement-templates.test.js`
16. `server/test-table-creation.js`
17. `update_lubricants_category.js`
18. `verify_sow_template_integration.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 47

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| document_id | string | uuid | ✓ | - |
| organization_id | string | character varying | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| template_name | string | text | ✗ | - |
| template_description | string | text | ✓ | - |
| template_type | string | text | ✗ | - |
| template_category | string | text | ✓ | - |
| level1_code | string | text | ✓ | - |
| level2_code | string | text | ✓ | - |
| level3_code | string | text | ✓ | - |
| template_content | unknown | jsonb | ✓ | - |
| field_protection | unknown | jsonb | ✓ | - |
| protection_enabled | boolean | boolean | ✓ | - |
| is_latest | boolean | boolean | ✓ | - |
| version_number | integer | integer | ✓ | - |
| approval_status | string | text | ✓ | - |
| approved_by | string | uuid | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| related_documents | unknown | jsonb | ✓ | - |
| compliance_requirements | unknown | jsonb | ✓ | - |
| lifecycle_stage | string | text | ✓ | - |
| tags | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| access_level | string | character varying | ✓ | - |
| discipline | string | character varying | ✓ | - |
| allowed_roles | unknown | jsonb | ✓ | - |
| component_type | string | character varying | ✓ | - |
| mandatory | boolean | boolean | ✓ | - |
| approval_workflow | unknown | jsonb | ✓ | JSONB containing approval workflow configuration including required approvals, hierarchy, and notification settings |
| html_content | string | text | ✓ | Generated HTML content from template fields for document processing. Indexed using MD5 hash for performance. |
| document_type | string | text | ✓ | Document type copied from governance template (e.g., PO, Contract, SOW) |
| document_type_label | string | text | ✓ | Human-readable label for the document type |
| discipline_code | string | text | ✓ | Discipline code (e.g., 00850 for Civil Engineering) for discipline-aware template filtering |
| appendix_letter | string | character | ✓ | - |
| sow_integration_enabled | boolean | boolean | ✓ | - |
| organization_name | string | text | ✓ | - |
| discipline_name | string | text | ✓ | - |
| source_governance_template_id | string | uuid | ✓ | - |
| source_order_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| source_project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| populated_data | unknown | jsonb | ✓ | - |
| variable_fields | unknown | jsonb | ✓ | - |
| derivation_metadata | unknown | jsonb | ✓ | - |
| derivation_confidence | number | numeric | ✓ | - |

---

### 300. `procurement_templates_backup_20251121`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 41

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✓ | - |
| document_id | string | uuid | ✓ | - |
| organization_id | string | character varying | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| template_name | string | text | ✓ | - |
| template_description | string | text | ✓ | - |
| template_type | string | text | ✓ | - |
| template_category | string | text | ✓ | - |
| level1_code | string | text | ✓ | - |
| level2_code | string | text | ✓ | - |
| level3_code | string | text | ✓ | - |
| template_content | unknown | jsonb | ✓ | - |
| field_protection | unknown | jsonb | ✓ | - |
| protection_enabled | boolean | boolean | ✓ | - |
| is_latest | boolean | boolean | ✓ | - |
| version_number | integer | integer | ✓ | - |
| approval_status | string | text | ✓ | - |
| approved_by | string | uuid | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| related_documents | unknown | jsonb | ✓ | - |
| compliance_requirements | unknown | jsonb | ✓ | - |
| lifecycle_stage | string | text | ✓ | - |
| tags | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| access_level | string | character varying | ✓ | - |
| discipline | string | character varying | ✓ | - |
| allowed_roles | unknown | jsonb | ✓ | - |
| component_type | string | character varying | ✓ | - |
| mandatory | boolean | boolean | ✓ | - |
| approval_workflow | unknown | jsonb | ✓ | - |
| html_content | string | text | ✓ | - |
| document_type | string | text | ✓ | - |
| document_type_label | string | text | ✓ | - |
| discipline_code | string | text | ✓ | - |
| appendix_letter | string | character | ✓ | - |
| sow_integration_enabled | boolean | boolean | ✓ | - |
| organization_name | string | text | ✓ | - |
| discipline_name | string | text | ✓ | - |
| source_governance_template_id | string | uuid | ✓ | - |

---

### 301. `project_engineering_templates`

**Scripts Using This Table:** 1

1. `server/src/services/EngineeringTemplateService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 18

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | string | uuid | ✗ | Note:
This is a Foreign Key to `master_engineering_templates.id`.<fk table='master_engineering_templates' column='id'/> |
| project_id | string | uuid | ✗ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| custom_name | string | character varying | ✓ | - |
| custom_description | string | text | ✓ | - |
| custom_html_content | string | text | ✓ | - |
| custom_json_content | unknown | jsonb | ✓ | - |
| is_required | boolean | boolean | ✓ | - |
| required_by | string | date | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| completed_by | string | uuid | ✓ | - |
| project_approval_status | string | character varying | ✓ | - |
| project_approved_by | string | uuid | ✓ | - |
| project_approved_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✗ | - |
| company_id | string | uuid | ✗ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 302. `project_permissions`

**Description:** User-based project access control with phase-level permissions

**Scripts Using This Table:** 1

1. `server/src/routes/project-permissions-routes.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| project_id | string | uuid | ✗ | Project ID reference |
| user_id | string | character varying | ✗ | User ID (UUID as text) |
| has_access | boolean | boolean | ✗ | Whether user has project access |
| phases_access | unknown | jsonb | ✓ | Array of accessible phase IDs |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | text | ✓ | - |
| updated_by | string | text | ✓ | - |

---

### 303. `project_phase_assignments`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| phase_id | string | uuid | ✓ | Note:
This is a Foreign Key to `project_phases.id`.<fk table='project_phases' column='id'/> |
| custom_name | string | character varying | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| start_date | string | date | ✓ | - |
| end_date | string | date | ✓ | - |
| sort_order | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 304. `project_phases`

**Description:** Standard project phases used across all projects

**Scripts Using This Table:** 4

1. `check_project_phases.js`
2. `server/src/controllers/aiDocumentAnalysisController.js`
3. `server/src/routes/project-permissions-routes.js`
4. `server/src/routes/project-routes.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Unique identifier for the project phase

Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | Human-readable name of the project phase |
| description | string | text | ✓ | Detailed description of the project phase |
| phase_code | string | character varying | ✓ | Unique code for the project phase |
| sort_order | integer | integer | ✓ | Order in which phases should be displayed/executed |
| is_active | boolean | boolean | ✓ | Whether this phase is currently active/available for use |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 305. `project_procurement_templates`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 51

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| document_id | string | uuid | ✓ | - |
| organization_id | string | character varying | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| template_name | string | text | ✗ | - |
| template_description | string | text | ✓ | - |
| template_type | string | text | ✗ | - |
| template_category | string | text | ✓ | - |
| level1_code | string | text | ✓ | - |
| level2_code | string | text | ✓ | - |
| level3_code | string | text | ✓ | - |
| template_content | unknown | jsonb | ✓ | - |
| field_protection | unknown | jsonb | ✓ | - |
| protection_enabled | boolean | boolean | ✓ | - |
| is_latest | boolean | boolean | ✓ | - |
| version_number | integer | integer | ✓ | - |
| approval_status | string | text | ✓ | - |
| approved_by | string | uuid | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| related_documents | unknown | jsonb | ✓ | - |
| compliance_requirements | unknown | jsonb | ✓ | - |
| lifecycle_stage | string | text | ✓ | - |
| tags | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| access_level | string | character varying | ✓ | - |
| discipline | string | character varying | ✓ | - |
| allowed_roles | unknown | jsonb | ✓ | - |
| component_type | string | character varying | ✓ | - |
| mandatory | boolean | boolean | ✓ | - |
| project_id | string | uuid | ✗ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| prepared_by | string | uuid | ✓ | - |
| prepared_at | string | timestamp with time zone | ✓ | - |
| template_scope | string | text | ✓ | - |
| approval_workflow | unknown | jsonb | ✓ | - |
| html_content | string | text | ✓ | - |
| document_type | string | text | ✓ | - |
| document_type_label | string | text | ✓ | - |
| discipline_code | string | text | ✓ | - |
| appendix_letter | string | character | ✓ | - |
| sow_integration_enabled | boolean | boolean | ✓ | - |
| organization_name | string | text | ✓ | - |
| discipline_name | string | text | ✓ | - |
| source_governance_template_id | string | uuid | ✓ | - |
| source_order_id | string | uuid | ✓ | - |
| source_project_id | string | uuid | ✓ | - |
| populated_data | unknown | jsonb | ✓ | - |
| variable_fields | unknown | jsonb | ✓ | - |
| derivation_metadata | unknown | jsonb | ✓ | - |
| derivation_confidence | number | numeric | ✓ | - |

---

### 306. `project_template_preparation`

**Scripts Using This Table:** 1

1. `server/src/services/ProjectTemplatePreparationService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 9

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| project_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/>
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| prepared_at | string | timestamp with time zone | ✓ | - |
| prepared_by | string | uuid | ✓ | - |
| disciplines_prepared | array | text[] | ✓ | - |
| total_templates | integer | integer | ✓ | - |
| status | string | text | ✓ | - |
| agent_notifications_sent | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 307. `project_templates`

**Description:** Project-specific template copies with auto-populated data from SOW

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 30

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| project_id | string | uuid | ✗ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| master_template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `master_templates.id`.<fk table='master_templates' column='id'/> |
| template_name | string | character varying | ✗ | - |
| template_type | string | character varying | ✗ | - |
| category | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| content | unknown | jsonb | ✓ | - |
| populated_data | unknown | jsonb | ✓ | - |
| sow_reference | string | uuid | ✓ | Note:
This is a Foreign Key to `scope_of_work.id`.<fk table='scope_of_work' column='id'/> |
| auto_populated_at | string | timestamp with time zone | ✓ | - |
| reviewed_at | string | timestamp with time zone | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| executed_at | string | timestamp with time zone | ✓ | - |
| total_value | number | numeric | ✓ | - |
| currency | string | character varying | ✓ | - |
| vendor_id | string | uuid | ✓ | - |
| contract_number | string | character varying | ✓ | - |
| notes | string | text | ✓ | - |
| priority | string | character varying | ✓ | - |
| requires_technical_review | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| form_template_id | string | uuid | ✓ | - |
| customized_content | unknown | jsonb | ✓ | - |
| deployment_rules | unknown | jsonb | ✓ | - |
| deployed_to_doc_control | boolean | boolean | ✓ | - |
| deployed_at | string | timestamp without time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |

---

### 308. `projects`

**Description:** Projects belonging to companies

**Scripts Using This Table:** 15

1. `debug-scope-of-work.js`
2. `debug_project_fallback.js`
3. `insert-sample-timesheet-data.js`
4. `server/api/process/index.js`
5. `server/create_dcs_tables.js`
6. `server/src/controllers/aiDocumentAnalysisController.js`
7. `server/src/controllers/procurementController.js`
8. `server/src/routes/project-permissions-routes.js`
9. `server/src/routes/project-routes.js`
10. `server/src/services/ProjectTemplatePreparationService.js`
11. `test/debug/debug-scope-of-work.js`
12. `test/debug/debug_project_fallback.js`
13. `test/debug/integration/test-mock-data-fix.js`
14. `test/debug/integration/test-mock-data-insertion.js`
15. `test/debug/integration/test-timesheet-descriptions.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 16

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| company_id | integer | integer | ✓ | - |
| name | string | character varying | ✗ | - |
| project_type | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| project_number | string | text | ✓ | - |
| project_description | string | text | ✓ | - |
| site_location | string | text | ✓ | - |
| delivery_date | string | date | ✓ | - |
| completion_date | string | date | ✓ | - |
| cost_center | string | text | ✓ | - |
| budget_code | string | text | ✓ | - |
| workflow_status | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 309. `prompt_usage_audit`

**Description:** Detailed audit trail of prompt usage by scripts and services for analytics and debugging

**Scripts Using This Table:** 1

1. `check_prompt_usage_and_compatibility.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| prompt_id | string | uuid | ✗ | Note:
This is a Foreign Key to `prompts.id`.<fk table='prompts' column='id'/> |
| script_name | string | text | ✗ | - |
| operation_type | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| response_time_ms | integer | integer | ✓ | - |
| success | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 310. `prompt_usage_summary`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 9

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| prompt_name | string | text | ✓ | - |
| prompt_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| is_active | boolean | boolean | ✓ | - |
| total_calls | integer | bigint | ✓ | - |
| successful_calls | integer | bigint | ✓ | - |
| avg_response_time_ms | number | numeric | ✓ | - |
| last_used | string | timestamp with time zone | ✓ | - |
| unique_scripts | integer | bigint | ✓ | - |
| scripts_using | string | text | ✓ | - |

---

### 311. `prompts`

**Description:** Stores AI prompts and templates used throughout the system for various AI-powered features

**Scripts Using This Table:** 44

1. `add_missing_prompts_route.js`
2. `add_prompts_columns.js`
3. `check_drawing_analysis_prompts.js`
4. `check_prompt_usage_and_compatibility.js`
5. `scripts/check-agent-prompts.js`
6. `scripts/check-discipline-prompts.js`
7. `scripts/create-quantity-surveying-prompts.js`
8. `scripts/enhance-discipline-detector.js`
9. `scripts/fix-core-agent-multi-category.js`
10. `scripts/fix-metadata-parsing-v2.js`
11. `scripts/fix-metadata-parsing.js`
12. `scripts/implement-true-multi-category.js`
13. `scripts/insert-all-discipline-prompts.js`
14. `scripts/insert-discipline-prompts-clean.js`
15. `scripts/insert-discipline-prompts-fixed.js`
16. `scripts/insert-discipline-prompts.js`
17. `scripts/insert-missing-agent-prompts.js`
18. `scripts/make-multi-category-by-updating-category-field.js`
19. `scripts/populate-agent-prompts-in-prompts-management.js`
20. `scripts/sync-md-prompts-to-database.js`
21. `scripts/test-agent-workflow.js`
22. `scripts/test-discipline-detector-accuracy.js`
23. `scripts/test-hitl-modal-integration.js`
24. `scripts/test-parallel-specialist-integration.js`
25. `scripts/update-agent-prompt-tags.js`
26. `server/scripts/create_document_structure_extraction_prompt.js`
27. `server/scripts/create_procurement_workflow_prompts.js`
28. `server/scripts/import-sample-prompts.js`
29. `server/scripts/insert_specialized_procurement_prompts.js`
30. `server/services/langchainDocumentChatService.js`
31. `server/src/controllers/drawingAnalysisController.js`
32. `server/src/controllers/promptsController.js`
33. `server/src/services/claudeVisionService.js`
34. `server/src/services/document-processing/DocumentStructureExtractionService.js`
35. `server/src/services/drawingAnalysisAIService.js`
36. `server/update_prompts_direct.js`
37. `setup-error-templates.js`
38. `setup-error-tracker-templates.js`
39. `test/debug/integration/test_prompt_check.js`
40. `test/debug/scripts/test_document_structure.js`
41. `test/debug/scripts/test_extraction_flow.js`
42. `test/debug/scripts/test_openai_access.js`
43. `test/debug/scripts/test_procurement_document_extraction.js`
44. `update_architectural_prompts.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 31

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Unique identifier for the prompt

Note:
This is a Primary Key.<pk/> |
| name | string | text | ✗ | Human-readable name for the prompt |
| content | string | text | ✗ | The actual prompt text/template |
| description | string | text | ✓ | Brief description of the prompt purpose |
| organization_id | string | uuid | ✓ | Associated organization (optional) |
| sector_id | string | uuid | ✓ | Associated sector (optional) |
| type | string | text | ✓ | Type of prompt (coding, analysis, chat, etc.) |
| category | string | text | ✓ | Category of prompt (development, legal, etc.) |
| tags | array | text[] | ✓ | Array of tags for categorization and search |
| is_active | boolean | boolean | ✓ | Whether the prompt is currently active/available |
| metadata | unknown | jsonb | ✓ | Additional metadata stored as JSON |
| created_at | string | timestamp with time zone | ✓ | Timestamp when prompt was created |
| updated_at | string | timestamp with time zone | ✓ | Timestamp when prompt was last updated |
| key | string | text | ✓ | - |
| role_type | string | text | ✓ | Type of prompt: system (dev-only) or user (accessible to end users) |
| access_permissions | unknown | jsonb | ✓ | JSON object defining granular access permissions for different user roles |
| created_by | string | text | ✓ | User ID of the prompt creator (for ownership tracking) |
| cross_reference_id | string | uuid | ✓ | - |
| pages_used | array | text[] | ✓ | - |
| date_added | string | timestamp with time zone | ✓ | - |
| date_modified | string | timestamp with time zone | ✓ | - |
| script_usage | unknown | jsonb | ✓ | JSONB tracking which scripts/services use this prompt with usage statistics |
| usage_statistics | unknown | jsonb | ✓ | Aggregated metrics including total usage, success rates, and performance data |
| workflow_context | unknown | jsonb | ✓ | Workflow integration context including triggers, dependencies, and outputs |
| performance_requirements | unknown | jsonb | ✓ | Performance expectations including accuracy targets and processing time limits |
| agent_capabilities | unknown | jsonb | ✓ | Agent capabilities including supported disciplines and document types |
| integration_points | unknown | jsonb | ✓ | System integration points including pages, APIs, and databases |
| success_criteria | unknown | jsonb | ✓ | Success criteria and quality metrics for prompt evaluation |
| prompt_version | string | text | ✓ | Version identifier for prompt versioning and tracking |
| last_tested | string | timestamp with time zone | ✓ | Timestamp of last testing/validation of the prompt |
| test_results | unknown | jsonb | ✓ | Latest test results and performance metrics |

---

### 312. `prompts_enhanced`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 48

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| name | string | text | ✓ | - |
| content | string | text | ✓ | - |
| description | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| sector_id | string | uuid | ✓ | - |
| type | string | text | ✓ | - |
| category | string | text | ✓ | - |
| tags | array | text[] | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| key | string | text | ✓ | - |
| role_type | string | text | ✓ | - |
| access_permissions | unknown | jsonb | ✓ | - |
| created_by | string | text | ✓ | - |
| cross_reference_id | string | uuid | ✓ | - |
| pages_used | array | text[] | ✓ | - |
| date_added | string | timestamp with time zone | ✓ | - |
| date_modified | string | timestamp with time zone | ✓ | - |
| script_usage | unknown | jsonb | ✓ | - |
| usage_statistics | unknown | jsonb | ✓ | - |
| workflow_context | unknown | jsonb | ✓ | - |
| performance_requirements | unknown | jsonb | ✓ | - |
| agent_capabilities | unknown | jsonb | ✓ | - |
| integration_points | unknown | jsonb | ✓ | - |
| success_criteria | unknown | jsonb | ✓ | - |
| prompt_version | string | text | ✓ | - |
| last_tested | string | timestamp with time zone | ✓ | - |
| test_results | unknown | jsonb | ✓ | - |
| workflow_triggers | string | text | ✓ | - |
| workflow_dependencies | string | text | ✓ | - |
| workflow_outputs | string | text | ✓ | - |
| target_accuracy | number | numeric | ✓ | - |
| max_processing_time | integer | integer | ✓ | - |
| expected_field_count | integer | integer | ✓ | - |
| supported_disciplines | string | text | ✓ | - |
| supported_document_types | string | text | ✓ | - |
| supports_multi_agent | boolean | boolean | ✓ | - |
| integrated_pages | string | text | ✓ | - |
| integrated_apis | string | text | ✓ | - |
| integrated_databases | string | text | ✓ | - |
| accuracy_threshold | number | numeric | ✓ | - |
| quality_score_min | number | numeric | ✓ | - |
| last_success_rate | number | numeric | ✓ | - |
| avg_processing_time | number | numeric | ✓ | - |
| total_tests_run | integer | integer | ✓ | - |

---

### 313. `prompts_with_rbac`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 22

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| name | string | text | ✓ | - |
| content | string | text | ✓ | - |
| description | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| sector_id | string | uuid | ✓ | - |
| type | string | text | ✓ | - |
| category | string | text | ✓ | - |
| tags | array | text[] | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| key | string | text | ✓ | - |
| role_type | string | text | ✓ | - |
| access_permissions | unknown | jsonb | ✓ | - |
| created_by | string | text | ✓ | - |
| role_description | string | text | ✓ | - |
| dev_can_access | boolean | boolean | ✓ | - |
| user_can_edit | boolean | boolean | ✓ | - |
| user_can_create | boolean | boolean | ✓ | - |
| user_can_delete | boolean | boolean | ✓ | - |

---

### 314. `quality_checks`

**Description:** Quality inspection and validation tasks across projects

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 15

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| title | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| check_type | string | character varying | ✓ | - |
| severity | string | character varying | ✓ | - |
| location | string | text | ✓ | - |
| status | string | character varying | ✓ | - |
| assigned_to | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| due_date | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |

---

### 315. `rate_limits`

**Description:** Rate limiting data to prevent abuse and ensure fair usage

**Scripts Using This Table:** 1

1. `server/src/services/securityService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 13

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| api_config_id | string | uuid | ✓ | - |
| discipline_code | string | text | ✓ | - |
| limit_type | string | text | ✗ | - |
| request_count | integer | integer | ✗ | - |
| limit_value | integer | integer | ✗ | - |
| window_start | string | timestamp with time zone | ✗ | - |
| window_end | string | timestamp with time zone | ✗ | - |
| blocked_until | string | timestamp with time zone | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |

---

### 316. `recent_audit_activity`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 13

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | - |
| user_email | string | text | ✓ | - |
| action | string | text | ✓ | - |
| resource_type | string | text | ✓ | - |
| resource_id | string | text | ✓ | - |
| discipline_code | string | text | ✓ | - |
| ip_address | string | inet | ✓ | - |
| user_agent | string | text | ✓ | - |
| success | boolean | boolean | ✓ | - |
| error_message | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 317. `record _manager`

**Description:** to manage records within the database

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 4

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| created_at | string | timestamp with time zone | ✗ | - |
| group_id | string | text | ✓ | - |
| source_id_key | string | text | ✓ | - |

---

### 318. `resource_documentation`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| resource_id | string | uuid | ✗ | - |
| resource_type | string | public.resource_type | ✗ | - |
| storage_service | string | public.storage_service_type | ✗ | - |
| storage_url | string | text | ✗ | - |
| document_id | string | character varying | ✗ | - |
| sections | unknown | jsonb | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 319. `resource_prompts`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 5

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| resource_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| resource_type | string | public.resource_type | ✗ | Note:
This is a Primary Key.<pk/> |
| prompt_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/>
This is a Foreign Key to `prompts.id`.<fk table='prompts' column='id'/> |
| applicable_sections | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 320. `risk_assessments`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 19

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| risk_id | string | character varying | ✗ | - |
| inspection_id | string | character varying | ✗ | Note:
This is a Foreign Key to `inspections.inspection_id`.<fk table='inspections' column='inspection_id'/> |
| project_id | string | character varying | ✗ | - |
| risk_level | string | character varying | ✗ | - |
| probability | number | numeric | ✓ | - |
| impact | number | numeric | ✓ | - |
| description | string | text | ✓ | - |
| mitigation_plan | string | text | ✓ | - |
| assigned_to | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| review_date | string | date | ✓ | - |
| closed_date | string | date | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| created_by | string | character varying | ✓ | - |
| updated_by | string | character varying | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 321. `role_definitions`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| role_name | string | character varying | ✗ | - |
| permissions | unknown | jsonb | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| description | string | text | ✓ | - |
| is_active | boolean | boolean | ✓ | - |

---

### 322. `routing_notifications`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 16

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| workflow_id | integer | bigint | ✓ | Note:
This is a Foreign Key to `document_routing_workflows.id`.<fk table='document_routing_workflows' column='id'/> |
| routing_step_id | integer | bigint | ✓ | Note:
This is a Foreign Key to `workflow_routing_steps.id`.<fk table='workflow_routing_steps' column='id'/> |
| recipient_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| recipient_role | string | character varying | ✓ | - |
| notification_type | string | character varying | ✗ | - |
| notification_priority | string | character varying | ✓ | - |
| subject | string | character varying | ✓ | - |
| message | string | text | ✓ | - |
| notification_data | unknown | jsonb | ✓ | - |
| sent | boolean | boolean | ✓ | - |
| sent_at | string | timestamp with time zone | ✓ | - |
| read_at | string | timestamp with time zone | ✓ | - |
| response_url | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 323. `routing_step_actions`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 13

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| routing_step_id | integer | bigint | ✓ | Note:
This is a Foreign Key to `workflow_routing_steps.id`.<fk table='workflow_routing_steps' column='id'/> |
| participant_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| participant_role | string | character varying | ✓ | - |
| action_type | string | character varying | ✗ | - |
| action_status | string | character varying | ✓ | - |
| action_comment | string | text | ✓ | - |
| action_data | unknown | jsonb | ✓ | - |
| deadline | string | timestamp with time zone | ✓ | - |
| reminded_at | string | timestamp with time zone | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 324. `routing_step_participants`

**Scripts Using This Table:** 1

1. `server/src/controllers/enhanced-routing-controller.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| step_id | integer | bigint | ✓ | Note:
This is a Foreign Key to `routing_template_steps.id`.<fk table='routing_template_steps' column='id'/> |
| participant_type | string | character varying | ✗ | - |
| participant_identifier | string | character varying | ✓ | - |
| required | boolean | boolean | ✓ | - |
| notification_enabled | boolean | boolean | ✓ | - |
| notification_priority | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 325. `routing_template_steps`

**Scripts Using This Table:** 1

1. `server/src/controllers/enhanced-routing-controller.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 17

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | integer | bigint | ✓ | Note:
This is a Foreign Key to `document_routing_templates.id`.<fk table='document_routing_templates' column='id'/> |
| step_order | integer | integer | ✗ | - |
| step_name | string | character varying | ✗ | - |
| step_description | string | text | ✓ | - |
| step_type | string | character varying | ✗ | - |
| routing_mode | string | character varying | ✗ | - |
| required_approvals | integer | integer | ✓ | - |
| deadline_hours | integer | integer | ✓ | - |
| escalate_after_hours | integer | integer | ✓ | - |
| escalate_to_role | string | character varying | ✓ | - |
| is_optional | boolean | boolean | ✓ | - |
| auto_advance | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 326. `safety_incidents`

**Description:** Safety incidents requiring investigation and resolution

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 17

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| title | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| incident_type | string | character varying | ✓ | - |
| severity | string | character varying | ✓ | - |
| location | string | text | ✓ | - |
| status | string | character varying | ✓ | - |
| assigned_to | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| reported_by | string | uuid | ✓ | - |
| incident_date | string | timestamp with time zone | ✓ | - |
| due_date | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |

---

### 327. `safety_template_categories`

**Description:** Categorization system for safety templates

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| category_code | string | character varying | ✗ | - |
| category_name | string | character varying | ✗ | - |
| category_description | string | text | ✓ | - |
| parent_category_id | string | uuid | ✓ | Note:
This is a Foreign Key to `safety_template_categories.id`.<fk table='safety_template_categories' column='id'/> |
| is_active | boolean | boolean | ✓ | - |
| sort_order | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 328. `safety_template_dependencies`

**Description:** Relationships and dependencies between safety templates

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| parent_template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `safety_templates.id`.<fk table='safety_templates' column='id'/> |
| dependent_template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `safety_templates.id`.<fk table='safety_templates' column='id'/> |
| dependency_type | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| applies_to_sites | array | text[] | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| valid_from | string | date | ✓ | - |
| valid_to | string | date | ✓ | - |
| created_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 329. `safety_template_usage`

**Description:** Audit trail and analytics for safety template usage

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `safety_templates.id`.<fk table='safety_templates' column='id'/> |
| user_id | string | text | ✓ | - |
| action_type | string | character varying | ✗ | - |
| site_location | string | character varying | ✓ | - |
| contractor_name | string | character varying | ✓ | - |
| session_id | string | character varying | ✓ | - |
| user_agent | string | text | ✓ | - |
| ip_address | string | inet | ✓ | - |
| timestamp | string | timestamp with time zone | ✓ | - |

---

### 330. `safety_templates`

**Description:** Standardized HSE Safety Templates - HTML content in html_content TEXT, schema in content_schema JSONB

**Scripts Using This Table:** 4

1. `modal-debug-test.js`
2. `test/debug/scripts/test_safety_table_direct.js`
3. `test-contractor-assignment-fix.js`
4. `update_safety_templates_rls.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 32

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| discipline_id | string | uuid | ✓ | Note:
This is a Foreign Key to `disciplines.id`.<fk table='disciplines' column='id'/> |
| template_name | string | character varying | ✗ | - |
| template_description | string | text | ✓ | - |
| template_type | string | character varying | ✗ | - |
| template_category | string | character varying | ✓ | - |
| template_content | unknown | jsonb | ✓ | DEPRECATED: Use html_content for HTML, content_metadata for structured data. Remove post-migration. |
| form_schema | unknown | jsonb | ✓ | - |
| html_content | string | text | ✓ | - |
| risk_level | string | character varying | ✓ | - |
| applicable_sites | array | text[] | ✓ | - |
| required_certifications | array | text[] | ✓ | - |
| review_frequency | string | interval | ✓ | - |
| status | string | character varying | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| approval_status | string | character varying | ✓ | - |
| version | string | character varying | ✓ | - |
| is_latest | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| updated_at | string | timestamp with time zone | ✓ | - |
| approved_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| approved_at | string | timestamp with time zone | ✓ | - |
| content_schema | unknown | jsonb | ✓ | - |
| content_metadata | unknown | jsonb | ✓ | - |
| document_type | string | text | ✓ | Document type copied from governance template (e.g., Risk Assessment, Safety Inspection, Incident Report) |
| document_type_label | string | text | ✓ | Human-readable label for the document type |
| organization_name | string | text | ✓ | - |
| discipline_name | string | text | ✓ | - |
| source_governance_template_id | string | uuid | ✓ | - |

---

### 331. `safety_templates_backup_20251121`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 32

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| discipline_id | string | uuid | ✓ | - |
| template_name | string | character varying | ✓ | - |
| template_description | string | text | ✓ | - |
| template_type | string | character varying | ✓ | - |
| template_category | string | character varying | ✓ | - |
| template_content | unknown | jsonb | ✓ | - |
| form_schema | unknown | jsonb | ✓ | - |
| html_content | string | text | ✓ | - |
| risk_level | string | character varying | ✓ | - |
| applicable_sites | array | text[] | ✓ | - |
| required_certifications | array | text[] | ✓ | - |
| review_frequency | string | interval | ✓ | - |
| status | string | character varying | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| approval_status | string | character varying | ✓ | - |
| version | string | character varying | ✓ | - |
| is_latest | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| approved_by | string | uuid | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| content_schema | unknown | jsonb | ✓ | - |
| content_metadata | unknown | jsonb | ✓ | - |
| document_type | string | text | ✓ | - |
| document_type_label | string | text | ✓ | - |
| organization_name | string | text | ✓ | - |
| discipline_name | string | text | ✓ | - |
| source_governance_template_id | string | uuid | ✓ | - |

---

### 332. `schema_migrations`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 3

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| version | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| applied_at | string | timestamp with time zone | ✓ | - |
| description | string | text | ✓ | - |

---

### 333. `scope_of_work`

**Scripts Using This Table:** 12

1. `debug-scope-of-work.js`
2. `debug-scope-structure.js`
3. `populate-scope-of-work-data.js`
4. `populate_procurement_test_data.js`
5. `server/src/controllers/procurementController.js`
6. `server/src/services/ProcurementDocumentService.js`
7. `server/src/services/hitl-assignment-service.js`
8. `server/src/services/procurementTemplateService.js`
9. `test/debug/debug-scope-of-work.js`
10. `test/debug/debug-scope-structure.js`
11. `test/debug/integration/test-mock-data-fix.js`
12. `test/debug/integration/test-mock-data-insertion.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 22

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| title | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| status | string | character varying | ✓ | - |
| priority | string | character varying | ✓ | - |
| estimated_cost | number | numeric | ✓ | - |
| target_completion_date | string | date | ✓ | - |
| assigned_to | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| scope_type | string | character varying | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| additional_context | string | text | ✓ | - |
| project_specifications | string | text | ✓ | - |
| compliance_requirements | string | text | ✓ | - |
| reference_urls | string | text | ✓ | - |
| reference_documents | string | text | ✓ | - |
| content | string | text | ✓ | - |
| draft_saved | boolean | boolean | ✓ | - |
| category | string | character varying | ✓ | - |
| discipline_id | string | uuid | ✓ | Note:
This is a Foreign Key to `disciplines.id`.<fk table='disciplines' column='id'/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 334. `scope_of_work_relationships`

**Scripts Using This Table:** 2

1. `server/src/routes/procurement-template-routes.js`
2. `server/src/services/procurementTemplateService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 9

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| scope_of_work_id | string | uuid | ✓ | - |
| related_document_id | string | uuid | ✓ | - |
| relationship_type | string | text | ✓ | - |
| procurement_code | string | text | ✓ | - |
| description | string | text | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 335. `section_hierarchy`

**Scripts Using This Table:** 14

1. `apply-accordion-hierarchy-enhancement.js`
2. `compare-directors-hierarchy-with-docs.js`
3. `diagnose-missing-hierarchy.js`
4. `fix-api-transformation-for-virtual-sections.js`
5. `fix-directors-hierarchy-to-match-docs.js`
6. `fix-directors-hierarchy-with-option-id.js`
7. `fix-directors-section-hierarchy.js`
8. `server/src/routes/accordion-sections-routes.js`
9. `test/debug/api/test-actual-api-output.js`
10. `test/debug/api/test-complete-api-transformation.js`
11. `test/debug/api/test-fixed-api-transformation.js`
12. `updated-accordion-routes.js`
13. `verify-accordion-hierarchy.js`
14. `verify-it-section-hierarchy.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| parent_section_key | string | text | ✓ | Note:
This is a Foreign Key to `accordion_sections.section_key`.<fk table='accordion_sections' column='section_key'/> |
| child_section_key | string | text | ✓ | Note:
This is a Foreign Key to `accordion_sections.section_key`.<fk table='accordion_sections' column='section_key'/> |
| display_order | integer | integer | ✓ | - |
| is_virtual | boolean | boolean | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 336. `section_organization_mapping`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 6

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| section_key | string | character varying | ✗ | Note:
This is a Foreign Key to `accordion_sections.section_key`.<fk table='accordion_sections' column='section_key'/> |
| organization_id | string | uuid | ✗ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| is_visible | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 337. `section_pages`

**Description:** Maps pages to sections using section_key

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| section_key | string | character varying | ✗ | - |
| page_id | string | uuid | ✗ | Note:
This is a Foreign Key to `pages.page_id`.<fk table='pages' column='page_id'/> |
| display_order | integer | integer | ✗ | - |
| is_subsection | boolean | boolean | ✓ | - |
| parent_page_id | string | uuid | ✓ | Note:
This is a Foreign Key to `pages.page_id`.<fk table='pages' column='page_id'/> |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 338. `sections`

**Description:** Defines accordion sections with metadata, linked by section_key

**Scripts Using This Table:** 2

1. `test/debug/check-existing-schema.js`
2. `test/debug/integration/test-pages-table-investigation.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 9

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| section_key | string | character varying | ✗ | - |
| section_name | string | character varying | ✗ | - |
| section_description | string | text | ✓ | - |
| section_icon | string | character varying | ✓ | - |
| display_order | integer | integer | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 339. `sectors`

**Scripts Using This Table:** 14

1. `create_missing_tables.js`
2. `delete-old-sectors-script.js`
3. `recreate_discipline.js`
4. `scripts/generateModalRegistry.js`
5. `scripts/migrate-sectors.js`
6. `server/scripts/check-database-tables.js`
7. `server/src/routes/section-creator.js`
8. `server/src/routes/sector-management-routes.js`
9. `server/src/routes/sectors.js`
10. `server/src/routes/test-routes.js`
11. `test/debug/integration/test-epcm-data-investigation.js`
12. `test/debug/integration/test-supabase.js`
13. `test-fix-verification.js`
14. `update-sectors-script.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| sector_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| sector_name | string | character varying | ✗ | - |
| is_active | boolean | boolean | ✗ | - |
| page_number_prefix_start | integer | integer | ✗ | - |
| page_number_prefix_end | integer | integer | ✗ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |

---

### 340. `security_alerts`

**Description:** Security alerts and incidents requiring attention

**Scripts Using This Table:** 1

1. `server/src/services/securityService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 16

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| alert_type | string | text | ✗ | - |
| severity | string | text | ✗ | - |
| title | string | text | ✗ | - |
| description | string | text | ✗ | - |
| user_id | string | uuid | ✓ | - |
| api_config_id | string | uuid | ✓ | - |
| ip_address | string | inet | ✓ | - |
| user_agent | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| acknowledged | boolean | boolean | ✗ | - |
| acknowledged_by | string | uuid | ✓ | - |
| acknowledged_at | string | timestamp with time zone | ✓ | - |
| resolved | boolean | boolean | ✗ | - |
| resolved_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |

---

### 341. `security_audit_log`

**Scripts Using This Table:** 1

1. `server/src/services/rowLevelSecurityService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 9

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| audit_type | string | text | ✗ | - |
| audit_date | string | date | ✗ | - |
| results | unknown | jsonb | ✗ | - |
| execution_time | string | interval | ✓ | - |
| tables_scanned | integer | integer | ✓ | - |
| policies_found | integer | integer | ✓ | - |
| critical_issues | integer | integer | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |

---

### 342. `sequence_overrides`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 16

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| procurement_order_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| template_variation_id | string | uuid | ✓ | Note:
This is a Foreign Key to `template_variation_sequences.id`.<fk table='template_variation_sequences' column='id'/> |
| original_sequence | unknown | jsonb | ✗ | - |
| overridden_sequence | unknown | jsonb | ✗ | - |
| override_reason | string | text | ✗ | - |
| override_type | string | character varying | ✗ | - |
| overridden_by | string | uuid | ✓ | - |
| approval_status | string | character varying | ✓ | - |
| approved_by | string | uuid | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| approval_notes | string | text | ✓ | - |
| validation_results | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 343. `shipment_containers`

**Description:** Junction table linking shipments to containers

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| shipment_id | string | uuid | ✓ | Note:
This is a Foreign Key to `logistics_shipments.id`.<fk table='logistics_shipments' column='id'/> |
| container_id | string | uuid | ✓ | Note:
This is a Foreign Key to `containers.id`.<fk table='containers' column='id'/> |
| sequence_number | integer | integer | ✓ | - |
| loading_order | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 344. `signature_audit_trail`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 15

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| signature_document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `signature_documents.id`.<fk table='signature_documents' column='id'/> |
| signature_request_id | string | uuid | ✓ | Note:
This is a Foreign Key to `signature_requests.id`.<fk table='signature_requests' column='id'/> |
| action_type | string | character varying | ✗ | - |
| action_description | string | text | ✓ | - |
| actor_id | string | uuid | ✓ | - |
| actor_email | string | character varying | ✓ | - |
| actor_ip_address | string | inet | ✓ | - |
| actor_user_agent | string | text | ✓ | - |
| previous_status | string | character varying | ✓ | - |
| new_status | string | character varying | ✓ | - |
| additional_data | unknown | jsonb | ✓ | - |
| compliance_flags | unknown | jsonb | ✓ | - |
| blockchain_hash | string | character varying | ✓ | - |
| performed_at | string | timestamp with time zone | ✓ | - |

---

### 345. `signature_documents`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 15

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `a_00900_doccontrol_documents.id`.<fk table='a_00900_doccontrol_documents' column='id'/> |
| documenso_document_id | string | character varying | ✗ | - |
| status | string | character varying | ✓ | - |
| workflow_type | string | character varying | ✓ | - |
| document_name | string | text | ✗ | - |
| document_url | string | text | ✓ | - |
| file_path | string | text | ✓ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| expires_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | integer | bigint | ✓ | - |
| contract_id | integer | bigint | ✓ | - |
| procurement_phase | string | character varying | ✓ | - |

---

### 346. `signature_requests`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 14

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| signature_document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `signature_documents.id`.<fk table='signature_documents' column='id'/> |
| signer_email | string | character varying | ✗ | - |
| signer_name | string | character varying | ✓ | - |
| signer_role | string | character varying | ✓ | - |
| signing_order | integer | integer | ✓ | - |
| signature_status | string | character varying | ✓ | - |
| signed_at | string | timestamp with time zone | ✓ | - |
| declined_at | string | timestamp with time zone | ✓ | - |
| decline_reason | string | text | ✓ | - |
| documenso_recipient_id | string | character varying | ✓ | - |
| signature_field_id | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 347. `signature_templates`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 15

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | integer | bigint | ✓ | - |
| template_name | string | character varying | ✗ | - |
| template_description | string | text | ✓ | - |
| applicable_msic_codes | array | text[] | ✓ | - |
| applicable_contract_types | array | text[] | ✓ | - |
| applicable_procurement_phases | array | text[] | ✓ | - |
| required_signers | unknown | jsonb | ✓ | - |
| default_deadline_hours | integer | integer | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| is_default_for_msic | array | text[] | ✓ | - |
| created_by | string | uuid | ✓ | - |
| version | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 348. `signature_webhooks`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 12

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| webhook_provider | string | character varying | ✓ | - |
| webhook_event_type | string | character varying | ✓ | - |
| webhook_id | string | character varying | ✓ | - |
| webhook_data | unknown | jsonb | ✓ | - |
| processed | boolean | boolean | ✓ | - |
| processed_at | string | timestamp with time zone | ✓ | - |
| processing_errors | unknown | jsonb | ✓ | - |
| signature_document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `signature_documents.id`.<fk table='signature_documents' column='id'/> |
| contract_id | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 349. `sow_appendices`

**Description:** SOW appendices that require contribution and review from different disciplines

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 12

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| sow_id | string | uuid | ✓ | Note:
This is a Foreign Key to `scope_of_work.id`.<fk table='scope_of_work' column='id'/> |
| appendix_type | string | character varying | ✗ | - |
| title | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| status | string | character varying | ✓ | - |
| assigned_to | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |

---

### 350. `sow_document_transfers`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 23

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| scope_of_work_id | string | uuid | ✗ | Note:
This is a Foreign Key to `scope_of_work.id`.<fk table='scope_of_work' column='id'/> |
| document_type | string | character varying | ✗ | - |
| document_title | string | text | ✗ | - |
| document_version | string | character varying | ✓ | - |
| html_content | string | text | ✓ | - |
| css_styles | string | text | ✓ | - |
| generated_pdf_url | string | text | ✓ | - |
| cloud_storage_url | string | text | ✓ | - |
| generated_at | string | timestamp with time zone | ✓ | - |
| last_modified_at | string | timestamp with time zone | ✓ | - |
| generated_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| approved_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| approval_status | string | character varying | ✓ | - |
| routed_for_signature | boolean | boolean | ✓ | - |
| signature_status | string | character varying | ✓ | - |
| route_id | string | uuid | ✓ | - |
| transfer_status | string | character varying | ✓ | - |
| processing_errors | string | text | ✓ | - |
| file_size_bytes | integer | integer | ✓ | - |
| content_hash | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 351. `sow_templates`

**Scripts Using This Table:** 4

1. `server/procurement-sow-api.js`
2. `server/scripts/apply_procurement_sow_integration_migration.js`
3. `server/scripts/create_procurement_sow_tables.js`
4. `server/src/controllers/procurementController.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_name | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| order_type | string | character varying | ✗ | - |
| appendix_definitions | unknown | jsonb | ✗ | - |
| discipline_defaults | unknown | jsonb | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 352. `sql_file_tracking`

**Description:** Tracks SQL files and their corresponding Supabase table versions

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 4

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| file_path | string | character varying | ✗ | Note:
This is a Primary Key.<pk/> |
| supabase_table | string | character varying | ✗ | - |
| last_validated | string | timestamp with time zone | ✓ | - |
| schema_hash | string | character | ✗ | - |

---

### 353. `supplier_verifications`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 16

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| supplier_id | integer | integer | ✓ | Note:
This is a Foreign Key to `suppliers.id`.<fk table='suppliers' column='id'/> |
| source_id | string | uuid | ✓ | Note:
This is a Foreign Key to `integration_sources.id`.<fk table='integration_sources' column='id'/> |
| external_supplier_id | string | character varying | ✗ | - |
| source_system | string | character varying | ✗ | - |
| verification_data | unknown | jsonb | ✗ | - |
| verification_status | string | character varying | ✓ | - |
| bbbee_level | string | character varying | ✓ | - |
| tax_compliant | boolean | boolean | ✓ | - |
| bbbee_compliant | boolean | boolean | ✓ | - |
| cidb_registered | boolean | boolean | ✓ | - |
| expiry_date | string | date | ✓ | - |
| last_verified_at | string | timestamp with time zone | ✓ | - |
| verification_certificate_url | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 354. `suppliers`

**Description:** Table to store supplier information for procurement

**Scripts Using This Table:** 3

1. `create_logistics_data_for_test_orders.js`
2. `create_test_logistics_workflow.js`
3. `server/src/controllers/procurementController.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 24

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| address | string | text | ✓ | - |
| email | string | text | ✓ | - |
| phone | string | text | ✓ | - |
| contact_person | string | text | ✓ | - |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| supplier_type | string | text | ✓ | Type of supplier (e.g., materials, equipment, services) |
| website | string | text | ✓ | Supplier website URL |
| approval_status | string | text | ✓ | Current approval status of the supplier |
| goods_services | string | text | ✓ | Description of goods and services provided |
| rating | number | numeric | ✓ | Supplier rating (0-5 scale) |
| completed_projects | integer | integer | ✓ | Number of completed projects |
| registration_date | string | date | ✓ | Date when supplier was registered |
| last_activity | string | timestamp with time zone | ✓ | Timestamp of last activity/update |
| tax_number | string | text | ✓ | Tax/VAT registration number |
| compliance_status | string | text | ✓ | Current compliance status |
| source_url | string | text | ✓ | URL where supplier information was scraped from |
| scrape_method | string | text | ✓ | Method used for scraping (e.g., tavily_search, manual) |
| scraped_at | string | timestamp with time zone | ✓ | Timestamp when supplier was scraped |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 355. `sync_history`

**Description:** History of synchronization activities with external tender sources

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| source | string | character varying | ✓ | - |
| sync_type | string | character varying | ✓ | - |
| sync_completed_at | string | timestamp with time zone | ✓ | - |
| tenders_found | integer | integer | ✓ | - |
| tenders_new | integer | integer | ✓ | - |
| errors | unknown | jsonb | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |

---

### 356. `task_attachments`

**Description:** File attachments associated with tasks

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| task_id | string | uuid | ✗ | Note:
This is a Foreign Key to `tasks.id`.<fk table='tasks' column='id'/> |
| filename | string | character varying | ✗ | - |
| file_path | string | text | ✗ | - |
| file_size | integer | bigint | ✓ | - |
| mime_type | string | character varying | ✓ | - |
| uploaded_by | string | uuid | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 357. `task_comments`

**Description:** Comments and notes added to tasks for collaboration

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| task_id | string | uuid | ✗ | Note:
This is a Foreign Key to `tasks.id`.<fk table='tasks' column='id'/> |
| user_id | string | uuid | ✗ | - |
| comment | string | text | ✗ | - |
| is_internal | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 358. `task_history`

**Description:** Audit trail of all changes made to tasks

**Scripts Using This Table:** 2

1. `server/src/routes/hitl-task-routes.js`
2. `server/src/services/hitl-assignment-service.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| task_id | string | uuid | ✗ | Note:
This is a Foreign Key to `tasks.id`.<fk table='tasks' column='id'/> |
| user_id | string | uuid | ✗ | - |
| action | string | character varying | ✗ | - |
| old_value | unknown | jsonb | ✓ | - |
| new_value | unknown | jsonb | ✓ | - |
| notes | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 359. `task_messages`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| task_id | string | uuid | ✗ | Note:
This is a Foreign Key to `tasks.id`.<fk table='tasks' column='id'/> |
| message | string | text | ✗ | - |
| message_type | string | text | ✓ | - |
| from_discipline | string | text | ✗ | - |
| to_discipline | string | text | ✗ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 360. `task_sequence_execution`

**Scripts Using This Table:** 1

1. `server/src/services/templateVariationSequencingService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 22

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| procurement_order_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| template_variation | string | character varying | ✗ | - |
| template_variation_id | string | uuid | ✓ | Note:
This is a Foreign Key to `template_variation_sequences.id`.<fk table='template_variation_sequences' column='id'/> |
| planned_sequence | unknown | jsonb | ✗ | - |
| actual_sequence | unknown | jsonb | ✓ | - |
| sequence_adherence | number | numeric | ✓ | - |
| total_tasks | integer | integer | ✓ | - |
| completed_tasks | integer | integer | ✓ | - |
| current_task_position | integer | integer | ✓ | - |
| parallel_groups_active | integer | integer | ✓ | - |
| estimated_completion_time | string | timestamp with time zone | ✓ | - |
| actual_completion_time | string | timestamp with time zone | ✓ | - |
| deviations | unknown | jsonb | ✓ | - |
| bottlenecks | unknown | jsonb | ✓ | - |
| performance_metrics | unknown | jsonb | ✓ | - |
| status | string | character varying | ✓ | - |
| started_at | string | timestamp with time zone | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 361. `tasks`

**Description:** Central repository for all tasks across the procurement and project management system

**Scripts Using This Table:** 20

1. `create_logistics_data_for_test_orders.js`
2. `create_test_logistics_workflow.js`
3. `populate_procurement_test_data.js`
4. `populate_tasks.js`
5. `server/src/controllers/approvalController.js`
6. `server/src/controllers/procurementController.js`
7. `server/src/routes/hitl-task-routes.js`
8. `server/src/services/hitl-assignment-service.js`
9. `server/src/services/hitl-performance-service.js`
10. `server/src/services/templateVariationSequencingService.js`
11. `test_procurement_workflow.js`
12. `tests/e2e/complete-procurement-workflow.e2e.test.js`
13. `tests/integration/error-handling-recovery.test.js`
14. `tests/integration/multi-discipline-coordination.test.js`
15. `tests/integration/performance-baseline-establishment.test.js`
16. `tests/integration/procurement-workflow.integration.test.js`
17. `tests/phase3-advanced-testing.js`
18. `tests/phase3-fixed-tests.js`
19. `tests/unit/task-generation-verification.test.js`
20. `tests/unit/user-assignment-logic.test.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 30

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Unique identifier for the task

Note:
This is a Primary Key.<pk/> |
| organization_id | string | uuid | ✗ | Organization context for multi-tenant isolation - references organizations(id)

Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| task_type | string | character varying | ✗ | Type of task (procurement_review, appendix_contribution, hitl, etc.) |
| title | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| business_object_type | string | character varying | ✓ | Type of business object this task relates to |
| business_object_id | string | uuid | ✓ | ID of the specific business object |
| assigned_to | string | uuid | ✓ | User currently assigned to complete this task - references auth.users(id) |
| assigned_by | string | uuid | ✓ | User who assigned this task - references auth.users(id) |
| discipline | string | character varying | ✓ | Discipline this task belongs to (engineering, procurement, etc.) |
| priority | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| due_date | string | timestamp with time zone | ✓ | - |
| is_hitl | boolean | boolean | ✓ | Whether this task requires human intervention |
| intervention_type | string | character varying | ✓ | Type of human intervention required |
| chatbot_session_id | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| escalated_at | string | timestamp with time zone | ✓ | - |
| metadata | unknown | jsonb | ✓ | Flexible storage for task-specific additional data |
| sequence_position | integer | integer | ✓ | - |
| sequence_group | string | character varying | ✓ | - |
| sequence_dependencies | unknown | jsonb | ✓ | - |
| sequence_execution_id | string | uuid | ✓ | - |
| estimated_duration_minutes | integer | integer | ✓ | - |
| actual_duration_minutes | integer | integer | ✓ | - |
| assigned_to_discipline | string | text | ✓ | - |
| procurement_order_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| created_by | string | uuid | ✓ | - |

---

### 362. `technical_document_categories`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| category_code | string | character varying | ✗ | - |
| category_name | string | character varying | ✗ | - |
| category_description | string | text | ✓ | - |
| discipline | string | character varying | ✗ | - |
| document_type | string | character varying | ✗ | - |
| template_count | integer | integer | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| sort_order | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 363. `template_analytics`

**Scripts Using This Table:** 1

1. `server/services/database-template-service.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `templates.id`.<fk table='templates' column='id'/> |
| date | string | date | ✗ | - |
| total_uses | integer | integer | ✓ | - |
| successful_uses | integer | integer | ✓ | - |
| failed_uses | integer | integer | ✓ | - |
| unique_users | integer | integer | ✓ | - |
| average_generation_time | number | numeric | ✓ | - |
| total_tokens_used | integer | integer | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 364. `template_approval_rules`

**Description:** Workflow rules for template approvals based on type and value

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_type | string | character varying | ✗ | - |
| category | string | character varying | ✓ | - |
| value_threshold | number | numeric | ✓ | - |
| required_roles | array | text[] | ✓ | - |
| requires_technical_review | boolean | boolean | ✓ | - |
| requires_legal_review | boolean | boolean | ✓ | - |
| approval_order | string | character varying | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 365. `template_approval_workflows`

**Description:** Approval workflow instances for procurement templates

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 13

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_templates.id`.<fk table='procurement_templates' column='id'/> |
| workflow_type | unknown | jsonb | ✓ | - |
| status | string | text | ✓ | - |
| current_step | integer | integer | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| rejected_at | string | timestamp with time zone | ✓ | - |
| required_approvals | unknown | jsonb | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 366. `template_assignments`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 18

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | string | uuid | ✗ | Note:
This is a Foreign Key to `templates.id`.<fk table='templates' column='id'/> |
| assigned_to_type | string | character varying | ✗ | - |
| assigned_to_id | string | uuid | ✗ | - |
| assigned_by | string | uuid | ✓ | - |
| assigned_at | string | timestamp without time zone | ✓ | - |
| status | string | character varying | ✓ | - |
| due_date | string | date | ✓ | - |
| priority | string | character varying | ✓ | - |
| submitted_data | unknown | jsonb | ✓ | - |
| submitted_at | string | timestamp without time zone | ✓ | - |
| contractor_comments | string | text | ✓ | - |
| reviewed_by | string | uuid | ✓ | - |
| reviewed_at | string | timestamp without time zone | ✓ | - |
| review_status | string | character varying | ✓ | - |
| reviewer_comments | string | text | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 367. `template_categories`

**Scripts Using This Table:** 1

1. `server/services/database-template-service.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | character varying | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| count | integer | integer | ✓ | - |
| category_type | string | character varying | ✓ | - |
| parent_category_id | string | character varying | ✓ | Note:
This is a Foreign Key to `template_categories.id`.<fk table='template_categories' column='id'/> |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 368. `template_customization_rules`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_category | string | text | ✗ | - |
| customization_type | string | text | ✗ | - |
| field_name | string | text | ✗ | - |
| field_type | string | text | ✗ | - |
| is_required | boolean | boolean | ✓ | - |
| validation_rules | unknown | jsonb | ✓ | - |
| auto_populate_from | string | text | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 369. `template_dependencies`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | string | uuid | ✓ | - |
| parent_template_id | string | uuid | ✓ | - |
| dependent_template_id | string | uuid | ✓ | - |
| dependency_type | string | text | ✓ | - |
| dependency_condition | unknown | jsonb | ✓ | - |
| is_required | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 370. `template_deployments`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| project_template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `project_templates.id`.<fk table='project_templates' column='id'/> |
| deployment_type | string | text | ✗ | - |
| source_system | string | text | ✗ | - |
| target_system | string | text | ✗ | - |
| status | string | text | ✓ | - |
| error_message | string | text | ✓ | - |
| executed_at | string | timestamp without time zone | ✓ | - |

---

### 371. `template_derivations`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| parent_template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_templates.id`.<fk table='procurement_templates' column='id'/> |
| derived_template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_templates.id`.<fk table='procurement_templates' column='id'/> |
| derivation_type | string | character varying | ✓ | - |
| derivation_date | string | timestamp without time zone | ✓ | - |
| derived_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| derivation_reason | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 372. `template_document_structures`

**Description:** Links templates to their hierarchical document structures

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | string | uuid | ✗ | - |
| discipline_table | string | text | ✗ | - |
| hierarchy_definition_id | string | uuid | ✓ | Note:
This is a Foreign Key to `document_hierarchy_definitions.id`.<fk table='document_hierarchy_definitions' column='id'/> |
| structure_data | unknown | jsonb | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 373. `template_relationships`

**Description:** Links templates together for complex document assemblies

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| parent_template_id | string | uuid | ✗ | - |
| child_template_id | string | uuid | ✗ | - |
| relationship_type | string | text | ✗ | - |
| section_path | string | text | ✓ | - |
| is_required | boolean | boolean | ✓ | - |
| sort_order | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 374. `template_reviews`

**Scripts Using This Table:** 1

1. `server/services/database-template-service.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `templates.id`.<fk table='templates' column='id'/> |
| user_id | string | uuid | ✓ | - |
| rating | integer | integer | ✓ | - |
| review_text | string | text | ✓ | - |
| is_helpful | boolean | boolean | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |

---

### 375. `template_usage_logs`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `templates.id`.<fk table='templates' column='id'/> |
| template_type | string | character varying | ✗ | - |
| user_id | string | uuid | ✓ | - |
| session_id | string | character varying | ✓ | - |
| generation_time | integer | integer | ✓ | - |
| success | boolean | boolean | ✓ | - |
| error_message | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |

---

### 376. `template_usage_stats`

**Description:** Analytics and usage statistics for templates

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_type | string | character varying | ✗ | - |
| category | string | character varying | ✓ | - |
| usage_count | integer | integer | ✓ | - |
| last_used | string | timestamp with time zone | ✓ | - |
| average_population_time | string | interval | ✓ | - |
| success_rate | number | numeric | ✓ | - |
| common_populations | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 377. `template_usage_tracking`

**Scripts Using This Table:** 3

1. `server/create_mock_templates.js`
2. `server/src/routes/procurement-template-routes.js`
3. `server/src/services/procurementTemplateService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | - |
| template_id | string | uuid | ✓ | - |
| action_type | string | text | ✗ | - |
| procurement_code | string | text | ✓ | - |
| department_code | string | character varying | ✓ | - |
| session_id | string | text | ✓ | - |
| user_agent | string | text | ✓ | - |
| ip_address | string | inet | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 378. `template_variation_sequences`

**Scripts Using This Table:** 1

1. `server/src/services/templateVariationSequencingService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 21

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| discipline_code | string | character varying | ✗ | - |
| template_variation | string | character varying | ✗ | - |
| variation_name | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| complexity_level | string | character varying | ✗ | - |
| sequence_definition | unknown | jsonb | ✗ | - |
| parallel_groups | unknown | jsonb | ✓ | - |
| dependencies | unknown | jsonb | ✓ | - |
| estimated_duration_minutes | integer | integer | ✓ | - |
| estimated_duration_display | string | character varying | ✓ | - |
| appendices_included | unknown | jsonb | ✓ | - |
| skip_tasks | unknown | jsonb | ✓ | - |
| business_rules | unknown | jsonb | ✓ | - |
| is_default | boolean | boolean | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 379. `template_versions`

**Description:** Version history for master template changes

**Scripts Using This Table:** 2

1. `server/services/database-template-service.js`
2. `server/src/services/templateEditorService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 6

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `master_templates.id`.<fk table='master_templates' column='id'/> |
| version_number | integer | integer | ✗ | - |
| changes | string | text | ✗ | - |
| content | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 380. `templates`

**Scripts Using This Table:** 30

1. `add_more_procurement_templates.js`
2. `apply_discipline_code_fix.js`
3. `check_database_templates.js`
4. `check_template_scope.js`
5. `check_templates_debug.js`
6. `debug_template_insert.js`
7. `docs/implementation/test-data/procurement/tables/test_procurement_data.js`
8. `migrate_procurement_service.js`
9. `migrate_remaining_services.js`
10. `server/api/document-types.js`
11. `server/services/database-template-service.js`
12. `server/src/controllers/procurementController.js`
13. `server/src/routes/form-save-routes.js`
14. `server/src/routes/process-routes-updated.js`
15. `server/src/routes/procurement-sow-templates-routes.js`
16. `server/src/routes/unified-templates-routes.js`
17. `server/src/services/DocumentGenerator.js`
18. `server/src/services/EngineeringTemplateService.js`
19. `server/src/services/ProcurementDocumentService.js`
20. `server/src/services/procurementTemplateService.js`
21. `simple_template_populate.js`
22. `test_bulk_copy_data_integrity.js`
23. `test_case_insensitive_fix.js`
24. `tests/fixtures/data/test-data-population.js`
25. `tests/integration/performance-baseline-establishment.test.js`
26. `tests/phase3-advanced-testing.js`
27. `tests/phase4-end-to-end-testing.js`
28. `tests/test-data-population-fixed.js`
29. `tests/unit/procurement-order-creation.test.js`
30. `tests/unit/sow-association-validation.test.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 33

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| type | string | character varying | ✗ | Template type (form_template, questionnaire, etc.) - not unique since same types can be used across disciplines |
| name | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| version | string | character varying | ✓ | - |
| prompt_template | string | text | ✗ | - |
| validation_config | unknown | jsonb | ✓ | - |
| ui_config | unknown | jsonb | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| is_public | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| usage_count | integer | integer | ✓ | - |
| success_rate | number | numeric | ✓ | - |
| average_generation_time | integer | integer | ✓ | - |
| tags | array | text[] | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| discipline_code | string | character varying | ✓ | EPCM discipline code (01300=Governance, 00850=Civil, 01900=Procurement, 02400=HSSE) |
| document_type | string | character varying | ✓ | Specific document type within the discipline (questionnaire, form, assessment, etc.) |
| discipline | string | character varying | ✓ | - |
| copied_from_template_id | string | uuid | ✓ | References the original template this was copied from

Note:
This is a Foreign Key to `templates.id`.<fk table='templates' column='id'/> |
| template_scope | string | character varying | ✓ | Indicates if template is original, copied, or project-specific |
| target_discipline | string | character varying | ✓ | The discipline this template was copied to (for copied templates) |
| copy_metadata | unknown | jsonb | ✓ | Additional metadata about the copy operation |
| processing_status | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| suitable_for_document_types | array | text[] | ✓ | Array of document types this template is suitable for (purchase_order, work_order, service_order) |
| category | string | character varying | ✓ | - |
| deleted_at | string | timestamp without time zone | ✓ | - |
| deleted_by | string | uuid | ✓ | - |
| deletion_reason | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | Discipline-specific metadata and configuration (e.g., procurement codes, category mappings, protection settings) |

---

### 381. `temporary_uploads`

**Scripts Using This Table:** 2

1. `server/routes/document-numbering-routes.js`
2. `test/debug/integration/test-document-numbering-system.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| organization_id | string | uuid | ✓ | - |
| company_id | string | uuid | ✓ | - |
| file_name | string | text | ✗ | - |
| file_path | string | text | ✗ | - |
| file_size | integer | integer | ✗ | - |
| file_type | string | character varying | ✗ | - |
| document_type | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| expires_at | string | timestamp with time zone | ✗ | - |

---

### 382. `tender_approvals`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 13

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| tender_id | string | uuid | ✗ | Note:
This is a Foreign Key to `tenders.id`.<fk table='tenders' column='id'/> |
| approval_level | integer | integer | ✗ | - |
| approver_id | string | uuid | ✓ | - |
| approver_name | string | text | ✓ | - |
| approver_role | string | text | ✓ | - |
| approval_status | string | character varying | ✓ | - |
| approval_date | string | timestamp without time zone | ✓ | - |
| comments | string | text | ✓ | - |
| approval_document_url | string | text | ✓ | - |
| delegation_to | string | uuid | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 383. `tender_documents`

**Scripts Using This Table:** 2

1. `server/src/routes/document-management-routes.js`
2. `server/src/services/document-retrieval-service.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 18

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| tender_id | string | uuid | ✗ | - |
| document_type | string | character varying | ✗ | - |
| document_name | string | text | ✗ | - |
| document_category | string | character varying | ✓ | - |
| file_path | string | text | ✗ | - |
| file_url | string | text | ✓ | - |
| file_size | integer | integer | ✓ | - |
| mime_type | string | character varying | ✓ | - |
| original_url | string | text | ✓ | - |
| original_filename | string | text | ✓ | - |
| download_status | string | character varying | ✓ | - |
| checksum_hash | string | text | ✓ | - |
| processing_status | string | character varying | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_by | string | text | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 384. `tender_evaluation`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 9

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| tender_id | string | uuid | ✗ | Note:
This is a Foreign Key to `tenders.id`.<fk table='tenders' column='id'/> |
| criterion_name | string | text | ✗ | - |
| criterion_description | string | text | ✓ | - |
| weightage | number | numeric | ✗ | - |
| max_score | number | numeric | ✗ | - |
| evaluation_method | string | character varying | ✓ | - |
| is_mandatory | boolean | boolean | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |

---

### 385. `tender_items`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 13

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| tender_id | string | uuid | ✗ | Note:
This is a Foreign Key to `tenders.id`.<fk table='tenders' column='id'/> |
| item_number | string | character varying | ✗ | - |
| description | string | text | ✗ | - |
| quantity | number | numeric | ✗ | - |
| unit | string | character varying | ✗ | - |
| estimated_unit_price | number | numeric | ✓ | - |
| estimated_total_price | number | numeric | ✓ | - |
| specifications | string | text | ✓ | - |
| delivery_timeline | string | text | ✓ | - |
| quality_standards | string | text | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 386. `tender_monitors`

**Description:** Stores automated tender monitoring configurations with filter criteria

**Scripts Using This Table:** 1

1. `server/src/services/tender-integration-service.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| frequency | string | character varying | ✓ | Check frequency: hourly, daily, or weekly |
| filters | unknown | jsonb | ✓ | JSON object containing filter criteria for matched tenders |
| is_active | boolean | boolean | ✓ | - |
| created_by_user_id | string | character varying | ✓ | - |
| user_ids | unknown | jsonb | ✓ | JSON array of user IDs to notify (in addition to created_by_user_id) |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 387. `tender_notification_logs`

**Description:** Logs all notifications sent to users about new tenders

**Scripts Using This Table:** 1

1. `server/src/services/tender-integration-service.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| monitor_id | string | uuid | ✓ | Note:
This is a Foreign Key to `tender_monitors.id`.<fk table='tender_monitors' column='id'/> |
| tender_id | string | character varying | ✓ | - |
| tender_title | string | character varying | ✓ | - |
| tender_number | string | character varying | ✓ | - |
| issuing_organization | string | character varying | ✓ | - |
| estimated_value | number | numeric | ✓ | - |
| currency | string | character varying | ✓ | - |
| location | string | text | ✓ | - |
| notification_sent_at | string | timestamp with time zone | ✓ | - |

---

### 388. `tender_suppliers`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 25

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| tender_id | string | uuid | ✗ | Note:
This is a Foreign Key to `tenders.id`.<fk table='tenders' column='id'/> |
| supplier_id | string | uuid | ✓ | - |
| supplier_name | string | text | ✗ | - |
| contact_person | string | text | ✓ | - |
| contact_email | string | text | ✓ | - |
| contact_phone | string | text | ✓ | - |
| bid_amount | number | numeric | ✓ | - |
| bid_currency | string | character varying | ✓ | - |
| bid_validity_period | integer | integer | ✓ | - |
| technical_score | number | numeric | ✓ | - |
| financial_score | number | numeric | ✓ | - |
| overall_score | number | numeric | ✓ | - |
| bid_status | string | character varying | ✓ | - |
| submission_date | string | timestamp without time zone | ✓ | - |
| bid_document_url | string | text | ✓ | - |
| technical_proposal | string | text | ✓ | - |
| financial_proposal | string | text | ✓ | - |
| clarifications_requested | array | text[] | ✓ | - |
| clarifications_provided | array | text[] | ✓ | - |
| evaluation_notes | string | text | ✓ | - |
| ranking | integer | integer | ✓ | - |
| is_preferred | boolean | boolean | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 389. `tenders`

**Scripts Using This Table:** 2

1. `server/src/routes/document-management-routes.js`
2. `server/src/routes/tender-integration-routes.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 54

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| tender_number | string | character varying | ✗ | - |
| title | string | text | ✗ | - |
| description | string | text | ✓ | - |
| tender_type | string | character varying | ✗ | - |
| procurement_method | string | character varying | ✗ | - |
| status | string | character varying | ✗ | - |
| priority | string | character varying | ✗ | - |
| estimated_value | number | numeric | ✓ | - |
| currency | string | character varying | ✓ | - |
| budget_allocated | number | numeric | ✓ | - |
| issue_date | string | date | ✗ | - |
| pre_bid_meeting_date | string | date | ✓ | - |
| bid_submission_deadline | string | date | ✗ | - |
| bid_opening_date | string | date | ✓ | - |
| evaluation_completion_date | string | date | ✓ | - |
| award_date | string | date | ✓ | - |
| contract_start_date | string | date | ✓ | - |
| contract_end_date | string | date | ✓ | - |
| location | string | text | ✓ | - |
| scope_of_work | string | text | ✓ | - |
| technical_specifications | string | text | ✓ | - |
| evaluation_criteria | string | text | ✓ | - |
| procurement_officer_id | string | uuid | ✓ | - |
| project_id | string | uuid | ✓ | - |
| department_id | string | uuid | ✓ | - |
| approval_status | string | character varying | ✓ | - |
| approval_workflow_id | string | uuid | ✓ | - |
| current_approval_level | integer | integer | ✓ | - |
| number_of_bids | integer | integer | ✓ | - |
| awarded_supplier_id | string | uuid | ✓ | - |
| awarded_supplier_name | string | text | ✓ | - |
| contract_value | number | numeric | ✓ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| version | integer | integer | ✓ | - |
| eligibility_requirements | string | text | ✓ | - |
| bid_security_amount | number | numeric | ✓ | - |
| bid_security_currency | string | character varying | ✓ | - |
| performance_security_percentage | number | numeric | ✓ | - |
| payment_terms | string | text | ✓ | - |
| delivery_timeline | string | text | ✓ | - |
| warranty_requirements | string | text | ✓ | - |
| tender_document_url | string | text | ✓ | - |
| addendum_urls | unknown | jsonb | ✓ | - |
| clarification_responses | unknown | jsonb | ✓ | - |
| compliance_requirements | string | text | ✓ | - |
| legal_requirements | string | text | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| tags | array | text[] | ✓ | - |
| notes | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 390. `timesheet_amendments`

**Description:** Amendments to timesheet entries

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| timesheet_id | string | uuid | ✓ | Timesheet this amendment is for

Note:
This is a Foreign Key to `timesheets.id`.<fk table='timesheets' column='id'/> |
| requested_by | string | uuid | ✓ | User who requested the amendment

Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| reason | string | text | ✗ | Reason for the amendment |
| status | string | character varying | ✓ | Status of the amendment |
| approved_by | string | uuid | ✓ | User who approved the amendment

Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| approved_at | string | timestamp with time zone | ✓ | When the amendment was approved |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 391. `timesheet_audit_logs`

**Description:** Audit logs for timesheet changes

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| timesheet_id | string | uuid | ✓ | Timesheet this log entry is for

Note:
This is a Foreign Key to `timesheets.id`.<fk table='timesheets' column='id'/> |
| user_id | string | uuid | ✓ | User who made the change

Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| action | string | character varying | ✗ | Action performed |
| old_values | unknown | jsonb | ✓ | Old values before the change |
| new_values | unknown | jsonb | ✓ | New values after the change |
| ip_address | string | inet | ✓ | IP address of the user |
| user_agent | string | text | ✓ | User agent of the request |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 392. `timesheet_descriptions`

**Description:** Timesheet task descriptions and codes per project

**Scripts Using This Table:** 1

1. `insert-sample-timesheet-data.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Unique identifier for the description

Note:
This is a Primary Key.<pk/> |
| project_id | string | uuid | ✓ | Reference to the project

Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| code | string | character varying | ✗ | Task code for timesheet entry |
| description | string | text | ✗ | Detailed task description |
| category | string | character varying | ✓ | Task category for grouping |
| is_active | boolean | boolean | ✓ | Whether the description is active for use |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |

---

### 393. `timesheet_entries`

**Description:** Timesheet entries for user work hours tracking (new implementation)

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 16

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | User who owns this timesheet entry |
| week_start_date | string | date | ✗ | Start date of the week (Monday) for this timesheet |
| description | string | character varying | ✗ | Description of the task or work performed |
| project | string | character varying | ✓ | Project associated with this task |
| monday_hours | number | numeric | ✓ | Hours worked on Monday |
| tuesday_hours | number | numeric | ✓ | Hours worked on Tuesday |
| wednesday_hours | number | numeric | ✓ | Hours worked on Wednesday |
| thursday_hours | number | numeric | ✓ | Hours worked on Thursday |
| friday_hours | number | numeric | ✓ | Hours worked on Friday |
| saturday_hours | number | numeric | ✓ | Hours worked on Saturday |
| sunday_hours | number | numeric | ✓ | Hours worked on Sunday |
| total_hours | number | numeric | ✓ | Total hours calculated automatically |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 394. `timesheet_submissions`

**Description:** Timesheet submissions for approval workflow

**Scripts Using This Table:** 1

1. `server/src/controllers/timesheetController.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 16

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Unique identifier for the submission

Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | Reference to the user who submitted |
| week_key | string | character varying | ✗ | Week identifier in YYYY-WXX format |
| week_start_date | string | date | ✗ | Start date of the week |
| week_end_date | string | date | ✗ | End date of the week |
| tasks | unknown | jsonb | ✗ | JSON array of tasks for the week |
| total_hours | number | numeric | ✓ | Total hours for the week |
| status | string | character varying | ✓ | Current status: draft, submitted, approved, rejected |
| submitted_at | string | timestamp with time zone | ✓ | When the timesheet was submitted |
| approved_at | string | timestamp with time zone | ✓ | When the timesheet was approved |
| rejected_at | string | timestamp with time zone | ✓ | When the timesheet was rejected |
| approver_id | string | uuid | ✓ | Reference to the approver |
| rejection_reason | string | text | ✓ | Reason for rejection if rejected |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 395. `timesheet_templates`

**Description:** Templates for creating timesheet entries

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | User who owns this template |
| name | string | character varying | ✗ | Name of the template |
| tasks | unknown | jsonb | ✓ | JSON array of task templates |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 396. `timesheets`

**Description:** Timesheet entries for employee work hours tracking

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 19

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| employee_id | string | uuid | ✗ | Employee who owns this timesheet entry

Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| date | string | date | ✗ | Date of the work |
| hours | number | numeric | ✗ | Hours worked on this date |
| project | string | character varying | ✗ | Project associated with this work |
| task | string | character varying | ✓ | Task associated with this work |
| client | string | character varying | ✓ | Client associated with this work |
| comments | string | text | ✓ | Comments about this work |
| currency | string | character varying | ✓ | Currency for any monetary values |
| status | string | character varying | ✓ | Status of this timesheet entry |
| template_id | string | uuid | ✓ | Template used to create this entry |
| approved_by | string | uuid | ✓ | User who approved this entry

Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| approved_at | string | timestamp with time zone | ✓ | When this entry was approved |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| locked | boolean | boolean | ✓ | Whether this entry is locked from editing |
| locked_at | string | timestamp with time zone | ✓ | When this entry was locked |
| user_id | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 397. `tracking_events`

**Description:** Historical tracking events for vessels and containers

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 23

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| event_type | string | character varying | ✗ | - |
| event_category | string | character varying | ✗ | - |
| vessel_id | string | uuid | ✓ | Note:
This is a Foreign Key to `vessels.id`.<fk table='vessels' column='id'/> |
| container_id | string | uuid | ✓ | Note:
This is a Foreign Key to `containers.id`.<fk table='containers' column='id'/> |
| event_timestamp | string | timestamp with time zone | ✗ | - |
| event_description | string | text | ✓ | - |
| event_location | string | character varying | ✓ | - |
| latitude | number | numeric | ✓ | - |
| longitude | number | numeric | ✓ | - |
| status_code | string | character varying | ✓ | - |
| status_description | string | character varying | ✓ | - |
| port_code | string | character varying | ✓ | - |
| port_name | string | character varying | ✓ | - |
| facility_name | string | character varying | ✓ | - |
| event_data | unknown | jsonb | ✓ | - |
| data_source | string | character varying | ✓ | - |
| api_reference | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| company_id | string | uuid | ✓ | - |
| organisation_id | string | uuid | ✓ | - |
| project_id | string | uuid | ✓ | - |

---

### 398. `training_materials`

**Description:** Training materials for procurement processes with full compliance and certification tracking

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 27

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| purpose | string | text | ✗ | Primary purpose and objective of the training material |
| target_audience | string | text | ✗ | Target audience for the training material |
| description | string | text | ✓ | - |
| content | string | text | ✓ | - |
| status | string | text | ✗ | - |
| priority | string | text | ✗ | - |
| certification | unknown | jsonb | ✓ | Certification details including type and issuing authority |
| compliance_requirements | unknown | jsonb | ✓ | Specific compliance requirements that must be met |
| regulatory_standards | array | text[] | ✓ | Array of regulatory standards this training material addresses |
| estimated_duration | string | interval | ✓ | - |
| scheduled_date | string | timestamp with time zone | ✓ | - |
| completion_deadline | string | timestamp with time zone | ✓ | - |
| procurement_order_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| scope_of_work_id | string | uuid | ✓ | Note:
This is a Foreign Key to `scope_of_work.id`.<fk table='scope_of_work' column='id'/> |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| assigned_to | string | uuid | ✓ | Note:
This is a Foreign Key to `user_profiles.user_id`.<fk table='user_profiles' column='user_id'/> |
| created_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_profiles.user_id`.<fk table='user_profiles' column='user_id'/> |
| approved_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_profiles.user_id`.<fk table='user_profiles' column='user_id'/> |
| category | string | text | ✓ | - |
| subcategory | string | text | ✓ | - |
| tags | array | text[] | ✓ | - |
| metadata | unknown | jsonb | ✓ | Additional metadata for tracking test data, versions, etc. |
| notes | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 399. `travel_airports`

**Description:** List of airports for travel routing

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | - |
| code | string | character varying | ✗ | - |
| hazards | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 400. `travel_equipment_filters`

**Description:** Equipment filters for travel routes

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | - |
| required_for | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 401. `travel_ground_routes`

**Description:** List of ground routes for travel routing

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | - |
| type | string | character varying | ✗ | - |
| hazards | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 402. `travel_hazard_alerts`

**Description:** Hazard alerts for travel routes

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| type | string | character varying | ✗ | - |
| message | string | text | ✗ | - |
| routes | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 403. `travel_helipads`

**Description:** List of helipads for travel routing

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | - |
| coordinates | string | character varying | ✓ | - |
| equipment | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 404. `travel_requests`

**Description:** Travel requests submitted by users

**Scripts Using This Table:** 1

1. `server/src/controllers/travelController.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 34

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | User who submitted the request |
| purpose | string | character varying | ✗ | Purpose of the travel |
| destination | string | character varying | ✗ | Travel destination |
| start_date | string | date | ✗ | Start date of travel |
| end_date | string | date | ✗ | End date of travel |
| travelers | array | text[] | ✓ | List of travelers |
| transport_mode | string | character varying | ✗ | Type of transport (domestic, international, project-specific) |
| domestic_transport | string | character varying | ✓ | Specific domestic transport type |
| international_transport | string | character varying | ✓ | Specific international transport type |
| project_transport | string | character varying | ✓ | Specific project transport type |
| accommodation | string | character varying | ✓ | Accommodation details |
| special_requirements | string | text | ✓ | Special requirements for the trip |
| citizenship | string | character varying | ✓ | Citizenship of the traveler |
| security_clearance | string | character varying | ✓ | Security clearance level |
| frequent_traveler | boolean | boolean | ✓ | Whether the user is a frequent traveler |
| frequent_flyer_numbers | array | text[] | ✓ | Frequent flyer numbers |
| project_site | string | character varying | ✓ | Project site location |
| visa_required | boolean | boolean | ✓ | Whether a visa is required |
| visa_check_completed | boolean | boolean | ✓ | Whether visa check is completed |
| departure_location | string | character varying | ✓ | Departure location |
| arrival_location | string | character varying | ✓ | Arrival location |
| route_preferences | array | text[] | ✓ | Preferred routes and equipment |
| status | string | character varying | ✓ | Request status (pending, approved, rejected) |
| submitted_at | string | timestamp with time zone | ✓ | When the request was submitted |
| approved_at | string | timestamp with time zone | ✓ | When the request was approved |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| flight_segments | unknown | jsonb | ✓ | - |
| has_return_leg | boolean | boolean | ✓ | - |
| return_segments | unknown | jsonb | ✓ | - |
| health_check_required | boolean | boolean | ✓ | - |
| health_check_passed | boolean | boolean | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 405. `travel_templates`

**Scripts Using This Table:** 3

1. `import-templates-server.js`
2. `import-travel-templates.js`
3. `server/src/controllers/travelController.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 30

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | - |
| name | string | character varying | ✗ | - |
| purpose | string | character varying | ✓ | - |
| destination | string | character varying | ✓ | - |
| travelers | array | text[] | ✓ | - |
| transport_mode | string | character varying | ✓ | - |
| domestic_transport | string | character varying | ✓ | - |
| international_transport | string | character varying | ✓ | - |
| project_transport | string | character varying | ✓ | - |
| accommodation | string | character varying | ✓ | - |
| special_requirements | string | text | ✓ | - |
| citizenship | string | character varying | ✓ | - |
| security_clearance | string | character varying | ✓ | - |
| frequent_traveler | boolean | boolean | ✓ | - |
| frequent_flyer_numbers | array | text[] | ✓ | - |
| project_site | string | character varying | ✓ | - |
| visa_required | boolean | boolean | ✓ | - |
| visa_check_completed | boolean | boolean | ✓ | - |
| departure_location | string | character varying | ✓ | - |
| arrival_location | string | character varying | ✓ | - |
| route_preferences | array | text[] | ✓ | - |
| flight_segments | unknown | jsonb | ✓ | - |
| has_return_leg | boolean | boolean | ✓ | - |
| return_segments | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| health_check_required | boolean | boolean | ✓ | - |
| health_check_passed | boolean | boolean | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 406. `ui_button_settings`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 9

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| company_id | integer | integer | ✗ | - |
| button_option_id | integer | integer | ✓ | Note:
This is a Foreign Key to `button_options.id`.<fk table='button_options' column='id'/> |
| is_visible | boolean | boolean | ✓ | - |
| user_type | string | character varying | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 407. `ui_display_settings`

**Scripts Using This Table:** 2

1. `remove-ui-display-settings.js`
2. `remove-ui-display-settings.mjs`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| company_id | integer | integer | ✗ | - |
| accordion_option_id | integer | integer | ✓ | - |
| is_visible | boolean | boolean | ✓ | - |
| user_type | string | character varying | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 408. `user_accordion_settings`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 8

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| user_type | string | character varying | ✗ | - |
| accordion_id | integer | integer | ✓ | - |
| is_visible | boolean | boolean | ✓ | - |
| contractor_name | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 409. `user_companies`

**Description:** Maps users to their assigned companies

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 4

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| user_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| company_id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 410. `user_company_access`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| company_id | string | text | ✗ | - |
| role | string | text | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 411. `user_department_access`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 6

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | text | ✗ | - |
| department_code | string | text | ✗ | - |
| role_level | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 412. `user_discipline_access`

**Scripts Using This Table:** 4

1. `scripts/populate_user_discipline_access.js`
2. `server/src/middleware/security-middleware.js`
3. `server/src/routes/user-discipline-routes.js`
4. `server/src/routes/users-routes.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| discipline_code | string | character varying | ✗ | - |
| access_level | string | character varying | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| updated_at | string | timestamp with time zone | ✓ | - |
| updated_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |

---

### 413. `user_email_accounts`

**Description:** User email account configurations and credentials

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 24

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| provider_id | string | uuid | ✗ | Note:
This is a Foreign Key to `email_providers.id`.<fk table='email_providers' column='id'/> |
| email_address | string | character varying | ✗ | - |
| display_name | string | character varying | ✓ | - |
| is_primary | boolean | boolean | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| access_token | string | text | ✓ | - |
| refresh_token | string | text | ✓ | - |
| token_expires_at | string | timestamp with time zone | ✓ | - |
| imap_host | string | character varying | ✓ | - |
| imap_port | integer | integer | ✓ | - |
| imap_username | string | character varying | ✓ | - |
| imap_password_encrypted | string | text | ✓ | - |
| smtp_host | string | character varying | ✓ | - |
| smtp_port | integer | integer | ✓ | - |
| smtp_username | string | character varying | ✓ | - |
| smtp_password_encrypted | string | text | ✓ | - |
| last_sync_at | string | timestamp with time zone | ✓ | - |
| sync_enabled | boolean | boolean | ✓ | - |
| sync_frequency_minutes | integer | integer | ✓ | - |
| settings | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 414. `user_email_aliases`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 6

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| email | string | public.citext | ✗ | - |
| normalized_email | string | public.citext | ✗ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| organization_id | string | uuid | ✓ | - |

---

### 415. `user_emails`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 16

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| created_at | string | timestamp with time zone | ✗ | - |
| thread_id | string | text | ✓ | Unique identifier for email thread |
| cc_recipients | array | text[] | ✓ | Array of CC email addresses |
| bcc_recipients | array | text[] | ✓ | Array of BCC email addresses |
| body_html | string | text | ✓ | HTML formatted email body content |
| status | string | text | ✓ | Current status of the email |
| is_starred | boolean | boolean | ✓ | Flag for starred/important emails |
| is_important | boolean | boolean | ✓ | Flag for priority emails |
| folder | string | text | ✓ | Current folder location of email |
| attachments | unknown | jsonb | ✓ | JSON array of attachment metadata |
| raw_headers | string | text | ✓ | Complete email headers in raw format |
| in_reply_to | string | text | ✓ | Message-ID this email is replying to |
| message_references | array | text[] | ✓ | Array of Message-IDs in thread |
| user_id | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 416. `user_langchain_settings`

**Description:** Secure storage for user-specific LangChain AI configurations with encrypted API keys

**Scripts Using This Table:** 3

1. `server/services/langchainDocumentChatService.js`
2. `server/src/routes/langchain-settings-routes.js`
3. `server/src/services/EnhancedLangChainSettingsService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 19

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | - |
| organization_id | string | text | ✓ | - |
| openai_api_key | string | text | ✓ | Encrypted OpenAI API key |
| anthropic_api_key | string | text | ✓ | Encrypted Anthropic API key |
| cohere_api_key | string | text | ✓ | - |
| llm_provider | string | text | ✓ | Primary LLM provider (openai, anthropic, etc.) |
| llm_model | string | text | ✓ | - |
| embeddings_provider | string | text | ✓ | - |
| embeddings_model | string | text | ✓ | - |
| temperature | number | numeric | ✓ | AI creativity/randomness setting (0.0-2.0) |
| max_tokens | integer | integer | ✓ | - |
| dimensions | integer | integer | ✓ | - |
| chunk_size | integer | integer | ✓ | - |
| chunk_overlap | integer | integer | ✓ | - |
| langsmith_enabled | boolean | boolean | ✓ | - |
| langsmith_project | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 417. `user_management`

**Description:** Comprehensive user management table with profile, contact, auth, and business fields

**Scripts Using This Table:** 29

1. `apply_secure_privacy_compliance_rls.js`
2. `check_existing_users.js`
3. `check_user_management_rls.js`
4. `debug-scope-of-work.js`
5. `docs/implementation/test-data/procurement/tables/populate-users.js`
6. `docs/implementation/test-data/procurement/tables/test_procurement_data.js`
7. `fix_privacy_compliance_access.js`
8. `populate_test_users.js`
9. `scripts/populate_disciplines_jsonb.js`
10. `scripts/populate_user_discipline_access.js`
11. `scripts/test_procurement_user_loading.js`
12. `server/assign_admin_role.js`
13. `server/check_user_role.js`
14. `server/scripts/check-database-tables.js`
15. `server/services/langchainProcessingService.js`
16. `server/src/controllers/enterpriseApprovalController.js`
17. `server/src/routes/privacy-routes.js`
18. `server/src/routes/project-permissions-routes.js`
19. `server/src/routes/user-discipline-routes.js`
20. `server/src/routes/users-routes.js`
21. `server/src/services/accessControlService.js`
22. `server/src/services/hitl-assignment-service.js`
23. `test/debug/debug-scope-of-work.js`
24. `test/debug/integration/test-mock-data-fix.js`
25. `test/debug/integration/test-mock-data-insertion.js`
26. `test_privacy_compliance_final.js`
27. `test_user_access.js`
28. `update_user_management_departments.js`
29. `verify_privacy_compliance_fix.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 80

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| user_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| email | string | text | ✗ | - |
| role | string | text | ✓ | - |
| active | boolean | boolean | ✓ | - |
| status | string | character varying | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| employer | string | text | ✓ | - |
| first_name | string | character varying | ✓ | - |
| last_name | string | character varying | ✓ | - |
| display_name | string | character varying | ✓ | User preferred display name, overrides full_name |
| full_name | string | character varying | ✓ | Auto-generated from first_name + last_name via trigger |
| preferred_name | string | character varying | ✓ | - |
| phone | string | character varying | ✓ | - |
| mobile | string | character varying | ✓ | - |
| address | string | text | ✓ | - |
| city | string | character varying | ✓ | - |
| state_province | string | character varying | ✓ | - |
| postal_code | string | character varying | ✓ | - |
| country | string | character varying | ✓ | - |
| job_title | string | character varying | ✓ | - |
| department | string | character varying | ✓ | - |
| division | string | character varying | ✓ | - |
| cost_center | string | character varying | ✓ | - |
| manager_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| employee_id | string | character varying | ✓ | - |
| hire_date | string | date | ✓ | - |
| employment_type | string | character varying | ✓ | employee, contractor, consultant, intern, etc. |
| security_clearance | string | character varying | ✓ | - |
| password_hash | string | character varying | ✓ | - |
| password_salt | string | character varying | ✓ | - |
| last_login | string | timestamp with time zone | ✓ | - |
| login_count | integer | integer | ✓ | - |
| failed_login_attempts | integer | integer | ✓ | - |
| account_locked_until | string | timestamp with time zone | ✓ | - |
| password_reset_token | string | character varying | ✓ | - |
| password_reset_expires | string | timestamp with time zone | ✓ | - |
| email_verified | boolean | boolean | ✓ | - |
| email_verification_token | string | character varying | ✓ | - |
| two_factor_enabled | boolean | boolean | ✓ | - |
| two_factor_secret | string | character varying | ✓ | - |
| avatar_url | string | text | ✓ | - |
| bio | string | text | ✓ | - |
| timezone | string | character varying | ✓ | - |
| locale | string | character varying | ✓ | - |
| theme_preference | string | character varying | ✓ | - |
| notification_preferences | unknown | jsonb | ✓ | JSON object for email/push notification settings |
| user_preferences | unknown | jsonb | ✓ | JSON object for user UI/UX preferences |
| last_activity | string | timestamp with time zone | ✓ | - |
| session_token | string | character varying | ✓ | - |
| session_expires | string | timestamp with time zone | ✓ | - |
| terms_accepted_at | string | timestamp with time zone | ✓ | - |
| privacy_policy_accepted_at | string | timestamp with time zone | ✓ | - |
| data_retention_policy | string | character varying | ✓ | - |
| account_deletion_requested_at | string | timestamp with time zone | ✓ | - |
| contractor_company | string | character varying | ✓ | - |
| consultant_rate | number | numeric | ✓ | - |
| billing_currency | string | character varying | ✓ | - |
| project_access_level | string | character varying | ✓ | standard, elevated, restricted, admin |
| disciplines | unknown | jsonb | ✓ | JSON array of engineering disciplines user works in |
| certifications | unknown | jsonb | ✓ | - |
| emergency_contact | unknown | jsonb | ✓ | - |
| passport_number | string | character varying | ✓ | Primary passport number for international travel |
| passport_expiry_date | string | date | ✓ | Passport expiry date - must be validated before booking flights |
| passport_issue_date | string | date | ✓ | - |
| passport_issuing_country | string | character varying | ✓ | - |
| alternative_travel_docs | unknown | jsonb | ✓ | JSON array of alternative travel documents (visa, green card, resident permit, etc.) |
| date_of_birth | string | date | ✓ | - |
| gender | string | character varying | ✓ | - |
| nationality | string | character varying | ✓ | - |
| residence_country | string | character varying | ✓ | - |
| title | string | character varying | ✓ | - |
| visa_requirements | unknown | jsonb | ✓ | JSON array of visa requirements for different destinations |
| frequent_flyer_programs | unknown | jsonb | ✓ | JSON array of frequent flyer program memberships and account numbers |
| medical_info | unknown | jsonb | ✓ | - |
| dietary_restrictions | array | text[] | ✓ | - |
| special_assistance | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 418. `user_organization_access`

**Scripts Using This Table:** 5

1. `check_existing_users.js`
2. `populate_test_users.js`
3. `server/api/document-types.js`
4. `server/src/middleware/security-middleware.js`
5. `server/src/routes/privacy-routes.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 5

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | text | ✗ | - |
| organization_id | string | text | ✗ | - |
| is_primary | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 419. `user_organizations`

**Scripts Using This Table:** 3

1. `server/src/middlewares/validateDiscipline.js`
2. `server/src/routes/discipline-document-paths-routes.js`
3. `server/src/routes/path-configurations-routes.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| organization_id | string | uuid | ✗ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| role | string | character varying | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 420. `user_profiles`

**Description:** User profile data for SOW Association Modal and user management

**Scripts Using This Table:** 6

1. `check_existing_users.js`
2. `fix_user_loading_gracefully.js`
3. `populate_test_users.js`
4. `server/src/controllers/procurementController.js`
5. `server/src/routes/privacy-routes.js`
6. `server/src/routes/users-routes.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 19

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| user_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✓ | - |
| role | string | text | ✓ | User role (Technical Director, Project Manager, etc.) |
| project_site | string | text | ✓ | - |
| citizenship | string | character varying | ✓ | - |
| security_clearance | string | character varying | ✓ | - |
| frequent_traveler | boolean | boolean | ✓ | - |
| frequent_flyer_numbers | array | text[] | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| email | string | text | ✓ | - |
| first_name | string | text | ✓ | - |
| last_name | string | text | ✓ | - |
| avatar_url | string | text | ✓ | - |
| id | string | uuid | ✓ | Unique user identifier |
| company_id | string | uuid | ✓ | Company/organization identifier |
| settings | unknown | jsonb | ✓ | User settings and profile data as JSONB |
| last_login | string | timestamp with time zone | ✓ | Timestamp of last login |

---

### 421. `user_project_access`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| project_id | string | text | ✗ | - |
| role | string | text | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 422. `user_project_assignments`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| project_id | string | uuid | ✗ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| assigned_role | string | text | ✗ | - |
| phases_access | unknown | jsonb | ✓ | - |
| assigned_by | string | uuid | ✓ | - |
| assigned_at | string | timestamp without time zone | ✓ | - |
| expires_at | string | timestamp without time zone | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 423. `user_role_assignments`

**Scripts Using This Table:** 1

1. `server/src/routes/project-routes.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| role_name | string | character varying | ✗ | Note:
This is a Foreign Key to `role_definitions.role_name`.<fk table='role_definitions' column='role_name'/> |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| company_id | string | uuid | ✓ | - |
| assigned_at | string | timestamp without time zone | ✓ | - |
| assigned_by | string | uuid | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 424. `user_roles`

**Scripts Using This Table:** 1

1. `server/src/services/apiAccessService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | text | ✗ | - |
| role | string | text | ✗ | - |
| department_code | string | text | ✓ | - |
| level | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 425. `user_vetting_permissions`

**Description:** Cached user permissions to improve performance and reduce database load. Auto-expires after 1 hour.

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 7

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| permissions | unknown | jsonb | ✗ | - |
| last_updated | string | timestamp with time zone | ✓ | - |
| expires_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 426. `v_chat_issues`

**Description:** Identifies chat sessions with performance or satisfaction issues

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| session_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| discipline_code | string | character varying | ✓ | - |
| chatbot_type | string | character varying | ✓ | - |
| company_name | string | character varying | ✓ | - |
| project_name | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| performance_issue | string | text | ✓ | - |
| avg_response_time_ms | integer | integer | ✓ | - |
| total_messages | integer | integer | ✓ | - |
| avg_rating | number | numeric | ✓ | - |
| error_message_count | integer | bigint | ✓ | - |

---

### 427. `v_chat_session_summary`

**Description:** Summary of chat sessions with project context for IT dashboard

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 18

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | - |
| discipline_code | string | character varying | ✓ | - |
| chatbot_type | string | character varying | ✓ | - |
| company_name | string | character varying | ✓ | - |
| organisation_name | string | character varying | ✓ | - |
| project_name | string | character varying | ✓ | - |
| project_phase_name | string | character varying | ✓ | - |
| session_title | string | character varying | ✓ | - |
| total_messages | integer | integer | ✓ | - |
| total_documents_referenced | integer | integer | ✓ | - |
| avg_response_time_ms | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| last_activity_at | string | timestamp with time zone | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| session_duration_minutes | number | numeric | ✓ | - |
| latest_message | string | text | ✓ | - |
| avg_user_rating | number | numeric | ✓ | - |

---

### 428. `v_company_project_chat_usage`

**Description:** Chat usage analytics grouped by company and project

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 14

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| company_name | string | character varying | ✓ | - |
| organisation_name | string | character varying | ✓ | - |
| project_name | string | character varying | ✓ | - |
| project_phase_name | string | character varying | ✓ | - |
| discipline_code | string | character varying | ✓ | - |
| chatbot_type | string | character varying | ✓ | - |
| total_sessions | integer | bigint | ✓ | - |
| total_messages | integer | bigint | ✓ | - |
| total_documents_referenced | integer | bigint | ✓ | - |
| avg_response_time_ms | number | numeric | ✓ | - |
| unique_users | integer | bigint | ✓ | - |
| last_activity | string | timestamp with time zone | ✓ | - |
| sessions_last_7_days | integer | bigint | ✓ | - |
| sessions_previous_7_days | integer | bigint | ✓ | - |

---

### 429. `v_daily_chat_stats`

**Description:** Daily aggregated chat statistics by discipline and project

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| date | string | date | ✓ | - |
| discipline_code | string | character varying | ✓ | - |
| chatbot_type | string | character varying | ✓ | - |
| company_name | string | character varying | ✓ | - |
| organisation_name | string | character varying | ✓ | - |
| project_name | string | character varying | ✓ | - |
| sessions_count | integer | bigint | ✓ | - |
| total_messages | integer | bigint | ✓ | - |
| total_documents_referenced | integer | bigint | ✓ | - |
| avg_response_time_ms | number | numeric | ✓ | - |
| unique_users | integer | bigint | ✓ | - |

---


**📝 Generated**: 2026-01-07T04:37:25.062Z
**📊 Tables Documented**: 143
**🏗️ System**: Construct AI Database Schema - Part 3
