#!/usr/bin/env node

import postgres from 'postgres';

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  console.error('Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY environment variables');
  process.exit(1);
}

// Construct the database URL for direct connection
const dbUrl = `postgresql://postgres:${SUPABASE_SERVICE_ROLE_KEY}@db.${SUPABASE_URL.replace('https://', '').replace('http://', '')}:5432/postgres?sslmode=require`;

async function queryAgentModels() {
  const sql = postgres(dbUrl, {
    connection: { family: 4 }
  });

  try {
    console.log('Querying agent_models table...');

    // Query to get current models being used
    const result = await sql`
      SELECT
        am.model_id,
        am.assignment_type,
        COUNT(*) as count,
        COUNT(DISTINCT am.agent_id) as unique_agents,
        AVG(am.temperature) as avg_temperature,
        AVG(am.max_tokens) as avg_max_tokens
      FROM agent_models am
      WHERE am.is_active = true
      GROUP BY am.model_id, am.assignment_type
      ORDER BY am.model_id, am.assignment_type
    `;

    console.log('\nCurrent Models in agent_models table:');
    console.log('=' .repeat(80));
    console.log('Model ID'.padEnd(40), 'Type'.padEnd(12), 'Count'.padEnd(8), 'Agents'.padEnd(8), 'Avg Temp'.padEnd(10), 'Avg Tokens');
    console.log('=' .repeat(80));

    for (const row of result) {
      console.log(
        row.model_id.padEnd(40),
        row.assignment_type.padEnd(12),
        row.count.toString().padEnd(8),
        row.unique_agents.toString().padEnd(8),
        (row.avg_temperature ? row.avg_temperature.toFixed(2) : 'N/A').padEnd(10),
        row.avg_max_tokens ? row.avg_max_tokens.toString() : 'N/A'
      );
    }

    // Also get total counts
    const totalQuery = await sql`
      SELECT
        COUNT(DISTINCT am.agent_id) as total_agents_with_models,
        COUNT(*) as total_assignments
      FROM agent_models am
      WHERE am.is_active = true
    `;

    const agentCountQuery = await sql`
      SELECT COUNT(*) as total_agents
      FROM agents
      WHERE is_active = true
    `;

    console.log('\nSummary:');
    console.log(`Total agents with model assignments: ${totalQuery[0].total_agents_with_models}`);
    console.log(`Total model assignments: ${totalQuery[0].total_assignments}`);
    console.log(`Total active agents: ${agentCountQuery[0].total_agents}`);

    if (totalQuery[0].total_agents_with_models !== agentCountQuery[0].total_agents) {
      console.log('\n⚠️  MISALIGNMENT DETECTED: Number of agents with models does not match total agents!');
    }

  } catch (error) {
    console.error('Query failed:', error.message);
  } finally {
    await sql.end();
  }
}

queryAgentModels().catch(console.error);