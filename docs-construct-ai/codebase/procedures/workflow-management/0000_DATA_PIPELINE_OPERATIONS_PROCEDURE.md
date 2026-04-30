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

# 0000_DATA_PIPELINE_OPERATIONS_PROCEDURE.md - Data Pipeline Operations Procedure

## Document Information

- **Document ID**: `02204_DATA_PIPELINE_OPERATIONS_PROCEDURE`
- **Version**: 1.0
- **Created**: 2026-01-23
- **Last Updated**: 2026-01-23
- **Author**: AI Assistant (Construct AI)
- **Review Cycle**: Monthly
- **Classification**: Operational Procedure
- **Related Documents**:
  - `02200_AI_TRAINING_EXPANSION_PROCEDURE.md` - Training pipeline details
  - `0000_QWEN_FINETUNING_PROCEDURE.md` - Base fine-tuning procedures
  - `docs/implementation/02200_UNIFIED_AI_TRAINING_IMPLEMENTATION_PLAN.md` - Architecture

---

## Overview

This procedure provides operational runbooks for managing the unified data pipeline that transforms simulation and HITL data into training datasets for AI model fine-tuning. The pipeline moves data from Supabase through ETL processes to GitHub Actions training workflows.

**Critical Operations**: This pipeline must run reliably to maintain fresh training data for continuous model improvement.

---

## Pipeline Architecture

### **Data Flow Overview**
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Simulation    │ -> │   Supabase      │ -> │   ETL Script    │ -> │ GitHub Actions  │
│   Data          │    │   Storage       │    │   Processing    │    │   Training      │
│                 │    │                 │    │                 │    │                 │
│ - Correspondence │    │ - correspondence│    │ - Quality      │    │ - Model         │
│ - HITL Tasks    │    │   _training_data│    │   Validation    │    │   Training      │
│ - Agent Workflows│    │ - model_registry│    │ - Format       │    │ - Validation    │
└─────────────────┘    └─────────────────┘    │   Conversion    │    └─────────────────┘
                                              └─────────────────┘
```

### **Key Components**
- **Data Sources**: Simulation outputs, HITL interactions, agent workflows
- **Storage**: Supabase PostgreSQL database
- **ETL Engine**: Node.js/Python scripts for data processing
- **Quality Gates**: Automated validation and filtering
- **Training Trigger**: GitHub Actions workflow activation

### **Multi-Workflow Data Integration Details**

#### **HITL (Human-in-the-Loop) Data Integration**
```javascript
// HITL data collection and formatting
class HITLDataCollector {
  async collectHITLInteractions(workflowId, userInteractions) {
    const hitlRecords = [];

    for (const interaction of userInteractions) {
      const record = {
        source: 'hitl',
        workflow_id: workflowId,
        user_id: interaction.userId,
        discipline: interaction.discipline,
        original_query: interaction.userInput,
        ai_response: interaction.aiResponse,
        human_feedback: interaction.humanCorrection,
        quality_score: this.calculateQualityScore(interaction),
        metadata: {
          workflow_type: 'hitl',
          interaction_type: interaction.type, // 'correction', 'approval', 'override'
          processing_time: interaction.processingTime,
          user_expertise_level: interaction.userExpertise
        },
        created_at: new Date().toISOString()
      };

      hitlRecords.push(record);
    }

    return hitlRecords;
  }

  calculateQualityScore(interaction) {
    // Quality scoring based on human feedback
    let score = 75; // Base score

    if (interaction.humanCorrection) {
      // Significant correction reduces score
      score -= 20;
    }

    if (interaction.approvalRating) {
      // User approval increases score
      score += interaction.approvalRating * 5; // 1-5 rating * 5 = 5-25 points
    }

    return Math.max(0, Math.min(100, score));
  }
}
```

#### **Simulation Data Integration**
```javascript
// Simulation data collection and formatting
class SimulationDataCollector {
  async collectSimulationOutputs(simulationResults) {
    const simulationRecords = [];

    for (const result of simulationResults) {
      const record = {
        source: 'simulation',
        simulation_id: result.simulationId,
        agent_type: result.agentType,
        discipline: result.discipline,
        scenario: result.scenario,
        input_prompt: result.inputPrompt,
        ai_response: result.aiResponse,
        expected_output: result.expectedOutput,
        quality_score: this.calculateSimulationQuality(result),
        metadata: {
          workflow_type: 'simulation',
          agent_generation_method: result.agentGenerationMethod,
          simulation_template: result.templateUsed,
          complexity_level: result.complexity,
          success_criteria_met: result.successCriteria
        },
        created_at: new Date().toISOString()
      };

      simulationRecords.push(record);
    }

    return simulationRecords;
  }

  calculateSimulationQuality(result) {
    // Quality scoring for simulation data
    let score = 80; // Base score for simulation data

    // Success criteria compliance
    if (result.successCriteria) {
      score += 10;
    }

    // Response relevance to scenario
    if (result.responseRelevance > 0.8) {
      score += 5;
    }

    // Technical accuracy
    if (result.technicalAccuracy) {
      score += 5;
    }

    return Math.max(0, Math.min(100, score));
  }
}
```

#### **Chatbot Data Integration**
```javascript
// Chatbot interaction data collection
class ChatbotDataCollector {
  async collectChatbotInteractions(chatSessions) {
    const chatbotRecords = [];

    for (const session of chatSessions) {
      for (const message of session.messages) {
        if (message.role === 'user') {
          // Find corresponding AI response
          const aiResponse = this.findNextAIResponse(session.messages, message);

          if (aiResponse) {
            const record = {
              source: 'chatbot',
              session_id: session.sessionId,
              user_id: session.userId,
              discipline: this.inferDiscipline(message.content, session.context),
              original_query: message.content,
              ai_response: aiResponse.content,
              quality_score: this.calculateChatbotQuality(message, aiResponse, session),
              metadata: {
                workflow_type: 'chatbot',
                conversation_context: session.context,
                message_sequence: message.sequenceNumber,
                response_time: aiResponse.timestamp - message.timestamp,
                user_satisfaction: session.userRating
              },
              created_at: message.timestamp
            };

            chatbotRecords.push(record);
          }
        }
      }
    }

    return chatbotRecords;
  }

  inferDiscipline(query, context) {
    // Discipline inference logic based on content analysis
    const disciplineKeywords = {
      'safety': ['hazard', 'safety', 'risk', 'accident', 'protection'],
      'contracts': ['contract', 'agreement', 'terms', 'clause', 'obligation'],
      'procurement': ['supplier', 'vendor', 'purchase', 'procurement', 'tender'],
      'civil_engineering': ['concrete', 'steel', 'foundation', 'structural', 'construction']
    };

    for (const [discipline, keywords] of Object.entries(disciplineKeywords)) {
      if (keywords.some(keyword => query.toLowerCase().includes(keyword))) {
        return discipline;
      }
    }

    return 'general'; // Default discipline
  }

  calculateChatbotQuality(userMessage, aiResponse, session) {
    let score = 70; // Base score for chatbot data

    // User satisfaction rating
    if (session.userRating) {
      score += (session.userRating - 3) * 10; // -20 to +20 based on 1-5 rating
    }

    // Response relevance (would be calculated by ML model)
    // For now, assume reasonable quality
    score += 10;

    // Conversation flow quality
    if (aiResponse.content.length > 50) { // Substantial response
      score += 5;
    }

    return Math.max(0, Math.min(100, score));
  }
}
```

#### **Unified Data Processing Pipeline**
```javascript
// Unified ETL processor for all data sources
class UnifiedDataProcessor {
  constructor() {
    this.collectors = {
      hitl: new HITLDataCollector(),
      simulation: new SimulationDataCollector(),
      chatbot: new ChatbotDataCollector()
    };
    this.qualityThresholds = {
      hitl: 70,
      simulation: 75,
      chatbot: 65
    };
  }

  async processAllDataSources() {
    const allRecords = [];

    // Collect from all sources
    for (const [sourceType, collector] of Object.entries(this.collectors)) {
      try {
        const sourceData = await this.fetchSourceData(sourceType);
        const processedRecords = await collector[`collect${sourceType.charAt(0).toUpperCase() + sourceType.slice(1)}Interactions`](sourceData);

        // Apply source-specific quality filtering
        const filteredRecords = processedRecords.filter(record =>
          record.quality_score >= this.qualityThresholds[sourceType]
        );

        allRecords.push(...filteredRecords);

        console.log(`Processed ${filteredRecords.length} records from ${sourceType} (filtered from ${processedRecords.length})`);
      } catch (error) {
        console.error(`Error processing ${sourceType} data:`, error);
      }
    }

    // Unify data format and standardize fields
    const unifiedRecords = this.unifyDataFormat(allRecords);

    // Apply cross-source quality validation
    const validatedRecords = await this.applyCrossSourceValidation(unifiedRecords);

    return validatedRecords;
  }

  unifyDataFormat(records) {
    return records.map(record => ({
      // Standardize core fields
      id: this.generateUnifiedId(record),
      source: record.source,
      discipline: record.discipline || 'general',
      input_text: this.normalizeInputText(record),
      output_text: this.normalizeOutputText(record),
      quality_score: record.quality_score,
      metadata: {
        ...record.metadata,
        unified_at: new Date().toISOString(),
        original_source: record.source,
        processing_version: '1.0'
      },
      created_at: record.created_at,
      processed_at: new Date().toISOString()
    }));
  }

  normalizeInputText(record) {
    // Standardize input text across sources
    const input = record.original_query || record.input_prompt || record.scenario || '';
    return input.trim();
  }

  normalizeOutputText(record) {
    // Standardize output text across sources
    const output = record.ai_response || record.expected_output || '';
    return output.trim();
  }

  async applyCrossSourceValidation(records) {
    // Additional validation that considers all sources together
    const validatedRecords = [];

    for (const record of records) {
      // Check for duplicate content across sources
      const isDuplicate = await this.checkForDuplicates(record, validatedRecords);
      if (isDuplicate) {
        continue;
      }

      // Apply ensemble quality scoring
      record.quality_score = await this.calculateEnsembleQualityScore(record, records);

      // Only include if it meets final quality threshold
      if (record.quality_score >= 70) {
        validatedRecords.push(record);
      }
    }

    return validatedRecords;
  }

  async checkForDuplicates(record, existingRecords) {
    // Simple duplicate detection based on input similarity
    const similarityThreshold = 0.85;

    for (const existing of existingRecords) {
      if (existing.discipline === record.discipline) {
        const similarity = this.calculateTextSimilarity(record.input_text, existing.input_text);
        if (similarity > similarityThreshold) {
          return true;
        }
      }
    }

    return false;
  }

  calculateTextSimilarity(text1, text2) {
    // Simple Jaccard similarity for demonstration
    const words1 = new Set(text1.toLowerCase().split(/\s+/));
    const words2 = new Set(text2.toLowerCase().split(/\s+/));

    const intersection = new Set([...words1].filter(x => words2.has(x)));
    const union = new Set([...words1, ...words2]);

    return intersection.size / union.size;
  }

  async calculateEnsembleQualityScore(record, allRecords) {
    // Ensemble scoring considering source reliability and cross-validation
    const sourceWeights = {
      hitl: 1.0,      // Highest weight - human validated
      simulation: 0.8, // Good weight - controlled scenarios
      chatbot: 0.6    // Lower weight - less controlled
    };

    const baseScore = record.quality_score;
    const sourceMultiplier = sourceWeights[record.source] || 0.5;

    return Math.min(100, baseScore * sourceMultiplier);
  }

  generateUnifiedId(record) {
    // Generate consistent ID across sources
    const timestamp = new Date(record.created_at).getTime();
    const sourceCode = record.source.substring(0, 3).toUpperCase();
    return `UNIFIED_${sourceCode}_${timestamp}_${Math.random().toString(36).substr(2, 9)}`;
  }
}
```

#### **Data Source Balancing Strategy**
```sql
-- Analyze data distribution across sources
SELECT
  source,
  discipline,
  COUNT(*) as record_count,
  AVG(quality_score) as avg_quality,
  MIN(quality_score) as min_quality,
  MAX(quality_score) as max_quality
FROM unified_training_data
WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY source, discipline
ORDER BY discipline, source;

-- Implement balancing queries for training
WITH source_balanced AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY discipline, source ORDER BY quality_score DESC) as source_rank
  FROM unified_training_data
  WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
),
balanced_sample AS (
  SELECT *
  FROM source_balanced
  WHERE source_rank <= 1000  -- Limit per source per discipline
)
SELECT
  discipline,
  source,
  COUNT(*) as final_count,
  AVG(quality_score) as balanced_quality
FROM balanced_sample
GROUP BY discipline, source
ORDER BY discipline, source;
```

#### **Quality Scoring Across Sources**
- **HITL Data**: 70-100 (human-validated, highest quality)
- **Simulation Data**: 75-100 (controlled scenarios, high quality)
- **Chatbot Data**: 65-95 (natural interactions, variable quality)
- **Unified Threshold**: 70+ for training inclusion

---

## Daily Operations

## Daily Operations

### **Morning Health Check (8:00 AM)**

#### **Step 1: Verify System Status**
```bash
# Check ETL pipeline health
curl -s http://localhost:3000/health/etl | jq .

# Expected response:
{
  "status": "healthy",
  "last_etl_run": "2026-01-23T06:00:00Z",
  "pending_records": 1250,
  "error_rate": 0.02
}
```

#### **Step 2: Review Data Ingestion**
```sql
-- Check recent data ingestion (Supabase)
SELECT
  DATE(created_at) as date,
  COUNT(*) as records,
  AVG(quality_score) as avg_quality,
  COUNT(CASE WHEN quality_score > 80 THEN 1 END) as high_quality
FROM correspondence_training_data
WHERE created_at >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY DATE(created_at)
ORDER BY date DESC;
```

#### **Step 3: Monitor ETL Performance**
```bash
# Check ETL logs
tail -50 logs/etl/etl_$(date +%Y%m%d).log

# Verify ETL completion
ls -la data/processed/$(date +%Y%m%d)/
```

### **ETL Execution (6:00 AM Daily)**

#### **Automated ETL Process**
```bash
#!/bin/bash
# ETL execution script - runs via cron

ETL_LOG="logs/etl/etl_$(date +%Y%m%d_%H%M%S).log"
DATA_DIR="data/processed/$(date +%Y%m%d)"

# Create directories
mkdir -p "$DATA_DIR" "$(dirname "$ETL_LOG")"

# Log start
echo "$(date): Starting ETL process" >> "$ETL_LOG"

# Extract data from Supabase
node scripts/etl/extract_training_data.js >> "$ETL_LOG" 2>&1

# Transform and validate
python scripts/etl/transform_validate.py \
  --input data/raw/$(date +%Y%m%d) \
  --output "$DATA_DIR" \
  --quality-threshold 75 >> "$ETL_LOG" 2>&1

# Load to training format
node scripts/etl/load_training_format.js \
  --input "$DATA_DIR" \
  --output models/training-data/ >> "$ETL_LOG" 2>&1

# Trigger training if enough data
if [ $(find models/training-data/ -name "*.jsonl" -exec cat {} \; | wc -l) -gt 1000 ]; then
  echo "$(date): Triggering training workflow" >> "$ETL_LOG"
  gh workflow run continual-learning.yml \
    --repo Construct-AI-primary/construct_ai >> "$ETL_LOG" 2>&1
fi

echo "$(date): ETL process completed" >> "$ETL_LOG"
```

#### **Manual ETL Trigger (Emergency)**
```bash
# Emergency ETL execution
ETL_DATE=$(date +%Y%m%d)
LOG_FILE="logs/etl/manual_etl_${ETL_DATE}.log"

# Run ETL with verbose logging
bash scripts/etl/run_etl.sh \
  --date "$ETL_DATE" \
  --verbose \
  --force \
  2>&1 | tee "$LOG_FILE"

# Verify results
echo "ETL Results:"
echo "- Processed records: $(grep "Processed" "$LOG_FILE" | tail -1)"
echo "- Quality filtered: $(grep "Filtered" "$LOG_FILE" | tail -1)"
echo "- Training files: $(ls -1 models/training-data/*.jsonl | wc -l)"
```

---

## Weekly Operations

### **ETL Performance Review (Every Monday)**

#### **Step 1: Analyze ETL Metrics**
```sql
-- Weekly ETL performance analysis
SELECT
  DATE_TRUNC('week', created_at) as week,
  COUNT(*) as total_records,
  AVG(quality_score) as avg_quality,
  COUNT(CASE WHEN quality_score >= 90 THEN 1 END) as excellent_quality,
  COUNT(CASE WHEN quality_score < 70 THEN 1 END) as poor_quality,
  AVG(EXTRACT(EPOCH FROM (processed_at - created_at))/3600) as processing_hours
FROM correspondence_training_data
WHERE created_at >= CURRENT_DATE - INTERVAL '4 weeks'
GROUP BY DATE_TRUNC('week', created_at)
ORDER BY week DESC;
```

#### **Step 2: Review Training Data Quality**
```bash
# Analyze training data distribution
python scripts/analyze_training_data.py \
  --data-dir models/training-data/ \
  --output reports/weekly_quality_report.md

# Check for data imbalances
python scripts/check_data_balance.py \
  --disciplines "safety,contracts,procurement,civil_engineering"
```

#### **Step 3: Training Pipeline Status**
```bash
# Check recent training runs
gh run list \
  --workflow continual-learning.yml \
  --limit 5 \
  --repo Construct-AI-primary/construct_ai

# Review training logs
find logs/training/ -name "*.log" -mtime -7 | head -10
```

### **Data Quality Maintenance**

#### **Step 1: Identify Quality Trends**
```sql
-- Quality degradation detection
WITH weekly_quality AS (
  SELECT
    DATE_TRUNC('week', created_at) as week,
    AVG(quality_score) as avg_quality,
    COUNT(*) as record_count
  FROM correspondence_training_data
  WHERE created_at >= CURRENT_DATE - INTERVAL '8 weeks'
  GROUP BY DATE_TRUNC('week', created_at)
),
quality_trends AS (
  SELECT
    week,
    avg_quality,
    LAG(avg_quality) OVER (ORDER BY week) as prev_quality,
    (avg_quality - LAG(avg_quality) OVER (ORDER BY week)) as quality_change
  FROM weekly_quality
)
SELECT * FROM quality_trends
WHERE quality_change < -5  -- Significant quality drop
ORDER BY week DESC;
```

#### **Step 2: Quality Improvement Actions**
```bash
# Regenerate poor quality data
python scripts/improve_data_quality.py \
  --discipline safety \
  --min-quality 75 \
  --regenerate-count 500

# Update quality validation rules
node scripts/update_quality_rules.js \
  --rules-file config/quality_rules.json \
  --update-technical-terms
```

---

## Monthly Operations

### **Pipeline Capacity Planning**

#### **Step 1: Analyze Data Volume Trends**
```sql
-- Monthly data volume analysis
SELECT
  DATE_TRUNC('month', created_at) as month,
  COUNT(*) as total_records,
  COUNT(DISTINCT discipline) as disciplines_covered,
  AVG(quality_score) as avg_quality,
  MAX(created_at) as latest_record
FROM correspondence_training_data
WHERE created_at >= CURRENT_DATE - INTERVAL '12 months'
GROUP BY DATE_TRUNC('month', created_at)
ORDER BY month DESC;
```

#### **Step 2: Forecast Resource Needs**
```bash
# Resource forecasting
python scripts/forecast_resources.py \
  --historical-months 6 \
  --forecast-months 3 \
  --output reports/resource_forecast.md

# Database capacity check
du -sh data/supabase_backups/
df -h /var/lib/postgresql/
```

### **Model Registry Maintenance**

#### **Step 1: Review Model Performance**
```sql
-- Model performance analysis
SELECT
  discipline,
  COUNT(*) as training_runs,
  AVG(accuracy) as avg_accuracy,
  MAX(accuracy) as best_accuracy,
  AVG(training_time_minutes) as avg_training_time,
  MAX(last_used) as last_used
FROM model_registry
WHERE created_at >= CURRENT_DATE - INTERVAL '3 months'
GROUP BY discipline
ORDER BY avg_accuracy DESC;
```

#### **Step 2: Archive Old Models**
```bash
# Archive models older than 6 months
python scripts/archive_old_models.py \
  --older-than 180 \
  --archive-dir models/archive/ \
  --dry-run

# Update model registry
node scripts/update_model_registry.js \
  --archive-threshold 180 \
  --cleanup-orphaned
```

---

## Emergency Procedures

### **ETL Pipeline Failure**

#### **Immediate Response**
```bash
# Stop any running ETL processes
pkill -f "etl"

# Check system resources
df -h
free -h
ps aux | grep etl

# Restart ETL with diagnostics
bash scripts/etl/run_etl.sh \
  --diagnostic \
  --verbose \
  2>&1 | tee logs/etl/emergency_$(date +%Y%m%d_%H%M%S).log
```

#### **Data Recovery**
```bash
# Restore from backup if needed
BACKUP_DATE=$(date -d 'yesterday' +%Y%m%d)
tar -xzf backups/etl/etl_backup_${BACKUP_DATE}.tar.gz -C data/

# Reprocess failed records
python scripts/recover_failed_records.py \
  --date "$BACKUP_DATE" \
  --retry-failed
```

### **Data Quality Crisis**

#### **Detection**
```sql
-- Detect quality crisis
SELECT
  discipline,
  COUNT(*) as total_records,
  AVG(quality_score) as avg_quality,
  COUNT(CASE WHEN quality_score < 50 THEN 1 END) as poor_records
FROM correspondence_training_data
WHERE created_at >= CURRENT_DATE - INTERVAL '1 day'
GROUP BY discipline
HAVING AVG(quality_score) < 70;
```

#### **Recovery Actions**
```bash
# Emergency quality filter adjustment
node scripts/adjust_quality_filters.js \
  --emergency-mode \
  --min-quality 60 \
  --max-filter-rate 0.5

# Regenerate critical discipline data
python scripts/emergency_data_generation.py \
  --disciplines "safety,contracts" \
  --count 1000 \
  --high-quality-only
```

---

## Monitoring & Alerting

### **Automated Monitoring**

#### **ETL Health Monitoring**
```javascript
// ETL health check script
const { Client } = require('pg');
const nodemailer = require('nodemailer');

async function checkETLHealth() {
    const client = new Client({
        connectionString: process.env.SUPABASE_CONNECTION_STRING
    });

    await client.connect();

    // Check ETL pipeline status
    const result = await client.query(`
        SELECT
            COUNT(*) as pending_records,
            AVG(quality_score) as avg_quality,
            MAX(created_at) as latest_record
        FROM correspondence_training_data
        WHERE processed_at IS NULL
        AND created_at > NOW() - INTERVAL '1 hour'
    `);

    const { pending_records, avg_quality, latest_record } = result.rows[0];

    // Alert conditions
    if (pending_records > 10000) {
        await sendAlert('ETL_BACKLOG', `High ETL backlog: ${pending_records} records`);
    }

    if (avg_quality < 70) {
        await sendAlert('QUALITY_DROP', `Quality drop detected: ${avg_quality}%`);
    }

    if (latest_record < new Date(Date.now() - 3600000)) { // 1 hour ago
        await sendAlert('DATA_STALE', 'No new data received in last hour');
    }

    await client.end();
}

async function sendAlert(type, message) {
    // Send email/Slack alert
    const transporter = nodemailer.createTransporter({
        service: 'gmail',
        auth: { user: process.env.ALERT_EMAIL, pass: process.env.ALERT_PASSWORD }
    });

    await transporter.sendMail({
        from: process.env.ALERT_EMAIL,
        to: process.env.TEAM_EMAIL,
        subject: `🚨 ETL Alert: ${type}`,
        text: message
    });
}

// Run every 15 minutes via cron
checkETLHealth();
```

#### **Training Pipeline Monitoring**
```yaml
# GitHub Actions workflow monitoring
name: Pipeline Health Check
on:
  schedule:
    - cron: '*/30 * * * *'  # Every 30 minutes
  workflow_dispatch:

jobs:
  health-check:
    runs-on: ubuntu-latest
    steps:
      - name: Check ETL Status
        run: |
          response=$(curl -s http://your-etl-endpoint/health)
          if [[ $(echo "$response" | jq -r '.status') != "healthy" ]]; then
            echo "ETL unhealthy"
            exit 1
          fi

      - name: Check Training Queue
        run: |
          queue_size=$(gh run list --workflow continual-learning.yml --limit 10 | grep -c "queued\|in_progress")
          if [[ $queue_size -gt 5 ]]; then
            gh issue create --title "Training Queue Backlog" --body "Queue size: $queue_size"
          fi
```

### **Dashboard Setup**

#### **Grafana Dashboard Configuration**
```json
{
  "dashboard": {
    "title": "Data Pipeline Operations",
    "panels": [
      {
        "title": "ETL Throughput",
        "type": "graph",
        "targets": [
          {
            "query": "rate(correspondence_records_processed_total[5m])",
            "legend": "Records/min"
          }
        ]
      },
      {
        "title": "Data Quality Distribution",
        "type": "histogram",
        "targets": [
          {
            "query": "correspondence_quality_score",
            "buckets": 10
          }
        ]
      },
      {
        "title": "Training Pipeline Status",
        "type": "stat",
        "targets": [
          {
            "query": "training_jobs_active",
            "thresholds": { "warning": 2, "error": 5 }
          }
        ]
      }
    ]
  }
}
```

---

## Performance Optimization

### **ETL Performance Tuning**

#### **Batch Size Optimization**
```python
# Dynamic batch sizing based on data volume
def optimize_batch_size(data_volume, system_resources):
    base_batch = 1000

    if data_volume > 100000:
        return base_batch * 2
    elif system_resources['memory_gb'] < 8:
        return base_batch // 2
    else:
        return base_batch
```

#### **Parallel Processing**
```javascript
// Parallel ETL processing
async function processETLParallel(dataChunks, workerCount = 4) {
    const workers = [];
    const results = [];

    for (let i = 0; i < workerCount; i++) {
        workers.push(processChunk(dataChunks[i]));
    }

    const outputs = await Promise.all(workers);
    return outputs.flat();
}

async function processChunk(chunk) {
    // Quality validation, transformation, etc.
    return chunk.map(record => transformRecord(record));
}
```

### **Database Optimization**

#### **Indexing Strategy**
```sql
-- Optimal indexes for ETL performance
CREATE INDEX CONCURRENTLY idx_correspondence_created_at ON correspondence_training_data (created_at);
CREATE INDEX CONCURRENTLY idx_correspondence_discipline_quality ON correspondence_training_data (discipline, quality_score);
CREATE INDEX CONCURRENTLY idx_correspondence_processed_status ON correspondence_training_data (processed_at) WHERE processed_at IS NULL;

-- Partitioning for large tables
CREATE TABLE correspondence_training_data_y2026m01 PARTITION OF correspondence_training_data
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');
```

#### **Query Optimization**
```sql
-- Optimized ETL queries
EXPLAIN ANALYZE
SELECT discipline, COUNT(*), AVG(quality_score)
FROM correspondence_training_data
WHERE created_at >= $1 AND quality_score > 75
GROUP BY discipline
ORDER BY COUNT(*) DESC;

-- Use CTEs for complex transformations
WITH quality_filtered AS (
    SELECT * FROM correspondence_training_data
    WHERE quality_score > 75 AND created_at >= CURRENT_DATE - INTERVAL '7 days'
),
discipline_stats AS (
    SELECT
        discipline,
        COUNT(*) as record_count,
        AVG(quality_score) as avg_quality
    FROM quality_filtered
    GROUP BY discipline
)
SELECT * FROM discipline_stats WHERE record_count > 100;
```

---

## Troubleshooting Guide

### **Common ETL Issues**

| Issue | Symptoms | Solution |
|-------|----------|----------|
| **High memory usage** | ETL process killed | Reduce batch size, add memory limits |
| **Slow processing** | ETL takes >2 hours | Check database indexes, optimize queries |
| **Data quality drop** | Quality score <70% | Update validation rules, regenerate data |
| **Training not triggered** | No new models | Check data volume thresholds |
| **Database locks** | ETL hangs | Use `CONCURRENTLY` for index creation |

### **Debug Commands**

```bash
# ETL debugging
bash scripts/etl/run_etl.sh --debug --verbose 2>&1 | tee debug.log

# Database query analysis
psql -h your-db-host -d your-db -c "EXPLAIN ANALYZE SELECT * FROM correspondence_training_data LIMIT 1000;"

# Training pipeline debug
gh run view <run-id> --repo Construct-AI-primary/construct_ai --log
```

---

## Backup & Recovery

### **Data Backup Strategy**
```bash
# Daily ETL data backup
BACKUP_DIR="backups/etl/$(date +%Y%m%d)"
mkdir -p "$BACKUP_DIR"

# Backup raw data
tar -czf "$BACKUP_DIR/raw_data.tar.gz" data/raw/$(date +%Y%m%d)/

# Backup processed data
tar -czf "$BACKUP_DIR/processed_data.tar.gz" data/processed/$(date +%Y%m%d)/

# Backup database
pg_dump -h $DB_HOST -U $DB_USER -d $DB_NAME \
  --table correspondence_training_data \
  --file "$BACKUP_DIR/database.sql"

# Retention: keep 30 days locally, 90 days in cold storage
find backups/etl/ -name "*.tar.gz" -mtime +30 -delete
```

### **Recovery Procedures**
```bash
# Data recovery from backup
BACKUP_DATE="20260120"
RECOVERY_DIR="recovery/$BACKUP_DATE"

mkdir -p "$RECOVERY_DIR"

# Restore files
tar -xzf "backups/etl/$BACKUP_DATE/processed_data.tar.gz" -C "$RECOVERY_DIR"

# Restore database
psql -h $DB_HOST -U $DB_USER -d $DB_NAME < "backups/etl/$BACKUP_DATE/database.sql"

# Validate recovery
python scripts/validate_recovery.py --date "$BACKUP_DATE" --recovery-dir "$RECOVERY_DIR"
```

---

## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-23 | AI Assistant | Initial comprehensive data pipeline operations procedure with monitoring, troubleshooting, and emergency procedures |

---

**Document Status**: ✅ **APPROVED FOR OPERATIONAL USE**

**Review Schedule**: Monthly operational review, quarterly procedure updates

**Escalation Contacts**:
- ETL Issues: DevOps Team (etl-alerts@construct.ai)
- Data Quality: Data Team (data-quality@construct.ai)
- Training Pipeline: ML Team (ml-training@construct.ai)