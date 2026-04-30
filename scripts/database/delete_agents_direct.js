#!/usr/bin/env node

// Script to delete agents from agents, agent_models, and agent_api_keys tables
// Uses connection string directly from .env

import postgres from 'postgres';

const DATABASE_URL = process.env.DATABASE_URL || 'postgresql://postgres.gmorarhibiptvcrnvrpi:bmdPWI7wQ172Ch1m@aws-1-eu-west-1.pooler.supabase.com:6543/postgres?sslmode=require';

const AGENT_IDS = [
  'a7e42dcb-2b0d-4074-adc6-adbf6da67bbd',
  '88ab7dce-16cc-421b-ae4c-f5c1aa7ee29b'
];

async function main() {
  console.log('Connecting to database...');

  const sql = postgres(DATABASE_URL, {
    max: 1,
    connect_timeout: 60,
    ssl: 'require',
    application_name: 'delete_agents_script'
  });

  try {
    console.log('\n=== Deleting agents ===');
    console.log('Agent IDs:', AGENT_IDS);

    // First, verify agents exist
    console.log('\nChecking agents...');
    const existingAgents = await sql`
      SELECT id, name, company_id 
      FROM agents 
      WHERE id IN ${sql(AGENT_IDS)}
    `;
    console.log(`Found ${existingAgents.length} agents to delete:`);
    existingAgents.forEach(a => console.log(`  - ${a.id} (${a.name}) in company ${a.company_id}`));

    if (existingAgents.length === 0) {
      console.log('No agents found with those IDs. Exiting.');
      return;
    }

    // Delete from agent_api_keys first (foreign key constraint)
    console.log('\nDeleting from agent_api_keys...');
    const deletedApiKeys = await sql`
      DELETE FROM agent_api_keys 
      WHERE agent_id IN ${sql(AGENT_IDS)}
      RETURNING id
    `;
    console.log(`Deleted ${deletedApiKeys.length} rows from agent_api_keys`);

    // Delete from agent_models (if table exists)
    console.log('\nDeleting from agent_models...');
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
    console.log('\nDeleting from agents...');
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
    if (err.code === '28P01') {
      console.error('Authentication failed - check your DATABASE_URL password');
    }
    console.error(err);
    process.exit(1);
  } finally {
    await sql.end();
  }
}

main();
