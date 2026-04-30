#!/usr/bin/env node

import postgres from 'postgres';

const configurations = [
  {
    name: 'Pooler (correct port 6543)',
    url: 'postgresql://postgres.gmorarhibiptvcrnvrpi:bmdPWI7wQ172Ch1m@aws-1-eu-west-1.pooler.supabase.com:6543/postgres?sslmode=require'
  },
  {
    name: 'Pooler (wrong port 5432) - current',
    url: 'postgresql://postgres.gmorarhibiptvcrnvrpi:bmdPWI7wQ172Ch1m@aws-1-eu-west-1.pooler.supabase.com:5432/postgres'
  },
  {
    name: 'Direct (postgres user, port 5432)',
    url: 'postgresql://postgres:bmdPWI7wQ172Ch1m@db.gmorarhibiptvcrnvrpi.supabase.co:5432/postgres?sslmode=require'
  },
  {
    name: 'Direct (postgres user, no SSL)',
    url: 'postgresql://postgres:bmdPWI7wQ172Ch1m@db.gmorarhibiptvcrnvrpi.supabase.co:5432/postgres'
  },
  {
    name: 'Direct (email user, port 5432)',
    url: 'postgresql://alistair.tennant%40constuctai.biz:bmdPWI7wQ172Ch1m@db.gmorarhibiptvcrnvrpi.supabase.co:5432/postgres?sslmode=require'
  },
];

async function testConnection(config) {
  console.log(`\n${'='.repeat(60)}`);
  console.log(`Testing: ${config.name}`);
  console.log(`URL: ${config.url.replace(/:[^:]*@/, ':****@')}`);
  console.log(`${'='.repeat(60)}`);
  
  const sql = postgres(config.url, {
    connection: { family: 4 }
  });

  try {
    console.log('Attempting connection...');
    const result = await sql`SELECT 1 as test`;
    console.log('✅ Connected successfully!');
    console.log('✅ Query executed:', result[0]);
    return true;
  } catch (error) {
    console.log('❌ Connection failed:');
    console.log(`   Error: ${error.message}`);
    console.log(`   Code: ${error.code || 'N/A'}`);
    console.log(`   Severity: ${error.severity || 'N/A'}`);
    return false;
  } finally {
    await sql.end();
  }
}

async function runTests() {
  console.log('Starting PostgreSQL connection tests...');
  console.log('This will test various connection configurations to identify the issue.');
  
  const results = [];
  for (const config of configurations) {
    const success = await testConnection(config);
    results.push({ ...config, success });
  }

  console.log('\n' + '='.repeat(60));
  console.log('SUMMARY');
  console.log('='.repeat(60));
  for (const result of results) {
    const status = result.success ? '✅' : '❌';
    console.log(`${status} ${result.name}`);
  }
  
  const successful = results.filter(r => r.success);
  if (successful.length > 0) {
    console.log('\n✅ Working configuration(s) found:');
    successful.forEach(r => {
      console.log(`  - ${r.name}`);
    });
  }
}

runTests().catch(console.error);