---
title: "Cross-Discipline Engineering Platform — UI/UX Specification"
description: "Complete UI/UX specification for the shared engineering platform covering 10 engineering disciplines, shared components, three-state navigation, and AI model backend"
author: "PaperclipForge AI — UI/UX Design Coordination"
date: "2026-04-28"
version: "1.0"
status: "active"
gigabrain_tags: engineering, ui-ux, specification, cross-discipline, platform-architecture, shared-components
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
  - docs-paperclip/disciplines-shared/engineering/knowledge/platform-architecture/shared-components.md
platform_links:
  desktop: "desktop.md"
  mobile: "mobile.md"
  web: "web.md"
---

# Cross-Discipline Engineering Platform — UI/UX Specification

## Platform Overview

This specification covers the UI/UX design for the Cross-Discipline Engineering Platform, supporting 10 engineering disciplines with a shared three-state navigation (Agents, Upsert, Workspace), AI model backend, and HITL review workflows.

## Platform-Specific Documents

| Platform | Document | Description |
|----------|----------|-------------|
| **Desktop** | [desktop.md](desktop.md) | Full UI/UX specification for desktop (1280px+) — wireframes, CSS architecture, component inventory, modal specs, dropdown specs, chatbot config, AI model backend, and agent knowledge ownership |
| **Mobile** | [mobile.md](mobile.md) | Mobile-specific adaptations and notes — handled by MobileForge AI separately |
| **Web** | [web.md](web.md) | Web-specific adaptations and notes — handled via construct_ai web platform |

## Quick Reference

- **Template Type**: Template B (Complex / Three-State)
- **Color Scheme**: Template A orange palette (#FF8C00, #FFA500, #FF6B35)
- **Navigation**: Three-state — Agents, Upsert, Workspace
- **Modal Sizing**: 98vw with gradient headers
- **Chatbot z-index**: 1500
- **AI Model**: Qwen 2.5 with discipline-specific LoRA adapters
- **HITL Model**: AI Agent → Review Queue → Human Review → Approve/Reject/Edit → Done

## Disciplines Covered

| Code | Discipline | Accent Color |
|------|-----------|-------------|
| 00825 | Architectural Engineering | #FF8C00 |
| 00835 | Chemical Engineering | #00BFFF |
| 00850 | Civil Engineering | #32CD32 |
| 00855 | Geotechnical Engineering | #8B4513 |
| 00860 | Electrical Engineering | #FFD700 |
| 00870 | Mechanical Engineering | #FF6B35 |
| 00871 | Process Engineering | #00CED1 |
| 00872 | Structural Engineering | #4682B4 |
| 01000 | Environmental Engineering | #228B22 |
| 03000 | Landscaping Engineering | #6B8E23 |

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-28 | Initial UI/UX specification for Cross-Discipline Engineering Platform |

---

**Document Information**
- **Author**: PaperclipForge AI — UI/UX Design Coordination
- **Date**: 2026-04-28
- **Status**: Active
- **Next Review**: 2026-05-28
