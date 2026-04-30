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

# 1400_01400 Agent Roles Implementation Procedure

## Overview

This document provides a comprehensive procedure for implementing agent roles and access restrictions for AI agents confined to specific disciplines or collections of disciplines. This procedure ensures secure role-based access control (RBAC) for AI agents across the ConstructAI platform, preventing unauthorized cross-discipline operations and maintaining data security boundaries.

## Requirements

### Prerequisites
- Supabase project with authentication enabled
- Database administrator access
- Understanding of PostgreSQL and RLS policies
- Familiarity with existing user roles implementation
- Access to agent architecture and discipline documentation

### Agent Discipline Confinement Rules

**CRITICAL REQUIREMENT**: Each agent must be assigned to specific disciplines and strictly confined to those disciplines. Cross-discipline agent operations are strictly prohibited.

#### Agent Definition
- Agents are AI-powered systems that perform automated tasks within specific disciplines
- Each agent has a unique identifier and belongs to one or more disciplines
- Agent operations include data access, processing, and analysis within their assigned disciplines

#### Discipline Confinement Constraints
1. **Strict Agent Isolation**: Agents may only access data and perform operations within their assigned disciplines
2. **No Cross-Discipline Access**: Agents cannot access resources or perform operations outside their authorized disciplines
3. **Explicit Permission Grants**: Each agent must have explicitly defined discipline permissions
4. **Runtime Validation**: All agent operations must validate discipline access before execution

#### Agent Role Architecture
- **Agent Roles Table**: `public.agent_roles` stores agent-discipline assignments
- **Discipline Permissions**: JSONB permissions arrays defining allowed operations per discipline
- **Access Control Middleware**: Runtime validation of agent discipline permissions
- **Audit Logging**: Complete audit trail of agent operations and access attempts

#### Examples of Correct vs Incorrect Agent Assignments

**CORRECT - Contracts Agent (00435):**
- ✅ ContractualCorrespondenceReplyAgent assigned to '00435' (Contracts Post-Award)
- ✅ Permissions: `["contracts:analyze", "contracts:respond", "documents:read_00435"]`
- ✅ Confinement: Strictly limited to contracts post-award operations

**INCORRECT - Cross-Discipline Agent:**
- ❌ SafetyAnalysisAgent attempting access to procurement data (01900)
- ❌ ContractualCorrespondenceReplyAgent accessing safety inspection data (02400)
- ❌ Multi-discipline agent without explicit permission grants

### System Components Involved
- **Supabase Database**: Core agent role storage and RLS enforcement
- **Agent Framework**: Client-side agent classes with discipline validation
- **Access Control Service**: Server-side permission checking and validation
- **Audit System**: Comprehensive logging of agent operations
- **Administrative Dashboard**: Agent role management interface

## Database Schema Analysis

### Agent Roles Table Structure

Before implementing agent roles, analyze the current database schema to understand agent storage and relationships.

#### Extract Agent-Related Tables
```sql
-- Get all tables related to agents and their operations
SELECT
  schemaname,
  tablename,
  tableowner,
  tablespace,
  hasindexes,
  hasrules,
  hastriggers,
  rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
  AND (tablename LIKE '%agent%'
       OR tablename LIKE '%ai%'
       OR tablename LIKE '%automation%')
ORDER BY tablename;
```

#### Agent Roles Schema Design
```sql
-- Create agent_roles table with discipline confinement
CREATE TABLE IF NOT EXISTS public.agent_roles (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  agent_id text NOT NULL, -- Unique agent identifier
  agent_name text NOT NULL, -- Human-readable agent name
  discipline_code text NOT NULL, -- Assigned discipline (e.g., '00435', '02400')
  permissions jsonb NOT NULL DEFAULT '[]'::jsonb, -- Allowed operations
  access_level text NOT NULL DEFAULT 'read', -- read, write, admin
  is_active boolean NOT NULL DEFAULT true,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  created_by text, -- User who assigned the role
  organization_id uuid,
  CONSTRAINT agent_roles_pkey PRIMARY KEY (id),
  CONSTRAINT agent_roles_unique UNIQUE (agent_id, discipline_code)
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_agent_roles_agent_id ON public.agent_roles USING btree (agent_id);
CREATE INDEX IF NOT EXISTS idx_agent_roles_discipline ON public.agent_roles USING btree (discipline_code);
CREATE INDEX IF NOT EXISTS idx_agent_roles_active ON public.agent_roles USING btree (is_active);
CREATE INDEX IF NOT EXISTS idx_agent_roles_organization ON public.agent_roles USING btree (organization_id);

-- Enable Row Level Security
ALTER TABLE public.agent_roles ENABLE ROW LEVEL SECURITY;
```

#### Agent Operations Audit Table
```sql
-- Create agent operations audit log
CREATE TABLE IF NOT EXISTS public.agent_operations_audit (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  agent_id text NOT NULL,
  agent_name text NOT NULL,
  operation text NOT NULL, -- e.g., 'analyze_document', 'access_data'
  discipline_code text NOT NULL,
  resource_id text, -- ID of accessed resource
  resource_type text, -- e.g., 'document', 'database_table'
  success boolean NOT NULL,
  error_message text,
  execution_time_ms integer,
  ip_address inet,
  user_agent text,
  timestamp timestamp with time zone DEFAULT now(),
  CONSTRAINT agent_operations_audit_pkey PRIMARY KEY (id)
);

-- Create indexes for audit table
CREATE INDEX IF NOT EXISTS idx_agent_audit_agent_id ON public.agent_operations_audit USING btree (agent_id);
CREATE INDEX IF NOT EXISTS idx_agent_audit_discipline ON public.agent_operations_audit USING btree (discipline_code);
CREATE INDEX IF NOT EXISTS idx_agent_audit_timestamp ON public.agent_operations_audit USING btree (timestamp);
CREATE INDEX IF NOT EXISTS idx_agent_audit_success ON public.agent_operations_audit USING btree (success);
```

## Implementation

### Phase 1: Database Schema Implementation

#### Step 1: Create Agent Roles Infrastructure

**Execute SQL Migration:**
```sql
-- Create agent roles table
CREATE TABLE IF NOT EXISTS public.agent_roles (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  agent_id text NOT NULL,
  agent_name text NOT NULL,
  discipline_code text NOT NULL,
  permissions jsonb NOT NULL DEFAULT '[]'::jsonb,
  access_level text NOT NULL DEFAULT 'read' CHECK (access_level IN ('read', 'write', 'admin')),
  is_active boolean NOT NULL DEFAULT true,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  created_by text,
  organization_id uuid,
  CONSTRAINT agent_roles_pkey PRIMARY KEY (id),
  CONSTRAINT agent_roles_unique UNIQUE (agent_id, discipline_code)
);

-- Create agent operations audit table
CREATE TABLE IF NOT EXISTS public.agent_operations_audit (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  agent_id text NOT NULL,
  agent_name text NOT NULL,
  operation text NOT NULL,
  discipline_code text NOT NULL,
  resource_id text,
  resource_type text,
  success boolean NOT NULL DEFAULT true,
  error_message text,
  execution_time_ms integer,
  ip_address inet,
  user_agent text,
  timestamp timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT agent_operations_audit_pkey PRIMARY KEY (id)
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_agent_roles_agent_id ON public.agent_roles USING btree (agent_id);
CREATE INDEX IF NOT EXISTS idx_agent_roles_discipline ON public.agent_roles USING btree (discipline_code);
CREATE INDEX IF NOT EXISTS idx_agent_roles_active ON public.agent_roles USING btree (is_active);
CREATE INDEX IF NOT EXISTS idx_agent_audit_agent_id ON public.agent_operations_audit USING btree (agent_id);
CREATE INDEX IF NOT EXISTS idx_agent_audit_discipline ON public.agent_operations_audit USING btree (discipline_code);
CREATE INDEX IF NOT EXISTS idx_agent_audit_timestamp ON public.agent_operations_audit USING btree (timestamp);

-- Enable RLS
ALTER TABLE public.agent_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.agent_operations_audit ENABLE ROW LEVEL SECURITY;
```

#### Step 2: Implement RLS Policies

**Agent Roles Access Policy:**
```sql
-- Administrative access for role management
CREATE POLICY "admin_agent_roles_access" ON public.agent_roles
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      WHERE ur.user_id = auth.uid()::text
      AND ur.level >= 3
      AND (ur.department_code = '01300' OR ur.level = 4) -- Governance or System Admin
    )
  );

-- Service role full access for agent operations
CREATE POLICY "service_agent_roles_access" ON public.agent_roles
  FOR SELECT USING (auth.role() = 'service_role');

-- Audit log policies
CREATE POLICY "admin_agent_audit_access" ON public.agent_operations_audit
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      WHERE ur.user_id = auth.uid()::text
      AND ur.level >= 3
    )
  );

CREATE POLICY "service_agent_audit_insert" ON public.agent_operations_audit
  FOR INSERT WITH CHECK (auth.role() = 'service_role');
```

### Phase 2: Agent Framework Implementation

#### Step 3: Create Agent Access Control Base Class

**Agent Base Class with Discipline Validation:**
```javascript
// client/src/common/js/agents/AgentBase.js
class AgentBase {
  constructor(config = {}) {
    this.agentId = config.agentId;
    this.agentName = config.agentName;
    this.disciplineCode = config.disciplineCode;
    this.permissions = config.permissions || [];
    this.accessLevel = config.accessLevel || 'read';
    this.isInitialized = false;
  }

  // Initialize agent with role validation
  async initialize() {
    try {
      console.log(`🔐 [${this.agentName}] Initializing with discipline confinement...`);

      // Validate agent roles from database
      const rolesValid = await this.validateAgentRoles();
      if (!rolesValid) {
        throw new Error(`Agent ${this.agentId} does not have valid roles for discipline ${this.disciplineCode}`);
      }

      // Load permissions
      await this.loadAgentPermissions();

      this.isInitialized = true;
      console.log(`✅ [${this.agentName}] Successfully initialized with discipline confinement`);
      return true;
    } catch (error) {
      console.error(`❌ [${this.agentName}] Initialization failed:`, error);
      throw error;
    }
  }

  // Validate agent has required roles for discipline
  async validateAgentRoles() {
    try {
      const { data: roles, error } = await supabase
        .from('agent_roles')
        .select('*')
        .eq('agent_id', this.agentId)
        .eq('discipline_code', this.disciplineCode)
        .eq('is_active', true);

      if (error) throw error;

      if (!roles || roles.length === 0) {
        console.error(`🚫 [${this.agentName}] No active roles found for discipline ${this.disciplineCode}`);
        return false;
      }

      // Store validated roles
      this.validatedRoles = roles;
      return true;
    } catch (error) {
      console.error(`❌ [${this.agentName}] Role validation failed:`, error);
      return false;
    }
  }

  // Load agent permissions for discipline
  async loadAgentPermissions() {
    if (!this.validatedRoles) return;

    // Aggregate permissions from all roles
    this.permissions = [];
    this.validatedRoles.forEach(role => {
      if (role.permissions && Array.isArray(role.permissions)) {
        this.permissions.push(...role.permissions);
      }
    });

    // Remove duplicates
    this.permissions = [...new Set(this.permissions)];

    console.log(`🔑 [${this.agentName}] Loaded permissions:`, this.permissions);
  }

  // Check if agent has specific permission
  hasPermission(permission) {
    return this.permissions.includes(permission);
  }

  // Validate operation against discipline confinement
  async validateOperation(operation, resourceDiscipline = null) {
    const startTime = Date.now();

    try {
      // Check if operation is allowed for this discipline
      const requiredPermission = this.getRequiredPermission(operation);
      if (!this.hasPermission(requiredPermission)) {
        throw new Error(`Agent ${this.agentId} does not have permission '${requiredPermission}' for discipline ${this.disciplineCode}`);
      }

      // Validate resource discipline matches agent discipline (if specified)
      if (resourceDiscipline && resourceDiscipline !== this.disciplineCode) {
        // Check if agent has cross-discipline permissions
        const crossDisciplinePermission = `disciplines:access_${resourceDiscipline}`;
        if (!this.hasPermission(crossDisciplinePermission)) {
          throw new Error(`Agent ${this.agentId} confined to discipline ${this.disciplineCode} cannot access resources in discipline ${resourceDiscipline}`);
        }
      }

      // Log successful validation
      await this.auditOperation(operation, resourceDiscipline, true, null, Date.now() - startTime);

      return true;
    } catch (error) {
      // Log failed validation
      await this.auditOperation(operation, resourceDiscipline, false, error.message, Date.now() - startTime);
      throw error;
    }
  }

  // Get required permission for operation
  getRequiredPermission(operation) {
    const permissionMap = {
      'analyze_document': 'documents:analyze',
      'access_database': 'database:read',
      'modify_data': 'database:write',
      'send_email': 'communication:send',
      'generate_report': 'reports:generate',
      'access_vector_store': 'vector_store:read'
    };

    return permissionMap[operation] || `${operation.replace('_', ':')}`;
  }

  // Audit agent operation
  async auditOperation(operation, resourceDiscipline, success, errorMessage, executionTime) {
    try {
      const auditEntry = {
        agent_id: this.agentId,
        agent_name: this.agentName,
        operation: operation,
        discipline_code: this.disciplineCode,
        resource_type: resourceDiscipline ? 'cross_discipline_resource' : 'local_resource',
        success: success,
        error_message: errorMessage,
        execution_time_ms: executionTime,
        timestamp: new Date().toISOString()
      };

      // Insert audit entry (server-side operation)
      await this.submitAuditEntry(auditEntry);

    } catch (auditError) {
      console.error(`❌ [${this.agentName}] Audit logging failed:`, auditError);
      // Don't throw - audit failure shouldn't stop agent operation
    }
  }

  // Submit audit entry to server
  async submitAuditEntry(auditEntry) {
    try {
      const response = await fetch('/api/agent-audit', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(auditEntry)
      });

      if (!response.ok) {
        throw new Error(`Audit submission failed: ${response.status}`);
      }
    } catch (error) {
      console.error('Audit submission error:', error);
    }
  }
}

export default AgentBase;
```

#### Step 4: Create Agent Permission Service

**Server-Side Permission Validation:**
```javascript
// server/src/services/agentPermissionService.js
const { createClient } = require('@supabase/supabase-js');

class AgentPermissionService {
  constructor() {
    this.supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_KEY);
  }

  // Validate agent operation against discipline confinement
  async validateAgentOperation(agentId, operation, targetDiscipline = null) {
    try {
      console.log(`🔐 [AgentPermissionService] Validating ${agentId} operation: ${operation}`);

      // Get agent roles
      const { data: roles, error } = await this.supabase
        .from('agent_roles')
        .select('*')
        .eq('agent_id', agentId)
        .eq('is_active', true);

      if (error) throw error;

      if (!roles || roles.length === 0) {
        throw new Error(`No active roles found for agent ${agentId}`);
      }

      // Check if agent has permission for operation
      const hasPermission = this.checkOperationPermission(roles, operation);
      if (!hasPermission) {
        throw new Error(`Agent ${agentId} does not have permission for operation: ${operation}`);
      }

      // Check discipline confinement
      if (targetDiscipline) {
        const hasDisciplineAccess = this.checkDisciplineAccess(roles, targetDiscipline);
        if (!hasDisciplineAccess) {
          throw new Error(`Agent ${agentId} cannot access discipline ${targetDiscipline}`);
        }
      }

      console.log(`✅ [AgentPermissionService] Validation successful for ${agentId}`);
      return { valid: true, roles: roles };

    } catch (error) {
      console.error(`❌ [AgentPermissionService] Validation failed:`, error.message);
      return { valid: false, error: error.message };
    }
  }

  // Check if agent has permission for operation
  checkOperationPermission(roles, operation) {
    const requiredPermission = this.getRequiredPermission(operation);

    return roles.some(role =>
      role.permissions &&
      Array.isArray(role.permissions) &&
      role.permissions.includes(requiredPermission)
    );
  }

  // Check if agent can access target discipline
  checkDisciplineAccess(roles, targetDiscipline) {
    // Agent can access its own discipline
    const hasOwnDiscipline = roles.some(role => role.discipline_code === targetDiscipline);

    // Check for explicit cross-discipline permissions
    const hasCrossDisciplinePermission = roles.some(role =>
      role.permissions &&
      Array.isArray(role.permissions) &&
      role.permissions.includes(`disciplines:access_${targetDiscipline}`)
    );

    return hasOwnDiscipline || hasCrossDisciplinePermission;
  }

  // Get required permission for operation
  getRequiredPermission(operation) {
    const permissionMap = {
      'analyze_document': 'documents:analyze',
      'access_database': 'database:read',
      'modify_data': 'database:write',
      'send_email': 'communication:send',
      'generate_report': 'reports:generate',
      'access_vector_store': 'vector_store:read',
      'cross_discipline_access': 'disciplines:access'
    };

    return permissionMap[operation] || operation;
  }

  // Log agent operation to audit table
  async logAgentOperation(auditData) {
    try {
      const { error } = await this.supabase
        .from('agent_operations_audit')
        .insert([auditData]);

      if (error) throw error;

      console.log(`📊 [AgentPermissionService] Audit entry logged for ${auditData.agent_id}`);
    } catch (error) {
      console.error('❌ [AgentPermissionService] Audit logging failed:', error);
    }
  }
}

module.exports = AgentPermissionService;
```

### Phase 3: Agent Integration and Middleware

#### Step 5: Update Existing Agents with Discipline Confinement

**Enhanced Contractual Correspondence Agent:**
```javascript
// Update existing agent to extend AgentBase
import AgentBase from '@common/js/agents/AgentBase.js';

class ContractualCorrespondenceReplyAgent extends AgentBase {
  constructor(config = {}) {
    // Initialize base agent with discipline confinement
    super({
      agentId: 'contractual_correspondence_reply_agent_00435',
      agentName: 'Contractual Correspondence Reply Agent',
      disciplineCode: '00435', // Contracts Post-Award
      permissions: [
        'documents:analyze',
        'documents:read_00435',
        'contracts:analyze',
        'contracts:respond',
        'vector_store:read',
        'communication:send'
      ],
      accessLevel: 'write'
    });

    // Agent-specific configuration
    this.pageId = config.pageId || '00435';
    this.apiEndpoint = config.apiEndpoint || '/api/chat/agent/message';
    // ... rest of existing constructor
  }

  // Override initialize to include base validation
  async initialize() {
    // First validate agent roles and discipline confinement
    const baseInitialized = await super.initialize();
    if (!baseInitialized) {
      throw new Error('Agent role validation failed');
    }

    // Continue with existing initialization
    try {
      console.log('📋 [ContractualCorrespondenceReplyAgent] Initializing agent-specific functionality');
      return true;
    } catch (error) {
      console.error('Error initializing Contractual Correspondence Reply Agent:', error);
      return false;
    }
  }

  // Enhanced document retrieval with discipline validation
  async retrieveFromVectorStore(query, metadataFilters = {}) {
    // Validate operation against discipline confinement
    await this.validateOperation('access_vector_store', metadataFilters.discipline_code);

    // Ensure query is confined to agent's discipline
    if (!metadataFilters.discipline_code || metadataFilters.discipline_code !== this.disciplineCode) {
      metadataFilters.discipline_code = this.disciplineCode;
      console.log(`🔒 [${this.agentName}] Confined vector store access to discipline ${this.disciplineCode}`);
    }

    // Proceed with existing retrieval logic
    return super.retrieveFromVectorStore(query, metadataFilters);
  }

  // Enhanced LLM call with operation validation
  async callLLM(prompt, options = {}) {
    // Validate analysis operation
    await this.validateOperation('analyze_document');

    // Proceed with existing LLM call
    return super.callLLM(prompt, options);
  }
}

// Export enhanced agent
export default ContractualCorrespondenceReplyAgent;
```

#### Step 6: Create Agent Audit API Endpoint

**Agent Audit Route:**
```javascript
// server/src/routes/agent-audit-routes.js
const express = require('express');
const router = express.Router();
const AgentPermissionService = require('../services/agentPermissionService');

const agentPermissionService = new AgentPermissionService();

// POST /api/agent-audit - Log agent operation
router.post('/', async (req, res) => {
  try {
    const auditData = req.body;

    // Validate required fields
    const requiredFields = ['agent_id', 'agent_name', 'operation', 'discipline_code', 'success'];
    const missingFields = requiredFields.filter(field => !auditData[field]);

    if (missingFields.length > 0) {
      return res.status(400).json({
        error: 'Missing required fields',
        missing: missingFields
      });
    }

    // Log the operation
    await agentPermissionService.logAgentOperation(auditData);

    res.json({ success: true, message: 'Audit entry logged' });

  } catch (error) {
    console.error('Agent audit error:', error);
    res.status(500).json({ error: 'Failed to log agent operation' });
  }
});

// GET /api/agent-audit - Query audit logs (admin only)
router.get('/', async (req, res) => {
  try {
    // Check admin permissions (implement based on your auth system)
    const isAdmin = await checkAdminPermissions(req.user);
    if (!isAdmin) {
      return res.status(403).json({ error: 'Admin access required' });
    }

    const { agent_id, discipline_code, limit = 100 } = req.query;

    let query = supabase
      .from('agent_operations_audit')
      .select('*')
      .order('timestamp', { ascending: false })
      .limit(limit);

    if (agent_id) {
      query = query.eq('agent_id', agent_id);
    }

    if (discipline_code) {
      query = query.eq('discipline_code', discipline_code);
    }

    const { data, error } = await query;

    if (error) throw error;

    res.json({ data });

  } catch (error) {
    console.error('Agent audit query error:', error);
    res.status(500).json({ error: 'Failed to query audit logs' });
  }
});

module.exports = router;
```

### Phase 4: Administrative Interface

#### Step 7: Create Agent Role Management Interface

**Agent Roles Management Component:**
```javascript
// client/src/components/admin/AgentRolesManagement.jsx
import React, { useState, useEffect } from 'react';
import { supabase } from '../../common/js/supabaseClient';

const AgentRolesManagement = () => {
  const [agents, setAgents] = useState([]);
  const [disciplines, setDisciplines] = useState([]);
  const [selectedAgent, setSelectedAgent] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadAgentsAndDisciplines();
  }, []);

  const loadAgentsAndDisciplines = async () => {
    try {
      // Load all agents and their current roles
      const { data: agentsData, error: agentsError } = await supabase
        .from('agent_roles')
        .select('*')
        .order('agent_name');

      if (agentsError) throw agentsError;

      // Load available disciplines
      const { data: disciplinesData, error: disciplinesError } = await supabase
        .from('disciplines')
        .select('*')
        .order('code');

      if (disciplinesError) throw disciplinesError;

      setAgents(agentsData || []);
      setDisciplines(disciplinesData || []);
    } catch (error) {
      console.error('Error loading data:', error);
    } finally {
      setLoading(false);
    }
  };

  const assignAgentRole = async (agentId, agentName, disciplineCode, permissions) => {
    try {
      const roleData = {
        agent_id: agentId,
        agent_name: agentName,
        discipline_code: disciplineCode,
        permissions: permissions,
        access_level: 'write',
        is_active: true,
        created_by: supabase.auth.user()?.id
      };

      const { error } = await supabase
        .from('agent_roles')
        .upsert(roleData, { onConflict: 'agent_id,discipline_code' });

      if (error) throw error;

      // Reload data
      await loadAgentsAndDisciplines();

      alert('Agent role assigned successfully');
    } catch (error) {
      console.error('Error assigning role:', error);
      alert('Failed to assign agent role');
    }
  };

  const revokeAgentRole = async (roleId) => {
    try {
      const { error } = await supabase
        .from('agent_roles')
        .update({ is_active: false })
        .eq('id', roleId);

      if (error) throw error;

      await loadAgentsAndDisciplines();
      alert('Agent role revoked successfully');
    } catch (error) {
      console.error('Error revoking role:', error);
      alert('Failed to revoke agent role');
    }
  };

  if (loading) {
    return <div>Loading agent roles...</div>;
  }

  return (
    <div className="agent-roles-management">
      <h2>Agent Roles Management</h2>

      <div className="agents-list">
        <h3>Current Agent Assignments</h3>
        {agents.map(agent => (
          <div key={agent.id} className="agent-card">
            <h4>{agent.agent_name}</h4>
            <p>Discipline: {agent.discipline_code}</p>
            <p>Permissions: {agent.permissions?.join(', ') || 'None'}</p>
            <p>Status: {agent.is_active ? 'Active' : 'Inactive'}</p>
            <button
              onClick={() => revokeAgentRole(agent.id)}
              disabled={!agent.is_active}
            >
              Revoke Role
            </button>
          </div>
        ))}
      </div>

      <div className="assign-role-form">
        <h3>Assign New Agent Role</h3>
        <form onSubmit={(e) => {
          e.preventDefault();
          const formData = new FormData(e.target);
          assignAgentRole(
            formData.get('agentId'),
            formData.get('agentName'),
            formData.get('disciplineCode'),
            formData.get('permissions').split(',').map(p => p.trim())
          );
        }}>
          <div>
            <label>Agent ID:</label>
            <input name="agentId" required />
          </div>
          <div>
            <label>Agent Name:</label>
            <input name="agentName" required />
          </div>
          <div>
            <label>Discipline:</label>
            <select name="disciplineCode" required>
              {disciplines.map(discipline => (
                <option key={discipline.code} value={discipline.code}>
                  {discipline.code} - {discipline.name}
                </option>
              ))}
            </select>
          </div>
          <div>
            <label>Permissions (comma-separated):</label>
            <input name="permissions" placeholder="documents:read, contracts:analyze" required />
          </div>
          <button type="submit">Assign Role</button>
        </form>
      </div>
    </div>
  );
};

export default AgentRolesManagement;
```

### Phase 5: Testing and Validation

#### Step 8: Create Agent Role Tests

**Agent Role Testing Suite:**
```javascript
// tests/agent-roles.test.js
const { createClient } = require('@supabase/supabase-js');
const AgentPermissionService = require('../server/src/services/agentPermissionService');

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_KEY);
const agentPermissionService = new AgentPermissionService();

describe('Agent Roles Implementation', () => {
  let testAgentId;
  let testDisciplineCode;

  beforeAll(async () => {
    testAgentId = 'test_contracts_agent_00435';
    testDisciplineCode = '00435';

    // Create test agent role
    await supabase.from('agent_roles').insert({
      agent_id: testAgentId,
      agent_name: 'Test Contracts Agent',
      discipline_code: testDisciplineCode,
      permissions: ['documents:analyze', 'contracts:read', 'vector_store:read'],
      access_level: 'write',
      is_active: true
    });
  });

  test('Agent can access its assigned discipline', async () => {
    const result = await agentPermissionService.validateAgentOperation(
      testAgentId,
      'analyze_document',
      testDisciplineCode
    );

    expect(result.valid).toBe(true);
  });

  test('Agent cannot access unassigned discipline', async () => {
    const result = await agentPermissionService.validateAgentOperation(
      testAgentId,
      'analyze_document',
      '02400' // Safety discipline
    );

    expect(result.valid).toBe(false);
    expect(result.error).toContain('cannot access discipline');
  });

  test('Agent cannot perform unauthorized operations', async () => {
    const result = await agentPermissionService.validateAgentOperation(
      testAgentId,
      'delete_database' // Unauthorized operation
    );

    expect(result.valid).toBe(false);
    expect(result.error).toContain('does not have permission');
  });

  test('Agent role audit logging works', async () => {
    // Perform a valid operation
    await agentPermissionService.validateAgentOperation(
      testAgentId,
      'analyze_document',
      testDisciplineCode
    );

    // Check audit log
    const { data: auditEntries } = await supabase
      .from('agent_operations_audit')
      .select('*')
      .eq('agent_id', testAgentId)
      .eq('success', true)
      .order('timestamp', { ascending: false })
      .limit(1);

    expect(auditEntries.length).toBeGreaterThan(0);
    expect(auditEntries[0].operation).toBe('analyze_document');
    expect(auditEntries[0].discipline_code).toBe(testDisciplineCode);
  });

  afterAll(async () => {
    // Clean up test data
    await supabase.from('agent_roles').delete().eq('agent_id', testAgentId);
    await supabase.from('agent_operations_audit').delete().eq('agent_id', testAgentId);
  });
});
```

## Implementation Summary

### Database Schema Created
- `agent_roles` table with discipline confinement
- `agent_operations_audit` table for comprehensive logging
- RLS policies for secure access control
- Performance indexes for efficient queries

### Agent Framework Enhanced
- `AgentBase` class with discipline validation
- Permission checking and operation validation
- Automatic audit logging for all operations
- Cross-discipline access controls

### Administrative Tools
- Agent role management interface
- Permission assignment and revocation
- Audit log viewing and analysis
- Role validation and conflict detection

### Security Implementation
- Strict discipline confinement for all agents
- Runtime permission validation
- Comprehensive audit trails
- Administrative oversight and controls

### Testing Coverage
- Unit tests for permission validation
- Integration tests for agent operations
- Security tests for cross-discipline access
- Performance tests for validation overhead

## Error Handling & Edge Cases

### Common Issues and Solutions

**Agent Initialization Failures**
```
Symptom: Agent fails to initialize with role validation errors
Root Cause: Missing or invalid agent roles in database
Solution: Verify agent roles are properly assigned and active
Prevention: Automated role validation during agent deployment
```

**Cross-Discipline Access Attempts**
```
Symptom: Agent operations blocked with discipline access errors
Root Cause: Agent attempting operations outside assigned disciplines
Solution: Review agent role assignments and add cross-discipline permissions if needed
Prevention: Clear documentation of agent discipline boundaries
```

**Audit Logging Failures**
```
Symptom: Agent operations succeed but audit entries not created
Root Cause: Database connectivity issues or permission problems
Solution: Check database connections and audit table permissions
Prevention: Implement audit logging fallbacks and error handling
```

## Performance & Scalability Considerations

### Database Performance
- Indexes on frequently queried columns (agent_id, discipline_code)
- Partition audit_log table by month for large volumes
- Connection pooling for permission validation queries

### Agent Performance
- Cache agent permissions to reduce database calls
- Batch permission validations where possible
- Asynchronous audit logging to avoid blocking operations

### Monitoring Metrics
- Agent operation success/failure rates
- Permission validation response times
- Cross-discipline access attempt frequency
- Audit log volume and storage requirements

## Documentation & Maintenance

### Update Required Documentation
- [01300_USER_ROLES_IMPLEMENTATION_PROCEDURE.md](../01300_USER_ROLES_IMPLEMENTATION_PROCEDURE.md) - Reference agent roles integration
- [0000_PROCEDURES_GUIDE.md](../0000_PROCEDURES_GUIDE.md) - Add agent roles procedure
- Agent-specific documentation for each discipline

### Maintenance Procedures
- Monthly agent role audit and cleanup
- Quarterly permission matrix review
- Regular audit log analysis and archiving
- Agent role synchronization with system updates

### Version History
- **v1.0** (2025-12-13): Initial agent roles implementation procedure
  - Complete database schema and RLS policies
  - Agent framework with discipline validation
  - Administrative interfaces and audit logging
  - Comprehensive testing and security implementation

---

## Database Schema Management

**Database Schema Management:**
- → `docs/schema/README.md` → Comprehensive database schema documentation and management guide
- → `extract_schema.sql` → PostgreSQL functions for automated schema extraction with RLS policies and constraints
- → `extract-schema-openapi.js` → Node.js script using Supabase OpenAPI specification for comprehensive schema extraction

  **The code in `extract-schema-openapi.js` is used to output the schema to `/Users/_PropAI/construct_ai/docs/schema/current-full-schema.md`.**

  **The script performs the following key operations:**

  1. Fetches the OpenAPI specification from Supabase
  2. Parses table definitions and metadata (RLS policies, foreign keys, indexes, constraints, etc.)
  3. Analyzes script usage patterns across the codebase
  4. Generates comprehensive markdown documentation using the `generateMarkdownSchema` function
  5. Writes the markdown content to `current-full-schema.md` with this specific line:

  ```javascript
  const mdFile = path.join(OUTPUT_DIR, 'current-full-schema.md');
  fs.writeFileSync(mdFile, markdown);
  ```

  **The script is executed to extract and document the complete database schema with all metadata, producing the markdown file you referenced.**
- → `update_schema.sh` → Automated schema update script with backup creation and validation

---

## 🔧 **Hybrid Prompt Management System Integration**

### **Agent Discipline Confinement & Prompt Security**

When implementing agent roles with discipline confinement, the **Hybrid Prompt Management System** ensures that agents can only access prompts within their authorized disciplines while maintaining secure prompt management.

### **Integration with Agent Roles**

#### **Prompt Access Control by Agent Role**
```javascript
// Agent role validation for prompt access
const agentPromptAccessControl = {
  validatePromptAccess: async (agentId, promptId, operation) => {
    // Get agent roles and disciplines
    const agentRoles = await getAgentRoles(agentId);

    // Get prompt metadata (discipline, security level)
    const promptMetadata = await getPromptMetadata(promptId);

    // Validate agent can access this discipline
    const hasDisciplineAccess = agentRoles.some(role =>
      role.discipline_code === promptMetadata.discipline_code
    );

    // Validate operation permissions
    const hasOperationPermission = agentRoles.some(role =>
      role.permissions.includes(`${operation}_prompt`)
    );

    return {
      accessGranted: hasDisciplineAccess && hasOperationPermission,
      disciplines: agentRoles.map(r => r.discipline_code),
      permissions: agentRoles.flatMap(r => r.permissions)
    };
  },

  // Audit all prompt access attempts
  auditPromptAccess: async (agentId, promptId, operation, success) => {
    await auditService.log({
      action: 'AGENT_PROMPT_ACCESS',
      agent_id: agentId,
      prompt_id: promptId,
      operation,
      success,
      timestamp: new Date(),
      disciplines: await getAgentDisciplines(agentId)
    });
  }
};
```

#### **Developer vs User Prompt Permissions**
```
┌─────────────────────┬─────────────┬─────────────┬─────────────┐
│ Permission          │ Developer   │ Admin       │ Agent       │
├─────────────────────┼─────────────┼─────────────┼─────────────┤
│ Edit prompts        │ ✅ Full     │ ❌ None     │ ❌ None     │
│ Test prompts        │ ✅ Full     │ ❌ None     │ ❌ None     │
│ Use prompts         │ ✅ Full     │ ✅ Limited  │ ✅ Constrained│
│ View analytics      │ ✅ Full     │ ✅ Limited  │ ❌ None     │
│ Modify preferences  │ ✅ Override │ ✅ Override │ ❌ None     │
└─────────────────────┴─────────────┴─────────────┴─────────────┘
```

### **Agent-Specific Prompt Controls**

#### **Discipline-Constrained Prompt Execution**
```javascript
// Agent prompt execution with discipline validation
class AgentPromptExecutor {
  constructor(agentId, agentPermissions) {
    this.agentId = agentId;
    this.permissions = agentPermissions;
  }

  async executePrompt(promptId, context) {
    // Validate agent can use this prompt
    const accessCheck = await agentPromptAccessControl.validatePromptAccess(
      this.agentId,
      promptId,
      'execute'
    );

    if (!accessCheck.accessGranted) {
      throw new Error(`Agent ${this.agentId} cannot access prompt ${promptId}`);
    }

    // Apply user preferences if applicable (developer override)
    const effectivePrompt = await this.applyPreferences(promptId, context.userPreferences);

    // Execute with discipline confinement
    const result = await executePromptInDiscipline(effectivePrompt, accessCheck.disciplines[0]);

    // Audit the execution
    await agentPromptAccessControl.auditPromptAccess(
      this.agentId,
      promptId,
      'execute',
      true
    );

    return result;
  }

  async applyPreferences(promptId, userPreferences) {
    // Only apply safe preferences for agents
    const safePreferences = {
      tone: userPreferences?.style?.tone || 'professional',
      detailLevel: userPreferences?.style?.detailLevel || 'standard',
      format: userPreferences?.output?.format || 'paragraphs'
    };

    return await preferenceApplicationService.applyPreferences(
      await loadBasePrompt(promptId),
      { style: safePreferences, output: { format: safePreferences.format } }
    );
  }
}
```

### **Testing & Validation Requirements**

#### **Agent Prompt Access Testing**
- [ ] Agent roles properly restrict prompt access by discipline
- [ ] Cross-discipline prompt access is blocked
- [ ] Audit logging captures all prompt access attempts
- [ ] User preferences are safely applied without security risks

#### **Integration Testing**
- [ ] Agent prompt execution validates discipline permissions
- [ ] Developer tools work independently of agent constraints
- [ ] User preferences enhance agent responses safely
- [ ] Security boundaries prevent prompt injection attacks

### **Security Considerations**

#### **Prompt Security in Agent Context**
1. **Discipline Isolation**: Agents confined to specific disciplines cannot access other prompts
2. **Permission Validation**: Runtime checks prevent unauthorized prompt operations
3. **Audit Compliance**: All prompt access logged for security monitoring
4. **Safe Preferences**: User preferences validated before application to prompts

#### **Agent-Specific Security Controls**
- Agents cannot modify prompts (developer-only)
- Agents cannot access developer testing tools
- Agent prompt usage is constrained by discipline permissions
- All agent prompt operations are audited

### **Implementation Checklist**
- [ ] Agent roles include prompt access permissions
- [ ] Discipline validation prevents cross-discipline prompt access
- [ ] Audit logging captures agent prompt operations
- [ ] User preferences safely enhance agent responses
- [ ] Security controls prevent prompt injection through agents

---

## Related Documentation

**Database Schema Management:**
- → `docs/schema/README.md` → Comprehensive database schema documentation and management guide
- → `extract_schema.sql` → PostgreSQL functions for automated schema extraction with RLS policies and constraints
- → `extract-schema-openapi.js` → Node.js script using Supabase OpenAPI specification for comprehensive schema extraction
- → `update_schema.sh` → Automated schema update script with backup creation and validation

**Security & Access Control:**
- → `01300_USER_ROLES_IMPLEMENTATION_PROCEDURE.md` → User roles implementation
- → `0000_TABLE_POLICIES_SECURITY_PROCEDURE.md` → RLS policy management and security configurations
- → `docs/role-permissions/01300_00000_MASTER_ROLES_PERMISSIONS_INDEX.md` → Master roles permissions index
- → `docs/authentication/0020_AUTHENTICATION_OVERVIEW.md` → Authentication framework

**System Integration:**
- → `0000_PROCEDURES_GUIDE.md` → Procedures index
- → `1300_00000_PAGE_LIST.md` → Discipline definitions
- → `0000_SQL_EXECUTION_PROCEDURE.md` → Raw SQL execution and schema deployment
- → `0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md` → JavaScript data population scripts

---

## Status Tracking

### Implementation Status
- [x] Database schema created
- [x] RLS policies implemented
- [x] Agent base framework developed
- [x] Permission validation service created
- [x] Administrative interface built
- [x] Audit logging configured
- [x] Testing suite implemented
- [x] Documentation completed
- [ ] Production deployment completed
- [ ] Agent integration finished
- [ ] User training completed

### Testing Status
- [x] Unit tests for permission validation
- [x] Integration tests for agent operations
- [x] Security tests for discipline confinement
- [x] Performance tests for validation overhead
- [ ] End-to-end agent workflow testing
- [ ] Load testing with multiple agents
- [ ] Security penetration testing

### Rollback Plan
**If critical issues occur after deployment:**
1. Disable agent role validation temporarily
2. Restore previous agent operation permissions
3. Clear audit logs if needed
4. Communicate with users about temporary changes
5. Monitor system stability for 24 hours before re-implementation

---

**Procedure Version:** v1.0 (2025-12-13)
**Last Updated:** 2025-12-13
**Author:** AI Assistant (Construct AI)
**Review Cycle:** Quarterly
**Next Review:** 2026-03-13

**Recent Updates:**
- **2025-12-13**: Agent roles implementation procedure created
  - Comprehensive database schema for agent discipline confinement
  - Agent framework with runtime validation and audit logging
  - Administrative interfaces for role management
  - Complete testing suite and security implementation
  - Integration with existing user roles architecture
