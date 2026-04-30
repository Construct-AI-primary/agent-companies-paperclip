---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/workflow-management
gigabrain_tags: procedures, workflow-management, codebase
documentation
openstinger_context: operational-procedures, workflow-management-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# 0000 HITL (Human-in-the-Loop) Workflow Procedure

## Overview
This procedure defines the Human-in-the-Loop (HITL) workflow system for Construct AI, enabling intelligent escalation of complex tasks to human experts when automated systems cannot provide adequate solutions. HITL integrates seamlessly with the chatbot system for natural language interaction and decision support.

## 🏗️ **HITL Workflow Architecture**

### **HITL Task Types vs Workflow Summaries**

Construct AI implements a two-tier HITL system with clear separation of responsibilities:

#### **1. Individual HITL Tasks (Simple Modal)**
- **Purpose**: Focused review of specific analysis outputs or decisions
- **UI**: Simple HITL modal in MyTasksDashboard
- **Scope**: Individual specialist reviews, final manager approvals
- **Examples**:
  - 17 specialist HITL tasks (structural, geotechnical, process, etc.)
  - Final contracts manager HITL review
  - Any individual analysis requiring human judgment

#### **2. Workflow Summaries (AgentWorkflowReview Modal)**
- **Purpose**: Comprehensive overview of entire agent execution workflow
- **UI**: AgentWorkflowReview modal with detailed workflow visualization
- **Scope**: Complete process from start to finish, all specialist analyses, final response
- **Examples**:
  - Correspondence Agent Orchestration workflow summary
  - Procurement workflow overview
  - Any complex multi-step agent workflow

### **Key Architectural Principle**
**ALL individual HITL tasks use the simple modal** - regardless of complexity, domain, or workflow stage. AgentWorkflowReview is reserved exclusively for workflow summaries and comprehensive process overviews.

**🔗 Cross-References to Related Procedures:**

**Agent Security & Governance:**
- → `0000_AGENT_ROLES_IMPLEMENTATION_PROCEDURE.md` → **MANDATORY REFERENCE** - Agent discipline confinement, role-based access control, and audit logging requirements for all HITL agents
- → `IMPLEMENT_RLS_POLICIES.md` → Database security policies for HITL operations

**Workflow Implementation Procedures:**
- → `0000_WORKFLOW_TASK_PROCEDURE.md` → Task execution procedures and HITL task assignment workflows
- → `0000_WORKFLOW_TEMPLATE_FIELD_ATTRIBUTE_IMPLEMENTATION_PROCEDURE.md` → AI field attribute handling in task workflows
- → `0000_WORKFLOW_OPTIMIZATION_GUIDE.md` → Performance monitoring and HITL workflow optimization

**AI & Integration Procedures:**
- → `0000_CHATBOT_COMPREHENSIVE_PROCEDURE.md` → Chatbot integration for HITL natural language interaction and decision support
- → `0500_VECTOR_DATA_ISOLATION_PROCEDURE.md` → Vector data integration for HITL context loading and semantic search

**System Maintenance & Troubleshooting:**
- → `0000_DEBUGGING_GUIDE.md` → Advanced debugging techniques for HITL integration issues and workflow problems
- → `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` → Framework for diagnosing HITL workflow failures and resolution issues

## Scope
- Intelligent task escalation based on complexity assessment
- Human expert intervention for high-value decisions
- Chatbot integration for HITL task resolution
- Audit trail and quality assurance for human decisions
- Performance monitoring and continuous improvement

---

  ## 🎯 **HITL Trigger Conditions**

  ### **Multiple HITL Initiation Methods**

  HITL workflows can be initiated through several mechanisms. The Correspondence Agent Orchestration workflow (00435) implements mandatory HITL for all correspondence, while other workflows use conditional escalation.

  #### **1. Correspondence Agent Orchestration - MANDATORY HITL** ✅ **IMPLEMENTED**
  
  The ContractualCorrespondenceReplyAgent enforces **mandatory HITL for ALL correspondence analysis**:
  
  ```javascript
  // CORRESPONDENCE AGENT POLICY: ALWAYS CREATE HITL TASKS
  // This agent MUST create HITL tasks for ALL correspondence - no assessment based on complexity/risk
  
  async performHITLWorkflow() {
    console.log('🔄 [CorrespondenceOrchestrator] Correspondence agent - HITL ALWAYS required for all correspondence analysis');
    const contractAnalysis = await this.runContractsManager();

    // MANDATORY HITL for correspondence analysis
    const hitlAssessment = {
      required: true,
      reason: 'Correspondence analysis requires mandatory human review',
      confidence: 100, // Always high confidence since HITL is guaranteed
      riskLevel: 'standard_review',
      priority: 'high'
    };

    // Create HITL task using the new HITL API - ALWAYS create for correspondence
    try {
      const hitlTask = await this.createHITLTask(contractAnalysis, hitlAssessment);
      return {
        decision: 'pending_hitl_review',
        confidenceScore: hitlAssessment.confidence,
        comments: `Mandatory HITL task created for correspondence review: ${hitlTask.task?.id}`,
        requiresHumanInput: true,
        hitlTaskId: hitlTask.task?.id,
        hitlCreated: true
      };
    } catch (error) {
      // For correspondence agent, HITL is mandatory - if creation fails, this is a critical error
      throw new Error(`Mandatory HITL task creation failed for correspondence analysis: ${error.message}`);
    }
  }
  ```

  **Key Characteristics:**
  - **100% HITL Rate**: All correspondence requires human review
  - **No Assessment**: No complexity/risk evaluation - HITL is always triggered
  - **Multiple HITL Tasks**: Creates 17 specialist HITL tasks + 1 final contracts manager HITL task
  - **Simple Modal for All**: ALL HITL tasks use the simple HITL modal in MyTasksDashboard
  - **Automatic Assignment**: `hitlAssignmentService` assigns tasks to appropriate specialists
  - **AgentWorkflowReview Reserved**: For comprehensive workflow summaries only, not individual HITL reviews

  #### **2. Task-Based HITL Escalation (Conditional)**
  Other workflows use task-based escalation based on predefined criteria:

```sql
-- HITL triggered for tasks meeting complexity criteria
CREATE OR REPLACE FUNCTION assess_hitl_eligibility(task_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
  task_record RECORD;
  should_escalate BOOLEAN := false;
BEGIN
  SELECT * INTO task_record FROM tasks WHERE id = task_id;

  -- Complexity-based escalation rules
  IF task_record.priority = 'urgent' THEN
    should_escalate := true;
  ELSIF task_record.business_object_type = 'procurement_order'
    AND (SELECT estimated_value FROM procurement_orders WHERE id = task_record.business_object_id) > 500000 THEN
    should_escalate := true;
  ELSIF task_record.task_type IN ('complex_decision', 'approval_required') THEN
    should_escalate := true;
  END IF;

  RETURN should_escalate;
END;
$$ LANGUAGE plpgsql;
```

#### **2. Agent-Initiated HITL Workflow**
AI agents can create HITL tasks directly as part of their processing workflow:

```javascript
// Agent-initiated HITL task creation (from ContractualCorrespondenceReplyAgent)
async processCorrespondenceWithHITLTask(correspondence, options = {}) {
  // Step 1-5: Complete automated analysis and specialist consultation
  await this.runCorrespondenceAnalyser();
  await this.extractIdentifiers();
  await this.retrieveDocuments();
  await this.runSpecialistAgents();
  await this.runContractsManager();

  // Step 6: HITL Assessment and Task Creation
  const hitlAssessment = assessCorrespondenceHITLEligibility(this.state);

  if (hitlAssessment.shouldEscalate) {
    const hitlTask = createHITLTaskFromAgent({
      originalTask: currentProcessingTask,
      assessment: hitlAssessment,
      agentData: this.state,
      businessObject: correspondence
    });

    const specialist = assignHITLSpecialist(hitlTask);
    return { originalTask, hitlTask, specialist };
  }
}
```

#### **3. Advanced Agent-Orchestrated HITL Workflows**
Complex workflows integrate autonomous agent orchestration with HITL for sophisticated document processing. This pattern applies across all disciplines with discipline-specific implementations:

```javascript
// Generic Agent-Orchestrated HITL Framework (adaptable to any discipline)
class AdvancedWorkflowAgentOrchestration {
  constructor() {
    this.agentMonitor = new AgentCapabilityMonitor();
    this.hitlManager = new DisciplineHITLManager();
    this.sequenceEngine = new DocumentSequenceEngine();
  }

  async orchestrateWorkflow(workflowId, sequence) {
    // Phase 1: Real-time Agent Capability Monitoring
    const capableAgents = await this.agentMonitor.findAvailableAgents(sequence);

    for (const sequenceItem of sequence) {
      // Immediate Task Assignment Upon Agent Capability
      const agent = await this.agentMonitor.waitForCapableAgent(sequenceItem);

      if (agent) {
        const taskResult = await this.dispatchToAgent(sequenceItem, agent);

        // Completion-Triggered HITL Creation
        if (taskResult.completed && this.requiresHITLReview(taskResult)) {
          await this.hitlManager.createCompletionTriggeredHITL({
            originalTask: taskResult,
            sequenceItem: sequenceItem,
            qualityThreshold: this.calculateQualityThreshold(sequenceItem),
            stakeholderIdentification: await this.identifyReviewers(sequenceItem)
          });
        }
      }
    }
  }

  // Discipline-Adaptive HITL Reviewer Assignment
  async identifyReviewers(sequenceItem, disciplineContext) {
    // Generic reviewer matrix - customize per discipline
    const reviewerMatrix = this.getDisciplineReviewerMatrix(disciplineContext);

    return reviewerMatrix[sequenceItem.type] || this.getDefaultReviewers(disciplineContext);
  }

  // Adaptive Quality Threshold Assessment
  calculateQualityThreshold(sequenceItem, disciplineContext) {
    // Base thresholds with discipline-specific adjustments
    const baseThresholds = {
      'technical_specs': 0.85,      // High confidence for technical documents
      'safety_documents': 0.95,     // Very high confidence for safety
      'schedules_timeline': 0.80,   // Moderate confidence for schedules
      'training_materials': 0.90,   // High confidence for training
      'logistics_operations': 0.75, // Lower threshold for logistics
      'compliance_standards': 0.85  // High confidence for standards
    };

    return this.adjustThresholdForDiscipline(
      baseThresholds[sequenceItem.type] || 0.80,
      disciplineContext
    );
  }
}

// Example Implementation: Procurement Discipline
class ProcurementHITLOrchestration extends AdvancedWorkflowAgentOrchestration {
  getDisciplineReviewerMatrix() {
    return {
      'specs': ['engineering', 'technical'],           // Product Specifications
      'safety': ['safety', 'compliance'],             // Safety Data Sheets
      'schedules': ['construction', 'logistics'],     // Delivery Schedules
      'training': ['technical', 'hr'],                // Training Materials
      'logistics': ['logistics', 'operations'],       // Logistics Documents
      'standards': ['quality', 'compliance']          // Packing Standards
    };
  }

  adjustThresholdForDiscipline(baseThreshold, context) {
    // Procurement-specific adjustments
    if (context.orderValue > 500000) return Math.max(baseThreshold, 0.90);
    if (context.isComplexEquipment) return Math.max(baseThreshold, 0.85);
    return baseThreshold;
  }
}
```

#### **4. Parallel Multi-Discipline HITL Framework** ✅ **IMPLEMENTED**
The ParallelSpecialistCoordinator implements a fully functional parallel multi-discipline HITL system where complex correspondence automatically spawns concurrent specialist reviews across multiple engineering disciplines:

#### **5. Contracts Post-Award HITL System** ✅ **NEW IMPLEMENTATION**
The ContractsHITLCoordinator provides decision-impact based escalation for contracts post-award system, ensuring high-value contract decisions get appropriate human oversight:

```javascript
// Real HITL Implementation (ParallelSpecialistCoordinator)
class ParallelSpecialistCoordinator {
  async createHITLTask(task) {
    console.log(`📋 [ParallelCoordinator] Creating HITL task for ${task.discipline} specialist review`);

    const interventionType = this.determineInterventionType(task);

    const hitlTaskData = {
      title: `HITL: ${task.name} Review Required`,
      description: `Human specialist review required for ${task.discipline} discipline analysis`,
      business_object_type: 'contractual_correspondence',
      business_object_id: task.context?.correspondence?.id || 'unknown',
      discipline: task.discipline,
      priority: task.priority || 'high',
      intervention_type: interventionType,
      hitl_reason: `Complex ${task.discipline} analysis requiring human specialist expertise`,
      confidence_score: task.confidence || 0.5,
      ai_decision: task.ai_decision || 'HITL required for complex technical evaluation',
      metadata: {
        original_specialist_task: task.id,
        discipline: task.discipline,
        expertise_required: task.hitlConfig?.expertise || [`${task.discipline} engineering`],
        created_by_agent: 'ParallelSpecialistCoordinator',
        creation_timestamp: new Date().toISOString()
      }
    };

    // Make real API call to create HITL task
    const hitlTask = await this.createRealHITLTask(hitlTaskData);
    return hitlTask.task;
  }

  async createRealHITLTask(taskData) {
    const response = await fetch('/api/tasks/hitl', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        ...this.getAuthHeaders()
      },
      body: JSON.stringify(taskData)
    });

    if (!response.ok) {
      throw new Error(`HITL API call failed: ${response.status}`);
    }

    const result = await response.json();
    return result.data;
  }

  determineInterventionType(task) {
    if (task.priority === 'critical' || task.complexity === 'critical') return 'approval_required';
    if (task.complexity === 'high' || ['structural', 'geotechnical', 'process', 'instrumentation'].includes(task.discipline)) {
      return 'complex_decision';
    }
    return 'clarification_needed';
  }
}
```

// Discipline-Specific HITL Assignment
async simulateSpecialistAssignment(taskData) {
  const disciplineSpecialists = {
    structural: [
      { id: 'user_structural_1', name: 'Senior Structural Engineer', role: 'structural_engineer' },
      { id: 'user_structural_2', name: 'Principal Structural Engineer', role: 'principal_engineer' }
    ],
    geotechnical: [
      { id: 'user_geotech_1', name: 'Principal Geotechnical Engineer', role: 'geotechnical_engineer' }
    ],
    process: [
      { id: 'user_process_1', name: 'Lead Process Engineer', role: 'process_engineer' }
    ],
    // ... additional discipline specialists
  };

  const specialists = disciplineSpecialists[taskData.discipline] || [
    { id: 'user_general_1', name: 'Engineering Manager', role: 'engineering_manager' }
  ];

  // Assign based on intervention type priority
  if (taskData.intervention_type === 'approval_required') {
    return specialists.find(s => s.role.includes('principal') || s.role.includes('lead')) || specialists[0];
  }

  return specialists[0];
}
```

#### **4. Multi-Discipline HITL Collaboration Framework**
Complex workflows require HITL coordination across multiple disciplines. This framework is discipline-agnostic and can be adapted for any cross-functional workflow:

```javascript
// Generic Multi-Discipline HITL Coordination Framework
class MultiDisciplineHITLCoordinator {
  constructor(disciplineConfig) {
    this.disciplineRouter = new DisciplineCollaborationRouter(disciplineConfig);
    this.hitlWorkflow = new ParallelHITLWorkflow();
    this.stakeholderManager = new StakeholderManager();
  }

  async coordinateHITLWorkflow(workflowContext, workItems) {
    // Parallel HITL Task Creation for Multiple Work Items
    const hitlTasks = await Promise.all(
      workItems.map(item => this.createDisciplineHITL(item, workflowContext))
    );

    // Discipline-Specific Assignment Based on Configuration
    const assignments = await this.assignByConfiguredDisciplines(hitlTasks, workflowContext);

    // Cross-Discipline Communication Setup
    await this.setupCollaborationChannels(assignments, workflowContext);

    return assignments;
  }

  async createDisciplineHITL(workItem, context) {
    // Use discipline configuration to determine requirements
    const disciplineMapping = this.getDisciplineMapping(context.discipline, workItem.type);

    return {
      workItem: workItem.id,
      requiredDisciplines: disciplineMapping.disciplines,
      priority: this.calculatePriority(workItem, context),
      complexity: this.assessComplexity(workItem, context),
      expertise: disciplineMapping.requiredExpertise
    };
  }

  // Example Discipline Configuration (Procurement)
  getDisciplineMapping(disciplineCode, workItemType) {
    const mappings = {
      'procurement_01900': {
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
        // Additional mappings...
      }
    };

    return mappings[disciplineCode]?.[workItemType] || {
      disciplines: [disciplineCode.split('_')[0]], // Default to primary discipline
      requiredExpertise: ['general']
    };
  }

  // Generic Technical Team Assignment Pattern
  async assignTechnicalTeamHITL(workItem, technicalDisciplines) {
    // Adaptable pattern for technical disciplines across any domain
    const technicalExpertiseAreas = this.getTechnicalExpertiseAreas(workItem);

    return await this.createTechnicalHITLTasks(
      workItem,
      technicalDisciplines,
      technicalExpertiseAreas
    );
  }
}
```

#### **3. Business Object Type Auto-Escalation**
Certain business object types automatically trigger HITL workflows:

```javascript
// Business object type assessment
const autoEscalateTypes = [
  'contractual_correspondence',    // Always requires human review
  'procurement_order_high_value', // > R500k procurement orders
  'variation_order_major',        // Major contract variations
  'claim_dispute',               // Contractual disputes
  'regulatory_compliance'        // Regulatory compliance matters
];
```

#### **2. HITL Task Creation**
```sql
-- Create HITL task when escalation is needed
INSERT INTO tasks (
  organization_id,
  task_type,
  title,
  description,
  business_object_type,
  business_object_id,
  assigned_to,
  discipline,
  priority,
  status,
  is_hitl,
  intervention_type,
  created_at,
  metadata
)
SELECT
  t.organization_id,
  'hitl',
  'HITL: ' || t.title,
  'Human intervention required for: ' || t.description,
  t.business_object_type,
  t.business_object_id,
  NULL, -- Will be assigned to HITL specialist
  'governance',
  CASE WHEN t.priority = 'urgent' THEN 'urgent' ELSE 'high' END,
  'pending',
  true,
  CASE
    WHEN t.priority = 'urgent' THEN 'approval_required'
    WHEN t.business_object_type = 'procurement_order' THEN 'complex_decision'
    ELSE 'clarification_needed'
  END,
  NOW(),
  jsonb_build_object(
    'original_task_id', t.id,
    'escalation_reason', 'complexity_assessment',
    'escalation_timestamp', NOW(),
    'automated_analysis', 'true'
  )
FROM tasks t
WHERE assess_hitl_eligibility(t.id) = true
  AND NOT EXISTS (
    SELECT 1 FROM tasks hitl
    WHERE hitl.business_object_type = t.business_object_type
      AND hitl.business_object_id = t.business_object_id
      AND hitl.is_hitl = true
      AND hitl.status IN ('pending', 'in_progress')
  );
```

### **Manual HITL Escalation**
Users can manually escalate tasks through the MyTasksDashboard interface when they encounter situations requiring human judgment.

---

## 👥 **HITL Task Assignment** ✅ **IMPLEMENTED**

### **HITL Assignment Service Implementation**
HITL tasks are automatically assigned to qualified specialists using the `hitlAssignmentService`:

```javascript
// HITL Assignment Service Implementation
class HITLAssignmentService {
  async assignHITLTask(supabase, task) {
    console.log(`👤 [HITLAssignment] Assigning HITL task ${task.id} for ${task.discipline}`);

    // Get available specialists for this discipline and intervention type
    const specialists = await this.findAvailableSpecialists(supabase, task);

    if (specialists.length === 0) {
      console.warn(`⚠️ [HITLAssignment] No specialists available for ${task.discipline}`);
      return { assigned: false, reason: 'no_specialists_available' };
    }

    // Select best specialist based on workload and expertise
    const selectedSpecialist = await this.selectOptimalSpecialist(specialists, task);

    // Assign the task
    const { error: assignError } = await supabase
      .from('tasks')
      .update({
        assigned_to: selectedSpecialist.id,
        status: 'assigned',
        assigned_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .eq('id', task.id);

    if (assignError) throw assignError;

    // Log assignment
    await supabase.from('task_history').insert([{
      task_id: task.id,
      user_id: selectedSpecialist.id,
      action: 'assigned',
      notes: `HITL task assigned to ${selectedSpecialist.name} (${selectedSpecialist.role})`,
      created_at: new Date().toISOString()
    }]);

    return {
      assigned: true,
      assigned_to: selectedSpecialist.id,
      specialist_name: selectedSpecialist.name,
      assignment_type: 'automated'
    };
  }

  async findAvailableSpecialists(supabase, task) {
    // Query for specialists based on discipline and intervention type
    const { data: specialists, error } = await supabase
      .from('user_management')
      .select(`
        user_id,
        first_name,
        last_name,
        email,
        role,
        disciplines,
        organization_id
      `)
      .eq('organization_id', task.organization_id)
      .eq('status', 'active');

    if (error) throw error;

    // Filter specialists based on intervention type and discipline
    return specialists.filter(user => {
      // Check discipline expertise
      const hasDiscipline = user.disciplines?.includes(task.discipline) ||
                           user.disciplines?.includes('general') ||
                           user.disciplines?.includes('engineering');

      // Check role suitability for intervention type
      const suitableRole = this.isRoleSuitableForIntervention(user.role, task.intervention_type);

      return hasDiscipline && suitableRole;
    }).map(user => ({
      id: user.user_id,
      name: `${user.first_name} ${user.last_name}`.trim(),
      email: user.email,
      role: user.role,
      disciplines: user.disciplines
    }));
  }

  isRoleSuitableForIntervention(role, interventionType) {
    const roleMappings = {
      'approval_required': ['executive', 'governance_admin', 'ceo', 'coo', 'principal_engineer', 'chief_engineer'],
      'complex_decision': ['senior_engineer', 'chief_engineer', 'technical_director', 'principal_engineer', 'engineering_manager'],
      'clarification_needed': ['engineer', 'senior_engineer', 'project_manager', 'technical_specialist']
    };

    return roleMappings[interventionType]?.includes(role) || false;
  }

  async selectOptimalSpecialist(specialists, task) {
    // Calculate workload scores for each specialist
    const specialistScores = await Promise.all(
      specialists.map(async (specialist) => {
        const workloadScore = await this.calculateWorkloadScore(specialist.id);
        const expertiseScore = this.calculateExpertiseScore(specialist, task);

        return {
          specialist,
          totalScore: workloadScore + expertiseScore
        };
      })
    );

    // Return specialist with lowest total score (best availability + expertise)
    const bestMatch = specialistScores.sort((a, b) => a.totalScore - b.totalScore)[0];

    return bestMatch.specialist;
  }

  async calculateWorkloadScore(specialistId) {
    // Count active HITL tasks assigned to this specialist
    const { count } = await supabase
      .from('tasks')
      .select('*', { count: 'exact', head: true })
      .eq('assigned_to', specialistId)
      .eq('is_hitl', true)
      .in('status', ['pending', 'assigned', 'in_progress']);

    // Lower score is better (less workload)
    return count || 0;
  }

  calculateExpertiseScore(specialist, task) {
    let score = 0;

    // Primary discipline match
    if (specialist.disciplines?.includes(task.discipline)) {
      score += 10;
    }

    // Related discipline match
    if (this.isRelatedDiscipline(specialist.disciplines, task.discipline)) {
      score += 5;
    }

    // Role priority for intervention type
    if (task.intervention_type === 'approval_required' &&
        ['executive', 'principal', 'chief'].some(title => specialist.role.includes(title))) {
      score += 8;
    }

    return score;
  }

  isRelatedDiscipline(userDisciplines, taskDiscipline) {
    const relatedDisciplines = {
      'structural': ['civil', 'geotechnical', 'architectural'],
      'geotechnical': ['civil', 'structural', 'environmental'],
      'civil': ['structural', 'geotechnical', 'environmental'],
      'mechanical': ['electrical', 'process'],
      'electrical': ['mechanical', 'instrumentation'],
      'process': ['mechanical', 'instrumentation', 'chemical']
    };

    return relatedDisciplines[taskDiscipline]?.some(related =>
      userDisciplines?.includes(related)
    ) || false;
  }
}
```

### **Assignment Rules** ✅ **IMPLEMENTED**
- **approval_required**: Executives, governance admins, principal/chief engineers
- **complex_decision**: Senior engineers, chief engineers, technical directors, engineering managers
- **clarification_needed**: Engineers, senior engineers, project managers, technical specialists
- **Workload Balancing**: Tasks assigned to specialists with lowest current HITL workload
- **Expertise Matching**: Priority given to specialists with matching or related disciplines
- **Fallback**: Automatic fallback to general engineering roles if no perfect matches

---

## 🤖 **HITL Resolution Workflow**

### **Chatbot Integration**
HITL tasks integrate with the chatbot system for natural language interaction:

#### **1. HITL Task Activation**
```javascript
// Activate HITL task in chatbot
function activateHITLTask(taskId) {
  // Load task context
  const task = await getTaskById(taskId);

  // Initialize chatbot session with task context
  const session = await chatbot.createSession({
    taskId: task.id,
    interventionType: task.intervention_type,
    businessObjectType: task.business_object_type,
    businessObjectId: task.business_object_id,
    userId: task.assigned_to
  });

  // Send initial context to user
  await chatbot.sendMessage(session.id, generateHITLContext(task));

  return session;
}
```

#### **2. Interactive Resolution**
- **Natural Language Processing**: Users can ask questions and provide reasoning
- **Context Awareness**: Chatbot has full access to business object data
- **Decision Support**: AI provides recommendations and analysis
- **Audit Trail**: All interactions logged for compliance

#### **3. Resolution Types**
```javascript
const resolutionTypes = {
  APPROVED: 'task_approved',
  REJECTED: 'task_rejected',
  CLARIFIED: 'clarification_provided',
  ESCALATED: 'further_escalation_needed',
  DELEGATED: 'delegated_to_another_user'
};
```

### **Agent-Initiated HITL Resolution**
AI agents can trigger and manage HITL workflows directly within their processing pipeline:

#### **Contractual Correspondence Agent HITL Integration**
```javascript
// ContractualCorrespondenceReplyAgent HITL workflow (implemented)
class ContractualCorrespondenceReplyAgent {
  // 7-step workflow with HITL at step 6
  async processCorrespondence(correspondence, options = {}) {
    // Steps 1-5: Automated analysis
    await this.runCorrespondenceAnalyser();
    await this.extractIdentifiers();
    await this.retrieveDocuments();
    await this.runSpecialistAgents();
    await this.runContractsManager();

    // Step 6: HITL Assessment and Modal Dispatch
    const existingHITLResult = this.state.hitl_result || this.state.final_response;

    if (!this.isValidHITLResult(existingHITLResult)) {
      // Dispatch HITL modal for human review
      this.dispatchHITLModalEvent(reviewData);
      const humanResponse = await this.waitForHITLResponse();

      // Process human decision
      await this.processHITLResponse(humanResponse);
    }

    // Step 7: Generate final response
    const finalResult = await this.generateProfessionalContractualLetter();
    return finalResult;
  }

  // HITL modal event dispatch
  dispatchHITLModalEvent(reviewData) {
    const hitlEvent = new CustomEvent('hitlModalRequest', {
      detail: {
        agentId: this.pageId,
        sessionId: `hitl_${Date.now()}`,
        reviewData: {
          originalCorrespondence: this.state.question,
          analysis: this.state.analysis_sum_complete,
          extractedIdentifiers: this.state.ref_list_variations,
          specialistAnalysis: this.state.comments_all,
          contractsManagerRecommendation: this.state.final_response,
          confidenceScore: this.calculateConfidenceScore()
        },
        callback: (response) => this.handleHITLResponse(response),
        timeout: 600000 // 10 minutes
      },
      bubbles: true
    });

    document.dispatchEvent(hitlEvent);
  }
}
```

#### **HITL Response Processing**
```javascript
// Handle human responses from HITL modal
handleHITLModalResponse(response) {
  this.state.hitl_decision = response.action;
  this.state.hitl_approver = response.reviewer;
  this.state.hitl_approver_comments = response.comments;

  switch (response.action) {
    case 'approve':
      return this.handleHITLApproval(response);
    case 'revise':
      return this.handleHITLRevision(response);
    case 'reject':
      return this.handleHITLRejection(response);
  }
}
```

### **Direct Resolution** ✅ **IMPLEMENTED**
Users can resolve HITL tasks directly through the MyTasksDashboard HITL tab with comprehensive API-driven resolution:

```javascript
// HITL Task Resolution API Implementation
PUT /api/tasks/hitl/:id/resolve

// Request Body
{
  "decision": "approved|rejected|revision_required",
  "decision_reason": "Detailed explanation of the decision",
  "decision_details": "Additional context and justification",
  "confidence_override": 0.85,  // Optional human confidence assessment
  "approved_content": "...",    // For approved content
  "revision_requests": "...",   // For revision requirements
  "quality_rating": 4,          // 1-5 quality rating
  "time_spent_minutes": 15      // Time spent on review
}

// Response includes comprehensive audit trail
{
  "success": true,
  "data": {
    "task": { /* resolved task */ },
    "audit_trail": {
      "entries_created": 3,
      "resolution_metrics": {
        "time_to_resolution": 45,
        "decision_alignment": false,
        "quality_rating": 4
      }
    }
  }
}
```

#### **Resolution Process** ✅ **IMPLEMENTED**
```javascript
// Comprehensive HITL Resolution with Audit Trail
async resolveHITLTask(taskId, resolutionData) {
  // 1. Validate resolution data
  const validation = validateResolutionData(resolutionData);

  // 2. Get current task with full context
  const currentTask = await getTaskWithUserContext(taskId);

  // 3. Calculate resolution metrics
  const metrics = calculateResolutionMetrics(currentTask, resolutionData);

  // 4. Update task with resolution
  const resolvedTask = await updateTaskWithResolution(taskId, resolutionData, metrics);

  // 5. Create comprehensive audit trail
  await createResolutionAuditTrail(taskId, currentTask, resolvedTask, metrics);

  // 6. Create performance metrics entry
  await createPerformanceMetricsEntry(taskId, metrics);

  // 7. Trigger workflow continuation
  await triggerWorkflowContinuation(resolvedTask);

  return { task: resolvedTask, audit_trail: auditEntries };
}

// Audit Trail Creation
async createResolutionAuditTrail(taskId, before, after, metrics) {
  const auditEntries = [
    // Main resolution entry
    {
      action: 'hitl_resolved',
      action_type: 'decision',
      notes: `HITL task resolved with decision: ${after.decision}`,
      old_value: { status: before.status },
      new_value: { status: 'completed', decision: after.decision }
    },
    // Decision justification
    {
      action: 'hitl_decision_justification',
      action_type: 'justification',
      notes: `Decision justification: ${after.decision_reason}`,
      metadata: { quality_rating: metrics.quality_rating }
    },
    // Workflow continuation
    {
      action: 'workflow_continuation_triggered',
      action_type: 'continuation',
      notes: `Workflow continuation triggered based on ${after.decision} decision`
    }
  ];

  await insertAuditEntries(taskId, auditEntries);
}
```

### **Resolution Types** ✅ **IMPLEMENTED**
```javascript
const resolutionTypes = {
  APPROVED: {
    value: 'approved',
    description: 'Content approved as-is',
    workflow_action: 'proceed_to_next_step',
    audit_category: 'positive_decision'
  },
  REJECTED: {
    value: 'rejected',
    description: 'Content rejected - alternative approach required',
    workflow_action: 'block_and_redirect',
    audit_category: 'blocking_decision'
  },
  REVISION_REQUIRED: {
    value: 'revision_required',
    description: 'Content requires modifications before approval',
    workflow_action: 'request_changes',
    audit_category: 'modification_decision'
  }
};
```

---

## 📊 **HITL Performance Monitoring** ✅ **IMPLEMENTED**

### **Real-time Metrics Tracking** ✅ **IMPLEMENTED**
HITL performance is tracked through dedicated services and database tables:

```javascript
// HITL Performance Service Implementation
class HITLPerformanceService {
  async getHITLPerformanceMetrics() {
    // Get HITL task metrics from the last 30 days
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const { data: hitlTasks, error } = await supabase
      .from('tasks')
      .select('*')
      .eq('is_hitl', true)
      .gte('created_at', thirtyDaysAgo.toISOString())
      .order('created_at', { ascending: false });

    if (error) throw error;

    // Calculate HITL performance KPIs
    const totalTasks = hitlTasks?.length || 0;
    const completedTasks = hitlTasks?.filter(t => t.status === 'completed').length || 0;
    const averageResolutionTime = this.calculateAverageResolutionTime(hitlTasks || []);
    const interventionTypes = this.categorizeInterventionTypes(hitlTasks || []);

    // Calculate assignment metrics
    const assignedTasks = hitlTasks?.filter(t => t.assigned_to).length || 0;
    const overdueTasks = this.calculateOverdueTasks(hitlTasks || []);

    return {
      totalTasks,
      completedTasks,
      completionRate: totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0,
      assignedTasks,
      assignmentRate: totalTasks > 0 ? (assignedTasks / totalTasks) * 100 : 0,
      overdueTasks,
      averageResolutionTime,
      interventionTypes,
      averageQualityScore: this.calculateAverageQualityScore(hitlTasks || []),
      timestamp: new Date().toISOString()
    };
  }

  calculateAverageResolutionTime(interventions) {
    const resolvedInterventions = interventions.filter(h => h.resolved_at && h.created_at);

    if (resolvedInterventions.length === 0) return 0;

    const totalTime = resolvedInterventions.reduce((sum, intervention) => {
      const created = new Date(intervention.created_at);
      const resolved = new Date(intervention.resolved_at);
      return sum + (resolved - created);
    }, 0);

    // Return average in hours
    return Math.round((totalTime / resolvedInterventions.length) / (1000 * 60 * 60));
  }
}
```

### **Performance Metrics Database** ✅ **IMPLEMENTED**
```sql
-- HITL performance metrics table
CREATE TABLE hitl_performance_metrics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID REFERENCES tasks(id),
  resolver_id UUID REFERENCES auth.users(id),
  discipline TEXT,
  intervention_type TEXT,
  decision TEXT,
  ai_confidence_before DECIMAL(3,2),
  human_confidence_after DECIMAL(3,2),
  decision_alignment BOOLEAN,
  time_to_resolution_minutes INTEGER,
  quality_rating INTEGER CHECK (quality_rating >= 1 AND quality_rating <= 5),
  complexity_level TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- HITL task history table (audit trail)
CREATE TABLE task_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID REFERENCES tasks(id),
  user_id UUID REFERENCES auth.users(id),
  action TEXT,
  action_type TEXT,
  notes TEXT,
  old_value JSONB,
  new_value JSONB,
  metadata JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### **Quality Assurance** ✅ **IMPLEMENTED**
- **Decision Quality Tracking**: Each resolution includes quality ratings and confidence assessments
- **Audit Trail Review**: Comprehensive audit entries for every HITL interaction
- **Performance Analytics**: Real-time metrics on resolution times, decision alignment, and specialist performance
- **Continuous Improvement**: Performance data feeds into AI model training and specialist recommendations

#### **HITL Performance API** ✅ **IMPLEMENTED**
```javascript
// GET /api/tasks/hitl/stats - Real-time performance metrics
{
  "success": true,
  "data": {
    "total": 150,
    "pending": 12,
    "assigned": 8,
    "completed": 130,
    "overdue": 3,
    "average_resolution_time": 2.4,  // hours
    "completion_rate": 86.7,
    "assignment_rate": 94.7,
    "timestamp": "2026-04-01T08:59:57.000Z"
  }
}
```

---

## 🔄 **HITL Decision Propagation**

### **Original Task Updates**
When HITL tasks are resolved, the original tasks are updated accordingly:

```sql
-- Propagate HITL resolution to original task
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
    WHEN 'escalated' THEN
      -- Create new HITL task with higher priority
      -- Implementation depends on escalation rules
      NULL;
    WHEN 'clarification_provided' THEN
      -- Update original task with clarification notes
      UPDATE tasks SET
        description = description || '\n\nClarification: ' || hitl_task.clarification_notes,
        updated_at = NOW()
      WHERE id = original_task_id;
  END CASE;
END;
$$ LANGUAGE plpgsql;
```

### **Business Object Updates**
HITL resolutions can trigger updates to the underlying business objects based on the decision context.

---

## 🔗 **Integration with Chatbot System**

### **Chatbot Workflow Cross-Reference**
- **HITL Task Initiation**: `0000_CHATBOT_WORKFLOW_PROCEDURE.md#hitl-integration`
- **Session Management**: Chatbot maintains HITL-specific conversation contexts
- **Decision Support**: AI provides analysis and recommendations during HITL resolution
- **Knowledge Base**: HITL decisions contribute to chatbot learning and improvement

### **Vector Data Integration**
- **Context Loading**: `0500_VECTOR_DATA_ISOLATION_PROCEDURE.md#hitl-context`
- **Semantic Search**: Vector embeddings help provide relevant information during HITL resolution
- **Knowledge Retrieval**: Historical HITL decisions inform new resolutions

---

## 🐛 **Troubleshooting HITL Issues**

### **Common Problems**
- **Tasks Not Escalating**: Check complexity assessment rules
- **Unassigned HITL Tasks**: Verify user role configurations
- **Chatbot Integration Issues**: Check session initialization
- **Resolution Not Propagating**: Verify metadata structure

### **Debugging Steps**
1. Check HITL eligibility assessment logs
2. Verify user role and discipline assignments
3. Test chatbot session creation
4. Review decision propagation logic
5. Check audit trail completeness

---

## 📋 **Related Procedures**

- **Task Workflow Procedure**: `0000_TASK_WORKFLOW_PROCEDURE.md`
- **Chatbot Workflow Procedure**: `0000_CHATBOT_WORKFLOW_PROCEDURE.md`
- **Vector Data Isolation Procedure**: `0500_VECTOR_DATA_ISOLATION_PROCEDURE.md`
- **HITL Dashboard Documentation**: `0750_MY_TASKS_DASHBOARD.md`

---

## 📈 **HITL Success Metrics**

- [ ] < 2 hours average HITL resolution time
- [ ] > 95% HITL task completion rate
- [ ] < 5% HITL escalation rate (HITL tasks requiring further escalation)
- [ ] > 90% user satisfaction with HITL resolution process
- [ ] Continuous improvement in decision quality metrics

---

  ## 🔄 **Version History**

- **v3.2** (2026-09-01): **HITL WORKFLOW ARCHITECTURE CLARIFICATION**
  - ✅ **Two-Tier HITL System Architecture** - Clear separation between individual HITL tasks and workflow summaries
  - ✅ **Individual HITL Tasks (Simple Modal)** - All HITL tasks use simple modal regardless of complexity (17 specialist + 1 final manager)
  - ✅ **AgentWorkflowReview Reserved for Summaries** - Comprehensive workflow overview modal only for process summaries
  - ✅ **Correspondence Agent Creates Multiple HITL Tasks** - 17 specialist HITL tasks + 1 final contracts manager HITL task
  - ✅ **Simple Modal for All HITL Reviews** - Removed complex routing logic, all HITL tasks use consistent simple modal
  - **Key Features**: Clear architectural separation, consistent user experience, proper modal usage by purpose
- **v3.1** (2026-07-01): **CORRESPONDENCE AGENT ORCHESTRATION HITL INTEGRATION**
  - ✅ **Mandatory HITL for All Correspondence** - 100% HITL rate for contractual correspondence analysis
  - ✅ **Two-Point HITL Integration** - HITL at Step 4 (specialist reviews) and Step 6 (overall review)
  - ✅ **ContractualCorrespondenceReplyAgent HITL** - Real API calls to `/api/tasks/hitl` for task creation
  - ✅ **DomainSpecialistAgent HITL Tasks** - Individual HITL tasks for each specialist analysis output
  - ✅ **Correspondence-Specific HITL Metadata** - Business object type 'contractual_correspondence'
  - ✅ **Automatic Assignment via hitlAssignmentService** - Workload balancing and expertise matching
  - ✅ **HITL Task Resolution Integration** - PUT `/api/tasks/hitl/:id/resolve` for decision processing
  - ✅ **Audit Trail and Performance Metrics** - Comprehensive logging of HITL interactions
  - **Key Features**: Mandatory human review, parallel specialist workflows, real-time assignment, enterprise-grade audit trails
- **v3.0** (2026-05-01): **CONTRACTS POST-AWARD HITL INTEGRATION**
  - ✅ **ContractsHITLCoordinator** - Decision-impact based escalation for contracts post-award system
  - ✅ **Specialist Agent HITL Integration** - Civil engineering specialist with HITL escalation logic
  - ✅ **Decision Type Analysis** - 8 contract decision types with specific escalation rules
  - ✅ **Financial Impact Assessment** - Automatic monetary value extraction and categorization
  - ✅ **Schedule Impact Evaluation** - Critical path and delay analysis
  - ✅ **Risk Level Assessment** - High/medium/low risk determination
  - ✅ **Multi-Discipline HITL Tasks** - Parallel specialist review creation
  - ✅ **Reviewer Assignment Logic** - Discipline and intervention-type based specialist selection
  - ✅ **Contracts HITL Test Suite** - Comprehensive testing framework with 7 test scenarios
  - ✅ **HITL Task Creation API Integration** - Real task creation for contracts decisions
  - **Key Features**: Contract value protection, safety incident escalation, quality failure review, dispute resolution
- **v2.0** (2026-04-01): **COMPLETE HITL INFRASTRUCTURE IMPLEMENTATION**
  - ✅ **HITL Task Creation API** (`/api/tasks/hitl`) - Full REST API for HITL task lifecycle management
  - ✅ **HITL Assignment Service** - Intelligent specialist assignment with workload balancing and expertise matching
  - ✅ **HITL Resolution API** (`/api/tasks/hitl/:id/resolve`) - Comprehensive decision resolution with audit trails
  - ✅ **HITL Performance Service** - Real-time metrics and analytics using tasks table data
  - ✅ **ParallelSpecialistCoordinator Integration** - Real API calls replacing simulation
  - ✅ **ContractualCorrespondenceReplyAgent Integration** - Agent-initiated HITL workflow with intelligent assessment
  - ✅ **MyTasksDashboard HITL Tab** - Dedicated UI with task filtering, priority badges, and action buttons
  - ✅ **Comprehensive Audit Trail System** - Multi-entry audit logging with decision quality metrics
  - ✅ **Database Schema Extensions** - `task_history` and `hitl_performance_metrics` tables
  - ✅ **Server Route Integration** - HITL routes registered in main application router
  - **Key Features**: Real-time task assignment, workflow continuation, decision propagation, performance analytics
- **v1.2** (2025-12-29): Added Parallel Multi-Discipline HITL Framework
  - Implemented task-based HITL integration for Correspondence Agent Orchestration
  - Added ParallelSpecialistCoordinator with discipline-specific HITL task creation
  - Included intelligent specialist assignment based on discipline expertise
  - Documented concurrent specialist workflows with HITL routing
- **v1.1** (2025-12-07): Enhanced HITL procedure with agent-initiated workflows
  - Added agent-initiated HITL workflow section
  - Included ContractualCorrespondenceReplyAgent integration examples
  - Added business object type auto-escalation rules
  - Documented HITL modal event dispatching and response handling
- **v1.0** (2025-12-07): Initial HITL workflow procedure
- **Related**: Task Workflow Procedure v1.0, Chatbot Workflow Procedure v1.0, Correspondence Agent Orchestration v1.0
