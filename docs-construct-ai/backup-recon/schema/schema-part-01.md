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

# 📊 Schema Part 1: Tables 1-143 (A-C alphabetically)

**Database schema documentation for Construct AI - Part 1 of 3.**

## 📋 Overview

This document contains detailed schema information for tables 1-143 (alphabetically ordered).

## 📊 Part Statistics

- **Tables in Part**: 143
- **Total Tables**: 445
- **Generated**: 2026-01-07T04:37:25.062Z

## 📖 Table Documentation

### 1. `a_00102_admin_data`

**Description:** Administration data

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

**Columns:** 2

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| created_at | string | timestamp with time zone | ✗ | - |

---

### 2. `a_00102_admin_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |
| created_by_user_id | integer | integer | ✓ | ID of the user who created this vector record |
| access_scope | string | character varying | ✓ | Access scope level for this vector record |
| organisation_id | integer | integer | ✓ | Organization ID this vector record belongs to |
| shared_with_disciplines | string | text | ✓ | JSON/text field indicating which disciplines can access this record |

---

### 3. `a_00105_travel_vector`

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
| id | string | text | ✓ | - |
| embedding | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | text | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | unknown | jsonb | ✓ | - |

---

### 4. `a_00106_timesheet_vector`

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
| id | string | text | ✓ | - |
| embedding | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | text | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | unknown | jsonb | ✓ | - |

---

### 5. `a_00200_commercial_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 6. `a_00300_construction_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 7. `a_00425_contracts_pre_vector`

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
| id | string | text | ✓ | - |
| embedding | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | text | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | unknown | jsonb | ✓ | - |

---

### 8. `a_00435_contracts_post_data`

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
| document_number | string | character varying | ✗ | - |
| contract_title | string | character varying | ✗ | - |
| contract_type | string | character varying | ✓ | - |
| contractor_name | string | character varying | ✓ | - |
| contract_value | number | numeric | ✓ | - |
| currency_code | string | character varying | ✓ | - |
| project_code | string | character varying | ✓ | - |
| project_name | string | character varying | ✓ | - |
| site_location | string | text | ✓ | - |
| award_date | string | date | ✓ | - |
| commencement_date | string | date | ✓ | - |
| completion_date | string | date | ✓ | - |
| original_value | number | numeric | ✓ | - |
| variations | number | numeric | ✓ | - |
| current_value | number | numeric | ✓ | - |
| contract_status | string | character varying | ✓ | - |
| progress_percentage | number | numeric | ✓ | - |
| days_remaining | integer | integer | ✓ | - |
| required_approvals | unknown | jsonb | ✓ | - |
| approval_status | string | character varying | ✓ | - |
| governance_category | string | character varying | ✓ | - |
| document_count | integer | integer | ✓ | - |
| last_document_date | string | timestamp with time zone | ✓ | - |
| template_used_id | string | uuid | ✓ | - |
| created_by | string | uuid | ✓ | - |
| approved_by | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| tags | array | text[] | ✓ | - |
| notes | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| signed_at | string | timestamp with time zone | ✓ | - |

---

### 9. `a_00435_contracts_post_vector`

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
| embedding | string | extensions.vector(1536) | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| organisation_id | string | uuid | ✓ | - |
| project_id | string | uuid | ✓ | - |
| project_phase_assignment_id | string | uuid | ✓ | - |
| isolation_metadata | unknown | jsonb | ✓ | - |
| created_by_user_id | string | uuid | ✓ | - |
| access_scope | string | text | ✓ | - |
| shared_with_disciplines | array | text[] | ✓ | - |
| workspace_id | string | uuid | ✓ | - |
| workspace_type | string | text | ✓ | - |
| deleted_at | string | timestamp with time zone | ✓ | - |
| deleted_by | string | uuid | ✓ | - |
| deletion_reason | string | text | ✓ | - |
| scheduled_hard_delete_at | string | timestamp with time zone | ✓ | - |

---

### 10. `a_00825_architectural_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 11. `a_00835_chemeng_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 12. `a_00850_civileng_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |
| workspace_id | string | uuid | ✓ | Note:
This is a Foreign Key to `vector_workspaces.id`.<fk table='vector_workspaces' column='id'/> |
| workspace_type | string | text | ✓ | - |
| deleted_at | string | timestamp with time zone | ✓ | - |
| deleted_by | string | uuid | ✓ | - |
| deletion_reason | string | text | ✓ | - |
| scheduled_hard_delete_at | string | timestamp with time zone | ✓ | - |
| isolation_metadata | unknown | jsonb | ✓ | - |

---

### 13. `a_00860_eleceng_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 14. `a_00870_mecheng_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 15. `a_00871_processeng_vector`

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
| id | string | text | ✓ | - |
| embedding | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | text | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | unknown | jsonb | ✓ | - |

---

### 16. `a_00872_developer_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 17. `a_00875_sales_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 18. `a_00877_sundry_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 19. `a_00880_boarddir_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 20. `a_00882_dirconst_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 21. `a_00883_dircontracts_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 22. `a_00884_1_dirfinance_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 23. `a_00884_direng_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 24. `a_00885_dirhse_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 25. `a_00886_dirlogistics_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 26. `a_00888_dirprocurement_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 27. `a_00889_dirfinance_vector`

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
| id | string | text | ✓ | - |
| embedding | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | text | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | unknown | jsonb | ✓ | - |

---

### 28. `a_00890_dirprojects_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 29. `a_00895_dirproject_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 30. `a_00900_doccontrol_approval_rule_steps`

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
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| rule_id | integer | bigint | ✗ | Note:
This is a Foreign Key to `a_00900_doccontrol_approval_rules.id`.<fk table='a_00900_doccontrol_approval_rules' column='id'/> |
| step_order | integer | integer | ✗ | - |
| role_slug | string | text | ✓ | - |
| required | boolean | boolean | ✗ | - |
| parallel_group_id | integer | integer | ✓ | - |

---

### 31. `a_00900_doccontrol_approval_rules`

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
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| discipline_id | integer | bigint | ✓ | - |
| store_id | integer | bigint | ✓ | - |
| doc_type | string | text | ✓ | - |
| routing_mode | string | text | ✗ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |

---

### 32. `a_00900_doccontrol_approvals`

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
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| version_id | integer | bigint | ✗ | Note:
This is a Foreign Key to `a_00900_doccontrol_document_versions.id`.<fk table='a_00900_doccontrol_document_versions' column='id'/> |
| step_order | integer | integer | ✗ | - |
| role_slug | string | text | ✓ | - |
| approver_id | string | uuid | ✓ | - |
| required | boolean | boolean | ✗ | - |
| status | string | text | ✗ | - |
| acted_by | string | uuid | ✓ | - |
| acted_at | string | timestamp with time zone | ✓ | - |
| comment | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |

---

### 33. `a_00900_doccontrol_data`

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
| document_id | string | uuid | ✗ | Note:
This is a Foreign Key to `a_00900_doccontrol_documents.id`.<fk table='a_00900_doccontrol_documents' column='id'/> |
| transmittal_number | string | text | ✓ | - |
| revision_code | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 34. `a_00900_doccontrol_document_embeddings`

**Description:** Stores text chunks and their vector embeddings for semantic search

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
| document_id | string | uuid | ✗ | Note:
This is a Foreign Key to `a_00900_doccontrol_documents.id`.<fk table='a_00900_doccontrol_documents' column='id'/> |
| chunk_index | integer | integer | ✗ | - |
| chunk_text | string | text | ✗ | - |
| chunk_metadata | unknown | jsonb | ✓ | - |
| embedding | string | extensions.vector(1536) | ✓ | - |
| embedding_model | string | character varying | ✗ | - |
| embedding_provider | string | character varying | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 35. `a_00900_doccontrol_document_versions`

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
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| document_id | string | uuid | ✗ | Note:
This is a Foreign Key to `a_00900_doccontrol_documents.id`.<fk table='a_00900_doccontrol_documents' column='id'/> |
| version_number | integer | integer | ✗ | - |
| file_path | string | text | ✗ | - |
| status | string | text | ✗ | - |
| submitted_at | string | timestamp with time zone | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| uploaded_at | string | timestamp with time zone | ✗ | - |
| uploaded_by | string | uuid | ✓ | - |
| changes_summary | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 36. `a_00900_doccontrol_documents`

**Scripts Using This Table:** 30

1. `add-construction-documents.js`
2. `add-sample-documents-fixed.js`
3. `add-sample-documents.js`
4. `get-table-schema.js`
5. `quick_seed.js`
6. `reconcile-table-schema.js`
7. `run-migration-direct.js`
8. `scripts/populateFlowiseDocumentIds.js`
9. `seed_document_control_mock_data.js`
10. `server/api/documents/manage.js`
11. `server/api/documents/upload-to-bucket.js`
12. `server/check_dcs_tables.js`
13. `server/routes/document-routes.js`
14. `server/services/langchainDocumentChatService.js`
15. `server/services/langchainProcessingService.js`
16. `server/services/langchainRecordManager.js`
17. `server/src/controllers/advanced-document-management.js`
18. `server/src/controllers/document-management-controller.js`
19. `server/src/routes/document-routes.js`
20. `server/src/services/langchainDocumentChatService.js`
21. `server/src/services/procurementTemplateService.js`
22. `server/src/tests/procurement-templates.test.js`
23. `test/debug/check-database-schema.js`
24. `test/debug/check-table-structure.js`
25. `test/debug/integration/systematic-schema-test.js`
26. `test/debug/integration/test-dummy-document.js`
27. `test/debug/integration/test-file-upload-fix.js`
28. `test/debug/integration/test-hybrid-workflow-success.js`
29. `test/debug/integration/test-minimal-insert.js`
30. `test/debug/scripts/test_openai_access.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 42

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| file_path | string | text | ✗ | - |
| file_name | string | text | ✗ | - |
| file_extension | string | text | ✓ | - |
| uploaded_by | string | uuid | ✓ | - |
| uploaded_at | string | timestamp with time zone | ✓ | - |
| discipline | string | text | ✗ | - |
| page_number | string | text | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| status | string | text | ✓ | - |
| metadata_table_id | string | uuid | ✓ | - |
| flowise_store_id | string | uuid | ✓ | - |
| flowise_loader_id | string | uuid | ✓ | - |
| flowise_doc_id | string | uuid | ✓ | - |
| flowise_file_id | string | uuid | ✓ | - |
| total_chunks | integer | integer | ✓ | - |
| total_characters | integer | integer | ✓ | - |
| flowise_status | string | text | ✓ | - |
| size | integer | integer | ✓ | - |
| original_filename | string | text | ✓ | - |
| storage_url | string | text | ✓ | - |
| category_id | string | uuid | ✓ | - |
| embedding_details | unknown | jsonb | ✓ | Metadata about embedding process |
| is_embedded | boolean | boolean | ✓ | Whether document has been processed for vector search |
| metadata | unknown | jsonb | ✓ | - |
| storage_type | string | text | ✓ | Type of storage used: flowise_store or supabase_bucket |
| flowise_document_id | string | text | ✓ | ID returned by Flowise after document upsert |
| storage_path | string | text | ✓ | - |
| store_id | string | uuid | ✓ | Reference to the document store this document belongs to

Note:
This is a Foreign Key to `document_stores.id`.<fk table='document_stores' column='id'/> |
| title | string | text | ✓ | Document title for display purposes |
| company_id | string | uuid | ✓ | Links document to specific company for filtering

Note:
This is a Foreign Key to `companies.id`.<fk table='companies' column='id'/> |
| organization_id | string | uuid | ✓ | Links document to specific organization for filtering |
| langchain_metadata | unknown | jsonb | ✓ | Complete LangChain processing metadata in JSON format |
| langchain_loader_type | string | character varying | ✓ | LangChain loader used for processing (PyPDFLoader, Docx2txtLoader, etc.) |
| langchain_processing_status | string | character varying | ✓ | Current processing status (pending, processing, completed, failed) |
| langchain_trace_id | string | uuid | ✓ | LangSmith trace ID for observability |
| langchain_chunk_count | integer | integer | ✓ | - |
| langchain_embedding_model | string | character varying | ✓ | - |
| langchain_embedding_provider | string | character varying | ✓ | - |
| langchain_processed_at | string | timestamp with time zone | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 37. `a_00900_doccontrol_langchain_jobs`

**Description:** Manages async LangChain processing jobs for documents

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
| document_id | string | uuid | ✗ | Note:
This is a Foreign Key to `a_00900_doccontrol_documents.id`.<fk table='a_00900_doccontrol_documents' column='id'/> |
| job_type | string | character varying | ✗ | - |
| status | string | character varying | ✗ | - |
| priority | integer | integer | ✓ | - |
| job_config | unknown | jsonb | ✓ | - |
| started_at | string | timestamp with time zone | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| error_message | string | text | ✓ | - |
| retry_count | integer | integer | ✓ | - |
| max_retries | integer | integer | ✓ | - |
| trace_id | string | uuid | ✓ | - |
| langsmith_run_id | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 38. `a_00900_doccontrol_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |
| workspace_id | string | uuid | ✓ | Note:
This is a Foreign Key to `vector_workspaces.id`.<fk table='vector_workspaces' column='id'/> |
| workspace_type | string | text | ✓ | - |
| deleted_at | string | timestamp with time zone | ✓ | - |
| deleted_by | string | uuid | ✓ | - |
| deletion_reason | string | text | ✓ | - |
| scheduled_hard_delete_at | string | timestamp with time zone | ✓ | - |
| isolation_metadata | unknown | jsonb | ✓ | - |

---

### 39. `a_00900_user_langchain_settings`

**Description:** Stores user-specific LangChain configuration settings

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

**Columns:** 40

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| organization_id | string | uuid | ✓ | - |
| llm_provider | string | character varying | ✓ | - |
| llm_model | string | character varying | ✓ | - |
| llm_api_key_encrypted | string | text | ✓ | - |
| llm_base_url | string | character varying | ✓ | - |
| llm_temperature | number | numeric | ✓ | - |
| llm_max_tokens | integer | integer | ✓ | - |
| llm_timeout | integer | integer | ✓ | - |
| embedding_provider | string | character varying | ✓ | - |
| embedding_model | string | character varying | ✓ | - |
| embedding_api_key_encrypted | string | text | ✓ | - |
| embedding_base_url | string | character varying | ✓ | - |
| embedding_dimensions | integer | integer | ✓ | - |
| embedding_batch_size | integer | integer | ✓ | - |
| text_chunk_size | integer | integer | ✓ | - |
| text_chunk_overlap | integer | integer | ✓ | - |
| text_separators | unknown | jsonb | ✓ | - |
| text_keep_separator | boolean | boolean | ✓ | - |
| text_length_function | string | character varying | ✓ | - |
| enable_embeddings | boolean | boolean | ✓ | - |
| enable_summarization | boolean | boolean | ✓ | - |
| enable_keyword_extraction | boolean | boolean | ✓ | - |
| enable_entity_extraction | boolean | boolean | ✓ | - |
| batch_processing | boolean | boolean | ✓ | - |
| max_concurrent_jobs | integer | integer | ✓ | - |
| retry_attempts | integer | integer | ✓ | - |
| retry_delay | integer | integer | ✓ | - |
| langsmith_enabled | boolean | boolean | ✓ | - |
| langsmith_api_key_encrypted | string | text | ✓ | - |
| langsmith_project_name | string | character varying | ✓ | - |
| langsmith_endpoint | string | character varying | ✓ | - |
| langsmith_tracing_enabled | boolean | boolean | ✓ | - |
| langsmith_evaluation_enabled | boolean | boolean | ✓ | - |
| vector_store_provider | string | character varying | ✓ | - |
| vector_store_connection_string_encrypted | string | text | ✓ | - |
| vector_store_table_name | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 40. `a_00test`

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
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| content | string | text | ✗ | - |
| metadata | unknown | jsonb | ✓ | - |
| embedding | string | extensions.vector(1024) | ✓ | - |

---

### 41. `a_01000_environmental_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 42. `a_01100_ethics_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 43. `a_01200_finance_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 44. `a_01300_governance_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 45. `a_01400_health_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 46. `a_01500_hr_candidate_evaluation`

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
| submission_date | string | timestamp without time zone | ✓ | - |
| first_name | string | text | ✓ | - |
| surname | string | text | ✓ | - |
| phone | string | text | ✓ | - |
| city | string | text | ✓ | - |
| province_state | string | text | ✓ | - |
| country | string | text | ✓ | - |
| job_reference_no | string | text | ✓ | - |
| discipline | string | text | ✓ | - |
| email | string | text | ✓ | - |
| educational | string | text | ✓ | - |
| job_history | string | text | ✓ | - |
| skills | string | text | ✓ | - |
| summarize | string | text | ✓ | - |
| vote | number | numeric | ✓ | - |
| consideration | string | text | ✓ | - |
| full_name | string | text | ✓ | - |

---

### 47. `a_01500_hr_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| organisation_id | string | uuid | ✓ | - |
| project_id | string | uuid | ✓ | - |
| project_phase_assignment_id | string | uuid | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 48. `a_01600_localcontent_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 49. `a_01700_logistics_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 50. `a_01750_legal_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 51. `a_01800_operations_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 52. `a_01850_otherparties_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 53. `a_01900_procurement_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | string | uuid | ✓ | - |
| access_scope | string | text | ✓ | - |
| organisation_id | string | uuid | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |
| workspace_id | string | uuid | ✓ | - |
| workspace_type | string | text | ✓ | - |
| deleted_at | string | timestamp with time zone | ✓ | - |
| deleted_by | string | uuid | ✓ | - |
| deletion_reason | string | text | ✓ | - |
| scheduled_hard_delete_at | string | timestamp with time zone | ✓ | - |
| isolation_metadata | unknown | jsonb | ✓ | - |
| discipline_code | string | text | ✓ | - |

---

### 54. `a_02000_projctrl_vector`

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
| id | string | text | ✓ | - |
| embedding | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | text | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | unknown | jsonb | ✓ | - |

---

### 55. `a_02025_invoice_processing`

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
| invoice_no | string | character varying | ✗ | - |
| amount | number | numeric | ✗ | - |
| due_date | string | date | ✗ | - |
| supplier_name | string | character varying | ✗ | - |
| category | string | character varying | ✓ | - |
| company | string | character varying | ✓ | - |
| project | string | character varying | ✓ | - |
| contract_type | string | character varying | ✓ | - |
| contractor | string | character varying | ✓ | - |
| contract | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| description | string | text | ✓ | - |

---

### 56. `a_02025_qs_data`

**Description:** QuantUM Quantity Surveying Data Table - Stores drawings and measurements with full audit trails and compliance tracking

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
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| created_at | string | timestamp with time zone | ✗ | - |
| company_id | string | uuid | ✓ | - |
| project_id | string | uuid | ✓ | - |
| contract_type | string | text | ✓ | - |
| contractor_id | string | uuid | ✓ | - |
| contract_id | string | uuid | ✓ | - |
| identifier | string | text | ✓ | - |
| allocation_values | array | text[] | ✓ | - |
| selected_storage_id | string | text | ✓ | - |
| data_storage_update_mode | string | text | ✓ | - |
| doc_type_value | string | text | ✓ | - |
| doc_type_values | array | text[] | ✓ | - |
| text_input | string | text | ✓ | - |
| selected_file | string | text | ✓ | - |
| text_class_value | string | text | ✓ | - |
| data_type | string | text | ✓ | - |
| title | string | text | ✓ | - |
| scale | string | text | ✓ | - |
| approval_status | string | text | ✓ | - |
| measurement_type | string | text | ✓ | - |
| value | number | numeric | ✓ | - |
| unit | string | text | ✓ | - |
| status | string | text | ✓ | - |
| element_type | string | text | ✓ | - |
| element_identifier | string | text | ✓ | - |
| asaqs_compliant | boolean | boolean | ✓ | - |
| sans_compliant | boolean | boolean | ✓ | - |
| measured_by | string | text | ✓ | - |
| recorded_by | string | text | ✓ | - |

---

### 57. `a_02025_qs_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 58. `a_02035_scheduling_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 59. `a_02050_it_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 60. `a_02050_logistics_data`

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

**Columns:** 2

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| created_at | string | timestamp with time zone | ✗ | - |

---

### 61. `a_02075_inspection_data`

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

**Columns:** 20

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| inspection_date | string | timestamp with time zone | ✗ | - |
| inspector_name | string | text | ✓ | - |
| inspection_type | string | character varying | ✓ | - |
| location | string | text | ✓ | - |
| status | string | character varying | ✓ | - |
| findings | string | text | ✓ | - |
| recommendations | string | text | ✓ | - |
| company | string | character varying | ✓ | - |
| project | string | character varying | ✓ | - |
| contract_type | string | character varying | ✓ | - |
| contractor | string | character varying | ✓ | - |
| contract | string | character varying | ✓ | - |
| attachments | unknown | jsonb | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| category | string | character varying | ✓ | - |
| processing_status | string | character varying | ✓ | - |
| error_message | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 62. `a_02075_inspection_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 63. `a_02075_knowledge_base`

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
| doc_types | string | character varying | ✓ | - |
| type_equipment | string | character varying | ✓ | - |
| type_component | string | character varying | ✓ | - |
| type_item | string | character varying | ✓ | - |
| revision_date | string | date | ✓ | - |
| media | string | character varying | ✓ | - |
| research_frequency | string | character varying | ✓ | - |
| last_search_date | string | date | ✓ | - |
| time | string | character varying | ✓ | - |
| external_sources | string | text | ✓ | - |
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| next_search_date | string | date | ✓ | - |
| comments | string | text | ✓ | - |
| knowledge_type | unknown | jsonb | ✓ | - |
| knowledge_owner | string | character varying | ✓ | - |
| owner_email | string | character varying | ✓ | - |
| owner_first_name | string | character varying | ✓ | - |
| owner_last_name | string | character varying | ✓ | - |
| source_url | string | character varying | ✓ | - |

---

### 64. `a_02075_knowledge_base_data`

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
| url | string | text | ✓ | - |
| original_search_result | string | text | ✓ | - |
| original_search_summary | string | text | ✓ | - |
| search_intent | string | text | ✓ | - |
| writing_style | string | text | ✓ | - |
| writing_tone | string | text | ✓ | - |
| hidden_insight | string | text | ✓ | - |
| target_audience | string | text | ✓ | - |
| goal_of_article | string | text | ✓ | - |
| semantic_analysis | string | text | ✓ | - |
| common_subtopics | string | text | ✓ | - |
| related_questions | string | text | ✓ | - |
| keywords | string | text | ✓ | - |
| primary_keyword | string | text | ✓ | - |
| secondary_keywords | string | text | ✓ | - |
| semantic_keywords | string | text | ✓ | - |
| long_tail_keywords | string | text | ✓ | - |
| re_written_article | string | text | ✓ | - |

---

### 65. `a_02100_pr_media`

**Description:** Table storing platform content data including video metrics and related content

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
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| platform | string | text | ✗ | - |
| channel_name | string | text | ✓ | - |
| channel_url | string | text | ✓ | - |
| views | integer | bigint | ✓ | - |
| likes | integer | bigint | ✓ | - |
| comments | integer | bigint | ✓ | - |
| video_url | string | text | ✓ | - |
| video_description | string | text | ✓ | - |
| video_title | string | text | ✓ | - |
| video_tags | array | text[] | ✓ | - |
| video_summary | string | text | ✓ | - |
| script_summary | string | text | ✓ | - |
| transcript | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| image_title | string | text | ✓ | - |

---

### 66. `a_02100_publicrel_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 67. `a_02200_qa_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 68. `a_02250_qc_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 69. `a_02400_contractor_vetting_data`

**Description:** Contractor vetting specific metadata

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
| document_id | string | uuid | ✗ | Reference to main document

Note:
This is a Foreign Key to `a_02400_contractor_vetting_documents.id`.<fk table='a_02400_contractor_vetting_documents' column='id'/> |
| contractor_name | string | text | ✓ | Name of contractor |
| evaluation_score | integer | integer | ✓ | Evaluation score (0-100) |
| confidence_level | integer | integer | ✓ | AI confidence level (0-100) |
| commentary | string | text | ✓ | AI generated commentary |
| extracted_data | unknown | jsonb | ✓ | JSON data extracted from documents |
| ai_analysis | unknown | jsonb | ✓ | AI analysis results |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 70. `a_02400_contractor_vetting_document_versions`

**Description:** Version history for contractor vetting documents

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
| document_id | string | uuid | ✗ | Reference to main document

Note:
This is a Foreign Key to `a_02400_contractor_vetting_documents.id`.<fk table='a_02400_contractor_vetting_documents' column='id'/> |
| version_number | integer | integer | ✗ | Version sequence number |
| file_path | string | text | ✗ | - |
| uploaded_at | string | timestamp with time zone | ✓ | - |
| uploaded_by | string | uuid | ✓ | - |
| changes_summary | string | text | ✓ | Summary of changes in this version |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 71. `a_02400_contractor_vetting_documents`

**Description:** Contractor vetting documents integrated with 00900 document control system

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
| file_path | string | text | ✗ | - |
| file_name | string | text | ✗ | - |
| file_extension | string | text | ✓ | - |
| uploaded_by | string | uuid | ✓ | - |
| uploaded_at | string | timestamp with time zone | ✓ | - |
| current_version_id | string | uuid | ✓ | Note:
This is a Foreign Key to `a_02400_contractor_vetting_document_versions.id`.<fk table='a_02400_contractor_vetting_document_versions' column='id'/> |
| discipline | string | text | ✗ | Discipline (Safety) |
| page_number | string | text | ✗ | Associated with Safety page (02400) |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| status | string | text | ✓ | - |
| metadata_table_id | string | uuid | ✓ | - |
| vetting_id | integer | integer | ✓ | Reference to contractor vetting record

Note:
This is a Foreign Key to `contractor_vetting.id`.<fk table='contractor_vetting' column='id'/> |
| section_id | integer | integer | ✓ | Reference to specific vetting section

Note:
This is a Foreign Key to `contractor_vetting_sections.id`.<fk table='contractor_vetting_sections' column='id'/> |
| document_type | string | character varying | ✓ | Type of document (financial, licensing, etc.) |
| processing_status | string | text | ✓ | Document processing status |
| processing_result | string | text | ✓ | - |
| document_hash | string | text | ✓ | - |
| content_hash | string | text | ✓ | - |
| storage_path | string | text | ✓ | - |
| department_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| version_number | string | text | ✓ | - |
| retention_policy | string | text | ✓ | - |
| legal_hold | boolean | boolean | ✓ | - |

---

### 72. `a_02400_safety_data`

**Description:** RLS disabled for testing

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
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| filename | string | text | ✗ | - |
| originalname | string | text | ✗ | - |
| filetype | string | text | ✗ | - |
| companyid | integer | integer | ✗ | - |
| projectid | integer | integer | ✗ | - |
| contractid | integer | integer | ✗ | - |
| contracttypeid | integer | integer | ✗ | - |
| mimetype | string | text | ✗ | - |
| filesize | integer | integer | ✗ | - |
| filepath | string | text | ✗ | - |
| uploaddate | string | timestamp with time zone | ✗ | - |
| userrole | string | text | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 73. `a_02400_safety_vector`

**Description:** RLS disabled for testing

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
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| content | string | text | ✗ | - |
| safetydataid | integer | integer | ✓ | Note:
This is a Foreign Key to `a_02400_safety_data.id`.<fk table='a_02400_safety_data' column='id'/> |
| companyid | integer | integer | ✗ | - |
| projectid | integer | integer | ✗ | - |
| contractid | integer | integer | ✗ | - |
| contracttypeid | integer | integer | ✗ | - |
| embedding | string | extensions.vector(1536) | ✓ | - |
| userrole | string | text | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 74. `a_02500_security_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 75. `a_03000_landscaping_vector`

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
| embedding | string | extensions.vector | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| created_by_user_id | integer | integer | ✓ | - |
| access_scope | string | character varying | ✓ | - |
| organisation_id | integer | integer | ✓ | - |
| shared_with_disciplines | string | text | ✓ | - |

---

### 76. `a_performance_docs_vector`

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
| discipline_code | string | character varying | ✓ | - |
| document_type | string | character varying | ✓ | - |
| title | string | text | ✓ | - |
| content | string | text | ✓ | - |
| embedding | string | extensions.vector(1536) | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| tags | array | text[] | ✓ | - |
| last_updated | string | timestamp with time zone | ✓ | - |

---

### 77. `accordion_options`

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
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | - |
| parent_id | integer | integer | ✓ | Note:
This is a Foreign Key to `accordion_options.id`.<fk table='accordion_options' column='id'/> |
| menu_level | integer | integer | ✗ | - |
| display_order | integer | integer | ✗ | - |

---

### 78. `accordion_sections`

**Scripts Using This Table:** 25

1. `analyze-accordion-schema.js`
2. `apply-accordion-hierarchy-enhancement.js`
3. `check-directors-data.js`
4. `compare-directors-hierarchy-with-docs.js`
5. `diagnose-accordion-issues.js`
6. `diagnose-missing-hierarchy.js`
7. `fix-accordion-comprehensive-issues.js`
8. `fix-api-transformation-for-virtual-sections.js`
9. `fix-directors-hierarchy-to-match-docs.js`
10. `fix-directors-hierarchy-with-option-id.js`
11. `fix-directors-section-hierarchy.js`
12. `run-accordion-hierarchy-fix.js`
13. `server/src/routes/accordion-sections-routes.js`
14. `test/debug/api/test-actual-api-output.js`
15. `test/debug/api/test-complete-api-transformation.js`
16. `test/debug/api/test-fixed-api-transformation.js`
17. `test/debug/check-developer-structure-intended.js`
18. `test/debug/integration/test-directors-accordion-fix.js`
19. `test/debug/integration/test-organization-filtering-accordion.js`
20. `test/debug/integration/test-pure-supabase-accordion.js`
21. `update-accordion-routes.js`
22. `updated-accordion-routes.js`
23. `verify-accordion-fix.js`
24. `verify-accordion-hierarchy.js`
25. `verify-it-section-hierarchy.js`

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
| section_key | string | character varying | ✗ | - |
| title | string | character varying | ✗ | - |
| option_id | integer | integer | ✗ | - |
| sector | string | character varying | ✗ | - |
| parent_section_key | string | character varying | ✓ | - |
| display_order | integer | integer | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| hierarchy_level | integer | integer | ✓ | - |
| is_virtual | boolean | boolean | ✓ | - |
| description | string | text | ✓ | - |
| icon_class | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 79. `accordion_sections_directors_backup_20250726`

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
| id | string | uuid | ✓ | - |
| section_key | string | character varying | ✓ | - |
| title | string | character varying | ✓ | - |
| option_id | integer | integer | ✓ | - |
| sector | string | character varying | ✓ | - |
| parent_section_key | string | character varying | ✓ | - |
| display_order | integer | integer | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 80. `accordion_structure`

**Description:** Complete view of accordion structure using existing section_organization_mapping

**Scripts Using This Table:** 3

1. `apply-accordion-schema.js`
2. `server/src/routes/organizations.js`
3. `test/debug/integration/test-universal-accordion-hierarchy.js`

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
| section_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| section_key | string | character varying | ✓ | - |
| section_name | string | character varying | ✓ | - |
| section_description | string | text | ✓ | - |
| section_icon | string | character varying | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| project_id | string | uuid | ✓ | - |
| phase_id | string | uuid | ✓ | - |
| section_display_order | integer | integer | ✓ | - |
| is_visible | boolean | boolean | ✓ | - |
| page_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| page_name | string | character varying | ✓ | - |
| page_slug | string | character varying | ✓ | - |
| page_display_order | integer | integer | ✓ | - |
| is_subsection | boolean | boolean | ✓ | - |
| parent_page_id | string | uuid | ✓ | Note:
This is a Foreign Key to `pages.page_id`.<fk table='pages' column='page_id'/> |
| organization_name | string | character varying | ✓ | - |
| project_name | string | character varying | ✓ | - |
| phase_name | string | character varying | ✓ | - |

---

### 81. `active_entities`

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
| user_id | string | uuid | ✓ | - |
| company_id | string | uuid | ✓ | Note:
This is a Foreign Key to `companies.id`.<fk table='companies' column='id'/> |
| organisation_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| project_phase_id | string | uuid | ✓ | Note:
This is a Foreign Key to `project_phases.id`.<fk table='project_phases' column='id'/> |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 82. `active_security_alerts`

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
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| alert_type | string | text | ✓ | - |
| severity | string | text | ✓ | - |
| title | string | text | ✓ | - |
| description | string | text | ✓ | - |
| user_id | string | uuid | ✓ | - |
| api_config_id | string | uuid | ✓ | - |
| ip_address | string | inet | ✓ | - |
| user_agent | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| acknowledged | boolean | boolean | ✓ | - |
| acknowledged_by | string | uuid | ✓ | - |
| acknowledged_at | string | timestamp with time zone | ✓ | - |
| resolved | boolean | boolean | ✓ | - |
| resolved_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 83. `active_templates`

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
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| type | string | character varying | ✓ | - |
| name | string | character varying | ✓ | - |
| description | string | text | ✓ | - |
| version | string | character varying | ✓ | - |
| prompt_template | string | text | ✓ | - |
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
| discipline_code | string | character varying | ✓ | - |
| document_type | string | character varying | ✓ | - |
| discipline | string | character varying | ✓ | - |
| copied_from_template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `templates.id`.<fk table='templates' column='id'/> |
| template_scope | string | character varying | ✓ | - |
| target_discipline | string | character varying | ✓ | - |
| copy_metadata | unknown | jsonb | ✓ | - |
| processing_status | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| suitable_for_document_types | array | text[] | ✓ | - |
| category | string | character varying | ✓ | - |
| deleted_at | string | timestamp without time zone | ✓ | - |
| deleted_by | string | uuid | ✓ | - |
| deletion_reason | string | text | ✓ | - |

---

### 84. `active_users_travel_docs`

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
| user_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| email | string | text | ✓ | - |
| full_name | string | character varying | ✓ | - |
| passport_number | string | character varying | ✓ | - |
| passport_expiry_date | string | date | ✓ | - |
| passport_issuing_country | string | character varying | ✓ | - |
| alternative_travel_docs | unknown | jsonb | ✓ | - |
| nationality | string | character varying | ✓ | - |
| residence_country | string | character varying | ✓ | - |
| emergency_contact | unknown | jsonb | ✓ | - |
| active | boolean | boolean | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 85. `agent_activity_log`

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
| agent_id | string | uuid | ✗ | - |
| human_user_id | string | uuid | ✓ | - |
| session_id | string | uuid | ✓ | Note:
This is a Foreign Key to `agent_sessions.id`.<fk table='agent_sessions' column='id'/> |
| action_type | string | text | ✗ | - |
| resource_type | string | text | ✗ | - |
| resource_id | string | uuid | ✓ | - |
| action_details | unknown | jsonb | ✓ | - |
| safety_metrics | unknown | jsonb | ✓ | - |
| ip_address | string | inet | ✓ | - |
| user_agent | string | text | ✓ | - |
| confidence_score | number | numeric | ✓ | - |
| processing_time_ms | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 86. `agent_context_boundaries`

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
| agent_id | string | uuid | ✗ | - |
| boundary_type | string | text | ✗ | - |
| boundary_id | string | uuid | ✗ | - |
| access_level | string | text | ✓ | - |
| created_by | string | uuid | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 87. `agent_modal_assignments`

**Scripts Using This Table:** 4

1. `establish-agents-tracking-as-source-of-truth.js`
2. `populate-agent-modal-assignments.js`
3. `server/src/routes/agent-modal-routes.js`
4. `server/src/routes/agent-names-routes.js`

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
| modal_configuration_id | string | uuid | ✗ | Note:
This is a Foreign Key to `modal_configurations.id`.<fk table='modal_configurations' column='id'/> |
| page_id | string | uuid | ✗ | Note:
This is a Foreign Key to `pages.page_id`.<fk table='pages' column='page_id'/> |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |
| last_used | string | timestamp with time zone | ✓ | - |
| agent_name | string | character varying | ✗ | - |

---

### 88. `agent_permissions`

**Description:** Manages role-based access control for AI agents

**Scripts Using This Table:** 1

1. `server/src/controllers/agentPermissionsController.js`

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
| agent_id | string | text | ✗ | Identifier for the AI agent |
| role_id | integer | integer | ✗ | Reference to role_definitions.id

Note:
This is a Foreign Key to `role_definitions.id`.<fk table='role_definitions' column='id'/> |
| has_access | boolean | boolean | ✗ | Whether the role has access to this agent |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | text | ✓ | - |
| updated_by | string | text | ✓ | - |

---

### 89. `agent_profiles`

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
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_type | string | text | ✓ | - |
| agent_metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 90. `agent_roles`

**Scripts Using This Table:** 2

1. `server/src/controllers/agentPermissionsController.js`
2. `server/src/routes/page-permissions-routes.js`

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
| role_name | string | text | ✗ | - |
| description | string | text | ✓ | - |
| capabilities | unknown | jsonb | ✓ | - |
| safety_restrictions | unknown | jsonb | ✓ | - |
| max_requests_per_hour | integer | integer | ✓ | - |
| context_isolation_level | string | text | ✓ | - |
| audit_level | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 91. `agent_sequence_operations`

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
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| agent_id | string | character varying | ✗ | - |
| agent_version | string | character varying | ✓ | - |
| operation | string | character varying | ✗ | - |
| resource_type | string | character varying | ✗ | - |
| resource_id | string | uuid | ✓ | - |
| disciplines | unknown | jsonb | ✓ | - |
| input_data | unknown | jsonb | ✓ | - |
| output_data | unknown | jsonb | ✓ | - |
| processing_time_ms | integer | integer | ✓ | - |
| confidence_score | number | numeric | ✓ | - |
| success | boolean | boolean | ✓ | - |
| error_message | string | text | ✓ | - |
| ip_address | string | inet | ✓ | - |
| user_agent | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 92. `agent_sessions`

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
| agent_id | string | uuid | ✗ | - |
| human_user_id | string | uuid | ✓ | - |
| session_context | unknown | jsonb | ✓ | - |
| started_at | string | timestamp with time zone | ✓ | - |
| expires_at | string | timestamp with time zone | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| safety_metrics | unknown | jsonb | ✓ | - |

---

### 93. `agent_template_integrations`

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
| form_template_id | string | uuid | ✓ | - |
| agent_id | string | uuid | ✓ | Note:
This is a Foreign Key to `agents_tracking.id`.<fk table='agents_tracking' column='id'/> |
| integration_type | string | text | ✗ | - |
| trigger_fields | unknown | jsonb | ✓ | - |
| agent_actions | unknown | jsonb | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| priority | integer | integer | ✓ | - |
| error_handling | string | text | ✓ | - |

---

### 94. `agents_tracking`

**Description:** Tracks AI agents by company, sector, organization, phase, and page assignments

**Scripts Using This Table:** 12

1. `establish-agents-tracking-as-source-of-truth.js`
2. `fix-agent-organizations.js`
3. `populate-agent-modal-assignments.js`
4. `run-agent-relationship-fix.js`
5. `scripts/update-agents-tracking-with-comprehensive-agents.js`
6. `server/src/routes/agents-tracking-routes.js`
7. `server/src/routes/contributors-routes.js`
8. `test/debug/integration/test-modal-creation-fix.js`
9. `update-agent-tables-with-real-agents.js`
10. `update-agents-tracking-with-comprehensive-agents.js`
11. `update-to-single-organization-fixed.js`
12. `update-to-single-organization.js`

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
| agent_name | string | character varying | ✗ | Name of the AI agent |
| company | string | character varying | ✓ | Company the agent is assigned to |
| sector | string | character varying | ✓ | Sector the agent operates in |
| organization | string | character varying | ✓ | Organization within the company |
| phase | string | character varying | ✓ | Project phase the agent is active in |
| page_id | string | uuid | ✓ | Reference to the page the agent is associated with

Note:
This is a Foreign Key to `pages.page_id`.<fk table='pages' column='page_id'/> |
| page_name | string | character varying | ✓ | Name of the associated page |
| page_prefix | string | character varying | ✓ | Prefix of the associated page |
| contributor_id | string | uuid | ✓ | ID of the contributor responsible for this agent |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| notes | string | text | ✓ | Additional notes about the agent |
| last_used | string | timestamp with time zone | ✓ | Timestamp when the agent was last used |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 95. `agents_unified`

**Scripts Using This Table:** 1

1. `establish-agents-tracking-as-source-of-truth.js`

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
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| agent_name | string | character varying | ✓ | - |
| company | string | character varying | ✓ | - |
| sector | string | character varying | ✓ | - |
| organization | string | character varying | ✓ | - |
| phase | string | character varying | ✓ | - |
| page_name | string | character varying | ✓ | - |
| page_prefix | string | character varying | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| notes | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| last_used | string | timestamp with time zone | ✓ | - |
| modal_assignments | integer | bigint | ✓ | - |

---

### 96. `alert_configurations`

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
| alert_type | string | text | ✗ | - |
| threshold_value | number | numeric | ✗ | - |
| threshold_operator | string | text | ✗ | - |
| enabled | boolean | boolean | ✗ | - |
| notification_channels | array | text[] | ✓ | - |
| discipline_code | string | text | ✓ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 97. `api_health_checks`

**Description:** Automated health monitoring results for API endpoints

**Scripts Using This Table:** 2

1. `server/src/routes/chatbot-permissions-routes.js`
2. `server/src/services/monitoringService.js`

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
| api_config_id | string | uuid | ✗ | - |
| check_type | string | text | ✗ | - |
| status | string | text | ✗ | - |
| response_time | integer | integer | ✓ | - |
| status_code | integer | integer | ✓ | - |
| error_message | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| checked_at | string | timestamp with time zone | ✗ | - |
| next_check_at | string | timestamp with time zone | ✓ | - |

---

### 98. `api_usage_metrics`

**Description:** Detailed usage metrics and performance data for API configurations

**Scripts Using This Table:** 2

1. `server/src/routes/chatbot-permissions-routes.js`
2. `server/src/services/monitoringService.js`

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
| api_config_id | string | uuid | ✗ | - |
| user_id | string | uuid | ✓ | - |
| discipline_code | string | text | ✓ | - |
| request_count | integer | integer | ✗ | - |
| success_count | integer | integer | ✗ | - |
| error_count | integer | integer | ✗ | - |
| average_response_time | integer | integer | ✓ | - |
| total_tokens_used | integer | integer | ✓ | - |
| cost_estimate | number | numeric | ✓ | - |
| rate_limit_hits | integer | integer | ✗ | - |
| last_request_at | string | timestamp with time zone | ✓ | - |
| period_start | string | timestamp with time zone | ✗ | - |
| period_end | string | timestamp with time zone | ✗ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |

---

### 99. `api_usage_summary`

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
| api_config_id | string | uuid | ✓ | - |
| discipline_code | string | text | ✓ | - |
| total_requests | integer | bigint | ✓ | - |
| total_success | integer | bigint | ✓ | - |
| total_errors | integer | bigint | ✓ | - |
| avg_response_time | number | numeric | ✓ | - |
| last_request | string | timestamp with time zone | ✓ | - |

---

### 100. `approval_cover_sheets`

**Description:** Generated approval cover sheets for procurement orders

**Scripts Using This Table:** 1

1. `server/src/controllers/approvalController.js`

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
| procurement_order_id | string | uuid | ✗ | Reference to the procurement order

Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| html_content | string | text | ✗ | Generated HTML content of the cover sheet |
| approval_matrix | unknown | jsonb | ✓ | JSON array of required approvers and their roles |
| generated_at | string | timestamp with time zone | ✓ | - |
| status | string | character varying | ✓ | Status of the cover sheet (generated, sent, approved, etc.) |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 101. `approval_delegations`

**Description:** Approval delegation management for when users are unavailable

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
| delegator_user_id | string | uuid | ✓ | - |
| delegate_user_id | string | uuid | ✓ | - |
| role_filter | string | character varying | ✓ | - |
| department_filter | string | character varying | ✓ | - |
| start_date | string | timestamp with time zone | ✓ | - |
| end_date | string | timestamp with time zone | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| reason | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 102. `approval_document_links`

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
| approval_instance_id | string | uuid | ✗ | Note:
This is a Foreign Key to `governance_approval_instances.id`.<fk table='governance_approval_instances' column='id'/> |
| document_id | string | uuid | ✓ | - |
| document_source | string | text | ✓ | - |
| version_number | string | text | ✓ | - |
| file_path | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 103. `approval_history_log`

**Description:** Complete audit trail of all approval actions

**Scripts Using This Table:** 2

1. `server/src/controllers/enterpriseApprovalController.js`
2. `tests/unit/approval-workflow-validation.test.js`

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
| approval_instance_id | string | uuid | ✓ | Note:
This is a Foreign Key to `approval_instances.id`.<fk table='approval_instances' column='id'/> |
| approval_step_id | string | uuid | ✓ | Note:
This is a Foreign Key to `approval_steps.id`.<fk table='approval_steps' column='id'/> |
| action | string | character varying | ✗ | - |
| actor_user_id | string | uuid | ✓ | - |
| target_user_id | string | uuid | ✓ | - |
| old_values | unknown | jsonb | ✓ | - |
| new_values | unknown | jsonb | ✓ | - |
| comments | string | text | ✓ | - |
| ip_address | string | inet | ✓ | - |
| user_agent | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 104. `approval_instances`

**Description:** Individual approval instances for specific documents

**Scripts Using This Table:** 8

1. `server/src/controllers/enterpriseApprovalController.js`
2. `tests/e2e/complete-procurement-workflow.e2e.test.js`
3. `tests/integration/error-handling-recovery.test.js`
4. `tests/integration/performance-baseline-establishment.test.js`
5. `tests/integration/procurement-workflow.integration.test.js`
6. `tests/phase3-advanced-testing.js`
7. `tests/phase3-fixed-tests.js`
8. `tests/unit/approval-workflow-validation.test.js`

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
| workflow_template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `approval_workflow_templates.id`.<fk table='approval_workflow_templates' column='id'/> |
| document_id | string | uuid | ✓ | - |
| document_type | string | character varying | ✗ | - |
| document_reference | string | character varying | ✗ | - |
| document_title | string | character varying | ✓ | - |
| current_step | integer | integer | ✓ | - |
| total_steps | integer | integer | ✓ | - |
| status | string | character varying | ✓ | - |
| priority | string | character varying | ✓ | - |
| initiated_by | string | uuid | ✗ | - |
| initiated_at | string | timestamp with time zone | ✓ | - |
| due_date | string | timestamp with time zone | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| metadata | unknown | jsonb | ✓ | JSONB containing document-specific data used for routing decisions |
| notes | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 105. `approval_steps`

**Description:** Individual approval steps within an approval workflow

**Scripts Using This Table:** 4

1. `server/src/controllers/enterpriseApprovalController.js`
2. `tests/e2e/complete-procurement-workflow.e2e.test.js`
3. `tests/integration/error-handling-recovery.test.js`
4. `tests/unit/approval-workflow-validation.test.js`

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
| approval_instance_id | string | uuid | ✓ | Note:
This is a Foreign Key to `approval_instances.id`.<fk table='approval_instances' column='id'/> |
| step_order | integer | integer | ✗ | - |
| step_name | string | character varying | ✓ | - |
| approver_role | string | character varying | ✗ | - |
| approver_user_id | string | uuid | ✓ | - |
| assigned_at | string | timestamp with time zone | ✓ | - |
| status | string | character varying | ✓ | - |
| decision_date | string | timestamp with time zone | ✓ | - |
| comments | string | text | ✓ | - |
| rejection_reason | string | text | ✓ | - |
| esignature_data | unknown | jsonb | ✓ | JSONB containing encrypted e-signature metadata |
| escalation_date | string | timestamp with time zone | ✓ | - |
| escalated_at | string | timestamp with time zone | ✓ | - |
| escalated_to | string | uuid | ✓ | - |
| is_required | boolean | boolean | ✓ | - |
| is_parallel | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 106. `approval_workflow_templates`

**Description:** Governance-managed approval workflow templates for different document types

**Scripts Using This Table:** 1

1. `server/src/controllers/enterpriseApprovalController.js`

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
| name | string | character varying | ✗ | - |
| department | string | character varying | ✗ | - |
| document_type | string | character varying | ✗ | - |
| approval_matrix | unknown | jsonb | ✗ | JSONB containing the complete approval routing rules |
| conditions | unknown | jsonb | ✓ | JSONB containing conditional routing logic (amount thresholds, etc.) |
| requires_esignature | boolean | boolean | ✓ | - |
| escalation_hours | integer | integer | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 107. `approval_workflows`

**Scripts Using This Table:** 4

1. `server/src/controllers/approvalController.js`
2. `tests/fixtures/data/test-data-population.js`
3. `tests/test-data-population-fixed.js`
4. `tests/unit/approval-workflow-validation.test.js`

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
| name | string | character varying | ✗ | - |
| department | string | character varying | ✓ | - |
| role | string | character varying | ✓ | - |
| approvers | unknown | jsonb | ✓ | - |
| escalation_rules | unknown | jsonb | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 108. `audit_log`

**Scripts Using This Table:** 3

1. `server/src/controllers/advanced-document-management.js`
2. `server/src/services/auditLoggingService.js`
3. `tests/unit/procurement-order-creation.test.js`

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
| action | string | text | ✗ | - |
| table_name | string | text | ✓ | - |
| user_id | string | text | ✓ | - |
| record_id | string | text | ✓ | - |
| details | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 109. `available_companies`

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

**Columns:** 2

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| company_name | string | character varying | ✓ | - |
| source | string | text | ✓ | - |

---

### 110. `button_options`

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
| name | string | character varying | ✗ | - |
| button_id | string | character varying | ✗ | - |
| page_id | string | character varying | ✗ | - |
| display_order | integer | integer | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 111. `chat_analytics`

**Description:** Analytics data for IT dashboard and usage monitoring

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
| session_id | string | uuid | ✓ | Note:
This is a Foreign Key to `chat_sessions.id`.<fk table='chat_sessions' column='id'/> |
| user_id | string | uuid | ✓ | - |
| discipline_code | string | character varying | ✗ | - |
| chatbot_type | string | character varying | ✗ | - |
| company_id | string | uuid | ✓ | - |
| company_name | string | character varying | ✓ | - |
| organisation_id | string | uuid | ✓ | - |
| organisation_name | string | character varying | ✓ | - |
| project_id | string | uuid | ✓ | - |
| project_name | string | character varying | ✓ | - |
| project_phase_id | string | uuid | ✓ | - |
| project_phase_name | string | character varying | ✓ | - |
| query_type | string | character varying | ✓ | - |
| query_category | string | character varying | ✓ | - |
| response_quality_score | number | numeric | ✓ | - |
| user_satisfaction_rating | integer | integer | ✓ | - |
| response_time_ms | integer | integer | ✓ | - |
| documents_found | integer | integer | ✓ | - |
| documents_relevant | integer | integer | ✓ | - |
| session_duration_minutes | integer | integer | ✓ | - |
| messages_in_session | integer | integer | ✓ | - |
| time_of_day | integer | integer | ✓ | - |
| day_of_week | integer | integer | ✓ | - |
| user_feedback | string | text | ✓ | - |
| improvement_suggestions | string | text | ✓ | - |
| error_occurred | boolean | boolean | ✓ | - |
| error_type | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |

---

### 112. `chat_messages`

**Description:** Stores individual chat messages with AI processing metadata

**Scripts Using This Table:** 1

1. `server/src/routes/chat-history/chat-history-routes.js`

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
| session_id | string | uuid | ✓ | Note:
This is a Foreign Key to `chat_sessions.id`.<fk table='chat_sessions' column='id'/> |
| role | string | character varying | ✗ | - |
| content | string | text | ✗ | - |
| citations | unknown | jsonb | ✓ | - |
| document_count | integer | integer | ✓ | - |
| documents_accessed | unknown | jsonb | ✓ | - |
| ai_model_used | string | character varying | ✓ | - |
| processing_time_ms | integer | integer | ✓ | - |
| token_count | integer | integer | ✓ | - |
| search_query | string | text | ✓ | - |
| search_results_count | integer | integer | ✓ | - |
| vector_similarity_scores | unknown | jsonb | ✓ | - |
| user_rating | integer | integer | ✓ | - |
| user_feedback | string | text | ✓ | - |
| was_helpful | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |

---

### 113. `chat_sessions`

**Description:** Stores chat sessions with full project context from active_entities

**Scripts Using This Table:** 1

1. `server/src/routes/chat-history/chat-history-routes.js`

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
| user_id | string | uuid | ✓ | - |
| discipline_code | string | character varying | ✗ | - |
| chatbot_type | string | character varying | ✗ | - |
| company_id | string | uuid | ✓ | Note:
This is a Foreign Key to `companies.id`.<fk table='companies' column='id'/> |
| company_name | string | character varying | ✓ | Denormalized company name for performance |
| organisation_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| organisation_name | string | character varying | ✓ | Denormalized organisation name for performance |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| project_name | string | character varying | ✓ | Denormalized project name for performance |
| project_phase_id | string | uuid | ✓ | Note:
This is a Foreign Key to `project_phases.id`.<fk table='project_phases' column='id'/> |
| project_phase_name | string | character varying | ✓ | Denormalized project phase name for performance |
| session_title | string | character varying | ✓ | - |
| session_summary | string | text | ✓ | - |
| total_messages | integer | integer | ✓ | - |
| total_documents_referenced | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| last_activity_at | string | timestamp with time zone | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| is_archived | boolean | boolean | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| avg_response_time_ms | integer | integer | ✓ | - |
| total_processing_time_ms | integer | bigint | ✓ | - |

---

### 114. `chatbot_audit_logs`

**Description:** Comprehensive audit trail for all chatbot and API access activities

**Scripts Using This Table:** 2

1. `server/src/routes/chatbot-permissions-routes.js`
2. `server/src/services/securityService.js`

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
| user_id | string | uuid | ✓ | - |
| user_email | string | text | ✓ | - |
| action | string | text | ✗ | - |
| resource_type | string | text | ✗ | - |
| resource_id | string | text | ✓ | - |
| discipline_code | string | text | ✓ | - |
| ip_address | string | inet | ✓ | - |
| user_agent | string | text | ✓ | - |
| success | boolean | boolean | ✗ | - |
| error_message | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |

---

### 115. `chatbot_interactions`

**Scripts Using This Table:** 1

1. `server/src/services/ChatbotSessionManager.js`

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
| interaction_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| session_id | string | uuid | ✗ | Note:
This is a Foreign Key to `chatbot_sessions.session_id`.<fk table='chatbot_sessions' column='session_id'/> |
| user_id | string | uuid | ✗ | - |
| page_id | string | character varying | ✗ | - |
| interaction_type | string | character varying | ✗ | - |
| content | string | text | ✗ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |

---

### 116. `chatbot_pages`

**Scripts Using This Table:** 1

1. `server/src/routes/chatbot-permissions-routes.js`

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
| page_id | string | text | ✗ | - |
| page_name | string | text | ✗ | - |
| category | string | text | ✗ | - |
| chatbot_type | string | text | ✗ | - |
| has_chatbot | boolean | boolean | ✗ | - |
| vector_table_name | string | text | ✓ | - |
| description | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |

---

### 117. `chatbot_performance_metrics`

**Scripts Using This Table:** 1

1. `server/src/services/ChatbotSessionManager.js`

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
| metric_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| page_id | string | character varying | ✗ | - |
| user_id | string | uuid | ✓ | - |
| session_id | string | uuid | ✓ | Note:
This is a Foreign Key to `chatbot_sessions.session_id`.<fk table='chatbot_sessions' column='session_id'/> |
| metric_type | string | character varying | ✗ | - |
| metric_value | number | numeric | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| recorded_at | string | timestamp with time zone | ✗ | - |

---

### 118. `chatbot_performance_summary`

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
| page_id | string | character varying | ✓ | - |
| metric_type | string | character varying | ✓ | - |
| metric_count | integer | bigint | ✓ | - |
| avg_value | number | numeric | ✓ | - |
| min_value | number | numeric | ✓ | - |
| max_value | number | numeric | ✓ | - |
| hour_recorded | string | timestamp with time zone | ✓ | - |

---

### 119. `chatbot_permissions`

**Description:** Fine-grained permissions for chatbot access by page and role

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

**Columns:** 10

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| page_id | string | text | ✗ | - |
| role_id | integer | integer | ✗ | - |
| has_access | boolean | boolean | ✗ | - |
| granted_by | string | uuid | ✓ | - |
| granted_at | string | timestamp with time zone | ✗ | - |
| expires_at | string | timestamp with time zone | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |

---

### 120. `chatbot_sessions`

**Scripts Using This Table:** 1

1. `server/src/services/ChatbotSessionManager.js`

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
| session_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✗ | - |
| page_id | string | character varying | ✗ | - |
| discipline_code | string | character varying | ✗ | - |
| chat_type | string | character varying | ✗ | - |
| current_state | string | character varying | ✓ | - |
| session_data | unknown | jsonb | ✓ | - |
| started_at | string | timestamp with time zone | ✗ | - |
| ended_at | string | timestamp with time zone | ✓ | - |
| total_interactions | integer | integer | ✓ | - |
| last_activity_at | string | timestamp with time zone | ✓ | - |

---

### 121. `chatbot_usage_analytics`

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
| page_id | string | character varying | ✓ | - |
| total_sessions | integer | bigint | ✓ | - |
| unique_users | integer | bigint | ✓ | - |
| total_interactions | integer | bigint | ✓ | - |
| avg_session_minutes | number | numeric | ✓ | - |
| chat_type | string | character varying | ✓ | - |
| discipline_code | string | character varying | ✓ | - |
| session_date | string | timestamp with time zone | ✓ | - |

---

### 122. `chatbot_vector_configs`

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
| config_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| page_id | string | character varying | ✗ | - |
| vector_table_name | string | character varying | ✗ | - |
| search_enabled | boolean | boolean | ✓ | - |
| search_threshold | number | numeric | ✓ | - |
| max_results | integer | integer | ✓ | - |
| filters | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |

---

### 123. `chatbots`

**Description:** Stores configurations for chatbots, mapping pages and states to Flowise flow IDs.

**Scripts Using This Table:** 2

1. `server/src/controllers/flowise.js`
2. `server/src/controllers/sector-management-controller.js`

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
| page | string | character varying | ✗ | Note:
This is a Primary Key.<pk/> |
| state | string | character varying | ✗ | Note:
This is a Primary Key.<pk/> |
| flow_id | string | character varying | ✗ | - |
| input_placeholder | string | text | ✓ | Optional placeholder text for the chat input field. |
| sector | string | text | ✓ | - |
| sector_id | string | uuid | ✓ | Note:
This is a Foreign Key to `sectors.sector_id`.<fk table='sectors' column='sector_id'/> |
| updated_at | string | date | ✓ | - |

---

### 124. `chatbots_backup`

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
| page | string | character varying | ✓ | - |
| state | string | character varying | ✓ | - |
| flow_id | string | character varying | ✓ | - |
| input_placeholder | string | text | ✓ | - |
| sector | string | text | ✓ | - |
| sector_id | string | uuid | ✓ | - |
| updated_at | string | date | ✓ | - |

---

### 125. `civil_engineering_document_links`

**Description:** Junction table for linking civil engineering documents to other documents and references

**Scripts Using This Table:** 1

1. `server/src/services/CivilEngineeringDocumentService.js`

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
| document_id | string | uuid | ✗ | Note:
This is a Foreign Key to `civil_engineering_documents.id`.<fk table='civil_engineering_documents' column='id'/> |
| linked_document_id | string | uuid | ✓ | - |
| linked_document_type | string | character varying | ✓ | - |
| reference_type | string | character varying | ✓ | Type of relationship: reference, supersedes, related, supporting |
| link_description | string | text | ✓ | - |
| link_created_by | string | uuid | ✓ | - |
| link_created_at | string | timestamp with time zone | ✓ | - |
| project_phase | string | character varying | ✓ | - |
| document_section | string | character varying | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 126. `civil_engineering_documents`

**Description:** Dedicated table for civil engineering technical documents (adapted from procurement orders workflow)

**Scripts Using This Table:** 4

1. `create_civil_engineering_table_test.js`
2. `server/check_dcs_tables.js`
3. `server/src/routes/civil-engineering-documents-routes.js`
4. `server/src/services/CivilEngineeringDocumentService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 26

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| document_number | string | character varying | ✓ | Auto-generated unique document number (SP-2025-001, CA-2025-001, DR-2025-001, etc.) |
| document_type | string | character varying | ✗ | Type of engineering document: specifications, calculations, drawings, reports, technical_notes, method_statements |
| title | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| discipline | string | character varying | ✓ | Engineering discipline: civil, structural, geotechnical, transportation, etc. |
| priority | string | character varying | ✓ | - |
| engineering_standard | string | character varying | ✓ | Applicable engineering standard (BS, SANS, Eurocode, etc.) |
| design_code | string | character varying | ✓ | Specific design code reference |
| project_phase | string | character varying | ✓ | Current project phase for document filtering and suggestions |
| project_id | string | uuid | ✓ | Reference to projects table for project context awareness

Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| project_location | string | character varying | ✓ | - |
| project_scale | string | character varying | ✓ | - |
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `master_engineering_templates.id`.<fk table='master_engineering_templates' column='id'/> |
| linked_documents | unknown | jsonb | ✓ | JSON array of linked documents with metadata for document integration feature |
| approval_status | string | character varying | ✓ | - |
| issue_date | string | date | ✓ | - |
| revision_date | string | date | ✓ | - |
| review_deadline | string | date | ✓ | - |
| technical_requirements | string | text | ✓ | - |
| compliance_requirements | string | text | ✓ | - |
| quality_standards | string | text | ✓ | - |
| created_by | string | uuid | ✗ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 127. `companies`

**Scripts Using This Table:** 6

1. `gather_database_info.js`
2. `scripts/fix-companies-table.js`
3. `scripts/migrate-organization-id-to-uuid.js`
4. `scripts/setup-companies-table.js`
5. `server/src/controllers/companies.js`
6. `server/src/routes/sector-management-routes.js`

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
| name | string | character varying | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| active | boolean | boolean | ✓ | - |
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 128. `complete_epcm_accordion`

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
| section_key | string | character varying | ✓ | - |
| title | string | character varying | ✓ | - |
| option_id | integer | integer | ✓ | - |
| sector | string | character varying | ✓ | - |
| parent_section_key | string | character varying | ✓ | - |
| display_order | integer | integer | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| is_visible | boolean | boolean | ✓ | - |
| organization_name | string | character varying | ✓ | - |
| section_type | string | text | ✓ | - |
| page_number | integer | integer | ✓ | - |

---

### 129. `compliance_checks`

**Description:** Compliance monitoring results for various regulatory frameworks

**Scripts Using This Table:** 3

1. `server/src/services/quality-procurement-metrics-service.js`
2. `server/src/services/securityService.js`
3. `test-data-population-quality.js`

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
| check_type | string | text | ✗ | - |
| resource_type | string | text | ✗ | - |
| resource_id | string | text | ✓ | - |
| status | string | text | ✗ | - |
| check_result | unknown | jsonb | ✗ | - |
| checked_by | string | uuid | ✓ | - |
| checked_at | string | timestamp with time zone | ✗ | - |
| next_check_at | string | timestamp with time zone | ✓ | - |
| remediation_required | boolean | boolean | ✗ | - |
| remediation_notes | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |

---

### 130. `compliance_reports`

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
| report_id | string | character varying | ✗ | - |
| project_id | string | character varying | ✗ | - |
| inspection_id | string | character varying | ✓ | - |
| report_period | string | character varying | ✓ | - |
| compliance_rate | number | numeric | ✓ | - |
| inspections_completed | integer | integer | ✓ | - |
| total_inspections | integer | integer | ✓ | - |
| defects_found | integer | integer | ✓ | - |
| critical_findings | integer | integer | ✓ | - |
| recommendations | unknown | jsonb | ✓ | - |
| regulations | unknown | jsonb | ✓ | - |
| status | string | character varying | ✓ | - |
| generated_at | string | timestamp without time zone | ✓ | - |
| created_by | string | character varying | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 131. `consolidated_documents`

**Description:** Unified view of document embeddings with store and processing information

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
| embedding_id | integer | bigint | ✓ | Note:
This is a Primary Key.<pk/> |
| source | string | text | ✓ | - |
| content | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| discipline_code | string | text | ✓ | - |
| embedding_created_at | string | timestamp with time zone | ✓ | - |
| document_store_uuid | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| document_store_name | string | text | ✓ | - |
| document_store_description | string | text | ✓ | - |
| security_level | string | character varying | ✓ | - |
| access_roles | unknown | jsonb | ✓ | - |
| flowise_document_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| document_name | string | text | ✓ | - |
| original_filename | string | text | ✓ | - |
| file_size | integer | bigint | ✓ | - |
| mime_type | string | text | ✓ | - |
| total_chunks | integer | integer | ✓ | - |
| total_characters | integer | integer | ✓ | - |
| processing_status | string | text | ✓ | - |
| uploaded_at | string | timestamp with time zone | ✓ | - |
| processed_at | string | timestamp with time zone | ✓ | - |

---

### 132. `consultants`

**Description:** Consultants table with procurement entity fields for approval workflow

**Scripts Using This Table:** 1

1. `server/populate-consultants.js`

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
| name | string | character varying | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| address | string | text | ✓ | - |
| email | string | text | ✓ | - |
| phone | string | text | ✓ | - |
| contact_person | string | text | ✓ | - |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| consultant_type | string | text | ✓ | Type of consultant (e.g., engineering, architectural, legal) |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| services_offered | string | text | ✓ | - |
| license_number | string | text | ✓ | - |
| insurance_status | string | text | ✓ | - |
| registration_date | string | date | ✓ | - |
| approval_status | string | text | ✓ | - |
| compliance_status | string | text | ✓ | - |
| last_activity | string | timestamp with time zone | ✓ | - |
| scraped_at | string | timestamp with time zone | ✓ | - |

---

### 133. `contacts`

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
| contact_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| users_name | string | character varying | ✓ | - |
| email | string | character varying | ✓ | - |
| first_name | string | character varying | ✓ | - |
| last_name | string | character varying | ✓ | - |
| phone_number | string | character varying | ✓ | - |
| company | string | character varying | ✓ | - |
| job_title | string | character varying | ✓ | - |
| address | string | character varying | ✓ | - |
| city | string | character varying | ✓ | - |
| province | string | character varying | ✓ | - |
| postal_code | string | character varying | ✓ | - |
| country | string | character varying | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| notes | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 134. `containers`

**Description:** Stores container information and tracking data

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

**Columns:** 38

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| container_number | string | character varying | ✗ | - |
| container_type | string | character varying | ✓ | - |
| container_size | string | character varying | ✓ | - |
| iso_code | string | character varying | ✓ | - |
| tare_weight | number | numeric | ✓ | - |
| max_payload | number | numeric | ✓ | - |
| current_status | string | character varying | ✓ | - |
| current_location | string | character varying | ✓ | - |
| current_latitude | number | numeric | ✓ | - |
| current_longitude | number | numeric | ✓ | - |
| vessel_id | string | uuid | ✓ | Note:
This is a Foreign Key to `vessels.id`.<fk table='vessels' column='id'/> |
| vessel_name | string | character varying | ✓ | - |
| cargo_description | string | text | ✓ | - |
| cargo_weight | number | numeric | ✓ | - |
| cargo_value | number | numeric | ✓ | - |
| cargo_currency | string | character varying | ✓ | - |
| booking_reference | string | character varying | ✓ | - |
| bill_of_lading | string | character varying | ✓ | - |
| shipper_name | string | character varying | ✓ | - |
| consignee_name | string | character varying | ✓ | - |
| notify_party | string | character varying | ✓ | - |
| port_of_loading | string | character varying | ✓ | - |
| port_of_discharge | string | character varying | ✓ | - |
| final_destination | string | character varying | ✓ | - |
| estimated_arrival | string | timestamp with time zone | ✓ | - |
| actual_arrival | string | timestamp with time zone | ✓ | - |
| container_tracking_id | string | character varying | ✓ | - |
| last_tracking_update | string | timestamp with time zone | ✓ | - |
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

### 135. `contractor_evaluation_results`

**Description:** Evaluation results for contractor vetting display

**Scripts Using This Table:** 1

1. `server/src/routes/auto-fill-routes.js`

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
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| vetting_id | integer | integer | ✓ | Reference to vetting record

Note:
This is a Foreign Key to `contractor_vetting.id`.<fk table='contractor_vetting' column='id'/> |
| document_id | integer | integer | ✓ | Reference to specific document

Note:
This is a Foreign Key to `contractor_vetting_documents.id`.<fk table='contractor_vetting_documents' column='id'/> |
| contractor_name | string | character varying | ✓ | Name of the contractor |
| document_type | string | character varying | ✓ | Type of document evaluated |
| document_path | string | text | ✓ | Path to the evaluated document |
| processing_status | string | character varying | ✓ | Status of the evaluation process |
| score | integer | integer | ✓ | Evaluation score (0-100) |
| confidence | integer | integer | ✓ | Confidence level in the evaluation (0-100) |
| commentary | string | text | ✓ | Detailed commentary on the evaluation |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| questions | unknown | jsonb | ✓ | - |
| answers | unknown | jsonb | ✓ | - |
| document_name | string | text | ✓ | - |
| form_submission_data | unknown | jsonb | ✓ | - |

---

### 136. `contractor_evaluations`

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
| contractor_name | string | text | ✗ | - |
| document_name | string | text | ✓ | - |
| evaluation_type | string | text | ✗ | - |
| answers | unknown | jsonb | ✓ | - |
| score | integer | integer | ✓ | - |
| confidence | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 137. `contractor_vetting`

**Description:** Main table for contractor vetting information and status tracking

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
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| contractor_id | integer | integer | ✓ | Reference to the main contractors table |
| company_name | string | character varying | ✗ | - |
| contact_person | string | character varying | ✓ | - |
| phone | string | character varying | ✓ | - |
| email | string | character varying | ✓ | - |
| business_address | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| vetting_status | string | text | ✓ | Current vetting status of the contractor |
| overall_score | integer | integer | ✓ | Overall vetting score (0-100) |
| notes | string | text | ✓ | General notes about the vetting process |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 138. `contractor_vetting_chat_messages`

**Description:** Chat messages for contractor vetting assistance

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
| vetting_id | integer | integer | ✓ | Reference to vetting record

Note:
This is a Foreign Key to `contractor_vetting.id`.<fk table='contractor_vetting' column='id'/> |
| message_type | string | character varying | ✓ | Type of message |
| sender | string | character varying | ✓ | Name of the message sender |
| message_text | string | text | ✗ | Content of the message |
| timestamp | string | timestamp with time zone | ✓ | - |
| session_id | string | character varying | ✓ | Session identifier |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 139. `contractor_vetting_dashboard_stats`

**Description:** Dashboard statistics for contractor vetting

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
| stat_date | string | date | ✓ | Date for which statistics are recorded |
| total_contractors | integer | integer | ✓ | Total number of contractors in system |
| average_score | integer | integer | ✓ | Average vetting score |
| high_scores_count | integer | integer | ✓ | Count of contractors with high scores (85+) |
| pending_reviews_count | integer | integer | ✓ | Count of pending reviews |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 140. `contractor_vetting_document_hashes`

**Description:** Document hashes for deduplication and incremental ingestion per 1300_00220

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
| document_id | string | uuid | ✓ | Reference to main document

Note:
This is a Foreign Key to `a_02400_contractor_vetting_documents.id`.<fk table='a_02400_contractor_vetting_documents' column='id'/> |
| version | string | text | ✗ | Document version for hash uniqueness |
| document_hash | string | text | ✗ | SHA-256 hash of entire document for deduplication |
| content_hash | string | text | ✗ | SHA-256 hash of content for incremental ingestion |
| chunk_id | string | text | ✓ | Chunk identifier for vector store deduplication |
| file_size | integer | bigint | ✓ | - |
| mime_type | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| source_path | string | text | ✓ | Original file path for tracking |
| department_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 141. `contractor_vetting_document_parts`

**Description:** Document parts for discrete additions per 1300_00220

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
| document_id | string | uuid | ✓ | Reference to main document

Note:
This is a Foreign Key to `a_02400_contractor_vetting_documents.id`.<fk table='a_02400_contractor_vetting_documents' column='id'/> |
| part_number | string | text | ✗ | Part identifier |
| part_title | string | text | ✓ | - |
| content_hash | string | text | ✗ | Hash of this specific part |
| part_content | string | text | ✓ | Extracted content for this part |
| start_page | integer | integer | ✓ | - |
| end_page | integer | integer | ✓ | - |
| word_count | integer | integer | ✓ | - |
| character_count | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| version | string | text | ✓ | - |
| parent_part_id | string | uuid | ✓ | Parent part for hierarchical structure

Note:
This is a Foreign Key to `contractor_vetting_document_parts.id`.<fk table='contractor_vetting_document_parts' column='id'/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 142. `contractor_vetting_documents`

**Description:** Uploaded documents for contractor vetting

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
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| vetting_id | integer | integer | ✓ | Reference to the vetting record

Note:
This is a Foreign Key to `contractor_vetting.id`.<fk table='contractor_vetting' column='id'/> |
| section_id | integer | integer | ✓ | Reference to the specific section this document belongs to

Note:
This is a Foreign Key to `contractor_vetting_sections.id`.<fk table='contractor_vetting_sections' column='id'/> |
| file_name | string | character varying | ✗ | Stored file name |
| original_file_name | string | character varying | ✓ | Original uploaded file name |
| file_path | string | text | ✓ | Path to the stored file |
| file_size | integer | bigint | ✓ | File size in bytes |
| mime_type | string | character varying | ✓ | MIME type of the file |
| upload_timestamp | string | timestamp with time zone | ✓ | - |
| document_type | string | character varying | ✓ | Type of document (financial, license, etc.) |
| processing_status | string | text | ✓ | Status of document processing |
| processing_result | string | text | ✓ | Results from document processing |
| extracted_data | unknown | jsonb | ✓ | JSON data extracted from the document |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 143. `contractor_vetting_ingestion_registry`

**Description:** Registry for tracking document ingestion status per 1300_00220

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
| document_hash | string | text | ✗ | Document hash for deduplication |
| content_hash | string | text | ✗ | Content hash for incremental processing |
| ingestion_status | string | text | ✓ | Current ingestion status |
| ingestion_timestamp | string | timestamp with time zone | ✓ | - |
| completion_timestamp | string | timestamp with time zone | ✓ | - |
| error_message | string | text | ✓ | - |
| retry_count | integer | integer | ✓ | - |
| vector_store_id | string | text | ✓ | Reference to vector store record |
| metadata | unknown | jsonb | ✓ | Additional ingestion metadata |
| department_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---


**📝 Generated**: 2026-01-07T04:37:25.062Z
**📊 Tables Documented**: 143
**🏗️ System**: Construct AI Database Schema - Part 1
