#!/usr/bin/env node

/**
 * Remove duplicate agents from Paperclip agents table
 * JavaScript equivalent of remove_duplicates.sql
 * Keeps the agent with API keys when possible, otherwise the most recently updated
 */

import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

// Load environment variables
import dotenv from 'dotenv';
dotenv.config();

// Database connection
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing Supabase credentials. Set SUPABASE_URL and SUPABASE_KEY environment variables.');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function findDuplicates() {
  console.log('🔍 Finding duplicate agents...\n');

  try {
    // Find name + company duplicates
    const { data: nameDuplicates, error: nameError } = await supabase
      .rpc('find_agent_duplicates');

    if (nameError) {
      console.log('⚠️  RPC function not found, using direct query...\n');

      // Direct query approach - get all agents (without API key counts due to permissions)
      const { data: agents, error } = await supabase
        .from('agents')
        .select(`
          id,
          name,
          company_id,
          title,
          role,
          created_at,
          updated_at
        `);

      if (error) {
        console.error('❌ Error fetching agents:', error);
        return null;
      }

      // Get API key counts separately
      const { data: apiKeyCounts, error: keyError } = await supabase
        .from('agent_api_keys')
        .select('agent_id');

      const keyCountMap = {};
      if (!keyError && apiKeyCounts) {
        apiKeyCounts.forEach(key => {
          keyCountMap[key.agent_id] = (keyCountMap[key.agent_id] || 0) + 1;
        });
      }

      // Add API key counts to agents
      agents.forEach(agent => {
        agent.api_key_count = keyCountMap[agent.id] || 0;
      });

      // Get company info separately to avoid permission issues
      const { data: companies, error: companyError } = await supabase
        .from('companies')
        .select('id, name');

      const companyMap = {};
      if (!companyError && companies) {
        companies.forEach(c => companyMap[c.id] = c.name);
      }

      // Group by name + company_id (exact duplicates)
      const nameDuplicatesMap = {};
      const ceoDuplicatesMap = {};

      agents.forEach(agent => {
        // Check for name + company duplicates
        const nameKey = `${agent.name}|${agent.company_id}`;
        if (!nameDuplicatesMap[nameKey]) {
          nameDuplicatesMap[nameKey] = [];
        }
        nameDuplicatesMap[nameKey].push(agent);

        // Check for CEO role duplicates
        const isCeo = (agent.title && (
          agent.title.toLowerCase().includes('chief executive') ||
          agent.title.toLowerCase().includes('ceo')
        )) || (agent.role && agent.role.toLowerCase() === 'ceo');

        if (isCeo) {
          const ceoKey = `CEO|${agent.company_id}`;
          if (!ceoDuplicatesMap[ceoKey]) {
            ceoDuplicatesMap[ceoKey] = [];
          }
          ceoDuplicatesMap[ceoKey].push(agent);
        }
      });

      // Filter to only groups with duplicates
      const nameDuplicateGroups = Object.values(nameDuplicatesMap).filter(group => group.length > 1);
      const ceoDuplicateGroups = Object.values(ceoDuplicatesMap).filter(group => group.length > 1);

      console.log(`📊 Found ${nameDuplicateGroups.length} name+company duplicate groups\n`);
      console.log(`👑 Found ${ceoDuplicateGroups.length} CEO role duplicate groups\n`);

      // Show name duplicates
      if (nameDuplicateGroups.length > 0) {
        console.log('📝 Name + Company Duplicates:');
        nameDuplicateGroups.forEach((group, index) => {
          const companyName = companyMap[group[0].company_id] || 'Unknown Company';
          console.log(`${index + 1}. ${group[0].name} (${companyName}) - ${group.length} duplicates`);
          group.forEach(agent => {
            const apiKeys = agent.api_key_count || 0;
            console.log(`   - ${agent.id}: ${agent.title || 'N/A'} (${apiKeys} API keys, created: ${new Date(agent.created_at).toLocaleDateString()})`);
          });
          console.log('');
        });
      }

      // Show CEO duplicates
      if (ceoDuplicateGroups.length > 0) {
        console.log('👑 CEO Role Duplicates:');
        ceoDuplicateGroups.forEach((group, index) => {
          const companyName = companyMap[group[0].company_id] || 'Unknown Company';
          console.log(`${index + 1}. CEO Role in ${companyName} - ${group.length} duplicates`);
          group.forEach(agent => {
            const apiKeys = agent.api_key_count || 0;
            console.log(`   - ${agent.id}: ${agent.name} (${agent.title || 'N/A'}) (${apiKeys} API keys, created: ${new Date(agent.created_at).toLocaleDateString()})`);
          });
          console.log('');
        });
      }

      return {
        nameDuplicates: nameDuplicateGroups,
        ceoDuplicates: ceoDuplicateGroups
      };
    }

    return nameDuplicates;
  } catch (error) {
    console.error('❌ Error finding duplicates:', error);
    return null;
  }
}

async function removeDuplicates(duplicateData) {
  if (!duplicateData) {
    console.log('✅ No duplicates found to remove.');
    return;
  }

  const { nameDuplicates = [], ceoDuplicates = [] } = duplicateData;
  const allDuplicates = [...nameDuplicates, ...ceoDuplicates];

  if (allDuplicates.length === 0) {
    console.log('✅ No duplicates found to remove.');
    return;
  }

  console.log('🧹 Removing duplicates...\n');

  let totalRemoved = 0;

  // Process name + company duplicates
  if (nameDuplicates.length > 0) {
    console.log('📝 Processing name + company duplicates...');
    for (const group of nameDuplicates) {
      const removed = await processDuplicateGroup(group, 'name+company');
      totalRemoved += removed;
    }
  }

  // Process CEO role duplicates
  if (ceoDuplicates.length > 0) {
    console.log('👑 Processing CEO role duplicates...');
    for (const group of ceoDuplicates) {
      const removed = await processDuplicateGroup(group, 'CEO role');
      totalRemoved += removed;
    }
  }

  console.log(`\n🎉 Successfully removed ${totalRemoved} duplicate agents.`);
}

async function processDuplicateGroup(group, duplicateType) {
  if (group.length <= 1) return 0;

  // Sort by priority: API keys first, then most recent update, then creation, then ID
  const sorted = group.sort((a, b) => {
    const aKeys = a.api_key_count || 0;
    const bKeys = b.api_key_count || 0;

    if (aKeys !== bKeys) return bKeys - aKeys;
    if (a.updated_at !== b.updated_at) return new Date(b.updated_at) - new Date(a.updated_at);
    if (a.created_at !== b.created_at) return new Date(b.created_at) - new Date(a.created_at);
    return a.id.localeCompare(b.id);
  });

  // Keep the first (highest priority), remove the rest
  const toRemove = sorted.slice(1);
  let removed = 0;

  for (const agent of toRemove) {
    console.log(`🗑️  Removing ${duplicateType} duplicate: ${agent.name} (${agent.id})`);

    // First remove API keys
    const { error: keyError } = await supabase
      .from('agent_api_keys')
      .delete()
      .eq('agent_id', agent.id);

    if (keyError) {
      console.error(`❌ Error removing API keys for ${agent.id}:`, keyError);
      continue;
    }

    // Then remove the agent
    const { error: agentError } = await supabase
      .from('agents')
      .delete()
      .eq('id', agent.id);

    if (agentError) {
      console.error(`❌ Error removing agent ${agent.id}:`, agentError);
      continue;
    }

    removed++;
    console.log(`✅ Removed ${agent.id}`);
  }

  return removed;
}

async function verifyCleanup() {
  console.log('\n🔍 Verifying cleanup...\n');

  // Check for remaining duplicates
  const { data: remaining, error } = await supabase
    .from('agents')
    .select('name, company_id')
    .then(async ({ data, error }) => {
      if (error) return { data: null, error };

      const counts = {};
      data.forEach(agent => {
        const key = `${agent.name}|${agent.company_id}`;
        counts[key] = (counts[key] || 0) + 1;
      });

      const duplicates = Object.entries(counts)
        .filter(([key, count]) => count > 1)
        .map(([key, count]) => ({ name: key.split('|')[0], company_id: key.split('|')[1], count }));

      return { data: duplicates, error: null };
    });

  if (error) {
    console.error('❌ Error verifying cleanup:', error);
    return;
  }

  if (remaining.length === 0) {
    console.log('✅ No duplicates remaining!');
  } else {
    console.log('⚠️  Remaining duplicates:');
    remaining.forEach(dup => {
      console.log(`   - ${dup.name}: ${dup.count} instances`);
    });
  }

  // Show summary
  const { data: summary, error: summaryError } = await supabase
    .from('agents')
    .select('id', { count: 'exact' });

  if (!summaryError) {
    const { data: keySummary } = await supabase
      .from('agent_api_keys')
      .select('id', { count: 'exact' });

    console.log(`\n📊 Summary:`);
    console.log(`   - Total agents: ${summary.length || 0}`);
    console.log(`   - Total API keys: ${keySummary?.length || 0}`);
  }
}

async function main() {
  console.log('🚀 Starting duplicate agent removal process...\n');

  try {
    const duplicates = await findDuplicates();

    if (duplicates) {
      const { nameDuplicates = [], ceoDuplicates = [] } = duplicates;
      const totalGroups = nameDuplicates.length + ceoDuplicates.length;

      if (totalGroups > 0) {
        console.log(`⚠️  Found ${totalGroups} duplicate groups (${nameDuplicates.length} name+company, ${ceoDuplicates.length} CEO role).`);
        console.log('This will permanently delete duplicate agents.');
        console.log('Make sure you have a backup before proceeding!\n');

        // In a real script, you'd want user confirmation here
        // For now, we'll proceed automatically
        await removeDuplicates(duplicates);
      } else {
        console.log('✅ No duplicates found.');
      }
    } else {
      console.log('✅ No duplicates found.');
    }

    await verifyCleanup();

    console.log('\n✨ Process completed successfully!');

  } catch (error) {
    console.error('❌ Fatal error:', error);
    process.exit(1);
  }
}

// Run if called directly
if (import.meta.url === `file://${process.argv[1]}`) {
  main();
}

export { findDuplicates, removeDuplicates, verifyCleanup };
