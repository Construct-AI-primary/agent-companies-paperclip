---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/paperclip
gigabrain_tags: procedures, paperclip, design-workflows, workflow-implementation, schema-alignment
openstinger_context: design-workflow-procedures, paperclip-implementation
last_updated: 2026-04-08
related_docs:
  - docs_construct_ai/disciplines/00800-design/agent-data/domain-knowledge/00800_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/codebase/schema/paperclip/total_schema.csv
  - docs_construct_ai/codebase/agents/paperclip-teams/Paperclip_Teams_Cross_Reference.md
  - .clinerules/guide/project-implementation-workflow-guide.md
---

# Design Workflow Implementation Preparation Procedure

## Overview

This procedure outlines how to create project implementation workflow guides for each missing design workflow, ensuring alignment with the existing Supabase table structure and leveraging the full capabilities of the Paperclip agent ecosystem.

### Purpose
- Standardize design workflow implementation across the Paperclip ecosystem
- Ensure schema alignment with existing design-related Supabase tables
- Provide consistent team assignments and phase definitions
- Maintain audit trails and compliance requirements for design operations

### Scope
- 5 missing design workflows requiring implementation guides
- Schema alignment with existing design-related Supabase tables
- Integration with 9 Paperclip agent companies and their capabilities
- 5-phase implementation process per workflow

---

## Step 1: Schema Alignment Requirements

### Critical Design Tables to Align With

| Table | Purpose | Key Fields | Workflow Integration |
|-------|---------|------------|---------------------|
| **projects** | Core project management | id, organization_id, name, status, start_date, end_date | All design workflows must reference project context |
| **design_deliverables** | Deliverable tracking | id, project_id, deliverable_type, status, due_date, revision | Design coordination and review workflows |
| **design_reviews** | Review management | id, deliverable_id, review_type, status, reviewer, due_date | Design review and quality assurance workflows |
| **rfis** | RFI tracking | id, project_id, originator, status, response_date, priority | Construction support and RFI management workflows |
| **bim_models** | BIM model management | id, project_id, model_type, version, status, last_updated | BIM and model coordination workflows |
| **design_changes** | Change control | id, project_id, change_type, status, impact_assessment, approval_date | Design change control workflows |
| **design_interfaces** | Interface management | id, project_id, discipline_1, discipline_2, interface_type, status | Design coordination workflows |

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
- **REST Endpoints**: Use existing design API endpoints
- **Real-time Updates**: Implement Supabase real-time subscriptions where needed
- **Error Handling**: Follow established error response patterns

---

## Step 2: Workflow Prioritization & Assignment

### Priority Order (based on design criticality)
1. **Design Coordination and Management Workflow (DESIGN-COORD)** - Foundation for all design activities
2. **Design Review and Quality Assurance Workflow (DESIGN-REVIEW)** - Quality assurance and compliance
3. **Construction Support and RFI Management Workflow (DESIGN-CONSTRUCTION)** - Construction support
4. **Design Change Control Workflow (DESIGN-CHANGE)** - Change management and control
5. **BIM and Model Coordination Workflow (DESIGN-BIM)** - Digital design coordination

---

## Step 3: Directory Structure Setup

For each workflow, create a dedicated folder structure:

```
docs-paperclip/disciplines/00800-design/
├── design-coordination-workflow/     # DESIGN-COORD
│   ├── project/
│   ├── issues/
│   └── README.md
├── design-review-workflow/           # DESIGN-REVIEW
│   ├── project/
│   ├── issues/
│   └── README.md
├── construction-support-workflow/    # DESIGN-CONSTRUCTION
│   ├── project/
│   ├── issues/
│   └── README.md
├── bim-coordination-workflow/        # DESIGN-BIM
│   ├── project/
│   ├── issues/
│   └── README.md
└── design-change-workflow/           # DESIGN-CHANGE
    ├── project/
    ├── issues/
    └── README.md
```

---

## Step 4: Template Adaptation for Each Workflow

**Base Template**: Use `.clinerules/guide/project-implementation-workflow-guide.md`

**For Each Workflow, customize these variables:**

### Core Project Variables
```
{PLAN_DOCUMENT_PATH} = docs-paperclip/disciplines/00800-design/[workflow-name]/project/2026-04-XX-[workflow-slug]-plan.md
{PROJECT_DOCUMENT_PATH} = docs-paperclip/disciplines/00800-design/[workflow-name]/project/2026-04-XX-[workflow-slug]-implementation.md
{CEO_AGENT} = nexus-devforge-ceo
{ISSUE_PREFIX} = DESIGN-[CODE]
```

### Company and Team Assignments
```
{PRIMARY_COMPANY} = DevForge AI
{PRIMARY_TEAM} = Engineering
{PRIMARY_AGENTS} = interface-devforge, codesmith-devforge, devcore-devforge
{PRIMARY_SKILLS} = Design Workflow Development, Project Management, Design Coordination

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

{DOMAIN_COMPANY} = DomainForge AI
{DOMAIN_TEAM} = Design
{DOMAIN_AGENTS} = design-domainforge
{DOMAIN_SKILLS} = Design Management, BIM Coordination
```

### Enhanced Template Variables for Schema Alignment
```
{PRIMARY_TABLE} = Main Supabase table for this workflow (e.g., design_deliverables, design_reviews, rfis)
{RELATED_TABLES} = Comma-separated list of dependent tables
{SCHEMA_INTEGRATION_POINTS} = Key integration points with existing schema
{DATA_VALIDATION_RULES} = Schema-based validation requirements
{RLS_COMPLIANCE_REQUIREMENTS} = Row-level security implementation needs
{AUDIT_TRAIL_REQUIREMENTS} = Audit logging requirements for compliance
```

---

## Step 5: Schema-Aware Phase Definitions

**Standard 5-Phase Structure for Design Workflows:**

```
{PHASE_1_NAME} = Phase 1: Schema Analysis & Design Data Modeling (Weeks 1-2)
{PHASE_1_ISSUE_1} = Analyze existing design table relationships and constraints
{PHASE_1_AGENT_1} = database-infraforge
{PHASE_1_ISSUE_2} = Design workflow data flow aligned with design schema
{PHASE_1_AGENT_2} = codesmith-devforge
{PHASE_1_ISSUE_3} = Implement RLS policies for new design workflow components
{PHASE_1_AGENT_3} = database-infraforge

{PHASE_2_NAME} = Phase 2: API Integration & Backend Development (Weeks 3-4)
{PHASE_2_ISSUE_1} = Build CRUD operations for primary design workflow table
{PHASE_2_AGENT_1} = devcore-devforge
{PHASE_2_ISSUE_2} = Implement workflow state management with schema alignment
{PHASE_2_AGENT_2} = codesmith-devforge
{PHASE_2_ISSUE_3} = Integrate with existing design APIs and external providers
{PHASE_2_AGENT_3} = interface-devforge

{PHASE_3_NAME} = Phase 3: Integration & Testing (Weeks 5-6)
{PHASE_3_ISSUE_1} = Implement real-time design tracking and alert systems
{PHASE_3_AGENT_1} = devcore-devforge
{PHASE_3_ISSUE_2} = Create comprehensive test suite with design scenarios
{PHASE_3_AGENT_2} = validator-qualityforge
{PHASE_3_ISSUE_3} = Performance optimization and security review
{PHASE_3_AGENT_3} = guardian-qualityforge

{PHASE_4_NAME} = Phase 4: Documentation & Training (Weeks 7-8)
{PHASE_4_ISSUE_1} = Create user documentation and design operational guides
{PHASE_4_AGENT_1} = doc-analyzer-knowledgeforge
{PHASE_4_ISSUE_2} = Develop training materials for design workflows
{PHASE_4_AGENT_2} = doc-analyzer-knowledgeforge
{PHASE_4_ISSUE_3} = Knowledge base integration and cross-referencing
{PHASE_4_AGENT_3} = doc-analyzer-knowledgeforge

{PHASE_5_NAME} = Phase 5: Deployment & Go-Live (Weeks 9-10)
{PHASE_5_ISSUE_1} = Production deployment and design data migration
{PHASE_5_AGENT_1} = database-infraforge
{PHASE_5_ISSUE_2} = User acceptance testing and design team training
{PHASE_5_AGENT_2} = validator-qualityforge
{PHASE_5_ISSUE_3} = Go-live support and design performance monitoring
{PHASE_5_AGENT_3} = guardian-qualityforge
```

---

## Step 6: Schema-Specific Success Criteria

**Database Integration Success Criteria:**
```
{FUNCTIONAL_SUCCESS_CRITERIA_1} = All design workflow data properly stored in aligned Supabase design tables
{FUNCTIONAL_SUCCESS_CRITERIA_2} = RLS policies correctly implemented for design data security
{FUNCTIONAL_SUCCESS_CRITERIA_3} = Foreign key relationships maintained across design operations
{FUNCTIONAL_SUCCESS_CRITERIA_4} = Audit trails capture all design state changes and formal communications
{FUNCTIONAL_SUCCESS_CRITERIA_5} = Real-time updates work with existing design subscription patterns
```

**Schema Compliance Validation:**
```
{TECHNICAL_RISK_1} = Schema changes may break existing design functionality
{TECHNICAL_RISK_1_MITIGATION} = Comprehensive testing against existing workflows before deployment

{TECHNICAL_RISK_2} = RLS policy conflicts may prevent legitimate design data access
{TECHNICAL_RISK_2_MITIGATION} = Thorough testing of permission scenarios with existing roles

{TECHNICAL_RISK_3} = Performance impact on existing design queries and reporting
{TECHNICAL_RISK_3_MITIGATION} = Database query optimization and indexing strategy for design data
```

---

## Step 7: Workflow-Specific Schema Mapping

### Priority Workflow Schema Alignments

#### 1. Design Coordination and Management Workflow (DESIGN-COORD)
- **Primary Table**: `design_deliverables`
- **Related Tables**: `projects`, `design_interfaces`, `design_reviews`
- **Key Integration**: Design deliverable tracking and interdisciplinary coordination
- **Audit Requirements**: Design coordination decision and communication tracking

#### 2. Design Review and Quality Assurance Workflow (DESIGN-REVIEW)
- **Primary Table**: `design_reviews`
- **Related Tables**: `design_deliverables`, `projects`
- **Key Integration**: Review process management and quality assurance tracking
- **Audit Requirements**: Review decision and approval workflow tracking

#### 3. Construction Support and RFI Management Workflow (DESIGN-CONSTRUCTION)
- **Primary Table**: `rfis`
- **Related Tables**: `projects`, `design_deliverables`
- **Key Integration**: RFI processing and construction support tracking
- **Audit Requirements**: RFI response and construction support tracking

#### 4. BIM and Model Coordination Workflow (DESIGN-BIM)
- **Primary Table**: `bim_models`
- **Related Tables**: `projects`, `design_deliverables`, `design_interfaces`
- **Key Integration**: BIM model management and coordination tracking
- **Audit Requirements**: Model coordination and clash detection tracking

#### 5. Design Change Control Workflow (DESIGN-CHANGE)
- **Primary Table**: `design_changes`
- **Related Tables**: `projects`, `design_deliverables`, `design_reviews`
- **Key Integration**: Change control and impact assessment tracking
- **Audit Requirements**: Change approval and implementation tracking

---

## Step 8: Implementation Execution

**For Each Workflow:**

1. **Create Project Folder Structure**
   ```bash
   mkdir -p docs-paperclip/disciplines/00800-design/[workflow-name]/project
   mkdir -p docs-paperclip/disciplines/00800-design/[workflow-name]/issues
   ```

2. **Copy and Customize Template**
   ```bash
   cp .clinerules/guide/project-implementation-workflow-guide.md \
      docs-paperclip/disciplines/00800-design/[workflow-name]/project/2026-04-XX-[workflow-slug]-implementation-guide.md
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
   - **DomainForge AI**: Design domain expertise (design-domainforge)

---

## Step 9: Quality Assurance

### Schema Compliance Checklist
- [ ] All new tables follow existing naming conventions
- [ ] Foreign key relationships properly defined
- [ ] RLS policies implemented for multi-tenant security
- [ ] Indexes created for performance-critical design queries
- [ ] Audit triggers configured for compliance tables
- [ ] Migration scripts tested against production data
- [ ] API endpoints documented with OpenAPI specs
- [ ] Database constraints validated for data integrity

### Integration Testing Requirements
- [ ] End-to-end workflow testing with real design schema data
- [ ] Performance testing against existing design query patterns
- [ ] Security testing for RLS policy effectiveness
- [ ] External API integration testing (BIM systems, CAD software)
- [ ] Real-time design tracking and alert system validation
- [ ] Rollback procedures documented and tested

---

## Step 10: Success Metrics & Monitoring

### Implementation Success Metrics
- **Schema Alignment**: 100% of workflows integrate with existing design tables
- **RLS Compliance**: Zero security violations in production
- **Performance**: No degradation of existing design queries and reporting
- **Data Integrity**: 100% foreign key relationship maintenance
- **Audit Compliance**: Complete audit trails for all design actions
- **External Integration**: Successful API connectivity and data flow

### Continuous Improvement
- **Schema Evolution**: Regular review of design table utilization and optimization opportunities
- **Performance Monitoring**: Ongoing monitoring of design query performance and reporting systems
- **Security Audits**: Regular RLS policy reviews and updates for design data
- **API Reliability**: Monitoring of external design API performance and failover procedures
- **User Feedback**: Incorporation of design team feedback into workflow improvements

---

This procedure ensures that all design workflow implementations are fully aligned with the existing Supabase schema architecture, maintaining data integrity, security, and performance while extending the design capabilities systematically.