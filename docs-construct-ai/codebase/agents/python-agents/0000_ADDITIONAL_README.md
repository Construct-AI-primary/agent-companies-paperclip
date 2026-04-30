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
# AI/IT Knowledge

> IT/AI conventions for building the Construct AI application

## Purpose

This directory contains **how to build the app** - IT/AI conventions, UI patterns, modal standards, and development guidelines. This is different from:

- **discipline-knowledge/** - Domain expertise for each discipline (what the AI knows)
- **docs/procedures/** - AI training procedures (LoRA adapters, fine-tuning)

## Structure

```
ai-it-knowledge/
├── README.md                         # This file
├── organisation-conventions.md       # General IT/AI conventions
├── organisation_conventions.py       # Programmatic access
├── discipline_knowledge.py          # Discipline-specific IT/AI access
└── disciplines/                     # IT/AI specifics per discipline
    └── 01900-procurement.md        # Modal states, dimensions, patterns
```

## What's Included

### Organisation Conventions
- Naming patterns (Upsert, Create, Edit modals)
- Context detection (AGENTS, UPSERT, WORKSPACE)
- Standard dimensions for UI components

### Discipline-Specific IT/AI
- Page states and navigation
- Modal configurations
- Standardized field ordering
- Dimension requirements

## Usage

```python
from ai_it_knowledge import get_context_for_modal, get_modal_dimensions

# Detect modal context
context = get_context_for_modal("01900-UpsertFileModal.js")
# Returns: "UPSERT"

# Get standardized dimensions
dims = get_modal_dimensions("01900-UpsertFileModal.js")
# Returns: {"width": "600px", "height": "90vh max"}
```

## AI/IT Specialists

The `deep-agents/deep_agents/agents/shared/ai_it_specialists/` directory contains specialist agents that assist with development, testing, and validation tasks.

### Testing Specialists

| Specialist | ID | Purpose |
|------------|-----|---------|
| **Document Compilation Tester** | `document_compilation_tester` | Tests document retrieval, compilation, and assembly workflows |
| **Workflow Orchestration Tester** | `workflow_orchestration_tester` | Tests workflow execution and agent coordination |
| **Workflow Debug Analyst** | `workflow_debug_analyst` | Analyzes and debugs workflow issues |
| **Page Testing Verification** | `page_testing_verification` | Verifies page component functionality |
| **Configuration Validator** | `configuration_validator` | Validates system configurations |
| **UI Configuration Validator** | `ui_configuration_validator` | Validates UI component configurations |

### Development Specialists

| Specialist | ID | Purpose |
|------------|-----|---------|
| **Agent Generator** | `agent_generator` | Generates new agent implementations |
| **Agent Manager** | `agent_manager` | Manages agent lifecycle and registration |
| **Agent Enhancer** | `agent_enhancer` | Enhances existing agent capabilities |
| **Agent Validator** | `agent_validator` | Validates agent implementations |
| **Page Builder** | `page_builder` | Builds page components and layouts |

### Knowledge & Learning Specialists

| Specialist | ID | Purpose |
|------------|-----|---------|
| **Knowledge Sync Specialist** | `knowledge_sync_specialist` | Synchronizes knowledge across systems |
| **Knowledge Store** | `knowledge_store` | Manages knowledge persistence |
| **Learning Enhancement** | `learning_enhancement` | Enhances learning capabilities |
| **Continuous Improvement** | `continuous_improvement` | Implements continuous improvement processes |

### Integration Specialists

| Specialist | ID | Purpose |
|------------|-----|---------|
| **HITL Integration** | `hitl_integration` | Human-in-the-loop integration |
| **MCP Client** | `mcp_client` | Model Context Protocol client |
| **Simulation Coordinator** | `simulation_coordinator` | Coordinates simulation workflows |

## Document Compilation Testing

The Document Compilation Tester (`a_0220_document_compilation_tester.py`) provides comprehensive testing for document workflows:

### Test Types

1. **SOW Retrieval** (`test_sow_retrieval`)
   - Validates SOW document exists
   - Checks required sections (scope, deliverables, timeline, resources)
   - Validates approval and version information

2. **Appendix Compilation** (`test_appendix_compilation`)
   - Tests Appendix A-F generation
   - Validates required fields for each appendix
   - Checks validation rules pass

3. **Import Documentation** (`test_import_docs`)
   - Tests import document package assembly
   - Validates: Commercial Invoice, Packing List, Bill of Lading, Certificate of Origin, Import Permit

4. **Export Documentation** (`test_export_docs`)
   - Tests export document package assembly
   - Validates: Export Declaration, Export Permit, Customs Clearance

5. **CDC Documentation** (`test_cdc_docs`)
   - Tests CDC documentation for Guinea operations
   - Validates: Domiciliation Request, Import Declaration, Bank Transfer Proof, Customs Duty Receipt
   - Checks NIF/RCCM validity
   - Determines DDI requirement based on order value

6. **Complete Package** (`test_complete_package`)
   - Tests full document package compilation
   - Calculates completeness percentage
   - Validates all expected documents present

### Test Scenarios

| Scenario | Expected Documents | Not Expected |
|----------|-------------------|--------------|
| Domestic Order (ZA) | SOW, Appendix A-F | Import/Export/CDC docs |
| International (Guinea) | SOW, Appendix A-F, Import/Export/CDC docs | None |
| International (Other) | SOW, Appendix A-F, Import/Export docs | CDC docs |
| High-Value (HITL) | All + HITL approval checks | None |

### Usage Example

```python
from deep_agents.agents.shared.ai_it_specialists import DocumentCompilationTester

# Initialize tester
tester = DocumentCompilationTester()

# Run specific test
result = tester.process_task({
    "query_type": "test_cdc_docs",
    "order_id": "po-2026-001",
    "order_value_usd": 85000
})

# Run full test suite
full_result = tester.process_task({
    "query_type": "full_test",
    "order_id": "po-2026-001"
})
```

## Integration with Testing Dashboard

The Document Compilation Tester integrates with the Testing Dashboard (`/02050-testing-dashboard`) to provide:

- Real-time test execution feedback
- Document package validation results
- Completeness scoring
- Scenario-based testing

### API Integration

```javascript
// Frontend call to run document compilation tests
const response = await fetch('/api/workflow-tests/run', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    workflowId: '01900-procurement',
    testType: 'document_compilation',
    scenario: 'international_guinea',
    orderId: 'po-2026-001'
  })
});
```

## Related Documents

| Document | Location | Purpose |
|----------|----------|---------|
| Testing Dashboard Procedure | `docs/workflows-simulations/0000_TESTING_DASHBOARD_PROCEDURE.md` | Comprehensive testing procedures |
| Testing Framework | `docs/workflows-simulations/TESTING_FRAMEWORK.md` | Overall testing framework |
| Workflow Optimization Guide | `deep-agents/docs/0000_WORKFLOW_OPTIMIZATION_GUIDE.md` | Agent workflow optimization |
| Agent Coding Standards | `docs/standards/0000_AGENT_CODING_STANDARDS.md` | Coding standards for agents |

## Related

- **discipline-knowledge/** - Domain expertise for AI
- **docs/procedures/** - Training procedures
- **deep-agents/deep_agents/agents/shared/ai_it_specialists/** - Specialist agent implementations