import { readFileSync } from 'fs';
import postgres from 'postgres';

// Database connection - using Supabase credentials from env or defaults
const SUPABASE_URL = process.env.SUPABASE_URL || 'https://gmorarhibiptvcrnvrpi.supabase.co';
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb3JhcmhpYmlwdHZjcm52cnBpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MzI4MzI0OSwiZXhwIjoyMDg4ODU5MjQ5fQ.LMTbfUtyurnJDfn_aW4UIXiyMLwTUMhc70jjRAZRpIQ';

// Use the same credentials as test-db.mjs
const DATABASE_URL = 'postgresql://postgres:JvFAeF6GHq7YDZlo@db.gmorarhibiptvcrnvrpi.supabase.co:5432/postgres';

console.log('Executing Builder Procurement Agents SQL...');
console.log('Database URL:', DATABASE_URL.replace(/:[^:]*@/, ':****@'));

// Read the SQL file
const sqlContent = readFileSync('docs-paperclip/companies/infraforge-ai/agents/nimbus-infraforge-supabase-specialist/builder-procurement-agents.sql', 'utf8');

console.log('SQL file loaded, length:', sqlContent.length);

// Execute the entire SQL file as one operation
const sql = postgres(DATABASE_URL, { max: 1, connect_timeout: 10, connection: { family: 4 } });

try {
  console.log('Executing entire SQL file...');

  // Execute the entire SQL content
  const result = await sql.unsafe(sqlContent);
  console.log('✅ SQL file executed successfully');
  console.log('Result count:', result.length);

  console.log('\n🎉 All SQL statements processed!');

  // Run verification queries
  console.log('\n🔍 Running verification queries...');

  const agentCount = await sql`SELECT COUNT(*) as agent_count FROM agents WHERE company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI') AND name IN ('Sage Weaver', 'Forge Master', 'Resource Baron', 'Service Sage', 'Task Titan', 'Match Maker', 'Candy Connector', 'Budget Guardian', 'Gate Keeper')`;

  console.log('Agent count:', agentCount[0].agent_count);

  const agents = await sql`SELECT a.name, a.title, a.status, a.adapter_config->>'model' as model FROM agents a WHERE a.company_id = (SELECT id FROM companies WHERE name = 'MeasureForge AI') AND a.name IN ('Sage Weaver', 'Forge Master', 'Resource Baron', 'Service Sage', 'Task Titan', 'Match Maker', 'Candy Connector', 'Budget Guardian', 'Gate Keeper') ORDER BY a.name`;

  console.log('\nCreated agents:');
  agents.forEach(agent => {
    console.log(`- ${agent.name}: ${agent.title} (${agent.model})`);
  });

} catch (error) {
  console.error('❌ Database operation failed:', error.message);
} finally {
  await sql.end();
}