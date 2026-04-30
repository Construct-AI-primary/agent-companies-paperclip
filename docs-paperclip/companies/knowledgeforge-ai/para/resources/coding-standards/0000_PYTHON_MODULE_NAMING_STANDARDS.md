---
memory_layer: durable_knowledge
para_section: pages/codebase/coding-standards
gigabrain_tags: coding-standards, codebase, development-practices
documentation
openstinger_context: coding-standards-practices
last_updated: 2026-03-21
related_docs:
  - codebase/coding-standards/
  - disciplines/
---
# Python Module Naming Standards for Construct AI

**Document ID**: `0006_PYTHON_MODULE_NAMING_STANDARDS`  
**Version**: 1.0.0  
**Created**: 2026-02-24  
**Status**: ACTIVE

---

## Overview

This document establishes the naming conventions for Python modules, packages, and directories within the Construct AI codebase. These standards ensure compatibility with Python import system, IDE tooling, and static analysis tools.

## Core Principles

### Python Naming Rules (PEP 8 Compliance)

Python module names **MUST** follow PEP 8 conventions:

1. **Lowercase only**: All module and package names must be lowercase
2. **Underscores for separation**: Use underscores (`_`) instead of hyphens (`-`)
3. **No special characters**: Only letters, numbers, and underscores allowed
4. **No emojis**: Files must not contain any emoji characters
5. **Valid Python identifiers**: Names must be valid Python identifiers

### Why Hyphens Are Problematic

```python
# ❌ INVALID - Hyphen in directory name
from deep_agents.agents.pages.01900-procurement import something
# SyntaxError: invalid syntax (hyphen creates invalid identifier)

# ✅ VALID - Underscore in directory name
from deep_agents.agents.pages.01900_procurement import something
# Works correctly with standard Python imports
```

**Issues caused by hyphens:**
- Standard `import` statements fail with syntax errors
- IDE autocomplete and IntelliSense break
- Static analysis tools (mypy, pylint, pyright) cannot resolve imports
- Refactoring tools cannot trace dependencies
- Runtime `importlib` workarounds are fragile and error-prone

---

## Naming Conventions

### Package/Directory Names

| Type | Convention | Example |
|------|------------|---------|
| Top-level package | `lowercase` | `deep_agents` |
| Subpackage | `lowercase_with_underscores` | `procurement_workflow` |
| Discipline package | `{code}_{name}` | `01900_procurement` |
| Agent package | `{code}_{agent_type}` | `01900_procurement_coordinator` |

### Module/File Names

| Type | Convention | Example |
|------|------------|---------|
| Agent module | `{code}_{agent_name}.py` | `01900_template_analysis_agent.py` |
| Utility module | `{purpose}.py` | `structured_logging.py` |
| Core module | `c_{purpose}.py` | `c_deep_agents_state_management.py` |
| Abstract base | `a_{number}_{name}.py` | `a_0000_base_governance_agent.py` |

### Class Names

| Type | Convention | Example |
|------|------------|---------|
| Agent class | `PascalCase` | `ProcurementTemplateAnalysisAgent` |
| State class | `PascalCase` | `WorkflowState` |
| Mixin class | `PascalCase` + `Mixin` suffix | `GovernedAgentMixin` |
| Abstract base | `PascalCase` + `Base` prefix | `BaseWorkflowState` |

### Function/Method Names

| Type | Convention | Example |
|------|------------|---------|
| Function | `snake_case` | `validate_workflow` |
| Private method | `_leading_underscore` | `_execute_impl` |
| Async method | `async def snake_case` | `async def coordinate` |
| Decorator | `with_` prefix | `with_governance` |

---

## Directory Structure Standards

### Deep Agents Package Structure

```
deep_agents/
├── __init__.py
├── core/                           # Core framework modules
│   ├── c_deep_agents_core_framework.py
│   ├── c_deep_agents_state_management.py
│   └── ...
├── agents/
│   ├── shared/                     # Shared agents and utilities
│   │   ├── governance/
│   │   ├── specialist_agents/
│   │   └── ...
│   └── pages/                      # Discipline-specific agents
│       ├── 00102_administration/   # ✅ Underscore
│       ├── 01300_governance/       # ✅ Underscore
│       ├── 01900_procurement/      # ✅ Underscore
│       └── ...
└── utils/
    └── ...
```

### Discipline Directory Naming

Discipline directories MUST use the following pattern:

```
{discipline_code}_{discipline_name}
```

**Examples:**
- `01900_procurement` (NOT `01900-procurement`)
- `01300_governance` (NOT `01300-governance`)
- `00835_chemical_engineering` (NOT `00835-chemical-engineering`)
- `02025_quantity_surveying` (already correct)

---

## Migration Guide

### Renaming Hyphenated Directories

When migrating existing hyphenated directories:

1. **Use git mv to preserve history:**
```bash
git mv deep_agents/agents/pages/01900-procurement deep_agents/agents/pages/01900_procurement
```

2. **Update all import statements:**
```python
# Before
mod = importlib.import_module(
    f"deep_agents.agents.pages.01900-procurement.main_agents.{module_name}"
)

# After
from deep_agents.agents.pages.01900_procurement.main_agents import (
    ProcurementTemplateAnalysisAgent
)
```

3. **Update __init__.py files** to expose public interfaces

4. **Run tests** to verify all imports resolve correctly

### Affected Directories (Current State)

The following directories need renaming:

| Current (Invalid) | Target (Valid) |
|-------------------|----------------|
| `00102-administration` | `00102_administration` |
| `00300-construction` | `00300_construction` |
| `00400-contracts` | `00400_contracts` |
| `00425-contracts-pre-award` | `00425_contracts_pre_award` |
| `00800-design` | `00800_design` |
| `00825-architectural` | `00825_architectural` |
| `00835-chemical-engineering` | `00835_chemical_engineering` |
| `00850-civil-engineering` | `00850_civil_engineering` |
| `00855-geotechnical-engineering` | `00855_geotechnical_engineering` |
| `00860-electrical-engineering` | `00860_electrical_engineering` |
| `00870-mechanical-engineering` | `00870_mechanical_engineering` |
| `00871-process-engineering` | `00871_process_engineering` |
| `00872-developer` | `00872_developer` |
| `00876-directors` | `00876_directors` |
| `00877-sundry` | `00877_sundry` |
| `00880-board-of-directors` | `00880_board_of_directors` |
| `00882-director-construction` | `00882_director_construction` |
| `00883-director-contracts` | `00883_director_contracts` |
| `00884-director-engineering` | `00884_director_engineering` |
| `00885-director-hse` | `00885_director_hse` |
| `00886-director-logistics` | `00886_director_logistics` |
| `00888-director-procurement` | `00888_director_procurement` |
| `00889-director-finance` | `00889_director_finance` |
| `00890-director-projects` | `00890_director_projects` |
| `00895-director-project` | `00895_director_project` |
| `01000-environmental` | `01000_environmental` |
| `01100-ethics` | `01100_ethics` |
| `01200-finance` | `01200_finance` |
| `01300-governance` | `01300_governance` |
| `01400-health` | `01400_health` |
| `01500-human-resources` | `01500_human_resources` |
| `01600-local-content` | `01600_local_content` |
| `01700-logistics` | `01700_logistics` |
| `01750-legal` | `01750_legal` |
| `01800-operations` | `01800_operations` |
| `01850-other-parties` | `01850_other_parties` |
| `01900-procurement` | `01900_procurement` |
| `02000-project-controls` | `02000_project_controls` |
| `02035-scheduling` | `02035_scheduling` |
| `02050-information-technology` | `02050_information_technology` |
| `02075-inspection` | `02075_inspection` |
| `02100-public-relations` | `02100_public_relations` |
| `02200-quality-assurance` | `02200_quality_assurance` |
| `02250-quality-control` | `02250_quality_control` |
| `02400-safety` | `02400_safety` |
| `02500-security` | `02500_security` |
| `03000-landscaping` | `03000_landscaping` |

---

## Validation Checklist

### For New Python Modules

- [ ] Module name is lowercase
- [ ] Uses underscores (not hyphens) for word separation
- [ ] Name is a valid Python identifier
- [ ] Follows discipline code prefix pattern
- [ ] Has corresponding `__init__.py` if it's a package

### For New Directories

- [ ] Directory name is lowercase
- [ ] Uses underscores (not hyphens) for word separation
- [ ] Contains `__init__.py` for Python packages
- [ ] Follows established naming patterns

### For Imports

- [ ] Uses standard `import` statements (not `importlib` workarounds)
- [ ] IDE can resolve the import
- [ ] Static analysis tools pass without errors

---

## Related Standards

- **File Naming Standards**: `docs/standards/0002_FILE_NAMING_STANDARDS.md`
- **Agent Coding Standards**: `docs/standards/0000_AGENT_CODING_STANDARDS.md`
- **Workflow State Standards**: `docs/standards/0007_WORKFLOW_STATE_STANDARDS.md`

---

## Document Information

- **Document ID**: `0006_PYTHON_MODULE_NAMING_STANDARDS`
- **Version**: 1.0.0
- **Created**: 2026-02-24
- **Author**: Construct AI Development Team
- **Status**: ACTIVE
- **Next Review**: 2026-03-24