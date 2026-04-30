// Clear agent order for IntraForge AI specifically
// Run this in browser console when viewing IntraForge AI

console.log('=== CLEARING INTRAFORGE AI AGENT ORDER ===');

// IntraForge AI company ID from server logs
const companyId = '550e8400-e29b-41d4-a716-446655440008';
const userId = 'local-board';

console.log('Company ID:', companyId);

const storageKey = `paperclip.agentOrder:${companyId}:${userId}`;

console.log('Storage key:', storageKey);

// Clear the stored order
localStorage.removeItem(storageKey);
console.log('✅ Cleared IntraForge AI agent order from localStorage');

// Clear sessionStorage
sessionStorage.clear();
console.log('✅ Cleared sessionStorage');

// Clear React Query cache
if (window.queryClient) {
  window.queryClient.clear();
  console.log('✅ Cleared React Query cache');
}

console.log('🔄 Now refresh the IntraForge AI page to see all 10 agents!');
console.log('Expected result: 10 agents in alphabetical order (Felix, Gwen, Hugo, etc.)');