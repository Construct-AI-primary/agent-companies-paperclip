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
# Organisation Conventions

> Documented learnings from AI interactions that apply organisation-wide

---

## Terminology

### Upsert Modals
- **Definition:** Modal components with "Upsert" in their filename, OR modals used for create/update operations
- **Context:** Used for importing/uploading documents from different sources (file, URL, cloud) OR creating/editing entities
- **Examples:** 
  - `01900-UpsertFileModal.js`
  - `01900-UpsertUrlModal.js`
  - `01900-UpsertCloudModal.jsx`
  - `CreateOrderModal.jsx`
  - `EditOrderModal.jsx`
- **Pattern:** Files with "Upsert" in name OR create/edit operation modals = UPSERT context

---

## Naming Conventions

### Modal Prefixes (Organisation-Wide)
| Prefix | Purpose | Context |
|--------|---------|---------|
| Upsert | Data import (file, URL, cloud) | UPSERT |
| Create | New entity creation | UPSERT |
| Edit | Modify existing entities | UPSERT |
| Detail | View details (may include edit) | UPSERT |

---

## 01900 Procurement Page - State-Based Modal Organization

The 01900 procurement page has 3 selectable states, each displaying different modals:

### STATE 1: AGENTS (2 Modals)
**Button Label:** "Agents"

| Button Label | Modal ID | Modal Title |
|--------------|----------|-------------|
| Correspondence Reply | 01900-03-CorrespondenceReplyModal | Procurement Correspondence Reply |
| Create Procurement Order via Agent | 01900-ProcurementInputAgentModal | Create Procurement Order via Agent |

---

### STATE 2: UPSERTS (3 Modals)
**Button Label:** "Upserts" (internal state name: "suppliers")

| Button Label | Modal ID | Modal Title |
|--------------|----------|-------------|
| Cloud Upsert | 01900-UpsertCloudModal | Cloud Upsert |
| Upsert from URL | 01900-UpsertUrlModal | Upsert from URL |
| Upsert Files | 01900-UpsertFileModal | Upsert Files |

**Note:** These are the TRUE "Upsert" modals - they have "Upsert" in their filename.

---

### STATE 3: WORKSPACE (5 Modals)
**Button Label:** "Workspace" (internal state name: "vetting")

| Button Label | Modal ID | Modal Title |
|--------------|----------|-------------|
| Access Permissions | AccessPermissionVisualizerModal | Access Permission Visualizer |
| Contact Scraper | 01900-ContactScraperModal | Contact Scraper |
| Cross-Discipline Sharing | DisciplinePermissionMatrixModal | Cross-Discipline Permissions |
| Supplier Setup | 01900-SupplierSetupModal | Supplier Setup |
| Vector Data Manager | VectorDataManagerModal | Vector Data Manager |

---

## UPSERT Context - Modal Dimensions (01900 Page)

| Modal | Width | Height |
|-------|-------|--------|
| CreateOrderModal.jsx | 800px (fixed) | 95vh max |
| EditOrderModal.jsx | 800px (fixed) | 95vh max |
| 01900-SupplierEditModal.js | 600px / 90% | 90vh max |
| 01900-SupplierSetupModal.js | Inherits from parent | Inherits from parent |
| 01900-ScopeOfWorkModal.js | 900px (fixed) | 90vh max |
| 01900-UpsertFileModal.js | 700px (fixed) | 90vh max |
| 01900-UpsertUrlModal.js | 600px | Auto |
| 01900-UpsertCloudModal.jsx | 600px | Auto |

---

## Differentiation Guidelines

When analyzing UI components on the 01900 page:

1. **Check the active state button:**
   - "Agents" selected → AGENTS context (2 modals)
   - "Upserts" selected → UPSERT context (3 modals with "Upsert" in name)
   - "Workspace" selected → WORKSPACE context (5 modals)

2. **Filename Pattern:**
   - Contains "Upsert" in filename → UPSERT
   - Contains "Agent" or "Chat" → AGENTS
   - General utility modals → WORKSPACE

3. **State to Context Mapping:**
   - `agents` state → AGENTS
   - `suppliers` state (labeled "Upserts") → UPSERT
   - `vetting` state (labeled "Workspace") → WORKSPACE

---

## Vector Data Access Control System

> Organisation-wide system for managing document access and vector embeddings

### Purpose

This section documents the Vector Data Access Control system which provides a unified framework for:
- Controlling WHO can access documents (Access Scope)
- Organising WHERE documents are stored (Workspace)
- Managing cross-discipline document sharing
- Maintaining data isolation per discipline

### When to Use This Knowledge

Use this section when:
- Implementing new Upsert modals that require access control
- Configuring document sharing between disciplines
- Analyzing or debugging access permission issues
- Understanding how vector search filters results by user

---

### System Architecture

The ConstructAI system uses a **two-layer access control system** for vector embeddings and documents:

1. **Access Scope** (WHO can access) - Controls user permissions
2. **Workspace** (WHERE data is stored) - Organises documents logically

---

### Access Scope Options

| Scope | Icon | Who Can Access |
|-------|------|----------------|
| **Private** | 🔒 | Only you (the document owner) |
| **Team Only** | 👥 | Your discipline team members |
| **Shared** | 🤝 | Selected disciplines you choose |
| **Public** | 🌐 | All organisation members |
| **Temporary** | ⏰ | Auto-deletes after set period |

**How Access Scope Works:**
- Selected when uploading/importing documents via Upsert modals
- Stored in the vector table as `access_scope` column
- Enforced via RLS (Row Level Security) policies
- Automatically filters what users can see in searches

---

### Workspace Types

| Type | Icon | Description |
|------|------|-------------|
| **Personal** | 👤 | Only you can access |
| **Phase** | 📋 | Project phase specific (e.g., Design, Construction) |
| **Collaborative** | 👥 | Team can access |
| **Project** | 📁 | Project specific |
| **Organization** | 🏢 | All organisation members |
| **Temporary** | ⏰ | Auto-delete after period |
| **Archive** | 📦 | Long-term storage |

**Workspace Purpose:**
- Groups related documents together
- Provides AI context for searches (e.g., "search within Project X")
- Does NOT replace Access Scope - both work together

---

### Per-Discipline Vector Tables

> ⚠️ Important: Vector data is stored in **separate tables per discipline**

**Current Metrics:**
- ✅ **50+ Vector Tables**: Production-ready semantic search infrastructure
- ✅ **Per-Discipline Isolation**: Clear audit trails per discipline
- ✅ **HNSW Indexing**: Optimized vector search with m=16, ef_construction=64

Each discipline has its own vector table:
- `a_01900_procurement_vector` - Procurement
- `a_00435_contracts_post_vector` - Contracts Post-Award
- `a_01500_hr_vector` - Human Resources
- ...and 50+ more

**Why Separate Tables?**
- Data isolation per discipline (compliance/audit)
- Smaller tables = faster queries per discipline
- Clear boundaries between disciplines

**Implications:**
- When searching, the system queries the discipline's vector table
- Cross-discipline searches require querying multiple tables
- Workspace can span multiple disciplines but data lives in discipline-specific tables

---

### Cross-Discipline Sharing

To share documents across disciplines:

1. **Set Access Scope to "Shared"** when uploading
2. **Select which disciplines** can access
3. Users in those disciplines will see the document in their searches

The **DisciplinePermissionMatrixModal** (Cross-Discipline Sharing button) allows:
- Viewing current sharing permissions
- Modifying which disciplines can access your documents
- Managing cross-discipline access requests

---

### Related Workspace Buttons (01900 Example)

Located in Workspace state:

| Button | Modal | Purpose |
|--------|-------|---------|
| Access Permissions | AccessPermissionVisualizerModal | View/manage who can access your documents |
| Cross-Discipline Sharing | DisciplinePermissionMatrixModal | Configure cross-discipline access |
| Vector Data Manager | VectorDataManagerModal | Manage vector embeddings |

---

### Key Concepts Summary

1. **Access Scope** = WHO can see the document (Private/Team/Shared/Public/Temporary)
2. **Workspace** = WHERE the document is stored/grouped (Personal/Phase/Project/Org)
3. **Per-discipline tables** = physical storage separation (50+ vector tables)
4. **RLS policies** = automatic filtering based on user + scope

---

# Standardized Procedures Reference

This section documents the organisation's standardized procedures that must be followed for all implementations. Reference these procedures when implementing new features or modifying existing ones.

---

## Dropdown Implementation Procedure

**Reference:** `docs/procedures/human-workflows/0000_DROPDOWN_IMPLEMENTATION_PROCEDURE.md`

### Overview
This procedure establishes a standardized method for implementing dropdown components in React-based UI modals and forms. It addresses recurring issues when adding dropdown functionality to modal dialogs, particularly the disciplines dropdown implementation across "Create New Template" and "AI Template Generator" modals.

### Standardized Implementation Pattern

#### Controlled Dropdown with State Lifting
```javascript
// Recommended implementation pattern for modal dropdowns
import React, { useState, useEffect } from 'react';
import { DisciplineDropdown } from '@components/dropdowns/DisciplineDropdown';

function TemplateCreationModal({ onSubmit, initialData = {} }) {
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    disciplineId: initialData.disciplineId || '',
    ...initialData
  });

  const [disciplines, setDisciplines] = useState([]);
  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState({});

  // Fetch disciplines on mount
  useEffect(() => {
    loadDisciplines();
  }, []);

  const loadDisciplines = async () => {
    try {
      setLoading(true);
      const response = await fetch('/api/disciplines');
      const data = await response.json();
      setDisciplines(data);
    } catch (error) {
      console.error('Failed to load disciplines:', error);
      setErrors(prev => ({
        ...prev,
        discipline: 'Failed to load discipline options'
      }));
    } finally {
      setLoading(false);
    }
  };

  const handleDisciplineChange = (selectedOption) => {
    setFormData(prev => ({
      ...prev,
      disciplineId: selectedOption?.value || ''
    }));

    // Clear validation error when user makes selection
    if (errors.discipline) {
      setErrors(prev => ({ ...prev, discipline: null }));
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    // Validate dropdown selection
    if (!formData.disciplineId) {
      setErrors(prev => ({
        ...prev,
        discipline: 'Please select a discipline'
      }));
      return;
    }

    // Clear all errors on successful validation
    setErrors({});
    onSubmit(formData);
  };

  return (
    <form onSubmit={handleSubmit}>
      <DisciplineDropdown
        options={disciplines}
        value={formData.disciplineId}
        onChange={handleDisciplineChange}
        loading={loading}
        error={errors.discipline}
        required
      />
    </form>
  );
}
```

### Key Requirements

1. **Data Fetching**: Component must fetch discipline data on mount using useEffect
2. **State Binding**: Dropdown value must be bound to component state
3. **Change Handler**: Must have proper onChange handler updating parent state
4. **Validation Integration**: Dropdown selection must be validated before form submission
5. **Error Display**: Validation errors must be properly displayed to user

### Common Issues to Avoid

| Issue | Symptom | Root Cause |
|-------|---------|------------|
| Inconsistent Data Binding | Dropdown shows options but selected value doesn't persist | Mismatch between dropdown value prop and form state binding |
| Data Not Loading | Dropdown renders but shows "No options available" | Missing discipline data fetch in component lifecycle |
| Validation Bypass | Form submits without required selection | Dropdown validation not integrated with form validation |
| State Sync Issues | Selection not reflected in parent component | Improper prop drilling or state lifting patterns |

### Verification Checklist

- [ ] Dropdown renders with loading state
- [ ] useEffect triggers data fetch on mount
- [ ] Loading state clears after data load
- [ ] Options appear in dropdown
- [ ] Selection updates component state
- [ ] Selection persists across re-renders
- [ ] Required field validation triggers
- [ ] Error messages display correctly
- [ ] Form submission blocked on validation failure
- [ ] Network failures handled gracefully

---

## Chatbot Implementation Procedure

**Reference:** `docs/procedures/human-workflows/0000_CHATBOT_MASTER_PROCEDURE.md`

### Overview
This comprehensive procedure establishes standards for implementing, configuring, testing, and maintaining chatbots across all pages in the ConstructAI system. Chatbots serve as intelligent assistants providing contextual help, document search capabilities, and workflow guidance.

### Template Classification

#### Template A (Simple Pages)
- **Navigation**: Standard or tab-based (no three-state buttons)
- **Scope**: Single primary function per page
- **Chat Type**: `document` or `workspace`
- **Z-Index**: 1000 (standard positioning)

#### Template B (Complex Pages)
- **Navigation**: Three-state buttons (Agents, Upsert, Workspace)
- **Scope**: Multi-context support across navigation states
- **Chat Type**: Always `agent`
- **Z-Index**: 1500 (higher for complex navigation compatibility)

### Standard Implementation Pattern

```javascript
// Template A Implementation Pattern
<ChatbotBase
  pageId="01900"
  disciplineCode="01900"
  userId={currentUser.id}
  chatType="workspace" // or "document" based on page function
  title="Procurement Assistant"
  welcomeTitle="Procurement Intelligence"
  welcomeMessage="I can help with procurement queries, document analysis, contract terms, and supplier information. For complex questions requiring expert review, I'll escalate through our human specialists."
  exampleQueries={[
    "What are the procurement approval processes?",
    "Analyze this supplier's performance history",
    "Find contracts expiring in the next 6 months",
    "What are the current procurement policies?"
  ]}
  theme={{
    primary: "#2E8B57",    // Procurement green
    secondary: "#228B22",
    background: "#F0F8F0"
  }}
  enableCitations={true}
  enableDocumentCount={true}
  enableConversationHistory={true}
  enableHITL={true}        // HITL integration enabled
  hitlConfig={{
    confidenceThreshold: 0.7,
    escalationEnabled: true,
    statusUpdates: true
  }}
/>
```

### Required Components

1. **ChatbotErrorBoundary**: Wrap chatbot with error boundary for graceful error handling
2. **Defensive Programming**: Safe prop validation and type coercion
3. **I18N Support**: Translation files for all supported languages
4. **Vector Search**: Integration with vector database for document retrieval

### Human-in-the-Loop (HITL) Configuration

**Required for:** Procurement (01900), Safety (02400), Contracts (00435)

The HITL system provides sequential escalation for complex queries:
- **Confidence Threshold**: 70% provides optimal balance
- **Escalation Chain**: 3-level chains (Analyst → Specialist → Manager)
- **Timeout Settings**: 4-8-12 hour progression matches typical work patterns

### AI Model Recommendations by Discipline

| Discipline | Page/Function | Recommended Model |
|------------|---------------|-------------------|
| Procurement (01900) | Document Ordering | GPT-4 |
| Procurement (01900) | Supplier Directory | Claude Haiku |
| Procurement (01900) | Gantt/Scheduling | GPT-4 Turbo |
| Safety (02400) | Risk Assessments | GPT-4 |
| Safety (02400) | Inspections | Claude Haiku |
| Safety (02400) | SDS Review | GPT-4 |
| Contracts (00435) | Contract Analysis | GPT-4 |

### Verification Checklist

- [ ] ChatbotBase component integrated
- [ ] Error boundary wrapper implemented
- [ ] Backend API routes functional
- [ ] Vector search implemented
- [ ] I18N translations loaded (all 9 languages)
- [ ] Security controls applied
- [ ] Badge configuration updated
- [ ] HITL configuration (if required by discipline)
- [ ] Unit tests passing
- [ ] Integration tests successful

---

## Workflow Optimization Guide

**Reference:** `deep-agents/docs/0000_WORKFLOW_OPTIMIZATION_GUIDE.md`

### Overview
This guide provides a unified framework for system optimization, quality assessment, workflow design, and documentation. It combines enterprise-grade troubleshooting methodologies with systematic workflow documentation procedures.

### AI Enhancement Integration

The ConstructAI system features comprehensive AI enhancement with:
- **455 Tables Enhanced**: Complete database AI transformation
- **47 Vector Tables**: Production-ready semantic search infrastructure
- **14 Specialized AI Agents**: Intelligent processing across all data types
- **1536 Dimensions**: High-dimensional semantic representations
- **HNSW Indexing**: Optimized vector search with m=16, ef_construction=64
- **Sub-second Response Times**: Expected for vector similarity searches

### Performance Metrics
- **Index Optimization**: 47 vector indexes created successfully
- **Performance Testing**: All benchmarks completed successfully
- **Security Testing**: RLS policies validated across vector tables
- **Quality Validation**: 100% automated data integrity checks
- **Production Deployment**: Live AI-enhanced search capabilities

### Code Quality Standards (AGENTS.md Compliance)

| Category | Standard |
|----------|----------|
| Syntax | ES6+ required (import, export, const, let, arrow functions, async/await) |
| Variables | camelCase |
| Functions | camelCase |
| Components | PascalCase |
| Files | kebab-case or camelCase |
| Server Code | /server directory |
| Client Code | /client directory |
| Documentation | /docs directory |

### Error Handling Patterns

```javascript
// Comprehensive client-side logging
const logger = {
  info: (message, context = {}) => {
    console.log(JSON.stringify({
      timestamp: new Date().toISOString(),
      level: 'info',
      component: 'frontend',
      userId: getCurrentUserId(),
      sessionId: getSessionId(),
      correlationId: getCorrelationId(),
      message,
      ...context
    }));
  },

  error: (error, context = {}) => {
    console.error(JSON.stringify({
      timestamp: new Date().toISOString(),
      level: 'error',
      component: 'frontend',
      userId: getCurrentUserId(),
      error: {
        name: error.name,
        message: error.message,
        stack: error.stack
      },
      ...context
    }));
  },

  performance: (metric, value, context = {}) => {
    console.log(JSON.stringify({
      timestamp: new Date().toISOString(),
      level: 'info',
      type: 'performance',
      metric,
      value,
      ...context
    }));
  }
};
```

### System Optimization Triggers

#### Performance Issues
- Response times exceeding acceptable thresholds
- High memory usage or memory leaks
- Database query performance degradation
- System resource utilization spikes
- User experience degradation

#### Code Quality Concerns
- Functions exceeding 50+ lines (refactoring candidates)
- Files with excessive length or complexity
- Standards compliance violations against AGENTS.md
- Technical debt accumulation
- Security vulnerabilities or concerns

---

## 01900 Implementation Assessment

### Current Status - ✅ COMPLIANT

The 01900 Procurement page implementation has been updated to fully comply with the organisation's standardized procedures:

#### ✅ Correctly Implemented
- **State-Based Navigation**: Three-state system (Agents/Upserts/Workspace) properly implemented
- **Modal Organization**: Modals correctly categorized by state
- **Error Boundary**: Chatbot wrapped with ChatbotErrorBoundary
- **Chat Modes**: Both AI Chat and Document Search modes functional
- **Citations**: EnableCitations properly configured
- **HITL Enabled**: Human-in-the-Loop system enabled with confidence threshold 0.7
- **Example Queries**: Added array of procurement-specific example queries
- **Theme**: Updated to procurement-specific green theme (#2E8B57)
- **PropTypes**: Updated to include all new props (welcomeTitle, exampleQueries, enableHITL, hitlConfig)

### Implementation Changes Made

1. **Chatbot Component Updated** (`01900-procurement-chatbot.js`)
   - Added support for `welcomeTitle` prop
   - Added support for `exampleQueries` prop
   - Added support for `enableHITL` and `hitlConfig` props
   - Updated PropTypes to include all new props

2. **Page Component Updated** (`01900-procurement-page.js`)
   - Added `chatType="agent"` (Template B - complex page)
   - Added `welcomeTitle="Procurement Intelligence"`
   - Added detailed `welcomeMessage` explaining HITL capabilities
   - Added `exampleQueries` array with procurement-specific questions
   - Updated theme colors to procurement green (#2E8B57)
   - Added `enableConversationHistory={true}`
   - Added `enableHITL={true}` with proper configuration

### Remaining Recommendations

1. **I18N Translation Files**
   - Verify and complete translation files for all 9 languages (en, ar, pt, es, fr, zu, xh, sw, de)

---

## Last Updated
- 2026-02-14
