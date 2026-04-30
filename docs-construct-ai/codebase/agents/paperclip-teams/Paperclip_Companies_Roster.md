---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation, paperclip-companies, company-roster
openstinger_context: general-documentation
last_updated: 2026-04-28
related_docs:
  - docs/
---

# Paperclip Companies Roster

Complete reference for all companies in the Paperclip ecosystem. Each company follows the `agentcompanies/v1` specification and runs via the Hermes agent runtime with the `hermes_local` adapter.

---

## 1. Construct-AI

| Property | Value |
|----------|-------|
| **Slug** | `construct-ai` |
| **Description** | Multi-discipline construction/engineering company with 50+ discipline agents |
| **Schema** | agentcompanies/v1 |
| **Directory** | `docs-paperclip/companies/construct-ai/` |
| **Focus Areas** | Commercial, Construction, Contracts, Design, Engineering (Civil, Structural, Mechanical, Electrical, etc.), Governance, Finance, Health, Logistics, Procurement, Quality, Safety, Security, IT, Project Controls |

### Structure

Organized by discipline code rather than traditional teams. Each discipline is a subdirectory under `construct-ai/`:

| Discipline Code | Name | Focus |
|----------------|------|-------|
| `00250-commercial` | Commercial | Commercial management, quantity surveying |
| `00300_construction` | Construction | Construction management |
| `00400_contracts` | Contracts | Contract management |
| `00425_contracts-pre-award` | Contracts Pre-Award | Pre-award processes |
| `00435_contracts-post-award` | Contracts Post-Award | Post-award management |
| `00800_design` | Design | Design engineering |
| `00825_architectural` | Architectural | Architectural engineering |
| `00835_chemical-engineering` | Chemical Engineering | Chemical engineering |
| `00850_civil-engineering` | Civil Engineering | Civil engineering |
| `00855_geotechnical-engineering` | Geotechnical | Geotechnical engineering |
| `00860_electrical-engineering` | Electrical | Electrical engineering |
| `00870_mechanical-engineering` | Mechanical | Mechanical engineering |
| `00871_process-engineering` | Process Engineering | Process engineering |
| `00872_developer` | Developer | Software development |
| `00875_sales` | Sales | Sales |
| `00876_directors` | Directors | Director coordination |
| `00877_sundry` | Sundry | Sundry matters |
| `00880_board-of-directors` | Board of Directors | Board governance |
| `00882-00895` | Directors (various) | Construction, Contracts, Engineering, HSE, Logistics, Sales, Procurement, Finance, Projects |
| `00900-document-control` | Document Control | Document management |
| `01000_environmental` | Environmental | Environmental management |
| `01100_ethics` | Ethics | Ethics |
| `01200_finance` | Finance | Finance |
| `01300_governance` | Governance | Governance |
| `01400_health` | Health | Health |
| `01600_local-content` | Local Content | Local content |
| `01700_logistics` | Logistics | Logistics |
| `01750_legal` | Legal | Legal |
| `01850_other-parties` | Other Parties | Stakeholders |
| `01900_procurement` | Procurement | Procurement |
| `02000_project-controls` | Project Controls | Project controls |
| `02025_quantity-surveying` | Quantity Surveying | QS |
| `02035_scheduling` | Scheduling | Scheduling |
| `02050_information-technology` | IT | Information technology |
| `02075_inspection` | Inspection | Inspection |
| `02100_public-relations` | PR | Public relations |
| `02200_quality-assurance` | QA | Quality assurance |
| `02250_quality-control` | QC | Quality control |
| `02400_safety` | Safety | Safety |
| `02500_security` | Security | Security |
| `03000_landscaping` | Landscaping | Landscaping |

---

## 2. DevForge AI

| Property | Value |
|----------|-------|
| **Slug** | `devforge-ai` |
| **Description** | Enterprise development, orchestration, and system architecture |
| **Schema** | agentcompanies/v1 |
| **Directory** | `docs-paperclip/companies/devforge-ai/` |
| **Total Agents** | 54 |
| **CEO** | Nexus (`nexus-devforge-ceo`) |
| **Tags** | enterprise, development, orchestration, architecture |

### Teams

| Team | Slug | Agent Count | Focus |
|------|------|-------------|-------|
| Executive | `executive` | 4 | CEO, leadership, brand representation, knowledge management |
| Engineering | `engineering` | 11 | Core development, system architecture, automation, API integration, workflow management |
| Data | `data` | 10 | Data engineering, analytics, ML pipelines, data quality |
| Product | `product` | 7 | Product innovation, design, roadmap, launches |
| Growth | `growth` | 10 | Marketing, sales, brand development, customer acquisition |
| Security | `security` | 6 | Security compliance, threat protection, access control |
| Strategy | `strategy` | 6 | Strategic planning, decision making, direction setting |

### Skills

One skill per agent in `skills/` directory (52 skills total, e.g., `skills/nexus-devforge-ceo/SKILL.md`).

---

## 3. DomainForge AI

| Property | Value |
|----------|-------|
| **Slug** | `domainforge-ai` |
| **Description** | Domain knowledge and technical documentation company specializing in code structure analysis, page implementation documentation, and technical architecture for all 45 engineering and business disciplines |
| **Schema** | agentcompanies/v1 |
| **Directory** | `docs-paperclip/companies/domainforge-ai/` |
| **Total Agents** | 53 (including CEO) |
| **CEO** | Orion (`orion-domainforge-ceo`, Chief Orchestrator) |
| **Tags** | domain-knowledge, technical-documentation, code-analysis, discipline-specialists |

### Teams

| Team | Slug | Agent Count | Focus |
|------|------|-------------|-------|
| Engineering | `engineering` | 5 | Civil, structural, geotechnical, construction, transportation |
| Operations | `operations` | 9 | Procurement, logistics, finance, safety, quality, contract administration |
| Governance | `governance` | 38 | All discipline domain specialists across business and engineering |

### Skills

One skill per agent in `skills/` directory (53 skills total).

---

## 4. InfraForge AI

| Property | Value |
|----------|-------|
| **Slug** | `infraforge-ai` |
| **Description** | Dedicated infrastructure services specializing in comprehensive infrastructure management, system orchestration, data processing, security, and operational excellence |
| **Schema** | agentcompanies/v1 |
| **Directory** | `docs-paperclip/companies/infraforge-ai/` |
| **Total Agents** | 7 |
| **CEO** | Infra CEO (`orchestrator-infraforge-ceo`) |
| **Tags** | infrastructure, system-orchestration, data-processing, security |

### Teams

| Team | Slug | Agent Count | Focus |
|------|------|-------------|-------|
| Infrastructure | `infrastructure` | 6 | Infrastructure management, database services, systems integration, PostgreSQL, Supabase, Render deployment |

### Skills

- `skills/database-infraforge-database-infrastructure/SKILL.md`
- `skills/mobile-api-infraforge-mobile-api-integration/SKILL.md`
- `skills/supply-chain-integration-infraforge-supply-chain/SKILL.md`
- `skills/orchestrator-infraforge-ceo/SKILL.md`
- `skills/nimbus-infraforge-supabase-specialist/SKILL.md`
- `skills/postgres-infraforge-postgresql/SKILL.md`
- `skills/render-environment-integration/SKILL.md`

---

## 5. KnowledgeForge AI

| Property | Value |
|----------|-------|
| **Slug** | `knowledgeforge-ai` |
| **Description** | Comprehensive knowledge management and documentation autonomous AI company specializing in enterprise knowledge systems, documentation architecture, and information lifecycle management |
| **Schema** | agentcompanies/v1 |
| **Directory** | `docs-paperclip/companies/knowledgeforge-ai/` |
| **Total Agents** | 12+ (core system management + domain specialists) |
| **CEO** | Coordinator Guardian (`kfg-coordinator-guardian-id`, Chief Knowledge Orchestrator) |
| **Tags** | knowledge-management, documentation-architecture, information-lifecycle, system-management |

### Teams

| Team | Slug | Agent Count | Focus |
|------|------|-------------|-------|
| Executive | `executive` | 1 | CEO, knowledge orchestration, and strategic direction |
| System Management | `system-management` | 8 | AI systems, communication, development, interface, operations, quality, system admin, user management |
| Knowledge Engineering | `knowledge-engineering` | 3+ | Domain-specific knowledge agents (Engineer, Electrician, Buyer, etc.) |
| Documentation Operations | `documentation-operations` | Variable | Specialized documentation and content management agents |

### Agents

| Agent | Slug | Role | Team |
|-------|------|------|------|
| Coordinator Guardian | `kfg-coordinator-guardian-id` | Chief Knowledge Orchestrator | Executive |
| AI Manager | `kfg-ai-manager-id` | AI Systems & Agent Management | System Management |
| Communication Manager | `kfg-communication-manager-id` | Email Systems & Notifications | System Management |
| Development Manager | `kfg-development-manager-id` | Development Tools & Templates | System Management |
| Interface Specialist | `kfg-interface-specialist-id` | UI Components & Modal Management | System Management |
| Operations Coordinator | `kfg-operations-coordinator-id` | Business Operations & Workflow Management | System Management |
| Quality Assurance | `kfg-quality-assurance-id` | Quality Control & Testing Processes | System Management |
| System Administrator | `kfg-system-administrator-id` | System Configuration & IT Management | System Management |
| User Manager | `kfg-user-manager-id` | User Management & Authentication | System Management |
| Engineer | `kfg-engineer-id` | Knowledge Engineering & Information Architecture | Knowledge Engineering |
| Electrician | `kfg-electrician-id` | Technical Documentation & Electrical Systems | Knowledge Engineering |
| Buyer | `kfg-buyer-id` | Knowledge Procurement & Content Acquisition | Knowledge Engineering |

### Skills

11 skills in `skills/` directory, one per agent (e.g., `skills/doc-analysis/SKILL.md`).

### Routines

| Routine | Trigger | Task |
|---------|---------|------|
| `knowledge-sync` | Schedule (2 AM daily) | `tasks/knowledge-sync/TASK.md` |
| `qa-review` | Webhook (PR opened/sync/reopen) | `tasks/qa-review/TASK.md` |

### Knowledge Base

- **Source**: `docs-construct-ai/` (git repository, main branch)
- **Tag Schema**: `discipline:`, `wf:`, `sec:`, `codebase:`, `testing:`, `standards:`, `error-tracking:`
- **Export**: `scripts/export_knowledgeforge.sh` → `./knowledge-export`

---

## 6. Loopy AI

| Property | Value |
|----------|-------|
| **Slug** | `loopy-ai` |
| **Description** | Creative AI, content generation, and artistic applications |
| **Schema** | agentcompanies/v1 |
| **Directory** | `docs-paperclip/companies/loopy-ai/` |
| **Total Agents** | 6 |
| **CEO** | Vision (`vision-loopy-ceo`) |
| **Tags** | creative-ai, content-generation, artistic-applications |

### Teams

| Team | Slug | Agent Count | Focus |
|------|------|-------------|-------|
| Creative | `creative` | 5 | Creative AI, content generation, marketing, deep research, social media |

### Agents

| Agent | Slug | Role | Team |
|-------|------|------|------|
| Vision | `vision-loopy-ceo` | Chief Executive Officer | Executive |
| Alex | `alex-loopy-deep-research` | Deep Research Specialist | Creative |
| Maya | `maya-loopy-content-strategist` | Content Strategist | Creative |
| Jordan | `jordan-loopy-marketing-specialist` | Marketing Specialist | Creative |
| Sam | `sam-loopy-social-media-coordinator` | Social Media Coordinator | Creative |
| Dev | `dev-loopy-technical-creative` | Technical Creative | Creative |

---

## 7. PromptForge AI

| Property | Value |
|----------|-------|
| **Slug** | `promptforge-ai` |
| **Description** | Advanced Prompt Engineering & Orchestration Specialists |
| **Schema** | agentcompanies/v1 |
| **Directory** | `docs-paperclip/companies/promptforge-ai/` |
| **Total Agents** | 23 |
| **CEO** | Sage (`sage-promptforge-chief-architect`, Chief Prompt Architect) |
| **Tags** | prompt-engineering, ai-orchestration, workflow-design |

### Teams

| Team | Slug | Agent Count | Focus |
|------|------|-------------|-------|
| Architecture | `architecture` | 9 | Prompt architecture, template design, workflow design, state management |
| Research | `research` | 4 | Academic research, hypothesis testing, exploration, advanced innovation |
| Ethics | `ethics` | 2 | Ethical AI compliance, regulatory compliance, responsible practices |
| Analytics | `analytics` | 6 | Outcome prediction, prompt analytics, performance optimization, A/B testing |
| Integration | `integration` | 2 | Cross-agent compatibility, cross-company knowledge sharing |

### Projects

- `projects/prompt-architecture/PROJECT.md`

---

## 8. QualityForge AI

| Property | Value |
|----------|-------|
| **Slug** | `qualityforge-ai` |
| **Description** | Testing, debugging, coding excellence, and quality assurance |
| **Schema** | agentcompanies/v1 |
| **Directory** | `docs-paperclip/companies/qualityforge-ai/` |
| **Total Agents** | 11 |
| **CEO** | Apex (`apex-qualityforge-ceo`) |
| **Tags** | testing, debugging, coding-excellence, quality-assurance |

### Teams

| Team | Slug | Agent Count | Focus |
|------|------|-------------|-------|
| Executive | `executive` | 2 | CEO, quality director, organizational leadership |
| Quality | `quality` | 9 | Quality assurance, governance, standards, monitoring, validation, testing, debugging, coding |

### Agents

| Agent | Slug | Role | Team |
|-------|------|------|------|
| Apex | `apex-qualityforge-ceo` | Chief Executive Officer | Executive |
| Governor | `governor-qualityforge-quality-director` | Quality Director | Executive |
| Guardian | `guardian-qualityforge-quality-guardian` | Quality Guardian | Quality |
| Standards | `standards-Standards-enforcer` | Standards Enforcer | Quality |
| Monitor | `monitor-qualityforge-quality-monitor` | Quality Monitor | Quality |
| Validator | `validator-Validator` | Validator | Quality |
| Reporter | `report-qualityforge-quality-reporter` | Quality Reporter | Quality |
| Trainer | `trainer-qualityforge-quality-trainer` | Quality Trainer | Quality |
| Documenter | `documenter-qualityforge-documentation-specialist` | Documentation Specialist | Quality |
| Coverage | `coverage-qualityforge-test-coverage-analyst` | Test Coverage Analyst | Quality |
| Auditor | `auditor-qualityforge-quality-auditor` | Quality Auditor | Quality |

---

## 9. MobileForge AI

| Property | Value |
|----------|-------|
| **Slug** | `mobileforge-ai` |
| **Description** | Mobile device ecosystem management, optimization, and development |
| **Schema** | agentcompanies/v1 |
| **Directory** | `docs-paperclip/companies/mobileforge-ai/` |
| **Total Agents** | 10 |
| **CEO** | Mobile Maestro (`mobile-maestro`) |
| **Tags** | mobile-development, device-management, cross-platform, app-lifecycle |

### Teams

| Team | Slug | Agent Count | Focus |
|------|------|-------------|-------|
| Device Management | `device-management` | 4 | Device lifecycle, security, performance optimization |
| Development | `development` | 3 | Cross-platform development, UI/UX, testing |
| Integration | `integration` | 2 | API integration, cloud connectivity |

### Agents

| Agent | Slug | Role | Team |
|-------|------|------|------|
| Mobile Maestro | `mobile-maestro` | Chief Executive Officer | Executive |
| Device Controller | `device-controller` | Device Management Specialist | Device Management |
| App Manager | `app-manager` | Application Lifecycle Specialist | Device Management |
| Security Guardian | `security-guardian` | Mobile Security Specialist | Device Management |
| Performance Optimizer | `performance-optimizer` | Device Performance Specialist | Device Management |
| Mobile Developer | `mobile-developer` | Cross-Platform Development Specialist | Development |
| UI/UX Specialist | `ui-ux-specialist` | Mobile Interface Design Specialist | Development |
| Testing Coordinator | `testing-coordinator` | Mobile Testing Specialist | Development |
| API Specialist | `api-specialist` | Mobile API Integration Specialist | Integration |
| Cloud Connector | `cloud-connector` | Mobile-Cloud Services Specialist | Integration |

### Technology Stack

- **Cross-Platform**: React Native, Flutter, Ionic/Capacitor
- **Native iOS**: Swift, SwiftUI
- **Native Android**: Kotlin, Jetpack Compose
- **Cloud Platforms**: AWS, Google Cloud, Azure
- **Testing**: Jest, Detox, Appium, Firebase Test Lab

---

## 10. PaperclipForge AI

| Property | Value |
|----------|-------|
| **Slug** | `paperclipforge-ai` |
| **Description** | Operational backbone company specializing in intelligent project management, issue orchestration, workflow automation, and seamless integration across the Paperclip ecosystem |
| **Schema** | agentcompanies/v1 |
| **Directory** | `docs-paperclip/companies/paperclipforge-ai/` |
| **Total Agents** | 19 |
| **CEO** | Project Maestro (`project-maestro`) |
| **Tags** | project-management, issue-orchestration, workflow-automation, ecosystem-integration |

### Teams

| Team | Slug | Agent Count | Focus |
|------|------|-------------|-------|
| Operations | `operations` | 2 | Agent lifecycle management, model assignment optimization, operational oversight |
| Project Management | `project-management` | 4 | Project lifecycle, resource optimization, risk management, performance tracking |
| Issue Orchestration | `issue-orchestration` | 4 | Intelligent issue generation, assignment, dependency management, progress tracking |
| Integration & Automation | `integration-automation` | 4 | API management, workflow automation, quality control, data integration |
| Analytics & Intelligence | `analytics-intelligence` | 4 | Reporting analytics, predictive modeling, knowledge integration, user experience |

### Agents

| Agent | Slug | Role | Team |
|-------|------|------|------|
| Project Maestro | `project-maestro` | Chief Executive Officer | Executive |
| Operations Director | `operations-director` | Chief Operations Officer | Executive |
| Integration Architect | `integration-architect` | Chief Technology Officer | Executive |
| Atlas Agent Creator | `atlas-agent-creator` | Agent Creator & Manager | Operations |
| Model Assignment Specialist (SparkAssign) | `model-assignment-specialist` | Intelligent Model Assignment | Operations |
| Project Coordinator | `project-coordinator` | Project Lifecycle Management | Project Management |
| Resource Manager | `resource-manager` | Resource Allocation & Optimization | Project Management |
| Risk Analyst | `risk-analyst` | Risk Identification & Mitigation | Project Management |
| Performance Monitor | `performance-monitor` | Performance Tracking & Analytics | Project Management |
| Issue Generator | `issue-generator` | AI-Powered Issue Creation | Issue Orchestration |
| Assignment Specialist | `assignment-specialist` | Intelligent Issue Routing | Issue Orchestration |
| Dependency Manager | `dependency-manager` | Dependency Tracking & Resolution | Issue Orchestration |
| Progress Tracker | `progress-tracker` | Real-Time Monitoring | Issue Orchestration |
| API Manager | `api-manager` | API Ecosystem Management | Integration & Automation |
| Workflow Automator | `workflow-automator` | Workflow Design & Automation | Integration & Automation |
| Quality Controller | `quality-controller` | Quality Assurance | Integration & Automation |
| Data Integrator | `data-integrator` | Data Flow Management | Integration & Automation |
| Reporting Analyst | `reporting-analyst` | Analytics & Reporting | Analytics & Intelligence |
| Predictive Modeler | `predictive-modeler` | Predictive Analytics | Analytics & Intelligence |
| Knowledge Integrator | `knowledge-integrator` | Knowledge Integration | Analytics & Intelligence |
| User Experience Coordinator | `user-experience-coordinator` | User Interaction Management | Analytics & Intelligence |

---

## Company Summary

| # | Slug | Name | Agents | Focus | CEO |
|---|------|------|--------|-------|-----|
| 1 | `construct-ai` | Construct-AI | 50+ disciplines | Multi-discipline engineering | Discipline leads |
| 2 | `devforge-ai` | DevForge AI | 54 | Enterprise development | Nexus |
| 3 | `domainforge-ai` | DomainForge AI | 53 | Domain knowledge & technical documentation | Orion |
| 4 | `infraforge-ai` | InfraForge AI | 7 | Infrastructure services | Infra CEO |
| 5 | `knowledgeforge-ai` | KnowledgeForge AI | 11 | Institutional memory & QA | Doc Analyst |
| 6 | `loopy-ai` | Loopy AI | 6 | Creative AI | Vision |
| 7 | `promptforge-ai` | PromptForge AI | 23 | Prompt engineering | Sage |
| 8 | `qualityforge-ai` | QualityForge AI | 11 | Quality assurance | Apex |
| 9 | `mobileforge-ai` | MobileForge AI | 10 | Mobile device ecosystem | Mobile Maestro |
| 10 | `paperclipforge-ai` | PaperclipForge AI | 19 | Project management & issue orchestration | Project Maestro |

**Total Active Agents**: ~230+ (Construct-AI has 50+ discipline agents; remaining 10 companies total 155 agents)

## Shared Resources

| Resource | Path | Purpose |
|----------|------|---------|
| Shared Skills | `docs-paperclip/companies/shared/` | Skills shared across companies |
| Companies Spec | `docs-paperclip/companies/companies-spec.md` | Company specification documentation |
| README | `docs-paperclip/companies/README.md` | Companies overview |