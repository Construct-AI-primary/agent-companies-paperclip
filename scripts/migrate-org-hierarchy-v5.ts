/**
 * Migration v5: Include QualityForge (all report_to were null in DB, need links added)
 */

import * as fs from "fs";
import * as path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const CONFIG_DIR = path.resolve(__dirname, "../src/config");
// Include ALL teams — QualityForge needs hierarchy added too (all had reports_to: null)
const AGENT_FILES = [
  "agents-domainforge.json",
  "agents-deepforge.json",
  "agents-qualityforge.json",
  "agents-devforge.json",
  "agents-infraforge.json",
  "agents-loopy.json",
];

const PROMPTFORGE_COMPANY_ID = "f02b83a8-e0db-4332-b507-22f85e71ebf5";

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

// QualityForge agents — Apex = CEO, Governor/Guardian report to Apex, all others to Apex
// Based on CSV dump showing all had reports_to: null
const QUALITYFORGE_AGENTS: { name: string; division: string; authority_level: string; reportsTo: string | null }[] = [
  { name: "Apex", division: "executive", authority_level: "ceo", reportsTo: null },
  { name: "Governor", division: "executive", authority_level: "executive", reportsTo: "Apex" },
  { name: "Guardian", division: "executive", authority_level: "executive", reportsTo: "Apex" },
  // Testing
  { name: "Unittest", division: "testing", authority_level: "standard", reportsTo: "Apex" },
  { name: "Integration", division: "testing", authority_level: "standard", reportsTo: "Apex" },
  { name: "E2e", division: "testing", authority_level: "standard", reportsTo: "Apex" },
  { name: "Performance", division: "testing", authority_level: "standard", reportsTo: "Apex" },
  { name: "SecurityTest", division: "testing", authority_level: "senior", reportsTo: "Apex" },
  { name: "Accessibility", division: "testing", authority_level: "standard", reportsTo: "Apex" },
  { name: "Compatibility", division: "testing", authority_level: "standard", reportsTo: "Apex" },
  { name: "Load", division: "testing", authority_level: "standard", reportsTo: "Apex" },
  { name: "Automation", division: "testing", authority_level: "senior", reportsTo: "Apex" },
  { name: "Coverage", division: "testing", authority_level: "standard", reportsTo: "Apex" },
  // Debugging
  { name: "Diagnostics", division: "debugging", authority_level: "senior", reportsTo: "Apex" },
  { name: "Tracer", division: "debugging", authority_level: "standard", reportsTo: "Apex" },
  { name: "Fixer", division: "debugging", authority_level: "standard", reportsTo: "Apex" },
  { name: "Analyzer", division: "debugging", authority_level: "senior", reportsTo: "Apex" },
  { name: "Profiler", division: "debugging", authority_level: "standard", reportsTo: "Apex" },
  { name: "Debugger", division: "debugging", authority_level: "standard", reportsTo: "Apex" },
  { name: "Inspector", division: "debugging", authority_level: "standard", reportsTo: "Apex" },
  { name: "Resolver", division: "debugging", authority_level: "senior", reportsTo: "Apex" },
  // Coding
  { name: "Codesmith", division: "coding", authority_level: "standard", reportsTo: "Apex" },
  { name: "Refactor", division: "coding", authority_level: "standard", reportsTo: "Apex" },
  { name: "Architect", division: "coding", authority_level: "senior", reportsTo: "Apex" },
  { name: "Optimizer", division: "coding", authority_level: "standard", reportsTo: "Apex" },
  { name: "Maintainer", division: "coding", authority_level: "standard", reportsTo: "Apex" },
  { name: "Integrator", division: "coding", authority_level: "standard", reportsTo: "Apex" },
  { name: "Reviewer", division: "coding", authority_level: "senior", reportsTo: "Apex" },
  { name: "Standards", division: "coding", authority_level: "senior", reportsTo: "Apex" },
  { name: "Documenter", division: "coding", authority_level: "standard", reportsTo: "Apex" },
  { name: "Migrator", division: "coding", authority_level: "standard", reportsTo: "Apex" },
  // Quality
  { name: "Auditor", division: "quality", authority_level: "senior", reportsTo: "Apex" },
  { name: "Validator", division: "quality", authority_level: "standard", reportsTo: "Apex" },
  { name: "Monitor", division: "quality", authority_level: "standard", reportsTo: "Apex" },
  { name: "Reporter", division: "quality", authority_level: "standard", reportsTo: "Apex" },
  { name: "Trainer", division: "quality", authority_level: "standard", reportsTo: "Apex" },
];

const PROMPTFORGE_AGENTS: { name: string; division: string; authority_level: string; reportsTo: string | null }[] = [
  { name: "Sage", division: "executive", authority_level: "ceo", reportsTo: null },
  { name: "Clarity", division: "executive", authority_level: "senior", reportsTo: "Sage" },
  { name: "Harmonic", division: "executive", authority_level: "executive", reportsTo: "Sage" },
  { name: "Integrity", division: "executive", authority_level: "executive", reportsTo: "Sage" },
  { name: "Blueprint", division: "architecture", authority_level: "senior", reportsTo: "Sage" },
  { name: "FlowDesigner", division: "architecture", authority_level: "senior", reportsTo: "Sage" },
  { name: "Cascade", division: "architecture", authority_level: "standard", reportsTo: "Sage" },
  { name: "StateMaster", division: "architecture", authority_level: "standard", reportsTo: "Sage" },
  { name: "ErrorHandler", division: "architecture", authority_level: "standard", reportsTo: "Sage" },
  { name: "Integration", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Probe", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Simulator", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Predictor", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "LoadTester", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Compatibility", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Benchmarker", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "SafetyCheck", division: "testing", authority_level: "standard", reportsTo: "Sage" },
  { name: "Tuner", division: "optimization", authority_level: "senior", reportsTo: "Clarity" },
  { name: "Analyzer", division: "optimization", authority_level: "senior", reportsTo: "Clarity" },
  { name: "Refiner", division: "optimization", authority_level: "standard", reportsTo: "Sage" },
  { name: "Specialist", division: "optimization", authority_level: "standard", reportsTo: "Sage" },
  { name: "Enhancer", division: "research", authority_level: "senior", reportsTo: "Sage" },
  { name: "Experimenter", division: "research", authority_level: "senior", reportsTo: "Sage" },
  { name: "Quantifier", division: "research", authority_level: "senior", reportsTo: "Sage" },
  { name: "Explorer", division: "research", authority_level: "senior", reportsTo: "Sage" },
  { name: "Scholar", division: "research", authority_level: "standard", reportsTo: "Sage" },
  { name: "Collaborator", division: "research", authority_level: "standard", reportsTo: "Sage" },
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

function generateCustomReportsToSql(
  agents: { name: string; division: string; authority_level: string; reportsTo: string | null }[],
  companyId: string,
  prefix: string
): string {
  const lines: string[] = [];
  lines.push(`-- ${prefix} adapterConfig updates`);
  for (const agent of agents) {
    const authorityLevel = agent.authority_level || "standard";
    const division = agent.division || "general";
    lines.push(`UPDATE agents SET adapter_config = CASE`);
    lines.push(`  WHEN adapter_config IS NULL THEN '{"authority_level":"${authorityLevel}","division":"${division}"}'::jsonb`);
    lines.push(`  ELSE jsonb_set(jsonb_set(adapter_config::jsonb, '{authority_level}', '"${authorityLevel}"'::jsonb), '{division}', '"${division}"'::jsonb)`);
    lines.push(`END`);
    lines.push(`WHERE company_id = '${companyId}' AND name ILIKE '${escapeRegex(agent.name)}';`);
    lines.push("");
  }
  lines.push(`-- ${prefix} reports_to`);
  for (const agent of agents) {
    if (agent.reportsTo) {
      lines.push(`UPDATE agents SET reports_to = (SELECT id FROM agents AS mgr WHERE name ILIKE '${escapeRegex(agent.reportsTo)}' LIMIT 1)`);
      lines.push(`WHERE company_id = '${companyId}' AND name ILIKE '${escapeRegex(agent.name)}';`);
      lines.push("");
    }
  }
  return lines.join("\n");
}

function generateMigrationSql(
  agents: AgentConfig[],
): string {
  const lines: string[] = [];
  const agentByAgentId = new Map<string, AgentConfig>();
  for (const agent of agents) agentByAgentId.set(agent.agent_id, agent);

  const shortnameById = new Map<string, string>();
  for (const agent of agents) shortnameById.set(agent.agent_id, generateShortname(agent.name));

  lines.push("-- Org hierarchy migration v5");
  lines.push("-- Covers: DomainForge, DeepForge, QualityForge, DevForge, InfraForge, Loopy, PromptForge");
  lines.push("-- All agents now have proper reports_to links");
  lines.push("BEGIN;");
  lines.push("");

  // Pass 1: adapterConfig for JSON config agents
  lines.push("-- 1. Update adapterConfig (JSON config agents)");
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

  // Pass 3: QualityForge (custom hierarchy — all reports_to was null in DB)
  lines.push(generateCustomReportsToSql(QUALITYFORGE_AGENTS, "f535f9bc-00be-4b6d-9f53-c53abfacacef", "QualityForge"));

  // Pass 4: PromptForge (scoped to company_id)
  lines.push(generateCustomReportsToSql(PROMPTFORGE_AGENTS, PROMPTFORGE_COMPANY_ID, "PromptForge"));

  lines.push("COMMIT;");
  lines.push("-- Done");
  return lines.join("\n");
}

function main() {
  const configs = loadAgentConfigs();
  const agents = flattenAgents(configs);
  console.log(`Agents from JSON configs (incl QualityForge): ${agents.length}`);
  console.log(`QualityForge custom agents: ${QUALITYFORGE_AGENTS.length}`);
  console.log(`PromptForge agents: ${PROMPTFORGE_AGENTS.length}`);

  const sql = generateMigrationSql(agents);
  const outputPath = path.resolve(__dirname, "../tmp/org-hierarchy-migration-v5.sql");
  if (!fs.existsSync(path.dirname(outputPath))) fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  fs.writeFileSync(outputPath, sql);
  console.log(`\nSQL written to: ${outputPath}`);
  console.log("Apply via Supabase SQL Editor or psql.");
}

main();