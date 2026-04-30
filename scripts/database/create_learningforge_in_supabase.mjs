// Create Learning Forge AI company directly in Supabase and verify
// Run with: node scripts/database/create_learningforge_in_supabase.mjs

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://gmorarhibiptvcrnvrpi.supabase.co";
const SUPABASE_SERVICE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb3JhcmhpYmlwdHZjcm52cnBpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MzI4MzI0OSwiZXhwIjoyMDg4ODU5MjQ5fQ.LMTbfUtyurnJDfn_aW4UIXiyMLwTUMhc70jjRAZRpIQ";

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

const COMPANY_ID = '550e8400-e29b-41d4-a716-446655440013';

async function createAndVerify() {
  console.log("Creating Learning Forge AI in Supabase...");
  console.log("=" .repeat(60));
  console.log();

  try {
    // First, check if it already exists
    console.log("1. Checking if company already exists...");
    const { data: existing, error: checkError } = await supabase
      .from('companies')
      .select('*')
      .eq('id', COMPANY_ID)
      .maybeSingle();

    if (checkError && checkError.code !== 'PGRST116') {
      console.error("❌ Error checking existing company:", checkError.message);
      return;
    }

    if (existing) {
      console.log("⚠️  Company already exists:");
      console.log(`   ID: ${existing.id}`);
      console.log(`   Name: ${existing.name}`);
      console.log(`   Issue Prefix: ${existing.issue_prefix}`);
      console.log();
    } else {
      // Insert the company
      console.log("2. Creating company record...");
      const { data: newCompany, error: insertError } = await supabase
        .from('companies')
        .insert({
          id: COMPANY_ID,
          name: 'Learning Forge AI',
          description: 'AI Learning & Knowledge Management company specializing in construction domain learning',
          status: 'active',
          issue_prefix: 'LFA',
          issue_counter: 0,
          budget_monthly_cents: 0,
          spent_monthly_cents: 0,
          require_board_approval_for_new_agents: true,
          brand_color: '#9333ea',
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        })
        .select()
        .single();

      if (insertError) {
        console.error("❌ Error creating company:", insertError.message);
        console.error("   Details:", insertError);
        return;
      }

      console.log("✅ Company created successfully!");
      console.log(`   ID: ${newCompany.id}`);
      console.log(`   Name: ${newCompany.name}`);
      console.log(`   Issue Prefix: ${newCompany.issue_prefix}`);
      console.log();
    }

    // Verify the company exists
    console.log("3. Verifying company in database...");
    const { data: verified, error: verifyError } = await supabase
      .from('companies')
      .select('*')
      .eq('id', COMPANY_ID)
      .single();

    if (verifyError) {
      console.error("❌ Error verifying company:", verifyError.message);
      return;
    }

    console.log("✅ Company verified in Supabase:");
    console.log(`   ID: ${verified.id}`);
    console.log(`   Name: ${verified.name}`);
    console.log(`   Description: ${verified.description}`);
    console.log(`   Status: ${verified.status}`);
    console.log(`   Issue Prefix: ${verified.issue_prefix}`);
    console.log(`   Brand Color: ${verified.brand_color}`);
    console.log(`   Created: ${verified.created_at}`);
    console.log();

    // Check agents
    console.log("4. Checking agents linked to company...");
    const { data: agents, error: agentsError, count } = await supabase
      .from('agents')
      .select('id, name, role', { count: 'exact' })
      .eq('company_id', COMPANY_ID);

    if (agentsError) {
      console.error("❌ Error checking agents:", agentsError.message);
      return;
    }

    console.log(`✅ Found ${count} agents linked to company`);
    if (count > 0) {
      console.log("\nSample agents:");
      agents.slice(0, 5).forEach(agent => {
        console.log(`   - ${agent.name} (${agent.role})`);
      });
      if (count > 5) {
        console.log(`   ... and ${count - 5} more`);
      }
    }

    console.log();
    console.log("=" .repeat(60));
    console.log("✅ Setup Complete!");
    console.log(`   Company: Learning Forge AI`);
    console.log(`   Total Agents: ${count}`);
    console.log("=" .repeat(60));
    console.log();
    console.log("🎉 Learning Forge AI should now appear in Paperclip UI!");
    console.log("   URL: http://localhost:3100");

  } catch (error) {
    console.error("❌ Unexpected error:", error.message);
    console.error(error);
  }
}

createAndVerify();
