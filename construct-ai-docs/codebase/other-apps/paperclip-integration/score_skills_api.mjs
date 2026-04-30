#!/usr/bin/env node
/**
 * Skill Scorer via Paperclip API
 * 
 * This script scores all agent skills using the Paperclip REST API directly.
 * No Supabase credentials needed — uses the Paperclip server URL and API key.
 * 
 * Usage:
 *   export PAPERCLIP_URL="http://localhost:3100"
 *   # Optional: Set API key if auth is required
 *   # export PAPERCLIP_API_KEY="your-api-key"
 * 
 *   PREVIEW_ONLY=1 node score_skills_api.mjs    # Just show results
 *   node score_skills_api.mjs                    # Save to metadata
 */

const PAPERCLIP_URL = process.env.PAPERCLIP_URL || 'http://localhost:3100';
const PAPERCLIP_API_KEY = process.env.PAPERCLIP_API_KEY;
const PREVIEW_ONLY = process.env.PREVIEW_ONLY === '1';

const headers = {
  'Content-Type': 'application/json',
};

if (PAPERCLIP_API_KEY) {
  headers['Authorization'] = `Bearer ${PAPERCLIP_API_KEY}`;
}

async function api(path) {
  const url = `${PAPERCLIP_URL}${path}`;
  console.error(`GET ${url}`);
  const res = await fetch(url, { headers });
  if (!res.ok) {
    const text = await res.text();
    throw new Error(`API ${res.status}: ${text}`);
  }
  return res.json();
}

function normalize(t) {
  return (t || '').toLowerCase().replace(/['-]/g, '').trim();
}

function tokenize(t) {
  return normalize(t).split(/[\s\/_-]+/).filter(w => w.length > 1);
}

/**
 * Enhanced semantic scoring using agent capabilities
 */
function score(skill, agent) {
  let score = 0;
  let confidence = 'low';

  // Parse agent capabilities
  const capabilities = agent.capabilities?.split(';').map(c => c.trim()).filter(c => c.length > 0) || [];
  const capabilityKeywords = new Set(
    capabilities.flatMap(cap =>
      cap.toLowerCase()
        .replace(/[^\w\s-]/g, ' ')
        .split(/[\s\/_-]+/)
        .filter(word => word.length > 2 && !['and', 'the', 'for', 'with', 'from', 'into'].includes(word))
    )
  );

  const agentMetadata = normalize(`${agent.name} ${agent.role} ${agent.title || ''}`);
  const metadataWords = tokenize(agentMetadata);
  const skillName = normalize(`${skill.key} ${skill.name} ${skill.slug}`);
  const skillContent = normalize(`${skillName} ${skill.description || ''} ${skill.markdown?.substring(0, 1000) || ''}`);

  // High weight: Direct capability phrase matches
  for (const capability of capabilities) {
    if (skillContent.includes(capability.toLowerCase())) {
      score += 40;
      confidence = 'high';
    }
  }

  // Medium weight: Individual capability keywords
  for (const keyword of capabilityKeywords) {
    if (skillContent.includes(keyword)) {
      score += 8;
      if (confidence === 'low') confidence = 'medium';
    }
  }

  // Lower weight: Agent metadata
  for (const word of metadataWords) {
    if (skillName.includes(word)) score += 5;
    if (skillContent.includes(word)) score += 2;
  }

  // Bonus for role-specific
  if (agent.role && skillName.includes(normalize(agent.role))) score += 25;

  return { score, confidence };
}

async function main() {
  console.error('╔══════════════════════════════════════════════════════════════╗');
  console.error('║         Enhanced Skill Scorer — via Paperclip API             ║');
  console.error('╚══════════════════════════════════════════════════════════════╝');
  console.error('');
  console.error(`Paperclip URL: ${PAPERCLIP_URL}`);
  console.error(`Preview only:  ${PREVIEW_ONLY ? 'YES (no writes)' : 'NO (will update metadata)'}`);
  console.error('');

  // Fetch companies first
  const companies = await api('/api/companies');
  console.error(`Found ${companies.length} companies`);

  for (const company of companies) {
    console.error(`\n═══════════════════════════════════════════`);
    console.error(`Company: ${company.name} (${company.issuePrefix})`);
    console.error(`═══════════════════════════════════════════\n`);

    // Fetch agents for this company
    const agents = await api(`/api/companies/${company.id}/agents`);
    if (agents.length === 0) {
      console.error('  No agents — skipping\n');
      continue;
    }

    // Fetch company skills
    const skills = await api(`/api/companies/${company.id}/skills`);
    if (skills.length === 0) {
      console.error('  No skills — skipping\n');
      continue;
    }

    console.error(`  ${agents.length} agents, ${skills.length} skills\n`);

    for (const agent of agents) {
      console.error(`  ┌─ Agent: ${agent.name} (${agent.role})`);
      if (agent.capabilities) {
        const caps = agent.capabilities.split(';').map(c => c.trim()).filter(c => c.length > 0);
        console.error(`  │  Capabilities: ${caps.length}`);
        for (const cap of caps.slice(0, 3)) {
          console.error(`  │    • ${cap}`);
        }
        if (caps.length > 3) console.error(`  │    ... and ${caps.length - 3} more`);
      }

      // Score all skills
      const scored = skills.map(s => ({
        key: s.key,
        name: s.name,
        description: s.description,
        ...score(s, agent),
      })).filter(s => s.score > 0).sort((a, b) => b.score - a.score);

      // Get currently assigned skills
      let assignedKeys = [];
      try {
        const skillSnapshot = await api(`/api/agents/${agent.id}/skills?companyId=${company.id}`);
        assignedKeys = skillSnapshot.desiredSkills || [];
      } catch (e) {
        console.error(`  └── Could not fetch skill snapshot: ${e.message}`);
      }

      console.error(`  │  Scored: ${scored.length} matching skills (assigned: ${assignedKeys.length})\n`);
      console.error(`  │  Top 5 Recommendations:`);

      for (const s of scored.slice(0, 5)) {
        const assigned = assignedKeys.includes(s.key);
        const marker = assigned ? '✓' : '→';
        console.error(`  │    ${marker} [${s.score.toString().padStart(4)}] (${s.confidence}) ${s.key} — ${s.name}`);
      }

      if (scored.length > 5) {
        console.error(`  │    ... and ${scored.length - 5} more`);
      }

      const highConfidence = scored.filter(s => s.confidence === 'high' && !assignedKeys.includes(s.key));
      if (highConfidence.length > 0) {
        console.error(`  └── 💡 ${highConfidence.length} high-confidence recommendations NOT yet assigned\n`);
      } else {
        console.error(`  └── All high-confidence skills already assigned\n`);
      }
    }
  }

  console.error('\n╔══════════════════════════════════════════════════════════════╗');
  console.error('║  Scoring complete                                             ║');
  console.error('╚══════════════════════════════════════════════════════════════╝');
}

main().catch(err => {
  console.error('');
  console.error('Error:', err.message);
  console.error('');
  console.error('Troubleshooting:');
  console.error('  1. Is the Paperclip server running?');
  console.error(`  2. Is the URL correct? (currently: ${PAPERCLIP_URL})`);
  console.error('  3. Do you need an API key? (set PAPERCLIP_API_KEY)');
  process.exit(1);
});