// Debug script to check agent API responses
// Run this in browser console on the DevForge page

// Check if we're on the right page
console.log('Current URL:', window.location.href);
console.log('Page title:', document.title);

// Check for any JavaScript errors
window.onerror = function(msg, url, line, col, error) {
  console.error('JavaScript Error:', msg, 'at', url, ':', line, ':', col);
  console.error('Error object:', error);
};

// Check API endpoints
const apiBase = 'http://127.0.0.1:3100/api';

// Test health endpoint
fetch(apiBase + '/health')
  .then(r => r.json())
  .then(data => console.log('Health check:', data))
  .catch(err => console.error('Health check failed:', err));

// Test companies endpoint
fetch(apiBase + '/companies')
  .then(r => r.json())
  .then(data => {
    console.log('Companies:', data);
    // Find DevForge
    const devforge = data.find(c => c.name === 'DevForge AI');
    if (devforge) {
      console.log('DevForge company found:', devforge);

      // Test agents endpoint for DevForge
      return fetch(apiBase + '/companies/' + devforge.id + '/agents');
    }
  })
  .then(r => r ? r.json() : null)
  .then(agents => {
    if (agents) {
      console.log('DevForge agents count:', agents.length);
      console.log('First 10 agents:', agents.slice(0, 10));

      // Check status distribution
      const statusCounts = agents.reduce((acc, agent) => {
        acc[agent.status] = (acc[agent.status] || 0) + 1;
        return acc;
      }, {});
      console.log('Agent status distribution:', statusCounts);

      // Check for any agents with problematic data
      const problematic = agents.filter(a =>
        !a.name || !a.status || typeof a.status !== 'string'
      );
      console.log('Problematic agents:', problematic);
    }
  })
  .catch(err => console.error('API test failed:', err));

// Check local storage/session storage
console.log('Local storage keys:', Object.keys(localStorage));
console.log('Session storage keys:', Object.keys(sessionStorage));

// Check if there are any React errors
const reactRoot = document.getElementById('root');
if (reactRoot) {
  console.log('React root found');
} else {
  console.log('React root NOT found - this could be the issue');
}

// Check for any error boundaries or error messages in DOM
const errorElements = document.querySelectorAll('[class*="error"], [id*="error"]');
console.log('Error elements found:', errorElements.length);
errorElements.forEach(el => console.log('Error element:', el));