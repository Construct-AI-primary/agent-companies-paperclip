---
schema: knowledge-registry/v1
last_rebuilt: 2026-04-28T12:00:00Z
version: 1
maintainer: knowledge-curator-domainforge
---

# DomainForge AI Knowledge Registry

This registry maps sector and organisation knowledge sources to DomainForge AI discipline agents. It is maintained by the `knowledge-curator-domainforge` agent and rebuilt on-demand when knowledge files are added or updated.

## Sector → Discipline Knowledge

| sector_id | discipline | knowledge_file |
|-----------|-----------|----------------|
| 00001-solar-installations | electrical | ../../disciplines-sector-specific-details/00001-solar-installations/knowledge/electrical-solar-knowledge.md |
| 00001-solar-installations | civil | ../../disciplines-sector-specific-details/00001-solar-installations/knowledge/civil-geotechnical-solar-knowledge.md |
| 00001-solar-installations | architectural | ../../disciplines-sector-specific-details/00001-solar-installations/knowledge/architectural-solar-knowledge.md |
| 00001-solar-installations | environmental | ../../disciplines-sector-specific-details/00001-solar-installations/knowledge/environmental-solar-knowledge.md |
| 00001-solar-installations | qaqc | ../../disciplines-sector-specific-details/00001-solar-installations/knowledge/qaqc-solar-knowledge.md |
| 00001-solar-installations | safety | ../../disciplines-sector-specific-details/00001-solar-installations/knowledge/safety-solar-knowledge.md |
| 00001-solar-installations | security | ../../disciplines-sector-specific-details/00001-solar-installations/knowledge/security-solar-knowledge.md |
| 00002-traffic-signals | electrical | ../../disciplines-sector-specific-details/00002-traffic-signals/knowledge/electrical-traffic-knowledge.md |
| 00002-traffic-signals | civil | ../../disciplines-sector-specific-details/00002-traffic-signals/knowledge/civil-traffic-knowledge.md |
| 00002-traffic-signals | environmental | ../../disciplines-sector-specific-details/00002-traffic-signals/knowledge/environmental-traffic-knowledge.md |
| 00002-traffic-signals | its | ../../disciplines-sector-specific-details/00002-traffic-signals/knowledge/its-traffic-knowledge.md |
| 00002-traffic-signals | qaqc | ../../disciplines-sector-specific-details/00002-traffic-signals/knowledge/qaqc-traffic-knowledge.md |
| 00002-traffic-signals | safety | ../../disciplines-sector-specific-details/00002-traffic-signals/knowledge/safety-traffic-knowledge.md |
| 00002-traffic-signals | security | ../../disciplines-sector-specific-details/00002-traffic-signals/knowledge/security-traffic-knowledge.md |

## Organisation Knowledge

| org_slug | knowledge_category | knowledge_file |
|----------|-------------------|----------------|
| GPC | company-profile | ../../organisation-knowledge/GPC/knowledge/industry-context/company-profile.md |
| GPC | competitor-analysis | ../../organisation-knowledge/GPC/knowledge/industry-context/competitor-analysis.md |
| GPC | market-analysis | ../../organisation-knowledge/GPC/knowledge/industry-context/market-analysis.md |
| GPC | core-workflows | ../../organisation-knowledge/GPC/knowledge/workflows/core-workflows.md |
| GPC | ai-agents-suitability | ../../organisation-knowledge/GPC/knowledge/workflows/ai-agents-suitability.md |
| zama | company-profile | ../../organisation-knowledge/zama/knowledge/industry-context/company-profile.md |
| zama | competitor-analysis | ../../organisation-knowledge/zama/knowledge/industry-context/competitor-analysis.md |
| zama | market-analysis | ../../organisation-knowledge/zama/knowledge/industry-context/market-analysis.md |
| zama | core-workflows | ../../organisation-knowledge/zama/knowledge/workflows/core-workflows.md |
| zama | ai-agents-suitability | ../../organisation-knowledge/zama/knowledge/workflows/ai-agents-suitability.md |

## Registry Build Procedure

### When to Rebuild
- A new sector-specific knowledge file is added to `disciplines-sector-specific-details/*/knowledge/`
- A new organisation knowledge file is added to `organisation-knowledge/*/knowledge/`
- An existing knowledge file is updated with significant structural changes
- A new organisation is added to `organisation-knowledge/`

### How to Rebuild
1. The `knowledge-curator-domainforge` agent scans both directories
2. For each `{discipline}-*-knowledge.md` file found, adds a row to the sector table
3. For each file in `organisation-knowledge/*/knowledge/`, adds a row to the org table
4. Validates all file paths resolve correctly
5. Updates `last_rebuilt` timestamp
6. Commits the updated registry

### Agent Resolution Protocol
When a DomainForge discipline agent receives an issue with `sector_ref` and/or `org_ref` in frontmatter:
1. Read `sector_ref` → look up matching rows in sector table for the agent's discipline
2. Read `org_ref` → look up matching rows in organisation table
3. Resolve relative paths from this registry's location
4. Load all matched knowledge files into working context
5. Proceed with task execution