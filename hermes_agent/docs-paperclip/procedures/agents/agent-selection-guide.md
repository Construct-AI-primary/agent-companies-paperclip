---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation, paperclip-teams, agent-selection, hermes-agent
openstinger_context: general-documentation
last_updated: 2026-04-18
related_docs:
  - docs-construct-ai/codebase/agents/paperclip-teams/Paperclip_Teams_Cross_Reference.md
  - procedures/agents/adding-companies-and-agents.md
---

# Agent Selection Guide

## Overview

This guide helps you select the right CEO agent for your Paperclip workflow. All agents run via the **Hermes agent** runtime with the `hermes_local` adapter, using OpenRouter models with persistent sessions.

---

## Quick Reference Matrix

| Your Need | Recommended CEO | Company | Agent Slug |
|-----------|-----------------|---------|------------|
| **GitHub PR Workflow** | Nexus | DevForge AI | `Nexus` |
| **Project Management** | Project Maestro | PaperclipForge AI | `project-maestro` |
| **Prompt/AI Orchestration** | Sage | PromptForge AI | `Sage` |
| **Quality Assurance** | Apex | QualityForge AI | `Apex` |
| **Engineering Design** | Orion | DomainForge AI | `orion-domainforge-ceo` |
| **Infrastructure** | Orchestrator | InfraForge AI | `orchestrator-infraforge-ceo` |
| **Creative Content** | Vision | Loopy AI | `vision-loopy-ceo` |
| **Knowledge Management** | Coordinator Guardian | KnowledgeForge AI | `kfg-coordinator-guardian-id` |
| **Tool Integration** | Integration Orchestrator | IntegrateForge AI | `integration-orchestrator` |

---

## Company Profiles

### DevForge AI

**Specialization:** Enterprise Development & Orchestration  
**Total Agents:** 52  
**CEO:** Nexus (`Nexus`)

| Team | Focus |
|------|-------|
| Executive | CEO, leadership, brand, knowledge |
| Engineering | Core development, system architecture |
| Data | Data engineering, analytics, ML |
| Product | Product innovation, design, roadmap |
| Growth | Marketing, sales, brand development |
| Security | Security compliance, threat protection |
| Strategy | Strategic planning, decision making |

**Best For:**
- Complex system architecture and implementation
- Enterprise integration
- Data processing pipelines
- Security implementation

---

### PaperclipForge AI

**Specialization:** Project Management & Issue Orchestration  
**Total Agents:** 16  
**CEO:** Project Maestro (`project-maestro`)

| Team | Focus |
|------|-------|
| Project Management | Project lifecycle, resource optimization |
| Issue Orchestration | Issue generation, assignment, tracking |
| Integration & Automation | API management, workflow automation |
| Analytics & Intelligence | Reporting, predictive modeling |

**Best For:**
- End-to-end project lifecycle management
- Intelligent issue generation and tracking
- Cross-company workflow automation
- Resource optimization and risk management

---

### PromptForge AI

**Specialization:** Prompt Engineering & AI Orchestration  
**Total Agents:** 23  
**CEO:** Sage (`Sage`)

| Team | Focus |
|------|-------|
| Architecture | Prompt architecture, template design |
| Research | Academic research, hypothesis testing |
| Ethics | Ethical AI compliance, regulatory |
| Analytics | Outcome prediction, performance optimization |
| Integration | Cross-agent compatibility, knowledge sharing |

**Best For:**
- Prompt design and optimization
- Multi-agent workflow orchestration
- AI ethics and compliance
- Advanced AI technique research

---

### QualityForge AI

**Specialization:** Testing, Debugging & Code Quality  
**Total Agents:** 11  
**CEO:** Apex (`Apex`)

| Team | Focus |
|------|-------|
| Executive | CEO, quality director |
| Quality | QA, standards, monitoring, validation |

**Best For:**
- Comprehensive testing and quality validation
- Complex debugging and issue resolution
- Performance optimization
- Code review and quality standards

---

### DomainForge AI

**Specialization:** Multi-Discipline Engineering  
**Total Agents:** 22  
**CEO:** Orion (`orion-domainforge-ceo`)

| Team | Focus |
|------|-------|
| Engineering | Civil, structural, geotechnical, transportation |
| Operations | Procurement, logistics, supplier management |
| Governance | Strategic planning, finance, compliance, quality |

**Best For:**
- Engineering design (structural, geotechnical, transportation)
- Construction management
- Regulatory compliance
- Multi-discipline coordination

---

### InfraForge AI

**Specialization:** Infrastructure Services  
**Total Agents:** 4  
**CEO:** Orchestrator (`orchestrator-infraforge-ceo`)

| Team | Focus |
|------|-------|
| Infrastructure | Database, systems integration, management |

**Best For:**
- Database infrastructure
- Systems integration
- Infrastructure management

---

### KnowledgeForge AI

**Specialization:** Institutional Memory & QA  
**Total Agents:** 12+  
**CEO:** Coordinator Guardian (`kfg-coordinator-guardian-id`)

| Team | Focus |
|------|-------|
| System Management | AI systems, communication, development |
| Knowledge Engineering | Doc analysis, QA strategy, architecture |

**Best For:**
- Institutional memory and document indexing
- QA strategy and test planning
- Architecture review
- Learning from failure

---

### Loopy AI

**Specialization:** Creative AI & Content Generation  
**Total Agents:** 6  
**CEO:** Vision (`vision-loopy-ceo`)

| Team | Focus |
|------|-------|
| Creative | Content generation, marketing, deep research |

**Best For:**
- Creative content creation
- User experience design
- Brand development
- Marketing materials

---

### IntegrateForge AI

**Specialization:** Third-Party Tool Integration  
**Total Agents:** 19  
**CEO:** Integration Orchestrator (`integration-orchestrator`)

| Team | Focus |
|------|-------|
| Design & BIM | BIM 360, Navisworks, Revit, AutoCAD |
| Project Controls | P6, MS Project, Asta, CostX, Procore |
| Document Management | Aconex, SharePoint, ProjectWise |
| Analysis Tools | STAAD, ETABS, HEC-RAS, SWMM |

**Best For:**
- Engineering software integrations
- API connectivity
- Data synchronization
- BIM/CAD workflows

---

## Workflow-Specific Recommendations

### GitHub PR Workflow

**Recommended Company:** DevForge AI  
**CEO:** Nexus (`Nexus`)

**Sub-agents to create:**
1. **GitCoder** - Handles git clone, file edits, commit, push
2. **PRCreator** - Creates PRs via GitHub CLI/API
3. **Tester** - Runs tests before PR submission

**Configuration:**
```json
{
  "adapterType": "hermes_local",
  "adapterConfig": {
    "model": "openrouter/anthropic/claude-sonnet-4.5",
    "persistSession": true,
    "toolsets": ["file_tools", "terminal_tools", "git"]
  }
}
```

**Environment Variables:**
```env
PAPERCLIP_API_KEY=<from Paperclip dashboard>
PAPERCLIP_API_URL=https://paperclip-xxxx.onrender.com
GITHUB_TOKEN=ghp_your-github-pat
OPENROUTER_API_KEY=sk-or-v1-your-key
```

---

### Multi-Discipline Engineering Workflow

**Recommended Company:** DomainForge AI  
**CEO:** Orion (`orion-domainforge-ceo`)

**Discipline Agents Available:**
- Civil Engineering
- Structural Engineering
- Geotechnical Engineering
- Transportation Engineering
- Construction Engineering

---

### Quality Assurance Workflow

**Recommended Company:** QualityForge AI  
**CEO:** Apex (`Apex`)

**Quality Team Agents:**
- Guardian - Quality Guardian
- Standards - Standards Enforcer
- Monitor - Quality Monitor
- Validator - Validator
- Auditor - Quality Auditor

---

## Agent Naming Convention

Agents follow the pattern: `{AgentName}-{CompanySlug}-{TeamName}`

**Examples:**
- `Nexus` (DevForge AI Executive)
- `orion-domainforge-ceo` (DomainForge AI CEO)
- `project-maestro` (PaperclipForge AI CEO)
- `integration-orchestrator` (IntegrateForge AI CEO)

---

## Adapter Configuration

All agents use the `hermes_local` adapter with these common settings:

```json
{
  "adapterType": "hermes_local",
  "adapterConfig": {
    "model": "openrouter/anthropic/claude-sonnet-4.5",
    "persistSession": true,
    "toolsets": ["file_tools", "terminal_tools"],
    "timeoutSec": 600,
    "graceSec": 15
  }
}
```

### Common Toolsets

| Toolset | Capabilities |
|---------|---------------|
| `file_tools` | read_file, write_to_file, search_files |
| `terminal_tools` | Command execution, git operations |
| `code_execution` | Python/JS code execution |
| `web_tools` | Web search, content extraction |
| `git` | Git operations (clone, commit, push, PR) |

---

## Environment Setup for Render Deployment

### Paperclip Service (Web)
```env
DATABASE_URL=postgresql://postgres:xxx@db.xxx.supabase.co:5432/postgres
PAPERCLIP_AGENT_JWT_SECRET=your-secret
PORT=3100
```

### Hermes Agent Service (Background Worker)
```env
OPENROUTER_API_KEY=sk-or-v1-your-key
TERMINAL_BACKEND=docker
TERMINAL_DOCKER_IMAGE=nikolaik/python-nodejs:python3.11-nodejs20
GITHUB_TOKEN=ghp_your-github-pat
PAPERCLIP_API_KEY=<from Paperclip dashboard>
PAPERCLIP_API_URL=https://paperclip-xxxx.onrender.com
```

---

## Finding Agent API Keys

1. **Dashboard:** Navigate to Companies → Select Company → Agents → Click Agent → API Key section
2. **Database:** Query `agent_api_keys` table
3. **Format:** Keys start with `pcak_` prefix

---

## Cross-Company Collaboration

### Default Collaboration Patterns

| Primary Company | Collaborates With | Purpose |
|-----------------|-------------------|---------|
| DevForge AI | DomainForge AI | Engineering development |
| DevForge AI | InfraForge AI | Infrastructure services |
| QualityForge AI | DomainForge AI | Engineering quality validation |
| PromptForge AI | QualityForge AI | Prompt testing |
| KnowledgeForge AI | All Companies | Institutional memory |

### Collaboration Flow Example

```
1. Loopy AI → designs creative concept
2. DevForge AI → implements technical architecture
3. PromptForge AI → optimizes AI prompts
4. QualityForge AI → validates through testing
5. KnowledgeForge AI → indexes learnings
```

---

## Success Metrics

| Company | Key Metrics |
|---------|-------------|
| DevForge AI | System reliability, performance benchmarks |
| PaperclipForge AI | Project delivery, issue resolution time |
| QualityForge AI | Quality scores, bug resolution time |
| DomainForge AI | Engineering design quality, regulatory compliance |
| InfraForge AI | System availability (>99.9%), security compliance |

---

## Related Documentation

- [Paperclip Teams Cross-Reference](../codebase/agents/paperclip-teams/Paperclip_Teams_Cross_Reference.md)
- [Adding Companies and Agents](./adding-companies-and-agents.md)
- [Render Docker Deployment](../../deployment/render-docker-deployment.md)
