---
memory_layer: durable_knowledge
para_section: pages/codebase/guides
gigabrain_tags: guides, codebase, documentation
documentation
openstinger_context: development-guides, implementation-guidance
last_updated: 2026-03-21
related_docs:
  - codebase/guides/
  - disciplines/
---
# 🚀 Continual Learning Workflow Debugging & Testing Guide

## Quick Status Check
✅ **Workflow YAML**: Valid syntax and structure
✅ **Script Dependencies**: All referenced scripts exist
✅ **Job Configuration**: Proper dependencies and matrix setup

## 🎯 Expedited Debugging Strategy

### **Phase 1: Pre-Flight Checks (5 minutes)**

#### **1.1 Environment Setup**
```bash
# Check secrets are configured in GitHub
# Required secrets:
# - SUPABASE_SERVICE_ROLE_KEY
# - SUPABASE_URL
# - RUNPOD_SERVERLESS_URL
# - RUNPOD_API_KEY
# - HUGGINGFACE_API_TOKEN
# - SLACK_WEBHOOK_URL (optional)
```

#### **1.2 Local Validation**
```bash
# Run workflow validator
python3 validate_workflow.py

# Check script permissions
ls -la scripts/
chmod +x scripts/*.py scripts/*.js 2>/dev/null || true
```

### **Phase 2: Controlled Testing (15 minutes)**

#### **2.1 Manual Workflow Trigger**
```yaml
# In GitHub Actions tab, click "Run workflow"
# Use these test parameters:
force_training: true  # Force training even with no data
```

#### **2.2 Monitor First Job: `check-training-data`**
**Expected Output:**
```
📊 Training data count: 0 (or actual count)
🎯 Average quality score: 0.5 (or actual score)
✅ Force training enabled for testing
has_sufficient_data=true
data_quality_score=0.5
```

**Common Issues:**
- ❌ `No module named 'commander'` → Install npm dependencies
- ❌ Supabase connection failed → Check secrets configuration
- ❌ Quality score parsing error → Review data format

#### **2.3 Monitor Second Job: `runpod-training`**
**Expected Behavior:**
- Downloads training data from Supabase
- Calls RunPod serverless endpoint
- Receives job ID confirmation

**Debug Commands:**
```bash
# Check RunPod endpoint directly (replace with actual values)
curl -X POST YOUR_RUNPOD_URL \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"input": {"test": "data"}}'
```

### **Phase 3: Matrix Job Testing (30 minutes)**

#### **3.1 Test Single Specialist First**
**Modify workflow temporarily:**
```yaml
matrix:
  specialist: [civil_engineering]  # Test one specialist only
```

**Expected Per-Specialist Flow:**
1. Transform simulation data → training data
2. Prepare specialist-specific dataset
3. Upload to RunPod for training
4. Validate trained model
5. Register in model registry
6. Activate for production use

#### **3.2 Monitor Training Logs**
**Key Indicators of Success:**
```
✅ Simulation data transformed and saved to database
📊 Training data for civil_engineering: X samples
🚀 Starting specialist model training...
✅ Training completed successfully
✅ Model validation passed
✅ Model activated successfully
```

### **Phase 4: Full Matrix Testing (60 minutes)**

#### **4.1 Enable All Specialists**
```yaml
matrix:
  specialist: [civil_engineering, structural_engineering, mechanical_engineering, electrical_engineering, geotechnical_engineering, safety_engineering, quantity_surveying, environmental_engineering, architectural_specialist, construction_specialist, logistics_specialist, process_engineering, instrumentation_engineering, inspection_specialist, health_safety_specialist, quality_control_specialist, scheduling_specialist]
```

#### **4.2 Parallel Execution Monitoring**
- **Max Parallel**: 5 concurrent training jobs
- **Fail-fast**: Disabled (continues on individual failures)
- **Expected Duration**: 45-90 minutes total

### **Phase 5: Production Readiness (30 minutes)**

#### **5.1 Final Validation**
```bash
# Run full verification suite
python3 run_qwen_verification_suite.py

# Check model registry
# Verify Hugging Face model updates
python3 scripts/verify_hf_model_update.py
```

#### **5.2 Monitoring Setup**
- Enable Slack notifications for failures
- Set up GitHub alerts for workflow status
- Configure production monitoring dashboards

---

## 🔍 Common Issues & Solutions

### **Issue 1: Missing Training Data**
**Symptoms:**
```
📊 Training data count: 0
⚠️ No correspondence training data exported
```

**Solutions:**
1. Check Supabase data: `correspondence_training_data` table
2. Run simulation manually: `node agents/simulation/correspondence-workflow-simulator.js`
3. Verify data quality threshold (currently 0.8)

### **Issue 2: RunPod Connection Failed**
**Symptoms:**
```
❌ RunPod API call failed with status: 401/403/500
```

**Solutions:**
1. Verify `RUNPOD_API_KEY` secret
2. Check `RUNPOD_SERVERLESS_URL` format
3. Test endpoint manually with curl

### **Issue 3: Script Permission Errors**
**Symptoms:**
```
Permission denied: scripts/train_correspondence_specialists.py
```

**Solutions:**
```bash
chmod +x scripts/*.py scripts/*.js
git add scripts/
git commit -m "Fix script permissions"
```

### **Issue 4: Python Dependencies Missing**
**Symptoms:**
```
ModuleNotFoundError: No module named 'transformers'
```

**Solutions:**
- Workflow installs dependencies automatically
- Check if installation step completed
- Verify Python version (3.9 required)

### **Issue 5: Matrix Job Failures**
**Symptoms:**
```
❌ Training failed for civil_engineering
❌ Model validation failed
```

**Solutions:**
1. Check individual job logs
2. Reduce matrix to single specialist for testing
3. Verify training data exists for that specialist
4. Check GPU availability on RunPod

---

## 📊 Monitoring & Alerting

### **GitHub Actions Monitoring**
- **Workflow Status**: Check Actions tab for real-time status
- **Job Logs**: Detailed logs for each step
- **Failure Notifications**: Automatic on workflow failure

### **Production Monitoring Setup**
```yaml
# Add to workflow for production
- name: Send success notification
  if: success()
  run: |
    curl -X POST ${{ secrets.SLACK_WEBHOOK_URL }} \
      -H 'Content-type: application/json' \
      -d '{"text":"✅ Continual Learning Pipeline Completed"}'
```

### **Key Metrics to Monitor**
- **Training Data Volume**: Should increase weekly
- **Model Performance**: Accuracy improvements over time
- **Training Duration**: Should be consistent (45-90 min)
- **Success Rate**: All specialists should complete successfully

---

## 🚀 Quick Recovery Actions

### **If Workflow Fails Completely:**
1. **Check Secrets**: Verify all required secrets are set
2. **Test Manually**: Run individual scripts locally
3. **Force Training**: Use `force_training: true` parameter
4. **Single Specialist**: Reduce matrix to one specialist

### **If Partial Matrix Failure:**
1. **Identify Failed Jobs**: Check individual specialist logs
2. **Fix Root Cause**: Address specific specialist issues
3. **Re-run Workflow**: Failed jobs won't re-run automatically
4. **Monitor Recovery**: Ensure subsequent runs succeed

### **If Data Pipeline Issues:**
1. **Check Supabase**: Verify training data exists
2. **Run Simulation**: Generate fresh training data
3. **Adjust Thresholds**: Lower quality requirements if needed
4. **Manual Data Export**: Test data export scripts

---

## 📋 Testing Checklist

### **Pre-Deployment Testing**
- [ ] Workflow YAML validation passes
- [ ] All script dependencies exist
- [ ] GitHub secrets configured
- [ ] Manual workflow trigger works
- [ ] Single specialist training succeeds
- [ ] Data pipeline functional

### **Production Deployment**
- [ ] Full matrix testing completed
- [ ] Monitoring and alerting configured
- [ ] Rollback procedures documented
- [ ] Success notifications enabled
- [ ] Performance baselines established

### **Post-Deployment Monitoring**
- [ ] First automated run (Sunday 2 AM UTC) monitored
- [ ] Weekly training cycles tracked
- [ ] Model performance improvements measured
- [ ] Failure recovery procedures tested

---

## 🎯 Success Criteria

### **Workflow Execution Success:**
- ✅ All jobs complete without critical errors
- ✅ Training data successfully processed
- ✅ Models trained and deployed to Hugging Face
- ✅ Model registry updated with new versions
- ✅ Notifications sent on completion/failure

### **Data Pipeline Success:**
- ✅ Training data extracted from Supabase
- ✅ Data quality meets thresholds
- ✅ Specialist-specific datasets created
- ✅ Data uploaded to training endpoints

### **Model Training Success:**
- ✅ All specialists trained successfully
- ✅ Validation passes for trained models
- ✅ Models registered and activated
- ✅ Performance metrics recorded

---

## 📞 Emergency Contacts & Support

### **Immediate Actions for Critical Failures:**
1. **Stop Auto-Scheduling**: Comment out cron trigger
2. **Manual Testing**: Use workflow_dispatch with force_training=true
3. **Isolate Issues**: Test individual components separately
4. **Document Findings**: Log all errors and attempted fixes

### **Support Resources:**
- **GitHub Actions Docs**: https://docs.github.com/en/actions
- **RunPod Documentation**: Check API documentation
- **Supabase Status**: https://status.supabase.com
- **Hugging Face Status**: https://status.huggingface.co

---

**🎯 Bottom Line**: The workflow structure is solid. Focus on data availability, API connectivity, and individual specialist training. Start with forced training and single specialist testing, then scale up to full matrix execution.