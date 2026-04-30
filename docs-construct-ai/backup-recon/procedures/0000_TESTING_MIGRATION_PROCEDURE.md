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

# Migration Testing Protocol

## Overview

This protocol establishes mandatory testing procedures for database migrations to prevent production failures and ensure data integrity.

## Testing Levels

### Level 1: Unit Testing (Required)

**Before any migration deployment:**

```bash
# 1. Syntax validation
psql -d "$TEST_DATABASE_URL" -f migration.sql --dry-run

# 2. Basic execution test
psql -d "$TEST_DATABASE_URL" -f migration.sql

# 3. Rollback capability test
psql -d "$TEST_DATABASE_URL" -f rollback_migration.sql

# 4. Schema consistency validation
psql -d "$TEST_DATABASE_URL" -f schema_validation.sql
```

### Level 2: Integration Testing (Required)

**Test migration in isolated environment:**

```bash
# 1. Create test database snapshot
pg_dump "$PROD_DATABASE_URL" | psql "$TEST_DATABASE_URL"

# 2. Run migration on test data
psql -d "$TEST_DATABASE_URL" -f migration.sql

# 3. Validate data integrity
psql -d "$TEST_DATABASE_URL" -f validation_queries.sql

# 4. Performance impact assessment
psql -d "$TEST_DATABASE_URL" -f performance_test.sql

# 5. Application API testing (NEW)
npm run test:unit -- --migration-mode

# 6. RLS policy validation (NEW)
npm run test:rls-validation
```

### Level 3: Production Simulation (High-Risk Migrations)

**For migrations affecting >1000 rows or critical tables:**

```bash
# 1. Production replica testing
psql -d "$PROD_REPLICA_URL" -f migration.sql

# 2. Application compatibility testing
npm test -- --migration-test

# 3. Load testing with migration
k6 run migration_load_test.js

# 4. API endpoint regression testing (NEW)
npm run test:api-regression

# 5. End-to-end workflow testing (NEW)
npm run test:e2e -- --migration-validation

# 6. Failover scenario testing
# Simulate migration failure and recovery
```

## Schema Documentation References

### Essential Schema Documentation Files

**📋 Core Schema References for Migration Testing:**

#### **Master Schema Guides**
- **[0300_DATABASE_SCHEMA_MASTER_GUIDE.md](../schema/0300_DATABASE_SCHEMA_MASTER_GUIDE.md)** - Master guide for database schema architecture and design patterns
- **[current-full-schema.md](../schema/current-full-schema.md)** - Authoritative current schema reference with all tables, columns, and relationships
- **[schema-part-01.md](../schema/schema-part-01.md)** - Core schema components and table definitions
- **[schema-part-02.md](../schema/schema-part-02.md)** - Advanced schema features and relationships
- **[schema-part-03.md](../schema/schema-part-03.md)** - Schema extensions and specialized tables

#### **Schema Management Scripts**
- **[update_schema.js](../schema/update_schema.js)** - Automated schema update utilities
- **[current-full-schema.sql](../schema/current-full-schema.sql)** - Executable SQL schema dump for validation
- **[extract_schema.sql](../schema/extract_schema.sql)** - Schema extraction queries
- **[run_schema_update.sh](../schema/run_schema_update.sh)** - Schema update automation script

#### **Migration-Specific References**
- **[0300_PROCUREMENT_TEMPLATES_TO_UNIFIED_MIGRATION.md](../0300_PROCUREMENT_TEMPLATES_TO_UNIFIED_MIGRATION.md)** - Template table unification migration guide
- **JavaScript Data Population Procedures**: See [0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md](../procedures/0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md)

### Schema Validation Workflow

**Pre-Migration Schema Review:**
```bash
# 1. Review current schema architecture
cat docs/schema/0300_DATABASE_SCHEMA_MASTER_GUIDE.md

# 2. Check current full schema reference
head -50 docs/schema/current-full-schema.md

# 3. Validate table relationships
grep -A 10 "Foreign Keys" docs/schema/current-full-schema.md

# 4. Review RLS policies
grep -A 5 "RLS Policies" docs/schema/current-full-schema.md
```

**Post-Migration Schema Validation:**
```bash
# 1. Extract updated schema
node docs/schema/extract_schema.js

# 2. Validate against master guide
# Compare migration changes with 0300_DATABASE_SCHEMA_MASTER_GUIDE.md

# 3. Update schema documentation
# Ensure current-full-schema.md reflects migration changes
```

## Migration Complexity Assessment

### Risk Levels

| **Risk Level** | **Criteria** | **Testing Required** |
|----------------|-------------|---------------------|
| **Low** | < 10 affected rows, simple DDL | Level 1 only |
| **Medium** | 10-1000 rows, single table | Level 1 + 2 |
| **High** | >1000 rows, multiple tables | Level 1 + 2 + 3 |
| **Critical** | Core business tables, financial data | Level 1 + 2 + 3 + Manual Review |

### Complexity Metrics

```sql
-- Calculate migration complexity score
DO $$
DECLARE
    affected_tables INTEGER;
    affected_rows INTEGER;
    ddl_operations INTEGER;
    complexity_score INTEGER := 0;
BEGIN
    -- Count affected tables
    SELECT COUNT(DISTINCT table_name) INTO affected_tables
    FROM migration_impact_analysis;

    -- Estimate affected rows
    SELECT SUM(estimated_rows) INTO affected_rows
    FROM migration_impact_analysis;

    -- Count DDL operations
    SELECT COUNT(*) INTO ddl_operations
    FROM migration_ddl_operations;

    -- Calculate complexity score
    complexity_score := (affected_tables * 10) + (affected_rows / 100) + (ddl_operations * 5);

    -- Determine risk level
    CASE
        WHEN complexity_score < 50 THEN RAISE NOTICE 'LOW RISK migration';
        WHEN complexity_score < 200 THEN RAISE NOTICE 'MEDIUM RISK migration';
        WHEN complexity_score < 500 THEN RAISE NOTICE 'HIGH RISK migration';
        ELSE RAISE NOTICE 'CRITICAL RISK migration - Full review required';
    END CASE;

    RAISE NOTICE 'Complexity Score: %', complexity_score;
END $$;
```

## Pre-Deployment Checklist

### Development Phase
- [ ] Migration follows defensive template pattern
- [ ] PostgreSQL-specific requirements checked
- [ ] Type consistency validated across tables
- [ ] Rollback script prepared and tested
- [ ] Documentation updated

### Testing Phase
- [ ] Unit tests pass on migration
- [ ] Integration tests pass
- [ ] Performance benchmarks met
- [ ] Data integrity validation passes
- [ ] Application compatibility confirmed

### Deployment Phase
- [ ] Backup created and verified
- [ ] Deployment window scheduled
- [ ] Rollback plan documented
- [ ] Monitoring alerts configured
- [ ] Communication plan ready

## Automated Validation Scripts

### Schema Consistency Check

```sql
-- Validate type consistency across related tables
CREATE OR REPLACE FUNCTION validate_schema_consistency(
    p_table_pattern TEXT DEFAULT '%'
) RETURNS TABLE (
    table_name TEXT,
    column_name TEXT,
    data_type TEXT,
    consistency_status TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        t.table_name,
        c.column_name,
        c.data_type,
        CASE
            WHEN c.data_type = 'uuid' THEN 'CONSISTENT'
            WHEN c.data_type = 'integer' THEN 'CHECK_REQUIRED'
            ELSE 'REVIEW_NEEDED'
        END as consistency_status
    FROM information_schema.tables t
    JOIN information_schema.columns c ON t.table_name = c.table_name
    WHERE t.table_schema = 'public'
      AND t.table_name LIKE p_table_pattern
      AND c.column_name IN ('organisation_id', 'user_id', 'created_by')
    ORDER BY t.table_name, c.column_name;
END;
$$ LANGUAGE plpgsql;

-- Usage
SELECT * FROM validate_schema_consistency('a_%_vector');
```

### Migration Impact Analysis

```sql
-- Analyze potential migration impact
CREATE OR REPLACE FUNCTION analyze_migration_impact(
    p_migration_sql TEXT
) RETURNS TABLE (
    impact_type TEXT,
    affected_object TEXT,
    risk_level TEXT,
    mitigation_strategy TEXT
) AS $$
BEGIN
    -- This would parse the migration SQL and analyze impacts
    -- Simplified version for demonstration

    RETURN QUERY
    SELECT
        'TABLE_CREATION'::TEXT,
        'new_table'::TEXT,
        'LOW'::TEXT,
        'Standard creation pattern'::TEXT
    UNION ALL
    SELECT
        'INDEX_CREATION'::TEXT,
        'idx_new_table'::TEXT,
        'LOW'::TEXT,
        'Non-blocking index creation'::TEXT
    UNION ALL
    SELECT
        'RLS_POLICY'::TEXT,
        'row_security_policy'::TEXT,
        'MEDIUM'::TEXT,
        'Test policy evaluation'::TEXT;
END;
$$ LANGUAGE plpgsql;
```

## Emergency Procedures

### Migration Failure Response

1. **Immediate Actions:**
   ```bash
   # Stop application traffic if needed
   # Execute rollback script
   psql -d "$DATABASE_URL" -f rollback_migration.sql

   # Verify rollback success
   psql -d "$DATABASE_URL" -f validation_queries.sql
   ```

2. **Investigation:**
   ```bash
   # Check PostgreSQL logs
   tail -f /var/log/postgresql/postgresql.log

   # Analyze failed migration
   psql -d "$DATABASE_URL" -c "
   SELECT * FROM migration_audit_log
   WHERE created_at > NOW() - INTERVAL '1 hour'
   ORDER BY created_at DESC;
   "
   ```

3. **Recovery:**
   - Restore from backup if rollback fails
   - Apply hotfix migration if needed
   - Update incident response documentation

### Post-Mortem Requirements

After any migration failure:

1. **Root Cause Analysis:** Document what went wrong
2. **Prevention Measures:** Update procedures to prevent recurrence
3. **Testing Enhancement:** Add specific test case for the failure scenario
4. **Documentation Update:** Update migration template with lessons learned

## Success Metrics

### Migration Quality Metrics
- **Zero production rollbacks** in 6 months
- **100% test coverage** for migration logic
- **< 5 minute** average deployment time
- **99.9%** data integrity post-migration

### Process Compliance Metrics
- **100%** migrations follow template pattern
- **100%** migrations pass pre-deployment checklist
- **Zero** emergency deployments
- **Weekly** migration testing reviews

## Continuous Improvement

### Monthly Review Process
1. **Analyze past migrations** for patterns and issues
2. **Update testing protocols** based on lessons learned
3. **Enhance automation** for validation and monitoring
4. **Train team** on new procedures and tools

### Tool Enhancement
- **Automated complexity scoring**
- **Pre-deployment validation pipeline**
- **Real-time monitoring dashboards**
- **Automated rollback generation**

## Application-Level Testing Integration

### API Endpoint Regression Testing

**Validate API behavior after schema changes:**

```bash
# Test API endpoints affected by migration
npm run test:api-regression -- --migration-id=MIGRATION_001

# Validate GraphQL schema changes
npm run test:graphql-schema

# Test authentication and authorization
npm run test:auth-integration
```

### Unified Schema Migration Testing

**For migrations affecting the unified templates architecture:**

```bash
# Validate unified schema integrity
npm run test:unified-schema -- --migration-validation

# Test discipline-based filtering
npm run test:discipline-filtering

# Validate template associations
npm run test:template-associations

# Test appendix structure changes
npm run test:appendix-structure
```

### RLS Policy Testing

**Validate Row Level Security policy changes:**

```bash
# Test RLS policy enforcement
npm run test:rls-policies -- --organization-isolation

# Validate data access patterns
npm run test:data-access -- --rls-validation

# Test policy performance impact
npm run test:policy-performance

# Audit trail validation
npm run test:audit-trail -- --rls-changes
```

### JavaScript-Based Test Data Population

**Use our comprehensive test data framework:**

```javascript
// Pre-migration data population
import { populateTestData } from './tests/fixtures/data/test-data-population.js';
await populateTestData();

// Migration testing
// ... run migration ...

// Post-migration validation
import { validateMigrationImpact } from './tests/fixtures/utilities/test-helpers.js';
const impact = await validateMigrationImpact(migrationId);
console.log('Migration impact:', impact);

// Cleanup
await cleanupTestData();
```

### Performance Impact Assessment

**Comprehensive performance testing:**

```bash
# Establish pre-migration baselines
npm run benchmark:create -- --label=pre-migration

# Run migration
psql -d "$TEST_DATABASE_URL" -f migration.sql

# Performance regression testing
npm run test:performance-regression

# Load testing with new schema
npm run test:load-with-migration

# Query optimization validation
npm run test:query-performance -- --migration-impact
```

### CI/CD Pipeline Integration

**Automated migration testing in CI/CD:**

```yaml
# .github/workflows/migration-test.yml
name: Migration Testing Pipeline
on: [pull_request]

jobs:
  migration-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'

      - name: Setup test database
        run: npm run db:test-setup

      - name: Populate test data
        run: npm run data:populate

      - name: Run database migration
        run: npm run migration:up

      - name: Schema validation
        run: npm run test:schema-validation

      - name: API regression tests
        run: npm run test:api-regression

      - name: RLS policy tests
        run: npm run test:rls-validation

      - name: Performance baseline tests
        run: npm run test:performance-baseline

      - name: End-to-end workflow tests
        run: npm run test:e2e -- --migration-validation

      - name: Cleanup
        run: npm run data:cleanup
```

### Disaster Recovery Testing

**Test backup/restore procedures post-migration:**

```bash
# Create pre-migration backup
npm run backup:create -- --label=pre-migration-backup

# Run migration
psql -d "$DATABASE_URL" -f migration.sql

# Test disaster recovery
npm run test:disaster-recovery -- --migration-scenario

# Validate backup integrity
npm run backup:validate -- --migration-impact

# Performance testing on restored data
npm run test:performance -- --restored-data
```

### Migration-Specific Test Scenarios

#### Template Table Migration Testing

```javascript
describe('Template Table Migration', () => {
  it('should migrate procurement templates to unified schema', async () => {
    // Test data migration from separate tables to unified templates
    const migrationResult = await runMigration('0300_procurement_templates_unified');

    // Validate template data integrity
    const templates = await queryUnifiedTemplates();
    expect(templates.length).toBeGreaterThan(0);

    // Test discipline filtering
    const procurementTemplates = await queryTemplatesByDiscipline('Procurement');
    expect(procurementTemplates.length).toBeGreaterThan(0);

    // Validate metadata preservation
    procurementTemplates.forEach(template => {
      expect(template.metadata).toBeDefined();
      expect(template.metadata.complexity_level).toBeDefined();
    });
  });

  it('should maintain template associations post-migration', async () => {
    // Create procurement order with template association
    const order = await createProcurementOrder({
      sow_id: migratedTemplateId
    });

    // Verify association works in unified schema
    const orderWithTemplate = await getOrderWithTemplate(order.id);
    expect(orderWithTemplate.templates.discipline).toBe('Procurement');
  });
});
```

#### Discipline Document Sections Migration Testing

```javascript
describe('Discipline Document Sections Migration', () => {
  it('should migrate appendix structures to discipline sections', async () => {
    const sections = await queryDisciplineSections('01900'); // Procurement
    expect(sections.length).toBeGreaterThan(0);

    sections.forEach(section => {
      expect(section.discipline_code).toBe('01900');
      expect(section.section_type).toBe('appendix');
      expect(section.required).toBeDefined();
    });
  });

  it('should validate appendix compatibility with templates', async () => {
    const templates = await queryProcurementTemplates();
    const sections = await queryProcurementSections();

    // Validate template appendices match available sections
    templates.forEach(template => {
      template.metadata.appendices_required.forEach(appendix => {
        const sectionExists = sections.some(s => s.section_code === appendix);
        expect(sectionExists).toBe(true);
      });
    });
  });
});
```

### Migration Rollback Testing

**Comprehensive rollback validation:**

```bash
# Test rollback procedures
npm run migration:rollback -- --dry-run

# Validate rollback success
npm run test:rollback-validation

# Data integrity post-rollback
npm run test:data-integrity -- --post-rollback

# Application functionality post-rollback
npm run test:app-functionality -- --rollback-scenario
```

### Success Metrics Enhancement

#### Migration Testing Coverage Metrics
- **100% schema validation** coverage for migrations
- **100% API endpoint regression** testing completion
- **Zero RLS policy violations** in testing
- **< 10% performance regression** threshold
- **100% test data cleanup** success rate

#### Quality Assurance Metrics
- **Weekly migration testing** completion rate
- **Zero production incidents** from tested migrations
- **< 2 hour mean time to detect** migration issues
- **100% automated validation** pass rate
- **Monthly test framework updates** completion

This enhanced protocol ensures migrations are thoroughly tested across all application layers, from database schema changes through API endpoints to end-user workflows, providing comprehensive protection against production failures.

This protocol ensures migrations are thoroughly tested, safely deployed, and continuously improved to prevent future failures.
