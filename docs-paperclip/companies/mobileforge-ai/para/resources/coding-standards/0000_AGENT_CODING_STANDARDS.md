---
memory_layer: durable_knowledge
para_section: pages/codebase/coding-standards
gigabrain_tags: coding-standards, codebase, development-practices
documentation
openstinger_context: coding-standards-practices
last_updated: 2026-03-21
related_docs:
  - codebase/coding-standards/
  - disciplines/
---
# Agent Coding Standards for Construct AI Repository

This document outlines the coding standards, architectural patterns, and rules that AI agents should follow when working on this repository.

## Project Overview
Construct AI is a web-based construction management system built with:
- **Frontend**: React.js
- **Backend**: Node.js with Express.js
- **Database**: Supabase (PostgreSQL) with SQLite for local development
- **Authentication**: Custom authentication with dev bypass for development

## Coding Standards

### JavaScript/Node.js
- Use ES6+ syntax (imports/exports, arrow functions, async/await)
- camelCase for variables, functions, and file names
- PascalCase for React components and classes
- Use `const` and `let` instead of `var`
- Descriptive variable and function names
- Add JSDoc comments for complex functions

### File Structure
- Server code in `/server` directory
- Client code in `/client` directory
- Documentation in `/docs` directory
- Database schemas in `/server/sql`
- Routes organized by feature in `/server/src/routes`

### Import/Export
- Use ES6 imports: `import module from 'path'`
- Group imports: standard libraries, third-party, local modules
- Use relative paths with `../` for parent directories
- Export functions/objects at the end of files

### Error Handling
- Use try/catch for async operations
- Log errors with context
- Return appropriate HTTP status codes
- Use middleware for centralized error handling

### Database
- Use parameterized queries to prevent SQL injection
- Follow naming conventions: snake_case for columns, camelCase for JS
- Include foreign key constraints
- Add indexes for frequently queried columns

### API Design
- RESTful endpoints with consistent naming
- Use HTTP methods appropriately (GET, POST, PUT, DELETE)
- Include request logging middleware
- Health check endpoint at `/health`
- Version API endpoints when needed

### Security
- Validate user input
- Use authentication middleware
- Sanitize database inputs
- Log security events

### Testing
- Write unit tests for utility functions
- Integration tests for API endpoints
- Use descriptive test names
- Mock external dependencies

## Architectural Patterns

### Express Server
- Modular router structure
- Middleware for cross-cutting concerns
- Static file serving for client build
- SPA fallback routing

### React Frontend
- Component-based architecture
- Use hooks for state management
- Consistent CSS class naming
- Responsive design principles

### Database Design
- Normalized schema with foreign keys
- Multi-tenant support with organization_id
- Audit trails for important changes
- Migration scripts for schema changes

## Development Workflow

### Git
- Use descriptive commit messages
- Branch naming: feature/, bugfix/, hotfix/
- Pull requests for code review
- Squash merges for clean history

### Environment
- Use `.env` files for configuration
- Separate dev/prod environments
- Document environment variables

### Deployment
- Build client for production
- Minify and optimize assets
- Health checks for monitoring
- Rollback procedures

## AI Agent Guidelines

### Prompt Key Naming Convention

All AI agent prompt keys must follow the standardized hierarchical naming convention for scalability and consistency:

```
{category}_{subcategory}_{specific}_{variant}
```

#### Naming Convention Rules:
- **Always lowercase**: All keys must be all lowercase
- **Underscore separation**: Use underscores, never spaces or other characters
- **Hierarchical structure**: Category → Subcategory → Specific → Variant
- **No special characters**: Only letters, numbers, and underscores allowed
- **Descriptive but concise**: Clear meaning without being overly long

#### Category Types:
- `agent_*`: Agent-specific prompts (correspondence, workflow, specialist)
- `specialist_*`: Discipline specialist prompts
- `function_*`: Functional prompts (analysis, generation, validation)
- `system_*`: System-level prompts (error handling, formatting)

#### Correspondence Agent Keys:
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

#### Discipline Specialist Keys:
```
specialist_discipline_{discipline_name}
```
- `specialist_discipline_civil`
- `specialist_discipline_structural`
- `specialist_discipline_mechanical`

#### Validation:
Use `PromptKeyValidator` class to validate key naming conventions before deployment. All prompt keys must pass validation to ensure consistency across the system.

### Prompt Debugging and Streaming Requirements

All AI agents must implement comprehensive prompt debugging and streaming logging to enable real-time visibility into prompt retrieval and usage during development and debugging.

#### Required Debug Logging Structure:

All agents must log the following information when retrieving prompts from the database:

```javascript
// Required logging pattern for prompt retrieval
try {
  const promptKey = 'agent_correspondence_01_document_analysis';
  console.log(`[AgentName] Attempting to retrieve prompt from database...`);
  console.log(`🔑 [AgentName] Prompt Key: ${promptKey}`);

  const promptContent = await PromptsService.getPromptByKey(promptKey);

  if (promptContent) {
    console.log(`✅ [AgentName] Retrieved prompt from database`);
    console.log(`📝 [AgentName] Retrieved Prompt Content (first 200 chars): ${promptContent.substring(0, 200)}...`);
    console.log(`📏 [AgentName] Full Prompt Length: ${promptContent.length} characters`);
  } else {
    console.warn(`⚠️ [AgentName] Database prompt not found`);
    // Handle fallback mode
  }
} catch (dbError) {
  console.warn(`⚠️ [AgentName] Database prompt retrieval failed:`, dbError.message);
  // Handle fallback mode
}

// Log final prompt being used
if (usingFallback) {
  console.log(`🔄 [AgentName] Using fallback prompt due to database issues`);
  console.log(`📝 [AgentName] Fallback Prompt Content (first 200 chars): ${promptContent?.substring(0, 200) || 'No fallback available'}...`);
}
```

#### Logging Standards:

1. **Prompt Key Logging**: Always log the exact key being requested
2. **Success/Failure Status**: Clear indication of database retrieval success/failure
3. **Content Preview**: First 200 characters of retrieved prompt content
4. **Length Information**: Full character count of the prompt
5. **Fallback Indication**: Clear marking when fallback mode is active
6. **Error Context**: Include error messages with appropriate context

#### Agent-Specific Logging Patterns:

- **Document Analysis Agent**: `[DocumentAnalysisAgent]`
- **Domain Specialist Agent**: `[DomainSpecialistAgent]`
- **Contract Management Agent**: `[ContractManagementAgent]`
- **Orchestrator Agent**: `[CorrespondenceOrchestrator]`

#### Debugging Benefits:

1. **Real-time Visibility**: Developers can see exactly which prompts are being retrieved
2. **Database Connectivity**: Immediate detection of database connectivity issues
3. **Fallback Mode Detection**: Clear indication when fallback prompts are being used
4. **Prompt Content Validation**: Ability to verify correct prompt content is being used
5. **Performance Monitoring**: Character count helps identify unusually large/small prompts

#### Implementation Requirements:

All agents must implement this logging pattern in their `runCorrespondenceAnalyser()`, `consultSpecialist()`, `manageContractCompliance()`, and equivalent prompt retrieval methods. The logging should be active in both development and production environments to ensure continuous debugging capability.

When modifying code:
1. Maintain existing code style and patterns
2. Update documentation for changes
3. Test changes thoroughly
4. Follow security best practices
5. Ensure backward compatibility
6. Add appropriate logging
7. Update database migrations if needed
8. **Validate prompt key naming conventions** using `PromptKeyValidator`

When adding features:
1. Follow existing architectural patterns
2. Add proper error handling
3. Include input validation
4. Update API documentation
5. Add tests
6. **Use standardized prompt key naming conventions**
7. Update this AGENTS.md if new patterns emerge

---

## 🏛️ **Governance Swarm Integration (NEW)**

All agents MUST integrate with the **11-Agent Governance Swarm** for AIUC-1, ISO 42001, ISO 27701, EU AI Act, and NIS2 compliance.

### Governance Integration Requirements

1. **Import Governance Utilities:**
```javascript
// JavaScript/Node.js agents
import { with_governance } from 'deep-agents/agents/shared/governance';
```

```python
# Python agents
from deep_agents.agents.shared.governance import with_governance, GovernedAgentMixin
```

2. **Apply Governance Decorator:**
```python
class MyAgent(SubAgent):
    @with_governance(jurisdiction='FI', strict_mode=True)
    async def _execute_impl(self, workflow_state, **kwargs):
        # Agent logic with automatic governance validation
        return result
```

3. **Required Jurisdiction Declaration:**
- All agents must specify their primary jurisdiction (FI, ZA, SE, GN, SA, EU)
- Multi-jurisdiction projects must declare contractor jurisdictions
- See [PrivacyAgent](../../deep-agents/deep_agents/agents/shared/governance/0030_privacy_agent.py) for jurisdiction rules

### Governance Compliance Checklist

- [ ] Agent uses `@with_governance` decorator or `GovernedAgentMixin`
- [ ] Jurisdiction specified (primary_controller)
- [ ] Contractor jurisdictions declared for multi-national projects
- [ ] Agent handles governance_blocked results
- [ ] Audit logging enabled
- [ ] Risk scores reviewed

### Related Governance Documents

| Document | Location | Purpose |
|----------|----------|---------|
| **Governance Swarm Architecture** | [./0000_GOVERNANCE_SWARM_ARCHITECTURE.md](./0000_GOVERNANCE_SWARM_ARCHITECTURE.md) | Full architecture specification |
| **Governance Implementation Procedure** | [../procedures/agent-development/0000_GOVERNANCE_AGENT_IMPLEMENTATION_PROCEDURE.md](../procedures/agent-development/0000_GOVERNANCE_AGENT_IMPLEMENTATION_PROCEDURE.md) | Implementation guide |
| **Security Assessment** | [../security/0000_ENTERPRISE_PORT_SECURITY_ASSESSMENT.md](../security/0000_ENTERPRISE_PORT_SECURITY_ASSESSMENT.md) | Security controls |

---

## 📋 **CROSS-REFERENCE GUIDE: Agent System Documentation**

### 🎯 **Key Reference Points**

| **Prompt Key** | **Agent Code File** | **Prompt MD File** | **API Mapping** | **Browser Mapping** |
|---|---|---|---|---|
| `agent_correspondence_01_document_analysis` | `correspondence-01-document-analysis-agent.js` | `contract_correspondence_analysis.md` | ✅ | ✅ |
| `agent_correspondence_02_identifier_extraction` | `correspondence-02-information-extraction-agent.js` | `contract_identifier_extraction.md` | ✅ | ✅ |
| `agent_correspondence_03_document_retrieval` | `correspondence-03-document-retrieval-agent.js` | `document_retrieval_agent.md` | ✅ | ✅ |
| `agent_correspondence_04_domain_specialist` | `correspondence-04-domain-specialist-agent.js` | `domain_specialist_agent.md` | ✅ | ✅ |
| `agent_correspondence_05_contract_management` | `correspondence-05-contract-management-agent.js` | `contract_management_agent.md` | ✅ | ✅ |
| `agent_correspondence_06_human_review` | `correspondence-06-human-review-agent.js` | `human_review_agent.md` | ✅ | ✅ |
| `agent_correspondence_07_professional_formatting` | `correspondence-07-professional-formatting-agent.js` | `professional_formatting_agent.md` | ✅ | ✅ |

### 📁 **File Location Map**

```
📦 Project Root
├── 📁 client/src/pages/00435-contracts-post-award/components/agents/
│   ├── 📄 correspondence-01-document-analysis-agent.js
│   ├── 📄 correspondence-02-information-extraction-agent.js
│   ├── 📄 correspondence-03-document-retrieval-agent.js
│   ├── 📄 correspondence-04-domain-specialist-agent.js
│   ├── 📄 correspondence-05-contract-management-agent.js
│   ├── 📄 correspondence-06-human-review-agent.js
│   └── 📄 correspondence-07-professional-formatting-agent.js
│
├── 📁 docs/dev-prompts/00435-contracts-post-award/correspondence-workflow/
│   ├── 📄 contract_correspondence_analysis.md
│   ├── 📄 contract_identifier_extraction.md
│   ├── 📄 document_retrieval_agent.md
│   ├── 📄 domain_specialist_agent.md
│   ├── 📄 contract_management_agent.md
│   ├── 📄 human_review_agent.md
│   ├── 📄 professional_formatting_agent.md
│   └── 📁 specialists/
│       ├── 📄 civil.md
│       ├── 📄 structural.md
│       └── 📄 ... (other specialist prompts)
│
├── 📁 client/src/common/js/services/
│   ├── 📄 enhancedPromptsService.js ← BROWSER MAPPING
│   └── 📄 promptKeyValidator.js ← VALIDATION RULES
│
└── 📁 server/api/prompts/
    └── 📄 local.js ← SERVER API MAPPING
```

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
