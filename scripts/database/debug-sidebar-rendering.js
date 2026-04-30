// Debug script to check SidebarAgents component rendering
// Run this in browser console on the DevForge page

// Check if SidebarAgents component is mounted
const sidebarAgentsElements = document.querySelectorAll('[class*="sidebar"], [class*="agent"]');
console.log('Sidebar elements found:', sidebarAgentsElements.length);

// Look for the agents section specifically
const agentsSection = Array.from(document.querySelectorAll('*')).find(el =>
  el.textContent && el.textContent.toLowerCase().includes('agents') &&
  el.tagName === 'SPAN' && el.className.includes('text-[10px]')
);
console.log('Agents section found:', agentsSection);

// Check if the collapsible content is visible
const collapsibleContent = agentsSection?.parentElement?.parentElement?.nextElementSibling;
console.log('Collapsible content:', collapsibleContent);
console.log('Collapsible content visible:', collapsibleContent?.style?.display !== 'none');

// Count agent links in the sidebar
const agentLinks = document.querySelectorAll('a[href*="/agents/"]');
console.log('Agent links found:', agentLinks.length);

// Log details of each agent link
agentLinks.forEach((link, index) => {
  console.log(`Agent ${index + 1}:`, {
    href: link.href,
    text: link.textContent?.trim(),
    visible: link.offsetWidth > 0 && link.offsetHeight > 0,
    display: window.getComputedStyle(link).display,
    visibility: window.getComputedStyle(link).visibility
  });
});

// Check if there are any hidden agent links
const hiddenAgentLinks = Array.from(agentLinks).filter(link =>
  window.getComputedStyle(link).display === 'none' ||
  window.getComputedStyle(link).visibility === 'hidden' ||
  link.offsetWidth === 0 || link.offsetHeight === 0
);
console.log('Hidden agent links:', hiddenAgentLinks.length);

// Check for any CSS issues with flexbox or overflow
const sidebarContainer = document.querySelector('[class*="sidebar"]');
if (sidebarContainer) {
  console.log('Sidebar container styles:', {
    height: window.getComputedStyle(sidebarContainer).height,
    overflow: window.getComputedStyle(sidebarContainer).overflow,
    display: window.getComputedStyle(sidebarContainer).display
  });
}

// Check if React DevTools shows the component state
console.log('To debug further:');
console.log('1. Open React DevTools');
console.log('2. Find SidebarAgents component');
console.log('3. Check orderedAgents array length');
console.log('4. Check if map() is working correctly');

// Try to access React internals if available
if (window.__REACT_DEVTOOLS_GLOBAL_HOOK__) {
  console.log('React DevTools available - use it to inspect SidebarAgents');
}

// Check for any error boundaries that might have caught errors
const errorBoundaries = document.querySelectorAll('[class*="error"], [data-error]');
console.log('Error boundaries found:', errorBoundaries.length);