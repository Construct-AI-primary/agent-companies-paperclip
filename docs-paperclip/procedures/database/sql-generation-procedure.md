# SQL Generation Procedure

## Overview

This procedure establishes a systematic approach for generating accurate SQL scripts for the Paperclip database system. It ensures all SQL generation uses verified schema information and follows standardized patterns to prevent errors and inconsistencies.

## Scope

This procedure applies to:
- All SQL script generation for database operations
- Agent creation and management scripts
- Data migration and transformation scripts
- Schema modification scripts
- Backup and recovery scripts

## Prerequisites

### Required Knowledge
- Complete understanding of PostgreSQL syntax and features
- Familiarity with Paperclip database schema (see `/docs-paperclip/schema/`)
- Knowledge of foreign key relationships and constraints
- Understanding of transaction management and error handling

### Required Tools
- Access to schema documentation (`/docs-paperclip/schema/`)
- Database connection for verification
- SQL validation tools (pg_dump, psql)
- Version control system for script management

## Schema Documentation Structure

### Organization
```
docs-paperclip/schema/
├── agents/           # Agent-related table schemas
├── companies/        # Company-related table schemas
├── issues/          # Issue tracking schemas
├── projects/        # Project management schemas
├── workflows/       # Workflow orchestration schemas
├── security/        # Authentication and authorization
├── audit/          # Activity logging and compliance
└── assets/         # File and media storage
```

### Schema File Format
Each schema file contains:
- **Table Structure**: Complete field definitions with types and constraints
- **Indexes**: Performance optimization indexes
- **Foreign Keys**: Relationship mappings and cascade rules
- **Common Queries**: Frequently used query patterns
- **Validation Rules**: Data integrity constraints
- **Migration Notes**: Schema evolution considerations

## SQL Generation Workflow

### Phase 1: Requirements Analysis

#### Step 1.1: Define Operation Scope
- Identify target tables and operations
- Determine data dependencies and relationships
- Assess transaction requirements and rollback needs
- Define success criteria and validation checks

#### Step 1.2: Review Schema Documentation
- Consult relevant schema files for table structures
- Verify foreign key relationships and constraints
- Check index requirements and query patterns
- Review validation rules and data types

#### Step 1.3: Identify Dependencies
- Map all foreign key relationships
- Identify cascading delete implications
- Determine transaction isolation requirements
- Plan for concurrent access scenarios

### Phase 2: SQL Script Development

#### Step 2.1: Use Verified Column Names
**Always reference schema documentation for exact column names:**

```sql
-- ✅ CORRECT: Use schema-verified column names
INSERT INTO agents (
  id, company_id, name, role, title, status,
  adapter_type, adapter_config, runtime_config,
  permissions, created_at, updated_at
) VALUES (...)

-- ❌ WRONG: Don't assume camelCase vs snake_case
INSERT INTO agents (
  id, companyId, name, role, title, status,  -- Wrong column names!
  adapterType, adapterConfig, runtimeConfig,
  permissions, createdAt, updatedAt
) VALUES (...)
```

#### Step 2.2: Handle Foreign Key Constraints
**Always consider foreign key relationships:**

```sql
-- ✅ CORRECT: Verify parent records exist
INSERT INTO agents (company_id, name, ...)
SELECT c.id, 'Agent Name', ...
FROM companies c
WHERE c.name = 'Target Company'
  AND c.status = 'active';

-- ❌ WRONG: Don't assume IDs exist
INSERT INTO agents (company_id, name, ...)
VALUES ('hardcoded-uuid', 'Agent Name', ...);  -- May not exist!
```

#### Step 2.3: Use Proper Data Types and Functions
**Reference schema for correct PostgreSQL types and functions:**

```sql
-- ✅ CORRECT: Use PostgreSQL functions and types
INSERT INTO agents (
  id, created_at, adapter_config, permissions
) VALUES (
  gen_random_uuid(),
  NOW(),
  '{"model": "glm-5.1"}'::jsonb,
  '{"access": "full"}'::jsonb
);

-- ❌ WRONG: Don't use non-existent functions
INSERT INTO agents (id, created_at, ...)
VALUES (
  gen_random_uuid(),
  NOW(),
  sha256('data')  -- Function doesn't exist!
);
```

#### Step 2.4: Implement Transaction Safety
**Always use transactions for multi-step operations:**

```sql
-- ✅ CORRECT: Transaction-wrapped operations
BEGIN;

-- Step 1: Create agent
INSERT INTO agents (...) VALUES (...);

-- Step 2: Create API key (only if agent creation succeeded)
INSERT INTO agent_api_keys (...)
SELECT gen_random_uuid(), a.id, ...
FROM agents a
WHERE a.name = 'Agent Name'
  AND a.created_at >= NOW() - INTERVAL '1 minute';

-- Step 3: Log activity
INSERT INTO activity_log (...) VALUES (...);

COMMIT;

-- ❌ WRONG: No transaction protection
INSERT INTO agents (...) VALUES (...);
INSERT INTO agent_api_keys (...) VALUES (...);  -- May fail if agent creation failed
```

### Phase 3: Validation and Testing

#### Step 3.1: Syntax Validation
```bash
# Test SQL syntax without executing
psql -f script.sql --dry-run

# Or use pg_validate extension
psql -c "SELECT pg_validate_sql('script.sql');"
```

#### Step 3.2: Schema Compatibility Check
```sql
-- Verify all referenced columns exist
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'target_table'
  AND table_schema = 'public'
  AND column_name IN ('col1', 'col2', 'col3');

-- Check foreign key constraints
SELECT
  tc.constraint_name,
  kcu.column_name,
  ccu.table_name AS referenced_table,
  ccu.column_name AS referenced_column
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu ON tc.constraint_name = ccu.constraint_name
WHERE tc.table_name = 'target_table'
  AND tc.constraint_type = 'FOREIGN KEY';
```

#### Step 3.3: Logic Testing
- Test with sample data on development environment
- Verify rollback behavior on failures
- Confirm foreign key relationships work correctly
- Validate business logic constraints

#### Step 3.4: Performance Testing
- Analyze query execution plans
- Test with realistic data volumes
- Monitor resource usage during execution
- Verify indexing effectiveness

### Phase 4: Documentation and Review

#### Step 4.1: Script Documentation
**Every SQL script must include comprehensive headers:**

```sql
-- Script: create-discipline-automation-agent.sql
-- Purpose: Create the Discipline Automation Agent with full configuration
-- Author: Atlas Agent Creator
-- Date: 2026-04-15
-- Schema Version: 1.0
-- Related Tables: agents, agent_models, activity_log
-- Dependencies: companies table must have 'PromptForge AI' record
-- Rollback: Run cleanup-discipline-automation-agent-duplicates.sql
-- Validation: Run verification queries at end of script

-- Prerequisites:
-- 1. Company 'PromptForge AI' must exist
-- 2. No existing agent with name 'Discipline Automation Agent'
-- 3. Database user must have INSERT permissions on affected tables

-- Post-execution verification:
-- SELECT * FROM agents WHERE name = 'Discipline Automation Agent';
-- SELECT * FROM agent_models WHERE agent_id = 'Discipline Automation Agent';
```

#### Step 4.2: Change Documentation
- Document all schema assumptions and dependencies
- Include rollback procedures for failure scenarios
- Note any data migration requirements
- Record performance implications

#### Step 4.3: Peer Review Process
- **Schema Review**: Verify all table/column references are correct
- **Logic Review**: Confirm business logic implementation
- **Security Review**: Validate permission and access controls
- **Performance Review**: Assess query efficiency and resource usage

### Phase 5: Deployment and Monitoring

#### Step 5.1: Pre-Deployment Checks
- Verify target environment schema matches development
- Confirm all prerequisites are met
- Test script on staging environment first
- Prepare rollback procedures

#### Step 5.2: Execution Monitoring
```bash
# Monitor script execution with timing
time psql $DATABASE_URL -f script.sql

# Log execution results
echo "$(date): Script execution completed with exit code $?" >> deployment.log
```

#### Step 5.3: Post-Deployment Validation
- Verify data integrity after script execution
- Confirm all expected records were created/modified
- Test related functionality to ensure no regressions
- Update documentation with actual execution results

#### Step 5.4: Incident Response
- **Immediate Actions**: Stop execution if errors detected
- **Rollback Procedures**: Execute prepared rollback scripts
- **Communication**: Notify stakeholders of issues and resolution
- **Root Cause Analysis**: Document lessons learned for future improvements

## Common SQL Generation Patterns

### Agent Creation Template
```sql
-- Template for creating new agents
DO $$
DECLARE
  company_id UUID;
  agent_id UUID;
BEGIN
  -- Get company ID safely
  SELECT id INTO company_id
  FROM companies
  WHERE name = 'Target Company Name'
    AND status = 'active';

  IF company_id IS NULL THEN
    RAISE EXCEPTION 'Company not found or not active';
  END IF;

  -- Check for existing agent
  IF EXISTS (SELECT 1 FROM agents WHERE name = 'Agent Name') THEN
    RAISE NOTICE 'Agent already exists, skipping creation';
    RETURN;
  END IF;

  -- Create agent
  INSERT INTO agents (
    company_id, name, role, title, status,
    adapter_type, adapter_config, runtime_config,
    permissions, created_at, updated_at
  ) VALUES (
    company_id, 'Agent Name', 'agent-role', 'Agent Title', 'active',
    'process', '{"model": "glm-5.1"}'::jsonb, '{"config": "data"}'::jsonb,
    '{"permissions": "data"}'::jsonb, NOW(), NOW()
  ) RETURNING id INTO agent_id;

  -- Create model assignment
  INSERT INTO agent_models (agent_id, model_id, assignment_type, priority, assigned_at, assigned_by, reason, is_active)
  VALUES ('Agent Name', 'Z.ai: GLM 5.1', 'primary', 1, NOW(), 'system', 'Default model assignment', true);

  -- Log creation
  INSERT INTO activity_log (company_id, actor_type, actor_id, action, entity_type, entity_id, agent_id, details, created_at)
  VALUES (company_id, 'system', 'atlas-agent-creator', 'create', 'agent', agent_id, agent_id,
          '{"description": "Agent created via template"}'::jsonb, NOW());

  RAISE NOTICE 'Agent created successfully with ID: %', agent_id;
END $$;
```

### Bulk Operation Template
```sql
-- Template for bulk operations with error handling
DO $$
DECLARE
  processed_count INTEGER := 0;
  error_count INTEGER := 0;
BEGIN
  -- Process each item with individual error handling
  FOR record IN SELECT * FROM source_table WHERE status = 'pending' LOOP
    BEGIN
      -- Perform operation
      INSERT INTO target_table (...) VALUES (...);

      processed_count := processed_count + 1;

      -- Mark as processed
      UPDATE source_table SET status = 'completed', processed_at = NOW()
      WHERE id = record.id;

    EXCEPTION WHEN OTHERS THEN
      error_count := error_count + 1;

      -- Log error but continue processing
      UPDATE source_table SET status = 'error', error_message = SQLERRM, processed_at = NOW()
      WHERE id = record.id;

      RAISE NOTICE 'Error processing record %: %', record.id, SQLERRM;
    END;
  END LOOP;

  RAISE NOTICE 'Bulk operation completed: % processed, % errors', processed_count, error_count;
END $$;
```

## Error Prevention Guidelines

### Schema Reference Requirements
- **Always check schema documentation first**
- **Never assume column names or relationships**
- **Verify foreign key constraints exist**
- **Test with actual database before production deployment**

### Transaction Management
- **Use explicit transactions for multi-step operations**
- **Implement proper error handling and rollback**
- **Test transaction behavior under failure conditions**
- **Document transaction boundaries and isolation levels**

### Data Integrity
- **Validate all input data before insertion**
- **Implement constraint checking in application logic**
- **Use database constraints as final safety net**
- **Test edge cases and boundary conditions**

### Performance Considerations
- **Analyze query execution plans**
- **Use appropriate indexes for new query patterns**
- **Batch large operations to reduce lock contention**
- **Monitor resource usage during execution**

## Quality Assurance

### Code Review Checklist
- [ ] Schema references verified against documentation
- [ ] Foreign key relationships properly handled
- [ ] Transaction boundaries correctly defined
- [ ] Error handling implemented for all operations
- [ ] Performance implications assessed
- [ ] Security considerations addressed
- [ ] Documentation complete and accurate

### Testing Requirements
- [ ] Syntax validation passed
- [ ] Schema compatibility verified
- [ ] Logic testing completed on development
- [ ] Performance testing conducted
- [ ] Rollback procedures tested
- [ ] Documentation reviewed and approved

## Continuous Improvement

### Process Metrics
- **Error Rate**: Percentage of SQL scripts with post-deployment issues
- **Development Time**: Average time to develop and test SQL scripts
- **Review Cycle Time**: Time from submission to approval
- **Deployment Success Rate**: Percentage of successful deployments

### Feedback Integration
- **Error Analysis**: Track and categorize SQL generation errors
- **Process Improvements**: Implement lessons learned from issues
- **Tool Enhancements**: Develop better validation and testing tools
- **Training Updates**: Update team training based on common issues

---

**Procedure Owner**: Database Development Team
**Review Frequency**: Quarterly
**Approval Required**: Database Administrator and Tech Lead
**Last Updated**: 2026-04-15