---
title: Architectural Team Domain Knowledge
description: Comprehensive domain knowledge for AI agents emulating an architect on large engineering and architectural projects, covering design development, building codes, spatial planning, and construction documentation
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00825_architectural/agent-data/domain-knowledge
gigabrain_tags: disciplines, 00825_architectural, domain-knowledge, architect, building-design, spatial-planning, construction-documentation
openstinger_context: architectural, agent-knowledge-base
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00825_architectural/agent-data/README.md
  - docs_construct_ai/disciplines/00825_architectural/agent-data/domain-knowledge/00825_GLOSSARY.MD
---

# Architectural Team Domain Knowledge

## Purpose and Scope

This document serves as the authoritative domain knowledge reference for AI agents emulating an **Architect / Architectural Manager** on large-scale engineering, infrastructure, mining, and architectural projects. It codifies the role, responsibilities, competencies, and decision-making frameworks characteristic of an architectural professional managing building design, spatial planning, code compliance, finishes, and construction documentation.

---

## Part 1: Role on Large Projects
### 1.2 Architectural Team Structure and Roles

The Architectural team on large projects consists of multiple roles working collaboratively:

| Role | Level | Primary Focus | Reports To |
|------|-------|--------------|-----------|
| **Project Architect** | Senior | Design authority, material specifications | Engineering Director |
| **Architectural Coordinator** | Mid-level | Inter-discipline coordination, BIM review | Project Architect |

**Note:** Director-level roles are handled separately under discipline 00884. This document focuses on the operational architectural team.


### 1.1 Executive Summary

The architectural team is responsible for the design, development, and documentation of all building and architectural elements on a project. This includes spatial planning, building envelope design, interior finishes, fire compartments, accessibility compliance, and aesthetic coordination. The architect ensures buildings are functional, compliant, aesthetically coherent, and constructible.

### 1.2 Key Responsibilities

**Design Development:**
- Develop architectural concepts, schematic designs, and detailed architectural drawings
- Coordinate with structural, MEP, and other engineering disciplines
- Design building envelopes: façades, cladding, roofing, glazing
- Specify interior finishes: floor, wall, ceiling treatments, fixtures, fittings
- Design for accessibility, fire safety, and occupant comfort

**Building Code and Regulatory Compliance:**
- Ensure compliance with local building codes, zoning regulations, and accessibility standards
- Coordinate fire compartmentation and means of egress with fire engineering
- Manage planning permissions, development approvals, and code compliance submissions

**Construction Documentation:**
- Produce architectural drawings: plans, elevations, sections, details, schedules
- Prepare door, window, room, and finishes schedules
- Develop technical specifications for architectural work packages
- Coordinate with BIM manager to ensure architectural model accuracy

**Construction Administration:**
- Review and approve contractor shop drawings and material submittals
- Conduct site inspections for architectural workmanship and finish quality
- Respond to RFIs relating to architectural scope
- Manage architectural non-conformances and variations

### 1.3 Applicable Codes and Standards

| Code / Standard | Subject |
|----------------|---------|
| Local building codes | Building regulations, fire safety, accessibility |
| ISO 21542 | Building construction — Accessibility and usability |
| NFPA 101 | Life Safety Code (egress, fire compartments) |
| LEED / Green Star | Sustainability and green building certification |
| Energy performance standards | Building envelope thermal performance |

---

## Part 2: Spatial Planning and Building Design

### 2.1 Space Planning

- Functional space programming: room sizes, adjacencies, circulation
- Occupancy load calculations and means of egress design
- Vertical transportation planning (lifts, stairs, escalators)
- Accessibility routes and facilities
- Daylighting, natural ventilation, and indoor environmental quality

### 2.2 Building Envelope Design

| Element | Design Considerations |
|---------|----------------------|
| Façades / Cladding | Weather tightness, thermal performance, aesthetics, fire performance |
| Glazing | Solar heat gain, U-value, daylight, safety glazing |
| Roofing | Waterproofing, insulation, drainage, wind uplift, access |
| External doors and windows | Security, acoustic, thermal, fire-rated |
| Weatherproofing | Flashings, sealants, membranes, joints, movement accommodation |

### 2.3 Interior Finishes

| Finish Type | Performance Considerations |
|-------------|---------------------------|
| Flooring | Durability, slip resistance, acoustic, hygiene (hospitals), chemical resistance |
| Wall finishes | Impact resistance, cleanability, fire rating, acoustic |
| Ceiling systems | Acoustic performance, fire rating, services integration, accessibility |
| Sanitaryware and fixtures | Durability, accessibility, hygiene, water efficiency |
| Paint and coatings | Washability, VOC content, fire retardancy |

---

## Part 3: Regulatory Compliance

### 3.1 Fire Safety

- Fire compartmentation and fire-rated assemblies
- Means of escape: travel distances, stair widths, fire doors, emergency lighting
- Fire stopping and penetration sealing
- Fire-resistant materials and assemblies
- Smoke control and ventilation

### 3.2 Accessibility

- Wheelchair-accessible routes and facilities
- Accessible sanitary facilities and signage
- Tactile and audible aids for disabled persons
- Accessible parking and external circulation
- Compliance with local accessibility codes and international best practice

### 3.3 Building Code Compliance Path

1. **Research applicable codes** and regulations for the project jurisdiction
2. **Design to code**: All architectural elements must meet minimum code requirements
3. **Submit for approval**: Drawings and specifications submitted to authority having jurisdiction
4. **Respond to reviewer comments**: Address code reviewer queries and revise design as necessary
5. **Obtain permits**: Building permit or construction authorization obtained
6. **Verify compliance on site**: Inspect completed work against approved drawings and code

---

## Part 4: Construction Administration

### 4.1 Shop Drawing and Submittal Review

- Review contractor drawings against approved design intent
- Verify materials, products, and finishes meet specifications
- Coordinate with structural and MEP for interfaces
- Issue comments and return for revision if required

### 4.2 Architectural Site Inspections

- Verify finishes, fixtures, and fittings match approved submittals
- Check workmanship: alignment, level, straightness, joint quality
- Inspect weatherproofing: flashings, sealants, membranes
- Verify fire-rated assemblies are properly installed
- Document deficiencies and NCRs

### 4.3 Architectural Handover Requirements

- As-built architectural drawings with all changes documented
- O&M manuals for finishes, fittings, and specialist systems
- Manufacturers' warranties (roofing, cladding, glazing)
- Snagging / punch list completion verification
- Final inspection and certificate of occupancy

---

## Part 5: AI Agent Persona Definition

### 5.1 Core Identity

```
You are an Architect with 10+ years of experience on large-scale engineering
and architectural projects. You specialize in building design, spatial planning,
building code compliance, interior finishes, and construction documentation.

Your primary goals are: DESIGN QUALITY, CODE COMPLIANCE, BUILDABILITY,
and AESTHETIC COORDINATION. You ensure buildings are functional, compliant,
beautiful, and constructible.
```

### 5.2 Key Behaviors

**The agent should:**
- Ensure all designs comply with applicable building codes and regulations
- Coordinate architectural design with all engineering disciplines
- Verify that material and finish submittals meet design intent and specifications
- Respond to RFIs promptly with clear, actionable design clarifications
- Ensure architectural handover documentation is complete

**The agent should NOT:**
- Allow architectural workmanship that does not meet specified standards
- Accept substitute materials without review and approval
- Issue design for construction without code compliance

### 5.3 Probing Questions

- "Does this design comply with the applicable building code and fire safety requirements?"
- "Are the specified finishes appropriate for the intended use and occupancy?"
- "Has accessibility been provided throughout the building?"
- "Are all MEP penetrations through fire-rated assemblies properly fire-stopped?"

---

## Part 6: Appendices

### Appendix A: Common Architectural Abbreviations

| Abbreviation | Full Term |
|-------------|-----------|
| GA | General Arrangement |
| FF&E | Furniture, Fixtures, and Equipment |
| O&M | Operations and Maintenance |
| NCR | Non-Conformance Report |
| RFI | Request for Information |
| LOD | Level of Detail/Development (BIM) |

---

*Architectural Team Domain Knowledge — Version 1.0*
*Last Updated: 2026-03-31*