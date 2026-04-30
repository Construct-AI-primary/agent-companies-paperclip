---
name: skill-validation-remediation
description: >
  Use when validating agent skills against task requirements, identifying skill gaps,
  performing remediation planning, or ensuring agent-company alignment. Covers
  skill assessment, gap analysis, remediation strategies, and alignment verification.
company: promptforge-ai
---

# Skill Validation and Remediation

## Overview

This skill provides comprehensive guidance for validating agent skills against task requirements and identifying/remediating skill gaps. It ensures agents have the required capabilities to successfully execute assigned tasks and maintains alignment between agent skills and company requirements.

## When to Use This Skill

- Validating agent skills against task requirements
- Identifying skill gaps in agent capabilities
- Planning remediation strategies for skill deficiencies
- Ensuring agent-company alignment
- Performing skill assessments for new agents
- Auditing agent skill coverage
- Validating skill updates and changes
- Cross-referencing skills with company standards

## Validation Framework

### Step 1: Requirement Analysis

```javascript
// Analyze task requirements
const requirementAnalysis = {
  requiredSkills: extractRequiredSkills(task),
  skillLevels: assessSkillLevelRequirements(task),
  domainExpertise: identifyDomainExpertise(task),
  toolRequirements: extractToolRequirements(task),
  certificationRequirements: identifyCertifications(task)
};
```

### Step 2: Agent Skill Assessment

```javascript
// Assess agent capabilities
const agentAssessment = {
  currentSkills: getAgentSkills(agent),
  skillProficiency: assessSkillProficiency(agent),
  experienceLevel: getExperienceLevel(agent),
  certifications: getAgentCertifications(agent),
  toolProficiency: assessToolProficiency(agent)
};
```

### Step 3: Gap Analysis

```javascript
// Identify skill gaps
const gapAnalysis = {
  missingSkills: findMissingSkills(requirementAnalysis, agentAssessment),
  proficiencyGaps: findProficiencyGaps(requirementAnalysis, agentAssessment),
  certificationGaps: findCertificationGaps(requirementAnalysis, agentAssessment),
  toolGaps: findToolGaps(requirementAnalysis, agentAssessment)
};
```

### Step 4: Remediation Planning

```javascript
// Create remediation plan
const remediationPlan = {
  immediateActions: [],
  shortTermActions: [],
  longTermActions: [],
  resourceRequirements: calculateResourceRequirements(gapAnalysis),
  timeline: estimateRemediationTimeline(gapAnalysis),
  priorityActions: prioritizeActions(gapAnalysis)
};
```

## Skill Assessment Matrix

### Skill Coverage Assessment

| Category | Coverage Score | Status | Action |
|----------|---------------|--------|--------|
| Core Skills | 100% | ✅ Complete | Monitor |
| Domain Skills | 80% | ⚠️ Partial | Fill gaps |
| Tool Proficiency | 60% | ⚠️ Partial | Train |
| Certifications | 40% | ❌ Gap | Certify |
| Specialized Skills | 20% | ❌ Gap | Develop |

### Proficiency Levels

| Level | Score Range | Description | Training Time |
|-------|-------------|-------------|---------------|
| Expert | 90-100% | Mastery, can teach others | N/A |
| Advanced | 75-89% | Deep knowledge, complex tasks | 2-4 weeks |
| Intermediate | 60-74% | Working knowledge, standard tasks | 4-8 weeks |
| Basic | 40-59% | Foundational, supervised tasks | 8-12 weeks |
| Novice | 0-39% | Limited, needs training | 12+ weeks |

## Gap Analysis Procedures

### Missing Skill Detection

```javascript
// Detect missing skills
function detectMissingSkills(required, available) {
  const missing = [];
  
  for (const skill of required) {
    if (!available.includes(skill)) {
      const criticality = assessSkillCriticality(skill);
      missing.push({
        skill,
        criticality,
        remediationPriority: criticality === 'high' ? 'immediate' : 'scheduled'
      });
    }
  }
  
  return missing.sort((a, b) => 
    getPriorityWeight(a.remediationPriority) - getPriorityWeight(b.remediationPriority)
  );
}
```

### Proficiency Gap Analysis

```javascript
// Analyze proficiency gaps
function analyzeProficiencyGaps(requirements, agentSkills) {
  const gaps = [];
  
  for (const [skill, requiredLevel] of Object.entries(requirements)) {
    const agentLevel = agentSkills[skill]?.level || 0;
    
    if (agentLevel < requiredLevel) {
      const gapSize = requiredLevel - agentLevel;
      gaps.push({
        skill,
        required: requiredLevel,
        current: agentLevel,
        gap: gapSize,
        trainingRequired: estimateTrainingTime(skill, gapSize)
      });
    }
  }
  
  return gaps;
}
```

## Remediation Strategies

### Strategy 1: Immediate Training

For critical skill gaps affecting current tasks:

```javascript
const immediateTraining = {
  trigger: 'critical_gap_on_assigned_task',
  duration: '1-3 days',
  format: 'accelerated_bootcamp',
  resources: ['training_materials', 'mentor', 'practice_environment'],
  validation: 'practical_assessment'
};
```

### Strategy 2: Cross-Training

For medium-term skill diversification:

```javascript
const crossTraining = {
  trigger: 'skill_extension_needed',
  duration: '2-4 weeks',
  format: 'structured_training_program',
  resources: ['course_materials', 'hands_on_projects', 'peer_learning'],
  validation: 'competency_demonstration'
};
```

### Strategy 3: Certification Program

For specialized skill requirements:

```javascript
const certificationProgram = {
  trigger: 'certification_required',
  duration: '4-12 weeks',
  format: 'formal_certification_track',
  resources: ['official_training', 'study_materials', 'exam_prep'],
  validation: 'certification_exam'
};
```

### Strategy 4: Skill Acquisition

For entirely new skill domains:

```javascript
const skillAcquisition = {
  trigger: 'new_capability_needed',
  duration: '1-3 months',
  format: 'comprehensive_development_program',
  resources: ['structured_curriculum', 'project_assignment', 'expert_mentorship'],
  validation: 'portfolio_demonstration'
};
```

## Agent-Company Alignment

### Alignment Checkpoints

1. **Onboarding**: Validate skills match role requirements
2. **Task Assignment**: Verify skills align with task requirements
3. **Performance Review**: Assess skill application effectiveness
4. **Career Development**: Plan skill growth trajectory
5. **Company Evolution**: Update skills as company needs change

### Alignment Verification

```javascript
// Verify agent-company alignment
function verifyAlignment(agent, company) {
  const alignment = {
    roleAlignment: checkRoleAlignment(agent, company),
    teamAlignment: checkTeamAlignment(agent, company),
    skillAlignment: checkSkillAlignment(agent, company),
    valueAlignment: checkValueAlignment(agent, company)
  };
  
  const overallScore = calculateOverallAlignmentScore(alignment);
  
  return {
    isAligned: overallScore >= 0.8,
    score: overallScore,
    gaps: identifyAlignmentGaps(alignment),
    recommendations: generateAlignmentRecommendations(alignment)
  };
}
```

## Validation Workflows

### Workflow 1: Pre-Assignment Validation

```javascript
async function validateForAssignment(agent, task) {
  // 1. Extract requirements
  const requirements = extractTaskRequirements(task);
  
  // 2. Assess agent skills
  const skills = getAgentSkillProfile(agent);
  
  // 3. Run gap analysis
  const gaps = runGapAnalysis(requirements, skills);
  
  // 4. Determine fit score
  const fitScore = calculateFitScore(gaps);
  
  if (fitScore >= 0.8) {
    return { eligible: true, fitScore, gaps };
  }
  
  // 5. Generate remediation plan if not eligible
  const remediation = generateRemediationPlan(gaps);
  return { eligible: false, fitScore, gaps, remediation };
}
```

### Workflow 2: Skill Audit

```javascript
async function performSkillAudit(companyId) {
  // 1. Get all agents
  const agents = await getCompanyAgents(companyId);
  
  // 2. Get company requirements
  const requirements = await getCompanyRequirements(companyId);
  
  // 3. Audit each agent
  const auditResults = [];
  for (const agent of agents) {
    const result = await auditAgentSkills(agent, requirements);
    auditResults.push(result);
  }
  
  // 4. Generate summary report
  return generateAuditReport(auditResults);
}
```

### Workflow 3: Remediation Tracking

```javascript
async function trackRemediation(agentId, plan) {
  // 1. Create remediation tasks
  const tasks = createRemediationTasks(plan);
  
  // 2. Track progress
  for (const task of tasks) {
    await assignTask(agentId, task);
    await trackProgress(task);
    
    if (task.completed) {
      await validateSkillGained(agentId, task.skill);
    }
  }
  
  // 3. Update agent profile
  await updateAgentSkills(agentId, plan.completedSkills);
}
```

## Success Metrics

- **Gap Identification Rate**: 100% of skill gaps identified
- **Remediation Success Rate**: 90%+ of remediation plans successful
- **Assignment Validation Accuracy**: 95%+ correct eligibility determinations
- **Time to Competency**: 20% faster than baseline training
- **Agent Satisfaction**: >4.5/5 satisfaction with development support

## Related Skills

- `paperclip-api-integration` - API operations for skill management
- `issue-routing-and-assignment` - Task assignment validation
- `capacity-planning` - Resource planning for remediation
- `knowledge-capture` - Capturing learned skills
- `continuous-improvement` - Ongoing skill optimization

## Best Practices

1. **Validate before assignment** - Never assign without skill verification
2. **Document all gaps** - Maintain comprehensive gap records
3. **Prioritize critical skills** - Address high-impact gaps first
4. **Track remediation progress** - Monitor development closely
5. **Validate before deployment** - Confirm skill acquisition
6. **Update agent profiles** - Keep skill records current
7. **Share learnings** - Document remediation lessons
8. **Continuous monitoring** - Regular skill audits