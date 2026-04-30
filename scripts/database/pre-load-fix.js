// PRE-LOAD FIX: Clear agent order BEFORE page loads
// Create a bookmarklet from this code and run it BEFORE navigating to the DevForge page

javascript:(function(){
  // Clear localStorage agent order
  const companyId = 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4';
  const userId = 'local-board';
  const storageKey = `paperclip.agentOrder:${companyId}:${userId}`;

  localStorage.removeItem(storageKey);
  console.log('✅ Cleared agent order from localStorage');

  // Clear sessionStorage
  sessionStorage.clear();
  console.log('✅ Cleared sessionStorage');

  // Clear any existing query cache
  if (window.queryClient) {
    window.queryClient.clear();
    console.log('✅ Cleared React Query cache');
  }

  // Force reload current page
  window.location.reload(true);
})();