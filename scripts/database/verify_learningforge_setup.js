// Verify Learning Forge AI company and agents via API
// Run with: node scripts/database/verify_learningforge_setup.js

const API_URL = process.env.PAPERCLIP_API_URL || "http://localhost:3100";
const BOARD_TOKEN = process.env.BOARD_TOKEN;

if (!BOARD_TOKEN) {
  console.error("Error: BOARD_TOKEN environment variable required");
  console.log("Get your board token from the Paperclip UI and run:");
  console.log("BOARD_TOKEN=your_token node scripts/database/verify_learningforge_setup.js");
  process.exit(1);
}

async function verifySetup() {
  try {
    // Get all companies
    const companiesResponse = await fetch(`${API_URL}/api/companies`, {
      headers: { "Authorization": `Bearer ${BOARD_TOKEN}` }
    });

    if (!companiesResponse.ok) {
      throw new Error(`Failed to fetch companies: ${companiesResponse.status}`);
    }

    const companies = await companiesResponse.json();
    const learningForge = companies.find(c => c.name === "Learning Forge AI");

    if (!learningForge) {
      console.error("❌ Learning Forge AI company not found!");
      process.exit(1);
    }

    console.log("✅ Learning Forge AI Company Found:");
    console.log(`   ID: ${learningForge.id}`);
    console.log(`   Name: ${learningForge.name}`);
    console.log(`   Status: ${learningForge.status}`);
    console.log(`   Issue Prefix: ${learningForge.issuePrefix}`);
    console.log(`   Brand Color: ${learningForge.brandColor || 'Not set'}`);
    console.log();

    // Get agents for this company
    const agentsResponse = await fetch(`${API_URL}/api/companies/${learningForge.id}/agents`, {
      headers: { "Authorization": `Bearer ${BOARD_TOKEN}` }
    });

    if (!agentsResponse.ok) {
      throw new Error(`Failed to fetch agents: ${agentsResponse.status}`);
    }

    const agents = await agentsResponse.json();
    
    console.log(`✅ Agents Count: ${agents.length}`);
    console.log();

    if (agents.length === 0) {
      console.log("⚠️  No agents found for Learning Forge AI");
      process.exit(0);
    }

    // Group agents by role
    const byRole = {};
    agents.forEach(agent => {
      const role = agent.role || 'unknown';
      if (!byRole[role]) byRole[role] = [];
      byRole[role].push(agent.name);
    });

    console.log("Agents by Role:");
    Object.keys(byRole).sort().forEach(role => {
      console.log(`\n  ${role.toUpperCase()} (${byRole[role].length}):`);
      byRole[role].forEach(name => console.log(`    - ${name}`));
    });

    console.log();
    console.log("=" .repeat(60));
    console.log("✅ Verification Complete!");
    console.log(`   Company: Learning Forge AI`);
    console.log(`   Total Agents: ${agents.length}`);
    console.log("=" .repeat(60));

  } catch (error) {
    console.error("❌ Error during verification:", error.message);
    process.exit(1);
  }
}

verifySetup();
