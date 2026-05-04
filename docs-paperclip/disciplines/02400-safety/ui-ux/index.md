---
title: "02400 Safety — UI/UX Specification Index"
description: "Master index for the 02400 Safety discipline UI/UX specifications across desktop, mobile, and web platforms"
author: "QualityForge AI — Safety Domain"
date: "2026-04-28"
version: "1.0"
status: "active"
gigabrain_tags: safety, ui-ux, specification, index, desktop, mobile, web
related_docs:
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
  - docs-paperclip/disciplines/02400-safety/projects/SAFETY-CONTRACTOR/desktop/issues/SAFETY-CONTRACTOR-001-core-workflow-dashboard.md
---

# 02400 Safety — UI/UX Specification Index

This index provides links to the platform-specific UI/UX specifications for the 02400 Safety discipline (Contractor Safety Management).

## Platform Specifications

| Platform | File | Description |
|----------|------|-------------|
| 🖥️ Desktop | [desktop.md](./desktop.md) | Full UI/UX specification for desktop (1280px+). Covers UX patterns, three-state button & modal rules, Mermaid flow diagrams, implementation standards, detailed screen specifications, AI model backend, and agent knowledge ownership. |
| 📱 Mobile | [mobile.md](./mobile.md) | Mobile-specific UI/UX adaptations (< 768px). Handled separately by MobileForge AI. |
| 🌐 Web | [web.md](./web.md) | Web-specific UI/UX considerations. Handled via the construct_ai web platform. |

## Quick Reference

- **Template Type**: Template B (Complex / Three-State)
- **Primary Routes**: `/safety/safetycontractor`
- **Accordion Section**: Safety (display_order: 2400)
- **Accordion Subsection**: Contractor Safety Management
- **Color Palette**: Red safety theme (`#D32F2F`, `#FF5252`, `#FFC107`, `#4CAF50`)
- **Chatbot z-index**: 1500
- **Modal Width**: 98vw with red gradient headers

## Related Documentation

- [Visual Design Standards](../../../docs-construct-ai/standards/0000_VISUAL_DESIGN_STANDARDS.md)
- [Page Architecture Guide](../../../docs-construct-ai/standards/0000_PAGE_ARCHITECTURE_GUIDE.md)
- [CSS Standardization Guide](../../../docs-construct-ai/codebase/guides/styling/0000_CSS_STANDARDIZATION_GUIDE.md)
- [Accordion Management Audit](../../../docs-construct-ai/codebase/audits/0950_ACCORDION_MANAGEMENT_AUDIT.md)
- [Modal Documentation Master Guide](../../../docs-construct-ai/codebase/guides/developer/0170_MODAL_DOCUMENTATION_MASTER_GUIDE.md)
- [Dropdown Master Guide](../../../docs-construct-ai/codebase/guides/developer/0750_DROPDOWN_MASTER_GUIDE.md)
- [Pages Chatbot Master Guide](../../../docs-construct-ai/codebase/guides/developer/1300_PAGES_CHATBOT_MASTER_GUIDE.md)
- [Mermaid Master Guide](../../../docs-construct-ai/codebase/guides/developer/1500_MERMAID_MASTER_GUIDE.md)
- [HF Model Integration Procedure](../../../docs-construct-ai/codebase/procedures/ai-ml/0000_HF_MODEL_INTEGRATION_PROCEDURE.md)
- [LoRA Adapter Integration Procedure](../../../docs-construct-ai/codebase/procedures/ai-ml/0000_LORA_ADAPTER_INTEGRATION_PROCEDURE.md)
- [Qwen Finetuning Procedure](../../../docs-construct-ai/codebase/procedures/ai-ml/0000_QWEN_FINETUNING_PROCEDURE.md)
- [SAFETY-CONTRACTOR-001: Core Workflow Dashboard](../projects/SAFETY-CONTRACTOR/desktop/issues/SAFETY-CONTRACTOR-001-core-workflow-dashboard.md)

---

**Document Information**
- **Author**: QualityForge AI — Safety Domain
- **Date**: 2026-04-28
- **Status**: Active
- **Next Review**: 2026-05-28
