# Database Backup and Recovery Procedure

## Overview

This procedure establishes comprehensive guidelines for backing up and recovering the Paperclip database system. It ensures data integrity, business continuity, and compliance with data protection requirements through systematic backup operations and tested recovery processes.

## Scope

This procedure applies to:
- All Paperclip production databases
- Development and staging environments (as applicable)
- Database backup operations and storage
- Data recovery and restoration processes
- Backup verification and testing

## Responsibilities

### Database Administrator
- Execute backup operations according to schedule
- Monitor backup success and system health
- Perform backup verification and testing
- Maintain backup storage and retention policies
- Coordinate with infrastructure team for storage management

### Infrastructure Team
- Provide backup storage infrastructure
- Ensure backup system availability and performance
- Monitor storage capacity and alert thresholds
- Implement security controls for backup data
- Support disaster recovery scenarios

### Security Team
- Review backup security controls and encryption
- Ensure compliance with data protection regulations
- Audit backup access and usage logs
- Approve backup storage location security

### Business Continuity Coordinator
- Define recovery time objectives (RTO) and recovery point objectives (RPO)
- Test disaster recovery scenarios
- Coordinate recovery operations during incidents
- Maintain recovery documentation and procedures

## Backup Strategy

### Backup Types

#### 1. Full Database Backup
- **Frequency**: Weekly (Sundays 02:00)
- **Retention**: 12 weeks
- **Purpose**: Complete system recovery
- **Scope**: All tables, schemas, and configurations

#### 2. Differential Backup
- **Frequency**: Daily (Monday-Saturday 02:00)
- **Retention**: 7 days
- **Purpose**: Faster recovery than full backup
- **Scope**: Changes since last full backup

#### 3. Transaction Log Backup
- **Frequency**: Every 15 minutes
- **Retention**: 24 hours
- **Purpose**: Point-in-time recovery
- **Scope**: Transaction logs for real-time data recovery

#### 4. Schema-Only Backup
- **Frequency**: On schema changes
- **Retention**: Indefinite (version controlled)
- **Purpose**: Structure recovery and environment setup
- **Scope**: Table structures, indexes, constraints

### Backup Storage

#### Primary Storage
- **Location**: On-premises NAS with RAID 6
- **Encryption**: AES-256 at rest
- **Retention**: 90 days hot storage
- **Access**: Restricted to DBA and infrastructure teams

#### Secondary Storage
- **Location**: Cloud storage (AWS S3 with cross-region replication)
- **Encryption**: AES-256 with customer-managed keys
- **Retention**: 1 year cold storage
- **Access**: Emergency access only

#### Tertiary Storage
- **Location**: Off-site tape library
- **Encryption**: AES-256 with air-gapped keys
- **Retention**: 7 years for compliance
- **Access**: Physical security controls

## Backup Procedures

### Automated Backup Execution

#### Daily Backup Schedule
```bash
# Full backup (Sundays)
0 2 * * 0 /opt/paperclip/scripts/backup-all-tables.sh --type full

# Differential backup (Mon-Sat)
0 2 * * 1-6 /opt/paperclip/scripts/backup-all-tables.sh --type differential

# Transaction log backup (every 15 minutes)
*/15 * * * * /opt/paperclip/scripts/backup-transaction-logs.sh
```

#### Backup Script Execution
```bash
#!/bin/bash
# Paperclip automated backup script

# Set environment
export DATABASE_URL="${PAPERCLIP_DB_URL}"
export BACKUP_TYPE="${1:-full}"

# Execute backup
cd /opt/paperclip
./scripts/backup-all-tables.sh

# Verify backup integrity
if ./scripts/verify-backup.sh "$BACKUP_FILE"; then
    # Send success notification
    notify_backup_success "$BACKUP_TYPE"
else
    # Send failure alert
    alert_backup_failure "$BACKUP_TYPE"
    exit 1
fi
```

### Manual Backup Procedures

#### Emergency Backup
1. **Assess Situation**: Determine backup urgency and scope
2. **Execute Backup**: Run appropriate backup type
3. **Verify Integrity**: Confirm backup completeness
4. **Secure Storage**: Ensure backup reaches secure storage
5. **Document Action**: Record emergency backup details

#### Pre-Maintenance Backup
1. **Schedule Backup**: Coordinate with maintenance window
2. **Execute Full Backup**: Create complete system backup
3. **Verify Backup**: Test backup integrity
4. **Confirm Readiness**: Ensure backup available for rollback
5. **Document Backup**: Record backup details and location

### Backup Verification

#### Automated Verification
```sql
-- Check backup file integrity
SELECT
  backup_file,
  backup_date,
  file_size,
  checksum,
  verification_status
FROM backup_verification_log
WHERE backup_date >= CURRENT_DATE - INTERVAL '1 day'
ORDER BY backup_date DESC;

-- Verify table counts match
SELECT
  'source' as source,
  COUNT(*) as table_count
FROM information_schema.tables
WHERE table_schema = 'public'
UNION ALL
SELECT
  'backup' as source,
  COUNT(*) as table_count
FROM backup_table_inventory
WHERE backup_date = (SELECT MAX(backup_date) FROM backup_verification_log);
```

#### Manual Verification Steps
1. **File Integrity**: Verify backup files are not corrupted
2. **Table Counts**: Compare source vs backup table counts
3. **Data Sampling**: Spot-check critical data in backups
4. **Restore Testing**: Test restore to separate environment
5. **Performance Validation**: Ensure backup doesn't impact production

## Recovery Procedures

### Recovery Time Objectives (RTO)
- **Critical Systems**: 4 hours
- **Important Systems**: 24 hours
- **Standard Systems**: 72 hours

### Recovery Point Objectives (RPO)
- **Critical Data**: 15 minutes data loss maximum
- **Important Data**: 1 hour data loss maximum
- **Standard Data**: 4 hours data loss maximum

### Full System Recovery

#### Step 1: Assess Damage
1. **Determine Scope**: Identify affected systems and data
2. **Assess Data Loss**: Calculate RPO impact
3. **Resource Requirements**: Identify recovery resources needed
4. **Communication Plan**: Notify stakeholders and teams

#### Step 2: Prepare Recovery Environment
1. **Provision Hardware**: Set up recovery infrastructure
2. **Network Configuration**: Establish connectivity
3. **Security Setup**: Configure access controls
4. **Team Coordination**: Assemble recovery team

#### Step 3: Execute Recovery
```bash
# 1. Restore schema structure
psql $RECOVERY_DB_URL < latest_schema_backup.sql

# 2. Restore full backup
psql $RECOVERY_DB_URL < latest_full_backup.sql

# 3. Apply transaction logs for point-in-time recovery
# (Apply logs up to desired point in time)
pg_restore -d $RECOVERY_DB_URL transaction_logs/

# 4. Verify data integrity
psql $RECOVERY_DB_URL -f scripts/verify-data-integrity.sql
```

#### Step 4: Validate Recovery
1. **Data Verification**: Confirm all data restored correctly
2. **Application Testing**: Test application functionality
3. **Performance Validation**: Ensure system performance meets requirements
4. **Security Verification**: Confirm security controls operational

#### Step 5: Failover and Cutover
1. **Application Switch**: Redirect traffic to recovered system
2. **User Communication**: Notify users of system availability
3. **Monitoring Setup**: Establish monitoring and alerting
4. **Documentation**: Record recovery process and lessons learned

### Point-in-Time Recovery

#### Transaction Log Recovery
```bash
# Stop target database
pg_ctl stop -D $PGDATA

# Restore full backup
pg_restore -d $RECOVERY_DB_URL full_backup.sql

# Apply transaction logs to specific point
pg_wal_replay --target-time "2026-04-15 10:30:00"

# Start database
pg_ctl start -D $PGDATA
```

### Table-Level Recovery

#### Selective Table Restore
```bash
# Create temporary restore database
createdb temp_restore

# Restore specific table
pg_restore -d temp_restore -t table_name backup_file.sql

# Export table data
pg_dump -d temp_restore -t table_name > table_restore.sql

# Import to production
psql $PRODUCTION_DB_URL < table_restore.sql
```

## Monitoring and Alerting

### Backup Success Monitoring
- **Automated Checks**: Backup completion verification
- **Size Validation**: Compare backup sizes to expected ranges
- **Duration Monitoring**: Alert on backup time anomalies
- **Storage Verification**: Confirm backup file storage success

### Alert Thresholds
- **Backup Failure**: Immediate alert to DBA and infrastructure teams
- **Size Deviation**: Alert if backup size varies by >20%
- **Duration Increase**: Alert if backup takes >150% of average time
- **Storage Issues**: Alert on storage capacity <10% available

### Dashboard Metrics
- **Backup Success Rate**: Target >99.9%
- **Recovery Test Success**: Target >95%
- **RTO/RPO Compliance**: Target 100%
- **Storage Utilization**: Monitor capacity planning

## Testing and Validation

### Recovery Testing Schedule
- **Quarterly**: Full disaster recovery test
- **Monthly**: Point-in-time recovery test
- **Weekly**: Backup integrity verification
- **Daily**: Automated backup verification

### Recovery Test Scenarios
1. **Complete System Loss**: Full database recovery
2. **Data Corruption**: Table-level recovery
3. **Point-in-Time Recovery**: Transaction log replay
4. **Partial System Failure**: Selective component recovery

### Test Documentation Requirements
- **Test Plan**: Detailed recovery test procedures
- **Test Results**: Documented test outcomes and issues
- **Performance Metrics**: Recovery time and resource usage
- **Lessons Learned**: Process improvements identified

## Compliance and Auditing

### Regulatory Compliance
- **Data Retention**: Meet industry data retention requirements
- **Encryption Standards**: Use approved encryption algorithms
- **Access Controls**: Implement least-privilege access
- **Audit Logging**: Maintain comprehensive audit trails

### Audit Requirements
- **Backup Logs**: Record all backup operations
- **Access Logs**: Track backup file access
- **Recovery Logs**: Document all recovery operations
- **Change Logs**: Track backup process changes

### Compliance Verification
- **Quarterly Audits**: Independent backup process review
- **Annual Assessments**: Comprehensive compliance evaluation
- **Gap Analysis**: Identify and address compliance gaps
- **Remediation Plans**: Document corrective actions

## Emergency Response

### Disaster Declaration Criteria
- **System Unavailable**: >4 hours downtime
- **Data Loss**: >1 hour of data unrecoverable
- **Security Breach**: Confirmed data compromise
- **Infrastructure Failure**: Primary and secondary systems affected

### Emergency Recovery Team
- **Incident Commander**: Overall coordination
- **Database Administrator**: Technical recovery execution
- **Infrastructure Lead**: System provisioning and setup
- **Security Officer**: Security validation and compliance
- **Communications Lead**: Stakeholder communication

### Communication Protocols
- **Internal Teams**: Immediate notification via emergency channels
- **External Stakeholders**: Timely updates via established protocols
- **Regulatory Bodies**: Required notifications within mandated timeframes
- **Media Relations**: Coordinated messaging for public communications

## Continuous Improvement

### Process Optimization
- **Performance Monitoring**: Track backup and recovery times
- **Automation Enhancement**: Improve automated processes
- **Tool Evaluation**: Assess new backup and recovery tools
- **Cost Optimization**: Balance backup costs with business requirements

### Lessons Learned Process
- **Post-Incident Review**: Analyze recovery operations
- **Process Updates**: Incorporate lessons learned
- **Training Updates**: Update team training based on experience
- **Documentation Updates**: Maintain current and accurate procedures

### Metrics and KPIs
- **Backup Success Rate**: Percentage of successful backups
- **Recovery Time**: Average time to recover systems
- **Data Loss**: Average data loss in recovery scenarios
- **Cost Efficiency**: Backup costs vs. business value

## Related Documentation

- **Database Operations**: `database-operations-procedure.md`
- **Disaster Recovery Plan**: `disaster-recovery-plan.md`
- **Business Continuity Plan**: `business-continuity-plan.md`
- **Security Procedures**: `database-security-procedure.md`

## Version History

- **v1.0** (2026-04-15): Initial comprehensive backup and recovery procedure
- **Future Updates**: Automated testing enhancements, cloud backup integration

---

**Procedure Owner**: Database Administration Team
**Review Frequency**: Quarterly
**Approval Required**: Infrastructure Director and Security Officer
**Last Updated**: 2026-04-15