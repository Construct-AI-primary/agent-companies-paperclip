---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/ai-ml
gigabrain_tags: procedures, ai-ml, codebase
documentation
openstinger_context: operational-procedures, ai-ml-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# 0000_PROMPT_MANAGEMENT_PROCEDURE.md - Prompt Management Procedure - Construct AI System

## Document Usage Guide

**🎯 This Document's Role**: Comprehensive procedure for managing, documenting, and maintaining AI prompts across all agent systems in the ConstructAI platform. **Use this FIRST** when creating, updating, or documenting prompts for any AI agent implementation.

**📚 Related Documents in Documentation Ecosystem:**
- **`docs/pages-agents/shared-agent-architecture.md`** → **REQUIRED REFERENCE** for agent architecture implementation details
- **`0000_PROCEDURES_GUIDE.md`** → Go here for navigation index and procedure selection
- **`0000_WORKFLOW_DOCUMENTATION_PROCEDURE.md`** → General workflow documentation standards

---

## Overview

This comprehensive procedure establishes standards and workflows for the complete lifecycle management of AI prompts across all ConstructAI agent systems. The prompt management framework ensures consistency, quality, versioning, and maintainability of prompts used by correspondence agents, workflow agents, and specialized AI systems.

### **Current Implementation Status**

**✅ ENHANCED PROMPT MANAGEMENT FRAMEWORK ACTIVE & FULLY FUNCTIONAL**

The ConstructAI system now implements an **Enhanced Prompt Management Framework** that provides scalable, hierarchical prompt organization with development mode overrides, hot reloading, validation, and comprehensive auditing.

#### **Recent Critical Fix Applied**
**FIXED 2026-02-01**: Added missing export statement to `enhancedPromptsService.js`, resolving import failures that prevented all agents from retrieving prompts. The service now properly exports a singleton instance with automatic environment detection.

#### **Correspondence Agent Integration Status**
**✅ FULLY INTEGRATED & OPERATIONAL**: All 7 segregated correspondence agents successfully integrated with enhanced prompts service:

1. **Agent 01** (`agent_correspondence_01_document_analysis`) - Document Analysis Agent
2. **Agent 02** (`agent_correspondence_02_identifier_extraction`) - Information Extraction Agent
3. **Agent 03** (`agent_correspondence_03_document_retrieval`) - Document Retrieval Agent
4. **Agent 04** (`agent_correspondence_04_domain_specialist`) - Domain Specialist Agent
5. **Agent 05** (`agent_correspondence_05_contract_management`) - Contract Management Agent
6. **Agent 06** (`agent_correspondence_06_human_review`) - Human Review Agent
7. **Agent 07** (`agent_correspondence_07_professional_formatting`) - Professional Formatting Agent

#### **Directory Structure**
```
docs/dev-prompts/
├── 00435-contracts-post-award/           # Page-based organization
│   └── correspondence-workflow/          # Workflow-specific subdirs
│       ├── agent_correspondence_01_document_analysis.md    # System + User prompts
│       ├── agent_correspondence_02_identifier_extraction.md
│       ├── agent_correspondence_03_document_retrieval.md
│       ├── agent_correspondence_04_domain_specialist.md
│       ├── agent_correspondence_05_contract_management.md
│       ├── agent_correspondence_06_human_review.md
│       ├── agent_correspondence_07_professional_formatting.md
│       └── specialists/                          # Specialist categorization
│           ├── specialist_discipline_civil.md   # (17 total specialists)
│           ├── specialist_discipline_structural.md
│           ├── specialist_discipline_mechanical.md
│           └── ... (14 more discipline specialists)
├── 01900-procurement/                      # Future page workflows
│   └── supplier-workflow/
└── shared/                                 # Cross-page reusable prompts
    └── common_business_rules.md
```

#### **Enhanced MD File Structure (2026-01-05)**
**MODULAR SYSTEM PROMPT + USER CUSTOMIZATION SEPARATION**

Each prompt file now follows a standardized structure separating locked system prompts from customizable user prompts:

```markdown
---
# METADATA HEADER (YAML Front Matter)
prompt_key: "agent_correspondence_01_document_analysis"
category: "contracts"
agent_type: "correspondence"
version: "1.0.0"
created_date: "2026-01-05"
author: "Construct AI Team"
status: "active"
tags: ["correspondence:agent:segregated"]
---

# 🔒 SYSTEM PROMPT (CORE INSTRUCTIONS - LOCKED)
[Fundamental agent identity, security requirements, core capabilities]
[Cannot be modified by end users - system-level instructions]

---
# 🔧 USER PROMPT (CUSTOMIZABLE BUSINESS RULES)
[Editable formatting preferences, business logic, examples]
[User can modify for specific business needs and workflows]
---
```

#### **Integration Features Enabled**
- ✅ **Hierarchical prompt file search** across page and workflow directories
- ✅ **Development mode overrides** for all 7 agents with automatic detection
- ✅ **Hot reloading** capability for rapid prompt iteration
- ✅ **Complete streaming audit trails** with full prompt content transparency
- ✅ **Validation and quality assurance** for all agent prompts
- ✅ **Database synchronization** with local development overrides
- ✅ **Seamless dev→production migration** with environment detection

## 🎯 **SCOPE & OBJECTIVES**

### **Applicable Systems**
- **All AI Agents**: Correspondence agents, workflow agents, specialized discipline agents
- **Prompt Categories**: Contracts, procurement, governance, technical disciplines, general AI interactions
- **Agent Types**: Correspondence reply agents, workflow orchestration agents, specialist consultation agents
- **Integration Points**: PromptsService, agent configurations, database storage, version control

### **Key Objectives**
1. **Standardized Prompt Creation**: Consistent format and structure across all agent prompts
2. **Version Control & Auditing**: Complete history tracking and change management
3. **Quality Assurance**: Validation, testing, and approval workflows for prompt changes
4. **Cross-Agent Consistency**: Reusable prompt components and standardized terminology
5. **Performance Optimization**: Prompt tuning and effectiveness monitoring
6. **Security & Compliance**: Safe prompt handling and regulatory compliance
7. **Agent Documentation**: Each agent must have detailed implementation documentation in `/docs/pages-agents/` following standardized naming conventions

## 📋 **PROMPT MANAGEMENT FRAMEWORK**

### **🎯 Recent Implementation Updates (2026-01-05)**

#### **✅ Prompt Viewing Modal Implementation**
**COMPLETED**: Integrated prompt viewing functionality directly into correspondence agent modals with system/user prompt separation.

**Key Features Added:**
- **🪄 Magic Wand Button**: Top-right modal button for prompt access
- **🔒 System Prompts**: Locked core instructions (read-only)
- **🔧 User Prompts**: Customizable business rules (editable)
- **📋 Agent Selector**: Dropdown for all 7 correspondence agents
- **🎯 Contextual Access**: Prompts viewable during correspondence processing

**Technical Implementation:**
```javascript
// Added to 00435-03-CorrespondenceReplyModal.js
const [showPromptViewer, setShowPromptViewer] = useState(false);
const [agentPrompts, setAgentPrompts] = useState({});
const [selectedAgent, setSelectedAgent] = useState(null);

// Magic wand button with toggle functionality
<button onClick={() => setShowPromptViewer(!showPromptViewer)}>
  🪄 {showPromptViewer ? 'Hide' : 'View'} Prompts
</button>
```

#### **✅ Chat Streaming Cleanup**
**COMPLETED**: Removed prompt display from chat streaming to maintain clean user interface.

**Changes Made:**
- **Removed Audit Messages**: Eliminated prompt content display in agent completion streaming
- **Clean Chat Interface**: Prompts no longer clutter correspondence processing chat
- **Dedicated Access**: Prompt viewing now available through modal interface only

**Code Updates:**
```javascript
// Removed from orchestrator agent completion streaming:
// auditMessage += `📝 **AUDIT: Actual Prompt Retrieved from Supabase Database:**\n\n`;
// auditMessage += `--- PROMPT CONTENT ---\n\n`;
// auditMessage += `${lastPrompt}\n\n`;
// etc.
```

#### **✅ Enhanced MD File Structure**
**IMPLEMENTED**: Modular prompt system with system/user separation for better maintainability.

**New MD Structure:**
```markdown
---
prompt_key: "agent_correspondence_01_document_analysis"
category: "contracts"
agent_type: "correspondence"
version: "1.0.0"
created_date: "2026-01-05"
author: "Construct AI Team"
status: "active"
tags: ["correspondence:agent:segregated"]
---

# 🔒 SYSTEM PROMPT (CORE)
[Locked agent identity and fundamental instructions]

---
# 🔧 USER PROMPT (CUSTOMIZABLE)
[Editable business rules, formatting preferences, examples]
---
```

### **Agent Documentation Requirements**

#### **Mandatory Agent Documentation Files**
**Each AI agent must have comprehensive implementation documentation** created in `/docs/pages-agents/` following standardized naming conventions and using `1300_00435_AGENT_CORRESPONDENCE_REPLY_PROCEDURE.md` as the template guide.

#### **Required Documentation Structure:**
```markdown
# [PAGE_ID]_AGENT_[AGENT_NAME]_PROCEDURE.md - [Agent Display Name] Procedure

## Document Usage Guide
[Purpose and scope of the agent]

## Overview
[Agent functionality and integration details]

## Database Keys and Prompt Retrieval
[Complete prompt keys and retrieval mechanisms]

## [Agent-Specific Sections]
[Implementation details, workflows, security, etc.]

## Success Metrics
[Performance and quality benchmarks]
```

#### **Naming Convention:**
- **Format**: `[PAGE_ID]_AGENT_[AGENT_NAME]_PROCEDURE.md`
- **Examples**:
  - `1300_00435_AGENT_CORRESPONDENCE_REPLY_PROCEDURE.md`
  - `1300_00436_AGENT_DOCUMENT_ANALYSIS_PROCEDURE.md`
  - `1300_00437_AGENT_SPECIALIST_CONSULTATION_PROCEDURE.md`

#### **Documentation Requirements Checklist:**
- [ ] **Unique Agent Details**: Complete implementation specifications
- [ ] **Prompt Integration**: All prompt keys and usage patterns
- [ ] **Security Controls**: Agent-specific access and audit requirements
- [ ] **Performance Benchmarks**: Response times and quality metrics
- [ ] **Error Handling**: Agent-specific failure modes and recovery
- [ ] **Testing Procedures**: Validation and integration testing requirements
- [ ] **Cross-References**: Links to related agents and procedures

### **Prompt Key Naming Convention**

#### **Hierarchical Naming Convention: `{category}_{subcategory}_{specific}_{variant}`**

Implemented standardized naming convention for prompt keys to ensure scalability and consistency across 1000s of prompts:

```
{category}_{subcategory}_{specific}_{variant}
```

#### **Examples:**
- `agent_correspondence_01_document_analysis` - Correspondence agent 01 document analysis
- `specialist_discipline_civil` - Civil engineering specialist
- `agent_safety_image_analysis_default` - Safety image analysis agent default prompt

#### **Naming Convention Rules:**
- **Always lowercase**: All keys must be lowercase for consistency
- **Underscore separation**: Use underscores, never spaces or other characters
- **Hierarchical structure**: Category → Subcategory → Specific → Variant
- **No special characters**: Only letters, numbers, and underscores allowed
- **Descriptive but concise**: Clear meaning without being overly long

#### **Category Types:**
- `agent_*`: Agent-specific prompts (correspondence, workflow, specialist)
- `specialist_*`: Discipline specialist prompts
- `function_*`: Functional prompts (analysis, generation, validation)
- `system_*`: System-level prompts (error handling, formatting)

#### **Correspondence Agent Keys:**
```
agent_correspondence_{agent_id}_{purpose}
```
- `agent_correspondence_01_document_analysis`
- `agent_correspondence_02_identifier_extraction`
- `agent_correspondence_03_document_retrieval`
- `agent_correspondence_04_domain_specialist`
- `agent_correspondence_05_contract_management`
- `agent_correspondence_06_human_review`
- `agent_correspondence_07_professional_formatting`

#### **Discipline Specialist Keys:**
```
specialist_discipline_{discipline_name}
```
- `specialist_discipline_civil`
- `specialist_discipline_structural`
- `specialist_discipline_mechanical`
- `specialist_discipline_electrical`

### **Prompt Categorization System**

#### **Hierarchical Tagging Convention: `domain:function:variant`**

Implemented standardized tagging system for scalable prompt management:

```
domain:function:variant
```

#### **Examples:**
- `correspondence:agent:segregated` - All segregated correspondence agents
- `correspondence:analysis:document` - Document analysis functions
- `agent:order:01` - First agent in workflow sequence

#### **Current Implementation:**
- **Correspondence Agents**: 7 segregated prompts with `correspondence:agent:segregated` + specific function tags
- **Filtering**: Easy wildcard filtering (e.g., `correspondence:*`, `agent:order:*`)
- **Scalability**: Hierarchical structure supports unlimited prompt expansion

### **Prompt Lifecycle Stages**

```
1. PLANNING → 2. CREATION → 3. VALIDATION → 4. TESTING → 5. APPROVAL → 6. DEPLOYMENT → 7. MONITORING → 8. OPTIMIZATION
```

#### **Stage 1: Planning**
- Define prompt purpose and scope
- Identify target agent and use case
- Determine prompt complexity and dependencies
- Plan testing and validation approach

#### **Stage 2: Creation**
- Write initial prompt content
- Apply standardized structure and formatting
- Include required metadata and context
- Implement security and compliance controls

#### **Stage 3: Validation**
- Syntax and structure validation
- Content quality and clarity checks
- Consistency with existing prompts
- Security and compliance review

#### **Stage 4: Testing**
- Unit testing with sample inputs
- Integration testing with target agents
- Performance and response quality testing
- Edge case and error handling validation

#### **Stage 5: Approval**
- Peer review by domain experts
- Security and compliance approval
- Performance benchmark validation
- Final quality assurance sign-off

#### **Stage 6: Deployment**
- Database insertion with proper versioning
- Configuration updates for affected agents
- Documentation updates and cross-references
- Rollback plan preparation

#### **Stage 7: Monitoring**
- Performance metrics collection
- Usage analytics and effectiveness tracking
- Error rate and failure pattern analysis
- User feedback and satisfaction monitoring

#### **Stage 8: Optimization**
- Performance tuning based on metrics
- Content refinement and improvement
- A/B testing for alternative formulations
- Continuous improvement implementation

## 🔧 **PROMPT CREATION STANDARDS**

### **Standardized Prompt Structure**

#### **Required Components:**
```yaml
# PROMPT METADATA HEADER
---
prompt_key: "unique_identifier"
category: "contracts|procurement|governance|technical"
agent_type: "correspondence|workflow|specialist"
version: "1.0.0"
created_date: "2025-12-31"
author: "Developer Name"
last_modified: "2025-12-31"
approved_by: "Technical Lead"
status: "active|draft|deprecated"
tags: ["domain:function:variant"]
dependencies: ["other_prompt_keys"]
security_level: "public|internal|confidential"
compliance_requirements: ["GDPR", "POPIA", "industry_standards"]
---

# PROMPT CONTENT
## Role Definition
You are [Agent Role], specialized in [specific domain/function].

## Context & Guidelines
[Provide comprehensive context about the domain, objectives, and operational guidelines]

## Task Instructions
[Clear, actionable instructions for the AI agent]

## Output Format
[Specify exact output structure and formatting requirements]

## Quality Standards
[Define success criteria and quality benchmarks]

## Error Handling
[Specify how to handle edge cases and errors]

## Examples
[Provide concrete examples of input/output pairs]
```

### **Prompt Quality Standards**

#### **Content Requirements:**
- **Clarity**: Unambiguous language and instructions
- **Completeness**: All necessary context and information provided
- **Consistency**: Alignment with existing prompt patterns and terminology
- **Actionability**: Clear, executable instructions for the AI agent

#### **Technical Standards:**
- **Security**: No sensitive information or security vulnerabilities
- **Performance**: Optimized for response quality and processing efficiency
- **Scalability**: Adaptable to different contexts and use cases
- **Maintainability**: Clear structure for future updates and modifications

#### **Compliance Standards:**
- **Regulatory**: Meets all applicable data protection and privacy regulations
- **Ethical**: Promotes responsible AI usage and bias mitigation
- **Organizational**: Aligns with company policies and standards
- **Industry**: Follows relevant industry best practices and guidelines

## 🏗️ **DATABASE INTEGRATION**

### **Prompt Storage Schema**

#### **Core Fields:**
```sql
CREATE TABLE prompts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  key text UNIQUE NOT NULL,                    -- Unique identifier (e.g., 'contract_correspondence_analysis')
  name text NOT NULL,                          -- Human-readable name
  content text NOT NULL,                       -- Full prompt content
  category text NOT NULL,                      -- contracts, procurement, governance, etc.
  agent_type text NOT NULL,                    -- correspondence, workflow, specialist
  version text NOT NULL,                       -- Semantic versioning (1.0.0)
  is_active boolean DEFAULT true,              -- Active status flag
  metadata jsonb DEFAULT '{}'::jsonb,          -- Extended metadata
  tags text[] DEFAULT '{}',                    -- Tag array for filtering
  created_by uuid REFERENCES auth.users(id),  -- Creator
  approved_by uuid REFERENCES auth.users(id),  -- Approver
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now()
);
```

#### **Version Control:**
```sql
CREATE TABLE prompt_versions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  prompt_id uuid REFERENCES prompts(id),
  version text NOT NULL,
  content text NOT NULL,
  change_summary text,
  changed_by uuid REFERENCES auth.users(id),
  created_at timestamp with time zone DEFAULT now()
);
```

### **PromptsService Integration**

#### **Core Methods:**
```javascript
class PromptsService {
  // Retrieve active prompt by key
  static async getPromptByKey(key) {
    const { data, error } = await supabase
      .from('prompts')
      .select('*')
      .eq('key', key)
      .eq('is_active', true)
      .single();

    if (error) throw error;
    return data;
  }

  // Retrieve prompts by category
  static async getPromptsByCategory(category) {
    const { data, error } = await supabase
      .from('prompts')
      .select('*')
      .eq('category', category)
      .eq('is_active', true);

    if (error) throw error;
    return data;
  }

  // Retrieve prompt with version history
  static async getPromptWithHistory(key) {
    const { data: prompt, error: promptError } = await supabase
      .from('prompts')
      .select('*')
      .eq('key', key)
      .eq('is_active', true)
      .single();

    if (promptError) throw promptError;

    const { data: versions, error: versionError } = await supabase
      .from('prompt_versions')
      .select('*')
      .eq('prompt_id', prompt.id)
      .order('created_at', { ascending: false });

    if (versionError) throw versionError;

    return { ...prompt, versions };
  }
}
```

## 📊 **QUALITY ASSURANCE FRAMEWORK**

### **Prompt Validation Pipeline**

#### **Automated Validation:**
```javascript
const promptValidationRules = {
  // Structure validation
  structureChecks: {
    hasMetadataHeader: true,
    hasRoleDefinition: true,
    hasTaskInstructions: true,
    hasOutputFormat: true,
    hasExamples: true
  },

  // Content validation
  contentChecks: {
    minimumLength: 500,
    maximumLength: 8000,
    prohibitedTerms: ['confidential', 'secret', 'internal_only'],
    requiredSections: ['role', 'context', 'instructions', 'format']
  },

  // Security validation
  securityChecks: {
    noSensitiveData: true,
    noApiKeys: true,
    noPersonalInfo: true,
    safeInstructions: true
  },

  // Performance validation
  performanceChecks: {
    tokenEfficiency: '> 70%',
    clarityScore: '> 85%',
    actionabilityScore: '> 80%'
  }
};
```

#### **Manual Review Process:**
1. **Peer Review**: Technical peer review by domain experts
2. **Security Review**: Security team validation for vulnerabilities
3. **Compliance Review**: Legal and compliance team approval
4. **Performance Review**: QA team validation of effectiveness

### **Testing Framework**

#### **Prompt Testing Categories:**
- **Unit Testing**: Individual prompt validation with sample inputs
- **Integration Testing**: End-to-end agent workflow testing
- **Performance Testing**: Response quality and processing time validation
- **Regression Testing**: Impact assessment on existing functionality

#### **Test Case Structure:**
```javascript
const promptTestCases = {
  promptKey: 'contract_correspondence_analysis',
  testCases: [
    {
      input: 'Sample correspondence text...',
      expectedOutput: {
        structure: 'formal_letter',
        containsSections: ['decision', 'commercial', 'requirements'],
        qualityScore: '> 85%'
      },
      performanceTarget: '< 30 seconds'
    }
  ],
  edgeCases: [
    'Empty input handling',
    'Malformed correspondence',
    'Extremely long documents',
    'Special characters and encoding'
  ]
};
```

## 🔄 **VERSION CONTROL & CHANGE MANAGEMENT**

### **Semantic Versioning**

#### **Version Number Format:**
```
MAJOR.MINOR.PATCH
```

- **MAJOR**: Breaking changes requiring agent reconfiguration
- **MINOR**: New features or significant improvements
- **PATCH**: Bug fixes and minor refinements

#### **Version Update Triggers:**
- **MAJOR**: Changes to output format, required inputs, or core functionality
- **MINOR**: New features, expanded capabilities, or significant content improvements
- **PATCH**: Typos, clarity improvements, or minor optimizations

### **Change Management Process**

#### **Change Request Process:**
1. **Submit Change Request**: Document proposed changes with rationale
2. **Impact Assessment**: Evaluate impact on existing agents and workflows
3. **Testing Plan**: Define testing requirements and validation criteria
4. **Approval Workflow**: Obtain necessary approvals based on impact level

#### **Deployment Process:**
1. **Version Creation**: Create new version with change documentation
2. **Gradual Rollout**: Deploy to staging environment first
3. **Validation Testing**: Comprehensive testing in staging
4. **Production Deployment**: Controlled rollout with monitoring
5. **Rollback Plan**: Prepared rollback procedures and triggers

## 📈 **MONITORING & ANALYTICS**

### **Prompt Performance Metrics**

#### **Core Performance Indicators:**
```javascript
const promptPerformanceMetrics = {
  // Usage Metrics
  usageFrequency: 'requests per hour',
  averageResponseTime: '< 30 seconds',
  cacheHitRate: '> 80%',

  // Quality Metrics
  averageQualityScore: '> 85%',
  userSatisfactionRate: '> 90%',
  errorRate: '< 5%',

  // Efficiency Metrics
  tokenEfficiency: '> 75%',
  costPerRequest: '< $0.10',
  improvementRate: '> 5% monthly'
};
```

#### **Analytics Dashboard**

**Real-time Monitoring:**
- Prompt usage patterns by agent and category
- Response quality trends and degradation alerts
- Performance bottlenecks and optimization opportunities
- Error patterns and failure analysis
- User feedback and satisfaction scores

## 🔒 **SECURITY & COMPLIANCE**

### **Prompt Security Framework**

#### **Access Control:**
```sql
-- Row Level Security for prompts
CREATE POLICY "prompt_access_control" ON prompts
FOR ALL USING (
  -- Public prompts accessible to all authenticated users
  (security_level = 'public' AND auth.jwt() ->> 'role' IS NOT NULL)
  OR
  -- Internal prompts for employees and contractors
  (security_level = 'internal' AND auth.jwt() ->> 'role' IN ('employee', 'contractor'))
  OR
  -- Confidential prompts for authorized personnel only
  (security_level = 'confidential' AND auth.jwt() ->> 'role' IN ('admin', 'security_officer'))
);
```

#### **Audit Logging:**
```sql
CREATE TABLE prompt_audit_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  prompt_id uuid REFERENCES prompts(id),
  action text NOT NULL,                          -- create, update, delete, access
  user_id uuid REFERENCES auth.users(id),
  old_values jsonb,
  new_values jsonb,
  ip_address inet,
  user_agent text,
  created_at timestamp with time zone DEFAULT now()
);
```

### **Compliance Controls**

#### **Data Protection:**
- **PII Detection**: Automatic scanning for personal identifiable information
- **Content Filtering**: Sensitive term detection and blocking
- **Retention Policies**: Automatic cleanup of deprecated prompts
- **Encryption**: Database-level encryption for sensitive prompts

#### **Regulatory Compliance:**
- **GDPR**: Data minimization and consent management
- **POPIA**: South African privacy regulation compliance
- **Industry Standards**: Domain-specific regulatory requirements
- **Audit Trails**: Complete change history and access logging

## 🧪 **IMPLEMENTATION WORKFLOW**

### **Phase 1: Prompt Planning**

#### **Step 1.1: Define Prompt Requirements**
```javascript
const promptRequirements = {
  purpose: 'Document analysis for correspondence agents',
  targetAgent: 'CorrespondenceAnalysisAgent',
  category: 'contracts',
  complexity: 'high', // low, medium, high
  dependencies: ['contract_identifier_extraction'],
  securityLevel: 'internal',
  performanceTarget: '< 30 seconds',
  qualityTarget: '> 85%'
};
```

#### **Step 1.2: Create Prompt Specification**
```javascript
const promptSpecification = {
  key: 'contract_correspondence_analysis',
  name: 'Contract Correspondence Analysis',
  description: 'Analyzes contractual correspondence for key information extraction',
  inputFormat: 'Plain text correspondence document',
  outputFormat: 'Structured JSON with analysis results',
  successCriteria: [
    'Accurate information extraction',
    'Proper categorization',
    'Complete context preservation'
  ]
};
```

### **Phase 2: Prompt Development**

#### **Step 2.1: Write Initial Prompt**
```javascript
const initialPrompt = `# Contract Correspondence Analysis Agent

## Role Definition
You are a specialized Contract Correspondence Analysis Agent with expertise in analyzing contractual correspondence and extracting key information for decision-making.

## Context & Guidelines
You will receive correspondence related to contracts, agreements, and legal documents. Your task is to analyze the content, extract relevant information, and provide structured insights for further processing.

## Task Instructions
1. Read and analyze the provided correspondence
2. Extract key information including parties, dates, amounts, and requirements
3. Identify the type and purpose of the correspondence
4. Assess urgency and priority level
5. Provide clear, actionable insights

## Output Format
Return a JSON object with the following structure:
{
  "analysis": {
    "type": "string",
    "purpose": "string",
    "urgency": "high|medium|low",
    "parties": ["array of parties"],
    "key_dates": ["array of important dates"],
    "financial_impacts": ["array of financial elements"],
    "requirements": ["array of action items"]
  },
  "confidence": "number between 0-1",
  "recommendations": ["array of recommendations"]
}

## Quality Standards
- Accuracy: Extract information with high precision
- Completeness: Capture all relevant details
- Clarity: Provide clear, unambiguous analysis
- Actionability: Include specific recommendations

## Error Handling
If the correspondence is unclear or incomplete:
- Request clarification on ambiguous sections
- Flag uncertain information
- Provide best-effort analysis with confidence scores

## Examples

Input: "Please provide updated contract terms for the Q4 delivery schedule..."

Output:
{
  "analysis": {
    "type": "contract_modification_request",
    "purpose": "Schedule and terms update",
    "urgency": "medium",
    "parties": ["Client", "Contractor"],
    "key_dates": ["Q4 2025"],
    "financial_impacts": [],
    "requirements": ["Review current contract", "Prepare updated terms", "Schedule negotiation meeting"]
  },
  "confidence": 0.95,
  "recommendations": ["Forward to contract management team", "Schedule review meeting within 5 business days"]
}`;
```

#### **Step 2.2: Apply Standardized Formatting**
```javascript
const formattedPrompt = applyStandardFormatting(initialPrompt, {
  includeMetadata: true,
  addQualityChecks: true,
  validateStructure: true
});
```

### **Phase 3: Validation & Testing**

#### **Step 3.1: Automated Validation**
```javascript
const validationResults = await validatePrompt(formattedPrompt, promptValidationRules);

if (!validationResults.isValid) {
  console.error('Prompt validation failed:', validationResults.errors);
  return;
}
```

#### **Step 3.2: Manual Review Process**
```javascript
// Submit for peer review
const reviewRequest = await submitForReview(formattedPrompt, {
  reviewers: ['domain_expert', 'security_officer', 'qa_lead'],
  reviewType: 'technical_and_security',
  deadline: '2025-12-31'
});
```

#### **Step 3.3: Testing Execution**
```javascript
const testResults = await executePromptTests(formattedPrompt, testCases);

if (testResults.passRate < 0.85) {
  console.error('Prompt testing failed:', testResults.failures);
  return;
}
```

### **Phase 4: Approval & Deployment**

#### **Step 4.1: Approval Workflow**
```javascript
const approvalResults = await executeApprovalWorkflow(formattedPrompt, {
  approvalChain: ['technical_lead', 'security_officer', 'product_owner'],
  requiredApprovals: 3,
  timeout: 7 * 24 * 60 * 60 * 1000 // 7 days
});
```

#### **Step 4.2: Database Deployment**
```javascript
const deploymentResult = await deployPrompt(formattedPrompt, {
  version: '1.0.0',
  environment: 'staging',
  rollbackEnabled: true,
  monitoringEnabled: true
});
```

#### **Step 4.3: Production Rollout**
```javascript
const rolloutResult = await productionRollout(deploymentResult.promptId, {
  rolloutStrategy: 'gradual',
  monitoringPeriod: 24 * 60 * 60 * 1000, // 24 hours
  rollbackTriggers: {
    errorRateThreshold: 0.05,
    performanceDegradation: 0.20
  }
});
```

## 📋 **COMPLIANCE CHECKLIST**

### **Prompt Creation Checklist**
- [ ] Requirements clearly defined and documented
- [ ] Standardized structure and formatting applied
- [ ] Security and compliance requirements identified
- [ ] Dependencies and relationships documented
- [ ] Testing strategy defined and implemented

### **Validation Checklist**
- [ ] Automated validation rules passed
- [ ] Manual peer review completed
- [ ] Security assessment conducted
- [ ] Performance benchmarks met
- [ ] Integration testing successful

### **Approval Checklist**
- [ ] Technical lead approval obtained
- [ ] Security officer approval obtained
- [ ] Domain expert review completed
- [ ] Quality assurance sign-off received
- [ ] Change management approval granted

### **Deployment Checklist**
- [ ] Staging deployment successful
- [ ] Production readiness verified
- [ ] Rollback procedures documented
- [ ] Monitoring and alerting configured
- [ ] User communication prepared

## 🔗 **CROSS-REFERENCES**

### **Core AI & Agent Procedures**
- **[docs/pages-agents/shared-agent-architecture.md](../pages-agents/shared-agent-architecture.md)**: Agent architecture implementation details
- **[0000_AGENT_ROLES_IMPLEMENTATION_PROCEDURE.md](../procedures/0000_AGENT_ROLES_IMPLEMENTATION_PROCEDURE.md)**: Agent security and discipline confinement
- **[1300_00435_AGENT_CORRESPONDENCE_REPLY_PROCEDURE.md](../pages-agents/1300_00435_AGENT_CORRESPONDENCE_REPLY_PROCEDURE.md)**: Complete agent implementation example

### **Workflow & HITL Integration**
- **[0000_WORKFLOW_HITL_PROCEDURE.md](../procedures/0000_WORKFLOW_HITL_PROCEDURE.md)**: Human-in-the-loop workflow management
- **[0000_WORKFLOW_TASK_PROCEDURE.md](../procedures/0000_WORKFLOW_TASK_PROCEDURE.md)**: Task execution and workflow states
- **[0000_WORKFLOW_OPTIMIZATION_GUIDE.md](../procedures/0000_WORKFLOW_OPTIMIZATION_GUIDE.md)**: Performance optimization frameworks
- **[0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md](../procedures/0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md)**: Complete workflow implementation framework

### **AI Service & Model Management**
- **[0000_QWEN_FINETUNING_PROCEDURE.md](../procedures/0000_QWEN_FINETUNING_PROCEDURE.md)**: QWEN fine-tuning for agent model optimization
- **[0000_HIERARCHICAL_AI_CONFIG.md](../procedures/0000_HIERARCHICAL_AI_CONFIG.md)**: AI configuration hierarchy management
- **[0000_API_KEY_SECURITY_MIGRATION_PROCEDURE.md](../procedures/0000_API_KEY_SECURITY_MIGRATION_PROCEDURE.md)**: Secure AI service API key management
- **[0000_CHATBOT_MASTER_PROCEDURE.md](../procedures/0000_CHATBOT_MASTER_PROCEDURE.md)**: Chatbot implementation and AI service integration

### **Quality Assurance & Testing**
- **[0000_TESTING_WORKFLOW_PROCEDURE.md](../procedures/0000_TESTING_WORKFLOW_PROCEDURE.md)**: Complete testing framework for workflows
- **[1300_00000_ERROR_TRACKING_ALL.md](../error-tracking/1300_00000_ERROR_TRACKING_ALL.md)**: Error tracking and agent performance monitoring
- **[0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md](../procedures/0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md)**: System troubleshooting framework

### **Database & Security Operations**
- **[0000_SQL_EXECUTION_PROCEDURE.md](../procedures/0000_SQL_EXECUTION_PROCEDURE.md)**: Database operations for prompt storage
- **[0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md](../procedures/0000_JAVASCRIPT_DATA_POPULATION_PROCEDURE.md)**: Data population scripts for prompt management
- **[0000_PRIVACY_PROCEDURE.md](../procedures/0000_PRIVACY_PROCEDURE.md)**: Privacy compliance for prompt data handling

### **Documentation Standards**
- **[0000_WORKFLOW_DOCUMENTATION_PROCEDURE.md](../procedures/0000_WORKFLOW_DOCUMENTATION_PROCEDURE.md)**: Workflow documentation standards
- **[docs/0000_MASTER_DATABASE_SCHEMA.md](../0000_MASTER_DATABASE_SCHEMA.md)**: Database schema reference
- **[docs/procedures/0000_PROCEDURES_GUIDE.md](../procedures/0000_PROCEDURES_GUIDE.md)**: Procedures navigation guide

## 📈 **SUCCESS METRICS**

### **Prompt Quality Metrics**
- **Creation Success Rate**: >95% of prompts created successfully
- **Validation Pass Rate**: >90% of prompts pass validation on first attempt
- **Approval Timeline**: <7 days average approval time
- **Deployment Success Rate**: >99% successful deployments

### **Runtime Performance Metrics**
- **Average Response Time**: <30 seconds for prompt retrieval and processing
- **Cache Hit Rate**: >80% for frequently used prompts
- **Error Rate**: <2% prompt-related errors
- **User Satisfaction**: >90% user satisfaction with prompt outputs

## 🔧 **DEVELOPMENT MODE ENHANCEMENTS**

### **Local Prompt Development Framework**

**RECOMMENDED**: Implement development mode overrides for efficient prompt iteration and debugging.

#### **Development Prompt Manager**

```javascript
class DevelopmentPromptManager {
  constructor(options = {}) {
    this.devMode = options.devMode || process.env.NODE_ENV === 'development';
    this.localPromptsDir = options.localPromptsDir || path.join(process.cwd(), 'docs', 'dev-prompts');
    this.enableHotReload = options.enableHotReload || false;
    this.cache = new Map();

    if (this.enableHotReload) {
      this.setupHotReload();
    }
  }

  async getPrompt(promptKey, options = {}) {
    if (this.devMode) {
      // Check for local override first
      const localPrompt = await this.getLocalPromptOverride(promptKey);
      if (localPrompt) {
        console.log(`🔧 [DevMode] Using local prompt override: ${promptKey}`);
        return this.enhanceWithDevMetadata(localPrompt, promptKey);
      }
    }

    // Fall back to database retrieval
    return await this.getDatabasePrompt(promptKey, options);
  }

  async getLocalPromptOverride(promptKey) {
    try {
      const filePath = path.join(this.localPromptsDir, `${promptKey}.md`);
      if (fs.existsSync(filePath)) {
        const content = fs.readFileSync(filePath, 'utf8');
        this.cache.set(promptKey, { content, timestamp: Date.now() });
        return content;
      }
    } catch (error) {
      console.warn(`⚠️ Error reading local prompt override ${promptKey}:`, error.message);
    }
    return null;
  }

  async getDatabasePrompt(promptKey, options) {
    // Existing PromptsService.getPromptByKey logic
    const { data, error } = await supabase
      .from('prompts')
      .select('*')
      .eq('key', promptKey)
      .eq('is_active', true)
      .single();

    if (error) throw error;
    return data;
  }

  enhanceWithDevMetadata(promptContent, promptKey) {
    const devHeader = `---\nDEV_MODE: true\nLOCAL_OVERRIDE: ${promptKey}\nTIMESTAMP: ${new Date().toISOString()}\nSOURCE: ${this.localPromptsDir}/${promptKey}.md\n---\n\n`;
    return devHeader + promptContent;
  }

  setupHotReload() {
    const chokidar = require('chokidar');
    const watcher = chokidar.watch(this.localPromptsDir, {
      ignored: /(^|[\/\\])\../, // ignore dotfiles
      persistent: true
    });

    watcher.on('change', (filePath) => {
      const promptKey = path.basename(filePath, '.md');
      console.log(`🔄 [HotReload] Prompt updated: ${promptKey}`);

      // Clear cache for this prompt
      this.cache.delete(promptKey);

      // Emit event for UI updates
      if (typeof window !== 'undefined') {
        window.dispatchEvent(new CustomEvent('promptUpdated', {
          detail: { promptKey, filePath }
        }));
      }
    });

    console.log(`🔥 [HotReload] Watching ${this.localPromptsDir} for prompt changes`);
  }

  async createLocalOverride(promptKey, content, options = {}) {
    const dirPath = this.localPromptsDir;
    const filePath = path.join(dirPath, `${promptKey}.md`);

    // Ensure directory exists
    if (!fs.existsSync(dirPath)) {
      fs.mkdirSync(dirPath, { recursive: true });
    }

    // Add development metadata
    const enhancedContent = this.addDevelopmentMetadata(content, options);

    // Write file
    fs.writeFileSync(filePath, enhancedContent, 'utf8');

    console.log(`💾 [DevMode] Created local prompt override: ${filePath}`);
    return filePath;
  }

  addDevelopmentMetadata(content, options) {
    const metadata = {
      dev_mode: true,
      created: new Date().toISOString(),
      author: options.author || 'developer',
      purpose: options.purpose || 'development_override',
      notes: options.notes || 'Local development override for rapid iteration'
    };

    const metadataBlock = `---\n${Object.entries(metadata)
      .map(([key, value]) => `${key}: ${value}`)
      .join('\n')}\n---\n\n`;

    return metadataBlock + content;
  }

  async syncToDatabase(promptKey, options = {}) {
    const localContent = await this.getLocalPromptOverride(promptKey);
    if (!localContent) {
      throw new Error(`No local override found for ${promptKey}`);
    }

    // Remove development metadata for database storage
    const cleanContent = this.removeDevelopmentMetadata(localContent);

    // Update database
    const result = await this.updateDatabasePrompt(promptKey, cleanContent, {
      version: options.version || 'dev-sync',
      change_summary: options.changeSummary || 'Synced from local development override'
    });

    if (options.deleteLocalAfterSync) {
      const filePath = path.join(this.localPromptsDir, `${promptKey}.md`);
      fs.unlinkSync(filePath);
      console.log(`🗑️ [DevMode] Removed local override after sync: ${filePath}`);
    }

    return result;
  }

  removeDevelopmentMetadata(content) {
    // Remove development metadata blocks
    return content.replace(/^---\n(?:dev_mode|created|author|purpose|notes): .*\n---\n\n/gms, '');
  }

  async updateDatabasePrompt(promptKey, content, options) {
    const updateData = {
      content: content,
      version: options.version,
      updated_at: new Date().toISOString()
    };

    const { data, error } = await supabase
      .from('prompts')
      .update(updateData)
      .eq('key', promptKey)
      .select()
      .single();

    if (error) throw error;

    // Create version record
    await this.createVersionRecord(data.id, options.version, content, options.change_summary);

    console.log(`✅ [DevMode] Synced prompt to database: ${promptKey} v${options.version}`);
    return data;
  }

  async createVersionRecord(promptId, version, content, changeSummary) {
    const { error } = await supabase
      .from('prompt_versions')
      .insert({
        prompt_id: promptId,
        version: version,
        content: content,
        change_summary: changeSummary
      });

    if (error) throw error;
  }
}
```

### **Rapid Prompt Iteration Workflow**

#### **Development Workflow Steps:**

1. **Enable Development Mode**
   ```javascript
   const promptManager = new DevelopmentPromptManager({
     devMode: true,
     enableHotReload: true
   });
   ```

2. **Create Local Prompt Override**
   ```javascript
   // During debugging, quickly create local overrides
   await promptManager.createLocalOverride(
     'agent_correspondence_01_analysis',
     `# Debug Version: Document Analysis Agent

   You are debugging the document analysis agent. Focus on:
   - Extracting sender/recipient information
   - Identifying key issues only
   - Providing basic categorization

   Skip complex validation for now.`,
     {
       purpose: 'debugging_basic_extraction',
       notes: 'Simplified version for rapid testing'
     }
   );
   ```

3. **Iterate with Hot Reload**
   ```javascript
   // File watcher automatically detects changes
   // Edit prompts in your IDE and see changes immediately

   // Manual reload if needed
   await promptManager.clearCache();
   const updatedPrompt = await promptManager.getPrompt('agent_correspondence_01_analysis');
   ```

4. **Test & Validate**
   ```javascript
   // Test with your agent
   const result = await agent.processCorrespondence(testInput, {
     promptManager: promptManager
   });

   // Validate output
   console.log('Test Result:', result);
   ```

5. **Sync to Production**
   ```javascript
   // When ready, sync local changes to database
   await promptManager.syncToDatabase('agent_correspondence_01_analysis', {
     version: '1.1.0',
     changeSummary: 'Enhanced document analysis with improved extraction accuracy',
     deleteLocalAfterSync: true
   });
   ```

### **Development Tools & Utilities**

#### **Prompt Comparison Tool**
```javascript
class PromptComparisonTool {
  static async comparePrompts(promptKey, options = {}) {
    const devManager = new DevelopmentPromptManager({ devMode: true });

    const localPrompt = await devManager.getLocalPromptOverride(promptKey);
    const dbPrompt = await devManager.getDatabasePrompt(promptKey);

    if (!localPrompt || !dbPrompt) {
      console.warn(`Cannot compare - missing ${!localPrompt ? 'local' : 'database'} version`);
      return null;
    }

    const differences = this.calculateDifferences(
      devManager.removeDevelopmentMetadata(localPrompt),
      dbPrompt.content
    );

    return {
      promptKey,
      hasDifferences: differences.length > 0,
      differences,
      localLength: localPrompt.length,
      dbLength: dbPrompt.content.length,
      lastModified: dbPrompt.updated_at
    };
  }

  static calculateDifferences(text1, text2) {
    // Simple diff calculation - in practice, use a proper diff library
    const lines1 = text1.split('\n');
    const lines2 = text2.split('\n');

    const differences = [];
    const maxLines = Math.max(lines1.length, lines2.length);

    for (let i = 0; i < maxLines; i++) {
      if (lines1[i] !== lines2[i]) {
        differences.push({
          line: i + 1,
          local: lines1[i] || '',
          database: lines2[i] || ''
        });
      }
    }

    return differences;
  }
}
```

#### **Bulk Prompt Operations**
```javascript
class BulkPromptOperations {
  static async exportPromptsToLocal(promptKeys, options = {}) {
    const devManager = new DevelopmentPromptManager({ devMode: true });

    for (const promptKey of promptKeys) {
      try {
        const dbPrompt = await devManager.getDatabasePrompt(promptKey);
        if (dbPrompt) {
          await devManager.createLocalOverride(promptKey, dbPrompt.content, {
            purpose: 'bulk_export',
            notes: `Exported from database v${dbPrompt.version}`
          });
          console.log(`📤 Exported: ${promptKey}`);
        }
      } catch (error) {
        console.error(`❌ Failed to export ${promptKey}:`, error.message);
      }
    }
  }

  static async validateLocalPrompts() {
    const devManager = new DevelopmentPromptManager({ devMode: true });
    const localDir = devManager.localPromptsDir;

    if (!fs.existsSync(localDir)) {
      return { valid: [], invalid: [] };
    }

    const files = fs.readdirSync(localDir).filter(f => f.endsWith('.md'));
    const results = { valid: [], invalid: [] };

    for (const file of files) {
      const promptKey = file.replace('.md', '');
      try {
        const content = fs.readFileSync(path.join(localDir, file), 'utf8');

        // Basic validation
        const isValid = this.validatePromptContent(content);

        if (isValid) {
          results.valid.push({ promptKey, file });
        } else {
          results.invalid.push({ promptKey, file, errors: ['Content validation failed'] });
        }
      } catch (error) {
        results.invalid.push({ promptKey, file, errors: [error.message] });
      }
    }

    return results;
  }

  static validatePromptContent(content) {
    // Basic validation rules
    const rules = [
      content.length > 100,  // Minimum length
      content.includes('#'), // Has headers
      !content.includes('undefined'), // No undefined values
      !content.includes('null') // No null values
    ];

    return rules.every(rule => rule);
  }
}
```

### **Development Environment Setup**

#### **VS Code Integration**
```json
// .vscode/settings.json for prompt development
{
  "files.associations": {
    "dev-prompts/*.md": "markdown"
  },
  "markdown.preview.breaks": true,
  "editor.quickSuggestions": {
    "comments": "on",
    "strings": "on",
    "other": "on"
  },
  "files.watcherExclude": {
    "**/node_modules": true,
    "**/.git": "**/node_modules",
    "**/dev-prompts/*.tmp": true
  }
}
```

#### **Git Configuration**
```bash
# .gitignore - Exclude development overrides from version control
dev-prompts/
*.dev.md

# .gitattributes - Treat prompt files appropriately
dev-prompts/*.md linguist-language=Markdown
dev-prompts/*.md linguist-detectable=false
```

### **Development Best Practices**

#### **Prompt Version Control**
- **Local Overrides**: Use `dev-prompts/` for active development
- **Version Numbers**: Use `dev-1.0.0`, `dev-1.0.1` for development versions
- **Change Tracking**: Document changes in override metadata
- **Regular Sync**: Sync significant changes to database frequently

#### **Testing Strategy**
- **Unit Tests**: Test individual prompts with local overrides
- **Integration Tests**: Test agent workflows with development prompts
- **Performance Tests**: Validate prompt efficiency in development
- **Comparison Tests**: Compare local vs database prompt outputs

#### **Collaboration Guidelines**
- **Branch Strategy**: Use feature branches for prompt development
- **Review Process**: Review local overrides before database sync
- **Documentation**: Document significant prompt changes
- **Backup**: Regular backup of working local overrides

## 📞 **SUPPORT & ESCALATION**

### **Implementation Support**
- **Technical Issues**: Contact AI/Agent development team
- **Prompt Creation**: Use prompt creation template and validation tools
- **Debug Workflow Issues**: Use development mode overrides for rapid iteration
- **Performance Issues**: Report to DevOps team for optimization
- **Security Concerns**: Escalate immediately to security team

### **Escalation Path**
1. **Individual Developer**: Initial prompt creation and troubleshooting
2. **Technical Lead**: Code review and architectural guidance
3. **AI/ML Lead**: Prompt-specific technical issues
4. **Engineering Manager**: Cross-team coordination for complex changes
5. **Security Officer**: Security and compliance related issues

---

## 📋 **CROSS-REFERENCE GUIDE: Agent System Documentation**

### 🎯 **Key Reference Points**

| **Prompt Key** | **Agent Code File** | **Prompt MD File** | **API Mapping** | **Browser Mapping** | **Modal Access** |
|---|---|---|---|---|---|
| `agent_correspondence_01_document_analysis` | `correspondence-01-document-analysis-agent.js` | `agent_correspondence_01_document_analysis.md` | ✅ | ✅ | 🪄 |
| `agent_correspondence_02_identifier_extraction` | `correspondence-02-information-extraction-agent.js` | `agent_correspondence_02_identifier_extraction.md` | ✅ | ✅ | 🪄 |
| `agent_correspondence_03_document_retrieval` | `correspondence-03-document-retrieval-agent.js` | `agent_correspondence_03_document_retrieval.md` | ✅ | ✅ | 🪄 |
| `agent_correspondence_04_domain_specialist` | `correspondence-04-domain-specialist-agent.js` | `agent_correspondence_04_domain_specialist.md` | ✅ | ✅ | 🪄 |
| `agent_correspondence_05_contract_management` | `correspondence-05-contract-management-agent.js` | `agent_correspondence_05_contract_management.md` | ✅ | ✅ | 🪄 |
| `agent_correspondence_06_human_review` | `correspondence-06-human-review-agent.js` | `agent_correspondence_06_human_review.md` | ✅ | ✅ | 🪄 |
| `agent_correspondence_07_professional_formatting` | `correspondence-07-professional-formatting-agent.js` | `agent_correspondence_07_professional_formatting.md` | ✅ | ✅ | 🪄 |

### 📁 **File Location Map**

```
📦 Project Root
├── 📁 client/src/pages/00435-contracts-post-award/components/
│   ├── 📁 agents/
│   │   ├── 📄 correspondence-01-document-analysis-agent.js
│   │   ├── 📄 correspondence-02-information-extraction-agent.js
│   │   ├── 📄 correspondence-03-document-retrieval-agent.js
│   │   ├── 📄 correspondence-04-domain-specialist-agent.js
│   │   ├── 📄 correspondence-05-contract-management-agent.js
│   │   ├── 📄 correspondence-06-human-review-agent.js
│   │   └── 📄 correspondence-07-professional-formatting-agent.js
│   │
│   └── 📁 modals/
│       └── 📄 00435-03-CorrespondenceReplyModal.js ← PROMPT VIEWER INTEGRATION
│           ├── 🪄 Magic Wand Button (top-right)
│           ├── 📋 Agent Selector Dropdown
│           ├── 🔒 System Prompts Display (read-only)
│           └── 🔧 User Prompts Display (editable)
│
├── 📁 docs/dev-prompts/00435-contracts-post-award/correspondence-workflow/
│   ├── 📄 agent_correspondence_01_document_analysis.md ← SYSTEM + USER PROMPTS
│   ├── 📄 agent_correspondence_02_identifier_extraction.md
│   ├── 📄 agent_correspondence_03_document_retrieval.md
│   ├── 📄 agent_correspondence_04_domain_specialist.md
│   ├── 📄 agent_correspondence_05_contract_management.md
│   ├── 📄 agent_correspondence_06_human_review.md
│   ├── 📄 agent_correspondence_07_professional_formatting.md
│   └── 📁 specialists/
│       ├── 📄 specialist_discipline_civil.md
│       ├── 📄 specialist_discipline_structural.md
│       └── 📄 ... (14 more discipline specialists)
│
├── 📁 client/src/common/js/services/
│   ├── 📄 enhancedPromptsService.js ← BROWSER MAPPING + API INTEGRATION
│   └── 📄 promptKeyValidator.js ← VALIDATION RULES
│
└── 📁 server/api/prompts/
    └── 📄 local.js ← SERVER API MAPPING + ENDPOINT HANDLING
```

### 🪄 **Prompt Viewer Modal Implementation Details (2026-01-05)**

#### **Modal Integration Architecture**
**Location**: `client/src/pages/00435-contracts-post-award/components/modals/00435-03-CorrespondenceReplyModal.js`

**State Management**:
```javascript
// Added to modal state
const [showPromptViewer, setShowPromptViewer] = useState(false);
const [agentPrompts, setAgentPrompts] = useState({});
const [selectedAgent, setSelectedAgent] = useState(null);
```

**UI Components**:
- **Header Button**: Fixed position top-right with magic wand icon
- **Toggle Section**: Collapsible prompt viewer that doesn't clutter main form
- **Agent Selector**: Dropdown with all 7 correspondence agents
- **Dual Display**: System prompts (🔒 locked) + User prompts (🔧 editable)

#### **API Integration**
**Endpoint**: `GET /api/prompts/:key`
**Response Format**:
```javascript
{
  content: "system prompt content",
  userContent: "user customizations or null",
  metadata: { version, tags, compliance, etc. }
}
```

#### **User Experience Flow**
1. **Access**: Click 🪄 button during correspondence processing
2. **Select**: Choose agent from dropdown (7 available)
3. **View**: See system prompt (locked) and user customizations (editable)
4. **Context**: Understand agent behavior without leaving workflow
5. **Close**: Return to correspondence processing seamlessly

#### **Benefits Delivered**
- ✅ **Transparency**: Users can see exactly what instructions agents follow
- ✅ **Education**: Learn about 7-agent orchestration without technical complexity
- ✅ **Non-intrusive**: Modal integration doesn't disrupt main workflow
- ✅ **Future-ready**: Foundation for user customization features
- ✅ **Clean Interface**: Prompts removed from chat streaming clutter

### 🔧 **Maintenance Checklist**

#### **When Adding a New Agent:**
1. **Create Agent Code**: `client/src/pages/00435-contracts-post-award/components/agents/correspondence-XX-name-agent.js`
2. **Create Prompt MD**: `docs/dev-prompts/00435-contracts-post-award/correspondence-workflow/name_agent.md`
3. **Update Browser Mapping**: `enhancedPromptsService.js` → `promptFileMap`
4. **Update Server Mapping**: `server/api/prompts/local.js` → `keyMappings`
5. **Validate Key**: Use `promptKeyValidator.js` to ensure proper naming

#### **When Modifying a Prompt:**
1. **Edit MD File**: Update the prompt content in `docs/dev-prompts/...`
2. **Test in Dev Mode**: Changes reflect immediately in development
3. **Update Database**: For production, update prompts table in Supabase

#### **When Renaming a Prompt Key:**
1. **Update Agent Code**: Change `getPromptByKey('old_key')` to `getPromptByKey('new_key')`
2. **Update Browser Mapping**: `enhancedPromptsService.js`
3. **Update Server Mapping**: `server/api/prompts/local.js`
4. **Update Database**: Rename key in prompts table
5. **Update Tests**: Any test files referencing the old key

### 🛠️ **Tools for Cross-Referencing**

#### **1. Prompt Key Validator** (`promptKeyValidator.js`)
```javascript
import PromptKeyValidator from './promptKeyValidator.js';
const validator = new PromptKeyValidator();

// Validate a key
const result = validator.validate('agent_correspondence_07_professional_formatting');
// Returns: { isValid: true, category: 'agent', ... }
```

#### **2. Enhanced Prompts Service** (`enhancedPromptsService.js`)
```javascript
import enhancedPromptsService from './enhancedPromptsService.js';

// Get prompt info
const result = await enhancedPromptsService.getPromptByKey('agent_correspondence_07_professional_formatting');
// Returns: { success: true, content: '...', source: 'local_override', ... }
```

#### **3. Manual Verification Script**
```bash
# Check if all mappings are consistent
node -e "
const fs = require('fs');
const path = require('path');

// Read mappings from different files and compare
// This would be a custom script to validate consistency
"
```

### 🚨 **Common Issues & Solutions**

#### **Issue: "Prompt not found" errors**
- **Check**: Is the MD file in the correct location?
- **Check**: Is the mapping updated in both `enhancedPromptsService.js` and `server/api/prompts/local.js`?
- **Check**: Is the prompt key spelled correctly in the agent code?

#### **Issue: Old prompt content still being used**
- **Check**: Clear browser cache (MD files are fetched fresh each time)
- **Check**: Is dev mode enabled? (`NODE_ENV === 'development'`)
- **Check**: Database fallback - disable database prompts for testing

#### **Issue: Mismatched file names**
- **Use**: `promptKeyValidator.js` to ensure consistent naming
- **Pattern**: `agent_{subcategory}_{number}_{purpose}`

### 📊 **Validation Commands**

```bash
# Validate all prompt keys in the system
node -e "
const PromptKeyValidator = require('./client/src/common/js/services/promptKeyValidator.js');
const validator = new PromptKeyValidator();

const keys = [
  'agent_correspondence_01_document_analysis',
  'agent_correspondence_07_professional_formatting',
  // ... all keys
];

const results = validator.validateBatch(keys);
console.log('Valid:', results.valid.length, 'Invalid:', results.invalid.length);
if (results.invalid.length > 0) {
  console.log('Issues found:', results.invalid);
}
"
```

### 🎯 **Quick Reference**

**To find the prompt for an agent:**
1. Look at agent code → find `getPromptByKey('key_name')`
2. Check `enhancedPromptsService.js` → `promptFileMap['key_name']`
3. Find MD file at that path in `docs/dev-prompts/`

**To find the agent for a prompt:**
1. Look at MD file name
2. Find corresponding agent file in `agents/` directory
3. Check that agent calls the correct prompt key

This cross-reference system ensures that all components stay synchronized when making changes to the agent system.

---

**Note**: This procedure establishes the comprehensive framework for managing AI prompts throughout their entire lifecycle. Following these standards ensures consistency, quality, security, and maintainability across all ConstructAI agent systems.
