---
title: "01900 Procurement UI/UX Specification — Master Index"
description: "Master index for the 01900 Procurement discipline UI/UX specification, covering desktop, mobile, and web platform breakdowns"
author: "DomainForge AI — Procurement Domain"
date: "2026-05-03"
version: "2.0"
status: "active"
tags: procurement, ui-ux, specification, index, supplier-management, tender, three-state
related_docs:
  - docs-construct-ai/other/0000_TEMPLATE_A_CSS_INVENTORY.md
  - docs-construct-ai/standards/0000_VISUAL_DESIGN_STANDARDS.md
  - docs-construct-ai/standards/0000_PAGE_ARCHITECTURE_GUIDE.md
  - docs-construct-ai/codebase/guides/styling/0000_CSS_STANDARDIZATION_GUIDE.md
  - docs-construct-ai/codebase/audits/0950_ACCORDION_MANAGEMENT_AUDIT.md
  - docs-construct-ai/codebase/guides/developer/0170_MODAL_DOCUMENTATION_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/0750_DROPDOWN_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/1300_PAGES_CHATBOT_MASTER_GUIDE.md
  - docs-construct-ai/codebase/guides/developer/1500_MERMAID_MASTER_GUIDE.md
  - docs-construct-ai/codebase/procedures/ai-ml/0000_HF_MODEL_INTEGRATION_PROCEDURE.md
  - docs-construct-ai/codebase/procedures/ai-ml/0000_LORA_ADAPTER_INTEGRATION_PROCEDURE.md
  - docs-construct-ai/codebase/procedures/ai-ml/0000_QWEN_FINETUNING_PROCEDURE.md
  - docs-paperclip/disciplines-shared/testing/projects/PROCURE-TEST/desktop/issues/PROCURE-001-phase1-foundation.md
  - docs-paperclip/disciplines-shared/testing/projects/PROCURE-TEST/knowledge/AGENT-DELEGATION-MAP.md
  - docs-paperclip/companies/shared/i18n-translation-management/
platforms:
  desktop: "ui-ux/desktop.md"
  mobile: "ui-ux/mobile.md"
  web: "ui-ux/web.md"
---

# 01900 Procurement UI/UX Specification — Master Index

## Platform Breakdown

This specification is split into three platform-specific documents:

| Platform | Document | Description |
|----------|----------|-------------|
| **Desktop** | [`ui-ux/desktop.md`](desktop.md) | Full desktop UI/UX specification — three-state navigation, procurement workflows, supplier management, AI model backend |
| **Mobile** | [`ui-ux/mobile.md`](mobile.md) | Mobile-specific adaptations — handled separately by MobileForge AI |
| **Web** | [`ui-ux/web.md`](web.md) | Web platform notes — handled via construct_ai web platform |

## Quick Reference

- **Template Type**: Template B (Complex / Three-State) — serves as Template A CSS Foundation Reference
- **Route**: `/procurement`
- **Accordion Section**: Procurement (display_order: 1900)
- **Color Palette**: Template A Orange (`--template-a-primary: #FF8C00`)
- **Background**: Uses a background image (standard for most Template A pages)
- **Chatbot z-index**: 1500
- **CSS Class Convention**: `A-01900-*`

## Language Support

This application supports **9 languages** via the i18n translation management system:

| # | Language | Locale Code |
|---|----------|-------------|
| 1 | English | `en` |
| 2 | Afrikaans | `af` |
| 3 | Zulu (isiZulu) | `zu` |
| 4 | Xhosa (isiXhosa) | `xh` |
| 5 | Swahili (Kiswahili) | `sw` |
| 6 | French | `fr` |
| 7 | Portuguese | `pt` |
| 8 | Mandarin Chinese (中文) | `zh-CN` |
| 9 | Arabic (العربية) | `ar` |

All UI text, labels, buttons, and notifications must use i18n translation keys rather than hardcoded strings. Language files are managed in the shared i18n framework:

- [`docs-paperclip/companies/shared/i18n-translation-management/`](../../../companies/shared/i18n-translation-management/) — Shared i18n framework and language file locations
- [`docs-paperclip/companies/devforge-ai/shared/i18n-translation-management/`](../../../companies/devforge-ai/shared/i18n-translation-management/) — DevForge AI i18n implementation
- [`docs-paperclip/companies/promptforge-ai/shared/i18n-translation-management/`](../../../companies/promptforge-ai/shared/i18n-translation-management/) — PromptForge AI i18n routing

Refer to the i18n management documentation for key naming conventions and language file locations.

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.0 | 2026-05-03 | Split into platform-specific files (desktop, mobile, web). Added language support reference. |
| 1.3 | 2026-04-29 | Clarified button ownership |
| 1.0 | 2026-04-28 | Initial UI/UX specification |