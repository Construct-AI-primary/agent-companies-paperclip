---
memory_layer: durable_knowledge
para_section: pages/model-assignment-framework-procedure
gigabrain_tags: procedures, agents, model-assignment, capability-mapping, glm-models
openstinger_context: model-assignment-procedure
last_updated: 2026-04-19
---

# Generic Model Assignment Framework Procedure

## Overview

This procedure provides a standardized approach for implementing the Intelligent Model Assignment Framework across Paperclip companies. The framework replaces inefficient bulk skill assignments with intelligent, capability-based GLM model and skill assignments.

## Problem Solved

### Before (Inefficient System)
- ❌ 10,306 meaningless skill assignments created simultaneously
- ❌ Random GLM model assignments without reasoning
- ❌ No capability-based intelligence
- ❌ Manual maintenance overhead

### After (Intelligent System)
- ✅ 646 targeted capability-based skill assignments
- ✅ GLM models assigned based on agent capabilities
- ✅ Automated pattern matching and assignment
- ✅ Cost optimization through appropriate model selection

## Prerequisites

### Required Files
- `scripts/agent-model-framework/skill-capability-mapping.yaml` - Configuration file
- `scripts/agent-model-framework/capability-mapping-engine.py` - Analysis engine
- `scripts/agent-model-framework/migration-engine.py` - Migration system
- `scripts/agent-model-framework/restore-skill-assignments.py` - Skill restoration

### Required Permissions
- Database write access for agent and skill tables
- File system access to scripts directory
- Company administrator privileges

### Environment Setup
- Python 3.8+ with required dependencies
- Access to Paperclip database
- GLM model API keys configured

## Procedure Steps

### Step 1: Framework Preparation

#### 1.1 Verify Framework Components
```bash
# Check that all required files exist
ls -la scripts/agent-model-framework/
ls -la docs-paperclip/procedures/agents/model-assignment-framework/
```

**Expected Output:**
- All Python scripts present
- Configuration YAML file exists
- Documentation files available

#### 1.2 Validate Configuration
```bash
# Review capability mapping configuration
cat scripts/agent-model-framework/skill-capability-mapping.yaml
```

**Validation Checklist:**
- [ ] GLM model assignments defined
- [ ] Capability categories configured
- [ ] Temperature ranges specified
- [ ] Pattern matching rules present

#### 1.3 Backup Current State
```bash
# Create backup of current agent assignments
python3 scripts/agent-model-framework/backup-current-assignments.py
```

**Backup includes:**
- Current agent_models table state
- Current agent_skill_assignments table state
- Timestamped backup files

### Step 2: Capability Analysis

#### 2.1 Run Capability Analysis
```bash
# Analyze all agents and map to capabilities
python3 scripts/agent-model-framework/capability-mapping-engine.py
```

**Analysis Process:**
- Scans all active agents (414 expected)
- Analyzes agent roles, titles, and descriptions
- Maps agents to 13 capability categories
- Generates capability mapping report

#### 2.2 Review Analysis Results
```bash
# Check the generated analysis report
cat scripts/agent-model-framework/analysis-results-$(date +%Y%m%d).md
```

**Review Criteria:**
- [ ] All agents successfully categorized
- [ ] Capability distribution reasonable
- [ ] No agents left unmapped
- [ ] GLM model assignments appropriate

#### 2.3 Validate Capability Distribution

Expected distribution across categories:
- Strategic & Leadership: 88 agents
- Technical Development: 72 agents
- Specialized Roles: 49 agents
- Support & Coordination: 14 agents

### Step 3: Model Assignment Migration

#### 3.1 Execute Model Migration
```bash
# Migrate GLM model assignments
python3 scripts/agent-model-framework/migration-engine.py
```

**Migration Process:**
- Updates agent_models table
- Applies GLM-3-Turbo, GLM-4-Plus, GLM-5.1 assignments
- Optimizes temperature settings
- Applies company-specific overrides

#### 3.2 Verify Model Assignments
```bash
# Check model assignment results
python3 scripts/agent-model-framework/verify-model-assignments.py
```

**Verification Checks:**
- [ ] All agents have GLM model assignments
- [ ] Model distribution matches expectations
- [ ] Temperature settings appropriate
- [ ] No duplicate assignments

### Step 4: Skill Assignment Restoration

#### 4.1 Generate Skill Assignments
```bash
# Restore capability-based skill assignments
python3 scripts/agent-model-framework/restore-skill-assignments.py
```

**Skill Assignment Process:**
- Creates 646 targeted skill assignments
- Maps capabilities to specific skills
- Removes meaningless bulk assignments
- Applies intelligent skill matching

#### 4.2 Validate Skill Assignments
```bash
# Verify skill assignment quality
python3 scripts/agent-model-framework/analyze-skill-assignments.py
```

**Validation Metrics:**
- [ ] Total assignments: 646 (not 10,306)
- [ ] Skills per agent: ~1.6 average
- [ ] Capability categories: 13 (not 241)
- [ ] Assignment quality score > 90%

### Step 5: System Validation

#### 5.1 Run Integration Tests
```bash
# Test agent functionality with new assignments
python3 scripts/agent-model-framework/integration-test.py
```

**Test Coverage:**
- [ ] Agent initialization works
- [ ] Model selection functions
- [ ] Skill-based routing works
- [ ] API calls successful

#### 5.2 Performance Validation
```bash
# Check system performance metrics
python3 scripts/agent-model-framework/performance-validation.py
```

**Performance Checks:**
- [ ] Response times within acceptable ranges
- [ ] Memory usage stable
- [ ] API rate limits not exceeded
- [ ] Cost optimization achieved

#### 5.3 Cost Analysis
```bash
# Analyze cost savings
python3 scripts/agent-model-framework/cost-analysis.py
```

**Expected Results:**
- Cost savings: ~$87/month
- Model distribution optimized
- Appropriate model selection verified

### Step 6: Documentation and Reporting

#### 6.1 Generate Implementation Report
```bash
# Create comprehensive implementation report
python3 scripts/agent-model-framework/generate-report.py
```

**Report Contents:**
- Pre/post implementation metrics
- Capability mapping results
- Cost analysis summary
- Performance benchmarks

#### 6.2 Update Documentation
```bash
# Update framework documentation with results
cp scripts/agent-model-framework/MIGRATION_RESULTS.md \
   docs-paperclip/procedures/agents/model-assignment-framework/
```

**Documentation Updates:**
- [ ] Success metrics documented
- [ ] Configuration examples updated
- [ ] Troubleshooting guides enhanced

#### 6.3 Create Rollback Plan
```bash
# Generate rollback procedures
python3 scripts/agent-model-framework/create-rollback-plan.py
```

**Rollback Components:**
- Database restoration scripts
- Configuration rollback commands
- Validation checkpoints

## Success Criteria

### Quantitative Metrics
- ✅ **Assignment Reduction**: 10,306 → 646 assignments (93% reduction)
- ✅ **Skill Categories**: 241 → 13 categories (95% reduction)
- ✅ **Cost Savings**: $87/month minimum savings
- ✅ **Assignment Quality**: >90% capability match accuracy

### Qualitative Metrics
- ✅ **System Stability**: No agent initialization failures
- ✅ **Performance**: Response times maintained or improved
- ✅ **User Experience**: Agent behavior more predictable
- ✅ **Maintainability**: Framework easily configurable

## Error Handling and Recovery

### Common Issues and Solutions

#### Issue: Capability Mapping Fails
**Symptoms:** Agents not categorized, analysis incomplete
**Solution:**
```bash
# Debug capability mapping
python3 scripts/agent-model-framework/debug-mapping.py
# Check agent data quality
python3 scripts/agent-model-framework/validate-agent-data.py
```

#### Issue: Model Assignment Conflicts
**Symptoms:** Duplicate assignments, invalid model selections
**Solution:**
```bash
# Clean conflicting assignments
python3 scripts/agent-model-framework/clean-conflicts.py
# Re-run migration with conflict resolution
python3 scripts/agent-model-framework/migration-engine.py --resolve-conflicts
```

#### Issue: Skill Assignment Errors
**Symptoms:** Missing skills, invalid skill references
**Solution:**
```bash
# Validate skill definitions
python3 scripts/agent-model-framework/validate-skills.py
# Restore from backup if needed
python3 scripts/agent-model-framework/rollback-skill-assignments.py
```

### Emergency Rollback Procedure

#### Immediate Rollback
```bash
# Stop all agent processing
python3 scripts/agent-model-framework/emergency-stop.py

# Restore from backup
python3 scripts/agent-model-framework/emergency-rollback.py

# Restart with original assignments
python3 scripts/agent-model-framework/restart-original.py
```

#### Partial Rollback Options
- Rollback only model assignments
- Rollback only skill assignments
- Selective rollback by company/agent

## Maintenance and Updates

### Regular Maintenance Tasks

#### Monthly Review
```bash
# Monthly capability analysis
python3 scripts/agent-model-framework/monthly-review.py
```

#### Quarterly Updates
```bash
# Update capability mappings
python3 scripts/agent-model-framework/quarterly-update.py
```

#### Annual Optimization
```bash
# Full system optimization
python3 scripts/agent-model-framework/annual-optimization.py
```

### Configuration Updates

#### Adding New Capabilities
1. Edit `skill-capability-mapping.yaml`
2. Add new capability definition
3. Test with subset of agents
4. Deploy incrementally

#### Updating Model Assignments
1. Review GLM model performance
2. Update model mappings in configuration
3. Run migration with new assignments
4. Monitor performance impact

## Monitoring and Alerting

### Key Metrics to Monitor

#### Daily Metrics
- Agent initialization success rate
- Model selection performance
- API call success rates

#### Weekly Metrics
- Cost analysis reports
- Performance benchmarks
- Error rate trends

#### Monthly Metrics
- Capability distribution changes
- Assignment quality scores
- User satisfaction feedback

### Alert Conditions

#### Critical Alerts
- Agent initialization failure rate > 5%
- Model assignment errors > 1%
- System performance degradation > 10%

#### Warning Alerts
- Capability mapping accuracy < 90%
- Cost optimization below target
- Configuration drift detected

## Training and Knowledge Transfer

### Required Training

#### For System Administrators
- Framework operation procedures
- Configuration management
- Troubleshooting common issues
- Emergency response procedures

#### For Company Managers
- Understanding capability categories
- Interpreting performance metrics
- Requesting configuration changes
- Escalation procedures

### Knowledge Base Updates

#### Documentation Updates
- [ ] Update runbooks with new procedures
- [ ] Create troubleshooting guides
- [ ] Document configuration options
- [ ] Maintain change history

#### Training Materials
- [ ] Create video tutorials
- [ ] Develop quick reference guides
- [ ] Build interactive training modules

---

## Implementation Checklist

### Pre-Implementation
- [ ] Framework components verified
- [ ] Configuration validated
- [ ] Backup created
- [ ] Team trained

### During Implementation
- [ ] Capability analysis completed
- [ ] Model migration successful
- [ ] Skill assignments restored
- [ ] System validation passed

### Post-Implementation
- [ ] Documentation updated
- [ ] Monitoring configured
- [ ] Training completed
- [ ] Rollback procedures tested

## Contact Information

**Framework Owners:**
- Primary: Model Assignment Framework Team
- Secondary: Paperclip Platform Engineering

**Emergency Contacts:**
- 24/7: Platform Operations Center
- Business Hours: Company System Administrators

**Documentation Location:**
- Code: `scripts/agent-model-framework/`
- Docs: `docs-paperclip/procedures/agents/model-assignment-framework/`

---

**Procedure Version:** 1.0
**Effective Date:** 2026-04-19
**Review Date:** 2026-10-19
**Approval Required:** Company System Administrator