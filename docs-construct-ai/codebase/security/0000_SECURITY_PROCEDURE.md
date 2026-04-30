---
memory_layer: durable_knowledge
para_section: pages/codebase/security
gigabrain_tags: security, codebase, compliance
documentation
openstinger_context: security-practices, compliance-requirements
last_updated: 2026-03-21
related_docs:
  - codebase/security/
  - disciplines/
---
# 0000_SECURITY_PROCEDURE.md - Security Procedure

## Document Information

- **Document ID**: `0000_SECURITY_PROCEDURE`
- **Version**: 1.0
- **Created**: 2026-01-23
- **Last Updated**: 2026-01-23
- **Author**: AI Assistant (Construct AI)
- **Review Cycle**: Monthly
- **Classification**: Security Procedure
- **Related Documents**:
  - `0000_API_KEY_SECURITY_MIGRATION_PROCEDURE.md` - API key security implementation
  - `0000_ROLES_AGENT_IMPLEMENTATION_PROCEDURE.md` - Agent security and confinement
  - `0000_ROLES_USER_IMPLEMENTATION_PROCEDURE.md` - User access control
  - `docs/procedures/0000_PRIVACY_PROCEDURE.md` - Privacy and compliance

---

## Overview

This procedure establishes comprehensive security practices for the Construct AI system, covering AI model security, data protection, access control, and compliance requirements. The goal is to maintain enterprise-grade security while enabling AI functionality.

**Critical Security**: AI systems introduce unique security challenges that must be addressed proactively to prevent unauthorized access, data breaches, and malicious model manipulation.

---

## Security Architecture

### **Defense in Depth Strategy**

```
┌─────────────────────────────────────────────────────────────┐
│                    ENTERPRISE SECURITY LAYERS               │
├─────────────────────────────────────────────────────────────┤
│  🔐 Access Control      🛡️  Data Protection    🚨 Monitoring │
│  - Authentication       - Encryption          - Audit Logs  │
│  - Authorization        - Tokenization        - Alerts      │
│  - Session Management   - Masking             - SIEM        │
├─────────────────────────────────────────────────────────────┤
│  🤖 AI-Specific Security                                    │
│  - Model Poisoning Protection                               │
│  - Prompt Injection Defense                                 │
│  - Output Sanitization                                      │
│  - Model Access Control                                     │
└─────────────────────────────────────────────────────────────┘
```

### **Security Domains**

- **Authentication & Authorization**: User and system access control
- **Data Security**: Information protection and privacy
- **AI Model Security**: Specialized protections for machine learning models
- **Network Security**: Communication and API security
- **Monitoring & Compliance**: Security monitoring and regulatory compliance

---

## Authentication & Authorization

### **Multi-Factor Authentication (MFA)**

#### **Implementation Requirements**
```javascript
// MFA configuration for user authentication
const mfaConfig = {
  required: true,
  methods: ['TOTP', 'SMS', 'Email'],
  backupCodes: true,
  gracePeriod: 7 * 24 * 60 * 60 * 1000, // 7 days
  maxAttempts: 5,
  lockoutDuration: 15 * 60 * 1000, // 15 minutes
  rememberDevice: {
    enabled: true,
    duration: 30 * 24 * 60 * 60 * 1000 // 30 days
  }
};

// MFA verification middleware
async function verifyMFA(req, res, next) {
  const userId = req.user.id;
  const mfaToken = req.headers['x-mfa-token'];

  // Check if MFA is required for this user
  const userMFA = await getUserMFAStatus(userId);
  if (!userMFA.enabled) {
    return next();
  }

  // Verify MFA token
  const isValid = await verifyMFAToken(userId, mfaToken);
  if (!isValid) {
    return res.status(401).json({
      error: 'MFA verification failed',
      retryAfter: 30
    });
  }

  next();
}
```

#### **MFA Policy Enforcement**
```sql
-- MFA compliance monitoring
SELECT
  u.email,
  u.mfa_enabled,
  u.last_login,
  CASE
    WHEN u.mfa_enabled = false THEN 'NON_COMPLIANT'
    WHEN u.last_mfa_verification < NOW() - INTERVAL '30 days' THEN 'EXPIRED'
    ELSE 'COMPLIANT'
  END as mfa_status
FROM users u
WHERE u.active = true
ORDER BY
  CASE
    WHEN u.mfa_enabled = false THEN 1
    WHEN u.last_mfa_verification < NOW() - INTERVAL '30 days' THEN 2
    ELSE 3
  END;
```

### **Role-Based Access Control (RBAC)**

#### **Security Role Definitions**
```javascript
// Security role hierarchy
const securityRoles = {
  super_admin: {
    level: 100,
    permissions: ['*'],
    restrictions: [],
    mfaRequired: true,
    auditRequired: true
  },
  security_admin: {
    level: 90,
    permissions: [
      'security.view',
      'security.manage',
      'audit.view',
      'users.manage_security',
      'models.security_review'
    ],
    restrictions: ['super_admin_only'],
    mfaRequired: true,
    auditRequired: true
  },
  model_admin: {
    level: 80,
    permissions: [
      'models.view',
      'models.deploy',
      'models.monitor',
      'training.approve'
    ],
    restrictions: ['security_critical'],
    mfaRequired: true,
    auditRequired: true
  },
  data_scientist: {
    level: 70,
    permissions: [
      'models.view',
      'training.create',
      'data.analyze',
      'experiments.run'
    ],
    restrictions: ['production_models', 'security_data'],
    mfaRequired: false,
    auditRequired: false
  },
  user: {
    level: 10,
    permissions: [
      'models.infer',
      'data.view_own'
    ],
    restrictions: ['admin_functions', 'security_data'],
    mfaRequired: false,
    auditRequired: false
  }
};

// Permission checking utility
function hasPermission(user, permission) {
  const userRole = securityRoles[user.role];
  if (!userRole) return false;

  // Check explicit permissions
  if (userRole.permissions.includes('*')) return true;
  if (userRole.permissions.includes(permission)) return true;

  // Check restrictions
  if (userRole.restrictions.some(restrict => permission.includes(restrict))) {
    return false;
  }

  return false;
}
```

#### **Access Control Lists (ACLs)**
```sql
-- Model access control list
CREATE TABLE model_acl (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  model_id UUID REFERENCES models(id),
  user_id UUID REFERENCES users(id),
  role VARCHAR(50) NOT NULL,
  permissions JSONB NOT NULL DEFAULT '[]',
  granted_by UUID REFERENCES users(id),
  granted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  expires_at TIMESTAMP WITH TIME ZONE,
  is_active BOOLEAN DEFAULT true,

  UNIQUE(model_id, user_id, role)
);

-- ACL checking function
CREATE OR REPLACE FUNCTION check_model_access(
  p_model_id UUID,
  p_user_id UUID,
  p_required_permission VARCHAR
) RETURNS BOOLEAN AS $$
DECLARE
  user_permissions JSONB;
BEGIN
  -- Get user permissions for this model
  SELECT permissions INTO user_permissions
  FROM model_acl
  WHERE model_id = p_model_id
    AND user_id = p_user_id
    AND is_active = true
    AND (expires_at IS NULL OR expires_at > NOW());

  -- Check if permission exists
  IF user_permissions IS NULL THEN
    RETURN false;
  END IF;

  RETURN user_permissions ? p_required_permission;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

---

## AI Model Security

### **Model Poisoning Protection**

#### **Input Validation & Sanitization**
```javascript
// AI model input sanitization
class ModelInputSanitizer {
  constructor() {
    this.maxLength = 2048;
    this.forbiddenPatterns = [
      /<script[^>]*>.*?<\/script>/gi,
      /javascript:/gi,
      /data:text\/html/gi,
      /vbscript:/gi,
      /onload\s*=/gi,
      /onerror\s*=/gi
    ];
    this.allowedDomains = ['construct.ai', 'trusted-domain.com'];
  }

  sanitizeInput(input, context = {}) {
    if (!input || typeof input !== 'string') {
      throw new Error('Invalid input: must be non-empty string');
    }

    // Length validation
    if (input.length > this.maxLength) {
      throw new Error(`Input too long: ${input.length} > ${this.maxLength}`);
    }

    // Remove potentially harmful patterns
    let sanitized = input;
    for (const pattern of this.forbiddenPatterns) {
      sanitized = sanitized.replace(pattern, '[FILTERED]');
    }

    // URL validation if present
    sanitized = this.validateAndSanitizeURLs(sanitized);

    // Context-specific validation
    if (context.discipline) {
      sanitized = this.validateDisciplineContent(sanitized, context.discipline);
    }

    return sanitized;
  }

  validateAndSanitizeURLs(text) {
    const urlRegex = /https?:\/\/[^\s]+/g;
    return text.replace(urlRegex, (url) => {
      try {
        const urlObj = new URL(url);
        const domain = urlObj.hostname.toLowerCase();

        // Check if domain is allowed
        if (!this.allowedDomains.some(allowed => domain.includes(allowed))) {
          return '[URL_FILTERED]';
        }

        return url;
      } catch {
        return '[INVALID_URL]';
      }
    });
  }

  validateDisciplineContent(content, discipline) {
    // Discipline-specific content validation
    const disciplineRules = {
      'safety': {
        maxRiskWords: 10,
        forbiddenWords: ['dangerous', 'hazardous', 'toxic']
      },
      'contracts': {
        maxLegalTerms: 50,
        requiredDisclaimer: true
      }
    };

    const rules = disciplineRules[discipline];
    if (!rules) return content;

    // Apply discipline-specific rules
    // Implementation would include specific validation logic

    return content;
  }
}
```

#### **Output Sanitization & Filtering**
```javascript
// AI model output sanitization
class ModelOutputSanitizer {
  constructor() {
    this.confidenceThreshold = 0.8;
    this.sensitivityPatterns = [
      /\b\d{3}-\d{2}-\d{4}\b/g,  // SSN pattern
      /\b\d{4} \d{4} \d{4} \d{4}\b/g,  // Credit card pattern
      /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/g  // Email pattern
    ];
    this.maxOutputLength = 4096;
  }

  sanitizeOutput(output, metadata = {}) {
    if (!output || typeof output !== 'string') {
      throw new Error('Invalid output: must be string');
    }

    let sanitized = output;

    // Confidence validation
    if (metadata.confidence < this.confidenceThreshold) {
      sanitized = this.addLowConfidenceWarning(sanitized, metadata.confidence);
    }

    // Sensitive data filtering
    sanitized = this.filterSensitiveData(sanitized);

    // Length validation
    if (sanitized.length > this.maxOutputLength) {
      sanitized = sanitized.substring(0, this.maxOutputLength) + '...[TRUNCATED]';
    }

    // Content validation
    sanitized = this.validateContentAppropriateness(sanitized, metadata);

    return sanitized;
  }

  filterSensitiveData(text) {
    let filtered = text;

    for (const pattern of this.sensitivityPatterns) {
      filtered = filtered.replace(pattern, '[REDACTED]');
    }

    return filtered;
  }

  addLowConfidenceWarning(text, confidence) {
    const warning = `[LOW CONFIDENCE: ${(confidence * 100).toFixed(1)}%] `;
    return warning + text;
  }

  validateContentAppropriateness(content, metadata) {
    // Check for potentially harmful content
    const harmfulPatterns = [
      /harmful instructions/i,
      /illegal activities/i,
      /dangerous procedures/i
    ];

    for (const pattern of harmfulPatterns) {
      if (pattern.test(content)) {
        return '[CONTENT_FILTERED: Potentially harmful content detected]';
      }
    }

    return content;
  }
}
```

### **Model Access Control**

#### **Model Security Classifications**
```javascript
// Model security classification system
const modelSecurityLevels = {
  public: {
    level: 1,
    access: 'unrestricted',
    monitoring: 'basic',
    audit: false,
    encryption: false
  },
  internal: {
    level: 2,
    access: 'authenticated_users',
    monitoring: 'standard',
    audit: true,
    encryption: false
  },
  confidential: {
    level: 3,
    access: 'role_based',
    monitoring: 'enhanced',
    audit: true,
    encryption: true
  },
  restricted: {
    level: 4,
    access: 'approved_users_only',
    monitoring: 'comprehensive',
    audit: true,
    encryption: true,
    additionalControls: ['usage_approval', 'output_review']
  }
};

// Model security assessment
function assessModelSecurity(modelMetadata) {
  let securityLevel = 'public';

  // Assess based on training data sensitivity
  if (modelMetadata.containsPII) {
    securityLevel = 'restricted';
  } else if (modelMetadata.discipline === 'safety' || modelMetadata.discipline === 'contracts') {
    securityLevel = 'confidential';
  } else if (modelMetadata.isPublic) {
    securityLevel = 'public';
  } else {
    securityLevel = 'internal';
  }

  return {
    level: securityLevel,
    requirements: modelSecurityLevels[securityLevel],
    assessmentDate: new Date().toISOString(),
    assessedBy: 'automated_security_system'
  };
}
```

#### **Model Usage Auditing**
```sql
-- Model usage audit logging
CREATE TABLE model_usage_audit (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  model_id UUID REFERENCES models(id),
  user_id UUID REFERENCES users(id),
  session_id VARCHAR(255),
  input_hash VARCHAR(64), -- SHA256 hash of input
  output_hash VARCHAR(64), -- SHA256 hash of output
  tokens_used INTEGER,
  processing_time_ms INTEGER,
  confidence_score DECIMAL(3,2),
  security_flags JSONB DEFAULT '[]',
  ip_address INET,
  user_agent TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Partition by month for performance
CREATE TABLE model_usage_audit_y2026m01 PARTITION OF model_usage_audit
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

-- Security monitoring queries
CREATE OR REPLACE FUNCTION detect_suspicious_activity(
  p_user_id UUID,
  p_time_window INTERVAL DEFAULT INTERVAL '1 hour'
) RETURNS TABLE (
  activity_type VARCHAR(50),
  severity VARCHAR(20),
  details JSONB
) AS $$
BEGIN
  -- Detect rapid-fire requests (potential abuse)
  RETURN QUERY
  SELECT
    'rapid_requests'::VARCHAR(50) as activity_type,
    CASE
      WHEN COUNT(*) > 100 THEN 'high'
      WHEN COUNT(*) > 50 THEN 'medium'
      ELSE 'low'
    END as severity,
    jsonb_build_object(
      'request_count', COUNT(*),
      'time_window', p_time_window,
      'avg_interval', AVG(EXTRACT(EPOCH FROM (created_at - LAG(created_at) OVER (ORDER BY created_at))))
    ) as details
  FROM model_usage_audit
  WHERE user_id = p_user_id
    AND created_at > NOW() - p_time_window
  GROUP BY DATE_TRUNC('minute', created_at)
  HAVING COUNT(*) > 10;

  -- Detect unusual token usage patterns
  RETURN QUERY
  SELECT
    'unusual_token_usage'::VARCHAR(50) as activity_type,
    'medium'::VARCHAR(20) as severity,
    jsonb_build_object(
      'avg_tokens', AVG(tokens_used),
      'max_tokens', MAX(tokens_used),
      'user_avg', user_avg_tokens
    ) as details
  FROM model_usage_audit
  CROSS JOIN (
    SELECT AVG(tokens_used) as user_avg_tokens
    FROM model_usage_audit
    WHERE user_id = p_user_id
      AND created_at > NOW() - INTERVAL '30 days'
  ) user_stats
  WHERE user_id = p_user_id
    AND created_at > NOW() - p_time_window
    AND tokens_used > user_avg_tokens * 3; -- 3x normal usage

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

---

## Data Protection

### **Encryption Standards**

#### **Data at Rest Encryption**
```javascript
// Database encryption configuration
const encryptionConfig = {
  algorithm: 'AES-256-GCM',
  keyRotation: {
    enabled: true,
    interval: 90 * 24 * 60 * 60 * 1000, // 90 days
    overlap: 30 * 24 * 60 * 60 * 1000   // 30 days
  },
  keyManagement: {
    provider: 'AWS_KMS', // or 'Azure_KeyVault', 'GCP_KMS'
    region: process.env.AWS_REGION,
    keyId: process.env.KMS_KEY_ID
  },
  encryptedFields: [
    'user.email',
    'user.phone',
    'model.training_data',
    'api_keys.encrypted_key',
    'audit_logs.sensitive_data'
  ]
};

// Field-level encryption utility
class FieldEncryptor {
  constructor(config = encryptionConfig) {
    this.config = config;
    this.keyCache = new Map();
  }

  async encryptField(value, context = {}) {
    if (!value) return value;

    const key = await this.getCurrentKey();
    const iv = crypto.randomBytes(16);

    const cipher = crypto.createCipher(this.config.algorithm, key);
    cipher.setAAD(Buffer.from(context.field || 'default'));

    let encrypted = cipher.update(JSON.stringify(value), 'utf8', 'hex');
    encrypted += cipher.final('hex');

    const authTag = cipher.getAuthTag();

    return {
      encrypted: encrypted,
      iv: iv.toString('hex'),
      authTag: authTag.toString('hex'),
      keyVersion: this.currentKeyVersion,
      algorithm: this.config.algorithm
    };
  }

  async decryptField(encryptedData, context = {}) {
    const key = await this.getKeyByVersion(encryptedData.keyVersion);

    const decipher = crypto.createDecipher(encryptedData.algorithm, key);
    decipher.setAAD(Buffer.from(context.field || 'default'));
    decipher.setAuthTag(Buffer.from(encryptedData.authTag, 'hex'));

    let decrypted = decipher.update(encryptedData.encrypted, 'hex', 'utf8');
    decrypted += decipher.final('utf8');

    return JSON.parse(decrypted);
  }
}
```

#### **Data in Transit Encryption**
```javascript
// TLS configuration for API communications
const tlsConfig = {
  minVersion: 'TLSv1.3',
  maxVersion: 'TLSv1.3',
  ciphers: [
    'ECDHE-RSA-AES256-GCM-SHA384',
    'ECDHE-RSA-AES128-GCM-SHA256'
  ],
  certificate: {
    certFile: '/etc/ssl/certs/server.crt',
    keyFile: '/etc/ssl/private/server.key',
    caBundle: '/etc/ssl/certs/ca-bundle.crt'
  },
  hsts: {
    enabled: true,
    maxAge: 31536000, // 1 year
    includeSubdomains: true,
    preload: false
  },
  session: {
    timeout: 300, // 5 minutes
    resumption: true
  }
};

// API server TLS configuration
const httpsServer = https.createServer({
  cert: fs.readFileSync(tlsConfig.certificate.certFile),
  key: fs.readFileSync(tlsConfig.certificate.keyFile),
  ca: fs.readFileSync(tlsConfig.certificate.caBundle),
  minVersion: tlsConfig.minVersion,
  maxVersion: tlsConfig.maxVersion,
  ciphers: tlsConfig.ciphers.join(':'),
  secureOptions: crypto.constants.SSL_OP_NO_TLSv1 | crypto.constants.SSL_OP_NO_TLSv1_1
}, app);

// Security headers middleware
function securityHeaders(req, res, next) {
  // HSTS
  if (tlsConfig.hsts.enabled) {
    const hstsValue = `max-age=${tlsConfig.hsts.maxAge}`;
    if (tlsConfig.hsts.includeSubdomains) hstsValue += '; includeSubDomains';
    if (tlsConfig.hsts.preload) hstsValue += '; preload';
    res.setHeader('Strict-Transport-Security', hstsValue);
  }

  // Content Security Policy
  res.setHeader('Content-Security-Policy', "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'");

  // Other security headers
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('X-XSS-Protection', '1; mode=block');
  res.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');

  next();
}
```

### **Privacy by Design**

#### **Data Minimization**
```javascript
// Data collection minimization
class DataMinimizer {
  constructor() {
    this.retentionPolicies = {
      user_interactions: 365 * 24 * 60 * 60 * 1000, // 1 year
      model_usage_logs: 90 * 24 * 60 * 60 * 1000,  // 90 days
      training_data: 2555 * 24 * 60 * 60 * 1000,   // 7 years (legal requirement)
      audit_logs: 2555 * 24 * 60 * 60 * 1000,      // 7 years
      temp_files: 7 * 24 * 60 * 60 * 1000          // 7 days
    };
  }

  shouldCollect(field, context) {
    // Determine if field should be collected based on necessity
    const necessaryFields = [
      'user.id',        // Authentication
      'user.role',      // Authorization
      'model.discipline', // Functional requirement
      'timestamp',      // Audit requirement
      'ip_address'      // Security requirement
    ];

    const fieldPath = `${context.entity}.${field}`;
    return necessaryFields.some(necessary => fieldPath.includes(necessary));
  }

  scheduleDeletion(dataType, identifier) {
    const retentionPeriod = this.retentionPolicies[dataType];
    if (!retentionPeriod) return;

    const deletionDate = new Date(Date.now() + retentionPeriod);

    // Schedule deletion job
    scheduleDeletionJob({
      dataType,
      identifier,
      deletionDate,
      reason: 'retention_policy'
    });
  }

  anonymizeData(data, fieldsToAnonymize) {
    const anonymized = { ...data };

    for (const field of fieldsToAnonymize) {
      if (anonymized[field]) {
        anonymized[field] = this.anonymizeField(anonymized[field], field);
      }
    }

    return anonymized;
  }

  anonymizeField(value, fieldType) {
    // Field-specific anonymization
    switch (fieldType) {
      case 'email':
        return value.replace(/(.{2}).*@.*\.(.{2})/, '$1***@$1***.$2');
      case 'phone':
        return value.replace(/(\d{3})\d{3}(\d{4})/, '$1***$2');
      case 'ip_address':
        return value.replace(/(\d+\.\d+)\.\d+\.\d+/, '$1.*.*');
      default:
        return '[ANONYMIZED]';
    }
  }
}
```

---

## Security Monitoring & Incident Response

### **Security Information and Event Management (SIEM)**

#### **Real-time Security Monitoring**
```javascript
// SIEM integration and alerting
class SecurityMonitor {
  constructor() {
    this.alertThresholds = {
      failed_logins: { count: 5, window: 15 * 60 * 1000 },     // 5 in 15 min
      suspicious_requests: { count: 10, window: 60 * 1000 },   // 10 in 1 min
      model_access_denied: { count: 3, window: 5 * 60 * 1000 }, // 3 in 5 min
      data_exfiltration: { threshold: 1000000 },                // 1MB data transfer
      anomalous_tokens: { threshold: 50000 }                    // 50K tokens
    };

    this.incidentQueue = [];
    this.monitoringInterval = setInterval(() => {
      this.checkSecurityMetrics();
    }, 30000); // Check every 30 seconds
  }

  async checkSecurityMetrics() {
    const metrics = await this.collectSecurityMetrics();

    for (const [metricName, config] of Object.entries(this.alertThresholds)) {
      const violations = this.detectViolations(metrics[metricName], config);

      if (violations.length > 0) {
        await this.createSecurityIncident(metricName, violations);
      }
    }
  }

  async createSecurityIncident(metricName, violations) {
    const incident = {
      id: `sec_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
      type: 'security_violation',
      metric: metricName,
      severity: this.calculateSeverity(metricName, violations),
      violations: violations,
      detectedAt: new Date().toISOString(),
      status: 'active',
      assignedTo: null,
      resolvedAt: null
    };

    this.incidentQueue.push(incident);

    // Immediate alerting for high/critical incidents
    if (incident.severity === 'high' || incident.severity === 'critical') {
      await this.sendImmediateAlert(incident);
    }

    // Log to security audit
    await this.logSecurityEvent(incident);
  }

  calculateSeverity(metricName, violations) {
    // Severity calculation based on metric type and violation count
    const severityMatrix = {
      failed_logins: { 1: 'low', 5: 'medium', 10: 'high', 20: 'critical' },
      suspicious_requests: { 1: 'low', 5: 'medium', 15: 'high', 30: 'critical' },
      model_access_denied: { 1: 'low', 3: 'medium', 10: 'high', 20: 'critical' },
      data_exfiltration: { 1000000: 'medium', 10000000: 'high', 100000000: 'critical' },
      anomalous_tokens: { 10000: 'low', 50000: 'medium', 100000: 'high', 500000: 'critical' }
    };

    const matrix = severityMatrix[metricName];
    const violationCount = violations.length;

    for (const [threshold, severity] of Object.entries(matrix).sort((a, b) => parseInt(b[0]) - parseInt(a[0]))) {
      if (violationCount >= parseInt(threshold)) {
        return severity;
      }
    }

    return 'low';
  }

  async sendImmediateAlert(incident) {
    // Send alerts via multiple channels
    const alertMessage = {
      subject: `🚨 SECURITY INCIDENT: ${incident.metric.toUpperCase()}`,
      body: `
Security incident detected:

Type: ${incident.type}
Metric: ${incident.metric}
Severity: ${incident.severity.toUpperCase()}
Violations: ${incident.violations.length}
Time: ${incident.detectedAt}

Please investigate immediately.
      `,
      channels: ['email', 'slack', 'sms']
    };

    await this.distributeAlert(alertMessage);
  }
}
```

#### **Incident Response Procedures**
```javascript
// Automated incident response system
class IncidentResponseCoordinator {
  constructor() {
    this.responsePlaybooks = {
      failed_logins: this.handleBruteForceAttack.bind(this),
      suspicious_requests: this.handleSuspiciousActivity.bind(this),
      model_access_denied: this.handleUnauthorizedAccess.bind(this),
      data_exfiltration: this.handleDataBreach.bind(this),
      anomalous_tokens: this.handleResourceAbuse.bind(this)
    };
  }

  async coordinateResponse(incident) {
    console.log(`🚨 Coordinating response for incident: ${incident.id}`);

    const playbook = this.responsePlaybooks[incident.metric];
    if (playbook) {
      await playbook(incident);
    } else {
      await this.defaultResponse(incident);
    }

    // Escalate if needed
    if (incident.severity === 'critical') {
      await this.escalateToSecurityTeam(incident);
    }
  }

  async handleBruteForceAttack(incident) {
    // Automated response for brute force attacks
    const affectedUsers = incident.violations.map(v => v.userId);

    for (const userId of affectedUsers) {
      // Temporarily lock account
      await this.lockUserAccount(userId, 15 * 60 * 1000); // 15 minutes

      // Force MFA reset
      await this.resetUserMFA(userId);

      // Notify user
      await this.notifyUserOfSuspiciousActivity(userId, incident);
    }

    // Block suspicious IPs
    const suspiciousIPs = [...new Set(incident.violations.map(v => v.ipAddress))];
    for (const ip of suspiciousIPs) {
      await this.blockIPAddress(ip, 60 * 60 * 1000); // 1 hour
    }
  }

  async handleUnauthorizedAccess(incident) {
    // Response for unauthorized model access attempts
    const affectedModels = incident.violations.map(v => v.modelId);

    for (const modelId of affectedModels) {
      // Increase access logging
      await this.enableEnhancedLogging(modelId);

      // Review and tighten permissions
      await this.auditModelPermissions(modelId);
    }

    // Alert model owners
    await this.notifyModelOwners(affectedModels, incident);
  }

  async handleDataBreach(incident) {
    // Critical response for potential data breaches
    console.log('🚨 CRITICAL: Potential data breach detected');

    // Immediate containment
    await this.enableEmergencyMode();

    // Preserve evidence
    await this.createForensicSnapshot(incident);

    // Notify authorities if required
    await this.assessBreachNotificationRequirements(incident);

    // Escalate to executive team
    await this.notifyExecutiveTeam(incident);
  }

  async defaultResponse(incident) {
    // Generic incident response
    await this.logIncident(incident);
    await this.notifySecurityTeam(incident);
    await this.createInvestigationTicket(incident);
  }
}
```

---

## Compliance & Audit

### **Regulatory Compliance Monitoring**

#### **Automated Compliance Checks**
```javascript
// Compliance monitoring system
class ComplianceMonitor {
  constructor() {
    this.frameworks = {
      'GDPR': this.checkGDPRCompliance.bind(this),
      'CCPA': this.checkCCPACompliance.bind(this),
      'ISO27001': this.checkISO27001Compliance.bind(this),
      'SOC2': this.checkSOC2Compliance.bind(this)
    };

    this.complianceSchedule = {
      'GDPR': 365,      // Annual
      'CCPA': 365,      // Annual
      'ISO27001': 365,  // Annual
      'SOC2': 365       // Annual
    };
  }

  async runComplianceAudit(framework = null) {
    const results = {
      auditId: `audit_${Date.now()}`,
      timestamp: new Date().toISOString(),
      frameworks: {},
      overallCompliance: true,
      criticalFindings: [],
      recommendations: []
    };

    const frameworksToCheck = framework ? [framework] : Object.keys(this.frameworks);

    for (const fw of frameworksToCheck) {
      console.log(`📋 Checking ${fw} compliance...`);

      try {
        const complianceResult = await this.frameworks[fw]();
        results.frameworks[fw] = complianceResult;

        if (!complianceResult.compliant) {
          results.overallCompliance = false;

          if (complianceResult.criticalFindings) {
            results.criticalFindings.push(...complianceResult.criticalFindings);
          }
        }
      } catch (error) {
        console.error(`❌ Error checking ${fw} compliance:`, error);
        results.frameworks[fw] = {
          compliant: false,
          error: error.message,
          lastChecked: new Date().toISOString()
        };
        results.overallCompliance = false;
      }
    }

    // Generate recommendations
    results.recommendations = this.generateComplianceRecommendations(results);

    // Log audit results
    await this.logComplianceAudit(results);

    return results;
  }

  async checkGDPRCompliance() {
    const checks = {
      dataMinimization: await this.verifyDataMinimization(),
      consentManagement: await this.verifyConsentManagement(),
      dataSubjectRights: await this.verifyDataSubjectRights(),
      breachNotification: await this.verifyBreachNotification(),
      privacyByDesign: await this.verifyPrivacyByDesign()
    };

    const passedChecks = Object.values(checks).filter(Boolean).length;
    const totalChecks = Object.keys(checks).length;
    const complianceScore = (passedChecks / totalChecks) * 100;

    return {
      compliant: complianceScore >= 95,
      score: complianceScore,
      checks: checks,
      lastChecked: new Date().toISOString(),
      nextAudit: new Date(Date.now() + this.complianceSchedule.GDPR * 24 * 60 * 60 * 1000).toISOString()
    };
  }

  async checkISO27001Compliance() {
    const checks = {
      accessControl: await this.verifyAccessControl(),
      cryptography: await this.verifyCryptography(),
      physicalSecurity: await this.verifyPhysicalSecurity(),
      operationalSecurity: await this.verifyOperationalSecurity(),
      communicationsSecurity: await this.verifyCommunicationsSecurity(),
      supplierRelationships: await this.verifySupplierSecurity(),
      incidentManagement: await this.verifyIncidentManagement(),
      complianceMonitoring: await this.verifyComplianceMonitoring()
    };

    const passedChecks = Object.values(checks).filter(Boolean).length;
    const totalChecks = Object.keys(checks).length;
    const complianceScore = (passedChecks / totalChecks) * 100;

    return {
      compliant: complianceScore >= 95,
      score: complianceScore,
      checks: checks,
      lastChecked: new Date().toISOString(),
      nextAudit: new Date(Date.now() + this.complianceSchedule.ISO27001 * 24 * 60 * 60 * 1000).toISOString()
    };
  }

  generateComplianceRecommendations(auditResults) {
    const recommendations = [];

    for (const [framework, result] of Object.entries(auditResults.frameworks)) {
      if (!result.compliant) {
        recommendations.push(`Address ${framework} compliance gaps (Score: ${result.score.toFixed(1)}%)`);

        // Framework-specific recommendations
        if (framework === 'GDPR' && !result.checks.dataSubjectRights) {
          recommendations.push('Implement comprehensive data subject rights handling (GDPR Article 15-20)');
        }

        if (framework === 'ISO27001' && !result.checks.accessControl) {
          recommendations.push('Strengthen access control mechanisms (ISO 27001 A.9)');
        }
      }
    }

    return recommendations;
  }
}
```

---

## Security Incident Response

### **Incident Classification & Response**

#### **Incident Severity Matrix**
```javascript
// Incident classification system
const incidentSeverityMatrix = {
  // Authentication & Authorization Incidents
  brute_force_attack: {
    severity: 'high',
    responseTime: 15 * 60 * 1000, // 15 minutes
    notificationRequired: true,
    legalReporting: false
  },
  unauthorized_access: {
    severity: 'critical',
    responseTime: 5 * 60 * 1000, // 5 minutes
    notificationRequired: true,
    legalReporting: true
  },

  // Data Security Incidents
  data_breach: {
    severity: 'critical',
    responseTime: 1 * 60 * 1000, // 1 minute
    notificationRequired: true,
    legalReporting: true
  },
  data_exfiltration: {
    severity: 'high',
    responseTime: 10 * 60 * 1000, // 10 minutes
    notificationRequired: true,
    legalReporting: true
  },

  // AI Model Incidents
  model_poisoning: {
    severity: 'critical',
    responseTime: 2 * 60 * 1000, // 2 minutes
    notificationRequired: true,
    legalReporting: false
  },
  prompt_injection: {
    severity: 'medium',
    responseTime: 30 * 60 * 1000, // 30 minutes
    notificationRequired: false,
    legalReporting: false
  },

  // System Incidents
  ddos_attack: {
    severity: 'high',
    responseTime: 5 * 60 * 1000, // 5 minutes
    notificationRequired: true,
    legalReporting: false
  },
  system_compromise: {
    severity: 'critical',
    responseTime: 1 * 60 * 1000, // 1 minute
    notificationRequired: true,
    legalReporting: true
  }
};
```

#### **Incident Response Workflow**
```javascript
// Incident response orchestration
class IncidentResponseWorkflow {
  constructor() {
    this.stages = [
      'detection',
      'assessment',
      'containment',
      'eradication',
      'recovery',
      'lessons_learned'
    ];

    this.currentStage = null;
    this.incidentData = null;
  }

  async initiateResponse(incident) {
    console.log(`🚨 Initiating incident response for: ${incident.id}`);

    this.incidentData = {
      ...incident,
      responseStartTime: new Date().toISOString(),
      stages: {},
      timeline: []
    };

    // Execute response stages
    for (const stage of this.stages) {
      await this.executeStage(stage);
    }

    // Final reporting
    await this.generateIncidentReport();
  }

  async executeStage(stageName) {
    console.log(`📋 Executing stage: ${stageName}`);

    const stageStart = new Date();
    this.currentStage = stageName;

    try {
      switch (stageName) {
        case 'detection':
          await this.stageDetection();
          break;
        case 'assessment':
          await this.stageAssessment();
          break;
        case 'containment':
          await this.stageContainment();
          break;
        case 'eradication':
          await this.stageEradication();
          break;
        case 'recovery':
          await this.stageRecovery();
          break;
        case 'lessons_learned':
          await this.stageLessonsLearned();
          break;
      }

      const stageEnd = new Date();
      this.incidentData.stages[stageName] = {
        status: 'completed',
        startTime: stageStart.toISOString(),
        endTime: stageEnd.toISOString(),
        duration: stageEnd - stageStart
      };

      this.incidentData.timeline.push({
        stage: stageName,
        action: 'completed',
        timestamp: stageEnd.toISOString()
      });

    } catch (error) {
      console.error(`❌ Stage ${stageName} failed:`, error);

      this.incidentData.stages[stageName] = {
        status: 'failed',
        error: error.message,
        startTime: stageStart.toISOString(),
        endTime: new Date().toISOString()
      };

      // Escalate on stage failure
      await this.escalateStageFailure(stageName, error);
    }
  }

  async stageDetection() {
    // Verify incident detection was appropriate
    await this.validateDetection(this.incidentData);

    // Gather initial evidence
    this.incidentData.initialEvidence = await this.collectInitialEvidence();
  }

  async stageAssessment() {
    // Assess incident scope and impact
    this.incidentData.impact = await this.assessImpact(this.incidentData);

    // Determine affected systems and data
    this.incidentData.affectedSystems = await this.identifyAffectedSystems();

    // Classify incident severity
    this.incidentData.severity = this.classifyIncidentSeverity();
  }

  async stageContainment() {
    // Implement immediate containment measures
    await this.implementContainmentMeasures();

    // Prevent incident spread
    await this.preventIncidentSpread();

    // Preserve evidence for investigation
    await this.preserveEvidence();
  }

  async stageEradication() {
    // Identify root cause
    this.incidentData.rootCause = await this.identifyRootCause();

    // Remove threat components
    await this.removeThreatComponents();

    // Verify eradication
    await this.verifyEradication();
  }

  async stageRecovery() {
    // Restore affected systems
    await this.restoreSystems();

    // Validate system integrity
    await this.validateSystemIntegrity();

    // Monitor for recurrence
    await this.implementMonitoring();
  }

  async stageLessonsLearned() {
    // Document incident details
    await this.documentIncident();

    // Identify improvement opportunities
    this.incidentData.improvements = await this.identifyImprovements();

    // Update security controls
    await this.updateSecurityControls();
  }

  async generateIncidentReport() {
    const report = {
      incidentId: this.incidentData.id,
      title: `Security Incident Report: ${this.incidentData.type}`,
      summary: this.generateIncidentSummary(),
      timeline: this.incidentData.timeline,
      impact: this.incidentData.impact,
      rootCause: this.incidentData.rootCause,
      response: this.incidentData.stages,
      recommendations: this.incidentData.improvements,
      generatedAt: new Date().toISOString()
    };

    // Save report
    await this.saveIncidentReport(report);

    // Distribute to stakeholders
    await this.distributeIncidentReport(report);
  }
}
```

---

## Security Training & Awareness

### **Automated Security Training**

#### **User Security Training System**
```javascript
// Security training and awareness system
class SecurityTrainingSystem {
  constructor() {
    this.trainingModules = {
      phishing_awareness: {
        title: 'Phishing Awareness',
        duration: 15,
        required: true,
        frequency: 90 // days
      },
      password_security: {
        title: 'Password Security Best Practices',
        duration: 10,
        required: true,
        frequency: 180
      },
      data_handling: {
        title: 'Sensitive Data Handling',
        duration: 20,
        required: true,
        frequency: 90
      },
      ai_security: {
        title: 'AI Model Security Awareness',
        duration: 25,
        required: false,
        frequency: 180
      },
      incident_reporting: {
        title: 'Security Incident Reporting',
        duration: 15,
        required: true,
        frequency: 365
      }
    };

    this.userTrainingRecords = new Map();
  }

  async scheduleUserTraining(userId, forceRefresh = false) {
    const user = await this.getUserDetails(userId);
    const overdueModules = await this.getOverdueModules(userId);

    if (overdueModules.length > 0 || forceRefresh) {
      await this.assignTrainingModules(userId, overdueModules);
      await this.sendTrainingNotification(user, overdueModules);
    }
  }

  async getOverdueModules(userId) {
    const userRecords = this.userTrainingRecords.get(userId) || [];
    const overdueModules = [];

    for (const [moduleId, module] of Object.entries(this.trainingModules)) {
      const userRecord = userRecords.find(r => r.moduleId === moduleId);

      if (!userRecord) {
        // Never completed
        overdueModules.push(moduleId);
      } else {
        // Check if retraining is due
        const daysSinceCompletion = (Date.now() - new Date(userRecord.completedAt).getTime()) / (1000 * 60 * 60 * 24);

        if (daysSinceCompletion > module.frequency) {
          overdueModules.push(moduleId);
        }
      }
    }

    return overdueModules;
  }

  async assignTrainingModules(userId, moduleIds) {
    const assignments = moduleIds.map(moduleId => ({
      userId,
      moduleId,
      assignedAt: new Date().toISOString(),
      dueDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(), // 30 days
      status: 'assigned'
    }));

    await this.saveTrainingAssignments(assignments);
  }

  async trackTrainingProgress(userId, moduleId, progress) {
    const record = {
      userId,
      moduleId,
      progress: progress.percentage,
      timeSpent: progress.timeSpent,
      completed: progress.completed,
      lastUpdated: new Date().toISOString()
    };

    if (progress.completed) {
      record.completedAt = new Date().toISOString();

      // Update user training records
      const userRecords = this.userTrainingRecords.get(userId) || [];
      userRecords.push({
        moduleId,
        completedAt: record.completedAt,
        score: progress.score
      });
      this.userTrainingRecords.set(userId, userRecords);
    }

    await this.updateTrainingProgress(record);
  }

  async generateTrainingComplianceReport() {
    const allUsers = await this.getAllUsers();
    const report = {
      generatedAt: new Date().toISOString(),
      totalUsers: allUsers.length,
      compliance: {
        overall: 0,
        byDepartment: {},
        byModule: {}
      },
      overdueTraining: [],
      recommendations: []
    };

    let totalComplianceScore = 0;

    for (const user of allUsers) {
      const userCompliance = await this.calculateUserCompliance(user.id);
      totalComplianceScore += userCompliance.score;

      // Track by department
      const dept = user.department || 'unknown';
      if (!report.compliance.byDepartment[dept]) {
        report.compliance.byDepartment[dept] = [];
      }
      report.compliance.byDepartment[dept].push(userCompliance);

      // Check for overdue training
      if (userCompliance.overdueModules.length > 0) {
        report.overdueTraining.push({
          userId: user.id,
          userName: user.name,
          overdueModules: userCompliance.overdueModules
        });
      }
    }

    report.compliance.overall = totalComplianceScore / allUsers.length;

    // Generate recommendations
    report.recommendations = this.generateTrainingRecommendations(report);

    return report;
  }

  generateTrainingRecommendations(report) {
    const recommendations = [];

    if (report.compliance.overall < 80) {
      recommendations.push('Overall training compliance is below acceptable levels. Implement mandatory training enforcement.');
    }

    if (report.overdueTraining.length > report.totalUsers * 0.1) {
      recommendations.push('High number of users with overdue training. Consider automated reminders and access restrictions.');
    }

    // Department-specific recommendations
    for (const [dept, users] of Object.entries(report.compliance.byDepartment)) {
      const deptAvg = users.reduce((sum, u) => sum + u.score, 0) / users.length;
      if (deptAvg < 70) {
        recommendations.push(`${dept} department has low training compliance. Schedule targeted training sessions.`);
      }
    }

    return recommendations;
  }
}
```

---

## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-23 | AI Assistant | Initial comprehensive security procedure covering authentication, AI security, data protection, monitoring, compliance, and incident response |

---

**Document Status**: ✅ **APPROVED FOR IMMEDIATE IMPLEMENTATION**

**Review Schedule**: Monthly security review, quarterly comprehensive audit

**Escalation Contacts**:
- Security Incidents: CISO (ciso@construct.ai) - Immediate response required
- Compliance Issues: Legal Team (legal@construct.ai) - Regulatory matters
- Technical Security: DevSecOps Team (security@construct.ai) - Implementation support

**Critical Security Note**: This document establishes the security foundation for AI model protection. All team members must adhere to these procedures to maintain enterprise-grade security standards.</result>
</write_to_file>