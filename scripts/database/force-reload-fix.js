// Force complete reload and clear all caches
// Run this in browser console, then refresh the page

console.log('=== FORCE RELOAD FIX ===');

// Clear localStorage
const companyId = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';
const userId = 'local-board';
const storageKey = `paperclip.agentOrder:${companyId}:${userId}`;

localStorage.removeItem(storageKey);
console.log('✅ Cleared localStorage agent order');

// Clear sessionStorage
sessionStorage.clear();
console.log('✅ Cleared sessionStorage');

// Clear any React Query cache
if (window.queryClient) {
  window.queryClient.clear();
  console.log('✅ Cleared React Query cache');
}

// Force hard reload
console.log('🔄 Forcing hard reload in 2 seconds...');
setTimeout(() => {
  window.location.reload(true);
}, 2000);