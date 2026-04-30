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

# 0000_AGENT_DEVELOPMENT_PROCEDURE.md - Agent Development Procedure - Construct AI System Documentation

## Document Usage Guide

**🎯 This Document's Role**: Comprehensive procedure for developing, implementing, and maintaining AI agents across the ConstructAI system. **Use this FIRST** when creating new agents or modifying existing agent functionality to ensure consistent, reliable, and scalable implementations.

**📚 Related Documents in Agent Ecosystem:**
- **`docs/standards/0000_AGENT_CODING_STANDARDS.md`** → **REQUIRED REFERENCE** for coding standards and architectural patterns
- **`docs/implementation/agents/1300_00435_CONTRACTS_POST_AWARD_CORRESPONDENCE_AGENT_IMPLEMENTATION_PROCEDURE.md`** → **REQUIRED REFERENCE** for multi-agent correspondence workflows
- **`docs/pages-agents/shared-agent-architecture.md`** → Shared agent architecture implementation guide
- **`docs/procedures/0000_PROMPT_MANAGEMENT_PROCEDURE.md`** → **REQUIRED REFERENCE** for enhanced prompt management framework
- **`0000_PROCEDURES_GUIDE.md`** → Navigation index and procedure selection
- **`0000_DEBUGGING_GUIDE.md`** → Agent debugging and troubleshooting techniques

---

## Overview

This comprehensive procedure establishes standards and workflows for developing AI agents across the ConstructAI system. Based on lessons learned from the correspondence agent fixes, this procedure addresses critical gaps in agent development including prompt management, validation, error handling, testing, and quality assurance.

### **Key Problems Addressed**

The correspondence agent fixes revealed systemic issues that this procedure prevents:

1. **❌ Missing Prompt Management** → No standardized way to retrieve and audit prompts
2. **❌ No Validation Logic** → Agents produced nonsense data like "lume" and "lumes"
3. **❌ Poor Error Handling** → Agents crashed on LLM failures instead of graceful fallback
4. **❌ Hardcoded Fake Data** → Agents returned fake identifiers instead of real extraction
5. **❌ Missing Deduplication** → Same clauses appeared multiple times
6. **❌ No Quality Assurance** → No systematic testing or validation framework
7. **❌ Inadequate Substance** → Human Review and Professional Formatting lacked depth

---

## 🎯 **AGENT DEVELOPMENT METHODOLOGY**

### **Agent Design Determination Framework**

**MANDATORY**: Before classifying agents, conduct comprehensive design analysis using LangChain/LangGraph frameworks to determine optimal architecture.

#### **Step 1: Analyze Existing Workflows**

**Critical Analysis Process:**
- **Map Current Implementations**: Document all existing LangChain/LangGraph setups, identifying nodes (LLM calls, tools), edges (conditional routing), and state management
- **Performance Assessment**: Review execution traces for bottlenecks, latency issues, and failure points in construction workflows
- **Complexity Evaluation**: Determine if current flat/single-loop agents (ReAct patterns) handle task complexity adequately
- **Data Access Patterns**: Assess vector table usage vs. direct PDF processing for 1000+ page documents
- **Security Requirements**: Evaluate need for RLS policies restricting agent access to specific document subsets

```javascript
// Example workflow analysis structure
const workflowAnalysis = {
  currentAgents: [
    {
      name: 'Correspondence Agent',
      framework: 'LangChain',
      pattern: 'ReAct Loop',
      issues: ['Context overload on large documents', 'No sub-agent delegation'],
      performance: { avgLatency: 45000, failureRate: 0.15 }
    }
  ],
  dataSources: {
    vectorTables: ['document_embeddings', 'contract_chunks'],
    rawDocuments: { format: 'PDF', avgPages: 2000 },
    accessPatterns: 'Supabase RLS with agent-specific filters'
  },
  enhancementOpportunities: [
    'Implement deep agents for complex multi-step tasks',
    'Add hierarchical sub-agent delegation',
    'Integrate checkpointers for long-running workflows'
  ]
};
```

#### **Step 2: Determine Agent Architecture Type**

**Decision Framework Based on Task Complexity:**

| Complexity Level | Characteristics | Recommended Architecture | When to Use Deep Agents |
|------------------|----------------|---------------------------|-------------------------|
| **Simple Tasks** | Single-purpose, focused functionality | Flat ReAct agents | Never - overkill |
| **Multi-Step Tasks** | Sequential processes with planning | StateGraph with conditional edges | When tasks require decomposition (e.g., contract review: parse → check → report) |
| **Context-Intensive** | Large documents exceeding LLM windows | Hierarchical with sub-agents | When handling 1000+ page PDFs - delegate to specialized retrievers |
| **Multi-Agent Orchestration** | Parallel processing with HITL | Deep agents with supervisor routing | For 7+ agent chains with parallel subgraphs |
| **Enterprise Workflows** | Cross-system with compliance | Nested StateGraphs with persistence | Always - for sustained sessions and complex delegation |

**Deep Agent Usage Criteria:**
- ✅ **Complex Multi-Step Tasks**: End-to-end processes requiring dynamic planning
- ✅ **Context Overload**: Documents exceeding 4k token windows
- ✅ **Sub-Agent Delegation**: Specialized functions (compliance, logistics, safety)
- ✅ **Long-Running Persistence**: Sessions spanning multiple interactions
- ✅ **Parallel Processing**: 17+ sub-agents with independent execution

#### **Step 3: Design Data Access Strategy**

**Vector Table vs. Direct PDF Processing:**

| Data Scale | Primary Method | Enhancement Strategy |
|------------|----------------|---------------------|
| **Small Documents** (<500 pages) | Direct processing | Optional vector caching |
| **Large Documents** (500-2000 pages) | Pre-chunked vectors in Supabase | Semantic chunking with Mistral/Qwen embeddings |
| **Mega Projects** (2000+ pages) | Vector-first with hybrid fallback | File-system mounting for on-demand chunking |

**Security Implementation:**
```sql
-- RLS Policy for agent-specific document access
CREATE POLICY "Agent project docs only" ON document_embeddings
FOR SELECT TO authenticated
USING (
  project_id IN (
    SELECT project_id FROM project_agents
    WHERE agent_id = current_setting('app.current_agent_id')::uuid
  )
  AND agent_roles @> ARRAY[current_setting('app.agent_role')]
);
```

#### **Step 4: Define Enhancement Roadmap**

**Progressive Enhancement Strategy:**
1. **Immediate**: Upgrade flat agents to StateGraphs with conditional routing
2. **Short-term**: Add checkpointers for session persistence
3. **Medium-term**: Implement supervisor agents with sub-agent delegation
4. **Long-term**: Deploy full deep agent architecture with custom UI

### **Agent Classification Framework**

#### **Classification by Complexity**

| Agent Type | Characteristics | Examples | Development Time |
|------------|----------------|----------|------------------|
| **Simple Agents** | Single-purpose, focused functionality | Data extraction, format conversion | 2-3 days |
| **Workflow Agents** | Multi-step processes with state management | Correspondence analysis, document processing | 1-2 weeks |
| **Multi-Agent Systems** | Orchestrated agent teams with HITL | Correspondence reply, procurement analysis | 2-4 weeks |
| **Enterprise Agents** | Complex orchestration with compliance | Full procurement cycles, governance workflows | 4-8 weeks |

#### **Classification by Discipline Integration**

| Integration Level | Requirements | Examples |
|------------------|-------------|----------|
| **Standalone** | No external dependencies | Text analysis, format conversion |
| **Database-Integrated** | Vector search, RLS policies | Document retrieval, compliance checking |
| **HITL-Integrated** | Human oversight workflows | Approval processes, complex decisions |
| **Multi-System** | Cross-discipline orchestration | Enterprise procurement, governance |

---

## 🎯 **STREAMING IMPLEMENTATION REQUIREMENTS**

### **Streaming Architecture Standards**

**MANDATORY**: All agents must implement comprehensive streaming for user transparency and auditability.

#### **Streaming Event Types**

| Event Type | Purpose | Timing | Content Requirements | Reference |
|------------|---------|--------|---------------------|-----------|
| **task_created** | Task initialization | Pre-agent execution | Task metadata, expected inputs/outputs | `0000_WORKFLOW_TASK_PROCEDURE.md` |
| **prompt_retrieved** | Prompt loading | During agent setup | Full prompt content in markdown | - |
| **step_completion** | Agent completion | Post-agent execution | Full prompt used + results summary | - |
| **specialist_prompt_retrieved** | Specialist consultation | During multi-agent workflow | Full specialist prompt content | - |
| **hitl_completed** | Human review assessment | Post-HITL assessment | Decision outcomes + confidence scores | `0000_WORKFLOW_HITL_PROCEDURE.md` |
| **hitl_task_created** | HITL task creation | When human intervention needed | Task details, escalation reason, specialist assignment | `0000_WORKFLOW_HITL_PROCEDURE.md` |

#### **Streaming Content Standards**

**MANDATORY**: All streaming messages must include complete, untruncated content.

```javascript
// ✅ CORRECT: Full prompt content streaming
onProgress(0.8, `🎯 **SPECIALIST PROMPT RETRIEVED: ${specialistName}**\n\n**Specialist:** ${specialistName}\n**Prompt Key:** ${promptKey}\n**Content Preview:** ${promptContent.substring(0, 150)}...\n\n**FULL PROMPT CONTENT:**\n\`\`\`\n${promptContent}\n\`\`\`\n\n**Status:** Specialist consultation queued`, {
  taskType: 'specialist_prompt_retrieved',
  specialistType: specialistType,
  promptKey: promptKey,
  promptLength: promptContent.length,
  fullPromptContent: promptContent, // Include full content in metadata
  timestamp: new Date().toISOString()
});

// ❌ INCORRECT: Truncated content only
onProgress(0.8, `Prompt retrieved: ${promptContent.substring(0, 150)}...`, {
  taskType: 'prompt_retrieved'
  // Missing full content
});
```

#### **Agent State Management for Streaming**

**MANDATORY**: All agents must store prompts for completion streaming.

```javascript
class StreamingAgent {
  constructor(config = {}) {
    this.state = {
      // ... existing state ...
      lastPrompt: null, // REQUIRED: Store last prompt for completion streaming
      streamingEnabled: true
    };
  }

  async retrieveAndStorePrompt(promptKey) {
    const promptContent = await PromptsService.getPromptByKey(promptKey);
    this.state.lastPrompt = promptContent; // REQUIRED: Store for completion streaming
    return promptContent;
  }

  // Completion streaming method
  streamCompletion(onProgress, step, agentName) {
    if (this.state.lastPrompt && onProgress) {
      onProgress(step, `📋 **Step ${step}: ${agentName} Complete**\n\n📝 **AUDIT: Actual Prompt Retrieved from Supabase Database:**\n\n\`\`\`\n${this.state.lastPrompt}\n\`\`\``, {
        taskType: 'step_completion',
        step: step,
        agentName: agentName,
        promptContent: this.state.lastPrompt,
        promptLength: this.state.lastPrompt.length,
        timestamp: new Date().toISOString()
      });
    }
  }
}
```

### **Streaming Implementation Checklist**

#### **Pre-Implementation**
- [ ] Agent state includes `lastPrompt: null` property
- [ ] All prompt retrieval methods store prompts in state
- [ ] Orchestrator includes completion streaming calls
- [ ] Streaming metadata includes full prompt content

#### **Implementation**
- [ ] Specialist prompts streamed with full content in markdown code blocks
- [ ] Main agent prompts streamed after completion with full content
- [ ] HITL completion events include decision outcomes
- [ ] All streaming events include timestamps and correlation data

#### **Testing**
- [ ] Streaming displays full prompt content without truncation
- [ ] Completion streaming shows prompts used for each step
- [ ] UI renders markdown formatting correctly
- [ ] Performance impact of full content streaming is acceptable

### **Streaming Performance Considerations**

#### **Content Size Management**
```javascript
class StreamingOptimizer {
  static shouldStreamFullContent(promptLength, userPreference) {
    // Default: Always stream full content for auditability
    // Future: Allow user preference for truncated vs full
    return true;
  }

  static formatPromptForStreaming(promptContent, specialistName = null) {
    const header = specialistName ?
      `🎯 **SPECIALIST PROMPT RETRIEVED: ${specialistName}**` :
      `📝 **AUDIT: Actual Prompt Retrieved from Supabase Database:**`;

    return `${header}\n\n\`\`\`\n${promptContent}\n\`\`\``;
  }
}
```

#### **Memory Management**
```javascript
class StreamingMemoryManager {
  static optimizeStreamingPayload(promptContent, maxLength = 50000) {
    if (promptContent.length <= maxLength) {
      return promptContent;
    }

    // If extremely long, provide truncated version with warning
    const truncated = promptContent.substring(0, maxLength - 100);
    return `${truncated}...\n\n**[CONTENT TRUNCATED]** Full prompt length: ${promptContent.length} characters`;
  }
}
```

---

## 📋 **PHASED DEVELOPMENT PROCESS**

### **Phase 1: Planning & Requirements Analysis**

#### **Step 1.1: Agent Requirements Definition**

**Required Deliverables:**
```javascript
const agentRequirements = {
  // Basic Information
  name: 'AgentName',
  discipline: 'DISCIPLINE_CODE',
  pageId: 'PAGE_ID',
  type: 'simple|workflow|multi-agent|enterprise',

  // Functional Requirements
  purpose: 'Clear description of what the agent does',
  inputs: ['input1', 'input2', 'input3'],
  outputs: ['output1', 'output2', 'output3'],
  successCriteria: [
    'Must process X documents per minute',
    'Must achieve Y% accuracy',
    'Must handle Z edge cases'
  ],

  // Technical Requirements
  promptKeys: ['agent_discipline_01_purpose', 'agent_discipline_02_validation'],
  vectorTables: ['table1', 'table2'],
  specialistTypes: ['specialist1', 'specialist2'],
  hitlRequired: true|false,

  // Quality Requirements
  minConfidenceScore: 0.75,
  maxProcessingTime: 30000, // ms
  errorTolerance: 0.05, // 5%
  auditRequirements: true
};
```

#### **Step 1.2: Prompt Management Planning**

**Critical Requirement**: All agents MUST use database-managed prompts, never hardcoded prompts.

```javascript
// ✅ CORRECT: Database-managed prompts
const promptKey = 'agent_discipline_01_analysis';
const promptContent = await PromptsService.getPromptByKey(promptKey);

// Log for audit purposes
console.log(`📝 [${this.constructor.name}] AUDIT: Prompt retrieved from database: ${promptContent.substring(0, 100)}...`);

// ❌ INCORRECT: Never hardcode prompts
const prompt = `You are an AI assistant...`; // NEVER DO THIS
```

**Prompt Key Standards:**
- Format: `agent_{discipline}_{sequence}_{purpose}`
- Examples: `agent_correspondence_01_document_analysis`, `agent_procurement_02_validation`
- All keys must be validated using `PromptKeyValidator`

#### **Step 1.3: Data Validation Strategy**

**MANDATORY**: All agents must implement robust validation to prevent nonsense outputs.

```javascript
class AgentValidator {
  // Prevent nonsense like "lume", "lumes", "volume"
  static isValidIdentifier(identifier, type) {
    // Implementation from correspondence agent fixes
    const invalidPatterns = [
      /^lume[s]?$/i,  // Common OCR errors
      /^volume[s]?$/i,
      /^material[s]?$/i,
      /^[a-z]{1,3}$/i,  // Very short identifiers
      /^\d+$/,  // Pure numbers
      /^.{0,2}$/,  // Empty/short strings
    ];

    for (const pattern of invalidPatterns) {
      if (pattern.test(identifier)) {
        return false;
      }
    }

    // Type-specific validation
    switch (type) {
      case 'variation':
        return /^[A-Z]{2,3}-\d{1,4}$/.test(identifier.toUpperCase());
      case 'technical':
        return /^[A-Z]{3,4}-[A-Z0-9\-]{3,}$/.test(identifier.toUpperCase());
      case 'correspondence':
        return /^[A-Z]{2,}\/[A-Z0-9]{2,}\/[CE]\d{1,4}$/.test(identifier.toUpperCase());
      default:
        return /^[A-Z0-9\-\/]{3,}$/.test(identifier.toUpperCase());
    }
  }
}
```

#### **Step 1.4: Error Handling Strategy**

**MANDATORY**: All agents must implement graceful error handling with fallbacks.

```javascript
class AgentErrorHandler {
  static async handleAgentFailure(agentId, operation, error) {
    console.error(`❌ [${agentId}] ${operation} failed:`, error);

    // Try fallback operation
    try {
      return await this.executeFallback(agentId, operation);
    } catch (fallbackError) {
      console.error(`❌ [${agentId}] Fallback also failed:`, fallbackError);

      // Return transparent error response
      return {
        success: false,
        error: error.message,
        fallbackAttempted: true,
        timestamp: new Date().toISOString(),
        agentId: agentId,
        operation: operation
      };
    }
  }

  static async executeFallback(agentId, operation) {
    // Implement operation-specific fallback logic
    const fallbacks = {
      'llm_call': () => this.patternBasedFallback(agentId),
      'database_query': () => this.cachedDataFallback(agentId),
      'vector_search': () => this.manualSearchFallback(agentId)
    };

    return await (fallbacks[operation] || (() => ({ success: false, error: 'No fallback available' })))();
  }
}
```

### **Phase 2: Core Implementation**

#### **Step 2.1: Agent Architecture Setup**

**MANDATORY**: All agents must follow the standardized architecture.

```javascript
class NewAgent {
  constructor(config = {}) {
    // Required properties
    this.pageId = config.pageId || 'PAGE_ID';
    this.disciplineCode = config.disciplineCode || 'DISCIPLINE';
    this.userId = config.userId || 'USER_DEFAULT';
    this.apiEndpoint = config.apiEndpoint || '/api/chat-agent/message';
    this.projectName = config.projectName || 'Project Name';
    this.projectContext = config.projectContext || 'Project Context';

    // State management
    this.state = {
      currentStep: 'initialized',
      isProcessing: false,
      results: {},
      errors: [],
      warnings: []
    };

    // Services
    this.llmService = config.llmService || new LLMService(config);
    this.promptsService = config.promptsService || PromptsService;
    this.validator = config.validator || AgentValidator;

    console.log(`🎯 [${this.constructor.name}] Agent initialized`);
  }

  async initialize() {
    try {
      // Validate prompt availability
      const requiredPrompts = this.getRequiredPrompts();
      for (const promptKey of requiredPrompts) {
        const prompt = await this.promptsService.getPromptByKey(promptKey);
        if (!prompt) {
          console.warn(`⚠️ [${this.constructor.name}] Required prompt missing: ${promptKey}`);
          this.state.warnings.push(`Missing prompt: ${promptKey}`);
        } else {
          console.log(`✅ [${this.constructor.name}] Prompt available: ${promptKey}`);
        }
      }

      return true;
    } catch (error) {
      console.error(`❌ [${this.constructor.name}] Initialization failed:`, error);
      return false;
    }
  }

  getRequiredPrompts() {
    // Override in subclasses to return array of required prompt keys
    return ['agent_discipline_01_purpose'];
  }
}
```

#### **Step 2.2: Prompt Integration Implementation**

**MANDATORY**: All prompt retrieval must be logged for audit purposes.

```javascript
class PromptManager {
  static async getAndLogPrompt(promptKey, agentName) {
    try {
      console.log(`📋 [${agentName}] Retrieving prompt: ${promptKey}`);

      const promptContent = await PromptsService.getPromptByKey(promptKey);

      if (promptContent && promptContent.trim()) {
        console.log(`✅ [${agentName}] Prompt retrieved successfully (${promptContent.length} chars)`);
        console.log(`📝 [${agentName}] AUDIT: ${promptContent.substring(0, 100)}...`);

        return promptContent;
      } else {
        console.warn(`⚠️ [${agentName}] Prompt not found in database: ${promptKey}`);
        console.log(`🔄 [${agentName}] Using fallback prompt mode`);

        return this.getFallbackPrompt(promptKey, agentName);
      }

    } catch (error) {
      console.error(`❌ [${agentName}] Prompt retrieval failed: ${promptKey}`, error);
      console.log(`🔄 [${agentName}] Using fallback prompt mode due to error`);

      return this.getFallbackPrompt(promptKey, agentName);
    }
  }

  static getFallbackPrompt(promptKey, agentName) {
    // Provide basic fallback prompts when database unavailable
    const fallbacks = {
      'agent_correspondence_01_document_analysis': `# Document Analysis Agent

You are a construction contract document analysis expert. Analyze the provided correspondence and extract key information including sender, recipient, date, subject, and main issues discussed.`,
    };

    return fallbacks[promptKey] || `# Fallback Prompt for ${promptKey}

This is a fallback prompt because the database version could not be retrieved. Please provide a basic analysis based on standard practices.`;
  }
}
```

#### **Step 2.3: Validation Layer Implementation**

**MANDATORY**: All agents must validate inputs and outputs.

```javascript
class AgentValidation {
  static validateInput(input, schema) {
    const errors = [];

    // Required field validation
    for (const [field, rules] of Object.entries(schema)) {
      if (rules.required && (!input[field] || input[field].toString().trim() === '')) {
        errors.push(`Missing required field: ${field}`);
      }

      // Type validation
      if (input[field] && rules.type && typeof input[field] !== rules.type) {
        errors.push(`Invalid type for ${field}: expected ${rules.type}, got ${typeof input[field]}`);
      }

      // Length validation
      if (input[field] && rules.minLength && input[field].length < rules.minLength) {
        errors.push(`Field ${field} too short: minimum ${rules.minLength} characters`);
      }

      // Pattern validation
      if (input[field] && rules.pattern && !rules.pattern.test(input[field])) {
        errors.push(`Field ${field} does not match required pattern`);
      }
    }

    return {
      isValid: errors.length === 0,
      errors: errors,
      warnings: []
    };
  }

  static validateOutput(output, expectedSchema) {
    const errors = [];

    // Structure validation
    if (expectedSchema.requiredFields) {
      for (const field of expectedSchema.requiredFields) {
        if (!output[field]) {
          errors.push(`Missing required output field: ${field}`);
        }
      }
    }

    // Content validation
    if (expectedSchema.contentRules) {
      for (const [field, rules] of Object.entries(expectedSchema.contentRules)) {
        if (output[field]) {
          // Check for nonsense content
          if (rules.noNonsense && this.containsNonsense(output[field])) {
            errors.push(`Field ${field} contains potentially nonsensical content`);
          }

          // Check minimum substance
          if (rules.minWords && this.countWords(output[field]) < rules.minWords) {
            errors.push(`Field ${field} lacks sufficient content (${this.countWords(output[field])} words, minimum ${rules.minWords})`);
          }
        }
      }
    }

    return {
      isValid: errors.length === 0,
      errors: errors,
      qualityScore: this.calculateQualityScore(output, expectedSchema)
    };
  }

  static containsNonsense(text) {
    // Check for common nonsense patterns
    const nonsensePatterns = [
      /\blume[s]?\b/gi,  // OCR errors
      /\bvolume[s]?\b/gi,  // Generic terms
      /\bmaterial[s]?\b/gi,
      /^\s*$/,  // Empty or whitespace only
      /^[^\w]*$/,  // Punctuation only
    ];

    return nonsensePatterns.some(pattern => pattern.test(text));
  }

  static countWords(text) {
    return text.trim().split(/\s+/).length;
  }

  static calculateQualityScore(output, schema) {
    let score = 100;

    // Deduct for errors
    score -= (schema.errors || []).length * 20;

    // Deduct for missing required fields
    const missingFields = schema.requiredFields?.filter(f => !output[f]) || [];
    score -= missingFields.length * 15;

    // Deduct for low content quality
    if (schema.contentRules) {
      for (const [field, rules] of Object.entries(schema.contentRules)) {
        if (output[field] && rules.minWords) {
          const wordCount = this.countWords(output[field]);
          if (wordCount < rules.minWords) {
            score -= Math.max(0, (rules.minWords - wordCount) * 2);
          }
        }
      }
    }

    return Math.max(0, Math.min(100, score));
  }
}
```

#### **Step 2.4: Deduplication Logic Implementation**

**MANDATORY**: All agents must implement deduplication for repeated items.

```javascript
class AgentDeduplication {
  static deduplicateResults(items, options = {}) {
    if (!Array.isArray(items)) return items;

    const seen = new Set();
    const normalized = new Set();

    return items.filter(item => {
      // Exact match deduplication
      const exactKey = this.getExactKey(item);
      if (seen.has(exactKey)) {
        return false;
      }

      // Normalized deduplication (for clauses, identifiers)
      const normalizedKey = this.getNormalizedKey(item, options);
      if (normalized.has(normalizedKey)) {
        console.log(`⚠️ [AgentDeduplication] Duplicate normalized item removed: ${normalizedKey}`);
        return false;
      }

      seen.add(exactKey);
      normalized.add(normalizedKey);
      return true;
    });
  }

  static getExactKey(item) {
    // For objects, create a stable key
    if (typeof item === 'object') {
      return JSON.stringify(item, Object.keys(item).sort());
    }
    return item.toString();
  }

  static getNormalizedKey(item, options) {
    if (typeof item === 'string') {
      // For clauses like "Clause 5", "Contract Clause 5", "Scope of Work Clause 5"
      const clauseMatch = item.match(/(?:clause\s+)?(\d+(?:\.\d+)*)/i);
      if (clauseMatch) {
        return `clause_${clauseMatch[1]}`;
      }

      // For identifiers, normalize case and remove extra spaces
      return item.toLowerCase().trim().replace(/\s+/g, ' ');
    }

    if (typeof item === 'object' && item.extractedId) {
      return item.extractedId.toLowerCase().trim();
    }

    return this.getExactKey(item);
  }

  static mergeWithDeduplication(existing, additional) {
    const combined = [...existing, ...additional];
    return this.deduplicateResults(combined);
  }
}
```

### **Phase 3: Testing & Quality Assurance**

#### **Step 3.1: Unit Testing Framework**

**MANDATORY**: All agents must have comprehensive unit tests.

```javascript
describe('NewAgent', () => {
  let agent;
  let mockPromptsService;
  let mockLLMService;

  beforeEach(() => {
    // Mock services
    mockPromptsService = {
      getPromptByKey: jest.fn()
    };

    mockLLMService = {
      callLLM: jest.fn()
    };

    // Create agent with mocks
    agent = new NewAgent({
      promptsService: mockPromptsService,
      llmService: mockLLMService
    });
  });

  describe('Initialization', () => {
    test('initializes with correct configuration', async () => {
      mockPromptsService.getPromptByKey.mockResolvedValue('# Test Prompt');

      const result = await agent.initialize();

      expect(result).toBe(true);
      expect(mockPromptsService.getPromptByKey).toHaveBeenCalledWith('agent_discipline_01_purpose');
    });

    test('handles missing prompts gracefully', async () => {
      mockPromptsService.getPromptByKey.mockResolvedValue(null);

      const result = await agent.initialize();

      expect(result).toBe(true);
      expect(agent.state.warnings).toContain('Missing prompt: agent_discipline_01_purpose');
    });
  });

  describe('Validation', () => {
    test('rejects nonsense identifiers', () => {
      expect(agent.validator.isValidIdentifier('lume', 'variation')).toBe(false);
      expect(agent.validator.isValidIdentifier('lumes', 'variation')).toBe(false);
      expect(agent.validator.isValidIdentifier('volume', 'variation')).toBe(false);
    });

    test('accepts valid identifiers', () => {
      expect(agent.validator.isValidIdentifier('VI-003', 'variation')).toBe(true);
      expect(agent.validator.isValidIdentifier('DWG-STR-001', 'technical')).toBe(true);
      expect(agent.validator.isValidIdentifier('BB/DHBEP/C003', 'correspondence')).toBe(true);
    });
  });

  describe('Error Handling', () => {
    test('handles LLM failures gracefully', async () => {
      mockLLMService.callLLM.mockRejectedValue(new Error('API Error'));

      const result = await agent.processInput('test input');

      expect(result.success).toBe(false);
      expect(result.fallbackAttempted).toBe(true);
      expect(result.error).toContain('API Error');
    });

    test('provides meaningful fallback responses', async () => {
      mockLLMService.callLLM.mockRejectedValue(new Error('API Error'));

      const result = await agent.processInput('test input');

      expect(result.fallbackData).toBeDefined();
      expect(result.fallbackMode).toBe(true);
    });
  });
});
```

#### **Step 3.2: Integration Testing Framework**

**MANDATORY**: All agents must pass integration tests.

```javascript
describe('Agent Integration Tests', () => {
  let agent;

  beforeEach(async () => {
    agent = await AgentFactory.createAgent('TEST_AGENT');
  });

  test('complete workflow execution', async () => {
    const progressUpdates = [];

    const result = await agent.processCorrespondence('Test input', {
      onProgress: (step, message, data) => {
        progressUpdates.push({ step, message, data });
      }
    });

    // Verify all steps executed
    expect(progressUpdates.length).toBeGreaterThan(0);
    expect(result).toBeDefined();
    expect(result.success).toBe(true);
  });

  test('handles real LLM API failures', async () => {
    // Temporarily disable LLM service
    agent.llmService.enabled = false;

    const result = await agent.processCorrespondence('Test input');

    expect(result.fallbackMode).toBe(true);
    expect(result.success).toBe(true);
  });

  test('produces valid, non-nonsense output', async () => {
    const result = await agent.processCorrespondence('Test construction correspondence');

    // Verify output quality
    expect(result.output).not.toMatch(/\blume[s]?\b/i);
    expect(result.output).not.toMatch(/\bvolume[s]?\b/i);
    expect(result.output.length).toBeGreaterThan(100);
  });

  test('properly deduplicates repeated items', async () => {
    const result = await agent.extractIdentifiers('Clause 5, Contract Clause 5, SOW Clause 5');

    const clause5Matches = result.clauses.filter(c =>
      c.extractedId.toLowerCase().includes('clause 5')
    );

    expect(clause5Matches.length).toBe(1); // Should be deduplicated
  });
});
```

#### **Step 3.3: Performance Testing**

**MANDATORY**: All agents must meet performance requirements.

```javascript
describe('Agent Performance Tests', () => {
  test('meets response time requirements', async () => {
    const agent = await AgentFactory.createAgent('PERFORMANCE_TEST');
    const startTime = Date.now();

    await agent.processCorrespondence('Performance test input');

    const duration = Date.now() - startTime;
    expect(duration).toBeLessThan(30000); // 30 seconds max
  });

  test('handles concurrent requests', async () => {
    const agent = await AgentFactory.createAgent('CONCURRENCY_TEST');
    const promises = [];

    // Create 5 concurrent requests
    for (let i = 0; i < 5; i++) {
      promises.push(agent.processCorrespondence(`Request ${i}`));
    }

    const results = await Promise.all(promises);

    // All should succeed
    results.forEach(result => {
      expect(result.success).toBe(true);
    });
  });

  test('circuit breaker prevents cascade failures', async () => {
    const agent = await AgentFactory.createAgent('CIRCUIT_BREAKER_TEST');

    // Simulate multiple failures
    for (let i = 0; i < 10; i++) {
      try {
        await agent.llmService.callLLM('Failing prompt');
      } catch (error) {
        // Expected
      }
    }

    // Circuit breaker should activate
    expect(agent.llmService.circuitBreaker.state).toBe('OPEN');

    // Subsequent calls should use fallback
    const result = await agent.processCorrespondence('Test input');
    expect(result.fallbackMode).toBe(true);
  });
});
```

#### **Step 3.4: Quality Assurance Testing**

**MANDATORY**: All agents must pass quality validation.

```javascript
describe('Agent Quality Assurance', () => {
  test('produces substantive content', async () => {
    const agent = await AgentFactory.createAgent('QUALITY_TEST');
    const result = await agent.generateResponse('Test input');

    // Check for substance
    expect(result.content).toBeDefined();
    expect(result.content.length).toBeGreaterThan(500); // Minimum length
    expect(result.confidenceScore).toBeGreaterThan(0.7); // Minimum confidence
  });

  test('includes all required sections', async () => {
    const agent = await AgentFactory.createAgent('STRUCTURE_TEST');
    const result = await agent.generateProfessionalResponse('Test correspondence');

    // Check for required sections
    expect(result.content).toMatch(/decision/i);
    expect(result.content).toMatch(/commercial/i);
    expect(result.content).toMatch(/implementation/i);
    expect(result.content).toMatch(/requirements/i);
  });

  test('handles edge cases gracefully', async () => {
    const agent = await AgentFactory.createAgent('EDGE_CASE_TEST');

    // Test with empty input
    const emptyResult = await agent.processCorrespondence('');
    expect(emptyResult.success).toBe(false);
    expect(emptyResult.error).toContain('Invalid input');

    // Test with very long input
    const longInput = 'A'.repeat(10000);
    const longResult = await agent.processCorrespondence(longInput);
    expect(longResult.success).toBe(true);

    // Test with special characters
    const specialInput = 'Test with @#$%^&*() characters';
    const specialResult = await agent.processCorrespondence(specialInput);
    expect(specialResult.success).toBe(true);
  });
});
```

### **Phase 4: Deployment & Monitoring**

#### **Step 4.1: Pre-Deployment Validation**

**MANDATORY**: All agents must pass pre-deployment checks.

```javascript
const preDeploymentChecks = {
  async validateAgentForDeployment(agentId, config) {
    const checks = {
      promptAvailability: false,
      configurationValid: false,
      dependenciesResolved: false,
      securityConfigured: false,
      performanceAcceptable: false
    };

    // Check prompt availability
    const requiredPrompts = config.requiredPrompts || [];
    for (const promptKey of requiredPrompts) {
      const prompt = await PromptsService.getPromptByKey(promptKey);
      if (!prompt) {
        console.error(`❌ Missing required prompt: ${promptKey}`);
        return false;
      }
    }
    checks.promptAvailability = true;

    // Check configuration
    if (!config.pageId || !config.disciplineCode) {
      console.error('❌ Invalid agent configuration');
      return false;
    }
    checks.configurationValid = true;

    // Check dependencies
    const dependencies = config.dependencies || [];
    for (const dep of dependencies) {
      if (!await this.checkDependencyAvailable(dep)) {
        console.error(`❌ Missing dependency: ${dep}`);
        return false;
      }
    }
    checks.dependenciesResolved = true;

    // Security validation
    if (!await this.validateSecurityConfig(config)) {
      console.error('❌ Security configuration invalid');
      return false;
    }
    checks.securityConfigured = true;

    // Performance validation
    if (!await this.validatePerformanceRequirements(agentId)) {
      console.error('❌ Performance requirements not met');
      return false;
    }
    checks.performanceAcceptable = true;

    console.log('✅ All pre-deployment checks passed');
    return true;
  }
};
```

#### **Step 4.2: Production Monitoring Setup**

**MANDATORY**: All agents must have monitoring in production.

```javascript
const agentMonitoring = {
  setupProductionMonitoring(agentId, config) {
    // Error tracking
    this.setupErrorTracking(agentId);

    // Performance monitoring
    this.setupPerformanceMonitoring(agentId);

    // Usage analytics
    this.setupUsageAnalytics(agentId);

    // Alert configuration
    this.setupAlerts(agentId, config.alertThresholds);
  },

  setupErrorTracking(agentId) {
    // Integrate with error tracking service
    window.addEventListener('error', (event) => {
      if (event.message.includes(agentId)) {
        this.reportAgentError(agentId, event.error);
      }
    });

    // Custom agent error events
    window.addEventListener('agentError', (event) => {
      if (event.detail.agentId === agentId) {
        this.reportAgentError(agentId, event.detail.error);
      }
    });
  },

  setupPerformanceMonitoring(agentId) {
    // Monitor response times
    this.performanceObserver = new PerformanceObserver((list) => {
      for (const entry of list.getEntries()) {
        if (entry.name.includes(agentId)) {
          this.reportPerformanceMetric(agentId, entry);
        }
      }
    });
    this.performanceObserver.observe({ entryTypes: ['measure'] });
  },

  setupUsageAnalytics(agentId) {
    // Track agent usage patterns
    this.usageMetrics = {
      totalRequests: 0,
      successfulRequests: 0,
      averageResponseTime: 0,
      errorRate: 0,
      fallbackUsage: 0
    };
  },

  setupAlerts(agentId, thresholds) {
    const defaultThresholds = {
      errorRate: 0.05, // 5% error rate
      responseTime: 30000, // 30 seconds
      circuitBreakerTriggers: 5 // per hour
    };

    const alertConfig = { ...defaultThresholds, ...thresholds };

    // Set up alert conditions
    this.alertConditions = {
      highErrorRate: (metrics) => metrics.errorRate > alertConfig.errorRate,
      slowResponse: (metrics) => metrics.averageResponseTime > alertConfig.responseTime,
      circuitBreaker: (metrics) => metrics.circuitBreakerTriggers > alertConfig.circuitBreakerTriggers
    };
  }
};
```

---

## 🔧 **AGENT DEVELOPMENT BEST PRACTICES**

### **Prompt Management Standards**

#### **Prompt Key Naming Convention**
```javascript
// ✅ CORRECT: Hierarchical naming
agent_correspondence_01_document_analysis
agent_correspondence_02_identifier_extraction
agent_procurement_01_quotation_analysis

// ❌ INCORRECT: Non-hierarchical
correspondence_analysis
analysis_agent
procurement_agent
```

#### **Prompt Content Standards**
```javascript
// ✅ CORRECT: Structured, role-based prompts
`# Document Analysis Agent - Construction Industry Specialist

You are the Document Analysis Agent in a multi-agent correspondence analysis workflow.
Your primary function is to perform comprehensive analysis of construction correspondence.

**ANALYSIS REQUIREMENTS:**
1. Extract sender and recipient information
2. Identify document references and contractual terms
3. Analyze compliance requirements and potential issues
4. Provide structured findings for downstream processing

**OUTPUT FORMAT:**
Return analysis in structured JSON format with the following fields:
- metadata: sender, recipient, date, subject
- keyIssues: array of identified issues
- referencedDocs: categorized document references`

// ❌ INCORRECT: Unstructured, generic prompts
`You are an AI assistant. Analyze this document and provide some information about it.`
```

### **Error Handling Patterns**

#### **Graceful Degradation**
```javascript
class AgentResilience {
  static async withFallback(operation, fallbackFn) {
    try {
      return await operation();
    } catch (error) {
      console.warn(`⚠️ Operation failed, using fallback:`, error.message);

      try {
        const fallbackResult = await fallbackFn();
        return {
          ...fallbackResult,
          _fallbackMode: true,
          _originalError: error.message
        };
      } catch (fallbackError) {
        console.error(`❌ Both operation and fallback failed:`, fallbackError);
        throw new Error(`Operation failed: ${error.message}, fallback also failed: ${fallbackError.message}`);
      }
    }
  }
}
```

#### **Circuit Breaker Pattern**
```javascript
class CircuitBreaker {
  constructor(failureThreshold = 5, recoveryTimeout = 60000) {
    this.failureThreshold = failureThreshold;
    this.recoveryTimeout = recoveryTimeout;
    this.failureCount = 0;
    this.lastFailureTime = null;
    this.state = 'CLOSED'; // CLOSED, OPEN, HALF_OPEN
  }

  async execute(operation) {
    if (this.state === 'OPEN') {
      if (Date.now() - this.lastFailureTime > this.recoveryTimeout) {
        this.state = 'HALF_OPEN';
      } else {
        throw new Error('Circuit breaker is OPEN');
      }
    }

    try {
      const result = await operation();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      throw error;
    }
  }

  onSuccess() {
    this.failureCount = 0;
    this.state = 'CLOSED';
  }

  onFailure() {
    this.failureCount++;
    this.lastFailureTime = Date.now();

    if (this.failureCount >= this.failureThreshold) {
      this.state = 'OPEN';
    }
  }
}
```

### **Validation Best Practices**

#### **Input Validation**
```javascript
class InputValidator {
  static validateCorrespondenceInput(input) {
    const schema = {
      text: { required: true, type: 'string', minLength: 10 },
      discipline: { required: true, type: 'string', pattern: /^[A-Z]{2,4}$/ },
      userId: { required: true, type: 'string' }
    };

    return AgentValidation.validateInput(input, schema);
  }

  static validateAgentOutput(output, agentType) {
    const schemas = {
      documentAnalysis: {
        requiredFields: ['metadata', 'keyIssues', 'referencedDocs'],
        contentRules: {
          analysis: { minWords: 50, noNonsense: true },
          keyIssues: { minWords: 20 }
        }
      },
      informationExtraction: {
        requiredFields: ['extractedData', 'extractionStats'],
        contentRules: {
          extractedData: { noNonsense: true }
        }
      }
    };

    return AgentValidation.validateOutput(output, schemas[agentType]);
  }
}
```

### **Testing Best Practices**

#### **Test Coverage Requirements**
```javascript
const testCoverageRequirements = {
  unitTests: {
    required: true,
    minimumCoverage: 80,
    focusAreas: [
      'Input validation',
      'Error handling',
      'Prompt retrieval',
      'Output formatting'
    ]
  },
  integrationTests: {
    required: true,
    scenarios: [
      'Complete workflow execution',
      'LLM service failures',
      'Database connectivity issues',
      'Invalid input handling'
    ]
  },
  performanceTests: {
    required: true,
    metrics: [
      'Response time < 30s',
      'Memory usage < 100MB',
      'Error rate < 5%'
    ]
  },
  qualityTests: {
    required: true,
    criteria: [
      'No nonsense output',
      'Proper deduplication',
      'Substantive content',
      'Audit trail completeness'
    ]
  }
};
```

---

## 📋 **COMPLIANCE CHECKLIST**

### **Pre-Development Checklist**
- [ ] Agent requirements defined and approved
- [ ] Prompt keys created and validated
- [ ] Vector database tables configured
- [ ] Agent configuration added to agentConfigs.js
- [ ] Security permissions reviewed
- [ ] Monitoring and alerting configured

### **Development Checklist**
- [ ] Agent follows standardized architecture
- [ ] All prompts retrieved from database with audit logging
- [ ] Robust validation prevents nonsense output
- [ ] Graceful error handling with fallbacks
- [ ] Deduplication logic implemented
- [ ] Comprehensive unit tests written
- [ ] Integration tests pass
- [ ] Performance requirements met

### **Pre-Deployment Checklist**
- [ ] Quality assurance tests pass
- [ ] Security validation completed
- [ ] Pre-deployment checks pass
- [ ] Monitoring configured
- [ ] Rollback plan documented
- [ ] Stakeholder approval obtained

### **Post-Deployment Checklist**
- [ ] Production monitoring active
- [ ] Error tracking functional
- [ ] Performance metrics collected
- [ ] User feedback monitored
- [ ] Continuous improvement plan active

---

## 🔗 **CROSS-REFERENCES**

### **Related Procedures**
- **`docs/standards/0000_AGENT_CODING_STANDARDS.md`** → **REQUIRED REFERENCE** for coding standards and architectural patterns
- **`docs/pages-agents/1300_00435_AGENT_CORRESPONDENCE_REPLY_PROCEDURE.md`** → **REQUIRED REFERENCE** for multi-agent correspondence workflows
- **`docs/pages-agents/shared-agent-architecture.md`** → Shared agent architecture implementation guide
- **`docs/procedures/0000_PROMPT_MANAGEMENT_PROCEDURE.md`** → **REQUIRED REFERENCE** for enhanced prompt management framework
- **`docs/procedures/0000_WORKFLOW_HITL_PROCEDURE.md`** → **MANDATORY REFERENCE** for HITL integration, agent-initiated workflows, and human-in-the-loop decision frameworks
- **`docs/procedures/0001_PROMPT_SYNCHRONIZATION_PROCEDURE.md`** → **REQUIRED REFERENCE** for prompt synchronization, MD file management, and development workflow integration
- **`docs/procedures/0500_VECTOR_DATA_ISOLATION_PROCEDURE.md`** → **MANDATORY REFERENCE** for vector data access strategies, RLS policies, and data isolation security
- **`0000_PROCEDURES_GUIDE.md`** → Navigation index and procedure selection
- **`0000_DEBUGGING_GUIDE.md`** → Agent debugging and troubleshooting techniques

### **Referenced Documentation**
- **`AGENTS.md`** → AI agent development guidelines and standards
- **`docs/0000_MASTER_DATABASE_SCHEMA.md`** → Complete database schema reference
- **`docs/error-tracking/1300_00000_ERROR_TRACKING_ALL.md`** → Error tracking and monitoring

## 📊 **SUCCESS METRICS**

### **Development Quality Metrics**
- **Prompt Retrieval Success**: >99% of prompts retrieved from database
- **Validation Coverage**: 100% of inputs and outputs validated
- **Error Handling Coverage**: 100% of error paths handled gracefully
- **Test Coverage**: >80% code coverage with comprehensive testing

### **Production Performance Metrics**
- **Response Time**: <30 seconds average for all agent types
- **Error Rate**: <5% of requests result in errors
- **Fallback Usage**: <10% of requests use fallback modes
- **User Satisfaction**: >85% positive user feedback

### **Quality Assurance Metrics**
- **Nonsense Content**: 0% of outputs contain nonsense data
- **Deduplication Accuracy**: >95% of duplicate items properly removed
- **Content Substance**: 100% of outputs meet minimum content requirements
- **Audit Completeness**: 100% of operations fully logged

## 🔧 **ENHANCED PROMPT MANAGEMENT FRAMEWORK**

### **Overview**
The ConstructAI system now implements an **Enhanced Prompt Management Framework** that provides scalable, hierarchical prompt organization with development mode overrides, hot reloading, validation, and comprehensive auditing. This framework addresses the limitations of flat prompt storage and enables efficient debugging workflows for hundreds of agents across multiple pages.

### **Key Features**
- **Hierarchical Organization**: Page-based and workflow-based directory structure
- **Development Mode Overrides**: Local prompt files for rapid iteration
- **Hot Reloading**: Automatic detection of prompt changes during development
- **Prompt Validation**: Quality assurance with scoring and error detection
- **Streaming Audit Trails**: Complete prompt content streaming for debugging transparency
- **Version Control**: Comparison tools and database synchronization
- **Multi-Agent Integration**: Fully integrated with 7 segregated correspondence agents

### **Directory Structure**
```
docs/dev-prompts/
├── 00435-contracts-post-award/           # Page-based organization
│   └── correspondence-workflow/          # Workflow-specific subdirs
│       ├── contract_correspondence_analysis.md    # Main agents (7 total)
│       ├── contract_identifier_extraction.md
│       ├── document_retrieval_agent.md
│       ├── domain_specialist_agent.md
│       ├── contract_management_agent.md
│       ├── human_review_agent.md
│       └── professional_formatting_agent.md
│       └── specialists/                          # Specialist categorization
│           ├── architectural.md
│           ├── civil.md
│           ├── construction.md
│           ├── electrical.md
│           ├── environmental.md
│           ├── geotechnical.md
│           ├── health.md
│           ├── inspection.md
│           ├── instrumentation.md
│           ├── logistics.md
│           ├── mechanical.md
│           ├── process.md
│           ├── quality_control.md
│           ├── quantity_surveying.md
│           ├── safety.md
│           ├── scheduling.md
│           └── structural.md          # (17 total specialists)
└── [other-pages]/                            # Future page workflows
```

### **Correspondence Agent Integration Status**
**✅ FULLY INTEGRATED**: All 7 segregated correspondence agents successfully integrated with enhanced prompts service:

1. **Agent 01** (`agent_correspondence_01_document_analysis`) - Document Analysis Agent
2. **Agent 02** (`agent_correspondence_02_identifier_extraction`) - Information Extraction Agent
3. **Agent 03** (`agent_correspondence_03_document_retrieval`) - Document Retrieval Agent
4. **Agent 04** (`agent_correspondence_04_domain_specialist`) - Domain Specialist Agent
5. **Agent 05** (`agent_correspondence_05_contract_management`) - Contract Management Agent
6. **Agent 06** (`agent_correspondence_06_human_review`) - Human Review Agent
7. **Agent 07** (`agent_correspondence_07_professional_formatting`) - Professional Formatting Agent

**Integration Features Enabled:**
- Hierarchical prompt file search across page and workflow directories
- Development mode overrides for all 7 agents
- Hot reloading for rapid prompt iteration
- Complete streaming audit trails with full prompt content
- Validation and quality assurance for all agent prompts
- Database synchronization with local development overrides

### **Prompt Metadata Standards**
All prompts include comprehensive metadata for cross-referencing:

```yaml
---
supabase_table: prompts                    # Database table reference
supabase_key: contract_correspondence_analysis  # Exact key used for retrieval
workflow: 00435-correspondence-orchestration    # Workflow context
agent_sequence: 01                          # Agent execution order
page_id: 00435                             # Page identifier
category: contracts                         # Content category
agent_type: correspondence                  # Agent classification
---
```

### **Development Workflow Integration**

#### **Rapid Prompt Iteration**
```javascript
// Enhanced service automatically finds prompts hierarchically
const result = await enhancedPromptsService.getPromptByKey('contract_correspondence_analysis', {
  onProgress: (step, message, data) => {
    console.log(`📊 Progress: ${message}`);
  }
});

// Returns full prompt with metadata and validation
{
  success: true,
  content: "...",           // Full prompt content
  source: "local_override", // or "database"
  metadata: {               // Complete audit trail
    correlationId: "...",
    retrievalTime: 45,
    validationResult: {...}
  }
}
```

#### **Hot Reload Development**
```javascript
// File watching for instant prompt updates
// Edit prompts in IDE, see changes immediately in application
// Automatic cache invalidation and event emission
```

### **Quality Assurance**
- **Automatic Validation**: Content quality scoring and error detection
- **Security Checks**: API key and sensitive data detection
- **Structure Validation**: Required sections and formatting verification
- **Performance Monitoring**: Retrieval time and success metrics

### **Cross-References**
- **`docs/procedures/0000_PROMPT_MANAGEMENT_PROCEDURE.md`** → Complete framework documentation
- **`client/src/common/js/services/enhancedPromptsService.js`** → Service implementation
- **`docs/dev-workflow/`** → Development workflow tools

## 🔧 **DEEP AGENTS DEPLOYMENT & DEVELOPMENT**

### **Deep Agents Environment Setup**

**MANDATORY**: For complex multi-agent workflows requiring deep agent architectures, set up the Python deep agents environment.

#### **Environment Installation Steps**

1. **Create Python Virtual Environment**
   ```bash
   python3 -m venv deep-agents-env
   source deep-agents-env/bin/activate  # Linux/Mac
   # or deep-agents-env\Scripts\activate  # Windows
   ```

2. **Install Deep Agents Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Configure Environment Variables**
   ```bash
   # Create .env file in project root
   OPENAI_API_KEY=your_openai_key
   ANTHROPIC_API_KEY=your_anthropic_key
   GOOGLE_API_KEY=your_google_key
   SUPABASE_URL=your_supabase_url
   SUPABASE_SERVICE_ROLE_KEY=your_service_key
   ```

#### **Required Dependencies (requirements.txt)**
```txt
langchain>=0.2.0
langchain-core>=0.2.0
langchain-community>=0.2.0
langchain-openai>=0.1.0
langchain-anthropic>=0.1.0
langchain-google-genai>=1.0.0
langchain-mistralai>=0.1.0
langgraph>=0.1.0
langsmith>=0.1.0
python-dotenv>=1.0.0
openai>=1.0.0
anthropic>=0.30.0
google-generativeai>=0.8.0
mistralai>=0.4.0
faiss-cpu>=1.7.0
chromadb>=0.4.0
pypdf>=4.0.0
docx2txt>=0.8
python-multipart>=0.0.6
uvicorn>=0.30.0
fastapi>=0.115.0
pydantic>=2.0.0
supabase>=2.0.0
```

#### **Deep Agent Architecture Patterns**

**Supervisor-Sub-Agent Pattern**:
```python
class ConstructionDeepAgent:
    def __init__(self):
        self.supervisor_llm = ChatOpenAI(model="gpt-4o")
        self.sub_agents = {
            "document_analysis": DocumentAnalysisAgent(),
            "compliance_validation": ComplianceValidationAgent(),
            "quantity_estimation": QuantityEstimationAgent()
        }

    async def process_workflow(self, input_data):
        # Phase 1: Sub-agent processing
        analysis = await self.sub_agents["document_analysis"].analyze(input_data)
        compliance = await self.sub_agents["compliance_validation"].validate(input_data)
        quantities = await self.sub_agents["quantity_estimation"].estimate(input_data)

        # Phase 2: Supervisor synthesis
        synthesis = await self._supervisor_synthesis({
            "analysis": analysis,
            "compliance": compliance,
            "quantities": quantities
        })

        return synthesis
```

**LangGraph Workflow Pattern**:
```python
def create_construction_workflow():
    workflow = StateGraph(ConstructionState)

    # Add specialized nodes
    workflow.add_node("analyze_docs", analyze_documents)
    workflow.add_node("validate_compliance", validate_compliance)
    workflow.add_node("estimate_quantities", estimate_quantities)
    workflow.add_node("supervisor_synthesis", supervisor_synthesis)

    # Define workflow edges
    workflow.add_edge(START, "analyze_docs")
    workflow.add_edge("analyze_docs", "validate_compliance")
    workflow.add_edge("validate_compliance", "estimate_quantities")
    workflow.add_edge("estimate_quantities", "supervisor_synthesis")
    workflow.add_edge("supervisor_synthesis", END)

    return workflow.compile()
```

#### **Deep Agent Usage Guidelines**

**When to Use Deep Agents**:
- ✅ **Complex Multi-Step Tasks**: End-to-end processes requiring dynamic planning
- ✅ **Context Overload**: Documents exceeding 4k token windows
- ✅ **Sub-Agent Delegation**: Specialized functions (compliance, logistics, safety)
- ✅ **Long-Running Persistence**: Sessions spanning multiple interactions
- ✅ **Parallel Processing**: 17+ sub-agents with independent execution

**Performance Considerations**:
- **Memory Management**: Use streaming for large document processing
- **Rate Limiting**: Implement API call throttling
- **Caching**: Cache vector search results
- **Error Handling**: Graceful fallback to simpler agents

### **Deep Agents Integration with Node.js System**

**Hybrid Architecture Pattern**:
```javascript
// Node.js orchestrates Python deep agents
class DeepAgentOrchestrator {
  async processComplexWorkflow(workflowData) {
    // Check if deep agents are needed
    if (this.requiresDeepAgents(workflowData)) {
      // Call Python deep agent service
      const result = await this.callPythonDeepAgent(workflowData);
      return result;
    } else {
      // Use standard Node.js agents
      return await this.processStandardWorkflow(workflowData);
    }
  }

  async callPythonDeepAgent(data) {
    // HTTP call to Python FastAPI service
    const response = await fetch('http://localhost:8000/deep-agent/process', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });
