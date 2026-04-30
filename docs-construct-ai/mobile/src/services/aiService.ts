/**
 * AI Service Framework for ConstructAI Mobile
 * Implements multi-model AI integration with offline capabilities
 * Following the mobile enhancement implementation plan
 */

import AsyncStorage from '@react-native-async-storage/async-storage';

export interface AIModelProvider {
  id: string;
  name: string;
  capabilities: string[];
  downloadUrl: string;
  fileSize: number;
  requirements: {
    minStorage: number;
    minRAM: number;
    supportedPlatforms: string[];
  };
  isDownloaded: boolean;
  lastUsed: Date | null;
}

export interface AIRequest {
  type: 'text-generation' | 'document-analysis' | 'incident-classification' | 'customs-clearance' | 'procurement-analysis';
  parameters: {
    priority: 'low' | 'normal' | 'high' | 'critical';
    content: string;
    context?: any;
    maxTokens?: number;
  };
}

export interface DeviceContext {
  connectivity: 'online' | 'offline' | 'limited';
  availableStorage: number;
  availableRAM: number;
  batteryLevel: number;
  platform: 'ios' | 'android';
}

// Available AI models following the implementation plan
export const AVAILABLE_MODELS: AIModelProvider[] = [
  {
    id: 'qwen-7b',
    name: 'QWEN 2.5 7B',
    capabilities: ['text-generation', 'construction-analysis', 'document-analysis'],
    downloadUrl: '/api/models/download/qwen-7b',
    fileSize: 2_000_000_000, // 2GB
    requirements: {
      minStorage: 3_000_000_000, // 3GB
      minRAM: 4_000_000_000, // 4GB
      supportedPlatforms: ['ios', 'android']
    },
    isDownloaded: false,
    lastUsed: null
  },
  {
    id: 'deepseek-7b',
    name: 'DeepSeek 7B',
    capabilities: ['text-generation', 'analysis', 'coding', 'incident-classification'],
    downloadUrl: '/api/models/download/deepseek-7b',
    fileSize: 1_800_000_000, // 1.8GB
    requirements: {
      minStorage: 2_500_000_000, // 2.5GB
      minRAM: 3_000_000_000, // 3GB
      supportedPlatforms: ['ios', 'android']
    },
    isDownloaded: false,
    lastUsed: null
  },
  {
    id: 'qwen-1.5b',
    name: 'QWEN 1.5B (Lightweight)',
    capabilities: ['text-generation', 'basic-analysis'],
    downloadUrl: '/api/models/download/qwen-1.5b',
    fileSize: 500_000_000, // 500MB
    requirements: {
      minStorage: 1_000_000_000, // 1GB
      minRAM: 1_000_000_000, // 1GB
      supportedPlatforms: ['ios', 'android']
    },
    isDownloaded: false,
    lastUsed: null
  }
];

class ModelRouter {
  async selectModel(request: AIRequest, context: DeviceContext): Promise<AIModelProvider | null> {
    // Critical operations always get best available model
    if (request.parameters.priority === 'critical') {
      return this.selectCriticalModel(context.connectivity, context.availableStorage);
    }

    // Cost optimization for normal operations
    return this.optimizeCostPerformance(request, context);
  }

  private selectCriticalModel(connectivity: string, storage: number): AIModelProvider | null {
    // For critical operations, prefer QWEN 7B if available, fallback to any downloaded model
    const downloadedModels = AVAILABLE_MODELS.filter(model => model.isDownloaded);

    if (downloadedModels.length === 0) {
      // No models downloaded - return null for online processing
      return null;
    }

    // Prefer QWEN 7B for critical operations
    const qwen7b = downloadedModels.find(model => model.id === 'qwen-7b');
    if (qwen7b && storage >= qwen7b.requirements.minStorage) {
      return qwen7b;
    }

    // Fallback to any available model
    return downloadedModels[0];
  }

  private optimizeCostPerformance(request: AIRequest, context: DeviceContext): AIModelProvider | null {
    const downloadedModels = AVAILABLE_MODELS.filter(model =>
      model.isDownloaded &&
      context.availableStorage >= model.requirements.minStorage &&
      context.availableRAM >= model.requirements.minRAM
    );

    if (downloadedModels.length === 0) {
      return null; // Online processing
    }

    // Select based on request type and capabilities
    const suitableModels = downloadedModels.filter(model =>
      model.capabilities.includes(request.type)
    );

    if (suitableModels.length === 0) {
      return downloadedModels[0]; // Fallback to any model
    }

    // Prefer lightweight model for battery conservation when battery is low
    if (context.batteryLevel < 20) {
      const lightweight = suitableModels.find(model => model.id === 'qwen-1.5b');
      if (lightweight) return lightweight;
    }

    // Otherwise, use most recently used or first available
    return suitableModels.sort((a, b) => {
      if (!a.lastUsed && !b.lastUsed) return 0;
      if (!a.lastUsed) return 1;
      if (!b.lastUsed) return -1;
      return b.lastUsed.getTime() - a.lastUsed.getTime();
    })[0];
  }
}

class CriticalOperationsManager {
  private criticalTypes = [
    'customs_clearance',
    'emergency_response',
    'safety_incident',
    'equipment_failure'
  ];

  isCriticalOperation(requestType: string): boolean {
    return this.criticalTypes.includes(requestType);
  }

  async ensureOfflineCapability(requestType: string): Promise<boolean> {
    if (this.isCriticalOperation(requestType)) {
      // Preload critical resources
      const model = AVAILABLE_MODELS.find(m => m.capabilities.includes(requestType) && m.isDownloaded);
      return !!model;
    }
    return false;
  }
}

class AIService {
  private modelRouter: ModelRouter;
  private criticalOps: CriticalOperationsManager;
  private responseCache: Map<string, any> = new Map();

  constructor() {
    this.modelRouter = new ModelRouter();
    this.criticalOps = new CriticalOperationsManager();
    this.loadModelStates();
  }

  async processRequest(request: AIRequest, deviceContext: DeviceContext): Promise<any> {
    const cacheKey = this.generateCacheKey(request);

    // Check cache first
    if (this.responseCache.has(cacheKey)) {
      return this.responseCache.get(cacheKey);
    }

    // Select appropriate model
    const selectedModel = await this.modelRouter.selectModel(request, deviceContext);

    let response;

    if (selectedModel && deviceContext.connectivity === 'offline') {
      // Offline processing with local model
      response = await this.processOffline(request, selectedModel);
    } else {
      // Online processing or fallback
      response = await this.processOnline(request);
    }

    // Cache response for future use
    this.responseCache.set(cacheKey, response);

    // Update model usage statistics
    if (selectedModel) {
      selectedModel.lastUsed = new Date();
      this.saveModelStates();
    }

    return response;
  }

  private async processOffline(request: AIRequest, model: AIModelProvider): Promise<any> {
    // Implementation would integrate with actual local AI model
    // For now, return mock response based on request type
    console.log(`Processing ${request.type} with ${model.name} (offline)`);

    switch (request.type) {
      case 'customs-clearance':
        return {
          status: 'success',
          data: {
            hsCode: '8471.30.00',
            duties: 0,
            requirements: ['commercial_invoice', 'packing_list'],
            processingTime: '2-3 days'
          }
        };

      case 'incident-classification':
        return {
          status: 'success',
          data: {
            severity: 'medium',
            category: 'equipment',
            responseTime: '4 hours',
            reportRequired: true
          }
        };

      case 'document-analysis':
        return {
          status: 'success',
          data: {
            extractedFields: {},
            confidence: 0.85,
            suggestions: []
          }
        };

      default:
        return {
          status: 'success',
          data: { message: 'Offline processing completed' }
        };
    }
  }

  private async processOnline(request: AIRequest): Promise<any> {
    // Implementation would call actual AI API endpoints
    console.log(`Processing ${request.type} online`);

    try {
      // Mock API call - replace with actual implementation
      const response = await fetch('/api/ai/process', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(request)
      });

      return await response.json();
    } catch (error) {
      console.error('Online AI processing failed:', error);
      throw error;
    }
  }

  async downloadModel(modelId: string): Promise<boolean> {
    const model = AVAILABLE_MODELS.find(m => m.id === modelId);
    if (!model) return false;

    try {
      console.log(`Downloading model: ${model.name}`);

      // Mock download process - replace with actual implementation
      // In real implementation, this would:
      // 1. Check available storage
      // 2. Download model files
      // 3. Verify integrity
      // 4. Update model state

      model.isDownloaded = true;
      model.lastUsed = new Date();
      await this.saveModelStates();

      return true;
    } catch (error) {
      console.error(`Failed to download model ${modelId}:`, error);
      return false;
    }
  }

  async getAvailableModels(): Promise<AIModelProvider[]> {
    await this.loadModelStates();
    return AVAILABLE_MODELS;
  }

  private generateCacheKey(request: AIRequest): string {
    return `${request.type}_${JSON.stringify(request.parameters).slice(0, 100)}`;
  }

  private async loadModelStates(): Promise<void> {
    try {
      const stored = await AsyncStorage.getItem('ai_model_states');
      if (stored) {
        const states = JSON.parse(stored);
        AVAILABLE_MODELS.forEach(model => {
          const state = states[model.id];
          if (state) {
            model.isDownloaded = state.isDownloaded;
            model.lastUsed = state.lastUsed ? new Date(state.lastUsed) : null;
          }
        });
      }
    } catch (error) {
      console.error('Failed to load model states:', error);
    }
  }

  private async saveModelStates(): Promise<void> {
    try {
      const states = {};
      AVAILABLE_MODELS.forEach(model => {
        states[model.id] = {
          isDownloaded: model.isDownloaded,
          lastUsed: model.lastUsed?.toISOString()
        };
      });
      await AsyncStorage.setItem('ai_model_states', JSON.stringify(states));
    } catch (error) {
      console.error('Failed to save model states:', error);
    }
  }

  // Workflow optimization monitoring
  async logPerformanceMetrics(operation: string, duration: number, success: boolean): Promise<void> {
    const metric = {
      operation,
      duration,
      success,
      timestamp: new Date().toISOString(),
      deviceInfo: {
        platform: 'mobile',
        connectivity: 'unknown' // Would be populated from device context
      }
    };

    console.log('AI Performance Metric:', metric);

    // In production, send to monitoring service
    // await monitoringService.logMetric(metric);
  }
}

export const aiService = new AIService();
export { ModelRouter, CriticalOperationsManager };