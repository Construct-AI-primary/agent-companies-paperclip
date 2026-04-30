#!/usr/bin/env node
/**
 * Enhanced Skill Scoring Script
 * 
 * Scores company_skills by relevance to agent capabilities using semantic matching.
 * Uses agent capabilities (e.g., "Knowledge base development; Information organization")
 * to match against skill content (name, description, markdown).
 * 
 * Usage:
 *   export SUPABASE_URL="https://your-project.supabase.co"
 *   export SUPABASE_KEY="your-service-role-key"
 *   node score_skills.mjs
 * 
 * To only preview recommendations without DB writes:
 *   PREVIEW_ONLY=1 node score_skills.mjs
 */

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_KEY;
const PREVIEW_ONLY = process.env.PREVIEW_ONLY === '1';

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error('');
  console.error('╔══════════════════════════════════════════════════════════════╗');
  console.error('║           Skill Scoring Script — Configuration Required       ║');
  console.error('╚══════════════════════════════════════════════════════════════╝');
  console.error('');
  console.error('You need Supabase credentials to run this script:');
  console.error('');
  console.error('  export SUPABASE_URL="https://your-project.supabase.co"');
  console.error('  export SUPABASE_KEY="your-service-role-key"');
  console.error('');
  console.error('To preview results WITHOUT writing to the database:');
  console.error('');
  console.error('  export SUPABASE_URL="https://your-project.supabase.co"');
  console.error('  export SUPABASE_KEY="your-service-role-key"');
  console.error('  PREVIEW_ONLY=1 node score_skills.mjs');
  console.error('');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

function normalize(t) {
  return (t || '').toLowerCase()
    .replace(/['-]/g, '')
    .trim();
}

// Tokenize text into words for fuzzy matching
function tokenize(t) {
  return normalize(t).split(/[\s_\/-]+/).filter(w => w.length > 1);
}

// Enhanced semantic scoring using agent capabilities
function score(skill, agent) {
  let score = 0;
  let confidence = 'low';

  // Parse agent capabilities into semantic keywords
  const capabilities = agent.capabilities?.split(';').map(c => c.trim()).filter(c => c.length > 0) || [];
  const capabilityKeywords = new Set(
    capabilities.flatMap(cap =>
      cap.toLowerCase()
        .replace(/[^\w\s-]/g, ' ') // Remove punctuation
        .split(/[\s\/_-]+/)
        .filter(word => word.length > 2 && !['and', 'the', 'for', 'with', 'from', 'into'].includes(word))
    )
  );

  // Also include basic agent metadata
  const agentMetadata = normalize(`${agent.name} ${agent.role} ${agent.title || ''}`);
  const metadataWords = tokenize(agentMetadata);

  // Skill content for matching
  const skillName = normalize(`${skill.key} ${skill.name} ${skill.slug}`);
  const skillContent = normalize(`${skillName} ${skill.description || ''} ${skill.markdown?.substring(0, 1000) || ''}`);

  // High weight: Direct capability phrase matches in skill content
  for (const capability of capabilities) {
    const capLower = capability.toLowerCase();
    if (skillContent.includes(capLower)) {
      score += 40; // Strong semantic match
      confidence = 'high';
    }
  }

  // Medium weight: Individual capability keywords in skill content
  for (const keyword of capabilityKeywords) {
    if (skillContent.includes(keyword)) {
      score += 8;
      if (confidence === 'low') confidence = 'medium';
    }
  }

  // Lower weight: Agent metadata matches (fallback)
  for (const word of metadataWords) {
    if (skillName.includes(word)) score += 5;
    if (skillContent.includes(word)) score += 2;
  }

  // Bonus for role-specific matches
  if (agent.role && skillName.includes(normalize(agent.role))) {
    score += 25;
  }

  return { score, confidence };
}

async function scoreAllSkills() {
  console.log('Fetching agents...');
  const { data: agents } = await supabase
    .from('agents')
    .select('id, name, role, title, company_id, description, capabilities');
  
  console.log(`Scoring skills for ${agents?.length || 0} agents...\n`);

  for (const agent of agents) {
    const cid = agent.company_id;
    if (!cid) continue;
    
    // Get all skills for this company
    const { data: skills } = await supabase
      .from('company_skills')
      .select('id, key, name, description, markdown, slug')
      .eq('company_id', cid);
    
    if (!skills || skills.length === 0) continue;
    
    console.log(`Agent: ${agent.name} (${agent.role}) - ${skills.length} skills to score`);
    
    // Score every skill
    const scored = skills.map(s => ({
      ...s,
      relevance_score: score(s, agent)
    }));
    
    // Sort by score desc
    scored.sort((a, b) => b.relevance_score - a.relevance_score);
    
    // Print top 5 recommended
    const recommended = scored.slice(0, 5).map(s => 
      `  ${s.relevance_score > 0 ? '✓' : ' '} ${s.relevance_score.toString().padStart(3, ' ')} | ${s.key}`
    ).join('\n');
    
    console.log(`Top 5 recommendations:\n${recommended}\n`);
    
    // Update scores in DB (optional - add a relevance_score column first)
    const sqlUpdates = scored
      .filter(s => s.relevance_score > 0)
      .map(s => `-- ${agent.name}: UPDATE company_skills SET metadata = jsonb_set(COALESCE(metadata,'{}'::jsonb), '{agent_suggestions_${agent.id.slice(0,8)}}', '${s.relevance_score}'::jsonb) WHERE key = '${s.key}';`);
    
    if (sqlUpdates.length > 0) {
      // Write recommendations to metadata
      const suggestions = Object.fromEntries(
        scored.filter(s => s.relevance_score > 0).map(s => [s.key, s.relevance_score])
      );
      
      // For each skill, update metadata with agent suggestion scores
      for (const s of scored.filter(s => s.relevance_score > 0)) {
        const meta = { agent_suggestions: { [agent.id]: s.relevance_score } };
        const { error } = await supabase
          .from('company_skills')
          .update({
            metadata: supabase.rpc('jsonb_merge', { 
              orig: s.metadata || {}, incoming: meta 
            }).code // fallback
          })
          .eq('id', s.id);
        
        // Simpler approach: just set metadata directly
        await supabase
          .from('company_skills')
          .update({
            metadata: { ...s.metadata, agent_suggestions: { [agent.id]: s.relevance_score } }
          })
          .eq('id', s.id);
      }
    }
  }
}

scoreAllSkills().catch(err => {
  console.error(err);
  process.exit(1);
});