# Hermes Agent Profiles for Paperclip Integration

## Overview

This document defines Hermes Agent profiles configured to integrate with Paperclip's orchestration platform. Each profile maps to the OpenClaw team structure and provides specialized capabilities for the ConstructAI ecosystem.

## Profile Architecture

Profiles are configured via:
1. **cli-config.yaml** - Memory and execution settings
2. **MEMORY.md** - Agent's working knowledge
3. **USER.md** - User preferences and context
4. **Skills** - Domain-specific capabilities loaded at runtime

---

## Profile 1: Orion (Executive/Orchestration)

### Role: Chief Engineering Orchestrator
Maps to: DomainForge AI's Orion + OpenClaw Teams' DevForge coordination

### Configuration:
```yaml
# ~/.hermes-memory-orchestrator/MEMORY.md
# Project: ConstructAI
# Role: Multi-team coordination and governance
```

### Responsibilities:
- Cross-team workflow orchestration
- Engineering governance and standards
- Strategic planning and execution oversight
- Paperclip company goal alignment
- Budget monitoring and allocation across teams

### Integration Points:
- Paperclip: Goal alignment, org chart coordination
- OpenClaw: DevForge ↔ QualityForge ↔ DomainForge orchestration

---

## Profile 2: Forge (Development/Engineering)

### Role: Development & System Architecture
Maps to: DevForge AI Team (51 agents)

### Configuration:
```yaml
# ~/.hermes-memory-forge/MEMORY.md
# Focus: Enterprise development, architecture, data pipelines
```

### Responsibilities:
- System architecture and implementation
- API development and integration
- Database schema and data management
- Security implementation
- Cloud operations and DevOps

### Integration Points:
- Paperclip: Task execution, code artifacts, deployments
- OpenClaw: Codesmith → QualityForge unittest pipeline
- ConstructAI: Next.js/Supabase development

---

## Profile 3: Sage (Prompt/Quality Engineering)

### Role: Prompt Engineering & AI Quality
Maps to: PromptForge AI Team (28 agents) + QualityForge AI Team (36 agents)

### Configuration:
```yaml
# ~/.hermes-memory-quality/MEMORY.md
# Focus: Prompt architecture, testing, ethical AI
```

### Responsibilities:
- Prompt template design and optimization
- AI system testing and validation
- Ethical AI compliance and bias testing
- Performance benchmarking
- Code quality standards enforcement

### Integration Points:
- Paperclip: Agent adapter configuration, quality gates
- OpenClaw: QualityForge validation pipelines
- PromptForge: Prompt architecture and testing

---

## Profile 4: Strategos (Business/Strategy)

### Role: Strategic Planning & Market Intelligence
Maps to: Loopy AI Team (25 agents) + DomainForge's Strategos

### Configuration:
```yaml
# ~/.hermes-memory-strategy/MEMORY.md
# Focus: Market analysis, creative solutions, UX
```

### Responsibilities:
- Market research and competitive analysis
- Strategic planning and growth
- Creative solution design
- User experience optimization
- Brand and communication strategy

### Integration Points:
- Paperclip: Business goals, multi-company management
- OpenClaw: Loopy AI creative coordination
- ConstructAI: Sales and customer experience

---

## Profile 5: Guardian (Security/Compliance)

### Role: Security, Compliance & Risk Management
Maps to: DomainForge's Council + QualityForge's security agents

### Configuration:
```yaml
# ~/.hermes-memory-guardian/MEMORY.md
# Focus: Security testing, regulatory compliance, governance
```

### Responsibilities:
- Security vulnerability assessment
- Regulatory compliance monitoring
- Risk assessment and mitigation
- Governance policy enforcement
- Incident response coordination

### Integration Points:
- Paperclip: Governance gates, audit logging
- OpenClaw: QualityForge security-test validation
- ConstructAI: Legal, safety, compliance disciplines

---

## Profile Integration with Paperclip

### Paperclip Org Chart Mapping:
```
Company: ConstructAI
├── Orion (CEO/CTO) - Orchestrator profile
├── Forge (Engineering Team) - Development profile
│   ├── Lead Developer agent
│   ├── Database specialist
│   └── CloudOps agent
├── Sage (QA/Prompt Engineering) - Quality profile
│   ├── Prompt Architect
│   ├── Testing specialist
│   └── Ethics compliance
├── Strategos (Strategy/Creative) - Strategy profile
│   ├── Market analyst
│   └── UX designer
└── Guardian (Security/Compliance) - Guardian profile
    ├── Security tester
    └── Compliance officer
```

### Paperclip Task Flow:
1. **Task Creation**: Paperclip creates task with goal ancestry
2. **Assignment**: Orion profile receives and delegates to appropriate profile
3. **Execution**: Specialized profile executes with context from MEMORY.md
4. **Validation**: Guardian/Sage profile validates quality and compliance
5. **Completion**: Results logged back to Paperclip audit trail

### Heartbeat Schedule:
- **Orion**: Every 2 hours - strategy and coordination check
- **Forge**: Continuous - active development tasks
- **Sage**: Every 4 hours - quality reviews and prompt optimization
- **Strategos**: Every 6 hours - market and strategy updates
- **Guardian**: Every 1 hour - security and compliance monitoring

---

## Setting Up Multiple Profiles

### Directory Structure:
```
~/.hermes-memory/              # Default profile (Orion)
├── MEMORY.md
└── USER.md

~/.hermes-memory-forge/        # Development profile
├── MEMORY.md
└── USER.md

~/.hermes-memory-quality/      # Quality profile
├── MEMORY.md
└── USER.md

~/.hermes-memory-strategy/     # Strategy profile
├── MEMORY.md
└── USER.md

~/.hermes-memory-guardian/     # Security profile
├── MEMORY.md
└── USER.md
```

### Switching Profiles:
Run with different memory directories:
```bash
# Using orchestrator profile
HERMES_MEMORY_DIR=~/.hermes-memory bash run.sh "coordinate teams"

# Using development profile
HERMES_MEMORY_DIR=~/.hermes-memory-forge bash run.sh "implement feature X"

# Using quality profile
HERMES_MEMORY_DIR=~/.hermes-memory-quality bash run.sh "validate implementation"
```

---

## Cross-Profile Knowledge Sharing

### Shared Knowledge Base:
All profiles share access to:
- docs-construct-ai/ documentation
- OpenClaw team cross-reference
- Paperclip org configurations
- DomainForge engineering standards

### Profile-Specific Memory:
Each profile maintains private memory for:
- Active work tracking
- Profile-specific learnings
- Current task context
- Recent decisions and rationale

### Synchronization Protocol:
- Major decisions documented in shared MEMORY.md sections
- Critical updates propagated via Paperclip activity logs
- Cross-profile handoffs include full context transfer