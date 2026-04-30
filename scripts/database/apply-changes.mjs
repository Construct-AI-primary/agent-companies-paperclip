#!/usr/bin/env node
// apply-changes.mjs - Apply Supabase data changes to local SQLite
// Usage: echo "$JSON_DATA" | node scripts/database/apply-changes.mjs <table_name> <sqlite_path>
//
// Reads JSON data from stdin and upserts into SQLite database.
// Handles PostgreSQL → SQLite type conversions.

import { readFileSync, writeFileSync } from 'fs';
import { stdin as input } from 'process';
import { createInterface } from 'readline';
import sqlite3 from 'sqlite3';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Import schema adapter
import { pgToSqliteValue } from './schema-adapter.mjs';

// PostgreSQL type hints for columns we know about
const TYPE_HINTS = {
  id: 'uuid',
  company_id: 'uuid',
  reports_to: 'uuid',
  agent_id: 'uuid',
  task_id: 'uuid',
  issue_id: 'uuid',
  user_id: 'uuid',
  created_at: 'timestamptz',
  updated_at: 'timestamptz',
  deleted_at: 'timestamptz',
  paused_at: 'timestamptz',
  last_heartbeat_at: 'timestamptz',
  is_active: 'boolean',
  adapter_config: 'jsonb',
  model_config: 'jsonb',
  runtime_config: 'jsonb',
  permissions: 'jsonb',
  metadata: 'jsonb',
  device_config: 'jsonb',
  capabilities: 'text',
};

/**
 * Convert a row from PostgreSQL format to SQLite format
 */
function convertRow(row) {
  const converted = {};
  
  for (const [key, value] of Object.entries(row)) {
    const hint = TYPE_HINTS[key];
    converted[key] = pgToSqliteValue(value, hint);
  }
  
  return converted;
}

/**
 * Generate UPSERT SQL for a table
 */
function generateUpsertSql(tableName, row) {
  const columns = Object.keys(row);
  const values = columns.map(c => '?');
  const updates = columns
    .filter(c => c !== 'id') // Don't update primary key
    .map(c => `"${c}" = excluded."${c}"`);
  
  const updateClause = updates.length > 0 ? `ON CONFLICT("id") DO UPDATE SET ${updates.join(', ')}` : 'ON CONFLICT("id") DO NOTHING';
  
  return {
    sql: `INSERT INTO "${tableName}" (${columns.map(c => `"${c}"`).join(', ')}) VALUES (${values.join(', ')}) ${updateClause}`,
    values: columns.map(c => row[c]),
  };
}

/**
 * Create table if not exists based on row schema
 */
function createTableIfNotExists(db, tableName, sampleRow) {
  const columns = Object.keys(sampleRow);
  const columnDefs = columns.map(col => {
    const hint = TYPE_HINTS[col];
    let type = 'TEXT';
    
    if (col === 'id') {
      type = 'TEXT PRIMARY KEY';
    } else if (hint === 'uuid') {
      type = 'TEXT';
    } else if (hint === 'boolean') {
      type = 'INTEGER';
    } else if (hint === 'timestamptz' || hint === 'timestamp') {
      type = 'TEXT';
    } else if (hint === 'jsonb' || hint === 'json') {
      type = 'TEXT';
    } else if (typeof sampleRow[col] === 'number') {
      type = Number.isInteger(sampleRow[col]) ? 'INTEGER' : 'REAL';
    } else if (typeof sampleRow[col] === 'boolean') {
      type = 'INTEGER';
    }
    
    return `"${col}" ${type}`;
  });
  
  const createSql = `CREATE TABLE IF NOT EXISTS "${tableName}" (${columnDefs.join(', ')})`;
  db.run(createSql);
  
  // Create indexes for common query patterns
  if (columns.includes('company_id')) {
    db.run(`CREATE INDEX IF NOT EXISTS "idx_${tableName}_company_id" ON "${tableName}"("company_id")`);
  }
  if (columns.includes('updated_at')) {
    db.run(`CREATE INDEX IF NOT EXISTS "idx_${tableName}_updated_at" ON "${tableName}"("updated_at")`);
  }
}

async function main() {
  const tableName = process.argv[2];
  const sqlitePath = process.argv[3] || './data/paperclip.db';
  
  if (!tableName) {
    console.error('❌ Usage: echo "$JSON" | node apply-changes.mjs <table_name> <sqlite_path>');
    process.exit(1);
  }
  
  // Read JSON from stdin
  let inputData = '';
  for await (const chunk of input) {
    inputData += chunk;
  }
  
  if (!inputData.trim()) {
    console.log('⏭️  No data provided');
    process.exit(0);
  }
  
  let rows;
  try {
    rows = JSON.parse(inputData);
    if (!Array.isArray(rows)) {
      rows = [rows];
    }
  } catch (err) {
    console.error('❌ Invalid JSON input:', err.message);
    process.exit(1);
  }
  
  if (rows.length === 0) {
    console.log('⏭️  Empty data array');
    process.exit(0);
  }
  
  // Open SQLite database
  const db = new sqlite3.Database(sqlitePath);
  
  // Enable foreign keys
  db.run('PRAGMA foreign_keys = ON');
  
  // Create table if needed
  createTableIfNotExists(db, tableName, rows[0]);
  
  // Upsert each row
  let upserted = 0;
  let errors = 0;
  
  for (const row of rows) {
    const converted = convertRow(row);
    const { sql, values } = generateUpsertSql(tableName, converted);
    
    db.run(sql, values, function(err) {
      if (err) {
        console.error(`  ❌ Error upserting ${row.id || 'unknown'}: ${err.message}`);
        errors++;
      } else {
        upserted++;
      }
    });
  }
  
  // Wait for all operations to complete
  db.close((err) => {
    if (err) {
      console.error('❌ Error closing database:', err.message);
      process.exit(1);
    }
    
    console.log(`  ✅ ${tableName}: ${upserted} upserted, ${errors} errors`);
  });
}

main().catch(err => {
  console.error('❌ Fatal error:', err.message);
  process.exit(1);
});