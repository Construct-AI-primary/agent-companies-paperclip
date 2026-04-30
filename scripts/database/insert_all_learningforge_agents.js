#!/usr/bin/env node
// Insert all Learning Forge AI agents from documentation into Paperclip via API
// This reads agent definitions from docs-paperclip/companies/learningforge-ai/agents/
// Run with: BOARD_TOKEN=your_token node scripts/database/insert_all_learningforge_agents.js

const fs = require('fs');
const path = require('path');

const API_URL = process.env.PAPERCLIP_API_URL || "http://localhost:3100";
const BOARD_TOKEN = process.env.BOARD_TOKEN;
const COMPANY_ID = "2bda2da6-dfa7-4709-b5d1-ea865f14072a";
const AGENTS_DIR = path.join(__dirname, '../../docs-paperclip/companies/learningforge-ai/agents');

if (!BOARD_TOKEN) {
  console.error("Error: BOARD_TOKEN environment variable required");
  console.log("Usage: BOARD_TOKEN=your_token node scripts/database/insert_all_learningforge_agents.js");
  process.exit(1);
}

// Parse YAML frontmatter from AGENTS.md file
function parseAgentFile(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    
    // Extract YAML frontmatter
    const yamlMatch = content.match(/^---\n([\s\S]*?)\n---/);
    if (!yamlMatch) {
      console.warn(`No YAML frontmatter found in ${filePath}`);
      return null;
    }

    const yaml = yamlMatch[1];
    const agent = {};

    // Parse YAML fields
    const nameMatch = yaml.match(/name:\s*["']?([^"'\n]+)["']?/);
    const roleMatch = yaml.match(/role:\s*["']?([^"'\n]+)["']?/);
    const titleMatch = yaml.match(/title:\s*["']?([^"'\n]+)["']?/);
    const capabilitiesMatch = yaml.match(/capabilities:\s*["']?([^"'\n]+)["']?/);

    if (nameMatch) agent.name = nameMatch[1].trim();
    if (roleMatch) agent.role = roleMatch[1].trim();
    if (titleMatch) agent.title = titleMatch[1].trim();
    if (capabilitiesMatch) agent.capabilities = capabilitiesMatch[1].trim();

    // Validate required fields
    if (!agent.name) {
      console.warn(`Missing name in ${filePath}`);
      return null;
    }

    // Set defaults
    if (!agent.role) agent.role = 'engineer';
    if (!agent.title) agent.title = agent.name;
    if (!agent.capabilities) agent.capabilities = 'Learning and knowledge management specialist';

    return agent;
  } catch (error) {
    console.error(`Error reading ${filePath}:`, error.message);
    return null;
  }
}

// Get all agent definitions
function getAllAgents() {
  const agents = [];
  
  try {
    const agentDirs = fs.readdirSync(AGENTS_DIR);
    
    for (const dir of agentDirs) {
      const agentPath = path.join(AGENTS_DIR, dir);
      const stats = fs.statSync(agentPath);
      
      if (stats.isDirectory()) {
        const agentFile = path.join(agentPath, 'AGENTS.md');
        if (fs.existsSync(agentFile)) {
          const agent = parseAgentFile(agentFile);
          if (agent) {
            agents.push(agent);
          }
        }
      }
    }
  } catch (error) {
    console.error("Error reading agents directory:", error.message);
    process.exit(1);
  }

  return agents;
}

// Insert agent via API
async function insertAgent(agent) {
  try {
    const response = await fetch(`${API_URL}/api/companies/${COMPANY_ID}/agents`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${BOARD_TOKEN}`
      },
      body: JSON.stringify({
        name: agent.name,
        role: agent.role,
        title: agent.title,
        capabilities: agent.capabilities,
        status: "active"
      })
    });

    if (!response.ok) {
      const error = await response.text();
      console.error(`❌ Failed to create ${agent.name}: ${response.status} - ${error}`);
      return false;
    }

    const created = await response.json();
    console.log(`✅ Created: ${agent.name} (${agent.role})`);
    return true;
  } catch (error) {
    console.error(`❌ Error creating ${agent.name}:`, error.message);
    return false;
  }
}

// Main execution
async function main() {
  console.log("Learning Forge AI - Agent Insertion Script");
  console.log("=" .repeat(60));
  console.log(`Company ID: ${COMPANY_ID}`);
  console.log(`Agents Directory: ${AGENTS_DIR}`);
  console.log();

  const agents = getAllAgents();
  console.log(`Found ${agents.length} agent definitions`);
  console.log();

  if (agents.length === 0) {
    console.error("No agents found to insert!");
    process.exit(1);
  }

  // Group by role for display
  const byRole = {};
  agents.forEach(agent => {
    const role = agent.role || 'unknown';
    if (!byRole[role]) byRole[role] = [];
    byRole[role].push(agent.name);
  });

  console.log("Agents to be created:");
  Object.keys(byRole).sort().forEach(role => {
    console.log(`  ${role}: ${byRole[role].length} agents`);
  });
  console.log();

  let successCount = 0;
  let failCount = 0;

  console.log("Inserting agents...");
  console.log();

  for (const agent of agents) {
    const success = await insertAgent(agent);
    if (success) {
      successCount++;
    } else {
      failCount++;
    }
    // Small delay to avoid overwhelming the API
    await new Promise(resolve => setTimeout(resolve, 100));
  }

  console.log();
  console.log("=" .repeat(60));
  console.log(`✅ Successfully created: ${successCount} agents`);
  if (failCount > 0) {
    console.log(`❌ Failed to create: ${failCount} agents`);
  }
  console.log("=" .repeat(60));
  console.log();
  console.log("Run verification script:");
  console.log(`BOARD_TOKEN=${BOARD_TOKEN} node scripts/database/verify_learningforge_setup.js`);
}

main();
