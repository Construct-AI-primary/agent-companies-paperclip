import postgres from 'postgres';

// Test 1: Direct Connection
const directUrl = 'postgresql://postgres:JvFAeF6GHq7YDZlo@db.gmorarhibiptvcrnvrpi.supabase.co:5432/postgres';
console.log('Testing Direct Connection...');
const sql1 = postgres(directUrl, { max: 1, connect_timeout: 10 });
try {
  const r = await sql1`SELECT 1 as test`;
  console.log('DIRECT CONNECTION: OK');
  console.log('Result:', JSON.stringify(r));
} catch (e) {
  console.log('DIRECT CONNECTION: FAILED');
  console.log('Error:', e.message);
}
await sql1.end();

// Test 2: Session Pooler
const sessionUrl = 'postgresql://postgres.gmorarhibiptvcrnvrpi:JvFAeF6GHq7YDZlo@aws-1-eu-west-1.pooler.supabase.com:5432/postgres';
console.log('\nTesting Session Pooler...');
const sql2 = postgres(sessionUrl, { max: 1, connect_timeout: 10, connection: { family: 4 } });
try {
  const r = await sql2`SELECT 1 as test`;
  console.log('SESSION POOLER: OK');
  console.log('Result:', JSON.stringify(r));
} catch (e) {
  console.log('SESSION POOLER: FAILED');
  console.log('Error:', e.message);
}
await sql2.end();
