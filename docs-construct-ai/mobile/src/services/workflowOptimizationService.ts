/**
 * Workflow Optimization Service for ConstructAI Mobile
 * Implements performance monitoring, quality assessment, and system optimization
 * Following the workflow optimization guide standards
 */

import AsyncStorage from '@react-native-async-storage/async-storage';
import { aiService } from './aiService';

export interface PerformanceMetric {
  id: string;
  operation: string;
  duration: number;
  success: boolean;
  timestamp: string;
  deviceInfo: {
    platform: 'ios' | 'android';
    connectivity: 'online' | 'offline' | 'limited';
    batteryLevel: number;
    memoryUsage: number;
  };
  metadata?: any;
}

export interface CodeQualityMetric {
  filePath: string;
  linesOfCode: number;
  complexity: number;
  functionCount: number;
  timestamp: string;
  issues: string[];
}

export interface WorkflowMetric {
  workflowId: string;
  step: string;
  duration: number;
  success: boolean;
  timestamp: string;
  userId?: string;
}

export interface SystemHealthReport {
  timestamp: string;
  performance: {
    averageResponseTime: number;
    successRate: number;
    errorRate: number;
    topSlowOperations: Array<{ operation: string; avgDuration: number }>;
  };
  quality: {
    totalFiles: number;
    filesWithIssues: number;
    averageComplexity: number;
    topIssues: string[];
  };
  workflows: {
    totalWorkflows: number;
    successRate: number;
    averageDuration: number;
    bottleneckSteps: Array<{ step: string; avgDuration: number }>;
  };
  recommendations: string[];
}

class WorkflowOptimizationService {
  private performanceMetrics: PerformanceMetric[] = [];
  private qualityMetrics: CodeQualityMetric[] = [];
  private workflowMetrics: WorkflowMetric[] = [];
  private readonly MAX_METRICS = 1000; // Limit stored metrics
  private monitoringInterval: NodeJS.Timeout | null = null;

  constructor() {
    this.loadMetricsFromStorage();
    this.startContinuousMonitoring();
  }

  // Performance Monitoring
  async trackPerformanceMetric(
    operation: string,
    duration: number,
    success: boolean,
    metadata?: any
  ): Promise<void> {
    const metric: PerformanceMetric = {
      id: Date.now().toString(),
      operation,
      duration,
      success,
      timestamp: new Date().toISOString(),
      deviceInfo: {
        platform: this.getPlatform(),
        connectivity: await this.getConnectivityStatus(),
        batteryLevel: await this.getBatteryLevel(),
        memoryUsage: this.getMemoryUsage()
      },
      metadata
    };

    this.performanceMetrics.push(metric);

    // Maintain limit
    if (this.performanceMetrics.length > this.MAX_METRICS) {
      this.performanceMetrics = this.performanceMetrics.slice(-this.MAX_METRICS);
    }

    // AI-powered anomaly detection
    if (duration > 5000) { // Slow operation threshold
      await this.analyzePerformanceAnomaly(metric);
    }

    await this.saveMetricsToStorage();
    console.log(`Performance Metric: ${operation} - ${duration}ms (${success ? 'SUCCESS' : 'FAILED'})`);
  }

  // Code Quality Assessment
  async assessCodeQuality(filePath: string, content: string): Promise<CodeQualityMetric> {
    const linesOfCode = content.split('\n').length;
    const functionCount = (content.match(/function\s+\w+|const\s+\w+\s*=\s*\(/g) || []).length;
    const complexity = this.calculateComplexity(content);

    const issues: string[] = [];

    // Code quality checks following AGENTS.md standards
    if (linesOfCode > 500) {
      issues.push('LONG_FILE: File exceeds 500 lines');
    }

    if (complexity > 20) {
      issues.push('HIGH_COMPLEXITY: Cyclomatic complexity > 20');
    }

    if (content.includes('var ')) {
      issues.push('VAR_USAGE: Use const/let instead of var');
    }

    if (!content.includes('import') && !content.includes('export')) {
      issues.push('MISSING_MODULES: No ES6 imports/exports');
    }

    const metric: CodeQualityMetric = {
      filePath,
      linesOfCode,
      complexity,
      functionCount,
      timestamp: new Date().toISOString(),
      issues
    };

    this.qualityMetrics.push(metric);

    // Maintain limit
    if (this.qualityMetrics.length > this.MAX_METRICS) {
      this.qualityMetrics = this.qualityMetrics.slice(-this.MAX_METRICS);
    }

    await this.saveMetricsToStorage();

    if (issues.length > 0) {
      console.warn(`Code Quality Issues in ${filePath}:`, issues);
    }

    return metric;
  }

  // Workflow Performance Tracking
  async trackWorkflowStep(
    workflowId: string,
    step: string,
    duration: number,
    success: boolean,
    userId?: string
  ): Promise<void> {
    const metric: WorkflowMetric = {
      workflowId,
      step,
      duration,
      success,
      timestamp: new Date().toISOString(),
      userId
    };

    this.workflowMetrics.push(metric);

    // Maintain limit
    if (this.workflowMetrics.length > this.MAX_METRICS) {
      this.workflowMetrics = this.workflowMetrics.slice(-this.MAX_METRICS);
    }

    // Detect workflow bottlenecks
    if (duration > 10000) { // 10 second threshold
      await this.analyzeWorkflowBottleneck(metric);
    }

    await this.saveMetricsToStorage();
    console.log(`Workflow Step: ${workflowId}.${step} - ${duration}ms (${success ? 'SUCCESS' : 'FAILED'})`);
  }

  // Generate Comprehensive Health Report
  async generateHealthReport(): Promise<SystemHealthReport> {
    const now = new Date();
    const last24Hours = new Date(now.getTime() - 24 * 60 * 60 * 1000);

    // Filter recent metrics
    const recentPerformance = this.performanceMetrics.filter(m =>
      new Date(m.timestamp) > last24Hours
    );
    const recentWorkflows = this.workflowMetrics.filter(m =>
      new Date(m.timestamp) > last24Hours
    );

    // Performance Analysis
    const totalOperations = recentPerformance.length;
    const successfulOperations = recentPerformance.filter(m => m.success).length;
    const averageResponseTime = totalOperations > 0
      ? recentPerformance.reduce((sum, m) => sum + m.duration, 0) / totalOperations
      : 0;

    // Group operations by type for top slow operations
    const operationGroups = recentPerformance.reduce((groups, metric) => {
      if (!groups[metric.operation]) {
        groups[metric.operation] = [];
      }
      groups[metric.operation].push(metric);
      return groups;
    }, {} as Record<string, PerformanceMetric[]>);

    const topSlowOperations = Object.entries(operationGroups)
      .map(([operation, metrics]) => ({
        operation,
        avgDuration: metrics.reduce((sum, m) => sum + m.duration, 0) / metrics.length
      }))
      .sort((a, b) => b.avgDuration - a.avgDuration)
      .slice(0, 5);

    // Quality Analysis
    const totalFiles = this.qualityMetrics.length;
    const filesWithIssues = this.qualityMetrics.filter(m => m.issues.length > 0).length;
    const averageComplexity = totalFiles > 0
      ? this.qualityMetrics.reduce((sum, m) => sum + m.complexity, 0) / totalFiles
      : 0;

    const issueCounts: Record<string, number> = {};
    this.qualityMetrics.forEach(metric => {
      metric.issues.forEach(issue => {
        issueCounts[issue] = (issueCounts[issue] || 0) + 1;
      });
    });

    const topIssues = Object.entries(issueCounts)
      .sort(([, a], [, b]) => b - a)
      .slice(0, 5)
      .map(([issue]) => issue);

    // Workflow Analysis
    const totalWorkflows = recentWorkflows.length;
    const successfulWorkflows = recentWorkflows.filter(m => m.success).length;
    const averageWorkflowDuration = totalWorkflows > 0
      ? recentWorkflows.reduce((sum, m) => sum + m.duration, 0) / totalWorkflows
      : 0;

    // Group workflow steps for bottleneck analysis
    const stepGroups = recentWorkflows.reduce((groups, metric) => {
      if (!groups[metric.step]) {
        groups[metric.step] = [];
      }
      groups[metric.step].push(metric);
      return groups;
    }, {} as Record<string, WorkflowMetric[]>);

    const bottleneckSteps = Object.entries(stepGroups)
      .map(([step, metrics]) => ({
        step,
        avgDuration: metrics.reduce((sum, m) => sum + m.duration, 0) / metrics.length
      }))
      .sort((a, b) => b.avgDuration - a.avgDuration)
      .slice(0, 5);

    // Generate AI-powered recommendations
    const recommendations = await this.generateOptimizationRecommendations({
      performance: { averageResponseTime, successRate: successfulOperations / totalOperations },
      quality: { averageComplexity, topIssues },
      workflows: { averageDuration: averageWorkflowDuration }
    });

    const report: SystemHealthReport = {
      timestamp: now.toISOString(),
      performance: {
        averageResponseTime,
        successRate: totalOperations > 0 ? successfulOperations / totalOperations : 0,
        errorRate: totalOperations > 0 ? (totalOperations - successfulOperations) / totalOperations : 0,
        topSlowOperations
      },
      quality: {
        totalFiles,
        filesWithIssues,
        averageComplexity,
        topIssues
      },
      workflows: {
        totalWorkflows,
        successRate: totalWorkflows > 0 ? successfulWorkflows / totalWorkflows : 0,
        averageDuration: averageWorkflowDuration,
        bottleneckSteps
      },
      recommendations
    };

    console.log('System Health Report Generated:', report);
    return report;
  }

  // Private helper methods
  private calculateComplexity(content: string): number {
    let complexity = 1; // Base complexity

    // Count control structures
    const controlStructures = content.match(/\b(if|else|for|while|switch|case|catch|try)\b/g);
    if (controlStructures) {
      complexity += controlStructures.length;
    }

    // Count logical operators
    const logicalOps = content.match(/(\&\&|\|\||\?|:)/g);
    if (logicalOps) {
      complexity += logicalOps.length * 0.5;
    }

    return Math.round(complexity);
  }

  private async analyzePerformanceAnomaly(metric: PerformanceMetric): Promise<void> {
    try {
      // Use AI to analyze performance anomalies
      const analysisRequest = {
        type: 'analysis',
        parameters: {
          priority: 'normal',
          content: JSON.stringify({
            metric,
            context: 'performance_anomaly'
          })
        }
      };

      const deviceContext = {
        connectivity: 'online',
        availableStorage: 1000000000,
        availableRAM: 2000000000,
        batteryLevel: 80,
        platform: 'ios'
      };

      const result = await aiService.processRequest(analysisRequest, deviceContext);

      if (result.data?.recommendations) {
        console.warn('AI Performance Analysis:', result.data.recommendations);
      }
    } catch (error) {
      console.error('Failed to analyze performance anomaly:', error);
    }
  }

  private async analyzeWorkflowBottleneck(metric: WorkflowMetric): Promise<void> {
    try {
      const analysisRequest = {
        type: 'analysis',
        parameters: {
          priority: 'normal',
          content: JSON.stringify({
            metric,
            context: 'workflow_bottleneck'
          })
        }
      };

      const deviceContext = {
        connectivity: 'online',
        availableStorage: 1000000000,
        availableRAM: 2000000000,
        batteryLevel: 80,
        platform: 'ios'
      };

      const result = await aiService.processRequest(analysisRequest, deviceContext);

      if (result.data?.recommendations) {
        console.warn('AI Workflow Analysis:', result.data.recommendations);
      }
    } catch (error) {
      console.error('Failed to analyze workflow bottleneck:', error);
    }
  }

  private async generateOptimizationRecommendations(data: any): Promise<string[]> {
    const recommendations: string[] = [];

    // Performance recommendations
    if (data.performance.averageResponseTime > 2000) {
      recommendations.push('High average response time detected. Consider optimizing network calls and caching strategies.');
    }

    if (data.performance.successRate < 0.95) {
      recommendations.push('Low success rate detected. Review error handling and retry mechanisms.');
    }

    // Quality recommendations
    if (data.quality.averageComplexity > 15) {
      recommendations.push('High code complexity detected. Consider refactoring complex functions into smaller, focused modules.');
    }

    if (data.quality.topIssues.includes('VAR_USAGE')) {
      recommendations.push('Legacy var usage detected. Migrate to const/let for better code quality.');
    }

    // Workflow recommendations
    if (data.workflows.averageDuration > 5000) {
      recommendations.push('Slow workflow performance detected. Optimize async operations and reduce blocking calls.');
    }

    return recommendations;
  }

  private getPlatform(): 'ios' | 'android' {
    // Implementation would detect actual platform
    return 'ios';
  }

  private async getConnectivityStatus(): Promise<'online' | 'offline' | 'limited'> {
    // Implementation would check actual connectivity
    return 'online';
  }

  private async getBatteryLevel(): Promise<number> {
    // Implementation would get actual battery level
    return 80;
  }

  private getMemoryUsage(): number {
    // Implementation would get actual memory usage
    return 500000000; // 500MB
  }

  private async loadMetricsFromStorage(): Promise<void> {
    try {
      const stored = await AsyncStorage.getItem('workflow_optimization_metrics');
      if (stored) {
        const data = JSON.parse(stored);
        this.performanceMetrics = data.performance || [];
        this.qualityMetrics = data.quality || [];
        this.workflowMetrics = data.workflow || [];
      }
    } catch (error) {
      console.error('Failed to load metrics from storage:', error);
    }
  }

  private async saveMetricsToStorage(): Promise<void> {
    try {
      const data = {
        performance: this.performanceMetrics.slice(-100), // Keep last 100
        quality: this.qualityMetrics.slice(-50), // Keep last 50
        workflow: this.workflowMetrics.slice(-200), // Keep last 200
        timestamp: new Date().toISOString()
      };
      await AsyncStorage.setItem('workflow_optimization_metrics', JSON.stringify(data));
    } catch (error) {
      console.error('Failed to save metrics to storage:', error);
    }
  }

  private startContinuousMonitoring(): void {
    // Generate health reports every hour
    this.monitoringInterval = setInterval(async () => {
      try {
        const report = await this.generateHealthReport();
        // In production, send report to monitoring service
        console.log('Hourly Health Report:', report);
      } catch (error) {
        console.error('Failed to generate health report:', error);
      }
    }, 60 * 60 * 1000); // 1 hour
  }

  // Cleanup
  destroy(): void {
    if (this.monitoringInterval) {
      clearInterval(this.monitoringInterval);
    }
  }
}

export const workflowOptimizationService = new WorkflowOptimizationService();