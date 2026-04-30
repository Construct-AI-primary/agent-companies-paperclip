---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/paperclip
gigabrain_tags: procedures, paperclip, commercial-workflows, workflow-implementation, schema-alignment
openstinger_context: commercial-workflow-procedures, paperclip-implementation
last_updated: 2026-04-08
related_docs:
  - docs_construct_ai/disciplines/00250-commercial/agent-data/domain-knowledge/00250_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00250-commercial/agent-data/prompts/00250_AI-NATIVE-COMMERCIAL-PROMPT.md
  - docs_construct_ai/codebase/schema/paperclip/total_schema.csv
  - docs_construct_ai/codebase/agents/paperclip-teams/Paperclip_Teams_Cross_Reference.md
  - .clinerules/guide/project-implementation-workflow-guide.md
---

# Commercial Workflow Implementation Preparation Procedure

## Overview

This procedure outlines how to create project implementation workflow guides for each missing commercial workflow, ensuring alignment with the existing Supabase table structure and leveraging the full capabilities of the Paperclip agent ecosystem.

### Purpose
- Standardize commercial workflow implementation across the Paperclip ecosystem
- Ensure schema alignment with existing commercial-related Supabase tables
- Provide consistent team assignments and phase definitions
- Maintain audit trails and compliance requirements for commercial operations

### Scope
- 6 missing commercial workflows requiring implementation guides
- Schema alignment with existing commercial-related Supabase tables
- Integration with 9 Paperclip agent companies and their capabilities
- 5-phase implementation process per workflow

---

## Step 1: Schema Alignment Requirements

### Critical Commercial Tables to Align With

| Table | Purpose | Key Fields | Workflow Integration |
|-------|---------|------------|---------------------|
| **contracts** | Core contract management | id, organization_id, contract_type, status, value, parties | All commercial workflows must create/update contract records |
| **suppliers** | Supplier information and evaluation | id, organization_id, name, category, performance_score, status | Supplier evaluation and management workflows |
| **commercial_risks** | Commercial risk tracking | id, organization_id, risk_type, probability, impact, mitigation_status | Risk management workflows |
| **negotiations** | Negotiation tracking and documentation | id, organization_id, counterparty, status, strategy, outcomes | Negotiation management workflows |
| **bids_proposals** | Bid and proposal management | id, organization_id, opportunity_id, status, value, win_probability | Business development workflows |
| **commercial_reports** | Commercial performance reporting | id, organization_id, report_type, period, metrics, insights | All workflows requiring reporting |
| **market_intelligence** | Market data and competitor analysis | id, organization_id, sector, competitor, market_share, trends | Strategy development workflows |

### Schema-Aware Workflow Design Requirements

#### Database Integration Points
- **Primary Table**: Identify which table serves as the workflow's primary data store
- **Related Tables**: Map all foreign key relationships and dependent tables
- **Status Fields**: Align workflow states with table status enums
- **Audit Trail**: Ensure all changes are logged via existing audit mechanisms

#### RLS (Row Level Security) Compliance
- **Organization Scoping**: All queries must respect organization_id filtering
- **User Permissions**: Implement proper role-based access controls
- **Data Isolation**: Ensure multi-tenant data separation

#### API Integration Requirements
- **REST Endpoints**: Use existing commercial API endpoints
- **Real-time Updates**: Implement Supabase real-time subscriptions where needed
- **Error Handling**: Follow established error response patterns

---

## Step 2: Workflow Prioritization & Assignment

### Priority Order (based on commercial criticality)
1. **Commercial Strategy Development Workflow** (COMM-STRAT) - Foundation for all commercial activities
2. **Negotiation Management Workflow** (COMM-NEGOTIATE) - Core commercial competency
3. **Contract Administration Workflow** (COMM-CONTRACT) - Legal and financial risk management
4. **Business Development and Bid Management Workflow** (COMM-BID) - Revenue generation
5. **Commercial Risk Management Workflow** (COMM-RISK) - Risk protection
6. **Supplier Evaluation and Management Workflow** (COMM-SUPPLIER) - Supply chain management

---

## Step 3: Directory Structure Setup

For each workflow, create a dedicated folder structure:

```
docs-paperclip/disciplines/00250-commercial/
├── strategy-development-workflow/        # COMM-STRAT
│   ├── project/
│   ├── issues/
│   └── README.md
├── negotiation-management-workflow/      # COMM-NEGOTIATE
│   ├── project/
│   ├── issues/
│   └── README.md
├── contract-administration-workflow/     # COMM-CONTRACT
│   ├── project/
│   ├── issues/
│   └── README.md
└── [additional workflow folders...]
```

---

## Step 4: Template Adaptation for Each Workflow

**Base Template**: Use `.clinerules/guide/project-implementation-workflow-guide.md`

**For Each Workflow, customize these variables:**

### Core Project Variables
```
{PLAN_DOCUMENT_PATH} = docs-paperclip/disciplines/00250-commercial/[workflow-name]/project/2026-04-XX-[workflow-slug]-plan.md
{PROJECT_DOCUMENT_PATH} = docs-paperclip/disciplines/00250-commercial/[workflow-name]/project/2026-04-XX-[workflow-slug]-implementation.md
{CEO_AGENT} = nexus-devforge-ceo
{ISSUE_PREFIX} = COMM-[CODE]
```

### Company and Team Assignments
```
{PRIMARY_COMPANY} = DevForge AI
{PRIMARY_TEAM} = Engineering
{PRIMARY_AGENTS} = interface-devforge, codesmith-devforge, devcore-devforge
{PRIMARY_SKILLS} = Commercial Workflow Development, Contract Management, Negotiation Systems

{INFRA_COMPANY} = InfraForge AI
{INFRA_TEAM} = Infrastructure
{INFRA_AGENTS} = database-infraforge
{INFRA_SKILLS} = Database Administration, System Integration

{QUALITY_COMPANY} = QualityForge AI
{QUALITY_TEAM} = Quality
{QUALITY_AGENTS} = guardian-qualityforge, validator-qualityforge
{QUALITY_SKILLS} = Testing, Validation, Quality Assurance

{KNOWLEDGE_COMPANY} = KnowledgeForge AI
{KNOWLEDGE_TEAM} = Documentation
{KNOWLEDGE_AGENTS} = doc-analyzer-knowledgeforge
{KNOWLEDGE_SKILLS} = Documentation, Knowledge Management
```

### Enhanced Template Variables for Schema Alignment
```
{PRIMARY_TABLE} = Main Supabase table for this workflow (e.g., contracts, suppliers, commercial_risks)
{RELATED_TABLES} = Comma-separated list of dependent tables
{SCHEMA_INTEGRATION_POINTS} = Key integration points with existing schema
{DATA_VALIDATION_RULES} = Schema-based validation requirements
{RLS_COMPLIANCE_REQUIREMENTS} = Row-level security implementation needs
{AUDIT_TRAIL_REQUIREMENTS} = Audit logging requirements for compliance
```

---

## Step 5: Schema-Aware Phase Definitions

**Standard 5-Phase Structure for Commercial Workflows:**

```
{PHASE_1_NAME} = Phase 1: Schema Analysis & Commercial Data Modeling (Weeks 1-2)
{PHASE_1_ISSUE_1} = Analyze existing commercial table relationships and constraints
{PHASE_1_AGENT_1} = database-infraforge
{PHASE_1_ISSUE_2} = Design workflow data flow aligned with commercial schema
{PHASE_1_AGENT_2} = codesmith-devforge
{PHASE_1_ISSUE_3} = Implement RLS policies for new commercial workflow components
{PHASE_1_AGENT_3} = database-infraforge

{PHASE_2_NAME} = Phase 2: API Integration & Backend Development (Weeks 3-4)
{PHASE_2_ISSUE_1} = Build CRUD operations for primary commercial workflow table
{PHASE_2_AGENT_1} = devcore-devforge
{PHASE_2_ISSUE_2} = Implement workflow state management with schema alignment
{PHASE_2_AGENT_2} = codesmith-devforge
{PHASE_2_ISSUE_3} = Integrate with existing commercial APIs and external providers
{PHASE_2_AGENT_3} = interface-devforge

{PHASE_3_NAME} = Phase 3: Integration & Testing (Weeks 5-6)
{PHASE_3_ISSUE_1} = Implement real-time commercial tracking and alert systems
{PHASE_3_AGENT_1} = devcore-devforge
{PHASE_3_ISSUE_2} = Create comprehensive test suite with commercial scenarios
{PHASE_3_AGENT_2} = validator-qualityforge
{PHASE_3_ISSUE_3} = Performance optimization and security review
{PHASE_3_AGENT_3} = guardian-qualityforge

{PHASE_4_NAME} = Phase 4: Documentation & Training (Weeks 7-8)
{PHASE_4_ISSUE_1} = Create user documentation and commercial operational guides
{PHASE_4_AGENT_1} = doc-analyzer-knowledgeforge
{PHASE_4_ISSUE_2} = Develop training materials for commercial workflows
{PHASE_4_AGENT_2} = doc-analyzer-knowledgeforge
{PHASE_4_ISSUE_3} = Knowledge base integration and cross-referencing
{PHASE_4_AGENT_3} = doc-analyzer-knowledgeforge

{PHASE_5_NAME} = Phase 5: Deployment & Go-Live (Weeks 9-10)
{PHASE_5_ISSUE_1} = Production deployment and commercial data migration
{PHASE_5_AGENT_1} = database-infraforge
{PHASE_5_ISSUE_2} = User acceptance testing and commercial team training
{PHASE_5_AGENT_2} = validator-qualityforge
{PHASE_5_ISSUE_3} = Go-live support and commercial performance monitoring
{PHASE_5_AGENT_3} = guardian-qualityforge
```

---

## Step 6: Schema-Specific Success Criteria

**Database Integration Success Criteria:**
```
{FUNCTIONAL_SUCCESS_CRITERIA_1} = All commercial workflow data properly stored in aligned Supabase commercial tables
{FUNCTIONAL_SUCCESS_CRITERIA_2} = RLS policies correctly implemented for commercial data security
{FUNCTIONAL_SUCCESS_CRITERIA_3} = Foreign key relationships maintained across commercial operations
{FUNCTIONAL_SUCCESS_CRITERIA_4} = Audit trails capture all commercial state changes and negotiations
{FUNCTIONAL_SUCCESS_CRITERIA_5} = Real-time updates work with existing commercial subscription patterns
```

**Schema Compliance Validation:**
```
{TECHNICAL_RISK_1} = Schema changes may break existing commercial functionality
{TECHNICAL_RISK_1_MITIGATION} = Comprehensive testing against existing workflows before deployment

{TECHNICAL_RISK_2} = RLS policy conflicts may prevent legitimate commercial data access
{TECHNICAL_RISK_2_MITIGATION} = Thorough testing of permission scenarios with existing roles

{TECHNICAL_RISK_3} = Performance impact on existing commercial queries and reporting
{TECHNICAL_RISK_3_MITIGATION} = Database query optimization and indexing strategy for commercial data
```

---

## Step 7: Workflow-Specific Schema Mapping

### Priority Workflow Schema Alignments

#### 1. Commercial Strategy Development Workflow (COMM-STRAT)
- **Primary Table**: New `commercial_strategies` table
- **Related Tables**: `market_intelligence`, `commercial_risks`, `contracts`
- **Key Integration**: Strategy execution tracking with contract and risk management
- **Audit Requirements**: Strategy decision tracking and approval workflows

#### 2. Negotiation Management Workflow (COMM-NEGOTIATE)
- **Primary Table**: `negotiations`
- **Related Tables**: `contracts`, `suppliers`, `commercial_risks`
- **Key Integration**: Negotiation outcomes linked to contract creation and risk mitigation
- **Audit Requirements**: Negotiation position and concession tracking

#### 3. Contract Administration Workflow (COMM-CONTRACT)
- **Primary Table**: `contracts`
- **Related Tables**: `suppliers`, `commercial_reports`, `negotiations`
- **Key Integration**: Contract lifecycle management with supplier and reporting systems
- **Audit Requirements**: Contract amendment and compliance tracking

#### 4. Business Development and Bid Management Workflow (COMM-BID)
- **Primary Table**: `bids_proposals`
- **Related Tables**: `market_intelligence`, `contracts`, `commercial_risks`
- **Key Integration**: Bid outcomes linked to contract creation and risk assessment
- **Audit Requirements**: Bid decision and win/loss analysis tracking

#### 5. Commercial Risk Management Workflow (COMM-RISK)
- **Primary Table**: `commercial_risks`
- **Related Tables**: `contracts`, `suppliers`, `negotiations`
- **Key Integration**: Risk mitigation linked to contract and supplier management
- **Audit Requirements**: Risk assessment and mitigation action tracking

#### 6. Supplier Evaluation and Management Workflow (COMM-SUPPLIER)
- **Primary Table**: `suppliers`
- **Related Tables**: `contracts`, `commercial_reports`, `bids_proposals`
- **Key Integration**: Supplier performance linked to contract and bid management
- **Audit Requirements**: Supplier evaluation and performance tracking

---

## Step 8: Implementation Execution

**For Each Workflow:**

1. **Create Project Folder Structure**
   ```bash
   mkdir -p docs-paperclip/disciplines/00250-commercial/[workflow-name]/project
   mkdir -p docs-paperclip/disciplines/00250-commercial/[workflow-name]/issues
   ```

2. **Copy and Customize Template**
   ```bash
   cp .clinerules/guide/project-implementation-workflow-guide.md \
      docs-paperclip/disciplines/00250-commercial/[workflow-name]/project/2026-04-XX-[workflow-slug]-implementation-guide.md
   ```

3. **Replace Variables** using systematic find-and-replace for all template variables

4. **Create Supporting Documents**
   - Project plan document
   - Issue templates for each phase
   - README.md with workflow overview

5. **Team Assignment** based on cross-reference:
   - **DevForge AI**: Core development (nexus-devforge-ceo, interface-devforge, codesmith-devforge, devcore-devforge)
   - **InfraForge AI**: Database and infrastructure (database-infraforge)
   - **QualityForge AI**: Testing and QA (guardian-qualityforge, validator-qualityforge)
   - **KnowledgeForge AI**: Documentation (doc-analyzer-knowledgeforge)
   - **DomainForge AI**: Commercial domain expertise (commercial agents)

---

## Step 9: Quality Assurance

### Schema Compliance Checklist
- [ ] All new tables follow existing naming conventions
- [ ] Foreign key relationships properly defined
- [ ] RLS policies implemented for multi-tenant security
- [ ] Indexes created for performance-critical commercial queries
- [ ] Audit triggers configured for compliance tables
- [ ] Migration scripts tested against production data
- [ ] API endpoints documented with OpenAPI specs
- [ ] Database constraints validated for data integrity

### Integration Testing Requirements
- [ ] End-to-end workflow testing with real commercial schema data
- [ ] Performance testing against existing commercial query patterns
- [ ] Security testing for RLS policy effectiveness
- [ ] External API integration testing (CRM, ERP, legal systems)
- [ ] Real-time commercial tracking and alert system validation
- [ ] Rollback procedures documented and tested

---

## Step 10: Success Metrics & Monitoring

### Implementation Success Metrics
- **Schema Alignment**: 100% of workflows integrate with existing commercial tables
- **RLS Compliance**: Zero security violations in production
- **Performance**: No degradation of existing commercial queries and reporting
- **Data Integrity**: 100% foreign key relationship maintenance
- **Audit Compliance**: Complete audit trails for all commercial actions
- **External Integration**: Successful API connectivity and data flow

### Continuous Improvement
- **Schema Evolution**: Regular review of commercial table utilization and optimization opportunities
- **Performance Monitoring**: Ongoing monitoring of commercial query performance and reporting systems
- **Security Audits**: Regular RLS policy reviews and updates for commercial data
- **API Reliability**: Monitoring of external commercial API performance and failover procedures
- **User Feedback**: Incorporation of commercial team feedback into workflow improvements

---

This procedure ensures that all commercial workflow implementations are fully aligned with the existing Supabase schema architecture, maintaining data integrity, security, and performance while extending the commercial capabilities systematically.