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

# 0000_SUPABASE_TABLE_CREATION_AGENT_PROCEDURE.md - Supabase Table Creation Agent Procedure - Construct AI System Documentation

## Document Usage Guide

**🎯 This Document's Role**: Comprehensive operational guide for the Supabase Table Creation Agent, covering deployment, configuration, usage patterns, and operational procedures.

**📚 Related Documents in Agent Development Ecosystem:**
- → `docs/standards/0003_DATABASE_NAMING_STANDARDS.md` → **MANDATORY REFERENCE** - Database naming conventions enforced by the agent
- → `docs/procedures/human-workflows/0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md` → Framework used by the agent
- → `docs/role-permissions/01300_00000_MASTER_ROLES_PERMISSIONS_INDEX.md` → RBAC system integrated with the agent

---

## Agent Overview

The **Supabase Table Creation Agent** is an enterprise-grade AI agent designed for secure, standards-compliant database management within the Construct AI system.

### Core Purpose
- **Secure Database Operations**: Enforce RBAC and discipline confinement for all database changes
- **Standards Compliance**: Automatically validate and enforce database naming conventions
- **Operational Safety**: Provide transaction safety with automatic rollback capabilities
- **Audit Trail**: Comprehensive logging of all database operations
- **Workflow Integration**: Seamless integration with MyTasksDashboard and HITL workflows

### Agent Classification
- **Agent Type**: JavaScript Agent
- **Framework**: JavaScript Data Population Procedure
- **Security Level**: Enterprise (RBAC, discipline confinement, audit logging)
- **Operational Status**: Ready for production (requires simulator testing)

### Key Capabilities
- ✅ **CREATE TABLE**: Full schema creation with RLS policies
- ✅ **ALTER TABLE**: Schema modifications with automatic rollback
- ✅ **Naming Enforcement**: Database standards validation
- ✅ **RBAC Integration**: Discipline-based access control
- ✅ **Transaction Safety**: Automatic rollback on failures
- ✅ **Audit Logging**: Complete operation traceability
- ✅ **Task Notifications**: MyTasksDashboard integration (no email)
- ✅ **Simulator Checkpoint**: Pre-production validation

---

## Agent Architecture

### File Structure
```
agents/supabase/supabase-table-creation-agent/
├── index.js                 # Main agent implementation (700+ lines)
├── package.json            # Node.js configuration
├── README.md               # Operational documentation
└── [test files]           # Testing suites
```

### Sub-Agent Architecture
```
SupabaseTableCreationAgent
├── RBACValidationSubAgent     # User permission validation
├── NamingConventionSubAgent   # Database standards enforcement
├── RollbackManagerSubAgent    # Transaction rollback handling
├── TaskNotificationSubAgent   # MyTasksDashboard integration
└── SimulatorCheckpointSubAgent # Pre-production validation
```

### Integration Points
- **Supabase Database**: Primary data persistence and operations
- **MyTasksDashboard**: Task notifications (no email system)
- **User Roles Table**: RBAC permission validation
- **Agent Audit Table**: Operation logging
- **Simulator System**: Pre-production checkpoints
- **HITL Workflow**: Human-in-the-loop approvals for complex operations

---

## Pre-Implementation Requirements

### Environment Setup

#### System Prerequisites
- ✅ **Node.js 18+**
- ✅ **Supabase project** with service role access
- ✅ **Database tables**: `user_roles`, `agent_operations_audit`, `tasks`
- ✅ **RLS policies** configured for agent access

#### Environment Variables
```bash
# Required for agent initialization
SUPABASE_URL=your-project-supabase-url
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key

# Optional: Simulation configuration
NODE_ENV=production|development|test
SIMULATOR_CHECKPOINT_ENABLED=true
```

#### Database Permissions
The agent requires these database permissions:
```sql
-- Grant agent operational permissions
GRANT EXECUTE ON FUNCTION execute_sql(text) TO authenticated;
GRANT EXECUTE ON FUNCTION execute_sql_in_transaction(text[]) TO authenticated;

-- Grant access to required tables
GRANT SELECT ON user_roles TO authenticated;
GRANT INSERT ON agent_operations_audit TO authenticated;
GRANT INSERT, UPDATE ON tasks TO authenticated;
GRANT SELECT ON information_schema.tables TO authenticated;
```

### Role-Based Access Control Setup

#### Agent Discipline Confinement
The agent enforces these discipline boundaries:

| Discipline | Code | Access Pattern |
|------------|------|----------------|
| Procurement | 01900 | `a_01900_*` tables |
| Safety | 02400 | `a_02400_*` tables |
| Ethics | 01100 | `a_01100_*` tables |
| IT | 02050 | `a_02050_*` tables **+ Universal Access** |
| System Admin | Level 4 | All disciplines |

#### Permission Level Requirements
- **Level 1 (User)**: Basic CREATE permissions
- **Level 2 (Advanced User)**: CREATE + ALTER permissions
- **Level 3 (Administrator)**: Full database operations
- **Level 4 (System Admin)**: Universal access (no discipline restrictions)

#### User Role Assignment
Users must have appropriate roles in the `user_roles` table:
```sql
-- Example user role assignment
INSERT INTO user_roles (
  user_id,
  role,
  department_code,
  level,
  permissions
) VALUES (
  'user-uuid-here',
  'database_administrator',
  '01900',
  3,
  '["database:create", "database:alter", "database:drop"]'
);
```

---

## Agent Operational Procedures

### 1. Agent Initialization

#### Standard Initialization
```javascript
const { SupabaseTableCreationAgent } = require('./agents/supabase/supabase-table-creation-agent');

const agent = new SupabaseTableCreationAgent({
  // Optional: Custom configuration
  maxTransactionTimeout: 60000, // 60 seconds
  simulatorEnabled: true
});

// Set current user context (REQUIRED)
agent.currentUser = {
  id: 'user-uuid',
  roles: ['database_administrator'],
  discipline: '01900' // For discipline-specific operations
};
```

#### Simulator Integration
**MANDATORY**: All operations require simulator checkpoint validation

```javascript
// Agent operations will automatically validate with simulator
// No manual setup required - integrated into agent workflow
```

### 2. CREATE TABLE Operations

#### Basic Table Creation
```javascript
const schema = {
  columns: {
    order_id: {
      type: 'uuid',
      not_null: true,
      default: 'gen_random_uuid()'
    },
    supplier_name: {
      type: 'varchar(255)',
      not_null: true
    },
    order_value: {
      type: 'decimal(10,2)',
      not_null: false
    },
    status: {
      type: 'varchar(50)',
      not_null: true,
      default: "'pending'"
    },
    created_at: {
      type: 'timestamptz',
      not_null: true,
      default: 'now()'
    },
    updated_at: {
      type: 'timestamptz',
      not_null: true,
      default: 'now()'
    }
  },
  primary_key: 'order_id',
  indexes: [
    { columns: 'status' },
    { columns: 'created_at' }
  ],
  foreign_keys: [
    {
      column: 'created_by_user_id',
      referenced_table: 'a_users',
      referenced_column: 'user_id'
    }
  ]
};

const result = await agent.createTable('a_01900_procurement_orders', schema);
console.log(result); // { success: true, tableName: '...', operationId: '...' }
```

#### Advanced Table Creation with Constraints
```javascript
const complexSchema = {
  columns: {
    item_id: { type: 'uuid', not_null: true, default: 'gen_random_uuid()' },
    description: { type: 'text', not_null: true },
    category: { type: 'varchar(100)', not_null: true },
    quantity: { type: 'integer', not_null: true },
    unit_price: { type: 'decimal(10,2)', not_null: true },
    total_value: { type: 'decimal(12,2)', not_null: true },
    is_active: { type: 'boolean', not_null: true, default: 'true' },
    procurement_order_id: { type: 'uuid', not_null: true },
    created_by_user_id: { type: 'uuid', not_null: true },
    created_at: { type: 'timestamptz', not_null: true, default: 'now()' }
  },
  primary_key: 'item_id',
  indexes: [
    { columns: ['procurement_order_id', 'created_at'] },
    { columns: 'category' },
    { columns: 'is_active' }
  ],
  foreign_keys: [
    {
      column: 'procurement_order_id',
      referenced_table: 'a_01900_procurement_orders',
      referenced_column: 'order_id'
    },
    {
      column: 'created_by_user_id',
      referenced_table: 'a_users',
      referenced_column: 'user_id'
    }
  ],
  unique_constraints: [
    { columns: ['procurement_order_id', 'description'] }
  ],
  check_constraints: [
    {
      name: 'positive_quantity',
      condition: 'quantity > 0'
    },
    {
      name: 'positive_unit_price',
      condition: 'unit_price >= 0'
    },
    {
      name: 'valid_category',
      condition: 'category IN (''equipment'', ''services'', ''materials'', ''software'')'
    }
  ]
};

const result = await agent.createTable('a_01900_procurement_order_items', complexSchema);
```

### 3. ALTER TABLE Operations

#### Safe Column Addition
```javascript
const alterations = [
  'ADD COLUMN approval_date timestamptz',
  'ADD COLUMN approved_by_user_id uuid',
  'ADD COLUMN approval_notes text'
];

const result = await agent.alterTable('a_01900_procurement_orders', alterations);
// Automatic rollback occurs on failure
```

#### Complex Schema Modifications
```javascript
const schemaChanges = [
  'ADD COLUMN contract_reference varchar(255)',
  'ADD COLUMN delivery_date date',
  'ALTER COLUMN order_value TYPE decimal(12,2)',
  'ADD CONSTRAINT chk_positive_value CHECK (order_value > 0)',
  'CREATE INDEX idx_procurement_orders_delivery ON procurement_orders(delivery_date) WHERE delivery_date IS NOT NULL'
];

const result = await agent.alterTable('a_01900_procurement_orders', schemaChanges);
```

### 4. Naming Convention Validation

#### Programmatic Validation
```javascript
// Validate table name before operations
const validation = agent.namingValidator.validateTableName('a_01900_procurement_orders');

if (!validation.valid) {
  console.log('Naming violations:', validation.error);
  console.log('Suggestions:', validation.suggestions);
  // Agent will reject operations with invalid names
}
```

#### Manual Validation Examples
```javascript
// ✅ Valid discipline table
agent.namingValidator.validateTableName('a_01900_procurement_orders');
// Returns: { valid: true, type: 'discipline' }

// ✅ Valid core table
agent.namingValidator.validateTableName('a_users');
// Returns: { valid: true, type: 'core' }

// ✅ Valid vector table
agent.namingValidator.validateTableName('a_01900_procurement_vector');
// Returns: { valid: true, type: 'vector' }

// ❌ Invalid table names
agent.namingValidator.validateTableName('procurement_orders');
// Returns: {
//   valid: false,
//   error: 'Missing prefix. Table names must start with a_',
//   suggestions: ['a_procurement_orders', 'a_procurement_orders_data']
// }
```

---

## Safety and Error Handling

### Automatic Transaction Management

#### Transaction Wrapping
All agent operations use database transactions:
```javascript
// Agent automatically wraps operations in transactions
BEGIN;
-- Agent operations here
COMMIT;

// On failure:
ROLLBACK;
-- Agent executes predefined rollback scripts
```

#### Timeout Protection
Operations have automatic timeout protection:
```javascript
// Default: 30 seconds maximum per operation
// Configurable: agent.maxTransactionTimeout = 60000;
```

### Automatic Rollback System

#### Failure Recovery
```javascript
// ALTER TABLE operations generate rollback scripts upfront
const result = await agent.alterTable('table_name', alterations);

// If operation fails:
// 1. Automatic transaction rollback
// 2. Pre-generated rollback script execution
// 3. Task notification of failure
// 4. Comprehensive audit logging
```

#### Rollback Script Examples
```sql
-- Generated rollback for ADD COLUMN
ALTER TABLE a_01900_procurement_orders
DROP COLUMN approval_date,
DROP COLUMN approved_by_user_id,
DROP COLUMN approval_notes;

-- Generated rollback for complex operations
ALTER TABLE a_01900_procurement_orders
DROP COLUMN IF EXISTS contract_reference,
DROP COLUMN IF EXISTS delivery_date,
ALTER COLUMN order_value TYPE decimal(10,2), -- Restore original type
DROP CONSTRAINT IF EXISTS chk_positive_value,
DROP INDEX IF EXISTS idx_procurement_orders_delivery;
```

### Error Categories and Handling

#### Validation Errors
```javascript
try {
  await agent.createTable('invalid_table_name', schema);
} catch (error) {
  // Naming convention violations
  console.log(error.message);
  // "Naming convention violation: Missing prefix. Table names must start with a_"
}
```

#### Permission Errors
```javascript
try {
  await agent.createTable('a_02400_safety_orders', schema); // Wrong discipline
} catch (error) {
  // RBAC violations
  console.log(error.message);
  // "Discipline confinement violation: No access to discipline 02400"
}
```

#### Simulator Checkpoint Errors
```javascript
try {
  await agent.createTable('a_01900_procurement_orders', schema);
} catch (error) {
  // Checkpoint failures
  console.log(error.message);
  // "Simulator checkpoint failed: Operation must pass simulation testing before production execution.
  //  Visit: https://construct-ai.onrender.com/#/agent-generation and ..."
}
```

---

## Notification and Monitoring

### Task-Based Notifications

#### MyTasksDashboard Integration
```javascript
// Successful operations create completion tasks
// Business Object Type: 'database_operation'
// Task Type: 'database_operation_complete'

Example Task:
{
  title: "Database Operation Complete: CREATE TABLE a_01900_procurement_orders",
  description: "Completed CREATE TABLE operation... Duration: 1500ms",
  priority: "normal",
  status: "completed"
}
```

#### Failure Notifications
```javascript
// Failed operations create investigation tasks
// Task Type: 'database_operation_failed'

Example Failure Task:
{
  title: "Database Operation Failed: ALTER TABLE a_01900_procurement_orders",
  description: "Failed ALTER TABLE operation: column 'invalid_col' does not exist",
  priority: "high",
  status: "pending"
}
```

### Audit Trail

#### Comprehensive Logging
```javascript
// All operations logged to agent_operations_audit table
{
  operation_id: 'op_1640995200000_xyz123',
  agent_id: 'supabase_table_creation_agent',
  operation_type: 'CREATE TABLE',
  target_table: 'a_01900_procurement_orders',
  user_id: 'user-uuid',
  success: true,
  error_message: null,
  metadata: {
    schema: {...},
    rollback_script: null,
    duration_ms: 1500,
    simulator_checkpoint: true
  },
  created_at: '2026-02-03T10:30:00.000Z'
}
```

#### Operation Tracking
- **Unique Operation IDs**: Each operation has a timestamp-based identifier
- **Performance Metrics**: Execution time and resource usage tracking
- **Error Categorization**: Structured error reporting
- **Rollback Tracking**: Pre and post-rollback state capture

---

## Testing and Validation

### Simulator Requirements

#### Mandatory Pre-Production Testing
**CRITICAL REQUIREMENT**: All agent operations must pass simulator validation before production use.

```javascript
// Required Simulator URLs
const AGENT_GENERATION_URL = 'https://construct-ai.onrender.com/#/agent-generation';
const AGENT_SIMULATION_UI_URL = 'https://construct-ai.onrender.com/#/agent-simulation-ui';

// Simulator validation occurs automatically:
// 1. Operation submission to simulator
// 2. HITL checkpoint validation
// 3. Approval/rejection with feedback
// 4. Checkpoint completion for production access
```

#### Checkpoint Validation Flow
```
1. Agent operation initiated
2. Simulator checkpoint validation starts
3. Operation parameters sent to simulator API
4. HITL review if required for ALTER operations
5. Checkpoint approval/rejection returned
6. Production operation permitted/denied
```

### Unit Testing

#### Agent Component Testing
```bash
# Test individual sub-agents
npm test -- --testPathPattern=subagent

# Test naming validation
npm run test:naming

# Test RBAC validation
npm run test:rbac
```

#### Integration Testing
```bash
# Full agent testing with Supabase
npm run test:integration

# Requires test database setup
SUPABASE_URL=test-url
SUPABASE_SERVICE_ROLE_KEY=test-key
```

### Operational Validation

#### Pre-Production Checklist
- [ ] Agent loads without syntax errors
- [ ] Environment variables configured
- [ ] Database permissions granted
- [ ] RBAC roles properly assigned
- [ ] Simulator checkpoints functional
- [ ] Audit logging operational
- [ ] Task notifications working

---

## Operational Guidelines

### User Role Requirements

#### User Permission Assignment
Users must have appropriate permissions for database operations:

```sql
-- Example: Procurement administrator with Level 3 access
INSERT INTO user_roles (user_id, role, department_code, level, permissions)
VALUES (
  'procurement-admin-user-id',
  'procurement_database_admin',
  '01900',
  3,
  '["database:create", "database:alter", "database:drop"]'
);

-- Example: IT administrator with universal access
INSERT INTO user_roles (user_id, role, department_code, level, permissions)
VALUES (
  'it-admin-user-id',
  'system_database_admin',
  '02050',
  4,
  '["database:*"]' -- Universal database permissions
);
```

#### Discipline-Specific Access
```sql
-- Finance user restricted to finance tables only
{
  user_id: 'finance-user-id',
  department_code: '01200',     // Finance discipline
  level: 2,                     // ALTER permissions
  permissions: ['database:create', 'database:alter']
}
-- Can only operate on tables: a_01200_finance_*
```

### Performance Considerations

#### Resource Management
- **Transaction Timeouts**: Operations limited to 30 seconds by default
- **Concurrent Operations**: Maximum 10 simultaneous requests
- **Memory Usage**: Optimized for <150MB per agent instance
- **CPU Usage**: <0.5 cores under normal load

#### Monitoring Metrics
```javascript
// Agent exposes performance metrics
const metrics = agent.getPerformanceMetrics();
console.log(metrics);
// {
//   requestsProcessed: 1500,
//   averageResponseTime: 1250, // ms
//   successRate: 99.5,
//   errorCount: 7,
//   rollbackSuccessRate: 100,
//   namingComplianceRate: 98.5
// }
```

---

## Troubleshooting

### Common Operational Issues

#### "Simulator checkpoint failed"
**Symptom**: Operations rejected with checkpoint error
**Solution**:
1. Visit https://construct-ai.onrender.com/#/agent-generation
2. Run simulation for your operation type
3. Complete HITL checkpoints if required
4. Retry production operation

#### "RBAC Authorization failed"
**Symptom**: Operations blocked due to permission errors
**Solution**:
1. Verify user role in `user_roles` table
2. Check department_code matches table discipline
3. Ensure level 2+ for ALTER operations
4. Verify permissions array includes required operations

#### "Naming convention violation"
**Symptom**: Operations rejected due to naming standards
**Solution**:
1. Review `docs/standards/0003_DATABASE_NAMING_STANDARDS.md`
2. Use agent's suggestion system: `agent.namingValidator.generateSuggestions()`
3. Follow discipline-based naming: `a_XXXXX_entity_descriptor`

#### "ALTER operation failed and was rolled back"
**Symptom**: Schema changes reverted automatically
**Solution**:
1. Check audit logs in `agent_operations_audit`
2. Review generated rollback script
3. Verify column existence before operations
4. Check data constraints (cannot drop columns with data)

### Emergency Procedures

#### Agent Unresponsive
1. Check environment variable configuration
2. Verify Supabase connectivity
3. Review Node.js process logs
4. Restart agent with clean state

#### Database Permission Issues
```sql
-- Temporary permission grant (use sparingly)
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO authenticated;

-- Revoke after resolution
REVOKE EXECUTE ON FUNCTION execute_sql(text) FROM authenticated;
```

#### Incorrect Table Creation
1. Use agent to ALTER TABLE (will auto-rollback if fails)
2. Manual cleanup if required (Level 4 admin only)
3. Document incident in audit logs
4. Update naming standards if pattern issue identified

---

## Success Metrics

### Operational Metrics
- **Operation Success Rate**: >99.5% (target)
- **Rollback Success Rate**: 100% (mandatory)
- **Average Response Time**: <3 seconds (target)
- **Naming Compliance**: >98% (agent-enforced)

### Security Metrics
- **Permission Violation Rate**: <0.1% (target)
- **Discipline Compliance**: 100% (enforced)
- **Audit Coverage**: 100% operations logged

### User Experience Metrics
- **Task Notification Time**: <5 seconds
- **Simulator Checkpoint Time**: <30 seconds
- **Error Message Clarity**: 100% actionable

---

## Related Procedures and Documents

### Core Standards and Procedures
- → `docs/standards/0003_DATABASE_NAMING_STANDARDS.md` → Naming conventions enforced by agent
- → `docs/procedures/human-workflows/0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md` → Agent framework
- → `docs/role-permissions/01300_00000_MASTER_ROLES_PERMISSIONS_INDEX.md` → RBAC system

### Integration Procedures
- → `docs/workflow/0000_WORKFLOW_TASK_PROCEDURE.md` → Task notification integration
- → `docs/procedures/0000_SIMULATOR_INTEGRATION_PROCEDURE.md` → Simulator checkpoint procedures
- → `docs/procedures/0000_AGENT_AUDIT_PROCEDURE.md` → Audit logging procedures

### Quality and Testing Procedures
- → `docs/testing/0000_AGENT_INTEGRATION_TESTING_PROCEDURE.md` → Agent testing procedures
- → `docs/monitoring/0000_AGENT_PERFORMANCE_PROCEDURE.md` → Performance monitoring
- → `docs/security/0000_AGENT_SECURITY_PROCEDURE.md` → Security validation procedures

---

## Document Information

- **Document ID**: `0000_SUPABASE_TABLE_CREATION_AGENT_PROCEDURE`
- **Version**: 1.0
- **Created**: 2026-02-03
- **Last Updated**: 2026-02-03
- **Author**: Construct AI Development Team
- **Review Cycle**: Quarterly
- **Related Documents**:
  - `agents/supabase/supabase-table-creation-agent/`
  - `docs/standards/0003_DATABASE_NAMING_STANDARDS.md`
  - `docs/role-permissions/01300_00000_MASTER_ROLES_PERMISSIONS_INDEX.md`

---

**🎯 Key Takeaway**: This agent provides enterprise-grade database management with comprehensive safety, security, and standards compliance. All operations are subject to simulator validation before production use, ensuring reliable and secure database evolution.