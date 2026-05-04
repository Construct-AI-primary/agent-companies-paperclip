---
id: LAND-PLANT-003
title: "Planting Operations Integration — Nursery Ordering, Delivery Coordination & Irrigation Linking"
labels: ["landscaping", "planting", "3 — Discipline Integration"]
phase: "3 — Discipline Integration"
status: todo
priority: High
story_points: 8
due_date: "2026-08-31"
assignee: devforge-ai
company: devforge-ai
blocked_by:
  - LAND-PLANT-002
estimated_weeks: 4
---

# LAND-PLANT-003: Planting Operations Integration — Nursery Ordering, Delivery Coordination & Irrigation Linking

## Description

Integrate nursery ordering workflows, delivery coordination, and irrigation linking into the planting operations platform. This issue covers purchase order generation from plant schedules, delivery scheduling and receipt, and the integration of plant water requirements with irrigation design data.

## Objectives

1. Implement nursery ordering workflow with PO generation, approval, and submission
2. Build delivery coordination with scheduling, receipt, and quality verification
3. Create irrigation linking for plant water requirement calculation and watering schedule generation
4. Develop return/rejection workflow for non-conforming plant stock
5. Integrate with nursery supplier systems for order and stock data exchange

## Requirements

### Nursery Ordering Workflow

- [ ] Purchase order generation from plant schedule line items
- [ ] Order approval workflow with configurable approval hierarchy
- [ ] Order submission to nursery (email, API, or manual export)
- [ ] Order confirmation and acknowledgement tracking
- [ ] Order amendment and cancellation handling with audit trail
- [ ] Partial order release (split orders by delivery schedule)
- [ ] Order status tracking: Draft → Submitted → Confirmed → In Transit → Delivered → Completed
- [ ] Integration with nursery supplier systems for automated ordering

### Delivery Coordination

- [ ] Delivery scheduling with date/time windows and delivery notes
- [ ] Delivery receipt with quantity verification and quality inspection
- [ ] Partial delivery handling with back-order tracking
- [ ] Delivery documentation management (dockets, photos, signatures)
- [ ] Return/rejection workflow for non-conforming stock:
  - Rejection reason categorisation (size, quality, species, damage)
  - Return authorisation and credit note tracking
  - Replacement order generation
- [ ] Delivery performance tracking (on-time, complete, damage-free)

### Irrigation Linking

- [ ] Plant water requirement calculation by species and size class
- [ ] Irrigation zone assignment from landscape design data
- [ ] Watering schedule generation based on:
  - Establishment phase (initial, active, mature)
  - Seasonal adjustments (summer, winter, rainfall)
  - Soil type and drainage characteristics
- [ ] Integration with irrigation design data from LAND-WORKFLOW project
- [ ] Soil moisture monitoring data ingestion (manual or sensor-based)
- [ ] Irrigation event logging and water usage tracking

## Acceptance Criteria

- [ ] Nursery ordering workflow operational with PO generation and tracking
- [ ] Order approval workflow functional with configurable hierarchy
- [ ] Delivery coordination with receipt and quality verification working
- [ ] Return/rejection workflow for non-conforming stock operational
- [ ] Irrigation linking with water requirement calculations functional
- [ ] Watering schedule generation based on establishment phase
- [ ] Integration with LAND-WORKFLOW irrigation data verified
- [ ] End-to-end integration tests passing

## Dependencies

- BLOCKED BY: LAND-PLANT-002 (Core workflow engine)
- Requires: Irrigation design data from LAND-WORKFLOW project
- Requires: Nursery supplier API specifications
- Requires: Supplier master data from procurement system

## Notes

- Coordinate with LAND-WORKFLOW project for irrigation zone and design data
- Nursery supplier APIs may vary; implement standardised integration layer
- Consider barcode/QR code scanning for delivery receipt on mobile
- Water requirement calculations should follow industry standards (e.g., ET₀-based)
