#!/usr/bin/env node
/**
 * Assign skills to agents with smart initial guesses
 * 
 * Strategy:
 * 1. Match agent name → company skill (primary match) 
 * 2. Assign ALL shared skills to all agents (these are common patterns)
 * 3. For skills where no match, leave unchecked — user can refine
 * 
 * Usage: SUPABASE_URL=xxx SUPABASE_KEY=xxx node assign_agent_skills.mjs
 */

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error('Error: Set SUPABASE_URL and SUPABASE_KEY environment variables');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

// Normalize for fuzzy matching
function normalize(str) {
  return str.toLowerCase().replace(/[^a-z0-9]/g, '');
}

// Check if agent name matches a skill (bidirectional)
function agentMatchesSkill(agentName, skillKey) {
  const a = normalize(agentName);
  const s = normalize(skillKey);
  
  // Direct containment either way
  if (s.includes(a) || a.includes(s)) return { score: 10, reason: 'direct' };
  
  // Word-level matching (e.g., "Quality Auditor" matches "auditor-qualityforge")
  const agentWords = a.split(/[-_]/).filter(w => w.length > 3);
  for (const word of agentWords) {
    if (s.includes(word)) return { score: 8, reason: `word "${word}"` };
  }
  
  return null;
}

async function assignSkills() {
  console.log('=== Agent Skill Assignment with Smart Guesses ===\n');

  // Fetch agents
  const { data: agents } = await supabase.from('agents')
    .select('id, name, company_id, role')
    .not('company_id', 'is', null);
  console.log(`Found ${agents?.length || 0} agents\n`);

  // Fetch company skills
  const { data: companySkills } = await supabase.from('company_skills')
    .select('key, name, company_id');
  console.log(`Found ${companySkills?.length || 0} company skills`);

  // Fetch shared skills
  const { data: sharedSkills } = await supabase.from('shared_skills')
    .select('key, name');
  console.log(`Found ${sharedSkills?.length || 0} shared skills\n`);

  let totalPrimaryAssigned = 0;
  let totalSharedAssigned = 0;
  let totalAgents = agents?.length || 0;

  for (const agent of agents) {
    console.log(`\n━━━ ${agent.name} (${agent.role}) [${agent.company_id.slice(0, 8)}...] ━━━`);

    // 1. Find PRIMARY matching skill
    const primaryMatch = (companySkills || [])
      .filter(s => s.company_id === agent.company_id)
      .map(s => ({ skill: s, match: agentMatchesSkill(agent.name, s.key) }))
      .filter(x => x.match)
      .sort((a, b) => b.match.score - a.match.score);

    const assignedSkills = [];

    if (primaryMatch.length > 0) {
      const best = primaryMatch[0];
      console.log(`  ✓ Primary match: "${best.skill.name}" (via ${best.match.reason})`);
      assignedSkills.push(best.skill.key);
      totalPrimaryAssigned++;
    } else {
      console.log(`  ⚠ No primary skill match found — will only assign shared skills`);
    }

    // 2. Assign ALL shared skills to all agents
    const sharedKeys = sharedSkills.map(s => s.key);
    assignedSkills.push(...sharedKeys);
    totalSharedAssigned += sharedKeys.length;

    // 3. Upsert the assignment
    const allInserts = assignedSkills.map(key => ({
      company_id: agent.company_id,
      agent_id: agent.id,
      skill_key: key,
      source: sharedKeys.includes(key) ? 'shared_skills' : 'company_skills'
    }));

    const { error } = await supabase
      .from('agent_skill_assignments')
      .upsert(allInserts, { onConflict: 'agent_id,skill_key' });

    if (error) {
      console.log(`  ✗ Database error: ${error.message}`);
    } else {
      console.log(`  ✓ Assigned ${assignedSkills.length} skills (${primaryMatch.length} primary + ${sharedKeys.length} shared)`);
    }

    // 4. Also update adapterConfig so UI reflects immediately
    const skillsJson = JSON.stringify(assignedSkills);
    const { error: updateError } = await supabase.rpc('update_agent_skills', {
      p_agent_id: agent.id,
      p_skills: skillsJson
    }).catch(() => ({ error: { message: 'RPC not available' } }));

    if (updateError?.message && updateError.message !== 'RPC not available') {
      console.log(`  ⚠ adapterConfig update: ${updateError.message}`);
    }
  }

  console.log('\n\n=== SUMMARY ===');
  console.log(`Agents processed: ${totalAgents}`);
  console.log(`Total primary assignments: ${totalPrimaryAssigned}`);
  console.log(`Total shared assignments: ${totalSharedAssigned}`);
  
  const { data: count } = await supabase
    .from('agent_skill_assignments')
    .select('count(*)');
  console.log(`Total rows in agent_skill_assignments: ${count?.[0]?.count || 0}`);

  if (totalAgents - totalPrimaryAssigned > 0) {
    console.log(`\n⚠ ${totalAgents - totalPrimaryAssigned} agents had no primary skill match — assigned shared skills only`);
  }
}

assignSkills().catch(err => {
  console.error('Fatal:', err);
  process.exit(1);
});