----
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, codebase, ai-automation
documentation
openstinger_context: agent-development, ai-systems
last_updated: 2026-04-10
related_docs:
  - codebase/agents/
  - disciplines/
---
# Agents Directory

**AI Agents for the Construct AI Platform**

This directory contains all AI agent implementations, organized by type and function.

---

## 📁 Directory Structure

```
agents/
├── README.md                           # This file
├── SWARM_AGENT_ARCHITECTURE_README.md  # Swarm architecture overview
├── core/                               # Core agent frameworks
│   ├── javascript/                     # JavaScript agent core
│   └── python/                         # Python agent core
├── communication/                      # Agent communication protocols
│   ├── protocols/                      # Communication implementations
│   └── standards/                      # Message formats & standards
├── deep-agents/                        # Deep learning agents (deprecated - see /deep-agents)
├── demo/                               # Demo implementations
├── deployment/                         # Deployment automation
│   ├── docker/                         # Docker configurations
│   ├── kubernetes/                     # K8s manifests
│   └── scripts/                        # Deployment scripts
├── discipline/                         # Discipline-specific agents
├── evolution/                          # Agent evolution & learning
├── generation/                         # Agent generation tools
│   └── templates/                      # Agent templates
├── it_specialists/                     # IT specialist swarm agents
├── models/                             # Trained models & training data
├── monitoring/                         # Monitoring & analytics
├── paperclip-teams/                    # Paperclip AI team implementations
│   ├── DevForge_AI_Team.md             # Dev Forge team documentation
│   ├── DevForge_AI_Workflow_Review_Guide.md # Dev Forge workflow review guide
│   ├── DomainForge_AI_Team.md          # Domain Forge team documentation
│   ├── InfraForge_AI_Team.md           # Infra Forge team documentation
│   ├── KnowledgeForge_AI_Team.md       # Knowledge Forge team documentation
│   ├── Loopy_AI_Team.md                # Loopy AI team documentation
│   ├── MobileForge_AI_Team.md          # Mobile Forge team documentation
│   ├── Paperclip_Teams_Cross_Reference.md # Cross-reference documentation
│   ├── PROCUREMENT_WORKFLOW_TEAM_STAFFING_ANALYSIS.md # Procurement workflow staffing analysis
│   ├── PromptForge_AI_Team.md          # Prompt Forge team documentation
│   └── QualityForge_AI_Team.md         # Quality Forge team documentation
├── optimization/                       # Performance optimization
├── pages/                              # Page-specific agents
├── production/                         # Production safeguards
├── registry/                           # Agent registry
│   ├── api/                            # Registry API
│   ├── database/                       # Registry database
│   ├── deployed/                       # Deployed agents
│   └── tools/                          # Registry tools
├── scripts/                            # Utility scripts
├── simulation/                         # Simulation & testing framework
├── source-data/                        # Training/test data
├── supabase/                           # Supabase integration agents
├── testing/                            # Testing utilities
├── training/                           # Training pipelines
├── types/                              # Agent type definitions
├── ui/                                 # UI integration agents
└── utils/                              # Utility agents
```

---

## 🚀 Quick Start

### Finding an Agent

1. **By Type**: Check `types/` for agent classifications
2. **By Function**: Look in `generation/`, `monitoring/`, `ui/`, etc.
3. **By Discipline**: See `discipline/` for domain-specific agents
4. **Registry**: Check `registry/deployed/active/` for active agents

### Creating a New Agent

1. Choose the appropriate category folder
2. Follow naming convention: `{prefix}_{descriptive_name}.{ext}`
3. See [File Naming Standards](../docs/standards/0002_FILE_NAMING_STANDARDS.md)
4. Register in `registry/deployed/active/`

---

## 📋 Agent Categories

### Core Agents (`core/`)
Base frameworks and shared functionality for agent implementations.

### Communication Agents (`communication/`)
Message protocols, serialization, and inter-agent communication standards.

### Generation Agents (`generation/`)
Tools for generating new agents from templates:
- `meta-agent-generator.js` - Meta agent creation
- `template-matcher.js` - Template matching
- `agent-validator.js` - Agent validation

### IT Specialist Swarm (`it_specialists/`)
IT management agents for agent lifecycle control:
- Agent Generator
- Agent Manager
- Agent Enhancer
- Agent Validator
- Simulation Coordinator

### Page Agents (`pages/`)
Page creation and management agents:
- EPCM Page Standardization Agent
- Page Creation Assistant Agent
- Grid Standardization Agent

### Registry (`registry/`)
Central agent registry for discovery and management.

### Simulation (`simulation/`)
Testing and simulation framework for agent workflows.

### Paperclip Teams (`paperclip-teams/`)
Specialized AI teams for workflow orchestration:
- **DevForge_AI_Team.md**: Development and implementation team for code generation and deployment (52 agents)
- **DevForge_AI_Workflow_Review_Guide.md**: Workflow review and optimization guide for Dev Forge processes
- **DomainForge_AI_Team.md**: Multi-discipline engineering expertise across civil engineering disciplines (52 agents)
- **InfraForge_AI_Team.md**: Infrastructure services, system orchestration, and operational excellence (4 agents)
- **KnowledgeForge_AI_Team.md**: Institutional memory and QA company (11 agents)
- **Loopy_AI_Team.md**: Iterative and loop-based AI processing team (6 agents)
- **MobileForge_AI_Team.md**: Mobile device ecosystem management and development (10 agents)
- **Paperclip_Teams_Cross_Reference.md**: Cross-reference documentation for all Paperclip teams
- **PROCUREMENT_WORKFLOW_TEAM_STAFFING_ANALYSIS.md**: Comprehensive procurement workflow team staffing analysis and optimization recommendations
- **PromptForge_AI_Team.md**: Prompt engineering, expansion, and complex specification processing (23 agents)
- **QualityForge_AI_Team.md**: Quality assurance, testing, and validation workflows (11 agents)

### UI Agents (`ui/`)
User interface integration agents.

---

## 🔧 Naming Conventions

### File Naming
- **Numeric Prefix**: `0000_`, `0010_`, etc. for ordering
- **Lowercase**: All lowercase with underscores
- **Extensions**: `.JS`, `.PY`, `.MD` as appropriate

### Examples
```
0010_agent_generator.py       # Python agent
meta-agent-generator.js       # JavaScript agent
0000_base_it_specialist.py    # Base class
AGENT_GUIDE.MD                # Documentation file
```

See [File Naming Standards](../docs/standards/0002_FILE_NAMING_STANDARDS.MD) for complete details.

---

## 📊 Agent Registry

The authoritative source for agent information:
- **Database**: `agents_tracking` table
- **File Registry**: `registry/deployed/active/`
- **Documentation**: [0000_AGENTS_REGISTRY.md](../docs/agents/0000_AGENTS_REGISTRY.md)

---

## 🏗️ Architecture

### Swarm Architecture
Agents work in coordinated swarms:
- **Supervisor Agents**: Orchestrate multiple agents
- **Specialist Agents**: Handle specific tasks
- **Service Agents**: Provide shared functionality

See `SWARM_AGENT_ARCHITECTURE_README.md` for details.

---

## 📝 Documentation

- **Agent Registry**: [docs/agents/0000_AGENTS_REGISTRY.md](../docs/agents/0000_AGENTS_REGISTRY.md)
- **Architecture**: [docs/agents/plans/AGENT_ARCHITECTURE_MASTER_DOCUMENT.md](../docs/agents/plans/AGENT_ARCHITECTURE_MASTER_DOCUMENT.md)
- **Development Guide**: [docs/procedures/agent-development/0000_AGENT_DEVELOPMENT_PROCEDURE.md](../docs/procedures/agent-development/0000_AGENT_DEVELOPMENT_PROCEDURE.md)
- **Coding Standards**: [docs/standards/0000_AGENT_CODING_STANDARDS.md](../docs/standards/0000_AGENT_CODING_STANDARDS.md)
- **Skills Framework**: [skills/README.md](../../skills/README.md)

---

## 🎯 Agent Skills Framework

Skills represent frequently used patterns and techniques that agents leverage for consistent, high-quality task execution. Derived from analysis of 904 chat history tasks (68.47% success rate), skills are organized by category and cross-referenced with source documentation.

### Skill Locations

**✅ CANONICAL LOCATION:** All skills are now organized within `docs_construct_ai/skills/`

| Location | Purpose | Count |
|----------|---------|-------|
| `docs_construct_ai/skills/shared/` | Cross-platform shared skills | 34 |
| `docs_construct_ai/skills/construct_ai/` | Construct AI-specific skills | 2 |
| `docs_construct_ai/skills/loopy_ai/` | Loopy AI creative skills | 5 |
| `docs_construct_ai/skills/promptforge_ai/` | PromptForge skills | 0 |
| `docs_construct_ai/skills/devforge_ai/` | DevForge skills | 0 |
| `docs_construct_ai/skills/qualityforge_ai/` | QualityForge skills | 0 |
| `docs_construct_ai/skills/domainforge_ai/` | DomainForge industry-specific skills | 0 |
| `docs_construct_ai/skills/infraforge_ai/` | InfraForge infrastructure skills | 0 |

### Filing Structure

All skills are organized within `docs_construct_ai/skills/` with company-specific subfolders:

```
docs_construct_ai/skills/
├── shared/                    # Cross-platform skills (34 skills)
├── construct_ai/              # Construct AI-specific skills
├── loopy_ai/                  # Loopy AI creative skills
├── promptforge_ai/            # PromptForge-specific skills
├── devforge_ai/               # DevForge-specific skills
├── qualityforge_ai/           # QualityForge-specific skills
├── domainforge_ai/            # DomainForge industry-specific skills
└── infraforge_ai/             # InfraForge infrastructure skills
```

### Key Skills by Category

#### UI/Frontend Development
- `state-based-button-display` - State-based navigation and button layouts (85% frequency, 94.2% success)
- `accordion-section-management` - Accordion navigation system management
- `dropdown-implementation` - Dropdown menu implementation
- `correspondence-reply-modal` - Modal implementations

#### Agent Development
- `agent-accuracy-enhancement` - AI agent accuracy improvement (95% frequency, 88.5% success)
- `agent-coding-standards` - Cross-language coding standards
- `agent-development-standards` - Development practices framework
- `dispatching-parallel-agents` - Multi-agent coordination

#### Development Workflow
- `brainstorming` - Creative problem solving
- `executing-plans` - Plan execution methodologies
- `writing-plans` - Planning documentation
- `writing-skills` - Skill documentation creation
- `subagent-driven-development` - Subagent orchestration

#### Code Quality
- `systematic-debugging` - Structured debugging approaches (92% success)
- `test-driven-development` - TDD implementation
- `receiving-code-review` - Code review handling
- `requesting-code-review` - Review request procedures
- `verification-before-completion` - Pre-completion validation

#### Version Control
- `using-git-worktrees` - Git worktree management
- `finishing-a-development-branch` - Branch completion workflows

#### Database
- `database-schema-management` - Schema design and management
- `database-naming-standards` - Naming conventions

### Agent-Skill Mapping

| Agent Team | Primary Skills |
|------------|----------------|
| **DevForge** | executing-plans, writing-plans, systematic-debugging, test-driven-development |
| **PromptForge** | brainstorming, writing-skills, agent-accuracy-enhancement |
| **QualityForge** | verification-before-completion, receiving-code-review, testing-verification |
| **Loopy AI** | creative-content-generation, narrative-design, artistic-ai-ethics |
| **DomainForge** | domain-expertise, industry-compliance, vertical-solutions |
| **InfraForge** | infrastructure-automation, devops, cloud-operations, monitoring |

### Cross-References

Skills are cross-referenced to:
1. **Source Documentation** - Procedures in `codebase/procedures/`
2. **Related Skills** - Complementary skills
3. **Agent Teams** - Specialized agents
4. **Error Tracking** - Common errors and solutions

See [skills/README.md](../../skills/README.md) for complete skills framework documentation.

---

## 🔗 Related Folders

- **/deep-agents/** - Deep learning agents (Python-based)
- **/docs/agents/** - Agent documentation and plans
- **/schemas/** - Database schemas for agents

---

## 🆘 Support

For agent development questions:
- Check [docs/procedures/agent-development/](../docs/procedures/agent-development/)
- Review [docs/agents/plans/](../docs/agents/plans/)
- See [docs/standards/0000_AGENT_CODING_STANDARDS.md](../docs/standards/0000_AGENT_CODING_STANDARDS.md)

---

---

## 🆕 Recent Updates

### 2026-03-31: Procurement Specialist Agents
Added 9 new specialist agents to DomainForge AI and InfraForge AI teams based on procurement workflow optimization analysis:

**DomainForge AI Specialists (7 agents)**:
- Procurement Strategy Specialist (HIGH PRIORITY)
- Supplier Management Specialist (HIGH PRIORITY)
- Contract Administration Specialist (HIGH PRIORITY)
- Procurement Analytics Specialist (HIGH PRIORITY)
- Mobile Workflow Designer (MEDIUM PRIORITY)
- Mobile Testing Specialist (MEDIUM PRIORITY)
- Financial Compliance Specialist (MEDIUM PRIORITY)

**InfraForge AI Specialists (2 agents)**:
- Mobile API Integration Specialist (MEDIUM PRIORITY)
- Supply Chain Integration Specialist (MEDIUM PRIORITY)

**Expected Impact**:
- 40% improvement in domain-specific validation quality
- 30% improvement in mobile feature validation
- 25% improvement in supply chain integration validation
- 20% improvement in financial compliance validation

**SQL Migration**: `/sql/creations/create-procurement-specialist-agents.sql`

---

**Last Updated**: 2026-03-31
**Maintainer**: Construct AI Development Team