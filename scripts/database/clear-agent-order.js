// Clear stored agent order to fix sidebar showing only 5 agents
// Run this in browser console on the DevForge page

// Clear the stored agent order for DevForge AI
const companyId = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';
const userId = 'local-board';
const storageKey = `paperclip.agentOrder:${companyId}:${userId}`;

console.log('Clearing stored agent order for key:', storageKey);
localStorage.removeItem(storageKey);

console.log('Agent order cleared! Refresh the page to see all 55 agents.');
console.log('The agents will now be sorted alphabetically by default.');