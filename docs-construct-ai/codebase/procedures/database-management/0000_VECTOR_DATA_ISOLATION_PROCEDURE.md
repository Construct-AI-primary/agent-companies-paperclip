---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/database-management
gigabrain_tags: procedures, database-management, codebase
documentation
openstinger_context: operational-procedures, database-management-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# 0500 Vector Data Isolation Implementation Procedure

## Overview

**Procedure ID**: 0500_VECTOR_DATA_ISOLATION_PROCEDURE
**Version**: 1.0
**Status**: 🟢 ACTIVE
**Scope**: Data Processing - Vector Database Isolation
**Target Audience**: Backend Engineers, Database Administrators, Frontend Engineers

This procedure provides a standardized methodology for implementing vector data isolation across discipline-specific vector tables. It was developed based on the successful implementation of vector data isolation on the `a_00435_contracts_post_vector` table and can be replicated across other vector tables in the system.

**🔗 Cross-References to Related Documentation:**

**Vector System Implementation:**
- → `docs/data-processing/1350_VECTOR_SYSTEM_MASTER_GUIDE.md` → Complete consolidated guide for LangChain, Supabase vector storage, record management, security architecture, and AI document processing
- → `docs/data-processing/0500_VECTOR_ISOLATION_REVIEW_REPORT.md` → Implementation review and validation report
- → `0000_VECTOR_ISOLATION_SECURITY_PROCEDURE.md` → **REQUIRED REFERENCE** for security controls, compliance standards, and audit requirements

**System Maintenance & Database:**
- → `0000_SQL_EXECUTION_PROCEDURE.md` → Database operations and schema changes for vector table implementation
- → `docs/0000_MASTER_DATABASE_SCHEMA.md` → Database schema reference for understanding table structures and relationships
- → `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` → Framework for diagnosing vector isolation and RLS policy issues

**Workflow & AI Integration:**
- → `0000_WORKFLOW_HITL_PROCEDURE.md` → Human-in-the-loop procedures using vector data for context loading
- → `0000_CHATBOT_COMPREHENSIVE_PROCEDURE.md` → Chatbot integration with vector data isolation for semantic search
- → `0000_DEBUGGING_GUIDE.md` → Advanced debugging techniques for vector operation failures and isolation issues

## 🎯 **Objective**

Enable user-specific data isolation, cross-discipline sharing, and temporary workspace management for vector databases while maintaining security, performance, and compliance.

## 📋 **Prerequisites**

### **System Requirements**
- ✅ PostgreSQL with pgvector extension
- ✅ Supabase authentication system
- ✅ Row Level Security (RLS) enabled
- ✅ Existing vector table with embeddings
- ✅ LangChain integration (optional but recommended)

### **Team Requirements**
- ✅ Backend Engineer (2 required)
- ✅ Frontend Engineer (1 required)
- ✅ Database Administrator (1 required)
- ✅ QA Engineer (1 required)
- ✅ Product Owner for requirements validation

### **Knowledge Prerequisites**
- ✅ SQL and PostgreSQL expertise
- ✅ React.js and JavaScript
- ✅ REST API development
- ✅ Authentication and authorization systems
- ✅ Database security and RLS policies

## 🔄 **Procedure Steps**

### **Phase 1: Planning and Analysis (1-2 Days)**

#### **Step 1.1: Scope Definition**
```markdown
1. Identify target vector table (e.g., a_00850_civil_engineering_vector)
2. Define isolation requirements:
   - User-specific isolation needed?
   - Cross-discipline sharing required?
   - Temporary workspaces needed?
   - Deletion lifecycle management needed?
3. Identify stakeholder disciplines for sharing matrix
4. Define access control requirements
```

#### **Step 1.2: Impact Analysis**
```sql
-- Analyze current table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'target_vector_table'
  AND table_schema = 'public';

-- Analyze data volume and usage patterns
SELECT
    COUNT(*) as total_records,
    COUNT(DISTINCT organisation_id) as organisations,
    COUNT(DISTINCT project_id) as projects,
    COUNT(DISTINCT project_phase_assignment_id) as project_phases
FROM target_vector_table;

-- Analyze project-phase distribution for isolation planning
SELECT
    p.name as project_name,
    ppa.phase_name,
    COUNT(v.id) as vector_count,
    COUNT(DISTINCT v.created_by_user_id) as contributing_users
FROM target_vector_table v
LEFT JOIN projects p ON v.project_id = p.id
LEFT JOIN project_phase_assignments ppa ON v.project_phase_assignment_id = ppa.id
WHERE v.deleted_at IS NULL
GROUP BY p.name, ppa.phase_name
ORDER BY p.name, ppa.phase_name;

-- Analyze user project access for isolation requirements
SELECT
    u.email,
    COUNT(DISTINCT upa.project_id) as assigned_projects,
    COUNT(DISTINCT v.id) as user_vectors,
    COUNT(DISTINCT v.project_id) as user_projects_with_vectors
FROM auth.users u
LEFT JOIN user_project_assignments upa ON u.id = upa.user_id
LEFT JOIN target_vector_table v ON u.id = v.created_by_user_id AND v.deleted_at IS NULL
GROUP BY u.id, u.email
ORDER BY assigned_projects DESC;
```

#### **Step 1.3: Success Criteria Definition**
- [ ] Zero data leakage between isolated vectors
- [ ] <5 second query response time
- [ ] 100% user satisfaction with controls
- [ ] Seamless integration with existing workflows

### **Phase 2: Database Schema Implementation (3-5 Days)**

#### **Step 2.1: Schema Enhancement**
```sql
-- Add isolation columns to target vector table
ALTER TABLE target_vector_table
ADD COLUMN IF NOT EXISTS isolation_metadata JSONB DEFAULT '{}'::jsonb,
ADD COLUMN IF NOT EXISTS created_by_user_id UUID,
ADD COLUMN IF NOT EXISTS access_scope TEXT CHECK (access_scope IN ('private', 'shared', 'team', 'public', 'temporary')),
ADD COLUMN IF NOT EXISTS shared_with_disciplines TEXT[],
ADD COLUMN IF NOT EXISTS workspace_id UUID,
ADD COLUMN IF NOT EXISTS workspace_type TEXT CHECK (workspace_type IN ('personal', 'collaborative', 'temporary', 'archive')),
ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMPTZ,
ADD COLUMN IF NOT EXISTS deleted_by UUID,
ADD COLUMN IF NOT EXISTS deletion_reason TEXT,
ADD COLUMN IF NOT EXISTS scheduled_hard_delete_at TIMESTAMPTZ;
```

#### **Step 2.2: Supporting Tables Creation**
```sql
-- Create workspace management table
CREATE TABLE IF NOT EXISTS vector_workspaces (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  workspace_type TEXT CHECK (workspace_type IN ('personal', 'collaborative', 'temporary', 'archive')),
  created_by UUID REFERENCES auth.users(id),
  organisation_id UUID,
  project_id UUID,
  discipline_restrictions TEXT[],
  auto_cleanup_after INTERVAL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  expires_at TIMESTAMPTZ,
  is_active BOOLEAN DEFAULT true
);

-- Create deletion audit table
CREATE TABLE IF NOT EXISTS vector_deletion_audit (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vector_id UUID NOT NULL,
  table_name TEXT NOT NULL,
  deleted_by UUID,
  deletion_reason TEXT,
  deletion_type TEXT CHECK (deletion_type IN ('soft', 'hard', 'auto_cleanup')),
  restored_at TIMESTAMPTZ,
  restored_by UUID,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create deletion policies table
CREATE TABLE IF NOT EXISTS vector_deletion_policies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  policy_name TEXT NOT NULL,
  applies_to_scope TEXT CHECK (applies_to_scope IN ('user_private', 'workspace_temporary', 'shared_expired', 'admin_cleanup')),
  retention_period INTERVAL,
  auto_delete BOOLEAN DEFAULT false,
  requires_approval BOOLEAN DEFAULT false,
  created_by UUID,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### **Step 2.3: Index Optimization**
```sql
-- Performance indexes for isolation queries
CREATE INDEX IF NOT EXISTS idx_{table_name}_isolation_access
ON target_vector_table(access_scope, created_by_user_id);

CREATE INDEX IF NOT EXISTS idx_{table_name}_workspace
ON target_vector_table(workspace_id) WHERE workspace_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_{table_name}_deletion
ON target_vector_table(deleted_at) WHERE deleted_at IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_{table_name}_shared_disciplines
ON target_vector_table USING GIN (shared_with_disciplines);
```

#### **Step 2.4: Row Level Security Policies**
```sql
-- Enable RLS on target table
ALTER TABLE target_vector_table ENABLE ROW LEVEL SECURITY;

-- User private access policy
CREATE POLICY "user_private_vectors" ON target_vector_table
FOR ALL USING (
  access_scope = 'private'
  AND created_by_user_id = auth.uid()
);

-- Shared access policy
CREATE POLICY "shared_vectors" ON target_vector_table
FOR SELECT USING (
  access_scope IN ('shared', 'public', 'team')
  OR created_by_user_id = auth.uid()
  OR (access_scope = 'team' AND created_by_user_id IN (
    SELECT user_id FROM team_members
    WHERE team_id = (SELECT team_id FROM user_team_membership WHERE user_id = auth.uid())
  ))
);

-- Workspace-based access policy
CREATE POLICY "workspace_based_access" ON target_vector_table
FOR ALL USING (
  workspace_id IS NULL  -- Public vectors
  OR workspace_id IN (
    SELECT id FROM vector_workspaces
    WHERE is_active = true
    AND (
      created_by = auth.uid()
      OR id IN (
        SELECT workspace_id FROM workspace_members
        WHERE user_id = auth.uid() AND access_level IN ('read', 'write', 'admin')
      )
    )
  )
);
```

### **Phase 3: Backend API Development (4-6 Days)**

#### **Step 3.1: Vector Processing Service Enhancement**
```javascript
// Enhanced VectorProcessingService
class VectorProcessingService {
  async processDocumentWithIsolation(documentData, isolationSettings, userContext) {
    // 1. Process document content and generate embeddings
    const { content, metadata, embedding } = await this.processDocumentContent(documentData);

    // 2. Apply isolation metadata
    const enhancedMetadata = {
      ...metadata,
      isolation: {
        access_scope: isolationSettings.accessScope,
        created_by_user_id: userContext.userId,
        shared_with_disciplines: isolationSettings.sharedWithDisciplines,
        workspace_id: isolationSettings.workspaceId,
        workspace_type: isolationSettings.workspaceType,
        auto_cleanup: isolationSettings.autoCleanup
      }
    };

    // 3. Insert into target vector table
    const vectorRecord = {
      content,
      metadata: enhancedMetadata,
      embedding,
      organisation_id: userContext.organisationId,
      project_id: documentData.projectId || null,
      project_phase_assignment_id: documentData.phaseId || null,
      created_by_user_id: userContext.userId,
      access_scope: isolationSettings.accessScope,
      shared_with_disciplines: isolationSettings.sharedWithDisciplines,
      workspace_id: isolationSettings.workspaceId,
      workspace_type: isolationSettings.workspaceType
    };

    await supabase.from('target_vector_table').insert(vectorRecord);
    return { success: true, vectorId: vectorRecord.id };
  }
}
```

#### **Step 3.2: Search Function Enhancement**
```sql
-- Enhanced search function with isolation
CREATE OR REPLACE FUNCTION search_{table_name}_with_isolation(
  query_embedding vector(1536),
  user_id uuid,
  user_discipline text DEFAULT NULL,
  workspace_id uuid DEFAULT NULL,
  access_scopes text[] DEFAULT ARRAY['private', 'shared', 'public']
)
RETURNS TABLE(id uuid, content text, metadata jsonb, similarity float8) AS $$
BEGIN
  RETURN QUERY
  SELECT
    v.id,
    v.content,
    v.metadata,
    1 - (v.embedding <=> query_embedding) AS similarity
  FROM target_vector_table v
  WHERE v.deleted_at IS NULL
    AND v.access_scope = ANY(access_scopes)
    AND (
      v.created_by_user_id = user_id
      OR v.access_scope IN ('public', 'shared')
      OR (user_discipline IS NOT NULL AND user_discipline = ANY(v.shared_with_disciplines))
      OR EXISTS (
        SELECT 1 FROM user_roles
        WHERE user_id = user_id
        AND role IN ('director', 'admin', 'discipline_manager')
      )
    )
    AND (workspace_id IS NULL OR v.workspace_id = workspace_id)
  ORDER BY v.embedding <=> query_embedding
  LIMIT 20;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

#### **Step 3.3: Workspace Management API**
```javascript
// Workspace management endpoints
app.post('/api/workspaces', async (req, res) => {
  const { name, type, autoCleanupAfter, disciplineRestrictions } = req.body;
  const userId = req.user.id;

  const workspace = await db.vector_workspaces.insert({
    name,
    workspace_type: type,
    auto_cleanup_after: autoCleanupAfter,
    discipline_restrictions: disciplineRestrictions,
    created_by: userId
  });

  res.json({ success: true, workspace });
});

app.delete('/api/workspaces/:workspaceId', async (req, res) => {
  const { workspaceId } = req.params;
  const userId = req.user.id;

  // Soft delete workspace and all vectors
  await db.vector_workspaces.update(workspaceId, { is_active: false });
  await db.target_vector_table.update(
    { workspace_id: workspaceId },
    {
      deleted_at: new Date(),
      deleted_by: userId,
      deletion_reason: 'Workspace deletion'
    }
  );

  res.json({ success: true });
});
```

#### **Step 3.4: Deletion Management System**
```javascript
// Deletion service
class VectorDeletionService {
  async deleteVector(vectorId, userId, reason) {
    const canDelete = await this.checkDeletionPermissions(vectorId, userId);
    if (!canDelete) throw new Error('Insufficient permissions');

    await db.target_vector_table.update(vectorId, {
      deleted_at: new Date(),
      deleted_by: userId,
      deletion_reason: reason,
      scheduled_hard_delete_at: new Date(Date.now() + 24 * 60 * 60 * 1000) // 24 hours
    });

    await this.auditDeletion(vectorId, userId, reason);
    return { success: true };
  }

  async cleanupExpiredVectors() {
    const expiredVectors = await db.target_vector_table.find({
      scheduled_hard_delete_at: { $lt: new Date() }
    });

    for (const vector of expiredVectors) {
      await db.target_vector_table.destroy(vector.id);
    }

    return { deletedCount: expiredVectors.length };
  }
}
```

### **Phase 4: Frontend Implementation (4-6 Days)**

#### **Step 4.1: Enhanced Existing Upload Modals**
```jsx
// Create reusable VectorIsolationSection component
const VectorIsolationSection = ({ discipline, onIsolationChange, organizationId }) => {
  const [isolationSettings, setIsolationSettings] = useState({
    accessScope: 'private',
    workspaceId: null,
    sharedWithDisciplines: [],
    autoCleanup: null,
    workspaceType: 'personal',
    documentType: '' // Discipline-based document type selection
  });

  // Load document types based on discipline (following templates page pattern)
  const [documentTypes, setDocumentTypes] = useState([]);
  useEffect(() => {
    if (discipline) {
      getDocumentTypesForDiscipline(discipline).then(setDocumentTypes);
    }
  }, [discipline]);

  const handleSettingsChange = (newSettings) => {
    setIsolationSettings(newSettings);
    onIsolationChange(newSettings);
  };

  return (
    <div className="vector-isolation-section">
      <h4>Vector Data Access Control</h4>

      {/* Access Scope Selection */}
      <AccessScopeSelector
        value={isolationSettings.accessScope}
        onChange={(scope) => handleSettingsChange({...isolationSettings, accessScope: scope})}
      />

      {/* Discipline-based Document Type Selection */}
      <DocumentTypeSelector
        discipline={discipline}
        availableTypes={documentTypes}
        value={isolationSettings.documentType}
        onChange={(type) => handleSettingsChange({...isolationSettings, documentType: type})}
      />

      {/* Conditional Discipline Sharing */}
      {isolationSettings.accessScope === 'shared' && (
        <DisciplineSharingSelector
          availableDisciplines={getOrganizationDisciplines(organizationId)}
          selected={isolationSettings.sharedWithDisciplines}
          onChange={(disciplines) => handleSettingsChange({...isolationSettings, sharedWithDisciplines: disciplines})}
        />
      )}

      {/* Workspace Selection */}
      <WorkspaceSelector
        selectedWorkspace={isolationSettings.workspaceId}
        onWorkspaceChange={(workspaceId) => handleSettingsChange({...isolationSettings, workspaceId})}
      />

      {/* Temporary Settings */}
      {isolationSettings.accessScope === 'temporary' && (
        <TemporarySettings
          autoCleanup={isolationSettings.autoCleanup}
          onCleanupChange={(cleanup) => handleSettingsChange({...isolationSettings, autoCleanup: cleanup})}
        />
      )}
    </div>
  );
};

// Integration into existing UpsertFileModal
const EnhancedUpsertFileModal = ({ modalProps }) => {
  const [isolationSettings, setIsolationSettings] = useState({});

  // Existing modal logic...
  const handleSubmit = useCallback(async () => {
    // ... existing validation ...

    // Enhanced upload with isolation metadata
    const enhancedMetadata = {
      ...existingMetadata,
      isolation: isolationSettings
    };

    // Pass to existing /api/process endpoint
    await uploadWithIsolation(files, enhancedMetadata);
  }, [files, existingMetadata, isolationSettings]);

  return (
    <Modal>
      {/* Existing file upload UI */}
      <FileUploadSection />

      {/* Existing processing options */}
      <OCRToggleSection />

      {/* NEW: Vector Isolation Section */}
      <VectorIsolationSection
        discipline="00435"
        organizationId={organizationId}
        onIsolationChange={setIsolationSettings}
      />

      {/* Existing submit button */}
      <button onClick={handleSubmit}>Upload & Process</button>
    </Modal>
  );
};
```

#### **Step 4.2: Access Control Components**
```jsx
const AccessIsolationSection = ({ settings, onSettingsChange, currentDiscipline }) => {
  return (
    <div className="access-isolation-section">
      <h4>Access Control & Data Isolation</h4>

      {/* Access Scope Selection */}
      <div className="form-group">
        <label>Access Scope:</label>
        <AccessScopeSelector
          value={settings.accessScope}
          onChange={(scope) => onSettingsChange({...settings, accessScope: scope})}
        />
      </div>

      {/* Conditional Discipline Sharing */}
      {settings.accessScope === 'shared' && (
        <DisciplineSharingSelector
          availableDisciplines={getOrganizationDisciplines(currentUser.organizationId)}
          selected={settings.sharedWithDisciplines}
          onChange={(disciplines) => onSettingsChange({...settings, sharedWithDisciplines: disciplines})}
        />
      )}

      {/* Workspace Selection */}
      <WorkspaceSelector
        selectedWorkspace={settings.workspaceId}
        onWorkspaceChange={(workspaceId) =>
          onSettingsChange({...settings, workspaceId})
        }
      />

      {/* Temporary Settings */}
      {settings.accessScope === 'temporary' && (
        <TemporarySettings
          autoCleanup={settings.autoCleanup}
          onCleanupChange={(cleanup) =>
            onSettingsChange({...settings, autoCleanup: cleanup})
          }
        />
      )}
    </div>
  );
};
```

#### **Step 4.3: Workspace Management Interface**
```jsx
const WorkspaceManager = ({ discipline }) => {
  const [workspaces, setWorkspaces] = useState([]);

  useEffect(() => {
    loadWorkspaces(discipline).then(setWorkspaces);
  }, [discipline]);

  const createWorkspace = async (config) => {
    const workspace = await api.createWorkspace({
      ...config,
      disciplineRestrictions: [discipline]
    });
    setWorkspaces([...workspaces, workspace]);
  };

  return (
    <div className="workspace-manager">
      <h3>Workspace Management</h3>
      <WorkspaceList workspaces={workspaces} />
      <CreateWorkspaceModal onCreate={createWorkspace} />
    </div>
  );
};
```

### **Phase 5: Integration and Testing (3-5 Days)**

#### **Step 5.1: Chatbot Integration**
```jsx
const DisciplineChatbot = ({ pageId, userId, discipline }) => {
  const [currentWorkspace, setCurrentWorkspace] = useState('default');

  const performVectorSearch = async (query) => {
    return await searchVectorsWithIsolation({
      query,
      userId,
      discipline,
      workspaceId: currentWorkspace,
      accessScopes: ['private', 'shared', 'public']
    });
  };

  return (
    <div className="discipline-chatbot">
      <WorkspaceContextSelector
        currentWorkspace={currentWorkspace}
        onWorkspaceChange={setCurrentWorkspace}
        discipline={discipline}
      />
      <ChatbotBase
        pageId={pageId}
        discipline={discipline}
        userId={userId}
        vectorSearchFunction={performVectorSearch}
        context={`Working in ${currentWorkspace} workspace`}
      />
    </div>
  );
};
```

#### **Step 5.2: Cross-Discipline Access Mapping**
```jsx
const DisciplineAccessMatrix = ({ currentDiscipline }) => {
  const disciplines = [
    'civil_engineering', 'electrical_engineering', 'mechanical_engineering',
    'procurement', 'finance', 'legal', 'safety', 'project_management'
  ];

  const [permissions, setPermissions] = useState({});

  const updatePermission = (targetDiscipline, accessLevel) => {
    setPermissions({
      ...permissions,
      [`${currentDiscipline}_${targetDiscipline}`]: accessLevel
    });
  };

  return (
    <div className="discipline-access-matrix">
      <h4>Cross-Discipline Access Permissions</h4>
      <table>
        <thead>
          <tr>
            <th>Discipline</th>
            <th>Access Level</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          {disciplines.map(discipline => (
            <tr key={discipline}>
              <td>{discipline.replace('_', ' ').toUpperCase()}</td>
              <td>
                <select
                  value={permissions[`${currentDiscipline}_${discipline}`] || 'none'}
                  onChange={(e) => updatePermission(discipline, e.target.value)}
                >
                  <option value="none">No Access</option>
                  <option value="read">Read Only</option>
                  <option value="write">Read + Write</option>
                  <option value="admin">Full Admin</option>
                </select>
              </td>
              <td>Can access shared {currentDiscipline} vectors</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};
```

#### **Step 5.3: Testing Procedures**
```javascript
// Unit Tests
describe('Vector Isolation Logic', () => {
  test('user can access own private vectors', async () => {
    const result = await searchVectorsWithIsolation({
      userId: 'user123',
      accessScopes: ['private']
    });
    expect(result.every(v => v.created_by_user_id === 'user123')).toBe(true);
  });

  test('user cannot access other private vectors', async () => {
    const result = await searchVectorsWithIsolation({
      userId: 'user123',
      accessScopes: ['private']
    });
    expect(result.some(v => v.created_by_user_id !== 'user123')).toBe(false);
  });

  test('shared vectors are accessible to specified disciplines', async () => {
    const result = await searchVectorsWithIsolation({
      userId: 'user456',
      userDiscipline: 'civil_engineering',
      accessScopes: ['shared']
    });
    expect(result.some(v => v.shared_with_disciplines.includes('civil_engineering'))).toBe(true);
  });
});

// Integration Tests
describe('End-to-End Vector Isolation', () => {
  test('upload with isolation settings', async () => {
    const isolationSettings = {
      accessScope: 'shared',
      sharedWithDisciplines: ['civil_engineering'],
      workspaceId: 'workspace123'
    };

    const result = await processDocumentWithIsolation(documentData, isolationSettings, userContext);

    const savedVector = await db.target_vector_table.find(result.vectorId);
    expect(savedVector.access_scope).toBe('shared');
    expect(savedVector.shared_with_disciplines).toContain('civil_engineering');
    expect(savedVector.workspace_id).toBe('workspace123');
  });
});
```

### **Phase 6: Deployment and Monitoring (2-3 Days)**

#### **Step 6.1: Data Migration**
```sql
-- Migrate existing vectors to default workspace
UPDATE target_vector_table
SET workspace_id = 'default_workspace_id'
WHERE workspace_id IS NULL;

-- Set default access scope for existing vectors
UPDATE target_vector_table
SET access_scope = 'private'
WHERE access_scope IS NULL;

-- Assign created_by_user_id for existing vectors
UPDATE target_vector_table
SET created_by_user_id = (
  SELECT created_by FROM documents
  WHERE documents.id = target_vector_table.document_id
  LIMIT 1
)
WHERE created_by_user_id IS NULL;
```

#### **Step 6.2: Feature Flag Implementation**
```javascript
// Feature flag for gradual rollout
const VECTOR_ISOLATION_ENABLED = process.env.VECTOR_ISOLATION_ENABLED === 'true';

if (VECTOR_ISOLATION_ENABLED) {
  // Enable isolation features
  app.use('/api/vector-isolation', vectorIsolationRoutes);
} else {
  // Fallback to original behavior
  app.use('/api/vectors', legacyVectorRoutes);
}
```

#### **Step 6.3: Monitoring Setup**
```javascript
// Performance monitoring
app.use('/api/vectors/*', (req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    const duration = Date.now() - start;
    if (duration > 5000) { // Log slow queries
      logger.warn('Slow vector query', {
        duration,
        userId: req.user.id,
        endpoint: req.path,
        isolationEnabled: VECTOR_ISOLATION_ENABLED
      });
    }
  });
  next();
});

// Security monitoring
const auditVectorAccess = (userId, action, resourceId, metadata) => {
  logger.info('Vector access audit', {
    userId,
    action,
    resourceId,
    metadata,
    timestamp: new Date().toISOString()
  });
};
```

## 📋 **Quality Assurance Checklist**

### **Pre-Deployment Checklist**
- [ ] Database schema changes applied successfully
- [ ] RLS policies tested and validated
- [ ] API endpoints responding correctly
- [ ] Frontend components rendering properly
- [ ] Cross-discipline sharing working as expected
- [ ] Workspace management functional
- [ ] Deletion workflows operational
- [ ] Performance benchmarks met
- [ ] Security audit passed

### **Post-Deployment Validation**
- [ ] User acceptance testing completed
- [ ] Performance monitoring active
- [ ] Audit logging functional
- [ ] Rollback procedures tested
- [ ] Documentation updated
- [ ] Training materials distributed

## 🔧 **Troubleshooting Guide**

### **Common Issues and Solutions**

#### **Issue: RLS Policies Blocking Access**
```sql
-- Check RLS policy application
SELECT schemaname, tablename, rowsecurity
FROM pg_tables
WHERE tablename = 'target_vector_table';

-- Temporarily disable RLS for debugging
ALTER TABLE target_vector_table DISABLE ROW LEVEL SECURITY;
-- Re-enable after fixing policies
ALTER TABLE target_vector_table ENABLE ROW LEVEL SECURITY;
```

#### **Issue: Slow Query Performance**
```sql
-- Check query execution plan
EXPLAIN ANALYZE
SELECT * FROM target_vector_table
WHERE access_scope = 'shared'
  AND created_by_user_id = $1;

-- Add composite indexes if needed
CREATE INDEX CONCURRENTLY idx_access_user
ON target_vector_table(access_scope, created_by_user_id);
```

#### **Issue: Workspace Cleanup Not Working**
```sql
-- Check cleanup function execution
SELECT cleanup_temporary_workspaces();

-- Verify scheduled job configuration
SELECT job_name, schedule, active
FROM cron.job
WHERE job_name LIKE '%cleanup%';
```

#### **Issue: Cross-Discipline Access Not Working**
```sql
-- Check discipline sharing configuration
SELECT id, access_scope, shared_with_disciplines
FROM target_vector_table
WHERE access_scope = 'shared';

-- Verify user discipline mapping
SELECT user_id, discipline
FROM user_discipline_assignments
WHERE user_id = $1;
```

### **Rollback Procedures**

#### **Database Rollback**
```sql
-- Remove isolation columns
ALTER TABLE target_vector_table
DROP COLUMN IF EXISTS isolation_metadata,
DROP COLUMN IF EXISTS created_by_user_id,
DROP COLUMN IF EXISTS access_scope,
DROP COLUMN IF EXISTS shared_with_disciplines,
DROP COLUMN IF EXISTS workspace_id,
DROP COLUMN IF EXISTS workspace_type,
DROP COLUMN IF EXISTS deleted_at,
DROP COLUMN IF EXISTS deleted_by,
DROP COLUMN IF EXISTS deletion_reason,
DROP COLUMN IF EXISTS scheduled_hard_delete_at;
```

#### **Application Rollback**
```javascript
// Disable feature flag
process.env.VECTOR_ISOLATION_ENABLED = 'false';

// Revert to original search functions
const searchVectors = async (params) => {
  // Original search logic without isolation
  return await legacyVectorSearch(params);
};
```

## 📊 **Success Metrics**

### **Functional Metrics**
- ✅ Zero data leakage between isolated vectors
- ✅ <5 second average query response time
- ✅ 100% user satisfaction with access controls
- ✅ Seamless chatbot integration

### **Performance Metrics**
- ✅ <10% increase in database storage
- ✅ <5% degradation in query performance
- ✅ 95% of expired temporary data auto-cleaned
- ✅ <1% error rate in isolation logic

### **Adoption Metrics**
- ✅ 80% of users actively using workspaces within 30 days
- ✅ 60% of vectors assigned to specific workspaces
- ✅ 40% of vectors shared across disciplines
- ✅ Positive feedback from 90% of users

## 🔄 **Advanced Features (Optional Enhancements)**

### **Feature 7.1: Data Migration Strategies**
```sql
-- Advanced migration for large datasets
CREATE OR REPLACE FUNCTION migrate_vectors_with_isolation(
  source_table TEXT,
  target_table TEXT,
  batch_size INTEGER DEFAULT 1000
)
RETURNS TABLE(processed INTEGER, errors INTEGER) AS $$
DECLARE
  total_processed INTEGER := 0;
  total_errors INTEGER := 0;
  current_batch RECORD;
BEGIN
  -- Create temporary migration table
  EXECUTE format('CREATE TEMP TABLE migration_batch AS
    SELECT id, content, metadata, embedding, organisation_id, project_id, project_phase_assignment_id
    FROM %I
    WHERE created_by_user_id IS NULL
    LIMIT %s', source_table, batch_size);

  -- Process each record with isolation defaults
  FOR current_batch IN SELECT * FROM migration_batch LOOP
    BEGIN
      EXECUTE format('INSERT INTO %I (
        id, content, metadata, embedding, organisation_id, project_id,
        project_phase_assignment_id, created_by_user_id, access_scope,
        workspace_id, workspace_type
      ) VALUES (
        $1, $2, $3, $4, $5, $6, $7,
        (SELECT id FROM auth.users WHERE email LIKE ''system@migration.local'' LIMIT 1),
        ''private'', ''default'', ''personal''
      )', target_table)
      USING
        current_batch.id, current_batch.content, current_batch.metadata,
        current_batch.embedding, current_batch.organisation_id,
        current_batch.project_id, current_batch.project_phase_assignment_id;

      total_processed := total_processed + 1;
    EXCEPTION WHEN OTHERS THEN
      total_errors := total_errors + 1;
      RAISE NOTICE 'Migration error for record %: %', current_batch.id, SQLERRM;
    END;
  END LOOP;

  -- Cleanup
  DROP TABLE migration_batch;

  RETURN QUERY SELECT total_processed, total_errors;
END;
$$ LANGUAGE plpgsql;
```

### **Feature 7.2: Backup and Recovery Procedures**
```sql
-- Vector data backup function
CREATE OR REPLACE FUNCTION backup_vector_isolation_data(
  backup_table_suffix TEXT DEFAULT ''
)
RETURNS TEXT AS $$
DECLARE
  backup_timestamp TEXT;
  backup_table_name TEXT;
BEGIN
  backup_timestamp := to_char(NOW(), 'YYYY_MM_DD_HH24_MI_SS');
  backup_table_name := 'vector_isolation_backup_' || backup_timestamp || backup_table_suffix;

  -- Backup workspaces
  EXECUTE format('CREATE TABLE %I AS SELECT * FROM vector_workspaces', backup_table_name || '_workspaces');

  -- Backup deletion audit
  EXECUTE format('CREATE TABLE %I AS SELECT * FROM vector_deletion_audit', backup_table_name || '_audit');

  -- Backup policies
  EXECUTE format('CREATE TABLE %I AS SELECT * FROM vector_deletion_policies', backup_table_name || '_policies');

  -- Create recovery function
  EXECUTE format('
    CREATE OR REPLACE FUNCTION restore_vector_isolation_%s()
    RETURNS VOID AS $restore$
    BEGIN
      -- Restore workspaces (avoiding conflicts)
      INSERT INTO vector_workspaces
      SELECT * FROM %I
      ON CONFLICT (id) DO NOTHING;

      -- Restore policies
      INSERT INTO vector_deletion_policies
      SELECT * FROM %I
      ON CONFLICT (id) DO NOTHING;

      -- Note: Audit logs are append-only, no restoration needed
    END;
    $restore$ LANGUAGE plpgsql;
  ', backup_timestamp, backup_table_name || '_workspaces', backup_table_name || '_policies');

  RETURN 'Backup completed: ' || backup_table_name || '. Use restore_vector_isolation_' || backup_timestamp || '() to restore.';
END;
$$ LANGUAGE plpgsql;
```

### **Feature 7.3: Compliance and Audit Enhancements**
```sql
-- GDPR compliance: Right to erasure
CREATE OR REPLACE FUNCTION gdpr_erase_user_vectors(
  target_user_id UUID,
  erasure_reason TEXT DEFAULT 'GDPR Right to Erasure'
)
RETURNS TABLE(vectors_deleted INTEGER, workspaces_deleted INTEGER) AS $$
DECLARE
  deleted_vectors INTEGER := 0;
  deleted_workspaces INTEGER := 0;
BEGIN
  -- Soft delete all user's vectors
  UPDATE target_vector_table
  SET
    deleted_at = NOW(),
    deleted_by = target_user_id,
    deletion_reason = erasure_reason,
    scheduled_hard_delete_at = NOW() + INTERVAL '30 days'
  WHERE created_by_user_id = target_user_id
    AND deleted_at IS NULL;

  GET DIAGNOSTICS deleted_vectors = ROW_COUNT;

  -- Mark user's workspaces as deleted
  UPDATE vector_workspaces
  SET is_active = false
  WHERE created_by = target_user_id;

  GET DIAGNOSTICS deleted_workspaces = ROW_COUNT;

  -- Audit the erasure
  INSERT INTO vector_deletion_audit (
    vector_id, table_name, deleted_by, deletion_reason, deletion_type
  )
  SELECT
    id, 'target_vector_table', target_user_id,
    'GDPR Erasure: ' || erasure_reason, 'gdpr_erasure'
  FROM target_vector_table
  WHERE created_by_user_id = target_user_id;

  RETURN QUERY SELECT deleted_vectors, deleted_workspaces;
END;
$$ LANGUAGE plpgsql;
```

### **Feature 7.4: Performance Optimization Strategies**
```sql
-- Query performance optimization
CREATE OR REPLACE FUNCTION optimize_vector_queries()
RETURNS TABLE(optimization TEXT, impact TEXT) AS $$
BEGIN
  -- Analyze table statistics
  ANALYZE target_vector_table;

  -- Rebuild indexes if needed
  REINDEX INDEX CONCURRENTLY idx_target_vector_table_isolation_access;
  REINDEX INDEX CONCURRENTLY idx_target_vector_table_workspace;

  -- Update table statistics for better query planning
  UPDATE pg_statistic SET stadistinct = -0.1
  WHERE starelid = 'target_vector_table'::regclass
    AND staattnum = (SELECT attnum FROM pg_attribute
                     WHERE attrelid = 'target_vector_table'::regclass
                       AND attname = 'access_scope');

  RETURN QUERY
  SELECT 'Table Statistics Updated'::TEXT, 'Improved query planning'::TEXT
  UNION ALL
  SELECT 'Indexes Rebuilt'::TEXT, 'Faster isolation queries'::TEXT
  UNION ALL
  SELECT 'Column Statistics Optimized'::TEXT, 'Better access_scope filtering'::TEXT;
END;
$$ LANGUAGE plpgsql;

-- Caching layer for frequently accessed vectors
CREATE TABLE vector_access_cache (
  cache_key TEXT PRIMARY KEY,
  user_id UUID NOT NULL,
  discipline TEXT,
  workspace_id UUID,
  access_scopes TEXT[],
  cached_results JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  expires_at TIMESTAMPTZ DEFAULT (NOW() + INTERVAL '1 hour')
);

-- Cache-aware search function
CREATE OR REPLACE FUNCTION search_vectors_cached(
  query_embedding vector(1536),
  user_id uuid,
  user_discipline text DEFAULT NULL,
  workspace_id uuid DEFAULT NULL,
  access_scopes text[] DEFAULT ARRAY['private', 'shared', 'public'],
  use_cache boolean DEFAULT true
)
RETURNS TABLE(id uuid, content text, metadata jsonb, similarity float8, cached boolean) AS $$
DECLARE
  cache_key TEXT;
  cached_result JSONB;
BEGIN
  -- Generate cache key
  cache_key := md5(user_id::text || COALESCE(user_discipline, '') ||
                   COALESCE(workspace_id::text, '') || array_to_string(access_scopes, ','));

  -- Check cache if enabled
  IF use_cache THEN
    SELECT cached_results INTO cached_result
    FROM vector_access_cache
    WHERE cache_key = cache_key
      AND expires_at > NOW()
      AND user_id = user_id;

    IF FOUND THEN
      -- Return cached results
      RETURN QUERY
      SELECT
        (result->>'id')::uuid,
        result->>'content',
        (result->>'metadata')::jsonb,
        (result->>'similarity')::float8,
        true as cached
      FROM jsonb_array_elements(cached_result) AS result;
      RETURN;
    END IF;
  END IF;

  -- Execute search and cache results
  RETURN QUERY
  SELECT
    v.id, v.content, v.metadata, similarity, false as cached
  FROM search_target_vector_table_with_isolation(
    query_embedding, user_id, user_discipline, workspace_id, access_scopes
  ) v;

  -- Cache the results if enabled
  IF use_cache THEN
    INSERT INTO vector_access_cache (cache_key, user_id, discipline, workspace_id, access_scopes, cached_results)
    SELECT
      cache_key, user_id, user_discipline, workspace_id, access_scopes,
      jsonb_agg(jsonb_build_object(
        'id', v.id,
        'content', v.content,
        'metadata', v.metadata,
        'similarity', v.similarity
      ))
    FROM search_target_vector_table_with_isolation(
      query_embedding, user_id, user_discipline, workspace_id, access_scopes
    ) v;
  END IF;
END;
$$ LANGUAGE plpgsql;
```

### **Feature 7.5: Bulk Operations Support**
```javascript
// Bulk isolation settings application
const BulkIsolationManager = {
  async applyBulkIsolation(vectors, isolationSettings) {
    const batchSize = 50;
    const results = { success: 0, failed: 0, errors: [] };

    for (let i = 0; i < vectors.length; i += batchSize) {
      const batch = vectors.slice(i, i + batchSize);

      try {
        await api.updateVectorsIsolation(batch.map(v => v.id), isolationSettings);
        results.success += batch.length;
      } catch (error) {
        results.failed += batch.length;
        results.errors.push(`Batch ${Math.floor(i/batchSize) + 1}: ${error.message}`);
      }
    }

    return results;
  },

  async exportVectorsWithIsolation(criteria) {
    const vectors = await api.searchVectors(criteria);
    const exportData = vectors.map(vector => ({
      id: vector.id,
      content: vector.content,
      isolation: {
        access_scope: vector.access_scope,
        shared_with_disciplines: vector.shared_with_disciplines,
        workspace_id: vector.workspace_id,
        created_by_user_id: vector.created_by_user_id
      },
      metadata: vector.metadata
    }));

    return exportData;
  },

  async importVectorsWithIsolation(importData, defaultIsolation = {}) {
    const results = { imported: 0, skipped: 0, errors: [] };

    for (const item of importData) {
      try {
        const isolationSettings = {
          ...defaultIsolation,
          ...item.isolation
        };

        await api.importVectorWithIsolation(item, isolationSettings);
        results.imported++;
      } catch (error) {
        results.errors.push(`Vector ${item.id}: ${error.message}`);
        results.skipped++;
      }
    }

    return results;
  }
};
```

### **Feature 7.6: Analytics and Reporting**
```sql
-- Vector usage analytics
CREATE OR REPLACE FUNCTION generate_vector_usage_report(
  start_date DATE DEFAULT CURRENT_DATE - INTERVAL '30 days',
  end_date DATE DEFAULT CURRENT_DATE
)
RETURNS TABLE(
  metric TEXT,
  value BIGINT,
  percentage_change DECIMAL
) AS $$
BEGIN
  RETURN QUERY
  WITH current_metrics AS (
    SELECT
      COUNT(*) as total_vectors,
      COUNT(DISTINCT created_by_user_id) as active_users,
      COUNT(DISTINCT workspace_id) as active_workspaces,
      AVG(CASE WHEN access_scope = 'shared' THEN 1 ELSE 0 END) * 100 as shared_percentage
    FROM target_vector_table
    WHERE created_at >= start_date AND created_at <= end_date
  ),
  previous_metrics AS (
    SELECT
      COUNT(*) as total_vectors,
      COUNT(DISTINCT created_by_user_id) as active_users,
      COUNT(DISTINCT workspace_id) as active_workspaces,
      AVG(CASE WHEN access_scope = 'shared' THEN 1 ELSE 0 END) * 100 as shared_percentage
    FROM target_vector_table
    WHERE created_at >= start_date - (end_date - start_date) AND created_at < start_date
  )
  SELECT
    'Total Vectors'::TEXT,
    cm.total_vectors,
    CASE WHEN pm.total_vectors > 0
         THEN ((cm.total_vectors - pm.total_vectors)::DECIMAL / pm.total_vectors) * 100
         ELSE NULL END
  FROM current_metrics cm, previous_metrics pm
  UNION ALL
  SELECT
    'Active Users'::TEXT,
    cm.active_users,
    CASE WHEN pm.active_users > 0
         THEN ((cm.active_users - pm.active_users)::DECIMAL / pm.active_users) * 100
         ELSE NULL END
  FROM current_metrics cm, previous_metrics pm
  UNION ALL
  SELECT
    'Active Workspaces'::TEXT,
    cm.active_workspaces,
    CASE WHEN pm.active_workspaces > 0
         THEN ((cm.active_workspaces - pm.active_workspaces)::DECIMAL / pm.active_workspaces) * 100
         ELSE NULL END
  FROM current_metrics cm, previous_metrics pm
  UNION ALL
  SELECT
    'Shared Vectors %'::TEXT,
    ROUND(cm.shared_percentage)::BIGINT,
    cm.shared_percentage - pm.shared_percentage
  FROM current_metrics cm, previous_metrics pm;
END;
$$ LANGUAGE plpgsql;

-- Access pattern analysis
CREATE OR REPLACE FUNCTION analyze_access_patterns()
RETURNS TABLE(
  access_scope TEXT,
  total_accesses BIGINT,
  unique_users BIGINT,
  avg_response_time DECIMAL,
  peak_usage_hour INTEGER
) AS $$
BEGIN
  -- This would integrate with your access logging system
  -- Implementation depends on your audit logging setup
  RETURN QUERY
  SELECT
    v.access_scope::TEXT,
    COUNT(al.*)::BIGINT as total_accesses,
    COUNT(DISTINCT al.user_id)::BIGINT as unique_users,
    AVG(al.response_time)::DECIMAL as avg_response_time,
    MODE() WITHIN GROUP (ORDER BY EXTRACT(hour FROM al.access_time))::INTEGER as peak_usage_hour
  FROM target_vector_table v
  LEFT JOIN access_logs al ON al.resource_id = v.id
  WHERE al.access_time >= CURRENT_DATE - INTERVAL '30 days'
  GROUP BY v.access_scope;
END;
$$ LANGUAGE plpgsql;
```

### **Feature 7.7: Real-time Collaboration Features**
```javascript
// Real-time workspace collaboration
const RealTimeWorkspaceManager = {
  joinWorkspace(workspaceId, userId) {
    // Subscribe to workspace changes
    this.socket.emit('join_workspace', { workspaceId, userId });

    // Listen for real-time updates
    this.socket.on('workspace_updated', (update) => {
      this.handleWorkspaceUpdate(update);
    });

    this.socket.on('vector_shared', (shareEvent) => {
      this.handleVectorShare(shareEvent);
    });
  },

  async shareVectorRealtime(vectorId, targetUsers, permissions) {
    // Update permissions in database
    await api.shareVector(vectorId, targetUsers, permissions);

    // Broadcast to connected users
    this.socket.emit('vector_shared', {
      vectorId,
      sharedBy: currentUser.id,
      targetUsers,
      permissions,
      timestamp: new Date()
    });
  },

  handleWorkspaceUpdate(update) {
    // Update local workspace state
    this.updateLocalWorkspace(update.workspaceId, update.changes);

    // Notify user of changes
    this.showNotification(`${update.userName} updated workspace ${update.workspaceName}`);
  },

  handleVectorShare(shareEvent) {
    // Add shared vector to local view
    this.addSharedVector(shareEvent.vectorId, shareEvent.permissions);

    // Show share notification
    this.showNotification(`New vector shared by ${shareEvent.sharedBy}`);
  }
};
```

### **Feature 7.8: API Rate Limiting and Abuse Protection**
```javascript
// Rate limiting for vector operations
const VectorRateLimiter = {
  limits: {
    search: { window: '1 minute', max: 100 },
    upload: { window: '1 hour', max: 50 },
    delete: { window: '1 hour', max: 20 },
    share: { window: '1 hour', max: 30 }
  },

  async checkLimit(operation, userId) {
    const limit = this.limits[operation];
    if (!limit) return true; // No limit for this operation

    const key = `vector_${operation}_${userId}`;
    const current = await redis.get(key) || 0;

    if (current >= limit.max) {
      throw new Error(`Rate limit exceeded for ${operation}. Max ${limit.max} per ${limit.window}`);
    }

    // Increment counter with expiration
    await redis.incr(key);
    await redis.expire(key, this.parseWindow(limit.window));

    return true;
  },

  parseWindow(window) {
    const match = window.match(/(\d+)\s*(minute|hour|day)/);
    if (!match) return 60; // Default 1 minute

    const [_, num, unit] = match;
    const multipliers = { minute: 60, hour: 3600, day: 86400 };
    return parseInt(num) * multipliers[unit];
  }
};

// Apply rate limiting to API routes
app.use('/api/vectors/search', async (req, res, next) => {
  try {
    await VectorRateLimiter.checkLimit('search', req.user.id);
    next();
  } catch (error) {
    res.status(429).json({ error: error.message });
  }
});
```

### **Feature 7.9: Data Archiving and Long-term Storage**
```sql
-- Automatic archiving for old vectors
CREATE OR REPLACE FUNCTION archive_old_vectors(
  archive_after_days INTEGER DEFAULT 365,
  archive_table_suffix TEXT DEFAULT ''
)
RETURNS TABLE(archived_count INTEGER, archive_table_name TEXT) AS $$
DECLARE
  archive_timestamp TEXT;
  archive_table_name TEXT;
  archived_count INTEGER := 0;
BEGIN
  archive_timestamp := to_char(NOW(), 'YYYY_MM_DD');
  archive_table_name := 'vector_archive_' || archive_timestamp || archive_table_suffix;

  -- Create archive table with same structure
  EXECUTE format('CREATE TABLE %I AS
    SELECT * FROM target_vector_table
    WHERE created_at < NOW() - INTERVAL ''%s days''
      AND access_scope = ''private''
      AND workspace_type != ''temporary''
      AND deleted_at IS NULL', archive_table_name, archive_after_days);

  GET DIAGNOSTICS archived_count = ROW_COUNT;

  -- Mark archived vectors
  EXECUTE format('UPDATE target_vector_table
    SET deletion_reason = ''Archived to %s'',
        deleted_at = NOW(),
        scheduled_hard_delete_at = NOW() + INTERVAL ''30 days''
    WHERE id IN (SELECT id FROM %I)', archive_table_name, archive_table_name);

  -- Create index on archive table
  EXECUTE format('CREATE INDEX idx_%s_created_at ON %I(created_at)', archive_table_name, archive_table_name);

  RETURN QUERY SELECT archived_count, archive_table_name;
END;
$$ LANGUAGE plpgsql;

-- Archive retrieval function
CREATE OR REPLACE FUNCTION retrieve_archived_vectors(
  archive_table TEXT,
  search_criteria JSONB
)
RETURNS TABLE(id uuid, content text, metadata jsonb) AS $$
BEGIN
  RETURN QUERY EXECUTE format('
    SELECT id, content, metadata
    FROM %I
    WHERE metadata @> $1', archive_table)
  USING search_criteria;
END;
$$ LANGUAGE plpgsql;
```

### **Feature 7.10: Multi-tenancy and Organization Isolation**
```sql
-- Organization-level workspace policies
CREATE TABLE organization_workspace_policies (
  organization_id UUID PRIMARY KEY,
  max_workspaces_per_user INTEGER DEFAULT 10,
  max_vectors_per_workspace INTEGER DEFAULT 1000,
  allow_cross_discipline_sharing BOOLEAN DEFAULT true,
  default_retention_days INTEGER DEFAULT 90,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Organization-specific access control
CREATE OR REPLACE FUNCTION check_organization_access(
  user_id UUID,
  resource_organization_id UUID
)
RETURNS BOOLEAN AS $$
BEGIN
  -- Check if user belongs to organization
  RETURN EXISTS (
    SELECT 1 FROM user_organization_access
    WHERE user_id = user_id
      AND organization_id = resource_organization_id
      AND access_level IN ('read', 'write', 'admin')
  );
END;
$$ LANGUAGE plpgsql;

-- Enhanced RLS with organization isolation
CREATE POLICY "organization_isolation" ON target_vector_table
FOR ALL USING (
  check_organization_access(auth.uid(), organisation_id)
);

CREATE POLICY "cross_organization_sharing" ON target_vector_table
FOR SELECT USING (
  access_scope IN ('public', 'shared')
  AND check_organization_access(auth.uid(), organisation_id)
);
```

## 📝 **Documentation Updates Required**

### **Post-Implementation Documentation**
- [ ] Update API documentation with new endpoints
- [ ] Add vector isolation section to user guides
- [ ] Create administrator configuration guide
- [ ] Update security documentation
- [ ] Add troubleshooting section to knowledge base

### **Training Materials**
- [ ] Create user training videos
- [ ] Develop administrator setup guide
- [ ] Prepare FAQ document
- [ ] Create quick reference cards

## 🎯 **Completion Criteria**

### **Technical Completion**
- [ ] All database schema changes applied
- [ ] All API endpoints implemented and tested
- [ ] All UI components functional
- [ ] All integration points working
- [ ] Performance benchmarks met
- [ ] Security requirements satisfied

### **Business Completion**
- [ ] User acceptance testing passed
- [ ] Training completed for target users
- [ ] Documentation finalized
- [ ] Support procedures established
- [ ] Monitoring and alerting configured

### **Operational Completion**
- [ ] Production deployment successful
- [ ] Rollback procedures documented
- [ ] Support team trained
- [ ] Incident response procedures updated

## 📞 **Support and Escalation**

### **Primary Support Contacts**
- **Technical Issues**: Backend Engineering Team
- **Database Issues**: Database Administration Team
- **UI/UX Issues**: Frontend Engineering Team
- **User Training**: Product Management Team

### **Escalation Matrix**
1. **Level 1**: Development team investigates and resolves
2. **Level 2**: Senior engineering review if complex
3. **Level 3**: Architecture review for systemic issues
4. **Level 4**: Executive decision for major changes

### **Monitoring and Alerting**
- **Performance Monitoring**: Query response times >5 seconds
- **Security Monitoring**: Unauthorized access attempts
- **Data Integrity**: Missing or corrupted isolation metadata
- **System Health**: API endpoint failures or timeouts

---

## **Document Information**

- **Document ID**: 0500_VECTOR_DATA_ISOLATION_PROCEDURE
- **Version**: 1.0
- **Created**: 2025-11-28
- **Based On**: 1350_00435_VECTOR_DATA_ISOLATION_IMPLEMENTATION_PLAN
- **Next Review**: 2026-05-28

**Related Documents:**
- [1350_00435_VECTOR_DATA_ISOLATION_IMPLEMENTATION_PLAN.md](../data-processing/1350_00435_VECTOR_DATA_ISOLATION_IMPLEMENTATION_PLAN.md)
- [0500_DATA_PROCESSING_MASTER_GUIDE.md](0500_DATA_PROCESSING_MASTER_GUIDE.md)
- [0000_DOCUMENTATION_GUIDE.md](../0000_DOCUMENTATION_GUIDE.md)

**Change History:**
- v1.0 (2025-11-28): Initial procedure document based on successful 00435 implementation
