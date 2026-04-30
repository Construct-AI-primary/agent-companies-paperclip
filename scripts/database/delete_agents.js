#!/usr/bin/env node

// Script to delete agents from agents, agent_models, and agent_api_keys tables
// Run with: node delete_agents.js

import postgres from 'postgres';

const SUPABASE_URL = process.env.SUPABASE_URL || 'https://gmorarhibiptvcrnvrpi.supabase.co';
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb3JhcmhpYmlwdHZjcm52cnBpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MzI4MzI0OSwiZXhwIjoyMDg4ODU5MjQ5fQ.LMTbfUtyurnJDfn_aW4UIXiyMLwTUMhc70jjRAZRpIQ';

// Direct connection to Supabase Postgres using service role key
const dbUrl = `postgresql://postgres:${SUPABASE_SERVICE_ROLE_KEY}@db.${SUPABASE_URL.replace('https://', '').replace('http://', '')}:5432/postgres?sslmode=require`;

const AGENT_IDS = [
  '9e780111-85f6-4cc3-a110-377f23e8fdfc'
];

async function main() {
  console.log('Connecting to database...');

  const sql = postgres(dbUrl, {
    max: 1,
    connect_timeout: 30,
    ssl: 'require'
  });

  try {
    console.log('\n=== Deleting agents ===');
    console.log('Agent IDs:', AGENT_IDS);

    // First, verify agents exist
    const existingAgents = await sql`
      SELECT id, name, company_id 
      FROM agents 
      WHERE id IN ${sql(AGENT_IDS)}
    `;
    console.log(`\nFound ${existingAgents.length} agents to delete:`);
    existingAgents.forEach(a => console.log(`  - ${a.id} (${a.name}) in company ${a.company_id}`));

    // Delete from agent_api_keys first (foreign key constraint)
    const deletedApiKeys = await sql`
      DELETE FROM agent_api_keys 
      WHERE agent_id IN ${sql(AGENT_IDS)}
      RETURNING id
    `;
    console.log(`\nDeleted ${deletedApiKeys.length} rows from agent_api_keys`);

    // Delete from agent_models (if table exists)
    let deletedModels = 0;
    try {
      const result = await sql`
        DELETE FROM agent_models 
        WHERE agent_id IN ${sql(AGENT_IDS)}
        RETURNING id
      `;
      deletedModels = result.length;
      console.log(`Deleted ${deletedModels} rows from agent_models`);
    } catch (err) {
      if (err.code === '42P01') {
        console.log('agent_models table does not exist, skipping...');
      } else {
        throw err;
      }
    }

    // Delete from agents table
    const deletedAgents = await sql`
      DELETE FROM agents 
      WHERE id IN ${sql(AGENT_IDS)}
      RETURNING id, name
    `;
    console.log(`\nDeleted ${deletedAgents.length} rows from agents`);
    deletedAgents.forEach(a => console.log(`  - ${a.id} (${a.name})`));

    console.log('\n=== Deletion complete ===');

  } catch (err) {
    console.error('Error:', err.message);
    console.error(err);
    process.exit(1);
  } finally {
    await sql.end();
  }
}

main();
