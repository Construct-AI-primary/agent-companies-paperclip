// Verify the agent order fix worked
// Run this in browser console on the DevForge page

console.log('=== AGENT ORDER FIX VERIFICATION ===');

// Check if localStorage key was cleared
const companyId = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';
const userId = 'local-board';
const storageKey = `paperclip.agentOrder:${companyId}:${userId}`;

const storedOrder = localStorage.getItem(storageKey);
console.log('Stored agent order:', storedOrder);

if (storedOrder) {
  console.log('❌ ERROR: Agent order still exists in localStorage!');
  console.log('Stored order contains', JSON.parse(storedOrder).length, 'agent IDs');
} else {
  console.log('✅ SUCCESS: Agent order cleared from localStorage');
}

// Check if React Query cache has the right data
if (window.queryClient) {
  const queries = window.queryClient.getQueryCache().getAll();
  const agentQueries = queries.filter(q =>
    q.queryKey && q.queryKey[0] === 'agents' && q.queryKey[1] === 'list'
  );

  agentQueries.forEach(query => {
    if (query.state.data) {
      console.log('✅ API cache has', query.state.data.length, 'agents');
    }
  });
}

// Check current useAgentOrder hook state
console.log('🔍 To check React component state:');
console.log('1. Open React DevTools');
console.log('2. Find useAgentOrder hook');
console.log('3. Check orderedAgents.length');
console.log('4. Should be 55 if fix worked');

console.log('=== VERIFICATION COMPLETE ===');
console.log('If localStorage is cleared but still only 5 agents show:');
console.log('- Hard refresh the page (Ctrl+Shift+R)');
console.log('- Check React DevTools for useAgentOrder state');