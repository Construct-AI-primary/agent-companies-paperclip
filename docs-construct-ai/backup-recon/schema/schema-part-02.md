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

# 📊 Schema Part 2: Tables 144-286 (D-P alphabetically)

**Database schema documentation for Construct AI - Part 2 of 3.**

## 📋 Overview

This document contains detailed schema information for tables 144-286 (alphabetically ordered).

## 📊 Part Statistics

- **Tables in Part**: 143
- **Total Tables**: 445
- **Generated**: 2026-01-07T04:37:25.062Z

## 📖 Table Documentation

### 144. `contractor_vetting_sections`

**Description:** Individual sections of the contractor vetting process

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
| vetting_id | integer | integer | ✓ | Note:
This is a Foreign Key to `contractor_vetting.id`.<fk table='contractor_vetting' column='id'/> |
| section_name | string | character varying | ✗ | Internal section identifier (details, financial, licensing, etc.) |
| section_title | string | character varying | ✗ | Display title for the section |
| status | string | text | ✓ | Status of this section |
| score | integer | integer | ✓ | Score for this section (0-100) |
| analysis_text | string | text | ✓ | AI analysis output for this section |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 145. `contractors`

**Description:** Table to store contractor information for projects

**Scripts Using This Table:** 1

1. `server/src/routes/contractors-routes.js`

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
| name | string | character varying | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| address | string | text | ✓ | Physical address of the contractor. |
| email | string | text | ✓ | Primary contact email address for the contractor. |
| phone | string | text | ✓ | Primary contact phone number for the contractor. |
| contact_person | string | text | ✓ | Name of the primary contact person at the contractor. |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| contractor_type | string | text | ✓ | Type of contractor (e.g., general, electrical, plumbing) |
| construction_type | string | text | ✓ | Type of construction (EPCM, EPC, Construction Only, Design-Build) |
| sector | string | text | ✓ | Industry sector (Mining, Oil & Gas, Power Generation, etc) |
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 146. `contractors_backup_before_uuid_migration`

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
| id | integer | integer | ✓ | - |
| name | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| address | string | text | ✓ | - |
| email | string | text | ✓ | - |
| phone | string | text | ✓ | - |
| contact_person | string | text | ✓ | - |
| project_id | string | uuid | ✓ | - |
| contractor_type | string | text | ✓ | - |
| construction_type | string | text | ✓ | - |
| sector | string | text | ✓ | - |

---

### 147. `contracts`

**Description:** Contracts associated with contractors on projects

**Scripts Using This Table:** 1

1. `server/src/services/hitl-assignment-service.js`

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
| contractor_id | integer | integer | ✓ | - |
| contract_number | string | character varying | ✗ | - |
| contract_type | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| contract_type_id | string | uuid | ✓ | Note:
This is a Foreign Key to `dropdown_options.id`.<fk table='dropdown_options' column='id'/> |
| category | string | text | ✓ | Category associated with the contract, e.g., Contracts information. |
| working_zones | array | text[] | ✓ | Array of working zones or areas applicable to the contract. |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |
| assigned_to | string | character varying | ✓ | - |

---

### 148. `contracts_post_summary`

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
| contract_status | string | character varying | ✓ | - |
| contract_count | integer | bigint | ✓ | - |
| total_value | number | numeric | ✓ | - |
| avg_progress | number | numeric | ✓ | - |
| total_documents | integer | bigint | ✓ | - |
| latest_contract | string | timestamp with time zone | ✓ | - |

---

### 149. `contributor_assignments`

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
| contributor_id | string | uuid | ✓ | Note:
This is a Foreign Key to `contributors.id`.<fk table='contributors' column='id'/> |
| page_id | string | uuid | ✓ | - |
| branch_name | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| assigned_at | string | timestamp without time zone | ✓ | - |
| completed_at | string | timestamp without time zone | ✓ | - |
| modal_configuration_id | string | uuid | ✓ | - |
| github_branch_url | string | text | ✓ | - |
| auto_generated_files | unknown | jsonb | ✓ | - |
| notes | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 150. `contributors`

**Description:** Enhanced contributors table with full GitHub integration

**Scripts Using This Table:** 3

1. `server/src/routes/contributors-routes.js`
2. `server/src/services/githubService.js`
3. `test/debug/check-contributor-table.js`

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
| name | string | text | ✗ | - |
| github_username | string | text | ✓ | - |
| email | string | text | ✓ | - |
| avatar_url | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| bio | string | text | ✓ | - |
| github_id | integer | integer | ✓ | GitHub user ID (unique identifier) |
| github_login | string | text | ✓ | GitHub username/login |
| display_name | string | text | ✓ | Display name (GitHub name or fallback to login) |
| company | string | text | ✓ | Company from GitHub profile |
| location | string | text | ✓ | Location from GitHub profile |
| blog | string | text | ✓ | Blog/website URL from GitHub profile |
| twitter_username | string | text | ✓ | Twitter username from GitHub profile |
| public_repos | integer | integer | ✓ | - |
| public_gists | integer | integer | ✓ | - |
| followers | integer | integer | ✓ | - |
| following | integer | integer | ✓ | - |
| hireable | boolean | boolean | ✓ | Whether user is available for hire |
| github_created_at | string | timestamp with time zone | ✓ | When GitHub account was created |
| github_updated_at | string | timestamp with time zone | ✓ | When GitHub profile was last updated |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 151. `credential_rotation_logs`

**Description:** Audit trail for API credential rotation activities

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

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| api_config_id | string | uuid | ✗ | - |
| rotation_type | string | text | ✗ | - |
| old_key_hash | string | text | ✓ | - |
| new_key_hash | string | text | ✓ | - |
| rotated_by | string | uuid | ✓ | - |
| rotated_at | string | timestamp with time zone | ✗ | - |
| reason | string | text | ✓ | - |
| success | boolean | boolean | ✗ | - |
| error_message | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |

---

### 152. `custom_document_types`

**Scripts Using This Table:** 1

1. `test_expandable_document_types.js`

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
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| discipline_code | string | text | ✗ | - |
| document_type | string | character varying | ✗ | - |
| document_type_code | string | character varying | ✗ | - |
| category | string | character varying | ✓ | - |
| description | string | text | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 153. `customized`

**Description:** App-wide dropdown options shared across multiple modals

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
| dropdown_id | string | character varying | ✗ | - |
| options | string | text | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 154. `cv_analyses`

**Scripts Using This Table:** 1

1. `server/routes/cv-analysis-routes.js`

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
| candidate_name | string | text | ✓ | - |
| position_applied | string | text | ✓ | - |
| experience_level | string | text | ✓ | - |
| years_experience | integer | integer | ✓ | - |
| job_title | string | text | ✓ | - |
| job_department | string | text | ✓ | - |
| overall_rating | number | numeric | ✓ | - |
| analysis_data | unknown | jsonb | ✓ | - |
| ai_model | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 155. `cv_application_stats`

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
| total_applications | integer | bigint | ✓ | - |
| pending_count | integer | bigint | ✓ | - |
| under_review_count | integer | bigint | ✓ | - |
| interview_scheduled_count | integer | bigint | ✓ | - |
| approved_count | integer | bigint | ✓ | - |
| rejected_count | integer | bigint | ✓ | - |
| on_hold_count | integer | bigint | ✓ | - |
| average_rating | number | numeric | ✓ | - |
| applications_this_week | integer | bigint | ✓ | - |
| applications_this_month | integer | bigint | ✓ | - |

---

### 156. `cv_applications`

**Description:** Stores CV/job application data for HR CV Processing system

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

**Columns:** 66

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| applicant_name | string | character varying | ✗ | - |
| email | string | character varying | ✗ | - |
| phone | string | character varying | ✓ | - |
| position_applied | string | character varying | ✗ | - |
| status | string | character varying | ✗ | Application status: pending, under_review, interview_scheduled, approved, rejected, on_hold |
| years_experience | integer | integer | ✓ | - |
| education_level | string | character varying | ✓ | - |
| skills | array | text[] | ✓ | Array of candidate skills and competencies |
| certifications | array | text[] | ✓ | Professional certifications data |
| salary_expectation | number | numeric | ✓ | - |
| currency | string | character varying | ✓ | - |
| availability_date | string | date | ✓ | - |
| employment_type | string | character varying | ✓ | Type of employment: full_time, part_time, contract, freelance, internship |
| location | string | character varying | ✓ | - |
| remote_work_preference | string | character varying | ✓ | Remote work preference: on_site, remote, hybrid |
| cv_file_url | string | text | ✓ | - |
| cover_letter_url | string | text | ✓ | - |
| portfolio_url | string | text | ✓ | - |
| additional_documents_urls | array | text[] | ✓ | - |
| interview_stage | string | character varying | ✓ | - |
| interview_date | string | timestamp with time zone | ✓ | Scheduled interview date |
| interview_notes | string | text | ✓ | - |
| interviewer_id | string | uuid | ✓ | - |
| technical_score | integer | integer | ✓ | - |
| communication_score | integer | integer | ✓ | - |
| culture_fit_score | integer | integer | ✓ | - |
| overall_rating | number | numeric | ✓ | - |
| hr_notes | string | text | ✓ | - |
| feedback | string | text | ✓ | - |
| rejection_reason | string | text | ✓ | - |
| application_source | string | character varying | ✓ | - |
| referral_source | string | character varying | ✓ | - |
| priority_level | string | character varying | ✓ | Priority level for processing: low, normal, high, urgent |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| applied_date | string | date | ✓ | - |
| last_contact_date | string | date | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| additional_info | unknown | jsonb | ✓ | Additional flexible information stored as JSON |
| custom_fields | unknown | jsonb | ✓ | Custom fields for organization-specific data |
| discipline | string | character varying | ✓ | Applicant's discipline or department (formerly department) |
| address | string | text | ✓ | - |
| scoring_details | unknown | jsonb | ✓ | - |
| analysis_type | string | character varying | ✓ | - |
| analysis_timestamp | string | timestamp with time zone | ✓ | - |
| original_notes | string | text | ✓ | - |
| openai_feedback | string | text | ✓ | AI-generated feedback |
| date_of_birth | string | date | ✓ | Candidate date of birth |
| professional_summary | string | text | ✓ | Professional summary from CV |
| work_experience | unknown | jsonb | ✓ | Structured work history data |
| education | unknown | jsonb | ✓ | Education history data |
| projects | unknown | jsonb | ✓ | Key projects from resume |
| extracted_emails | string | text | ✓ | - |
| extracted_phones | string | text | ✓ | - |
| application_date | string | date | ✓ | When the application was submitted |
| linkedin | string | character varying | ✓ | - |
| cv_file | string | character varying | ✓ | - |
| availability | string | character varying | ✓ | Available start date or notice period |
| cover_letter | string | text | ✓ | Cover letter content if provided |
| experience_level | string | character varying | ✓ | Entry, mid, or senior level |
| notes | string | text | ✓ | - |
| rating | number | numeric | ✓ | - |
| opennai_feedback | string | text | ✓ | OpenAI feedback (typo from CV processing code) |

---

### 157. `data_sheet_specifications`

**Scripts Using This Table:** 2

1. `server/src/services/procurementTemplateService.js`
2. `server/src/tests/procurement-templates.test.js`

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
| template_id | string | uuid | ✓ | - |
| spec_type | string | text | ✓ | - |
| spec_code | string | text | ✓ | - |
| spec_name | string | text | ✓ | - |
| specifications | unknown | jsonb | ✓ | - |
| compliance_standards | array | text[] | ✓ | - |
| safety_requirements | array | text[] | ✓ | - |
| supplier_name | string | text | ✓ | - |
| manufacturer | string | text | ✓ | - |
| model_number | string | text | ✓ | - |
| serial_number | string | text | ✓ | - |
| issue_date | string | date | ✓ | - |
| expiry_date | string | date | ✓ | - |
| revision_number | integer | integer | ✓ | - |
| procurement_code | string | text | ✓ | - |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 158. `defects`

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
| defect_id | string | character varying | ✗ | - |
| inspection_item_id | string | character varying | ✗ | Note:
This is a Foreign Key to `inspection_items.item_id`.<fk table='inspection_items' column='item_id'/> |
| defect_type | string | character varying | ✗ | - |
| severity | string | character varying | ✓ | - |
| description | string | text | ✗ | - |
| location | string | character varying | ✓ | - |
| assigned_to | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| priority | string | character varying | ✓ | - |
| due_date | string | date | ✓ | - |
| resolved_date | string | date | ✓ | - |
| resolution_notes | string | text | ✓ | - |
| cost_estimate | number | numeric | ✓ | - |
| media_urls | unknown | jsonb | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| created_by | string | character varying | ✓ | - |
| updated_by | string | character varying | ✓ | - |

---

### 159. `discipline_document_paths`

**Scripts Using This Table:** 1

1. `server/src/routes/discipline-document-paths-routes.js`

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
| organisation_id | string | uuid | ✗ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| discipline_id | string | uuid | ✗ | - |
| document_type_id | string | uuid | ✗ | Note:
This is a Foreign Key to `document_types_by_discipline.id`.<fk table='document_types_by_discipline' column='id'/> |
| path_configuration | unknown | jsonb | ✗ | - |
| path_template | string | character varying | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| is_default | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 160. `discipline_document_sections`

**Description:** Flexible document sections system allowing disciplines to define their own appendix, schedule, and attachment structures

**Scripts Using This Table:** 11

1. `populate-missing-disciplines.js`
2. `run_multi_dimensional_migration.js`
3. `server/src/controllers/procurementController.js`
4. `server/src/routes/discipline-document-sections-routes.js`
5. `server/src/routes/migration-routes.js`
6. `server/src/routes/procurement-sow-templates-routes.js`
7. `tests/fixtures/data/test-data-population.js`
8. `tests/phase3-advanced-testing.js`
9. `tests/phase4-end-to-end-testing.js`
10. `tests/test-data-population-fixed.js`
11. `tests/unit/sow-association-validation.test.js`

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
| discipline_code | string | character varying | ✗ | - |
| organization_id | string | uuid | ✗ | - |
| section_code | string | character varying | ✗ | Unique code within discipline (e.g., appendix_a, schedule_1) |
| section_name | string | character varying | ✗ | - |
| section_type | string | character varying | ✗ | Type of section: appendix, schedule, attachment, exhibit, policy, procedure |
| display_order | integer | integer | ✗ | - |
| required | boolean | boolean | ✓ | - |
| allows_multiple_types | boolean | boolean | ✓ | - |
| available_document_types | unknown | jsonb | ✓ | JSON array of allowed document types for this section |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| contract_type | string | character varying | ✓ | Contract type for filtering: po (procurement orders), wo (work orders), so (service orders), general (general sections) |
| default_document_type | string | character varying | ✓ | - |
| parent_template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `discipline_document_sections.id`.<fk table='discipline_document_sections' column='id'/> |

---

### 161. `discipline_evaluation_weights`

**Scripts Using This Table:** 1

1. `server/src/services/ExternalPartyEvaluationService.js`

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
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| evaluation_context | string | character varying | ✗ | - |
| discipline_code | string | character varying | ✗ | - |
| discipline_name | string | character varying | ✗ | - |
| weight_percentage | number | numeric | ✗ | - |
| scoring_criteria | unknown | jsonb | ✓ | - |
| max_score | integer | integer | ✓ | - |
| passing_score | integer | integer | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| updated_at | string | timestamp with time zone | ✓ | - |
| updated_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |

---

### 162. `discipline_template_config`

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
| discipline | string | character varying | ✗ | Note:
This is a Primary Key.<pk/> |
| allowed_template_types | array | text[] | ✗ | - |
| requires_approval | boolean | boolean | ✓ | - |
| max_templates_per_user | integer | integer | ✓ | - |
| description | string | text | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 163. `discipline_template_constraints`

**Scripts Using This Table:** 3

1. `server/create_discipline_template_constraints_table.js`
2. `server/schema/constraints/template-constraints-config.js`
3. `server/src/routes/template-constraints-routes.js`

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
| discipline_name | string | text | ✗ | - |
| table_name | string | text | ✗ | - |
| allowed_template_types | array | text[] | ✓ | - |
| description | string | text | ✓ | - |
| is_active | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 164. `disciplines`

**Scripts Using This Table:** 42

1. `analyze_discipline_inconsistency.js`
2. `check_database_templates.js`
3. `check_existing_users.js`
4. `check_templates_debug.js`
5. `debug_ai_modal.js`
6. `debug_discipline_uuids.js`
7. `diagnose_form_insert.js`
8. `dynamic_discipline_mapping.js`
9. `execute_uuid_fix_direct.js`
10. `execute_uuid_fix_final.js`
11. `execute_uuid_fix_sql.js`
12. `execute_uuid_fix_supabase.js`
13. `execute_uuid_fix_ultimate.js`
14. `execute_uuid_fix_workaround.js`
15. `fix_all_procurement_uuids.js`
16. `fix_procurement_final.js`
17. `isolate_specific_error.js`
18. `recreate_discipline.js`
19. `run_index_fix.js`
20. `server/api/document-types.js`
21. `server/seed_epcm_disciplines.js`
22. `server/src/controllers/procurementController.js`
23. `server/src/routes/disciplines-routes.js`
24. `server/src/routes/unified-templates-routes.js`
25. `server/src/routes/user-discipline-routes.js`
26. `server/src/routes/users-routes.js`
27. `server/src/services/ProjectTemplatePreparationService.js`
28. `server/src/services/TechnicalDisciplineService.js`
29. `server/src/services/TemplateVariationService.js`
30. `simple_template_populate.js`
31. `test/debug/debug_discipline_uuids.js`
32. `test_case_insensitive_fix.js`
33. `tests/fixtures/data/test-data-population.js`
34. `tests/phase3-advanced-testing.js`
35. `tests/phase3-fixed-tests.js`
36. `tests/phase4-end-to-end-testing.js`
37. `tests/test-data-population-fixed.js`
38. `tests/test-data-rls-compliant.js`
39. `tests/test-data-working.js`
40. `tests/unit/user-assignment-logic.test.js`
41. `update_user_management_departments.js`
42. `verify_uuid_fix.js`

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
| page_id | string | uuid | ✗ | - |
| name | string | text | ✗ | - |
| code | string | text | ✗ | - |
| slug | string | text | ✓ | - |
| organization_id | string | uuid | ✗ | - |
| organization_name | string | text | ✓ | - |
| sector_id | string | uuid | ✓ | - |
| sector_name | string | text | ✓ | - |
| parent_discipline_id | string | uuid | ✓ | - |
| hierarchy_level | integer | integer | ✓ | - |
| display_order | integer | integer | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| is_standard_link | boolean | boolean | ✓ | - |
| is_virtual | boolean | boolean | ✓ | - |
| organization_ids | array | uuid[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| updated_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |

---

### 165. `document_access_logs`

**Scripts Using This Table:** 1

1. `server/src/routes/document-management-routes.js`

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
| document_id | string | uuid | ✗ | - |
| user_id | string | text | ✓ | - |
| tender_id | string | uuid | ✗ | - |
| access_type | string | character varying | ✗ | - |
| accessed_at | string | timestamp without time zone | ✓ | - |

---

### 166. `document_ai_analysis`

**Description:** Stores AI analysis results for uploaded documents including confidence scores and human corrections

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
| document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `a_00900_doccontrol_documents.id`.<fk table='a_00900_doccontrol_documents' column='id'/> |
| analysis_results | unknown | jsonb | ✗ | JSON containing AI extracted metadata, document type, entities, etc. |
| confidence_scores | unknown | jsonb | ✗ | JSON containing confidence scores for each AI prediction |
| human_corrections | unknown | jsonb | ✓ | JSON containing any manual corrections made by users |
| processing_status | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 167. `document_analysis_feedback`

**Description:** Tracks AI learning from user corrections and feedback

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
| user_id | string | uuid | ✗ | - |
| original_analysis | unknown | jsonb | ✓ | - |
| user_correction | unknown | jsonb | ✓ | - |
| document_content | string | text | ✓ | - |
| feedback_type | string | text | ✓ | - |
| confidence_score | number | numeric | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 168. `document_analysis_prompts`

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
| prompt_type | string | character varying | ✗ | - |
| document_type | string | character varying | ✗ | - |
| discipline_id | string | character varying | ✓ | - |
| prompt_text | string | text | ✗ | - |
| model_parameters | unknown | jsonb | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 169. `document_categories`

**Scripts Using This Table:** 3

1. `gather_database_info.js`
2. `run-migration-direct.js`
3. `server/src/routes/document-management-routes.js`

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
| category_code | string | character varying | ✗ | - |
| category_name | string | text | ✗ | - |
| description | string | text | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 170. `document_comparisons`

**Description:** Table for storing document comparison results

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
| id | string | uuid | ✗ | Unique identifier for each comparison

Note:
This is a Primary Key.<pk/> |
| document_ids | array | uuid[] | ✗ | Array of document IDs that were compared |
| mode | string | text | ✗ | Comparison mode: pairwise or consolidated |
| result | unknown | jsonb | ✓ | JSON result of the comparison |
| created_at | string | timestamp with time zone | ✓ | Timestamp when comparison was created |
| created_by | string | uuid | ✓ | User ID who created the comparison |
| options | unknown | jsonb | ✓ | Options used for the comparison |

---

### 171. `document_download_queue`

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

**Columns:** 23

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| tender_id | string | uuid | ✗ | - |
| document_url | string | text | ✗ | - |
| document_type | string | character varying | ✗ | - |
| source_name | string | character varying | ✓ | - |
| priority | integer | integer | ✓ | - |
| status | string | character varying | ✓ | - |
| queue_order | integer | integer | ✓ | - |
| download_options | unknown | jsonb | ✓ | - |
| expected_file_size | integer | integer | ✓ | - |
| retry_count | integer | integer | ✓ | - |
| max_retries | integer | integer | ✓ | - |
| error_message | string | text | ✓ | - |
| started_at | string | timestamp without time zone | ✓ | - |
| scheduled_at | string | timestamp without time zone | ✓ | - |
| completed_at | string | timestamp without time zone | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| created_by | string | text | ✓ | - |
| user_ip | string | text | ✓ | - |
| user_agent | string | text | ✓ | - |
| document_name | string | text | ✓ | - |
| source | string | character varying | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 172. `document_embeddings`

**Description:** Direct embeddings storage bypassing Flowise document store system

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
| content | string | text | ✗ | - |
| embedding | string | extensions.vector(1536) | ✓ | Vector embedding (1536 dimensions for OpenAI text-embedding-ada-002) |
| metadata | unknown | jsonb | ✓ | JSON metadata including pagePrefix, discipline, security level, etc. |
| source | string | text | ✓ | - |
| page | integer | integer | ✓ | - |
| section | string | text | ✓ | - |
| chunk_id | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| document_store_id | string | uuid | ✓ | UUID reference to document_stores table for department routing

Note:
This is a Foreign Key to `document_stores.id`.<fk table='document_stores' column='id'/> |
| discipline_code | string | text | ✓ | Page prefix/discipline code for department-specific routing |
| flowise_store_id | string | text | ✓ | Flowise store ID for integration when available |

---

### 173. `document_hashes`

**Description:** Table for storing document content hashes to prevent duplication during ingestion

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
| id | string | uuid | ✗ | Unique identifier for each hash record

Note:
This is a Primary Key.<pk/> |
| doc_id | string | uuid | ✗ | Reference to the document this hash belongs to |
| version | string | text | ✗ | Version of the document (semver-like format) |
| hash | string | text | ✗ | SHA-256 hash of document content |
| chunk_id | string | text | ✓ | Identifier for document chunk (if applicable) |
| timestamp | string | timestamp with time zone | ✓ | Timestamp when hash was created |
| source_path | string | text | ✓ | Original path of the document source |
| department_id | string | uuid | ✓ | Department associated with this document |

---

### 174. `document_hierarchy_definitions`

**Description:** Defines hierarchical structures for different document types (Part/Section/Clause/etc.)

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
| discipline_id | string | text | ✗ | - |
| document_type | string | text | ✗ | - |
| hierarchy_levels | unknown | jsonb | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 175. `document_number_audit_log`

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
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| discipline_code | string | text | ✗ | - |
| document_type | string | text | ✗ | - |
| organization_id | string | text | ✗ | - |
| company_id | integer | integer | ✗ | - |
| generated_number | string | text | ✗ | - |
| sequence_number | integer | integer | ✗ | - |
| context | unknown | jsonb | ✓ | - |
| generated_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 176. `document_number_sequences`

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
| discipline_code | string | character varying | ✗ | Note:
This is a Primary Key.<pk/> |
| document_type | string | character varying | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| current_value | integer | integer | ✗ | - |

---

### 177. `document_numbering_methodologies`

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

**Columns:** 12

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | string | character varying | ✗ | - |
| company_id | integer | integer | ✓ | - |
| methodology_name | string | character varying | ✗ | - |
| methodology_description | string | text | ✓ | - |
| default_pattern | string | text | ✗ | - |
| pattern_variables | unknown | jsonb | ✓ | - |
| is_default | boolean | boolean | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |

---

### 178. `document_numbering_sequences`

**Scripts Using This Table:** 4

1. `server/api/document-numbering/generate.js`
2. `server/api/document-numbering/preview.js`
3. `server/routes/document-numbering-routes.js`
4. `test/debug/integration/test-document-numbering-system.js`

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
| document_type_id | string | uuid | ✓ | Note:
This is a Foreign Key to `document_types_by_discipline.id`.<fk table='document_types_by_discipline' column='id'/> |
| sequence_key | string | character varying | ✗ | - |
| current_number | integer | integer | ✓ | - |
| last_generated_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 179. `document_processing_history`

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

**Columns:** 11

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| tender_id | string | uuid | ✗ | - |
| document_id | string | uuid | ✓ | - |
| document_url | string | text | ✗ | - |
| operation_type | string | character varying | ✗ | - |
| status | string | character varying | ✗ | - |
| error_message | string | text | ✓ | - |
| processing_time_ms | integer | integer | ✓ | - |
| file_size_processed | integer | integer | ✓ | - |
| metadata_collected | unknown | jsonb | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |

---

### 180. `document_processing_log`

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
| instance_id | string | uuid | ✓ | Note:
This is a Foreign Key to `form_instances.id`.<fk table='form_instances' column='id'/> |
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `governance_document_templates.id`.<fk table='governance_document_templates' column='id'/> |
| file_name | string | text | ✗ | - |
| file_type | string | text | ✓ | - |
| organization_name | string | text | ✓ | - |
| discipline_name | string | text | ✓ | - |
| processing_type | string | text | ✗ | - |
| processing_status | string | text | ✗ | - |
| processing_message | string | text | ✓ | - |
| processing_details | unknown | jsonb | ✓ | - |
| processing_time_ms | integer | integer | ✓ | - |
| file_size | integer | integer | ✓ | - |
| extracted_fields_count | integer | integer | ✓ | - |
| error_details | unknown | jsonb | ✓ | - |
| stack_trace | string | text | ✓ | - |
| user_agent | string | text | ✓ | - |
| user_ip | string | text | ✓ | - |
| created_by | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 181. `document_processing_queue`

**Description:** Queue for tracking document processing status and progress

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
| file_id | string | text | ✗ | Unique identifier for the file being processed (before document creation) |
| document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `a_00900_doccontrol_documents.id`.<fk table='a_00900_doccontrol_documents' column='id'/> |
| status | string | text | ✓ | - |
| progress | integer | integer | ✓ | Processing progress percentage (0-100) |
| metadata | unknown | jsonb | ✓ | - |
| ai_analysis | unknown | jsonb | ✓ | Temporary storage for AI analysis results during processing |
| error_message | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| processed_at | string | timestamp with time zone | ✓ | - |

---

### 182. `document_references`

**Scripts Using This Table:** 2

1. `server/src/routes/document-references-routes.js`
2. `update_document_references.js`

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
| identifier | string | text | ✗ | - |
| document_type_id | string | uuid | ✗ | - |
| title | string | text | ✗ | - |
| file_path | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| vector_doc_ids | array | text[] | ✓ | - |
| organization_id | string | uuid | ✗ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 183. `document_routing_history`

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
| workflow_id | integer | bigint | ✓ | Note:
This is a Foreign Key to `document_routing_workflows.id`.<fk table='document_routing_workflows' column='id'/> |
| document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `a_00900_doccontrol_documents.id`.<fk table='a_00900_doccontrol_documents' column='id'/> |
| version_id | integer | bigint | ✓ | Note:
This is a Foreign Key to `a_00900_doccontrol_document_versions.id`.<fk table='a_00900_doccontrol_document_versions' column='id'/> |
| action_type | string | character varying | ✗ | - |
| action_description | string | text | ✓ | - |
| actor_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| actor_role | string | character varying | ✓ | - |
| old_status | string | character varying | ✓ | - |
| new_status | string | character varying | ✓ | - |
| step_name | string | character varying | ✓ | - |
| action_metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 184. `document_routing_templates`

**Scripts Using This Table:** 3

1. `server/scripts/check-database-tables.js`
2. `server/src/controllers/enhanced-routing-controller.js`
3. `server/src/routes/enhanced-routing-routes.js`

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
| template_name | string | character varying | ✗ | - |
| template_description | string | text | ✓ | - |
| document_type | string | character varying | ✓ | - |
| organization_id | integer | bigint | ✓ | - |
| creator_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| is_active | boolean | boolean | ✓ | - |
| is_default | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 185. `document_routing_workflows`

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
| id | integer | bigint | ✗ | Note:
This is a Primary Key.<pk/> |
| document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `a_00900_doccontrol_documents.id`.<fk table='a_00900_doccontrol_documents' column='id'/> |
| version_id | integer | bigint | ✓ | Note:
This is a Foreign Key to `a_00900_doccontrol_document_versions.id`.<fk table='a_00900_doccontrol_document_versions' column='id'/> |
| template_id | integer | bigint | ✓ | Note:
This is a Foreign Key to `document_routing_templates.id`.<fk table='document_routing_templates' column='id'/> |
| workflow_name | string | character varying | ✓ | - |
| workflow_status | string | character varying | ✓ | - |
| current_step_order | integer | integer | ✓ | - |
| initiated_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| deadline | string | timestamp with time zone | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 186. `document_sections`

**Description:** Stores detailed section content within hierarchical document structures

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
| structure_id | string | uuid | ✗ | Note:
This is a Foreign Key to `template_document_structures.id`.<fk table='template_document_structures' column='id'/> |
| section_path | string | text | ✗ | - |
| level_name | string | text | ✗ | - |
| level_number | string | text | ✗ | - |
| title | string | text | ✓ | - |
| content | unknown | jsonb | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| parent_section_id | string | uuid | ✓ | Note:
This is a Foreign Key to `document_sections.id`.<fk table='document_sections' column='id'/> |
| sort_order | integer | integer | ✓ | - |
| is_required | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 187. `document_stores`

**Description:** Logical grouping for documents to be managed and upserted via Flowise

**Scripts Using This Table:** 19

1. `create-flowise-store-sync.js`
2. `extract_and_upload_docs.js`
3. `gather_database_info.js`
4. `run-migration-direct.js`
5. `scripts/create-missing-document-stores.js`
6. `scripts/enhance-document-store-names.js`
7. `scripts/get-all-document-stores.js`
8. `scripts/insert-sample-documents.js`
9. `scripts/query-local-documents.js`
10. `scripts/sync-all-flowise-document-stores.js`
11. `scripts/sync-flowise-documents.js`
12. `server/routes/document-routes.js`
13. `server/services/flowiseService.js`
14. `server/src/controllers/document-management-controller.js`
15. `server/src/middlewares/validateDiscipline.js`
16. `server/src/routes/document-routes.js`
17. `server/src/routes/flowise-documents-routes.js`
18. `sync_flowise_stores.js`
19. `test/debug/check-database-schema.js`

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
| name | string | text | ✗ | Unique name for the document store |
| description | string | text | ✓ | Human-readable description of the store purpose |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| metadata | unknown | jsonb | ✓ | Additional configuration and metadata for the store |
| is_active | boolean | boolean | ✓ | Whether this store is currently active for new documents |
| flowise_id | string | character varying | ✓ | - |
| discipline_code | string | character varying | ✓ | - |
| security_level | string | character varying | ✓ | - |
| access_roles | unknown | jsonb | ✓ | - |
| store_type | string | character varying | ✓ | - |
| doc_id | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 188. `document_type_relationships`

**Description:** Defines relationships between document types (e.g., scope_of_work can be part of purchase_order)

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
| child_type | string | text | ✗ | - |
| parent_type | string | text | ✗ | - |
| relationship_type | string | text | ✗ | - |
| is_common | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 189. `document_types`

**Scripts Using This Table:** 3

1. `server/src/routes/document-references-routes.js`
2. `test/debug/integration/test-db-functions.js`
3. `test/debug/test-document-numbering.js`

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
| name | string | text | ✗ | - |
| code | string | text | ✗ | - |
| discipline_code | string | text | ✗ | - |
| category | string | text | ✗ | - |
| description | string | text | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 190. `document_types_by_discipline`

**Scripts Using This Table:** 13

1. `analyze_discipline_inconsistency.js`
2. `server/api/document-numbering/generate.js`
3. `server/api/document-numbering/preview.js`
4. `server/api/document-numbering/types.js`
5. `server/api/document-types.js`
6. `server/routes/document-numbering-routes.js`
7. `server/scripts/insert_procurement_document_types.js`
8. `server/src/controllers/documentStructureExtractionController.js`
9. `server/src/routes/unified-templates-routes.js`
10. `server/src/services/document-processing/DocumentStructureExtractionService.js`
11. `test/debug/integration/test-document-numbering-system.js`
12. `test/debug/scripts/test_procurement_document_extraction.js`
13. `test_expandable_document_types.js`

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
| discipline_code | string | character varying | ✗ | - |
| discipline_name | string | character varying | ✗ | - |
| document_type | string | character varying | ✗ | - |
| document_type_code | string | character varying | ✗ | - |
| numbering_pattern | string | text | ✗ | - |
| numbering_explanation | string | text | ✗ | - |
| organization_id | string | character varying | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| auto_increment_start | integer | integer | ✓ | - |
| auto_increment_current | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| company_id | string | uuid | ✓ | Note:
This is a Foreign Key to `companies.id`.<fk table='companies' column='id'/> |
| supported_file_types | array | text[] | ✓ | Array of allowed file extensions for this document type (e.g., ["pdf", "docx"]) |
| template_categories | array | text[] | ✓ | Array of available template categories for this discipline (e.g., ["scope_of_work", "method_statement"]) |
| notification_templates | unknown | jsonb | ✓ | JSON configuration for email/SMS notification templates used in workflows |
| workflow_rules | unknown | jsonb | ✓ | JSON configuration for assignment and approval workflows (auto-evaluation, clarification requirements, etc.) |
| ui_labels | unknown | jsonb | ✓ | JSON configuration for user interface help text and labels |
| validation_rules | unknown | jsonb | ✓ | JSON configuration for file validation rules (max size, required fields, etc.) |

---

### 191. `document_variation_sections`

**Scripts Using This Table:** 3

1. `create-template-variations.js`
2. `docs/implementation/test-data/procurement/populate-document-variation-sections.js`
3. `server/src/routes/document-variations-routes.js`

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
| variation_id | string | uuid | ✗ | Note:
This is a Foreign Key to `document_variations.id`.<fk table='document_variations' column='id'/> |
| section_code | string | character varying | ✗ | - |
| section_name | string | character varying | ✗ | - |
| section_type | string | character varying | ✗ | - |
| display_order | integer | integer | ✗ | - |
| required | boolean | boolean | ✓ | - |
| organization_id | string | uuid | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 192. `document_variations`

**Scripts Using This Table:** 5

1. `create-template-variations.js`
2. `docs/implementation/test-data/procurement/populate-document-variations.js`
3. `server/src/controllers/procurementController.js`
4. `server/src/routes/document-variations-routes.js`
5. `server/src/routes/template-types-routes.js`

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
| discipline_code | string | character varying | ✗ | - |
| contract_type | string | character varying | ✓ | - |
| template_variation | string | character varying | ✓ | - |
| organization_id | string | uuid | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 193. `document_versions`

**Description:** Tracks all versions of documents for version control system

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
| document_id | string | uuid | ✗ | Reference to the parent document

Note:
This is a Foreign Key to `a_00900_doccontrol_documents.id`.<fk table='a_00900_doccontrol_documents' column='id'/> |
| version_number | string | text | ✗ | Semantic version number (e.g., 1.0.0, 1.2.3) |
| previous_version_id | string | uuid | ✓ | Reference to the previous version for rollback/compare

Note:
This is a Foreign Key to `document_versions.id`.<fk table='document_versions' column='id'/> |
| author_id | string | uuid | ✓ | User who created this version

Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| author_name | string | text | ✓ | Name of the author (cached for display) |
| version_notes | string | text | ✓ | Mandatory notes explaining changes in this version |
| change_summary | string | text | ✓ | Auto-generated or user-provided summary of changes |
| status | string | text | ✓ | Version status: draft, review, approved, archived, superseded |
| file_path | string | text | ✓ | Storage path for this version of the document |
| file_hash | string | text | ✓ | Content hash for integrity verification |
| file_size | integer | bigint | ✓ | Size of the document file in bytes |
| content_type | string | text | ✓ | MIME type of the document |
| metadata | unknown | jsonb | ✓ | Additional version-specific metadata |
| created_at | string | timestamp with time zone | ✓ | Timestamp when this version was created |
| updated_at | string | timestamp with time zone | ✓ | Timestamp when this version was last updated |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 194. `dropdown_options`

**Description:** Modal-specific dropdown options

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
| modal_id | string | character varying | ✗ | - |
| type | string | character varying | ✗ | - |
| value | string | text | ✗ | - |
| company_id | integer | integer | ✓ | - |
| contractor_id | integer | integer | ✓ | - |
| field_label | string | character varying | ✓ | - |
| project | string | character varying | ✓ | - |
| modal_name | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| type_contract | string | character varying | ✓ | - |
| language | string | character varying | ✓ | - |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |

---

### 195. `email_access_logs`

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
| email_send_id | string | uuid | ✗ | Note:
This is a Foreign Key to `email_sends.id`.<fk table='email_sends' column='id'/> |
| doc_id | string | text | ✗ | - |
| actor_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| accessed_at | string | timestamp with time zone | ✗ | - |
| ip | string | text | ✓ | - |
| user_agent | string | text | ✓ | - |

---

### 196. `email_ai_processing_queue`

**Description:** Queue for AI processing tasks on emails with user and organization-based access control

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
| email_id | string | uuid | ✗ | Note:
This is a Foreign Key to `emails.id`.<fk table='emails' column='id'/> |
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| processing_type | string | character varying | ✗ | - |
| priority | integer | integer | ✓ | - |
| status | string | character varying | ✓ | - |
| result | unknown | jsonb | ✓ | - |
| confidence_score | number | numeric | ✓ | - |
| attempts | integer | integer | ✓ | - |
| max_attempts | integer | integer | ✓ | - |
| started_at | string | timestamp with time zone | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| error_message | string | text | ✓ | - |
| last_error_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | Organization context for email processing (for shared access)

Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 197. `email_attachments`

**Description:** Stores email attachment metadata and references to Supabase storage

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
| email_id | string | uuid | ✗ | Note:
This is a Foreign Key to `emails.id`.<fk table='emails' column='id'/> |
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| filename | string | character varying | ✗ | - |
| content_type | string | character varying | ✓ | - |
| file_size | integer | bigint | ✓ | - |
| attachment_id | string | character varying | ✓ | - |
| storage_path | string | text | ✓ | - |
| storage_bucket | string | character varying | ✓ | - |
| is_inline | boolean | boolean | ✓ | - |
| content_id | string | character varying | ✓ | - |
| is_safe | boolean | boolean | ✓ | - |
| virus_scan_result | string | character varying | ✓ | - |
| virus_scan_at | string | timestamp with time zone | ✓ | - |
| download_count | integer | integer | ✓ | - |
| last_downloaded_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 198. `email_content_storage`

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
| email_id | string | uuid | ✗ | Note:
This is a Foreign Key to `emails.id`.<fk table='emails' column='id'/> |
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| content_type | string | character varying | ✗ | - |
| original_size | integer | bigint | ✗ | - |
| compressed_size | integer | bigint | ✓ | - |
| compression_type | string | character varying | ✓ | - |
| storage_bucket | string | character varying | ✗ | - |
| storage_path | string | text | ✗ | - |
| encoding | string | character varying | ✓ | - |
| language | string | character varying | ✓ | - |
| access_count | integer | integer | ✓ | - |
| last_accessed_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 199. `email_drafts`

**Description:** Draft emails that haven't been sent yet

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
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| account_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_email_accounts.id`.<fk table='user_email_accounts' column='id'/> |
| to_emails | array | text[] | ✗ | - |
| cc_emails | array | text[] | ✓ | - |
| bcc_emails | array | text[] | ✓ | - |
| subject | string | text | ✗ | - |
| body_text | string | text | ✓ | - |
| body_html | string | text | ✓ | - |
| is_reply | boolean | boolean | ✓ | - |
| is_forward | boolean | boolean | ✓ | - |
| original_email_id | string | uuid | ✓ | Note:
This is a Foreign Key to `emails.id`.<fk table='emails' column='id'/> |
| priority | string | character varying | ✓ | - |
| scheduled_send_at | string | timestamp with time zone | ✓ | - |
| is_scheduled | boolean | boolean | ✓ | - |
| auto_saved_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 200. `email_notification_queue`

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
| approval_instance_id | string | uuid | ✓ | Note:
This is a Foreign Key to `governance_approval_instances.id`.<fk table='governance_approval_instances' column='id'/> |
| user_id | string | text | ✓ | - |
| email_type | string | text | ✗ | - |
| email_subject | string | text | ✓ | - |
| email_body | string | text | ✓ | - |
| send_after | string | timestamp with time zone | ✓ | - |
| sent_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 201. `email_providers`

**Description:** Supported email providers (Gmail, Outlook, IMAP, etc.)

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
| display_name | string | character varying | ✗ | - |
| provider_type | string | character varying | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| configuration | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 202. `email_search_history`

**Description:** User search history for analytics and quick access

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
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| search_query | string | text | ✗ | - |
| search_type | string | character varying | ✓ | - |
| search_filters | unknown | jsonb | ✓ | - |
| results_count | integer | integer | ✓ | - |
| execution_time_ms | integer | integer | ✓ | - |
| ai_interpretation | string | text | ✓ | - |
| ai_confidence | number | numeric | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 203. `email_send_attachments`

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
| email_send_id | string | uuid | ✗ | Note:
This is a Foreign Key to `email_sends.id`.<fk table='email_sends' column='id'/> |
| doc_id | string | text | ✗ | - |
| version_id | string | text | ✓ | - |
| file_key | string | text | ✓ | - |
| delivery_mode | string | text | ✗ | - |
| signed_url | string | text | ✓ | - |
| expires_at | string | timestamp with time zone | ✓ | - |
| size_bytes | integer | bigint | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |

---

### 204. `email_sends`

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
| actor_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| recipients_json | unknown | jsonb | ✗ | - |
| lists_json | unknown | jsonb | ✗ | - |
| template_id | string | text | ✓ | - |
| subject | string | text | ✗ | - |
| mode | string | text | ✗ | - |
| sent_at | string | timestamp with time zone | ✓ | - |
| provider_message_id | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |

---

### 205. `email_signatures`

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
| user_id | string | uuid | ✗ | - |
| content | string | text | ✗ | - |
| is_default | boolean | boolean | ✓ | - |
| type | string | text | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 206. `email_sync_log`

**Description:** Logs of email synchronization operations

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
| account_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_email_accounts.id`.<fk table='user_email_accounts' column='id'/> |
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| sync_type | string | character varying | ✗ | - |
| sync_status | string | character varying | ✗ | - |
| emails_fetched | integer | integer | ✓ | - |
| emails_processed | integer | integer | ✓ | - |
| emails_failed | integer | integer | ✓ | - |
| new_emails | integer | integer | ✓ | - |
| updated_emails | integer | integer | ✓ | - |
| started_at | string | timestamp with time zone | ✗ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| duration_seconds | integer | integer | ✓ | - |
| error_message | string | text | ✓ | - |
| error_details | unknown | jsonb | ✓ | - |
| provider_response | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 207. `email_templates`

**Description:** Email templates for quick composition

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
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| name | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| category | string | character varying | ✓ | - |
| subject_template | string | text | ✓ | - |
| body_template | string | text | ✓ | - |
| variables | unknown | jsonb | ✓ | - |
| usage_count | integer | integer | ✓ | - |
| last_used_at | string | timestamp with time zone | ✓ | - |
| is_public | boolean | boolean | ✓ | - |
| is_system_template | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 208. `email_threads`

**Description:** Groups related emails into conversation threads

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
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| thread_id | string | character varying | ✗ | - |
| subject | string | text | ✗ | - |
| participants | array | text[] | ✓ | - |
| message_count | integer | integer | ✓ | - |
| unread_count | integer | integer | ✓ | - |
| has_attachments | boolean | boolean | ✓ | - |
| priority | string | character varying | ✓ | - |
| labels | array | text[] | ✓ | - |
| last_activity_at | string | timestamp with time zone | ✓ | - |
| is_archived | boolean | boolean | ✓ | - |
| is_deleted | boolean | boolean | ✓ | - |
| ai_summary | string | text | ✓ | - |
| ai_sentiment | string | character varying | ✓ | - |
| ai_priority_score | number | numeric | ✓ | - |
| ai_action_items | array | text[] | ✓ | - |
| ai_processed_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 209. `email_vector`

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
| embedding | string | extensions.vector | ✗ | - |
| metadata | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |

---

### 210. `emails`

**Description:** Main table storing all email messages with full content and metadata

**Scripts Using This Table:** 1

1. `server/services/langchainProcessingService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 44

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| account_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_email_accounts.id`.<fk table='user_email_accounts' column='id'/> |
| thread_id | string | uuid | ✓ | Note:
This is a Foreign Key to `email_threads.id`.<fk table='email_threads' column='id'/> |
| message_id | string | character varying | ✓ | - |
| provider_thread_id | string | uuid | ✓ | - |
| subject | string | text | ✗ | - |
| sender_email | string | character varying | ✗ | - |
| sender_name | string | character varying | ✓ | - |
| recipient_email | string | character varying | ✗ | - |
| recipient_name | string | character varying | ✓ | - |
| cc_emails | array | text[] | ✓ | - |
| bcc_emails | array | text[] | ✓ | - |
| reply_to_email | string | character varying | ✓ | - |
| body_text | string | text | ✓ | - |
| body_html | string | text | ✓ | - |
| snippet | string | text | ✓ | - |
| sent_date | string | timestamp with time zone | ✗ | - |
| received_date | string | timestamp with time zone | ✓ | - |
| is_read | boolean | boolean | ✓ | - |
| is_flagged | boolean | boolean | ✓ | - |
| is_important | boolean | boolean | ✓ | - |
| is_draft | boolean | boolean | ✓ | - |
| is_sent | boolean | boolean | ✓ | - |
| is_archived | boolean | boolean | ✓ | - |
| is_deleted | boolean | boolean | ✓ | - |
| is_spam | boolean | boolean | ✓ | - |
| has_attachments | boolean | boolean | ✓ | - |
| attachment_count | integer | integer | ✓ | - |
| priority | string | character varying | ✓ | - |
| labels | array | text[] | ✓ | - |
| ai_summary | string | text | ✓ | - |
| ai_sentiment | string | character varying | ✓ | - |
| ai_priority_score | number | numeric | ✓ | - |
| ai_action_items | array | text[] | ✓ | - |
| ai_entities | unknown | jsonb | ✓ | - |
| ai_processed_at | string | timestamp with time zone | ✓ | - |
| provider_data | unknown | jsonb | ✓ | - |
| search_vector | string | tsvector | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| sender_email_normalized | string | public.citext | ✓ | - |
| recipient_email_normalized | string | public.citext | ✓ | - |
| resolution_debug | unknown | jsonb | ✓ | - |

---

### 211. `equipment_documentation`

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
| equipment_id | string | uuid | ✗ | Note:
This is a Foreign Key to `operations_equipment.id`.<fk table='operations_equipment' column='id'/> |
| storage_service | string | public.storage_service_type | ✗ | - |
| storage_url | string | text | ✗ | - |
| document_id | string | character varying | ✗ | - |
| sections | unknown | jsonb | ✗ | - |
| compliance_standards | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 212. `error_implementations`

**Scripts Using This Table:** 1

1. `server/src/services/analyticsService.js`

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
| error_tracking_id | string | uuid | ✗ | Note:
This is a Foreign Key to `error_trackings.id`.<fk table='error_trackings' column='id'/> |
| implementation_type | string | character varying | ✗ | - |
| status | string | character varying | ✗ | - |
| priority | string | character varying | ✓ | - |
| code_example | string | text | ✓ | - |
| technical_notes | string | text | ✓ | - |
| developer_assigned | string | character varying | ✓ | - |
| qa_validation_status | string | character varying | ✓ | - |
| deployment_status | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 213. `error_metrics`

**Scripts Using This Table:** 1

1. `server/src/services/analyticsService.js`

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
| error_tracking_id | string | uuid | ✗ | Note:
This is a Foreign Key to `error_trackings.id`.<fk table='error_trackings' column='id'/> |
| metric_type | string | character varying | ✗ | - |
| value | number | numeric | ✗ | - |
| unit | string | character varying | ✓ | - |
| measured_at | string | timestamp with time zone | ✓ | - |
| measurement_context | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 214. `error_trackings`

**Scripts Using This Table:** 3

1. `server/src/routes/error-tracking-routes.js`
2. `server/src/services/analyticsService.js`
3. `server/src/services/errorProcessorService.js`

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
| error_id | string | character varying | ✗ | - |
| title | string | character varying | ✗ | - |
| category | string | character varying | ✗ | - |
| severity | string | character varying | ✗ | - |
| status | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| root_cause | string | text | ✓ | - |
| solution | string | text | ✓ | - |
| impact_assessment | string | text | ✓ | - |
| error_pattern | string | character varying | ✓ | - |
| affected_system | string | character varying | ✓ | - |
| resolution_timestamp | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| resolved_at | string | timestamp with time zone | ✓ | - |
| fingerprint | string | text | ✓ | Hash of error signature for deduplication and similarity detection |
| batch_id | string | uuid | ✓ | Groups related errors that occurred in the same batch/request |

---

### 215. `esignature_audit`

**Description:** Complete audit trail for all e-signatures

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

**Columns:** 17

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| approval_step_id | string | uuid | ✓ | Note:
This is a Foreign Key to `approval_steps.id`.<fk table='approval_steps' column='id'/> |
| approval_instance_id | string | uuid | ✓ | Note:
This is a Foreign Key to `approval_instances.id`.<fk table='approval_instances' column='id'/> |
| signer_user_id | string | uuid | ✓ | - |
| signature_method | string | character varying | ✗ | - |
| signature_data | unknown | jsonb | ✗ | Encrypted signature data for compliance and verification |
| signature_hash | string | character varying | ✓ | - |
| ip_address | string | inet | ✓ | - |
| user_agent | string | text | ✓ | - |
| location_data | unknown | jsonb | ✓ | - |
| signed_at | string | timestamp with time zone | ✓ | - |
| document_hash | string | character varying | ✗ | - |
| document_version | string | character varying | ✓ | - |
| certificate_data | unknown | jsonb | ✓ | - |
| is_valid | boolean | boolean | ✓ | - |
| invalidated_at | string | timestamp with time zone | ✓ | - |
| invalidation_reason | string | text | ✓ | - |

---

### 216. `evaluation_packages`

**Scripts Using This Table:** 2

1. `server/src/routes/external-party-evaluation-routes.js`
2. `server/src/services/ExternalPartyEvaluationService.js`

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
| package_context | string | character varying | ✗ | - |
| context_reference_id | string | character varying | ✓ | - |
| package_name | string | character varying | ✗ | - |
| package_description | string | text | ✓ | - |
| party_email | string | character varying | ✗ | - |
| party_name | string | character varying | ✓ | - |
| party_org_name | string | character varying | ✓ | - |
| party_type | string | character varying | ✓ | - |
| party_id | string | uuid | ✓ | Optional UUID reference to external party. May reference contractors table, user_management, or other party tables. Not a foreign key to allow flexibility. The party_email field is the primary identifier. |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| overall_status | string | character varying | ✓ | - |
| discipline_scores | unknown | jsonb | ✓ | - |
| final_weighted_score | number | numeric | ✓ | - |
| final_weighted_percentage | number | numeric | ✓ | - |
| scoring_calculation | unknown | jsonb | ✓ | - |
| final_decision | string | character varying | ✓ | - |
| final_decision_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| final_decision_at | string | timestamp with time zone | ✓ | - |
| final_decision_comments | string | text | ✓ | - |
| context_metadata | unknown | jsonb | ✓ | - |
| created_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| created_at | string | timestamp with time zone | ✓ | - |
| due_date | string | date | ✓ | - |
| completed_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| updated_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |

---

### 217. `external_api_configurations`

**Scripts Using This Table:** 22

1. `create_missing_tables.js`
2. `debug_api_configs.js`
3. `diagnose_google_vision.js`
4. `server/routes/cv-analysis-routes.js`
5. `server/scripts/create-external-api-configurations-table.js`
6. `server/src/controllers/drawingAnalysisController.test.js`
7. `server/src/controllers/externalApiController.js`
8. `server/src/controllers/simpleExternalApiController.js`
9. `server/src/database/setup-security-tables.js`
10. `server/src/routes/chatbot-permissions-routes.js`
11. `server/src/routes/external-api-configurations-routes.js`
12. `server/src/services/apiAccessService.js`
13. `server/src/services/claudeVisionService.js`
14. `server/src/services/document-processing/DocumentStructureExtractionService.js`
15. `server/src/services/monitoringService.js`
16. `server/src/services/pdfTableExtractionService.js`
17. `server/src/services/securityService.js`
18. `server/src/services/technicalDrawingAreaExtractionService.js`
19. `setup_api_configs.js`
20. `test/debug/debug_api_configs.js`
21. `test/debug/integration/drawing_analysis_integration_test.js`
22. `test/debug/scripts/test_vision_api.js`

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
| api_name | string | text | ✗ | - |
| api_type | string | text | ✗ | - |
| endpoint_url | string | text | ✗ | - |
| api_key | string | text | ✗ | - |
| organization_id | string | text | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| description | string | text | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 218. `external_party_document_instances`

**Description:** Standardized External Party Documents - HTML content in html_content TEXT, schema in content_schema JSONB

**Scripts Using This Table:** 2

1. `server/src/routes/external-party-evaluation-routes.js`
2. `server/src/services/ExternalPartyEvaluationService.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 58

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| document_context | string | character varying | ✗ | - |
| context_reference_id | string | character varying | ✓ | - |
| source_table | string | character varying | ✗ | - |
| source_template_id | string | uuid | ✗ | - |
| template_snapshot | unknown | jsonb | ✗ | - |
| discipline_code | string | character varying | ✗ | - |
| discipline_owner_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| document_name | string | character varying | ✗ | - |
| document_description | string | text | ✓ | - |
| document_type | string | character varying | ✓ | - |
| assigned_to_party_id | string | uuid | ✓ | Optional UUID reference to external party. May reference contractors table, user_management, or other party tables. Not a foreign key to allow flexibility. The assigned_to_party_email field is the primary identifier. |
| assigned_to_party_email | string | character varying | ✗ | - |
| assigned_to_party_name | string | character varying | ✓ | - |
| assigned_to_party_org_name | string | character varying | ✓ | - |
| assigned_to_party_type | string | character varying | ✓ | - |
| created_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| created_at | string | timestamp with time zone | ✓ | - |
| reviewed_before_issue_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| reviewed_before_issue_at | string | timestamp with time zone | ✓ | - |
| pre_issue_review_notes | string | text | ✓ | - |
| issued_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| issued_at | string | timestamp with time zone | ✓ | - |
| due_date | string | date | ✓ | - |
| assignment_instructions | string | text | ✓ | - |
| html_content | string | text | ✗ | - |
| form_schema | unknown | jsonb | ✓ | DEPRECATED: Use content_schema. Remove post-migration. |
| party_responses | unknown | jsonb | ✓ | - |
| response_metadata | unknown | jsonb | ✓ | - |
| started_at | string | timestamp with time zone | ✓ | - |
| last_saved_at | string | timestamp with time zone | ✓ | - |
| submitted_at | string | timestamp with time zone | ✓ | - |
| reviewed_after_submission_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| reviewed_after_submission_at | string | timestamp with time zone | ✓ | - |
| post_submission_review_notes | string | text | ✓ | - |
| review_decision | string | character varying | ✓ | - |
| discipline_score | integer | integer | ✓ | - |
| discipline_max_score | integer | integer | ✓ | - |
| discipline_score_percentage | number | numeric | ✓ | - |
| score_breakdown | unknown | jsonb | ✓ | - |
| scoring_comments | string | text | ✓ | - |
| scored_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| scored_at | string | timestamp with time zone | ✓ | - |
| revision_count | integer | integer | ✓ | - |
| revision_history | unknown | jsonb | ✓ | - |
| status | string | character varying | ✓ | - |
| access_token | string | character varying | ✓ | - |
| access_expires_at | string | timestamp with time zone | ✓ | - |
| access_revoked | boolean | boolean | ✓ | - |
| evaluation_package_id | string | uuid | ✓ | - |
| evaluation_package_name | string | character varying | ✓ | - |
| context_metadata | unknown | jsonb | ✓ | - |
| version | string | character varying | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| updated_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| content_schema | unknown | jsonb | ✓ | - |

---

### 219. `field_attribute_compliance`

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
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_templates.id`.<fk table='procurement_templates' column='id'/> |
| procurement_order_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| field_name | string | character varying | ✓ | - |
| attribute_type | string | character varying | ✓ | - |
| ai_action_taken | string | character varying | ✓ | - |
| confidence_score | number | numeric | ✓ | - |
| user_override | boolean | boolean | ✓ | - |
| enforcement_timestamp | string | timestamp without time zone | ✓ | - |
| workflow_execution_id | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 220. `financial_records`

**Description:** Financial records management table for invoices, payments, expenses, contracts, budgets, and assets

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
| type | string | character varying | ✗ | Record type: invoice, payment, expense, contract, budget, asset |
| reference | string | character varying | ✗ | Unique reference number for the financial record |
| description | string | text | ✗ | - |
| amount | number | numeric | ✗ | - |
| currency | string | character varying | ✓ | - |
| date | string | date | ✗ | - |
| due_date | string | date | ✓ | - |
| status | string | character varying | ✓ | Status: pending, approved, paid, overdue, cancelled |
| vendor | string | character varying | ✓ | - |
| project | string | character varying | ✓ | - |
| category | string | character varying | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| active | boolean | boolean | ✓ | - |
| notes | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 221. `flowise_documents`

**Description:** Local tracking of individual documents and loaders within Flowise document stores

**Scripts Using This Table:** 8

1. `add-sample-documents-fixed.js`
2. `add-sample-documents.js`
3. `scripts/demo-document-queries.js`
4. `scripts/insert-sample-documents.js`
5. `scripts/query-local-documents.js`
6. `scripts/sync-flowise-documents.js`
7. `server/src/routes/flowise-documents-routes.js`
8. `test/debug/check-database-schema.js`

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
| document_store_id | string | uuid | ✗ | Reference to the document store containing this document

Note:
This is a Foreign Key to `document_stores.id`.<fk table='document_stores' column='id'/> |
| flowise_loader_id | string | text | ✗ | Flowise loader ID that processed this document |
| flowise_file_id | string | text | ✓ | Flowise file ID (if available) |
| document_name | string | text | ✗ | Display name for the document |
| original_filename | string | text | ✓ | Original filename when uploaded |
| file_size | integer | bigint | ✓ | File size in bytes |
| mime_type | string | text | ✓ | MIME type of the document |
| loader_name | string | text | ✓ | Human-readable name of the loader |
| loader_type | string | text | ✓ | Type of loader (pdfFile, textFile, etc.) |
| splitter_name | string | text | ✓ | Text splitter used for chunking |
| total_chunks | integer | integer | ✓ | Number of chunks created from this document |
| total_characters | integer | integer | ✓ | Total character count in the document |
| status | string | text | ✓ | Processing status in Flowise |
| uploaded_at | string | timestamp with time zone | ✓ | When the document was uploaded to Flowise |
| processed_at | string | timestamp with time zone | ✓ | When the document was processed/embedded |
| loader_config | unknown | jsonb | ✓ | Flowise loader configuration |
| document_metadata | unknown | jsonb | ✓ | Document metadata from Flowise |
| splitter_config | unknown | jsonb | ✓ | Text splitter configuration |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| last_synced_at | string | timestamp with time zone | ✓ | Last time this record was synced from Flowise |

---

### 222. `flowise_documents_with_stores`

**Description:** View combining Flowise documents with their document store information

**Scripts Using This Table:** 8

1. `scripts/demo-document-queries.js`
2. `scripts/insert-sample-documents.js`
3. `scripts/query-local-documents.js`
4. `scripts/sync-flowise-documents.js`
5. `server/routes/document-routes.js`
6. `server/src/routes/document-routes.js`
7. `server/src/routes/flowise-documents-routes.js`
8. `test/debug/check-database-schema.js`

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
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| document_store_id | string | uuid | ✓ | Note:
This is a Foreign Key to `document_stores.id`.<fk table='document_stores' column='id'/> |
| flowise_loader_id | string | text | ✓ | - |
| flowise_file_id | string | text | ✓ | - |
| document_name | string | text | ✓ | - |
| original_filename | string | text | ✓ | - |
| file_size | integer | bigint | ✓ | - |
| mime_type | string | text | ✓ | - |
| loader_name | string | text | ✓ | - |
| loader_type | string | text | ✓ | - |
| splitter_name | string | text | ✓ | - |
| total_chunks | integer | integer | ✓ | - |
| total_characters | integer | integer | ✓ | - |
| status | string | text | ✓ | - |
| uploaded_at | string | timestamp with time zone | ✓ | - |
| processed_at | string | timestamp with time zone | ✓ | - |
| loader_config | unknown | jsonb | ✓ | - |
| document_metadata | unknown | jsonb | ✓ | - |
| splitter_config | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| last_synced_at | string | timestamp with time zone | ✓ | - |
| store_name | string | text | ✓ | - |
| store_description | string | text | ✓ | - |
| store_metadata | unknown | jsonb | ✓ | - |

---

### 223. `flowise_record_manager`

**Description:** Record Manager table for Flowise Document Store to track document chunks and prevent duplicates

**Scripts Using This Table:** 1

1. `test/debug/integration/test-record-manager-integration.js`

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
| uuid | string | uuid | ✗ | Primary key UUID

Note:
This is a Primary Key.<pk/> |
| key | string | text | ✗ | Unique identifier for the document chunk (typically hash of content + metadata) |
| group_id | string | text | ✓ | Group identifier for related documents (e.g., document store ID or page prefix) |
| updated_at | string | timestamp with time zone | ✓ | Timestamp when the record was last updated |
| created_at | string | timestamp with time zone | ✓ | Timestamp when the record was created |
| metadata | unknown | jsonb | ✓ | Additional metadata about the document chunk |

---

### 224. `form_completions`

**Scripts Using This Table:** 1

1. `scripts/setup-form-completions-data.js`

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
| title | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| template_type | string | character varying | ✓ | - |
| status | string | character varying | ✗ | - |
| priority | string | character varying | ✓ | - |
| project_id | string | uuid | ✓ | - |
| project_name | string | character varying | ✓ | - |
| assigned_to | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| completed_date | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| reference_number | string | character varying | ✓ | - |
| tags | array | text[] | ✓ | - |
| form_data | unknown | jsonb | ✓ | - |
| comments | string | text | ✓ | - |

---

### 225. `form_instances`

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
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `governance_document_templates.id`.<fk table='governance_document_templates' column='id'/> |
| organization_name | string | text | ✓ | - |
| instance_name | string | text | ✗ | - |
| instance_slug | string | text | ✓ | - |
| source_file_name | string | text | ✗ | - |
| source_file_type | string | text | ✓ | - |
| source_file_size | integer | integer | ✓ | - |
| processed_data | unknown | jsonb | ✓ | - |
| submission_data | unknown | jsonb | ✓ | - |
| html_form | string | text | ✓ | - |
| json_form | unknown | jsonb | ✓ | - |
| processing_status | string | text | ✓ | - |
| version | integer | integer | ✓ | - |
| is_submitted | boolean | boolean | ✓ | - |
| submitted_by | string | text | ✓ | - |
| submitted_at | string | timestamp with time zone | ✓ | - |
| created_by | string | text | ✓ | - |
| updated_by | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| deleted_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 226. `form_templates`

**Scripts Using This Table:** 24

1. `analyze_discipline_inconsistency.js`
2. `debug_discipline_uuids.js`
3. `debug_form_display_issue.js`
4. `diagnose_form_insert.js`
5. `execute_uuid_fix_direct.js`
6. `execute_uuid_fix_final.js`
7. `execute_uuid_fix_sql.js`
8. `execute_uuid_fix_supabase.js`
9. `execute_uuid_fix_ultimate.js`
10. `execute_uuid_fix_workaround.js`
11. `fix_all_procurement_uuids.js`
12. `fix_procurement_final.js`
13. `isolate_error.js`
14. `isolate_specific_error.js`
15. `quick_supabase_test.js`
16. `real_time_supabase_test.js`
17. `server/src/routes/form-template-routes.js`
18. `server/src/services/formTemplateService.js`
19. `test/debug/debug_discipline_uuids.js`
20. `test/debug/debug_form_display_issue.js`
21. `test/debug/scripts/test_form_template_api.test.js`
22. `test/integration/quick_supabase_test.js`
23. `test/integration/real_time_supabase_test.js`
24. `verify_uuid_fix.js`

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
| template_name | string | text | ✗ | - |
| html_content | string | text | ✓ | - |
| json_schema | unknown | jsonb | ✓ | - |
| processing_status | string | text | ✓ | - |
| organization_name | string | text | ✓ | - |
| discipline_id | string | uuid | ✓ | Note:
This is a Foreign Key to `disciplines.id`.<fk table='disciplines' column='id'/> |
| discipline_name | string | text | ✓ | - |
| created_by | string | text | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| form_metadata | unknown | jsonb | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 227. `form_templates_audit`

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
| form_template_id | string | uuid | ✓ | - |
| action | string | text | ✗ | - |
| old_data | unknown | jsonb | ✓ | - |
| new_data | unknown | jsonb | ✓ | - |
| changed_by | string | text | ✓ | - |
| changed_at | string | timestamp with time zone | ✓ | - |
| user_role | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| is_dev_mode | boolean | boolean | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 228. `fuel_lubricants`

**Description:** ✅ MASTER GUIDE COMPLIANT: Organization-isolated fuel/lubricants management
with creator ownership, audit trails, and approval workflow patterns.
Reference: procurement_templates table standard.

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

**Columns:** 55

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | - |
| product_code | string | character varying | ✓ | - |
| category | string | character varying | ✗ | - |
| subtype | string | character varying | ✓ | - |
| supplier_id | integer | integer | ✓ | Note:
This is a Foreign Key to `suppliers.id`.<fk table='suppliers' column='id'/> |
| supplier_name | string | character varying | ✓ | - |
| supplier_contact | string | character varying | ✓ | - |
| supplier_email | string | character varying | ✓ | - |
| viscosity | string | character varying | ✓ | - |
| viscosity_class | string | character varying | ✓ | - |
| grade | string | character varying | ✓ | - |
| specification_standard | string | character varying | ✓ | - |
| specifications | unknown | jsonb | ✓ | JSON object containing detailed technical specifications |
| current_stock_quantity | number | numeric | ✓ | - |
| minimum_stock_level | number | numeric | ✓ | - |
| maximum_stock_level | number | numeric | ✓ | - |
| unit_of_measure | string | character varying | ✓ | - |
| reorder_quantity | number | numeric | ✓ | - |
| quality_status | string | character varying | ✓ | - |
| compliance_certificate | string | character varying | ✓ | - |
| batch_number | string | character varying | ✓ | - |
| expiry_date | string | date | ✓ | - |
| production_date | string | date | ✓ | - |
| purchase_price | number | numeric | ✓ | - |
| selling_price | number | numeric | ✓ | - |
| purchase_date | string | date | ✓ | - |
| purchase_order_number | string | character varying | ✓ | - |
| invoice_number | string | character varying | ✓ | - |
| consumption_rate | number | numeric | ✓ | - |
| last_used_date | string | date | ✓ | - |
| total_consumed | number | numeric | ✓ | - |
| approval_status | string | character varying | ✓ | - |
| approved_by | string | uuid | ✓ | - |
| approval_date | string | timestamp with time zone | ✓ | - |
| rejection_reason | string | text | ✓ | - |
| equipment_assigned | unknown | jsonb | ✓ | JSON array of equipment IDs compatible with this fuel/lubricant |
| project_assigned | string | character varying | ✓ | - |
| storage_location | string | character varying | ✓ | - |
| storage_temperature | string | character varying | ✓ | - |
| storage_conditions | string | text | ✓ | - |
| scheduled_changes | unknown | jsonb | ✓ | JSON object with change schedules and reminders |
| last_change_date | string | date | ✓ | - |
| change_frequency_days | integer | integer | ✓ | - |
| hazard_classification | string | character varying | ✓ | - |
| sds_url | string | character varying | ✓ | - |
| environmental_impact | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| active | boolean | boolean | ✓ | - |
| archived | boolean | boolean | ✓ | - |
| critical_item | boolean | boolean | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 229. `governance_approval_instances`

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
| matrix_id | string | uuid | ✓ | Note:
This is a Foreign Key to `governance_approval_matrices.id`.<fk table='governance_approval_matrices' column='id'/> |
| document_id | string | uuid | ✓ | - |
| document_title | string | text | ✗ | - |
| document_number | string | text | ✓ | - |
| department_code | string | text | ✗ | - |
| requester_id | string | text | ✓ | - |
| requester_name | string | text | ✗ | - |
| current_level | integer | integer | ✓ | - |
| status | string | text | ✓ | - |
| started_at | string | timestamp with time zone | ✓ | - |
| deadline_at | string | timestamp with time zone | ✓ | - |
| escalated_at | string | timestamp with time zone | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| approved_by | string | text | ✓ | - |
| rejection_reason | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| document_version_major | integer | integer | ✓ | - |
| document_version_minor | integer | integer | ✓ | - |
| document_version_revision | string | text | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| created_by | string | uuid | ✓ | - |

---

### 230. `governance_approval_matrices`

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
| organization_id | string | text | ✓ | - |
| department_code | string | text | ✗ | - |
| document_type | string | text | ✗ | - |
| approval_levels | unknown | jsonb | ✗ | - |
| auto_approval_threshold | number | numeric | ✓ | - |
| deadline_days | integer | integer | ✓ | - |
| escalation_rules | unknown | jsonb | ✓ | - |
| email_templates | unknown | jsonb | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |

---

### 231. `governance_approval_steps`

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
| approval_instance_id | string | uuid | ✗ | Note:
This is a Foreign Key to `governance_approval_instances.id`.<fk table='governance_approval_instances' column='id'/> |
| step_number | integer | integer | ✗ | - |
| approver_role | string | text | ✗ | - |
| approver_user_id | string | text | ✓ | - |
| approver_name | string | text | ✓ | - |
| status | string | text | ✓ | - |
| action_taken | string | text | ✓ | - |
| action_timestamp | string | timestamp with time zone | ✓ | - |
| notified_at | string | timestamp with time zone | ✓ | - |
| reminder_sent_at | string | timestamp with time zone | ✓ | - |
| comments | string | text | ✓ | - |
| attachment_urls | array | text[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| created_by | string | uuid | ✓ | - |

---

### 232. `governance_document_templates`

**Description:** Standardized Governance Form Templates - HTML content in html_content TEXT, schema in content_schema JSONB

**Scripts Using This Table:** 4

1. `debug_project_fallback.js`
2. `enhanced_form_save_null_debug.js`
3. `test/debug/debug_project_fallback.js`
4. `test/debug/scripts/test_duplicate_logic_standalone.js`

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** 1

**Policy 1:** RLS Enabled
- **Operations:** ALL
- **Roles:** authenticated
- **Condition:** `RLS policies active (details not accessible via this method)`

**Columns:** 29

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| organization_name | string | text | ✓ | - |
| discipline_id | string | uuid | ✓ | Note:
This is a Foreign Key to `disciplines.id`.<fk table='disciplines' column='id'/> |
| discipline_name | string | text | ✓ | - |
| template_name | string | text | ✗ | - |
| template_slug | string | text | ✓ | - |
| html_content | string | text | ✓ | - |
| json_schema | unknown | jsonb | ✓ | DEPRECATED: Use content_schema. Remove post-migration. |
| form_metadata | unknown | jsonb | ✓ | - |
| source_file_name | string | text | ✓ | - |
| source_file_type | string | text | ✓ | - |
| extracted_fields_count | integer | integer | ✓ | - |
| extraction_method | string | text | ✓ | - |
| processing_status | string | text | ✓ | - |
| version | integer | integer | ✓ | - |
| parent_template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `governance_document_templates.id`.<fk table='governance_document_templates' column='id'/> |
| is_default | boolean | boolean | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_by | string | text | ✓ | - |
| updated_by | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| deleted_at | string | timestamp with time zone | ✓ | - |
| content_schema | unknown | jsonb | ✓ | - |
| processing_method | string | text | ✓ | Method used to process the document (e.g., structured_excel_parsing, ai_generated) |
| document_type | string | text | ✓ | Document type selected during upload (e.g., PO, Contract, SOW) |
| document_type_label | string | text | ✓ | Human-readable label for the document type |
| source_governance_template_id | string | uuid | ✓ | - |

---

### 233. `governance_document_templates_backup_20251121`

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

**Columns:** 29

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| organization_name | string | text | ✓ | - |
| discipline_id | string | uuid | ✓ | - |
| discipline_name | string | text | ✓ | - |
| template_name | string | text | ✓ | - |
| template_slug | string | text | ✓ | - |
| html_content | string | text | ✓ | - |
| json_schema | unknown | jsonb | ✓ | - |
| form_metadata | unknown | jsonb | ✓ | - |
| source_file_name | string | text | ✓ | - |
| source_file_type | string | text | ✓ | - |
| extracted_fields_count | integer | integer | ✓ | - |
| extraction_method | string | text | ✓ | - |
| processing_status | string | text | ✓ | - |
| version | integer | integer | ✓ | - |
| parent_template_id | string | uuid | ✓ | - |
| is_default | boolean | boolean | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_by | string | text | ✓ | - |
| updated_by | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| deleted_at | string | timestamp with time zone | ✓ | - |
| content_schema | unknown | jsonb | ✓ | - |
| processing_method | string | text | ✓ | - |
| document_type | string | text | ✓ | - |
| document_type_label | string | text | ✓ | - |
| source_governance_template_id | string | uuid | ✓ | - |

---

### 234. `governance_document_templates-old`

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
| name | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| category | string | character varying | ✗ | - |
| template_type | string | character varying | ✓ | - |
| fields | unknown | jsonb | ✓ | - |
| settings | unknown | jsonb | ✓ | - |
| content | string | text | ✓ | - |
| status | string | character varying | ✓ | - |
| version | integer | integer | ✓ | - |
| usage_count | integer | integer | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organizations | unknown | jsonb | ✓ | - |
| disciplines | unknown | jsonb | ✓ | - |
| sectors | unknown | jsonb | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |

---

### 235. `governance_template_usage`

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
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `governance_document_templates-old.id`.<fk table='governance_document_templates-old' column='id'/> |
| user_id | string | uuid | ✓ | - |
| action | string | character varying | ✗ | - |
| metadata | unknown | jsonb | ✓ | - |
| used_at | string | timestamp with time zone | ✓ | - |

---

### 236. `imported_emails_with_placeholder_users`

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
| email_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| subject | string | text | ✓ | - |
| sender_email | string | character varying | ✓ | - |
| recipient_email | string | character varying | ✓ | - |
| sent_date | string | timestamp with time zone | ✓ | - |
| user_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| user_email | string | text | ✓ | - |
| user_active | boolean | boolean | ✓ | - |
| is_placeholder_user | boolean | boolean | ✓ | - |

---

### 237. `inspection_items`

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
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| inspection_id | string | character varying | ✗ | Note:
This is a Foreign Key to `inspections.inspection_id`.<fk table='inspections' column='inspection_id'/> |
| item_id | string | character varying | ✗ | - |
| item_type | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| location | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| priority | string | character varying | ✓ | - |
| assigned_to | string | character varying | ✓ | - |
| due_date | string | date | ✓ | - |
| completed_date | string | date | ✓ | - |
| notes | string | text | ✓ | - |
| media_urls | unknown | jsonb | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 238. `inspection_media`

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
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| media_id | string | character varying | ✗ | - |
| inspection_id | string | character varying | ✓ | - |
| inspection_item_id | string | character varying | ✓ | - |
| defect_id | string | character varying | ✓ | - |
| file_name | string | character varying | ✗ | - |
| file_type | string | character varying | ✗ | - |
| file_size | integer | integer | ✓ | - |
| file_url | string | text | ✗ | - |
| storage_path | string | text | ✓ | - |
| description | string | text | ✓ | - |
| tags | unknown | jsonb | ✓ | - |
| uploaded_by | string | character varying | ✓ | - |
| upload_date | string | timestamp without time zone | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 239. `inspections`

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
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| inspection_id | string | character varying | ✗ | - |
| project_id | string | character varying | ✗ | - |
| inspection_type | string | character varying | ✗ | - |
| scheduled_date | string | date | ✗ | - |
| completed_date | string | date | ✓ | - |
| inspector_id | string | character varying | ✓ | - |
| facility | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| priority | string | character varying | ✓ | - |
| notes | string | text | ✓ | - |
| findings_count | integer | integer | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| created_by | string | character varying | ✓ | - |
| updated_by | string | character varying | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 240. `integration_sources`

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
| source_id | string | character varying | ✗ | - |
| name | string | character varying | ✗ | - |
| description | string | text | ✓ | - |
| base_url | string | character varying | ✓ | - |
| api_key_encrypted | string | text | ✓ | - |
| username_encrypted | string | text | ✓ | - |
| password_encrypted | string | text | ✓ | - |
| integration_type | string | character varying | ✗ | - |
| status | string | character varying | ✓ | - |
| config | unknown | jsonb | ✓ | - |
| last_sync_at | string | timestamp with time zone | ✓ | - |
| last_successful_sync_at | string | timestamp with time zone | ✓ | - |
| last_error | string | text | ✓ | - |
| sync_interval_minutes | integer | integer | ✓ | - |
| rate_limit_per_minute | integer | integer | ✓ | - |
| timeout_seconds | integer | integer | ✓ | - |
| retry_attempts | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 241. `integration_sync_history`

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
| integration_source_id | string | uuid | ✓ | Note:
This is a Foreign Key to `integration_sources.id`.<fk table='integration_sources' column='id'/> |
| sync_type | string | character varying | ✓ | - |
| status | string | character varying | ✗ | - |
| records_processed | integer | integer | ✓ | - |
| records_created | integer | integer | ✓ | - |
| records_updated | integer | integer | ✓ | - |
| records_failed | integer | integer | ✓ | - |
| start_time | string | timestamp with time zone | ✗ | - |
| end_time | string | timestamp with time zone | ✓ | - |
| duration_seconds | integer | integer | ✓ | - |
| error_message | string | text | ✓ | - |
| sync_metadata | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 242. `internal_notifications`

**Description:** Internal notification system to avoid email dependency

**Scripts Using This Table:** 4

1. `server/src/controllers/enterpriseApprovalController.js`
2. `server/src/services/ProjectTemplatePreparationService.js`
3. `tests/integration/multi-discipline-coordination.test.js`
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

**Columns:** 15

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| user_id | string | uuid | ✓ | - |
| type | string | character varying | ✗ | - |
| category | string | character varying | ✓ | - |
| title | string | character varying | ✗ | - |
| message | string | text | ✗ | - |
| approval_instance_id | string | uuid | ✓ | Note:
This is a Foreign Key to `approval_instances.id`.<fk table='approval_instances' column='id'/> |
| approval_step_id | string | uuid | ✓ | Note:
This is a Foreign Key to `approval_steps.id`.<fk table='approval_steps' column='id'/> |
| priority | string | character varying | ✓ | - |
| is_read | boolean | boolean | ✓ | - |
| read_at | string | timestamp with time zone | ✓ | - |
| action_required | boolean | boolean | ✓ | - |
| action_url | string | character varying | ✓ | Direct link to the approval action page |
| created_at | string | timestamp with time zone | ✓ | - |
| expires_at | string | timestamp with time zone | ✓ | - |

---

### 243. `job_descriptions`

**Scripts Using This Table:** 1

1. `server/scripts/create-job-descriptions-table-supabase.js`

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
| title | string | text | ✗ | - |
| location | string | text | ✓ | - |
| employment_type | string | text | ✓ | - |
| salary_range_min | number | numeric | ✓ | - |
| salary_range_max | number | numeric | ✓ | - |
| job_description | string | text | ✓ | - |
| requirements | string | text | ✓ | - |
| responsibilities | string | text | ✓ | - |
| benefits | string | text | ✓ | - |
| application_deadline | string | date | ✓ | - |
| contact_person | string | text | ✓ | - |
| status | string | text | ✓ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| discipline | string | text | ✓ | Discipline or division (formerly department) |

---

### 244. `legal_reviews`

**Description:** Legal reviews and compliance checks for contracts and documents

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
| review_type | string | character varying | ✓ | - |
| document_type | string | character varying | ✓ | - |
| urgency | string | character varying | ✓ | - |
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

### 245. `limits_of_authority`

**Description:** Defines organizational limits of authority for document approvals

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

**Columns:** 13

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| organization_id | string | uuid | ✗ | Organization this limit applies to

Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| department_code | string | character varying | ✓ | Department code (optional - null means applies to all) |
| document_type | string | character varying | ✗ | Type of document (procurement_order, work_order, etc.) |
| min_amount | number | numeric | ✓ | Minimum amount threshold (inclusive) |
| max_amount | number | numeric | ✓ | Maximum amount threshold (exclusive) |
| required_approvals | unknown | jsonb | ✗ | JSON array of required approval roles |
| conditions | unknown | jsonb | ✓ | Additional conditions for approval routing |
| is_active | boolean | boolean | ✓ | - |
| created_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_profiles.user_id`.<fk table='user_profiles' column='user_id'/> |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| updated_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_profiles.user_id`.<fk table='user_profiles' column='user_id'/> |

---

### 246. `llm_configurations`

**Scripts Using This Table:** 3

1. `populate-llm-configurations.js`
2. `server/src/controllers/aiDocumentAnalysisController.js`
3. `server/src/controllers/llmConfigurationController.js`

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
| id | string | character varying | ✗ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✗ | - |
| provider | string | character varying | ✗ | - |
| model | string | character varying | ✗ | - |
| api_key | string | character varying | ✓ | - |
| status | string | character varying | ✗ | - |
| usage_count | integer | integer | ✓ | - |
| last_used | string | timestamp without time zone | ✓ | - |
| created_at | string | timestamp without time zone | ✗ | - |
| updated_at | string | timestamp without time zone | ✗ | - |
| created_by | string | character varying | ✓ | - |
| updated_by | string | character varying | ✓ | - |
| purposes | array | text[] | ✓ | - |

---

### 247. `llm_document_type_mappings`

**Scripts Using This Table:** 2

1. `populate-llm-configurations.js`
2. `server/src/controllers/llmConfigurationController.js`

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
| llm_configuration_id | string | character varying | ✓ | Note:
This is a Foreign Key to `llm_configurations.id`.<fk table='llm_configurations' column='id'/> |
| document_type | string | character varying | ✗ | - |
| analysis_type | string | character varying | ✗ | - |
| created_at | string | timestamp without time zone | ✗ | - |
| updated_at | string | timestamp without time zone | ✗ | - |
| file_format | string | character varying | ✓ | - |
| default_format | boolean | boolean | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 248. `llm_functions`

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
| name | string | text | ✗ | - |
| description | string | text | ✓ | - |
| function_type | string | public.llm_function_type | ✗ | - |
| model_name | string | text | ✗ | - |
| api_config | unknown | jsonb | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |
| created_by | string | uuid | ✓ | - |

---

### 249. `logistics_alerts`

**Description:** System-generated alerts and notifications

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
| alert_type | string | character varying | ✗ | - |
| severity | string | character varying | ✗ | - |
| shipment_id | string | uuid | ✓ | Note:
This is a Foreign Key to `logistics_shipments.id`.<fk table='logistics_shipments' column='id'/> |
| vessel_id | string | uuid | ✓ | Note:
This is a Foreign Key to `vessels.id`.<fk table='vessels' column='id'/> |
| container_id | string | uuid | ✓ | Note:
This is a Foreign Key to `containers.id`.<fk table='containers' column='id'/> |
| alert_title | string | character varying | ✗ | - |
| alert_description | string | text | ✓ | - |
| alert_timestamp | string | timestamp with time zone | ✓ | - |
| status | string | character varying | ✓ | - |
| acknowledged_at | string | timestamp with time zone | ✓ | - |
| acknowledged_by | string | uuid | ✓ | - |
| resolved_at | string | timestamp with time zone | ✓ | - |
| resolved_by | string | uuid | ✓ | - |
| action_required | boolean | boolean | ✓ | - |
| action_description | string | text | ✓ | - |
| due_date | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| company_id | string | uuid | ✓ | - |
| organisation_id | string | uuid | ✓ | - |
| project_id | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 250. `logistics_approval_steps`

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
| workflow_id | string | uuid | ✓ | Note:
This is a Foreign Key to `logistics_approval_workflows.id`.<fk table='logistics_approval_workflows' column='id'/> |
| step_number | integer | integer | ✗ | - |
| step_type | string | text | ✗ | - |
| assigned_to | string | uuid | ✓ | - |
| status | string | text | ✓ | - |
| decision | string | text | ✓ | - |
| comments | string | text | ✓ | - |
| decision_at | string | timestamp with time zone | ✓ | - |
| time_spent_minutes | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |

---

### 251. `logistics_approval_workflows`

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
| document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `logistics_documents.id`.<fk table='logistics_documents' column='id'/> |
| workflow_type | string | text | ✗ | - |
| current_step | string | text | ✗ | - |
| status | string | text | ✓ | - |
| priority | string | text | ✓ | - |
| assigned_to | string | uuid | ✓ | - |
| assigned_at | string | timestamp with time zone | ✓ | - |
| due_date | string | timestamp with time zone | ✓ | - |
| escalation_level | integer | integer | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 252. `logistics_context_data`

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
| procurement_order_id | string | uuid | ✓ | - |
| orderid | string | uuid | ✓ | - |
| ordernumber | string | text | ✓ | - |
| orderdate | string | timestamp with time zone | ✓ | - |
| exporterdetails | unknown | jsonb | ✓ | - |
| importerdetails | unknown | jsonb | ✓ | - |
| cargodescription | string | text | ✓ | - |
| hscode | string | text | ✓ | - |
| quantity | number | numeric | ✓ | - |
| unit | string | text | ✓ | - |
| value | number | numeric | ✓ | - |
| currency | string | text | ✓ | - |
| weight | number | numeric | ✓ | - |
| deliveryterms | string | text | ✓ | - |
| transportmode | string | text | ✓ | - |
| deliveryaddress | unknown | jsonb | ✓ | - |
| lastupdated | string | timestamp with time zone | ✓ | - |
| source | string | text | ✓ | - |
| exportdeclarationrequired | boolean | boolean | ✓ | - |

---

### 253. `logistics_coordination_monitor`

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
| task_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| title | string | character varying | ✓ | - |
| task_status | string | character varying | ✓ | - |
| priority | string | character varying | ✓ | - |
| assigned_to_discipline | string | text | ✓ | - |
| procurement_order_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| procurement_description | string | text | ✓ | - |
| documents_generated | integer | bigint | ✓ | - |
| last_document_generated | string | timestamp with time zone | ✓ | - |
| total_messages | integer | bigint | ✓ | - |
| last_message_date | string | timestamp with time zone | ✓ | - |

---

### 254. `logistics_document_versions`

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
| document_id | string | uuid | ✓ | Note:
This is a Foreign Key to `logistics_documents.id`.<fk table='logistics_documents' column='id'/> |
| version_number | integer | integer | ✗ | - |
| content | unknown | jsonb | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| generated_by_ai | boolean | boolean | ✓ | - |
| ai_model | string | text | ✓ | - |
| ai_confidence | number | numeric | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |

---

### 255. `logistics_documents`

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
| procurement_order_id | string | uuid | ✗ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| document_type | string | text | ✗ | - |
| direction | string | text | ✗ | - |
| content | string | text | ✗ | - |
| metadata | unknown | jsonb | ✓ | - |
| status | string | text | ✓ | - |
| shared_with | string | text | ✓ | - |
| shared_at | string | timestamp with time zone | ✓ | - |
| generated_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 256. `logistics_shipments`

**Description:** High-level shipment records

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

**Columns:** 36

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| shipment_number | string | character varying | ✗ | - |
| shipment_name | string | character varying | ✓ | - |
| shipment_type | string | character varying | ✓ | - |
| shipper_name | string | character varying | ✓ | - |
| shipper_address | string | text | ✓ | - |
| consignee_name | string | character varying | ✓ | - |
| consignee_address | string | text | ✓ | - |
| freight_forwarder | string | character varying | ✓ | - |
| origin_port | string | character varying | ✓ | - |
| destination_port | string | character varying | ✓ | - |
| transit_ports | array | text[] | ✓ | - |
| booking_date | string | date | ✓ | - |
| planned_departure_date | string | date | ✓ | - |
| actual_departure_date | string | date | ✓ | - |
| planned_arrival_date | string | date | ✓ | - |
| actual_arrival_date | string | date | ✓ | - |
| total_value | number | numeric | ✓ | - |
| currency | string | character varying | ✓ | - |
| incoterms | string | character varying | ✓ | - |
| payment_terms | string | character varying | ✓ | - |
| shipment_status | string | character varying | ✓ | - |
| priority_level | string | character varying | ✓ | - |
| documents_complete | boolean | boolean | ✓ | - |
| customs_cleared | boolean | boolean | ✓ | - |
| insurance_reference | string | character varying | ✓ | - |
| notes | string | text | ✓ | - |
| special_instructions | string | text | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| company_id | string | uuid | ✓ | - |
| organisation_id | string | uuid | ✓ | - |
| project_id | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 257. `maintenance_assets`

**Description:** Equipment and plant assets for maintenance tracking

**Scripts Using This Table:** 1

1. `server/src/controllers/maintenanceController.js`

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
| name | string | character varying | ✗ | - |
| type | string | character varying | ✗ | - |
| manufacturer | string | character varying | ✓ | - |
| model | string | character varying | ✓ | - |
| serial_number | string | character varying | ✓ | - |
| year | integer | integer | ✓ | - |
| location | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| description | string | text | ✓ | - |
| purchase_date | string | date | ✓ | - |
| purchase_cost | number | numeric | ✓ | - |
| warranty_expiry | string | date | ✓ | - |
| last_maintenance | string | date | ✓ | - |
| next_due | string | date | ✓ | - |
| user_id | string | uuid | ✓ | - |
| project_id | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 258. `maintenance_history`

**Description:** Historical record of completed maintenance

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
| asset_id | string | uuid | ✓ | Note:
This is a Foreign Key to `maintenance_assets.id`.<fk table='maintenance_assets' column='id'/> |
| work_order_id | string | uuid | ✓ | Note:
This is a Foreign Key to `maintenance_work_orders.id`.<fk table='maintenance_work_orders' column='id'/> |
| schedule_id | string | uuid | ✓ | Note:
This is a Foreign Key to `maintenance_schedules.id`.<fk table='maintenance_schedules' column='id'/> |
| maintenance_type | string | character varying | ✗ | - |
| description | string | text | ✗ | - |
| performed_by | string | uuid | ✓ | - |
| performed_by_name | string | character varying | ✓ | - |
| performed_date | string | date | ✗ | - |
| hours_spent | number | numeric | ✓ | - |
| cost | number | numeric | ✓ | - |
| parts_used | string | text | ✓ | - |
| notes | string | text | ✓ | - |
| project_id | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 259. `maintenance_schedules`

**Description:** Scheduled maintenance for assets

**Scripts Using This Table:** 1

1. `server/src/controllers/maintenanceController.js`

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
| asset_id | string | uuid | ✓ | Note:
This is a Foreign Key to `maintenance_assets.id`.<fk table='maintenance_assets' column='id'/> |
| asset_name | string | character varying | ✗ | - |
| maintenance_type | string | character varying | ✗ | - |
| frequency | integer | integer | ✗ | - |
| frequency_unit | string | character varying | ✓ | - |
| description | string | text | ✗ | - |
| last_completed | string | date | ✓ | - |
| next_due | string | date | ✓ | - |
| status | string | character varying | ✓ | - |
| assigned_to | string | uuid | ✓ | - |
| assigned_to_name | string | character varying | ✓ | - |
| created_by | string | uuid | ✓ | - |
| estimated_hours | number | numeric | ✓ | - |
| cost_per_service | number | numeric | ✓ | - |
| instructions | string | text | ✓ | - |
| project_id | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 260. `maintenance_work_orders`

**Description:** Work orders for maintenance tasks

**Scripts Using This Table:** 1

1. `server/src/controllers/maintenanceController.js`

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
| asset_id | string | uuid | ✓ | Note:
This is a Foreign Key to `maintenance_assets.id`.<fk table='maintenance_assets' column='id'/> |
| asset_name | string | character varying | ✗ | - |
| type | string | character varying | ✗ | - |
| priority | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| title | string | character varying | ✗ | - |
| description | string | text | ✗ | - |
| assigned_to | string | uuid | ✓ | - |
| assigned_to_name | string | character varying | ✓ | - |
| created_by | string | uuid | ✓ | - |
| due_date | string | date | ✓ | - |
| start_date | string | date | ✓ | - |
| completion_date | string | date | ✓ | - |
| estimated_hours | number | numeric | ✓ | - |
| actual_hours | number | numeric | ✓ | - |
| cost | number | numeric | ✓ | - |
| parts_used | string | text | ✓ | - |
| notes | string | text | ✓ | - |
| project_id | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |

---

### 261. `master_engineering_templates`

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

**Columns:** 28

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| template_name | string | character varying | ✗ | - |
| template_description | string | text | ✓ | - |
| discipline | string | character varying | ✗ | - |
| template_category | string | character varying | ✗ | - |
| template_type | string | character varying | ✗ | - |
| risk_level | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| html_content | string | text | ✓ | - |
| json_content | unknown | jsonb | ✓ | - |
| file_attachments | unknown | jsonb | ✓ | - |
| tags | array | text[] | ✓ | - |
| version | integer | integer | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| is_latest | boolean | boolean | ✓ | - |
| project_id | string | uuid | ✓ | Note:
This is a Foreign Key to `projects.id`.<fk table='projects' column='id'/> |
| approval_required | boolean | boolean | ✓ | - |
| approved_by | string | uuid | ✓ | - |
| approved_at | string | timestamp with time zone | ✓ | - |
| published_to_procurement_at | string | timestamp with time zone | ✓ | - |
| dcs_document_id | string | character varying | ✓ | - |
| dcs_version | string | character varying | ✓ | - |
| organization_id | string | uuid | ✗ | - |
| company_id | string | uuid | ✗ | - |
| created_by | string | uuid | ✓ | - |
| updated_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 262. `master_templates`

**Description:** Approved organizational template standards for procurement documents

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
| template_name | string | character varying | ✗ | - |
| template_type | string | character varying | ✗ | - |
| procurement_category | string | character varying | ✗ | - |
| category_code | string | character varying | ✓ | - |
| status | string | character varying | ✗ | - |
| content | unknown | jsonb | ✓ | - |
| approval_workflow | unknown | jsonb | ✓ | - |
| version | integer | integer | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| tags | array | text[] | ✓ | - |
| language_support | array | character varying[] | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 263. `match_all_documents`

**Scripts Using This Table:** None found

**Referenced By:** No other tables

**Foreign Keys:** None found

**Constraints:** None found

**Indexes:** None found

**RLS Policies:** None found

**Columns:** 4

| Column Name | Data Type | Format | Nullable | Description |
|-------------|-----------|--------|----------|-------------|
| source_table | string | text | ✓ | - |
| id | string | text | ✓ | - |
| content | string | text | ✓ | - |
| similarity | number | double precision | ✓ | - |

---

### 264. `materials`

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
| name | string | text | ✗ | - |
| type | string | text | ✗ | - |
| specifications | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 265. `migration_rename_log`

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
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| old_table_name | string | text | ✓ | - |
| new_table_name | string | text | ✓ | - |
| rename_status | string | text | ✓ | - |
| error_message | string | text | ✓ | - |
| renamed_at | string | timestamp without time zone | ✓ | - |

---

### 266. `migration_validation_results`

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
| id | integer | integer | ✗ | Note:
This is a Primary Key.<pk/> |
| check_name | string | text | ✓ | - |
| check_type | string | text | ✓ | - |
| status | string | text | ✓ | - |
| details | string | text | ✓ | - |
| checked_at | string | timestamp without time zone | ✓ | - |

---

### 267. `modal_configurations`

**Scripts Using This Table:** 10

1. `establish-agents-tracking-as-source-of-truth.js`
2. `fix-00435-modal-issues.js`
3. `populate-agent-modal-assignments.js`
4. `server/scripts/updateModalConfigs.js`
5. `server/src/controllers/sector-management-controller.js`
6. `server/src/controllers/ui-settings-controller.js`
7. `server/src/routes/contributors-routes.js`
8. `server/src/routes/modal-configurations-routes.js`
9. `test/debug/integration/test-00435-fixes.js`
10. `update-agent-tables-with-real-agents.js`

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
| id | string | uuid | ✗ | Unique identifier for the modal configuration

Note:
This is a Primary Key.<pk/> |
| modal_key | string | text | ✓ | Unique, human-readable key used for registration and triggering (e.g., "RiskAssessmentModal") |
| display_name | string | text | ✓ | User-friendly name shown in the UI (e.g., "Risk Assessment") |
| component_path | string | text | ✓ | The dynamic import path for the React component file (e.g., "@pages/2400-safety/components/modals/2400-RiskAssessmentModal.js") |
| description | string | text | ✓ | Optional text describing the modal's purpose |
| target_page_prefix | string | text | ✓ | The 4-digit page prefix the modal is primarily associated with (e.g., "2400") |
| chatbot_id | string | text | ✓ | The Flowise/Agent ID associated with this modal (nullable) |
| integration_type | string | text | ✗ | Type of integration, if any (e.g., "Flowise", "n8n", "None") |
| interaction_style | string | text | ✗ | Interaction style for integration modals (e.g., "Input Form", "No Input Form", "None") |
| is_legacy | boolean | boolean | ✗ | Flag to indicate if this configuration represents a legacy (non-React) modal |
| created_at | string | timestamp with time zone | ✗ | Timestamp of when the record was created |
| updated_at | string | timestamp with time zone | ✗ | Timestamp of when the record was last updated |
| target_state | string | text | ✓ | The state group the modal button belongs to (e.g., "Workspace", "Upsert", "Agent", nullable) |
| sector | string | text | ✓ | - |
| sector_id | string | uuid | ✓ | Note:
This is a Foreign Key to `sectors.sector_id`.<fk table='sectors' column='sector_id'/> |
| created_by | string | uuid | ✓ | Reference to the contributor who created this modal configuration |
| updated_by | string | uuid | ✓ | Reference to the contributor who last updated this modal configuration |
| is_active | boolean | boolean | ✓ | - |
| is_deleted | boolean | boolean | ✓ | - |
| sort_order | integer | integer | ✓ | - |
| tags | array | text[] | ✓ | - |
| metadata | unknown | jsonb | ✓ | - |
| modal_type | string | text | ✓ | - |
| page_name | string | text | ✓ | - |
| page_prefix | string | text | ✓ | - |

---

### 268. `monthly_documents_created`

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
| month_year | string | timestamp with time zone | ✓ | - |
| documents_created | integer | bigint | ✓ | - |

---

### 269. `multi_source_tenders`

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
| tender_id | string | uuid | ✓ | Note:
This is a Foreign Key to `tenders.id`.<fk table='tenders' column='id'/> |
| source_id | string | uuid | ✓ | Note:
This is a Foreign Key to `integration_sources.id`.<fk table='integration_sources' column='id'/> |
| external_id | string | character varying | ✗ | - |
| source_system | string | character varying | ✗ | - |
| source_data | unknown | jsonb | ✗ | - |
| transformed_data | unknown | jsonb | ✓ | - |
| data_quality_score | number | numeric | ✓ | - |
| conflict_resolution | string | character varying | ✓ | - |
| last_conflict_at | string | timestamp with time zone | ✓ | - |
| conflict_notes | string | text | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 270. `notifications`

**Description:** User notifications for tender opportunities and system alerts

**Scripts Using This Table:** 2

1. `server/src/routes/tender-integration-routes.js`
2. `server/src/services/tender-integration-service.js`

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
| user_id | string | character varying | ✗ | - |
| type | string | character varying | ✓ | - |
| title | string | character varying | ✓ | - |
| message | string | text | ✓ | - |
| data | unknown | jsonb | ✓ | Additional structured data for notifications (e.g., tender details, monitor info) |
| is_read | boolean | boolean | ✓ | - |
| read_at | string | timestamp with time zone | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 271. `numbering_config`

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
| organization_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| config | unknown | jsonb | ✗ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 272. `numbering_methodologies`

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
| description | string | text | ✓ | - |
| organization_id | string | uuid | ✗ | - |
| pattern_template | string | text | ✗ | - |
| is_default | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 273. `numbering_patterns`

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
| description | string | text | ✓ | - |
| organization_id | string | uuid | ✗ | - |
| pattern | string | text | ✗ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---

### 274. `operations_equipment`

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
| name | string | text | ✗ | - |
| type | string | text | ✗ | - |
| specifications | unknown | jsonb | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 275. `order_derived_template_usage`

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
| template_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_templates.id`.<fk table='procurement_templates' column='id'/> |
| order_id | string | uuid | ✓ | Note:
This is a Foreign Key to `procurement_orders.id`.<fk table='procurement_orders' column='id'/> |
| user_id | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| action_type | string | character varying | ✓ | - |
| time_saved_minutes | integer | integer | ✓ | - |
| fields_modified | unknown | jsonb | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |

---

### 276. `organisations_backup`

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
| id | integer | integer | ✓ | - |
| name | string | character varying | ✓ | - |
| sector_id | string | uuid | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| is_template | boolean | boolean | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| uuid | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 277. `organization_collaborations`

**Description:** Defines collaborations between organizations for cross-organizational accordion sharing

**Scripts Using This Table:** 3

1. `server/src/routes/accordion-collaboration-routes.js`
2. `server/src/routes/accordion-sections-routes.js`
3. `test/debug/integration/test-page-precedence.js`

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
| primary_organization_id | string | uuid | ✗ | The organization that owns the primary accordion structure

Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| collaborating_organization_id | string | uuid | ✗ | The organization that collaborates with the primary organization

Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| shared_sections | array | text[] | ✓ | Array of section IDs that are shared between organizations |
| agent_sharing_permissions | array | text[] | ✓ | Array of agent IDs that can be shared between organizations |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| primary_org_supabase_config | unknown | jsonb | ✓ | Supabase configuration for the primary organization (cached for performance) |
| context_mapping | unknown | jsonb | ✓ | Mapping of sections to database contexts for this collaboration |
| page_precedence | string | text | ✓ | Determines which organization's pages take precedence when there are conflicts: 'host' or 'collaborator' |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 278. `organization_db_configs`

**Description:** View of organizations with valid Supabase database configurations for multi-database context switching

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
| id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| name | string | character varying | ✓ | - |
| supabase_url | string | text | ✓ | - |
| supabase_anon_key | string | text | ✓ | - |
| supabase_service_key | string | text | ✓ | - |
| is_active | boolean | boolean | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |

---

### 279. `organization_users`

**Scripts Using This Table:** 12

1. `check_existing_users.js`
2. `fix_user_loading_gracefully.js`
3. `tests/e2e/complete-procurement-workflow.e2e.test.js`
4. `tests/fixtures/data/test-data-population.js`
5. `tests/integration/error-handling-recovery.test.js`
6. `tests/phase3-advanced-testing.js`
7. `tests/phase3-fixed-tests.js`
8. `tests/test-data-population-fixed.js`
9. `tests/test-data-rls-compliant.js`
10. `tests/test-data-working.js`
11. `tests/unit/user-assignment-logic.test.js`
12. `update_user_management_departments.js`

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
| organization_id | string | uuid | ✗ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| user_id | string | uuid | ✗ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| discipline_id | string | uuid | ✗ | Note:
This is a Foreign Key to `disciplines.id`.<fk table='disciplines' column='id'/> |
| role | string | character varying | ✓ | - |
| status | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |
| updated_by | string | uuid | ✓ | Note:
This is a Foreign Key to `user_management.user_id`.<fk table='user_management' column='user_id'/> |

---

### 280. `organizations`

**Scripts Using This Table:** 28

1. `create_logistics_data_for_test_orders.js`
2. `debug_project_fallback.js`
3. `diagnose_form_insert.js`
4. `gather_database_info.js`
5. `isolate_specific_error.js`
6. `recreate_discipline.js`
7. `server/api/process/index.js`
8. `server/insert_mock_procurement_orders.js`
9. `server/seed_epcm_disciplines.js`
10. `server/src/controllers/aiDocumentAnalysisController.js`
11. `server/src/controllers/organizations.js`
12. `server/src/controllers/procurementController.js`
13. `server/src/routes/accordion-collaboration-routes.js`
14. `server/src/routes/accordion-sections-routes.js`
15. `server/src/tests/procurement-templates.test.js`
16. `test/debug/check-existing-schema.js`
17. `test/debug/debug_project_fallback.js`
18. `test/debug/integration/test-dynamic-accordion-system.js`
19. `test/debug/integration/test-epcm-data-investigation.js`
20. `test/debug/integration/test-page-precedence.js`
21. `tests/fixtures/data/test-data-population.js`
22. `tests/phase3-advanced-testing.js`
23. `tests/phase4-end-to-end-testing.js`
24. `tests/simple-procurement-test.js`
25. `tests/simple-test.js`
26. `tests/test-data-population-fixed.js`
27. `tests/test-data-rls-compliant.js`
28. `tests/test-data-working.js`

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
| name | string | character varying | ✗ | - |
| sector_id | string | uuid | ✓ | Note:
This is a Foreign Key to `sectors.sector_id`.<fk table='sectors' column='sector_id'/> |
| is_active | boolean | boolean | ✓ | - |
| is_template | boolean | boolean | ✓ | - |
| created_at | string | timestamp without time zone | ✓ | - |
| updated_at | string | timestamp without time zone | ✓ | - |
| id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| supabase_url | string | text | ✓ | Supabase project URL for this organization |
| supabase_anon_key | string | text | ✓ | Supabase anonymous key for this organization |
| supabase_service_key | string | text | ✓ | Supabase service key for this organization (server-side operations) |
| organization_id | string | uuid | ✓ | - |
| user_id | string | uuid | ✓ | - |

---

### 281. `page_permissions`

**Scripts Using This Table:** 1

1. `server/src/routes/page-permissions-routes.js`

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
| page_path | string | text | ✗ | - |
| role_id | integer | integer | ✗ | Note:
This is a Foreign Key to `role_definitions.id`.<fk table='role_definitions' column='id'/> |
| has_access | boolean | boolean | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| created_by | string | text | ✓ | - |
| updated_by | string | text | ✓ | - |

---

### 282. `pages`

**Scripts Using This Table:** 86

1. `activate-main-directors.js`
2. `add-contracts-self-links.js`
3. `add-developer-standard-links.js`
4. `add-missing-directors-standard-links.js`
5. `analyze-accordion-schema.js`
6. `apply-accordion-hierarchy-enhancement.js`
7. `check-directors-data.js`
8. `clean-directors-fake-parents.js`
9. `clean-duplicate-contracts.js`
10. `clean-duplicate-directors.js`
11. `cleanup-contracts-structure.js`
12. `cleanup-it-section.js`
13. `compare-directors-hierarchy-with-docs.js`
14. `diagnose-accordion-issues.js`
15. `diagnose-accordion-standard-links.js`
16. `establish-agents-tracking-as-source-of-truth.js`
17. `final-contracts-cleanup.js`
18. `fix-accordion-comprehensive-issues.js`
19. `fix-all-section-hierarchies.js`
20. `fix-contracts-accordion-structure.js`
21. `fix-design-comprehensive.js`
22. `fix-design-duplicate.js`
23. `fix-directors-hierarchy-to-match-docs.js`
24. `fix-directors-hierarchy.js`
25. `fix-directors-parent-relationships.js`
26. `fix-directors-section-hierarchy.js`
27. `fix-it-section-careful.js`
28. `fix-it-section-structure.js`
29. `fix-pc-duplicate.js`
30. `populate-agent-modal-assignments.js`
31. `run-accordion-hierarchy-fix.js`
32. `scripts/analyze-sector-organization-combinations.js`
33. `scripts/check-pages-schema.js`
34. `scripts/create-missing-document-stores.js`
35. `scripts/fix-organization-id-column.js`
36. `scripts/generate-organization-uuids.js`
37. `scripts/insert_pages.js`
38. `scripts/insert_pages_fixed.js`
39. `scripts/inspect-pages-table.js`
40. `scripts/migrate-organization-id-to-uuid.js`
41. `server/scripts/apply-organisation-ids-migration.js`
42. `server/seed_epcm_disciplines.js`
43. `server/src/controllers/organizations.js`
44. `server/src/middlewares/validateDiscipline.js`
45. `server/src/routes/accordion-sections-routes.js`
46. `server/src/routes/organizations.js`
47. `server/src/routes/pages-routes.js`
48. `server/src/routes/section-creator.js`
49. `server/src/routes/sector-management-routes.js`
50. `test/debug/api/test-actual-api-output.js`
51. `test/debug/api/test-complete-api-transformation.js`
52. `test/debug/api/test-fixed-api-transformation.js`
53. `test/debug/check-active-directors.js`
54. `test/debug/check-all-directors-pages.js`
55. `test/debug/check-all-pages.js`
56. `test/debug/check-contracts-complete-structure.js`
57. `test/debug/check-contracts-pages.js`
58. `test/debug/check-design-detailed.js`
59. `test/debug/check-design-pages.js`
60. `test/debug/check-developer-links-detailed.js`
61. `test/debug/check-developer-structure-intended.js`
62. `test/debug/check-existing-schema.js`
63. `test/debug/check-fake-parent.js`
64. `test/debug/check-inactive-pages.js`
65. `test/debug/check-it-detailed.js`
66. `test/debug/check-main-directors.js`
67. `test/debug/check-pages-in-supabase.js`
68. `test/debug/check-pages-schema.js`
69. `test/debug/check-parent-page.js`
70. `test/debug/check-pc-detailed.js`
71. `test/debug/check-project-controls-pages.js`
72. `test/debug/check-real-parents.js`
73. `test/debug/integration/test-contracts-accordion-hierarchy.js`
74. `test/debug/integration/test-directors-accordion-fix.js`
75. `test/debug/integration/test-dynamic-accordion-system.js`
76. `test/debug/integration/test-epcm-data-investigation.js`
77. `test/debug/integration/test-organization-filtering-accordion.js`
78. `test/debug/integration/test-pages-table-investigation.js`
79. `test/debug/integration/test-pure-supabase-accordion.js`
80. `update-accordion-routes.js`
81. `updated-accordion-routes.js`
82. `verify-accordion-fix.js`
83. `verify-accordion-hierarchy.js`
84. `verify-contracts-fix.js`
85. `verify-it-section-hierarchy.js`
86. `verify-section-hierarchies.js`

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
| page_id | string | uuid | ✗ | Note:
This is a Primary Key.<pk/> |
| page_prefix | string | character varying | ✗ | Page prefix - up to 6 characters (e.g., 00100, E00200, D00300) |
| page_name | string | character varying | ✗ | - |
| page_slug | string | character varying | ✗ | - |
| sector_id | string | uuid | ✓ | Note:
This is a Foreign Key to `sectors.sector_id`.<fk table='sectors' column='sector_id'/> |
| organization_id | string | uuid | ✓ | UUID of the organization this page belongs to (references organizations.id)

Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| organisation_name | string | character varying | ✓ | - |
| sector_name | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✗ | - |
| updated_at | string | timestamp with time zone | ✗ | - |
| display_order | integer | integer | ✓ | - |
| parent_page_id | string | uuid | ✓ | Note:
This is a Foreign Key to `pages.page_id`.<fk table='pages' column='page_id'/> |
| organisation_id | string | uuid | ✓ | DEPRECATED: Contains sector UUID - use sector_uuid instead

Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| sector_uuid | string | uuid | ✓ | UUID of the sector for this page

Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| is_active | boolean | boolean | ✓ | Whether this page is active |
| hierarchy_level | integer | integer | ✓ | Level in the hierarchy (0 = top level, 1 = subsection, etc.) |
| is_standard_link | boolean | boolean | ✓ | Whether this is a standard link (e.g., All Documents, Email Management) |
| is_virtual | boolean | boolean | ✓ | Whether this is a virtual page (not directly linked to a folder) |
| organisation_ids | array | text[] | ✓ | Array of organization IDs that this page belongs to - supports multi-organization access control |

---

### 283. `pages_directors_backup_20250726`

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
| page_id | string | uuid | ✓ | - |
| page_prefix | string | character varying | ✓ | - |
| page_name | string | character varying | ✓ | - |
| page_slug | string | character varying | ✓ | - |
| sector_id | string | uuid | ✓ | - |
| organization_id | string | uuid | ✓ | - |
| organisation_name | string | character varying | ✓ | - |
| sector_name | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| display_order | integer | integer | ✓ | - |
| parent_page_id | string | uuid | ✓ | - |
| organisation_id | string | uuid | ✓ | - |
| sector_uuid | string | uuid | ✓ | - |
| is_active | boolean | boolean | ✓ | - |

---

### 284. `pages_with_clear_columns`

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
| page_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| page_prefix | string | character varying | ✓ | - |
| page_name | string | character varying | ✓ | - |
| page_slug | string | character varying | ✓ | - |
| sector_id | string | uuid | ✓ | Note:
This is a Foreign Key to `sectors.sector_id`.<fk table='sectors' column='sector_id'/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| sector_uuid | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| old_sector_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| organisation_name | string | character varying | ✓ | - |
| sector_name | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| display_order | integer | integer | ✓ | - |
| parent_page_id | string | uuid | ✓ | Note:
This is a Foreign Key to `pages.page_id`.<fk table='pages' column='page_id'/> |
| data_consistency | string | text | ✓ | - |

---

### 285. `pages_with_organization_mapping`

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
| page_id | string | uuid | ✓ | Note:
This is a Primary Key.<pk/> |
| page_prefix | string | character varying | ✓ | - |
| page_name | string | character varying | ✓ | - |
| page_slug | string | character varying | ✓ | - |
| sector_id | string | uuid | ✓ | Note:
This is a Foreign Key to `sectors.sector_id`.<fk table='sectors' column='sector_id'/> |
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| sector_uuid | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| old_sector_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| organisation_name | string | character varying | ✓ | - |
| sector_name | string | character varying | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |
| display_order | integer | integer | ✓ | - |
| parent_page_id | string | uuid | ✓ | Note:
This is a Foreign Key to `pages.page_id`.<fk table='pages' column='page_id'/> |
| organization_name | string | character varying | ✓ | - |
| sector_name_clear | string | character varying | ✓ | - |

---

### 286. `path_configurations`

**Description:** Template configurations for generating document storage paths per organization

**Scripts Using This Table:** 1

1. `server/src/routes/path-configurations-routes.js`

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
| organization_id | string | uuid | ✓ | Note:
This is a Foreign Key to `organizations.id`.<fk table='organizations' column='id'/> |
| name | string | text | ✗ | - |
| components | unknown | jsonb | ✗ | JSON array defining path structure with placeholders for dynamic values |
| is_default | boolean | boolean | ✓ | Whether this is the default path configuration for the organization |
| created_by | string | uuid | ✓ | - |
| created_at | string | timestamp with time zone | ✓ | - |
| updated_at | string | timestamp with time zone | ✓ | - |

---


**📝 Generated**: 2026-01-07T04:37:25.062Z
**📊 Tables Documented**: 143
**🏗️ System**: Construct AI Database Schema - Part 2
