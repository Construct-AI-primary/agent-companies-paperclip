// Engineering Agent Service
// Orchestrates AI agents for different engineering disciplines and calculations

import { supabase } from './api';
import { taskWorkflowService } from './taskWorkflowService';
import { hitlService } from './hitlService';
import { agentService } from './agentService';

export interface EngineeringAgentExecution {
  agentId: string;
  disciplineCode: string;
  calculationType: string;
  operationType: string;
  businessObjectId: string;
  inputData: any;
  onProgress?: (step: string, message: string, data: any) => void;
}

export interface AgentExecutionResult {
  success: boolean;
  result?: any;
  error?: string;
  executionTime: number;
  agentUsed: string;
  confidence?: number;
  requiresHITL?: boolean;
  hitlReason?: string;
}

export class EngineeringAgentService {
  private static instance: EngineeringAgentService;

  static getInstance(): EngineeringAgentService {
    if (!EngineeringAgentService.instance) {
      EngineeringAgentService.instance = new EngineeringAgentService();
    }
    return EngineeringAgentService.instance;
  }

  // Main execution method for engineering agents
  async executeEngineeringAgent(
    agentName: string,
    disciplineCode: string,
    calculationType: string,
    operationType: string,
    businessObjectId: string,
    inputData: any,
    onProgress?: (step: string, message: string, data: any) => void
  ): Promise<any> {
    const startTime = Date.now();

    try {
      console.log(`🔧 [EngAgent] Executing ${agentName} for ${calculationType}`);

      // Step 1: Validate agent availability and permissions
      await this.validateAgentAccess(agentName, disciplineCode);

      // Step 2: Prepare agent prompt and context
      const agentPrompt = await this.prepareAgentPrompt(agentName, calculationType, inputData);

      // Step 3: Execute agent with streaming response
      const result = await this.executeAgentWithStreaming(
        agentName,
        agentPrompt,
        inputData,
        onProgress
      );

      // Step 4: Validate and enhance results
      const validatedResult = await this.validateAgentResult(result, calculationType, inputData);

      // Step 5: Assess confidence and HITL requirements
      const confidence = await this.assessResultConfidence(validatedResult, calculationType);
      const hitlAssessment = await this.assessHITLRequirement(validatedResult, inputData);

      const executionTime = Date.now() - startTime;

      // Step 6: Log execution for audit trail
      await this.logAgentExecution({
        agentId: agentName,
        disciplineCode,
        calculationType,
        operationType,
        businessObjectId,
        inputData,
        result: validatedResult,
        executionTime,
        confidence,
        requiresHITL: hitlAssessment.required,
        hitlReason: hitlAssessment.reason
      });

      // Step 7: Create HITL task if required
      if (hitlAssessment.required) {
        await this.createHITLTask(
          agentName,
          disciplineCode,
          calculationType,
          businessObjectId,
          hitlAssessment.reason,
          validatedResult
        );
      }

      console.log(`✅ [EngAgent] ${agentName} completed in ${executionTime}ms`);
      return validatedResult;

    } catch (error) {
      console.error(`❌ [EngAgent] ${agentName} failed:`, error);

      const executionTime = Date.now() - startTime;

      // Log failed execution
      await this.logAgentExecution({
        agentId: agentName,
        disciplineCode,
        calculationType,
        operationType,
        businessObjectId,
        inputData,
        error: error.message,
        executionTime,
        requiresHITL: true,
        hitlReason: 'Agent execution failed - requires manual review'
      });

      // Always escalate to HITL on failure
      await this.createHITLTask(
        agentName,
        disciplineCode,
        calculationType,
        businessObjectId,
        `Agent execution failed: ${error.message}`,
        null
      );

      throw error;
    }
  }

  // Civil Engineering Agent Methods

  async getCivilFoundationAgent(): Promise<any> {
    return await agentService.getAgentByName('civilFoundationAgent');
  }

  async getCivilStructuralAgent(): Promise<any> {
    return await agentService.getAgentByName('civilStructuralAgent');
  }

  async getCivilSoilAgent(): Promise<any> {
    return await agentService.getAgentByName('civilSoilAgent');
  }

  async getCivilConcreteAgent(): Promise<any> {
    return await agentService.getAgentByName('civilConcreteAgent');
  }

  // Mechanical Engineering Agent Methods

  async getMechanicalEquipmentAgent(): Promise<any> {
    return await agentService.getAgentByName('mechanicalEquipmentAgent');
  }

  async getMechanicalMaintenanceAgent(): Promise<any> {
    return await agentService.getAgentByName('mechanicalMaintenanceAgent');
  }

  async getMechanicalFailureAgent(): Promise<any> {
    return await agentService.getAgentByName('mechanicalFailureAgent');
  }

  // Electrical Engineering Agent Methods

  async getElectricalCircuitAgent(): Promise<any> {
    return await agentService.getAgentByName('electricalCircuitAgent');
  }

  async getElectricalPowerAgent(): Promise<any> {
    return await agentService.getAgentByName('electricalPowerAgent');
  }

  async getElectricalProtectionAgent(): Promise<any> {
    return await agentService.getAgentByName('electricalProtectionAgent');
  }

  // Process Engineering Agent Methods

  async getProcessSimulationAgent(): Promise<any> {
    return await agentService.getAgentByName('processSimulationAgent');
  }

  async getProcessSafetyAgent(): Promise<any> {
    return await agentService.getAgentByName('processSafetyAgent');
  }

  async getProcessOptimizationAgent(): Promise<any> {
    return await agentService.getAgentByName('processOptimizationAgent');
  }

  // Private Helper Methods

  private async validateAgentAccess(agentName: string, disciplineCode: string): Promise<void> {
    // Check if user has access to the discipline
    const { data: userDisciplines, error } = await supabase
      .from('user_discipline_access')
      .select('discipline_code, is_active')
      .eq('user_id', 'current_user') // TODO: Get from auth
      .eq('discipline_code', disciplineCode)
      .eq('is_active', true)
      .single();

    if (error || !userDisciplines) {
      throw new Error(`Access denied to discipline ${disciplineCode}`);
    }

    // Check if agent exists and is available
    const agent = await agentService.getAgentByName(agentName);
    if (!agent) {
      throw new Error(`Agent ${agentName} not found`);
    }

    if (!agent.isActive) {
      throw new Error(`Agent ${agentName} is not active`);
    }
  }

  private async prepareAgentPrompt(
    agentName: string,
    calculationType: string,
    inputData: any
  ): Promise<string> {
    // Get agent-specific prompt template
    const agentPrompt = await this.getAgentPromptTemplate(agentName, calculationType);

    // Format input data for the agent
    const formattedInput = this.formatInputForAgent(inputData, calculationType);

    // Combine prompt template with formatted input
    return agentPrompt.replace('{{INPUT_DATA}}', JSON.stringify(formattedInput, null, 2));
  }

  private async getAgentPromptTemplate(agentName: string, calculationType: string): Promise<string> {
    // Get prompt from database based on agent and calculation type
    const { data, error } = await supabase
      .from('agent_prompts')
      .select('prompt_template')
      .eq('agent_name', agentName)
      .eq('calculation_type', calculationType)
      .single();

    if (error) {
      // Fallback to default prompts
      return this.getDefaultPrompt(agentName, calculationType);
    }

    return data.prompt_template;
  }

  private getDefaultPrompt(agentName: string, calculationType: string): string {
    const prompts: Record<string, Record<string, string>> = {
      civilFoundationAgent: {
        foundation_design: `
You are a civil engineering foundation design expert. Analyze the following foundation design requirements and provide a complete design solution.

Input Data:
{{INPUT_DATA}}

Provide a detailed foundation design including:
1. Recommended foundation type and dimensions
2. Structural calculations for bearing capacity, settlement, and stability
3. Reinforcement details with bar sizes and spacing
4. Safety factors for all failure modes
5. Construction considerations and potential issues
6. Estimated quantities and costs

Format your response as valid JSON with the following structure:
{
  "foundationType": "isolated|combined|raft|pile",
  "dimensions": {
    "length": number,
    "width": number,
    "depth": number
  },
  "reinforcement": {
    "mainBars": "string description",
    "distributionBars": "string description",
    "shearReinforcement": "string description"
  },
  "safetyFactors": {
    "bearing": number,
    "overturning": number,
    "sliding": number
  },
  "calculations": {
    "bearingPressure": number,
    "settlement": number,
    "moment": number,
    "shear": number
  },
  "constructionNotes": ["array of construction considerations"]
}
`
      },
      civilStructuralAgent: {
        structural_analysis: `
You are a structural engineering analysis expert. Perform structural analysis on the provided structural system.

Input Data:
{{INPUT_DATA}}

Provide a complete structural analysis including:
1. Member forces (axial, shear, moment)
2. Deflections and deformations
3. Utilization ratios for strength and deflection
4. Code compliance verification
5. Design recommendations and warnings

Format your response as valid JSON.
`
      },
      civilSoilAgent: {
        soil_analysis: `
You are a geotechnical engineering expert. Analyze the provided soil investigation data.

Input Data:
{{INPUT_DATA}}

Provide a comprehensive soil analysis including:
1. Soil classification and properties
2. Bearing capacity assessment
3. Settlement analysis
4. Foundation recommendations
5. Ground improvement requirements

Format your response as valid JSON.
`
      },
      civilConcreteAgent: {
        concrete_mix_design: `
You are a concrete technology expert. Design an optimized concrete mix for the specified requirements.

Input Data:
{{INPUT_DATA}}

Provide a complete concrete mix design including:
1. Mix proportions (cement, aggregates, water)
2. Workability and strength predictions
3. Cost analysis
4. Environmental impact assessment
5. Quality control recommendations

Format your response as valid JSON.
`
      }
    };

    return prompts[agentName]?.[calculationType] || 'Please analyze the following engineering data and provide expert recommendations.';
  }

  private formatInputForAgent(inputData: any, calculationType: string): any {
    // Format input data appropriately for different calculation types
    switch (calculationType) {
      case 'foundation_design':
        return {
          project: inputData.projectId,
          location: inputData.location,
          loads: inputData.loads,
          soil: inputData.soilProperties,
          foundationType: inputData.foundationType,
          dimensions: inputData.dimensions
        };

      case 'structural_analysis':
        return {
          structureType: inputData.structureType,
          material: inputData.material,
          loads: inputData.loads,
          geometry: inputData.geometry,
          constraints: inputData.constraints
        };

      case 'soil_analysis':
        return {
          location: inputData.location,
          testType: inputData.testType,
          testData: inputData.testData,
          requirements: inputData.projectRequirements
        };

      case 'concrete_mix_design':
        return {
          strength: inputData.strength,
          exposure: inputData.exposureConditions,
          aggregates: inputData.aggregateProperties,
          cement: inputData.cementType,
          workability: inputData.workability
        };

      default:
        return inputData;
    }
  }

  private async executeAgentWithStreaming(
    agentName: string,
    prompt: string,
    inputData: any,
    onProgress?: (step: string, message: string, data: any) => void
  ): Promise<any> {
    // Progress callbacks
    onProgress?.('preparing', 'Preparing agent execution...', {});

    // Get agent configuration
    const agent = await agentService.getAgentByName(agentName);
    if (!agent) {
      throw new Error(`Agent ${agentName} not found`);
    }

    onProgress?.('analyzing', 'Analyzing input data...', inputData);

    // Execute agent with streaming
    const result = await agentService.executeAgentStreaming(
      agent.id,
      prompt,
      {
        discipline: agent.disciplineCode,
        calculationType: agent.specialization,
        inputData
      },
      (step, message, data) => {
        onProgress?.(step, message, data);
      }
    );

    onProgress?.('completed', 'Agent execution completed', result);
    return result;
  }

  private async validateAgentResult(
    result: any,
    calculationType: string,
    inputData: any
  ): Promise<any> {
    // Basic validation that result is properly formatted
    if (!result || typeof result !== 'object') {
      throw new Error('Invalid agent result format');
    }

    // Calculation-specific validations
    switch (calculationType) {
      case 'foundation_design':
        this.validateFoundationResult(result);
        break;
      case 'structural_analysis':
        this.validateStructuralResult(result);
        break;
      case 'soil_analysis':
        this.validateSoilResult(result);
        break;
      case 'concrete_mix_design':
        this.validateConcreteResult(result);
        break;
    }

    return result;
  }

  private validateFoundationResult(result: any): void {
    if (!result.foundationType || !result.dimensions || !result.safetyFactors) {
      throw new Error('Foundation design result missing required fields');
    }

    if (result.safetyFactors.bearing < 1.0) {
      throw new Error('Bearing safety factor must be >= 1.0');
    }
  }

  private validateStructuralResult(result: any): void {
    if (!result.memberForces || !result.utilizationRatios) {
      throw new Error('Structural analysis result missing required fields');
    }
  }

  private validateSoilResult(result: any): void {
    if (!result.bearingCapacity || !result.soilType) {
      throw new Error('Soil analysis result missing required fields');
    }
  }

  private validateConcreteResult(result: any): void {
    if (!result.mixProportions || !result.characteristicStrength) {
      throw new Error('Concrete mix design result missing required fields');
    }
  }

  private async assessResultConfidence(result: any, calculationType: string): Promise<number> {
    // Assess confidence based on various factors
    let confidence = 0.8; // Base confidence

    // Adjust based on safety factors
    if (result.safetyFactors) {
      if (result.safetyFactors.bearing >= 3.0) confidence += 0.1;
      if (result.safetyFactors.overturning >= 2.0) confidence += 0.05;
      if (result.safetyFactors.sliding >= 1.5) confidence -= 0.05; // Penalty for low sliding safety
    }

    // Adjust based on complexity
    if (result.complexityLevel === 'high') confidence -= 0.1;

    // Cap at 0.95 max (always leave room for human review)
    return Math.min(confidence, 0.95);
  }

  private async assessHITLRequirement(result: any, inputData: any): Promise<{required: boolean, reason: string}> {
    const reasons: string[] = [];

    // Check safety factors
    if (result.safetyFactors) {
      if (result.safetyFactors.bearing < 2.0) {
        reasons.push('Bearing safety factor critically low');
      }
      if (result.safetyFactors.overturning < 1.5) {
        reasons.push('Overturning safety factor below minimum');
      }
      if (result.safetyFactors.sliding < 1.2) {
        reasons.push('Sliding safety factor too low');
      }
    }

    // Check for unusual conditions
    if (inputData.loads?.seismicLoad && inputData.loads.seismicLoad > inputData.loads.deadLoad) {
      reasons.push('High seismic loads require specialist review');
    }

    if (inputData.soilProperties?.plasticityIndex > 40) {
      reasons.push('High plasticity soil requires geotechnical review');
    }

    // Check utilization ratios
    if (result.utilizationRatios) {
      if (result.utilizationRatios.strength > 0.95) {
        reasons.push('Structure approaching capacity limits');
      }
      if (result.utilizationRatios.deflection > 0.95) {
        reasons.push('Deflection limits nearly exceeded');
      }
    }

    return {
      required: reasons.length > 0,
      reason: reasons.join('; ')
    };
  }

  private async createHITLTask(
    agentName: string,
    disciplineCode: string,
    calculationType: string,
    businessObjectId: string,
    reason: string,
    result: any
  ): Promise<void> {
    try {
      await hitlService.createHITLTask(
        `engineering_${calculationType}_${Date.now()}`,
        reason,
        'engineering_review',
        calculationType,
        businessObjectId,
        disciplineCode,
        {
          agentName,
          result,
          calculationType,
          disciplineCode,
          reviewPriority: this.calculateHITLPriority(reason)
        }
      );

      console.log(`🎯 HITL task created for ${calculationType}: ${reason}`);
    } catch (error) {
      console.error('Failed to create HITL task:', error);
    }
  }

  private calculateHITLPriority(reason: string): 'low' | 'medium' | 'high' | 'critical' {
    if (reason.includes('critically low') || reason.includes('below minimum')) {
      return 'critical';
    }
    if (reason.includes('too low') || reason.includes('approaching')) {
      return 'high';
    }
    if (reason.includes('require') || reason.includes('review')) {
      return 'medium';
    }
    return 'low';
  }

  private async logAgentExecution(execution: any): Promise<void> {
    try {
      const logData = {
        agent_id: execution.agentId,
        discipline_code: execution.disciplineCode,
        calculation_type: execution.calculationType,
        operation_type: execution.operationType,
        business_object_id: execution.businessObjectId,
        input_data: execution.inputData,
        result_data: execution.result,
        error_message: execution.error,
        execution_time_ms: execution.executionTime,
        confidence_score: execution.confidence,
        requires_hitl: execution.requiresHITL,
        hitl_reason: execution.hitlReason,
        created_at: new Date().toISOString()
      };

      await supabase.from('agent_execution_logs').insert([logData]);
    } catch (error) {
      console.warn('Failed to log agent execution:', error);
    }
  }

  // Public API Methods

  async getAgentExecutionHistory(
    agentName?: string,
    disciplineCode?: string,
    limit: number = 50
  ): Promise<any[]> {
    let query = supabase
      .from('agent_execution_logs')
      .select('*')
      .order('created_at', { ascending: false })
      .limit(limit);

    if (agentName) {
      query = query.eq('agent_id', agentName);
    }

    if (disciplineCode) {
      query = query.eq('discipline_code', disciplineCode);
    }

    const { data, error } = await query;
    if (error) throw error;

    return data || [];
  }

  async getAgentPerformanceMetrics(
    agentName: string,
    timeRange: { start: Date; end: Date }
  ): Promise<any> {
    const { data, error } = await supabase
      .from('agent_execution_logs')
      .select('*')
      .eq('agent_id', agentName)
      .gte('created_at', timeRange.start.toISOString())
      .lte('created_at', timeRange.end.toISOString());

    if (error) throw error;

    const executions = data || [];

    return {
      totalExecutions: executions.length,
      successRate: executions.filter(e => !e.error_message).length / executions.length,
      averageExecutionTime: executions.reduce((sum, e) => sum + e.execution_time_ms, 0) / executions.length,
      averageConfidence: executions.reduce((sum, e) => sum + (e.confidence_score || 0), 0) / executions.length,
      hitlRate: executions.filter(e => e.requires_hitl).length / executions.length,
      errorRate: executions.filter(e => e.error_message).length / executions.length
    };
  }
}

export const engineeringAgentService = EngineeringAgentService.getInstance();