---
title: Domain Knowledge Integration Strategy
summary: How to integrate 408 construct-ai domain skills with Paperclip agents
---

# Domain Knowledge Integration Strategy

## The Problem

We have **408 domain-specific skills** in `construct-ai/skills/` organized by discipline code (00250-commercial, 00300_construction, etc.). These represent deep domain knowledge in construction, engineering, contracts, procurement, safety, and other disciplines.

The question is: **how do agents access and use this domain knowledge?**

## Why 1:1 Agent-to-Skill Mapping Doesn't Work for Domain Knowledge

### The Scale Problem
- 178 company skills → ~171 agents = ~1 skill per agent (manageable)
- 408 domain skills → ~171 agents = ~2.4 domain skills per agent (complex)
- But domain skills are **not agent-specific** — they're **discipline-specific**

### The Reuse Problem
- `commercial-contract-drafting` is useful to DevForge's Dealmaker AND DomainForge's Procurement
- `safety-risk-assessment` is useful to DomainForge's Safety AND QualityForge's Guardian
- Hardcoding 1:1 creates duplication and maintenance nightmares

### The Context Problem
- Domain skills contain **procedural knowledge** (how to do things) not **agent capabilities** (what agents can do)
- An agent's SKILL.md defines "I am a contracts specialist who can draft contracts"
- A domain skill defines "Here is how to draft a contract under FIDIC conditions"

## Recommended Architecture: Three-Layer Skill System

### Layer 1: Agent Capability Skills (1:1 mapping)
**What it is**: Each agent's primary SKILL.md that defines their role and capabilities
**Where**: `skills/{company}/{agent-name}/SKILL.md`
**Example**: `skills/devforge-ai/dealmaker-devforge-sales-negotiation/SKILL.md`
**Purpose**: Tells the agent WHO they are and WHAT they do

### Layer 2: Shared Process Skills (many-to-many)
**What it is**: Cross-cutting capabilities any agent can load
**Where**: `skills/shared/{process-name}/SKILL.md`
**Example**: `skills/shared/cross-team-collaboration/SKILL.md`
**Purpose**: Tells agents HOW to work together

### Layer 3: Domain Knowledge Skills (on-demand reference)
**What it is**: Discipline-specific procedural knowledge
**Where**: `skills/construct-ai/{discipline-code}/{skill-name}/SKILL.md`
**Example**: `skills/construct-ai/00250-commercial/commercial-contract-drafting/SKILL.md`
**Purpose**: Gives agents the DOMAIN KNOWLEDGE to do their job well

## How Domain Skills Should Be Used

### Option A: Agent Profile Mapping (Recommended)
Each agent's configuration includes a `domain_skills` array listing which domain skills they should load:

```json
{
  "agent": {
    "name": "Dealmaker",
    "company": "DevForge AI",
    "role": "Sales and Negotiation",
    "core_skill": "/skills/devforge-ai/dealmaker-devforge-sales-negotiation/SKILL.md",
    "domain_skills": [
      "/skills/construct-ai/00250-commercial/commercial-negotiation-strategy/SKILL.md",
      "/skills/construct-ai/00250-commercial/commercial-contract-drafting/SKILL.md",
      "/skills/construct-ai/00400_contracts/contracts-fidic-nec-jct-interpretation/SKILL.md",
      "/skills/construct-ai/01900_procurement/procurement-contract-negotiation/SKILL.md"
    ],
    "shared_skills": [
      "/skills/shared/cross-team-collaboration/SKILL.md",
      "/skills/shared/executing-plans/SKILL.md"
    ]
  }
}
```

### Option B: Task-Based Loading
Domain skills are loaded dynamically based on task context:
- Task involves "contract drafting" → load `commercial-contract-drafting`
- Task involves "safety inspection" → load `safety-hazard-identification`
- Task involves "procurement" → load `procurement-bid-evaluation`

### Option C: Discipline-Based Assignment
Agents are assigned entire discipline skill sets:
- Commercial agents get all 00250-commercial skills
- Construction agents get all 00300_construction skills
- Safety agents get all 02400_safety skills

## Recommended: Hybrid Approach

### Step 1: Map Disciplines to Companies
| Discipline Code | Discipline | Primary Company | Secondary Companies |
|----------------|------------|-----------------|-------------------|
| 00250 | Commercial | DevForge AI | DomainForge AI |
| 00300 | Construction | DomainForge AI | QualityForge AI |
| 00400 | Contracts | DomainForge AI | DevForge AI |
| 00425 | Contracts Pre-Award | DomainForge AI | DevForge AI |
| 00435 | Contracts Post-Award | DomainForge AI | DevForge AI |
| 00800 | Design | DomainForge AI | — |
| 00825 | Architectural | DomainForge AI | — |
| 00835 | Chemical Engineering | DomainForge AI | — |
| 00850 | Civil Engineering | DomainForge AI | — |
| 00855 | Geotechnical | DomainForge AI | — |
| 00860 | Electrical Engineering | DomainForge AI | — |
| 00870 | Mechanical Engineering | DomainForge AI | — |
| 00871 | Process Engineering | DomainForge AI | — |
| 00872 | Developer | DevForge AI | InfraForge AI |
| 00875 | Sales | DevForge AI | — |
| 00876-00895 | Directors | All companies | — |
| 00900 | Document Control | All companies | — |
| 01000 | Environmental | DomainForge AI | — |
| 01100 | Ethics | All companies | — |
| 01200 | Finance | DevForge AI | DomainForge AI |
| 01300 | Governance | All companies | — |
| 01400 | Health | DomainForge AI | — |
| 01600 | Local Content | DomainForge AI | — |
| 01700 | Logistics | DomainForge AI | InfraForge AI |
| 01750 | Legal | DomainForge AI | — |
| 01850 | Other Parties | All companies | — |
| 01900 | Procurement | DomainForge AI | DevForge AI |
| 02000 | Project Controls | DomainForge AI | — |
| 02025 | Quantity Surveying | DomainForge AI | — |
| 02035 | Scheduling | DomainForge AI | — |
| 02050 | Information Technology | DevForge AI | InfraForge AI |
| 02075 | Inspection | DomainForge AI | QualityForge AI |
| 02100 | Public Relations | DevForge AI | — |
| 02200 | Quality Assurance | QualityForge AI | DomainForge AI |
| 02250 | Quality Control | QualityForge AI | DomainForge AI |
| 02400 | Safety | DomainForge AI | QualityForge AI |
| 02500 | Security | DevForge AI | — |
| 03000 | Landscaping | DomainForge AI | — |

### Step 2: Create Agent-Domain Skill Mapping Files
For each company, create a mapping file that specifies which domain skills each agent should load.

### Step 3: Register Domain Skills in Supabase
Add domain skills to `company_skills` table with `source_type = 'domain_knowledge'` and appropriate `company_id`.

### Step 4: Update Agent Configuration
Update each agent's `capabilities` or `adapterConfig` to reference their domain skills.

## Domain Skills by Company Assignment

### DevForge AI Domain Skills (108 skills)
- 00250-commercial (25) — Commercial expertise for sales/negotiation agents
- 00872_developer (4) — Developer skills for engineering agents
- 00875_sales (9) — Sales skills for growth agents
- 00876_directors (3) — Director oversight skills
- 00880_board-of-directors (2) — Board governance
- 00887_sales-director (3) — Sales director skills
- 00888_procurement-director (3) — Procurement director skills
- 00889_finance-director (3) — Finance director skills
- 00890_projects-director (3) — Projects director skills
- 00895_director-project (3) — Project director skills
- 01200_finance (10) — Finance skills for ledger/ledgerai
- 01300_governance (16) — Governance skills for council/strategos
- 01750_legal (8) — Legal skills for auditor/guardian
- 01850_other-parties (5) — Stakeholder management
- 01900_procurement (11) — Procurement skills for dealmaker/merchant
- 02050_information-technology (11) — IT skills for devcore/codesmith
- 02100_public-relations (6) — PR skills for ambassador/amplifier
- 02500_security (5) — Security skills for guardian/watchtower

### DomainForge AI Domain Skills (189 skills)
- 00300_construction (15) — Construction skills for construction agent
- 00400_contracts (11) — Contracts skills for contract-administration
- 00425_contracts-pre-award (16) — Pre-award skills for procurement
- 00435_contracts-post-award (10) — Post-award skills for procurement
- 00800_design (10) — Design skills for civil/structural agents
- 00825_architectural (10) — Architectural skills
- 00835_chemical-engineering (9) — Chemical engineering skills
- 00850_civil-engineering (11) — Civil engineering skills
- 00855_geotechnical-engineering (9) — Geotechnical skills
- 00860_electrical-engineering (10) — Electrical engineering skills
- 00870_mechanical-engineering (9) — Mechanical engineering skills
- 00871_process-engineering (3) — Process engineering skills
- 00882_construction-director (1) — Construction director
- 00883_contracts-director (1) — Contracts director
- 00884_engineering-director (1) — Engineering director
- 00885_hse-director (8) — HSE director skills
- 00886_logistics-director (1) — Logistics director
- 00900-document-control (1) — Document control
- 01000_environmental (1) — Environmental skills
- 01100_ethics (8) — Ethics skills
- 01400_health (6) — Health skills
- 01600_local-content (6) — Local content skills
- 01700_logistics (7) — Logistics skills
- 02000_project-controls (9) — Project controls skills
- 02025_quantity-surveying (7) — Quantity surveying skills
- 02035_scheduling (6) — Scheduling skills
- 02075_inspection (6) — Inspection skills
- 02200_quality-assurance (6) — QA skills
- 02250_quality-control (6) — QC skills
- 02400_safety (13) — Safety skills
- 03000_landscaping (7) — Landscaping skills

### InfraForge AI Domain Skills (22 skills)
- 02050_information-technology (11) — IT skills for database/mobile-api agents
- 01700_logistics (7) — Logistics skills for supply-chain-integration
- 01900_procurement (4) — Procurement skills for supply-chain

### Loopy AI Domain Skills (6 skills)
- 02100_public-relations (6) — PR skills for content/marketing agents

### PromptForge AI Domain Skills (16 skills)
- 01300_governance (16) — Governance skills for compliance/ethics agents

### QualityForge AI Domain Skills (67 skills)
- 00300_construction (5) — Construction quality skills
- 02075_inspection (6) — Inspection skills
- 02200_quality-assurance (6) — QA skills
- 02250_quality-control (6) — QC skills
- 02400_safety (13) — Safety skills
- 00400_contracts (5) — Contract quality skills
- 00435_contracts-post-award (4) — Post-award quality
- 01900_procurement (7) — Procurement quality
- 02000_project-controls (8) — Project controls quality
- 00850_civil-engineering (3) — Civil QA skills
- 00870_mechanical-engineering (4) — Mechanical QA skills

## Implementation Steps

### Phase 1: Register Domain Skills in Supabase
Generate SQL to insert all 408 domain skills into `company_skills` table with appropriate `company_id` based on the mapping above.

### Phase 2: Create Agent-Domain Mapping Files
Create per-company mapping files:
- `DEVFORGE_AGENT_DOMAIN_SKILLS.md`
- `DOMAINFORGE_AGENT_DOMAIN_SKILLS.md`
- `INFRAFORGE_AGENT_DOMAIN_SKILLS.md`
- `LOOPY_AGENT_DOMAIN_SKILLS.md`
- `PROMPTFORGE_AGENT_DOMAIN_SKILLS.md`
- `QUALITYFORGE_AGENT_DOMAIN_SKILLS.md`

### Phase 3: Update Agent Configuration
Update each agent's configuration to reference their domain skills.

### Phase 4: Test Domain Skill Loading
Verify agents can load and use their assigned domain skills.

## Related Documents

- [SKILL_REGISTRY.md](./SKILL_REGISTRY.md) — Master skill registry
- [ALL_COMPANY_SKILLS.sql](./ALL_COMPANY_SKILLS.sql) — Company skills SQL
- [OpenClaw_Teams_Cross_Reference.md](../../agents/openclaw-teams/OpenClaw_Teams_Cross_Reference.md) — Agent roster