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
# Deep Agents Documentation

## Overview

This directory contains comprehensive documentation for the Deep Agents system - an AI-powered procurement and workflow automation platform.

## Directory Structure

```
deep-agents/docs/
├── 0000_readme.md                    # This file - documentation index
├── architecture/                      # System architecture documentation
│   └── 0000_ai_agents_self_validation_architecture.md
├── guides/                            # User and developer guides
│   ├── 0000_workflow_optimization_guide.md
│   ├── 0001_operations_guide.md
│   └── 0002_ui_configuration_validator_guide.md
├── reports/                           # Audit reports and test results
│   ├── 0000_checkpointer_audit_report.md
│   └── [security test reports].json
└── workflows/                         # Workflow-specific documentation
    └── 01900_procurement/             # Procurement workflow (01900)
        ├── 0000_readme.md             # Procurement workflow overview
        ├── 0013_technical_implementation.md
        ├── 0015_document_handoff_flow.md
        ├── agents/                    # Agent documentation
        │   ├── 0010_agent_workflow.md
        │   ├── 0011_data_flow.md
        │   ├── 0012_thread_sequences.md
        │   └── 0016_agent_inventory.md
        ├── documents/                 # Document templates
        │   ├── 0003_sow_document.md
        │   ├── 0004_appendix_a_specifications.md
        │   ├── 0005_appendix_b_safety.md
        │   ├── 0006_appendix_c_delivery.md
        │   ├── 0007_appendix_d_training.md
        │   ├── 0008_appendix_e_logistics.md
        │   └── 0009_appendix_f_packing.md
        ├── interface/                 # UI documentation
        │   ├── 0001_chat_interface.md
        │   └── 0002_preview_validation.md
        └── testing/                   # Testing documentation
            ├── 0000_modal_implementation_testing_plan.md
            └── 0014_testing_scenarios.md
```

## Documentation Categories

### Architecture (`architecture/`)
System-level architecture documentation including:
- AI agent self-validation architecture
- Governance integration patterns
- Multi-agent orchestration

### Guides (`guides/`)
User and developer guides:
- **0000**: Workflow optimization guide
- **0001**: Operations guide
- **0002**: UI configuration validator guide
- **0003**: LangExtract configuration summary
- **0004**: LangExtract README
- **0005**: README LangExtract
- **0006**: Render deployment guide

### Reports (`reports/`)
Audit reports and test results:
- **0000**: Checkpointer audit report
- **0001**: Governance audit report
- **0002**: Governance remediation plan
- Security analysis reports (JSON)
- Policy deployment test results (JSON)

### Workflows (`workflows/`)
Workflow-specific documentation organized by discipline code:
- **01900**: Procurement workflow

## Naming Conventions

All files follow the Construct AI File Naming Standards (`docs/standards/0002_FILE_NAMING_STANDARDS.md`):

- **Lowercase**: All filenames are lowercase
- **Underscores**: Word separation using underscores
- **Numeric Prefixes**: Sequential ordering with 4-digit prefixes
- **Descriptive Names**: Clear indication of content

### Prefix Ranges
- `0000-0999`: Master guides and foundational documents
- `1000-1999`: Agent-specific documentation
- `2000-2999`: Workflow and process documentation
- `3000-3999`: Technical implementation guides
- `6000-6999`: Testing and quality assurance

## Quick Links

### Procurement Workflow (01900)
- [Overview](workflows/01900_procurement/0000_readme.md)
- [Chat Interface](workflows/01900_procurement/interface/0001_chat_interface.md)
- [SOW Document](workflows/01900_procurement/documents/0003_sow_document.md)
- [Agent Inventory](workflows/01900_procurement/agents/0016_agent_inventory.md)
- [Testing Scenarios](workflows/01900_procurement/testing/0014_testing_scenarios.md)

### Architecture
- [AI Agents Self-Validation Architecture](architecture/0000_ai_agents_self_validation_architecture.md)

### Guides
- [Workflow Optimization Guide](guides/0000_workflow_optimization_guide.md)
- [Operations Guide](guides/0001_operations_guide.md)

## Related Documentation

- **Main Docs**: `/docs/` - Primary project documentation
- **Standards**: `/docs/standards/` - Development standards
- **Procedures**: `/docs/procedures/` - Implementation procedures
- **Agent Registry**: `/docs/agents/0000_AGENTS_REGISTRY.md`

## Contributing

When adding new documentation:
1. Follow the file naming standards
2. Place files in the appropriate category directory
3. Update this README with new entries
4. Use numeric prefixes for proper ordering

---

**Last Updated**: 2026-02-24
**Maintainer**: AI Engineering Team