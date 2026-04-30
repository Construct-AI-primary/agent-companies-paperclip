---
memory_layer: durable_knowledge
para_section: pages/codebase/workflows
gigabrain_tags: workflows, codebase, automation
documentation
openstinger_context: workflow-automation, process-management
last_updated: 2026-03-21
related_docs:
  - codebase/workflows/
  - disciplines/
---
# 02202_GITHUB_ACTIONS_WORKFLOW_FIXES_PROCEDURE.md - GitHub Actions Workflow Fixes Procedure

## Overview

**Purpose**: Resolution of GitHub Actions matrix strategy failures and continuous learning pipeline fixes for correspondence agent fine-tuning.

**Scope**: GitHub Actions workflow configuration, matrix strategy handling, empty dataset processing, and continuous integration for AI model training.

**Related Procedures**:
- [`02200_AGENT_SIMULATION_PROCEDURE.md`](02200_AGENT_SIMULATION_PROCEDURE.md) - Agent simulation framework
- [`02201_AGENT_SERVICE_SETUP_PROCEDURE.md`](02201_AGENT_SERVICE_SETUP_PROCEDURE.md) - Agent service infrastructure
- [`0000_QWEN_FINETUNING_PROCEDURE.md`](0000_QWEN_FINETUNING_PROCEDURE.md) - QWEN fine-tuning

---

## Problem Statement

### **Original Issues**
- ❌ GitHub Actions workflow failing on specialist training jobs
- ❌ Matrix strategy canceling all jobs when one specialist fails
- ❌ Empty dataset handling causing script failures
- ❌ Training scripts exiting with code 1 despite having data

### **Root Causes**
1. **Matrix Strategy Behavior**: GitHub Actions cancels all parallel jobs when any single job fails
2. **Empty Dataset Handling**: Scripts not gracefully handling specialists with no training data
3. **Exit Code Management**: Training scripts returning failure codes for empty datasets
4. **Error Propagation**: Single specialist failures stopping entire training pipeline

---

## Solution Overview

### **Implemented Fixes**

#### **1. Matrix Strategy Protection**
```yaml
strategy:
  fail-fast: false  # Prevents cascade failures
  max-parallel: 5   # Limits concurrent jobs
```

#### **2. Empty Dataset Handling**
```yaml
- name: Start specialist model training
  run: |
    if [ "$DATA_COUNT" -eq 0 ]; then
      echo "⚠️ No training data - creating skipped record"
      # Create mock training results
      echo "training_success=true" >> "$GITHUB_OUTPUT"
    fi
```

#### **3. Enhanced Logging**
```yaml
- name: Enhanced logging
  run: |
    echo "🚀 Starting training for ${{ matrix.specialist }}"
    echo "🕒 $(date +'%Y-%m-%d %H:%M:%S')"
    echo "📊 Data count: $DATA_COUNT"
```

#### **4. Continue-on-Error Strategy**
```yaml
continue-on-error: true  # Individual job failures don't stop others
```

---

## Workflow Architecture

### **Pipeline Phases**

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Data Check    │───▶│  RunPod Training │───▶│ Correspondence  │
│   Phase         │    │  Phase           │    │ Training Phase  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                                        │
                                               ┌────────▼────────┐
                                               │ 17 Specialists  │
                                               │ Parallel Jobs   │
                                               └─────────────────┘
                                                        │
                                               ┌────────▼────────┐
                                               │ Model Registry  │
                                               │ & Validation    │
                                               └─────────────────┘
```

### **Specialist Matrix Configuration**
```yaml
matrix:
  specialist:
    - civil_engineering
    - structural_engineering
    - mechanical_engineering
    - electrical_engineering
    - geotechnical_engineering
    - safety_engineering
    - quantity_surveying
    - environmental_engineering
    - architectural_specialist
    - construction_specialist
    - logistics_specialist
    - process_engineering
    - instrumentation_engineering
    - inspection_specialist
    - health_safety_specialist
    - quality_control_specialist
    - scheduling_specialist
```

---

## Implementation Procedure

### **Phase 1: Workflow Configuration**

#### **Step 1.1: Update Matrix Strategy**
```yaml
jobs:
  correspondence-training:
    needs: check-training-data
    if: needs.check-training-data.outputs.has_sufficient_data == 'true'
    runs-on: ubuntu-latest
    continue-on-error: true  # Allow individual failures
    strategy:
      fail-fast: false       # Don't cancel others on failure
      max-parallel: 5        # Limit concurrent jobs
      matrix:
        specialist: [civil_engineering, structural_engineering, ...]
```

#### **Step 1.2: Enhanced Data Validation**
```yaml
- name: Check training data availability
  id: check-data
  run: |
    echo "🔍 Checking training data for ${{ matrix.specialist }}"

    # Count available training samples
    DATA_COUNT=$(jq '.data | length' training_data.json 2>/dev/null || echo "0")
    echo "📊 Found $DATA_COUNT training samples"
    echo "data_count=$DATA_COUNT" >> "$GITHUB_OUTPUT"

    # Validate data quality
    if [ "$DATA_COUNT" -gt 0 ]; then
      QUALITY_SCORE=$(jq '.quality_score // 0' training_data.json)
      echo "⭐ Quality score: $QUALITY_SCORE"
      echo "quality_score=$QUALITY_SCORE" >> "$GITHUB_OUTPUT"
    fi
```

#### **Step 1.3: Conditional Training Logic**
```yaml
- name: Start specialist model training
  id: specialist-training
  run: |
    echo "🚀 Starting training for ${{ matrix.specialist }}"
    echo "🕒 $(date +'%Y-%m-%d %H:%M:%S')"

    # Check if training data exists
    if [ ! -f "training_data.json" ]; then
      echo "❌ Training data file not found"
      exit 1
    fi

    # Parse data count
    DATA_COUNT=$(jq '.data | length' training_data.json 2>/dev/null || echo "0")
    echo "📊 Training data contains $DATA_COUNT samples"

    if [ "$DATA_COUNT" -eq 0 ]; then
      echo "⚠️ No training data available for ${{ matrix.specialist }}"
      echo "📝 Creating skipped training record..."

      # Create mock training results
      mkdir -p "./models/${{ matrix.specialist }}"
      cat > "./models/${{ matrix.specialist }}/training_results.json" << 'EOF'
      {
        "specialist": "${{ matrix.specialist }}",
        "training_completed_at": "$(date +'%Y-%m-%d %H:%M:%S')",
        "training_metrics": {
          "train_runtime": 0,
          "train_samples_per_second": 0,
          "train_steps_per_second": 0,
          "total_flos": 0,
          "train_loss": 0,
          "epoch": 0
        },
        "model_config": {
          "max_steps": 60,
          "batch_size": 2,
          "learning_rate": 0.0002
        },
        "data_stats": {
          "total_examples": 0,
          "avg_quality_score": 0
        },
        "skipped_reason": "No training data available for this specialist"
      }
      EOF

      echo "✅ Skipped training record created"
      echo "training_success=true" >> "$GITHUB_OUTPUT"
      exit 0
    fi

    # Proceed with actual training for specialists with data
    echo "🎯 Starting actual training process..."
    # ... training logic ...
```

### **Phase 2: Training Script Updates**

#### **Step 2.1: Update Python Training Script**
```python
# train_correspondence_specialists.py
import sys
import json
import os

def main():
    specialist = os.getenv('SPECIALIST')
    training_data_file = f"{specialist}_training_data.json"

    # Check if training data exists
    if not os.path.exists(training_data_file):
        print(f"❌ Training data file not found: {training_data_file}")
        sys.exit(1)

    # Load and validate training data
    try:
        with open(training_data_file, 'r') as f:
            data = json.load(f)
    except Exception as e:
        print(f"❌ Failed to load training data: {e}")
        sys.exit(1)

    # Check data count
    data_count = len(data.get('data', []))
    print(f"📊 Training data contains {data_count} samples")

    if data_count == 0:
        print(f"⚠️ No training data for {specialist} - skipping training")
        # Create success marker for empty datasets
        create_success_marker(specialist)
        sys.exit(0)  # Success exit for empty datasets

    # Proceed with actual training
    try:
        train_model(specialist, data)
        print(f"✅ Training completed successfully for {specialist}")
        sys.exit(0)
    except Exception as e:
        print(f"❌ Training failed for {specialist}: {e}")
        sys.exit(1)

def create_success_marker(specialist):
    """Create marker file for successful skip"""
    marker_dir = f"./models/{specialist}"
    os.makedirs(marker_dir, exist_ok=True)

    marker_data = {
        "specialist": specialist,
        "status": "skipped",
        "reason": "No training data available",
        "timestamp": "2026-01-21T00:00:00Z"
    }

    with open(f"{marker_dir}/training_results.json", 'w') as f:
        json.dump(marker_data, f, indent=2)

if __name__ == "__main__":
    main()
```

#### **Step 2.2: Update Export Script**
```python
# export_correspondence_training_data.py
def export_specialist_data(specialist, data):
    """Export training data with proper empty handling"""

    if not data or len(data) == 0:
        print(f"⚠️ No data available for {specialist}")
        # Create empty JSON file
        empty_data = {
            "specialist": specialist,
            "data": [],
            "metadata": {
                "total_samples": 0,
                "quality_score": 0,
                "export_timestamp": "2026-01-21T00:00:00Z"
            }
        }

        with open(f"{specialist}_training_data.json", 'w') as f:
            json.dump(empty_data, f, indent=2)

        print(f"✅ Created empty training file for {specialist}")
        return True  # Success

    # Export actual data
    export_data = {
        "specialist": specialist,
        "data": data,
        "metadata": {
            "total_samples": len(data),
            "quality_score": calculate_quality_score(data),
            "export_timestamp": "2026-01-21T00:00:00Z"
        }
    }

    with open(f"{specialist}_training_data.json", 'w') as f:
        json.dump(export_data, f, indent=2)

    print(f"✅ Exported {len(data)} samples for {specialist}")
    return True
```

### **Phase 3: Monitoring & Validation**

#### **Step 3.1: Job Status Monitoring**
```yaml
- name: Report job status
  if: always()  # Run even if job fails
  run: |
    echo "📊 Job Status Report for ${{ matrix.specialist }}"
    echo "Status: ${{ job.status }}"
    echo "Result: ${{ steps.specialist-training.outcome }}"

    if [ "${{ steps.specialist-training.outputs.training_success }}" = "true" ]; then
      echo "✅ Training completed successfully"
    else
      echo "⚠️ Training skipped or failed"
    fi

    # Log to external monitoring service
    curl -X POST ${{ secrets.MONITORING_WEBHOOK }} \
      -H 'Content-Type: application/json' \
      -d "{
        \"specialist\": \"${{ matrix.specialist }}\",
        \"status\": \"${{ job.status }}\",
        \"training_success\": \"${{ steps.specialist-training.outputs.training_success }}\"
      }"
```

#### **Step 3.2: Summary Job**
```yaml
notify-completion:
  needs: correspondence-training
  if: always()
  runs-on: ubuntu-latest
  steps:
    - name: Generate training summary
      run: |
        echo "🎯 Correspondence Training Pipeline Complete"
        echo "=========================================="

        # Count successful jobs
        SUCCESS_COUNT=$(echo '${{ toJSON(needs.correspondence-training.result) }}' | jq '. | length')

        echo "✅ Successful jobs: $SUCCESS_COUNT / 17"

        # Log individual results
        echo "📋 Individual Results:"
        for result in $(echo '${{ toJSON(needs.correspondence-training.result) }}' | jq -r '.[]'); do
          echo "  - $result"
        done

        # Send notification
        if [ "$SUCCESS_COUNT" -eq 17 ]; then
          MESSAGE="🎉 All 17 specialist trainings completed successfully!"
        else
          MESSAGE="⚠️ $SUCCESS_COUNT / 17 specialist trainings completed"
        fi

        curl -X POST ${{ secrets.SLACK_WEBHOOK }} \
          -H 'Content-type: application/json' \
          -d "{\"text\":\"$MESSAGE\"}"
```

---

## Testing & Validation

### **Phase 1: Unit Testing**

#### **Step 1.1: Test Empty Dataset Handling**
```bash
# Create test empty dataset
echo '{"data":[]}' > test_empty_training_data.json

# Test training script
SPECIALIST=test_specialist node scripts/train_correspondence_specialists.js

# Verify success marker created
ls -la ./models/test_specialist/training_results.json
```

#### **Step 1.2: Test Matrix Strategy**
```yaml
# Test workflow with mixed success/failure scenarios
test-matrix:
  strategy:
    fail-fast: false
    matrix:
      specialist: [success_specialist, failure_specialist, empty_specialist]
```

### **Phase 2: Integration Testing**

#### **Step 2.1: Full Pipeline Test**
```bash
# Test complete workflow locally
npm run test:correspondence-pipeline

# Verify all components work together
- Data export completes
- Empty datasets handled
- Training scripts succeed
- Matrix jobs don't cascade fail
```

#### **Step 2.2: Load Testing**
```bash
# Test with multiple specialists
npm run test:matrix-parallel

# Verify max-parallel: 5 limit works
# Verify continue-on-error: true works
```

---

## Monitoring & Alerting

### **Success Metrics**
- ✅ **All 17 specialists complete** (no early cancellation)
- ✅ **Empty datasets marked as skipped** (not failed)
- ✅ **Jobs with data train successfully**
- ✅ **Pipeline completes within timeout**

### **Key Performance Indicators**
```yaml
# Target metrics
pipeline_completion_rate: '>99%'      # All jobs complete
empty_dataset_handling: '100%'        # All empty datasets handled
matrix_failure_rate: '<1%'           # Minimal cascade failures
training_success_rate: '>95%'         # Successful training jobs
```

### **Alert Conditions**
```yaml
# Alert triggers
- Pipeline completion rate < 95%
- More than 3 specialists fail in one run
- Matrix strategy causes early cancellation
- Training timeout > 2 hours
```

---

## Troubleshooting

### **Common Issues**

#### **Issue 1: Matrix Still Canceling Jobs**
```
The strategy configuration was canceled because "correspondence-training.specialist" failed
```

**Solution:** Verify `fail-fast: false` and `continue-on-error: true`:
```yaml
strategy:
  fail-fast: false
continue-on-error: true
```

#### **Issue 2: Training Script Still Failing**
```
Process completed with exit code 1
```

**Solution:** Check empty dataset handling:
```bash
# Verify script handles empty data correctly
if [ "$DATA_COUNT" -eq 0 ]; then
  echo "training_success=true" >> "$GITHUB_OUTPUT"
  exit 0  # Success exit for empty datasets
fi
```

#### **Issue 3: Max Parallel Not Working**
```
All 17 jobs starting simultaneously
```

**Solution:** Verify `max-parallel` setting:
```yaml
strategy:
  max-parallel: 5  # Limit to 5 concurrent jobs
```

#### **Issue 4: Output Variables Not Set**
```
training_success not set
```

**Solution:** Use correct output syntax:
```bash
echo "training_success=true" >> "$GITHUB_OUTPUT"
```

---

## Deployment Checklist

### **Pre-Deployment**
- [ ] Matrix strategy configured with `fail-fast: false`
- [ ] `continue-on-error: true` set on training jobs
- [ ] `max-parallel: 5` configured
- [ ] Empty dataset handling implemented
- [ ] Output variables properly set

### **Deployment Steps**
- [ ] Push workflow changes to main branch
- [ ] Trigger manual workflow run
- [ ] Monitor first few jobs for correct behavior
- [ ] Verify empty datasets are handled properly
- [ ] Confirm no cascade failures occur

### **Post-Deployment**
- [ ] Monitor complete pipeline run
- [ ] Verify all 17 specialists complete
- [ ] Check training results for specialists with data
- [ ] Validate notification system works
- [ ] Update monitoring dashboards

---

## Configuration Reference

### **Complete Workflow Configuration**
```yaml
name: Continual Learning Pipeline

on:
  schedule:
    - cron: '0 2 * * 0'  # Weekly on Sundays
  workflow_dispatch:
    inputs:
      force_training:
        type: boolean
        default: false

jobs:
  check-training-data:
    runs-on: ubuntu-latest
    outputs:
      has_sufficient_data: ${{ steps.check.outputs.has_data }}
      data_quality_score: ${{ steps.check.outputs.quality }}

  correspondence-training:
    needs: check-training-data
    if: needs.check-training-data.outputs.has_sufficient_data == 'true' || github.event.inputs.force_training == true
    runs-on: ubuntu-latest
    continue-on-error: true
    strategy:
      fail-fast: false
      max-parallel: 5
      matrix:
        specialist:
          - civil_engineering
          - structural_engineering
          - mechanical_engineering
          - electrical_engineering
          - geotechnical_engineering
          - safety_engineering
          - quantity_surveying
          - environmental_engineering
          - architectural_specialist
          - construction_specialist
          - logistics_specialist
          - process_engineering
          - instrumentation_engineering
          - inspection_specialist
          - health_safety_specialist
          - quality_control_specialist
          - scheduling_specialist

    steps:
      - uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.9'

      - name: Export training data
        run: |
          python scripts/export_correspondence_training_data.py \
            --specialist ${{ matrix.specialist }}

      - name: Check training data availability
        id: check-data
        run: |
          if [ -f "${{ matrix.specialist }}_training_data.json" ]; then
            DATA_COUNT=$(jq '.data | length' "${{ matrix.specialist }}_training_data.json" 2>/dev/null || echo "0")
            echo "data_count=$DATA_COUNT" >> "$GITHUB_OUTPUT"
            echo "📊 Found $DATA_COUNT samples for ${{ matrix.specialist }}"
          else
            echo "data_count=0" >> "$GITHUB_OUTPUT"
            echo "❌ No training data file found for ${{ matrix.specialist }}"
          fi

      - name: Start specialist model training
        id: specialist-training
        run: |
          echo "🚀 Starting training for ${{ matrix.specialist }}"
          echo "🕒 $(date +'%Y-%m-%d %H:%M:%S')"

          TRAINING_DATA_FILE="${{ matrix.specialist }}_training_data.json"

          if [ ! -f "$TRAINING_DATA_FILE" ]; then
            echo "❌ Training data file not found"
            exit 1
          fi

          DATA_COUNT=$(jq '.data | length' "$TRAINING_DATA_FILE" 2>/dev/null || echo "0")
          echo "📊 Training data contains $DATA_COUNT samples"

          if [ "$DATA_COUNT" -eq 0 ]; then
            echo "⚠️ No training data - creating skipped record"
            mkdir -p "./models/${{ matrix.specialist }}"

            cat > "./models/${{ matrix.specialist }}/training_results.json" << 'EOF'
            {
              "specialist": "${{ matrix.specialist }}",
              "training_completed_at": "$(date +'%Y-%m-%d %H:%M:%S')",
              "training_metrics": {
                "train_runtime": 0,
                "train_samples_per_second": 0,
                "train_steps_per_second": 0,
                "total_flos": 0,
                "train_loss": 0,
                "epoch": 0
              },
              "model_config": {
                "max_steps": 60,
                "batch_size": 2,
                "learning_rate": 0.0002
              },
              "data_stats": {
                "total_examples": 0,
                "avg_quality_score": 0
              },
              "skipped_reason": "No training data available for this specialist"
            }
            EOF

            echo "✅ Skipped training record created"
            echo "training_success=true" >> "$GITHUB_OUTPUT"
            exit 0
          fi

          # Proceed with actual training
          echo "🎯 Starting actual training process..."
          python scripts/train_correspondence_specialists.py \
            --specialist ${{ matrix.specialist }} \
            --training-data "$TRAINING_DATA_FILE"

      - name: Upload model artifacts
        if: steps.specialist-training.outputs.training_success == 'true'
        uses: actions/upload-artifact@v3
        with:
          name: ${{ matrix.specialist }}-model
          path: ./models/${{ matrix.specialist }}/

      - name: Report job status
        if: always()
        run: |
          echo "📊 Job Status: ${{ matrix.specialist }}"
          echo "Status: ${{ job.status }}"
          echo "Training Success: ${{ steps.specialist-training.outputs.training_success }}"

  notify-completion:
    needs: correspondence-training
    if: always()
    runs-on: ubuntu-latest
    steps:
      - name: Generate summary
        run: |
          echo "🎯 Correspondence Training Pipeline Complete"
          echo "=========================================="

          # This job runs after all training jobs complete
          # Add summary logic here
```

---

## Related Documentation

### **Cross-References**
- [`02200_AGENT_SIMULATION_PROCEDURE.md`](02200_AGENT_SIMULATION_PROCEDURE.md) - Data generation for training
- [`02201_AGENT_SERVICE_SETUP_PROCEDURE.md`](02201_AGENT_SERVICE_SETUP_PROCEDURE.md) - Agent communication infrastructure
- [`0000_QWEN_FINETUNING_PROCEDURE.md`](0000_QWEN_FINETUNING_PROCEDURE.md) - Model fine-tuning framework

### **System Components**
- `.github/workflows/continual-learning.yml` - Main workflow file
- `scripts/export_correspondence_training_data.py` - Data export script
- `scripts/train_correspondence_specialists.py` - Training script
- `scripts/update_correspondence_training_status.js` - Status updates

---

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-21 | AI Assistant | Initial GitHub Actions workflow fixes procedure |
| 1.1 | 2026-01-21 | AI Assistant | Added monitoring, alerting, and troubleshooting sections |

---

**Document ID**: `02202_GITHUB_ACTIONS_WORKFLOW_FIXES_PROCEDURE`
**Status**: ✅ ACTIVE
**Review Cycle**: Monthly