---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# AGENTS.md

Keep this file focused on durable operating rules.
Do not turn it into a memory dump.

<!-- MEMORY-STACK-GIVEAWAY:START -->
## Memory Stack Rules
- Keep `AGENTS.md` focused on durable operating rules, ownership, approvals, and stop behavior.
- Keep `MEMORY.md` as a tiny routing/index layer, not a warehouse.
- Put durable facts in PARA (`para/` - integrated within repository).
- Put daily execution residue in `memory/YYYY-MM-DD.md`.
- Use LCM for current-session recovery, not durable truth.
- Use OpenStinger for cross-session recall only when available and needed.
- If a rule must survive compaction, promote it into a durable file this session.

## Agent Documentation Access Patterns

### Codebase & Development Standards (Priority: High)
**Codebase Directory**: `codebase/` - Complete development lifecycle documentation
- **Architecture**: `codebase/architecture/system-overview.md` - System design principles
- **Coding Standards**: `codebase/coding-standards/README.md` - Language-specific standards
- **Development Guides**: `codebase/guides/` - API, debugging, and workflow guides
- **Procedures**: `codebase/procedures/` - Operational and deployment procedures
- **Security**: `codebase/security/` - Authentication and compliance standards (25+ files)
- **Performance**: `codebase/performance/` - Optimization and monitoring guidelines
- **Agents**: `codebase/agents/` - AI agent documentation and frameworks (436 files)
- **Analysis**: `codebase/analysis/` - System analysis and research documents (39 files)
- **Audits**: `codebase/audits/` - Compliance and quality audit documentation (36 files)
- **Testing**: `codebase/testing/` - Testing frameworks and procedures
- **Tools**: `codebase/tools/` - Development tools and utilities
- **Gigabrain Tags**: codebase, architecture, development-standards, coding-practices, agents, analysis, audits, archive, backup, docs, examples, errors, mobile, other-apps

### Target Disciplines (Complete Implementation)

#### **Core Business Disciplines**
1. **00250 Commercial** (Implemented)
   - PARA Index: `disciplines/00250-commercial/`
   - Gigabrain Tags: disciplines, 00250-commercial, commercial-practices

2. **00300 Construction** (Implemented)
   - PARA Index: `disciplines/00300_construction/`
   - Gigabrain Tags: disciplines, 00300_construction, construction-practices

3. **00400 Contracts** (Implemented)
   - PARA Index: `disciplines/00400_contracts/`
   - Gigabrain Tags: disciplines, 00400_contracts, contracts-practices

4. **00425 Contracts Pre-Award** (Implemented)
   - PARA Index: `disciplines/00425_contracts-pre-award/`
   - Gigabrain Tags: disciplines, 00425_contracts-pre-award, contracts-practices

5. **00430 Contracts Pre-Award** (Implemented)
   - PARA Index: `disciplines/00430_contracts-pre-award/`
   - Gigabrain Tags: disciplines, 00430_contracts-pre-award, contracts-practices

6. **00435 Contracts Post-Award** (Implemented)
   - PARA Index: `disciplines/00435_contracts-post-award/`
   - Gigabrain Tags: disciplines, 00435_contracts-post-award, contracts-practices

#### **Engineering Disciplines**
7. **00825 Architectural** (Implemented)
   - PARA Index: `disciplines/00825_architectural/`
   - Gigabrain Tags: disciplines, 00825_architectural, architectural-practices

8. **00835 Chemical Engineering** (Implemented)
   - PARA Index: `disciplines/00835_chemical-engineering/`
   - Gigabrain Tags: disciplines, 00835_chemical-engineering, chemical-engineering-practices

9. **00850 Civil Engineering** (Implemented)
   - PARA Index: `disciplines/00850_civil-engineering/`
   - Gigabrain Tags: disciplines, 00850_civil-engineering, civil-engineering-practices

10. **00850 Landscaping** (Implemented)
    - PARA Index: `disciplines/00850_landscaping/`
    - Gigabrain Tags: disciplines, 00850_landscaping, landscaping-practices

11. **00855 Geotechnical Engineering** (Implemented)
    - PARA Index: `disciplines/00855_geotechnical-engineering/`
    - Gigabrain Tags: disciplines, 00855_geotechnical-engineering, geotechnical-engineering-practices

12. **00860 Electrical Engineering** (Implemented)
    - PARA Index: `disciplines/00860_electrical-engineering/`
    - Gigabrain Tags: disciplines, 00860_electrical-engineering, electrical-engineering-practices

13. **00870 Mechanical Engineering** (Implemented)
    - PARA Index: `disciplines/00870_mechanical-engineering/`
    - Gigabrain Tags: disciplines, 00870_mechanical-engineering, mechanical-engineering-practices

14. **00871 Process Engineering** (Implemented)
    - PARA Index: `disciplines/00871_process-engineering/`
    - Gigabrain Tags: disciplines, 00871_process-engineering, process-engineering-practices

15. **00872 Structural** (Implemented)
    - PARA Index: `disciplines/00872_structural/`
    - Gigabrain Tags: disciplines, 00872_structural, structural-practices

#### **Executive & Governance**
16. **00877 Sales** (Implemented)
    - PARA Index: `disciplines/00877_sales/`
    - Gigabrain Tags: disciplines, 00877_sales, sales-practices

17. **00880 Board of Directors** (Implemented)
    - PARA Index: `disciplines/00880_board-of-directors/`
    - Gigabrain Tags: disciplines, 00880_board-of-directors, governance-practices

18. **00882 Construction Director** (Implemented)
    - PARA Index: `disciplines/00882_construction-director/`
    - Gigabrain Tags: disciplines, 00882_construction-director, director-practices

19. **00883 Contracts Director** (Implemented)
    - PARA Index: `disciplines/00883_contracts-director/`
    - Gigabrain Tags: disciplines, 00883_contracts-director, director-practices

20. **00884 Engineering Director** (Implemented)
    - PARA Index: `disciplines/00884_engineering-director/`
    - Gigabrain Tags: disciplines, 00884_engineering-director, director-practices

21. **00885 HSE Director** (Implemented)
    - PARA Index: `disciplines/00885_hse-director/`
    - Gigabrain Tags: disciplines, 00885_hse-director, director-practices

22. **00886 Logistics Director** (Implemented)
    - PARA Index: `disciplines/00886_logistics-director/`
    - Gigabrain Tags: disciplines, 00886_logistics-director, director-practices

23. **00888 Procurement Director** (Implemented)
    - PARA Index: `disciplines/00888_procurement-director/`
    - Gigabrain Tags: disciplines, 00888_procurement-director, director-practices

24. **00889 Finance Director** (Implemented)
    - PARA Index: `disciplines/00889_finance-director/`
    - Gigabrain Tags: disciplines, 00889_finance-director, director-practices

25. **00890 Projects Director** (Implemented)
    - PARA Index: `disciplines/00890_projects-director/`
    - Gigabrain Tags: disciplines, 00890_projects-director, director-practices

26. **00895 Project Director** (Implemented)
    - PARA Index: `disciplines/00895_project-director/`
    - Gigabrain Tags: disciplines, 00895_project-director, director-practices

#### **Support Disciplines**
27. **00900 Document Control** (Implemented)
    - PARA Index: `disciplines/00900-document-control/`
    - Gigabrain Tags: disciplines, 00900-document-control, document-control-practices

28. **01000 Environmental** (Implemented)
    - PARA Index: `disciplines/01000_environmental/`
    - Gigabrain Tags: disciplines, 01000_environmental, environmental-practices

29. **01100 Ethics** (Implemented)
    - PARA Index: `disciplines/01100_ethics/`
    - Gigabrain Tags: disciplines, 01100_ethics, ethics-practices

30. **01200 Finance** (Implemented)
    - PARA Index: `disciplines/01200_finance/`
    - Gigabrain Tags: disciplines, 01200_finance, finance-practices

31. **01200 Sales** (Implemented)
    - PARA Index: `disciplines/01200_sales/`
    - Gigabrain Tags: disciplines, 01200_sales, sales-practices

32. **01300 Developer** (Implemented)
    - PARA Index: `disciplines/01300_developer/`
    - Gigabrain Tags: disciplines, 01300_developer, developer-practices

33. **01300 Governance** (Implemented)
    - PARA Index: `disciplines/01300_governance/`
    - Gigabrain Tags: disciplines, 01300_governance, governance-practices

34. **01400 Health** (Implemented)
    - PARA Index: `disciplines/01400_health/`
    - Gigabrain Tags: disciplines, 01400_health, health-practices

35. **01500 Human Resources** (Implemented)
    - PARA Index: `disciplines/01500_human-resources/`
    - Gigabrain Tags: disciplines, 01500_human-resources, hr-practices

36. **01500 Information Technology** (Implemented)
    - PARA Index: `disciplines/01500_information-technology/`
    - Gigabrain Tags: disciplines, 01500_information-technology, it-practices

37. **01600 Local Content** (Implemented)
    - PARA Index: `disciplines/01600_local-content/`
    - Gigabrain Tags: disciplines, 01600_local-content, local-content-practices

38. **01700 Logistics** (Implemented)
    - PARA Index: `disciplines/01700_logistics/`
    - Gigabrain Tags: disciplines, 01700_logistics, logistics-practices

39. **01750 Legal** (Implemented)
    - PARA Index: `disciplines/01750_legal/`
    - Gigabrain Tags: disciplines, 01750_legal, legal-practices

40. **01800 Operations** (Implemented)
    - PARA Index: `disciplines/01800_operations/`
    - Gigabrain Tags: disciplines, 01800_operations, operations-practices

41. **01800 Public Relations** (Implemented)
    - PARA Index: `disciplines/01800_public-relations/`
    - Gigabrain Tags: disciplines, 01800_public-relations, pr-practices

42. **01850 Other Parties** (Implemented)
    - PARA Index: `disciplines/01850_other-parties/`
    - Gigabrain Tags: disciplines, 01850_other-parties, stakeholder-practices

43. **01900 Procurement** (Implemented)
    - PARA Index: `disciplines/01900_procurement/`
    - Gigabrain Tags: disciplines, 01900_procurement, procurement-practices

44. **02000 Document Control** (Implemented)
    - PARA Index: `disciplines/02000_document-control/`
    - Gigabrain Tags: disciplines, 02000_document-control, document-control-practices

45. **02000 Project Controls** (Implemented)
    - PARA Index: `disciplines/02000_project-controls/`
    - Gigabrain Tags: disciplines, 02000_project-controls, project-controls-practices

46. **02025 Quantity Surveying** (Implemented)
    - PARA Index: `disciplines/02025_quantity-surveying/`
    - Gigabrain Tags: disciplines, 02025_quantity-surveying, quantity-surveying-practices

47. **02035 Scheduling** (Implemented)
    - PARA Index: `disciplines/02035_scheduling/`
    - Gigabrain Tags: disciplines, 02035_scheduling, scheduling-practices

48. **02050 Information Technology** (Implemented)
    - PARA Index: `disciplines/02050-information-technology/`
    - Gigabrain Tags: disciplines, 02050-information-technology, it-practices

49. **02075 Inspection** (Implemented)
    - PARA Index: `disciplines/02075_inspection/`
    - Gigabrain Tags: disciplines, 02075_inspection, inspection-practices

50. **02200 Quality Assurance** (Implemented)
    - PARA Index: `disciplines/02200_quality-assurance/`
    - Gigabrain Tags: disciplines, 02200_quality-assurance, qa-practices

51. **02250 Quality Control** (Implemented)
    - PARA Index: `disciplines/02250_quality-control/`
    - Gigabrain Tags: disciplines, 02250_quality-control, qc-practices

52. **02400 Safety** (Implemented)
    - PARA Index: `disciplines/02400_safety/`
    - Gigabrain Tags: disciplines, 02400_safety, safety-practices

53. **02500 Security** (Implemented)
    - PARA Index: `disciplines/02500_security/`
    - Gigabrain Tags: disciplines, 02500_security, security-practices

54. **03000 Sundry** (Implemented)
    - PARA Index: `disciplines/03000_sundry/`
    - Gigabrain Tags: disciplines, 03000_sundry, sundry-practices

#### **Cross-Discipline Integration**
55. **CROSS-DISCIPLINE** (Implemented)
    - PARA Index: `disciplines/CROSS-DISCIPLINE.md`
    - Gigabrain Tags: cross-discipline, integration, collaboration

### Memory Layer Usage for Code Generation
- **Layer C (PARA)**: Use discipline para-index.md for complete context
- **Layer D (Daily)**: Check memory/YYYY-MM-DD.md for recent updates
- **Layer E (Gigabrain)**: Automatic surfacing via YAML frontmatter tags
- **Layer B (LCM)**: Session continuity for workflow implementation

### Documentation Priority Order
1. Discipline PARA Index (`disciplines/[code]/para-index.md`)
2. Workflow Documentation (`disciplines/[code]/workflow_docs/`)
3. API References (`disciplines/[code]/api/`)
4. Related Procedures (`procedures/[area]/`)
<!-- MEMORY-STACK-GIVEAWAY:END -->
