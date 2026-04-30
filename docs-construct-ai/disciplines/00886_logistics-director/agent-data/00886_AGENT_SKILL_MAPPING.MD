---
title: 00886 Logistics Director Agent Skill Mapping
description: Mapping of skills to Logistics Director agents and their capabilities
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00886_logistics-director/agent-data
gigabrain_tags: disciplines, 00886_logistics-director, agent-skills, skill-mapping
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00886_logistics-director/agent-data/domain-knowledge/00886_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00886_logistics-director/agent-data/00886_AGENT_NAMING-MAP.MD
---

# 00886 Logistics Director Agent Skill Mapping

## Overview

This document maps skills to Logistics Director agents, defining which capabilities each agent possesses and how they coordinate to deliver logistics director executive oversight.

## Agent-to-Skill Matrix

| Agent Code | Agent Name | Primary Skills | Supporting Skills |
|-----------|------------|---------------|------------------|
| LOG-SUP-001 | Supplier Performance Agent | logistics-supplier-performance | pre-task-assessment-readiness |
| LOG-TRN-001 | Transportation Management Agent | logistics-transportation-management | pre-task-assessment-readiness, logistics-cost-optimization |
| LOG-WHS-001 | Warehouse Operations Agent | logistics-warehouse-operations | pre-task-assessment-readiness, logistics-inventory-control |
| LOG-INV-001 | Inventory Control Agent | logistics-inventory-control | pre-task-assessment-readiness, logistics-warehouse-operations |
| LOG-CST-001 | Freight Cost Agent | logistics-cost-optimization | pre-task-assessment-readiness, logistics-transportation-management |
| LOG-CUS-001 | Customs and Compliance Agent | logistics-customs-compliance | pre-task-assessment-readiness |
| LOG-RPT-001 | Logistics Executive Reporting Agent | logistics-executive-reporting | pre-task-assessment-readiness, all logistics skills |

## Skill Definitions

### Domain-Specific Skills

#### logistics-supplier-performance
**Location:** `docs-construct-ai/skills/domainforge_ai/00886_logistics-director/logistics-supplier-performance/SKILL.md`

**Purpose:** Monitor and analyze supplier delivery performance, quality metrics, lead time accuracy, and responsiveness to support supplier management and risk mitigation

**Capabilities:**
- On-time delivery rate calculation and trending
- Quality acceptance rate monitoring
- Lead time accuracy analysis
- Supplier responsiveness assessment
- Supplier scorecarding with weighted metrics
- Single-source dependency identification
- Supplier risk rating

**Agents Using This Skill:**
- LOG-SUP-001: Supplier Performance Agent (primary)
- LOG-RPT-001: Logistics Executive Reporting Agent (consumer)

**Automation Level:** Augment AI+Human

#### logistics-transportation-management
**Location:** `docs-construct-ai/skills/domainforge_ai/00886_logistics-director/logistics-transportation-management/SKILL.md`

**Purpose:** Optimize transportation routes, manage fleet operations, analyze freight costs, monitor carrier performance, and coordinate delivery logistics

**Capabilities:**
- Route optimization (multi-stop, backhaul opportunities)
- Fleet tracking and utilization monitoring
- Carrier performance scorecarding
- Delivery schedule management
- Transportation mode selection analysis
- Consolidation opportunity identification
- Freight cost per ton calculation

**Agents Using This Skill:**
- LOG-TRN-001: Transportation Management Agent (primary)
- LOG-CST-001: Freight Cost Agent (consumer)
- LOG-RPT-001: Logistics Executive Reporting Agent (consumer)

**Automation Level:** Augment AI+Human

#### logistics-warehouse-operations
**Location:** `docs-construct-ai/skills/domainforge_ai/00886_logistics-director/logistics-warehouse-operations/SKILL.md`

**Purpose:** Manage warehouse inventory, optimize space utilization, coordinate receiving/dispatch operations, implement stock rotation, and track warehouse KPIs

**Capabilities:**
- Inventory management (receipts, issues, transfers)
- Space utilization monitoring and optimization
- Receiving/dispatch workflow coordination
- Stock rotation (FIFO/FEFO) enforcement
- Warehouse KPI tracking (throughput, accuracy, cycle time)
- Slow-moving inventory identification
- Warehouse capacity planning

**Agents Using This Skill:**
- LOG-WHS-001: Warehouse Operations Agent (primary)
- LOG-INV-001: Inventory Control Agent (consumer)
- LOG-RPT-001: Logistics Executive Reporting Agent (consumer)

**Automation Level:** Augment AI+Human

#### logistics-inventory-control
**Location:** `docs-construct-ai/skills/domainforge_ai/00886_logistics-director/logistics-inventory-control/SKILL.md`

**Purpose:** Monitor stock levels, calculate reorder points, identify slow-moving inventory, optimize safety stock, and prevent stockouts or excess inventory

**Capabilities:**
- Stock level monitoring across all locations
- Reorder point calculation based on lead time and usage
- Safety stock optimization
- ABC analysis (inventory value classification)
- Slow-moving and obsolete inventory identification
- Stockout risk assessment
- Inventory turnover rate calculation

**Agents Using This Skill:**
- LOG-INV-001: Inventory Control Agent (primary)
- LOG-WHS-001: Warehouse Operations Agent (contributor)
- LOG-RPT-001: Logistics Executive Reporting Agent (consumer)

**Automation Level:** Full Automation

#### logistics-cost-optimization
**Location:** `docs-construct-ai/skills/domainforge_ai/00886_logistics-director/logistics-cost-optimization/SKILL.md`

**Purpose:** Track and analyze freight costs, identify cost reduction opportunities, perform cost-benefit analysis for logistics decisions, and monitor budget variance

**Capabilities:**
- Freight cost tracking and categorization
- Cost-per-unit and cost-per-ton analysis
- Budget variance monitoring
- Cost optimization opportunity identification
- Transportation mode cost comparison
- Consolidation benefit analysis
- Warehouse cost-per-unit-stored calculation

**Agents Using This Skill:**
- LOG-CST-001: Freight Cost Agent (primary)
- LOG-TRN-001: Transportation Management Agent (contributor)
- LOG-RPT-001: Logistics Executive Reporting Agent (consumer)

**Automation Level:** Augment AI+Human

#### logistics-customs-compliance
**Location:** `docs-construct-ai/skills/domainforge_ai/00886_logistics-director/logistics-customs-compliance/SKILL.md`

**Purpose:** Manage import/export documentation, ensure customs clearance compliance, track regulatory requirements, coordinate with customs brokers, and maintain trade compliance

**Capabilities:**
- Import/export documentation management
- Customs declaration accuracy verification
- HS code classification support
- Duty and tax calculation verification
- Customs clearance tracking
- Trade compliance monitoring
- Customs broker coordination

**Agents Using This Skill:**
- LOG-CUS-001: Customs and Compliance Agent (primary)
- LOG-RPT-001: Logistics Executive Reporting Agent (consumer)

**Automation Level:** Augment AI+Human

**Non-Delegable Human Decisions:**
- Customs declaration approval
- Trade compliance strategy
- Import/export license applications

#### logistics-executive-reporting
**Location:** `docs-construct-ai/skills/domainforge_ai/00886_logistics-director/logistics-executive-reporting/SKILL.md`

**Purpose:** Compile executive logistics briefings, prepare board reports, generate KPI dashboards, create management summaries, deliver strategic communications

**Capabilities:**
- Logistics data aggregation from all agents
- Real-time logistics dashboard generation
- Weekly executive briefing compilation
- Monthly board report preparation
- Trend analysis and strategic insights
- Logistics performance rating
- Supply chain risk assessment summary
- Executive decision support

**Agents Using This Skill:**
- LOG-RPT-001: Logistics Executive Reporting Agent (primary)

**Automation Level:** Augment AI+Human

### Shared Skills

#### pre-task-assessment-readiness
**Location:** `docs-construct-ai/skills/shared/pre-task-assessment-readiness/SKILL.md`

**Purpose:** Pre-task assessment and readiness verification before logistics operations

**Capabilities:**
- Task risk assessment
- Resource availability verification
- Prerequisites validation
- Authority and competency confirmation

**Agents Using This Skill:** All Logistics Director agents

## Skill Coordination Patterns

### Logistics Performance Monitoring Workflow
```
Supplier Performance Agent (LOG-SUP-001)
    → Uses: logistics-supplier-performance
    → Analyzes delivery data, calculates on-time delivery rate, identifies high-risk suppliers
    → Outputs: Supplier scorecard, delivery performance metrics
    ↓
Transportation Management Agent (LOG-TRN-001)
    → Uses: logistics-transportation-management
    → Analyzes route performance, tracks carrier performance, calculates freight costs
    → Outputs: Transportation KPIs, carrier scorecard
    ↓
Warehouse Operations Agent (LOG-WHS-001)
    → Uses: logistics-warehouse-operations
    → Analyzes inventory movements, monitors space utilization, tracks warehouse KPIs
    → Outputs: Warehouse performance metrics, space utilization report
    ↓
Inventory Control Agent (LOG-INV-001)
    → Uses: logistics-inventory-control
    → Analyzes stock levels, calculates reorder points, identifies slow-moving inventory
    → Outputs: Inventory status, stockout risks, reorder recommendations
    ↓
Freight Cost Agent (LOG-CST-001)
    → Uses: logistics-cost-optimization
    → Analyzes freight costs, identifies cost reduction opportunities, monitors budget variance
    → Outputs: Cost analysis, optimization recommendations
    ↓
Customs and Compliance Agent (LOG-CUS-001)
    → Uses: logistics-customs-compliance
    → Verifies import/export compliance, tracks customs clearance, monitors regulatory requirements
    → Outputs: Customs compliance status, clearance delays
    ↓
Logistics Executive Reporting Agent (LOG-RPT-001)
    → Uses: logistics-executive-reporting
    → Compiles all logistics performance data into executive briefing
    → Outputs: Executive logistics dashboard, board briefing
    ↓
Director Review and Approval
```

### Supply Chain Issue Management Workflow
```
Supplier Performance Agent (LOG-SUP-001)
    → Uses: logistics-supplier-performance, pre-task-assessment-readiness
    → Detects supplier delivery delays or quality issues
    → Assesses impact on project schedule
    → Outputs: Supplier issue alert, alternative supplier recommendations
    ↓
Inventory Control Agent (LOG-INV-001)
    → Uses: logistics-inventory-control
    → Assesses inventory impact of supplier delay
    → Checks for alternative stock sources
    → Outputs: Stockout risk assessment, mitigation options
    ↓
Transportation Management Agent (LOG-TRN-001)
    → Uses: logistics-transportation-management
    → Evaluates expedited delivery options
    → Calculates cost impact of alternative transportation
    → Outputs: Transportation alternatives, cost-benefit analysis
    ↓
Freight Cost Agent (LOG-CST-001)
    → Uses: logistics-cost-optimization
    → Analyzes cost impact of mitigation options
    → Compares alternatives
    → Outputs: Cost comparison, budget impact
    ↓
Logistics Executive Reporting Agent (LOG-RPT-001)
    → Uses: logistics-executive-reporting
    → Compiles issue summary for director decision
    → Presents mitigation options with cost-benefit analysis
    → Outputs: Executive decision brief
    ↓
Director Decision and Authorization
```

### Inventory Replenishment Workflow
```
Inventory Control Agent (LOG-INV-001)
    → Uses: logistics-inventory-control, pre-task-assessment-readiness
    → Monitors stock levels against reorder points
    → Generates reorder recommendations
    → Outputs: Reorder alerts, recommended quantities
    ↓
Supplier Performance Agent (LOG-SUP-001)
    → Uses: logistics-supplier-performance
    → Recommends supplier based on performance and lead time
    → Verifies supplier availability and capacity
    → Outputs: Supplier recommendation, expected delivery date
    ↓
Freight Cost Agent (LOG-CST-001)
    → Uses: logistics-cost-optimization
    → Evaluates transportation options
    → Recommends cost-effective delivery method
    → Outputs: Transportation recommendation, cost estimate
    ↓
Transportation Management Agent (LOG-TRN-001)
    → Uses: logistics-transportation-management
    → Coordinates delivery logistics
    → Tracks shipment
    → Outputs: Delivery schedule, tracking information
    ↓
Warehouse Operations Agent (LOG-WHS-001)
    → Uses: logistics-warehouse-operations
    → Prepares for receipt
    → Processes incoming material
    → Updates inventory
    → Outputs: Receipt confirmation, updated stock levels
```

## Skill Development Roadmap

### Phase 1: Core Logistics Monitoring (Planned)
- [ ] logistics-supplier-performance skill creation
- [ ] logistics-transportation-management skill creation
- [ ] logistics-warehouse-operations skill creation
- [ ] logistics-inventory-control skill creation
- [ ] logistics-cost-optimization skill creation
- [ ] logistics-customs-compliance skill creation
- [ ] logistics-executive-reporting skill creation

### Phase 2: Advanced Logistics Analytics
- [ ] Predictive delivery delay modeling
- [ ] Dynamic route optimization with real-time traffic
- [ ] Automated supplier risk scoring
- [ ] Warehouse space optimization algorithms

### Phase 3: Proactive Logistics Intelligence
- [ ] Supply chain disruption forecasting
- [ ] Inventory optimization with demand forecasting
- [ ] Freight cost prediction modeling
- [ ] Supplier performance trend analysis

## Cross-Discipline Integration

### Integration with Related Disciplines

| Related Discipline | Integration Point | Shared Data/Skills |
|-------------------|------------------|-------------------|
| 01900 Procurement | Supplier sourcing, purchase orders | Supplier performance data, delivery tracking |
| 00883 Contracts Director | Commercial oversight | Supplier contracts, performance compliance |
| 00882 Construction Director | Material requirements | Construction schedule, material requisitions |
| 00889 Finance Director | Budget management | Freight costs, budget variance |
| 00300 Construction | Site logistics | Material delivery to site, site inventory |

## Version History

- **v1.0** (2026-04-01): Initial Logistics Director Agent Skill Mapping
- Defined 7 logistics director agents with skill assignments
- Mapped logistics skills to all logistics agents
- Documented logistics performance monitoring, supply chain issue management, and inventory replenishment workflows
