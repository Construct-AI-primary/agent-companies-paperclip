#!/usr/bin/env node

import postgres from 'postgres';
import fs from 'fs';

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  console.error('Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY environment variables');
  console.error('Please set these in your .env file or environment');
  process.exit(1);
}

// Construct the database URL for direct connection
const dbUrl = `postgresql://postgres:${SUPABASE_SERVICE_ROLE_KEY}@db.${SUPABASE_URL.replace('https://', '').replace('http://', '')}:5432/postgres?sslmode=require`;

async function updateAgentModels() {
  const sql = postgres(dbUrl, {
    connection: { family: 4 }
  });

  try {
    console.log('🔄 Updating GLM-4-Plus to z-ai/glm-4.7-flash in agent_models table...');

    // First, check current state
    console.log('\n📊 Current state before update:');
    const beforeStats = await sql`
      SELECT
        COUNT(*) as total_models,
        COUNT(CASE WHEN model_id = 'GLM-4-Plus' THEN 1 END) as glm_4_plus_count,
        COUNT(CASE WHEN model_id = 'z-ai/glm-4.7-flash' THEN 1 END) as glm_47_flash_count
      FROM agent_models
      WHERE is_active = true
    `;

    console.log(`Total active models: ${beforeStats[0].total_models}`);
    console.log(`GLM-4-Plus models: ${beforeStats[0].glm_4_plus_count}`);
    console.log(`z-ai/glm-4.7-flash models: ${beforeStats[0].glm_47_flash_count}`);

    if (beforeStats[0].glm_4_plus_count === 0) {
      console.log('\n✅ No GLM-4-Plus models found to update.');
      return;
    }

    // Perform the update
    console.log('\n🔄 Performing update...');
    const updateResult = await sql`
      UPDATE agent_models
      SET model_id = 'z-ai/glm-4.7-flash'
      WHERE model_id = 'GLM-4-Plus'
    `;

    console.log(`✅ Updated ${updateResult.count} records`);

    // Update provider field for the new model
    const providerUpdate = await sql`
      UPDATE agent_models
      SET provider = 'z-ai'
      WHERE model_id = 'z-ai/glm-4.7-flash' AND (provider IS NULL OR provider = '')
    `;

    console.log(`✅ Updated provider for ${providerUpdate.count} records`);

    // Verify the changes
    console.log('\n📊 Verification after update:');
    const afterStats = await sql`
      SELECT
        COUNT(*) as total_models,
        COUNT(CASE WHEN model_id = 'GLM-4-Plus' THEN 1 END) as glm_4_plus_count,
        COUNT(CASE WHEN model_id = 'z-ai/glm-4.7-flash' THEN 1 END) as glm_47_flash_count
      FROM agent_models
      WHERE is_active = true
    `;

    console.log(`Total active models: ${afterStats[0].total_models}`);
    console.log(`GLM-4-Plus models: ${afterStats[0].glm_4_plus_count}`);
    console.log(`z-ai/glm-4.7-flash models: ${afterStats[0].glm_47_flash_count}`);

    // Show affected agents
    console.log('\n👥 Affected agents:');
    const affectedAgents = await sql`
      SELECT
        a.name as agent_name,
        am.model_id,
        am.provider,
        c.name as company_name
      FROM agents a
      JOIN agent_models am ON a.id = am.agent_id
      LEFT JOIN companies c ON a.company_id = c.id
      WHERE am.model_id = 'z-ai/glm-4.7-flash' AND am.is_active = true
      ORDER BY a.name
    `;

    if (affectedAgents.length > 0) {
      console.log('Agent Name'.padEnd(30), 'Model'.padEnd(25), 'Provider'.padEnd(15), 'Company');
      console.log('='.repeat(85));
      for (const agent of affectedAgents) {
        console.log(
          agent.agent_name.padEnd(30),
          agent.model_id.padEnd(25),
          (agent.provider || 'N/A').padEnd(15),
          agent.company_name || 'N/A'
        );
      }
    } else {
      console.log('No agents found with the updated model');
    }

    console.log('\n✅ Update completed successfully!');

  } catch (error) {
    console.error('❌ Update failed:', error.message);
    process.exit(1);
  } finally {
    await sql.end();
  }
}

updateAgentModels().catch(console.error);