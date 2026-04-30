// Debug script to check agent data quality and rendering issues
// Run this in browser console on the DevForge page

// Wait for React to load, then check agent data
setTimeout(() => {
  // Try to find agents data from React Query cache
  const queryClient = window.queryClient || window.__REACT_QUERY_CLIENT__;
  if (queryClient) {
    console.log('Found React Query client');

    // Get all queries
    const queries = queryClient.getQueryCache().getAll();
    const agentQueries = queries.filter(q =>
      q.queryKey && q.queryKey[0] === 'agents' && q.queryKey[1] === 'list'
    );

    agentQueries.forEach(query => {
      console.log('Agent query:', query.queryKey);
      console.log('Agent data:', query.state.data);
      if (query.state.data) {
        console.log('Agent count:', query.state.data.length);

        // Check for duplicates
        const ids = query.state.data.map(a => a.id);
        const uniqueIds = new Set(ids);
        console.log('Unique IDs:', uniqueIds.size, 'Total:', ids.length);
        if (uniqueIds.size !== ids.length) {
          console.log('DUPLICATE IDs FOUND!');
          const duplicates = ids.filter((id, index) => ids.indexOf(id) !== index);
          console.log('Duplicate IDs:', [...new Set(duplicates)]);
        }

        // Check agent data quality
        query.state.data.forEach((agent, index) => {
          const issues = [];
          if (!agent.id) issues.push('missing id');
          if (!agent.name) issues.push('missing name');
          if (!agent.status) issues.push('missing status');
          if (typeof agent.status !== 'string') issues.push('status not string');

          if (issues.length > 0) {
            console.log(`Agent ${index} (${agent.name || 'unnamed'}) issues:`, issues);
          }

          // Check if agentUrl would work
          try {
            // Simulate agentUrl logic
            const routeRef = agent.name ? agent.name.toLowerCase().replace(/\s+/g, '-') : agent.id;
            const url = `/DFA/agents/${routeRef}`;
            // This would be the href
          } catch (e) {
            console.log(`Agent ${index} URL generation error:`, e);
          }
        });
      }
    });
  } else {
    console.log('React Query client not found');
  }

  // Check if we can find the SidebarAgents component in DOM
  const sidebarElements = document.querySelectorAll('[class*="sidebar"]');
  console.log('Sidebar elements:', sidebarElements.length);

  // Look for the agents collapsible section
  const agentsHeaders = Array.from(document.querySelectorAll('*')).filter(el =>
    el.textContent && el.textContent.toLowerCase().trim() === 'agents' &&
    el.tagName === 'SPAN'
  );
  console.log('Agents headers found:', agentsHeaders.length);

  if (agentsHeaders.length > 0) {
    const agentsHeader = agentsHeaders[0];
    console.log('Agents header:', agentsHeader);

    // Find the parent collapsible
    let parent = agentsHeader.parentElement;
    while (parent && !parent.className.includes('collapsible')) {
      parent = parent.parentElement;
    }
    console.log('Collapsible parent:', parent);

    if (parent) {
      // Find the content area
      const content = parent.querySelector('[data-radix-collapsible-content]');
      console.log('Collapsible content:', content);

      if (content) {
        const links = content.querySelectorAll('a');
        console.log('Links in collapsible:', links.length);

        // Check if content is visible
        const style = window.getComputedStyle(content);
        console.log('Content visibility:', {
          display: style.display,
          visibility: style.visibility,
          height: style.height,
          maxHeight: style.maxHeight
        });
      }
    }
  }

  // Check for any console errors that might have occurred during rendering
  console.log('Checking for recent errors...');
  // This won't catch past errors, but we can check if new ones occur

}, 2000);