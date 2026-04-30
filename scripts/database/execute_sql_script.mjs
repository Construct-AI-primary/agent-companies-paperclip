#!/usr/bin/env node
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { config } from 'dotenv';

// Load environment variables from .env file
config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Database connection
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

// Validate environment variables
if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  console.error('❌ Missing required environment variables:');
  console.error('   SUPABASE_URL: ', SUPABASE_URL ? '✅ Set' : '❌ Missing');
  console.error('   SUPABASE_SERVICE_ROLE_KEY: ', SUPABASE_SERVICE_ROLE_KEY ? '✅ Set' : '❌ Missing');
  console.error('\nPlease ensure .env file contains the correct Supabase credentials.');
  process.exit(1);
}

// Split SQL into individual statements
function splitSqlStatements(sql) {
  // Remove single-line comments
  const cleaned = sql.replace(/--.*$/gm, '');
  // Split on semicolons but respect quoted strings
  const statements = [];
  let current = '';
  let inString = false;
  let stringChar = '';
  
  for (let i = 0; i < cleaned.length; i++) {
    const char = cleaned[i];
    
    if (!inString && (char === "'" || char === '"')) {
      inString = true;
      stringChar = char;
    } else if (inString && char === stringChar && cleaned[i-1] !== '\\') {
      inString = false;
    } else if (!inString && char === ';') {
      const stmt = current.trim();
      if (stmt) statements.push(stmt);
      current = '';
      continue;
    }
    current += char;
  }
  
  const last = current.trim();
  if (last) statements.push(last);
  
  return statements;
}

async function executeStatement(sql) {
  // Use Supabase SQL API via pgBouncer
  // We execute via the REST API by posting to a table endpoint
  // For raw SQL, we need to use the Supabase Management API or SQL editor
  // Since we don't have direct SQL execution via REST, we use the Supabase client
  
  // Try using the Supabase SQL endpoint directly
  const response = await fetch(`${SUPABASE_URL}/rest/v1/`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'apikey': SUPABASE_SERVICE_ROLE_KEY,
      'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
      'Prefer': 'return=minimal'
    },
    body: JSON.stringify({})
  });
  
  if (!response.ok) {
    const text = await response.text();
    throw new Error(`HTTP ${response.status}: ${text}`);
  }
  return {};
}

async function executeSqlScript(scriptPath) {
  try {
    console.log(`\n📝 Reading SQL script: ${scriptPath}\n`);
    const sqlContent = readFileSync(scriptPath, 'utf8');

    console.log('🔄 Executing SQL script via Supabase REST API...');
    console.log('⚠️  Note: This script uses the Supabase REST API which has limitations.');
    console.log('   For complex SQL (DO blocks, functions), use the Supabase SQL Editor directly.\n');

    const statements = splitSqlStatements(sqlContent);
    console.log(`📊 Found ${statements.length} SQL statements to execute\n`);

    let successCount = 0;
    let errorCount = 0;

    for (let i = 0; i < statements.length; i++) {
      const stmt = statements[i];
      if (!stmt || stmt.startsWith('--')) continue;
      
      const preview = stmt.substring(0, 60) + (stmt.length > 60 ? '...' : '');
      console.log(`  [${i + 1}/${statements.length}] ${preview}`);
      
      try {
        // For UPDATE/INSERT/DELETE statements, we need to use the Supabase client
        // Since we can't execute raw SQL via REST, we'll parse and execute via appropriate endpoints
        
        // Detect statement type
        const upperStmt = stmt.toUpperCase().trim();
        
        if (upperStmt.startsWith('UPDATE')) {
          // Parse UPDATE: UPDATE table SET col=val WHERE condition
          const match = stmt.match(/UPDATE\s+(\w+)\s+SET\s+(\w+)\s*=\s*'([^']+)'\s+WHERE\s+(.+)/i);
          if (match) {
            const [, table, column, value, whereClause] = match;
            // Parse WHERE clause for name = 'value' AND company_id = (SELECT...)
            const whereMatch = whereClause.match(/(\w+)\s*=\s*'([^']+)'/i);
            if (whereMatch) {
              const [_, filterCol, filterVal] = whereMatch;
              
              // First, get the record ID
              const getResponse = await fetch(`${SUPABASE_URL}/rest/v1/${table}?${filterCol}=eq.${filterVal}`, {
                headers: {
                  'apikey': SUPABASE_SERVICE_ROLE_KEY,
                  'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`
                }
              });
              
              if (getResponse.ok) {
                const records = await getResponse.json();
                if (records.length > 0) {
                  // Update the record
                  const updateResponse = await fetch(`${SUPABASE_URL}/rest/v1/${table}?id=eq.${records[0].id}`, {
                    method: 'PATCH',
                    headers: {
                      'Content-Type': 'application/json',
                      'apikey': SUPABASE_SERVICE_ROLE_KEY,
                      'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
                      'Prefer': 'return=minimal'
                    },
                    body: JSON.stringify({ [column]: value })
                  });
                  
                  if (updateResponse.ok) {
                    console.log(`     ✅ Updated ${records[0].id}`);
                    successCount++;
                  } else {
                    const errText = await updateResponse.text();
                    console.log(`     ⚠️  Update failed: ${errText.substring(0, 100)}`);
                    errorCount++;
                  }
                } else {
                  console.log(`     ⏭️  No record found with ${filterCol}='${filterVal}'`);
                }
              } else {
                console.log(`     ⚠️  Query failed`);
                errorCount++;
              }
            } else {
              console.log(`     ⚠️  Could not parse WHERE clause`);
              errorCount++;
            }
          } else {
            console.log(`     ⚠️  Could not parse UPDATE statement`);
            errorCount++;
          }
        } else if (upperStmt.startsWith('INSERT')) {
          // For INSERT ... SELECT ... WHERE NOT EXISTS, we need to handle differently
          // Parse INSERT INTO agents (...) SELECT ... WHERE NOT EXISTS
          const insertMatch = stmt.match(/INSERT\s+INTO\s+(\w+)\s*\(([^)]+)\)\s*SELECT\s*(.+?)\s*WHERE\s+NOT\s+EXISTS\s*\(\s*SELECT\s+1\s+FROM\s+(\w+)\s+WHERE\s+(\w+)\s*=\s*'([^']+)'\s*\)/is);
          
          if (insertMatch) {
            const [, table, columns, selectValues, checkTable, checkCol, checkVal] = insertMatch;
            
            // Check if record exists
            const checkResponse = await fetch(`${SUPABASE_URL}/rest/v1/${checkTable}?${checkCol}=eq.${checkVal}`, {
              headers: {
                'apikey': SUPABASE_SERVICE_ROLE_KEY,
                'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`
              }
            });
            
            if (checkResponse.ok) {
              const existing = await checkResponse.json();
              if (existing.length > 0) {
                console.log(`     ⏭️  Record with ${checkCol}='${checkVal}' already exists, skipping`);
                successCount++; // Not an error, just skipped
              } else {
                // Parse the SELECT values - they contain gen_random_uuid(), subqueries, and literals
                const colList = columns.split(',').map(c => c.trim());
                
                // For complex INSERT with subqueries, we need to resolve them
                // Extract values from SELECT clause
                const valuesStr = selectValues.trim();
                const values = [];
                
                // Parse values - handle gen_random_uuid(), subqueries, and literals
                let depth = 0;
                let current = '';
                for (const char of valuesStr) {
                  if (char === '(') depth++;
                  if (char === ')') depth--;
                  if (char === ',' && depth === 0) {
                    values.push(current.trim());
                    current = '';
                  } else {
                    current += char;
                  }
                }
                if (current.trim()) values.push(current.trim());
                
                // Build the record object
                const record = {};
                for (let j = 0; j < colList.length && j < values.length; j++) {
                  const col = colList[j];
                  let val = values[j];
                  
                  // Handle gen_random_uuid()
                  if (val === 'gen_random_uuid()') {
                    // Generate UUID client-side
                    val = crypto.randomUUID();
                  }
                  // Handle subquery: (SELECT id FROM companies WHERE name = 'MeasureForge AI')
                  else if (val.startsWith('(SELECT')) {
                    const subMatch = val.match(/SELECT\s+(\w+)\s+FROM\s+(\w+)\s+WHERE\s+(\w+)\s*=\s*'([^']+)'/i);
                    if (subMatch) {
                      const [, subCol, subTable, subWhereCol, subWhereVal] = subMatch;
                      const subResponse = await fetch(`${SUPABASE_URL}/rest/v1/${subTable}?${subWhereCol}=eq.${subWhereVal}&select=${subCol}`, {
                        headers: {
                          'apikey': SUPABASE_SERVICE_ROLE_KEY,
                          'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`
                        }
                      });
                      if (subResponse.ok) {
                        const subResult = await subResponse.json();
                        val = subResult[0]?.[subCol];
                      }
                    }
                  }
                  // Handle string literals (remove quotes)
                  else if (val.startsWith("'") && val.endsWith("'")) {
                    val = val.slice(1, -1);
                  }
                  // Handle ::jsonb casts
                  else if (val.includes('::jsonb')) {
                    val = val.replace(/::jsonb/g, '');
                    // Remove outer quotes if present
                    if (val.startsWith("'") && val.endsWith("'")) {
                      val = val.slice(1, -1);
                    }
                    try {
                      val = JSON.parse(val);
                    } catch (e) {
                      // Keep as string if not valid JSON
                    }
                  }
                  // Handle numeric values
                  else if (!isNaN(val)) {
                    val = Number(val);
                  }
                  
                  record[col] = val;
                }
                
                // Insert the record
                const insertResponse = await fetch(`${SUPABASE_URL}/rest/v1/${table}`, {
                  method: 'POST',
                  headers: {
                    'Content-Type': 'application/json',
                    'apikey': SUPABASE_SERVICE_ROLE_KEY,
                    'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
                    'Prefer': 'return=minimal'
                  },
                  body: JSON.stringify(record)
                });
                
                if (insertResponse.ok) {
                  console.log(`     ✅ Inserted ${record.name || 'record'}`);
                  successCount++;
                } else {
                  const errText = await insertResponse.text();
                  console.log(`     ⚠️  Insert failed: ${errText.substring(0, 100)}`);
                  errorCount++;
                }
              }
            } else {
              console.log(`     ⚠️  Check query failed`);
              errorCount++;
            }
          } else {
            // Try simpler INSERT INTO table (cols) VALUES (vals)
            const simpleMatch = stmt.match(/INSERT\s+INTO\s+(\w+)\s*\(([^)]+)\)\s*VALUES\s*\((.+)\)/is);
            if (simpleMatch) {
              const [, table, columns, valuesStr] = simpleMatch;
              const colList = columns.split(',').map(c => c.trim());
              
              // Parse values
              const values = [];
              let depth = 0;
              let current = '';
              let inStr = false;
              for (const char of valuesStr) {
                if (!inStr && char === '(') depth++;
                if (!inStr && char === ')') depth--;
                if (char === "'" && valuesStr[valuesStr.indexOf(char) - 1] !== '\\') inStr = !inStr;
                if (char === ',' && depth === 0 && !inStr) {
                  values.push(current.trim());
                  current = '';
                } else {
                  current += char;
                }
              }
              if (current.trim()) values.push(current.trim());
              
              const record = {};
              for (let j = 0; j < colList.length && j < values.length; j++) {
                let val = values[j];
                if (val === 'gen_random_uuid()') val = crypto.randomUUID();
                else if (val.startsWith("'") && val.endsWith("'")) val = val.slice(1, -1);
                else if (val.includes('::jsonb')) {
                  val = val.replace(/::jsonb/g, '');
                  if (val.startsWith("'") && val.endsWith("'")) val = val.slice(1, -1);
                  try { val = JSON.parse(val); } catch (e) {}
                }
                else if (!isNaN(val)) val = Number(val);
                record[colList[j]] = val;
              }
              
              const insertResponse = await fetch(`${SUPABASE_URL}/rest/v1/${table}`, {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                  'apikey': SUPABASE_SERVICE_ROLE_KEY,
                  'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
                  'Prefer': 'return=minimal'
                },
                body: JSON.stringify(record)
              });
              
              if (insertResponse.ok) {
                console.log(`     ✅ Inserted ${record.name || 'record'}`);
                successCount++;
              } else {
                const errText = await insertResponse.text();
                console.log(`     ⚠️  Insert failed: ${errText.substring(0, 100)}`);
                errorCount++;
              }
            } else {
              console.log(`     ⚠️  Could not parse INSERT statement`);
              errorCount++;
            }
          }
        } else if (upperStmt.startsWith('SELECT')) {
          // For SELECT statements, just run them
          console.log(`     ℹ️  SELECT statement - run in Supabase SQL Editor`);
          successCount++;
        } else if (upperStmt.startsWith('DO') || upperStmt.startsWith('CREATE') || upperStmt.startsWith('ALTER') || upperStmt.startsWith('DROP')) {
          // These require DDL execution which REST API doesn't support directly
          console.log(`     ⚠️  DDL statement (${upperStmt.split(' ')[0]}) - run in Supabase SQL Editor`);
          errorCount++;
        } else {
          console.log(`     ⚠️  Unsupported statement type`);
          errorCount++;
        }
      } catch (err) {
        console.error(`     ⚠️  ${err.message.substring(0, 100)}`);
        errorCount++;
      }
    }

    console.log(`\n✅ Execution complete: ${successCount} succeeded, ${errorCount} errors`);
    if (errorCount > 0) {
      console.log('\n💡 For DDL statements (CREATE, ALTER, DO blocks), use the Supabase SQL Editor directly.');
    }
    return errorCount === 0;

  } catch (err) {
    console.error('❌ Fatal error:', err.message);
    process.exit(1);
  }
}

const scriptPath = process.argv[2] || join(__dirname, 'insert_all_missing_api_keys.sql');
executeSqlScript(scriptPath);