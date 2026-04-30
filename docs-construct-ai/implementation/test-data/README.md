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

# Test Data Generation Framework

This directory contains comprehensive test data generation for the Construct AI system, specifically focused on the 01900 Procurement workflow as a primary example.

## Directory Structure

```
docs/implementation/test-data/
├── procurement/              # Procurement workflow test data
│   ├── tables/             # Individual table data files
│   ├── relationships/      # Foreign key relationships
│   ├── indexes/           # Index-specific data
│   ├── chatbots/          # Chatbot configurations
│   ├── templates/         # Template system data
│   ├── policies/          # RLS policies and permissions
│   └── fixes/             # Maintenance and fix scripts
├── users/                  # User management test data
├── organizations/          # Organization structures
├── workflows/             # Workflow-specific data
└── generated/             # Final compiled datasets
    └── complete-dataset.json  # Comprehensive test dataset
```

## Usage Instructions

### For Client Installations

1. **Load Complete Dataset**: Use `generated/complete-dataset.json` for full system setup
2. **Selective Loading**: Use individual table files for specific workflow testing
3. **Relationship Validation**: Check `relationships/` files for foreign key dependencies

### For Development

1. **Schema-Driven Generation**: Follow procedures in `1300_TEST_DATA_GENERATION_PROCEDURE.md`
2. **Incremental Updates**: Add new records to existing files following established patterns
3. **Validation**: Use built-in validation scripts to ensure data integrity

## Data Quality Standards

- **Minimum Records**: 10+ records per table
- **Relationship Integrity**: All foreign keys properly linked
- **Realistic Data**: Business-realistic values and patterns
- **Anonymization**: No real sensitive information
- **Schema Compliance**: Matches database schema exactly

## Test Data Categories

### Core Procurement Data
- Procurement orders with realistic business scenarios
- Template system with multiple document types
- Task management with proper workflow states
- User assignments with discipline mapping

### Support Data
- User management with role-based access
- Organization structures with proper hierarchies
- Chatbot configurations for AI assistance
- RLS policies for security compliance

### Agent Workflow Data
- 6-Agent Procurement workflow execution data
- Specialist agent configurations
- Performance metrics and analytics
- Integration test scenarios

## File Formats & Conversion Strategy

### **Primary Approach: JavaScript Scripts**
- **JavaScript**: Primary format for Supabase/RLS environments
- **JSON**: Data structure definitions and examples
- **SQL**: Legacy files (being converted to JavaScript)

### **SQL to JavaScript Conversion Status**

**✅ CONVERTED:**
- `populate-users.js` - User management population with RLS compliance
- `populate-procurement-orders.js` - Procurement orders with proper relationships
- `populate-agent-workflow-executions.js` - Agent workflow executions

**🔄 PENDING CONVERSION:**
- `user_management.sql` → `populate-user-management.js`
- `templates.sql` → `populate-templates.js`
- `procurement_orders.sql` → `populate-procurement-orders.js` (partial)
- `tasks.sql` → `populate-tasks.js`
- `agent_workflow_executions.sql` → `populate-agent-workflow-executions.js` (partial)
- `document_variations.sql` → Already converted
- `document_variation_sections.sql` → Already converted

**📋 See:** `docs/implementation/test-data/procurement/tables/README.md` for detailed conversion strategy and templates.

## Data Retention and Maintenance Strategy

### Schema Documentation Approach

**🔗 Reference-Based (Recommended):**
- **Link to Live Schema**: Reference current schema documentation rather than duplicating
- **Sample Structures**: Keep representative data examples for common patterns
- **Change Logs**: Document schema evolution and migration points
- **Validation Rules**: Maintain constraint summaries for data population

**✅ Benefits:**
- No outdated documentation
- Single source of truth for schema
- Easier maintenance and updates
- Automatic synchronization with schema changes

### 📚 **Essential Schema Cross-References**

**For Test Data Development - Always Reference These:**

#### **📋 Master Schema Guide**
- **[0300_DATABASE_SCHEMA_MASTER_GUIDE.md](../schema/0300_DATABASE_SCHEMA_MASTER_GUIDE.md)** - Complete database architecture and table relationships

#### **🔍 Schema Indexes**
- **[index-table.md](../schema/index-table.md)** - Direct links to all schema part files with table names
- **[index-pages.md](../schema/index-pages.md)** - Page-specific schema documentation
- **[index-chatbots.md](../schema/index-chatbots.md)** - Chatbot and AI system schemas

#### **📄 Schema Parts**
- **[schema-part-01.md](../schema/schema-part-01.md)** - Core tables (users, organizations, disciplines)
- **[schema-part-02.md](../schema/schema-part-02.md)** - Workflow and process tables
- **[schema-part-03.md](../schema/schema-part-03.md)** - Vector and AI tables
- **[schema-part-04.md](../schema/schema-part-04.md)** - Integration and external system tables

#### **🔧 Quick Reference Guides**
- **[constraint-quick-reference.md](../schema/constraint-quick-reference.md)** - Common constraint violations and fixes
- **[data-validation-templates.md](../schema/data-validation-templates.md)** - Pre-validated data structures
- **[rls-policy-quick-reference.md](../schema/rls-policy-quick-reference.md)** - Multi-tenant access rules

**💡 Pro Tip:** Always check these schema references before writing test data scripts to ensure proper table structures, constraints, and RLS policies.

### Data Retention Strategy

**📊 Keep Current + Historical Samples:**
- **Current Examples**: Representative data for each table type
- **Pattern Library**: Common data structures and relationships
- **Edge Cases**: Special scenarios and boundary conditions
- **Archived Versions**: Major schema changes with timestamps

**📁 File Organization:**
```
tables/
├── current/           # Current representative data
│   ├── procurement_orders.json
│   ├── users.json
│   └── templates.json
├── patterns/          # Common data patterns
│   ├── user_role_assignments.json
│   ├── workflow_sequences.json
│   └── relationship_examples.json
└── archive/           # Historical versions
    ├── 2025-12-01/
    └── 2026-01-15/
```

### Maintenance Cadence

**Weekly:**
- Review generated datasets for accuracy
- Update sample data with new business scenarios
- Verify relationships remain valid

**Monthly:**
- Audit against current schema changes
- Update constraint validations
- Review fix scripts applicability

**Quarterly:**
- Major version archives for significant changes
- Performance benchmark updates
- Documentation refresh

### Quality Assurance

**Data Freshness Checks:**
- Schema alignment verification
- Relationship integrity testing
- Business rule compliance
- Performance benchmark validation

**Archival Strategy:**
- Keep 6 months of historical samples
- Archive major schema changes permanently
- Document migration paths between versions

This test data framework ensures systematic, repeatable data generation for comprehensive workflow testing and client installations.
