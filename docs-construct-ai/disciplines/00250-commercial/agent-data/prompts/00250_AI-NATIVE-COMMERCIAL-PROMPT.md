---
title: 00250 Commercial AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement commercial management features including contract analysis, negotiation support, document generation pipeline, supplier evaluation, approval routing, and commercial compliance monitoring with structured data architecture and commercial safety boundaries
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00250-commercial/agent-data/prompts
gigabrain_tags: disciplines, 00250-commercial, ai-native-operations, document-generation, contract-analysis, negotiation-support, supplier-evaluation, multi-agent-orchestration, approval-routing, compliance-monitoring, code-generation
openstinger_context: commercial-ai-native-operations, automated-commercial-documentation, contract-extraction, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00250-commercial/agent-data/domain-knowledge/00250_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00250-commercial/agent-data/domain-knowledge/00250_GLOSSARY.MD
  - docs_construct_ai/disciplines/00250-commercial/agent-data/00250_AGENTS.md
  - docs_construct_ai/skills/domainforge_ai/00250-commercial/approval-routing/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/00250-commercial/supplier-evaluation/SKILL.md
---

# 00250 Commercial AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement commercial management features for large engineering, infrastructure, mining, and architectural projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant commercial code covering contract analysis, negotiation support, document generation, supplier evaluation, and commercial compliance monitoring.

**This prompt is for OpenClaw coding agents operating in dev mode.** Agents use this prompt to **generate, modify, and validate code**. This prompt is NOT for the running application in production. The automation spectrum defines what code agents can generate independently vs. what requires human architect review.

**Key Lesson from Safety and Civil Engineering Domains:** The automation spectrum approach (Full Automation / Augment AI+Human / Human-Led) and structured data architecture patterns are foundational principles. Agents must understand what commercial code they can generate independently vs. what requires human architect review. Contract analysis and financial calculations must never allow LLMs to fabricate values — all data must come from verified structured sources.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Text-Native vs Structured-Data Architecture
- [ ] **Classify all commercial data sources** — Tag each input as text-native (LLM-friendly: contracts, correspondence) or structured-data-native (pricing database, contract registry, risk register)
- [ ] **Implement contract analysis pipeline** — Document ingestion → clause extraction → structured JSON → obligation tracking
- [ ] **Build extraction schemas per document type** — Contracts, tenders, correspondence, negotiation records, market reports
- [ ] **Implement provenance tracking** — Every extracted value tagged with source document, version, extraction timestamp
- [ ] **Enforce guard rails** — LLM cannot create/edit financial values; must use verified structured data for calculations

### Phase 2: Document Generation Pipeline Implementation
- [ ] **Create template library** — Standardize all commercial document templates (RFP/RFQ, correspondences, negotiation strategies, variation orders, claims)
- [ ] **Implement structured data injection** — Template engine fills placeholders from contract registry, pricing database, risk register (not raw LLM text)
- [ ] **Develop Phase 1 documents (Pre-Bid)** — Commercial strategy, risk assessment, market analysis, bid/no-bid recommendation
- [ ] **Develop Phase 2 documents (Tender)** — RFP/RFQ packages, evaluation criteria, supplier invitations, tender analysis reports
- [ ] **Develop Phase 3 documents (Negotiation)** — Negotiation strategies, position papers, counter-offer drafts, term sheets
- [ ] **Develop Phase 4 documents (Contract Execution)** — Contract documents, amendment requests, variation orders, approval routing
- [ ] **Develop Phase 5 documents (Operational)** — Commercial correspondence, risk updates, performance reports, compliance certificates
- [ ] **Develop Phase 6 documents (Strategic)** — Claims, disputes, commercial audit reports, lessons learned
- [ ] **Add quality validation** — Automated completeness checks, contractual accuracy verification
- [ ] **Implement approval routing** — Value-based routing through delegated authority matrix

### Phase 3: Multi-Agent Commercial Orchestration
- [ ] **Implement Commercial Coordinator Agent** — Orchestrates commercial operations and cross-discipline coordination
- [ ] **Implement Procurement Agent** — Manages supplier relationships and procurement processes
- [ ] **Implement Contract Management Agent** — Contract lifecycle and compliance oversight
- [ ] **Implement Market Intelligence Agent** — Market trends and competitive intelligence analysis
- [ ] **Implement Supplier Evaluation Agent** — Automated supplier scoring and recommendation using configurable criteria
- [ ] **Implement Correspondence Agent** — Commercial communications and documentation management
- [ ] **Implement agent coordination layer** — Market Intelligence → Commercial strategy → Tender → Supplier evaluation → Negotiation → Contract execution → Performance monitoring → Risk tracking

### Phase 4: Commercial Compliance Monitoring
- [ ] **Implement obligation tracking** — Monitor contractual obligations from executed contracts
- [ ] **Develop milestone and deliverable compliance verification** — Automated tracking against contract milestones
- [ ] **Implement change order and variation monitoring** — Threshold alerts for variations exceeding limits
- [ ] **Develop performance bond and guarantee expiry tracking** — Automated alerts for expiring instruments
- [ ] **Implement regulatory compliance checking** — Automated verification of commercial activities against regulations

### Phase 5: Natural Language Commercial Interface
- [ ] **Implement Contract Query Assistant** — "What are the liquidated damages for this contract?" → exact clause + amount
- [ ] **Develop Pricing Benchmark Lookup** — "What is our historical rate for this work category?" → structured data response
- [ ] **Implement Risk Query Interface** — "What are the outstanding risks for this counterparty?" → risk register summary
- [ ] **Develop Negotiation Preparation** — "What concessions did we make in similar negotiations?" → historical analysis
- [ ] **Implement chatbot with commercial boundaries** — Cannot approve commitments, cannot override delegated authority limits

### Phase 6: Predictive Commercial Intelligence
- [ ] **Implement counterparty risk prediction** — From payment history, market conditions, performance trends
- [ ] **Develop cost escalation forecasting** — From commodity data, currency trends, historical variation patterns
- [ ] **Implement negotiation outcome prediction** — From historical negotiation data and counterparty patterns
- [ ] **Develop cash flow prediction** — From contract milestones, payment terms, historical payment patterns
- [ ] **Implement dashboard interface** — Real-time commercial data visualization with trend analysis

### Phase 7: Approval Routing and Governance
- [ ] **Implement value-based approval routing** — Route commercial documents through delegated authority matrix
- [ ] **Develop approval workflow engine** — Sequential/Parallel/Hybrid routing with HITL integration
- [ ] **Implement escalation triggers** — Auto-escalation when value thresholds or compliance issues detected
- [ ] **Develop audit trail for approvals** — Immutable log of all approvers, timestamps, decisions
- [ ] **Implement delegated authority matrix** — Configurable limits for commercial commitments by role

### Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement non-delegable decision controls** — Final commercial commitments always require authorized signatory
- [ ] **Develop uncertainty disclosure** — AI must disclose when financial figures are estimates or assumptions
- [ ] **Implement immutable audit trail** — Log all AI outputs with provenance tags for contract-derived values
- [ ] **Develop human review gates** — Tenders, claims, strategic documents require human commercial review
- [ ] **Implement data retention and privacy** — Compliance with contract confidentiality, regulatory requirements

## Discipline Context

### 00250 Commercial Scope
The 00250 Commercial discipline encompasses:
- **AI-Native Operations**: Automating commercial work from document generation to predictive analytics
- **Contract Analysis Pipeline**: Document ingestion, clause extraction, structured JSON, obligation tracking
- **Document Generation Pipeline**: Six-phase automated document production (Pre-Bid through Strategic)
- **Multi-Agent Orchestration**: Coordinated agent workflow from market intelligence through contract execution
- **Approval Routing**: Value-based routing through delegated authority matrix
- **Supplier Evaluation**: Automated scoring and recommendation with configurable criteria
- **Natural Language Interface**: Contract queries, pricing benchmarks, risk queries, negotiation preparation
- **Commercial Compliance Monitoring**: Obligation tracking, milestone verification, regulatory compliance
- **Commercial Governance**: AI boundaries, human review gates, audit trails, authorized signatory controls

### Related Disciplines
- **01900 Procurement**: Procurement execution, supplier management, tender processes
- **00400 Contracts**: Contract formation, legal review, dispute resolution
- **01750 Legal**: Legal compliance, regulatory interpretation
- **01200 Finance**: Financial management, payment processing, cash flow
- **02000 Project Controls**: Cost control, schedule tracking, performance measurement
- **00876 Directors**: Strategic oversight, board reporting

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 00250 Commercial AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/00250-commercial/agent-data/domain-knowledge/
- Reference AI-native operations documentation (Part 6B in DOMAIN-KNOWLEDGE.MD)
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 00250-commercial", "ai-native-operations", "[specific-capability]"
- Filter by tags: "document-generation", "contract-analysis", "supplier-evaluation", "multi-agent-orchestration", "approval-routing"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with commercial domain knowledge and glossary
- Check memory for recent commercial AI implementation patterns

**Commercial AI-Native Context:**
- Reference text-native vs structured-data-native input classification
- Apply contract analysis pipeline (ingestion → clause extraction → validation → structured JSON → obligation tracking)
- Follow document generation pipeline (structured data injection from contract registry, pricing database, risk register)
- Respect non-delegable human decisions (final commitments, contract execution, authorized signatory)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar commercial AI implementations
- Build on established commercial organizational knowledge
- Ensure compliance with contract terms, delegated authority, and audit requirements

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## Commercial AI-Native Use Case Templates

### Contract Analysis Pipeline Execution
```
Process [CONTRACT_DOCUMENT] using contract analysis pipeline:

PARA Navigation:
- Access docs_construct_ai/disciplines/00250-commercial/agent-data/domain-knowledge/00250_DOMAIN-KNOWLEDGE.MD
- Reference contract analysis pipeline: Part 6B, Section 6B.1
- Check docs_construct_ai/disciplines/00250-commercial/agent-data/ for extraction schemas

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00250-commercial", "contract-analysis", "[document-type]"
- Filter by tags: "clause-extraction", "provenance-tracking", "obligation-tracking"

Memory Context:
- Include memory headers with contract analysis gigabrain_tags
- Cross-reference with agent capabilities and contract registry
- Reference historical contract analysis patterns

COMMERCIAL AI-NATIVE CONTEXT:
- Apply contract analysis pipeline: Ingestion → Clause Extraction → Schema Validation → Structured JSON → Obligation Tracking
- Use extraction schema for document type (Contract, Tender, Variation Order, etc.)
- Enforce guard rails: LLM cannot create/edit financial values or contractual obligations
- Implement provenance tracking: source document, version, extraction timestamp

Provide contract analysis implementation with:
- Preprocessing steps (document parsing, section identification, clause boundary detection)
- Clause extraction schema with all required fields per clause type
- Schema validation rules (mandatory clauses, numerical ranges, consistency checks)
- Structured data output format (JSON schema for contract registry)
- Provenance tagging implementation
- Human verification workflow before AI uses extracted contract data
```

### Document Generation Pipeline Execution
```
Implement [DOCUMENT_TYPE] generation using commercial AI pipeline:

PARA Navigation:
- Access docs_construct_ai/disciplines/00250-commercial/agent-data/domain-knowledge/00250_DOMAIN-KNOWLEDGE.MD
- Reference document generation pipeline: Part 6B, Section 6B.3
- Check docs_construct_ai/disciplines/00250-commercial/agent-data/ for agent capabilities

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00250-commercial", "document-generation", "[document-type]"
- Filter by tags: ["pre-bid", "tender", "negotiation", "contract-execution", "operational", "strategic"]

Memory Context:
- Include memory headers with document-specific gigabrain_tags
- Cross-reference with related discipline requirements (procurement, finance, legal)
- Reference historical document templates and patterns

COMMERCIAL AI-NATIVE CONTEXT:
- Apply document generation phase (Pre-Bid through Strategic)
- Use template engine with structured data injection from contract registry, pricing database, risk register (not raw LLM text)
- Follow quality validation: completeness checks, contractual accuracy verification
- Implement approval routing based on value thresholds and delegated authority matrix

Provide document generation implementation with:
- Template structure with all placeholders mapped to data sources
- Data extraction from source systems (contract registry, pricing database, risk register)
- Quality validation rules before document generation
- Approval routing and human review requirements
- Output format specification (PDF, DOCX, structured JSON, email)
```

### Multi-Agent Commercial Orchestration
```
Coordinate multi-agent workflow for [COMMERCIAL_PROCESS]:

PARA Navigation:
- Access docs_construct_ai/disciplines/00250-commercial/agent-data/domain-knowledge/00250_DOMAIN-KNOWLEDGE.MD
- Reference multi-agent orchestration: Part 6B, Section 6B.4
- Check docs_construct_ai/disciplines/00250-commercial/agent-data/00250_AGENTS.md for agent definitions

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00250-commercial", "multi-agent-orchestration", "[process-type]"
- Filter by tags: "agent-handoff", "data-flow", "workflow-automation"

Memory Context:
- Include memory headers with agent orchestration gigabrain_tags
- Cross-reference with agent capabilities and data formats
- Reference completed implementations of similar workflows

COMMERCIAL AI-NATIVE CONTEXT:
- Apply standard orchestration pattern: Market Intelligence → Commercial Strategy → Tender → Supplier Evaluation → Negotiation → Contract Execution → Performance Monitoring → Risk Tracking
- Define data formats passed between agents (structured JSON, not free text)
- Implement commercial boundaries: no agent can approve commitments, no agent can override delegated authority

Provide agent orchestration implementation with:
- Agent coordination sequence with trigger conditions
- Data schema passed between agents
- Error handling and escalation when agent cannot process
- Quality validation checkpoints between agent handoffs
- Human intervention points in the workflow
- Audit trail tracking for all agent actions and decisions
```

### Supplier Evaluation Execution
```
Implement [EVALUATION_TYPE] using supplier evaluation capability:

PARA Navigation:
- Access docs_construct_ai/disciplines/00250-commercial/agent-data/domain-knowledge/00250_DOMAIN-KNOWLEDGE.MD
- Reference supplier evaluation: Part 6B, Section 6B.4
- Check docs_construct_ai/skills/domainforge_ai/00250-commercial/supplier-evaluation/SKILL.md

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00250-commercial", "supplier-evaluation", "[evaluation-type]"
- Filter by tags: "scoring-engine", "criteria-matrix", "recommendation"

Memory Context:
- Include memory headers with supplier evaluation gigabrain_tags
- Cross-reference with existing supplier-evaluation skill
- Reference historical evaluations and scoring patterns

COMMERCIAL AI-NATIVE CONTEXT:
- Apply configurable scoring engine with criteria matrix
- Use structured data from supplier performance database
- Generate evaluation report with AI synthesis and recommendations

Provide supplier evaluation implementation with:
- Evaluation criteria configuration (capability, financial stability, quality, safety, experience)
- Scoring algorithm with configurable weights
- Data sources for supplier performance information
- Report generation with structured output
- Human review and acceptance workflow
- Audit trail of evaluation decisions
```

## Automation Spectrum for Commercial Tasks

### Fully Automatable Tasks (Human-Free Generation)
The AI can independently execute these tasks with structured data input, requiring only final human review before distribution:

| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **Contract Clause Extraction** | Contract received | Contract document, clause index | Auto-validation: clauses extracted accurately |
| **Commercial Correspondence** | Project update requires communication | Project data, correspondence template | Commercial manager reviews before sending |
| **Risk Register Update** | New issue logged | Issue log, risk criteria | Auto-validation: risk scoring consistent |
| **Approval Routing** | Document submitted | Document type, value, authority matrix | Auto-routed to correct approver |
| **Market Report Compilation** | Reporting period | Market data sources, template | Auto-validation: data sources verified |
| **Supplier Compliance Monitoring** | Performance data available | Supplier performance metrics | Alert when thresholds exceeded |
| **Obligation Tracking Report** | Milestone due | Contract obligations, milestone dates | Auto-validation: obligation status current |
| **Tender Analysis Report** | Bids received | Tender responses, evaluation criteria | Commercial manager validates scoring |
| **Performance Dashboard Update** | Data refresh | KPI data, contract status | Auto-populated from structured sources |
| **Commercial Audit Trail** | Any commercial action | All commercial documents and decisions | Immutable log, auto-generated |

### AI-Augmented Tasks (AI + Human Co-Creation)
The AI drafts, suggests, or analyses — human specialist reviews and finalizes:

| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Negotiation Strategy** | Counterparty analysis, BATNA assessment, historical concessions | Lead negotiator finalizes position | Human |
| **Tender Document Preparation** | Template filling, scope compilation, criteria selection | Commercial manager reviews and approves | Human |
| **Commercial Risk Assessment** | Risk identification, scoring based on historical data | Commercial director reviews and accepts risk | Human |
| **Pricing Analysis** | Historical rates, market benchmarks, cost escalation trends | Commercial manager validates pricing | Human |
| **Claim Quantification** | Contract clause identification, impact calculation | Senior commercial reviews evidence | Human |
| **Variation Order Analysis** | Rate application, impact assessment, precedent analysis | PM/Commercial director approves | Human |
| **Counterparty Risk Assessment** | Financial analysis, market conditions, performance history | Commercial director decides on counterparty | Human |

### Human-Led Tasks (AI Informs, Human Decides)
The AI provides data, context, and recommendations — human makes the final decision or action:

| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Final Contract Execution** | Compile all terms, conditions, approvals | Authorized signatory executes |
| **Strategic Commercial Decisions** | All commercial data, market intelligence, recommendations | Commercial director decides |
| **Dispute Resolution** | Contract terms, evidence, precedent, position analysis | Legal team + commercial director decide |
| **Counterparty Acceptance/Rejection** | Due diligence report, risk assessment, recommendation | Executive approval |
| **Board-Level Presentations** | Data compilation, trend analysis, visualizations | Board member presents |
| **Escalation Beyond Authority** | All relevant data, analysis, recommendation | Senior management decides |

## Document Generation Pipeline

### Pipeline Architecture
All AI-generated commercial documents flow through a consistent pipeline with quality gates at each stage:

```
INPUT DATA COLLECTION (contracts, bids, market data, supplier data)
    ↓
STRUCTURED DATA VALIDATION (schema, completeness, authority verification)
    ↓
TEMPLATE SELECTION & CONFIGURATION (document type, project context, counterparty)
    ↓
DATA INJECTION INTO TEMPLATE PLACEHOLDERS (structured data, not raw LLM text)
    ↓
QUALITY VALIDATION (completeness, accuracy, contractual compliance)
    ↓
APPROVAL ROUTING (value-based routing through delegated authority matrix)
    ↓
FINAL APPROVAL (authorized signatory for commercial commitments)
    ↓
OUTPUT GENERATION (PDF, DOCX, structured JSON, email)
    ↓
VERSION CONTROL & AUDIT LOG
    ↓
DISTRIBUTION & ARCHIVAL
```

### Template Design Principles
1. **Structured Data Injection, Not Raw Generation**: All templates use placeholders filled from verified structured data sources (contract registry, pricing database, risk register). The LLM structures and formats, but does not invent financial figures or contractual obligations.
2. **Provenance Tracking**: Every data point injected into a template is tagged with its source (e.g., "contract value from contract_registry_v2, contract_id: CON-2026-0042, extracted: 2026-04-01").
3. **Delegation-Aware**: Commercial documents are routed for approval based on value thresholds and delegated authority matrix. Documents exceeding authority limits are automatically escalated.
4. **Regulatory and Contractual Accuracy**: All references to contract clauses, regulations, and commercial terms are validated against the source contract and current regulations.
5. **Conditional Logic**: Templates include logic to add or omit sections based on data availability (e.g., "if variation order value exceeds 10% of contract sum, include escalation clause reference").
6. **Audit-Ready**: All generated documents include audit trail showing data sources, template version, approver chain, and authorization history.

## AI-Native Commercial Capabilities Beyond Automation

### Predictive Commercial Intelligence
- **Counterparty Risk Prediction**: Forecast contractor/supplier financial distress from payment history, market conditions, credit ratings, and performance trends
- **Cost Escalation Forecasting**: Predict cost increases from commodity price trends, currency fluctuations, and historical variation patterns
- **Negotiation Outcome Prediction**: Predict likely negotiation outcomes from historical negotiation data, counterparty behavior patterns, and market conditions
- **Cash Flow Prediction**: Forecast cash flow from contract milestones, payment terms, and historical payment patterns

### Multi-Agent Orchestration
- **Commercial Workflow Chain**: Opportunity identification → Commercial strategy → Tender preparation → Supplier evaluation → Negotiation → Contract execution → Performance monitoring → Risk tracking
- **Agent Handoff Pattern**: Market Intelligence Agent → Procurement Agent → Contract Management Agent → Commercial Coordinator → Finance Agent
- **Quality Gates**: Automated completeness and accuracy checks at each agent handoff

### Natural Language Commercial Interface
- **Contract Query Assistant**: "What are the liquidated damages for contract CON-2026-042?" → exact clause + amount + reference
- **Pricing Benchmark Lookup**: "What is our historical rate for electrical installation?" → structured data response from pricing database
- **Risk Query Interface**: "What are the outstanding risks for Counterparty X?" → summarized risk register entries
- **Negotiation Preparation**: "What concessions did we make in similar negotiations with this contractor?" → historical negotiation analysis

### Commercial Compliance Monitoring
- **Automated Obligation Tracking**: Continuous monitoring of contractual obligations, milestones, and deliverables
- **Change Order Monitoring**: Variation orders tracked against contract thresholds with automated escalation
- **Performance Bond Tracking**: Automated alerts for expiring performance bonds and guarantees
- **Regulatory Compliance Checking**: Commercial activities verified against applicable regulations and company policies

## AI Safety Boundaries — What Must NOT Be Automated

Certain decisions and actions must remain under human control for legal, ethical, and commercial reasons:

**Non-Delegable Human Decisions:**
- Final commercial commitment or contract execution (must be done by authorized signatory)
- Acceptance of onerous contractual terms or liability caps (requires legal + commercial director review)
- Strategic commercial decisions including dispute settlement amounts or waiver of contractual rights
- Escalation beyond delegated authority limits without appropriate management approval
- Acceptance of counterparty risk that exceeds organizational risk tolerance
- Commercial correspondence that admits liability or waives contractual rights
- Settlement of disputes or claims above delegated authority limits

**AI Must Always Disclose:**
- When contractual obligations are based on LLM interpretation of contract language (not verified structured data)
- When financial figures are estimates or assumptions (not validated against source data)
- When the AI has identified a potential contractual obligation or risk that requires specialist review
- When precedent or market benchmarks used are outdated or from different jurisdictions
- When negotiation recommendations are based on historical patterns that may not apply to current situation
- What delegated authority limits apply to any commercial recommendation

## Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| **Document generation** | Template engine with structured data injection from contract registry, pricing database, risk register |
| **Contract analysis** | NLP pipeline for clause extraction with human-verified clause index and cross-reference checking |
| **Pricing and cost analysis** | Direct integration with cost databases, pricing schedules, and ERP systems; LLM handles analysis and reporting |
| **Supplier evaluation** | Scoring engine with configurable criteria; LLM synthesizes evaluation reports and recommendations |
| **Negotiation support** | Knowledge graphs from historical negotiations; LLM develops strategy documents and position papers |
| **Risk management** | Structured risk register with automated scoring; LLM analyzes trends and generates reports |
| **Knowledge retrieval** | Vector database for contracts, commercial policies, legal precedents (RAG pattern with source verification) |
| **Audit trail** | Immutable log of all AI-generated commercial documents with provenance tags, data sources, and approval history |

## AI Agent Coordination Workflow

```
Market Intelligence Agent identifies opportunity or market change
    ↓
Commercial Coordinator Agent initiates commercial strategy development
    ↓
Procurement Agent prepares tender documents with AI drafting support
    ↓
Suppliers submit bids → Supplier Evaluation Agent scores proposals
    ↓
Contract Management Agent extracts key terms from top proposals
    ↓
Commercial Coordinator develops negotiation strategy with AI support
    ↓
Negotiation phase → AI drafts counter-offers and position papers
    ↓
Contract executed → Contract Management Agent begins obligation tracking
    ↓
Operational phase → Commercial correspondence, risk monitoring, performance reporting
    ↓
Finance Agent monitors payments, milestones, and cash flow
    ↓
End of project → Commercial audit and lessons learned
```

## Implementation Best Practices

### Agent Coordination Guidelines
1. **Start with document generation** — highest ROI, lowest risk commercial automation
2. **Implement one agent capability** at a time, validate, then add next
3. **Engage QualityForge AI** for all validation and quality assurance before deployment
4. **Define clear authority boundaries** in prompts and configuration from day one
5. **Document all agent decisions** with audit trail for regulatory and legal compliance
6. **Never let LLM generate financial values** — always route through structured data sources

### Commercial Boundary Enforcement
1. **Never allow AI to approve final commercial commitments** — always require authorized signatory
2. **Never allow AI to execute contracts or amendments** without human review
3. **Never allow AI to waive contractual rights or admit liability** in correspondence
4. **Always disclose AI limitations** — calculation scope, data coverage, assumption validity
5. **Always maintain immutable audit trail** for all AI decisions and outputs
6. **Always tag contract-derived values** with provenance (source contract, clause, extraction timestamp)

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ accuracy in generated documents vs source systems (contract registry, pricing data)
- **Timeliness**: 80%+ reduction in commercial document preparation time vs manual methods
- **Review Efficiency**: 50%+ reduction in human review cycles through pre-validation
- **Compliance**: 100% of tender documents generated within required timeframes

### Contract Analysis Metrics
- **Extraction Accuracy**: 95%+ of extracted clauses match manual extraction from contracts
- **Schema Validation Pass Rate**: 90%+ of contracts pass validation on first extraction
- **Provenance Coverage**: 100% of contract-derived values have provenance tags
- **Human Verification Time**: 50%+ reduction vs manual clause extraction from contracts

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of agent workflow sequences complete without failure
- **Latency**: End-to-end agent handoff <10 seconds for each transition
- **Error Recovery**: 100% of failed agent executions recovered or escalated to human
- **Audit Trail Integrity**: 100% of agent actions logged with source, timestamp, and decision

### Approval Routing Metrics
- **Routing Accuracy**: 100% of documents routed to correct approver based on authority matrix
- **Cycle Time Reduction**: 60%+ reduction in approval cycle time vs manual routing
- **Escalation Accuracy**: 100% of threshold violations correctly escalated
- **Audit Trail**: 100% of approvals logged with approver identity, timestamp, and decision

## Version History

- **v1.0** (2026-04-01): Initial AI-Native Commercial Operations Prompt Template
- Added structured metadata header following civil engineering template format
- Incorporated lessons learned from Safety and Civil Engineering domains' automation spectrum and document generation pipeline patterns
- Created commercial-specific use case templates for contract analysis, document generation, supplier evaluation, and agent orchestration
- Defined automation spectrum for all commercial tasks (Full, Augmented, Human-Led)
- Built comprehensive document generation pipeline with quality gates and template design principles
- Added contract analysis pipeline architecture with guard rails and provenance tracking
- Included approval routing with delegated authority matrix integration
- Detailed success metrics for all AI capabilities
- Added implementation best practices and commercial boundary enforcement

## Commercial AI Agent Behavioral Rules

### Non-Negotiable Rules for All Commercial AI Agents

1. **Authority Limit Rule:** Never approve commercial commitments that exceed defined delegated authority limits. Always route to appropriate approval chain.

2. **No Financial Fabrication Rule:** Never invent financial figures, pricing, or cost data. Only use values from verified structured data sources (pricing database, cost database, contract registry).

3. **Provenance Tracking Rule:** All contract-derived values must carry provenance tags (source contract, version, clause reference, extraction timestamp). Never present extracted values without source attribution.

4. **No Guessing Rule:** If contractual obligations, pricing data, or market rates are unclear, flag as "unknown — verify with source data." Never assume contractual terms or prices.

5. **Specialist Referral Rule:** When a question exceeds the agent's competency boundary (legal interpretation, complex financial modeling), explicitly recommend specialist input.

6. **Contract Reference Rule:** When making a contractual assertion, cite the applicable contract clause and provision. If uncertain, state "I would need to verify this against the source contract."

7. **Liability Disclaimer Rule:** Never draft correspondence that admits liability or waives contractual rights without commercial manager review and approval.

8. **Documentation Rule:** All recommendations should be structured so they could appear in a professional commercial memo or report. Use formal, auditable language.

9. **Respect Non-Delegable Decisions:** Never execute final contracts, accept onerous terms, settle disputes, or waive contractual rights. These require authorized human signatory and legal review.

10. **Audit Trail Rule:** All AI outputs, data extractions, and recommendations must be recorded with full audit trail for regulatory review, legal proceedings, and continuous improvement.