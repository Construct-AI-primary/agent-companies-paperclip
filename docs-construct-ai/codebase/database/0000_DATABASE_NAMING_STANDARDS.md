---
memory_layer: durable_knowledge
para_section: pages/codebase/database
gigabrain_tags: database, naming-standards, schema-design, data-management, supabase, postgresql, table-naming, column-naming, index-naming, constraint-naming, discipline-codes, vector-tables, foreign-keys, primary-keys, audit-columns, naming-conventions, database-standards, schema-validation, automated-enforcement, discipline-based-organization, scalable-naming, self-documenting-names, naming-validation, database-agent, supabase-agent, naming-patterns, database-objects, table-prefixes, column-types, index-strategies, constraint-types, view-naming, trigger-naming, database-governance, naming-compliance, schema-quality, database-performance
openstinger_context: database-standards, naming-conventions, schema-validation, database-governance, automated-enforcement, discipline-based-organization
last_updated: 2026-03-30
related_docs:
  - codebase/database/
  - codebase/procedures/agent-development/
  - disciplines/
---
# 0003_DATABASE_NAMING_STANDARDS.md - Database Naming Standards - Construct AI System Documentation

## Document Usage Guide

**🎯 This Document's Role**: Comprehensive naming standards for all database objects in the Construct AI database schema. **MANDATORY for all database development activities**.

**📚 Related Documents in Standards Ecosystem:**
- **`docs/standards/0002_FILE_NAMING_STANDARDS.md`** → File naming conventions (different from database naming)
- **`docs/standards/0000_AGENT_CODING_STANDARDS.md`** → AI agent development standards
- **`docs/standards/0001_PROMPT_TAGGING_STANDARDS.md`** → Prompt content standards

**🛡️ ENFORCED BY**: Supabase Table Creation Agent automatically validates and enforces these standards for all new database objects.

---

## Overview

This document establishes comprehensive naming standards for all database objects in the Construct AI system, ensuring consistency, maintainability, and efficient discovery across the database schema.

### **Key Principles**

#### **1. Consistent Naming Patterns**
- All database objects follow standardized patterns
- Patterns are enforced by automated validation tools
- Exceptions require documented justification and approval

#### **2. Self-Documenting Names**
- Object names clearly indicate purpose and content
- Abbreviations used consistently across all objects
- Names remain readable and understandable

#### **3. Scalability Considerations**
- Naming patterns support growing database schema
- Discipline-based organization for complex systems
- Hierarchical naming supports permission systems

### **Scope**
- **Applies to**: All tables, views, indexes, columns, constraints
- **Enforced by**: Supabase Table Creation Agent
- **Audited by**: Automated naming validation scripts
- **Excludes**: Framework-generated objects and temporary scratch tables

---

## Core Naming Patterns

### **1. Table Naming Convention**

#### **Primary Pattern: `{prefix}_{entity}_{descriptor}`**

##### **Prefix Categories**
- **`a_`** = Application tables (primary data persistence)
- **`t_`** = Temporary tables (session-based or ETL processing)
- **`v_`** = Materialized views (pre-computed results)
- **`m_`** = Migration tracking tables (system administration)

##### **Entity Types**

**Discipline-Specific Tables (Majority):**
```
Pattern: a_{discipline_code}_{entity}_{descriptor}
Examples:
├── a_01900_procurement_orders          -- Procurement orders
├── a_01900_procurement_contracts       -- Procurement contracts
├── a_00850_civileng_specifications      -- Civil engineering specifications
├── a_02400_safety_incidents            -- Safety incidents
├── a_01100_ethics_compliance_reports    -- Ethics compliance reports
└── a_02050_it_system_logs              -- IT system logs
```

**Core Application Tables:**
```
Pattern: a_{entity}_{descriptor}
Examples:
├── a_users                           -- User accounts
├── a_organizations                   -- Organizations
├── a_projects                        -- Projects
├── a_tasks                          -- Task management system
└── a_audit_logs                     -- System audit trail
```

**Relationship Tables:**
```
Pattern: a_{entity1}_{entity2}_{relation}
Examples:
├── a_users_projects_assignments      -- User-project assignment junction
├── a_projects_contracts_links        -- Project-contract relationships
└── a_tasks_users_assignments        -- Task-user assignments
```

##### **Vector Tables (AI Integration)**
Vector tables for AI embeddings follow strict discipline-based patterns:

```
Pattern: a_{discipline_code}_{entity}_vector
Examples:
├── a_01900_procurement_vector        -- Procurement-related vector embeddings
├── a_00850_civileng_vector          -- Civil engineering vector embeddings
├── a_02400_safety_vector            -- Safety vector embeddings
├── a_01100_ethics_vector            -- Ethics vector embeddings
└── a_02050_it_vector                -- IT vector embeddings
```

**✅ Automated Validation**
The Supabase Table Creation Agent validates vector table patterns using:
```javascript
// Vector table validation regex
const vectorPattern = /^a_\d{5}_[a-z]+_vector$/;
// Examples that PASS: a_01900_procurement_vector
// Examples that FAIL: procurement_vector_new, a_procurement_vector
```

**Temporary/ETL Tables:**
```
Pattern: t_{purpose}_{descriptor}
Examples:
├── t_session_cache                  -- User session caching
├── t_etl_processing_queue           -- ETL processing queue
├── t_monthly_reports_temp           -- Temporary report generation
└── t_bulk_import_staging           -- Bulk data import staging
```

### **2. Column Naming Convention**

#### **Standard Column Patterns**

**Primary Key Columns:**
```
{singular_table_entity}_id  (Serial/BigSerial)
Examples:
├── user_id                          -- Primary key for users table
├── project_id                       -- Primary key for projects table
├── procurement_order_id             -- Primary key for procurement_orders table
└── task_id                          -- Primary key for tasks table
```

**Foreign Key Columns:**
```
{referenced_table_entity}_id  (Matching foreign table type)
Examples:
├── user_id                          -- References users.user_id
├── created_by_user_id              -- References users.user_id (created by)
├── assigned_to_user_id             -- References users.user_id (assigned to)
├── organization_id                  -- References organizations.organization_id
└── project_id                      -- References projects.project_id
```

**Data Columns:**
```
{descriptor}_{data_type} or {entity}_{descriptor}
Examples:
├── first_name                       -- VARCHAR, person's first name
├── last_name                        -- VARCHAR, person's last name
├── email_address                    -- VARCHAR, email address
├── phone_number                     -- VARCHAR, phone number
├── is_active                        -- BOOLEAN, active status flag
├── created_at                       -- TIMESTAMPTZ, record creation timestamp
├── updated_at                       -- TIMESTAMPTZ, record modification timestamp
└── notes                            -- TEXT, additional notes/remarks
```

**Status and Type Columns:**
```
{entity}_status or {entity}_type
Examples:
├── user_status                      -- User account status
├── project_status                   -- Project status
├── task_status                      -- Task status
├── contract_type                    -- Type of contract
└── organization_role               -- User's role in organization
```

**Audit Columns (Standard):**
```
Standard audit columns on ALL tables:
├── created_by_user_id              -- UUID, REFERENCES users(user_id)
├── created_at                      -- TIMESTAMPTZ, DEFAULT NOW()
├── updated_by_user_id              -- UUID, REFERENCES users(user_id)
├── updated_at                      -- TIMESTAMPTZ, DEFAULT NOW()
├── deleted_by_user_id              -- UUID, REFERENCES users(user_id)
└── deleted_at                      -- TIMESTAMPTZ, soft delete timestamp
```

**Self-Referencing Columns:**
```
{entity}_{relationship}_{entity}_id
Examples:
├── parent_task_id                  -- Self-reference for task hierarchy
├── manager_user_id                 -- Self-reference for user hierarchy
├── root_organization_id            -- Self-reference for organization hierarchy
└── parent_category_id              -- Self-reference for category hierarchy
```

### **3. Index Naming Convention**

#### **Standard Index Patterns**

**Primary Key Indexes:**
```
{table_name}_pkey  (Generated by PostgreSQL)
Examples:
├── users_pkey                      -- Primary key index on users
├── projects_pkey                   -- Primary key index on projects
└── procurement_orders_pkey         -- Primary key index on procurement_orders
```

**Unique Indexes:**
```
idx_{table_name}_{column1}_{column2}_unique
Examples:
├── idx_users_email_unique          -- Unique index on users.email
├── idx_projects_code_unique        -- Unique index on projects.code
└── idx_procurement_orders_number_unique -- Unique index on procurement_orders.order_number
```

**Performance Indexes:**
```
idx_{table_name}_{column1}_{column2}
Examples:
├── idx_users_organization_id       -- Index on users.organization_id
├── idx_tasks_assigned_to_created_at -- Index on tasks(assigned_to_user_id, created_at)
├── idx_audit_logs_operation_at     -- Index on audit_logs(operation, created_at)
└── idx_procurement_orders_status   -- Index on procurement_orders.status
```

**Composite Indexes:**
```
idx_{table_name}_{col1}_{col2}_{col_n}
Examples:
├── idx_tasks_status_assigned_to    -- Index on tasks(status, assigned_to_user_id)
├── idx_projects_org_status         -- Index on projects(organization_id, status)
└── idx_audit_logs_user_timestamp   -- Index on audit_logs(user_id, created_at)
```

**Foreign Key Indexes:**
```
idx_{table_name}_{referenced_table}_{column}
Examples:
├── idx_tasks_assigned_to_user_id   -- FK index on tasks.assigned_to_user_id
├── idx_users_organization_id       -- FK index on users.organization_id
└── idx_procurement_orders_created_by -- FK index on procurement_orders.created_by_user_id
```

### **4. Constraint Naming Convention**

#### **Standard Constraint Patterns**

**Unique Constraints:**
```
{type}_{table_name}_{column1}_{column2}_unique
Examples:
├── uk_users_email                 -- Unique constraint on users.email
├── uk_projects_code               -- Unique constraint on projects.code
└── uk_procurement_orders_number   -- Unique constraint on procurement_orders.order_number
```

**Check Constraints:**
```
chk_{table_name}_{condition}_name
Examples:
├── chk_users_email_format         -- Email format validation
├── chk_projects_budget_positive   -- Budget > 0 validation
├── chk_tasks_status_valid         -- Valid status values
└── chk_contracts_value_range      -- Contract value within range
```

**Foreign Key Constraints:**
```
fk_{table_name}_{referenced_table}_{column}
Examples:
├── fk_users_organizations_org_id   -- FK from users to organizations
├── fk_tasks_users_assigned_to     -- FK from tasks to users
├── fk_procurement_orders_users_created_by -- FK from procurement_orders to users
└── fk_audit_logs_users_user_id    -- FK from audit_logs to users
```

### **5. View Naming Convention**

#### **Materialized View Patterns**

**Aggregate Views:**
```
v_{entity}_{calculation}
Examples:
├── v_users_department_counts      -- Count users by department
├── v_projects_status_summary      -- Project status aggregation
├── v_tasks_completion_rates       -- Task completion metrics
└── v_audit_logs_daily_summary     -- Daily audit log summary
```

**Filtered/Lookup Views:**
```
v_{entity}_{filter}_lookup
Examples:
├── v_users_active_lookup          -- Active users only
├── v_projects_current_lookup      -- Current projects only
├── v_tasks_pending_lookup         -- Pending tasks only
└── v_contracts_approved_lookup    -- Approved contracts only
```

**Reporting Views:**
```
v_{entity}_{frequency}_{metric}
Examples:
├── v_users_monthly_activity       -- Monthly user activity metrics
├── v_projects_quarterly_status    -- Quarterly project status
├── v_financial_monthly_summary    -- Monthly financial summary
└── v_audit_weekly_events          -- Weekly audit event summary
```

### **6. Trigger Naming Convention**

#### **Database Trigger Patterns**

```
trg_{table_name}_{action}_{purpose}
Examples:
├── trg_users_updated_at           -- Updates updated_at on row changes
├── trg_tasks_status_audit         -- Audits task status changes
├── trg_projects_validation        -- Validates project data integrity
└── trg_audit_logs_unchanging      -- Prevents audit log modifications
```

---

## Automated Enforcement

### **Supabase Table Creation Agent Validation**

The agent enforces naming standards through comprehensive validation:

```javascript
// Complete validation suite
class DatabaseNamingValidator {
  validateTableName(tableName) {
    const patterns = {
      // Discipline-specific: a_XXXXX_type_descriptor
      discipline: /^a_\d{5}_[a-z]+_[a-z_]+$/,
      // Core entity: a_entity_descriptor
      core: /^a_[a-z]+(_[a-z]+)*$/,
      // Relationship: a_entity1_entity2_relation
      relationship: /^a_[a-z]+_[a-z]+_[a-z]+$/,
      // Vector: a_XXXXX_entity_vector
      vector: /^a_\d{5}_[a-z]+_vector$/,
      // Temporary: t_purpose_descriptor
      temp: /^t_[a-z]+(_[a-z]+)*$/
    };

    for (const [type, pattern] of Object.entries(patterns)) {
      if (pattern.test(tableName)) {
        return { valid: true, type, pattern: pattern.source };
      }
    }

    return {
      valid: false,
      error: `Table name must follow naming conventions.`,
      suggestions: this.generateSuggestions(tableName)
    };
  }

  validateColumnName(columnName, context) {
    // Column validation logic...
  }

  validateIndexName(indexName, tableName, columns) {
    // Index validation logic...
  }
}
```

### **Validation Rules Summary**

#### **✅ Valid Examples**
```
✅ a_01900_procurement_orders         (Discipline + Entity)
✅ a_01900_procurement_vector         (Discipline + Vector)
✅ a_users                            (Core Entity)
✅ a_users_projects_assignments       (Relationship)
✅ t_session_cache                    (Temporary)
✅ v_active_users                     (View)
✅ idx_users_email_unique            (Index)
✅ fk_tasks_users_assigned_to         (Foreign Key)
```

#### **❌ Invalid Examples**
```
❌ procurement_orders                 (Missing prefix)
❌ a_procurement_orders               (Missing discipline code)
❌ a_01900_procurementOrders          (camelCase instead of snake_case)
❌ a_01900_procurement_orders_table   (Unnecessary 'table' suffix)
❌ users_backup                       (Missing prefix)
```

---

## Implementation Guidelines

### **1. New Table Creation**

#### **Required Steps**
1. **Define Purpose**: Clearly state table's business purpose
2. **Identify Discipline**: Determine appropriate discipline code
3. **Apply Naming Pattern**: Use appropriate pattern from standards
4. **Agent Validation**: Create via Supabase Table Creation Agent
5. **Documentation**: Record decision in system documentation

#### **Agent Usage**
```javascript
// All table creation must use the agent
const agent = new SupabaseTableCreationAgent();
await agent.createTable('a_01900_procurement_orders', schema);
```

### **2. Schema Migration**

#### **Existing Tables**
- **Current tables remain unchanged** (450+ tables in production)
- **New naming applies only to new tables**
- **Legacy table analysis optional** (not required for existing schema)

#### **Migration Strategy**
- **Do not rename existing tables** (high risk, low value)
- **Document learning opportunities** from existing inconsistencies
- **Apply standards going forward** only

### **3. Team Adoption**

#### **Developer Guidelines**
1. **Review Standards**: Read this document before database development
2. **Use Agent**: Always create tables via Supabase Table Creation Agent
3. **Validation First**: Agent validates before any database operations
4. **Documentation**: Record naming decisions for complex cases

#### **Code Review Checklist**
- [ ] Agent used for table creation
- [ ] Naming follows established patterns
- [ ] Discipline codes correctly assigned
- [ ] Proper column naming conventions
- [ ] Indexes and constraints named correctly

---

## Discipline Code Reference

### **Construct AI Discipline Codes**

| Discipline | Code | Example Tables |
|------------|------|----------------|
| Procurement | 01900 | `a_01900_procurement_orders` |
| Safety | 02400 | `a_02400_safety_incidents` |
| Ethics | 01100 | `a_01100_ethics_reports` |
| Civil Engineering | 00850 | `a_00850_civileng_specs` |
| IT | 02050 | `a_02050_it_system_logs` |
| Governance | 01300 | `a_01300_governance_documents` |
| Finance | 01200 | `a_01200_finance_records` |
| HR | 01500 | `a_01500_hr_candidates` |
| Legal | 01750 | `a_01750_legal_reviews` |
| Operations | 01800 | `a_01800_operations_assets` |
| Logistics | 01700 | `a_01700_logistics_shipments` |
| Environmental | 01000 | `a_01000_environmental_reports` |
| Quality | 02200 | `a_02200_quality_inspections` |
| Project Controls | 02000 | `a_02000_projctrl_reports` |
| Communications | 02100 | `a_02100_comm_press_releases` |
| Director Roles | 0088X | `a_00880_dirboard_meetings` |

**Complete discipline code list**: Reference EPCM discipline standards for latest codes.

---

## Quality Assurance

### **Automated Quality Gates**

#### **Development Time Validation**
- **Agent Integration**: Built into Supabase Table Creation Agent
- **Pre-commit Hooks**: Database validation scripts
- **CI/CD Gates**: Automated schema validation pipelines

#### **Agent Validation Features**
```javascript
// Quality assurance features
class DatabaseQualityAssurance {
  async validateSchema(schema) {
    // Name validation
    const namingValidation = this.validateAllNames(schema);

    // Structural validation
    const structuralValidation = this.validateStructure(schema);

    // Performance validation
    const performanceValidation = this.validatePerformanceIndexes(schema);

    return {
      naming: namingValidation,
      structure: structuralValidation,
      performance: performanceValidation
    };
  }
}
```

### **Code Review Requirements**

#### **Database Naming Checklist**
- [ ] **Prefix Correct**: Appropriate prefix (a_, t_, v_, etc.)
- [ ] **Discipline Code**: Valid 5-digit discipline code for domain-specific tables
- [ ] **Entity Descriptive**: Entity name clearly describes content
- [ ] **snake_case**: Under_score_notation (not camelCase or PascalCase)
- [ ] **No Plurals in Base**: Use singular nouns for base entity names
- [ ] **Suffix Appropriate**: Action or descriptor suffixes where needed
- [ ] **Agent Created**: Table created via Supabase Table Creation Agent

#### **Performance Validation**
- [ ] **Primary Key**: Proper primary key definition
- [ ] **Indexes**: Foreign keys indexed, performance indexes defined
- [ ] **Constraints**: Appropriate UNIQUE, CHECK, and FK constraints
- [ ] **Audit Columns**: Standard audit columns present (created_by, etc.)

---

## Success Metrics

### **Compliance Metrics**
- **Target**: >98% of new tables follow naming standards (agent-enforced)
- **Measurement**: Agent usage logs and schema analysis
- **Reporting**: Monthly compliance reports via agent metrics

### **Adoption Metrics**
- **Target**: 100% table creation via Supabase Table Creation Agent
- **Measurement**: Agent operation logs
- **Trends**: Percentage of compliant new database objects

### **Quality Metrics**
- **Target**: <2% schema-related bugs caused by naming issues
- **Measurement**: Database incident reports and resolution time
- **Efficiency**: Time to discover tables/objects in database

---

## Related Procedures and Standards

### **Core Standards Documents**
- **`docs/standards/0000_AGENT_CODING_STANDARDS.md`** → AI agent development standards
- **`docs/standards/0002_FILE_NAMING_STANDARDS.md`** → File naming conventions (different scope)
- **`docs/standards/0001_PROMPT_TAGGING_STANDARDS.md`** → Prompt content standards

### **Implementation Procedures**
- **`docs/procedures/database/0000_SUPABASE_AGENT_PROCEDURE.md`** → Agent usage guide
- **`docs/roles/agent-development/0000_ROLES_AGENT_IMPLEMENTATION_PROCEDURE.md`** → RBAC integration
- **`docs/workflow/0000_WORKFLOW_TASK_PROCEDURE.md`** → Task notification integration

### **Quality and Validation Procedures**
- **`docs/implementation/0000_SCHEMA_DEPLOYMENT_PROCEDURE.md`** → Schema deployment procedures
- **`docs/testing/0000_DATABASE_TESTING_PROCEDURE.md`** → Database testing procedures
- **`docs/monitoring/0000_DATABASE_MONITORING_PROCEDURE.md`** → Database performance monitoring

---

## Document Information

- **Document ID**: `0003_DATABASE_NAMING_STANDARDS`
- **Version**: 1.0
- **Created**: 2026-02-03
- **Last Updated**: 2026-02-03
- **Author**: Construct AI Development Team
- **Review Cycle**: Quarterly
- **Related Documents**:
  - `0000supabase-table-creation-agent/`
  - `inter-roles-agent-implementation-procedure.md`
  - `0000-javascript-data-population-procedure.md`
  - `0000-workflow-task-procedure.md`

---

**🎯 Key Takeaway**: These standards are enforceable through the Supabase Table Creation Agent for all new database objects. Use the agent for all table creation to ensure compliance and quality.