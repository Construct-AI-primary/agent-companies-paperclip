---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
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