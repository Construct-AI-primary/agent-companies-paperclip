# Atlas Agent Creation with Schema Inspection Procedure

## Overview

This procedure outlines the enhanced Atlas Agent Creator workflow that incorporates database schema inspection to ensure accurate SQL generation and prevent schema mismatch errors. The procedure ensures that all agent creation activities use real database structures rather than assumptions.

## Scope

This procedure applies to:
- All agent creation activities using Atlas Agent Creator
- Database integration tasks requiring SQL generation
- Schema validation and compatibility checking
- Agent registration and configuration

## Prerequisites

### Required Skills
- `database-schema-inspection` - For schema analysis and SQL generation
- `agent-creation-management` - For agent specification and configuration
- `nimbus-infraforge-supabase-specialist` - For database execution and validation
- `cross-agent-coordination` - For inter-agent collaboration

### Required Access
- Database read access for schema inspection
- Agent creation permissions in target company
- Cross-company coordination access (if applicable)

## Procedure Steps

### Phase 1: Schema Inspection & Analysis

#### Step 1.1: Connect to Target Database
```sql
-- Establish connection to target database
-- Use appropriate connection string for environment
```

#### Step 1.2: Inspect Target Tables
```sql
-- Inspect agents table structure
SELECT
  column_name,
  data_type,
  is_nullable,
  column_default,
  character_maximum_length,
  numeric_precision,
  numeric_scale
FROM information_schema.columns
WHERE table_name = 'agents'
  AND table_schema = 'public'
ORDER BY ordinal_position;

-- Inspect related tables
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('companies', 'agent_api_keys', 'activity_log');
```

#### Step 1.3: Analyze Relationships & Constraints
```sql
-- Check foreign key relationships
SELECT
  tc.table_name,
  kcu.column_name,
  ccu.table_name AS foreign_table_name,
  ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_name IN ('agents', 'agent_api_keys', 'activity_log');

-- Check available functions
SELECT
  routine_name,
  routine_type,
  data_type as return_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name IN ('gen_random_uuid', 'digest', 'encode', 'now');
```

#### Step 1.4: Validate Schema Assumptions
- Compare actual schema with TypeScript definitions
- Document any discrepancies
- Update internal knowledge base if needed

### Phase 2: Agent Specification Development

#### Step 2.1: Define Agent Requirements
- **Role & Responsibilities**: Clear articulation of agent purpose
- **Skills Required**: Specific skills for task routing
- **Integration Points**: Companies and systems to interact with
- **Performance Metrics**: Success criteria and KPIs

#### Step 2.2: Validate Company Existence
```sql
-- Verify target company exists
SELECT id, name, status
FROM companies
WHERE name = 'PromptForge AI'
  AND status = 'active';
```

#### Step 2.3: Design Agent Configuration
- **Adapter Configuration**: Model selection and capabilities
- **Runtime Configuration**: Automation settings and parameters
- **Permissions**: Access levels and restrictions
- **Metadata**: Tracking and monitoring information

### Phase 3: SQL Generation with Schema Validation

#### Step 3.1: Generate Agent Insert Statement
```sql
-- Use actual column names from schema inspection
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  status,
  capabilities,
  adapter_type,
  adapter_config,
  runtime_config,
  permissions,
  metadata,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'Target Company Name'),
  'Agent Name',
  'agent-role-slug',
  'Agent Display Title',
  'active',
  'Capabilities description',
  'process',
  '{"model": "claude-3", "skills": ["skill1", "skill2"]}'::jsonb,
  '{"automation_config": {...}}'::jsonb,
  '{"permissions": {...}}'::jsonb,
  '{"metadata": {...}}'::jsonb,
  NOW(),
  NOW()
);
```

#### Step 3.2: Generate API Key Statement
```sql
-- Use correct column names and functions
INSERT INTO agent_api_keys (
  id,
  agent_id,
  company_id,
  name,
  key_hash,
  created_at
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM agents WHERE name = 'Agent Name' ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM companies WHERE name = 'Target Company Name'),
  'agent_primary_key',
  encode(digest('key_prefix_' || gen_random_uuid()::text, 'sha256'), 'hex'),
  NOW()
);
```

#### Step 3.3: Generate Activity Log Statement
```sql
-- Use correct table and column names
INSERT INTO activity_log (
  id,
  company_id,
  actor_type,
  actor_id,
  action,
  entity_type,
  entity_id,
  agent_id,
  details,
  created_at
) VALUES (
  gen_random_uuid(),
  (SELECT id FROM companies WHERE name = 'Target Company Name'),
  'system',
  'atlas-agent-creator',
  'create',
  'agent',
  (SELECT id FROM agents WHERE name = 'Agent Name' ORDER BY created_at DESC LIMIT 1),
  (SELECT id FROM agents WHERE name = 'Agent Name' ORDER BY created_at DESC LIMIT 1),
  '{"description": "Agent created", "skills": [...], "capabilities": {...}}'::jsonb,
  NOW()
);
```

#### Step 3.4: Add Verification Query
```sql
-- Verify successful creation
SELECT
  a.id,
  a.name,
  a.role,
  a.status,
  c.name as company_name,
  a.created_at
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.name = 'Agent Name'
ORDER BY a.created_at DESC
LIMIT 1;
```

### Phase 4: SQL Validation & Testing

#### Step 4.1: Syntax Validation
- Parse generated SQL for syntax errors
- Validate against PostgreSQL grammar
- Check for reserved word conflicts

#### Step 4.2: Schema Compatibility Check
```sql
-- Test column existence
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'agents'
  AND table_schema = 'public'
  AND column_name IN ('id', 'company_id', 'name', 'role', 'title', 'status', 'capabilities', 'adapter_type', 'adapter_config', 'runtime_config', 'permissions', 'metadata', 'created_at', 'updated_at');
```

#### Step 4.3: Function Availability Check
```sql
-- Verify required functions exist
SELECT routine_name
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name IN ('gen_random_uuid', 'digest', 'encode', 'now');
```

#### Step 4.4: Dry Run Testing
- Execute EXPLAIN on generated queries
- Test with sample data (without committing)
- Validate foreign key relationships

#### Step 4.5: Delegate to Nimbus for Validation
- **Atlas → Nimbus**: Send generated SQL for validation and execution
- **Nimbus Validation**: Use `sql-generation-testing` skill to validate SQL syntax and schema compliance
- **Live Schema Inspection**: Query actual database to confirm column constraints and relationships
- **Execution Coordination**: Nimbus executes SQL with proper error handling and rollback capabilities

### Phase 5: Execution & Verification

#### Step 5.1: Execute SQL Script
```bash
# Execute the generated SQL script
psql $DATABASE_URL -f generated_agent_script.sql
```

#### Step 5.2: Verify Agent Creation
- Check agent appears in database
- Verify API key was created
- Confirm activity log entry
- Validate permissions and configuration

#### Step 5.3: Test Agent Functionality
- Verify agent can be queried by Paperclip system
- Test basic agent operations
- Validate skill routing works correctly

### Phase 6: Documentation & Handover

#### Step 6.1: Update Agent Documentation
- Create AGENTS.md file with complete specification
- Document skills and capabilities
- Record integration points and dependencies

#### Step 6.2: Create Skill Documentation
- Generate SKILL.md files for each agent skill
- Document routing criteria and capabilities
- Include examples and usage patterns

#### Step 6.3: Update Knowledge Base
- Record schema inspection results
- Document any schema discrepancies found
- Update agent creation patterns

## Error Handling

### Schema Mismatch Errors
- **Symptom**: Column does not exist, table not found
- **Action**: Re-run schema inspection, update SQL generation
- **Prevention**: Always inspect schema before SQL generation

### Function Compatibility Errors
- **Symptom**: Function does not exist
- **Action**: Use alternative functions, update function library
- **Prevention**: Maintain function compatibility matrix

### Constraint Violation Errors
- **Symptom**: Foreign key violations, check constraints
- **Action**: Validate data relationships, correct reference data
- **Prevention**: Include constraint validation in SQL generation

### Permission Errors
- **Symptom**: Insufficient privileges
- **Action**: Verify user permissions, use service accounts
- **Prevention**: Test with appropriate database user

## Quality Assurance

### Pre-Execution Checks
- [ ] Schema inspection completed and documented
- [ ] All required tables and columns verified
- [ ] Functions validated for compatibility
- [ ] SQL syntax validated
- [ ] Foreign key relationships confirmed

### Post-Execution Validation
- [ ] Agent record created successfully
- [ ] API key generated and functional
- [ ] Activity log entry recorded
- [ ] Permissions configured correctly
- [ ] Agent accessible by Paperclip system

### Documentation Completeness
- [ ] AGENTS.md file created and complete
- [ ] SKILL.md files generated for all skills
- [ ] SQL script archived with execution results
- [ ] Knowledge base updated with findings

## Continuous Improvement

### Process Metrics
- **Schema Inspection Time**: <5 minutes per agent creation
- **SQL Generation Accuracy**: >99% first-pass success rate
- **Execution Success Rate**: >95% successful agent creations
- **Documentation Completeness**: 100% of agents fully documented

### Feedback Integration
- **Error Pattern Analysis**: Track and resolve recurring issues
- **Schema Change Monitoring**: Detect database schema changes
- **Function Library Updates**: Maintain current function compatibility
- **Process Optimization**: Streamline based on experience

## Related Procedures

- **Agent Lifecycle Management**: `docs-paperclip/procedures/agents/agent-lifecycle-management-procedure.md`
- **Database Operations**: `docs-paperclip/procedures/database/database-operations-procedure.md`
- **Skill Routing Configuration**: `docs-paperclip/procedures/agents/skill-routing-configuration-procedure.md`

## Version History

- **v1.0** (2026-04-15): Initial procedure with schema inspection integration
- **Future Updates**: Schema change detection, automated validation, enhanced error recovery

---

**Procedure Owner**: Atlas Agent Creator (paperclipforge-ai-atlas-agent-creator)
**Review Cycle**: Quarterly
**Last Updated**: 2026-04-15