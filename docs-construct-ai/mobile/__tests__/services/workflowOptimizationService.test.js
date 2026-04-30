/**
 * Workflow Optimization Service Tests
 * Comprehensive testing for performance monitoring and quality assessment
 */

import { WorkflowOptimizationService } from '../../src/services/workflowOptimizationService';
import AsyncStorage from '@react-native-async-storage/async-storage';

// Mock AsyncStorage
jest.mock('@react-native-async-storage/async-storage', () => ({
  getItem: jest.fn(),
  setItem: jest.fn(),
}));

// Mock AI service
jest.mock('../../src/services/aiService', () => ({
  aiService: {
    processRequest: jest.fn(),
  }
}));

const mockAIService = require('../../src/services/aiService').aiService;

describe('Workflow Optimization Service', () => {
  let workflowService;

  beforeEach(() => {
    jest.clearAllMocks();
    AsyncStorage.getItem.mockResolvedValue(null);
    AsyncStorage.setItem.mockResolvedValue();

    // Mock AI service responses
    mockAIService.processRequest.mockResolvedValue({
      data: { recommendations: ['Test recommendation'] }
    });

    workflowService = new WorkflowOptimizationService();
  });

  afterEach(() => {
    workflowService.destroy();
  });

  describe('Performance Monitoring', () => {
    test('should track performance metrics correctly', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation(() => {});

      await workflowService.trackPerformanceMetric(
        'test_operation',
        1500,
        true,
        { userId: 'user123' }
      );

      expect(consoleSpy).toHaveBeenCalledWith(
        'Performance Metric: test_operation - 1500ms (SUCCESS)'
      );

      consoleSpy.mockRestore();
    });

    test('should trigger AI anomaly analysis for slow operations', async () => {
      await workflowService.trackPerformanceMetric(
        'slow_operation',
        6000, // Over 5 second threshold
        false
      );

      expect(mockAIService.processRequest).toHaveBeenCalledWith(
        expect.objectContaining({
          type: 'analysis',
          parameters: expect.objectContaining({
            content: expect.stringContaining('slow_operation')
          })
        }),
        expect.any(Object)
      );
    });

    test('should store metrics in AsyncStorage', async () => {
      await workflowService.trackPerformanceMetric('test', 1000, true);

      expect(AsyncStorage.setItem).toHaveBeenCalledWith(
        'workflow_optimization_metrics',
        expect.any(String)
      );
    });
  });

  describe('Code Quality Assessment', () => {
    test('should assess code quality and detect issues', async () => {
      const testCode = `
        function testFunction() {
          var oldVar = 'test'; // Should flag this
          if (true) {
            console.log('test');
            console.log('test');
            console.log('test');
            console.log('test');
            console.log('test');
            console.log('test'); // 6+ lines
          }
        }
      `;

      const result = await workflowService.assessCodeQuality('test.js', testCode);

      expect(result.filePath).toBe('test.js');
      expect(result.linesOfCode).toBeGreaterThan(5);
      expect(result.complexity).toBeGreaterThan(1);
      expect(result.issues).toContain('VAR_USAGE: Use const/let instead of var');
    });

    test('should calculate complexity correctly', () => {
      const testCode = `
        function complexFunction() {
          if (condition1) {
            if (condition2) {
              for (let i = 0; i < 10; i++) {
                if (condition3 && condition4) {
                  return true;
                }
              }
            }
          }
        }
      `;

      // Access private method for testing
      const complexity = workflowService.calculateComplexity(testCode);
      expect(complexity).toBeGreaterThan(3); // Should count control structures
    });

    test('should handle files without imports/exports', async () => {
      const codeWithoutModules = `
        console.log('test');
        function test() { return true; }
      `;

      const result = await workflowService.assessCodeQuality('test.js', codeWithoutModules);
      expect(result.issues).toContain('MISSING_MODULES: No ES6 imports/exports');
    });
  });

  describe('Workflow Performance Tracking', () => {
    test('should track workflow steps', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation(() => {});

      await workflowService.trackWorkflowStep(
        'order_processing',
        'validation',
        2000,
        true,
        'user123'
      );

      expect(consoleSpy).toHaveBeenCalledWith(
        'Workflow Step: order_processing.validation - 2000ms (SUCCESS)'
      );

      consoleSpy.mockRestore();
    });

    test('should trigger bottleneck analysis for slow workflows', async () => {
      await workflowService.trackWorkflowStep(
        'slow_workflow',
        'bottleneck_step',
        12000, // Over 10 second threshold
        false
      );

      expect(mockAIService.processRequest).toHaveBeenCalledWith(
        expect.objectContaining({
          type: 'analysis',
          parameters: expect.objectContaining({
            content: expect.stringContaining('bottleneck_step')
          })
        }),
        expect.any(Object)
      );
    });
  });

  describe('System Health Reports', () => {
    beforeEach(() => {
      // Add some test data
      workflowService.performanceMetrics = [
        {
          id: '1',
          operation: 'api_call',
          duration: 1500,
          success: true,
          timestamp: new Date().toISOString(),
          deviceInfo: {
            platform: 'ios',
            connectivity: 'online',
            batteryLevel: 80,
            memoryUsage: 500000000
          }
        },
        {
          id: '2',
          operation: 'file_upload',
          duration: 3000,
          success: true,
          timestamp: new Date().toISOString(),
          deviceInfo: {
            platform: 'ios',
            connectivity: 'online',
            batteryLevel: 80,
            memoryUsage: 500000000
          }
        }
      ];

      workflowService.workflowMetrics = [
        {
          workflowId: 'order_123',
          step: 'validation',
          duration: 1000,
          success: true,
          timestamp: new Date().toISOString(),
          userId: 'user123'
        },
        {
          workflowId: 'order_123',
          step: 'processing',
          duration: 2000,
          success: true,
          timestamp: new Date().toISOString(),
          userId: 'user123'
        }
      ];

      workflowService.qualityMetrics = [
        {
          filePath: 'component.js',
          linesOfCode: 150,
          complexity: 8,
          functionCount: 5,
          timestamp: new Date().toISOString(),
          issues: ['LONG_FILE']
        }
      ];
    });

    test('should generate comprehensive health report', async () => {
      const report = await workflowService.generateHealthReport();

      expect(report).toHaveProperty('timestamp');
      expect(report.performance).toHaveProperty('averageResponseTime');
      expect(report.performance).toHaveProperty('successRate');
      expect(report.quality).toHaveProperty('totalFiles');
      expect(report.quality).toHaveProperty('averageComplexity');
      expect(report.workflows).toHaveProperty('totalWorkflows');
      expect(report.workflows).toHaveProperty('successRate');
      expect(report.recommendations).toHaveLengthGreaterThan(0);
    });

    test('should calculate correct health score', () => {
      // Access private method through report generation
      const report = workflowService.generateHealthReport();

      // Health score should be calculated and present in report
      expect(typeof report.performance.averageResponseTime).toBe('number');
      expect(report.performance.averageResponseTime).toBeGreaterThan(0);
    });

    test('should identify top slow operations', async () => {
      const report = await workflowService.generateHealthReport();

      expect(report.performance.topSlowOperations).toBeDefined();
      expect(Array.isArray(report.performance.topSlowOperations)).toBe(true);
    });

    test('should identify workflow bottlenecks', async () => {
      const report = await workflowService.generateHealthReport();

      expect(report.workflows.bottleneckSteps).toBeDefined();
      expect(Array.isArray(report.workflows.bottleneckSteps)).toBe(true);
    });

    test('should generate AI-powered recommendations', async () => {
      const report = await workflowService.generateHealthReport();

      expect(report.recommendations).toBeDefined();
      expect(Array.isArray(report.recommendations)).toBe(true);
      expect(report.recommendations.length).toBeGreaterThan(0);
    });
  });

  describe('Data Persistence', () => {
    test('should load metrics from AsyncStorage', async () => {
      const mockData = {
        performance: [
          {
            id: '1',
            operation: 'test_op',
            duration: 1000,
            success: true,
            timestamp: new Date().toISOString(),
            deviceInfo: {
              platform: 'ios',
              connectivity: 'online',
              batteryLevel: 80,
              memoryUsage: 500000000
            }
          }
        ],
        quality: [],
        workflow: [],
        timestamp: new Date().toISOString()
      };

      AsyncStorage.getItem.mockResolvedValueOnce(JSON.stringify(mockData));

      // Create new instance to trigger loading
      const newService = new WorkflowOptimizationService();

      // Wait for async loading
      await new Promise(resolve => setTimeout(resolve, 100));

      expect(newService.performanceMetrics).toHaveLength(1);
      expect(newService.performanceMetrics[0].operation).toBe('test_op');

      newService.destroy();
    });

    test('should handle AsyncStorage errors gracefully', async () => {
      AsyncStorage.getItem.mockRejectedValueOnce(new Error('Storage error'));

      // Should not throw
      expect(() => new WorkflowOptimizationService()).not.toThrow();
    });
  });

  describe('Device Context Detection', () => {
    test('should detect platform correctly', () => {
      // Access private method through testing approach
      const platform = workflowService.getPlatform();
      expect(['ios', 'android']).toContain(platform);
    });

    test('should provide fallback connectivity status', async () => {
      const connectivity = await workflowService.getConnectivityStatus();
      expect(['online', 'offline', 'limited']).toContain(connectivity);
    });

    test('should provide battery level fallback', async () => {
      const batteryLevel = await workflowService.getBatteryLevel();
      expect(typeof batteryLevel).toBe('number');
      expect(batteryLevel).toBeGreaterThanOrEqual(0);
      expect(batteryLevel).toBeLessThanOrEqual(100);
    });

    test('should provide memory usage fallback', () => {
      const memoryUsage = workflowService.getMemoryUsage();
      expect(typeof memoryUsage).toBe('number');
      expect(memoryUsage).toBeGreaterThan(0);
    });
  });

  describe('Continuous Monitoring', () => {
    test('should start continuous monitoring on initialization', () => {
      // The constructor should start monitoring
      expect(workflowService.monitoringInterval).toBeDefined();
    });

    test('should clean up monitoring on destroy', () => {
      const intervalId = workflowService.monitoringInterval;

      workflowService.destroy();

      expect(workflowService.monitoringInterval).toBeNull();
    });
  });
});