---
title: Engineering Shared Workflows - Code and Documentation Placement
author: PaperclipForge AI
date: 2026-04-21
version: 2.0
status: active
related_docs:
  - docs-paperclip/plans/workflows/2026-04-20-paperclip-workflow-automation-ecosystem-implementation-plan.md
  - docs-paperclip/disciplines-shared/engineering/DISCIPLINE-WORKFLOWS-CATALOG.md
---

# Engineering Shared Workflows - Code and Documentation Placement

## Overview

This document defines the standardized location for all code and documentation within the **engineering shared workflows** discipline, which implements the AI-powered workflow automation ecosystem across all engineering disciplines.

**Reference**: [Paperclip Workflow Automation Ecosystem Implementation Plan](../../plans/workflows/2026-04-20-paperclip-workflow-automation-ecosystem-implementation-plan.md)

## Repository Rules

> ⚠️ **Never put implementation code in docs-paperclip**
> ⚠️ **Never put documentation in paperclip-render**
> ⚠️ **AI workflow templates belong in docs-paperclip/disciplines-shared/engineering/templates/**
> ⚠️ **Template selection logic belongs in paperclip-render agent implementations**

## AI-Powered Workflow Automation Structure

```
docs-paperclip/disciplines-shared/engineering/
├── CODE-AND-DOC-PLACEMENT.md                    ← This file (updated)
├── README.md                                   ← Discipline overview
├── DISCIPLINE-WORKFLOWS-CATALOG.md             ← AI + traditional workflows
│
├── templates/                                  ← AI workflow templates (80-95% reusable)
│   ├── specification-development/              ← Template AI-SPEC-DEV-001
│   │   ├── template-config.json                ← Template metadata & parameters
│   │   ├── workflow-definition.yaml            ← Core workflow logic
│   │   ├── discipline-adaptations/             ← Discipline-specific customizations
│   │   │   ├── architectural.json
│   │   │   ├── civil.json
│   │   │   ├── electrical.json
│   │   │   ├── mechanical.json
│   │   │   ├── structural.json
│   │   │   └── chemical.json
│   │   ├── third-party-integrations/           ← IntegrateForge AI connector configs
│   │   │   ├── bim360-integration.json
│   │   │   ├── revit-integration.json
│   │   │   ├── autocad-integration.json
│   │   │   └── civil3d-integration.json
│   │   └── selection-criteria.md               ← When to use this template
│   │
│   ├── regulatory-compliance/                  ← Template AI-REG-COMPLY-002
│   │   ├── template-config.json
│   │   ├── workflow-definition.yaml
│   │   ├── jurisdiction-mappings/
│   │   │   ├── south-africa/
│   │   │   ├── usa/
│   │   │   ├── uk/
│   │   │   └── eurocode/
│   │   ├── third-party-integrations/           ← Compliance tool integrations
│   │   │   ├── procore-compliance.json
│   │   │   ├── aconex-permits.json
│   │   │   └── sharepoint-audit-trails.json
│   │   └── selection-criteria.md
│   │
│   ├── construction-administration/            ← Template AI-CONST-ADMIN-003
│   │   ├── template-config.json
│   │   ├── workflow-definition.yaml
│   │   ├── rfi-templates/
│   │   ├── submittal-workflows/
│   │   ├── inspection-protocols/
│   │   └── third-party-integrations/           ← Construction management tools
│   │       ├── procore-rfi-workflow.json
│   │       ├── bim360-submittals.json
│   │       ├── asta-progress-tracking.json
│   │       └── costx-change-orders.json
│   │
│   ├── commissioning-handover/                 ← Template AI-COMMISSION-004
│   │   ├── template-config.json
│   │   ├── workflow-definition.yaml
│   │   ├── testing-protocols/
│   │   ├── handover-checklists/
│   │   └── third-party-integrations/           ← Commissioning tool integrations
│   │       ├── etabs-load-testing.json
│   │       ├── staad-structural-verification.json
│   │       └── hec-ras-hydraulic-testing.json
│   │
│   └── safety-risk-management/                 ← Template AI-SAFETY-RISK-005
│       ├── template-config.json
│       ├── workflow-definition.yaml
│       ├── hazard-analysis-templates/
│       │   ├── hazop/
│       │   ├── lopa/
│       │   └── jsa/
│       ├── incident-investigation/
│       └── third-party-integrations/           ← Safety management tools
│           ├── procore-safety-incidents.json
│           └── sharepoint-safety-docs.json
│
├── knowledge/                                  ← Cross-discipline engineering knowledge
│   ├── PAGE-KNOWLEDGE.md                       ← Master engineering knowledge base
│   ├── standards-mapping.md                    ← Engineering standards reference
│   ├── template-selection-guide.md             ← How agents choose templates
│   └── customization-thresholds.md             ← When to customize vs use as-is
│
├── projects/                                   ← Template implementation projects
│   └── {TEMPLATE-IMPLEMENTATION-PROJECT}/
│       ├── README.md                           ← Project overview
│       ├── plan.md                             ← Implementation plan
│       ├── AGENTS.md                           ← Project-specific agent instructions
│       │
│       ├── trigger/                            ← Project automation triggers
│       │   ├── README.md
│       │   └── {PROJECT}-000-template-rollout.md
│       │
│       ├── pilot-implementation/               ← Pilot discipline deployments
│       │   ├── architectural-pilot/
│       │   ├── civil-pilot/
│       │   └── electrical-pilot/
│       │
│       ├── full-rollout/                       ← Full discipline deployments
│       │   ├── phase-1-8-disciplines/
│       │   ├── phase-2-remaining-15/
│       │   └── optimization-phase/
│       │
│       ├── metrics/                            ← Performance tracking
│       │   ├── adoption-rates.json
│       │   ├── time-savings-analysis.json
│       │   └── quality-improvements.json
│       │
│       ├── issues/                             ← Implementation issues
│       │   ├── ENG-AUTO-001-template-selection-tuning.md
│       │   ├── ENG-AUTO-002-customization-thresholds.md
│       │   └── ISSUE-GENERATION-STATUS.md
│       │
│       ├── desktop/                            ← Desktop platform implementations
│       ├── mobile/                             ← Mobile platform implementations
│       ├── web/                                ← Web platform implementations
│       │
│       ├── shared/                             ← Cross-platform shared components
│       │   ├── api/                            ← Template APIs
│       │   ├── business-logic/                 ← Core workflow logic
│       │   ├── data-models/                    ← Template data structures
│       │   └── agent-coordination/             ← Multi-agent orchestration
│       │
│       └── knowledge/                          ← Project-specific knowledge
│           └── PAGE-KNOWLEDGE.md
│
├── trigger/                                    ← Discipline automation triggers
│   ├── README.md
│   └── template-rollout-automation/
│       └── issues/
│           └── ENG-AUTO-000-template-ecosystem-automation.md
│
├── procedures/                                 ← Engineering workflow procedures
│   ├── template-selection-procedure.md
│   ├── customization-workflow.md
│   ├── agent-orchestration-procedure.md
│   └── performance-monitoring-procedure.md
│
├── plans/                                      ← Implementation plans
│   ├── 2026-04-20-paperclip-workflow-automation-ecosystem-implementation-plan.md
│   └── YYYY-MM-DD-template-optimization-plan.md
│
└── research/                                   ← Template enhancement research
    ├── learning-algorithm-improvements/
    ├── template-expansion-opportunities/
    └── cross-industry-adaptation/
```

## Placement by File Type

| File Type | Location | Purpose |
|-----------|----------|---------|
| **AI Workflow Templates** | `disciplines-shared/engineering/templates/` | Reusable workflow patterns (80-95% reusability) |
| **Template Configuration** | `templates/{template}/template-config.json` | Template metadata, parameters, selection criteria |
| **Workflow Definitions** | `templates/{template}/workflow-definition.yaml` | Core workflow logic and agent orchestration |
| **Discipline Adaptations** | `templates/{template}/discipline-adaptations/` | Discipline-specific customizations (<20%) |
| **Third-Party Integrations** | `templates/{template}/third-party-integrations/` | IntegrateForge AI connector configurations |
| **Selection Criteria** | `templates/{template}/selection-criteria.md` | When agents should choose this template |
| **Implementation Projects** | `projects/{TEMPLATE-IMPLEMENTATION-PROJECT}/` | Template rollout and optimization projects |
| **Performance Metrics** | `projects/{PROJECT}/metrics/` | Adoption rates, time savings, quality improvements |
| **Agent Coordination** | `shared/agent-coordination/` | Multi-agent orchestration logic |
| **Template APIs** | `shared/api/` | Template integration interfaces |
| **Business Logic** | `shared/business-logic/` | Core workflow processing logic |
| **Data Models** | `shared/data-models/` | Template data structures and schemas |

## IntegrateForge AI Integration Structure

### Third-Party Integration Placement

Each AI workflow template includes a `third-party-integrations/` directory containing connector configurations for IntegrateForge AI tools:

```
templates/{template}/third-party-integrations/
├── {tool}-integration.json          ← Primary connector configuration
├── {tool}-workflows.json            ← Workflow-specific integration logic
├── data-mapping.json                ← Field mapping between systems
├── authentication-config.json       ← Secure credential management
└── error-handling.json              ← Integration failure recovery
```

### Integration Configuration Schema

**{tool}-integration.json** structure:
```json
{
  "connector": "integrateforge-ai-{tool}",
  "version": "1.0.0",
  "capabilities": ["read", "write", "sync", "webhook"],
  "data_formats": ["json", "xml", "csv"],
  "authentication": {
    "type": "oauth2",
    "scopes": ["read", "write"],
    "token_refresh": true
  },
  "rate_limits": {
    "requests_per_minute": 60,
    "burst_limit": 10
  },
  "error_handling": {
    "retry_attempts": 3,
    "backoff_strategy": "exponential",
    "fallback_mode": "offline_queue"
  }
}
```

### Integration Workflow Patterns

#### 1. Data Synchronization Pattern
```
Template Step → IntegrateForge Connector → Third-Party Tool → Data Transformation → Template Continuation
```

#### 2. Event-Driven Pattern
```
Third-Party Tool Event → Webhook → IntegrateForge Connector → Template Trigger → Workflow Execution
```

#### 3. Batch Processing Pattern
```
Template Schedule → IntegrateForge Connector → Bulk Data Retrieval → Processing Pipeline → Results Storage
```

### Connector Categories by Template

| Template | Primary Connectors | Integration Purpose |
|----------|-------------------|-------------------|
| **AI-SPEC-DEV-001** | BIM 360, Revit, AutoCAD, Civil 3D | Design data import/export, model synchronization |
| **AI-REG-COMPLY-002** | Procore, Aconex, SharePoint | Compliance tracking, permit management, audit trails |
| **AI-CONST-ADMIN-003** | Procore, BIM 360, Asta Powerproject, CostX | RFI management, submittals, progress tracking, change orders |
| **AI-COMMISSION-004** | ETABS, STAAD, HEC-RAS, SWMM | Load testing, structural verification, system validation |
| **AI-SAFETY-RISK-005** | Procore, SharePoint | Safety incident tracking, document management, compliance reporting |

### Integration Testing Structure

```
templates/{template}/third-party-integrations/
├── tests/
│   ├── unit-tests/                    ← Individual connector tests
│   ├── integration-tests/             ← End-to-end workflow tests
│   ├── mock-data/                     ← Test data for third-party APIs
│   └── performance-tests/             ← Load and scalability tests
└── monitoring/
    ├── health-checks.json             ← Connector availability monitoring
    ├── performance-metrics.json       ← Response time and throughput tracking
    └── error-logs/                    ← Integration failure analysis
```

## Engineering Shared Workflows Specifics

### Purpose
The engineering shared workflows discipline implements the AI-powered workflow automation ecosystem, providing **5 universal workflow templates** with **80-95% reusability** across **23 engineering disciplines**.

### Template Types
- **AI-SPEC-DEV-001**: Specification Development (90-95% reusable)
- **AI-REG-COMPLY-002**: Regulatory Compliance (85-90% reusable)
- **AI-CONST-ADMIN-003**: Construction Administration (80-85% reusable)
- **AI-COMMISSION-004**: Commissioning & Handover (75-80% reusable)
- **AI-SAFETY-RISK-005**: Safety & Risk Management (70-80% reusable)

### Platform Scope
Supporting: Desktop (design/office), Mobile (field work), Web (collaboration), and Shared (cross-platform APIs)

### Agent Integration
- **Workflow Complexity Analyzer** (DevForge AI): Template selection and complexity assessment
- **Discipline Automation Agent**: Template execution and multi-company orchestration
- **Learning Coordinator** (DevForge AI): Continuous template optimization

### Customization Thresholds
- **<10% customization**: Use template as-is
- **10-20% customization**: Apply parameterization
- **20-30% customization**: Use template + custom components
- **>30% customization**: Create new template or manual process

---

**Document Version**: 2.0
**Last Updated**: 2026-04-21
**Templates**: 5 AI-powered universal templates
**Reusability**: 80-95% across 23 disciplines
**Platform Support**: Desktop, Mobile, Web, Shared
