---
title: 01900 Procurement Discipline Prompt Template
description: Specialized prompt template for Order Creation, Supplier Management, and Approval Workflow tasks using Construct AI memory system with Gigabrain
version: 1.0
memory_layer: durable_knowledge
para_section: docs/memory-stack/templates/procurement
gigabrain_tags: disciplines, 01900_procurement, procurement-workflows, order-creation, supplier-management, approval-routing
openstinger_context: procurement-lifecycle, order-processing, supplier-integration, approval-workflows
last_updated: 2026-03-23
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/para-index.md
  - docs_construct_ai/disciplines/01900_procurement/1900_README.MD
  - docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/1900_API_SPEC.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/1900_INTEGRATIONS.MD
---

# 01900 Procurement Discipline Prompt Template

## Overview

This specialized template provides a standardized structure for prompts related to the 01900 Procurement discipline, leveraging the full power of the Construct AI memory system with Gigabrain integration. Use this template for all Order Creation, Supplier Management, Approval Workflows, Scope of Work (SOW) Generation, and Procurement Automation tasks.

## Discipline Context

### 01900 Procurement Scope
The 01900 Procurement discipline encompasses:
- **Order Creation**: Purchase orders, service orders, work orders with 5-phase workflow
- **Supplier Management**: Supplier directory, qualification, performance monitoring
- **Approval Workflows**: Dynamic routing, value-based approval matrices, HITL integration
- **Scope of Work (SOW)**: Template selection, appendix generation, document compilation
- **Procurement Automation**: AI agents, chatbot integration, intelligent suggestions
- **Template Management**: Unified template system, complexity specification, migration
- **Compliance & Validation**: Budget approval, regulatory compliance, quality assurance
- **Integration**: Supplier portal, logistics coordination, finance integration

### Related Disciplines
- **00435 Contracts Post-Award**: Contract amendments, performance monitoring, document integration
- **01700 Logistics**: Supplier performance, transportation coordination, inventory integration
- **01200 Finance**: Budget approval, payment processing, cost control
- **00888 Procurement Director**: Executive oversight, strategic procurement, performance metrics
- **02400 Safety**: Safety compliance, hazardous materials, safety protocols
- **01750 Legal**: Regulatory compliance, contract law, trade regulations

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 01900 Procurement discipline:

**PARA Navigation:**
- Access docs_construct_ai/para/pages/disciplines/01900_procurement/
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 01900_procurement", "[specific-area]", "[context-tag]"
- Filter by tags: "procurement-workflows", "order-creation", "supplier-management", "approval-routing"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with related disciplines (00435, 01700, 01200)
- Check memory/YYYY-MM-DD.md for recent procurement task context

**Procurement Domain Context:**
- Reference procurement workflow documentation: docs_construct_ai/disciplines/01900_procurement/workflow_docs/
- Apply order creation procedures from: docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD
- Follow approval workflow framework: docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_PROCUREMENT_APPROVAL_WORKFLOWS_MANAGEMENT.MD

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar procurement procedures
- Build on established procurement organizational knowledge
- Ensure compliance and approval alignment

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## Procurement-Specific Use Case Templates

### Order Creation & Processing
```
Create/Process [ORDER_TYPE] using memory system integration:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/01900_procurement/
- Reference order creation workflow: docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD
- Check docs_construct_ai/para/pages/disciplines/01200_finance/ for budget approval context

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "order-creation", "[order-type]"
- Filter by tags: "procurement-workflows", "purchase-order", "service-order", "work-order"

Memory Context:
- Include memory headers with order-specific gigabrain_tags
- Cross-reference with finance discipline for budget approval
- Reference historical order processing data

Procurement Domain Context:
- Apply 5-phase order creation workflow (Basic Info → Template → Disciplines → Approval → Review)
- Use order type selection (Purchase Order, Service Order, Work Order)
- Follow approval matrix based on order value and type
- Implement HITL integration for complex orders

Provide order creation guidance with:
- Phase-by-phase workflow instructions
- Required fields and validation rules
- Approval routing configuration
- Template selection recommendations
- Post-creation workflow initiation
```

### Supplier Management & Evaluation
```
Manage/Evaluate [SUPPLIER_AREA] using memory system integration:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/01900_procurement/
- Reference supplier documentation: docs_construct_ai/disciplines/01900_procurement/suppliers/
- Check docs_construct_ai/para/pages/disciplines/01700_logistics/ for delivery performance

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "supplier-management", "[evaluation-type]"
- Filter by tags: "supplier-qualification", "vendor-evaluation", "performance-monitoring"

Memory Context:
- Include memory headers with supplier-specific gigabrain_tags
- Cross-reference with logistics discipline for delivery reliability
- Reference historical supplier performance metrics

Procurement Domain Context:
- Follow supplier qualification process (Platinum/Gold/Silver/Bronze tiers)
- Apply performance monitoring (delivery reliability, quality, responsiveness)
- Use risk assessment frameworks (financial stability, compliance, capacity)
- Implement supplier directory management

Provide supplier evaluation with:
- Pre-qualification assessment criteria
- Performance evaluation metrics
- Risk assessment methodology
- Improvement recommendations
- Monitoring and review schedule
```

### Approval Workflow Configuration
```
Configure [APPROVAL_WORKFLOW] using memory system integration:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/01900_procurement/
- Reference approval workflows: docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_PROCUREMENT_APPROVAL_WORKFLOWS_MANAGEMENT.MD
- Check docs_construct_ai/para/pages/disciplines/01200_finance/ for budget authority matrices

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "approval-routing", "[workflow-type]"
- Filter by tags: "approval-matrix", "value-based-routing", "hitl-integration"

Memory Context:
- Include memory headers with approval-specific gigabrain_tags
- Cross-reference with finance discipline for authority limits
- Reference historical approval workflow performance

Procurement Domain Context:
- Apply value-based approval matrix (<$25k, $25k-$100k, >$100k thresholds)
- Use routing types (Sequential, Parallel, Hybrid)
- Follow HITL integration for confidence-based escalation
- Implement cover sheet generation

Provide approval workflow configuration with:
- Approval matrix setup based on order value
- Routing type selection (Sequential/Parallel/Hybrid)
- Approver assignment and validation
- HITL threshold configuration
- Escalation and notification rules
```

### Scope of Work (SOW) Generation
```
Generate [SOW_DOCUMENT] using memory system integration:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/01900_procurement/
- Reference SOW templates: docs_construct_ai/disciplines/01900_procurement/templates/
- Check docs_construct_ai/para/pages/disciplines/00435_contracts/ for contract integration

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "scope-of-work", "[sow-type]"
- Filter by tags: "sow-generation", "template-selection", "appendix-compilation"

Memory Context:
- Include memory headers with SOW-specific gigabrain_tags
- Cross-reference with contracts discipline for legal requirements
- Reference historical SOW generation patterns

Procurement Domain Context:
- Apply 19-stage SOW generation workflow
- Use template selection based on order type and complexity
- Follow appendix generation (A-F) with discipline-specific content
- Implement document compilation and validation

Provide SOW generation guidance with:
- Template selection recommendations
- Appendix structure and content requirements
- Discipline assignment for each appendix
- Document compilation workflow
- Quality validation and review process
```

### Procurement AI Agent Integration
```
Implement/Configure [AGENT_INTEGRATION] using memory system integration:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/01900_procurement/
- Reference agent data: docs_construct_ai/disciplines/01900_procurement/agent-data/
- Check docs_construct_ai/para/pages/codebase/agents/ for agent frameworks

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "ai-agents", "[agent-type]"
- Filter by tags: "procurement-automation", "agent-integration", "chatbot-integration"

Memory Context:
- Include memory headers with agent-specific gigabrain_tags
- Cross-reference with codebase agents for implementation patterns
- Reference historical agent deployment and performance

Procurement Domain Context:
- Apply agent registry and capability framework
- Use supervisor/specialist agent architecture
- Follow agent implementation procedures
- Implement chatbot integration for user interaction

Provide agent integration guidance with:
- Agent selection and capability mapping
- Implementation procedures and best practices
- Integration with procurement workflows
- Performance monitoring and optimization
- User interaction and chatbot configuration
```

### Template Management & Migration
```
Manage/Migrate [TEMPLATE_AREA] using memory system integration:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/01900_procurement/
- Reference template documentation: docs_construct_ai/disciplines/01900_procurement/templates/
- Check docs_construct_ai/para/pages/codebase/database/ for schema context

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "template-management", "[template-type]"
- Filter by tags: "unified-templates", "template-migration", "complexity-specification"

Memory Context:
- Include memory headers with template-specific gigabrain_tags
- Cross-reference with database schema for data structure
- Reference historical template usage and migration patterns

Procurement Domain Context:
- Apply unified template architecture (procurement_templates → templates migration)
- Use explicit complexity specification (simple/standard/complex/emergency/compliance)
- Follow template variation system for agent assignments
- Implement discipline-specific document sections

Provide template management guidance with:
- Template creation and configuration
- Complexity level specification
- Migration procedures and validation
- Integration with order creation workflows
- Quality assurance and testing
```

### Procurement Compliance & Validation
```
Validate [COMPLIANCE_AREA] using memory system integration:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/01900_procurement/
- Reference compliance documentation: docs_construct_ai/disciplines/01900_procurement/agent-data/1900_SECURITY.MD
- Check docs_construct_ai/para/pages/disciplines/01200_finance/ for budget compliance

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "compliance-validation", "[compliance-type]"
- Filter by tags: "budget-approval", "regulatory-compliance", "quality-assurance"

Memory Context:
- Include memory headers with compliance-specific gigabrain_tags
- Cross-reference with finance discipline for budget constraints
- Reference historical compliance audit results

Procurement Domain Context:
- Apply budget approval thresholds and authority matrices
- Use regulatory compliance frameworks
- Follow quality assurance procedures
- Implement audit trail and documentation

Provide compliance validation with:
- Budget approval verification
- Regulatory compliance checklist
- Quality assurance validation
- Audit trail documentation
- Risk assessment and mitigation
```

### Procurement Data Analytics & Reporting
```
Analyze [PROCUREMENT_DATA_AREA] using memory system integration:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/01900_procurement/
- Reference data pipelines: docs_construct_ai/disciplines/01900_procurement/agent-data/1900_DATA_PIPELINES.MD
- Check docs_construct_ai/para/pages/codebase/analytics/ for analytics frameworks

Gigabrain Search:
- Search gigabrain tags for "disciplines, 01900_procurement", "procurement-analytics", "[analysis-type]"
- Filter by tags: "data-pipelines", "spend-analysis", "performance-metrics"

Memory Context:
- Include memory headers with analytics-specific gigabrain_tags
- Cross-reference with finance discipline for cost analysis
- Reference historical procurement performance data

Procurement Domain Context:
- Apply procurement KPI frameworks (order cycle time, approval efficiency, supplier performance)
- Use spend analysis methodologies (category analysis, supplier consolidation)
- Follow data pipeline best practices (ETL, data quality, real-time processing)
- Implement dashboard and reporting solutions

Provide procurement analytics with:
- Key performance indicators and metrics
- Spend analysis and insights
- Process efficiency recommendations
- Dashboard and reporting design
- Data quality improvement initiatives
```

## Procurement-Specific Gigabrain Tags

### Primary Discipline Tags
```
disciplines, 01900_procurement
disciplines, 01900_procurement, procurement-workflows
disciplines, 01900_procurement, order-creation
disciplines, 01900_procurement, supplier-management
disciplines, 01900_procurement, approval-routing
disciplines, 01900_procurement, scope-of-work
disciplines, 01900_procurement, procurement-automation
```

### Procurement Process Tags
```
procurement-workflows, order-creation, supplier-management
order-creation, purchase-order, service-order, work-order
approval-routing, approval-matrix, value-based-routing
scope-of-work, sow-generation, template-selection
supplier-management, supplier-qualification, vendor-evaluation
procurement-automation, ai-agents, chatbot-integration
template-management, unified-templates, complexity-specification
```

### Cross-Discipline Integration Tags
```
disciplines, 00435_contracts, contract-amendments
disciplines, 01700_logistics, supplier-performance
disciplines, 01200_finance, budget-approval
disciplines, 00888_procurement-director, strategic-procurement
disciplines, 02400_safety, safety-compliance
disciplines, 01750_legal, regulatory-compliance
```

### Technical Implementation Tags
```
workflows, codebase, automation, procurement-automation
testing, codebase, quality-assurance, procurement-testing
guides, codebase, documentation, procurement-documentation
api, codebase, integration, procurement-api
database, codebase, data-management, procurement-data
```

## Procurement-Specific PARA Navigation

### Primary Procurement Paths
```
docs_construct_ai/para/pages/disciplines/01900_procurement/
docs_construct_ai/disciplines/01900_procurement/agent-data/
docs_construct_ai/disciplines/01900_procurement/workflow_docs/
docs_construct_ai/disciplines/01900_procurement/templates/
docs_construct_ai/disciplines/01900_procurement/plan/
docs_construct_ai/disciplines/01900_procurement/testing/
docs_construct_ai/disciplines/01900_procurement/implementation/
```

### Related Discipline Paths
```
docs_construct_ai/para/pages/disciplines/00435_contracts-post-award/
docs_construct_ai/para/pages/disciplines/01700_logistics/
docs_construct_ai/para/pages/disciplines/01200_finance/
docs_construct_ai/para/pages/disciplines/00888_procurement-director/
docs_construct_ai/para/pages/disciplines/02400_safety/
docs_construct_ai/para/pages/disciplines/01750_legal/
```

### Codebase Integration Paths
```
docs_construct_ai/para/pages/codebase/workflows/
docs_construct_ai/para/pages/codebase/api/
docs_construct_ai/para/pages/codebase/database/
docs_construct_ai/para/pages/codebase/agents/
docs_construct_ai/para/pages/codebase/integrations/
```

## Procurement-Specific Memory Headers

### Standard Procurement Memory Header
```yaml
---
title: [Document Title]
description: [Brief description of procurement document/process]
version: [Version number]
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01900_procurement/[subdirectory]
gigabrain_tags: disciplines, 01900_procurement, [specific-tags], [process-tags]
openstinger_context: [procurement-context], [workflow-context]
last_updated: [YYYY-MM-DD]
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/para-index.md
  - [Related procurement documents]
  - [Related discipline documents]
---
```

### Procurement Workflow Memory Header
```yaml
---
title: [Workflow Title]
description: [Workflow description and scope]
version: [Version number]
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01900_procurement/workflow_docs
gigabrain_tags: disciplines, 01900_procurement, procurement-workflows, [workflow-type], [operation-type]
openstinger_context: procurement-workflow-lifecycle, process-optimization
last_updated: [YYYY-MM-DD]
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD
  - [Related workflows]
  - [Integration specifications]
---
```

### Procurement Agent Memory Header
```yaml
---
title: [Agent Title]
description: [Agent capabilities and purpose]
version: [Version number]
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01900_procurement/agent-data
gigabrain_tags: disciplines, 01900_procurement, ai-agents, [agent-type], [capability-type]
openstinger_context: procurement-automation, agent-integration
last_updated: [YYYY-MM-DD]
related_docs:
  - docs_construct_ai/disciplines/01900_procurement/agent-data/1900_AGENTS-REGISTRY-SUMMARY.MD
  - [Related agents]
  - [Implementation specifications]
---
```

## Procurement-Specific Best Practices

### Order Creation Best Practices
1. **5-Phase Workflow**: Follow structured order creation (Basic Info → Template → Disciplines → Approval → Review)
2. **Template Selection**: Choose appropriate SOW template based on order type and complexity
3. **Approval Routing**: Configure value-based approval matrix for proper governance
4. **Discipline Assignment**: Map disciplines to appendices for comprehensive coverage
5. **HITL Integration**: Implement human oversight for complex or high-value orders

### Supplier Management Best Practices
1. **Qualification Tiers**: Use Platinum/Gold/Silver/Bronze classification for supplier evaluation
2. **Performance Monitoring**: Track delivery reliability, quality metrics, and responsiveness
3. **Risk Assessment**: Evaluate financial stability, compliance, and capacity
4. **Continuous Improvement**: Implement feedback loops and corrective actions
5. **Directory Management**: Maintain accurate and up-to-date supplier information

### Approval Workflow Best Practices
1. **Value-Based Routing**: Use order value thresholds for approval authority
2. **Routing Types**: Select Sequential/Parallel/Hybrid based on order complexity
3. **Cover Sheet Generation**: Enable approval cover sheets for documentation
4. **Escalation Rules**: Define clear escalation paths for delayed approvals
5. **Audit Trail**: Maintain complete approval history for compliance

### SOW Generation Best Practices
1. **Template Selection**: Choose template based on order type and complexity level
2. **Appendix Structure**: Follow A-F appendix framework for comprehensive documentation
3. **Discipline Mapping**: Assign appropriate disciplines to each appendix section
4. **Document Compilation**: Validate all sections before final generation
5. **Quality Review**: Implement review process for SOW accuracy and completeness

### Procurement Automation Best Practices
1. **Agent Architecture**: Use supervisor/specialist agent pattern for complex workflows
2. **Capability Mapping**: Match agent capabilities to procurement process requirements
3. **Integration Testing**: Validate agent integration with procurement workflows
4. **Performance Monitoring**: Track agent efficiency and accuracy
5. **User Experience**: Implement chatbot for intuitive user interaction

## Procurement-Specific Integration Checklist

### For Every Procurement Prompt
- [ ] **Task Description**: Clear, specific procurement objective
- [ ] **PARA Navigation**: Procurement discipline path + related disciplines
- [ ] **Gigabrain Search**: Procurement-specific tags (2-3 primary + context tags)
- [ ] **Memory Context**: Procurement memory headers and cross-references
- [ ] **Procurement Domain Context**: Reference workflows, procedures, frameworks
- [ ] **Compliance Alignment**: Ensure budget approval and regulatory compliance
- [ ] **Knowledge Integration**: Build on established procurement patterns

### For Complex Procurement Tasks
- [ ] **Multi-Discipline Access**: Contracts, logistics, finance integration
- [ ] **Cross-Reference Analysis**: Similar workflows, implementations, optimizations
- [ ] **Compliance Mapping**: Applicable budget, regulatory, and quality requirements
- [ ] **Stakeholder Involvement**: Suppliers, approvers, finance, legal
- [ ] **Implementation Planning**: Timeline, resources, technology requirements
- [ ] **Monitoring Framework**: KPIs, review schedule, improvement process

## Procurement-Specific Success Metrics

### Quality Indicators
- **Order Accuracy**: Correct order details, pricing, and specifications
- **Approval Efficiency**: Timely approval routing and processing
- **Supplier Performance**: Delivery reliability, quality, and responsiveness
- **Compliance Rate**: Adherence to budget and regulatory requirements
- **Process Automation**: Reduction in manual processing and errors

### Process Indicators
- **Order Cycle Time**: Time from order creation to completion
- **Approval Turnaround**: Time for approval routing and decision
- **Supplier Qualification Rate**: Percentage of qualified suppliers
- **SOW Generation Accuracy**: Correctness of generated documents
- **User Satisfaction**: Ease of use and process efficiency

## Procurement-Specific Troubleshooting

### If Order Creation Workflow Seems Incomplete
```
Request: "Expand the workflow by checking template selection options, reviewing approval routing configuration, verifying discipline assignments, and confirming HITL integration requirements."
```

### If Supplier Management Lacks Depth
```
Specify: "Deepen the evaluation by applying qualification tier criteria, analyzing performance metrics, reviewing risk assessment frameworks, and identifying improvement opportunities."
```

### If Approval Workflow Is Unclear
```
Clarify: "Reference approval workflow documentation, check value-based routing rules, review authority matrices, and verify escalation procedures."
```

### If SOW Generation Is Uncertain
```
Verify: "Cross-reference with template selection criteria, check appendix structure requirements, review discipline assignments, and confirm document compilation process."
```

## Version History

- **v1.0** (2026-03-23): Initial procurement-specific prompt template creation
- Comprehensive procurement domain coverage (orders, suppliers, approvals, SOW, automation, templates, compliance, analytics)
- Procurement-specific gigabrain tags and PARA navigation
- Cross-discipline integration guidance
- Procurement-specific best practices and success metrics

## Related Resources

- [01900 Procurement PARA Index](docs_construct_ai/disciplines/01900_procurement/para-index.md)
- [Procurement Discipline Overview](docs_construct_ai/disciplines/01900_procurement/1900_README.MD)
- [Order Creation Workflow](docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_CREATE_PROCUREMENT_ORDER_WORKFLOW.MD)
- [Procurement API Specification](docs_construct_ai/disciplines/01900_procurement/agent-data/1900_API_SPEC.MD)
- [Procurement Integrations](docs_construct_ai/disciplines/01900_procurement/agent-data/1900_INTEGRATIONS.MD)
- [Approval Workflows Management](docs_construct_ai/disciplines/01900_procurement/workflow_docs/1900_PROCUREMENT_APPROVAL_WORKFLOWS_MANAGEMENT.MD)
- [Gigabrain Tags Reference](docs/memory-stack/tags/gigabrain-tags-reference.md)
- [Cline Memory System Usage Guide](docs_construct_ai/Cline Memory System Usage Guide.md)
- [Memory System Quick Reference](docs_construct_ai/Memory System Quick Reference Methodology.md)