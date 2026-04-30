# Companies

All Paperclip agent companies follow the `agentcompanies/v1` specification. See `companies-spec.md` for the full spec.

## Company Registry

| # | Company | Slug | Description | Agents | Skills | Teams |
|---|---------|------|-------------|--------|--------|-------|
| 1 | DevForge AI | `devforge-ai` | Enterprise development, orchestration, and system architecture | 51 | 47 | 7 |
| 2 | DomainForge AI | `domainforge-ai` | Multi-discipline engineering and construction expertise | 22 | 21 | 3 |
| 3 | InfraForge AI | `infraforge-ai` | Infrastructure and systems integration company | 4 | 4 | 1 |
| 4 | KnowledgeForge AI | `knowledgeforge-ai` | Institutional memory and QA automation for multi-discipline engineering | 11 | 11 | 3 |
| 5 | Loopy AI | `loopy-ai` | AI vision and image analysis company | 1 | 0 | 0 |
| 6 | Org Template AI | `org-template-ai` | Generic organisation template for companies | 2 | 1 | 2 |
| 7 | PromptForge AI | `promptforge-ai` | Advanced Prompt Engineering & Orchestration Specialists | 24 | 23 | 5 |
| 8 | QualityForge AI | `qualityforge-ai` | Testing, debugging, coding excellence, and quality assurance | 37 | 37 | 5 |
| 9 | Construct AI | `construct-ai` | Discipline knowledge base (not a company — no COMPANY.md) | — | — | — |
| 10 | Shared | `shared` | Shared skills used across companies | — | 25 | — |

**Total: ~152 agents, 149 skills, 27 teams across 8 companies + shared pool**

## Company Profiles

### DevForge AI
- **Focus**: Enterprise development, orchestration, system architecture
- **Teams**: executive, engineering, data, security, product, growth, strategy
- **Key Agents**: nexus-devforge-ceo, orion-devforge-orchestrator
- **Unique**: 51 agents covering full enterprise stack from backend to growth

### DomainForge AI
- **Focus**: Multi-discipline engineering and construction
- **Teams**: engineering, operations, governance
- **Key Agents**: orion-domainforge-ceo
- **Unique**: Engineering disciplines (civil, structural, geotechnical, transportation, construction) + business functions (procurement, finance, logistics, safety, quality)

### InfraForge AI
- **Focus**: Infrastructure and systems integration
- **Teams**: infrastructure
- **Key Agents**: orchestrator-infraforge-ceo
- **Unique**: Database infrastructure, mobile API integration, supply chain connectivity

### KnowledgeForge AI
- **Focus**: Institutional memory and QA automation
- **Teams**: knowledge-engineering, discipline-operations, sector-analysis
- **Key Agents**: knowledgeforge-ceo, knowledgeforge-doc-analyzer, knowledgeforge-qa-strategist
- **Unique**: Cross-discipline QA review loops, failure learning, architecture refactoring

### Loopy AI
- **Focus**: AI vision and image analysis
- **Key Agents**: vision-loopy-ceo
- **Unique**: Minimal setup — single CEO agent, placeholder company

### Org Template AI
- **Focus**: Generic organisation template
- **Teams**: engineering, operations
- **Key Agents**: org-template-ai-ceo, org-template-ai-engineering-lead
- **Unique**: Clone-and-customize template for new organisations

### PromptForge AI
- **Focus**: Advanced prompt engineering and orchestration
- **Teams**: architecture, research, ethics, analytics, integration
- **Key Agents**: sage-promptforge-chief-architect
- **Unique**: Prompt architecture, testing, ethical AI compliance, cross-agent compatibility

### QualityForge AI
- **Focus**: Testing, debugging, coding excellence, quality assurance
- **Teams**: executive, quality, testing, debugging, coding
- **Key Agents**: apex-qualityforge-ceo
- **Unique**: 37 specialised QA agents covering every testing dimension

### Construct AI
- **Focus**: Discipline knowledge base (not a standard company package)
- **Structure**: Organised by discipline codes (00250-commercial, 00300_construction, etc.)
- **Unique**: Reference knowledge, not runtime agents

### Shared Skills
- **Purpose**: Reusable skills across companies
- **Skills**: accessibility-standards, agent-development-standards, agent-coding-standards, api-design-standards, audit-trail-management, brainstorming, capacity-planning, competitive-analysis, conflict-resolution, continuous-improvement, cross-team-collaboration, data-modeling-standards, data-privacy-check, edge-case-analysis, feedback-integration, handoff-protocol, incident-response, innovation-evaluation, knowledge-retrieval, knowledge-transfer, lessons-learned-synthesis, license-compliance, mobile-code-impact-assessment, output-validation-checklist, performance-benchmarking, react-native-expert, receiving-code-review, regression-prevention, requesting-code-review, risk-assessment, secrets-handling, status-reporting, systematic-debugging, taxonomy-standards, test-driven-development, testing-strategy, threat-modeling, ui-ux-guidelines, verification-before-completion, writing-skills

## Duplication Analysis

### Goals — No Overlap

| Company | Goals Summary |
|---------|---------------|
| DevForge AI | Enterprise development, orchestration, architecture, security, growth |
| DomainForge AI | Engineering expertise, quality standards, regulatory compliance |
| InfraForge AI | Infrastructure management, database solutions, mobile API |
| KnowledgeForge AI | Institutional memory, QA automation, discipline workflows |
| Loopy AI | Vision/image analysis |
| Org Template AI | Template for customisation |
| PromptForge AI | Prompt engineering, orchestration, ethical AI |
| QualityForge AI | Testing, debugging, quality assurance |

**Result**: No goal duplication. Each company has a distinct mission.

### Agents — No Duplicate Slugs

All agent slugs are unique and follow the pattern `{name}-{company}-{role}`. No agent slug appears in more than one company.

**Result**: No agent duplication.

### Skills — Some Overlap in Concept, Not Implementation

| Concept | Companies with similar skills | Notes |
|---------|------------------------------|-------|
| CEO/Leadership | All companies | Different CEO agents per company — expected |
| Code Review | DevForge (`reviewer-devforge-code-review-qa`), QualityForge (`reviewer-qualityforge-code-reviewer`) | Different scope — DevForge = general QA, QualityForge = specialised code review |
| Bug Fixing | DevForge (`fixer-devforge-bug-fixing`), QualityForge (`fixer-qualityforge-bug-fixing-specialist`) | Different scope — DevForge = general, QualityForge = specialist |
| Architecture | DevForge (`forge-devforge-system-architecture`), QualityForge (`architect-qualityforge-system-architect`) | Different scope — DevForge = building, QualityForge = reviewing |
| Strategic Planning | DevForge, DomainForge (`strategos-*`) | Different scope — DevForge = business strategy, DomainForge = engineering strategy |
| Quality Assurance | DomainForge, KnowledgeForge, QualityForge | Different scope — DomainForge = engineering QA, KnowledgeForge = cross-discipline QA, QualityForge = comprehensive QA |
| Weekly Review | DevForge, DomainForge, InfraForge, PromptForge, QualityForge, Org Template AI | **Expected** — recurring task pattern, not a skill duplication |
| Accessibility Testing | QualityForge (`accessibility-Accessibility-testing`), Shared (`accessibility-standards`) | Shared skill is generic, QualityForge version is QA-specific |

**Result**: Conceptual overlap is expected and intentional. Each company's skills are scoped to their domain. The `shared/` folder correctly provides generic skills that any company can reference.

### Teams — Some Similar Names, Different Scope

| Team Name | Companies | Notes |
|-----------|-----------|-------|
| Engineering | DevForge, DomainForge, Org Template AI | DevForge = software engineering, DomainForge = civil/structural/geotechnical, Org = template placeholder |
| Operations | DomainForge, Org Template AI | DomainForge = procurement/logistics/finance, Org = template placeholder |
| Executive | DevForge, QualityForge | Expected — each company needs a leadership team |
| Governance | DomainForge | Only in DomainForge — governance/standards/legal |

**Result**: Team name overlap reflects standard org structure patterns, not duplication.

## Naming Convention

All companies follow this pattern:
- **Company**: `{name}-ai` (e.g., `devforge-ai`, `knowledgeforge-ai`)
- **Agent slug**: `{agent-name}-{company}-{role}` (e.g., `nexus-devforge-ceo`)
- **Skill slug**: `{skill-name}-{company}-{role}` (e.g., `nexus-devforge-ceo`)

## How to Add a New Company

1. Copy `org-template-ai/` as your starting point:
   ```bash
   cp -r docs-paperclip/companies/org-template-ai/ docs-paperclip/companies/my-company-ai/
   ```
2. Search/replace `org-template-ai` with your company slug
3. Customize `COMPANY.md`, agents, teams, skills, knowledge
4. See `companies-spec.md` for the full specification

## How to Add Shared Skills

Place generic skills in `shared/` that any company can reference:
```yaml
includes:
  - ../shared/accessibility-standards/SKILL.md
```

## Verification

```bash
# Validate a company package
paperclip companies validate docs-paperclip/companies/my-company-ai/

# Check for duplicate agent slugs
grep -r "^slug:" docs-paperclip/companies/*/agents/*/AGENTS.md | sort | uniq -d

# Check for duplicate skill slugs
grep -r "^name:" docs-paperclip/companies/*/skills/*/SKILL.md | sort | uniq -d