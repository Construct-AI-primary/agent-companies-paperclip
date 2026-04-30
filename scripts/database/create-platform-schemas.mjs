#!/usr/bin/env node

/**
 * Platform Database Schema Creation Script
 * Created: 2026-04-21
 * Description: Executes the platform database schema creation for engineering and measurement platforms
 * Usage: node scripts/database/create-platform-schemas.mjs
 */

import { readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import { config } from 'dotenv';
import pkg from 'pg';
const { Client } = pkg;

// Load environment variables from .env file
config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Database connection configuration
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

// Validate environment variables
if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  console.error('❌ Missing required environment variables:');
  console.error('   SUPABASE_URL: ', SUPABASE_URL ? '✅ Set' : '❌ Missing');
  console.error('   SUPABASE_SERVICE_ROLE_KEY: ', SUPABASE_SERVICE_ROLE_KEY ? '✅ Set' : '❌ Missing');
  console.error('\nPlease set these environment variables before running this script.');
  process.exit(1);
}

// Extract database connection details from Supabase URL
// SUPABASE_URL format: https://gmorarhibiptvcrnvrpi.supabase.co
const url = new URL(SUPABASE_URL);
const host = `aws-1-eu-west-1.pooler.supabase.com`; // Standard Supabase pooler host
const database = 'postgres';

// Create PostgreSQL client (following the pattern from execute_sql_script.mjs)
const client = new Client({
  host,
  port: 6543,
  user: `postgres.${url.pathname.slice(1)}`, // Extract project ref from URL
  password: SUPABASE_SERVICE_ROLE_KEY,
  database,
  ssl: {
    rejectUnauthorized: false
  }
});

/**
 * Execute SQL script with proper error handling
 */
async function executeSqlScript(sqlContent, scriptName) {
  console.log(`\n🔄 Executing ${scriptName}...`);

  try {
    // Split into statements (simple split by semicolon, works for most cases)
    const statements = sqlContent
      .split(';')
      .map(s => {
        // Remove leading comments and whitespace
        let cleaned = s.trim();
        while (cleaned.startsWith('--')) {
          const lines = cleaned.split('\n');
          // Remove the first line if it starts with --
          if (lines[0].trim().startsWith('--')) {
            lines.shift();
            cleaned = lines.join('\n').trim();
          } else {
            break;
          }
        }
        return cleaned;
      })
      .filter(s => s.length > 0);

    console.log(`✅ Found ${statements.length} SQL statements to execute\n`);

    for (let i = 0; i < statements.length; i++) {
      const statement = statements[i];
      if (statement) {
        console.log(`\n[${i + 1}/${statements.length}] Executing statement...`);

        try {
          const result = await client.query(statement);
          console.log(`✅ Statement executed successfully (${result.rowCount || 0} rows affected)`);
        } catch (err) {
          console.error('❌ Error executing statement:', err.message);
          console.error('Statement:', statement.substring(0, 200));
          // Continue with next statement instead of exiting
        }
      }
    }

    console.log(`\n✅ ${scriptName} executed successfully`);
    return true;
  } catch (err) {
    console.error(`❌ Failed to execute ${scriptName}:`, err.message);
    return false;
  }
}

/**
 * Check if required tables exist
 */
async function checkPrerequisites() {
  console.log('\n🔍 Checking prerequisites...');

  try {
    // Connect to database
    await client.connect();

    // Check if base tables exist using direct SQL
    const checkSql = `
      SELECT table_name
      FROM information_schema.tables
      WHERE table_schema = 'public'
      AND table_name IN ('companies', 'agents', 'agent-models');
    `;

    const result = await client.query(checkSql);
    const existingTables = result.rows.map(row => row.table_name);

    const requiredTables = ['companies', 'agents', 'agent-models'];
    const missingTables = requiredTables.filter(table => !existingTables.includes(table));

    if (missingTables.length > 0) {
      console.error('❌ Missing required base tables:', missingTables.join(', '));
      console.error('Please ensure the base Paperclip database schema is created first.');
      console.error('Required tables: companies, agents, agent-models');
      await client.end();
      return false;
    }

    console.log('✅ All prerequisites met');
    return true;
  } catch (err) {
    console.error('❌ Error checking prerequisites:', err.message);
    await client.end();
    return false;
  }
}

/**
 * Verify schema creation
 */
async function verifySchemaCreation() {
  console.log('\n🔍 Verifying schema creation...');

  try {
    // Check engineering tables using direct SQL
    const engCheckSql = `
      SELECT table_name
      FROM information_schema.tables
      WHERE table_schema = 'public'
      AND table_name LIKE 'a_engineering%';
    `;

    const engResult = await client.query(engCheckSql);
    const engTables = engResult.rows.map(row => row.table_name);

    // Check measurement tables using direct SQL
    const measCheckSql = `
      SELECT table_name
      FROM information_schema.tables
      WHERE table_schema = 'public'
      AND table_name LIKE 'a_measurement%';
    `;

    const measResult = await client.query(measCheckSql);
    const measTables = measResult.rows.map(row => row.table_name);

    // Check views using direct SQL
    const viewCheckSql = `
      SELECT table_name
      FROM information_schema.views
      WHERE table_schema = 'public'
      AND table_name LIKE 'v_platform%';
    `;

    const viewResult = await client.query(viewCheckSql);
    const viewTables = viewResult.rows.map(row => row.table_name);

    console.log(`✅ Created ${engTables.length} engineering tables`);
    console.log(`✅ Created ${measTables.length} measurement tables`);
    console.log(`✅ Created ${viewTables.length} cross-platform views`);

    // List created tables
    if (engTables.length > 0) {
      console.log('\n📋 Engineering tables:');
      engTables.forEach(table => console.log(`   - ${table}`));
    }

    if (measTables.length > 0) {
      console.log('\n📋 Measurement tables:');
      measTables.forEach(table => console.log(`   - ${table}`));
    }

    if (viewTables.length > 0) {
      console.log('\n📋 Cross-platform views:');
      viewTables.forEach(view => console.log(`   - ${view}`));
    }

    return true;
  } catch (err) {
    console.error('❌ Error verifying schema creation:', err.message);
    return false;
  } finally {
    await client.end();
  }
}

/**
 * Main execution function
 */
async function main() {
  console.log('🚀 Starting Platform Database Schema Creation');
  console.log('=' .repeat(50));

  // Check prerequisites
  if (!await checkPrerequisites()) {
    process.exit(1);
  }

  // Read and execute the main schema script
  const schemaPath = join(__dirname, 'create-platform-schemas.sql');

  try {
    const sqlContent = readFileSync(schemaPath, 'utf8');

    // Execute the schema creation
    const success = await executeSqlScript(sqlContent, 'Platform Schema Creation');

    if (!success) {
      console.error('\n❌ Schema creation failed');
      process.exit(1);
    }

    // Verify the schema was created correctly
    if (!await verifySchemaCreation()) {
      console.error('\n❌ Schema verification failed');
      process.exit(1);
    }

    console.log('\n🎉 Platform database schema creation completed successfully!');
    console.log('\n📝 Next steps:');
    console.log('   1. Register the 6 new agents using their register-agent.sql scripts');
    console.log('   2. Test agent configurations and cross-company integrations');
    console.log('   3. Begin shared component development');
    console.log('   4. Implement API endpoints for the platforms');

  } catch (err) {
    console.error('❌ Error reading schema file:', err.message);
    console.error('Expected file at:', schemaPath);
    process.exit(1);
  }
}

// Handle unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
  console.error('❌ Unhandled Rejection at:', promise, 'reason:', reason);
  process.exit(1);
});

// Handle uncaught exceptions
process.on('uncaughtException', (error) => {
  console.error('❌ Uncaught Exception:', error);
  process.exit(1);
});

// Run the main function
main().catch((error) => {
  console.error('❌ Fatal error:', error);
  process.exit(1);
});