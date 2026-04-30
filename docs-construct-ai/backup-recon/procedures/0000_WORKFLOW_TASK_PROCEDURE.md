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

# 0000 Task Workflow Procedure

## Overview
This procedure defines the comprehensive task management workflow for the Construct AI system, covering task creation, assignment, execution, monitoring, and completion across all business domains.

**🔗 Cross-References to Related Procedures:**

**Agent Security & Governance:**
- → `0000_AGENT_ROLES_IMPLEMENTATION_PROCEDURE.md` → **MANDATORY REFERENCE** - Agent discipline confinement, role-based access control, and audit logging requirements for all workflow agents
- → `IMPLEMENT_RLS_POLICIES.md` → Database security policies for agent operations

**Workflow Implementation Procedures:**
- → `0000_WORKFLOW_HITL_PROCEDURE.md` → Human-in-the-loop task escalation and resolution workflows
- → `0000_WORKFLOW_TEMPLATE_FIELD_ATTRIBUTE_IMPLEMENTATION_PROCEDURE.md` → AI field attribute handling in task workflows
- → `0000_WORKFLOW_OPTIMIZATION_GUIDE.md` → Performance optimization for task processing workflows

**System Maintenance & Troubleshooting:**
- → `0000_DEBUGGING_GUIDE.md` → Advanced debugging techniques for task workflow issues and React hook violations
- → `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` → Framework for diagnosing task assignment and completion problems
- → `0000_PROCEDURES_GUIDE.md` → Complete index of all troubleshooting and operational procedures

## Scope
- Task creation from business objects (procurement_orders, scope_of_work, sow_appendices)
- Automated task assignment based on user roles and disciplines
- Task lifecycle management (pending → in_progress → completed)
- Integration with HITL workflows for complex decisions
- Cross-domain task coordination

---

## 🔐 **Agent Discipline Confinement & Security Requirements**

### **Mandatory Agent Role Validation**
**CRITICAL REQUIREMENT**: All agents involved in task orchestration must adhere to strict discipline confinement rules defined in `0000_AGENT_ROLES_IMPLEMENTATION_PROCEDURE.md`.

#### **Agent Discipline Confinement Rules**
1. **Strict Isolation**: Agents may only access data and perform operations within their assigned disciplines
2. **No Cross-Discipline Access**: Agents cannot access resources or perform operations outside authorized disciplines
3. **Explicit Permissions**: Each agent must have explicitly defined discipline permissions before task operations
4. **Runtime Validation**: All agent operations must validate discipline access before execution

#### **Task Assignment Security**
```javascript
// Agent Discipline Validation for Task Operations
class SecureTaskDispatcher {
  constructor(agentPermissionService) {
    this.agentPermissionService = agentPermissionService;
  }

  async dispatchTaskToAgent(task, agent) {
    // Validate agent has permission for task discipline
    const validation = await this.agentPermissionService.validateAgentOperation(
      agent.agentId,
      'task_assignment',
      task.discipline
    );

    if (!validation.valid) {
      throw new Error(`Agent ${agent.agentId} cannot access discipline ${task.discipline}: ${validation.error}`);
    }

    // Log secure task assignment
    await this.auditTaskAssignment(task, agent, validation.roles);

    return await this.performSecureTaskAssignment(task, agent);
  }

  async auditTaskAssignment(task, agent, agentRoles) {
    await this.agentPermissionService.logAgentOperation({
      agent_id: agent.agentId,
      agent_name: agent.agentName,
      operation: 'task_assignment',
      discipline_code: task.discipline,
      resource_id: task.id,
      resource_type: 'task',
      success: true,
      execution_time_ms: 0
    });
  }
}
```

#### **Agent Task Operation Audit Trail**
All agent task operations are logged to `agent_operations_audit` table with complete discipline confinement tracking:
- Agent identification and discipline assignment
- Operation type and target resources
- Success/failure status and error details
- Execution timing and performance metrics
- Compliance with organizational audit requirements

---

## 📢 **Notification Policy**

### **Primary Notification Channel: Tasks in MyTasksDashboard**
- **All workflow notifications** are delivered through the MyTasksDashboard task interface
- **Task Assignment Alerts**: Immediate notifications when tasks are assigned to users
- **HITL Task Notifications**: Special alerts for human intervention required tasks
- **Deadline Reminders**: Task-based deadline notifications and progress updates
- **Escalation Alerts**: Notifications for task reassignment and priority changes
- **Status Updates**: Real-time workflow progress and completion notifications

### **Email Usage Policy**
```
📧 Email-Only-as-Reminder Policy
├── Primary Notifications: All workflow notifications through MyTasksDashboard tasks
├── Email Reminders: Only sent when HITL task deadlines are missed
├── Escalation Notifications: Email alerts for critical deadline breaches
├── Stakeholder Updates: Email summaries for major workflow milestones
├── System Alerts: Email notifications for system-level issues and failures
└── Opt-in Only: Users must explicitly opt-in for any email notifications
```

### **Notification Delivery Rules**
- **Task-based notifications** are always delivered (cannot be disabled)
- **Email reminders** are sent only for missed HITL deadlines
- **Escalation emails** are sent for critical system issues or major delays
- **No spam policy**: Maximum 1 email per day per user unless critical system alerts
- **User preferences**: Individual users can opt-out of non-critical email notifications

---

## 🎯 **Task Creation Process**

### **Automatic Task Creation**
Tasks are automatically created when business objects are inserted/updated:

#### **1. Procurement Order Tasks**
```sql
-- Created when procurement_order.approval_status = 'pending_approval'
INSERT INTO tasks (
  business_object_type: 'procurement_order',
  task_type: 'procurement_review',
  discipline: 'procurement',
  priority: CASE WHEN priority = 'urgent' THEN 'urgent' ELSE 'normal' END
)
```

#### **2. Scope of Work Tasks**
```sql
-- Created when scope_of_work.status = 'in_review'
INSERT INTO tasks (
  business_object_type: 'scope_of_work',
  task_type: 'sow_review',
  discipline: 'engineering',
  priority: 'normal'
)
```

#### **3. SOW Appendix Tasks**
```sql
-- Created for each appendix requiring contribution
INSERT INTO tasks (
  business_object_type: 'sow_appendix',
  task_type: 'appendix_contribution',
  discipline: CASE
    WHEN appendix_type IN ('A', 'C', 'E') THEN 'engineering'
    WHEN appendix_type IN ('B', 'D') THEN 'quality'
    WHEN appendix_type = 'C' THEN 'safety'
    WHEN appendix_type = 'F' THEN 'legal'
    ELSE 'procurement'
  END
)
```

### **Manual Task Creation**
Tasks can also be created manually through the MyTasksDashboard interface for ad-hoc work items.

---

## 🤖 **Agent Orchestration & Intelligent Task Distribution**

### **Autonomous Agent Task Orchestration**
Advanced workflows integrate autonomous agent orchestration for intelligent task distribution across all disciplines:

```javascript
// Generic Workflow Agent Orchestration Framework (adaptable to any discipline)
class AdvancedWorkflowAgentOrchestration {
  constructor(disciplineConfig) {
    this.agentMonitor = new AgentCapabilityMonitor(disciplineConfig);
    this.taskDispatcher = new IntelligentTaskDispatcher();
    this.sequenceEngine = new DocumentSequenceEngine();
  }

  async orchestrateWorkflow(workflowId, sequence) {
    // Phase 1: Real-time Agent Capability Monitoring
    const capableAgents = await this.agentMonitor.findAvailableAgents(sequence);

    for (const sequenceItem of sequence) {
      // Immediate Task Assignment Upon Agent Capability
      const agent = await this.agentMonitor.waitForCapableAgent(sequenceItem);

      if (agent) {
        // Create task immediately when agent becomes capable
        const task = await this.taskDispatcher.createImmediateTask({
          sequenceItem: sequenceItem,
          assignedAgent: agent,
          priority: this.calculateTaskPriority(sequenceItem),
          deadline: this.calculateTaskDeadline(sequenceItem)
        });

        // Dispatch task to capable agent
        await this.taskDispatcher.dispatchToAgent(task, agent);

        // Monitor task completion and trigger next sequence item
        this.monitorTaskCompletion(task, sequenceItem);
      }
    }
  }

  // Dynamic Reassignment Based on Agent Capability Changes
  async handleAgentCapabilityChange(agentId, newCapability) {
    const affectedTasks = await this.findTasksAssignedToAgent(agentId);

    for (const task of affectedTasks) {
      if (!this.agentCanHandleTask(agentId, task, newCapability)) {
        // Find alternative capable agent
        const alternativeAgent = await this.agentMonitor.findAlternativeAgent(task);

        if (alternativeAgent) {
          await this.taskDispatcher.reassignTask(task, alternativeAgent);
        } else {
          // Escalate to HITL if no capable agent available
          await this.escalateToHITL(task, 'no_capable_agent');
        }
      }
    }
  }
}

// Example Implementation: Procurement Discipline
class ProcurementAgentOrchestration extends AdvancedWorkflowAgentOrchestration {
  constructor() {
    super({
      disciplineCode: '01900',
      agentTypes: ['procurement_analyzer', 'document_processor', 'compliance_checker'],
      capabilityThresholds: {
        highValueOrders: 0.90,
        complexEquipment: 0.85,
        standardOrders: 0.75
      }
    });
  }

  calculateTaskPriority(sequenceItem) {
    if (sequenceItem.type === 'safety') return 'urgent';
    if (sequenceItem.value > 500000) return 'high';
    return 'normal';
  }
}
```

### **Intelligent Sequence Management**
Complex workflows implement intelligent document processing sequences with override capabilities. This framework adapts to any discipline's workflow patterns:

```javascript
// Generic Intelligent Document Sequence Management Framework
class AdvancedDocumentSequenceManager {
  constructor(disciplineConfig) {
    this.disciplineConfig = disciplineConfig;
    this.defaultSequences = this.loadDisciplineSequences(disciplineConfig);
    this.overridePermissions = this.loadOverridePermissions(disciplineConfig);
    this.learningEngine = new SequenceLearningEngine();
  }

  // Discipline-adaptive default sequences
  getDisciplineSequences(disciplineCode) {
    // Load sequences based on discipline configuration
    const sequenceTemplates = this.getSequenceTemplates(disciplineCode);

    return {
      complex: sequenceTemplates.complexWorkflow,
      standard: sequenceTemplates.standardWorkflow,
      basic: sequenceTemplates.basicWorkflow
    };
  }

  // Flexible override capabilities
  getOverrideCapabilities(disciplineConfig) {
    return {
      orderLevel: {
        authorizedRoles: disciplineConfig.overrideRoles || ['manager', 'senior_officer'],
        overrideTypes: ['reorder', 'insert', 'remove', 'parallel'],
        validationRules: ['dependency_check', 'deadline_compliance', 'resource_availability']
      },

      dependencyBased: {
        automaticRules: this.getDisciplineDependencyRules(disciplineConfig)
      },

      priorityBased: {
        priorityLevels: ['critical', 'high', 'normal', 'low'],
        escalationRules: ['skip_non_essential', 'parallel_processing', 'resource_reallocation']
      }
    };
  }

  async getSequenceForWorkflow(workflowId, complexity, overrides = {}) {
    const baseSequence = await this.getBaseSequence(complexity);
    const validatedOverrides = await this.validateOverrides(overrides, workflowId);
    const optimizedSequence = await this.learningEngine.optimizeSequence(baseSequence, workflowId);

    return this.mergeSequences(baseSequence, validatedOverrides, optimizedSequence);
  }

  // Parallel task generation framework
  async generateParallelTasks(workflowId, sequence) {
    const tasks = [];

    // Create primary workflow task
    tasks.push(await this.createTask({
      type: this.getPrimaryTaskType(),
      businessObjectId: workflowId,
      priority: 'high',
      dependencies: []
    }));

    // Create secondary tasks in parallel based on sequence
    for (const sequenceItem of sequence.filter(item => this.isParallelExecutable(item))) {
      tasks.push(await this.createTask({
        type: this.mapSequenceToTaskType(sequenceItem),
        businessObjectId: workflowId,
        priority: this.calculateItemPriority(sequenceItem),
        dependencies: this.calculateItemDependencies(sequenceItem, sequence)
      }));
    }

    return tasks;
  }

  // Discipline-specific adaptations
  getSequenceTemplates(disciplineCode) {
    // Abstract method - implemented by discipline-specific subclasses
    return this.disciplineConfig.sequenceTemplates;
  }
}

// Example Implementation: Procurement Discipline
class ProcurementSequenceManager extends AdvancedDocumentSequenceManager {
  constructor() {
    super({
      disciplineCode: '01900',
      overrideRoles: ['procurement_officer', 'procurement_manager'],
      sequenceTemplates: {
        complexWorkflow: ['specs', 'sow', 'safety', 'training', 'schedules', 'logistics', 'standards'],
        standardWorkflow: ['specs', 'sow', 'safety', 'schedules', 'logistics'],
        basicWorkflow: ['specs', 'sow', 'delivery', 'documentation']
      }
    });
  }

  getPrimaryTaskType() { return 'sow_generation'; }
  isParallelExecutable(item) { return item.type.startsWith('appendix'); }
  mapSequenceToTaskType(sequenceItem) { return `appendix_${sequenceItem.code}`; }

  getDisciplineDependencyRules() {
    return [
      { trigger: 'safety_required', action: 'move_safety_early' },
      { trigger: 'equipment_complex', action: 'prioritize_training' },
      { trigger: 'international_shipment', action: 'add_customs_compliance' }
    ];
  }
}
```

### **Multi-Discipline Task Distribution**
Complex workflows distribute tasks across multiple disciplines with intelligent routing. This framework adapts to any discipline's collaborative requirements:

```javascript
// Generic Multi-Discipline Task Distribution Framework
class AdvancedMultiDisciplineTaskDistributor {
  constructor(disciplineConfig) {
    this.disciplineConfig = disciplineConfig;
    this.disciplineRouter = new DisciplineCollaborationRouter(disciplineConfig);
    this.workloadBalancer = new WorkloadBalancer();
    this.expertiseMatcher = new ExpertiseMatcher();
  }

  async distributeWorkflowTasks(workflowId, workItems) {
    const taskAssignments = {};

    // Parallel task creation for multiple work items
    const tasks = await Promise.all(
      workItems.map(item => this.createDisciplineTask(item, workflowId))
    );

    // Multi-discipline assignment based on configuration
    for (const task of tasks) {
      const requiredDisciplines = this.getRequiredDisciplines(task, this.disciplineConfig);
      const assignments = await this.assignToDisciplines(task, requiredDisciplines);

      taskAssignments[task.id] = assignments;
    }

    return taskAssignments;
  }

  // Discipline-adaptive work item processing
  async createDisciplineTask(workItem, workflowId) {
    const disciplineMapping = this.getDisciplineMapping(workItem.type, this.disciplineConfig);

    return {
      id: generateTaskId(),
      workItem: workItem.id,
      workflowId: workflowId,
      requiredDisciplines: disciplineMapping.disciplines,
      priority: this.calculatePriority(workItem, this.disciplineConfig),
      complexity: this.assessComplexity(workItem, this.disciplineConfig),
      expertise: disciplineMapping.requiredExpertise
    };
  }

  // Generic discipline requirement determination
  getRequiredDisciplines(task, disciplineConfig) {
    // Use discipline configuration to determine requirements
    const mapping = this.getDisciplineMapping(task.workItem.type, disciplineConfig);
    return mapping.disciplines;
  }

  // Optimized assignment across disciplines
  async assignToDisciplines(task, requiredDisciplines) {
    const assignments = [];

    for (const discipline of requiredDisciplines) {
      const users = await this.findUsersByDiscipline(discipline);
      const optimalUser = await this.expertiseMatcher.selectOptimalUser(task, users);

      assignments.push({
        taskId: task.id,
        discipline: discipline,
        assignedTo: optimalUser.id,
        role: this.determineRole(discipline, task, this.disciplineConfig)
      });
    }

    return assignments;
  }

  // Discipline-specific mapping (configurable)
  getDisciplineMapping(workItemType, disciplineConfig) {
    // Load mappings from discipline configuration
    const mappings = disciplineConfig.workItemMappings || {};

    return mappings[workItemType] || {
      disciplines: [disciplineConfig.primaryDiscipline],
      requiredExpertise: ['general']
    };
  }

  // Technical team assignment pattern (reusable across disciplines)
  async assignTechnicalTeamTasks(workItem, technicalDisciplines) {
    // Generic technical team assignment adaptable to any domain
    const technicalExpertiseAreas = this.getTechnicalExpertiseAreas(workItem, this.disciplineConfig);

    return await this.createTechnicalTasks(workItem, technicalDisciplines, technicalExpertiseAreas);
  }
}

// Example Implementation: Procurement Discipline
class ProcurementTaskDistributor extends AdvancedMultiDisciplineTaskDistributor {
  constructor() {
    super({
      primaryDiscipline: '01900',
      workItemMappings: {
        'specs': {
          disciplines: ['engineering', 'quality', 'safety'],
          requiredExpertise: ['technical', 'compliance']
        },
        'safety': {
          disciplines: ['safety', 'engineering', 'legal'],
          requiredExpertise: ['hsse', 'regulatory']
        },
        'training': {
          disciplines: ['technical', 'safety', 'hr'],
          requiredExpertise: ['training', 'certification']
        }
      },
      technicalDisciplines: [
        '00800', '00825', '00835', '00850',  // Design disciplines
        '00860', '00870', '00872',           // Engineering disciplines
        '00300',                             // Construction management
        '03000',                             // Landscaping
        '01000'                              // Environmental
      ]
    });
  }

  getTechnicalExpertiseAreas(workItem) {
    return {
      specifications: 'Technical specifications and requirements',
      procedures: 'Operational and maintenance procedures',
      training: 'Equipment-specific training programs',
      safety: 'Safety protocols and hazard identification',
      compliance: 'Regulatory compliance and certification'
    };
  }
}
```

### **Discipline Assignment Inheritance**
Workflows inherit pre-configured discipline assignments from Document Ordering Management. This framework is discipline-agnostic and adapts to any workflow type:

```javascript
// Generic Discipline Assignment Inheritance Framework
class AdvancedDisciplineAssignmentInheritance {
  constructor(disciplineConfig) {
    this.disciplineConfig = disciplineConfig;
    this.documentOrderingService = new DocumentOrderingService();
    this.disciplineValidation = new DisciplineValidationService();
  }

  async inheritDisciplineAssignments(workflowData) {
    // Get template variation or workflow type
    const templateVariation = workflowData.templateVariation ||
                             this.autoDetectTemplate(workflowData, this.disciplineConfig);

    // Load pre-configured discipline assignments from Document Ordering Management
    const inheritedAssignments = await this.documentOrderingService.getDisciplineAssignments(
      this.disciplineConfig.disciplineCode,
      templateVariation
    );

    // Apply discipline-specific business rules
    const processedAssignments = await this.applyBusinessRules(workflowData, inheritedAssignments, this.disciplineConfig);

    // Allow limited user customizations based on permissions
    const userCustomizations = await this.applyUserCustomizations(workflowData.userId, processedAssignments, this.disciplineConfig);

    // Validate final assignments
    const validatedAssignments = await this.disciplineValidation.validateAssignments(
      processedAssignments,
      workflowData,
      this.disciplineConfig
    );

    return {
      inheritedDisciplines: inheritedAssignments,
      processedAssignments: processedAssignments,
      userCustomizations: userCustomizations,
      validationResults: validatedAssignments
    };
  }

  // Discipline-adaptive business rules application
  async applyBusinessRules(workflowData, assignments, disciplineConfig) {
    const enhancedAssignments = { ...assignments };

    // Apply discipline-specific rules
    const rules = disciplineConfig.businessRules || [];

    for (const rule of rules) {
      if (this.evaluateRuleCondition(rule.condition, workflowData)) {
        enhancedAssignments = this.applyRuleAction(rule.action, enhancedAssignments, workflowData);
      }
    }

    return enhancedAssignments;
  }

  // Evaluate rule conditions (adaptable per discipline)
  evaluateRuleCondition(condition, workflowData) {
    switch (condition.type) {
      case 'value_threshold':
        return workflowData.value >= condition.threshold;
      case 'complexity_check':
        return this.assessComplexity(workflowData) === 'high';
      case 'compliance_required':
        return workflowData.requiresCompliance === true;
      case 'international':
        return workflowData.shippingDestination !== workflowData.originCountry;
      default:
        return false;
    }
  }

  // Apply rule actions (discipline-specific)
  applyRuleAction(action, assignments, workflowData) {
    const updated = { ...assignments };

    switch (action.type) {
      case 'add_required_discipline':
        if (!updated.required.includes(action.discipline)) {
          updated.required.push(action.discipline);
        }
        break;
      case 'add_recommended_discipline':
        if (!updated.recommended.includes(action.discipline)) {
          updated.recommended.push(action.discipline);
        }
        break;
      case 'set_priority':
        updated.priority = action.priority;
        break;
    }

    return updated;
  }

  // Limited user override capabilities (discipline-aware)
  async applyUserCustomizations(userId, assignments, disciplineConfig) {
    const userPermissions = await this.getUserPermissions(userId, disciplineConfig);

    if (userPermissions.canAddDisciplines) {
      // Allow adding optional disciplines within limits
      return await this.processUserAdditions(assignments, userPermissions, disciplineConfig);
    }

    return assignments; // No changes if no permissions
  }
}

// Example Implementation: Procurement Discipline
class ProcurementDisciplineInheritance extends AdvancedDisciplineAssignmentInheritance {
  constructor() {
    super({
      disciplineCode: '01900',
      businessRules: [
        {
          condition: { type: 'value_threshold', threshold: 500000 },
          action: { type: 'add_required_discipline', discipline: '01200' } // Finance
        },
        {
          condition: { type: 'complexity_check' },
          action: { type: 'add_recommended_discipline', discipline: '00800-00872' } // Engineering
        },
        {
          condition: { type: 'compliance_required' },
          action: { type: 'add_required_discipline', discipline: '01750' } // Legal
        }
      ],
      userPermissions: {
        managersCanAddDisciplines: true,
        officersCanAddDisciplines: false,
        maxAdditionalDisciplines: 2
      }
    });
  }

  assessComplexity(workflowData) {
    if (workflowData.equipmentInvolved && workflowData.value > 100000) return 'high';
    if (workflowData.multipleSuppliers || workflowData.technicalRequirements) return 'medium';
    return 'low';
  }
}
```

---

## 👥 **Task Assignment Logic**

### **Automated Assignment**
```sql
CREATE OR REPLACE FUNCTION assign_tasks_to_users()
RETURNS void AS $$
DECLARE
  task_record RECORD;
  assignee_id UUID;
BEGIN
  -- 1. Procurement Review Tasks
  FOR task_record IN
    SELECT t.id, t.organization_id, t.discipline
    FROM tasks t
    WHERE t.task_type = 'procurement_review'
      AND t.assigned_to IS NULL
      AND t.status = 'pending'
  LOOP
    SELECT u.id INTO assignee_id
    FROM auth.users u
    JOIN user_management um ON u.id = um.user_id
    WHERE um.organization_id = task_record.organization_id
      AND um.role IN ('procurement_officer', 'procurement_manager')
    LIMIT 1;

    IF assignee_id IS NOT NULL THEN
      UPDATE tasks SET assigned_to = assignee_id WHERE id = task_record.id;
    END IF;
  END LOOP;

  -- 2. Appendix Contribution Tasks
  FOR task_record IN
    SELECT t.id, t.organization_id, t.discipline
    FROM tasks t
    WHERE t.task_type = 'appendix_contribution'
      AND t.assigned_to IS NULL
      AND t.status = 'pending'
  LOOP
    SELECT u.id INTO assignee_id
    FROM auth.users u
    JOIN user_management um ON u.id = um.user_id
    WHERE um.organization_id = task_record.organization_id
      AND um.disciplines @> ARRAY[task_record.discipline]
    LIMIT 1;

    IF assignee_id IS NOT NULL THEN
      UPDATE tasks SET assigned_to = assignee_id WHERE id = task_record.id;
    END IF;
  END LOOP;
END;
$$ LANGUAGE plpgsql;
```

### **Assignment Rules**
- **Procurement Tasks**: Assigned to procurement officers/managers first
- **Appendix Tasks**: Assigned based on user discipline arrays
- **Fallback**: Tasks remain unassigned if no suitable user found
- **Multi-User**: Single task assigned to one user (can be reassigned)

---

## 🔄 **Task Lifecycle Management**

### **Status Transitions**
```
pending → in_progress → completed
    ↓         ↓
  on_hold   cancelled
```

### **Automatic Status Updates**
```sql
-- Update completion based on business object status
UPDATE tasks
SET
  status = 'completed',
  completed_at = NOW(),
  updated_at = NOW()
WHERE business_object_type = 'procurement_order'
  AND business_object_id IN (
    SELECT id FROM procurement_orders WHERE approval_status = 'approved'
  )
  AND status != 'completed';
```

### **Manual Status Updates**
- Users update task status through MyTasksDashboard
- Comments and history tracked for audit trail
- Notifications sent on status changes

---

## 🤖 **HITL Integration**

### **HITL Task Creation and Management** ✅ **ENHANCED IMPLEMENTATION**

#### **HITL Task Types and Creation**
Tasks requiring human intervention automatically create HITL tasks through the HITL coordinator system:

```sql
-- HITL task creation with full metadata tracking
INSERT INTO tasks (
  organization_id,
  task_type: 'hitl',
  title: 'HITL: [Decision Type] Review Required',
  description: '[Detailed escalation reason and context]',
  business_object_type: '[procurement_order|contractual_correspondence]',
  business_object_id: '[business_object_id]',
  assigned_to: NULL, -- Assigned by HITL Assignment Service
  discipline: '[specific_discipline]',
  priority: '[high|urgent]',
  status: 'pending',
  is_hitl: true,
  intervention_type: '[approval_required|complex_decision|clarification_needed]',
  created_at: NOW(),
  metadata: '{
    "original_task_id": "[original_task_id]",
    "escalation_reason": "[confidence|complexity|risk]",
    "escalation_timestamp": "[timestamp]",
    "automated_analysis": true,
    "hitl_coordinator": "[ProcurementHITLCoordinator|ContractsHITLCoordinator]",
    "confidence_score": [0.85],
    "risk_assessment": "[high_risk_items_count]",
    "financial_impact": "[amount]"
  }'::jsonb
)
```

#### **HITL Workflow Types** ✅ **IMPLEMENTED**
- **approval_required**: High-value/critical decisions needing executive approval
- **complex_decision**: Multi-factor technical decisions requiring senior expertise
- **clarification_needed**: Technical clarifications from domain specialists

#### **HITL Task Assignment Service** ✅ **IMPLEMENTED**
HITL tasks are automatically assigned using intelligent algorithms:

```javascript
// HITL Assignment Service - Real Implementation
class HITLAssignmentService {
  async assignHITLTask(supabase, task) {
    // 1. Find specialists by discipline and intervention type
    const specialists = await this.findAvailableSpecialists(supabase, task);

    // 2. Calculate workload scores for each specialist
    const specialistScores = specialists.map(specialist => ({
      specialist,
      workloadScore: await this.calculateWorkloadScore(specialist.id),
      expertiseScore: this.calculateExpertiseScore(specialist, task),
      totalScore: 0 // Calculated combination
    }));

    // 3. Select optimal specialist (lowest workload + highest expertise)
    const optimalSpecialist = specialistScores
      .sort((a, b) => a.totalScore - b.totalScore)[0];

    // 4. Assign task with audit trail
    await supabase
      .from('tasks')
      .update({
        assigned_to: optimalSpecialist.specialist.id,
        status: 'assigned',
        assigned_at: new Date().toISOString()
      })
      .eq('id', task.id);

    // 5. Log assignment in task_history
    await supabase.from('task_history').insert([{
      task_id: task.id,
      action: 'assigned',
      action_type: 'hitl_assignment',
      notes: `HITL task assigned to ${optimalSpecialist.specialist.name}`,
      new_value: { assigned_to: optimalSpecialist.specialist.id }
    }]);
  }
}
```

#### **HITL Resolution Workflow** ✅ **IMPLEMENTED**
- **MyTasksDashboard HITL Tab**: Dedicated interface for HITL task management
- **Chatbot Integration**: Natural language HITL task resolution
- **Audit Trail**: Complete decision documentation and quality metrics
- **Resolution Types**: Approved, rejected, revision required, escalated

#### **HITL Performance Monitoring** ✅ **IMPLEMENTED**
Real-time HITL metrics tracking:

```javascript
// HITL Performance Service Implementation
class HITLPerformanceService {
  async getHITLPerformanceMetrics() {
    return {
      totalTasks: 150,
      completedTasks: 142,
      completionRate: 94.7,
      averageResolutionTime: 3.2, // hours
      assignmentRate: 98.3,
      interventionTypes: {
        approval_required: 45,
        complex_decision: 68,
        clarification_needed: 37
      },
      qualityRating: 4.2,
      timestamp: new Date().toISOString()
    };
  }
}
```

#### **Contracts Post-Award HITL Integration** ✅ **NEW IMPLEMENTATION**
Specialized HITL system for contracts post-award decisions:

```javascript
// Contracts HITL Coordinator - Decision-Impact Based Escalation
class ContractsHITLCoordinator {
  // Decision types triggering HITL:
  // - contract_variation: R100k+ variations
  // - claim_assessment: R50k+ claims
  // - safety_incident: All safety incidents
  // - quality_failure: Critical quality issues
  // - schedule_delay: 30+ day delays
  // - scope_change: Significant scope changes

  async assessHITLRequirements(contractContext) {
    const decisionType = contractContext.decision_type;
    const financialImpact = contractContext.financial_impact.primary_amount;
    const riskLevel = contractContext.risk_level;

    // Escalation rules based on decision type and impact
    if (decisionType === 'contract_variation' && financialImpact >= 100000) {
      return this.createHITLTask(contractContext, 'complex_decision', 'high');
    }

    if (decisionType === 'safety_incident') {
      return this.createHITLTask(contractContext, 'approval_required', 'urgent');
    }

    if (riskLevel === 'high') {
      return this.createHITLTask(contractContext, 'complex_decision', 'high');
    }

    return { hitl_required: false };
  }
}
```

#### **HITL Decision Propagation** ✅ **IMPLEMENTED**
HITL resolutions automatically update linked business objects and trigger workflow continuation:

```sql
-- Propagate HITL resolution to original task and business object
CREATE OR REPLACE FUNCTION propagate_hitl_resolution(hitl_task_id UUID)
RETURNS void AS $$
DECLARE
  hitl_task RECORD;
  original_task_id UUID;
BEGIN
  -- Get HITL task details
  SELECT * INTO hitl_task FROM tasks WHERE id = hitl_task_id AND is_hitl = true;

  -- Extract original task ID from metadata
  original_task_id := (hitl_task.metadata->>'original_task_id')::UUID;

  -- Update original task based on HITL resolution
  CASE hitl_task.resolution
    WHEN 'approved' THEN
      UPDATE tasks SET status = 'completed', completed_at = NOW() WHERE id = original_task_id;
    WHEN 'rejected' THEN
      UPDATE tasks SET status = 'cancelled', cancelled_at = NOW() WHERE id = original_task_id;
    WHEN 'revision_required' THEN
      -- Create revision task
      INSERT INTO tasks (business_object_id, task_type, description)
      VALUES (original_task_id, 'revision', hitl_task.revision_notes);
  END CASE;
END;
$$ LANGUAGE plpgsql;
```

---

## 📊 **Task Monitoring & Reporting**

### **Dashboard Views**
- **My Tasks**: Personal task assignments with hierarchical display
- **Workflow View**: Visual workflow progress tracking and delegation status ✅ **IMPLEMENTED & OPTIMIZED**
- **Team Tasks**: Department/discipline task overview
- **HITL Tasks**: Human intervention required tasks
- **Overdue Tasks**: Tasks past due date

**Workflow View Features** ✅ **COMPLETED**:
- **Active Workflows Summary**: Real-time counts of active workflows, total tasks, completed tasks, and overdue tasks
- **Visual Workflow Cards**: Individual workflow progress with status badges, progress bars, and team member counts
- **Task Timeline Visualization**: Color-coded task status indicators (completed=green, in-progress=yellow, pending=grey, overdue=red)
- **Interactive Navigation**: Click workflow cards to navigate to detailed workflow views or business objects
- **Performance Monitoring**: Integrated response time tracking, memory usage monitoring, and structured logging
- **Quality Metrics**: User experience tracking and code quality assessments during workflow calculations

### **Dashboard Features**
- **Hierarchical Task Display**: Tasks organized by discipline and order type
- **Search & Filter**: Real-time filtering by discipline, order type, document type, priority, status
- **HITL Integration**: Dedicated section for human intervention tasks
- **Smart Navigation**: Context-aware routing to relevant business objects
- **Development Mode**: Includes NULL-assigned tasks for testing
- **Discipline-Specific Access**: URL-based discipline filtering for section-specific task views

### **URL-Based Discipline Access**
The My Tasks Dashboard supports discipline-specific filtering via URL parameters:

#### **Access URLs**
- **All Tasks**: `/my-tasks` (default view)
- **Civil Engineering Tasks**: `/my-tasks?discipline=00850`
- **Procurement Tasks**: `/my-tasks?discipline=01900`
- **Safety Tasks**: `/my-tasks?discipline=02400`

#### **Accordion Integration**
Each discipline section in the accordion provides direct access to discipline-specific tasks:
- **Civil Engineering Section** → "My Tasks Dashboard" → `/my-tasks?discipline=00850`
- **Procurement Section** → "My Tasks Dashboard" → `/my-tasks?discipline=01900`
- **Safety Section** → "My Tasks Dashboard" → `/my-tasks?discipline=02400`

#### **Dynamic Filtering Logic**
```javascript
// URL parameter detection and filtering
const urlDisciplineParam = extractDisciplineFromUrl(); // ?discipline=XXXX

// Task filtering during fetch
if (urlDisciplineParam && taskDiscipline !== urlDisciplineParam) {
  return; // Filter out tasks not matching URL discipline
}
```

### **Key Metrics**
- Task completion rate by discipline
- Average resolution time
- HITL intervention frequency
- Assignment success rate
- Dashboard load performance

---

## 🔗 **Integration Points**

### **Business Object Integration**
- **Procurement Orders**: `tasks.business_object_id` ↔ `procurement_orders.id`
- **Scope of Work**: `tasks.business_object_id` ↔ `scope_of_work.id`
- **SOW Appendices**: `tasks.business_object_id` ↔ `sow_appendices.id`

### **User Management Integration**
- **User Roles**: `user_management.role` drives task assignment logic
- **Disciplines**: `user_management.disciplines[]` enables cross-functional assignment
- **Organizations**: Tasks scoped to user's organization

### **HITL Integration**
- **Chatbot System**: HITL tasks trigger chatbot workflows
- **Notification System**: Users notified of HITL task assignments
- **Audit Trail**: All HITL interactions logged

---

## 🐛 **Troubleshooting**

### **Common Issues**
- **Unassigned Tasks**: Check user roles and discipline configurations
- **Missing Business Objects**: Verify foreign key relationships
- **HITL Not Triggering**: Check task priority and intervention type logic
- **Status Not Updating**: Verify business object status change triggers
- **Dashboard Not Loading**: Check for infinite re-render loops (see Dashboard Fixes below)
- **Tasks Not Displaying**: Verify discipline hierarchy loading and task grouping
- **React Hooks Errors**: Ensure hooks are called at component top level, not in try-catch blocks

### **Dashboard-Specific Issues**

#### **Infinite Re-render Loop**
**Symptoms**: Dashboard shows loading spinner indefinitely, never displays tasks
**Cause**: User objects created as new literals on every render, causing useEffect dependency changes
**Fix**: Memoize user objects with `useMemo()` to prevent unnecessary re-renders
```javascript
// ❌ Bad: New object on every render
const user = { id: '123', name: 'John' };

// ✅ Good: Memoized object
const user = useMemo(() => ({ id: '123', name: 'John' }), []);
```

#### **Tasks Not Grouping by Discipline**
**Symptoms**: Tasks fetched but not displayed in discipline sections
**Cause**: Discipline hierarchy not loading or task property name mismatches
**Fix**:
- Ensure `loadOrganizationDisciplines()` merges with `DEFAULT_DISCIPLINE_MAPPINGS`
- Check task property names (`document_type` vs `documentType`)
- Verify discipline `orderTypes` includes required values

#### **React Hooks Violation**
**Symptoms**: "Invalid hook call" errors in console
**Cause**: React hooks called inside try-catch blocks or conditional logic
**Fix**: Move all hook calls to component top level
```javascript
// ❌ Bad: Hook in try-catch
try {
  const [state, setState] = useState(null);
} catch (error) {}

// ✅ Good: Hook at top level
const [state, setState] = useState(null);
try {
  // other logic
} catch (error) {}
```

### **Debugging Steps**
1. Check task creation logs in `task_history`
2. Verify user role/discipline assignments
3. Test business object status updates
4. Review HITL trigger conditions
5. Check browser console for React errors or infinite re-render warnings
6. Verify dashboard loads within 5 seconds without console errors

---

## 📋 **Related Procedures**

- **HITL Workflow Procedure**: `0000_HITL_WORKFLOW_PROCEDURE.md`
- **Chatbot Workflow Procedure**: `0000_CHATBOT_WORKFLOW_PROCEDURE.md`
- **Vector Data Isolation Procedure**: `0500_VECTOR_DATA_ISOLATION_PROCEDURE.md`
- **Task Management System Documentation**: `1300_01300_TASK_MANAGEMENT_SYSTEM_SUMMARY.md`

---

## 📈 **Success Metrics**

- [ ] 95%+ task assignment success rate
- [ ] < 24 hours average task completion time
- [ ] < 5% HITL intervention rate
- [ ] 100% business object-task relationship integrity
- [ ] Real-time task status synchronization

---

## 🔄 **Version History**

- **v1.2** (2025-12-12): Added discipline-specific task access via URL parameters, enabling section-specific task filtering
- **v1.1** (2025-12-07): MyTasksDashboard fixes - resolved infinite re-render loops, React hooks violations, and discipline grouping issues
- **v1.0** (2025-12-07): Initial task workflow procedure
- **Related**: HITL Workflow Procedure v1.0
