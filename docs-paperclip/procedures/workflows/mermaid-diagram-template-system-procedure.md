---
title: "Mermaid Diagram Template System — Procedure"
description: "Complete procedure for creating, rendering, versioning, and maintaining parameterized mermaid diagram templates across all disciplines. Covers template extraction, CLI usage, version management, and cross-company agent coordination."
author: "PaperclipForge AI — Shared Services"
date: "2026-04-29"
version: "1.0"
status: "active"
gigabrain_tags: mermaid, diagrams, templates, procedures, workflow, code-generation, ui-ux
related_docs:
  - docs-paperclip/companies/paperclipforge-ai/skills/mermaid-diagram-templates/SKILL.md
  - docs-paperclip/companies/devforge-ai/skills/diagram-driven-code-generation/SKILL.md
  - docs-paperclip/companies/domainforge-ai/skills/discipline-ui-ux-spec-generation/SKILL.md
  - docs-paperclip/companies/qualityforge-ai/skills/diagram-code-conformance/SKILL.md
  - docs-paperclip/templates/mermaid/registry.yaml
  - docs-paperclip/scripts/render-mermaid.js
  - docs-construct-ai/codebase/guides/developer/1500_MERMAID_MASTER_GUIDE.md
---

# Mermaid Diagram Template System — Procedure

## 1. Overview

This procedure defines how to create, render, version, and maintain **parameterized mermaid diagram templates** across all Paperclip companies. The template system serves as the single source of truth for workflow visualization, UI/UX specifications, and React component code generation.

### 1.1 Purpose

- Eliminate hardcoded diagrams duplicated across discipline specs
- Enable automatic propagation of diagram refinements to all consumers
- Drive code generation from the same templates that produce documentation
- Provide a learning loop where template refinements automatically update specs and code

### 1.2 Architecture

```
Template YAML (parameterized)
    │
    ├── render-mermaid.js ──► Rendered Mermaid Diagram (in spec docs)
    │
    └── code-generator.js ──► React Component (state routers, modals, buttons)
                              │
                              └── conformance-check.js ──► Validation Report
```

### 1.3 File Locations

| Asset | Path |
|-------|------|
| Template Registry | `docs-paperclip/templates/mermaid/registry.yaml` |
| Template Definitions | `docs-paperclip/templates/mermaid/{name}.yaml` |
| Renderer CLI | `docs-paperclip/scripts/render-mermaid.js` |
| Shared Skill | `docs-paperclip/companies/paperclipforge-ai/skills/mermaid-diagram-templates/SKILL.md` |
| DevForge Skill | `docs-paperclip/companies/devforge-ai/skills/diagram-driven-code-generation/SKILL.md` |
| DomainForge Skill | `docs-paperclip/companies/domainforge-ai/skills/discipline-ui-ux-spec-generation/SKILL.md` |
| QualityForge Skill | `docs-paperclip/companies/qualityforge-ai/skills/diagram-code-conformance/SKILL.md` |

---

## 2. Template Lifecycle

### 2.1 Creating a New Template

**When**: A new workflow pattern is identified that will be reused across multiple disciplines.

**Steps**:

1. **Analyze the source diagram** from a UI/UX spec or workflow document
2. **Identify parameters** — which parts vary by discipline (codes, labels, complexity, boolean toggles)
3. **Create the template YAML** at `docs-paperclip/templates/mermaid/{name}.yaml`:

```yaml
name: my-new-template
version: "1.0"
description: "Description of what this template represents"
parameters:
  - name: discipline
    type: string
    default: "01900"
    description: "Discipline code"
  - name: showFeature
    type: boolean
    default: true
    description: "Whether to show the feature in the flow"
template: |
  flowchart TD
    START[Start] -->|action| MID[Middle]
    {% if showFeature %}
    MID --> FEATURE[Feature Step]
    {% endif %}
    MID --> END[End]

    classDef start fill:#e3f2fd,stroke:#1976d2
    class START start
```

4. **Register the template** in `docs-paperclip/templates/mermaid/registry.yaml`:

```yaml
my-new-template:
  current: "1.0"
  changelog:
    "1.0": "Initial template extracted from [source spec]"
  parameters:
    - discipline
    - showFeature
```

5. **Test the template** by rendering it:

```bash
node docs-paperclip/scripts/render-mermaid.js \
  --template my-new-template \
  --discipline 01900 \
  --showFeature true
```

6. **Verify the output** parses correctly in a Mermaid renderer (GitHub, Mermaid Live Editor, etc.)

### 2.2 Extracting a Template from an Existing Diagram

**When**: A UI/UX spec or workflow document contains a hardcoded diagram that should be converted to a parameterized template.

**Steps**:

1. **Copy the raw mermaid code** from the spec document
2. **Identify variable elements** — discipline codes, labels, conditional branches
3. **Replace variables with `{{ param }}` placeholders**:
   - `01900` → `{{ discipline }}`
   - `standard` → `{{ complexity }}`
   - Conditional sections → `{% if showHITL %} ... {% endif %}`
4. **Define parameters** in the YAML frontmatter with types, defaults, and descriptions
5. **Replace the hardcoded diagram** in the spec with a reference to the rendered template:

```markdown
<!-- This diagram is generated from the procurement-lifecycle template -->
<!-- To update: node render-mermaid.js --template procurement-lifecycle --discipline 01900 -->
![Procurement Lifecycle](diagrams/procurement-lifecycle.md)
```

6. **Render the template** to produce the initial diagram file:

```bash
node docs-paperclip/scripts/render-mermaid.js \
  --template procurement-lifecycle \
  --discipline 01900 \
  --output docs-paperclip/disciplines/01900-procurement/diagrams/procurement-lifecycle.md
```

### 2.3 Refining a Template (Version Bump)

**When**: A workflow pattern changes, a new parameter is needed, or a diagram is improved.

**Steps**:

1. **Update the template YAML** with the new pattern
2. **Bump the version** in both the template YAML and `registry.yaml`
3. **Add a changelog entry** in `registry.yaml`:

```yaml
my-new-template:
  current: "1.1"
  changelog:
    "1.1": "Added emergency routing path, new complexity parameter"
    "1.0": "Initial template"
```

4. **Re-render all consuming specs** — the DomainForge AI agent handles this:

```bash
# Re-render all diagrams for a specific discipline
node docs-paperclip/scripts/render-mermaid.js \
  --discipline 01900 \
  --output-dir docs-paperclip/disciplines/01900-procurement/diagrams/
```

5. **Notify DevForge AI** to regenerate components from the updated templates
6. **Notify QualityForge AI** to run conformance checks on the regenerated code

---

## 3. Renderer CLI Usage

### 3.1 Prerequisites

- Node.js 18+
- `js-yaml` package (install with `npm install js-yaml` in the scripts directory)

### 3.2 Commands

#### List Available Templates

```bash
node docs-paperclip/scripts/render-mermaid.js --list-templates
```

Output:
```
Available Mermaid Diagram Templates:

  procurement-lifecycle
    Version: 1.0
    Parameters: discipline, complexity, showHITL, showPayment

  three-state-navigation
    Version: 1.0
    Parameters: discipline, states, buttons
```

#### Show Template Details

```bash
node docs-paperclip/scripts/render-mermaid.js --template-info procurement-lifecycle
```

Output:
```
Template: procurement-lifecycle
Version: 1.0
Description: Full procurement lifecycle from need identification through payment

Parameters:
  discipline: string (default: 01900)
    Discipline code for the procurement
  complexity: enum (default: standard) [simple, standard, complex, emergency, compliance]
    Template complexity level
  showHITL: boolean (default: true)
    Whether to show the HITL review gate
  showPayment: boolean (default: true)
    Whether to show the payment step
```

#### Render a Single Template

```bash
node docs-paperclip/scripts/render-mermaid.js \
  --template procurement-lifecycle \
  --discipline 00860 \
  --complexity complex \
  --showHITL true \
  --showPayment false \
  --output docs-paperclip/disciplines/00860-electrical-engineering/diagrams/procurement-lifecycle.md
```

#### Render All Templates for a Discipline

```bash
node docs-paperclip/scripts/render-mermaid.js \
  --discipline 01900 \
  --output-dir docs-paperclip/disciplines/01900-procurement/diagrams/
```

This renders all 10 templates with the discipline parameter set to `01900` and all other parameters using their defaults.

#### Render to stdout (for quick testing)

```bash
node docs-paperclip/scripts/render-mermaid.js \
  --template procurement-lifecycle \
  --discipline 02400 \
  --complexity compliance
```

### 3.3 Parameter Reference

| Flag | Type | Description |
|------|------|-------------|
| `--template` | string | Template name (required for single render) |
| `--discipline` | string | Discipline code (e.g., 01900, 00860, 02400) |
| `--output` | string | Output file path (for single template render) |
| `--output-dir` | string | Output directory (renders all templates) |
| `--list-templates` | flag | List all available templates |
| `--template-info` | string | Show template details and parameters |
| `--{param}` | varies | Any template parameter (e.g., `--complexity complex`) |

---

## 4. Template Format Specification

### 4.1 YAML Structure

```yaml
name: string                    # Required. Unique template identifier (kebab-case)
version: string                 # Required. Semantic version (e.g., "1.0", "2.1")
description: string             # Required. Human-readable description
parameters:                     # Required. Array of parameter definitions
  - name: string                # Required. Parameter name (camelCase)
    type: string                # Required. One of: string, enum, boolean, number
    default: any                # Optional. Default value if not provided
    values: []                  # Required for enum type. Allowed values
    description: string         # Required. Human-readable description
template: string                # Required. Mermaid diagram template
```

### 4.2 Template Syntax

The template supports two substitution mechanisms:

#### Variable Substitution: `{{ paramName }}`

Replaced with the parameter value at render time:

```
    DISCIPLINE[Discipline: {{ discipline }}]
    COMPLEXITY[Complexity: {{ complexity }}]
```

#### Conditional Blocks: `{% if paramName %} ... {% else %} ... {% endif %}`

Included or excluded based on boolean parameter:

```
    {% if showHITL %}
    COLLAB -->|HITL gate| HITL{{HITL Review Required?}}
    HITL -->|yes| REVIEW[HITL Review Queue]
    {% else %}
    COLLAB --> APPROVAL[Approval Routing]
    {% endif %}
```

### 4.3 Best Practices

1. **Use descriptive parameter names** — `showHITL` not `hitl`
2. **Provide sensible defaults** — most renders should work with defaults
3. **Document each parameter** — description field is required
4. **Keep templates focused** — one workflow pattern per template
5. **Include classDefs** — color coding helps readability
6. **Test after every change** — run the renderer and verify output
7. **Version bump for any change** — even minor label tweaks

---

## 5. Cross-Company Agent Coordination

### 5.1 Agent Responsibility Matrix

| Phase | Agent | Company | Action |
|-------|-------|---------|--------|
| **Template Creation** | `paperclipforge-ai-atlasagentcreator` | PaperclipForge AI | Create template YAML, register in registry |
| **Spec Generation** | `construction-domainforge` / `commercial-domainforge` | DomainForge AI | Render templates into discipline UI/UX specs |
| **Code Generation** | `interface-devforge` / `codesmith-devforge` | DevForge AI | Generate React components from templates |
| **Conformance** | `guardian-qualityforge` / `validator-qualityforge` | QualityForge AI | Validate code matches diagram specs |
| **Knowledge Indexing** | `knowledge-curator-domainforge` | KnowledgeForge AI | Index template registry for agent discovery |

### 5.2 Template Refinement Workflow

When a template refinement is needed:

```
1. DomainForge AI identifies improvement
       │
2. PaperclipForge AI updates template YAML + bumps version
       │
3. DomainForge AI re-renders all consuming specs
       │
4. DevForge AI regenerates components from updated templates
       │
5. QualityForge AI validates conformance
       │
6. KnowledgeForge AI indexes new version
```

### 5.3 Communication Protocol

- **Template version bumps** are communicated via the `registry.yaml` changelog
- **Breaking changes** (parameter removals, structural changes) require a major version bump
- **Non-breaking changes** (new parameters, label tweaks) are minor version bumps
- **All agents** should check `registry.yaml` before starting work that involves diagrams

---

## 6. Quality Assurance

### 6.1 Pre-Commit Checks

Before committing a template change, verify:

- [ ] Template YAML parses without errors (`node -e "require('js-yaml').load(require('fs').readFileSync('template.yaml','utf8'))"`)
- [ ] Template renders without errors (`node render-mermaid.js --template <name>`)
- [ ] Rendered output parses in Mermaid Live Editor
- [ ] All parameters have descriptions
- [ ] Registry version is bumped
- [ ] Changelog entry is added

### 6.2 Conformance Validation

QualityForge AI runs these checks:

| Check | What It Validates |
|-------|------------------|
| State Router Conformance | Three-state navigation matches template |
| Button Configuration | Button labels, modals, gates match template |
| Modal Wiring | Modal open/close handlers match diagram |
| HITL Queue Structure | Review queue matches template |
| Approval Chain | Approval routing matches template |
| Template Version | Component uses current template version |

### 6.3 Success Metrics

| Metric | Target |
|--------|--------|
| Template Coverage | ≥90% of diagrams use parameterized templates |
| Version Compliance | 100% of specs use current template version |
| Render Accuracy | 100% of rendered diagrams parse without errors |
| Code Conformance | ≥95% match between diagrams and implemented code |
| Drift Detection | <1 hour from version bump to detection |

---

## 7. Troubleshooting

### 7.1 Template Not Found

```
Error: Template not found: my-template. Available: procurement-lifecycle, ...
```

**Cause**: Template name doesn't match a file in `docs-paperclip/templates/mermaid/`
**Fix**: Check the filename matches the `--template` argument exactly (kebab-case)

### 7.2 YAML Parse Error

```
Error: YAMLException: unacceptable kind of an object instance ...
```

**Cause**: Invalid YAML syntax in the template file
**Fix**: Validate with `node -e "require('js-yaml').load(require('fs').readFileSync('template.yaml','utf8'))"`

### 7.3 Parameter Validation Error

```
Parameter validation errors:
  - Invalid value for complexity: "extreme". Expected one of: simple, standard, complex, emergency, compliance
```

**Cause**: Parameter value doesn't match the enum definition
**Fix**: Use one of the allowed values or add the new value to the enum

### 7.4 Mermaid Parse Error in Rendered Output

**Cause**: The rendered template produces invalid Mermaid syntax
**Fix**: 
1. Render to stdout and copy the output
2. Paste into [Mermaid Live Editor](https://mermaid.live/)
3. Fix the template YAML based on the error
4. Re-render and verify

### 7.5 Version Drift Detected

**Cause**: A component was generated from an older template version
**Fix**:
1. Re-render the diagram with the current template version
2. Regenerate the component
3. Re-run conformance validation

---

## 8. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-04-29 | Initial procedure for Mermaid Diagram Template System |

---

*This procedure defines the Mermaid Diagram Template System used across all Paperclip companies for consistent, versioned, code-generatable workflow visualization.*