---
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, codebase, ai-automation
documentation
openstinger_context: agent-development, ai-systems
last_updated: 2026-03-21
related_docs:
  - codebase/agents/
  - disciplines/
---
# Vector System Conventions

> AI/IT conventions for implementing vector tables and upsert functions across all disciplines

---

## Overview

This document specifies the standard patterns for implementing vector tables and upsert functionality across ALL disciplines in the ConstructAI application. The 01900 Procurement implementation serves as the reference model for all other disciplines.

---

## 44 Discipline Vector Tables

### Complete Table Mapping

| Code | Vector Table | Category |
|------|-------------|-----------|
| 00835 | a_00835_chemeng_vector | Engineering |
| 00850 | a_00850_civileng_vector | Engineering |
| 00860 | a_00860_eleceng_vector | Engineering |
| 00870 | a_00870_mecheng_vector | Engineering |
| 00871 | a_00871_processeng_vector | Engineering |
| 00872 | a_00872_developer_vector | Engineering |
| 00875 | a_00875_sales_vector | Engineering |
| 00877 | a_00877_sundry_vector | Engineering |
| 00880 | a_00880_boarddir_vector | Directors |
| 00882 | a_00882_dirconst_vector | Directors |
| 00883 | a_00883_dircontracts_vector | Directors |
| 00884 | a_00884_direng_vector | Directors |
| 00885 | a_00885_dirhse_vector | Directors |
| 00886 | a_00886_dirlogistics_vector | Directors |
| 00888 | a_00888_dirprocurement_vector | Directors |
| 00889 | a_00889_dirfinance_vector | Directors |
| 00890 | a_00890_dirprojects_vector | Directors |
| 00895 | a_00895_dirproject_vector | Directors |
| 00102 | a_00102_admin_vector | Admin/Core |
| 00900 | a_00900_doccontrol_vector | Admin/Core |
| 01000 | a_01000_environmental_vector | Admin/Core |
| 01100 | a_01100_ethics_vector | Admin/Core |
| 01200 | a_01200_finance_vector | Admin/Core |
| 01300 | a_01300_governance_vector | Admin/Core |
| 01400 | a_01400_health_vector | Admin/Core |
| 01500 | a_01500_hr_vector | Admin/Core |
| 01600 | a_01600_localcontent_vector | Admin/Core |
| 01700 | a_01700_logistics_vector | Admin/Core |
| 01750 | a_01750_legal_vector | Admin/Core |
| 01800 | a_01800_operations_vector | Admin/Core |
| 01850 | a_01850_otherparties_vector | Admin/Core |
| 01900 | a_01900_procurement_vector | Admin/Core |
| 02000 | a_02000_projctrl_vector | Project/QM |
| 02025 | a_02025_qs_vector | Project/QM |
| 02035 | a_02035_scheduling_vector | Project/QM |
| 02050 | a_02050_it_vector | Project/QM |
| 02075 | a_02075_inspection_vector | Project/QM |
| 02100 | a_02100_publicrel_vector | Project/QM |
| 02200 | a_02200_qa_vector | Project/QM |
| 02250 | a_02250_qc_vector | Project/QM |
| 02400 | a_02400_safety_vector | Safety/Security |
| 02500 | a_02500_security_vector | Safety/Security |
| 00435 | a_00435_contracts_post_vector | Special |
| 03000 | a_03000_landscaping_vector | Special |

---

## Required Service: VectorProcessingService

**Location:** `server/src/services/VectorProcessingService.js`

All vector table operations MUST use this service for table name resolution:

```javascript
// ✅ CORRECT: Use VectorProcessingService
import VectorProcessingService from '../services/VectorProcessingService.js';
const tableName = VectorProcessingService.getVectorTable(disciplineCode);

// ❌ WRONG: Hardcoded table names
const tableName = 'a_01900_procurement_vector';
```

### getVectorTable() Method

```javascript
getVectorTable(disciplineCode) {
  const tableMap = {
    "00835": "a_00835_chemeng_vector",
    "00850": "a_00850_civileng_vector",
    // ... all 44 disciplines
    "01900": "a_01900_procurement_vector",
    // ...
  };
  
  const tableName = tableMap[disciplineCode];
  if (!tableName) {
    throw new Error(`No vector table found for discipline: ${disciplineCode}`);
  }
  return tableName;
}
```

---

## Required Service: vectorIsolationService

**Location:** `client/src/common/js/services/vectorIsolationService.js`

Frontend utility for workspace and access control:

```javascript
import vectorIsolationService from '@services/vectorIsolationService';

// Get workspace icon
const icon = vectorIsolationService.getWorkspaceIcon(workspaceType);

// Format expiry date
const expiryText = vectorIsolationService.formatExpiry(expiresAt);

// Validate isolation settings
const validation = vectorIsolationService.validateSettings(settings);
```

### Available Functions

| Function | Purpose |
|----------|---------|
| `getWorkspaceIcon(type)` | Returns emoji icon for workspace type |
| `formatExpiry(date)` | Formats expiry date for display |
| `isExpired(date)` | Checks if date has passed |
| `getAccessScopeDescription(scope)` | Returns human-readable scope description |
| `validateSettings(settings)` | Validates isolation settings |
| `getCleanupOptions()` | Returns auto-cleanup duration options |

---

## Upsert Modal Implementation Pattern

Each discipline MUST implement 3 Upsert modals following the 01900 pattern:

### 1. UpsertFileModal
- File upload via drag-and-drop
- Document type selection
- Vector isolation settings
- Access scope configuration

### 2. UpsertUrlModal  
- URL import functionality
- Content type detection
- Processing via LlamaParse/Mammoth

### 3. UpsertCloudModal
- Cloud storage import (Google Drive, Dropbox, SharePoint, OneDrive)
- OAuth authentication
- Batch file selection

---

## Vector Table Schema (Standard)

All discipline vector tables MUST have this schema:

```sql
CREATE TABLE a_XXXXX_discipline_vector (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  embedding VECTOR(1536),
  metadata JSONB,
  content TEXT,
  
  -- Access Control
  access_scope TEXT CHECK (access_scope IN ('private', 'team', 'shared', 'public', 'temporary')),
  workspace_id UUID,
  workspace_type TEXT,
  shared_with_disciplines TEXT[],
  
  -- Isolation
  organisation_id UUID,
  discipline_code TEXT DEFAULT 'XXXXX',
  created_by_user_id UUID,
  
  -- Audit
  deleted_at TIMESTAMPTZ,
  deleted_by UUID,
  deletion_reason TEXT,
  scheduled_hard_delete_at TIMESTAMPTZ,
  isolation_metadata JSONB DEFAULT '{}',
  
  -- Chunking
  chunks JSONB DEFAULT '[]'
);
```

---

## API Endpoints (Standard)

All disciplines use the same endpoints - the discipline is determined from the request:

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/process` | POST | Upload/process documents |
| `/api/vector-isolation/workspaces` | GET/POST | Workspace management |
| `/api/vector-isolation/vectors/:id/access` | GET | Check access |
| `/api/vector-isolation/cleanup/hard-delete` | POST | Cleanup expired vectors |
| `/api/vector-isolation/analytics/overview` | GET | Aggregate analytics |

---

## Key Implementation Rules

1. **NEVER hardcode table names** - Always use `VectorProcessingService.getVectorTable()`
2. **Always include discipline_code** in vector records
3. **Support all 5 access scopes** - private, team, shared, public, temporary
4. **Implement workspace assignment** for document grouping
5. **Use chunking** for large documents (1000 chars, 200 overlap)

---

## Cross-References

- **Procedures:** `docs/procedures/human-workflows/0000_VECTOR_UPSERT_PROCEDURE.md`
- **Isolation:** `docs/procedures/human-workflows/0000_VECTOR_DATA_ISOLATION_PROCEDURE.md`
- **Security:** `docs/procedures/human-workflows/0000_VECTOR_ISOLATION_SECURITY_PROCEDURE.md`

---

**Last Updated:** 2026-02-15
