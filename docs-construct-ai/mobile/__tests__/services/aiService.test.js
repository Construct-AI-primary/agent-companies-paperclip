/**
 * AI Service Tests
 * Comprehensive testing for multi-model AI integration
 */

import { aiService, AVAILABLE_MODELS, ModelRouter, CriticalOperationsManager } from '../../src/services/aiService';
import AsyncStorage from '@react-native-async-storage/async-storage';

// Mock AsyncStorage
jest.mock('@react-native-async-storage/async-storage', () => ({
  getItem: jest.fn(),
  setItem: jest.fn(),
  removeItem: jest.fn(),
}));

describe('AI Service', () => {
  beforeEach(() => {
    // Clear all mocks
    jest.clearAllMocks();

    // Reset AI service state
    aiService.responseCache.clear();
  });

  describe('Model Router', () => {
    let modelRouter;
    let deviceContext;

    beforeEach(() => {
      modelRouter = new ModelRouter();
      deviceContext = {
        connectivity: 'online',
        availableStorage: 3000000000, // 3GB
        availableRAM: 4000000000, // 4GB
        batteryLevel: 80,
        platform: 'ios'
      };
    });

    test('should select QWEN 7B for critical operations when available', async () => {
      // Mock model as downloaded
      AVAILABLE_MODELS[0].isDownloaded = true; // QWEN 7B

      const request = {
        type: 'customs-clearance',
        parameters: {
          priority: 'critical',
          content: 'test content'
        }
      };

      const selectedModel = await modelRouter.selectModel(request, deviceContext);
      expect(selectedModel?.id).toBe('qwen-7b');
    });

    test('should select lightweight model for low battery', async () => {
      // Set up multiple models as downloaded
      AVAILABLE_MODELS.forEach(model => model.isDownloaded = true);

      const request = {
        type: 'text-generation',
        parameters: {
          priority: 'normal',
          content: 'test content'
        }
      };

      // Low battery context
      const lowBatteryContext = { ...deviceContext, batteryLevel: 15 };

      const selectedModel = await modelRouter.selectModel(request, lowBatteryContext);
      expect(selectedModel?.id).toBe('qwen-1.5b'); // Should prefer lightweight model
    });

    test('should return null for online processing when no models downloaded', async () => {
      // Ensure no models are downloaded
      AVAILABLE_MODELS.forEach(model => model.isDownloaded = false);

      const request = {
        type: 'text-generation',
        parameters: {
          priority: 'normal',
          content: 'test content'
        }
      };

      const selectedModel = await modelRouter.selectModel(request, deviceContext);
      expect(selectedModel).toBeNull();
    });

    test('should select appropriate model based on capabilities', async () => {
      // Set up specific models as downloaded
      AVAILABLE_MODELS.forEach(model => model.isDownloaded = false);
      AVAILABLE_MODELS[1].isDownloaded = true; // DeepSeek 7B (supports incident-classification)

      const request = {
        type: 'incident-classification',
        parameters: {
          priority: 'high',
          content: 'safety incident report'
        }
      };

      const selectedModel = await modelRouter.selectModel(request, deviceContext);
      expect(selectedModel?.id).toBe('deepseek-7b');
    });
  });

  describe('Critical Operations Manager', () => {
    let criticalOps;

    beforeEach(() => {
      criticalOps = new CriticalOperationsManager();
    });

    test('should identify critical operations correctly', () => {
      expect(criticalOps.isCriticalOperation('customs_clearance')).toBe(true);
      expect(criticalOps.isCriticalOperation('emergency_response')).toBe(true);
      expect(criticalOps.isCriticalOperation('text-generation')).toBe(false);
    });

    test('should ensure offline capability for critical operations', async () => {
      // Set up model as downloaded
      AVAILABLE_MODELS[0].isDownloaded = true;

      const hasCapability = await criticalOps.ensureOfflineCapability('customs_clearance');
      expect(hasCapability).toBe(true);
    });

    test('should return false when no models available for critical operations', async () => {
      // Ensure no models are downloaded
      AVAILABLE_MODELS.forEach(model => model.isDownloaded = false);

      const hasCapability = await criticalOps.ensureOfflineCapability('emergency_response');
      expect(hasCapability).toBe(false);
    });
  });

  describe('AI Service Core Functionality', () => {
    beforeEach(() => {
      // Mock AsyncStorage responses
      AsyncStorage.getItem.mockResolvedValue(null);
      AsyncStorage.setItem.mockResolvedValue();
    });

    test('should process requests with offline models when available', async () => {
      // Set up QWEN 7B as downloaded
      AVAILABLE_MODELS[0].isDownloaded = true;

      const request = {
        type: 'customs-clearance',
        parameters: {
          priority: 'high',
          content: JSON.stringify({
            documentType: 'commercial_invoice',
            location: { latitude: -26.2041, longitude: 28.0473 }
          })
        }
      };

      const deviceContext = {
        connectivity: 'offline',
        availableStorage: 3000000000,
        availableRAM: 4000000000,
        batteryLevel: 80,
        platform: 'ios'
      };

      const result = await aiService.processRequest(request, deviceContext);

      expect(result.status).toBe('success');
      expect(result.data).toHaveProperty('hsCode');
      expect(result.data).toHaveProperty('duties');
    });

    test('should cache responses for repeated requests', async () => {
      AVAILABLE_MODELS[0].isDownloaded = true;

      const request = {
        type: 'customs-clearance',
        parameters: {
          priority: 'high',
          content: 'test content'
        }
      };

      const deviceContext = {
        connectivity: 'offline',
        availableStorage: 3000000000,
        availableRAM: 4000000000,
        batteryLevel: 80,
        platform: 'ios'
      };

      // First request
      const result1 = await aiService.processRequest(request, deviceContext);

      // Second request with same parameters should use cache
      const result2 = await aiService.processRequest(request, deviceContext);

      expect(result1).toEqual(result2);
      expect(aiService.responseCache.size).toBe(1);
    });

    test('should download models successfully', async () => {
      const downloadResult = await aiService.downloadModel('qwen-7b');

      expect(downloadResult).toBe(true);

      // Verify model state was updated
      const models = await aiService.getAvailableModels();
      const qwenModel = models.find(m => m.id === 'qwen-7b');
      expect(qwenModel?.isDownloaded).toBe(true);
    });

    test('should handle model download failures', async () => {
      // Mock a failure scenario
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation(() => {});

      // Test with invalid model ID
      const downloadResult = await aiService.downloadModel('invalid-model');

      expect(downloadResult).toBe(false);
      expect(consoleSpy).toHaveBeenCalled();

      consoleSpy.mockRestore();
    });

    test('should load and save model states from AsyncStorage', async () => {
      const mockModelStates = {
        'qwen-7b': {
          isDownloaded: true,
          lastUsed: new Date().toISOString()
        }
      };

      AsyncStorage.getItem.mockResolvedValueOnce(JSON.stringify(mockModelStates));

      // Trigger loading by accessing getAvailableModels
      await aiService.getAvailableModels();

      // Verify AsyncStorage was called
      expect(AsyncStorage.getItem).toHaveBeenCalledWith('ai_model_states');

      // Verify model state was loaded
      const models = await aiService.getAvailableModels();
      const qwenModel = models.find(m => m.id === 'qwen-7b');
      expect(qwenModel?.isDownloaded).toBe(true);
    });

    test('should log performance metrics', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation(() => {});

      await aiService.logPerformanceMetrics('test_operation', 1500, true);

      expect(consoleSpy).toHaveBeenCalledWith(
        'AI Performance Metric:',
        expect.objectContaining({
          operation: 'test_operation',
          duration: 1500,
          success: true
        })
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Error Handling', () => {
    test('should handle invalid model selection gracefully', async () => {
      const request = {
        type: 'invalid-type',
        parameters: {
          priority: 'normal',
          content: 'test'
        }
      };

      const deviceContext = {
        connectivity: 'offline',
        availableStorage: 3000000000,
        availableRAM: 4000000000,
        batteryLevel: 80,
        platform: 'ios'
      };

      const result = await aiService.processRequest(request, deviceContext);

      expect(result.status).toBe('success');
      expect(result.data).toHaveProperty('message');
    });

    test('should handle AsyncStorage failures gracefully', async () => {
      AsyncStorage.getItem.mockRejectedValueOnce(new Error('Storage failure'));

      // Should not throw, should handle gracefully
      await expect(aiService.getAvailableModels()).resolves.toBeDefined();
    });
  });
});