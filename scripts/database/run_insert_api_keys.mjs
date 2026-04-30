#!/usr/bin/env node

import { createClient } from '@supabase/supabase-js';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const SUPABASE_URL = "https://gmorarhibiptvcrnvrpi.supabase.co";
const SUPABASE_SERVICE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb3JhcmhpYmlwdHZjcm52cnBpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MzI4MzI0OSwiZXhwIjoyMDg4ODU5MjQ5fQ.LMTbfUtyurnJDfn_aW4UIXiyMLwTUMhc70jjRAZRpIQ";

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

async function runScript() {
  try {
    console.log('\n📝 Inserting API keys for agents missing them...\n');
    console.log('='.repeat(60));
    
    // First, get count of agents missing API keys
    const { data: missingCount, error: countError } = await supabase.rpc('exec_sql', {
      sql: `
        SELECT COUNT(DISTINCT a.id) as missing_count
        FROM agents a
        LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id AND aak.revoked_at IS NULL
        WHERE a.is_active = true AND aak.id IS NULL
      `
    });
    
    if (countError) {
      console.error('❌ Error checking missing keys:', countError.message);
    } else {
      console.log(`\n📊 Found ${missingCount?.[0]?.missing_count || 0} agents missing API keys\n`);
    }
    
    // Insert API keys for agents missing them
    console.log('🔑 Inserting API keys...\n');
    
    const { data: insertResult, error: insertError } = await supabase.rpc('exec_sql', {
      sql: `
        INSERT INTO agent_api_keys (id, agent_id, company_id, name, key_hash, created_at)
        SELECT 
            gen_random_uuid() as id,
            a.id as agent_id,
            a.company_id,
            'Primary Key' as name,
            encode(sha256(random()::text::bytea), 'hex') as key_hash,
            NOW() as created_at
        FROM agents a
        LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id AND aak.revoked_at IS NULL
        WHERE a.is_active = true AND aak.id IS NULL
      `
    });
    
    if (insertError) {
      console.error('❌ Error inserting API keys:', insertError.message);
      process.exit(1);
    }
    
    console.log('✅ API keys inserted successfully!\n');
    
    // Verification - get totals
    console.log('='.repeat(60));
    console.log('📊 VERIFICATION RESULTS\n');
    
    const { data: totals } = await supabase.rpc('exec_sql', {
      sql: `
        SELECT 
            COUNT(DISTINCT a.id) as total_active_agents,
            COUNT(DISTINCT aak.id) as agents_with_keys,
            COUNT(DISTINCT a.id) - COUNT(DISTINCT aak.id) as agents_missing_keys
        FROM agents a
        LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id AND aak.revoked_at IS NULL
        WHERE a.is_active = true
      `
    });
    
    if (totals && totals.length > 0) {
      const result = totals[0];
      console.log(`   Total Active Agents:    ${result.total_active_agents}`);
      console.log(`   Agents with API Keys:   ${result.agents_with_keys}`);
      console.log(`   Agents Missing Keys:    ${result.agents_missing_keys}`);
      
      if (result.agents_missing_keys === 0) {
        console.log('\n   ✅ 100% API KEY COVERAGE ACHIEVED!\n');
      }
    }
    
    // Breakdown by company
    console.log('='.repeat(60));
    console.log('📊 BREAKDOWN BY COMPANY\n');
    
    const { data: byCompany } = await supabase.rpc('exec_sql', {
      sql: `
        SELECT 
            c.name as company,
            COUNT(DISTINCT a.id) as active_agents,
            COUNT(DISTINCT aak.id) as agents_with_keys,
            COUNT(DISTINCT a.id) - COUNT(DISTINCT aak.id) as missing_keys
        FROM companies c
        INNER JOIN agents a ON c.id = a.company_id AND a.is_active = true
        LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id AND aak.revoked_at IS NULL
        WHERE c.status = 'active'
        GROUP BY c.name
        ORDER BY missing_keys DESC, c.name
      `
    });
    
    if (byCompany && byCompany.length > 0) {
      console.table(byCompany);
    }
    
    console.log('='.repeat(60));
    console.log('✨ Script execution complete!\n');
    
  } catch (error) {
    console.error('\n❌ Fatal error:', error.message);
    process.exit(1);
  }
}

runScript();
