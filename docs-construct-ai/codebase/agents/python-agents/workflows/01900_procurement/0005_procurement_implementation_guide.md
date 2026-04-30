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
# Procurement Workflow Implementation Guide

**Last Updated:** 2026-02-26  
**Purpose:** Consolidated technical implementation guide combining modal architecture and workflow integration

## 🏗️ Architecture Overview

### System Components

```
Procurement Workflow System
├── Frontend Components
│   ├── ProcurementInputAgentModal.js (Main Interface)
│   ├── AgentChatInterface (Chat Tab)
│   ├── AgentDataPreview (Preview Tab)
│   ├── AgentHandoffConfirmation (Handoff Tab)
│   └── Document Tabs (SOW, Appendices A-F)
├── Backend Services
│   ├── useProcurementAgentSession (Session Management)
│   ├── 7-Agent Streaming Workflow
│   ├── Database Integration (procurement_agent_sessions, procurement_orders)
│   └── API Controllers
└── Integration Layer
    ├── Chatbot Workflow Streaming
    ├── Template Management System
    ├── Document Assembly Dashboard
    └── Approval Routing System
```

### Data Flow Architecture

```
User Input → Chat Interface → Agent Processing → Data Extraction → Document Generation → Approval Workflow → Final Output
```

## 📱 Frontend Implementation

### Main Modal Component Structure

**File:** `ProcurementInputAgentModal.js`

```javascript
// Component Dependencies
import AgentChatInterface from './components/AgentChatInterface.js';
import AgentDataPreview from './components/AgentDataPreview.js';
import AgentHandoffConfirmation from './components/AgentHandoffConfirmation.js';
import { useProcurementAgentSession } from '../hooks/useProcurementAgentSession.js';
import { useModal } from '@components/modal/hooks/00170-useModal.js';

// Modal State Management
const [currentState, setCurrentState] = useState('chat');
const [sessionId, setSessionId] = useState(null);
const [extractedData, setExtractedData] = useState(null);
const [validationStatus, setValidationStatus] = useState(null);
```

### Tab Navigation System

**Conditional 8-9 Tab Interface:**
1. **Chat Tab** - Conversational requirements gathering
2. **Preview Tab** - Data validation and specialist agent processing
3. **SOW Tab** - Scope of Work document display (only if `procurement_categories.requires_sow = true`)
4. **Appendix A-F Tabs** - Supporting documentation

**Note:** The SOW tab is conditionally displayed based on the procurement category's `requires_sow` flag in the database.

### State Management

**Primary State Variables:**
```javascript
// Modal state
const [currentState, setCurrentState] = useState('chat');
const [sessionId, setSessionId] = useState(null);
const [extractedData, setExtractedData] = useState(null);
const [validationStatus, setValidationStatus] = useState(null);

// Specialist agents state
const [specialistAgents, setSpecialistAgents] = useState({
  templateAnalysis: null,
  requirementsExtraction: null,
  complianceValidation: null,
  fieldPopulation: null,
  qualityAssurance: null,
  finalReview: null,
  assignment: null
});

// Streaming workflow state
const [streamingWorkflow, setStreamingWorkflow] = useState({
  isActive: false,
  currentAgent: null,
  completedAgents: new Set(),
  totalAgents: 7,
  startTime: null,
  estimatedDuration: 5700
});
```

## 🤖 Agent Integration

### 7-Agent Streaming Workflow

**Sequential Agent Execution:**
1. **Template Analysis Agent** (800ms) - Analyzes available templates
2. **Requirements Extraction Agent** (700ms) - Extracts requirements from conversation
3. **Compliance Validation Agent** (900ms) - Validates regulatory compliance
4. **Field Population Agent** (800ms) - Populates form fields
5. **Quality Assurance Agent** (600ms) - QA checks and validation
6. **Final Review Agent** (850ms) - Final document review
7. **Assignment Agent** (650ms) - Task assignment and workflow completion

**Total Processing Time:** ~4.5 seconds

### Event-Based Communication

**Custom Events:**
```javascript
// Workflow events
'streaming-workflow-started'
'streaming-agent-activated'
'streaming-agent-completed'
'streaming-workflow-completed'
'streaming-workflow-error'

// Debug events
'procurement-debug-completed'
```

**Event Handler Example:**
```javascript
useEffect(() => {
  const handleWorkflowStart = (event) => {
    console.log('Workflow started:', event.detail);
  };
  
  window.addEventListener('streaming-workflow-started', handleWorkflowStart);
  
  return () => {
    window.removeEventListener('streaming-workflow-started', handleWorkflowStart);
  };
}, []);
```

## 🗄️ Database Schema

### Core Tables

**Sessions Table:**
```sql
CREATE TABLE procurement_agent_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id VARCHAR(255) UNIQUE NOT NULL,
  user_id VARCHAR(255),
  current_step VARCHAR(50),
  current_state VARCHAR(50),
  extracted_data JSONB,
  messages JSONB[],
  validation_status JSONB,
  specialist_agents JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

**Orders Table (Enhanced for SOW Generation):**
```sql
CREATE TABLE procurement_orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_number VARCHAR(50) UNIQUE NOT NULL,
  session_id VARCHAR(255) REFERENCES procurement_agent_sessions(session_id),
  procurement_type VARCHAR(50),
  estimated_value DECIMAL(15,2),
  items JSONB[],
  destination_country VARCHAR(100),
  destination_code VARCHAR(10),
  cdc_required BOOLEAN DEFAULT FALSE,
  importer_nif VARCHAR(50),
  importer_address TEXT,
  timeline VARCHAR(50),
  requirements TEXT,

  -- Enhanced fields for comprehensive SOW generation
  payment_terms JSONB,           -- Payment schedule, conditions, penalties
  acceptance_criteria JSONB,     -- Testing procedures, completion requirements
  safety_requirements JSONB,     -- Hazardous materials, certifications
  quality_standards JSONB,       -- Certification requirements, inspection levels
  logistics_requirements JSONB,  -- Transportation, insurance, special handling

  status VARCHAR(50) DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

**Documents Table:**
```sql
CREATE TABLE procurement_documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID REFERENCES procurement_orders(id),
  document_type VARCHAR(50),
  content TEXT,
  metadata JSONB,
  generated_at TIMESTAMP DEFAULT NOW()
);
```

## 🔌 API Integration

### Session Management

**Start Session:**
```javascript
const initializeSession = async () => {
  const userId = window.currentUser?.id || 'demo-user';
  const session = await startSession(userId, 'unknown');
  setSessionId(session.sessionId);
};
```

**End Session:**
```javascript
const handleCloseModal = async () => {
  if (sessionId) {
    await endSession('abandoned');
    await clearSession(sessionId);
  }
  onClose();
};
```

### Message Handling

**Send Message:**
```javascript
const handleSendMessage = async (message) => {
  if (!sessionId) return;
  
  const response = await sendMessage(message);
  
  if (response?.orderCreated) {
    setExtractedData(prev => ({
      ...prev,
      createdOrder: response.createdOrder
    }));
  }
  
  await extractData();
};
```

### Handoff to SOW

**Handoff Process:**
```javascript
const handleHandoff = async () => {
  const sowData = await handoffToSOW();
  
  if (sowData?.createdOrder) {
    setExtractedData(prev => ({
      ...prev,
      ...sowData,
      createdOrder: sowData.createdOrder,
      sowGenerated: true
    }));
  }
  
  await endSession('completed');
  setCurrentState('sow');
};
```

## 📋 Workflow States

### State Transitions

```
CHAT → PREVIEW → DRAFT → HANDOFF → SOW → Appendix A-F
```

### State Management

**State Variables:**
```javascript
const [currentState, setCurrentState] = useState('chat');
const [sessionId, setSessionId] = useState(null);
const [extractedData, setExtractedData] = useState(null);
const [validationStatus, setValidationStatus] = useState(null);
```

**State Transitions:**
- **CHAT**: User input and requirements gathering
- **PREVIEW**: Data validation and agent processing
- **DRAFT**: Order preview before submission
- **HANDOFF**: Order creation and SOW generation
- **SOW**: Scope of Work document display
- **Appendix A-F**: Supporting documentation tabs

## 🔧 Performance Optimization

### Memoization

**Completeness Calculation:**
```javascript
const calculateCompleteness = useMemo(() => {
  if (!extractedData) return 0;
  
  const requiredFields = ['procurement_type', 'estimated_value', 'items'];
  return requiredFields.filter(f => extractedData[f]?.value).length / requiredFields.length * 100;
}, [extractedData]);
```

### Lazy Loading

**Agent Implementation Loading:**
```javascript
const invokeSpecialistAgent = async (agentType, data, context) => {
  const response = await fetch('/api/agent-development-tasks', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      scope: '01900',
      taskType: `specialist_${agentType}`,
      developmentMode: true,
      extracted_data: data,
      context
    })
  });
  
  return response.json();
};
```

## 🛡️ Security Considerations

### Input Validation
- Sanitize all user inputs
- Validate file uploads
- Escape HTML in chat messages

### Session Security
- Validate session ownership
- Expire inactive sessions
- Secure session storage

### API Security
- Authenticate all requests
- Rate limit API calls
- Validate request payloads

## 🧪 Testing Integration

### Test Workflow Button

**Implementation:**
```javascript
<button
  onClick={async () => {
    const response = await fetch('/api/procurement/agent/test-scenario');
    const scenario = await response.json();
    const steps = scenario?.test_data?.steps || [];
    
    for (const step of steps) {
      await handleSendMessage(step.input);
      await new Promise(resolve => setTimeout(resolve, 600));
    }
  }}
>
  🧪 Test Workflow
</button>
```

### Error Handling

**Error Recovery:**
```javascript
const handleErrorWithDebug = async (error, action, context = {}) => {
  console.error(`Error during ${action}:`, error);
  
  // Trigger IT Swarm debugging
  const report = await triggerITSwarmDebug({
    error: error.message,
    stack: error.stack,
    sessionId,
    action,
    extractedData,
    sessionState,
    ...context
  });
  
  return report;
};
```

**Graceful Degradation:**
```javascript
// Fallback to demo mode when API unavailable
const initializeSession = async () => {
  try {
    const session = await startSession(userId, 'unknown');
    setSessionId(session.sessionId);
  } catch (error) {
    // Create demo session
    const demoSessionId = `demo-session-${Date.now()}`;
    setSessionId(demoSessionId);
    setMessages([
      { id: 1, role: 'agent', content: 'Hello! I can help you create a procurement order.' },
      { id: 2, role: 'agent', content: 'What type of procurement do you need?' }
    ]);
  }
};
```

## 📊 Integration Points

### Chatbot Workflow Streaming

**Component:** `client/src/pages/01900-procurement/components/01901-purchase-orders-page.js`
**System:** Event-based chatbot dispatcher with sequential agent execution
**Integration:** Works with ProcurementChatbot via `chatbotMessage` custom events

### Document Assembly Dashboard

**Component:** `Universal Document Assembly Dashboard`
**Features:**
- Real-time assembly progress
- Content validation
- Configuration options (PDF/Word/Both)
- Security controls (password protection, watermarks)
- Package generation (ZIP with individual downloads)

### Approval Routing System

**Component:** Limits of Authority System
**Database:** `limits_of_authority` table
**Function:** `get_limits_of_authority_approvals()`
**Process:** Automatic approval matrix resolution based on governance rules

## 🎯 Best Practices

### User Assignment Pattern

**Reliable User Assignment:**
```javascript
// 1. Load users with disciplines array
const usersWithDisciplines = fetchedUsers.map(user => ({
  ...user,
  disciplines: Array.from(assignedDisciplineNames)
}));

// 2. Filter by discipline name matching
const filteredUsers = usersWithDisciplines.filter(user => {
  const assignedNames = assignedDisciplines.map(id =>
    allDisciplines.find(d => d.id === id)?.name || id
  );
  return assignedNames.some(name =>
    user.disciplines.some(userDisc =>
      userDisc.toLowerCase().includes(name.toLowerCase())
    )
  );
});

// 3. Pass to UserSelector with onUserAssignment handler
<UserSelector
  availableUsers={filteredUsers}
  onUserAssignment={(appendix, userId, assign) => {
    console.log('[USER_ASSIGNMENT]', { appendix, userId, assign });
    // Update state and trigger task creation
  }}
/>
```

### Debug Logging Standards

**Comprehensive Logging:**
```javascript
// Component render logging
console.log(`[ComponentName] Rendering with ${users.length} users`);

// State change logging
console.log(`[ComponentName] State updated:`, newState);

// API call logging
console.log(`[ComponentName] API call:`, params);

// Error logging
console.error(`[ComponentName] Error:`, error);
```

### Data Structure Validation

**Validation Pattern:**
```javascript
// Validate user objects have required properties
const validUsers = users.filter(user =>
  user.id && user.email && Array.isArray(user.disciplines)
);

// Validate discipline assignments
const validAssignments = Object.entries(disciplineAssignments).filter(
  ([appendix, disciplines]) => Array.isArray(disciplines) && disciplines.length > 0
);
```

## 🔄 Development Mode

### Authentication Bypass

**RLS Policies:** Allow access when `auth.uid() IS NULL` for development mode
**Task Assignment:** Tasks assigned to `assigned_to: null` (visible to all users via auth bypass)
**Metadata Tracking:** `original_assigned_to` preserved for production migration
**Development Flag:** `development_mode: true` in task metadata

### Production Mode Behavior

- Tasks assigned to specific authenticated users as selected in UI
- Standard user-based task filtering and permissions
- Full authentication required - no bypass

---

## 📋 Quick Reference

### File Locations

**Frontend Components:**
- Main Modal: `ProcurementInputAgentModal.js`
- Chat Interface: `AgentChatInterface.js`
- Preview Interface: `AgentDataPreview.js`
- Handoff Interface: `AgentHandoffConfirmation.js`

**Backend Services:**
- Session Hook: `useProcurementAgentSession.js`
- API Controllers: `procurementController.js`
- Database: `procurement_agent_sessions`, `procurement_orders`, `procurement_documents`

**Integration:**
- Chatbot Streaming: `01901-purchase-orders-page.js`
- Document Assembly: `DocumentAssemblyDashboard.jsx`
- Approval System: `limits_of_authority` table

### Key Endpoints

- **Session Management:** `/api/procurement/sessions`
- **Message Handling:** `/api/procurement/messages`
- **Data Extraction:** `/api/procurement/extract`
- **SOW Handoff:** `/api/procurement/handoff`
- **Agent Tasks:** `/api/agent-development-tasks`

### Configuration Files

- **Database Schema:** `sql/create_procurement_tables.sql`
- **API Routes:** `server/src/routes/procurement.js`
- **Frontend Routes:** `client/src/pages/01900-procurement/`
- **Styles:** `client/src/pages/01900-procurement/css/01900-procurement-agent-modal.css`

---

*This consolidated implementation guide combines the best practices from both technical implementation documents, providing a comprehensive reference for developers working on the procurement workflow system.*