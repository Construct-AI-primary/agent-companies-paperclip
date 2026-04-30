---
title: "Logistics Agent-Skill Mapping"
description: "Agent and skill mapping for the Logistics discipline, covering freight management, customs clearance, delivery tracking, inventory management, and warehousing"
version: "1.0"
memory_layer: durable_knowledge
para_section: Logistics-Operations
gigabrain_tags:
  - logistics
  - agent-mapping
  - freight-management
  - customs-clearance
  - delivery-tracking
  - inventory-management
  - warehousing
openstinger_context: logistics-ops-v1
last_updated: 2026-03-31
related_docs:
  - "01700_LOGISTICS-DISCIPLINE-OVERVIEW.md"
  - "01700_LOGISTICS-PROCESS-MAP.md"
  - "01700_LOGISTICS-SKILL-REGISTRY.md"
---

# Logistics Agent-Skill Mapping

## Overview

This document defines the agent and skill mappings for the **Logistics** discipline (01700). It establishes how autonomous agents are assigned to specific logistics skills across freight management, customs clearance, delivery tracking, inventory management, and warehousing. The mapping ensures clear ownership, responsibilities, and cross-team interoperability for all logistics-related operations.

---

## Agent Summary by Skill

### Skill: logistics-freight-management

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Booker | Freight Booking Agent | Production / TMS | Book, manage, and optimize freight shipments across carriers, modes, and routes |
| Tracker | Tracking Agent | Production / Tracking Systems | Monitor shipment status, ETA updates, milestone events, and exception conditions across all freight movements |
| Reporter | Reporting Agent | Production / Analytics Systems | Generate freight cost analysis, carrier performance scorecards, and route optimization reports |

### Skill: logistics-customs-clearance

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Filers | Customs Agent | Production / Customs Systems | Prepare and submit customs declarations, tariff classifications, and trade compliance documentation |
| Approver | Clearance Agent | Production / Customs Systems | Coordinate customs clearance approvals, manage duty/tax payments, and maintain clearance status tracking |
| Reporter | Reporting Agent | Production / Analytics Systems | Produce customs compliance reports, duty cost summaries, and clearance cycle time analysis |

### Skill: logistics-delivery-tracking

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Tracker | Tracking Agent | Production / Tracking Systems | Monitor last-mile and final delivery status, coordinate delivery confirmations, and manage recipient communications |
| Manager | Delivery Agent | Production / Delivery Systems | Orchestrate delivery routing, assign delivery resources, manage delivery windows, and coordinate with downstream handlers |
| Responder | Exception Agent | Production / Alert Systems | Detect delivery exceptions, manage rerouting, coordinate recovery actions, and escalate unresolved issues |
| Reporter | Reporting Agent | Production / Analytics Systems | Generate delivery performance metrics, exception analysis, and customer satisfaction reports |

### Skill: logistics-inventory-management

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Controller | Inventory Agent | Production / IMS | Monitor inventory levels, manage stock replenishment triggers, optimize safety stock parameters, and reconcile inventory records |
| Responder | Exception Agent | Production / Alert Systems | Detect inventory discrepancies, stockouts, overstock conditions, and initiate corrective actions |
| Reporter | Reporting Agent | Production / Analytics Systems | Produce inventory valuation reports, turnover analysis, and demand forecast accuracy metrics |

### Skill: logistics-warehousing

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Manager | Warehouse Agent | Production / WMS | Manage warehouse space allocation, slotting optimization, pick paths, and labor scheduling |
| Controller | Inventory Agent | Production / WMS / IMS | Coordinate putaway, picking, and cycle count operations between warehouse and inventory systems |
| Responder | Exception Agent | Production / Alert Systems | Handle warehouse operational exceptions including receiving discrepancies, picking errors, and space constraints |
| Fixer | Remediation Agent | Production / Operations Systems | Execute corrective actions for failed warehouse operations, inventory adjustments, and order fulfillment recovery |
| Reporter | Reporting Agent | Production / Analytics Systems | Generate warehouse utilization reports, order fulfillment metrics, and operational efficiency dashboards |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Capabilities | Trigger Conditions | Output Artifacts |
|-------|-----------------|--------------|-------------------|------------------|
| Freight Booking Agent | logistics-freight-management | Carrier rate comparison, multi-mode booking, route optimization, booking confirmation, cancellation management | Shipment creation, tender acceptance, carrier capacity alerts | Booking confirmations, freight orders, rate comparisons |
| Customs Agent | logistics-customs-clearance | Tariff classification, customs declaration preparation, trade compliance validation, document generation | Shipment nearing border, import/export trigger, regulatory change | Customs declarations, tariff classifications, compliance certificates |
| Clearance Agent | logistics-customs-clearance | Clearance status monitoring, duty/tax calculation, payment processing, broker coordination | Customs submission, duty payment due, clearance hold | Clearance confirmations, duty payment records, release notices |
| Delivery Agent | logistics-delivery-tracking | Route planning, delivery appointment scheduling, resource assignment, recipient notification coordination | Shipment arrival at final hub, delivery window scheduling, route optimization cycle | Delivery assignments, route schedules, recipient notifications |
| Tracking Agent | logistics-freight-management, logistics-delivery-tracking | Multi-carrier tracking, ETA prediction, milestone detection, geofencing, status aggregation | Shipment booked, in-transit events, delivery scheduled, carrier updates | Tracking records, milestone logs, ETA updates, delivery confirmations |
| Warehouse Agent | logistics-warehousing | Space management, slotting optimization, pick path generation, labor forecasting, equipment scheduling | Inventory receipt, order wave creation, capacity thresholds, labor optimization cycles | Slotting plans, pick orders, labor schedules, space utilization reports |
| Inventory Agent | logistics-inventory-management, logistics-warehousing | Reorder point management, demand forecasting input, cycle count scheduling, stock reconciliation, ABC classification | Inventory threshold breaches, demand signal reception, periodic count schedule, receiving completion | Reorder requests, stock reconciliation records, cycle count results |
| Exception Agent | logistics-delivery-tracking, logistics-inventory-management, logistics-warehousing | Multi-domain exception detection, root cause classification, escalation routing, recovery coordination | Delivery delays, inventory discrepancies, warehouse operational failures, threshold breaches | Exception tickets, escalation records, exception summaries |
| Remediation Agent | logistics-warehousing | Corrective action execution, inventory adjustment processing, order re-fulfillment, damaged goods disposition, system reconciliation | Failed warehouse operation, inventory adjustment request, order fulfillment failure, exception escalation | Remediation orders, adjustment records, recovery confirmations |
| Reporting Agent | logistics-freight-management, logistics-customs-clearance, logistics-delivery-tracking, logistics-inventory-management, logistics-warehousing | Cross-domain report generation, KPI aggregation, cost analysis, performance benchmarking, dashboard publishing | Reporting cycles, stakeholder requests, regulatory filing deadlines, performance review periods | Logistics dashboards, carrier scorecards, customs compliance reports, delivery KPIs, inventory reports, warehouse utilization reports |

---

## Cross-Team Agent Assignments

### OpenClaw Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Delivery Agent | Primary owner | Last-mile routing logic, recipient notification UI/UX |
| Tracking Agent | Primary owner | Multi-carrier tracking integration, geofencing, ETA prediction |
| Exception Agent | Primary owner | Exception detection engine, multi-domain event correlation |

### deep-agents Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Freight Booking Agent | Primary owner | Carrier integration, rate engine, booking automation |
| Customs Agent | Primary owner | Tariff classification engine, customs document generation |
| Clearance Agent | Primary owner | Broker coordination, duty/tax processing, clearance workflow |
| Remediation Agent | Primary owner | Corrective action planning, recovery orchestration |

### JS Swarm Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Warehouse Agent | Primary owner | Slotting algorithms, labor scheduling swarm, pick path optimization |
| Inventory Agent | Primary owner | Distributed inventory consensus, stock rebalancing swarm |
| Reporting Agent | Shared owner | Report generation swarm, visualization components, cross-domain analytics |

### DevForge Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Reporting Agent | Infrastructure owner | Analytics pipeline infrastructure, data warehouse integration, CI/CD for reporting services |
| All Logistics Agents | Platform support | Shared authentication, RBAC, EDI integration infrastructure, API gateway management, deployment pipelines |

---

## Dependencies and Integrations

| Dependency | Related Agent(s) | Integration Type | Notes |
|------------|-----------------|-----------------|-------|
| TMS Platforms (Oracle, SAP, Blue Yonder) | Freight Booking Agent, Tracking Agent | External API/EDI | Transportation management system integration for booking and tracking |
| Customs & Trade Platforms | Customs Agent, Clearance Agent | External API/EDI | Government customs systems, broker platforms, trade compliance databases |
| WMS Platforms | Warehouse Agent, Inventory Agent | Internal/External API | Warehouse management systems for operational coordination |
| GPS/Telematics Services | Tracking Agent, Delivery Agent | External API | Real-time location data from vehicles and delivery assets |
| Carrier APIs | Freight Booking Agent, Tracking Agent | External API | Carrier booking, rate, and tracking system integration |
| Inventory Management Systems | Inventory Agent | Internal API | Stock level management, reorder processing, inventory reconciliation |

---

## Revision History

| Date | Version | Author | Change Description |
|------|---------|--------|-------------------|
| 2026-03-31 | 1.0 | Logistics Agent Team | Initial creation of agent-skill mapping document |
