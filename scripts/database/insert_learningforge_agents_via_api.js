// Insert Learning Forge AI agents via Paperclip API
// This ensures agents go to the same database as the company
// Run with: BOARD_TOKEN=your_token node scripts/database/insert_learningforge_agents_via_api.js

const API_URL = process.env.PAPERCLIP_API_URL || "http://localhost:3100";
const BOARD_TOKEN = process.env.BOARD_TOKEN;
const COMPANY_ID = "2bda2da6-dfa7-4709-b5d1-ea865f14072a";

if (!BOARD_TOKEN) {
  console.error("Error: BOARD_TOKEN environment variable required");
  process.exit(1);
}

// Agent definitions from docs-paperclip/companies/learningforge-ai/
const agents = [
  {
    name: "Learning Strategy Agent",
    role: "ceo",
    title: "Chief Learning Officer",
    capabilities: "Executive leadership and learning strategy for Learning Forge AI"
  },
  {
    name: "Learning Division Lead",
    role: "division-lead",
    title: "Learning Division Lead",
    capabilities: "Learning and curriculum development leadership"
  },
  {
    name: "Curriculum Design Agent",
    role: "engineer",
    title: "Curriculum Designer",
    capabilities: "Construction-specific curriculum development and instructional design"
  },
  {
    name: "Assessment Development Agent",
    role: "engineer",
    title: "Assessment Developer",
    capabilities: "Technical assessment creation and validation"
  },
  {
    name: "Learning Path Optimization Agent",
    role: "engineer",
    title: "Learning Path Optimizer",
    capabilities: "Personalized learning path creation and optimization"
  },
  {
    name: "Skill Gap Analysis Agent",
    role: "engineer",
    title: "Skill Gap Analyst",
    capabilities: "Construction workforce skill assessment and gap identification"
  },
  {
    name: "Training Content Creation Agent",
    role: "engineer",
    title: "Training Content Creator",
    capabilities: "Multi-format training content development"
  },
  {
    name: "Learning Experience Design Agent",
    role: "engineer",
    title: "Learning Experience Designer",
    capabilities: "Engaging learning experience design"
  },
  {
    name: "Knowledge Flow Division Lead",
    role: "division-lead",
    title: "Knowledge Flow Division Lead",
    capabilities: "Knowledge management and documentation leadership"
  },
  {
    name: "Knowledge Base Management Agent",
    role: "engineer",
    title: "Knowledge Base Manager",
    capabilities: "Construction knowledge repository management"
  },
  {
    name: "Documentation Standards Agent",
    role: "engineer",
    title: "Documentation Standards Specialist",
    capabilities: "Documentation standardization and quality control"
  },
  {
    name: "Best Practices Compilation Agent",
    role: "engineer",
    title: "Best Practices Compiler",
    capabilities: "Industry best practices identification and documentation"
  },
  {
    name: "Lessons Learned Analysis Agent",
    role: "engineer",
    title: "Lessons Learned Analyst",
    capabilities: "Project lessons learned extraction and synthesis"
  },
  {
    name: "Knowledge Transfer Facilitation Agent",
    role: "engineer",
    title: "Knowledge Transfer Facilitator",
    capabilities: "Cross-project knowledge sharing facilitation"
  },
  {
    name: "Technical Writing Agent",
    role: "engineer",
    title: "Technical Writer",
    capabilities: "Construction technical documentation creation"
  }
];

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
    console.log(`✅ Created: ${agent.name} (${created.id})`);
    return true;
  } catch (error) {
    console.error(`❌ Error creating ${agent.name}:`, error.message);
    return false;
  }
}

async function insertAllAgents() {
  console.log(`Inserting ${agents.length} agents into Learning Forge AI...`);
  console.log(`Company ID: ${COMPANY_ID}`);
  console.log();

  let successCount = 0;
  let failCount = 0;

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

insertAllAgents();
