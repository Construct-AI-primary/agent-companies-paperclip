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

# 📊 Schema Part 4: Tables 430-445 (V-W alphabetically)

**Database schema documentation for Construct AI - Part 4 of 3.**

## 📋 Overview

This document contains detailed schema information for tables 430-445 (alphabetically ordered).

## 📊 Part Statistics

- **Tables in Part**: 16
- **Total Tables**: 445
- **Generated**: 2026-01-07T04:37:25.062Z

## 📖 Table Documentation

### 430. `v_discipline_performance`

**Description:** Performance metrics for each discipline chatbot type

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
| discipline_code | string | character varying | ✓ | - |
| chatbot_type | string | character varying | ✓ | - |
| total_sessions | integer | bigint | ✓ | - |
| total_messages | integer | bigint | ✓ | - |
| avg_messages_per_session | number | numeric | ✓ | - |
| total_documents_referenced | integer | bigint | ✓ | - |
| avg_documents_per_session | number | numeric | ✓ | - |
| avg_response_time_ms | number | numeric | ✓ | - |
| unique_users | integer | bigint | ✓ | - |
| unique_companies | integer | bigint | ✓ | - |
| unique_projects | integer | bigint | ✓ | - |
| avg_user_satisfaction | number | numeric | ✓ | - |
| last_activity | string | timestamp with time zone | ✓ | - |
| active_today | integer | bigint | ✓ | - |
| active_this_week | integer | bigint | ✓ | - |

---

### 431. `v_document_types_lookup`

**Scripts Using This Table:** 1

1. `test/debug/integration/test-document-numbering-system.js`

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
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| document_type_code | string | character varying | ✓ | - |
| document_type | string | character varying | ✓ | - |
| numbering_pattern | string | text | ✓ | - |
| description | string | text | ✓ | - |
| discipline_code | string | character varying | ✓ | - |
| discipline_name | string | character varying | ✓ | - |
| company_id | string | uuid | ✓ | Note:
This is a Foreign Key to `companies.id`.<fk table='companies' column='id'/> |

---

### 432. `v_document_usage_analytics`

**Description:** Analytics on which documents are most referenced in chats

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
| discipline_code | string | character varying | ✓ | - |
| company_name | string | character varying | ✓ | - |
| project_name | string | character varying | ✓ | - |
| document_reference | string | text | ✓ | - |
| reference_count | integer | bigint | ✓ | - |
| sessions_referencing | integer | bigint | ✓ | - |
| users_referencing | integer | bigint | ✓ | - |
| avg_rating_when_referenced | number | numeric | ✓ | - |
| last_referenced | string | timestamp with time zone | ✓ | - |

---

### 433. `v_financial_overdue`

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
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| reference | string | character varying | ✓ | - |
| description | string | text | ✓ | - |
| amount | number | numeric | ✓ | - |
| due_date | string | date | ✓ | - |
| vendor | string | character varying | ✓ | - |
| project | string | character varying | ✓ | - |
| category | string | character varying | ✓ | - |
| days_overdue | integer | integer | ✓ | - |

---

### 434. `v_financial_summary`

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
| type | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| record_count | integer | bigint | ✓ | - |
| total_amount | number | numeric | ✓ | - |
| avg_amount | number | numeric | ✓ | - |
| min_amount | number | numeric | ✓ | - |
| max_amount | number | numeric | ✓ | - |
| categories | string | text | ✓ | - |
| earliest_date | string | date | ✓ | - |
| latest_date | string | date | ✓ | - |

---

### 435. `v_realtime_chat_activity`

**Description:** Real-time view of active chat sessions

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
| session_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | - |
| discipline_code | string | character varying | ✓ | - |
| chatbot_type | string | character varying | ✓ | - |
| company_name | string | character varying | ✓ | - |
| project_name | string | character varying | ✓ | - |
| session_title | string | character varying | ✓ | - |
| last_activity_at | string | timestamp with time zone | ✓ | - |
| minutes_since_last_activity | number | numeric | ✓ | - |
| activity_status | string | text | ✓ | - |
| latest_message_role | string | character varying | ✓ | - |
| latest_message_preview | string | text | ✓ | - |
| total_messages | integer | integer | ✓ | - |
| avg_response_time_ms | integer | integer | ✓ | - |

---

### 436. `vector_deletion_audit`

**Scripts Using This Table:** 1

1. `server/src/services/VectorProcessingService.js`

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
| vector_id | string | uuid | ✗ | - |
| table_name | string | text | ✗ | - |
| deleted_by | string | uuid | ✓ | - |
| deletion_reason | string | text | ✓ | - |
| deletion_type | string | text | ✓ | - |
| restored_at | string | timestamp with time zone | ✓ | - |
| restored_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 437. `vector_deletion_policies`

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
| policy_name | string | text | ✗ | - |
| applies_to_scope | string | text | ✓ | - |
| retention_period | string | interval | ✓ | - |
| auto_delete | boolean | boolean | ✓ | - |
| requires_approval | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 438. `vector_search_criteria`

**Description:** Stores dynamic search criteria for vector similarity searches across all disciplines

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
| discipline | string | text | ✗ | Discipline identifier (e.g., contracts_post_award, civil_engineering) |
| table_name | string | text | ✗ | Name of the vector table to search (e.g., a_00435_contracts_post_vector) |
| search_name | string | text | ✗ | Unique identifier for this search configuration within the discipline |
| description | string | text | ✓ | - |
| filter_criteria | unknown | jsonb | ✗ | JSONB object containing the filter criteria for the search |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 439. `vector_workspaces`

**Scripts Using This Table:** 3

1. `server/src/middleware/security-middleware.js`
2. `server/src/routes/vector-isolation-routes.js`
3. `server/src/services/VectorProcessingService.js`

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
| name | string | text | ✗ | - |
| description | string | text | ✓ | - |
| workspace_type | string | text | ✓ | - |
| created_by | string | uuid | ✓ | - |
| organisation_id | string | uuid | ✓ | - |
| project_id | string | uuid | ✓ | - |
| discipline_restrictions | array | text[] | ✓ | - |
| auto_cleanup_after | string | interval | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| expires_at | string | timestamp with time zone | ✓ | - |
| is_active | boolean | boolean | ✓ | - |

---

### 440. `vessels`

**Description:** Stores vessel/ship information from VesselFinder API

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

**Columns:** 33

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| imo | string | character varying | ✓ | - |
| mmsi | string | character varying | ✓ | - |
| vessel_name | string | character varying | ✗ | - |
| call_sign | string | character varying | ✓ | - |
| vessel_type | string | character varying | ✓ | - |
| vessel_class | string | character varying | ✓ | - |
| flag_country | string | character varying | ✓ | - |
| gross_tonnage | integer | integer | ✓ | - |
| deadweight_tonnage | integer | integer | ✓ | - |
| length_overall | number | numeric | ✓ | - |
| beam | number | numeric | ✓ | - |
| draught | number | numeric | ✓ | - |
| built_year | integer | integer | ✓ | - |
| latitude | number | numeric | ✓ | - |
| longitude | number | numeric | ✓ | - |
| speed_knots | number | numeric | ✓ | - |
| course | number | numeric | ✓ | - |
| heading | number | numeric | ✓ | - |
| status | string | character varying | ✓ | - |
| destination | string | character varying | ✓ | - |
| eta | string | timestamp with time zone | ✓ | - |
| vesselfinder_id | string | character varying | ✓ | - |
| last_position_update | string | timestamp with time zone | ✓ | - |
| api_data | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| company_id | string | uuid | ✓ | - |
| organisation_id | string | uuid | ✓ | - |
| project_id | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 441. `vetting_access_log`

**Description:** Audit log for all user access attempts to contractor vetting functionality. Used for security compliance and monitoring.

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
| user_id | string | uuid | ✗ | - |
| contractor_id | string | uuid | ✓ | - |
| action | string | character varying | ✗ | - |
| resource | string | character varying | ✗ | - |
| access_granted | boolean | boolean | ✓ | - |
| reason_denied | string | text | ✓ | - |
| discipline | string | character varying | ✓ | - |
| company_count | integer | integer | ✓ | - |
| project_count | integer | integer | ✓ | - |
| ip_address | string | inet | ✓ | - |
| user_agent | string | text | ✓ | - |
| session_id | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| expires_at | string | timestamp with time zone | ✓ | - |

---

### 442. `vetting_access_summary`

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
| access_date | string | timestamp with time zone | ✓ | - |
| discipline | string | character varying | ✓ | - |
| action | string | character varying | ✓ | - |
| access_granted | boolean | boolean | ✓ | - |
| access_count | integer | bigint | ✓ | - |
| unique_users | integer | bigint | ✓ | - |

---

### 443. `vetting_evaluation_audit`

**Description:** Detailed audit trail for vetting evaluation actions, linking evaluations with user permissions at time of action.

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
| evaluation_id | string | uuid | ✗ | - |
| user_id | string | uuid | ✗ | - |
| action | string | character varying | ✗ | - |
| section | string | character varying | ✓ | - |
| changes | unknown | jsonb | ✓ | - |
| user_discipline | string | character varying | ✓ | - |
| user_company_affiliations | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| ip_address | string | inet | ✓ | - |
| session_id | string | text | ✓ | - |

---

### 444. `workflow_routing_steps`

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
| step_id | integer | bigint | ✓ | Note:
This is a Foreign Key to `routing_template_steps.id`.<fk table='routing_template_steps' column='id'/> |
| step_order | integer | integer | ✗ | - |
| step_name | string | character varying | ✗ | - |
| step_status | string | character varying | ✓ | - |
| routing_mode | string | character varying | ✓ | - |
| required_actions | integer | integer | ✓ | - |
| completed_actions | integer | integer | ✓ | - |
| deadline | string | timestamp with time zone | ✓ | - |
| started_at | string | timestamp with time zone | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| esculated_at | string | timestamp with time zone | ✓ | - |
| escalated_to | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 445. `workspace_members`

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
| workspace_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/>
This is a Foreign Key to `vector_workspaces.id`.<fk table='vector_workspaces' column='id'/> |
| user_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| access_level | string | text | ✓ | - |
| added_by | string | uuid | ✓ | - |
| added_at | string | timestamp with time zone | ✓ | - |
| expires_at | string | timestamp with time zone | ✓ | - |

---


**📝 Generated**: 2026-01-07T04:37:25.062Z
**📊 Tables Documented**: 16
**🏗️ System**: Construct AI Database Schema - Part 4
