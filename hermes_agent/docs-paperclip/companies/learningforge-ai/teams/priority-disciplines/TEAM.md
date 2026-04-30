---
name: Priority Disciplines Team
slug: learningforge-ai-priority-disciplines
company: learningforge-ai
division: priority-disciplines
description: Team focused on managing workflows for priority disciplines: Contracts, Procurement, Logistics, Safety, and Electrical Engineering.
---

# Priority Disciplines Team

Team focused on managing workflows for priority disciplines: Contracts, Procurement, Logistics, Safety, and Electrical Engineering.

## Team Lead

- `learningforge-ai-priority-disciplines-lead`

## Team Members

| Agent | Discipline | Code | Focus |
|-------|------------|------|-------|
| `learningforge-ai-contracts-agent` | Contracts | 00400 | Contract creation, compliance, negotiation |
| `learningforge-ai-procurement-agent` | Procurement | 01900 | Order workflows, supplier management |
| `learningforge-ai-logistics-agent` | Logistics | 01700 | Transportation, warehouse, shipping |
| `learningforge-ai-safety-workflow-agent` | Safety | 02400 | Incident reporting, training compliance |
| `learningforge-ai-electrical-engineering-agent` | Electrical Engineering | 00860 | Design, code compliance, commissioning |

## Priority Discipline Overview

| Priority | Discipline | Code | Current State | AutoResearch Focus |
|----------|------------|------|---------------|-------------------|
| 1 | Contracts | 00400 | Basic structure | Contract law updates, negotiation techniques |
| 2 | Procurement | 01900 | ✅ Production-ready | Market intelligence, supplier research |
| 3 | Logistics | 01700 | Basic structure | Supply chain optimization, transportation |
| 4 | Safety | 02400 | Partial implementation | EHS regulations, incident analysis |
| 5 | Electrical Engineering | 00860 | Technical structure | Electrical codes, technology updates |

## Team Goals

1. Implement standardized workflows for Contracts (00400)
2. Enhance existing Procurement (01900) workflows with AutoResearch
3. Develop Logistics (01700) workflows
4. Expand Safety (02400) workflows beyond contractor vetting
5. Create Electrical Engineering (00860) workflows

## Workflow Templates

Each discipline follows the established workflow template:

```
disciplines/{CODE}/workflow_docs/
├── {CODE}_COMPREHENSIVE_WORKFLOW.MD    # Main technical spec
├── {CODE}_WORKFLOW.MD                   # Implementation plan
├── {CODE}_USER_GUIDE.MD                # User documentation
├── {CODE}_TECHNICAL_SPEC.MD             # Technical specifications
├── {CODE}_IMPLEMENTATION.MD             # Implementation details
└── {CODE}_TESTING_EXECUTION.MD          # Testing report
```

## Integration with Other Teams

- **Learning & Curriculum**: Generate discipline-specific learning content
- **Safety & Quality**: Share safety and quality workflow data
- **Knowledge-Flow & Docs**: Document workflows in VFS
- **Research & Compliance**: Receive AutoResearch discipline updates
