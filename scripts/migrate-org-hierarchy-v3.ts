/**
 * Migration script v3: Final org hierarchy for all teams
 * Fixes: all PromptForge agents report to someone (none standalone),
 *        duplicate agent names handled correctly
 */

import * as fs from "fs";
import * as path from "path";
import { fileURLToPath } from "url";

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

interface AgentConfig {
  agent_id: string;
  name: string;
  division: string;
  authority_level: string;
  integration?: { reports_to?: string };
}

interface TeamConfig {
  team_name: string;
  divisions: Record<string, { name: string; agents: AgentConfig[] }>;
}

// PromptForge agents - ALL report to Sage (CEO) or their managers
const PROMPTFORGE_AGENTS: { name: string; division: string; authority_level: string; reportsTo: string | null }[] = [
  // Executive roots
  { name: "Sage", division: "executive", authority_level: "ceo", reportsTo: null },
  { name: "Clarity", division: "executive", authority_level: "senior", reportsTo: "Sage" },
  { name: "Harmonic", division: "executive", authority_level: "executive", reportsTo: "Sage" },
  { name: "Integrity", division: "executive", authority_level: "executive", reportsTo: "Sage" },
  // Architecture division - report to Sage
  { name: "Blueprint", division: "architecture", authority_level: "senior", reportsTo: "Sage" },
  { name: "FlowDesigner", division: "architecture", authority_level: "senior", reportsTo: "Sage" },
  { name: "Cascade", division: "architecture", authority_level: "standard", reportsTo: "Sage" },
  { name: "StateMaster", division: "architecture", authority_level: "standard", reportsTo: "Sage" },
  { name: "ErrorHandler", division: "architecture", authority_level: "standard", reportsTo: "Sage" },
  // Testing division - report to Sage
  { name: "Integration", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Probe", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Simulator", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Predictor", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "LoadTester", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Compatibility", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Benchmarker", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "SafetyCheck", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  // Optimization division - report to Clarity
  { name: "Tuner", division: "optimization", authority_level: "senior", reportsTo: "Clarity" },
  { name: "Analyzer", division: "optimization", authority_level: "senior", reportsTo: "Clarity" },
  { name: "Refiner", division: "optimization", authority_level: "standard", reportsTo: "Sage" },
  { name: "Specialist", division: "optimization", authority_level: "standard", reportsTo: "Sage" },
  // Research division - report to Sage
  { name: "Enhancer", division: "research", authority_level: "senior", reportsTo: "Sage" },
  { name: "Experimenter", division: "research", authority_level: "senior", reportsTo: "Sage" },
  { name: "Quantifier", division: "research", authority_level: "senior", reportsTo: "Sage" },
  { name: "Explorer", division: "research", authority_level: "senior", reportsTo: "Sage" },
  { name: "Scholar", division: "research", authority_level: "standard", reportsTo: "Sage" },
  { name: "Collaborator", division: "research", authority_level: "standard", reportsTo: "Sage" },
  // Quality division - report to Integrity
  { name: "Validator", division: "quality", authority_level: "senior", reportsTo: "Integrity" },
  { name: "Compliance", division: "quality", authority_level: "standard", reportsTo: "Sage" },
];

function loadAgentConfigs(): TeamConfig[] {
  const configs: TeamConfig[] = [];
  for (const file of AGENT_FILES) {
    const filePath = path.join(CONFIG_DIR, file);
    try {
      const content = fs.readFileSync(filePath, "utf-8");
      const parsed = JSON.parse(content);
      configs.push({ team_name: parsed.team_name, divisions: parsed.divisions });
    } catch (error) {
      console.warn(`Warning: Could not load ${file}: ${error}`);
    }
  }
  return configs;
}

function flattenAgents(configs: TeamConfig[]): AgentConfig[] {
  const agents: AgentConfig[] = [];
  for (const config of configs) {
    for (const division of Object.values(config.divisions)) {
      agents.push(...division.agents);
    }
  }
  return agents;
}

function generateShortname(name: string): string {
  return name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "").slice(0, 64);
}

function escapeRegex(str: string): string {
  return str.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function generateMigrationSql(
  agents: AgentConfig[],
  promptforgeAgents: typeof PROMPTFORGE_AGENTS,
): string {
  const lines: string[] = [];
  const agentByAgentId = new Map<string, AgentConfig>();
  for (const agent of agents) agentByAgentId.set(agent.agent_id, agent);

  const shortnameById = new Map<string, string>();
  for (const agent of agents) shortnameById.set(agent.agent_id, generateShortname(agent.name));

  lines.push("-- Org hierarchy migration v3 (FINAL)");
  lines.push("-- Covers: DomainForge, DeepForge, QualityForge, DevForge, InfraForge, Loopy, PromptForge");
  lines.push("-- All agents have proper reports_to links");
  lines.push("BEGIN;");
  lines.push("");

  // Pass 1: adapterConfig updates for JSON config agents
  lines.push("-- 1. Update adapterConfig with authority_level and division (JSON config agents)");
  for (const agent of agents) {
    const shortname = shortnameById.get(agent.agent_id);
    if (!shortname) continue;
    const authorityLevel = agent.authority_level || "standard";
    const division = agent.division || "general";
    lines.push(`UPDATE agents SET adapter_config = CASE`);
    lines.push(`  WHEN adapter_config IS NULL THEN '{"authority_level":"${authorityLevel}","division":"${division}"}'::jsonb`);
    lines.push(`  ELSE jsonb_set(jsonb_set(adapter_config::jsonb, '{authority_level}', '"${authorityLevel}"'::jsonb), '{division}', '"${division}"'::jsonb)`);
    lines.push(`END`);
    lines.push(`WHERE LOWER(REPLACE(name, ' ', '-')) ~* '${escapeRegex(shortname)}' OR name ILIKE '${escapeRegex(agent.name)}';`);
    lines.push("");
  }

  // Pass 2: reports_to for JSON config agents
  const allAgentIds = new Set(agents.map((a) => a.agent_id));
  lines.push("-- 2. Update reports_to (JSON config agents)");
  for (const agent of agents) {
    const shortname = shortnameById.get(agent.agent_id);
    if (!shortname) continue;
    const reportsTo = agent.integration?.reports_to ?? null;
    if (reportsTo && allAgentIds.has(reportsTo)) {
      const mgrShortname = shortnameById.get(reportsTo);
      if (mgrShortname) {
        const mgrConfig = agentByAgentId.get(reportsTo);
        lines.push(`UPDATE agents SET reports_to = (SELECT id FROM agents AS mgr WHERE LOWER(REPLACE(mgr.name, ' ', '-')) ~* '${escapeRegex(mgrShortname)}' OR mgr.name ILIKE '${escapeRegex(mgrConfig?.name ?? "")}' LIMIT 1)`);
        lines.push(`WHERE LOWER(REPLACE(name, ' ', '-')) ~* '${escapeRegex(shortname)}' OR name ILIKE '${escapeRegex(agent.name)}';`);
        lines.push("");
      }
    }
  }

  // Pass 3: PromptForge - adapterConfig
  lines.push("-- 3. PromptForge adapterConfig updates");
  for (const agent of promptforgeAgents) {
    const shortname = generateShortname(agent.name);
    const authorityLevel = agent.authority_level || "standard";
    const division = agent.division || "general";
    lines.push(`UPDATE agents SET adapter_config = CASE`);
    lines.push(`  WHEN adapter_config IS NULL THEN '{"authority_level":"${authorityLevel}","division":"${division}"}'::jsonb`);
    lines.push(`  ELSE jsonb_set(jsonb_set(adapter_config::jsonb, '{authority_level}', '"${authorityLevel}"'::jsonb), '{division}', '"${division}"'::jsonb)`);
    lines.push(`END`);
    lines.push(`WHERE name ILIKE '${escapeRegex(agent.name)}';`);
    lines.push("");
  }

  // Pass 4: PromptForge - reports_to
  lines.push("-- 4. PromptForge reports_to");
  for (const agent of promptforgeAgents) {
    if (agent.reportsTo) {
      lines.push(`UPDATE agents SET reports_to = (SELECT id FROM agents AS mgr WHERE name ILIKE '${escapeRegex(agent.reportsTo)}' LIMIT 1)`);
      lines.push(`WHERE name ILIKE '${escapeRegex(agent.name)}';`);
      lines.push("");
    }
  }

  lines.push("COMMIT;");
  lines.push("-- Done");
  return lines.join("\n");
}

function main() {
  const configs = loadAgentConfigs();
  const agents = flattenAgents(configs);
  console.log(`Agents from JSON configs: ${agents.length}`);
  console.log(`PromptForge agents: ${PROMPTFORGE_AGENTS.length}`);
  const linked = PROMPTFORGE_AGENTS.filter(a => a.reportsTo).length;
  const standalone = PROMPTFORGE_AGENTS.filter(a => !a.reportsTo).length;
  console.log(`  → ${linked} report to someone, ${standalone} root(s): ${PROMPTFORGE_AGENTS.filter(a => !a.reportsTo).map(a => a.name).join(", ")}`);

  const sql = generateMigrationSql(agents, PROMPTFORGE_AGENTS);
  const outputPath = path.resolve(__dirname, "../tmp/org-hierarchy-migration-v3.sql");
  if (!fs.existsSync(path.dirname(outputPath))) fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  fs.writeFileSync(outputPath, sql);
  console.log(`\nSQL written to: ${outputPath}`);
  console.log("Apply via Supabase SQL Editor or psql.");
}

main();