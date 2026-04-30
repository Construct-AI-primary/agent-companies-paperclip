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
# Procurement Agent Input Collection - Complete Implementation

## Overview

The procurement agent input collection system provides a conversational interface for users to create procurement orders through natural language interaction. The system integrates seamlessly with the existing SOW generation workflow and supports multiple input methods including natural language, spreadsheet uploads, and fillable tables.

## Architecture

### System Components

1. **Frontend Hooks** (`client/src/pages/01900-procurement/hooks/useProcurementAgentSession.js`)
   - React hook for session management
   - API integration with backend services
   - State management for conversations and extracted data

2. **Backend Routes** (`deep-agents/deep_agents/agents/pages/01900_procurement/input-agent/routes/procurement-agent-routes.js`)
   - Express.js API endpoints
   - Session management endpoints
   - Message processing and data extraction

3. **Service Layer** (`deep-agents/deep_agents/agents/pages/01900_procurement/input-agent/services/ProcurementAgentService.js`)
   - Business logic orchestration
   - Agent instance management
   - Data validation and complexity assessment

4. **Database Layer** (`deep-agents/deep_agents/agents/pages/01900_procurement/input-agent/database/ProcurementAgentDB.js`)
   - Supabase integration
   - Conversation storage and retrieval
   - Session state persistence

5. **Database Schema** (`deep-agents/deep_agents/agents/pages/01900_procurement/input-agent/schema/procurement-agent-conversations.sql`)
   - Complete PostgreSQL schema
   - Row-level security policies
   - Analytics views and helper functions

## API Endpoints

### Session Management

#### POST `/api/tasks/start-session`
Start a new procurement conversation session.

**Request:**
```json
{
  "userId": "user-uuid",
  "orderType": "equipment_purchase|work_order|service_order|unknown"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "sessionId": "session-uuid",
    "initialPrompt": "Welcome message",
    "state": "active"
  }
}
```

#### POST `/api/tasks/send-message`
Send a message to the agent and receive a response.

**Request:**
```json
{
  "sessionId": "session-uuid",
  "message": "User message"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "agentMessage": "Agent response",
    "extractedData": { "field": "value" },
    "stage": "conversation-stage"
  }
}
```

#### POST `/api/tasks/extract-data`
Extract structured data from the conversation.

**Request:**
```json
{
  "sessionId": "session-uuid"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "structuredData": { "field": "value" },
    "confidenceScores": { "field": 0.95 },
    "missingFields": ["field1", "field2"],
    "completeness": 0.8
  }
}
```

#### POST `/api/tasks/validate`
Validate extracted data against procurement schema.

**Request:**
```json
{
  "sessionId": "session-uuid",
  "extractedData": { "field": "value" }
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "isValid": true,
    "errors": [],
    "warnings": [],
    "completeness": 0.9,
    "missingRequiredFields": []
  }
}
```

#### POST `/api/tasks/handoff-sow`
Prepare SOW data for generation.

**Request:**
```json
{
  "sessionId": "session-uuid",
  "reviewedData": { "field": "value" }
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "sowData": { "sow": "data" },
    "template": { "template": "data" },
    "complexity": "medium",
    "requiredAppendices": ["A", "B"],
    "nextSteps": ["step1", "step2"]
  }
}
```

### Session Control

#### POST `/api/tasks/end-session`
Mark conversation as completed or abandoned.

**Request:**
```json
{
  "sessionId": "session-uuid",
  "status": "completed|abandoned"
}
```

#### POST `/api/tasks/clear-session`
Permanently delete conversation session.

**Request:**
```json
{
  "sessionId": "session-uuid"
}
```

#### GET `/api/tasks/session/{sessionId}`
Get current session state.

#### POST `/api/tasks/continue-session`
Continue an existing session.

**Request:**
```json
{
  "sessionId": "session-uuid",
  "message": "Optional message"
}
```

### Advanced Features

#### POST `/api/tasks/analyze-complexity`
Analyze procurement requirements for complexity.

**Request:**
```json
{
  "extractedData": { "procurementType": "equipment_purchase", "estimatedValue": 50000 }
}
```

#### POST `/api/tasks/match-template`
Match extracted data to available templates.

**Request:**
```json
{
  "extractedData": { "procurementType": "equipment_purchase" },
  "complexity": "medium"
}
```

#### POST `/api/tasks/get-prompt`
Get agent prompt for specific conversation stage.

**Request:**
```json
{
  "stage": "discovery|requirements|compliance|template|validation|handoff",
  "extractedData": { "field": "value" },
  "context": "Additional context"
}
```

## Database Schema

### Main Table: `procurement_agent_conversations`

```sql
CREATE TABLE procurement_agent_conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    session_id UUID NOT NULL UNIQUE,
    messages JSONB[] DEFAULT '{}',
    extracted_data JSONB DEFAULT '{}',
    validation_errors JSONB DEFAULT '[]',
    stage VARCHAR(50) DEFAULT 'discovery',
    complexity_level VARCHAR(20),
    required_appendices JSONB DEFAULT '[]',
    recommended_template_id UUID,
    status VARCHAR(50) DEFAULT 'active',
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    completed_at TIMESTAMP WITH TIME ZONE
);
```

### Key Features

- **Session Management**: Unique session IDs with user association
- **Conversation History**: Array of message objects with timestamps
- **Structured Data**: JSONB storage for extracted procurement data
- **Validation**: Built-in validation error tracking
- **Complexity Assessment**: Automatic complexity level determination
- **Appendices**: Dynamic appendix requirements based on complexity
- **Status Tracking**: Complete lifecycle management

### Security & Access Control

- **Row-Level Security**: Users can only access their own conversations
- **Foreign Key Constraints**: Proper relationships with auth.users
- **Validation Constraints**: Data integrity checks
- **Audit Trail**: Complete timestamp tracking

## Frontend Integration

### Hook Usage

```javascript
import useProcurementAgentSession from './hooks/useProcurementAgentSession';

function ProcurementModal() {
  const {
    sessionId,
    sessionState,
    messages,
    extractedData,
    isProcessing,
    sessionError,
    
    // Actions
    startSession,
    sendMessage,
    extractData,
    validateData,
    handoffToSOW,
    endSession,
    clearSession,
    getSessionState,
    continueSession,
    addMessage,
    clearError
  } = useProcurementAgentSession();

  // Start new session
  const handleStart = async () => {
    try {
      const result = await startSession(userId, 'equipment_purchase');
      console.log('Session started:', result.sessionId);
    } catch (error) {
      console.error('Failed to start session:', error);
    }
  };

  // Send message
  const handleSendMessage = async (message) => {
    try {
      const result = await sendMessage(message);
      console.log('Agent response:', result.agentMessage);
    } catch (error) {
      console.error('Failed to send message:', error);
    }
  };

  // Complete workflow
  const handleComplete = async () => {
    try {
      const validation = await validateData();
      if (validation.isValid) {
        const sowData = await handoffToSOW();
        console.log('SOW ready:', sowData);
      }
    } catch (error) {
      console.error('Workflow failed:', error);
    }
  };
}
```

### State Management

The hook provides comprehensive state management:

- **Session State**: `idle`, `initializing`, `active`, `completed`, `error`
- **Processing State**: Loading indicators for all operations
- **Error Handling**: Centralized error management
- **Conversation History**: Real-time message updates
- **Extracted Data**: Structured data with confidence scores

## Workflow Integration

### Auto-Transition to SOW Generation

The system supports automatic handoff to SOW generation:

1. **Data Extraction**: Complete procurement data collection
2. **Validation**: Schema validation and completeness check
3. **Complexity Assessment**: Automatic complexity level determination
4. **Template Matching**: Recommended template selection
5. **SOW Preparation**: Structured data for SOW generation

### Order Creation Agent Integration

The OrderCreationAgent provides specialized order creation capabilities:

- **Spreadsheet Parsing**: Excel/CSV file processing
- **Natural Language Processing**: Text-based order creation
- **Fillable Tables**: Interactive table completion
- **Step-by-Step Guidance**: Progressive data collection

## Testing

### Test Coverage

The implementation includes comprehensive test suites:

1. **Unit Tests**: Individual component testing
2. **Integration Tests**: End-to-end workflow testing
3. **API Tests**: All endpoint functionality verification
4. **Error Handling**: Edge case and error scenario testing

### Test Results

All major functionality has been tested and verified:

✅ **Session Management**: Start, continue, end, clear sessions
✅ **Message Processing**: Send/receive messages with data extraction
✅ **Data Validation**: Schema validation and error reporting
✅ **Complexity Assessment**: Automatic complexity level determination
✅ **Template Matching**: Template recommendation system
✅ **SOW Handoff**: Complete data preparation for SOW generation
✅ **Error Handling**: Comprehensive error management
✅ **Security**: Row-level security and access control

## Deployment

### Environment Setup

1. **Database**: PostgreSQL with Supabase
2. **Backend**: Node.js with Express.js
3. **Frontend**: React with custom hooks
4. **Authentication**: Supabase auth integration

### Configuration

```javascript
// Environment variables
SUPABASE_URL=your-supabase-url
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### Migration

The schema includes migration scripts for existing systems:

```sql
-- Add conversation tracking to existing procurement_orders
ALTER TABLE procurement_orders ADD COLUMN conversation_id UUID;
ALTER TABLE procurement_orders ADD COLUMN input_method VARCHAR(50);
ALTER TABLE procurement_orders ADD COLUMN conversation_metadata JSONB;
```

## Performance Optimization

### Database Indexes

- **Session Lookup**: Fast session retrieval by ID
- **User Conversations**: Efficient user-specific queries
- **Status Filtering**: Quick status-based filtering
- **Analytics**: Optimized for reporting and analytics

### Caching Strategy

- **Agent Instances**: In-memory agent caching
- **Template Matching**: Cached template recommendations
- **Complexity Assessment**: Cached complexity calculations

### Scalability

- **Stateless API**: Horizontal scaling support
- **Database Optimization**: Efficient queries and indexes
- **Memory Management**: Proper cleanup and resource management

## Security Features

### Data Protection

- **Row-Level Security**: User data isolation
- **Input Validation**: Comprehensive input sanitization
- **Error Handling**: Secure error reporting
- **Audit Trail**: Complete activity logging

### Access Control

- **Authentication**: Supabase auth integration
- **Authorization**: Role-based access control
- **Session Management**: Secure session handling
- **Data Encryption**: Encrypted data transmission

## Monitoring & Analytics

### Built-in Analytics

- **Conversation Analytics**: Usage patterns and metrics
- **User Statistics**: User engagement and behavior
- **Performance Metrics**: Response times and success rates
- **Error Tracking**: Comprehensive error logging

### Monitoring Views

```sql
-- Active conversations
SELECT * FROM vw_procurement_active_conversations;

-- Conversation analytics
SELECT * FROM vw_procurement_conversation_analytics;

-- User statistics
SELECT * FROM vw_procurement_user_statistics;
```

## Future Enhancements

### Planned Features

1. **Multi-Language Support**: Internationalization
2. **Voice Input**: Speech-to-text integration
3. **Advanced NLP**: Improved natural language understanding
4. **Machine Learning**: Smart suggestions and auto-completion
5. **Integration APIs**: Third-party system integration

### Extension Points

- **Custom Agents**: Plugin architecture for specialized agents
- **Template System**: Dynamic template generation
- **Workflow Customization**: Configurable workflow stages
- **Reporting**: Advanced analytics and reporting

## Conclusion

The procurement agent input collection system provides a complete, production-ready solution for conversational procurement order creation. The implementation includes:

- **Complete API**: All necessary endpoints for full functionality
- **Robust Database**: Secure, scalable data storage with analytics
- **React Integration**: Easy frontend integration with comprehensive hooks
- **Comprehensive Testing**: Thoroughly tested and validated
- **Security**: Enterprise-grade security and access control
- **Performance**: Optimized for scalability and responsiveness

The system successfully bridges the gap between natural language input and structured procurement data, enabling users to create complex procurement orders through intuitive conversation while maintaining data integrity and security.