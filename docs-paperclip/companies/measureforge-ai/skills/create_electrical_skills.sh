#!/bin/bash

# Function to create SKILL.md for electrical skills
create_electrical_skill() {
    local skill_name="$1"
    local category="$2"
    local description="$3"
    
    mkdir -p "$skill_name"
    
    cat > "$skill_name/SKILL.md" << SKILL_EOF
---
name: $skill_name
description: $description
company: measureforge-ai
category: $category
complexity: expert
estimated_duration: 8-12 hours
success_criteria:
  - Electrical measurement capability implemented
  - Standards compliance achieved
  - Safety protocols integrated
  - Performance metrics validated
prerequisites:
  - Electrical engineering knowledge
  - Measurement instrument proficiency
  - Standards compliance understanding
  - Safety protocol familiarity
---

# ${skill_name//-/ } Skill

## Overview

This skill encompasses comprehensive ${skill_name//-/ } methodologies and practices essential for accurate electrical measurement, validation, and compliance in construction and infrastructure projects. It provides advanced capabilities for electrical system assessment and regulatory adherence.

## Capabilities

### Core Functionality
- **Measurement Execution**: Precise electrical parameter measurement and recording
- **Standards Validation**: Compliance verification against electrical codes and standards
- **Safety Integration**: Electrical safety protocol implementation and enforcement
- **Quality Assurance**: Measurement accuracy and reliability validation

### Technical Implementation
- **Instrument Integration**: Electrical measurement instrument configuration and calibration
- **Data Processing**: Electrical measurement data analysis and interpretation
- **System Integration**: Integration with electrical design and documentation systems
- **Performance Optimization**: Measurement process efficiency and accuracy optimization

### Professional Standards
- **Code Compliance**: Adherence to NFPA, NEC, and local electrical code requirements
- **Safety Protocols**: Implementation of electrical safety and arc-flash prevention measures
- **Documentation**: Professional measurement documentation and reporting standards
- **Quality Management**: Electrical measurement quality management and assurance

## Integration Points

### With Electrical Agents
- **Data Exchange**: Seamless data sharing between electrical measurement agents
- **Workflow Coordination**: Coordinated electrical measurement and validation workflows
- **Standards Alignment**: Consistent application of electrical standards across agents
- **Quality Control**: Integrated quality control and assurance processes

### With CAD Systems
- **Drawing Integration**: Direct integration with electrical CAD drawings and schematics
- **Asset Correlation**: Correlation of measurements with electrical system assets
- **Documentation Sync**: Synchronization of measurements with design documentation
- **Change Tracking**: Tracking of electrical system changes and measurement updates

## Success Metrics

### Technical Performance
- **Measurement Accuracy**: ±1% accuracy in electrical parameter measurements
- **Compliance Rate**: 100% compliance with applicable electrical standards
- **Safety Compliance**: Zero safety protocol violations in measurement activities
- **Process Efficiency**: 25% improvement in electrical measurement process efficiency

### Quality Assurance
- **Data Integrity**: 99.9% accuracy in electrical measurement data recording
- **Audit Success**: Successful completion of all electrical measurement audits
- **Documentation Quality**: Complete and accurate electrical measurement documentation
- **User Satisfaction**: High satisfaction ratings from electrical measurement stakeholders

## Implementation Guidelines

### Best Practices
- **Calibration Protocols**: Regular instrument calibration and verification procedures
- **Safety Procedures**: Comprehensive electrical safety procedure implementation
- **Quality Controls**: Multi-level quality control and validation processes
- **Training Requirements**: Specialized training for electrical measurement personnel

### Risk Management
- **Safety Risks**: Mitigation of electrical shock and arc-flash hazards
- **Accuracy Risks**: Prevention of measurement errors and data inaccuracies
- **Compliance Risks**: Avoidance of electrical code and standard violations
- **Operational Risks**: Management of electrical measurement process disruptions

## Training and Development

### Technical Proficiency
- **Electrical Knowledge**: Comprehensive electrical engineering and measurement knowledge
- **Instrument Expertise**: Proficiency with electrical measurement instruments and equipment
- **Standards Knowledge**: Deep understanding of electrical codes and standards
- **Safety Training**: Specialized electrical safety and arc-flash prevention training

### Professional Development
- **Certification**: Electrical measurement and safety certification maintenance
- **Continuing Education**: Ongoing education in electrical measurement technologies
- **Industry Knowledge**: Staying current with electrical industry developments
- **Cross-Training**: Development of complementary electrical and measurement skills
SKILL_EOF
}

# Create electrical measurement skills
create_electrical_skill "electrical-measurement-interpretation" "technical" "Advanced interpretation and analysis of electrical measurement data, including voltage, current, resistance, and power quality parameters"
create_electrical_skill "cad-electrical-annotation" "technical" "Electrical CAD system integration for measurement annotation, drawing updates, and documentation synchronization"
create_electrical_skill "electrical-compliance-validation" "professional" "Validation of electrical measurements against NFPA 70, NFPA 70E, NFPA 70B, and local electrical code requirements"
create_electrical_skill "power-quality-analysis" "technical" "Analysis of electrical power quality parameters including harmonics, transients, and voltage stability"
create_electrical_skill "grounding-system-verification" "technical" "Grounding system measurement, verification, and compliance assessment for electrical safety"
create_electrical_skill "electrical-safety-assessment" "professional" "Electrical safety assessment and arc-flash hazard analysis for measurement and maintenance activities"
create_electrical_skill "measurement-accuracy-validation" "technical" "Validation of electrical measurement accuracy, calibration, and uncertainty assessment"
create_electrical_skill "electrical-standards-compliance" "professional" "Compliance verification with electrical industry standards and regulatory requirements"
create_electrical_skill "instrument-calibration-tracking" "technical" "Electrical instrument calibration tracking, scheduling, and compliance management"
create_electrical_skill "electrical-fault-detection" "technical" "Detection and analysis of electrical faults, anomalies, and system irregularities"
create_electrical_skill "measurement-data-structuring" "technical" "Structuring and organization of electrical measurement data for analysis and reporting"
create_electrical_skill "electrical-audit-preparation" "professional" "Preparation of electrical measurement data and documentation for regulatory audits"
create_electrical_skill "measurement-trend-analysis" "technical" "Analysis of electrical measurement trends and predictive maintenance insights"
create_electrical_skill "electrical-risk-assessment" "professional" "Assessment of electrical risks and safety hazards in measurement and operational contexts"
create_electrical_skill "measurement-workflow-coordination" "management" "Coordination of electrical measurement workflows and interdisciplinary collaboration"

# Traffic signal specific skills
create_electrical_skill "traffic-signal-load-analysis" "technical" "Analysis of traffic signal electrical loads, power consumption, and system capacity requirements"
create_electrical_skill "controller-power-validation" "technical" "Validation of traffic signal controller power systems, backup power, and electrical performance"
create_electrical_skill "detector-circuit-testing" "technical" "Testing and validation of traffic signal detector circuits and vehicle detection systems"
create_electrical_skill "communication-interface-verification" "technical" "Verification of traffic signal communication interfaces and NTCIP protocol compliance"
create_electrical_skill "backup-power-assessment" "technical" "Assessment of traffic signal backup power systems and emergency power capabilities"
create_electrical_skill "surge-protection-validation" "technical" "Validation of surge protection systems and lightning protection for traffic signals"
create_electrical_skill "field-wiring-integrity" "technical" "Assessment of field wiring integrity and underground cable systems for traffic signals"
create_electrical_skill "traffic-signal-compliance" "professional" "Compliance verification for traffic signal electrical systems and standards"
create_electrical_skill "intersection-coordination" "technical" "Coordination of intersection electrical systems and signal synchronization"
create_electrical_skill "signal-timing-validation" "technical" "Validation of traffic signal timing parameters and phasing compliance"
create_electrical_skill "pedestrian-facility-testing" "technical" "Testing of pedestrian signal facilities and accessibility features"
create_electrical_skill "preemption-system-verification" "technical" "Verification of emergency vehicle preemption and priority signal systems"
create_electrical_skill "traffic-signal-grounding" "technical" "Traffic signal grounding system design, testing, and compliance verification"
create_electrical_skill "environmental-monitoring" "technical" "Monitoring of environmental conditions affecting traffic signal electrical performance"
create_electrical_skill "maintenance-scheduling" "management" "Scheduling and coordination of traffic signal electrical maintenance activities"

# Compliance and QA skills
create_electrical_skill "electrical-standards-validation" "professional" "Validation of electrical measurements against NFPA 70, NFPA 70E, NFPA 70B standards"
create_electrical_skill "nfpa-70-compliance-checking" "professional" "Automated compliance checking against NFPA 70 (NEC) electrical code requirements"
create_electrical_skill "ada-accessibility-verification" "professional" "Verification of electrical systems compliance with ADA accessibility requirements"
create_electrical_skill "grounding-system-validation" "technical" "Validation of electrical grounding systems and equipment grounding compliance"
create_electrical_skill "arc-flash-hazard-analysis" "professional" "Analysis of arc-flash hazards and personal protective equipment requirements"
create_electrical_skill "equipment-clearance-verification" "technical" "Verification of electrical equipment clearances and working space requirements"
create_electrical_skill "conductor-sizing-validation" "technical" "Validation of conductor sizing and ampacity calculations"
create_electrical_skill "overcurrent-protection-assessment" "technical" "Assessment of overcurrent protection systems and coordination"
create_electrical_skill "electrical-safety-compliance" "professional" "Compliance verification with electrical safety standards and regulations"
create_electrical_skill "code-violation-detection" "technical" "Detection and reporting of electrical code violations and non-compliance issues"
create_electrical_skill "compliance-reporting" "professional" "Generation of electrical compliance reports and regulatory documentation"
create_electrical_skill "regulatory-adherence-tracking" "professional" "Tracking and documentation of regulatory adherence and compliance status"
create_electrical_skill "safety-standard-enforcement" "professional" "Enforcement of electrical safety standards and workplace safety requirements"
create_electrical_skill "electrical-code-interpretation" "professional" "Interpretation and application of electrical codes and standards"
create_electrical_skill "compliance-audit-preparation" "professional" "Preparation of electrical systems for regulatory compliance audits"

# Traffic signal compliance skills
create_electrical_skill "traffic-signal-mutcd-compliance" "professional" "Compliance verification with MUTCD traffic signal standards and requirements"
create_electrical_skill "nema-controller-standards" "technical" "Compliance with NEMA TS-1/TS-2 traffic signal controller standards"
create_electrical_skill "fhwa-guideline-adherence" "professional" "Adherence to FHWA guidelines for traffic signal design and operation"
create_electrical_skill "signal-timing-validation" "technical" "Validation of traffic signal timing parameters and operational compliance"
create_electrical_skill "controller-grounding-verification" "technical" "Verification of traffic signal controller grounding and electrical safety"
create_electrical_skill "intersection-coordination-compliance" "technical" "Compliance verification for intersection coordination and signal synchronization"
create_electrical_skill "pedestrian-accessibility-validation" "professional" "Validation of pedestrian signal accessibility and ADA compliance"
create_electrical_skill "transportation-safety-standards" "professional" "Compliance with transportation safety standards and traffic signal requirements"
create_electrical_skill "traffic-signal-regulations" "professional" "Compliance with traffic signal regulations and local transportation authority requirements"
create_electrical_skill "infrastructure-compliance-audit" "professional" "Audit preparation and compliance verification for transportation infrastructure"
create_electrical_skill "signal-performance-standards" "technical" "Validation of traffic signal performance standards and operational requirements"
create_electrical_skill "emergency-vehicle-preemption" "technical" "Verification of emergency vehicle preemption systems and signal priority"
create_electrical_skill "transit-signal-priority" "technical" "Validation of transit signal priority systems and multimodal coordination"
create_electrical_skill "signal-visibility-requirements" "technical" "Verification of signal visibility requirements and photometric standards"
create_electrical_skill "maintenance-access-compliance" "technical" "Compliance verification for maintenance access and equipment servicing"

# QA and validation skills
create_electrical_skill "electrical-measurement-qa" "technical" "Quality assurance for electrical measurement processes and data integrity"
create_electrical_skill "cross-validation-analysis" "technical" "Cross-validation analysis of electrical measurements across multiple sources"
create_electrical_skill "measurement-consistency-checking" "technical" "Consistency checking of electrical measurements against design specifications"
create_electrical_skill "discrepancy-resolution" "technical" "Resolution of electrical measurement discrepancies and anomalies"
create_electrical_skill "quality-assurance-validation" "technical" "Validation of electrical measurement quality assurance processes"
create_electrical_skill "measurement-completeness-verification" "technical" "Verification of measurement completeness and requirement satisfaction"
create_electrical_skill "historical-baseline-comparison" "technical" "Comparison of electrical measurements against historical baselines"
create_electrical_skill "audit-trail-validation" "technical" "Validation of electrical measurement audit trails and documentation"
create_electrical_skill "measurement-accuracy-assessment" "technical" "Assessment of electrical measurement accuracy and precision"
create_electrical_skill "electrical-data-integrity" "technical" "Ensurance of electrical measurement data integrity and security"
create_electrical_skill "measurement-traceability-verification" "technical" "Verification of electrical measurement traceability and chain of custody"
create_electrical_skill "qa-reporting-and-documentation" "professional" "Generation of QA reports and documentation for electrical measurements"
create_electrical_skill "measurement-standard-compliance" "professional" "Compliance verification with electrical measurement standards and protocols"
create_electrical_skill "electrical-validation-testing" "technical" "Validation testing of electrical measurement systems and processes"
create_electrical_skill "qa-process-optimization" "management" "Optimization of QA processes for electrical measurement efficiency"

echo "All 75 electrical measurement skills created successfully!"
