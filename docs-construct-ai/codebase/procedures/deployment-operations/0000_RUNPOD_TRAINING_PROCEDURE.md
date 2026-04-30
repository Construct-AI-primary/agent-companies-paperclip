---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/deployment-operations
gigabrain_tags: procedures, deployment-operations, codebase
documentation
openstinger_context: operational-procedures, deployment-operations-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# 0000_RUNPOD_TRAINING_PROCEDURE.md - RunPod Training Procedure

## Document Information

- **Document ID**: `0000_RUNPOD_TRAINING_PROCEDURE`
- **Version**: 1.0
- **Created**: 2026-01-24
- **Last Updated**: 2026-01-24
- **Author**: AI Assistant (Construct AI)
- **Review Cycle**: Quarterly
- **Classification**: Technical Training Procedure
- **Related Documents**:
  - `0000_QWEN_FINETUNING_PROCEDURE.md` - Model fine-tuning basics
  - `0000_HF_MODEL_INTEGRATION_PROCEDURE.md` - Model deployment and integration
  - `0000_LORA_ADAPTER_INTEGRATION_PROCEDURE.md` - Adapter integration

---

## Executive Summary

This procedure provides comprehensive guidance for executing AI model training on RunPod infrastructure. It covers both Pod and Serverless deployment options, integrates with the existing QWEN fine-tuning and LoRA adapter procedures, and supports seamless integration with the ConstructAI training pipeline ecosystem.

**Use Cases**:
- Local model fine-tuning for specialized construction workflows
- Large-scale training with GPU acceleration
- Continuous learning pipeline execution
- Cost-optimized training deployment

**Key Success Factors**:
- Proper environment verification (see `0000_QWEN_FINETUNING_PROCEDURE.md`)
- Optimal GPU resource selection
- LoRA adapter training methodology
- Automated HuggingFace integration (see `0000_HF_MODEL_INTEGRATION_PROCEDURE.md`)

---

## Pod vs Serverless Selection

### **Pod Deployment (Recommended for Training)**

#### **When to Use:**
- Full control over training environment
- Interactive debugging and monitoring
- Long-running training sessions
- Custom environment requirements

#### **Advantages:**
- SSH access for direct control
- Real-time training progress monitoring
- Persistent storage across sessions
- Cost-effective for continuous use

### **Serverless Deployment**

#### **When to Use:**
- One-off training tasks
- API-based training triggers
- Automated pipeline integration
- Cost optimization for sporadic usage

#### **Advantages:**
- Pay-per-use billing
- Auto-scaling based on demand
- No infrastructure management
- Integration with existing APIs

---

## Prerequisites and Environment Setup

## **Prerequisites Checklist**

- [ ] **Account & Access**: RunPod account with billing enabled
- [ ] **Environment Verification**: Complete `0000_QWEN_FINETUNING_PROCEDURE.md` Phase 6 verification suite
- [ ] **Training Data**: Prepared dataset (see `0000_QWEN_FINETUNING_PROCEDURE.md` Phase 4)
- [ ] **Model Selection**: Choose base model (QWEN/Qwen2.5-7B-Instruct recommended)
- [ ] **HuggingFace Setup**: API tokens configured (see `0000_HF_MODEL_INTEGRATION_PROCEDURE.md`)
- [ ] **Repository Access**: Push access to target HuggingFace repository

---

## Procedure Phases

### **Phase 1: Pod Deployment Setup**

#### **Step 1.1: Resource Selection**
```yaml
# Recommended configurations for different model sizes:

# QWEN 7B Training (Recommended)
gpu: RTX_4090 (24GB VRAM)
vCPU: 8 cores
RAM: 32GB
Storage: 100GB NVMe
Container: RunPod Pytorch 2.1

# QWEN 3B Training (Cost Optimized)
gpu: RTX_3090 (24GB VRAM)
vCPU: 6 cores
RAM: 24GB
Storage: 100GB NVMe

# Multi-Model Training (High Performance)
gpu: A6000 (48GB VRAM)
vCPU: 12 cores
RAM: 64GB
Storage: 200GB NVMe
```

#### **Step 1.2: Pod Launch**
1. Access [runpod.io](https://runpod.io) ’ **"Pods"** tab
2. Click **"Deploy"**
3. Select **template**: `RunPod Pytorch 2.1`
4. Configure **GPU type and resources** as above
5. Set **pod name**: `construct-ai-training-{timestamp}`
6. Click **"Deploy Pod"**
7. Wait for **"Running"** status (2-5 minutes)

#### **Step 1.3: Environment Verification**
Execute the verification suite from `0000_QWEN_FINETUNING_PROCEDURE.md`:

```bash
# Connect to pod via SSH or JupyterLab
# Run verification suite
python run_qwen_verification_suite.py

# Expected output:
#  Environment ready for QWEN fine-tuning
#  QWEN model loading verification PASSED
#  Dataset preparation verification PASSED
#  LoRA adapter verification PASSED
#  Training pipeline verification PASSED
```

### **Phase 2: Training Execution**

#### **Step 2.1: Repository Setup**
```bash
# Clone project repository
git clone https://github.com/Construct-AI-primary/construct_ai.git
cd construct_ai

# Set environment variables
export HUGGINGFACE_API_TOKEN="your_hf_token"
export HUGGINGFACE_MODEL_REPO="alistairtennant/deep-agents"
export WANDB_API_KEY="optional_wandb_key"  # For logging

# Make training script executable
chmod +x runpod_correspondence_training.sh
```

#### **Step 2.2: Execute Training**
Choose one of the training methods:

**Option A: Automated Script (Recommended)**
```bash
# Run complete training pipeline
./runpod_correspondence_training.sh

# Real-time monitoring with logs showing:
# - Environment verification
# - Dataset preparation
# - Model loading progress
# - Training epochs and loss
# - Validation metrics
# - HuggingFace upload status
```

**Option B: Manual Training Execution**
```bash
# 1. Verify training data exists
ls -la models/training-data/
head models/training-data/correspondence_workflow_training_data.json

# 2. Execute training with manual parameters
python scripts/runpod_correspondence_training.py \
    --data-path models/training-data/correspondence_workflow_training_data.json \
    --output-dir models/trained-models/correspondence_workflow \
    --model-name Qwen/Qwen2.5-7B-Instruct \
    --epochs 3 \
    --batch-size 2 \
    --learning-rate 2e-4 \
    --lora-r 16 \
    --lora-alpha 16 \
    --max-length 512
```

#### **Step 2.3: Training Parameters**
Based on `0000_QWEN_FINETUNING_PROCEDURE.md` Phase 5:

```yaml
# Correspondence Workflow Training Configuration
model:
  base_model: "Qwen/Qwen2.5-7B-Instruct"
  quantization: "4bit"
  lora_config:
    r: 16
    alpha: 16
    dropout: 0.05
    target_modules: ["q_proj", "k_proj", "v_proj", "o_proj"]

training:
  epochs: 3
  batch_size: 2
  gradient_accumulation: 4
  learning_rate: 2e-4
  max_length: 512
  warmup_steps: 100
  save_steps: 500

data:
  train_split: 0.9
  quality_threshold: 0.8
  preprocessing_batch_size: 1000
```

### **Phase 3: Monitoring and Optimization**

#### **Step 3.1: Real-time Monitoring**
```bash
# Monitor GPU usage
watch -n 1 nvidia-smi

# Monitor training progress
tail -f models/trained-models/correspondence_workflow/training.log

# Check memory usage
htop  # Or nvtop for GPU-specific monitoring
```

#### **Step 3.2: Performance Optimization**
Based on observed metrics, adjust parameters:

```python
# Dynamic batch size adjustment based on memory
def optimize_batch_size():
    gpu_memory = get_gpu_memory_gb()
    if gpu_memory > 20:
        return 4  # Larger batch for high-end GPUs
    elif gpu_memory > 10:
        return 2  # Standard batch
    else:
        return 1  # Memory-constrained

# Learning rate scheduling
def get_learning_rate(epoch, base_lr=2e-4):
    if epoch < 1:
        return base_lr * 0.1  # Warmup
    elif epoch < 2:
        return base_lr       # Peak learning
    else:
        return base_lr * 0.1 # Fine-tuning
```

#### **Step 3.3: Logging and Checkpoints**
```bash
# View training metrics
cat models/trained-models/correspondence_workflow/training_results.json

# Monitor checkpoint saves
ls -la models/trained-models/correspondence_workflow/checkpoints/

# Log analysis
python scripts/analyze_training_logs.py \
    --log-path models/trained-models/correspondence_workflow/training.log
```

### **Phase 4: Model Upload and Integration**

#### **Step 4.1: HuggingFace Upload**
Automatic upload is handled by the training script, but manual verification:

```bash
# Check model repository
curl -I https://huggingface.co/alistairtennant/deep-agents

# Verify upload completed
python scripts/verify_hf_model_update.py \
    --model-repo alistairtennant/deep-agents \
    --local-path models/trained-models/correspondence_workflow
```

#### **Step 4.2: Integration Testing**
Follow `0000_LORA_ADAPTER_INTEGRATION_PROCEDURE.md`:

```python
# Test adapter loading
from peft import PeftModel, PeftConfig
from transformers import AutoModelForCausalLM, AutoTokenizer

# Load base model
model = AutoModelForCausalLM.from_pretrained("Qwen/Qwen2.5-7B-Instruct")
tokenizer = AutoTokenizer.from_pretrained("Qwen/Qwen2.5-7B-Instruct")

# Load adapter
model = PeftModel.from_pretrained(model, "alistairtennant/deep-agents")

# Test inference
prompt = "Analyze this construction safety incident:"
inputs = tokenizer(prompt, return_tensors="pt")
outputs = model.generate(**inputs, max_new_tokens=100)
response = tokenizer.decode(outputs[0])
print(f"Adapter response: {response}")
```

### **Phase 5: Cost Management and Cleanup**

#### **Step 5.1: Cost Monitoring**
```bash
# Track pod costs in real-time
# RunPod dashboard shows current session costs

# Calculate cost efficiency
training_cost = pod_cost_per_hour * training_duration_hours
model_improvement_value = baseline_accuracy * improvement_percentage
roi = model_improvement_value / training_cost

print(f"Training Cost: ${training_cost:.2f}")
print(f"Model Value: ${model_improvement_value:.2f}")
print(f"ROI: {roi:.2f}x")
```

#### **Step 5.2: Resource Cleanup**
```bash
# Save final model locally
cp -r models/trained-models/correspondence_workflow /workspace/final_model_backup/

# Clean up temporary files
rm -rf models/trained-models/correspondence_workflow/checkpoints/
rm -rf models/trained-models/correspondence_workflow/tmp/

# Stop pod (don't terminate if keeping for future use)
# In RunPod dashboard: Pod ’ Stop (keeps disk, charges storage only)
```

---

## Training Pipeline UI Integration

### **ConstructAI Training Dashboard**

Access the training pipeline at: `https://construct-ai.onrender.com/#/information-technology/training-pipeline`

#### **Monitor Active Training Jobs**
```javascript
// Training pipeline integration
const trainingService = {
    // Submit training job
    async submitTrainingJob(config) {
        const response = await fetch('/api/training-pipeline/jobs', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                type: 'fine_tuning',
                provider: 'runpod',
                model: config.model_id,
                dataset: config.dataset_id,
                parameters: config.training_params,
                pod_config: {
                    gpu: config.gpu_type,
                    storage: config.storage_gb,
                    container: config.container_image
                }
            })
        });
        return await response.json();
    },

    // Monitor job progress
    async getJobStatus(jobId) {
        const response = await fetch(`/api/training-pipeline/jobs/${jobId}`);
        return await response.json();
    },

    // Get cost analysis
    async getCostAnalysis(jobId) {
        const response = await fetch(`/api/training-pipeline/jobs/${jobId}/costs`);
        return await response.json();
    }
};
```

#### **Dashboard Features**
- **Real-time Training Metrics**: Loss curves, GPU utilization, throughput
- **Cost Tracking**: Live cost calculation with predictions
- **Model Comparison**: Before/after performance benchmarking
- **Log Viewer**: Streaming training logs with filtering
- **Resource Monitoring**: GPU memory, CPU usage, network I/O

---

## Troubleshooting Guide

### **Common Issues and Solutions**

#### **GPU Memory Errors**
```bash
# Reduce batch size
--batch-size 1

# Enable gradient checkpointing
--gradient-checkpointing true

# Use 8-bit quantization instead of 4-bit
--quantization 8bit
```

#### **Model Loading Failures**
```bash
# Check internet connectivity
curl -I https://huggingface.co/Qwen/Qwen2.5-7B-Instruct

# Clear cache and retry
rm -rf ~/.cache/huggingface/
```

#### **Training Instability**
```bash
# Adjust learning rate
--learning-rate 1e-4

# Enable gradient clipping
--max-grad-norm 1.0

# Use warmup steps
--warmup-steps 200
```

#### **HuggingFace Upload Issues**
```bash
# Verify token permissions
python -c "
from huggingface_hub import HfApi
api = HfApi(token='your_token')
api.whoami()
"

# Check repository access
curl -H "Authorization: Bearer your_token" \
     https://huggingface.co/api/repos/alistairtennant/deep-agents
```

---

## Advanced Configuration Options

### **Multi-GPU Training**
```python
# For A6000 pod with multiple GPUs
from accelerate import Accelerator

accelerator = Accelerator()
model, optimizer, train_dataloader = accelerator.prepare(
    model, optimizer, train_dataloader
)

# Training loop with accelerator
for epoch in range(num_epochs):
    for batch in train_dataloader:
        with accelerator.accumulate(model):
            outputs = model(**batch)
            loss = outputs.loss
            accelerator.backward(loss)
            optimizer.step()
            optimizer.zero_grad()
```

### **Custom Loss Functions**
```python
# Domain-specific loss for construction tasks
def construction_loss(outputs, targets):
    """Custom loss emphasizing safety and compliance terms"""
    base_loss = F.cross_entropy(outputs.logits, targets)

    # Bonus for correct safety terminology
    safety_bonus = detect_safety_terms(outputs) * 0.1

    # Penalty for hallucinations
    confidence_penalty = calculate_confidence_penalty(outputs) * 0.05

    return base_loss - safety_bonus + confidence_penalty
```

---

## Cost Optimization Strategies

### **Spot Instance Usage**
```yaml
# Use spot pricing for cost savings
spot_pricing:
  enabled: true
  max_bid_price: 0.8  # 80% of on-demand price
  interruption_policy: persist  # Resume training on interruption

# Schedule training during off-peak hours
scheduling:
  timezone: "America/New_York"
  preferred_hours: "02:00-06:00"  # Overnight training
  max_daily_cost_budget: 50  # USD
```

---

## Integration with ConstructAI Ecosystem

### **Training Pipeline API**
```javascript
// Integration with existing training pipeline
const trainingPipeline = {
    baseURL: 'https://construct-ai.onrender.com/api/training',

    // Submit RunPod training job
    async submitRunPodJob(config) {
        const webhook = `${this.baseURL}/webhooks/runpod-training`;

        return await fetch(`${this.baseURL}/jobs`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${getAuthToken()}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                provider: 'runpod',
                type: 'fine_tuning',
                model: 'Qwen/Qwen2.5-7B-Instruct',
                adapter_config: {
                    r: 16,
                    alpha: 16,
                    target_modules: ['q_proj', 'k_proj', 'v_proj', 'o_proj']
                },
                training_config: config,
                webhooks: {
                    completed: webhook,
                    failed: webhook
                }
            })
        });
    },

    // Get training analytics
    async getTrainingAnalytics(jobId) {
        return await fetch(`${this.baseURL}/jobs/${jobId}/analytics`);
    },

    // Export trained model
    async exportModel(jobId, targetRepo) {
        return await fetch(`${this.baseURL}/jobs/${jobId}/export`, {
            method: 'POST',
            body: JSON.stringify({
                platform: 'huggingface',
                repository: targetRepo,
                include_adapter: true
            })
        });
    }
};
```

---

## Summary and Next Steps

### **Key Achievements**
- **Verified Environment**: All prerequisites met via QWEN verification suite
- **Optimized Training**: LoRA fine-tuning with 16x compression ratio
- **Automated Deployment**: Seamless HuggingFace integration
- **Cost Control**: Budget management and optimization strategies

### **Integration Points**
1. **QWen Procedure**: Environment verification and training methodology
2. **HF Integration**: Model upload and deployment automation
3. **Training Pipeline**: UI monitoring and job management
4. **LoRA Adapters**: Efficient model specialization

### **Ongoing Operations**
- **Monitor Usage**: Track costs and performance metrics
- **Continuous Improvement**: Update procedures based on training results
- **Version Control**: Maintain training lineage and reproducibility
- **Knowledge Transfer**: Document lessons learned for team scaling

---

**Procedure Status**: =â **PRODUCTION READY**

**Last Validation**: 2026-01-24

**Next Review**: 2026-04-24 (Quarterly)
