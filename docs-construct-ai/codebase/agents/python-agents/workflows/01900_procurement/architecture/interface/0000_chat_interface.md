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
# 01 - Chat Interface Documentation

## Overview

The Chat Interface is the primary conversational component of the procurement workflow. It provides a natural language interface for users to describe their procurement requirements, with AI-powered data extraction and validation.

## Component Structure

### Core Files
- `ProcurementInputAgentModal.js` - Main modal component
- `AgentChatInterface.js` - Chat UI component
- `useProcurementAgentSession.js` - Session management hook

### UI Elements
- **Message History** - Scrollable conversation thread
- **Input Field** - Multi-line text input with send button
- **Typing Indicator** - Shows when AI is processing
- **Quick Actions** - Extract Data, Validate, Preview buttons

## Chat Flow Sequence

### Initialization (Step 1-2)
```
Agent: "Hello! I can help you create a procurement order.

What GROUP would you like to start with?

Available Groups:
1. Industrial Equipment
2. Construction Equipment
3. IT Equipment
4. Office Supplies
5. Mining Mobile Equipment

Please enter the number of your chosen group or type the group name."

User: "2" (Industrial equipment)
Agent: "Great! You've selected Industrial equipment. What category are you interested in?"
```

### Category Selection (Step 5-6)
```
User: "5" (Mining mobile equipment)
Agent: "Perfect! Mining mobile equipment. Please provide the detailed specifications for your items."
```

### Item Data Input (Step 7)
```
User: [Pastes tabular data with Product Name, Specification, Category, etc.]
Agent: "I've received your item specifications. How many items total? [X] items detected."
```

### Destination Country (Step 8-9)
```
Agent: "Where will these items be delivered?"
User: "Guinea"
Agent: "Guinea selected. This triggers CDC (Customs Declaration) requirements."
```

### Importer Details (Steps 10-12)
```
Agent: "For Guinea imports, please provide the importer's NIF (Numéro d'Identification Fiscale):"
User: "NIF123456789"
Agent: "Please provide the importer's address in Guinea:"
User: "123 Mining District, Conakry, Guinea"
```

### Value Confirmation (Step 13)
```
Agent: "Based on your specifications, the estimated value is R[X]. Is this correct?"
User: "yes"
```

### Procurement Type Confirmation (Step 14)
```
Agent: "What type of procurement is this? 1. Equipment 2. Services 3. Materials 4. Mixed"
User: "1"
```

### Special Requirements (Step 15)
```
Agent: "Any special requirements or specifications?"
User: "none"
```

### Timeline Selection (Step 16)
```
Agent: "What's your preferred delivery timeline? 1. Urgent (1-2 weeks) 2. Standard (2-4 weeks) 3. This month 4. This quarter"
User: "3"
```

### Order Confirmation (Step 17)
```
Agent: "Ready to create procurement order for [X] items totaling R[Y]? Type 'yes' to confirm."
User: "yes"
Agent: "Order created successfully! Order #[Z]. Preparing Scope of Work..."
```

## Data Extraction Process

### AI Parsing Logic
The chat interface uses AI to extract structured data from natural language and tabular input:

#### Primary Data Fields
- `procurement_type` - Equipment/Services/Materials/Mixed
- `group` - Industrial equipment, Construction, etc.
- `category` - Mining mobile equipment, etc.
- `items[]` - Array of product objects with specifications
- `destination_country` - Delivery location with country code
- `importer_nif` - Tax ID for customs (when required)
- `importer_address` - Delivery address
- `estimated_value` - Calculated from item rates × quantities
- `requirements` - Special requirements text
- `timeline` - Delivery timeframe selection

#### Item Object Structure
```javascript
{
  productName: "D3 Small Bulldozer – Caterpillar",
  specification: "80–100 HP, operating weight ±8,500 kg",
  category: "Small Bulldozer",
  typicalUse: "Landscaping, site clearing, light grading",
  quantity: 1,
  rate: 650,
  currency: "ZAR",
  unit: "Hour",
  amount: 650
}
```

### Validation Rules
- **Required Fields**: procurement_type, estimated_value, items
- **Country-Specific**: CDC requirements for Guinea
- **Data Types**: Numeric validation for quantities, rates, amounts
- **Business Rules**: Minimum order value, valid country codes

## Agent Integration

### Session Management
- **Session ID**: Unique identifier for conversation thread
- **State Tracking**: Current step in workflow sequence
- **Data Persistence**: Automatic saving of extracted data
- **Error Recovery**: Session restoration on page reload

### Specialist Agents (Triggered in Preview)
- **Data Quality Validator**: Validates extracted data completeness
- **Smart Suggestion Agent**: Recommends suppliers and alternatives
- **Compliance Checker**: Verifies regulatory requirements
- **Performance Monitor**: Tracks response times and bottlenecks

## Error Handling

### Common Error Scenarios
1. **Invalid Input Format** - Non-numeric values in quantity/rate fields
2. **Missing Required Data** - Incomplete item specifications
3. **Country Validation** - Invalid country codes
4. **Session Timeout** - Automatic session recovery

### Error Recovery
- **Graceful Degradation**: Fallback to manual data entry
- **User Guidance**: Clear error messages with correction instructions
- **Data Preservation**: Maintains valid data during error states
- **Debug Integration**: IT Swarm debugging for complex issues

## Technical Implementation

### State Management
```javascript
const [messages, setMessages] = useState([]);
const [extractedData, setExtractedData] = useState(null);
const [isProcessing, setIsProcessing] = useState(false);
const [sessionId, setSessionId] = useState(null);
```

### API Integration
- **sendMessage()** - Posts user input to AI agent
- **extractData()** - Triggers data extraction from conversation
- **validateData()** - Runs validation checks
- **handoffToSOW()** - Creates order and generates SOW

### Performance Optimization
- **Debounced Input** - Prevents excessive API calls
- **Lazy Loading** - Components load on demand
- **Caching** - Session data cached locally
- **Streaming Responses** - Real-time message updates

## Testing Scenarios

### Happy Path
1. Complete workflow from greeting to order creation
2. All data fields populated correctly
3. No validation errors
4. Successful SOW generation

### Edge Cases
1. **Partial Data**: Missing specifications for some items
2. **Invalid Formats**: Non-standard tabular data
3. **Country Variations**: Different customs requirements
4. **Large Orders**: 50+ items with complex specifications

### Error Scenarios
1. **Network Issues**: API timeouts and retries
2. **Session Loss**: Recovery from interrupted sessions
3. **Data Corruption**: Validation of extracted data integrity
4. **Rate Limiting**: Handling API quota exceeded

## Metrics and Monitoring

### Key Performance Indicators
- **Completion Rate**: Percentage of sessions reaching order creation
- **Error Rate**: Frequency of validation failures
- **Response Time**: Average AI response latency
- **User Satisfaction**: Session completion without errors

### Logging and Analytics
- **Session Tracking**: Complete conversation logs
- **Error Reporting**: Detailed error context and stack traces
- **Performance Metrics**: Response times and throughput
- **User Behavior**: Click patterns and feature usage