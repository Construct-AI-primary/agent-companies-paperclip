---
title: 01900 Procurement AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw agents to implement procurement code including order creation workflows, supplier management, approval routing, contract intelligence, document generation, VFS integration, compliance validation, and UI components with structured data architecture and safety boundaries
version: 2.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01900_procurement/agent-data/prompts
gigabrain_tags: disciplines, 01900_procurement, ai-native-operations, document-generation, automation-spectrum, multi-agent-orchestration, code-generation, ui-components, workflow-development, vfs-integration, compliance-validation, supplier-cards
openstinger_context: procurement-development, code-generation, agent-driven-development, vfs-integration, compliance-validation
last_updated: 2026-04-02
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_GLOSSARY.MD
  - docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD
  - docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_PROCUREMENT_WORKFLOW_TECHNICAL_SPEC.MD
  - docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_PROCUREMENT_ARCHITECTURE.MD
  - docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_PROCUREMENT_COMPREHENSIVE_WORKFLOW.MD
---

# 01900 Procurement AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement procurement features on large-scale construction, infrastructure, and engineering projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant procurement code. Use this prompt when agents are developing procurement components, workflows, APIs, or UI elements.

**Key Lesson from Safety and Civil Domains:** Agents must understand what procurement code they can generate independently vs. what requires human architect review. The Text-Native vs Structured Data architecture pattern prevents agents from generating code that fabricates procurement data or bypasses validation.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Data Architecture Understanding
- [ ] **Identify all procurement data sources** — ERP tables, supplier tables, contract management, order tables, VFS metadata tables
- [ ] **Map data flow for order creation** — Requisition → Supplier Selection → Approval → PO → Delivery → Invoice → Payment
- [ ] **Document existing validation rules** — Required fields, foreign keys, value ranges, authority limits, compliance rules
- [ ] **Identify provenance requirements** — What fields need source tracking, audit trail logging, VFS file hashes
- [ ] **Define what agents can generate** — Forms with validation, API endpoints, business logic; what must not be auto-generated — authority bypasses, approval workflow overrides, audit trail modifications, compliance rule modifications
- [ ] **Map VFS directory structure** — Understand /templates/, /references/, /working/, /outputs/, /memories/ hierarchy per order
- [ ] **Document supplier card structure** — supplier_id, certifications, products_services, logistics, performance_history, risk_profile, metadata

### Phase 2: Code Generation — Order Creation System
- [ ] **Generate order creation form components** — 5-phase wizard (Basic Info & Supplier Selection → Template Selection → Assign Disciplines → Approval Setup → Review & Create)
- [ ] **Implement Phase 1 procurement hierarchy filtering** — Group → Category → Item → Goods → Qualified Suppliers cascade
- [ ] **Implement supplier selection with VFS integration** — Supplier card display with compliance scoring, risk assessment, smart ranking
- [ ] **Implement form validation logic** — Required fields, data types, value ranges, cross-field dependencies, compliance checks
- [ ] **Generate order API endpoints** — POST /orders, PUT /orders/:id, GET /orders/:id, GET /orders/:id/vfs
- [ ] **Implement approval routing logic** — Value-based routing (currency-aware: USD and ZAR thresholds per domain knowledge Part 5.3 & 8.4)
- [ ] **Generate database migrations** — Order tables, approval tables, audit log tables, VFS metadata tables
- [ ] **Add data validation at each phase** — Phase gates that prevent progression with incomplete data
- [ ] **Implement VFS directory initialization** — Auto-create /templates/, /references/, /working/, /outputs/, /memories/ on order creation

### Phase 3: Code Generation — Document Generation System
- [ ] **Implement document template engine** — Placeholder injection from structured data (not hardcoded text)
- [ ] **Generate procurement document templates** — POs, RFQs, contracts, supplier evaluations, NCRs, PO Amendments, SOWs
- [ ] **Implement template rendering pipeline** — Template selection → data injection → quality validation → output generation
- [ ] **Add provenance tagging** — Every generated value tagged with source (e.g., `{source: "BOQ_v2", item: "concrete_C30"}`)
- [ ] **Implement version control** — Document revision tracking with immutable audit trail
- [ ] **Generate export handlers** — PDF, DOCX, structured JSON, Excel output
- [ ] **Implement VFS file operations** — Read/write/grep/list/delete for virtual filesystem with audit logging
- [ ] **Generate VFS API endpoints** — GET /vfs/:order_id/:path, PUT /vfs/:order_id/:path, DELETE /vfs/:order_id/:path

### Phase 4: Code Generation — Supplier Management System
- [ ] **Generate supplier card JSON structure** — supplier_id, certifications, products_services, logistics, performance_history, risk_profile, metadata
- [ ] **Generate supplier qualification UI** — Pre-qualification form, document upload, evidence attachment
- [ ] **Implement supplier evaluation scoring** — Weighted scoring: Technical 25%, Financial 20%, Delivery 20%, Quality 15%, Commercial 10%, Compliance 10%
- [ ] **Implement compliance scoring algorithm** — ISO 9001 (30% weight) + B-BBEE Level (30%) + Financial Stability (20%) + other factors (20%)
- [ ] **Generate supplier performance tracking** — KPI dashboard, delivery reliability charts, quality trend reports
- [ ] **Implement supplier tier assignment** — Platinum (90-100) / Gold (75-89) / Silver (60-74) / Bronze (40-59) / Suspended (<40)
- [ ] **Generate supplier directory UI** — Searchable, filterable supplier list with detail views, VFS card integration
- [ ] **Add risk assessment alerts** — Notifications for financial risk, delivery issues, compliance gaps
- [ ] **Implement supplier search with hierarchy filtering** — Group → Category → Item → Goods cascade, with expansion to parent categories as fallback

### Phase 5: Code Generation — Approval & Compliance System
- [ ] **Generate approval routing UI** — Dynamic approval chain display, pending approvals list
- [ ] **Implement authority matrix** — Role-based approval limits, escalation rules (USD: <$25k, $25k-$100k, >$100k; ZAR: <R500k, R500k-R2M, R2M-R10M, >R10M per domain knowledge Part 8.4)
- [ ] **Generate compliance validation** — Budget checks, regulatory requirements (CIDB, SARS VAT, B-BBEE, ISO standards per jurisdiction), audit trail logging
- [ ] **Implement jurisdiction-aware compliance engine** — Load compliance rules per organization jurisdiction (ZA, FI, etc.), validate suppliers against framework-specific requirements
- [ ] **Implement HITL integration** — Human-in-the-loop decision capture, reason logging for orders > threshold, contract awards, single-source justifications, budget overrides
- [ ] **Generate rejection handling** — Rejection reason capture, rework workflow, resubmission with audit trail
- [ ] **Add audit trail components** — All approvals/rejections logged with timestamp, user, decision, VFS access operations logged
- [ ] **Implement procurement policy compliance engine** — Pre-PO checks, pre-approval authority verification, pre-payment 3-way match, post-award contract compliance monitoring

### Phase 6: Code Generation — Contract Intelligence
- [ ] **Generate contract document viewer** — Clause highlighting, obligation list extraction, VFS document integration
- [ ] **Implement contract change tracking** — Change detection, impact analysis, affected orders, propagation to POs/framework agreements/budget commitments
- [ ] **Generate obligation tracking dashboard** — Deliverables, milestones, penalties, upcoming deadlines with fulfillment evidence tracking
- [ ] **Implement contract health checks** — Missing signatures (weekly), expired terms (monthly), unfulfilled obligations (weekly), insurance/certification expiry (monthly)
- [ ] **Generate contract comparison view** — Side-by-side clause comparison, change highlighting, risk level classification (standard/minor deviation/material deviation/missing clause)
- [ ] **Add dispute resolution components** — Evidence compilation, timeline display, clause reference links, VFS evidence document management

### Phase 7: Code Generation — Analytics & Reporting
- [ ] **Generate spend analytics dashboard** — Category breakdown, vendor concentration, trend charts (pie, tree map, bar, Pareto, line, time series)
- [ ] **Implement procurement KPI widgets** — Order cycle time (target ≤5 days), approval turnaround (≤24 hours), PO accuracy (≥98%), on-time delivery (≥90%), budget variance (≤±5%), savings rate (≥3%), supplier quality (≥98%), audit compliance (100%)
- [ ] **Generate cost variance reports** — Budget vs. actual, variance causes (price_increase, scope_change, quantity_variance, timing), corrective action tracking with responsible party and due date
- [ ] **Implement supplier quality trending** — Inspection result charts, quality score over time, NCR frequency tracking
- [ ] **Generate export report handlers** — Scheduled reports, ad-hoc report builder, multi-format export
- [ ] **Add predictive analytics placeholders** — Risk prediction UI, price forecasting display (integrate with ML service later)
- [ ] **Implement fraud detection patterns** — Invoice splitting detection, duplicate invoicing, phantom supplier detection, price manipulation alerts, circular approval detection

### Phase 8: Code Generation — Safety Boundaries & Governance Enforcement
- [ ] **Implement authority enforcement** — Hard blocks preventing unauthorized approvals (no bypasses, no auto-approval logic)
- [ ] **Generate audit trail logging** — All procurement actions logged with user, timestamp, action, data_before, data_after (append-only, immutable, 10-year retention minimum)
- [ ] **Implement data validation middleware** — All procurement inputs validated before processing (forms, API params, file uploads, VFS operations)
- [ ] **Generate uncertainty disclosure UI** — Flags when inputs unverified, calculations limited, single-source risks identified
- [ ] **Implement human review gates** — Contract awards, orders > threshold, single-source justifications, budget overrides, supplier suspensions require human sign-off
- [ ] **Add data retention handlers** — Archival, anonymization, compliance with data privacy (GDPR/POPIA), configurable retention policies
- [ ] **Implement VFS audit logging** — All VFS file access (read, write, grep, list, delete) logged with agent_id, order_id, file_path, operation, timestamp

## Discipline Context

### 01900 Procurement Development Scope
The 01900 Procurement discipline codebase encompasses:
- **Order Creation System**: 5-phase wizard, approval routing, HITL integration
- **Document Generation System**: Template engine, provenance tracking, multi-format export
- **Supplier Management System**: Qualification, evaluation, performance tracking, tiering
- **Approval & Compliance System**: Authority matrix, compliance validation, audit logging
- **Contract Intelligence**: Clause analysis UI, obligation tracking, change propagation
- **Analytics & Reporting**: Spend analytics, KPIs, cost variance, quality trending
- **Safety & Governance**: Authority enforcement, audit trails, human review gates

### Related Disciplines (Code Dependencies)
- **00435 Contracts Post-Award**: Contract amendment flows, document integration APIs
- **01700 Logistics**: Delivery tracking components, material receipt flows
- **01200 Finance**: Budget validation middleware, payment processing integration
- **00888 Procurement Director**: Executive dashboard, strategic metrics aggregation
- **02400 Safety**: Hazardous materials compliance checks, safety protocol validation

## Core Agent Template Structure

```
[TASK: Generate procurement code component]

Using the Construct AI memory system with Gigabrain for 01900 Procurement AI-Native Development:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/
- Reference domain knowledge for business rules and data requirements
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 01900_procurement", "ai-native-operations", "[specific-capability]"
- Filter by tags: "document-generation", "contract-intelligence", "supplier-intelligence", "multi-agent-orchestration"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with procurement domain knowledge for business rules
- Check for recent procurement code implementations and patterns

**Procurement Development Context:**
- Reference text-native vs structured-data architecture (data flows, validation points)
- Apply document generation principles (template-based output, not hardcoded text)
- Respect safety boundaries in code (no authority bypasses, no audit modification, human review gates enforced)
- Follow procurement data validation patterns at every entry point

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns from existing procurement implementations
- Build on established organizational code patterns
- Ensure compliance with procurement audit and governance requirements

[SPECIFIC CODE GENERATION REQUIREMENTS]
```

## Procurement Development Use Case Templates

### Generate Order Creation Component
```
Generate [ORDER_COMPONENT] for procurement order creation:

PARA Navigation:
- Access docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/01900_DOMAIN-KNOWLEDGE.MD
- Reference order creation workflow: workflow_docs/1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD
- Check existing order components for patterns and conventions

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "order-creation", "[component-type]"
- Filter by tags: "procurement-workflows", "form-generation", "validation-logic"

Memory Context:
- Include memory headers with order-specific gigabrain_tags
- Cross-reference with finance discipline for budget validation integration
- Reference existing order processing components

PROCUREMENT DEVELOPMENT CONTEXT:
- Apply 5-phase order creation architecture (Basic Info → Template → Disciplines → Approval → Review)
- Use validated form patterns from existing procurement components
- Implement data validation at each phase gate
- Respect approval routing based on order value thresholds

Provide complete code with:
- Frontend component with form fields, validation rules, error handling
- Backend API endpoint with input validation, authorization checks
- Database model/schema with required fields, relationships, indexes
- Integration points (budget validation, approval routing)
- Unit test patterns covering validation, authorization, data integrity
```

### Generate Document Generation Component
```
Generate [DOCUMENT_COMPONENT] for procurement document generation:

PARA Navigation:
- Access docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/01900_DOMAIN-KNOWLEDGE.MD
- Reference document templates and data requirements
- Check existing document generation patterns

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "document-generation", "[document-type]"
- Filter by tags: "template-engineering", "export-generation", "provenance-tracking"

Memory Context:
- Include memory headers with document-specific gigabrain_tags
- Cross-reference with template definitions and data schemas
- Reference existing export implementations

PROCUREMENT DEVELOPMENT CONTEXT:
- Use structured data injection pattern (template + data, not hardcoded output)
- Implement provenance tracking on all generated values
- Apply conditional logic for optional sections
- Ensure multi-format export capability (PDF, DOCX, JSON, Excel)

Provide complete code with:
- Template definition with placeholder schema
- Data injection logic with source tracking
- Quality validation before output generation
- Export handlers for each format
- Unit tests for template rendering, provenance, export
```

### Generate Supplier Management Component
```
Generate [SUPPLIER_COMPONENT] for supplier management:

PARA Navigation:
- Access docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/01900_DOMAIN-KNOWLEDGE.MD
- Reference supplier qualification criteria and evaluation methods
- Check existing supplier component patterns

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "supplier-management", "[component-type]"
- Filter by tags: "supplier-qualification", "vendor-evaluation", "performance-monitoring"

Memory Context:
- Include memory headers with supplier-specific gigabrain_tags
- Cross-reference with logistics discipline for delivery performance integration
- Reference existing supplier components

PROCUREMENT DEVELOPMENT CONTEXT:
- Implement qualification tier logic (Platinum/Gold/Silver/Bronze)
- Apply performance monitoring patterns with KPI tracking
- Use risk assessment frameworks for alert generation
- Follow supplier directory search and filter patterns

Provide complete code with:
- Frontend components (qualification form, evaluation dashboard, directory UI)
- Backend logic (scoring algorithms, tier assignment, risk calculation)
- Database models (supplier, qualification, performance metrics, alerts)
- Integration points (delivery data from logistics, financial data from finance)
- Unit tests for scoring, tiering, alerts, search filtering
```

### Generate Approval & Compliance Component
```
Generate [APPROVAL_COMPONENT] for procurement approval and compliance:

PARA Navigation:
- Access docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/01900_DOMAIN-KNOWLEDGE.MD
- Reference approval workflow and authority matrix definitions
- Check compliance validation requirements

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "approval-routing", "[component-type]"
- Filter by tags: "approval-matrix", "value-based-routing", "compliance-validation"

Memory Context:
- Include memory headers with approval-specific gigabrain_tags
- Cross-reference with finance discipline for authority limits
- Reference existing approval implementations

PROCUREMENT DEVELOPMENT CONTEXT:
- Apply value-based approval matrix (<$25k, $25k-$100k, >$100k thresholds)
- Use sequential/parallel/hybrid routing patterns
- Implement HITL decision capture and reason logging
- Enforce audit trail on all approval actions

Provide complete code with:
- Approval routing logic with authority matrix enforcement
- HITL decision capture with reason logging
- Audit trail middleware for all approval actions
- Compliance validation (budget checks, regulatory requirements)
- Rejection handling with rework workflow
- Unit tests for routing, authority enforcement, audit logging
```

## Automation Spectrum for Procurement Code Generation

### Agent Can Generate Independently (Full Automation)
The agent can generate these components and code patterns without architect review:

| Component Type | Input Requirements | Validation Gate |
|----------------|-------------------|-----------------|
| **Form Components** | Field schema, validation rules, data source | All required fields, validation logic correct |
| **API Endpoints** | Route definition, data schema, authorization level | Input validation, auth checks, error handling |
| **Display Components** | Data schema, UI pattern library | Data binding correct, responsive design |
| **Report Handlers** | Report schema, data sources, export format | Query optimized, export validated |
| **Database Models** | Entity schema, relationships | Foreign keys, indexes, constraints correct |
| **Audit Log Middleware** | Event schema, logging requirements | Immutable logging, all actions captured |

### Agent Should Generate + Human Review (Augment)
The agent generates code but requires human architect review before merge:

| Component Type | Agent Contribution | Human Review Focus |
|----------------|-------------------|-------------------|
| **Approval Routing Logic** | Authority matrix implementation, routing algorithm | Authority limits correct, escalation paths valid |
| **Business Logic Services** | Scoring algorithms, calculation logic, validation rules | Business rules match domain knowledge, edge cases handled |
| **Integration Services** | API integration patterns, data sync logic | Error handling, idempotency, security |
| **Analytics Queries** | Aggregation logic, KPI calculations | Query correctness, performance, data accuracy |
| **Template Definitions** | Document templates with conditional sections | Business rules correct, regulatory compliance |

### Human Must Lead (Agent Informs)
Human architect designs, agent supports with code patterns:

| Component Type | Agent Support | Human Decision |
|----------------|--------------|----------------|
| **Authority Matrix Design** | Implementation patterns, enforcement code | Authority structure, approval limits |
| **Security Architecture** | Security middleware patterns, encryption utilities | Security requirements, threat model |
| **Compliance Framework** | Validation code, audit patterns | Regulatory requirements, compliance scope |
| **Data Architecture** | Migration patterns, indexing utilities | Schema design, data relationships |

## Component Generation Pipeline

### Pipeline Architecture
All AI-generated procurement code flows through a consistent generation pipeline:

```
REQUIREMENTS ANALYSIS (domain knowledge, workflow docs, data schemas)
    ↓
PATTERN IDENTIFICATION (existing component patterns, conventions)
    ↓
ARCHITECTURE DESIGN (component structure, data flow, integration points)
    ↓
CODE GENERATION (frontend, backend, database, tests)
    ↓
VALIDATION (business rules, security, data integrity, error handling)
    ↓
HUMAN REVIEW (where required — approval logic, compliance, security)
    ↓
CODE REVIEW & MERGE
    ↓
DEPLOYMENT & INTEGRATION
```

### Code Generation Principles
1. **Structured Data Binding, Not Hardcoded Values**: All components use data binding from defined schemas. Components display data from sources, not hardcoded text.
2. **Validation at Every Entry Point**: All data entry (forms, API endpoints, file uploads) validated against schema before processing.
3. **Provenance Tracking**: All generated values tagged with source data origin (ERP field, calculation, imported data).
4. **Audit Trail Enforcement**: All procurement actions (create, update, approve, reject) logged with user, timestamp, action, data.
5. **Human Review Gates**: Authority enforcement, approval routing, and compliance validation require human architect review.
6. **Error Handling Completeness**: All components include error states, loading states, and recovery mechanisms.

## Agent Can Generate These Components

### Frontend Components
| Component Category | Specific Components | Key Patterns |
|--------------------|--------------------|--------------|
| **Order Forms** | Order creation wizard, requisition form, approval form | 5-phase wizard, validation, progress indicator |
| **Supplier UI** | Qualification form, evaluation dashboard, supplier directory | Tiered display, scoring, search/filter |
| **Contract UI** | Contract viewer, clause comparison, obligation tracker | Clause highlighting, diff view, deadline alerts |
| **Approval UI** | Pending approvals list, approval detail, rejection form | Dynamic routing, authority display, reason capture |
| **Dashboard** | Spend analytics, KPI widgets, trend charts | Data aggregation, chart rendering, export |
| **Alert & Notification** | Risk alerts, deadline warnings, compliance flags | Severity display, dismiss action, escalation |

### Backend Components
| Component Category | Specific Services | Key Patterns |
|--------------------|-------------------|--------------|
| **Order Service** | Order CRUD, validation, approval routing | Transaction management, event emission |
| **Document Service** | Template rendering, export generation, provenance | Template injection, multi-format export |
| **Supplier Service** | Scoring, tier assignment, risk calculation | Weighted scoring, threshold evaluation |
| **Compliance Service** | Budget validation, regulatory checks, audit logging | Rule evaluation, middleware chain |
| **Analytics Service** | Spend aggregation, KPI calculation, trending | Time-series aggregation, caching |
| **Notification Service** | Alert generation, dispatch, escalation | Event-driven, retry logic, escalation |

### Database Components
| Component Category | Specific Migrations | Key Patterns |
|--------------------|--------------------|--------------|
| **Order Tables** | orders, order_items, order_approvals, order_audit | Foreign keys, indexes, audit trigger |
| **Supplier Tables** | suppliers, qualifications, performance_metrics, alerts | Tier enum, scoring columns, alert table |
| **Contract Tables** | contracts, contract_clauses, obligations, changes | Clause JSON, obligation tracking, change log |
| **Approval Tables** | approval_chains, approval_actions, authority_matrix | Routing logic, action audit trail |
| **Analytics Tables** | spend_records, kpi_snapshots, trend_data | Time-series, aggregation indexes |

## AI-Native Procurement Capabilities Beyond Automation

### Contract and Legal Intelligence (Implementation Patterns)
- **Clause Analysis UI**: Display non-standard clauses, risks, missing protections with severity indicators
- **Obligation Tracking**: Database schema for deliverables, milestones, penalties with deadline monitoring
- **Change Propagation**: Event system that identifies affected orders/documents when contract changes
- **Health Checking**: Scheduled jobs that validate contracts for missing signatures, expired terms

### Supplier Intelligence & Risk Monitoring (Implementation Patterns)
- **Risk Prediction**: Analytics service consuming financial + delivery data, outputting risk scores
- **Price Intelligence**: Data aggregation from procurement records, market data APIs
- **Fraud Detection**: Anomaly detection service flagging suspicious invoice patterns
- **Capacity Monitoring**: Workload tracking comparing supplier orders vs. historical capacity

### Data-Driven Procurement (Implementation Patterns)
- **Spend Analytics**: Aggregation pipelines for category, vendor, timeline analysis
- **Procycle Prediction**: ML integration points for procurement timeline forecasting
- **Cost Variance**: Budget tracking with variance detection and alerting
- **Quality Trending**: Inspection data aggregation with trend analysis and forecasting

### Natural Language Interface (Implementation Patterns)
- **Query Assistant**: RAG-powered interface for contract/spec queries with source citation
- **Compliance Checker**: Rule engine for procurement policy compliance verification
- **Supplier Search**: Full-text search across supplier data with faceted filtering
- **Precedent Search**: Historical procurement case search with structured results

## UI Integration with Workflow Documentation

### Authoritative Source for Component Specifications
All detailed component specifications, step definitions, and workflow documentation are maintained in `docs-construct-ai/disciplines/01900_procurement/workflow_docs/`. **Reference these workflow docs directly** during code generation — they are the authoritative source for what each component does and how it should behave.

### Key Workflow Documentation Files
| File | Purpose | When to Reference |
|------|---------|-------------------|
| `1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD` | Order creation step-by-step workflow | Generating order forms, order APIs, validation logic |
| `1900_PROCUREMENT_ORDER_WORKFLOW.MD` | Detailed order workflow specification | Generating order state machine, status transitions |
| `1900_PROCUREMENT_APPROVAL_WORKFLOWS_MANAGEMENT.MD` | Approval routing and authority matrix | Generating approval logic, HITL integration |
| `1900_PROCUREMENT_ARCHITECTURE.MD` | System architecture and component relationships | Understanding data flow, service dependencies |
| `1900_PROCUREMENT_COMPREHENSIVE_WORKFLOW.MD` | End-to-end procurement workflow | Generating multi-component features |
| `1900_PROCUREMENT_INPUT_AGENT_WORKFLOW.MD` | Input processing and agent coordination | Generating data ingestion, validation services |
| `1900_PROCUREMENT_SUPPLIER_OUTREACH_WORKFLOW.MD` | Supplier communication and qualification | Generating supplier management, outreach automation |
| `1900_PROCUREMENT_WORKFLOW_HITL_INTEGRATION.MD` | Human-in-the-loop integration points | Generating HITL decision capture, reason logging |
| `1900_PROCUREMENT_WORKFLOW_TECHNICAL_SPEC.MD` | Technical specifications for all components | Generating any procurement component |
| `1900_PROCUREMENT_WORKFLOW_IMPLEMENTATION.MD` | Implementation guidelines and conventions | Following coding standards, patterns |
| `1900_PROCUREMENT_WORKFLOW_USER_GUIDE.MD` | User-facing workflow documentation | Understanding user expectations, error messages |
| `1900_INTERACTIVE_WORKFLOW_GUIDE.MD` | Interactive workflow specifications | Generating guided workflows, wizards |

### How to Use Workflow Docs in Code Generation
When generating procurement code using this AI-Native prompt:

1. **Read the relevant workflow doc** — Identify the component you're building, read its specification in workflow_docs
2. **Extract component requirements** — Form fields, validation rules, data flow, user interactions, error states
3. **Apply AI-Native architecture patterns** — Structured data binding, validation gates, provenance tracking, audit logging
4. **Implement safety boundaries** — Authority enforcement, human review gates, input validation
5. **Generate code** — Frontend components follow workflow spec, backend enforces safety boundaries

### Example: Order Creation with Workflow Docs + AI-Native
```
Workflow Doc (1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD) provides:
  - 5-phase wizard steps with field definitions
  - Validation rules per phase
  - Approval routing logic per order value
  - HITL integration points

AI-Native Prompt adds:
  - Validation at each phase gate (enforced in code)
  - Provenance tracking on all generated values
  - Audit trail logging for all user actions
  - Authority enforcement (no bypasses)

Result: Agent generates a 5-phase wizard that:
  - Follows exact field definitions from workflow doc
  - Validates each phase before progression (AI-Native pattern)
  - Logs all actions to immutable audit trail (AI-Native pattern)
  - Enforces approval routing without bypasses (AI-Native pattern)
  - Tags all values with data source origin (AI-Native pattern)
```

## Safety Boundaries — What Agents Must NOT Generate

Certain code patterns must never be auto-generated by agents:

**Agents Must Never Generate:**
- Code that bypasses authority limits or approval routing
- Code that modifies or deletes audit trail records
- Code that allows non-authorized users to approve orders
- Code that circumvents budget validation or compliance checks
- Direct database modifications to procurement records (always use service layer)
- Code that hardcodes sensitive data (API keys, authority limits)
- Approval workflows that skip required review steps

**Agents Must Always Flag for Human Review:**
- Any changes to authority matrix or approval routing logic
- Any modifications to audit trail or logging systems
- Any code handling financial calculations or budget validation
- Any security-related changes (authentication, authorization, encryption)
- Any data migration affecting procurement records
- Any integration with external payment or banking systems

## Technical Architecture Guidelines

| Layer | Agent Generation Scope | Human Architect Required |
|-------|----------------------|--------------------|
| **UI Components** | Forms, displays, charts, navigation | Complex workflows, multi-step wizards |
| **API Layer** | CRUD endpoints, validation, error handling | Complex business logic, multi-service orchestration |
| **Service Layer** | Data processing, business rules, integration | Authority logic, compliance, financial calculations |
| **Data Layer** | Models, migrations, indexes, constraints | Schema design, data relationships, security |
| **Security** | Auth middleware, input sanitization | Role design, authority matrix, encryption |
| **Audit** | Logging middleware, event handlers | Audit requirements, retention policies |

## Agent Development Workflow

```
Code Task Identified (new component, feature, bug fix)
    → Agent checks automation spectrum (can I generate alone, need review, or human-led?)
    → If Full: Agent generates code with tests
    → If Augmented: Agent generates code, flags for human architect review
    → If Human-Led: Agent provides context, patterns, and supporting code for human architect
    → Generated code follows component generation pipeline
    → Validation: Business rules, security, data integrity, error handling
    → Code review with audit trail logging
    → Merge and deployment
```

## Virtual Filesystem (VFS) Integration

### VFS Directory Architecture
Every procurement order has a dedicated VFS directory structure that agents and services use for document management, supplier references, and learning memory:

```
/procurement/{order_id}/
├── /templates/                    # Reusable templates and rules
│   ├── procurement_plan.yaml     # Standard timelines and workflows
│   ├── compliance_rules.json     # Jurisdiction-specific compliance requirements
│   ├── inventory_catalog.json    # SKU data with ERP integration
│   ├── delivery_terms.docx       # Incoterms and logistics templates
│   └── shipping_schedule.csv     # Carrier and routing data
├── /references/                  # Order-specific supplier references
│   ├── selected_suppliers.json   # Cached supplier cards for this order
│   ├── supplier_search_cache.json # Cached search results
│   └── vendor_master.csv         # Supplier qualification criteria
├── /working/                     # Agent workspace for modifications
│   ├── selected_vendors.json     # User-selected vendors for RFQ
│   ├── compliance_report.json    # Validation results
│   ├── risk_assessment.yaml      # Dynamic risk analysis
│   └── rfq_draft.docx           # Working draft of RFQ
├── /outputs/                     # Final deliverables
│   ├── rfq_appendix_a.docx       # Generated with supplier data
│   ├── procurement_plan.pdf      # Adapted with real timelines
│   └── compliance_certificate.pdf # Automated validation report
└── /memories/                    # Learning framework persistence
    ├── negotiation_history.json  # Historical negotiation patterns
    ├── pricing_patterns.md       # Learned pricing trends
    └── supplier_performance.json # Supplier performance tracking
```

### VFS API Interface
When generating VFS integration code, follow this interface pattern:

| Operation | Method | Endpoint | Performance Target |
|-----------|--------|----------|-------------------|
| Read file | GET | `/vfs/:order_id/:path` | < 100ms for <1MB files |
| Write file | PUT | `/vfs/:order_id/:path` | < 200ms for <1MB files |
| Grep search | POST | `/vfs/:order_id/:path/grep` | < 500ms for 50+ cards |
| List directory | GET | `/vfs/:order_id/:path` | < 100ms |
| Delete file | DELETE | `/vfs/:order_id/:path` | < 200ms |
| Compliance validation | POST | `/compliance/validate/:order_id` | < 1000ms |
| Document generation | POST | `/documents/generate/:order_id` | < 5000ms |

### VFS Database Schema
Generate this schema when implementing VFS metadata tracking:

```sql
-- Virtual filesystem metadata
CREATE TABLE procurement_vfs_files (
    id UUID PRIMARY KEY,
    order_id VARCHAR(50) REFERENCES procurement_orders(id),
    file_path TEXT NOT NULL,
    file_type VARCHAR(10),
    content_hash VARCHAR(64),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- File access audit log
CREATE TABLE procurement_vfs_access_log (
    id UUID PRIMARY KEY,
    order_id VARCHAR(50),
    agent_id VARCHAR(100),
    file_path TEXT,
    operation VARCHAR(20), -- read, write, grep, list, delete
    timestamp TIMESTAMP DEFAULT NOW()
);
```

## Supplier Card Structure

### Supplier Card JSON Schema
All supplier data follows this standardized JSON card structure, stored in VFS `/references/` directory:

```json
{
  "supplier_id": "STEELCO_001",
  "company_name": "SteelCo ZA",
  "contact_info": {
    "email": "procurement@steelco.co.za",
    "phone": "+27-21-555-0123",
    "address": "15 Steel Road, Johannesburg, ZA"
  },
  "certifications": {
    "cidb_grade": "GR8",
    "iso_9001": true,
    "iso_14001": true,
    "bbee_level": "Level 2",
    "sars_vat_registered": true
  },
  "products_services": [
    {
      "sku": "STEEL-BEAM-10M",
      "description": "Structural steel beams, 10m length",
      "unit_price_zar": 12500.00,
      "lead_time_days": 14,
      "moq": 10,
      "stock_level": 500,
      "last_updated": "2026-03-15"
    }
  ],
  "logistics": {
    "incoterms_supported": ["DAP", "DDP", "FOB"],
    "preferred_carriers": ["Transnet", "Spoornet"],
    "delivery_zones": ["Gauteng", "Western Cape", "KwaZulu-Natal"],
    "customs_clearance": true
  },
  "performance_history": {
    "on_time_delivery_rate": 0.96,
    "quality_complaints": 2,
    "total_orders": 450,
    "average_order_value_zar": 250000.00,
    "last_order_date": "2026-02-28"
  },
  "risk_profile": {
    "financial_stability": "A",
    "supply_chain_risk": "Low",
    "geopolitical_exposure": "None",
    "currency_risk": "Medium"
  },
  "metadata": {
    "created_date": "2025-01-15",
    "last_audit_date": "2026-01-30",
    "approved_by": "Procurement Director",
    "next_review_date": "2026-07-15"
  }
}
```

### Supplier Filtering Logic
Implement this cascading filter chain for supplier selection in Phase 1:

```
Procurement Group (Level 1)
    ↓ Filters
Procurement Category (Level 2)
    ↓ Filters
Item Selection (Level 3)
    ↓ Filters
Goods Classification (Level 4)
    ↓ Queries
Qualified Suppliers (sorted by compliance score descending)
```

### Compliance Scoring Algorithm
Use this weighted formula for supplier ranking:

```
Compliance Score = (ISO 9001 Certified ? 0.30 : 0) +
                   (B-BBEE Weight: L1=0.30, L2=0.25, L3=0.20, L4=0.15, other=0) +
                   (Financial Stability: A=0.20, B=0.15, other=0) +
                   (Other Factors: certifications, location, capacity = 0.20)
```

## Agent Class Definitions

### Base Procurement Agent Class
When generating agent code, follow this class structure:

```python
class ProcurementAgent(BaseAgent):
    def __init__(self, config: dict):
        super().__init__(config)
        self.vfs = ProcurementVirtualFilesystem(config["order_id"])
        self.compliance_manager = ComplianceRuleManager()
        self.supplier_generator = SupplierCardGenerator()

    async def read_supplier_card(self, supplier_id: str) -> dict:
        """Read individual supplier card from VFS /references/"""
        pass

    async def search_suppliers(self, criteria: dict) -> List[dict]:
        """Search suppliers using grep operations on VFS cards"""
        pass

    async def validate_compliance(self, supplier_id: str) -> ComplianceReport:
        """Validate supplier against jurisdiction-specific compliance rules"""
        pass

    async def generate_document(self, template: str, data: dict) -> str:
        """Generate document using template and structured data injection"""
        pass
```

### Multi-Agent Communication Protocol
Implement inter-agent communication using this pattern:

```python
class MessagingMixin:
    async def send_message(self, recipient: str, message: dict) -> bool:
        """Send message to another agent"""
        pass

    async def receive_message(self) -> dict:
        """Receive message from another agent"""
        pass

    async def broadcast_message(self, message: dict) -> bool:
        """Broadcast message to all agents"""
        pass

    async def request_response(self, recipient: str, request: dict) -> dict:
        """Send request and wait for response with timeout"""
        pass
```

### Agent Specifications by Role
| Agent Role | Primary Responsibility | Key Methods |
|------------|----------------------|-------------|
| **Order Creation Agent** | Create POs, WOs, SOs from requisitions | `create_order()`, `validate_fields()`, `route_approval()` |
| **Supplier Management Agent** | Qualify, evaluate, track suppliers | `qualify_supplier()`, `score_suppliers()`, `track_performance()` |
| **Compliance Agent** | Validate against jurisdiction rules | `validate_compliance()`, `load_rules()`, `generate_report()` |
| **Document Generation Agent** | Render templates with structured data | `select_template()`, `inject_data()`, `export_document()` |
| **Approval Routing Agent** | Route orders through approval chains | `determine_chain()`, `notify_approver()`, `track_status()` |
| **Analytics Agent** | Generate spend reports, KPIs | `aggregate_spend()`, `calculate_kpis()`, `generate_report()` |

## Performance Requirements

### Response Time Requirements
- **VFS Read Operations**: < 100ms for files < 1MB
- **VFS Write Operations**: < 200ms for files < 1MB
- **Supplier Search**: < 500ms for grep operations across 50+ cards
- **Compliance Validation**: < 1000ms for complete validation
- **Document Generation**: < 5000ms for standard documents
- **Approval Routing**: < 200ms for chain determination
- **Order Creation**: < 1000ms for complete order + VFS initialization

### Throughput Requirements
- **Concurrent Orders**: Support 100+ concurrent procurement orders
- **Agent Processing**: Support 50+ concurrent agent operations
- **VFS Operations**: Support 1000+ VFS operations per minute
- **Database Queries**: Support 500+ queries per second

### Scalability Requirements
- **Horizontal Scaling**: Support for multiple agent instances with load balancing
- **Database Scaling**: Support for read replicas and connection pooling
- **Storage Scaling**: Support for unlimited VFS storage with automatic cleanup
- **Memory Usage**: < 50MB additional RAM per active order

## Implementation Best Practices

### Code Generation Guidelines
1. **Start with domain knowledge** — understand procurement business rules before generating code
2. **Use existing patterns** — follow established component and service patterns from the codebase
3. **Validate every input** — form fields, API parameters, file uploads, database queries, VFS operations
4. **Handle errors gracefully** — user-facing errors, not stack traces; include retry mechanisms
5. **Log all actions** — audit trail for every procurement action and VFS operation
6. **Test thoroughly** — unit tests for validation, integration tests for workflows, load tests for performance
7. **Tag all VFS operations** — Include order_id, agent_id, file_path, operation in audit logs
8. **Cache strategically** — Supplier cards, compliance rules, and template libraries should be cached but with invalidation triggers

### Safety Boundary Enforcement
1. **Never generate code that bypasses authority limits** — always enforce approval routing
2. **Never generate code that modifies audit trails** — audit records are immutable, append-only
3. **Never generate code that hardcodes sensitive data** — use environment variables, configuration, VFS templates
4. **Always flag financial logic changes** — calculations, budget checks, payment processing
5. **Always flag security-related changes** — authentication, authorization, encryption
6. **Always document generated code** — comments explaining business rules, not just what code does
7. **Never allow AI to approve orders** — all approvals must come through the defined HITL workflow

## Success Metrics

### Code Quality Metrics
- **Test Coverage**: 80%+ unit test coverage, 70%+ integration test coverage
- **Validation Completeness**: 100% of input paths validated (forms, APIs, file uploads)
- **Error Handling**: 100% of components have error states, loading states, recovery
- **Security Compliance**: 0 critical security findings from code review

### Component Generation Metrics
- **Pattern Consistency**: 95%+ of generated components follow established patterns
- **Business Rule Accuracy**: 100% of generated validation logic matches domain knowledge
- **Integration Correctness**: 95%+ of API integrations work on first deploy
- **Audit Trail Coverage**: 100% of procurement actions logged with complete audit trail

### Agent Efficiency Metrics
- **Generation Speed**: Components generated with minimal back-and-forth from architecture context
- **Review Rate**: Less than 10% of generated code requires significant revision
- **Safety Compliance**: 0 instances of agents generating prohibited code patterns
- **Documentation Quality**: All generated code documented with business rule context

## Version History

- **v1.0** (2026-03-31): Initial AI-Native Procurement Operations Development Prompt Template
- Created for OpenClaw coding agents to generate procurement code with proper context
- Includes automation spectrum specific to code generation (agent can/cannot generate)
- Defines safety boundaries for procurement code generation
- Provides component generation patterns for frontend, backend, database
- Includes agent development workflow with human review gates
- Based on lessons learned from Safety and Civil Engineering AI-Native prompts

- **v2.0** (2026-04-02): Comprehensive enhancement and quality remediation
- **Phase 1**: Added VFS metadata tables, supplier card structure documentation, VFS directory mapping
- **Phase 2**: Corrected 5-phase names to match workflow doc (Basic Info & Supplier Selection → Template Selection → Assign Disciplines → Approval Setup → Review & Create); Added procurement hierarchy filtering (Group→Category→Item→Goods→Supplier); Added VFS directory initialization; Added supplier selection with compliance scoring
- **Phase 3**: Added PO Amendments and SOWs to document templates; Added VFS file operations and API endpoints
- **Phase 4**: Added supplier card JSON structure; Added compliance scoring algorithm (ISO 9001 30% + B-BBEE 30% + Financial 20% + other 20%); Added hierarchy-based supplier search with parent category fallback
- **Phase 5**: Added jurisdiction-aware compliance engine (CIDB, SARS VAT, B-BBEE, ISO per jurisdiction); Added currency-aware approval thresholds (USD: <$25k/$25k-$100k/>$100k; ZAR: <R500k/R500k-R2M/R2M-R10M/>R10M); Added 3-way match pre-payment checks; Added VFS access operation logging
- **Phase 6**: Added VFS document integration; Added contract change propagation to POs/framework agreements/budget commitments; Added risk level classification for clause comparison
- **Phase 7**: Added visualization types per chart; Added KPI targets and thresholds; Added variance cause categories (price_increase, scope_change, quantity_variance, timing); Added fraud detection patterns (invoice splitting, duplicate invoicing, phantom suppliers, price manipulation, circular approval)
- **Phase 8**: Added VFS audit logging; Added GDPR/POPIA compliance for data retention; Added uncertainty disclosure for single-source risks
- **New Sections Added**: Virtual Filesystem Integration (directory architecture, API interface, database schema); Supplier Card Structure (JSON schema, filtering logic, compliance scoring algorithm); Agent Class Definitions (base class, messaging mixin, role specifications); Performance Requirements (response times, throughput, scalability targets)
- **Cross-references updated**: Added TECHNICAL_SPEC, ARCHITECTURE, COMPREHENSIVE_WORKFLOW to related_docs

## Deep Agents Memory System Integration

### ProcurementWorkflowState Schema
In production with deep-agents, use the `ProcurementWorkflowState` model instead of standalone session memory. This model persists via checkpointing and provides governance-compatible state tracking.

**Core State Model:** `deep_agents.core.c_procurement_workflow_state.ProcurementWorkflowState`

**6-Stage Pipeline (current_stage field):**
1. `template_analysis` → 2. `requirements_extraction` → 3. `compliance_validation` → 4. `field_population` → 5. `quality_assurance` → 6. `final_review`

**Key State Fields:**
| Field | Type | Purpose |
|-------|------|---------|
| `workflow_id` | str | Unique procurement workflow identifier |
| `current_stage` | Literal[6 stages] | Current pipeline stage |
| `hitl_gates` | Dict[str, HitlGateResult] | Human-in-the-loop gate results |
| `hitl_blocked` | bool | Whether workflow is blocked by HITL gate |
| `procurement_value` | float | Total order value |
| `currency` | str | Order currency |
| `high_value_threshold` | float | Threshold for human review (default: 500,000 ZAR) |
| `agent_states` | Dict[str, AgentState] | Per-agent execution state |
| `template_analysis` | Dict | Template analysis results |
| `extracted_requirements` | Dict | Extracted procurement requirements |
| `compliance_report` | Dict | Compliance validation report |
| `populated_fields` | Dict | Populated procurement form fields |
| `quality_assessment` | Dict | Quality check results |
| `final_review` | Dict | Final review data |

**HITL Gate Result Schema:**
```python
class HitlGateResult(BaseModel):
    gate_name: str
    triggered: bool
    blocked: bool
    reasons: List[str]
    timestamp: datetime
```

**Agent State Schema:**
```python
class AgentState(BaseModel):
    agent_id: str
    agent_type: str
    status: AgentStatus  # initialized, running, completed, failed, paused, cancelled
    current_step: Optional[str]
    progress: float  # 0.0 to 1.0
    start_time: Optional[datetime]
    end_time: Optional[datetime]
    error_message: Optional[str]
    retry_count: int
    metadata: Dict[str, Any]
    audit_trail: List[Dict[str, Any]]
```

### Checkpointing System
Deep-agents uses LangGraph-style checkpointing for persistence:
- **Checkpointer**: Supabase Postgres backend (`procurement_workflow_state` table)
- **State restoration**: `ProcurementWorkflowState.from_json()` deserializes checkpoint state
- **State update**: `ProcurementWorkflowState.to_json()` serializes for persistence
- **Audit trail**: All state transitions logged with timestamp, agent_id, metadata

### Governance Integration
The `@with_governance` decorator wraps all state transitions:
- Validates stage transitions before allowing progression
- Triggers HITL gates for high-value procurement (≥ 500,000 ZAR default)
- Records audit entries for all state mutations
- Blocks workflow if any HITL gate returns `blocked=true`

### Key Methods for Code Generation
When generating deep-agents procurement code, use these methods:
```python
# Stage transition with governance
state.transition_to("requirements_extraction", agent_id="procurement-agent-01")

# HITL gate evaluation
state.add_hitl_gate_result(HitlGateResult(
    gate_name="high_value_check",
    triggered=True,
    blocked=state.is_high_value_procurement(),
    reasons=["Procurement value exceeds threshold"]
))

# Metadata update
state.update_procurement_metadata({"totalValue": 750000, "currency": "ZAR"})

# Summary generation
summary = state.get_full_summary()
```

### Deep Agents vs OpenClaw Memory Comparison
| Aspect | OpenClaw / PARA System | Deep Agents Memory System |
|--------|----------------------|-------------------------|
| **Memory** | Markdown files in `memory_layer` directories | Pydantic models persisted via checkpointing |
| **State** | Document-based, semantic memory | Structured typed state with validation |
| **Governance** | Prompt-driven boundaries | Code-enforced `@with_governance` decorator |
| **HITL** | Prompt-based human review gates | `HitlGateResult` model with blocking |
| **Persistence** | File system + Supabase tables | LangGraph checkpointer (Supabase Postgres) |
| **Audit** | Prompt-level audit trail | Method-level audit entries with timestamps |

### When to Use Deep Agents System
Use the deep-agents memory system when:
- Generating code for `deep-agents/deep_agents/services/01900_procurement_patterns.py`
- Implementing production procurement workflow services
- Building HITL integration with governance enforcement
- Creating checkpointed multi-agent procurement pipelines

## Procurement AI Agent Behavioral Rules

### Non-Negotiable Rules for All Procurement Code Generation

1. **Authority Enforcement Rule:** Never generate code that bypasses authority limits or approval routing. All approval workflows must enforce defined authority matrix.

2. **Audit Immutability Rule:** Never generate code that modifies or deletes audit trail records. All audit records are append-only with user, timestamp, action, data.

3. **Input Validation Rule:** All code must validate every input path — forms, API endpoints, file uploads, database queries. No unvalidated data flows through procurement systems.

4. **No Hardcoded Data Rule:** Never generate code with hardcoded procurement values (prices, authority limits, thresholds). All values from configuration, database, or environment.

5. **Security Flagging Rule:** Any code touching authentication, authorization, or encryption must be flagged for human architect review. Agents do not autonomously modify security systems.

6. **Financial Code Review Rule:** Any code handling financial calculations, budget validation, or payment processing must be flagged for human review. Agents generate implementation code, humans validate business logic.

7. **Pattern Consistency Rule:** Generated code must follow established patterns from existing procurement components. New patterns require human architect review.

8. **Documentation Requirement:** All generated code must include comments explaining business rules, not just code mechanics. Future developers must understand why the code exists.

9. **Safety Boundary Respect:** Never generate code that circumvents budget checks, compliance validation, or required review steps. These are non-negotiable governance requirements.

10. **Audit Trail Completeness:** All generated procurement actions (create, update, approve, reject) must include audit trail logging with complete context (user, timestamp, action, data before, data after).

11. **Error Transparency Rule:** All generated error handling must be transparent — show users what went wrong, why, and how to fix it. Never silently fail or mask errors.