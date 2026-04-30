// Civil Engineering Service
// Implements foundation design, structural analysis, and soil mechanics for mobile engineering

import { supabase } from './api';
import { engineeringAgentService } from './engineeringAgentService';
import { taskWorkflowService } from './taskWorkflowService';
import { hitlService } from './hitlService';

export interface FoundationDesignInput {
  projectId: string;
  location: {
    latitude: number;
    longitude: number;
    soilType?: string;
  };
  loads: {
    deadLoad: number; // kN
    liveLoad: number; // kN
    windLoad?: number; // kN
    seismicLoad?: number; // kN
  };
  soilProperties: {
    bearingCapacity: number; // kPa
    soilType: 'clay' | 'sand' | 'gravel' | 'silt';
    groundwaterLevel?: number; // meters
    plasticityIndex?: number;
  };
  foundationType: 'isolated' | 'combined' | 'raft' | 'pile';
  dimensions?: {
    length?: number; // meters
    width?: number; // meters
    depth?: number; // meters
  };
}

export interface FoundationDesignResult {
  foundationType: string;
  dimensions: {
    length: number;
    width: number;
    depth: number;
  };
  reinforcement: {
    mainBars: string;
    distributionBars: string;
    shearReinforcement: string;
  };
  safetyFactors: {
    bearing: number;
    overturning: number;
    sliding: number;
  };
  estimatedCost: number;
  constructionNotes: string[];
  drawings: string[]; // Drawing IDs for visualization
}

export interface StructuralAnalysisInput {
  structureType: 'building' | 'bridge' | 'tower' | 'industrial';
  material: 'concrete' | 'steel' | 'timber' | 'masonry';
  loads: {
    deadLoad: number;
    liveLoad: number;
    windLoad: number;
    seismicLoad?: number;
  };
  geometry: {
    spans?: number[];
    heights?: number[];
    crossSection?: {
      width: number;
      depth: number;
    };
  };
  constraints: {
    deflectionLimit?: number;
    strengthLimit?: number;
  };
}

export interface StructuralAnalysisResult {
  memberForces: {
    axial: number;
    shear: number;
    moment: number;
  };
  deflections: {
    maximum: number;
    location: number;
  };
  utilizationRatios: {
    strength: number;
    deflection: number;
  };
  designRecommendations: string[];
  codeCompliance: {
    standard: string;
    satisfied: boolean;
    violations?: string[];
  };
}

export interface SoilAnalysisInput {
  location: {
    latitude: number;
    longitude: number;
  };
  testType: 'standard_penetration' | 'cone_penetration' | 'laboratory' | 'field_observation';
  testData: {
    depth: number[]; // meters
    values: number[]; // SPT N-values, CPT qc values, etc.
    moistureContent?: number[];
    plasticityIndex?: number[];
  };
  projectRequirements: {
    foundationType: string;
    expectedLoads: number;
  };
}

export interface ConcreteMixDesignInput {
  strength: {
    target28Day: number; // MPa
    target7Day?: number; // MPa
  };
  exposureConditions: {
    environment: 'mild' | 'moderate' | 'severe' | 'very_severe' | 'extreme';
    exposureClass: string;
  };
  aggregateProperties: {
    maxSize: number; // mm
    specificGravity: number;
    absorption: number;
  };
  cementType: 'OPC' | 'PPC' | 'PSC' | 'SRPC';
  workability: {
    slump: number; // mm
    placementMethod: 'pump' | 'manual' | 'vibrator';
  };
}

export class CivilEngineeringService {
  private static instance: CivilEngineeringService;

  static getInstance(): CivilEngineeringService {
    if (!CivilEngineeringService.instance) {
      CivilEngineeringService.instance = new CivilEngineeringService();
    }
    return CivilEngineeringService.instance;
  }

  // Foundation Design Calculation Engine
  async designFoundation(input: FoundationDesignInput): Promise<FoundationDesignResult> {
    console.log(`🏗️ [CivilEng] Designing ${input.foundationType} foundation`);

    try {
      // Step 1: Validate input parameters
      await this.validateFoundationInput(input);

      // Step 2: Execute foundation design through agent orchestration
      const result = await engineeringAgentService.executeEngineeringAgent(
        'civilFoundationAgent',
        '00850', // Civil Engineering discipline code
        'foundation_design',
        'foundation_design',
        `foundation_${Date.now()}`,
        input,
        (step, message, data) => {
          console.log(`[FoundationDesign] ${step}: ${message}`);
        }
      );

      // Step 3: Validate design results
      const validatedResult = await this.validateFoundationDesign(result, input);

      // Step 4: Generate construction drawings integration
      const drawings = await this.generateFoundationDrawings(validatedResult, input);

      // Step 5: Calculate estimated cost
      const cost = await this.calculateFoundationCost(validatedResult);

      const finalResult: FoundationDesignResult = {
        ...validatedResult,
        estimatedCost: cost,
        drawings: drawings,
        constructionNotes: this.generateConstructionNotes(validatedResult, input)
      };

      // Step 6: Check for HITL escalation
      await this.assessFoundationHITL(finalResult, input);

      console.log(`✅ [CivilEng] Foundation design completed: ${validatedResult.foundationType}`);
      return finalResult;

    } catch (error) {
      console.error(`❌ [CivilEng] Foundation design failed:`, error);

      // Escalate to HITL for complex cases
      await this.createFoundationHITL(input, error.message);
      throw error;
    }
  }

  // Structural Analysis Tools
  async performStructuralAnalysis(input: StructuralAnalysisInput): Promise<StructuralAnalysisResult> {
    console.log(`🔧 [CivilEng] Performing structural analysis for ${input.structureType}`);

    try {
      // Execute structural analysis through agent
      const result = await engineeringAgentService.executeEngineeringAgent(
        'civilStructuralAgent',
        '00850',
        'structural_analysis',
        'structural_analysis',
        `structural_${Date.now()}`,
        input,
        (step, message, data) => {
          console.log(`[StructuralAnalysis] ${step}: ${message}`);
        }
      );

      // Validate analysis results
      const validatedResult = await this.validateStructuralAnalysis(result, input);

      // Generate design recommendations
      validatedResult.designRecommendations = await this.generateDesignRecommendations(validatedResult, input);

      console.log(`✅ [CivilEng] Structural analysis completed`);
      return validatedResult;

    } catch (error) {
      console.error(`❌ [CivilEng] Structural analysis failed:`, error);
      throw error;
    }
  }

  // Soil Analysis Integration
  async analyzeSoilProperties(input: SoilAnalysisInput): Promise<any> {
    console.log(`🌱 [CivilEng] Analyzing soil properties at ${input.location.latitude}, ${input.location.longitude}`);

    try {
      // Execute soil analysis through agent
      const result = await engineeringAgentService.executeEngineeringAgent(
        'civilSoilAgent',
        '00850',
        'soil_analysis',
        'soil_analysis',
        `soil_${Date.now()}`,
        input,
        (step, message, data) => {
          console.log(`[SoilAnalysis] ${step}: ${message}`);
        }
      );

      // Validate and enhance results
      const enhancedResult = await this.enhanceSoilAnalysis(result, input);

      console.log(`✅ [CivilEng] Soil analysis completed`);
      return enhancedResult;

    } catch (error) {
      console.error(`❌ [CivilEng] Soil analysis failed:`, error);
      throw error;
    }
  }

  // Concrete Mix Design Calculator
  async designConcreteMix(input: ConcreteMixDesignInput): Promise<any> {
    console.log(`🧱 [CivilEng] Designing concrete mix for ${input.strength.target28Day} MPa`);

    try {
      // Execute mix design through agent
      const result = await engineeringAgentService.executeEngineeringAgent(
        'civilConcreteAgent',
        '00850',
        'concrete_mix_design',
        'concrete_mix_design',
        `concrete_${Date.now()}`,
        input,
        (step, message, data) => {
          console.log(`[ConcreteMix] ${step}: ${message}`);
        }
      );

      // Validate mix proportions
      const validatedMix = await this.validateConcreteMix(result, input);

      // Calculate costs and sustainability metrics
      const enhancedMix = await this.enhanceMixDesign(validatedMix, input);

      console.log(`✅ [CivilEng] Concrete mix design completed`);
      return enhancedMix;

    } catch (error) {
      console.error(`❌ [CivilEng] Concrete mix design failed:`, error);
      throw error;
    }
  }

  // Private Helper Methods

  private async validateFoundationInput(input: FoundationDesignInput): Promise<void> {
    if (input.loads.deadLoad <= 0 || input.loads.liveLoad <= 0) {
      throw new Error('Invalid load values: Dead and live loads must be positive');
    }

    if (input.soilProperties.bearingCapacity <= 0) {
      throw new Error('Invalid soil bearing capacity');
    }

    if (!['clay', 'sand', 'gravel', 'silt'].includes(input.soilProperties.soilType)) {
      throw new Error('Invalid soil type');
    }
  }

  private async validateFoundationDesign(
    result: any,
    input: FoundationDesignInput
  ): Promise<FoundationDesignResult> {
    // Check safety factors meet minimum requirements
    const minSafetyFactors = {
      bearing: 2.5,
      overturning: 1.5,
      sliding: 1.5
    };

    if (result.safetyFactors.bearing < minSafetyFactors.bearing) {
      console.warn(`⚠️ Bearing safety factor ${result.safetyFactors.bearing} below minimum ${minSafetyFactors.bearing}`);
    }

    return result as FoundationDesignResult;
  }

  private async generateFoundationDrawings(
    design: FoundationDesignResult,
    input: FoundationDesignInput
  ): Promise<string[]> {
    // Create drawing records for the foundation design
    const drawingIds: string[] = [];

    try {
      // Generate plan view drawing
      const planDrawing = await this.createFoundationDrawing('plan', design, input);
      drawingIds.push(planDrawing.id);

      // Generate section drawings
      const sectionDrawing = await this.createFoundationDrawing('section', design, input);
      drawingIds.push(sectionDrawing.id);

      // Generate reinforcement drawings
      const rebarDrawing = await this.createFoundationDrawing('reinforcement', design, input);
      drawingIds.push(rebarDrawing.id);

    } catch (error) {
      console.warn('Drawing generation failed, continuing without drawings:', error);
    }

    return drawingIds;
  }

  private async createFoundationDrawing(
    type: string,
    design: FoundationDesignResult,
    input: FoundationDesignInput
  ): Promise<any> {
    // Create drawing record in database
    const drawingData = {
      discipline_code: '00850',
      discipline_name: 'Civil Engineering',
      drawing_number: `FOUND-${Date.now()}`,
      title: `Foundation ${type} - ${design.foundationType}`,
      revision: '1.0',
      status: 'draft',
      drawing_category: 'foundations',
      metadata: {
        foundation_type: design.foundationType,
        dimensions: design.dimensions,
        reinforcement: design.reinforcement,
        design_input: input
      }
    };

    const { data, error } = await supabase
      .from('engineering_drawings')
      .insert([drawingData])
      .select()
      .single();

    if (error) throw error;
    return data;
  }

  private async calculateFoundationCost(design: FoundationDesignResult): Promise<number> {
    // Basic cost estimation based on dimensions and materials
    const volume = design.dimensions.length * design.dimensions.width * design.dimensions.depth;
    const concreteCost = volume * 150; // R150/m³ for concrete
    const rebarCost = this.estimateRebarCost(design.reinforcement);
    const excavationCost = volume * 50; // R50/m³ for excavation

    return concreteCost + rebarCost + excavationCost;
  }

  private estimateRebarCost(reinforcement: any): number {
    // Simplified rebar cost estimation
    // In practice, this would parse the reinforcement specifications
    return 5000; // Placeholder cost
  }

  private generateConstructionNotes(
    design: FoundationDesignResult,
    input: FoundationDesignInput
  ): string[] {
    const notes: string[] = [];

    if (input.soilProperties.groundwaterLevel && input.soilProperties.groundwaterLevel < design.dimensions.depth) {
      notes.push('⚠️ Groundwater level below foundation depth - consider dewatering');
    }

    if (design.safetyFactors.bearing < 3.0) {
      notes.push('⚠️ Bearing safety factor is marginal - monitor settlement');
    }

    if (input.soilProperties.soilType === 'clay') {
      notes.push('💧 Clay soil - ensure proper drainage and compaction');
    }

    return notes;
  }

  private async assessFoundationHITL(
    design: FoundationDesignResult,
    input: FoundationDesignInput
  ): Promise<void> {
    let requiresHITL = false;
    let reason = '';

    // High-risk conditions requiring human review
    if (design.safetyFactors.bearing < 2.0) {
      requiresHITL = true;
      reason = 'Bearing safety factor critically low';
    }

    if (input.loads.seismicLoad && input.loads.seismicLoad > input.loads.deadLoad) {
      requiresHITL = true;
      reason = 'High seismic loads require specialist review';
    }

    if (input.soilProperties.plasticityIndex && input.soilProperties.plasticityIndex > 40) {
      requiresHITL = true;
      reason = 'High plasticity soil requires geotechnical specialist review';
    }

    if (requiresHITL) {
      await this.createFoundationHITL(input, reason);
    }
  }

  private async createFoundationHITL(
    input: FoundationDesignInput,
    reason: string
  ): Promise<void> {
    try {
      await hitlService.createHITLTask(
        `foundation_design_${Date.now()}`,
        reason,
        'complex_decision',
        'foundation_design',
        `foundation_${Date.now()}`,
        '00850',
        {
          design_input: input,
          complexity_level: 'high',
          requires_geotechnical_review: true
        }
      );
      console.log('🎯 HITL task created for foundation design review');
    } catch (error) {
      console.error('Failed to create HITL task:', error);
    }
  }

  private async validateStructuralAnalysis(
    result: any,
    input: StructuralAnalysisInput
  ): Promise<StructuralAnalysisResult> {
    // Validate that utilization ratios are within acceptable limits
    if (result.utilizationRatios.strength > 1.0) {
      console.warn('⚠️ Structure exceeds strength capacity');
    }

    if (result.utilizationRatios.deflection > 1.0) {
      console.warn('⚠️ Structure exceeds deflection limits');
    }

    return result as StructuralAnalysisResult;
  }

  private async generateDesignRecommendations(
    analysis: StructuralAnalysisResult,
    input: StructuralAnalysisInput
  ): Promise<string[]> {
    const recommendations: string[] = [];

    if (analysis.utilizationRatios.strength > 0.8) {
      recommendations.push('Consider increasing member size to reduce utilization ratio');
    }

    if (analysis.utilizationRatios.deflection > 0.8) {
      recommendations.push('Add bracing or increase stiffness to control deflections');
    }

    if (analysis.memberForces.moment > 1000) { // kNm
      recommendations.push('High moment - consider continuous construction or additional reinforcement');
    }

    return recommendations;
  }

  private async enhanceSoilAnalysis(result: any, input: SoilAnalysisInput): Promise<any> {
    // Add recommendations based on soil analysis
    const recommendations: string[] = [];

    if (input.testType === 'standard_penetration') {
      const avgN = result.averageNValue || 0;
      if (avgN < 10) {
        recommendations.push('Very loose soil - deep foundations recommended');
      } else if (avgN < 30) {
        recommendations.push('Medium dense soil - consider shallow foundations with ground improvement');
      }
    }

    return {
      ...result,
      recommendations,
      suitabilityAssessment: this.assessFoundationSuitability(result, input)
    };
  }

  private assessFoundationSuitability(analysis: any, input: SoilAnalysisInput): any {
    // Determine suitable foundation types based on soil analysis
    const suitableTypes: string[] = [];

    if (analysis.bearingCapacity > 150) {
      suitableTypes.push('isolated', 'combined', 'raft');
    } else if (analysis.bearingCapacity > 75) {
      suitableTypes.push('raft', 'pile');
    } else {
      suitableTypes.push('pile');
    }

    return {
      suitableFoundationTypes: suitableTypes,
      recommendedType: suitableTypes[0],
      requiresGroundImprovement: analysis.bearingCapacity < 100
    };
  }

  private async validateConcreteMix(result: any, input: ConcreteMixDesignInput): Promise<any> {
    // Validate that the mix meets the target strength
    const expectedStrength = input.strength.target28Day;
    const designedStrength = result.characteristicStrength || 0;

    if (designedStrength < expectedStrength * 0.9) {
      console.warn(`⚠️ Designed strength ${designedStrength} below target ${expectedStrength}`);
    }

    return result;
  }

  private async enhanceMixDesign(result: any, input: ConcreteMixDesignInput): Promise<any> {
    // Add cost and sustainability calculations
    const cost = this.calculateMixCost(result);
    const co2Footprint = this.calculateCO2Footprint(result);
    const sustainability = this.assessSustainability(result);

    return {
      ...result,
      costAnalysis: cost,
      environmentalImpact: {
        co2Footprint,
        sustainabilityScore: sustainability.score,
        recommendations: sustainability.recommendations
      }
    };
  }

  private calculateMixCost(mix: any): any {
    // Calculate cost per cubic meter
    const cementCost = (mix.cement || 0) * 0.8; // R800/ton
    const aggregateCost = ((mix.fineAggregate || 0) + (mix.coarseAggregate || 0)) * 0.15; // R150/ton
    const admixtureCost = (mix.admixture || 0) * 50; // R50/kg

    const totalCost = cementCost + aggregateCost + admixtureCost;

    return {
      costPerCubicMeter: totalCost,
      costBreakdown: {
        cement: cementCost,
        aggregates: aggregateCost,
        admixtures: admixtureCost
      }
    };
  }

  private calculateCO2Footprint(mix: any): number {
    // CO2 emissions per cubic meter (kg)
    const cementCO2 = (mix.cement || 0) * 900; // 900 kg CO2 per ton of cement
    const transportCO2 = 50; // Transport emissions

    return cementCO2 + transportCO2;
  }

  private assessSustainability(mix: any): any {
    let score = 100;

    // Penalize high cement content
    if (mix.cement > 400) score -= 20;

    // Reward SCM usage
    if (mix.flyAsh || mix.ggbs) score += 10;

    const recommendations: string[] = [];
    if (mix.cement > 400) {
      recommendations.push('Consider reducing cement content with supplementary cementitious materials');
    }

    return {
      score,
      recommendations
    };
  }

  // Public API Methods for React Components

  async getFoundationDesignHistory(projectId: string): Promise<FoundationDesignResult[]> {
    // Get foundation designs for a project
    const { data, error } = await supabase
      .from('engineering_calculations')
      .select('*')
      .eq('project_id', projectId)
      .eq('calculation_type', 'foundation_design')
      .order('created_at', { ascending: false });

    if (error) throw error;
    return data || [];
  }

  async saveFoundationDesign(
    projectId: string,
    design: FoundationDesignResult,
    input: FoundationDesignInput
  ): Promise<string> {
    const calculationData = {
      project_id: projectId,
      calculation_type: 'foundation_design',
      input_data: input,
      result_data: design,
      discipline_code: '00850',
      created_by: 'current_user' // TODO: Get from auth
    };

    const { data, error } = await supabase
      .from('engineering_calculations')
      .insert([calculationData])
      .select()
      .single();

    if (error) throw error;
    return data.id;
  }
}

export const civilEngineeringService = CivilEngineeringService.getInstance();