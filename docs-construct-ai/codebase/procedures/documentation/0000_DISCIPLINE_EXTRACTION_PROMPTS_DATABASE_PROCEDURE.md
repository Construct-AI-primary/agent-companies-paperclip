---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/documentation
gigabrain_tags: procedures, documentation, codebase
documentation
openstinger_context: operational-procedures, documentation-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# 🔍 **0000 DISCIPLINE EXTRACTION PROMPTS DATABASE PROCEDURE**

## **Construct AI Discipline-Specific Data Storage Guide**

### **Document Purpose**
This procedure provides comprehensive guidance for managing the `discipline_extraction_prompts` database table, which serves as the central data repository for discipline-specific configurations used across training, extraction, and processing workflows in the Construct AI platform.

### **Table Overview**

**Primary Purpose:**
The `discipline_extraction_prompts` table stores structured configuration data for each engineering discipline, enabling:
- ✅ **Discipline-Specific Processing**: Tailored prompts and configurations for different engineering specialties
- ✅ **Training Data Management**: Structured prompts for AI model fine-tuning and training
- ✅ **Extraction Configuration**: Field mappings and focus areas for document analysis
- ✅ **Dynamic Configuration**: Runtime selection of discipline-appropriate processing parameters
- ✅ **Version Control**: Track changes and maintain prompt evolution history

---

## 📋 **DATABASE SCHEMA REFERENCE**

### **Table Structure**
```sql
CREATE TABLE discipline_extraction_prompts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    discipline_code VARCHAR(50) NOT NULL UNIQUE,
    display_name VARCHAR(100) NOT NULL,
    system_prompt TEXT NOT NULL,
    extraction_fields JSONB NOT NULL DEFAULT '[]',
    extraction_focus JSONB NOT NULL DEFAULT '[]',
    document_types JSONB NOT NULL DEFAULT '["correspondence", "specification"]',
    is_active BOOLEAN DEFAULT true,
    version INTEGER DEFAULT 1,
    created_by UUID REFERENCES auth.users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### **Field Definitions**

| **Field** | **Type** | **Purpose** | **Required** | **Default** |
|-----------|----------|-------------|--------------|-------------|
| `id` | UUID | Primary key identifier | Auto-generated | `gen_random_uuid()` |
| `discipline_code` | VARCHAR(50) | Unique discipline identifier (e.g., 'civil', 'electrical') | Yes | - |
| `display_name` | VARCHAR(100) | Human-readable discipline name | Yes | - |
| `system_prompt` | TEXT | AI system prompt for discipline-specific processing | Yes | - |
| `extraction_fields` | JSONB | Array of fields to extract for this discipline | Yes | `[]` |
| `extraction_focus` | JSONB | Array of focus areas/keywords for processing | Yes | `[]` |
| `document_types` | JSONB | Supported document types for this discipline | Yes | `["correspondence", "specification"]` |
| `is_active` | BOOLEAN | Whether this discipline configuration is active | No | `true` |
| `version` | INTEGER | Version number for change tracking | No | `1` |
| `created_by` | UUID | User who created this record | No | - |
| `created_at` | TIMESTAMPTZ | Record creation timestamp | Auto | `NOW()` |
| `updated_at` | TIMESTAMPTZ | Last update timestamp | Auto | `NOW()` |

### **Indexes and Performance**
```sql
-- Performance indexes
CREATE INDEX idx_discipline_prompts_code ON discipline_extraction_prompts(discipline_code);
CREATE INDEX idx_discipline_prompts_active ON discipline_extraction_prompts(is_active);

-- Additional recommended indexes for common queries
CREATE INDEX idx_discipline_prompts_created_at ON discipline_extraction_prompts(created_at);
CREATE INDEX idx_discipline_prompts_version ON discipline_extraction_prompts(version);
```

### **Row Level Security (RLS) Policies**
```sql
-- Enable RLS
ALTER TABLE discipline_extraction_prompts ENABLE ROW LEVEL SECURITY;

-- Read access for authenticated users (only active records)
CREATE POLICY "Enable read access for authenticated users" ON discipline_extraction_prompts
    FOR SELECT TO authenticated USING (is_active = true);

-- Admin full access
CREATE POLICY "Enable admin full access" ON discipline_extraction_prompts
    FOR ALL TO authenticated USING (
        EXISTS (
            SELECT 1 FROM auth.users
            WHERE id = auth.uid()
            AND raw_user_meta_data->>'role' IN ('admin', 'super_admin')
        )
    );
```

---

## 🎯 **USE CASES AND APPLICATIONS**

### **Primary Use Cases**

#### **1. Training Data Storage**
**Purpose:** Store discipline-specific prompts for AI model training and fine-tuning

**Implementation:**
```javascript
// Training data retrieval
const getTrainingPrompts = async (disciplineCode) => {
  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .select('system_prompt, extraction_fields, extraction_focus')
    .eq('discipline_code', disciplineCode)
    .eq('is_active', true)
    .single();

  if (error) throw error;
  return data;
};

// Usage in training pipeline
const trainingData = await getTrainingPrompts('civil');
// Use system_prompt for model fine-tuning
// Use extraction_fields for training data structure
```

#### **2. Runtime Discipline Selection**
**Purpose:** Dynamic selection of discipline-appropriate configurations during processing

**Implementation:**
```javascript
// Runtime discipline configuration
const getDisciplineConfig = async (disciplineCode, documentType = null) => {
  let query = supabase
    .from('discipline_extraction_prompts')
    .select('*')
    .eq('discipline_code', disciplineCode)
    .eq('is_active', true);

  // Filter by document type if specified
  if (documentType) {
    query = query.contains('document_types', [documentType]);
  }

  const { data, error } = await query.single();
  if (error) throw error;

  return {
    systemPrompt: data.system_prompt,
    extractionFields: data.extraction_fields,
    extractionFocus: data.extraction_focus,
    version: data.version
  };
};

// Usage in processing workflows
const civilConfig = await getDisciplineConfig('civil', 'correspondence');
```

#### **3. Document Analysis Configuration**
**Purpose:** Configure extraction parameters based on discipline and document type

**Implementation:**
```javascript
// Document analysis configuration
const configureDocumentAnalysis = async (documentType, disciplines) => {
  const configs = [];

  for (const discipline of disciplines) {
    const config = await getDisciplineConfig(discipline, documentType);
    configs.push({
      discipline,
      ...config
    });
  }

  return configs;
};

// Multi-discipline analysis setup
const analysisConfigs = await configureDocumentAnalysis('specification', ['civil', 'structural', 'electrical']);
```

#### **4. HITL Workflow Enhancement**
**Purpose:** Provide discipline-specific context for human-in-the-loop review

**Implementation:**
```javascript
// HITL context enrichment
const enrichHITLContext = async (documentId, selectedDisciplines) => {
  const disciplineContexts = [];

  for (const disciplineCode of selectedDisciplines) {
    const config = await getDisciplineConfig(disciplineCode);

    disciplineContexts.push({
      discipline: config.display_name,
      focusAreas: config.extraction_focus,
      keyFields: config.extraction_fields,
      systemPrompt: config.system_prompt
    });
  }

  return {
    documentId,
    disciplineContexts,
    timestamp: new Date().toISOString()
  };
};
```

---

## 🔧 **CRUD OPERATIONS PROCEDURES**

### **Create Operations**

#### **Adding New Discipline Configuration**
```sql
-- Insert new discipline configuration
INSERT INTO discipline_extraction_prompts (
    discipline_code,
    display_name,
    system_prompt,
    extraction_fields,
    extraction_focus,
    document_types,
    created_by
) VALUES (
    'new_discipline',
    'New Engineering Discipline',
    'You are a specialist in [discipline] engineering...',
    '["field1", "field2", "field3"]',
    '["focus_area_1", "focus_area_2"]',
    '["correspondence", "specification", "drawing"]',
    'user-uuid-here'
);
```

#### **Bulk Insert for Multiple Disciplines**
```sql
-- Bulk insert pattern
INSERT INTO discipline_extraction_prompts (
    discipline_code, display_name, system_prompt,
    extraction_fields, extraction_focus, document_types
) VALUES
    ('discipline1', 'Discipline One', 'Prompt 1...', '["field1"]', '["focus1"]', '["type1"]'),
    ('discipline2', 'Discipline Two', 'Prompt 2...', '["field2"]', '["focus2"]', '["type2"]'),
    ('discipline3', 'Discipline Three', 'Prompt 3...', '["field3"]', '["focus3"]', '["type3"]');
```

### **Read Operations**

#### **Basic Retrieval Patterns**
```javascript
// Get all active disciplines
const getActiveDisciplines = async () => {
  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .select('discipline_code, display_name, version')
    .eq('is_active', true)
    .order('display_name');

  if (error) throw error;
  return data;
};

// Get specific discipline configuration
const getDisciplineByCode = async (code) => {
  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .select('*')
    .eq('discipline_code', code)
    .eq('is_active', true)
    .single();

  if (error) throw error;
  return data;
};
```

#### **Advanced Query Patterns**
```javascript
// Get disciplines supporting specific document type
const getDisciplinesByDocumentType = async (documentType) => {
  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .select('discipline_code, display_name, extraction_fields')
    .contains('document_types', [documentType])
    .eq('is_active', true);

  if (error) throw error;
  return data;
};

// Search disciplines by focus area
const searchDisciplinesByFocus = async (focusKeyword) => {
  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .select('*')
    .contains('extraction_focus', [focusKeyword])
    .eq('is_active', true);

  if (error) throw error;
  return data;
};
```

### **Update Operations**

#### **Version-Controlled Updates**
```javascript
// Update with version increment
const updateDisciplineConfig = async (disciplineCode, updates) => {
  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .update({
      ...updates,
      version: supabase.raw('version + 1'),
      updated_at: new Date().toISOString()
    })
    .eq('discipline_code', disciplineCode)
    .select()
    .single();

  if (error) throw error;
  return data;
};

// Example usage
const updatedConfig = await updateDisciplineConfig('civil', {
  system_prompt: 'Updated civil engineering prompt...',
  extraction_fields: ['new_field1', 'new_field2']
});
```

#### **Safe Update with Conflict Resolution**
```javascript
// Update with optimistic locking
const updateWithVersionCheck = async (disciplineCode, updates, expectedVersion) => {
  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .update({
      ...updates,
      version: expectedVersion + 1,
      updated_at: new Date().toISOString()
    })
    .eq('discipline_code', disciplineCode)
    .eq('version', expectedVersion)
    .select()
    .single();

  if (error) {
    if (error.code === 'PGRST116') { // No rows updated
      throw new Error('Version conflict - record was modified by another user');
    }
    throw error;
  }

  return data;
};
```

### **Delete Operations**

#### **Soft Delete (Recommended)**
```javascript
// Soft delete by deactivating
const deactivateDiscipline = async (disciplineCode) => {
  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .update({
      is_active: false,
      updated_at: new Date().toISOString()
    })
    .eq('discipline_code', disciplineCode)
    .select()
    .single();

  if (error) throw error;
  return data;
};
```

#### **Hard Delete (Use with Caution)**
```sql
-- Hard delete (only for data cleanup, not recommended for production)
DELETE FROM discipline_extraction_prompts
WHERE discipline_code = 'obsolete_discipline'
  AND is_active = false;
```

---

## 🔗 **INTEGRATION PATTERNS**

### **LangExtract Service Integration**

#### **Dynamic Prompt Selection**
```javascript
// LangExtract integration service
class DisciplinePromptService {
  constructor() {
    this.cache = new Map();
    this.cacheTimeout = 5 * 60 * 1000; // 5 minutes
  }

  async getPromptForDiscipline(disciplineCode, documentType = null) {
    const cacheKey = `${disciplineCode}:${documentType || 'all'}`;

    // Check cache
    if (this.cache.has(cacheKey)) {
      const cached = this.cache.get(cacheKey);
      if (Date.now() - cached.timestamp < this.cacheTimeout) {
        return cached.data;
      }
    }

    // Fetch from database
    const { data, error } = await supabase
      .from('discipline_extraction_prompts')
      .select('system_prompt, extraction_fields, extraction_focus')
      .eq('discipline_code', disciplineCode)
      .eq('is_active', true)
      .single();

    if (error) throw error;

    // Validate document type support if specified
    if (documentType && !data.document_types.includes(documentType)) {
      throw new Error(`Discipline ${disciplineCode} does not support document type ${documentType}`);
    }

    // Cache result
    this.cache.set(cacheKey, {
      data,
      timestamp: Date.now()
    });

    return data;
  }

  async getAllActiveDisciplines() {
    const { data, error } = await supabase
      .from('discipline_extraction_prompts')
      .select('discipline_code, display_name, document_types')
      .eq('is_active', true)
      .order('display_name');

    if (error) throw error;
    return data;
  }
}

export default new DisciplinePromptService();
```

#### **Multi-Discipline Processing**
```javascript
// Multi-discipline document processing
const processDocumentWithDisciplines = async (documentContent, selectedDisciplines) => {
  const results = [];

  for (const disciplineCode of selectedDisciplines) {
    try {
      const promptData = await disciplinePromptService.getPromptForDiscipline(disciplineCode);

      const langExtractResult = await langExtractService.extract(documentContent, {
        systemPrompt: promptData.system_prompt,
        extractionFields: promptData.extraction_fields,
        extractionFocus: promptData.extraction_focus,
        discipline: disciplineCode
      });

      results.push({
        discipline: disciplineCode,
        success: true,
        data: langExtractResult,
        version: promptData.version
      });

    } catch (error) {
      results.push({
        discipline: disciplineCode,
        success: false,
        error: error.message
      });
    }
  }

  return results;
};
```

### **HITL Workflow Integration**

#### **Discipline Context Provision**
```javascript
// HITL context builder
const buildHITLContext = async (taskId, documentId, disciplines) => {
  const context = {
    taskId,
    documentId,
    disciplines: [],
    timestamp: new Date().toISOString()
  };

  for (const disciplineCode of disciplines) {
    const config = await disciplinePromptService.getPromptForDiscipline(disciplineCode);

    context.disciplines.push({
      code: disciplineCode,
      displayName: await getDisciplineDisplayName(disciplineCode),
      systemPrompt: config.system_prompt,
      extractionFields: config.extraction_fields,
      extractionFocus: config.extraction_focus,
      guidance: generateHITLGuidance(config)
    });
  }

  return context;
};

const generateHITLGuidance = (config) => {
  return {
    focusAreas: `Focus on: ${config.extraction_focus.join(', ')}`,
    keyFields: `Extract: ${config.extraction_fields.join(', ')}`,
    reviewCriteria: 'Ensure all discipline-specific requirements are addressed'
  };
};
```

### **Search and Indexing Integration**

#### **Discipline-Based Search Enhancement**
```javascript
// Search index enrichment
const enrichSearchIndex = async (documentId, disciplineCodes) => {
  const enrichmentData = [];

  for (const disciplineCode of disciplineCodes) {
    const config = await disciplinePromptService.getPromptForDiscipline(disciplineCode);

    enrichmentData.push({
      documentId,
      discipline: disciplineCode,
      focusKeywords: config.extraction_focus,
      fieldMappings: config.extraction_fields,
      indexedAt: new Date().toISOString()
    });
  }

  // Bulk insert into search index
  const { error } = await supabase
    .from('document_search_index')
    .insert(enrichmentData);

  if (error) throw error;

  return enrichmentData.length;
};
```

---

## 📊 **DATA MANAGEMENT AND GOVERNANCE**

### **Version Control Strategy**

#### **Semantic Versioning for Prompts**
```javascript
// Version management
const versionPromptUpdate = async (disciplineCode, newPrompt, changeType = 'patch') => {
  // Get current version
  const { data: current } = await supabase
    .from('discipline_extraction_prompts')
    .select('version')
    .eq('discipline_code', disciplineCode)
    .single();

  let newVersion;
  switch (changeType) {
    case 'major':
      newVersion = Math.floor(current.version / 100) * 100 + 100;
      break;
    case 'minor':
      newVersion = Math.floor(current.version / 10) * 10 + 10;
      break;
    case 'patch':
    default:
      newVersion = current.version + 1;
      break;
  }

  // Update with new version
  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .update({
      system_prompt: newPrompt,
      version: newVersion,
      updated_at: new Date().toISOString()
    })
    .eq('discipline_code', disciplineCode)
    .select()
    .single();

  if (error) throw error;

  // Log version change
  await logVersionChange(disciplineCode, current.version, newVersion, changeType);

  return data;
};
```

### **Audit and Compliance**

#### **Change Tracking**
```javascript
// Audit logging
const logPromptChange = async (disciplineCode, action, details) => {
  const { error } = await supabase
    .from('discipline_prompts_audit')
    .insert({
      discipline_code: disciplineCode,
      action,
      details,
      changed_by: supabase.auth.user()?.id,
      changed_at: new Date().toISOString()
    });

  if (error) throw error;
};

// Usage examples
await logPromptChange('civil', 'UPDATE', {
  field: 'system_prompt',
  oldVersion: 1,
  newVersion: 2,
  changeSummary: 'Updated foundation analysis requirements'
});
```

### **Data Validation**

#### **Prompt Quality Assurance**
```javascript
// Validation functions
const validatePromptData = (data) => {
  const errors = [];

  // Required fields
  if (!data.discipline_code) errors.push('discipline_code is required');
  if (!data.display_name) errors.push('display_name is required');
  if (!data.system_prompt) errors.push('system_prompt is required');

  // Data type validation
  if (data.extraction_fields && !Array.isArray(data.extraction_fields)) {
    errors.push('extraction_fields must be an array');
  }

  if (data.extraction_focus && !Array.isArray(data.extraction_focus)) {
    errors.push('extraction_focus must be an array');
  }

  if (data.document_types && !Array.isArray(data.document_types)) {
    errors.push('document_types must be an array');
  }

  // Content validation
  if (data.system_prompt && data.system_prompt.length < 50) {
    errors.push('system_prompt must be at least 50 characters');
  }

  return {
    isValid: errors.length === 0,
    errors
  };
};

// Usage in create/update operations
const createValidatedPrompt = async (promptData) => {
  const validation = validatePromptData(promptData);

  if (!validation.isValid) {
    throw new Error(`Validation failed: ${validation.errors.join(', ')}`);
  }

  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .insert(promptData)
    .select()
    .single();

  if (error) throw error;
  return data;
};
```

---

## 🔍 **MONITORING AND ANALYTICS**

### **Usage Tracking**

#### **Access Pattern Monitoring**
```javascript
// Usage tracking
const trackPromptUsage = async (disciplineCode, operation, context = {}) => {
  const { error } = await supabase
    .from('discipline_prompts_usage')
    .insert({
      discipline_code: disciplineCode,
      operation, // 'read', 'training', 'extraction', etc.
      context: JSON.stringify(context),
      used_at: new Date().toISOString(),
      used_by: supabase.auth.user()?.id
    });

  if (error) console.warn('Failed to track usage:', error);
};

// Usage examples
await trackPromptUsage('civil', 'extraction', {
  documentType: 'correspondence',
  fieldCount: 5
});

await trackPromptUsage('electrical', 'training', {
  modelVersion: 'v2.1',
  trainingSize: 1000
});
```

### **Performance Metrics**

#### **Query Performance Dashboard**
```javascript
// Performance monitoring
const getPromptPerformanceMetrics = async (timeRange = '24 hours') => {
  const { data, error } = await supabase
    .rpc('get_discipline_prompts_metrics', {
      time_range: timeRange
    });

  if (error) throw error;

  return {
    totalQueries: data.total_queries,
    averageResponseTime: data.avg_response_time,
    cacheHitRate: data.cache_hit_rate,
    errorRate: data.error_rate,
    topDisciplines: data.top_disciplines,
    slowQueries: data.slow_queries
  };
};
```

---

## 🧪 **TESTING AND VALIDATION**

### **Data Integrity Tests**

#### **Prompt Validation Suite**
```javascript
// Test suite for prompt data
describe('Discipline Prompts Data Integrity', () => {
  test('all active prompts have required fields', async () => {
    const prompts = await getActiveDisciplines();

    for (const prompt of prompts) {
      expect(prompt.discipline_code).toBeDefined();
      expect(prompt.display_name).toBeDefined();
      expect(prompt.system_prompt).toBeDefined();
      expect(Array.isArray(prompt.extraction_fields)).toBe(true);
      expect(Array.isArray(prompt.extraction_focus)).toBe(true);
    }
  });

  test('discipline codes are unique', async () => {
    const { data, error } = await supabase
      .from('discipline_extraction_prompts')
      .select('discipline_code');

    const codes = data.map(d => d.discipline_code);
    const uniqueCodes = [...new Set(codes)];

    expect(codes.length).toBe(uniqueCodes.length);
  });

  test('version numbers increment correctly', async () => {
    // Test version update logic
    const initialVersion = 1;
    const updated = await updateDisciplineConfig('civil', {
      system_prompt: 'Updated prompt for testing'
    });

    expect(updated.version).toBeGreaterThan(initialVersion);
  });
});
```

### **Integration Tests**

#### **End-to-End Validation**
```javascript
// Integration test for LangExtract workflow
test('discipline prompt integration with LangExtract', async () => {
  const testDocument = 'Sample civil engineering specification...';

  // Get discipline configuration
  const civilConfig = await getDisciplineConfig('civil', 'specification');
  expect(civilConfig).toBeDefined();

  // Test LangExtract integration
  const result = await langExtractService.extract(testDocument, {
    systemPrompt: civilConfig.systemPrompt,
    extractionFields: civilConfig.extractionFields
  });

  expect(result).toHaveProperty('entities');
  expect(result).toHaveProperty('keyPhrases');
  expect(result).toHaveProperty('processingMetadata');
});
```

---

## 🚀 **DEPLOYMENT AND MIGRATION**

### **Initial Data Population**

#### **Migration Script Execution**
```sql
-- Execute the migration
\i sql/migrate/20260110_add_discipline_extraction_prompts.sql

-- Verify table creation
SELECT table_name FROM information_schema.tables
WHERE table_name = 'discipline_extraction_prompts';

-- Verify data insertion
SELECT COUNT(*) as prompt_count FROM discipline_extraction_prompts;
SELECT discipline_code, display_name, version FROM discipline_extraction_prompts ORDER BY display_name;
```

### **Data Migration Patterns**

#### **Upgrading Existing Configurations**
```javascript
// Migration script for updating existing data
const migrateExistingPrompts = async () => {
  const { data: existingPrompts, error } = await supabase
    .from('discipline_extraction_prompts')
    .select('*');

  if (error) throw error;

  const updates = [];

  for (const prompt of existingPrompts) {
    // Add new fields or update existing ones
    updates.push({
      id: prompt.id,
      version: prompt.version + 1,
      // Add any new required fields
      document_types: prompt.document_types || ['correspondence', 'specification'],
      updated_at: new Date().toISOString()
    });
  }

  // Bulk update
  const { error: updateError } = await supabase
    .from('discipline_extraction_prompts')
    .upsert(updates);

  if (updateError) throw updateError;

  console.log(`Migrated ${updates.length} discipline prompts`);
};
```

---

## 🔧 **MAINTENANCE PROCEDURES**

### **Regular Maintenance Tasks**

#### **Monthly Review Process**
```javascript
// Monthly prompt effectiveness review
const reviewPromptEffectiveness = async () => {
  const thirtyDaysAgo = new Date();
  thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

  // Get usage statistics
  const { data: usageStats, error } = await supabase
    .from('discipline_prompts_usage')
    .select('discipline_code, operation, COUNT(*) as usage_count')
    .gte('used_at', thirtyDaysAgo.toISOString())
    .groupBy('discipline_code, operation');

  if (error) throw error;

  // Analyze and report
  const report = generateEffectivenessReport(usageStats);

  // Send to administrators
  await sendMaintenanceReport(report);

  return report;
};
```

#### **Cleanup Procedures**
```javascript
// Remove old inactive records (after 1 year)
const cleanupInactivePrompts = async () => {
  const oneYearAgo = new Date();
  oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);

  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .delete()
    .eq('is_active', false)
    .lt('updated_at', oneYearAgo.toISOString())
    .select();

  if (error) throw error;

  console.log(`Cleaned up ${data.length} inactive discipline prompts`);

  // Log cleanup action
  await logMaintenanceAction('cleanup', {
    recordsRemoved: data.length,
    cutoffDate: oneYearAgo.toISOString()
  });
};
```

---

## 📈 **PERFORMANCE OPTIMIZATION**

### **Caching Strategies**

#### **Application-Level Caching**
```javascript
// Redis/in-memory cache implementation
class PromptCache {
  constructor(redisClient = null) {
    this.redis = redisClient;
    this.localCache = new Map();
    this.cacheTTL = 10 * 60 * 1000; // 10 minutes
  }

  async get(disciplineCode) {
    // Try Redis first
    if (this.redis) {
      const cached = await this.redis.get(`discipline_prompt:${disciplineCode}`);
      if (cached) return JSON.parse(cached);
    }

    // Try local cache
    const local = this.localCache.get(disciplineCode);
    if (local && Date.now() - local.timestamp < this.cacheTTL) {
      return local.data;
    }

    return null;
  }

  async set(disciplineCode, data) {
    const cacheData = {
      data,
      timestamp: Date.now()
    };

    // Set in local cache
    this.localCache.set(disciplineCode, cacheData);

    // Set in Redis if available
    if (this.redis) {
      await this.redis.setex(
        `discipline_prompt:${disciplineCode}`,
        this.cacheTTL / 1000, // Redis expects seconds
        JSON.stringify(data)
      );
    }
  }

  async invalidate(disciplineCode) {
    this.localCache.delete(disciplineCode);
    if (this.redis) {
      await this.redis.del(`discipline_prompt:${disciplineCode}`);
    }
  }
}
```

### **Query Optimization**

#### **Efficient Bulk Operations**
```javascript
// Optimized bulk retrieval
const getMultipleDisciplineConfigs = async (disciplineCodes) => {
  const { data, error } = await supabase
    .from('discipline_extraction_prompts')
    .select('discipline_code, system_prompt, extraction_fields, extraction_focus, version')
    .in('discipline_code', disciplineCodes)
    .eq('is_active', true);

  if (error) throw error;

  // Convert to map for fast lookup
  const configMap = new Map();
  data.forEach(config => {
    configMap.set(config.discipline_code, config);
  });

  return configMap;
};

// Usage
const configs = await getMultipleDisciplineConfigs(['civil', 'structural', 'electrical']);
const civilConfig = configs.get('civil');
```

---

## 🚨 **TROUBLESHOOTING**

### **Common Issues and Solutions**

#### **Data Consistency Problems**
```javascript
// Check for data consistency
const validateDataConsistency = async () => {
  const issues = [];

  // Check for duplicate discipline codes
  const { data: duplicates } = await supabase
    .rpc('find_duplicate_discipline_codes');

  if (duplicates.length > 0) {
    issues.push({
      type: 'DUPLICATE_CODES',
      severity: 'HIGH',
      details: duplicates
    });
  }

  // Check for missing required fields
  const { data: incomplete } = await supabase
    .from('discipline_extraction_prompts')
    .select('id, discipline_code')
    .or('system_prompt.is.null,display_name.is.null')
    .eq('is_active', true);

  if (incomplete.length > 0) {
    issues.push({
      type: 'MISSING_FIELDS',
      severity: 'HIGH',
      details: incomplete
    });
  }

  return issues;
};
```

#### **Performance Issues**
```javascript
// Diagnose slow queries
const diagnosePerformance = async () => {
  // Check index usage
  const { data: indexStats } = await supabase
    .rpc('get_index_usage_stats');

  // Check query performance
  const { data: slowQueries } = await supabase
    .rpc('get_slow_queries', {
      threshold_ms: 1000
    });

  return {
    indexStats,
    slowQueries,
    recommendations: generatePerformanceRecommendations(indexStats, slowQueries)
  };
};
```

---

## 📋 **CROSS-REFERENCES**

### **Related Procedures**
- → `00435_LANGEXTRACT_INTEGRATION_PROCEDURE.md` - LangExtract service integration patterns
- → `0000_WORKFLOW_HITL_PROCEDURE.md` - Human-in-the-loop workflow procedures
- → `0000_QWEN_FINETUNING_PROCEDURE.md` - AI model training procedures
- → `sql/migrate/20260110_add_discipline_extraction_prompts.sql` - Database migration reference

### **Related Schemas**
- → `docs/schema/schema-part-01.md` - Core database schema documentation
- → `docs/schema/schema-part-04.md` - User and authentication schemas

---

## 🎯 **SUCCESS METRICS**

### **Data Quality Metrics**
- **Completeness**: 100% of active records have all required fields
- **Consistency**: 0 duplicate discipline codes
- **Validity**: All JSONB fields contain valid arrays
- **Version Control**: All changes properly versioned

### **Performance Metrics**
- **Query Response Time**: <100ms for single discipline retrieval
- **Cache Hit Rate**: >90% for frequently accessed prompts
- **Bulk Operation Time**: <500ms for multi-discipline retrieval

### **Usage Metrics**
- **Active Disciplines**: All configured disciplines actively used
- **Integration Coverage**: 100% of processing workflows use discipline prompts
- **Update Frequency**: Regular prompt updates based on performance data

---

## 🔄 **VERSION HISTORY**

| **Version** | **Date** | **Changes** | **Author** |
|-------------|----------|-------------|------------|
| 1.0 | 2026-01-10 | Initial procedure creation | System |
| 1.1 | 2026-10-01 | Added integration patterns and monitoring | AI Assistant |

---

## ✅ **IMPLEMENTATION CHECKLIST**

### **Database Setup**
- [x] Table created with proper schema
- [x] Indexes configured for performance
- [x] RLS policies implemented
- [x] Initial data populated

### **Core Functionality**
- [x] CRUD operations implemented
- [x] Validation logic in place
- [x] Version control system
- [x] Audit logging configured

### **Integration Points**
- [x] LangExtract service integration
- [x] HITL workflow integration
- [x] Search enhancement integration
- [x] Training pipeline integration

### **Monitoring & Maintenance**
- [x] Usage tracking implemented
- [x] Performance monitoring active
- [x] Data validation checks
- [x] Cleanup procedures defined

### **Documentation**
- [x] API reference documented
- [x] Integration examples provided
- [x] Troubleshooting guide included
- [x] Maintenance procedures outlined

---

## 🎉 **CONCLUSION**

The `discipline_extraction_prompts` database table serves as a robust foundation for discipline-specific data storage and processing across the Construct AI platform. This procedure provides comprehensive guidance for:

- **Data Management**: CRUD operations, validation, and version control
- **Integration**: Seamless connection with LangExtract, HITL, and training workflows
- **Performance**: Optimized queries, caching, and monitoring
- **Governance**: Audit trails, compliance, and maintenance procedures

**Key Benefits:**
- **Scalability**: Supports dynamic discipline configuration
- **Flexibility**: Adaptable to various use cases (training, extraction, processing)
- **Reliability**: Comprehensive error handling and fallback mechanisms
- **Maintainability**: Clear procedures for updates and maintenance

**Next Steps:**
1. Implement the caching layer for improved performance
2. Set up automated monitoring dashboards
3. Create discipline-specific prompt optimization workflows
4. Establish regular review cycles for prompt effectiveness

This database-backed approach ensures consistent, maintainable, and scalable discipline-specific processing across all Construct AI workflows.