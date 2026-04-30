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

# Correspondence Agent Orchestration Workflow - Troubleshooting Guide

## 🐛 **Critical HITL Issues**

### **Symptom: HITL tasks not appearing in MyTasksDashboard**
```
No HITL tasks visible despite agent creating them
```

**Root Causes & Solutions:**

**A. Database Table Issues**
- **Check**: Verify `task_history` and `hitl_performance_metrics` tables exist
- **Solution**: Run migration scripts to create HITL tables
```sql
-- Check HITL tables exist
SELECT table_name FROM information_schema.tables 
WHERE table_name IN ('task_history', 'hitl_performance_metrics');
```

**B. API Route Registration**
- **Check**: Verify HITL routes are registered in main application router
- **Solution**: Ensure `/api/tasks/hitl` routes are properly registered

### **Symptom: Parallel specialist processing fails**
```
17 discipline specialists not running in parallel
```

**Debug Steps:**
1. **Database Verification**: Check all 17 prompts are active
2. **Parallel Coordinator**: Verify `ParallelSpecialistCoordinator` initialization
3. **Processing Order**: Ensure sequential processing order (1-17) is maintained

## 🔄 **Agent Orchestration Issues**

### **Symptom: Agent sequence breaks down**
```
Agents stop processing after step 3
```

**Debug Steps:**
1. **Check Orchestrator**: Verify 7-step workflow coordination
2. **Agent Health**: Test individual agent functionality
3. **Data Flow**: Check data passing between agents

### **Symptom: Database prompt retrieval fails**
```
PromptsService.getPromptByKey() returning null
```

**Solutions:**
1. **Database Check**: Verify prompts exist and are active
2. **Category Filter**: Ensure `category = 'contracts'` filter
3. **Fallback Logic**: Check fallback prompt handling

## 📊 **Performance Issues**

### **Symptom: Processing time exceeds 15 minutes**
```
Complete correspondence analysis taking too long
```

**Performance Solutions:**
1. **Parallel Processing**: Ensure 17 specialists run in parallel
2. **Caching**: Implement prompt caching
3. **Optimization**: Review agent processing logic

### **Symptom: High HITL escalation rate**
```
>20% HITL rate exceeded
```

**Optimization:**
1. **Confidence Thresholds**: Adjust HITL trigger thresholds
2. **Algorithm Enhancement**: Improve discipline detection accuracy
3. **Fallback Logic**: Implement better fallback handling

## 🛡️ **Security & Data Isolation Issues**

### **Symptom: Vector data leakage**
```
Agent operations accessing wrong vector contexts
```

**Security Fixes:**
1. **Isolation Verification**: Check vector context isolation
2. **Audit Trails**: Review vector operation logs
3. **Access Controls**: Verify proper access restrictions

## 🔧 **Configuration Issues**

### **Symptom: Agent configuration not applying**
```
Configuration changes not taking effect
```

**Configuration Fixes:**
1. **Service Restart**: Restart correspondence services
2. **Cache Clearing**: Clear configuration caches
3. **Validation**: Verify configuration schema compliance

## 📋 **Database Issues**

### **Symptom: Discipline prompts not loading**
```
17 specialist prompts unavailable
```

**Database Solutions:**
1. **Migration Check**: Verify database migration completed
2. **Prompt Status**: Ensure all prompts marked as active
3. **Role Types**: Check role_type constraints are satisfied

## 🚨 **Emergency Troubleshooting**

### **Complete System Failure**
1. **Isolate Issue**: Determine if it's agent-specific or system-wide
2. **Fallback Mode**: Activate fallback processing
3. **Communication**: Alert stakeholders of processing delays
4. **Recovery**: Implement emergency response procedures

### **Data Loss Scenarios**
1. **Backup Verification**: Check recent backups are available
2. **Data Recovery**: Restore from clean backups
3. **Audit Review**: Review access logs for unauthorized changes
4. **Security Assessment**: Perform security audit of compromised systems

## 🛠️ **Development Best Practices**

### **HITL Integration Pattern**
```javascript
// Always follow this HITL integration pattern
const hitlIntegration = {
  taskCreation: async (agentData) => {
    return await fetch('/api/tasks/hitl', {
      method: 'POST',
      body: JSON.stringify(agentData)
    });
  },
  assignment: (taskId, specialistId) => {
    // Intelligent workload balancing
  },
  resolution: async (taskId, decision) => {
    return await fetch(`/api/tasks/hitl/${taskId}/resolve`, {
      method: 'POST', 
      body: JSON.stringify(decision)
    });
  }
};
```

### **Agent Error Handling**
```javascript
// Comprehensive error handling for agents
const agentErrorHandling = {
  retry: (operation, maxRetries = 3) => {
    // Implement exponential backoff
  },
  fallback: (primary, fallback) => {
    // Graceful degradation
  },
  logging: (error, context) => {
    // Comprehensive error logging
  }
};
```

## 📊 **Monitoring & Alerting**

### **Key Metrics to Monitor**
- **Processing Time**: <15 minutes target
- **HITL Rate**: <20% escalation rate
- **Accuracy**: >95% correct analysis
- **Uptime**: 99.9% system availability

### **Automated Alerts**
- **Performance Degradation**: Processing time >20 minutes
- **High HITL Rate**: Escalation rate >25%
- **Accuracy Drop**: Analysis accuracy <90%
- **System Downtime**: Unavailability >1 hour
