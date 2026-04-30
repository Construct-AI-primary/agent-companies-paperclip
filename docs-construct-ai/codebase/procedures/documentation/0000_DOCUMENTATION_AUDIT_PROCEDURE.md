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
# 0000_DOCUMENTATION_AUDIT_PROCEDURE.md - Automated Documentation Audit Procedure
Construct AI System Documentation
==========================================

## Document Usage Guide

**🎯 This Document's Role**: Comprehensive procedure for automated documentation quality assurance and continuous monitoring. **Use this procedure** to set up, maintain, and troubleshoot the automated documentation audit system.

**📚 Related Documents in Quality Assurance Ecosystem:**
- **`docs/procedures/0000_PROCEDURES_GUIDE.md`** → Procedures master index (find this procedure)
- **`docs/0000_DOCUMENTATION_MASTER_GUIDE.md`** → Documentation organization and standards
- **`docs/standards/0002_FILE_NAMING_STANDARDS.md`** → File naming conventions and validation

---

## Overview

The Automated Documentation Audit Procedure establishes a continuous quality assurance system for all Construct AI documentation. This procedure covers the setup, operation, and maintenance of automated documentation audits that run weekly to ensure documentation integrity, link validation, schema compliance, and status marker accuracy.

### **System Architecture**

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   LaunchAgent   │    │   Audit Runner   │    │   Audit Tools   │
│   (macOS)       │───▶│   (Bash Script)  │───▶│   (Node.js)     │
│                 │    │                  │    │                 │
│ • Weekly Schedule│    │ • Execution      │    │ • Link Checker │
│ • Auto-Start     │    │ • Error Handling │    │ • Schema Analyzer│
│ • Logging        │    │ • Reporting      │    │ • Status Scanner│
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                                        │
                                                        ▼
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Audit Reports │    │   Quality Metrics│    │   Alerts        │
│   (Markdown)    │    │   (JSON)         │    │   (Email/Logs)  │
│                 │    │                  │    │                 │
│ • Links Report  │    │ • Pass/Fail Rates│    │ • Critical Issues│
│ • Schema Report │    │ • Trend Analysis │    │ • Weekly Summary│
│ • Status Report │    │ • Coverage Stats │    │ • Quality Alerts│
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

---

## Prerequisites

### **System Requirements**
- **macOS** with LaunchAgent support
- **Node.js** 18+ for audit scripts
- **File system access** to `/docs/` directory
- **Write permissions** to `/reports/` directory

### **Required Components**
- `scripts/documentation-audit/run_all_audits.sh` - Main audit runner
- `scripts/documentation-audit/documentation-linker.js` - Link validation
- `scripts/documentation-audit/schema-analyzer.js` - Schema compliance
- `scripts/documentation-audit/status-checker.js` - Status marker validation

---

## Implementation Procedure

### **Phase 1: System Setup**

#### **Step 1.1: Verify Audit Scripts**
```bash
# Check script permissions and executability
ls -la scripts/documentation-audit/
-rwxr-xr-x  1 user  staff    892 Jan 10 13:53 run_all_audits.sh
-rw-r--r--  1 user  staff   2048 Jan 10 13:53 documentation-linker.js
-rw-r--r--  1 user  staff   1843 Jan 10 13:53 schema-analyzer.js
-rw-r--r--  1 user  staff    689 Jan 10 13:53 status-checker.js
```

#### **Step 1.2: Test Manual Execution**
```bash
# Run audit manually to verify functionality
cd /Users/_PropAI/construct_ai
bash scripts/documentation-audit/run_all_audits.sh

# Expected output:
# 🔍 Starting Documentation Audit Suite - Sat Jan 10 13:54:02 SAST 2026
# ==================================================
# 📋 Running Link Verification...
# Documentation verification complete. Report saved to /Users/_PropAI/construct_ai/reports/documentation-links-report.md
# 📊 Running Schema Analysis...
# Schema analysis complete. Report saved to /Users/_PropAI/construct_ai/reports/documentation-schema-report.md
# 📈 Running Status Check...
# Status verification complete. Report saved to /Users/_PropAI/construct_ai/reports/documentation-status-report.md
# ✅ Documentation Audit Complete
```

#### **Step 1.3: Verify Report Generation**
```bash
# Check that reports were created
ls -la reports/documentation-*.md
-rw-r--r--  1 user  admin    302 Jan 10 13:54 documentation-links-report.md
-rw-r--r--  1 user  admin   1843 Jan 10 13:54 documentation-schema-report.md
-rw-r--r--  1 user  admin    689 Jan 10 13:54 documentation-status-report.md
```

### **Phase 2: Automated Scheduling Setup**

#### **Step 2.1: Create LaunchAgent Configuration**
```bash
# Create LaunchAgent plist file
cat > ~/Library/LaunchAgents/com.constructai.documentation-audit.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0//EN">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.constructai.documentation-audit</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Users/_PropAI/construct_ai/scripts/documentation-audit/run_all_audits.sh</string>
    </array>
    <key>WorkingDirectory</key>
    <string>/Users/_PropAI/construct_ai</string>
    <key>StandardOutPath</key>
    <string>/Users/_PropAI/construct_ai/documentation-audit.log</string>
    <key>StandardErrorPath</key>
    <string>/Users/_PropAI/construct_ai/documentation-audit-error.log</string>
    <key>RunAtLoad</key>
    <true/>
    <key>StartInterval</key>
    <integer>604800</integer>
    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key>
        <string>/usr/local/bin:/usr/bin:/bin</string>
        <key>HOME</key>
        <string>/Users/_PropAI</string>
    </dict>
</dict>
</plist>
EOF
```

#### **Step 2.2: Load LaunchAgent**
```bash
# Load the LaunchAgent
launchctl load ~/Library/LaunchAgents/com.constructai.documentation-audit.plist

# Verify it's loaded
launchctl list | grep documentation
-	0	com.constructai.documentation-audit
```

#### **Step 2.3: Test LaunchAgent Execution**
```bash
# Force immediate execution for testing
launchctl start com.constructai.documentation-audit

# Check logs
tail -f /Users/_PropAI/construct_ai/documentation-audit.log
```

### **Phase 3: Monitoring and Maintenance**

#### **Step 3.1: Set Up Log Monitoring**
```bash
# Create log rotation for audit logs
cat >> /Users/_PropAI/.logrotate.conf << 'EOF'
/Users/_PropAI/construct_ai/documentation-audit.log {
    weekly
    rotate 4
    compress
    missingok
    create 644 _PropAI staff
}

/Users/_PropAI/construct_ai/documentation-audit-error.log {
    weekly
    rotate 4
    compress
    missingok
    create 644 _PropAI staff
}
EOF
```

#### **Step 3.2: Configure Alert System**
```bash
# Create audit monitoring script
cat > scripts/documentation-audit/monitor_audits.sh << 'EOF'
#!/bin/bash

# Monitor documentation audit health and send alerts

AUDIT_LOG="/Users/_PropAI/construct_ai/documentation-audit.log"
ERROR_LOG="/Users/_PropAI/construct_ai/documentation-audit-error.log"
REPORTS_DIR="/Users/_PropAI/construct_ai/reports"

# Check if last audit ran successfully
if [ -f "$AUDIT_LOG" ]; then
    LAST_RUN=$(stat -f %m "$AUDIT_LOG")
    NOW=$(date +%s)
    HOURS_SINCE=$(( (NOW - LAST_RUN) / 3600 ))

    if [ $HOURS_SINCE -gt 170 ]; then  # More than ~1 week + buffer
        echo "⚠️ WARNING: Documentation audit hasn't run in $HOURS_SINCE hours"
        # Send alert (integrate with your notification system)
    fi
fi

# Check for recent errors
if [ -f "$ERROR_LOG" ] && [ -s "$ERROR_LOG" ]; then
    echo "🚨 CRITICAL: Documentation audit errors detected"
    tail -20 "$ERROR_LOG"
    # Send critical alert
fi

# Check report freshness
for report in "$REPORTS_DIR"/documentation-*.md; do
    if [ -f "$report" ]; then
        REPORT_AGE=$(stat -f %m "$report")
        DAYS_OLD=$(( (NOW - REPORT_AGE) / 86400 ))

        if [ $DAYS_OLD -gt 8 ]; then
            echo "⚠️ WARNING: $(basename "$report") is $DAYS_OLD days old"
        fi
    fi
done
EOF

chmod +x scripts/documentation-audit/monitor_audits.sh
```

### **Phase 4: Integration with CI/CD**

#### **Step 4.1: Add to GitHub Actions**
```yaml
# Add to .github/workflows/documentation-audit.yml
name: "📚 Documentation Audit"
on:
  schedule:
    - cron: '0 2 * * 1'  # Weekly on Monday at 2 AM UTC
  workflow_dispatch:     # Manual trigger

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm install

      - name: Run documentation audit
        run: |
          mkdir -p reports
          node scripts/documentation-audit/documentation-linker.js
          node scripts/documentation-audit/schema-analyzer.js
          node scripts/documentation-audit/status-checker.js

      - name: Upload audit reports
        uses: actions/upload-artifact@v4
        with:
          name: documentation-audit-reports
          path: reports/documentation-*.md

      - name: Check for critical issues
        run: |
          if grep -q "❌" reports/documentation-*.md; then
            echo "::error::Critical documentation issues found"
            exit 1
          fi
```

---

## Audit Types and Scope

### **Link Verification Audit**
**Purpose:** Validates all React component references in documentation files
**Scope:** All `.md` files in `/docs/` directory
**Output:** `documentation-links-report.md`
**Frequency:** Weekly

**Validation Checks:**
- Component reference format: `0000_COMPONENT.js`
- File existence in `/client/src/` directory
- Path accuracy and naming conventions

### **Schema Compliance Audit**
**Purpose:** Ensures documentation follows proper structure and schema
**Scope:** All documentation files
**Output:** `documentation-schema-report.md`
**Frequency:** Weekly

**Validation Checks:**
- Required sections: H1 title, Overview, Requirements, Implementation, Status
- 5-digit prefix pattern: `XXXXX_filename.md`
- Schema adherence and completeness

### **Status Marker Audit**
**Purpose:** Validates status markers (✅/⚠️/❌) in documentation
**Scope:** All documentation files
**Output:** `documentation-status-report.md`
**Frequency:** Weekly

**Validation Checks:**
- Status marker presence and consistency
- Status type distribution
- Documentation completeness indicators

---

## Troubleshooting

### **Issue: LaunchAgent Not Starting**

**Symptoms:**
- `launchctl list` doesn't show the documentation-audit service
- No audit logs generated

**Resolution:**
```bash
# Unload and reload the LaunchAgent
launchctl unload ~/Library/LaunchAgents/com.constructai.documentation-audit.plist
launchctl load ~/Library/LaunchAgents/com.constructai.documentation-audit.plist

# Check for syntax errors
plutil ~/Library/LaunchAgents/com.constructai.documentation-audit.plist
```

### **Issue: Audit Scripts Failing**

**Symptoms:**
- Error logs show script execution failures
- Reports not generated or incomplete

**Resolution:**
```bash
# Test individual scripts
cd /Users/_PropAI/construct_ai
node scripts/documentation-audit/documentation-linker.js
node scripts/documentation-audit/schema-analyzer.js
node scripts/documentation-audit/status-checker.js

# Check Node.js version and dependencies
node --version
npm list
```

### **Issue: Permission Errors**

**Symptoms:**
- "Permission denied" errors in logs
- Reports directory not writable

**Resolution:**
```bash
# Fix permissions
chmod +x scripts/documentation-audit/run_all_audits.sh
chmod 755 scripts/documentation-audit/*.js
chmod 755 reports/

# Check ownership
ls -la scripts/documentation-audit/
ls -la reports/
```

### **Issue: Reports Not Generated**

**Symptoms:**
- Audit runs successfully but no report files created
- Empty or missing report files

**Resolution:**
```bash
# Check reports directory permissions
ls -la reports/

# Verify script output paths
grep "REPORT_FILE" scripts/documentation-audit/*.js

# Test manual report generation
mkdir -p reports
node scripts/documentation-audit/documentation-linker.js
ls -la reports/documentation-links-report.md
```

### **Issue: LaunchAgent Runs But No Output**

**Symptoms:**
- LaunchAgent shows as running
- No log files or report files generated

**Resolution:**
```bash
# Check LaunchAgent logs
tail -50 ~/Library/Logs/com.constructai.documentation-audit.log

# Verify working directory and paths
launchctl print system/com.constructai.documentation-audit

# Test manual execution
cd /Users/_PropAI/construct_ai
bash scripts/documentation-audit/run_all_audits.sh
```

---

## Maintenance Procedures

### **Weekly Maintenance**
1. **Review Audit Reports:** Check generated reports for issues
2. **Monitor Error Logs:** Review audit logs for failures
3. **Update Scripts:** Apply any script improvements
4. **Clean Old Reports:** Archive reports older than 30 days

### **Monthly Maintenance**
1. **Performance Review:** Analyze audit execution times
2. **Coverage Assessment:** Ensure all documentation is audited
3. **Alert Threshold Review:** Adjust monitoring thresholds
4. **Script Updates:** Update audit logic for new requirements

### **Quarterly Maintenance**
1. **System Audit:** Complete review of audit system
2. **Documentation Updates:** Update procedure for new features
3. **Integration Testing:** Test with updated documentation
4. **Performance Optimization:** Optimize audit execution time

---

## Quality Metrics

### **Audit Success Criteria**

| Metric | Target | Critical Threshold |
|--------|--------|-------------------|
| **Execution Success Rate** | >99% | <95% |
| **Report Generation Rate** | 100% | <100% |
| **Documentation Coverage** | 100% | <95% |
| **False Positive Rate** | <1% | >5% |
| **Execution Time** | <5 minutes | >15 minutes |

### **Quality Assurance Checks**

**Daily Checks:**
- ✅ LaunchAgent status verification
- ✅ Log file existence and size
- ✅ Report file generation
- ✅ Error-free execution

**Weekly Checks:**
- ✅ Report content validation
- ✅ Issue trend analysis
- ✅ Performance metrics review
- ✅ Alert system verification

---

## Integration Points

### **Related Systems**
- **Documentation Master Guide:** `docs/0000_DOCUMENTATION_MASTER_GUIDE.md`
- **Procedures Guide:** `docs/procedures/0000_PROCEDURES_GUIDE.md`
- **Quality Assurance Framework:** CI/CD pipeline integration
- **Monitoring Systems:** Log aggregation and alerting

### **Data Flow**
```
Documentation Files → Audit Scripts → Report Generation → Quality Metrics → Alerts
       ↓                ↓              ↓                    ↓              ↓
   docs/*.md      Node.js Tools   Markdown Reports    JSON Metrics   Email/Logs
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-10 | Initial implementation with weekly automated audits |
| 1.0.1 | 2026-01-10 | Added CI/CD integration and monitoring |

---

## Document Information

- **Document ID:** `0000_DOCUMENTATION_AUDIT_PROCEDURE`
- **Version:** 1.0.0
- **Created:** 2026-01-10
- **Last Updated:** 2026-01-10
- **Author:** AI Assistant (Construct AI)
- **Review Cycle:** Quarterly
- **Related Documents:**
  - `docs/0000_DOCUMENTATION_MASTER_GUIDE.md`
  - `docs/procedures/0000_PROCEDURES_GUIDE.md`
  - `docs/standards/0002_FILE_NAMING_STANDARDS.md`

---

**Navigation**: This procedure establishes automated documentation quality assurance. For manual documentation tasks, see `docs/0000_DOCUMENTATION_MASTER_GUIDE.md`. For system troubleshooting, see `docs/procedures/0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`.
