---
title: Project Typology Knowledge Index — Procurement
description: Master index of project-type-specific procurement knowledge files organized by sector/typology for procurement discipline
version: 1.0
memory_layer: durable_knowledge
para_section: docs_paperclip/knowledge-typologies/01900-procurement
gigabrain_tags: disciplines, 01900-procurement, project-typologies, procurement-order-types, goods-services
openstinger_context: knowledge-typologies, project-specific-procurement
last_updated: 2026-04-30
related_docs:
  - docs_paperclip/knowledge-typologies/01900-procurement/PROJECT-TYPOLOGIES-INDEX.MD
  - docs_paperclip/knowledge-typologies/01900-procurement/0010_OIL-AND-GAS.MD
  - docs_paperclip/knowledge-typologies/01900-procurement/0030_RESIDENTIAL.MD
  - docs_paperclip/knowledge-typologies/01900-procurement/0055_INDUSTRIAL.MD
  - docs_paperclip/knowledge-disciplines/README.MD
---

# Project Typology Knowledge Index — Procurement (01900)

## Purpose

This directory contains **project-type-specific procurement knowledge** organized by sector/typology. These files provide detailed PO (Purchase Order), SO (Supplier Order), and WO (Work Order) reference documentation for procurement professionals and AI agents, organized by the type of project being supplied.

## Relationship to knowledge-disciplines

- **`knowledge-disciplines/`** = Discipline-specific procurement knowledge (e.g., contracts, safety, logistics, engineering) — organized by discipline code
- **`knowledge-typologies/01900-procurement/`** = Project-type-specific procurement knowledge (e.g., Oil & Gas, Residential, Industrial) — organized by project typology

For the procurement discipline (01900), project typology files live here because procurement requirements vary significantly by project type. For other disciplines, typology files may be embedded directly within their discipline directory.

## Project Typology Files

| # | File | Sector / Project Type | Description |
|---|------|----------------------|-------------|
| 0010 | [0010_OIL-AND-GAS.MD](./0010_OIL-AND-GAS.MD) | Oil & Gas | Upstream, midstream, downstream, LNG, pipelines |
| 0020 | [0020_MINING.MD](./0020_MINING.MD) | Mining & Minerals | Open-pit, underground, processing, tailings, heap leach |
| 0030 | [0030_RESIDENTIAL.MD](./0030_RESIDENTIAL.MD) | Residential Buildings | Single-family, multi-unit, high-rise, estates |
| 0040 | [0040_COMMERCIAL.MD](./0040_COMMERCIAL.MD) | Commercial Buildings | Office, retail, hospitality |
| 0045 | [0045_MIXED-USE.MD](./0045_MIXED-USE.MD) | Mixed-Use Development | Mixed-use buildings, precincts, waterfront developments |
| 0050 | [0050_INFRASTRUCTURE.MD](./0050_INFRASTRUCTURE.MD) | Infrastructure | Roads, bridges, rail, ports, airports, tunnels |
| 0055 | [0055_INDUSTRIAL.MD](./0055_INDUSTRIAL.MD) | Industrial Facilities | Manufacturing, warehousing, data centers, food processing |
| 0060 | [0060_INSTITUTIONAL.MD](./0060_INSTITUTIONAL.MD) | Institutional | Hospitals, schools, universities, government facilities |
| 0070 | [0070_ENERGY-POWER.MD](./0070_ENERGY-POWER.MD) | Energy & Power | Solar, wind, thermal, hydro, transmission, substations |

## Supporting Files

| File | Description |
|------|-------------|
| [PROJECT-TYPOLOGIES-INDEX.MD](./PROJECT-TYPOLOGIES-INDEX.MD) | Comprehensive index of all project typologies with cross-references |
| [README.MD](./README.MD) | This file |

## How Agents Use This Reference

1. **Identify the project type** from user input, project metadata, or document context
2. **Open the corresponding typology file** (e.g., `0030_RESIDENTIAL.MD` for residential projects)
3. **Consult sector-specific procurement information** including PO categories, SO tracking requirements, and WO service types
4. **Cross-reference** with discipline-specific knowledge in `../knowledge-disciplines/` for specific procurement categories (contracts, safety, logistics, etc.)
5. **Cross-reference** with shared disciplines in `../knowledge-disciplines-shared/` for cross-cutting needs

## Naming Convention

- Files use 4-digit numeric prefixes for consistent ordering (0010, 0020, 0030, etc.)
- File names use ALL-CAPS with hyphens for word separation
- The PROJECT-TYPOLOGIES-INDEX.MD provides a comprehensive cross-reference

## Standard File Template

Each typology file contains the following sections:

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

*Project Typology Knowledge Index — Version 1.0*
*Procurement Discipline (01900) Reference for AI Agent Knowledge Base*
*Last Updated: 2026-04-30*