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

# 0000_HF_MODEL_INTEGRATION_PROCEDURE.md - HuggingFace Model Integration Procedure

## Document Information

- **Document ID**: `0000_HF_MODEL_INTEGRATION_PROCEDURE`
- **Version**: 1.0
- **Created**: 2026-01-23
- **Last Updated**: 2026-01-23
- **Author**: AI Assistant (Construct AI)
- **Review Cycle**: Quarterly
- **Classification**: Technical Integration Procedure
- **Related Documents**:
  - `0000_QWEN_FINETUNING_PROCEDURE.md` - Local model training
  - `0000_LORA_ADAPTER_INTEGRATION_PROCEDURE.md` - Local model integration
  - `docs/procedures/0000_PROCEDURES_GUIDE.md` - Procedure navigation

---

## Overview

This procedure documents how to integrate and use external HuggingFace models in the ConstructAI system. This covers scenarios where you want to use pre-trained models from HuggingFace Hub (like `alistairtennant/deep-agents` and `alistairtennant/construct-training-data`) rather than training new models locally.

**Use Cases**:
- Integrating community-trained models
- Using specialized pre-trained models
- Leveraging existing expertise models
- Rapid prototyping with available models

---

## Model Discovery and Evaluation

### **Step 1: Model Research and Selection**

#### **HuggingFace Hub Exploration**
```python
# Script: explore_hf_models.py
from huggingface_hub import HfApi
import pandas as pd

def explore_construction_models():
    """Explore available construction/AI models on HuggingFace"""
    api = HfApi()

    # Search for construction-related models
    construction_models = api.list_models(
        filter="text-generation",
        search="construction OR engineering OR building OR safety",
        sort="downloads",
        direction=-1,  # Descending
        limit=50
    )

    models_data = []
    for model in construction_models:
        models_data.append({
            'model_id': model.id,
            'author': model.author,
            'downloads': model.downloads,
            'likes': model.likes,
            'tags': model.tags,
            'created_at': model.created_at,
            'model_size': getattr(model, 'model_size', 'unknown')
        })

    df = pd.DataFrame(models_data)

    # Filter for promising models
    promising = df[
        (df['downloads'] > 100) &  # Has some usage
        (df['likes'] > 10) &       # Community approved
        (df['author'] != 'microsoft') &  # Avoid generic models
        (df['author'] != 'openai')
    ].head(20)

    print("Top Construction Models:")
    print(promising[['model_id', 'author', 'downloads', 'likes']].to_string())

    return promising

def check_specific_models(model_ids):
    """Check specific models of interest"""
    api = HfApi()

    for model_id in model_ids:
        try:
            model_info = api.model_info(model_id)
            print(f"\n🔍 {model_id}")
            print(f"  Author: {model_info.author}")
            print(f"  Downloads: {model_info.downloads}")
            print(f"  Likes: {model_info.likes}")
            print(f"  Tags: {model_info.tags}")
            print(f"  Size: {getattr(model_info, 'model_size', 'unknown')}")

            # Check for required files
            files = api.list_repo_files(model_id)
            has_config = any('config.json' in f for f in files)
            has_model = any('.bin' in f or '.safetensors' in f for f in files)
            has_tokenizer = any('tokenizer' in f for f in files)

            print(f"  Has Config: {has_config}")
            print(f"  Has Model: {has_model}")
            print(f"  Has Tokenizer: {has_tokenizer}")

        except Exception as e:
            print(f"❌ Error checking {model_id}: {e}")

if __name__ == "__main__":
    # Check your specific models
    your_models = [
        "alistairtennant/deep-agents",
        "alistairtennant/construct-training-data"
    ]

    print("Checking your specific models:")
    check_specific_models(your_models)

    print("\n" + "="*50)
    print("Exploring broader construction model landscape:")
    explore_construction_models()
```

#### **Model Compatibility Check**
```python
# Script: check_model_compatibility.py
from transformers import AutoConfig, AutoTokenizer, AutoModelForCausalLM
import torch

def check_model_compatibility(model_id: str):
    """Check if a HF model is compatible with your system"""

    print(f"🔍 Checking compatibility for: {model_id}")

    try:
        # Load config
        config = AutoConfig.from_pretrained(model_id)
        print("✅ Config loaded successfully"        print(f"  Model Type: {config.model_type}")
        print(f"  Vocab Size: {config.vocab_size}")
        print(f"  Hidden Size: {config.hidden_size}")
        print(f"  Num Layers: {config.num_hidden_layers}")
        print(f"  Num Heads: {config.num_attention_heads}")

        # Load tokenizer
        tokenizer = AutoTokenizer.from_pretrained(model_id)
        print("✅ Tokenizer loaded successfully"        print(f"  Special Tokens: {tokenizer.special_tokens_map}")
        print(f"  EOS Token: {tokenizer.eos_token}")
        print(f"  BOS Token: {tokenizer.bos_token}")

        # Quick model load test (without weights for speed)
        config_only = AutoConfig.from_pretrained(model_id)
        print("✅ Model architecture compatible"
        # Estimate memory requirements
        if hasattr(config, 'hidden_size') and hasattr(config, 'num_hidden_layers'):
            # Rough estimate: 2 bytes per parameter (FP16)
            estimated_params = config.hidden_size * config.hidden_size * config.num_hidden_layers * 12  # Rough multiplier
            estimated_memory = estimated_params * 2 / (1024**3)  # GB
            print(".1f"
        return {
            'compatible': True,
            'model_type': config.model_type,
            'vocab_size': config.vocab_size,
            'estimated_memory': estimated_memory if 'estimated_memory' in locals() else None
        }

    except Exception as e:
        print(f"❌ Compatibility check failed: {e}")
        return {
            'compatible': False,
            'error': str(e)
        }

def compare_models(model_ids: list):
    """Compare multiple models for selection"""
    results = {}

    for model_id in model_ids:
        print(f"\n{'='*60}")
        results[model_id] = check_model_compatibility(model_id)

    print(f"\n{'='*60}")
    print("COMPARISON SUMMARY")
    print(f"{'='*60}")

    for model_id, result in results.items():
        status = "✅ COMPATIBLE" if result['compatible'] else "❌ INCOMPATIBLE"
        print(f"{model_id}: {status}")

        if result['compatible']:
            print(f"  Type: {result.get('model_type', 'unknown')}")
            print(f"  Vocab: {result.get('vocab_size', 'unknown')}")
            if result.get('estimated_memory'):
                print(".1f")

    return results

if __name__ == "__main__":
    your_models = [
        "alistairtennant/deep-agents",
        "alistairtennant/construct-training-data"
    ]

    results = compare_models(your_models)
```

---

## Integration Methods

### **Method 1: Direct HuggingFace Integration**

#### **Python Service Integration**
```python
# hf_model_service.py
from transformers import AutoTokenizer, AutoModelForCausalLM, pipeline
import torch
from huggingface_hub import HfApi
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class HuggingFaceModelService:
    def __init__(self, device="auto"):
        self.device = device
        self.loaded_models = {}
        self.api = HfApi()

    def load_model(self, model_id: str, use_auth: bool = False):
        """Load a model from HuggingFace Hub"""
        try:
            logger.info(f"Loading model: {model_id}")

            # Check model info first
            model_info = self.api.model_info(model_id)
            logger.info(f"Model size: {getattr(model_info, 'model_size', 'unknown')}")

            # Load tokenizer
            tokenizer = AutoTokenizer.from_pretrained(
                model_id,
                trust_remote_code=True,
                use_auth_token=use_auth
            )

            # Load model with memory optimization
            model = AutoModelForCausalLM.from_pretrained(
                model_id,
                torch_dtype=torch.float16,
                device_map=self.device,
                trust_remote_code=True,
                use_auth_token=use_auth,
                load_in_8bit=True,  # Memory optimization
                low_cpu_mem_usage=True
            )

            # Create pipeline for easier inference
            pipe = pipeline(
                "text-generation",
                model=model,
                tokenizer=tokenizer,
                torch_dtype=torch.float16,
                device_map=self.device
            )

            self.loaded_models[model_id] = {
                'model': model,
                'tokenizer': tokenizer,
                'pipeline': pipe,
                'loaded_at': torch.cuda.Event().record() if torch.cuda.is_available() else None
            }

            logger.info(f"✅ Successfully loaded {model_id}")
            return True

        except Exception as e:
            logger.error(f"❌ Failed to load {model_id}: {e}")
            return False

    def generate_response(self, model_id: str, prompt: str, **kwargs):
        """Generate response using specified model"""
        if model_id not in self.loaded_models:
            if not self.load_model(model_id):
                raise ValueError(f"Model {model_id} not available")

        model_data = self.loaded_models[model_id]
        pipe = model_data['pipeline']

        # Default generation parameters
        generation_kwargs = {
            'max_new_tokens': kwargs.get('max_new_tokens', 512),
            'temperature': kwargs.get('temperature', 0.7),
            'do_sample': kwargs.get('do_sample', True),
            'pad_token_id': pipe.tokenizer.eos_token_id,
            'return_full_text': False
        }

        # Override with any provided kwargs
        generation_kwargs.update(kwargs)

        try:
            logger.info(f"Generating response with {model_id}")
            outputs = pipe(prompt, **generation_kwargs)

            response = outputs[0]['generated_text']
            return response

        except Exception as e:
            logger.error(f"Generation failed for {model_id}: {e}")
            raise

    def unload_model(self, model_id: str):
        """Unload model to free memory"""
        if model_id in self.loaded_models:
            del self.loaded_models[model_id]
            torch.cuda.empty_cache()  # Clear GPU cache
            logger.info(f"Unloaded model: {model_id}")

    def get_model_info(self, model_id: str):
        """Get information about a model"""
        try:
            info = self.api.model_info(model_id)
            return {
                'id': info.id,
                'author': info.author,
                'downloads': info.downloads,
                'likes': info.likes,
                'tags': info.tags,
                'created_at': info.created_at,
                'model_size': getattr(info, 'model_size', 'unknown')
            }
        except Exception as e:
            return {'error': str(e)}

# Usage example
if __name__ == "__main__":
    service = HuggingFaceModelService()

    # Load your models
    models_to_load = [
        "alistairtennant/deep-agents",
        "alistairtennant/construct-training-data"
    ]

    for model_id in models_to_load:
        if service.load_model(model_id):
            # Test generation
            prompt = "You are a construction expert. Analyze this safety issue: Worker fell from scaffolding."
            response = service.generate_response(model_id, prompt, max_new_tokens=200)
            print(f"\n{model_id} Response:")
            print(response)
```

#### **Node.js API Integration**
```javascript
// server/src/services/hf-model-service.js
const { spawn } = require('child_process');
const path = require('path');

class HuggingFaceModelService {
    constructor() {
        this.pythonServicePath = path.join(__dirname, 'hf_model_service.py');
        this.loadedModels = new Set();
    }

    async loadModel(modelId) {
        return new Promise((resolve, reject) => {
            const python = spawn('python', [
                this.pythonServicePath,
                '--load-model',
                modelId
            ], {
                stdio: ['pipe', 'pipe', 'pipe'],
                cwd: __dirname
            });

            let stdout = '';
            let stderr = '';

            python.stdout.on('data', (data) => {
                stdout += data.toString();
            });

            python.stderr.on('data', (data) => {
                stderr += data.toString();
            });

            python.on('close', (code) => {
                if (code === 0 && stdout.includes('Successfully loaded')) {
                    this.loadedModels.add(modelId);
                    resolve({ success: true, message: stdout });
                } else {
                    reject(new Error(`Failed to load model: ${stderr}`));
                }
            });
        });
    }

    async generateResponse(modelId, prompt, options = {}) {
        const {
            maxNewTokens = 512,
            temperature = 0.7,
            doSample = true
        } = options;

        return new Promise((resolve, reject) => {
            const python = spawn('python', [
                this.pythonServicePath,
                '--generate',
                '--model-id', modelId,
                '--prompt', prompt,
                '--max-new-tokens', maxNewTokens.toString(),
                '--temperature', temperature.toString(),
                '--do-sample', doSample.toString()
            ], {
                stdio: ['pipe', 'pipe', 'pipe'],
                cwd: __dirname
            });

            let response = '';

            python.stdout.on('data', (data) => {
                response += data.toString();
            });

            python.stderr.on('data', (data) => {
                stderr += data.toString();
            });

            python.on('close', (code) => {
                if (code === 0) {
                    resolve(response.trim());
                } else {
                    reject(new Error(`Generation failed: ${stderr}`));
                }
            });
        });
    }

    isModelLoaded(modelId) {
        return this.loadedModels.has(modelId);
    }

    async getModelInfo(modelId) {
        return new Promise((resolve, reject) => {
            const python = spawn('python', [
                this.pythonServicePath,
                '--model-info',
                modelId
            ], {
                stdio: ['pipe', 'pipe', 'pipe'],
                cwd: __dirname
            });

            let info = '';

            python.stdout.on('data', (data) => {
                info += data.toString();
            });

            python.stderr.on('data', (data) => {
                stderr += data.toString();
            });

            python.on('close', (code) => {
                if (code === 0) {
                    try {
                        resolve(JSON.parse(info));
                    } catch (e) {
                        resolve({ raw: info });
                    }
                } else {
                    reject(new Error(`Failed to get model info: ${stderr}`));
                }
            });
        });
    }
}

module.exports = HuggingFaceModelService;
```

### **Method 2: REST API Integration**

#### **Express Routes for HF Models**
```javascript
// server/src/routes/hf-model-routes.js
const express = require('express');
const router = express.Router();
const HuggingFaceModelService = require('../services/hf-model-service');

const hfService = new HuggingFaceModelService();

// POST /api/hf-models/load/:modelId
router.post('/load/:modelId', async (req, res) => {
    try {
        const { modelId } = req.params;
        const { useAuth = false } = req.body;

        console.log(`🔄 Loading HF model: ${modelId}`);

        const result = await hfService.loadModel(modelId, useAuth);

        res.json({
            success: true,
            modelId,
            message: 'Model loaded successfully',
            timestamp: new Date().toISOString()
        });

    } catch (error) {
        console.error(`❌ Failed to load HF model ${req.params.modelId}:`, error);
        res.status(500).json({
            success: false,
            error: error.message,
            modelId: req.params.modelId
        });
    }
});

// POST /api/hf-models/generate/:modelId
router.post('/generate/:modelId', async (req, res) => {
    try {
        const { modelId } = req.params;
        const {
            prompt,
            maxNewTokens = 512,
            temperature = 0.7,
            doSample = true
        } = req.body;

        if (!prompt) {
            return res.status(400).json({
                success: false,
                error: 'Prompt is required'
            });
        }

        console.log(`🤖 Generating with HF model: ${modelId}`);

        // Check if model is loaded
        if (!hfService.isModelLoaded(modelId)) {
            console.log(`Model ${modelId} not loaded, loading now...`);
            await hfService.loadModel(modelId);
        }

        const response = await hfService.generateResponse(modelId, prompt, {
            maxNewTokens,
            temperature,
            doSample
        });

        res.json({
            success: true,
            modelId,
            response,
            timestamp: new Date().toISOString()
        });

    } catch (error) {
        console.error(`❌ HF model generation failed for ${req.params.modelId}:`, error);
        res.status(500).json({
            success: false,
            error: error.message,
            modelId: req.params.modelId
        });
    }
});

// GET /api/hf-models/info/:modelId
router.get('/info/:modelId', async (req, res) => {
    try {
        const { modelId } = req.params;

        const info = await hfService.getModelInfo(modelId);

        res.json({
            success: true,
            modelId,
            info,
            timestamp: new Date().toISOString()
        });

    } catch (error) {
        console.error(`❌ Failed to get HF model info for ${req.params.modelId}:`, error);
        res.status(500).json({
            success: false,
            error: error.message,
            modelId: req.params.modelId
        });
    }
});

// GET /api/hf-models/loaded
router.get('/loaded', (req, res) => {
    const loadedModels = Array.from(hfService.loadedModels);

    res.json({
        success: true,
        loadedModels,
        count: loadedModels.length,
        timestamp: new Date().toISOString()
    });
});

// DELETE /api/hf-models/unload/:modelId
router.delete('/unload/:modelId', async (req, res) => {
    try {
        const { modelId } = req.params;

        await hfService.unloadModel(modelId);

        res.json({
            success: true,
            message: `Model ${modelId} unloaded successfully`,
            modelId,
            timestamp: new Date().toISOString()
        });

    } catch (error) {
        console.error(`❌ Failed to unload HF model ${req.params.modelId}:`, error);
        res.status(500).json({
            success: false,
            error: error.message,
            modelId: req.params.modelId
        });
    }
});

module.exports = router;
```

#### **Client-Side Integration**
```javascript
// client/src/services/huggingFaceService.js
class HuggingFaceService {
    constructor(baseURL = '/api/hf-models') {
        this.baseURL = baseURL;
    }

    async loadModel(modelId, useAuth = false) {
        const response = await fetch(`${this.baseURL}/load/${modelId}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.getAuthToken()}`
            },
            body: JSON.stringify({ useAuth })
        });

        if (!response.ok) {
            throw new Error(`Failed to load model: ${response.status}`);
        }

        return await response.json();
    }

    async generateResponse(modelId, prompt, options = {}) {
        const response = await fetch(`${this.baseURL}/generate/${modelId}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.getAuthToken()}`
            },
            body: JSON.stringify({
                prompt,
                maxNewTokens: options.maxNewTokens || 512,
                temperature: options.temperature || 0.7,
                doSample: options.doSample !== false
            })
        });

        if (!response.ok) {
            throw new Error(`Generation failed: ${response.status}`);
        }

        const data = await response.json();
        return data.response;
    }

    async getModelInfo(modelId) {
        const response = await fetch(`${this.baseURL}/info/${modelId}`, {
            headers: {
                'Authorization': `Bearer ${this.getAuthToken()}`
            }
        });

        if (!response.ok) {
            throw new Error(`Failed to get model info: ${response.status}`);
        }

        const data = await response.json();
        return data.info;
    }

    async getLoadedModels() {
        const response = await fetch(`${this.baseURL}/loaded`, {
            headers: {
                'Authorization': `Bearer ${this.getAuthToken()}`
            }
        });

        if (!response.ok) {
            throw new Error(`Failed to get loaded models: ${response.status}`);
        }

        const data = await response.json();
        return data.loadedModels;
    }

    async unloadModel(modelId) {
        const response = await fetch(`${this.baseURL}/unload/${modelId}`, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${this.getAuthToken()}`
            }
        });

        if (!response.ok) {
            throw new Error(`Failed to unload model: ${response.status}`);
        }

        return await response.json();
    }

    getAuthToken() {
        return localStorage.getItem('auth_token');
    }
}

// React Hook for HF Models
import { useState, useCallback } from 'react';
import { HuggingFaceService } from '../services/huggingFaceService';

export const useHuggingFaceModel = (modelId) => {
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState(null);
    const [response, setResponse] = useState(null);

    const hfService = new HuggingFaceService();

    const generateResponse = useCallback(async (prompt, options = {}) => {
        setIsLoading(true);
        setError(null);

        try {
            // Ensure model is loaded
            if (!await hfService.isModelLoaded(modelId)) {
                await hfService.loadModel(modelId);
            }

            const result = await hfService.generateResponse(modelId, prompt, options);
            setResponse(result);
            return result;
        } catch (err) {
            setError(err.message);
            throw err;
        } finally {
            setIsLoading(false);
        }
    }, [modelId]);

    return {
        generateResponse,
        response,
        isLoading,
        error
    };
};
```

---

## Integration with Your Specific Models

### **alistairtennant/deep-agents Integration**

#### **Model Analysis**
Your `alistairtennant/deep-agents` model appears to be a specialized agent model. Based on the naming, this is likely a multi-agent or deep agent system.

```python
# Specific integration for deep-agents model
class DeepAgentsService(HuggingFaceModelService):
    def __init__(self):
        super().__init__()
        self.model_id = "alistairtennant/deep-agents"
        self.agent_types = [
            'construction_planner',
            'safety_inspector',
            'cost_estimator',
            'quality_controller',
            'project_manager'
        ]

    def load_deep_agents(self):
        """Load the deep agents model with agent-specific configuration"""
        return self.load_model(self.model_id, use_auth=True)

    def run_agent_task(self, agent_type: str, task: str, context: dict = None):
        """Run a specific agent task"""

        if agent_type not in self.agent_types:
            raise ValueError(f"Unknown agent type: {agent_type}")

        # Format prompt for agent-specific task
        prompt = self._format_agent_prompt(agent_type, task, context)

        # Generate response with agent-specific parameters
        agent_params = self._get_agent_params(agent_type)

        return self.generate_response(self.model_id, prompt, **agent_params)

    def _format_agent_prompt(self, agent_type, task, context):
        """Format prompt for specific agent type"""
        base_prompts = {
            'construction_planner': "You are an expert construction planner. Plan the following construction task:",
            'safety_inspector': "You are a certified safety inspector. Inspect the following for safety hazards:",
            'cost_estimator': "You are a professional cost estimator. Estimate costs for:",
            'quality_controller': "You are a quality control expert. Check quality for:",
            'project_manager': "You are an experienced project manager. Manage the following project aspect:"
        }

        prompt = base_prompts.get(agent_type, "You are an expert. Handle the following task:")
        prompt += f"\n\nTask: {task}"

        if context:
            prompt += f"\n\nContext: {json.dumps(context, indent=2)}"

        return prompt

    def _get_agent_params(self, agent_type):
        """Get generation parameters optimized for each agent type"""
        params = {
            'construction_planner': {
                'max_new_tokens': 1000,
                'temperature': 0.3,  # More deterministic for planning
                'do_sample': True
            },
            'safety_inspector': {
                'max_new_tokens': 800,
                'temperature': 0.1,  # Very deterministic for safety
                'do_sample': False
            },
            'cost_estimator': {
                'max_new_tokens': 600,
                'temperature': 0.2,  # Somewhat deterministic for costs
                'do_sample': True
            },
            'quality_controller': {
                'max_new_tokens': 700,
                'temperature': 0.1,  # Deterministic for quality checks
                'do_sample': False
            },
            'project_manager': {
                'max_new_tokens': 900,
                'temperature': 0.4,  # More creative for management
                'do_sample': True
            }
        }

        return params.get(agent_type, {
            'max_new_tokens': 512,
            'temperature': 0.7,
            'do_sample': True
        })

# Usage
deep_agents = DeepAgentsService()
deep_agents.load_deep_agents()

# Run different agent tasks
safety_report = deep_agents.run_agent_task(
    'safety_inspector',
    'Inspect the concrete pouring operation',
    {'site': 'Building A', 'workers': 5, 'equipment': ['concrete truck', 'vibrators']}
)

cost_estimate = deep_agents.run_agent_task(
    'cost_estimator',
    'Estimate electrical work for office building',
    {'area': '5000 sq ft', 'floors': 3, 'complexity': 'medium'}
)
```

#### **alistairtennant/construct-training-data Integration**

#### **Dataset Model Analysis**
Your `alistairtennant/construct-training-data` appears to be a dataset or training data model, possibly containing construction-specific training examples.

```python
# Integration for construct-training-data
class ConstructTrainingDataService(HuggingFaceModelService):
    def __init__(self):
        super().__init__()
        self.model_id = "alistairtennant/construct-training-data"

    def load_training_data(self):
        """Load the training data model"""
        return self.load_model(self.model_id, use_auth=True)

    def generate_training_example(self, category: str, difficulty: str = "medium"):
        """Generate training examples for specific categories"""

        category_prompts = {
            'safety': "Generate a realistic construction safety scenario and analysis:",
            'cost_estimation': "Create a detailed cost estimation example:",
            'project_planning': "Develop a project planning case study:",
            'quality_control': "Design a quality control inspection scenario:",
            'contract_management': "Create a contract management situation:"
        }

        difficulty_levels = {
            'easy': "Keep it straightforward with clear solutions.",
            'medium': "Include realistic complexity and multiple considerations.",
            'hard': "Make it challenging with conflicting requirements and edge cases."
        }

        prompt = category_prompts.get(category, "Generate a construction training example:")
        prompt += f"\n\nDifficulty Level: {difficulty_levels.get(difficulty, difficulty_levels['medium'])}"
        prompt += "\n\nProvide a complete training example with scenario, analysis, and learning points."

        return self.generate_response(
            self.model_id,
            prompt,
            max_new_tokens=1500,
            temperature=0.8,  # More creative for examples
            do_sample=True
        )

    def validate_training_example(self, example: str):
        """Validate a training example for quality and completeness"""

        validation_prompt = f"""Validate this construction training example for:
        - Realism and accuracy
        - Educational value
        - Completeness of information
        - Safety considerations
        - Practical applicability

        Example to validate:
        {example}

        Provide validation score (1-10) and specific feedback for improvements."""

        return self.generate_response(
            self.model_id,
            validation_prompt,
            max_new_tokens=800,
            temperature=0.3,  # More deterministic for validation
            do_sample=False
        )

    def generate_curriculum(self, discipline: str, level: str):
        """Generate a complete training curriculum for a discipline"""

        curriculum_prompt = f"""Create a comprehensive training curriculum for {discipline} at {level} level.

        Include:
        1. Learning objectives
        2. Module breakdown (8-12 modules)
        3. Practical exercises
        4. Assessment methods
        5. Required resources
        6. Safety considerations
        7. Industry standards alignment

        Make it detailed and immediately usable for training programs."""

        return self.generate_response(
            self.model_id,
            curriculum_prompt,
            max_new_tokens=2000,
            temperature=0.6,
            do_sample=True
        )

# Usage
training_service = ConstructTrainingDataService()
training_service.load_training_data()

# Generate training examples
safety_example = training_service.generate_training_example('safety', 'hard')
cost_example = training_service.generate_training_example('cost_estimation', 'medium')

# Validate examples
validation = training_service.validate_training_example(safety_example)

# Generate curriculum
safety_curriculum = training_service.generate_curriculum('construction_safety', 'advanced')
```

---

## Route Registration and API Setup

### **Add HF Model Routes to App**
```javascript
// server/src/routes/app.js - Add to routeFiles array
const routeFiles = [
  // ... existing routes ...
  'hf-model-routes.js',  // Add this line
  // ... more routes ...
];
```

### **Update Main App.js**
```javascript
// server/app.js - Add HF model routes
import hfModelRouter from "./src/routes/hf-model-routes.js";

// Add to API routes section
app.use('/api/hf-models', hfModelRouter);
```

---

## Testing and Validation

### **Integration Tests**
```javascript
// test/hf-model-integration.test.js
const HuggingFaceService = require('../src/services/hf-model-service');

describe('HuggingFace Model Integration', () => {
    let hfService;

    beforeAll(async () => {
        hfService = new HuggingFaceService();
    });

    test('should load alistairtennant/deep-agents model', async () => {
        const result = await hfService.loadModel('alistairtennant/deep-agents');
        expect(result.success).toBe(true);
    }, 60000); // 60 second timeout for model loading

    test('should generate response from deep-agents', async () => {
        const prompt = "You are a construction safety expert. Identify hazards in: Workers using ladders without fall protection.";
        const response = await hfService.generateResponse('alistairtennant/deep-agents', prompt);
        expect(response).toBeDefined();
        expect(response.length).toBeGreaterThan(0);
    }, 30000);

    test('should load construct-training-data model', async () => {
        const result = await hfService.loadModel('alistairtennant/construct-training-data');
        expect(result.success).toBe(true);
    }, 60000);

    test('should generate training example', async () => {
        const response = await hfService.generateResponse(
            'alistairtennant/construct-training-data',
            "Generate a safety training scenario for working at heights."
        );
        expect(response).toContain('scenario') || expect(response).toContain('safety');
    }, 30000);

    test('should handle model not found', async () => {
        await expect(hfService.loadModel('nonexistent/model')).rejects.toThrow();
    });

    test('should unload model successfully', async () => {
        await hfService.unloadModel('alistairtennant/deep-agents');
        // Verify model is unloaded
        const loadedModels = hfService.getLoadedModels();
        expect(loadedModels).not.toContain('alistairtennant/deep-agents');
    });
});
```

### **API Endpoint Tests**
```javascript
// test/hf-model-api.test.js
const request = require('supertest');
const app = require('../app');

describe('HF Model API Endpoints', () => {
    test('POST /api/hf-models/load/:modelId - should load model', async () => {
        const response = await request(app)
            .post('/api/hf-models/load/alistairtennant%2Fdeep-agents')
            .expect(200);

        expect(response.body.success).toBe(true);
        expect(response.body.modelId).toBe('alistairtennant/deep-agents');
    });

    test('POST /api/hf-models/generate/:modelId - should generate response', async () => {
        const response = await request(app)
            .post('/api/hf-models/generate/alistairtennant%2Fdeep-agents')
            .send({
                prompt: 'Test prompt for generation',
                maxNewTokens: 100
            })
            .expect(200);

        expect(response.body.success).toBe(true);
        expect(response.body.response).toBeDefined();
    });

    test('GET /api/hf-models/info/:modelId - should get model info', async () => {
        const response = await request(app)
            .get('/api/hf-models/info/alistairtennant%2Fdeep-agents')
            .expect(200);

        expect(response.body.success).toBe(true);
        expect(response.body.info).toBeDefined();
    });

    test('GET /api/hf-models/loaded - should list loaded models', async () => {
        const response = await request(app)
            .get('/api/hf-models/loaded')
            .expect(200);

        expect(response.body.success).toBe(true);
        expect(Array.isArray(response.body.loadedModels)).toBe(true);
    });
});
```

---

## Performance Optimization

### **Memory Management**
```python
# Optimized loading for memory-constrained environments
def load_model_optimized(model_id: str, device: str = "cpu"):
    """Load model with memory optimizations"""

    # Use 8-bit quantization to reduce memory usage
    model = AutoModelForCausalLM.from_pretrained(
        model_id,
        load_in_8bit=True,  # Reduces memory by ~50%
        device_map={"": device},
        torch_dtype=torch.float16
    )

    # Use CPU offloading for large models
    if device == "cuda" and torch.cuda.is_available():
        model = model.to(device)

    return model

# Batch processing for multiple requests
def batch_generate(prompts: List[str], model, tokenizer, batch_size: int = 4):
    """Process multiple prompts efficiently"""

    results = []
    for i in range(0, len(prompts), batch_size):
        batch = prompts[i:i + batch_size]

        # Tokenize batch
        inputs = tokenizer(batch, return_tensors="pt", padding=True)
        if torch.cuda.is_available():
            inputs = inputs.to("cuda")

        with torch.no_grad():
            outputs = model.generate(**inputs, max_new_tokens=200)

        batch_results = tokenizer.batch_decode(outputs, skip_special_tokens=True)
        results.extend(batch_results)

    return results
```

### **Caching Strategies**
```javascript
// Response caching for repeated queries
const NodeCache = require('node-cache');
const cache = new NodeCache({ stdTTL: 3600 }); // 1 hour TTL

class CachedHFService extends HuggingFaceModelService {
    async generateResponse(modelId, prompt, options = {}) {
        const cacheKey = `${modelId}:${prompt}:${JSON.stringify(options)}`;

        // Check cache first
        const cached = cache.get(cacheKey);
        if (cached) {
            return cached;
        }

        // Generate new response
        const response = await super.generateResponse(modelId, prompt, options);

        // Cache the result
        cache.set(cacheKey, response);

        return response;
    }
}
```

---

## Monitoring and Analytics

### **Usage Tracking**
```javascript
// server/src/middleware/hf-model-tracking.js
const fs = require('fs').promises;
const path = require('path');

class HFModelTracker {
    constructor(logPath = './logs/hf-model-usage.json') {
        this.logPath = logPath;
        this.usageStats = {
            total_requests: 0,
            model_usage: {},
            response_times: [],
            errors: [],
            last_updated: new Date().toISOString()
        };
    }

    async trackRequest(modelId, prompt, response, responseTime, error = null) {
        this.usageStats.total_requests++;

        // Track model usage
        if (!this.usageStats.model_usage[modelId]) {
            this.usageStats.model_usage[modelId] = 0;
        }
        this.usageStats.model_usage[modelId]++;

        // Track response times
        this.usageStats.response_times.push(responseTime);

        // Keep only last 1000 response times
        if (this.usageStats.response_times.length > 1000) {
            this.usageStats.response_times = this.usageStats.response_times.slice(-1000);
        }

        // Track errors
        if (error) {
            this.usageStats.errors.push({
                model_id: modelId,
                error: error.message,
                timestamp: new Date().toISOString()
            });

            // Keep only last 100 errors
            if (this.usageStats.errors.length > 100) {
                this.usageStats.errors = this.usageStats.errors.slice(-100);
            }
        }

        this.usageStats.last_updated = new Date().toISOString();

        // Save to file
        await this.saveStats();
    }

    async saveStats() {
        try {
            await fs.writeFile(this.logPath, JSON.stringify(this.usageStats, null, 2));
        } catch (error) {
            console.error('Failed to save usage stats:', error);
        }
    }

    getStats() {
        const avgResponseTime = this.usageStats.response_times.length > 0
            ? this.usageStats.response_times.reduce((a, b) => a + b, 0) / this.usageStats.response_times.length
            : 0;

        return {
            ...this.usageStats,
            average_response_time: avgResponseTime,
            error_rate: this.usageStats.total_requests > 0
                ? (this.usageStats.errors.length / this.usageStats.total_requests) * 100
                : 0
        };
    }
}

// Middleware for tracking
const hfTracker = new HFModelTracker();

const trackHFUsage = (req, res, next) => {
    const startTime = Date.now();

    // Override res.json to track after response
    const originalJson = res.json;
    res.json = function(data) {
        const responseTime = Date.now() - startTime;
        const modelId = req.params.modelId;
        const error = data.success === false ? data : null;

        hfTracker.trackRequest(modelId, req.body?.prompt, data.response, responseTime, error);

        return originalJson.call(this, data);
    };

    next();
};

module.exports = { HFModelTracker, trackHFUsage };
```

---

## Security Considerations

### **API Key Management**
```javascript
// Secure HF token storage
const HF_TOKENS = {
    read: process.env.HF_READ_TOKEN,    // For public models
    write: process.env.HF_WRITE_TOKEN,  // For private models
};

// Use appropriate token based on operation
const useAuth = modelId.includes('alistairtennant'); // Your private models
const token = useAuth ? HF_TOKENS.write : HF_TOKENS.read;
```

### **Rate Limiting**
```javascript
// Rate limiting for HF API calls
const rateLimit = require('express-rate-limit');

const hfRateLimit = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100, // limit each IP to 100 requests per windowMs
    message: 'Too many requests to HF models, please try again later.'
});

app.use('/api/hf-models', hfRateLimit);
```

---

## Deployment and Production

### **Environment Setup**
```bash
# Install dependencies
pip install transformers torch huggingface-hub
npm install --save child_process

# Set environment variables
export HF_READ_TOKEN=your_read_token
export HF_WRITE_TOKEN=your_write_token
export NODE_ENV=production
```

### **Docker Configuration**
```dockerfile
# Dockerfile for HF model service
FROM node:18-alpine

# Install Python and dependencies
RUN apk add --no-cache python3 py3-pip
RUN pip install transformers torch huggingface-hub

# Copy application
COPY . /app
WORKDIR /app

# Expose port
EXPOSE 3000

# Start application
CMD ["npm", "start"]
```

### **Health Checks**
```javascript
// Health check endpoint
app.get('/health/hf-models', async (req, res) => {
    try {
        const loadedModels = await hfService.getLoadedModels();
        const stats = hfTracker.getStats();

        const health = {
            status: loadedModels.length > 0 ? 'healthy' : 'degraded',
            loaded_models: loadedModels,
            usage_stats: stats,
            timestamp: new Date().toISOString()
        };

        res.json(health);
    } catch (error) {
        res.status(503).json({
            status: 'unhealthy',
            error: error.message,
            timestamp: new Date().toISOString()
        });
    }
});
```

---

## Summary

This procedure provides comprehensive guidance for integrating your specific HuggingFace models:

### **Your Models Integration:**
- **`alistairtennant/deep-agents`**: Specialized multi-agent system for construction tasks
- **`alistairtennant/construct-training-data`**: Training data and curriculum generation

### **Key Integration Points:**
1. **Direct Python Service**: `hf_model_service.py` for core functionality
2. **Node.js API Layer**: Express routes for web integration
3. **Client Services**: React hooks and service classes
4. **Testing Framework**: Comprehensive unit and integration tests
5. **Monitoring**: Usage tracking and performance analytics

### **Next Steps:**
1. Run the compatibility check scripts on your models
2. Set up the Python service with proper authentication
3. Add the routes to your Express application
4. Test the integration with your specific use cases
5. Deploy with proper monitoring and rate limiting

The integration provides seamless access to your specialized models while maintaining the performance and reliability of your existing ConstructAI system.