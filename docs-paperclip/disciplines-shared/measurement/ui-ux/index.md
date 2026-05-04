---
title: "Cross-Discipline Measurement Platform — UI/UX Specification Index"
description: "Master index for the UI/UX specification of the shared measurement platform covering CAD measurement extraction, BOQ generation, standards compliance, tender portal, mobile measurement, and AI model backend"
author: "MeasureForge AI — UI/UX Design Coordination"
date: "2026-04-28"
version: "1.0"
status: "active"
gigabrain_tags: measurement, ui-ux, specification, cross-discipline, cad-extraction, boq, quantity-surveying, standards-compliance, tender
related_docs:
  - docs-construct-ai/standards/0000_VISUAL_DESIGN_STANDARDS.md
  - docs-construct-ai/standards/0000_PAGE_ARCHITECTURE_GUIDE.md
  - docs-construct-ai/standards/0000_ALL_PAGES_ONLY.md
  - docs-construct-ai/codebase/guides/styling/0000_CSS_STANDARDIZATION_GUIDE.md
  - docs-construct-ai/codebase/audits/0950_ACCORDION_MANAGEMENT_AUDIT.md
  - docs-construct-ai/codebase/guides/developer/0170_MODAL_DOCUMENTATION_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/0750_DROPDOWN_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/1300_PAGES_CHATBOT_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/1500_MERMAID_MASTER_GUIDE.md
  - docs-construct-ai/codebase/procedures/ai-ml/0000_HF_MODEL_INTEGRATION_PROCEDURE.md
  - docs-construct-ai/codebase/procedures/ai-ml/0000_LORA_ADAPTER_INTEGRATION_PROCEDURE.md
  - docs-construct-ai/codebase/procedures/ai-ml/0000_QWEN_FINETUNING_PROCEDURE.md
  - docs-paperclip/disciplines-shared/measurement/projects/MEASURE-AI/project.md
  - docs-paperclip/disciplines-shared/measurement/projects/MEASURE-TENDER/plan.md
platform_links:
  desktop: "desktop.md"
  mobile: "mobile.md"
  web: "web.md"
---

# Cross-Discipline Measurement Platform — UI/UX Specification

## Platform Overview

This specification defines the UI/UX for the Cross-Discipline Measurement Platform, covering CAD measurement extraction, BOQ generation, standards compliance, tender portal management, mobile on-site measurement, and AI model backend integration.

The specification is split by platform target:

| Platform | Document | Description |
|----------|----------|-------------|
| 🖥️ Desktop | [desktop.md](desktop.md) | Full specification for desktop (1280px+) — three-state navigation, CAD takeoff, BOQ composer, tender portal, all mermaid diagrams, component inventory, implementation standards |
| 📱 Mobile | [mobile.md](mobile.md) | Mobile-specific specification — on-site measurement capture, PWA offline sync, AR-assisted measurement, site inventory, mobile UI patterns |
| 🌐 Web | [web.md](web.md) | Web platform notes — construct_ai web platform integration, responsive adaptations, browser-based measurement tools |

## Table of Contents

1. [Part A: UX Patterns (High-Level)](desktop.md#part-a-ux-patterns-high-level)
2. [Part B: Three-State Button & Modal Rules](desktop.md#part-b-three-state-button--modal-rules)
3. [Part C: Mermaid UI Flow Diagrams](desktop.md#part-c-mermaid-ui-flow-diagrams)
4. [Part D: Implementation Standards](desktop.md#part-d-implementation-standards)
5. [Part E: Screen Specifications (Detailed)](desktop.md#part-e-screen-specifications-detailed)
6. [Part F: Shared Measurement Components](desktop.md#part-f-shared-measurement-components)
7. [Part G: Mobile Measurement (On-Site)](mobile.md#part-g-mobile-measurement-on-site)
8. [Part H: AI Model Backend](desktop.md#part-h-ai-model-backend)
9. [Part I: Agent Knowledge Ownership](desktop.md#part-i-agent-knowledge-ownership)
10. [Part J: Future Extension Architecture](desktop.md#part-j-future-extension-architecture)

## Version History

| Version | Date       | Changes                                                               |
| ------- | ---------- | --------------------------------------------------------------------- |
| 1.0     | 2026-04-28 | Initial UI/UX specification for Cross-Discipline Measurement Platform |

---

**Document Information**

- **Author**: MeasureForge AI — UI/UX Design Coordination
- **Date**: 2026-04-28
- **Status**: Active
- **Next Review**: 2026-05-28
- **Related Standards**: All documents referenced in frontmatter
