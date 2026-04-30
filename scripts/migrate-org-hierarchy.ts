/**
 * Migration script to update agent hierarchy from JSON config files.
 * 
 * This script reads agent configurations from src/config/agents-*.json files
 * and updates the database with proper:
 * - reportsTo: Links agents to their managers using the integration.reports_to field
 * - adapterConfig.authority_level: For proper org chart ordering
 * - adapterConfig.division: For secondary grouping in org chart
 * 
 * Usage:
 *   npx tsx scripts/migrate-org-hierarchy.ts
 * 
 * Environment:
 *   DATABASE_URL - PostgreSQL connection string (optional, uses embedded PG if not set)
 *   COMPANY_NAME - Name of the company to update (default: current company)
 *   DRY_RUN - Set to "true" to preview changes without applying (default: false)
 */

import * as fs from "fs";
import * as path from "path";
import { fileURLToPath } from "url";
import { createHash } from "crypto";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const CONFIG_DIR = path.resolve(__dirname, "../src/config");
const AGENT_FILES = [
  "agents-domainforge.json",
  "agents-deepforge.json",
  "agents-qualityforge.json",
  "agents-devforge.json",
  "agents-infraforge.json",
  "agents-loopy.json",
];

// ── Role mapping to authority levels ──────────────────────────────────────
const AUTHORITY_FROM_ROLE: Record<string, string> = {
  ceo: "ceo",
  cto: "cto",
  cmo: "cmo",
  cfo: "cfo",
  coo: "coo",
  "chief executive": "ceo",
  "technology": "cto",
  "marketing": "cmo",
  "finance": "cfo",
  "operations": "coo",
  vp: "vp",
  manager: "manager",
  engineer: "engineer",
  agent: "agent",
};

// ── Authority level ranking (for sorting) ─────────────────────────────────
const AUTHORITY_RANK: Record<string, number> = {
  executive: 1,
  ceo: 1,
  cto: 2,
  cmo: 3,
  cfo: 4,
  coo: 5,
  vp: 6,
  senior: 7,
  manager: 8,
  engineer: 9,
  agent: 10,
  standard: 10,
};

// ── Division ranking (for sorting) ────────────────────────────────────────
const DIVISION_RANK: Record<string, number> = {
  executive: 1,
  "deep-learning": 2,
  engineering: 3,
  testing: 4,
  debugging: 5,
  coding: 6,
  quality: 7,
  infrastructure: 8,
  construction: 9,
  commercial: 10,
  contracts: 11,
  support: 12,
  operations: 13,
  creative: 14,
};

interface AgentConfig {
  agent_id: string;
  name: string;
  division: string;
  role: string;
  authority_level: string;
  integration?: {
    reports_to?: string;
    coordinates_with?: string[];
  };
}

interface TeamConfig {
  team: string;
  team_name: string;
  divisions: {
    [key: string]: {
      name: string;
      agents: AgentConfig[];
    };
  };
}

interface AgentShortnameMapping {
  agent_id: string;
  shortname: string;
  agent_name: string;
}

/**
 * Load all agent JSON config files
 */
function loadAgentConfigs(): TeamConfig[] {
  const configs: TeamConfig[] = [];
  for (const file of AGENT_FILES) {
    const filePath = path.join(CONFIG_DIR, file);
    try {
      const content = fs.readFileSync(filePath, "utf-8");
      configs.push(JSON.parse(content));
    } catch (error) {
      console.warn(`Warning: Could not load ${file}: ${error}`);
    }
  }
  return configs;
}

/**
 * Flatten all agents from team configs
 */
function flattenAgents(configs: TeamConfig[]): AgentConfig[] {
  const agents: AgentConfig[] = [];
  for (const config of configs) {
    for (const division of Object.values(config.divisions)) {
      agents.push(...division.agents);
    }
  }
  return agents;
}

/**
 * Generate a shortname from agent name (mimics normalizeAgentUrlKey)
 */
function generateShortname(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "")
    .slice(0, 64);
}

/**
 * Extract agent_id to shortname mapping from configs
 */
function buildAgentIdMapping(configs: TeamConfig[]): Map<string, AgentShortnameMapping> {
  const mapping = new Map<string, AgentShortnameMapping>();
  for (const config of configs) {
    for (const division of Object.values(config.divisions)) {
      for (const agent of division.agents) {
        const shortname = generateShortname(agent.name);
        mapping.set(agent.agent_id, {
          agent_id: agent.agent_id,
          shortname,
          agent_name: agent.name,
        });
      }
    }
  }
  return mapping;
}

/**
 * Build the hierarchy map: agent_id -> reports_to agent_id
 */
function buildHierarchyMap(agents: AgentConfig[]): Map<string, string | null> {
  const hierarchy = new Map<string, string | null>();
  const allAgentIds = new Set(agents.map((a) => a.agent_id));

  for (const agent of agents) {
    const reportsTo = agent.integration?.reports_to ?? null;
    if (reportsTo && allAgentIds.has(reportsTo)) {
      hierarchy.set(agent.agent_id, reportsTo);
    } else {
      hierarchy.set(agent.agent_id, null);
    }
  }

  return hierarchy;
}

/**
 * Generate SQL UPDATE statements for migrating agent hierarchy
 */
function generateMigrationSql(
  agents: AgentConfig[],
  idMapping: Map<string, AgentShortnameMapping>,
  hierarchy: Map<string, string | null>,
): string {
  const statements: string[] = [];
  const allAgentIds = new Set(agents.map((a) => a.agent_id));

  // Build shortname lookup
  const shortnameById = new Map<string, string>();
  for (const [agentId, mapping] of idMapping) {
    shortnameById.set(agentId, mapping.shortname);
  }

  // Build reverse lookup: agent_id -> agent config
  const agentByAgentId = new Map<string, AgentConfig>();
  for (const agent of agents) {
    agentByAgentId.set(agent.agent_id, agent);
  }

  statements.push("-- Begin org hierarchy migration");
  statements.push("BEGIN;");
  statements.push("");

  // First pass: update adapterConfig with authority_level and division
  statements.push("-- Update agent adapterConfig with authority_level and division");
  for (const agent of agents) {
    const shortname = shortnameById.get(agent.agent_id);
    if (!shortname) {
      console.warn(`Warning: No shortname mapping for ${agent.agent_id}`);
      continue;
    }

    const authorityLevel = agent.authority_level || "standard";
    const division = agent.division || "general";

    // Build adapterConfig JSON merge statement
    statements.push(`-- Agent: ${agent.name} (${shortname})`);
    statements.push(`UPDATE agents SET`);
    statements.push(`  adapter_config = CASE`);
    statements.push(`    WHEN adapter_config IS NULL THEN '{"authority_level":"${authorityLevel}","division":"${division}"}'::jsonb`);
    statements.push(`    ELSE jsonb_set(`);
    statements.push(`      jsonb_set(`);
    statements.push(`        adapter_config::jsonb,`);
    statements.push(`        '{authority_level}',`);
    statements.push(`        '"${authorityLevel}"'::jsonb`);
    statements.push(`      ),`);
    statements.push(`      '{division}',`);
    statements.push(`      '"${division}"'::jsonb`);
    statements.push(`    )`);
    statements.push(`  END`);
    statements.push(`WHERE`);
    statements.push(`  -- Match by shortname (url_key) extracted from agent name`);
    statements.push(`  LOWER(TRANSLATE(name, ' ', '-')) ~* '${shortname.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}'`);
    statements.push(`  OR name ILIKE '${agent.name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}';`);
    statements.push("");
  }

  // Second pass: update reportsTo based on hierarchy
  statements.push("-- Update reportsTo relationships");
  for (const agent of agents) {
    const reportsTo = hierarchy.get(agent.agent_id);
    const shortname = shortnameById.get(agent.agent_id);
    if (!shortname) {
      continue;
    }

    if (reportsTo) {
      const managerShortname = shortnameById.get(reportsTo);
      if (!managerShortname) {
        console.warn(`Warning: No shortname for manager ${reportsTo} of ${agent.agent_id}`);
        continue;
      }

      statements.push(`-- ${agent.name} reports to ${agentByAgentId.get(reportsTo)?.name}`);
      statements.push(`-- Match manager by shortname: ${managerShortname}`);
      statements.push(`UPDATE agents SET`);
      statements.push(`  reports_to = (`);
      statements.push(`    SELECT id FROM agents AS mgr`);
      statements.push(`    WHERE LOWER(TRANSLATE(mgr.name, ' ', '-')) ~* '${managerShortname.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}'`);
      statements.push(`       OR mgr.name ILIKE '${(agentByAgentId.get(reportsTo)?.name || "").replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}'`);
      statements.push(`    LIMIT 1`);
      statements.push(`  )`);
      statements.push(`WHERE`);
      statements.push(`  LOWER(TRANSLATE(name, ' ', '-')) ~* '${shortname.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}'`);
      statements.push(`  OR name ILIKE '${agent.name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}';`);
      statements.push("");
    }
  }

  statements.push("COMMIT;");
  statements.push("-- End org hierarchy migration");

  return statements.join("\n");
}

/**
 * Direct database update function (for use with DB client)
 */
async function applyMigration(opts?: { dryRun?: boolean; companyName?: string }) {
  const dryRun = opts?.dryRun ?? process.env.DRY_RUN === "true";
  const configs = loadAgentConfigs();
  const agents = flattenAgents(configs);
  const idMapping = buildAgentIdMapping(configs);
  const hierarchy = buildHierarchyMap(agents);

  console.log(`\n=== Org Hierarchy Migration ===`);
  console.log(`Config files: ${AGENT_FILES.length}`);
  console.log(`Total agents found: ${agents.length}`);
  console.log(`Teams: ${configs.map((c) => c.team_name).join(", ")}`);
  console.log(`Dry run: ${dryRun}\n`);

  // Print hierarchy summary
  console.log("--- Hierarchy Summary ---");
  for (const config of configs) {
    console.log(`\n[${config.team_name}]`);
    for (const [divKey, division] of Object.entries(config.divisions)) {
      console.log(`  Division: ${division.name}`);
      for (const agent of division.agents) {
        const reportsTo = agent.integration?.reports_to;
        const reportsToName = reportsTo
          ? configs.flatMap((c) => Object.values(c.divisions))
              .flatMap((d) => d.agents)
              .find((a) => a.agent_id === reportsTo)?.name ?? reportsTo
          : null;
        console.log(`    - ${agent.name} (${agent.authority_level})${reportsToName ? ` -> ${reportsToName}` : ""}`);
      }
    }
  }

  // Generate SQL
  const sql = generateMigrationSql(agents, idMapping, hierarchy);
  const outputPath = path.resolve(__dirname, "../tmp/org-hierarchy-migration.sql");

  if (!fs.existsSync(path.dirname(outputPath))) {
    fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  }

  fs.writeFileSync(outputPath, sql);
  console.log(`\n--- Migration SQL written to: ${outputPath}\n`);

  if (dryRun) {
    console.log("DRY RUN: Review the SQL file before applying.");
    console.log("To apply: Remove DRY_RUN=true or run the SQL directly against your database.");
  } else {
    console.log("To apply the migration:");
    console.log(`  1. Review: cat ${outputPath}`);
    console.log(`  2. Apply: psql "$DATABASE_URL" -f ${outputPath}`);
    console.log(`  3. Verify: Check org chart at /org-chart endpoint`);
  }
}

// Run if called directly
import { pathToFileURL } from "url";
const isMain = process.argv[1] && pathToFileURL(process.argv[1]).href === import.meta.url;
if (isMain) {
  applyMigration().catch(console.error);
}

export { loadAgentConfigs, flattenAgents, buildHierarchyMap, buildAgentIdMapping, generateMigrationSql, applyMigration };