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

# 0000_MODEL_PERFORMANCE_MONITORING_PROCEDURE.md - Model Performance Monitoring Procedure

## Document Information

- **Document ID**: `02205_MODEL_PERFORMANCE_MONITORING_PROCEDURE`
- **Version**: 1.0
- **Created**: 2026-01-23
- **Last Updated**: 2026-01-23
- **Author**: AI Assistant (Construct AI)
- **Review Cycle**: Monthly
- **Classification**: Operational Monitoring Procedure
- **Related Documents**:
  - `02203_LORA_ADAPTER_INTEGRATION_PROCEDURE.md` - Model integration methods
  - `02200_AI_TRAINING_EXPANSION_PROCEDURE.md` - Training results
  - `docs/implementation/02200_UNIFIED_AI_TRAINING_IMPLEMENTATION_PLAN.md` - Architecture

---

## Overview

This procedure establishes operational practices for monitoring AI model performance in production, including A/B testing frameworks, model drift detection, and automated performance alerting. The goal is to maintain model accuracy and trigger retraining when performance degrades.

**Critical Operations**: Models must be monitored continuously to ensure they maintain accuracy as construction practices and data patterns evolve.

---

## Monitoring Architecture

### **Performance Metrics Hierarchy**
```
┌─────────────────────────────────────────────────────────────┐
│                    MODEL PERFORMANCE MONITORING             │
├─────────────────────────────────────────────────────────────┤
│  📊 Accuracy Metrics    📈 Usage Analytics    🚨 Alert System │
│  - Response Quality     - Query Patterns      - Drift Alerts │
│  - Consistency Scores   - User Satisfaction   - Quality Drops│
│  - Domain Relevance     - Response Times      - Error Spikes │
└─────────────────────┬───────────────────────────────────────┘
                      │
           ┌──────────▼──────────┐
           │   A/B TESTING       │
           │   FRAMEWORK         │
           ├─────────────────────┤
           │  ✅ Base vs Fine-   │
           │     tuned Models    │
           │  📊 Statistical     │
           │     Validation      │
           │  🎯 Performance     │
           │     Comparison      │
           └─────────────────────┘
```

### **Key Monitoring Components**
- **Accuracy Tracking**: Response quality and domain relevance
- **Usage Analytics**: Query patterns and user satisfaction
- **A/B Testing**: Statistical comparison of model variants
- **Drift Detection**: Automated identification of performance degradation
- **Alert System**: Proactive notifications and automated responses

---

## Daily Performance Monitoring

### **Morning Model Health Check (7:00 AM)**

#### **Step 1: Review Overnight Metrics**
```sql
-- Check model performance from last 24 hours
SELECT
  discipline,
  COUNT(*) as total_queries,
  AVG(accuracy_score) as avg_accuracy,
  AVG(response_time_ms) as avg_response_time,
  COUNT(CASE WHEN user_rating < 3 THEN 1 END) as poor_ratings,
  COUNT(CASE WHEN error_occurred = true THEN 1 END) as errors
FROM model_performance_logs
WHERE created_at >= CURRENT_TIMESTAMP - INTERVAL '24 hours'
GROUP BY discipline
ORDER BY avg_accuracy ASC;
```

#### **Step 2: Check for Performance Alerts**
```bash
# Automated alert check
python scripts/monitoring/check_performance_alerts.py \
  --timeframe 24h \
  --thresholds config/alert_thresholds.json

# Expected output:
# ✅ All models within acceptable ranges
# ⚠️  WARNING: safety model accuracy dropped 5%
# 🚨 ALERT: contracts model response time > 5s average
```

#### **Step 3: Review A/B Test Status**
```sql
-- Check active A/B tests
SELECT
  test_name,
  model_a, model_b,
  start_date,
  total_queries_a, total_queries_b,
  avg_accuracy_a, avg_accuracy_b,
  statistical_significance,
  estimated_completion_date
FROM ab_tests
WHERE status = 'active'
ORDER BY start_date DESC;
```

### **Real-time Performance Dashboard**

#### **Grafana Dashboard Setup**
```json
{
  "dashboard": {
    "title": "AI Model Performance Dashboard",
    "refresh": "30s",
    "panels": [
      {
        "title": "Model Accuracy by Discipline",
        "type": "bargauge",
        "targets": [
          {
            "query": "avg_over_time(model_accuracy{discipline=~\"$discipline\"}[24h])",
            "legend": "{{discipline}}"
          }
        ],
        "thresholds": [
          { "value": 85, "color": "red" },
          { "value": 90, "color": "yellow" },
          { "value": 95, "color": "green" }
        ]
      },
      {
        "title": "Response Time Trends",
        "type": "graph",
        "targets": [
          {
            "query": "rate(model_response_time_sum[5m]) / rate(model_response_time_count[5m])",
            "legend": "Average Response Time"
          }
        ]
      },
      {
        "title": "Model Drift Detection",
        "type": "table",
        "targets": [
          {
            "query": "model_drift_score > 0.1",
            "instant": true
          }
        ]
      }
    ]
  }
}
```

---

## A/B Testing Framework

### **A/B Test Setup Procedure**

#### **Step 1: Define Test Parameters**
```sql
-- Create A/B test configuration
INSERT INTO ab_tests (
  test_name,
  description,
  model_a,  -- Usually current production model
  model_b,  -- New/challenger model
  target_metric,
  minimum_sample_size,
  statistical_significance_threshold,
  test_duration_days
) VALUES (
  'safety_model_v2_improvement',
  'Testing improved safety model with additional training data',
  'safety_v1',  -- Current model
  'safety_v2',  -- Challenger model
  'accuracy',
  1000,  -- Minimum queries per variant
  0.95,  -- 95% confidence level
  14    -- 2 weeks
);
```

#### **Step 2: Configure Traffic Distribution**
```javascript
// A/B traffic routing configuration
const abTestConfig = {
  testId: 'safety_model_v2_improvement',
  trafficDistribution: {
    modelA: 70,  // 70% traffic to current model
    modelB: 30   // 30% traffic to challenger
  },
  userSegmentation: {
    // Route specific user types to ensure balance
    contractors: { modelA: 50, modelB: 50 },
    project_managers: { modelA: 70, modelB: 30 },
    random: { modelA: 70, modelB: 30 }
  }
};
```

#### **Step 3: Implement Test Routing**
```javascript
// Request routing with A/B logic
async function routeModelRequest(discipline, userId, query) {
  // Check if user is in active A/B test
  const activeTest = await getActiveTestForDiscipline(discipline);

  if (activeTest) {
    // Determine variant assignment
    const variant = await getUserVariant(userId, activeTest.testId);

    // Route to appropriate model
    const model = variant === 'A' ? activeTest.modelA : activeTest.modelB;

    // Log A/B test data
    await logABTestRequest(activeTest.testId, variant, userId, query);

    return await processWithModel(model, query);
  } else {
    // Use production model routing
    return await processWithProductionModel(discipline, query);
  }
}
```

### **A/B Test Monitoring**

#### **Real-time Test Analytics**
```sql
-- Monitor A/B test progress
SELECT
  test_name,
  model_a, model_b,
  queries_a, queries_b,
  accuracy_a, accuracy_b,
  (accuracy_b - accuracy_a) as accuracy_improvement,
  statistical_significance,
  CASE
    WHEN statistical_significance > 0.95 AND accuracy_b > accuracy_a THEN 'WINNER_B'
    WHEN statistical_significance > 0.95 AND accuracy_a > accuracy_b THEN 'WINNER_A'
    WHEN statistical_significance > 0.95 THEN 'INCONCLUSIVE_SIGNIFICANT'
    ELSE 'INCONCLUSIVE'
  END as test_status
FROM ab_test_results
WHERE test_name = 'safety_model_v2_improvement';
```

#### **Statistical Significance Calculation**
```python
import numpy as np
from scipy import stats

def calculate_ab_significance(metric_a, metric_b, sample_size_a, sample_size_b):
    """
    Calculate statistical significance for A/B test results
    """
    # Two-sample t-test
    t_stat, p_value = stats.ttest_ind_from_stats(
        mean1=metric_a, std1=np.std(metric_a), nobs1=sample_size_a,
        mean2=metric_b, std2=np.std(metric_b), nobs2=sample_size_b
    )

    # Effect size (Cohen's d)
    effect_size = (metric_b - metric_a) / np.sqrt(
        ((sample_size_a - 1) * np.var(metric_a) + (sample_size_b - 1) * np.var(metric_b)) /
        (sample_size_a + sample_size_b - 2)
    )

    return {
        'p_value': p_value,
        'significant': p_value < 0.05,
        'effect_size': effect_size,
        'confidence_level': 1 - p_value
    }
```

### **A/B Test Completion**

#### **Step 1: Analyze Final Results**
```bash
# Generate comprehensive A/B test report
python scripts/ab_testing/analyze_test_results.py \
  --test-id safety_model_v2_improvement \
  --output reports/ab_test_safety_v2_final.md

# Expected output:
# 📊 A/B Test Results: safety_model_v2_improvement
# ✅ Statistical Significance: 99.2% confidence
# 📈 Accuracy Improvement: +8.3%
# 🏆 Winner: Model B (safety_v2)
# 💡 Recommendation: Deploy Model B to production
```

#### **Step 2: Execute Test Conclusion**
```sql
-- Update test status and record results
UPDATE ab_tests
SET
  status = 'completed',
  end_date = CURRENT_TIMESTAMP,
  winner = 'model_b',
  final_accuracy_a = 87.3,
  final_accuracy_b = 94.6,
  statistical_significance = 0.992,
  conclusion = 'Model B shows significant improvement'
WHERE test_name = 'safety_model_v2_improvement';

-- Trigger production deployment if winner identified
INSERT INTO deployment_queue (model_name, environment, priority)
VALUES ('safety_v2', 'production', 'high');
```

---

## Model Drift Detection

### **Automated Drift Monitoring**

#### **Statistical Drift Detection**
```python
import pandas as pd
from scipy.stats import ks_2samp, chi2_contingency

class ModelDriftDetector:
    def __init__(self, baseline_window_days=30, current_window_hours=24):
        self.baseline_window = baseline_window_days
        self.current_window = current_window_hours

    def detect_accuracy_drift(self, discipline):
        """Detect if model accuracy has significantly changed"""
        # Get baseline accuracy (last 30 days)
        baseline_data = self.get_historical_accuracy(discipline, self.baseline_window)

        # Get current accuracy (last 24 hours)
        current_data = self.get_current_accuracy(discipline, self.current_window)

        # Kolmogorov-Smirnov test for distribution change
        ks_stat, p_value = ks_2samp(baseline_data, current_data)

        drift_detected = p_value < 0.05  # 95% confidence
        drift_magnitude = abs(np.mean(current_data) - np.mean(baseline_data))

        return {
            'drift_detected': drift_detected,
            'drift_magnitude': drift_magnitude,
            'p_value': p_value,
            'baseline_mean': np.mean(baseline_data),
            'current_mean': np.mean(current_data)
        }

    def detect_concept_drift(self, discipline):
        """Detect if query patterns have changed significantly"""
        # Analyze query topic distributions
        baseline_topics = self.get_topic_distribution(discipline, self.baseline_window)
        current_topics = self.get_topic_distribution(discipline, self.current_window)

        # Chi-square test for topic distribution change
        chi2, p_value, dof, expected = chi2_contingency([
            list(baseline_topics.values()),
            list(current_topics.values())
        ])

        return {
            'concept_drift': p_value < 0.05,
            'chi2_statistic': chi2,
            'p_value': p_value,
            'topic_changes': self.compare_topic_distributions(baseline_topics, current_topics)
        }
```

#### **Drift Alert System**
```javascript
// Automated drift monitoring and alerting
const driftMonitor = {
  checkInterval: 4 * 60 * 60 * 1000, // 4 hours
  alertThresholds: {
    accuracyDrift: 0.05,    // 5% accuracy drop
    conceptDrift: 0.10,     // 10% topic distribution change
    responseTimeIncrease: 2  // 2x response time increase
  },

  async monitorModels() {
    const disciplines = await this.getActiveDisciplines();

    for (const discipline of disciplines) {
      const driftResults = await this.detectDrift(discipline);

      if (this.shouldAlert(driftResults)) {
        await this.sendDriftAlert(discipline, driftResults);
        await this.triggerRetraining(discipline, driftResults);
      }
    }
  },

  shouldAlert(driftResults) {
    return driftResults.accuracyDrift.drift_detected ||
           driftResults.conceptDrift.concept_drift ||
           driftResults.performanceDegradation.response_time_increased;
  },

  async sendDriftAlert(discipline, driftResults) {
    const alertMessage = {
      subject: `🚨 Model Drift Alert: ${discipline}`,
      body: `
        Model drift detected for ${discipline} discipline:

        📊 Accuracy Drift: ${driftResults.accuracyDrift.drift_magnitude.toFixed(2)}%
        🧠 Concept Drift: ${driftResults.conceptDrift.p_value < 0.05 ? 'DETECTED' : 'NONE'}
        ⚡ Performance: Response time ${driftResults.performanceDegradation.increase_factor.toFixed(1)}x

        Automatic retraining has been triggered.
      `
    };

    await this.sendEmailAlert(alertMessage);
    await this.createIncidentTicket(discipline, driftResults);
  }
};

// Schedule monitoring
setInterval(() => driftMonitor.monitorModels(), driftMonitor.checkInterval);
```

### **Drift Response Procedures**

#### **Automatic Retraining Trigger**
```sql
-- Insert retraining request when drift detected
INSERT INTO retraining_queue (
  discipline,
  trigger_reason,
  drift_metrics,
  priority,
  target_accuracy_improvement
) VALUES (
  $discipline,
  'drift_detected',
  $drift_metrics_json,
  'high',
  0.05  -- 5% improvement target
);

-- Update model status
UPDATE model_registry
SET
  status = 'drift_detected',
  last_drift_detected = CURRENT_TIMESTAMP,
  retraining_scheduled = true
WHERE discipline = $discipline AND is_active = true;
```

#### **Manual Drift Investigation**
```bash
# Investigate drift causes
python scripts/drift_analysis/investigate_drift.py \
  --discipline contracts \
  --timeframe 7d \
  --output reports/drift_investigation_contracts.md

# Generate drift visualization
python scripts/drift_analysis/visualize_drift.py \
  --discipline contracts \
  --metrics accuracy,topics,response_time \
  --output charts/drift_contracts_dashboard.png
```

---

## User Satisfaction Monitoring

### **Feedback Collection System**

#### **Implicit Feedback Tracking**
```javascript
// Track user interactions for implicit feedback
class UserFeedbackTracker {
  async trackInteraction(userId, discipline, query, response, metadata) {
    const interaction = {
      userId,
      discipline,
      query,
      response,
      responseTime: metadata.responseTime,
      modelUsed: metadata.modelVersion,
      timestamp: new Date()
    };

    // Store interaction for analysis
    await this.storeInteraction(interaction);

    // Update user preference model
    await this.updateUserProfile(userId, interaction);
  }

  async collectExplicitFeedback(userId, interactionId, rating, comments) {
    await this.storeFeedback({
      userId,
      interactionId,
      rating,        // 1-5 scale
      comments,
      timestamp: new Date()
    });

    // Trigger quality analysis if rating is poor
    if (rating <= 2) {
      await this.analyzePoorFeedback(interactionId);
    }
  }
}
```

#### **Satisfaction Metrics Calculation**
```sql
-- Calculate user satisfaction metrics
WITH user_ratings AS (
  SELECT
    discipline,
    AVG(rating) as avg_rating,
    COUNT(*) as total_ratings,
    COUNT(CASE WHEN rating >= 4 THEN 1 END) as satisfied_users,
    COUNT(CASE WHEN rating <= 2 THEN 1 END) as dissatisfied_users
  FROM user_feedback
  WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
  GROUP BY discipline
),
usage_stats AS (
  SELECT
    discipline,
    COUNT(*) as total_queries,
    COUNT(DISTINCT user_id) as unique_users,
    AVG(response_time_ms) as avg_response_time
  FROM model_performance_logs
  WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
  GROUP BY discipline
)
SELECT
  u.discipline,
  u.avg_rating,
  u.satisfied_users::float / u.total_ratings * 100 as satisfaction_rate,
  us.total_queries,
  us.unique_users,
  us.avg_response_time
FROM user_ratings u
JOIN usage_stats us ON u.discipline = us.discipline
ORDER BY u.avg_rating DESC;
```

### **Feedback-Driven Improvements**

#### **Poor Performance Analysis**
```python
def analyze_poor_feedback(feedback_data):
    """Analyze patterns in poor feedback to identify improvement areas"""

    # Categorize poor feedback reasons
    categories = {
        'inaccurate': [],
        'irrelevant': [],
        'incomplete': [],
        'too_verbose': [],
        'technical_errors': []
    }

    for feedback in feedback_data:
        category = classify_feedback(feedback.comments)
        categories[category].append(feedback)

    # Generate improvement recommendations
    recommendations = []

    if len(categories['inaccurate']) > len(feedback_data) * 0.3:
        recommendations.append({
            'type': 'retraining',
            'discipline': feedback_data[0]['discipline'],
            'reason': 'High inaccuracy rate detected',
            'priority': 'high'
        })

    if len(categories['technical_errors']) > 5:
        recommendations.append({
            'type': 'bug_fix',
            'component': 'model_inference',
            'reason': 'Technical errors in model responses',
            'priority': 'critical'
        })

    return recommendations
```

---

## Automated Alerting System

### **Alert Configuration**
```yaml
# Alert rules configuration
alerts:
  accuracy_drop:
    condition: "avg_accuracy < baseline_accuracy * 0.95"
    severity: critical
    channels: [email, slack, pager]
    cooldown: 3600  # 1 hour

  response_time_spike:
    condition: "avg_response_time > baseline_response_time * 2"
    severity: warning
    channels: [slack]
    cooldown: 1800  # 30 minutes

  error_rate_spike:
    condition: "error_rate > 0.05"
    severity: critical
    channels: [email, slack, pager]
    cooldown: 300   # 5 minutes

  drift_detected:
    condition: "drift_score > 0.15"
    severity: warning
    channels: [email, slack]
    cooldown: 7200  # 2 hours
```

### **Alert Escalation**
```javascript
class AlertEscalationManager {
  async handleAlert(alertType, severity, context) {
    // Log alert
    await this.logAlert(alertType, severity, context);

    // Determine escalation path
    const escalation = this.getEscalationPath(severity, alertType);

    // Send notifications
    await this.sendNotifications(escalation.channels, alertType, context);

    // Create incident if critical
    if (severity === 'critical') {
      await this.createIncident(alertType, context);
    }

    // Schedule follow-up
    if (escalation.followUpRequired) {
      await this.scheduleFollowUp(alertType, escalation.followUpDelay);
    }
  }

  getEscalationPath(severity, alertType) {
    const paths = {
      critical: {
        channels: ['email', 'slack', 'sms'],
        createIncident: true,
        followUpDelay: 15 * 60 * 1000  // 15 minutes
      },
      warning: {
        channels: ['slack'],
        createIncident: false,
        followUpDelay: 60 * 60 * 1000  // 1 hour
      },
      info: {
        channels: ['slack'],
        createIncident: false,
        followUpRequired: false
      }
    };

    return paths[severity] || paths.info;
  }
}
```

---

## Performance Optimization

### **Model Serving Optimization**

#### **Caching Strategies**
```python
from functools import lru_cache
import hashlib

class ModelResponseCache:
    def __init__(self, max_size=10000):
        self.cache = {}
        self.max_size = max_size

    def get_cache_key(self, discipline, query, model_version):
        """Generate consistent cache key"""
        key_data = f"{discipline}:{query}:{model_version}"
        return hashlib.md5(key_data.encode()).hexdigest()

    @lru_cache(maxsize=10000)
    def get_cached_response(self, cache_key):
        """Get cached response if available"""
        return self.cache.get(cache_key)

    def cache_response(self, cache_key, response, ttl_seconds=3600):
        """Cache response with TTL"""
        expiry = time.time() + ttl_seconds
        self.cache[cache_key] = {
            'response': response,
            'expiry': expiry
        }

        # Cleanup expired entries
        self.cleanup_expired()

    def cleanup_expired(self):
        """Remove expired cache entries"""
        current_time = time.time()
        expired_keys = [
            key for key, data in self.cache.items()
            if data['expiry'] < current_time
        ]

        for key in expired_keys:
            del self.cache[key]
```

#### **Load Balancing**
```javascript
class ModelLoadBalancer {
  constructor(models) {
    this.models = models; // Array of model instances
    this.currentIndex = 0;
    this.requestCounts = new Array(models.length).fill(0);
  }

  getNextModel() {
    // Round-robin load balancing
    const model = this.models[this.currentIndex];
    this.requestCounts[this.currentIndex]++;
    this.currentIndex = (this.currentIndex + 1) % this.models.length;

    return model;
  }

  getModelHealth() {
    return this.models.map((model, index) => ({
      id: index,
      requestCount: this.requestCounts[index],
      isHealthy: model.isHealthy()
    }));
  }

  removeUnhealthyModels() {
    this.models = this.models.filter(model => model.isHealthy());
    // Reset load balancing if models were removed
    if (this.models.length < this.requestCounts.length) {
      this.requestCounts = new Array(this.models.length).fill(0);
      this.currentIndex = 0;
    }
  }
}
```

### **Query Optimization**

#### **Batch Processing**
```python
async def process_batch_queries(queries, discipline, batch_size=10):
    """Process multiple queries in batch for efficiency"""

    results = []
    for i in range(0, len(queries), batch_size):
        batch = queries[i:i + batch_size]

        # Process batch in parallel
        batch_tasks = [
            process_single_query(query, discipline)
            for query in batch
        ]

        batch_results = await asyncio.gather(*batch_tasks)
        results.extend(batch_results)

        # Small delay to prevent overwhelming the model
        await asyncio.sleep(0.1)

    return results
```

#### **Query Prioritization**
```javascript
class QueryPrioritizer {
  prioritizeQuery(query, userContext) {
    let priority = 'normal';

    // High priority for urgent safety queries
    if (query.includes('safety') && query.includes('urgent')) {
      priority = 'high';
    }

    // Low priority for routine queries
    if (query.includes('status') && !query.includes('issue')) {
      priority = 'low';
    }

    // VIP users get higher priority
    if (userContext.isVIP) {
      priority = priority === 'high' ? 'critical' : 'high';
    }

    return priority;
  }

  async queueQuery(query, priority, userContext) {
    const queueName = `model_queue_${priority}`;

    await redis.lpush(queueName, JSON.stringify({
      query,
      userContext,
      timestamp: Date.now(),
      priority
    }));

    // Set queue priority weights
    const priorityWeights = {
      critical: 1,
      high: 2,
      normal: 3,
      low: 4
    };

    await redis.zadd('queue_priorities', priorityWeights[priority], queueName);
  }
}
```

---

## Emergency Response

### **Critical Performance Degradation**

#### **Immediate Response Protocol**
```bash
# Emergency model rollback procedure
MODEL_DISCIPLINE="contracts"
BACKUP_MODEL="contracts_v1_stable"

echo "🚨 CRITICAL: Rolling back $MODEL_DISCIPLINE model to $BACKUP_MODEL"

# Switch traffic to backup model
python scripts/emergency/rollback_model.py \
  --discipline "$MODEL_DISCIPLINE" \
  --target-model "$BACKUP_MODEL" \
  --reason "Critical performance degradation detected"

# Notify stakeholders
python scripts/emergency/notify_stakeholders.py \
  --incident-type "model_rollback" \
  --affected-discipline "$MODEL_DISCIPLINE" \
  --severity critical

# Create incident report
python scripts/emergency/create_incident_report.py \
  --discipline "$MODEL_DISCIPLINE" \
  --rollback-model "$BACKUP_MODEL" \
  --trigger-metrics "$(cat /tmp/critical_metrics.json)"
```

#### **Post-Incident Analysis**
```sql
-- Analyze incident causes
WITH incident_period AS (
  SELECT
    discipline,
    created_at,
    accuracy_score,
    response_time_ms,
    error_occurred
  FROM model_performance_logs
  WHERE created_at >= $incident_start_time
    AND created_at <= $incident_end_time
    AND discipline = $affected_discipline
),
baseline_comparison AS (
  SELECT
    ip.discipline,
    ip.accuracy_score,
    ip.response_time_ms,
    ip.error_occurred,
    AVG(baseline.accuracy_score) as baseline_accuracy,
    AVG(baseline.response_time_ms) as baseline_response_time
  FROM incident_period ip
  CROSS JOIN (
    SELECT accuracy_score, response_time_ms
    FROM model_performance_logs
    WHERE created_at >= $baseline_start
      AND created_at <= $baseline_end
      AND discipline = $affected_discipline
  ) baseline
  GROUP BY ip.discipline, ip.accuracy_score, ip.response_time_ms, ip.error_occurred
)
SELECT
  discipline,
  AVG(accuracy_score) as incident_accuracy,
  AVG(baseline_accuracy) as baseline_accuracy,
  AVG(response_time_ms) as incident_response_time,
  AVG(baseline_response_time) as baseline_response_time,
  COUNT(CASE WHEN error_occurred THEN 1 END) as errors_during_incident
FROM baseline_comparison
GROUP BY discipline;
```

---

## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-23 | AI Assistant | Initial comprehensive model performance monitoring procedure with A/B testing, drift detection, and automated alerting |

---

**Document Status**: ✅ **APPROVED FOR OPERATIONAL USE**

**Review Schedule**: Monthly monitoring review, quarterly procedure updates

**Escalation Contacts**:
- Performance Alerts: ML Team (ml-alerts@construct.ai)
- A/B Testing Issues: Product Team (product-abtesting@construct.ai)
- Model Drift: Data Science Team (ds-drift@construct.ai)
- Emergency Rollback: DevOps Team (devops-rollback@construct.ai)