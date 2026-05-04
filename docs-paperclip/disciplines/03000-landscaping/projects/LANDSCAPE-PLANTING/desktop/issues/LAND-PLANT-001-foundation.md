---
id: LAND-PLANT-001
title: "Planting Operations Foundation — Plant Schedule, Nursery Database & Data Model"
labels: ["landscaping", "planting", "1 — Foundation"]
phase: "1 — Foundation"
status: todo
priority: Critical
story_points: 8
due_date: "2026-06-15"
assignee: domainforge-ai
company: domainforge-ai
blocks:
  - LAND-PLANT-002
  - LAND-PLANT-003
  - LAND-PLANT-004
  - LAND-PLANT-005
estimated_weeks: 4
---

# LAND-PLANT-001: Planting Operations Foundation — Plant Schedule, Nursery Database & Data Model

## Description

Establish the core data model for planting operations within the Landscaping discipline (03000). This foundation issue covers the plant schedule data model, nursery database schema, and all foundational data entities required to support planting workflows, quality inspection, establishment tracking, nursery ordering, and compliance auditing.

## Objectives

1. Define and implement the plant schedule data model with species catalogue, sizes, quantities, and specifications
2. Design and implement the nursery database schema with supplier catalogues and stock tracking
3. Create all core data entities (Plant, PlantSchedule, Nursery, Supplier, Order, PlantingZone, EstablishmentPeriod)
4. Build RESTful API foundation for plant schedule and nursery catalogue CRUD operations
5. Document the data model and API specifications

## Requirements

### Plant Schedule Data Model

- [ ] Plant species catalogue with botanical names, common names, and unique identifiers
- [ ] Plant size/grades: container size, height, spread, caliper, root ball dimensions
- [ ] Quantity tracking with unit of measure (each, litre, metre, square metre)
- [ ] Schedule versioning and revision history with change tracking
- [ ] Specification attributes: root type (container, bare-root, root-ball), form (standard, multi-stem, espalier), pruning requirements
- [ ] Planting density and spacing specifications
- [ ] Seasonality and availability windows
- [ ] Plant substitution rules and approved substitute species

### Nursery Database Schema

- [ ] Nursery supplier registry with business details, contact information, and certifications
- [ ] Supplier catalogue with available species, sizes, pricing, and stock levels
- [ ] Stock availability tracking with real-time updates
- [ ] Nursery quality grades and accreditation levels (Nursery Industry Accreditation Scheme)
- [ ] Delivery zone configuration and lead time settings
- [ ] Supplier performance metrics (on-time delivery, quality rating, defect rate)
- [ ] Contract and pricing agreement management

### Core Data Entities

| Entity | Description | Key Attributes |
|--------|-------------|----------------|
| `Plant` | Plant species and cultivar definition | species, cultivar, botanical_name, common_name, size, form, root_type |
| `PlantSchedule` | Project-linked planting schedule | project_id, version, status, line_items, total_quantity |
| `PlantScheduleLineItem` | Individual line item in a schedule | plant_id, quantity, spacing, zone, specification |
| `Nursery` | Nursery supplier entity | name, contact, address, certifications, accreditation |
| `NurseryCatalogue` | Supplier's available plant catalogue | nursery_id, plant_id, price, stock_level, lead_time |
| `Supplier` | Vendor details and contracts | legal_name, abn, contracts, insurance, performance |
| `Order` | Purchase order for plant stock | supplier_id, line_items, status, delivery_date, total |
| `OrderLineItem` | Individual order line | order_id, plant_id, quantity, unit_price, received_qty |
| `PlantingZone` | Site area designation for planting | project_id, zone_code, area_sqm, soil_type, aspect |
| `EstablishmentPeriod` | Defect liability tracking entity | planting_id, start_date, end_date, status, health_scores |

### API Foundation

- [ ] RESTful API endpoints for plant schedule CRUD
- [ ] Nursery catalogue query endpoints with filtering and search
- [ ] Data validation and schema enforcement
- [ ] API documentation (OpenAPI/Swagger specification)
- [ ] Authentication and authorisation integration
- [ ] Rate limiting and pagination support

## Acceptance Criteria

- [ ] Plant schedule data model reviewed and approved by landscaping SME
- [ ] Nursery database schema validated with sample supplier data
- [ ] All core data entities implemented with proper relationships and constraints
- [ ] API endpoints operational and returning correct responses
- [ ] API documentation published and accessible
- [ ] Data model documentation published to discipline knowledge base
- [ ] Unit tests passing for all data model operations
- [ ] Integration tests passing for API endpoints

## Dependencies

- Landscaping discipline data standards (03000)
- Project entity framework from Paperclip platform
- Supplier master data management system

## Blocking

This issue blocks:
- LAND-PLANT-002: Planting Operations Core — Planting Workflow, Quality Inspection & Establishment Tracking
- LAND-PLANT-003: Planting Operations Integration — Nursery Ordering, Delivery Coordination & Irrigation Linking
- LAND-PLANT-004: Planting Operations Mobile — Field Planting Log, Quality Inspection & Offline Records
- LAND-PLANT-005: Planting Operations Compliance — Planting Records, Establishment Monitoring & Audit Trail

## Notes

- Coordinate with GreenScape AI for plant species taxonomy and naming conventions
- Align with existing LAND-WORKFLOW project for irrigation data integration points
- Consider future integration with biodiversity offset tracking requirements
- Data model should support multi-region and multi-climate configurations
