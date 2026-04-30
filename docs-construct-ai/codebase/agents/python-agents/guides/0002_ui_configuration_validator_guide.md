---
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, codebase, ai-automation
documentation
openstinger_context: agent-development, ai-systems
last_updated: 2026-03-21
related_docs:
  - codebase/agents/
  - disciplines/
---
# UI Configuration Validator Agent - Complete Reference Guide

## Overview

The UI Configuration Validator is an AI agent that validates and fixes modal layouts, themes, and dropdown data across all disciplines. It learns from patterns and improves over time.

**Access via Agent Operations Center**: http://localhost:3060/#/agent-operations-center

---

## Quick Reference Commands

### Available Operations

| Operation | Purpose | Usage |
|-----------|---------|-------|
| `validate_ui_anomalies()` | Full UI validation across all disciplines | General health check |
| `validate_modal_layouts(discipline_code)` | Validate modal CSS layouts | Layout issues |
| `validate_cross_discipline_themes(learn=True)` | Check theme consistency | Enterprise-wide theme |
| `generate_configuration_fixes(results)` | Generate fixes for issues | Fix generation |
| `generate_layout_fixes(discipline_code)` | Generate layout fixes | Layout fixes |
| `apply_configuration_fixes(fixes, approval_granted)` | Apply fixes | Fix application |
| `get_learning_insights()` | View learning data | See what was learned |

---

## Usage Examples

### 1. Basic UI Validation (All Disciplines)

```python
from deep_agents.agents.shared.it_specialists.a_0000_ui_configuration_validator_refactored import UIConfigurationValidatorAgent

agent = UIConfigurationValidatorAgent()

# Run comprehensive validation
result = agent.validate_ui_anomalies()

print(f"Issues found: {result['total_issues_found']}")
print(f"Health score: {result['overall_health_score']}")
```

### 2. Validate Modal Layouts (Specific Discipline)

```python
# Validate layouts for 01900 (Procurement)
result = agent.validate_modal_layouts('01900')

# Or validate all disciplines
result = agent.validate_modal_layouts()
```

### 3. Cross-Discipline Theme Analysis (Auto-Learning)

```python
# Analyze themes across ALL disciplines
# Learning happens AUTOMATICALLY when appropriate:
# - First run (no learning data exists)
# - More than 3 inconsistencies found
# - High fix success rate (>80%)

result = agent.validate_cross_discipline_themes()

# Override auto-learning if needed:
result = agent.validate_cross_discipline_themes(learn=True)   # Force learning
result = agent.validate_cross_discipline_themes(learn=False) # Disable

# Check if learning was applied
print(f"Auto-learn applied: {result.get('auto_learning_applied')}")

# Check inconsistencies
for issue in result.get('inconsistencies', []):
    print(f"Property: {issue['property']}")
    print(f"Current: {issue.get('most_common_value')}")
    print(f"Fix: {issue.get('fix_suggestion')}")
```

### 4. Generate and Apply Fixes

```python
# Generate fixes from validation
validation = agent.validate_ui_anomalies()
fixes = await agent.generate_configuration_fixes(validation)

# Apply safe fixes automatically
results = await agent.apply_configuration_fixes(fixes['safe_fixes'], approval_granted=True)

# Apply fixes requiring approval
results = await agent.apply_configuration_fixes(fixes['requires_approval'], approval_granted=True)
```

### 5. Check Learning Insights

```python
# View what the agent has learned
insights = agent.learning_system.get_learning_insights()

print(f"Patterns learned: {insights['total_patterns_learned']}")
print(f"Success rates: {insights['fix_success_rates']}")
print(f"Recommendations: {insights['recommendations']}")
```

---

## Validation Categories

### Layout Validation
- **Positioning**: fixed/absolute, z-index values
- **Dimensions**: width, height, overflow handling
- **Responsive**: media queries, min-width
- **Accessibility**: focus styles, reduced-motion

### Dropdown Data Validation
Per `docs/procedures/human-workflows/0000_DROPDOWN_IMPLEMENTATION_PROCEDURE.md`:
- Hardcoded options detection (should load from DB)
- State management patterns
- Validation integration

### Theme Consistency
- Header gradient (standard: `linear-gradient(135deg, #FF8C00, #FFA500)`)
- Border radius (standard: `12px`)
- Required sections (header, body, footer)

### Cross-Discipline
- Scans ALL discipline modal CSS files
- Identifies inconsistencies
- Suggests enterprise-wide standards

---

## Enterprise Theme Standards

| Property | Standard Value |
|----------|---------------|
| Header Gradient | `linear-gradient(135deg, #FF8C00, #FFA500)` |
| Border Radius | `12px` |
| Position | `fixed` |
| Z-Index | `10000` |
| Primary Color | `#FF8C00` |

---

## Learning System

The agent learns from each analysis and fix application:

### What Gets Learned
1. **Theme Standards**: Most common values across disciplines
2. **Modal Mappings**: Button name → modal ID associations
3. **Success Rates**: Fix success/failure tracking
4. **Confidence Scores**: Pattern confidence improvements

### Data Storage
- **Location**: `data/ui_learning_data.json`
- **Persists**: Between sessions
- **Export**: `agent.learning_system.export_learning_data()`

---

## Common Use Cases

### Use Case 1: New Modal Not Opening

```python
# Check for button-modal mismatches
result = agent.validate_ui_anomalies()

# Generate fixes
fixes = await agent.generate_configuration_fixes(result)

# Apply safe fixes
await agent.apply_configuration_fixes(fixes['safe_fixes'])
```

### Use Case 2: Modal Layout Broken

```python
# Validate specific discipline
result = agent.validate_modal_layouts('01900')

# Generate layout fixes
fixes = agent.generate_layout_fixes('01900')

# View issues
for modal in result.get('modals_analyzed', []):
    print(f"Modal: {modal['name']}, Issues: {modal['issues']}")
```

### Use Case 3: Theme Inconsistent Across Disciplines

```python
# Run cross-discipline analysis
result = agent.validate_cross_discipline_themes(learn=True)

# View inconsistencies
for issue in result.get('inconsistencies', []):
    print(f"Fix: {issue['fix_suggestion']}")
```

### Use Case 4: Dropdown Not Loading Data

```python
# Check dropdown data binding
# Pass JSX content for dropdown validation
issues = validator.validate_modal_layout(
    css_content=css_string,
    modal_name="MyModal",
    discipline_code="01900",
    jsx_content=jsx_string  # For dropdown checks
)
```

---

## Troubleshooting

### Agent Not Responding

```python
# Check agent health
metadata = agent.get_agent_metadata()
print(f"Health: {metadata['health_score']}")
print(f"Version: {metadata['version']}")
```

### Learning Not Working

```python
# Check learning system health
if agent.learning_system.is_healthy():
    print("Learning system healthy")
else:
    print("Learning needs attention")
    # Reset if needed
    agent.learning_system.reset_learning_data()
```

### Validation Returns No Results

```python
# Check if disciplines are discovered
disciplines = agent.config_analyzer.discover_all_disciplines()
print(f"Found {len(disciplines)} disciplines")
```

---

## API Reference

### UIConfigurationValidatorAgent Methods

| Method | Parameters | Returns |
|--------|------------|---------|
| `validate_ui_anomalies()` | None | Dict with validation results |
| `validate_modal_layouts(discipline_code)` | str (optional) | Layout issues |
| `validate_cross_discipline_themes(learn)` | bool (default: True) | Theme analysis |
| `generate_configuration_fixes(results)` | Dict | Generated fixes |
| `generate_layout_fixes(discipline_code)` | str | Layout fixes |
| `apply_configuration_fixes(fixes, approval)` | List, bool | Application results |
| `get_agent_metadata()` | None | Agent info |
| `learning_system.get_learning_insights()` | None | Learning data |

---

## Files Reference

### Agent Implementation
- `deep-agents/deep_agents/agents/shared/it_specialists/a_0000_ui_configuration_validator_refactored.py`

### Modules
- `deep-agents/deep_agents/agents/shared/it_specialists/modules/ui_validator/`
  - `modal_layout_validator.py` - Layout validation
  - `learning_system.py` - Pattern learning
  - `fix_handlers.py` - Fix generation
  - `safety_controls.py` - Safety checks

### Configuration
- `agents/registry/deployed/active/ui-configuration-validator-it-specialist.json`

### Learning Data
- `data/ui_learning_data.json` (auto-created)

---

## Version History

| Version | Changes |
|---------|---------|
| 2.1.0 | Added cross-discipline theme analysis, learning integration |
| 2.0.0 | Refactored modular architecture |
| 1.0.0 | Initial release |

---

*Last Updated: 2026-02-13*
