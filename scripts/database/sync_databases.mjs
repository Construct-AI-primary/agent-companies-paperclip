#!/usr/bin/env node
// Database Synchronization Script
// Ensures Supabase and Local databases have the same data
// Run with: node scripts/database/sync_databases.mjs

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.SUPABASE_URL || "https://gmorarhibiptvcrnvrpi.supabase.co";
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb3JhcmhpYmlwdHZjcm52cnBpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MzI4MzI0OSwiZXhwIjoyMDg4ODU5MjQ5fQ.LMTbfUtyurnJDfn_aW4UIXiyMLwTUMhc70jjRAZRpIQ";
const API_URL = process.env.PAPERCLIP_API_URL || "http://localhost:3100";
const BOARD_TOKEN = process.env.BOARD_TOKEN;

console.log("Paperclip Database Synchronization");
console.log("=" .repeat(60));
console.log();

// Check configuration
if (!BOARD_TOKEN) {
  console.error("❌ BOARD_TOKEN environment variable required for local API access");
  console.log("   Set it with: export BOARD_TOKEN=your_token");
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY, {
  auth: { autoRefreshToken: false, persistSession: false }
});

async function getSupabaseData() {
  console.log("1️⃣  Fetching data from Supabase...");
  
  try {
    const { data: companies, error: compError } = await supabase
      .from('companies')
      .select('*')
      .order('created_at');

    if (compError) throw new Error(`Companies: ${compError.message}`);

    const { data: agents, error: agentError } = await supabase
      .from('agents')
      .select('*')
      .order('created_at');

    if (agentError) throw new Error(`Agents: ${agentError.message}`);

    console.log(`   ✅ Found ${companies?.length || 0} companies`);
    console.log(`   ✅ Found ${agents?.length || 0} agents`);
    console.log();

    return { companies, agents };
  } catch (error) {
    console.error(`   ❌ Error: ${error.message}`);
    return null;
  }
}

async function getLocalData() {
  console.log("2️⃣  Fetching data from Local API...");
  
  try {
    const response = await fetch(`${API_URL}/api/companies`, {
      headers: { 'Authorization': `Bearer ${BOARD_TOKEN}` }
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${await response.text()}`);
    }

    const companies = await response.json();
    
    // Get agents for each company
    const allAgents = [];
    for (const company of companies) {
      const agentsRes = await fetch(`${API_URL}/api/companies/${company.id}/agents`, {
        headers: { 'Authorization': `Bearer ${BOARD_TOKEN}` }
      });
      
      if (agentsRes.ok) {
        const agents = await agentsRes.json();
        allAgents.push(...agents);
      }
    }

    console.log(`   ✅ Found ${companies.length} companies`);
    console.log(`   ✅ Found ${allAgents.length} agents`);
    console.log();

    return { companies, agents: allAgents };
  } catch (error) {
    console.error(`   ❌ Error: ${error.message}`);
    return null;
  }
}

async function syncToLocal(supabaseData) {
  console.log("3️⃣  Syncing Supabase → Local API...");
  
  let createdCompanies = 0;
  let skippedCompanies = 0;
  let createdAgents = 0;
  let skippedAgents = 0;

  // Sync companies
  for (const company of supabaseData.companies) {
    try {
      const response = await fetch(`${API_URL}/api/companies`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${BOARD_TOKEN}`
        },
        body: JSON.stringify({
          name: company.name,
          description: company.description
        })
      });

      if (response.ok) {
        createdCompanies++;
        console.log(`   ✅ Created company: ${company.name}`);
      } else if (response.status === 409) {
        skippedCompanies++;
        console.log(`   ⏭️  Skipped (exists): ${company.name}`);
      } else {
        console.log(`   ❌ Failed: ${company.name} - ${response.status}`);
      }
    } catch (error) {
      console.log(`   ❌ Error creating ${company.name}: ${error.message}`);
    }
  }

  console.log();
  console.log(`   Companies: ${createdCompanies} created, ${skippedCompanies} skipped`);
  console.log(`   Note: Agents sync requires matching company IDs`);
  console.log();
}

async function compareData(supabase, local) {
  console.log("4️⃣  Comparing databases...");
  console.log();

  const supabaseCompanyNames = new Set(supabase.companies.map(c => c.name));
  const localCompanyNames = new Set(local.companies.map(c => c.name));

  const inSupabaseOnly = [...supabaseCompanyNames].filter(n => !localCompanyNames.has(n));
  const inLocalOnly = [...localCompanyNames].filter(n => !supabaseCompanyNames.has(n));
  const inBoth = [...supabaseCompanyNames].filter(n => localCompanyNames.has(n));

  console.log("📊 Company Comparison:");
  console.log(`   In both databases: ${inBoth.length}`);
  inBoth.forEach(name => console.log(`      ✅ ${name}`));
  
  if (inSupabaseOnly.length > 0) {
    console.log(`   In Supabase only: ${inSupabaseOnly.length}`);
    inSupabaseOnly.forEach(name => console.log(`      🔵 ${name}`));
  }
  
  if (inLocalOnly.length > 0) {
    console.log(`   In Local only: ${inLocalOnly.length}`);
    inLocalOnly.forEach(name => console.log(`      🟢 ${name}`));
  }

  console.log();
  console.log(`📊 Agent Comparison:`);
  console.log(`   Supabase: ${supabase.agents.length} agents`);
  console.log(`   Local: ${local.agents.length} agents`);
  console.log();
}

async function main() {
  const supabaseData = await getSupabaseData();
  if (!supabaseData) {
    console.error("Failed to fetch Supabase data");
    process.exit(1);
  }

  const localData = await getLocalData();
  if (!localData) {
    console.error("Failed to fetch Local data");
    process.exit(1);
  }

  await compareData(supabaseData, localData);

  console.log("=" .repeat(60));
  console.log();
  console.log("💡 Recommendation:");
  console.log("   Use Supabase as your single source of truth");
  console.log("   Configure .env with Supabase DATABASE_URL");
  console.log("   This eliminates sync issues entirely");
  console.log();
  console.log("📖 See: docs-paperclip/procedures/database-sync-strategy.md");
  console.log();
}

main();
