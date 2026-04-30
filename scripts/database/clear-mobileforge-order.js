// Clear agent order for MobileForge AI specifically
// Run this in browser console when viewing MobileForge AI

console.log('=== CLEARING MOBILEFORGE AI AGENT ORDER ===');

// Find MobileForge AI company ID
// You can get this from the URL or by inspecting the company selector
// For now, we'll try common patterns or you can replace with the actual ID

// Option 1: Try to find it from the current page
const currentCompanyId = window.location.pathname.split('/')[2];
console.log('Current company ID:', currentCompanyId);

// Option 2: If not on a company page, you'll need to replace this with the actual MobileForge AI company ID
// You can find it by:
// 1. Going to MobileForge AI page
// 2. Checking window.location.pathname.split('/')[2]
// 3. Or inspecting the company selector dropdown

const mobileforgeCompanyId = currentCompanyId || 'REPLACE_WITH_ACTUAL_MOBILEFORGE_COMPANY_ID';
const userId = 'local-board';

console.log('Using company ID:', mobileforgeCompanyId);

const storageKey = `paperclip.agentOrder:${mobileforgeCompanyId}:${userId}`;

console.log('Storage key:', storageKey);

// Clear the stored order
localStorage.removeItem(storageKey);
console.log('✅ Cleared MobileForge AI agent order from localStorage');

// Clear sessionStorage
sessionStorage.clear();
console.log('✅ Cleared sessionStorage');

// Clear React Query cache
if (window.queryClient) {
  window.queryClient.clear();
  console.log('✅ Cleared React Query cache');
}

console.log('🔄 Now refresh the MobileForge AI page to see all 10 agents!');
console.log('Expected result: 10 agents in alphabetical order');