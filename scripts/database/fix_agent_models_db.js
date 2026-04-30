#!/usr/bin/env node

// Script to fix agent_id mixup in agent_models table
// Run with: node fix_agent_models_db.js

import postgres from 'postgres';
import fs from 'fs';

// Database connection
const DATABASE_URL = process.env.DATABASE_URL || 'postgresql://postgres.gmorarhibiptvcrnvrpi:bmdPWI7wQ172Ch1m@aws-1-eu-west-1.pooler.supabase.com:6543/postgres?sslmode=require';

async function main() {
  console.log('Connecting to database...');

  const sql = postgres(DATABASE_URL, {
    max: 1,
    connect_timeout: 30,
    ssl: 'require'
  });

  try {
    console.log('Loading agent mapping...');

    // Get agent name to UUID mapping
    const agents = await sql`
      SELECT id, name FROM agents
      WHERE name IS NOT NULL AND id IS NOT NULL
    `;

    const nameToUuid = new Map();
    agents.forEach(agent => {
      nameToUuid.set(agent.name, agent.id);
    });

    console.log(`Loaded ${nameToUuid.size} agent mappings`);

    // Find records that need fixing
    const recordsToFix = await sql`
      SELECT id, agent_id
      FROM agent_models
      WHERE agent_id NOT LIKE '________-____-____-____-____________'
         OR LENGTH(agent_id) < 36
         OR agent_id ~ '[^0-9a-f\-]'
    `;

    console.log(`Found ${recordsToFix.length} records that need fixing`);

    let fixedCount = 0;
    let notFoundCount = 0;

    for (const record of recordsToFix) {
      const correctUuid = nameToUuid.get(record.agent_id);

      if (correctUuid) {
        await sql`
          UPDATE agent_models
          SET agent_id = ${correctUuid}
          WHERE id = ${record.id}
        `;
        fixedCount++;
      } else {
        console.log(`No mapping found for agent name: ${record.agent_id}`);
        notFoundCount++;
      }
    }

    // Report results
    const totalRecords = await sql`SELECT COUNT(*) as count FROM agent_models`;
    const uuidRecords = await sql`
      SELECT COUNT(*) as count FROM agent_models
      WHERE agent_id LIKE '________-____-____-____-____________'
    `;

    console.log('\n=== RESULTS ===');
    console.log(`Total records: ${totalRecords[0].count}`);
    console.log(`Records with UUID agent_id: ${uuidRecords[0].count}`);
    console.log(`Records with name-based agent_id: ${totalRecords[0].count - uuidRecords[0].count}`);
    console.log(`Successfully fixed: ${fixedCount}`);
    console.log(`Could not map: ${notFoundCount}`);

    // Show sample of fixed records
    const sample = await sql`
      SELECT am.id, am.agent_id, a.name as agent_name, am.model_id
      FROM agent_models am
      LEFT JOIN agents a ON a.id = am.agent_id::uuid
      WHERE am.agent_id LIKE '________-____-____-____-____________'
      LIMIT 5
    `;

    console.log('\nSample of fixed records:');
    sample.forEach(row => {
      console.log(`  ${row.agent_id} -> ${row.agent_name || 'Unknown'} (${row.model_id})`);
    });

  } catch (error) {
    console.error('Error:', error);
  } finally {
    await sql.end();
  }
}

main().catch(console.error);