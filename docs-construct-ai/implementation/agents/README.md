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

# Agent Implementation Documentation

This directory contains detailed implementation guides for specific agent systems deployed across the ConstructAI platform.

## Directory Structure

```
docs/implementation/agents/
├── README.md                                          # This file
├── 1300_00435_CONTRACTS_POST_AWARD_CORRESPONDENCE_AGENT_IMPLEMENTATION_PROCEDURE.md
└── [future agent implementations...]
```

## Purpose

This directory serves as the central repository for **page-specific agent implementations** that provide detailed technical specifications, database configurations, testing procedures, and operational guidelines for complex agent systems.

## Key Differences from General Procedures

### General Procedures (`docs/procedures/`)
- **Scope**: Broad methodology applicable to any agent development
- **Content**: Standards, patterns, and processes for agent development
- **Examples**: Agent Development Procedure, Prompt Management Procedure

### Implementation Guides (`docs/implementation/agents/`)
- **Scope**: Specific to one agent system or page implementation
- **Content**: Technical details, database keys, testing results, operational procedures
- **Examples**: 7-agent correspondence system, specific workflow implementations

## File Naming Convention

```
{page_id}_{page_name}_{agent_system}_{purpose}_{type}.md
```

**Examples:**
- `1300_00435_CONTRACTS_POST_AWARD_CORRESPONDENCE_AGENT_IMPLEMENTATION_PROCEDURE.md`
- `1300_00436_PROCUREMENT_ANALYSIS_AGENT_IMPLEMENTATION_PROCEDURE.md`

## Documentation Standards

### Required Sections
1. **Overview** - Agent system purpose and architecture
2. **Database Configuration** - Required tables, keys, and relationships
3. **Agent Workflow** - Step-by-step process flow
4. **Technical Implementation** - Code structure and integration points
5. **Testing & Validation** - Test cases and quality assurance
6. **Monitoring & Maintenance** - Operational procedures

### Cross-References
- Link to general procedures in `docs/procedures/`
- Reference shared agent architecture in `docs/pages-agents/shared-agent-architecture.md`
- Include error tracking documentation links

## Maintenance Guidelines

### When to Create New Implementation Guides
- Complex multi-agent systems (3+ agents)
- Custom workflows requiring detailed technical specifications
- Systems with extensive database integration
- Agent systems requiring specialized monitoring

### When to Use General Procedures Only
- Simple single-agent implementations
- Standard CRUD operations
- Basic form processing agents
- Systems following standard patterns

## Related Documentation

- **`docs/procedures/0000_AGENT_DEVELOPMENT_PROCEDURE.md`** - General agent development methodology
- **`docs/pages-agents/shared-agent-architecture.md`** - Shared agent architecture framework
- **`docs/standards/0000_AGENT_CODING_STANDARDS.md`** - Agent coding standards
- **`docs/error-tracking/`** - Agent-specific error tracking and debugging
