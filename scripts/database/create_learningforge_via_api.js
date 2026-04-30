// Create Learning Forge AI company via API
// Run with: node scripts/database/create_learningforge_via_api.js

const API_URL = process.env.PAPERCLIP_API_URL || "http://localhost:3100";
const BOARD_TOKEN = process.env.BOARD_TOKEN;

if (!BOARD_TOKEN) {
  console.error("Error: BOARD_TOKEN environment variable required");
  console.log("Get your board token from the Paperclip UI and run:");
  console.log("BOARD_TOKEN=your_token node scripts/database/create_learningforge_via_api.js");
  process.exit(1);
}

async function createCompany() {
  const response = await fetch(`${API_URL}/api/companies`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${BOARD_TOKEN}`
    },
    body: JSON.stringify({
      name: "Learning Forge AI"
    })
  });

  if (!response.ok) {
    const error = await response.text();
    console.error(`Error: ${response.status} - ${error}`);
    process.exit(1);
  }

  const company = await response.json();
  console.log("✅ Company created successfully!");
  console.log(JSON.stringify(company, null, 2));
}

createCompany();
