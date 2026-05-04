---
id: LAND-PLANT-WEB-002
title: "Planting Operations Web — Plant Schedule Management, Nursery Supplier Config & Quality Standards"
labels: ["landscaping", "planting", "web", "3 — Discipline Integration"]
phase: "3 — Discipline Integration"
status: todo
priority: High
story_points: 5
due_date: "2026-08-15"
assignee: devforge-ai
company: devforge-ai
blocked_by:
  - LAND-PLANT-WEB-001
platform: web
---

# LAND-PLANT-WEB-002: Planting Operations Web — Plant Schedule Management, Nursery Supplier Config & Quality Standards

## Description

Build the web-based administration interface for managing plant schedules, nursery supplier configurations, and quality standards. This admin panel enables landscape administrators to create and maintain plant schedules, manage nursery supplier catalogues, and configure quality inspection criteria and establishment assessment schedules.

## Objectives

1. Create plant schedule management interface with creation, editing, and versioning
2. Implement nursery supplier configuration with catalogue management
3. Build quality standards configuration for inspection checklists and scoring
4. Provide bulk import/export capabilities for schedule and catalogue data
5. Enable supplier performance tracking and reporting

## Requirements

### Plant Schedule Management

- [ ] Schedule creation and editing interface with line item management
- [ ] Species catalogue management (add, edit, archive plant species)
- [ ] Schedule version comparison (diff view between versions)
- [ ] Schedule approval workflow with status tracking
- [ ] Bulk import from CSV/Excel with validation and error reporting
- [ ] Bulk export to CSV, Excel, and PDF formats
- [ ] Schedule template library for common project types
- [ ] Copy schedule from existing project

### Nursery Supplier Configuration

- [ ] Supplier profile management (business details, contacts, certifications)
- [ ] Catalogue upload and maintenance (species, sizes, pricing, stock levels)
- [ ] Pricing and lead time configuration per supplier
- [ ] Supplier performance tracking (on-time delivery, quality rating, defect rate)
- [ ] Contract and pricing agreement management with date ranges
- [ ] Supplier accreditation and certification tracking
- [ ] Supplier communication log

### Quality Standards Configuration

- [ ] Inspection checklist template creation and editing
- [ ] Scoring criteria and threshold configuration
- [ ] Pass/fail criteria definition per checklist item
- [ ] Non-conformance category and severity configuration
- [ ] Establishment assessment schedule templates
- [ ] Health scoring dimensions and weight configuration
- [ ] Checklist assignment rules (by species, zone, project type)

## Acceptance Criteria

- [ ] Plant schedule management interface functional with CRUD operations
- [ ] Schedule version comparison working with diff view
- [ ] Bulk import/export operational with validation
- [ ] Nursery supplier configuration with catalogue management working
- [ ] Supplier performance tracking displaying metrics
- [ ] Quality standards configuration with checklist templates functional
- [ ] Scoring criteria and thresholds configurable
- [ ] Integration tests passing with backend APIs

## Dependencies

- BLOCKED BY: LAND-PLANT-WEB-001 (Web dashboard)
- Requires: Admin authentication and authorisation framework
- Requires: File upload and parsing for bulk import
- Requires: API endpoints from LAND-PLANT-001 and LAND-PLANT-003

## Notes

- Design for power users who manage large plant catalogues
- Bulk import should provide clear error messages for data validation failures
- Consider role-based access for admin functions (schedule editor vs quality configurator)
- Supplier catalogue should support image uploads for plant identification
