// Check Learning Forge AI in Supabase database directly
// Run with: node scripts/database/check_supabase_learningforge.js

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.SUPABASE_URL || "https://gmorarhibiptvcrnvrpi.supabase.co";
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb3JhcmhpYmlwdHZjcm52cnBpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MzI4MzI0OSwiZXhwIjoyMDg4ODU5MjQ5fQ.LMTbfUtyurnJDfn_aW4UIXiyMLwTUMhc70jjRAZRpIQ";

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

async function checkSupabase() {
  console.log("Checking Supabase for Learning Forge AI...");
  console.log("=" .repeat(60));
  console.log();

  try {
    // Check for Learning Forge AI company
    const { data: companies, error: companyError } = await supabase
      .from('companies')
      .select('*')
      .ilike('name', '%Learning Forge%');

    if (companyError) {
      console.error("❌ Error querying companies:", companyError.message);
      return;
    }

    if (!companies || companies.length === 0) {
      console.log("⚠️  No Learning Forge AI company found in Supabase");
      console.log();
      
      // Show all companies
      const { data: allCompanies } = await supabase
        .from('companies')
        .select('id, name, issue_prefix, status');
      
      console.log("All companies in Supabase:");
      allCompanies?.forEach(c => {
        console.log(`  - ${c.name} (${c.issue_prefix}) - ${c.status}`);
      });
      return;
    }

    const company = companies[0];
    console.log("✅ Learning Forge AI Company Found:");
    console.log(`   ID: ${company.id}`);
    console.log(`   Name: ${company.name}`);
    console.log(`   Status: ${company.status}`);
    console.log(`   Issue Prefix: ${company.issue_prefix}`);
    console.log(`   Created: ${company.created_at}`);
    console.log();

    // Check for agents
    const { data: agents, error: agentsError } = await supabase
      .from('agents')
      .select('id, name, role, title, status')
      .eq('company_id', company.id);

    if (agentsError) {
      console.error("❌ Error querying agents:", agentsError.message);
      return;
    }

    console.log(`✅ Agents Found: ${agents?.length || 0}`);
    console.log();

    if (agents && agents.length > 0) {
      // Group by role
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
    }

    console.log();
    console.log("=" .repeat(60));
    console.log("✅ Supabase Check Complete!");
    console.log(`   Company: ${company.name}`);
    console.log(`   Total Agents: ${agents?.length || 0}`);
    console.log("=" .repeat(60));

  } catch (error) {
    console.error("❌ Error:", error.message);
  }
}

checkSupabase();
