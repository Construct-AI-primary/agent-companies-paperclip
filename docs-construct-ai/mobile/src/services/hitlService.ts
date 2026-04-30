// HITL (Human-in-the-Loop) Integration Service
// Implements 0000_WORKFLOW_HITL_PROCEDURE.md for complex engineering decisions

import { supabase } from './api';
import { taskWorkflowService } from './taskWorkflowService';
import { notificationService } from './notificationService';

export interface HITLTask {
  id: string;
  organization_id: string;
  task_type: 'hitl';
  title: string;
  description: string;
  business_object_type: string;
  business_object_id: string;
  assigned_to?: string;
  discipline: string;
  priority: 'urgent' | 'high' | 'normal' | 'low';
  status: 'pending' | 'assigned' | 'in_progress' | 'completed' | 'cancelled';
  is_hitl: true;
  intervention_type: 'approval_required' | 'complex_decision' | 'clarification_needed';
  created_at: string;
  updated_at: string;
  completed_at?: string;
  due_date?: string;
  metadata?: Record<string, any>;
}

export interface HITLDecision {
  task_id: string;
  decision: 'approved' | 'rejected' | 'revision_required';
  decision_reason: string;
  decision_details?: string;
  confidence_override?: number;
  approved_content?: string;
  revision_requests?: string;
  quality_rating: 1 | 2 | 3 | 4 | 5;
  time_spent_minutes: number;
  reviewer_id: string;
  reviewer_name: string;
  reviewed_at: string;
}

export interface HITLSpecialist {
  id: string;
  name: string;
  role: string;
  disciplines: string[];
  workload_score: number;
  expertise_score: number;
  total_score: number;
}

export class HITLService {
  private static instance: HITLService;

  static getInstance(): HITLService {
    if (!HITLService.instance) {
      HITLService.instance = new HITLService();
    }
    return HITLService.instance;
  }

  // HITL Task Creation for Complex Engineering Decisions
  async createHITLTask(
    originalTaskId: string,
    escalationReason: string,
    interventionType: 'approval_required' | 'complex_decision' | 'clarification_needed',
    businessObjectType: string,
    businessObjectId: string,
    discipline: string,
    metadata?: Record<string, any>
  ): Promise<HITLTask | null> {
    try {
      console.log(`🎯 [HITL] Creating HITL task for ${businessObjectType}:${businessObjectId}`);

      const hitlTaskData = {
        organization_id: 'current_org_id', // TODO: Get from auth context
        task_type: 'hitl' as const,
        title: this.generateHITLTitle(interventionType, businessObjectType),
        description: this.generateHITLDescription(escalationReason, interventionType),
        business_object_type: businessObjectType,
        business_object_id: businessObjectId,
        discipline: discipline,
        priority: this.calculateHITLPriority(interventionType, metadata),
        status: 'pending',
        is_hitl: true,
        intervention_type: interventionType,
        metadata: {
          ...metadata,
          original_task_id: originalTaskId,
          escalation_reason: escalationReason,
          escalation_timestamp: new Date().toISOString(),
          created_by_system: true
        },
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      const { data: hitlTask, error } = await supabase
        .from('tasks')
        .insert([hitlTaskData])
        .select()
        .single();

      if (error) throw error;

      console.log(`✅ [HITL] HITL task created: ${hitlTask.id}`);

      // Automatically assign to optimal specialist
      await this.autoAssignHITLTask(hitlTask as HITLTask);

      return hitlTask as HITLTask;
    } catch (error) {
      console.error(`❌ [HITL] Failed to create HITL task:`, error);
      return null;
    }
  }

  // Intelligent HITL Specialist Assignment
  private async autoAssignHITLTask(hitlTask: HITLTask): Promise<void> {
    try {
      console.log(`🤖 [HITL] Auto-assigning HITL task ${hitlTask.id} for ${hitlTask.intervention_type}`);

      const specialist = await this.findOptimalHITLSpecialist(hitlTask);

      if (specialist) {
        const assignmentSuccess = await taskWorkflowService.assignTaskToUser(
          hitlTask.id,
          specialist.id,
          `HITL assignment: ${specialist.name} (${specialist.role}) - Expertise: ${specialist.expertise_score}, Workload: ${specialist.workload_score}`
        );

        if (assignmentSuccess) {
          // Send HITL notification
          await notificationService.sendHITLAssignedNotification(hitlTask, specialist.id);
          console.log(`✅ [HITL] Assigned to ${specialist.name} with score ${specialist.total_score}`);
        }
      } else {
        console.warn(`⚠️ [HITL] No suitable HITL specialist found for task ${hitlTask.id}`);
        // Escalate to engineering manager or create general notification
        await this.escalateHITLAssignment(hitlTask);
      }
    } catch (error) {
      console.error(`❌ [HITL] Auto-assignment failed:`, error);
    }
  }

  // Find Optimal HITL Specialist Based on Intervention Type and Expertise
  private async findOptimalHITLSpecialist(hitlTask: HITLTask): Promise<HITLSpecialist | null> {
    try {
      // Get eligible specialists based on intervention type and discipline
      const specialists = await this.getEligibleHITLSpecialists(hitlTask);

      if (specialists.length === 0) return null;

      // Calculate scores for each specialist
      const specialistScores = await Promise.all(
        specialists.map(async (specialist) => {
          const workloadScore = await this.calculateHITLWorkloadScore(specialist.id);
          const expertiseScore = this.calculateHITLExpertiseScore(specialist, hitlTask);
          const totalScore = expertiseScore - workloadScore; // Higher expertise, lower workload = better

          return {
            ...specialist,
            workload_score: workloadScore,
            expertise_score: expertiseScore,
            total_score: totalScore
          };
        })
      );

      // Return specialist with highest total score
      return specialistScores.sort((a, b) => b.total_score - a.total_score)[0];

    } catch (error) {
      console.error(`❌ [HITL] Specialist selection failed:`, error);
      return null;
    }
  }

  // Get Eligible Specialists for HITL Tasks
  private async getEligibleHITLSpecialists(hitlTask: HITLTask): Promise<Omit<HITLSpecialist, 'workload_score' | 'expertise_score' | 'total_score'>[]> {
    try {
      const { data: users, error } = await supabase
        .from('user_management')
        .select(`
          user_id,
          first_name,
          last_name,
          disciplines,
          role,
          organization_id
        `)
        .eq('organization_id', hitlTask.organization_id)
        .eq('status', 'active');

      if (error || !users) return [];

      // Filter users eligible for this intervention type
      return users
        .filter(user => this.isEligibleForHITLIntervention(user, hitlTask))
        .map(user => ({
          id: user.user_id,
          name: `${user.first_name} ${user.last_name}`.trim(),
          role: user.role,
          disciplines: user.disciplines || []
        }));

    } catch (error) {
      console.error(`❌ [HITL] Failed to get eligible specialists:`, error);
      return [];
    }
  }

  // Check if User is Eligible for HITL Intervention
  private isEligibleForHITLIntervention(user: any, hitlTask: HITLTask): boolean {
    const { intervention_type, discipline } = hitlTask;
    const { role, disciplines } = user;

    // Role-based eligibility for intervention types
    const roleEligibility: Record<string, string[]> = {
      'approval_required': [
        'executive', 'governance_admin', 'ceo', 'coo',
        'principal_engineer', 'chief_engineer', 'engineering_manager'
      ],
      'complex_decision': [
        'senior_engineer', 'chief_engineer', 'technical_director',
        'principal_engineer', 'engineering_manager', 'procurement_manager'
      ],
      'clarification_needed': [
        'engineer', 'senior_engineer', 'project_manager', 'technical_specialist'
      ]
    };

    const eligibleRoles = roleEligibility[intervention_type] || [];
    const hasEligibleRole = eligibleRoles.includes(role);

    // Discipline-based eligibility
    const hasRelevantDiscipline = disciplines?.includes(discipline) ||
                                 disciplines?.includes('engineering') ||
                                 this.isRelatedEngineeringDiscipline(disciplines, discipline);

    return hasEligibleRole || hasRelevantDiscipline;
  }

  // Calculate HITL Workload Score (lower is better)
  private async calculateHITLWorkloadScore(userId: string): Promise<number> {
    try {
      const { count } = await supabase
        .from('tasks')
        .select('*', { count: 'exact', head: true })
        .eq('assigned_to', userId)
        .eq('is_hitl', true)
        .in('status', ['pending', 'assigned', 'in_progress']);

      // Higher penalty for HITL tasks (they require more focus)
      return (count || 0) * 25;
    } catch (error) {
      console.error(`❌ [HITL] Workload calculation failed:`, error);
      return 100;
    }
  }

  // Calculate HITL Expertise Score (higher is better)
  private calculateHITLExpertiseScore(specialist: Omit<HITLSpecialist, 'workload_score' | 'expertise_score' | 'total_score'>, hitlTask: HITLTask): number {
    let score = 0;

    // Role-based expertise
    const roleScores: Record<string, number> = {
      'executive': 100,
      'chief_engineer': 90,
      'principal_engineer': 85,
      'engineering_manager': 80,
      'senior_engineer': 70,
      'engineer': 50,
      'technical_specialist': 40
    };

    score += roleScores[specialist.role] || 0;

    // Discipline match
    if (specialist.disciplines?.includes(hitlTask.discipline)) {
      score += 30;
    }

    // Intervention type expertise
    if (hitlTask.intervention_type === 'approval_required' &&
        ['executive', 'chief', 'principal'].some(title => specialist.role.includes(title))) {
      score += 25;
    }

    if (hitlTask.intervention_type === 'complex_decision' &&
        specialist.role.includes('senior')) {
      score += 20;
    }

    return score;
  }

  // HITL Decision Resolution
  async resolveHITLDecision(decision: HITLDecision): Promise<boolean> {
    try {
      console.log(`📝 [HITL] Resolving HITL decision for task ${decision.task_id}`);

      // Update task status
      const statusUpdate = decision.decision === 'approved' ? 'completed' :
                          decision.decision === 'rejected' ? 'cancelled' : 'in_progress';

      const statusSuccess = await taskWorkflowService.updateTaskStatus(
        decision.task_id,
        statusUpdate,
        `HITL Decision: ${decision.decision} - ${decision.decision_reason}`
      );

      if (!statusSuccess) throw new Error('Failed to update task status');

      // Log comprehensive decision audit trail
      await this.logHITLDecision(decision);

      // Propagate decision to original task/workflow
      await this.propagateHITLDecision(decision);

      // Update HITL performance metrics
      await this.updateHITLPerformanceMetrics(decision);

      console.log(`✅ [HITL] Decision resolved: ${decision.decision}`);
      return true;

    } catch (error) {
      console.error(`❌ [HITL] Decision resolution failed:`, error);
      return false;
    }
  }

  // Log HITL Decision with Full Audit Trail
  private async logHITLDecision(decision: HITLDecision): Promise<void> {
    try {
      const auditEntries = [
        {
          task_id: decision.task_id,
          action: 'hitl_decided',
          action_type: 'decision',
          notes: `HITL Decision: ${decision.decision} by ${decision.reviewer_name}`,
          metadata: {
            decision: decision.decision,
            decision_reason: decision.decision_reason,
            quality_rating: decision.quality_rating,
            time_spent_minutes: decision.time_spent_minutes,
            reviewer_id: decision.reviewer_id
          }
        },
        {
          task_id: decision.task_id,
          action: 'hitl_quality_assessed',
          action_type: 'quality',
          notes: `Quality rating: ${decision.quality_rating}/5`,
          metadata: { quality_rating: decision.quality_rating }
        },
        {
          task_id: decision.task_id,
          action: 'hitl_time_tracked',
          action_type: 'performance',
          notes: `Review time: ${decision.time_spent_minutes} minutes`,
          metadata: { time_spent_minutes: decision.time_spent_minutes }
        }
      ];

      for (const entry of auditEntries) {
        await supabase.from('task_history').insert([entry]);
      }

    } catch (error) {
      console.error(`❌ [HITL] Decision logging failed:`, error);
    }
  }

  // Propagate HITL Decision to Original Workflow
  private async propagateHITLDecision(decision: HITLDecision): Promise<void> {
    try {
      // Get original task information
      const { data: hitlTask } = await supabase
        .from('tasks')
        .select('metadata')
        .eq('id', decision.task_id)
        .single();

      if (!hitlTask?.metadata?.original_task_id) return;

      const originalTaskId = hitlTask.metadata.original_task_id;

      // Update original task based on decision
      switch (decision.decision) {
        case 'approved':
          await taskWorkflowService.updateTaskStatus(
            originalTaskId,
            'completed',
            `HITL Approved: ${decision.decision_reason}`
          );
          break;

        case 'rejected':
          await taskWorkflowService.updateTaskStatus(
            originalTaskId,
            'cancelled',
            `HITL Rejected: ${decision.decision_reason}`
          );
          break;

        case 'revision_required':
          await taskWorkflowService.updateTaskStatus(
            originalTaskId,
            'in_progress',
            `HITL Revision Required: ${decision.revision_requests}`
          );
          // Create follow-up task for revisions
          await this.createRevisionTask(originalTaskId, decision);
          break;
      }

    } catch (error) {
      console.error(`❌ [HITL] Decision propagation failed:`, error);
    }
  }

  // Create Revision Task for HITL Revision Requests
  private async createRevisionTask(originalTaskId: string, decision: HITLDecision): Promise<void> {
    try {
      const revisionTask = await taskWorkflowService.createTaskForEngineeringObject(
        'task_revision',
        originalTaskId,
        'engineering', // TODO: Get from original task
        'revision_task',
        {
          hitl_decision: decision,
          revision_requests: decision.revision_requests,
          priority: 'high'
        }
      );

      if (revisionTask) {
        console.log(`📝 [HITL] Created revision task: ${revisionTask.id}`);
      }
    } catch (error) {
      console.error(`❌ [HITL] Revision task creation failed:`, error);
    }
  }

  // Update HITL Performance Metrics
  private async updateHITLPerformanceMetrics(decision: HITLDecision): Promise<void> {
    try {
      const metricsEntry = {
        task_id: decision.task_id,
        reviewer_id: decision.reviewer_id,
        decision: decision.decision,
        quality_rating: decision.quality_rating,
        time_spent_minutes: decision.time_spent_minutes,
        reviewed_at: decision.reviewed_at,
        created_at: new Date().toISOString()
      };

      await supabase.from('hitl_performance_metrics').insert([metricsEntry]);
    } catch (error) {
      console.error(`❌ [HITL] Performance metrics update failed:`, error);
    }
  }

  // HITL Performance Monitoring
  async getHITLPerformanceMetrics(timeframeDays: number = 30): Promise<any> {
    try {
      const startDate = new Date();
      startDate.setDate(startDate.getDate() - timeframeDays);

      const { data: metrics, error } = await supabase
        .from('hitl_performance_metrics')
        .select('*')
        .gte('created_at', startDate.toISOString())
        .order('created_at', { ascending: false });

      if (error) throw error;

      return this.calculatePerformanceStats(metrics || []);
    } catch (error) {
      console.error(`❌ [HITL] Performance metrics retrieval failed:`, error);
      return {};
    }
  }

  // Calculate Performance Statistics
  private calculatePerformanceStats(metrics: any[]): any {
    if (metrics.length === 0) return {};

    const totalTasks = metrics.length;
    const completedTasks = metrics.filter(m => m.decision !== 'pending').length;
    const avgQualityRating = metrics.reduce((sum, m) => sum + m.quality_rating, 0) / totalTasks;
    const avgResolutionTime = metrics.reduce((sum, m) => sum + m.time_spent_minutes, 0) / totalTasks;

    const decisionBreakdown = metrics.reduce((acc, m) => {
      acc[m.decision] = (acc[m.decision] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);

    return {
      totalTasks,
      completedTasks,
      completionRate: (completedTasks / totalTasks) * 100,
      averageQualityRating: Math.round(avgQualityRating * 10) / 10,
      averageResolutionTime: Math.round(avgResolutionTime * 10) / 10,
      decisionBreakdown,
      timeframe: `${metrics.length} tasks analyzed`
    };
  }

  // Helper Methods
  private generateHITLTitle(interventionType: string, businessObjectType: string): string {
    const titleMap: Record<string, string> = {
      'approval_required': 'HITL: Executive Approval Required',
      'complex_decision': 'HITL: Complex Engineering Decision',
      'clarification_needed': 'HITL: Technical Clarification Needed'
    };

    return titleMap[interventionType] || `HITL: ${interventionType.replace('_', ' ').toUpperCase()}`;
  }

  private generateHITLDescription(escalationReason: string, interventionType: string): string {
    const baseDescription = `Human expert review required: ${escalationReason}`;

    const interventionGuidance: Record<string, string> = {
      'approval_required': 'Please review and provide executive approval decision.',
      'complex_decision': 'Please analyze the technical complexity and provide decision guidance.',
      'clarification_needed': 'Please provide technical clarification or additional requirements.'
    };

    return `${baseDescription}\n\n${interventionGuidance[interventionType] || ''}`;
  }

  private calculateHITLPriority(interventionType: string, metadata?: Record<string, any>): 'urgent' | 'high' | 'normal' | 'low' {
    if (interventionType === 'approval_required') return 'urgent';
    if (interventionType === 'complex_decision' && metadata?.financial_impact > 50000) return 'urgent';
    if (interventionType === 'complex_decision') return 'high';
    return 'normal';
  }

  private isRelatedEngineeringDiscipline(userDisciplines: string[], taskDiscipline: string): boolean {
    const engineeringDisciplines = ['civil', 'mechanical', 'electrical', 'process', 'structural', 'geotechnical'];
    return userDisciplines?.some(discipline =>
      engineeringDisciplines.includes(discipline) || discipline === 'engineering'
    ) || false;
  }

  private async escalateHITLAssignment(hitlTask: HITLTask): Promise<void> {
    // Notify engineering managers of unassigned HITL task
    console.warn(`🚨 [HITL] Escalating unassigned HITL task ${hitlTask.id}`);

    // TODO: Implement escalation notification to managers
    // await notificationService.sendHITLEscalationNotification(hitlTask);
  }

  // Public API Methods
  async getUserHITLTasks(userId: string): Promise<HITLTask[]> {
    const { data, error } = await supabase
      .from('tasks')
      .select('*')
      .eq('assigned_to', userId)
      .eq('is_hitl', true)
      .order('created_at', { ascending: false });

    if (error) throw error;
    return (data || []) as HITLTask[];
  }

  async getHITLTasksByInterventionType(interventionType: string): Promise<HITLTask[]> {
    const { data, error } = await supabase
      .from('tasks')
      .select('*')
      .eq('is_hitl', true)
      .eq('intervention_type', interventionType)
      .order('created_at', { ascending: false });

    if (error) throw error;
    return (data || []) as HITLTask[];
  }

  async getHITLTaskById(taskId: string): Promise<HITLTask | null> {
    const { data, error } = await supabase
      .from('tasks')
      .select('*')
      .eq('id', taskId)
      .eq('is_hitl', true)
      .single();

    if (error) throw error;
    return data as HITLTask;
  }
}

export const hitlService = HITLService.getInstance();