#!/usr/bin/env node

/**
 * Import agents from CSV file with corrected company ID mappings
 * Reads the agents CSV and imports with proper company assignments
 */

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { createClient } from '@supabase/supabase-js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Company ID mappings - keep original IDs from CSV, only map truly invalid ones
const COMPANY_MAPPINGS = {
  // Old QualityForge ID -> New QualityForge ID (this one was actually changed)
  'f535f9bc-00be-4b6d-9f53-c53abfacacef': 'a4f9d4c6-33f5-4552-b32d-054552144edf',

  // All other company IDs in CSV should be valid now that we created the companies
  // Keep them as-is
};

// CSV file path
const CSV_PATH = '/Users/alistairtennant/Downloads/agents_rows (18).csv';

// Database connection (using the embedded postgres connection)
const DB_CONFIG = {
  host: '127.0.0.1',
  port: 54329,
  database: 'paperclip',
  user: 'paperclip',
  password: 'paperclip'
};

function parseCSVLine(line) {
  const result = [];
  let current = '';
  let inQuotes = false;

  for (let i = 0; i < line.length; i++) {
    const char = line[i];

    if (char === '"') {
      if (inQuotes && line[i + 1] === '"') {
        // Escaped quote
        current += '"';
        i++; // Skip next quote
      } else {
        // Toggle quote state
        inQuotes = !inQuotes;
      }
    } else if (char === ',' && !inQuotes) {
      // Field separator
      result.push(current);
      current = '';
    } else {
      current += char;
    }
  }

  // Add the last field
  result.push(current);

  return result;
}

function parseCSV(csvContent) {
  const lines = csvContent.split('\n').filter(line => line.trim());
  const headers = parseCSVLine(lines[0]);

  const rows = [];
  for (let i = 1; i < lines.length; i++) {
    const values = parseCSVLine(lines[i]);
    if (values.length === headers.length) {
      const row = {};
      headers.forEach((header, index) => {
        row[header] = values[index];
      });
      rows.push(row);
    }
  }

  return rows;
}

function mapCompanyId(originalId) {
  return COMPANY_MAPPINGS[originalId] || originalId; // Keep original ID if not in mappings
}

function generateSQLInsert(agent) {
  const companyId = mapCompanyId(agent.company_id);

  // Parse JSON fields
  let metadata = {};
  let permissions = {};
  let runtimeConfig = {};

  try {
    metadata = JSON.parse(agent.metadata || '{}');
  } catch (e) {
    metadata = {};
  }

  try {
    permissions = JSON.parse(agent.permissions || '{}');
  } catch (e) {
    permissions = {};
  }

  try {
    runtimeConfig = JSON.parse(agent.runtime_config || '{}');
  } catch (e) {
    runtimeConfig = {};
  }

  // Handle null/empty reports_to
  const reportsTo = agent.reports_to && agent.reports_to.trim() ? `'${agent.reports_to}'` : 'NULL';

  // Handle timestamps
  const createdAt = agent.created_at ? `'${agent.created_at}'` : 'NOW()';
  const updatedAt = agent.updated_at ? `'${agent.updated_at}'` : 'NOW()';

  return `
INSERT INTO agents (
  id, company_id, name, role, title, capabilities, status, reports_to,
  created_at, updated_at, metadata, permissions, runtime_config
) VALUES (
  '${agent.id}',
  '${companyId}',
  '${agent.name.replace(/'/g, "''")}',
  '${agent.role || 'general'}',
  '${(agent.title || '').replace(/'/g, "''")}',
  '${(agent.capabilities || '').replace(/'/g, "''")}',
  '${agent.status || 'active'}',
  ${reportsTo},
  ${createdAt},
  ${updatedAt},
  '${JSON.stringify(metadata).replace(/'/g, "''")}',
  '${JSON.stringify(permissions).replace(/'/g, "''")}',
  '${JSON.stringify(runtimeConfig).replace(/'/g, "''")}'
) ON CONFLICT (id) DO UPDATE SET
  company_id = EXCLUDED.company_id,
  name = EXCLUDED.name,
  role = EXCLUDED.role,
  title = EXCLUDED.title,
  capabilities = EXCLUDED.capabilities,
  status = EXCLUDED.status,
  reports_to = EXCLUDED.reports_to,
  updated_at = EXCLUDED.updated_at,
  metadata = EXCLUDED.metadata,
  permissions = EXCLUDED.permissions,
  runtime_config = EXCLUDED.runtime_config;`;
}

async function importAgents() {
  try {
    // Read CSV file
    console.log('Reading CSV file...');
    const csvContent = fs.readFileSync(CSV_PATH, 'utf8');
    const agents = parseCSV(csvContent);

    console.log(`Found ${agents.length} agents in CSV`);

    // Generate SQL
    const sqlStatements = agents.map(agent => generateSQLInsert(agent)).join('\n');

    // Write to file
    const sqlFile = path.join(__dirname, 'import_agents.sql');
    fs.writeFileSync(sqlFile, sqlStatements);

    console.log(`Generated SQL file: ${sqlFile}`);

    // Execute SQL
    console.log('Executing SQL...');
    const { execSync } = await import('child_process');
    execSync(`psql "postgres://paperclip:paperclip@127.0.0.1:54329/paperclip" -f ${sqlFile}`, {
      stdio: 'inherit'
    });

    console.log('Import completed successfully!');

    // Verify results
    console.log('\nAgent count by company:');
    execSync(`psql "postgres://paperclip:paperclip@127.0.0.1:54329/paperclip" -c "SELECT c.name, COUNT(a.id) as agents FROM companies c LEFT JOIN agents a ON c.id = a.company_id GROUP BY c.id, c.name ORDER BY c.name;"`, {
      stdio: 'inherit'
    });

  } catch (error) {
    console.error('Import failed:', error);
    process.exit(1);
  }
}

importAgents();