const fs = require('fs');
const path = require('path');

function addYAMLFrontmatter(agentsMdPath, companyName) {
  const content = fs.readFileSync(agentsMdPath, 'utf8');

  // Check if YAML frontmatter already exists
  if (content.startsWith('---')) {
    console.log(`Skipping ${agentsMdPath} - already has YAML frontmatter`);
    return;
  }

  // Extract agent information from the content
  const nameMatch = content.match(/\*\*Name\*\*: ([^\n]+)/);
  const roleMatch = content.match(/\*\*Role\*\*: ([^\n]+)/);

  if (!nameMatch || !roleMatch) {
    console.log(`Skipping ${agentsMdPath} - missing required fields in content`);
    return;
  }

  const agentName = nameMatch[1].trim();
  const agentRole = roleMatch[1].trim();

  // Create kebab-case name for YAML
  const yamlName = agentName.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '');

  // Create YAML frontmatter
  const yamlFrontmatter = `---
name: ${yamlName}
role: ${agentRole}
---

`;

  // Add YAML frontmatter to the beginning of the file
  const newContent = yamlFrontmatter + content;

  fs.writeFileSync(agentsMdPath, newContent);
  console.log(`Added YAML frontmatter to: ${path.basename(path.dirname(agentsMdPath))}`);
}

function processCompany(companyPath, companyName) {
  const agentsDir = path.join(companyPath, 'agents');

  if (!fs.existsSync(agentsDir)) {
    console.log(`No agents directory for ${companyName}`);
    return;
  }

  const agentDirs = fs.readdirSync(agentsDir, { withFileTypes: true })
    .filter(dirent => dirent.isDirectory())
    .map(dirent => path.join(agentsDir, dirent.name));

  let processed = 0;

  for (const agentDir of agentDirs) {
    const agentsMdPath = path.join(agentDir, 'AGENTS.md');

    if (fs.existsSync(agentsMdPath)) {
      addYAMLFrontmatter(agentsMdPath, companyName);
      processed++;
    }
  }

  console.log(`Processed ${processed} agents for ${companyName}`);
}

// Process remaining companies
const companies = [
  { path: 'docs-paperclip/companies/learningforge-ai', name: 'LearningForge AI' },
  { path: 'docs-paperclip/companies/contentforge-ai', name: 'ContentForge AI' },
  { path: 'docs-paperclip/companies/infraforge-ai', name: 'InfraForge AI' }
];

for (const company of companies) {
  console.log(`\n=== Processing ${company.name} ===`);
  processCompany(company.path, company.name);
}

console.log('\n=== YAML Frontmatter Addition Complete ===');