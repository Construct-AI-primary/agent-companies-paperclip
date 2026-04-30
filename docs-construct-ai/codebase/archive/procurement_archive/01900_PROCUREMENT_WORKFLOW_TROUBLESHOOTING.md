---
memory_layer: durable_knowledge
para_section: pages/codebase/workflows
gigabrain_tags: workflows, codebase, automation
documentation
openstinger_context: workflow-automation, process-management
last_updated: 2026-03-21
related_docs:
  - codebase/workflows/
  - disciplines/
---
# Procurement Document Generation Workflow - Troubleshooting Guide

## 🐛 **Critical User Assignment Debugging Guide**

**⚠️ MOST COMMON ISSUE**: User assignments not working during procurement order creation

### **Symptom 1: "0 users available" in CreateOrderModal**
```
🔍 DEBUG: UserSelector for appendix_a - 0 users available
```

**Root Causes & Solutions:**

**A. Missing `disciplines` Array on User Objects**
- **Debug**: Check browser console for `[FILTER_DEBUG] first user disciplines: undefined`
- **Cause**: User objects from API don't have `disciplines` property
- **Solution**: Ensure `CreateOrderModal.loadUsersForDisciplines()` adds disciplines array:
```javascript
const usersWithDisciplines = uniqueUsers.map(user => ({
  ...user,
  disciplines: Array.from(assignedDisciplineNames) // Add discipline names
}));
```

**B. Discipline ID vs Name Matching Issues**
- **Debug**: Check console for `[FILTER_DEBUG] assignedDisciplineNames: ["Finance", "Sundry"]`
- **Cause**: Assigned disciplines are IDs, user disciplines are names
- **Solution**: Convert IDs to names before filtering:
```javascript
const assignedDisciplineNames = assignedDisciplines.map(disciplineId => {
  const discipline = allDisciplines.find(d => d.id === disciplineId);
  return discipline ? discipline.name : disciplineId;
});
```

### **Symptom 2: User Cards Not Clickable**
```
No [CREATE_ORDER_MODAL] User assignment change logs in console
```

**Debug Steps**:
1. **Check UserSelector Rendering**: Look for red-bordered debug box with yellow text
2. **Verify Component Props**: Ensure `onUserAssignment` prop is passed correctly
3. **Check Click Handlers**: Verify `handleUserToggle` is called on label click
4. **Inspect Element**: Check if CSS `pointer-events` or `z-index` blocking clicks

### **Symptom 3: Users Assigned But No Tasks Created**
```
Order created successfully but no tasks in MyTasksDashboard
```

**Debug Steps**:
1. **Check Order Data**: Verify `user_assignments` object has actual user IDs
2. **Verify Task Creation**: Check server logs for task creation during order submission
3. **Database Check**: Query tasks table for `business_object_id = order_id`
4. **User Permissions**: Ensure development mode bypass allows null `assigned_to`

## 📋 **Comprehensive User Assignment Debug Checklist**

**Client-Side Debugging:**
```javascript
// Add to CreateOrderModal for debugging
console.log('[DEBUG] userAssignments state:', userAssignments);
console.log('[DEBUG] availableUsers:', availableUsers);
console.log('[DEBUG] allDisciplines:', allDisciplines);
```

**Server-Side Debugging:**
```javascript
// Add to createProcurementOrder function
console.log('[SERVER] user_assignments received:', user_assignments);
console.log('[SERVER] Creating tasks for users:', Object.values(user_assignments).flat());
```

**Database Verification:**
```sql
-- Check if tasks were created
SELECT * FROM tasks WHERE business_object_id = 'order-uuid' AND task_type = 'appendix_contribution';

-- Check user-discipline relationships
SELECT * FROM user_discipline_access WHERE organization_id = '90cd635a-380f-4586-a3b7-a09103b6df94';
```

---

## 🔧 **Chatbot Workflow Streaming Issues (NEW - 2026-01-28)**

### **Symptom 1: Chatbot doesn't open or messages don't appear**
```
[PROCUREMENT_SUBMIT] 🤖 Opening chatbot for workflow streaming...
[CHATBOT_DISPATCHER] Initializing chatbot message listener...
[CHATBOT_DISPATCHER] ✅ Chatbot dispatcher initialized on window
[SEQUENTIAL_STREAMING] 🚀 Starting agent workflow streaming...
```
**But chatbot remains empty or doesn't open**

**Root Causes & Solutions:**

**A. Chatbot Dispatcher Not Initialized**
- **Debug**: Check console for `[CHATBOT_DISPATCHER]` initialization messages
- **Cause**: `useEffect` hook in PurchaseOrdersPage not running on component mount
- **Solution**: Verify `useEffect` dependency array includes empty array `[]` for mount-only execution

**B. Chatbot Component Not Listening for Events**
- **Debug**: Add event listener check in ProcurementChatbot component
- **Cause**: Chatbot component doesn't listen for `chatbotMessage` custom events
- **Solution**: Implement event listener in ProcurementChatbot:
```javascript
useEffect(() => {
  const handleChatbotMessage = (event) => {
    const { message, discipline, source } = event.detail;
    if (discipline === 'procurement' && source === 'procurement_workflow') {
      addMessage(message, 'assistant');
    }
  };
  
  document.addEventListener('chatbotMessage', handleChatbotMessage);
  return () => document.removeEventListener('chatbotMessage', handleChatbotMessage);
}, []);
```

**C. Modal Doesn't Close or Chatbot Doesn't Open**
- **Debug**: Check modal state changes in console
- **Cause**: `setShowCreateModal(false)` not called or chatbot visibility logic broken
- **Solution**: Verify modal closes and chatbot opens:
```javascript
// In handleSubmit, after form submission:
setShowCreateModal(false); // Close modal immediately
setTimeout(() => {
  // Open chatbot or ensure it's visible
  const chatbotContainer = document.querySelector('.chatbot-container, .procurement-chatbot');
  if (chatbotContainer) {
    chatbotContainer.scrollIntoView({ behavior: 'smooth' });
  }
}, 100);
```

### **Symptom 2: Messages appear but out of order or with incorrect timing**
```
Agent 3 completes before Agent 1
Processing times not displayed
```

**Debug Steps:**
1. **Check Timing Delays**: Verify agent delays are correctly set (800ms, 700ms, etc.)
2. **Async/Await Issues**: Ensure `await new Promise(resolve => setTimeout(resolve, delay))` is properly awaited
3. **Race Conditions**: Check if multiple agents execute simultaneously due to missing await

**Solutions:**
```javascript
// In startSequentialAgentStreaming function:
for (const agent of agents) {
  // Send activation message
  window.chatbotDispatcher.dispatchMessage(`**${agent.name} Activated**...`, 'procurement');
  
  // Wait for processing delay (AWAIT is critical!)
  await new Promise(resolve => setTimeout(resolve, agent.delay));
  
  // Send completion message
  window.chatbotDispatcher.dispatchMessage(`**${agent.name} Completed** ✅...`, 'procurement');
  
  // Wait before next agent
  await new Promise(resolve => setTimeout(resolve, 400));
}
```

### **Symptom 3: Messages show but processing times are missing or incorrect**
```
Agent messages show completion but no "⏱️ **Processing time:**" line
Processing times show as 0ms or unrealistic values
```

**Debug Steps:**
1. **Check Agent Data Structure**: Verify each agent has `delay` property
2. **Mock Data Generation**: Ensure random metrics are generated correctly
3. **Message Formatting**: Check if processing time is included in message string

**Solutions:**
```javascript
// In agent completion message generation:
const completionMessage = `
**${agent.name} Completed** ✅

📊 **Results:**
- Template compatibility score: ${Math.floor(Math.random() * 15) + 85}%
- Requirements extracted: ${Math.floor(Math.random() * 20) + 40}
- Compliance checks: ${Math.floor(Math.random() * 5) + 10}
- Fields populated: ${Math.floor(Math.random() * 30) + 70}
- Quality score: ${Math.floor(Math.random() * 10) + 90}%
- Documents prepared: ${Math.floor(Math.random() * 6) + 1}
- Specialists assigned: ${Math.floor(Math.random() * 5) + 3}

⏱️ **Processing time:** ${agent.delay}ms

---

`;
```

### **Symptom 4: Chatbot doesn't open at all - modal stays open or page redirects**
```
User clicks "Create" but nothing happens or page reloads
```

**Debug Steps:**
1. **Check Form Submit Handler**: Verify `handleSubmit` prevents default form submission
2. **Check Modal State**: Ensure modal closes after form submission
3. **Check Event Propagation**: Verify no event propagation issues

**Solutions:**
```javascript
// In CreateOrderModal form submission:
const handleSubmit = async (e) => {
  e.preventDefault(); // CRITICAL: Prevent default form submission
  e.stopPropagation(); // Stop event propagation
  
  // Show loading state
  setLoading(true);
  
  try {
    // Call parent handleSubmit
    await props.handleSubmit(e, formData);
    
    // Modal should close via props.onHide() or setShowCreateModal(false)
    // Chatbot should open via window.chatbotDispatcher
    
  } catch (error) {
    console.error('Form submission error:', error);
  } finally {
    setLoading(false);
  }
};
```

### **Symptom 5: Event-based communication not working between components**
```
[CHATBOT_DISPATCHER] Dispatching message to procurement chatbot
[CHATBOT_DISPATCHER] Found chatbot container, attempting direct message injection...
But no messages appear in chatbot
```

**Debug Steps:**
1. **Check Event Listener**: Verify chatbot component has event listener for `chatbotMessage`
2. **Check Event Detail**: Verify event.detail contains correct message data
3. **Check Component Mount**: Ensure chatbot component is mounted when events are dispatched

**Solutions:**
```javascript
// In ProcurementChatbot component (or wherever chatbot is rendered):
useEffect(() => {
  console.log('[CHATBOT] Event listener mounted');
  
  const handleChatbotMessage = (event) => {
    console.log('[CHATBOT] Event received:', event.detail);
    const { message, discipline, source, timestamp } = event.detail;
    
    if (discipline === 'procurement' && source === 'procurement_workflow') {
      console.log('[CHATBOT] Adding message to conversation');
      // Add message to chatbot conversation
      addMessageToConversation(message, 'assistant');
    }
  };
  
  // Listen with capture phase to catch events early
  document.addEventListener('chatbotMessage', handleChatbotMessage, true);
  
  return () => {
    document.removeEventListener('chatbotMessage', handleChatbotMessage, true);
  };
}, [addMessageToConversation]);
```

### **Symptom 6: Chatbot opens but messages are formatted incorrectly or missing markdown**
```
Messages appear as plain text without bold, emojis, or formatting
```

**Debug Steps:**
1. **Check Message Rendering**: Verify chatbot supports markdown rendering
2. **Check Message Format**: Ensure messages use markdown syntax (bold `**text**`, lists `- item`, etc.)
3. **Check CSS**: Verify chatbot container has proper styling for formatted text

**Solutions:**
```javascript
// In chatbot message rendering component:
function ChatMessage({ message }) {
  // Use markdown parser if available
  const html = marked.parse(message); // or similar
  
  return (
    <div className="chat-message assistant">
      <div className="message-content" dangerouslySetInnerHTML={{ __html: html }} />
    </div>
  );
}

// Or use a markdown library:
import ReactMarkdown from 'react-markdown';

function ChatMessage({ message }) {
  return (
    <div className="chat-message assistant">
      <ReactMarkdown>{message}</ReactMarkdown>
    </div>
  );
}
```

### **Symptom 7: Sequential streaming stops after a few agents**
```
Agent 1 completes, Agent 2 starts, then stops
Console shows errors or promises not resolving
```

**Debug Steps:**
1. **Check Async/Await**: Ensure all delays use `await`
2. **Check Promise Resolution**: Verify `setTimeout` promises are resolving
3. **Check Error Handling**: Wrap each agent in try-catch
4. **Check Browser Console**: Look for unhandled promise rejections

**Solutions:**
```javascript
// In startSequentialAgentStreaming with error handling:
for (const agent of agents) {
  try {
    // Send activation
    window.chatbotDispatcher.dispatchMessage(`**${agent.name} Activated**...`, 'procurement');
    
    // Wait with error handling
    await new Promise((resolve, reject) => {
      const timeout = setTimeout(resolve, agent.delay);
      // Optional: Add timeout cleanup
    });
    
    // Send completion
    window.chatbotDispatcher.dispatchMessage(`**${agent.name} Completed** ✅...`, 'procurement');
    
    // Wait between agents
    await new Promise(resolve => setTimeout(resolve, 400));
    
  } catch (error) {
    console.error(`Error in ${agent.name}:`, error);
    // Send error message to chatbot
    window.chatbotDispatcher.dispatchMessage(
      `❌ **${agent.name} Failed:** ${error.message}`,
      'procurement'
    );
    // Continue to next agent or break based on error severity
  }
}
```

### **Symptom 8: Multiple chatbots on page - messages appear in wrong chatbot**
```
Page has multiple chatbot instances (Procurement, General, etc.)
Messages intended for Procurement appear in General chatbot
```

**Debug Steps:**
1. **Check Discipline Filtering**: Verify events are filtered by `discipline` property
2. **Check Chatbot Identification**: Ensure each chatbot has unique identifier
3. **Check Event Bubbling**: Events may bubble to multiple listeners

**Solutions:**
```javascript
// In each chatbot component, filter by discipline:
useEffect(() => {
  const handleChatbotMessage = (event) => {
    const { message, discipline, source, targetChatbotId } = event.detail;
    
    // Check if message is for this specific chatbot
    if (targetChatbotId && targetChatbotId !== thisChatbotId) {
      return; // Not for this chatbot
    }
    
    // Check discipline match
    if (discipline === 'procurement' && source === 'procurement_workflow') {
      addMessage(message, 'assistant');
    }
  };
  
  document.addEventListener('chatbotMessage', handleChatbotMessage);
  return () => document.removeEventListener('chatbotMessage', handleChatbotMessage);
}, []);
```

**Alternative: Use chatbot-specific dispatch method:**
```javascript
// In window.chatbotDispatcher:
window.chatbotDispatcher.dispatchToProcurementChatbot = (message) => {
  const event = new CustomEvent('chatbotMessage', {
    detail: {
      message,
      discipline: 'procurement',
      source: 'procurement_workflow',
      targetChatbotId: 'procurement-chatbot-01'
    }
  });
  document.dispatchEvent(event);
};
```

### **Symptom 9: Performance issues - streaming causes browser slowdown**
```
Browser becomes sluggish during sequential streaming
High CPU usage during agent execution
```

**Debug Steps:**
1. **Check Agent Delays**: Ensure delays are reasonable (100-1000ms)
2. **Check Message Rendering**: Verify chatbot doesn't re-render entire conversation on each message
3. **Check Memory Leaks**: Ensure event listeners are cleaned up

**Solutions:**
```javascript
// Optimize message rendering:
function ChatbotComponent() {
  const [messages, setMessages] = useState([]);
  
  // Batch updates if needed
  const addMessage = useCallback((message, type) => {
    setMessages(prev => [...prev, { message, type, id: Date.now() }]);
  }, []);
  
  // Use React.memo for message components
  const ChatMessage = React.memo(({ message }) => {
    return <div className="message">{message}</div>;
  });
  
  // Virtual scrolling for large message lists
  // (if chatbot supports many messages)
}

// Optimize event dispatch:
window.chatbotDispatcher.dispatchMessage = (message, discipline) => {
  // Use requestAnimationFrame to avoid blocking
  requestAnimationFrame(() => {
    const event = new CustomEvent('chatbotMessage', {
      detail: { message, discipline, timestamp: Date.now() },
      bubbles: true
    });
    document.dispatchEvent(event);
  });
};
```

### **Symptom 10: Streaming doesn't work in production build**
```
Works in development but not in production build
Errors about CustomEvent or async/await
```

**Debug Steps:**
1. **Check Browser Compatibility**: Production build may have different polyfills
2. **Check Build Configuration**: Ensure async/await is transpiled correctly
3. **Check Error Logs**: Look for production-specific errors

**Solutions:**
```javascript
// Check if CustomEvent is supported (polyfill if needed)
if (typeof CustomEvent === 'function') {
  // Use CustomEvent
  const event = new CustomEvent('chatbotMessage', { detail: data });
  document.dispatchEvent(event);
} else {
  // Fallback: Create custom event manually
  const event = document.createEvent('CustomEvent');
  event.initCustomEvent('chatbotMessage', true, true, data);
  document.dispatchEvent(event);
}

// Ensure async/await is transpiled:
// In babel.config.js or webpack.config.js:
module.exports = {
  presets: [
    ['@babel/preset-env', {
      targets: {
        browsers: ['last 2 versions', 'not dead']
      }
    }]
  ]
};
```

## 📋 **Chatbot Workflow Streaming Debug Checklist**

**Client-Side Debugging:**
```javascript
// Add to PurchaseOrdersPage for debugging
console.log('[DEBUG] Chatbot dispatcher initialized:', window.chatbotDispatcher ? 'YES' : 'NO');
console.log('[DEBUG] Modal state after submit:', showCreateModal);
console.log('[DEBUG] Chatbot container visible:', document.querySelector('.procurement-chatbot') ? 'YES' : 'NO');
```

**Browser Console Checks:**
```javascript
// Check if event listeners are registered
getEventListeners(document);

// Check if custom events are firing
monitorEvents(document

## 🔄 **SOW Association Modal State Persistence**

- **Symptom**: Previously assigned users not displayed when reopening "Associate SOW with Procurement Order" modal
- **Cause**: User assignments, appendices, and notes were not being persisted to database or retrieved when reopening modal
- **Solution**: Fixed backend to store user assignments in `discipline_assignments.sow_association` JSONB field and frontend to load existing data on modal open

## 📋 **Task Assignment Issues**

- **Symptom**: Tasks not appearing in dashboard
- **Cause**: User discipline assignments incorrect
- **Solution**: Verify user_management.disciplines array matches task.discipline

## ⚖️ **Approval Routing Problems**

- **Symptom**: Approvals stuck or not routing correctly
- **Cause**: Approval matrix configuration errors
- **Solution**: Validate approval_config.approvalMatrix structure

## 📄 **Document Assembly Failures**

- **Symptom**: Final PDF generation fails
- **Cause**: Missing appendix content or corrupted templates
- **Solution**: Check all appendix tasks completed and content validated

## 📝 **Template Integration Issues**

- **Symptom**: SOW templates not loading correctly
- **Cause**: Template service initialization failure
- **Solution**: Verify ProcurementTemplateService initialization in component

## 🏗️ **Document Ordering Management Issues**

### **Symptom: Document sections not displaying correctly**
```
Error: discipline_document_sections table not found
```

**Solutions:**
1. **Check Database Schema**: Ensure `discipline_document_sections` table exists
2. **Run Migrations**: Execute `sql/create-discipline-document-sections-table.sql`
3. **Verify Permissions**: Check user has access to discipline document sections

### **Symptom: Agent capability indicators not updating**
```
Template permissions not reflecting in UI
```

**Debug Steps:**
1. **Check API Response**: Verify `/api/templates` returns field_protection data
2. **Validate Template Permissions**: Ensure `TemplatePermissionsService` is initialized
3. **Check Caching**: Clear browser cache and reload template data

## 🔧 **Template System Issues**

### **Symptom: Templates not loading in procurement modal**
```
[CREATE_ORDER_MODAL] ❌ FAILURE: Error loading procurement templates
```

**Root Causes:**
1. **API Endpoint Issues**: Check `/api/templates?discipline=01900` is accessible
2. **Discipline Mapping**: Verify 01900 → Procurement mapping in API routes
3. **Template Status**: Ensure templates have `processing_status = 'published'`

**Solutions:**
```javascript
// Check API endpoint
fetch('/api/templates?status=all&user_role=unknown&discipline=01900')
  .then(response => response.json())
  .then(data => console.log('Templates:', data));
```

### **Symptom: Template selection not saving**
```
Custom assignments failing to persist
```

**Debug Steps:**
1. **Check localStorage**: Verify `sow_assign_*` keys exist
2. **API Connectivity**: Test `/api/procurement/custom-assignments` endpoint
3. **Fallback Logic**: Ensure localStorage fallback is working during API issues

## 🛡️ **Authentication & Authorization Issues**

### **Symptom: Development mode bypass not working**
```
Tasks not visible in MyTasksDashboard
```

**Supabase RLS Debug:**
```javascript
// Check if RLS policies allow null auth.uid()
SELECT * FROM tasks WHERE assigned_to IS NULL;

// Verify development mode task creation
SELECT * FROM tasks WHERE metadata->>'development_mode' = 'true';
```

**Solutions:**
1. **RLS Policy Check**: Ensure policies allow `auth.uid() IS NULL` for development
2. **Task Assignment**: Verify tasks created with `assigned_to: null`
3. **Dashboard Query**: Check if dashboard includes NULL assignments

## 📊 **Performance Issues**

### **Symptom: Modal loading slowly**
```
Phase transitions taking >5 seconds
```

**Performance Optimizations:**
1. **Lazy Loading**: Implement lazy loading for user lists and templates
2. **Query Optimization**: Add database indexes on frequently queried fields
3. **Caching**: Cache discipline and user data for session duration

### **Symptom: API timeouts**
```
Network requests failing with 504 errors
```

**Timeout Solutions:**
1. **Query Optimization**: Reduce data payload sizes
2. **Pagination**: Implement pagination for large user lists
3. **Background Processing**: Move heavy operations to background tasks

## 🔄 **Workflow State Issues**

### **Symptom: Workflow stuck in phase**
```
Cannot proceed to next phase despite valid data
```

**State Debug:**
```javascript
// Check workflow state
console.log('Current phase:', workflow.currentPhase);
console.log('Validation errors:', workflow.validationErrors);
console.log('Can proceed:', workflow.canProceedToNext(formData));
```

**Solutions:**
1. **Validation Reset**: Clear validation errors between phases
2. **State Persistence**: Ensure modal state resets on open
3. **Form Data Sync**: Verify form data matches validation requirements

## 📱 **UI/UX Issues**

### **Symptom: Modal not responsive on mobile**
```
Modal overflows on small screens
```

**Responsive Fixes:**
1. **CSS Media Queries**: Add mobile-specific styles
2. **Modal Sizing**: Reduce modal width on mobile devices
3. **Touch Interactions**: Ensure touch targets meet accessibility standards

### **Symptom: Form validation errors not displaying**
```
Users can submit invalid data
```

**Validation Debug:**
1. **Check Validation Rules**: Verify form validation logic
2. **Error Display**: Ensure error messages are visible
3. **Real-time Validation**: Implement field-level validation feedback

## 🚨 **Emergency Troubleshooting Procedures**

### **Critical Workflow Failures**

**Template System Failure:**
1. **Immediate Response**: Check template database connectivity and RLS policies
2. **Temporary Workaround**: Use direct SQL queries to verify template data integrity
3. **Communication**: Alert procurement team of template unavailability
4. **Documentation Update**: Add new failure mode to troubleshooting section

**Discipline Mapping Failure:**
1. **Immediate Response**: Verify discipline code mapping in unified-templates-routes.js
2. **Temporary Workaround**: Use direct database queries with explicit discipline names
3. **Communication**: Notify governance administrators of mapping issues
4. **Documentation Update**: Update discipline mapping troubleshooting procedures

**Task Creation Failure:**
1. **Immediate Response**: Check task creation logs and user assignment validation
2. **Temporary Workaround**: Manual task creation via database inserts
3. **Communication**: Alert affected users and provide status updates
4. **Documentation Update**: Add task creation failure patterns to debugging guide

### **Security Incidents**

**Template Data Exposure:**
1. **Containment**: Immediately revoke compromised user access
2. **Investigation**: Audit template access logs for unauthorized viewing
3. **Recovery**: Rotate database credentials and review RLS policies
4. **Documentation**: Update security procedures with new threat patterns

**Procurement Data Breach:**
1. **Containment**: Isolate affected procurement orders and templates
2. **Investigation**: Review audit trails and access patterns
3. **Recovery**: Restore from secure backups and validate data integrity
4. **Documentation**: Enhance security controls documentation

---

## 🛠️ **Development Best Practices**

### **User Assignment Implementation Pattern**

**Always follow this pattern for reliable user assignments:**

```javascript
// 1. Load users with disciplines array
const usersWithDisciplines = fetchedUsers.map(user => ({
  ...user,
  disciplines: Array.from(assignedDisciplineNames)
}));

// 2. Filter by discipline name matching
const filteredUsers = usersWithDisciplines.filter(user => {
  const assignedNames = assignedDisciplines.map(id =>
    allDisciplines.find(d => d.id === id)?.name || id
  );
  return assignedNames.some(name =>
    user.disciplines.some(userDisc =>
      userDisc.toLowerCase().includes(name.toLowerCase())
    )
  );
});

// 3. Pass to UserSelector with onUserAssignment handler
<UserSelector
  availableUsers={filteredUsers}
  onUserAssignment={(appendix, userId, assign) => {
    console.log('[USER_ASSIGNMENT]', { appendix, userId, assign });
    // Update state and trigger task creation
  }}
/>
```

### **Debug Logging Standards**

**Always include these debug logs in user assignment components:**

```javascript
// Component render logging
console.log(`[ComponentName] Rendering with ${users.length} users`);

// State change logging
console.log(`[ComponentName] State updated:`, newState);

// API call logging
console.log(`[ComponentName] API call:`, params);

// Error logging
console.error(`[ComponentName] Error:`, error);
```

### **Data Structure Validation**

**Always validate data structures before processing:**

```javascript
// Validate user objects have required properties
const validUsers = users.filter(user =>
  user.id && user.email && Array.isArray(user.disciplines)
);

// Validate discipline assignments
const validAssignments = Object.entries(disciplineAssignments).filter(
  ([appendix, disciplines]) => Array.isArray(disciplines) && disciplines.length > 0
);
```

---

## 📋 **Common Error Patterns**

### **Phase Transition Errors**
- **Symptom**: Cannot move between workflow phases
- **Cause**: Validation logic blocking progression
- **Solution**: Check phase validation rules and form data completeness

### **Data Persistence Errors**
- **Symptom**: User assignments not saving between sessions
- **Cause**: localStorage or API failures
- **Solution**: Implement fallback storage and retry logic

### **Integration Errors**
- **Symptom**: External service calls failing
- **Cause**: Network issues or API changes
- **Solution**: Add retry logic and graceful degradation

### **Performance Errors**
- **Symptom**: UI becomes unresponsive with large datasets
- **Cause**: Inefficient rendering or data processing
- **Solution**: Implement virtualization and pagination

---

## 🔍 **Advanced Debugging Tools**

### **Browser Developer Tools**
```javascript
// Monitor React component updates
React.Profiler
// Check network requests
Network tab → Filter by API calls
// Monitor memory usage
Performance tab → Memory timeline
```

### **Database Debugging**
```sql
-- Check recent task creation
SELECT * FROM tasks
WHERE created_at > NOW() - INTERVAL '1 hour'
ORDER BY created_at DESC;

-- Verify user-discipline relationships
SELECT uda.*, u.email, d.name
FROM user_discipline_access uda
JOIN user_management u ON uda.user_id = u.user_id
JOIN disciplines d ON uda.discipline_code = d.code
WHERE uda.organization_id = '90cd635a-380f-4586-a3b7-a09103b6df94';
```

### **API Testing Tools**
```bash
# Test template API
curl -X GET "http://localhost:3060/api/templates?discipline=01900&status=all"

# Test user assignment API
curl -X GET "http://localhost:3060/api/user-discipline?organization_id=90cd635a-380f-4586-a3b7-a09103b6df94"
```

---

## 📞 **Support Escalation**

### **When to Escalate**

**Critical Issues (Immediate Escalation):**
- Complete workflow breakdown affecting all users
- Data loss or corruption
- Security vulnerabilities discovered
- System-wide performance degradation

**High Priority Issues (Same Day):**
- Workflow blocking specific user groups
- Template system failures
- Approval routing failures
- Integration service outages

**Standard Issues (Next Business Day):**
- Individual user assignment problems
- UI/UX issues not blocking functionality
- Performance optimization opportunities
- Documentation improvements

### **Escalation Contacts**

- **Technical Lead**: System architecture and critical failures
- **Product Manager**: Workflow logic and user experience issues
- **DevOps Engineer**: Infrastructure and performance problems
- **Security Officer**: Authentication and authorization issues

---

## 📊 **Monitoring & Alerting**

### **Key Metrics to Monitor**

```javascript
const monitoringMetrics = {
  systemHealth: {
    apiResponseTime: '< 200ms',
    errorRate: '< 1%',
    uptime: '> 99.9%'
  },
  workflowEfficiency: {
    completionRate: '> 95%',
    averageTime: '< 24 hours',
    userSatisfaction: '> 4.5/5'
  },
  performance: {
    pageLoadTime: '< 2 seconds',
    modalRenderTime: '< 500ms',
    apiLatency: '< 100ms'
  }
};
```

### **Automated Alerts**

- **Error Rate Spikes**: When client or server errors exceed 5%
- **Performance Degradation**: When response times exceed 2x normal
- **Workflow Blockages**: When task completion drops below 90%
- **Security Events**: Any authentication or authorization failures

This troubleshooting guide provides comprehensive solutions for the most common issues encountered in the procurement document generation workflow. Regular updates based on user feedback and system monitoring will ensure continued reliability and performance.