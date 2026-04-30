// Task Workflow Management Service
// Implements 0000_WORKFLOW_TASK_PROCEDURE.md for engineering disciplines

import { supabase } from './api';
import { notificationService } from './notificationService';

export interface Task {
  id: string;
  organization_id: string;
  task_type: 'procurement_review' | 'sow_review' | 'appendix_contribution' | 'engineering_review' | 'change_order_review' | 'design_review' | 'hitl';
  title: string;
  description: string;
  business_object_type: string;
  business_object_id: string;
  assigned_to?: string;
  discipline: string;
  priority: 'urgent' | 'high' | 'normal' | 'low';
  status: 'pending' | 'in_progress' | 'completed' | 'cancelled' | 'on_hold';
  is_hitl?: boolean;
  intervention_type?: 'approval_required' | 'complex_decision' | 'clarification_needed';
  created_at: string;
  updated_at: string;
  completed_at?: string;
  due_date?: string;
  metadata?: Record<string, any>;
}

export interface TaskAssignment {
  task_id: string;
  assigned_to: string;
  assigned_by: string;
  assignment_reason: string;
  priority_score: number;
}

export interface TaskHistory {
  id: string;
  task_id: string;
  action: string;
  action_type: string;
  notes: string;
  old_value?: Record<string, any>;
  new_value?: Record<string, any>;
  user_id: string;
  created_at: string;
}

export class TaskWorkflowService {
  private static instance: TaskWorkflowService;

  static getInstance(): TaskWorkflowService {
    if (!TaskWorkflowService.instance) {
      TaskWorkflowService.instance = new TaskWorkflowService();
    }
    return TaskWorkflowService.instance;
  }

  // Task Creation Triggers for Engineering Business Objects
  async createTaskForEngineeringObject(
    businessObjectType: string,
    businessObjectId: string,
    discipline: string,
    taskType: string,
    metadata?: Record<string, any>
  ): Promise<Task | null> {
    try {
      console.log(`🎯 [TaskWorkflow] Creating task for ${businessObjectType}:${businessObjectId}`);

      const taskData = {
        organization_id: 'current_org_id', // TODO: Get from auth context
        task_type: taskType as any,
        title: this.generateTaskTitle(taskType, businessObjectType),
        description: this.generateTaskDescription(taskType, businessObjectType),
        business_object_type: businessObjectType,
        business_object_id: businessObjectId,
        discipline: discipline,
        priority: this.calculateTaskPriority(taskType, metadata),
        status: 'pending',
        metadata: metadata || {},
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      const { data: task, error } = await supabase
        .from('tasks')
        .insert([taskData])
        .select()
        .single();

      if (error) throw error;

      console.log(`✅ [TaskWorkflow] Task created: ${task.id}`);

      // Trigger automatic assignment
      await this.autoAssignTask(task);

      return task;
    } catch (error) {
      console.error(`❌ [TaskWorkflow] Failed to create task:`, error);
      return null;
    }
  }

  // Automatic Task Assignment Logic for Engineering Disciplines
  private async autoAssignTask(task: Task): Promise<void> {
    try {
      console.log(`🤖 [TaskWorkflow] Auto-assigning task ${task.id} for discipline ${task.discipline}`);

      const assignment = await this.findOptimalAssignee(task);

      if (assignment) {
        await this.assignTaskToUser(task.id, assignment.assigned_to, assignment.assignment_reason);

        // Send notification
        await notificationService.sendTaskAssignedNotification(task, assignment.assigned_to);
      } else {
        console.warn(`⚠️ [TaskWorkflow] No suitable assignee found for task ${task.id}`);
        // Task remains unassigned, will be handled by manual assignment or escalation
      }
    } catch (error) {
      console.error(`❌ [TaskWorkflow] Auto-assignment failed:`, error);
    }
  }

  // Intelligent Assignee Selection Based on Workload and Expertise
  private async findOptimalAssignee(task: Task): Promise<TaskAssignment | null> {
    try {
      // Get available users for this discipline
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
        .eq('organization_id', task.organization_id)
        .eq('status', 'active');

      if (error || !users) return null;

      // Filter users with matching discipline
      const eligibleUsers = users.filter(user =>
        user.disciplines?.includes(task.discipline) ||
        user.disciplines?.includes('engineering') ||
        this.isRoleEligibleForTask(user.role, task.task_type)
      );

      if (eligibleUsers.length === 0) return null;

      // Calculate assignment scores for each user
      const userScores = await Promise.all(
        eligibleUsers.map(async (user) => {
          const workloadScore = await this.calculateUserWorkload(user.user_id);
          const expertiseScore = this.calculateExpertiseScore(user, task);
          const totalScore = workloadScore + expertiseScore;

          return {
            user,
            totalScore,
            workloadScore,
            expertiseScore
          };
        })
      );

      // Select user with best score (lowest workload + highest expertise)
      const bestMatch = userScores.sort((a, b) => b.totalScore - a.totalScore)[0];

      return {
        task_id: task.id,
        assigned_to: bestMatch.user.user_id,
        assigned_by: 'system',
        assignment_reason: `Optimal assignment based on expertise (${bestMatch.expertiseScore}) and workload (${bestMatch.workloadScore})`,
        priority_score: bestMatch.totalScore
      };

    } catch (error) {
      console.error(`❌ [TaskWorkflow] Assignee selection failed:`, error);
      return null;
    }
  }

  // Calculate User Workload (lower is better)
  private async calculateUserWorkload(userId: string): Promise<number> {
    try {
      const { count } = await supabase
        .from('tasks')
        .select('*', { count: 'exact', head: true })
        .eq('assigned_to', userId)
        .in('status', ['pending', 'in_progress']);

      // Base score: 10 points per active task
      // Lower score = less workload = better
      return (count || 0) * 10;
    } catch (error) {
      console.error(`❌ [TaskWorkflow] Workload calculation failed:`, error);
      return 100; // High penalty for calculation failure
    }
  }

  // Calculate Expertise Score (higher is better)
  private calculateExpertiseScore(user: any, task: Task): number {
    let score = 0;

    // Primary discipline match
    if (user.disciplines?.includes(task.discipline)) {
      score += 50;
    }

    // Related discipline match
    if (this.isRelatedDiscipline(user.disciplines, task.discipline)) {
      score += 25;
    }

    // Role-based expertise
    if (this.isRoleEligibleForTask(user.role, task.task_type)) {
      score += 30;
    }

    // Task type specific expertise
    if (task.task_type === 'engineering_review' && user.role?.includes('engineer')) {
      score += 20;
    }

    if (task.task_type === 'change_order_review' && user.role?.includes('senior')) {
      score += 15;
    }

    return score;
  }

  // Manual Task Assignment
  async assignTaskToUser(taskId: string, userId: string, reason: string): Promise<boolean> {
    try {
      console.log(`👤 [TaskWorkflow] Assigning task ${taskId} to user ${userId}`);

      const { error: updateError } = await supabase
        .from('tasks')
        .update({
          assigned_to: userId,
          status: 'assigned',
          updated_at: new Date().toISOString()
        })
        .eq('id', taskId);

      if (updateError) throw updateError;

      // Log assignment in task history
      await this.logTaskHistory(taskId, 'assigned', 'assignment', `Task assigned to user: ${reason}`, {
        assigned_to: userId,
        assignment_reason: reason
      });

      return true;
    } catch (error) {
      console.error(`❌ [TaskWorkflow] Manual assignment failed:`, error);
      return false;
    }
  }

  // Task Status Updates
  async updateTaskStatus(taskId: string, newStatus: Task['status'], notes?: string): Promise<boolean> {
    try {
      console.log(`📝 [TaskWorkflow] Updating task ${taskId} status to ${newStatus}`);

      const updateData: any = {
        status: newStatus,
        updated_at: new Date().toISOString()
      };

      if (newStatus === 'completed') {
        updateData.completed_at = new Date().toISOString();
      }

      const { error } = await supabase
        .from('tasks')
        .update(updateData)
        .eq('id', taskId);

      if (error) throw error;

      // Log status change
      await this.logTaskHistory(taskId, 'status_changed', 'status_update', notes || `Status changed to ${newStatus}`, {
        old_status: 'previous_status', // TODO: Get actual old status
        new_status: newStatus
      });

      return true;
    } catch (error) {
      console.error(`❌ [TaskWorkflow] Status update failed:`, error);
      return false;
    }
  }

  // Task History Logging
  private async logTaskHistory(
    taskId: string,
    action: string,
    actionType: string,
    notes: string,
    metadata?: Record<string, any>
  ): Promise<void> {
    try {
      const historyEntry = {
        task_id: taskId,
        action: action,
        action_type: actionType,
        notes: notes,
        metadata: metadata,
        user_id: 'system', // TODO: Get from auth context
        created_at: new Date().toISOString()
      };

      const { error } = await supabase
        .from('task_history')
        .insert([historyEntry]);

      if (error) throw error;
    } catch (error) {
      console.error(`❌ [TaskWorkflow] History logging failed:`, error);
    }
  }

  // Helper Methods
  private generateTaskTitle(taskType: string, businessObjectType: string): string {
    const titleMap: Record<string, string> = {
      'engineering_review': 'Engineering Review Required',
      'change_order_review': 'Change Order Review',
      'design_review': 'Design Review Required',
      'procurement_review': 'Procurement Review',
      'sow_review': 'Scope of Work Review'
    };

    return titleMap[taskType] || `${taskType.replace('_', ' ').toUpperCase()} Task`;
  }

  private generateTaskDescription(taskType: string, businessObjectType: string): string {
    const descMap: Record<string, string> = {
      'engineering_review': 'Please review the engineering specifications and provide technical feedback.',
      'change_order_review': 'Review the proposed change order for technical and financial impact.',
      'design_review': 'Conduct design review and provide approval recommendations.',
      'procurement_review': 'Review procurement requirements and specifications.',
      'sow_review': 'Review scope of work documentation and alignment.'
    };

    return descMap[taskType] || `Please complete the ${taskType.replace('_', ' ')} task.`;
  }

  private calculateTaskPriority(taskType: string, metadata?: Record<string, any>): 'urgent' | 'high' | 'normal' | 'low' {
    // Urgent priority for critical engineering decisions
    if (taskType === 'change_order_review' && metadata?.financial_impact > 100000) {
      return 'urgent';
    }

    if (taskType === 'engineering_review' && metadata?.complexity === 'high') {
      return 'high';
    }

    return 'normal';
  }

  private isRelatedDiscipline(userDisciplines: string[], taskDiscipline: string): boolean {
    const relatedDisciplines: Record<string, string[]> = {
      'civil': ['structural', 'geotechnical', 'architectural'],
      'mechanical': ['electrical', 'process'],
      'electrical': ['mechanical', 'instrumentation'],
      'process': ['mechanical', 'instrumentation', 'chemical']
    };

    return relatedDisciplines[taskDiscipline]?.some(related =>
      userDisciplines?.includes(related)
    ) || false;
  }

  private isRoleEligibleForTask(role: string, taskType: string): boolean {
    const roleEligibility: Record<string, string[]> = {
      'engineer': ['engineering_review', 'design_review', 'change_order_review'],
      'senior_engineer': ['engineering_review', 'design_review', 'change_order_review', 'procurement_review'],
      'principal_engineer': ['engineering_review', 'design_review', 'change_order_review', 'procurement_review', 'sow_review'],
      'engineering_manager': ['engineering_review', 'design_review', 'change_order_review', 'procurement_review', 'sow_review'],
      'procurement_officer': ['procurement_review', 'change_order_review'],
      'procurement_manager': ['procurement_review', 'change_order_review', 'sow_review']
    };

    return roleEligibility[role]?.includes(taskType) || false;
  }

  // Public API Methods for React Components
  async getUserTasks(userId: string): Promise<Task[]> {
    const { data, error } = await supabase
      .from('tasks')
      .select('*')
      .eq('assigned_to', userId)
      .order('created_at', { ascending: false });

    if (error) throw error;
    return data || [];
  }

  async getTasksByDiscipline(discipline: string): Promise<Task[]> {
    const { data, error } = await supabase
      .from('tasks')
      .select('*')
      .eq('discipline', discipline)
      .order('created_at', { ascending: false });

    if (error) throw error;
    return data || [];
  }

  async getTaskHistory(taskId: string): Promise<TaskHistory[]> {
    const { data, error } = await supabase
      .from('task_history')
      .select('*')
      .eq('task_id', taskId)
      .order('created_at', { ascending: false });

    if (error) throw error;
    return data || [];
  }
}

export const taskWorkflowService = TaskWorkflowService.getInstance();