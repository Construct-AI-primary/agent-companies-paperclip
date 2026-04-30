#!/usr/bin/env node

// Script to recreate agent_models records for agents that don't have them
// Run with: node recreate_agent_models.js

import postgres from 'postgres';

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
    console.log('Finding agents without model assignments...');

    // Find agents that don't have any agent_models records
    const agentsWithoutModels = await sql`
      SELECT
        a.id,
        a.name,
        a.company_id,
        c.name as company_name
      FROM agents a
      LEFT JOIN agent_models am ON a.id = am.agent_id::uuid
      LEFT JOIN companies c ON a.company_id = c.id::uuid
      WHERE am.id IS NULL
      ORDER BY a.company_id, a.name
    `;

    console.log(`Found ${agentsWithoutModels.length} agents without model assignments`);

    if (agentsWithoutModels.length === 0) {
      console.log('All agents already have model assignments!');
      return;
    }

    // Default model assignments based on company
    const companyDefaults = {
      '550e8400-e29b-41d4-a716-446655440013': { // QualityForge AI
        model: 'qwen/qwen-3.6-72b-instruct',
        temperature: 0.30,
        reason: 'Quality assurance and testing agent - requires analytical reasoning'
      },
      '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d': { // DomainForge AI
        model: 'qwen/qwen-3.6-72b-instruct',
        temperature: 0.30,
        reason: 'Domain specialization agent - requires deep understanding'
      },
      '550e8400-e29b-41d4-a716-446655440008': { // ContentForge AI
        model: 'z-ai/glm-5-turbo',
        temperature: 0.70,
        reason: 'Content creation agent - requires creative flexibility'
      },
      '550e8400-e29b-41d4-a716-446655440009': { // LearningForge AI
        model: 'z-ai/glm-5.1',
        temperature: 0.70,
        reason: 'Learning and education agent - requires adaptive reasoning'
      },
      '550e8400-e29b-41d4-a716-446655440011': { // InfraForge AI
        model: 'qwen/qwen-3.6-72b-instruct',
        temperature: 0.30,
        reason: 'Infrastructure agent - requires precise technical reasoning'
      },
      '550e8400-e29b-41d4-a716-446655440010': { // DevForge AI
        model: 'qwen/qwen-3.6-72b-instruct',
        temperature: 0.30,
        reason: 'Development agent - requires coding and technical expertise'
      },
      '550e8400-e29b-41d4-a716-446655440012': { // KnowledgeForge AI
        model: 'z-ai/glm-5.1',
        temperature: 0.50,
        reason: 'Knowledge management agent - requires comprehensive understanding'
      }
    };

    let createdCount = 0;
    let skippedCount = 0;

    for (const agent of agentsWithoutModels) {
      const companyDefaults_ = companyDefaults[agent.company_id] || {
        model: 'qwen/qwen-3.6-72b-instruct',
        temperature: 0.30,
        reason: 'General purpose agent - standard configuration'
      };

      console.log(`Creating model assignment for: ${agent.name} (${agent.company_name})`);

      try {
        await sql`
          INSERT INTO agent_models (
            id,
            agent_id,
            model_id,
            assignment_type,
            priority,
            temperature,
            max_tokens,
            assigned_at,
            assigned_by,
            reason,
            total_requests,
            total_tokens_input,
            total_tokens_output,
            total_cost,
            avg_latency_ms,
            error_rate,
            is_active,
            created_at,
            updated_at,
            company_id
          ) VALUES (
            gen_random_uuid(),
            ${agent.id},
            ${companyDefaults_.model},
            'primary',
            1,
            ${companyDefaults_.temperature},
            4096,
            NOW(),
            'system',
            ${companyDefaults_.reason + ' - Auto-created after agent_models cleanup'},
            0,
            0,
            0,
            0.0000,
            NULL,
            0.0000,
            true,
            NOW(),
            NOW(),
            ${agent.company_id}
          )
        `;
        createdCount++;
      } catch (error) {
        console.error(`Failed to create assignment for ${agent.name}:`, error.message);
        skippedCount++;
      }
    }

    // Final verification
    const finalStats = await sql`
      SELECT
        'Total agents' as metric,
        COUNT(*) as count
      FROM agents
      UNION ALL
      SELECT
        'Agents with model assignments' as metric,
        COUNT(DISTINCT am.agent_id) as count
      FROM agent_models am
      WHERE am.agent_id LIKE '________-____-____-____-____________'
      UNION ALL
      SELECT
        'Agents without model assignments' as metric,
        COUNT(*) as count
      FROM agents a
      LEFT JOIN agent_models am ON a.id = am.agent_id::uuid
      WHERE am.id IS NULL
      UNION ALL
      SELECT
        'Total agent_models records' as metric,
        COUNT(*) as count
      FROM agent_models
      UNION ALL
      SELECT
        'Valid agent_models records' as metric,
        COUNT(*) as count
      FROM agent_models
      WHERE agent_id LIKE '________-____-____-____-____-____________'
    `;

    console.log('\n=== FINAL RESULTS ===');
    finalStats.forEach(stat => {
      console.log(`${stat.metric}: ${stat.count}`);
    });

    console.log(`\nAssignments created: ${createdCount}`);
    console.log(`Assignments skipped (errors): ${skippedCount}`);

  } catch (error) {
    console.error('Error:', error);
  } finally {
    await sql.end();
  }
}

main().catch(console.error);