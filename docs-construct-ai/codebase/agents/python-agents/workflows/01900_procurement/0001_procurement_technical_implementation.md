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
# 13 - Technical Implementation

## Overview

This document provides technical implementation details for the procurement workflow, including component architecture, state management, API integration, and database schema.

## Component Architecture

### Main Component Structure

```
ProcurementInputAgentModal.js
├── Header (Navigation Tabs)
│   ├── Chat Tab
│   ├── Preview Tab
│   ├── SOW Tab
│   └── Appendix Tabs (A-F)
├── Status Bar
│   ├── Session Status
│   ├── Message Count
│   ├── Completeness %
│   └── Agent Status
├── Body Content
│   ├── AgentChatInterface
│   ├── AgentDataPreview
│   ├── AgentHandoffConfirmation
│   └── Document Tabs (SOW, Appendices)
└── Footer
    ├── Quick Actions
    ├── Debug Controls
    └── Close Button
```

### Component Dependencies

```javascript
// Main modal component
import AgentChatInterface from './components/AgentChatInterface.js';
import AgentDataPreview from './components/AgentDataPreview.js';
import AgentHandoffConfirmation from './components/AgentHandoffConfirmation.js';

// Hooks
import { useProcurementAgentSession } from '../hooks/useProcurementAgentSession.js';
import { useModal } from '@components/modal/hooks/00170-useModal.js';

// Styles
import './css/01900-procurement-agent-modal.css';
```

## State Management

### Primary State Variables

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

// Checkpoint state
const [threadId, setThreadId] = useState(null);
const [checkpointEnabled, setCheckpointEnabled] = useState(true);
const [resumedFromCheckpoint, setResumedFromCheckpoint] = useState(false);
```

### Hook Integration

```javascript
const {
  messages,
  extractedData: hookExtractedData,
  isProcessing,
  sessionState,
  sessionError,
  startSession,
  sendMessage,
  extractData,
  validateData,
  handoffToSOW,
  endSession,
  clearSession,
  setMessages,
  setExtractedData: setHookExtractedData
} = useProcurementAgentSession(sessionId);
```

## API Integration

### Session Management

```javascript
// Start session
const initializeSession = async () => {
  const userId = window.currentUser?.id || 'demo-user';
  const session = await startSession(userId, 'unknown');
  setSessionId(session.sessionId);
};

// End session
const handleCloseModal = async () => {
  if (sessionId) {
    await endSession('abandoned');
    await clearSession(sessionId);
  }
  onClose();
};
```

### Message Handling

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

## Database Schema

### Sessions Table

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

### Orders Table

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
  status VARCHAR(50) DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Documents Table

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

## Event System

### Custom Events

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

### Event Handlers

```javascript
// Listen for workflow events
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

## Error Handling

### Error Recovery

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

### Graceful Degradation

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

## Performance Optimization

### Memoization

```javascript
const calculateCompleteness = useMemo(() => {
  if (!extractedData) return 0;
  
  const requiredFields = ['procurement_type', 'estimated_value', 'items'];
  return requiredFields.filter(f => extractedData[f]?.value).length / requiredFields.length * 100;
}, [extractedData]);
```

### Lazy Loading

```javascript
// Load agent implementations on demand
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

## Testing Integration

### Test Workflow Button

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

## Security Considerations

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