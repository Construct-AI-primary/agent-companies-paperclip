---
title: Project Typologies Index
description: Master index of construction project types for AI agent reference across all disciplines
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_paperclip/knowledge-disciplines
gigabrain_tags: resources, project-typologies, construction-sectors, cross-discipline, agent-reference
openstinger_context: project-type-classification, sector-knowledge
last_updated: 2026-04-02
related_docs:
  - docs_paperclip/knowledge-disciplines/README.MD
  - docs_paperclip/knowledge-disciplines/01900_procurement/README.md
---

# Project Typologies Index

## Purpose

This directory contains reference documentation on the major types of construction and engineering projects. It is organized by **project type / industry sector** rather than by discipline, so that agents from any discipline can consult the relevant typology file to understand:

- The typical scope, scale, and lifecycle of projects in that sector
- The regulatory, permitting, and compliance regimes that apply
- The disciplines most prominently involved and their interfaces
- The risk profile, delivery methods, and commercial models typical of that sector
- The procurement-specific PO, SO, and WO requirements for that sector

## How Agents Use This Reference

1. **Identify the project type** from user input, project metadata, or document context
2. **Open the corresponding typology file** (e.g., `0010_OIL-AND-GAS.MD` for an upstream oil & gas project)
3. **Consult sector-specific information** before making discipline-specific recommendations
4. **Cross-reference** with discipline-specific knowledge (e.g., procurement domain knowledge) for detailed technical guidance

## Project Typology Files

| File | Sector / Project Type | Description |
|------|----------------------|-------------|
| [0010_OIL-AND-GAS.MD](./0010_OIL-AND-GAS.MD) | Oil & Gas | Upstream, midstream, downstream, LNG, pipelines |
| [0020_MINING.MD](./0020_MINING.MD) | Mining & Minerals | Open-pit, underground, processing, tailings, heap leach |
| [0030_RESIDENTIAL.MD](./0030_RESIDENTIAL.MD) | Residential Buildings | Single-family, multi-unit, high-rise, estates |
| [0040_COMMERCIAL.MD](./0040_COMMERCIAL.MD) | Commercial Buildings | Office, retail, mixed-use, hospitality |
| [0045_MIXED-USE.MD](./0045_MIXED-USE.MD) | Mixed-Use Development | Mixed-use buildings, precincts, waterfront developments |
| [0050_INFRASTRUCTURE.MD](./0050_INFRASTRUCTURE.MD) | Infrastructure | Roads, bridges, rail, ports, airports, tunnels |
| [0055_INDUSTRIAL.MD](./0055_INDUSTRIAL.MD) | Industrial Facilities | Manufacturing, warehousing, data centers, food processing |
| [0060_INSTITUTIONAL.MD](./0060_INSTITUTIONAL.MD) | Institutional | Hospitals, schools, universities, government facilities |
| [0070_ENERGY-POWER.MD](./0070_ENERGY-POWER.MD) | Energy & Power | Solar, wind, thermal, hydro, transmission, substations |

## Discipline-Specific Extensions

Where a discipline has significant project-type-specific knowledge, discipline-specific typology files are maintained within the discipline's domain-knowledge area:

| Discipline | Location |
|------------|----------|
| Procurement | `docs_paperclip/knowledge-disciplines/01900_procurement/` |

## Naming Convention

- Files are numbered with 4-digit codes for consistent ordering
- File names use ALL-CAPS with hyphens for word separation
- Each file follows a standard template (see below)

## Standard File Template

Each typology file should contain the following sections:

```markdown
# [Project Type Name] Procurement Typology

## Sector Overview
## Common PO Types (Purchase Orders for Goods)
## Common SO Tracking Requirements (Supplier Order Confirmations)
## Common WO Types (Work Orders for Services)
## Key Goods vs Services Distinctions
## Project-Specific Procurement Considerations
```

---

*Project Typologies Index — Version 1.0*
*Cross-Discipline Reference for AI Agent Knowledge Base*
*Last Updated: 2026-04-02*
