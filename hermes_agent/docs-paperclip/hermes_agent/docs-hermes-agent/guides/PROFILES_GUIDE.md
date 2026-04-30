# Hermes Agent Profiles Guide

## Overview

Hermes Agent supports 5 specialized profiles mapped to the OpenClaw team architecture and integrated with Paperclip's orchestration platform. Each profile has its own `MEMORY.md` with role-specific context.

## Profiles

| Profile | Maps To | Purpose | Memory Directory |
|---|---|---|---|
| **Orion** | DomainForge AI (Orion) | Executive orchestration & governance | `~/.hermes-memory/` |
| **Forge** | DevForge AI (51 agents) | Development & system architecture | `~/.hermes-memory-forge/` |
| **Sage** | PromptForge + QualityForge (64 agents) | Prompt engineering & quality assurance | `~/.hermes-memory-quality/` |
| **Strategos** | Loopy AI + Strategos | Strategy, market analysis & UX | `~/.hermes-memory-strategy/` |
| **Guardian** | Council + Security agents | Security, compliance & risk management | `~/.hermes-memory-guardian/` |

## Using Profiles

### Option 1: Via "hermes run" Command (Recommended)

When you type `hermes run "your task"` Cline will automatically prompt you to select a profile via the UI and remember your last selection for next time.

The last used profile is stored in `.hermes-profile` (defaults to "orion").

### Option 2: Profile Switcher Script

```bash
./hermes_agent/switch-profile.sh
```

This launches an interactive menu where you select a profile and provide your task. Quick switch: `./hermes_agent/switch-profile.sh forge`

### Option 3: Command Line Direct

```bash
HERMES_MEMORY_DIR=~/.hermes-memory-forge bash hermes_agent/run.sh "implement this API endpoint"
```

## Profile Details

### Orion (Executive/Orchestration)
- Cross-team workflow orchestration
- Engineering governance and standards
- Paperclip company goal alignment
- Budget monitoring across teams

### Forge (Development/Engineering)
- Next.js/Supabase development
- API development and integration
- Database schema management
- Cloud operations and DevOps

### Sage (Prompt/Quality Engineering)
- Prompt template design and optimization
- AI system testing and validation
- Ethical AI compliance
- Performance benchmarking

### Strategos (Business/Strategy)
- Market research and competitive analysis
- Creative solution design
- User experience optimization
- Brand and communication strategy

### Guardian (Security/Compliance)
- Security vulnerability assessment
- Regulatory compliance monitoring
- Risk assessment and mitigation
- Governance policy enforcement

## Paperclip Integration

The profiles integrate with Paperclip's orchestration:
- **Org Chart**: Each profile maps to an agent role in the ConstructAI org chart
- **Task Flow**: Paperclip tasks are routed through Orion to specialized profiles
- **Quality Gates**: Guardian and Sage profiles validate before completion
- **Audit Trail**: All profile activity logged to Paperclip's activity log

## OpenClaw Team Mapping

```
ConstructAI Company
├── Orion → DomainForge AI (Orion) — Executive coordination
├── Forge → DevForge AI (51 agents) — Development pipeline
├── Sage  → PromptForge (28) + QualityForge (36) — Quality assurance  
├── Strategos → Loopy AI (25) + Strategos — Creative/strategy
└── Guardian → Council + Security agents — Compliance
```

## Adding New Profiles

1. Create memory directory: `mkdir ~/.hermes-memory-<name>`
2. Create MEMORY.md with role-specific context
3. Update the switch-profile.sh script
4. Document in this guide