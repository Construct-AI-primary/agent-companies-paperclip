---
title: SOLAR-003 - Electrical System Design & Grid Integration
description: Complete electrical system design and grid integration engineering for solar PV installations including PV array configuration, inverter selection, protection systems, and interconnection requirements
issue_number: SOLAR-003
priority: high
status: open
assignee: TBD
start_date: TBD
due_date: TBD
estimated_hours: 180
---

# SOLAR-003: Electrical System Design & Grid Integration

## Issue Summary

Develop complete electrical system design and grid integration engineering for solar PV installations. This issue encompasses PV array configuration, inverter system design, electrical protection coordination, grounding systems, and utility interconnection requirements to ensure safe, reliable, and compliant electrical systems.

## Objectives

- Design optimal PV array electrical configuration
- Specify and integrate inverter systems
- Develop comprehensive electrical protection schemes
- Design grounding and bonding systems
- Prepare grid interconnection applications and studies
- Ensure NEC and IEEE compliance throughout

## Scope of Work

### 1. PV Array Electrical Design

#### Array Configuration
- **String Sizing and Configuration**
  - Voltage and current calculations per string
  - Maximum power point tracking optimization
  - Shade impact analysis and mitigation
  - Temperature coefficient considerations

- **Array Layout Optimization**
  - DC cable routing and voltage drop analysis
  - combiner box placement and sizing
  - Recombiner and inverter station layout
  - Future expansion provisions

#### DC System Design
- **Conductor Sizing**
  - NEC Table 310.15(B)(3)(c) ampacity calculations
  - Voltage drop limitations (≤3% for feeders, ≤5% for branch circuits)
  - Temperature correction factors
  - Conductor type selection (USE-2, PV Wire, etc.)

- **Overcurrent Protection**
  - Fuse and breaker sizing per NEC 690.9
  - Series fuse rating calculations
  - Coordination with downstream protection
  - Arc fault protection requirements

### 2. Inverter System Design

#### Inverter Selection and Specification
- **System Voltage Determination**
  - 480V, 600V, or 1000V DC system selection
  - AC output voltage requirements (120/208V, 277/480V, etc.)
  - Efficiency optimization and MPPT range
  - Grid support function capabilities

- **Inverter Types and Configurations**
  - String inverters vs. central inverters
  - Multi-string inverters and optimizers
  - Hybrid inverters with energy storage
  - Medium-voltage output transformers

#### Inverter Integration
- **AC Collection System**
  - AC cable sizing and routing
  - Transformer specifications and placement
  - Switchgear and protection coordination
  - Grounding system integration

- **Monitoring and Control**
  - Data acquisition system design
  - Communication protocol specifications
  - SCADA system integration
  - Remote monitoring capabilities

### 3. Protection and Safety Systems

#### DC Side Protection
- **Ground Fault Protection**
  - GFP requirements for ungrounded systems (NEC 690.5)
  - Ground fault detection sensitivity
  - Automatic disconnection requirements
  - Islanding prevention

- **Arc Fault Protection**
  - AFCI requirements for dwelling units (NEC 690.11)
  - Detection algorithm specifications
  - False positive mitigation
  - Maintenance and testing procedures

#### AC Side Protection
- **Overcurrent and Short Circuit Protection**
  - Main service disconnect sizing
  - Feeder and branch circuit protection
  - Ground fault circuit interrupter requirements
  - Coordination with utility protection

- **Surge Protection**
  - SPD type selection (Type 1, Type 2, Type 3)
  - Location requirements and specifications
  - UL 1449 compliance verification
  - Maintenance and testing

### 4. Grounding and Bonding

#### Equipment Grounding
- **NEC 690.41 Compliance**
  - All exposed conductive parts grounded
  - Grounding electrode system design
  - Grounding electrode conductor sizing (NEC Table 250.53)
  - Supplemental grounding electrodes

- **System Grounding**
  - Grounded vs. ungrounded system selection
  - Grounding transformer specifications
  - Neutral grounding resistor requirements
  - Ground fault monitoring

#### Lightning Protection
- **IEEE 998 Compliance**
  - Rolling sphere method application
  - Air terminal placement and specifications
  - Down conductor routing and sizing
  - Ground ring design and installation

### 5. Grid Interconnection Design

#### Interconnection Requirements
- **IEEE 1547 Compliance**
  - Interconnection system testing and certification
  - Anti-islanding protection verification
  - Voltage and frequency ride-through capabilities
  - Power quality requirements

- **Utility Interconnection Standards**
  - Point of common coupling (PCC) specifications
  - Interconnection agreement requirements
  - Metering and telemetry specifications
  - Protection coordination with utility systems

#### Power Quality and Stability
- **Voltage Regulation**
  - Voltage ride-through requirements
  - Reactive power capability and control
  - Harmonic distortion limits (IEEE 519)
  - Flicker and voltage fluctuation control

- **Frequency Regulation**
  - Frequency ride-through requirements
  - Inertial response capabilities
  - Primary frequency response
  - Grid-forming vs. grid-following operation

### 6. Commissioning and Testing

#### Pre-Commissioning Verification
- **System Checkout Procedures**
  - Continuity and polarity testing
  - Insulation resistance measurements (>1 GΩ)
  - Ground resistance verification (<10Ω)
  - Protective device operation testing

- **Functional Testing**
  - Inverter programming and configuration
  - Protection system verification
  - Communication system testing
  - Monitoring system validation

#### Grid Interconnection Testing
- **Interconnection Compliance Testing**
  - IEEE 1547 certification testing
  - Anti-islanding verification
  - Power quality measurements
  - Protection coordination testing

- **Performance Testing**
  - Maximum power output verification
  - Efficiency measurements
  - Harmonic analysis
  - Stability testing under various conditions

## Deliverables

### Primary Deliverables
1. **Electrical Design Report**
   - System design calculations and analysis
   - Equipment specifications and selection
   - Protection coordination study
   - Grounding system design

2. **Single-Line Diagrams**
   - Complete electrical system schematics
   - Equipment ratings and specifications
   - Protection device coordination
   - Cable and conductor schedules

3. **Interconnection Application Package**
   - Utility interconnection application
   - Technical specifications and studies
   - Protection coordination analysis
   - Power quality analysis

### Supporting Documentation
4. **Equipment Specifications**
   - Inverter technical specifications
   - Cable and conductor specifications
   - Protection device requirements
   - Grounding system components

5. **Commissioning Plan**
   - Pre-commissioning checklist
   - Testing procedures and acceptance criteria
   - Safety requirements during commissioning
   - Documentation and record keeping

6. **Operations and Maintenance Manual**
   - System operation procedures
   - Maintenance schedules and procedures
   - Troubleshooting guides
   - Safety procedures for maintenance

## Technical Requirements

### Design Standards
- **NEC Article 690**: Solar Photovoltaic Systems
- **NEC Article 250**: Grounding and Bonding
- **NEC Article 240**: Overcurrent Protection
- **IEEE 1547**: Interconnection and Interoperability

### Analysis Tools
- **Electrical Design Software**
  - ETAP, SKM PowerTools, or EasyPower for protection coordination
  - PVsyst or Helioscope for system design
  - Grounding system analysis software
  - Harmonic analysis tools

### Testing Standards
- **IEEE 1547.1**: Conformance Test Procedures
- **UL 1741**: Inverter Testing Standards
- **IEC 62109**: Safety Testing for Power Converters
- **ASTM Standards**: Material and component testing

## Quality Assurance

### Design Review Process
- **Internal Technical Review**
  - Calculation verification and validation
  - Code compliance confirmation
  - Constructability assessment
  - Risk identification and mitigation

- **Independent Engineering Review**
  - Third-party electrical engineering review
  - Utility interconnection specialist review
  - Arc flash hazard analysis verification
  - Grounding system design validation

### Testing and Verification
- **Factory Acceptance Testing**
  - Equipment performance verification
  - Protection system testing
  - Communication system validation
  - Documentation completeness

- **Field Verification**
  - Installation quality inspection
  - System performance testing
  - Commissioning documentation
  - As-built record verification

## Dependencies

### Internal Dependencies
- **Site Assessment Results**: Grid interconnection capacity from SOLAR-001
- **Structural Design**: Equipment mounting and cable routing constraints
- **Equipment Specifications**: Component electrical characteristics
- **Budget and Schedule**: Procurement timelines and cost constraints

### External Dependencies
- **Utility Requirements**: Interconnection standards and procedures
- **Regulatory Approvals**: NEC compliance and local code requirements
- **Equipment Availability**: Lead times for specialized components
- **Testing Facilities**: Access to certified testing laboratories

## Risk Assessment

### Technical Risks
- **Grid Interconnection Delays**: Extended approval timelines from utilities
- **Protection Coordination Issues**: Conflicts with existing utility protection
- **Harmonic Distortion**: Excessive harmonics affecting power quality
- **Grounding System Performance**: Inadequate grounding causing safety issues

### Schedule Risks
- **Equipment Delivery Delays**: Supply chain disruptions for inverters
- **Regulatory Changes**: Updates to interconnection requirements
- **Testing Facility Availability**: Limited access to specialized testing
- **Weather-Dependent Installation**: Electrical work weather restrictions

### Mitigation Strategies
- **Early Utility Engagement**: Initiate interconnection discussions early
- **Conservative Design**: Use conservative assumptions and safety margins
- **Alternative Equipment**: Multiple vendor options for critical components
- **Phased Testing**: Modular testing approach to identify issues early

## Success Criteria

### Technical Success
- **Code Compliance**: Full compliance with NEC and IEEE standards
- **Safety**: Zero electrical safety hazards in final design
- **Performance**: System efficiency meeting or exceeding specifications
- **Reliability**: Redundant systems and fail-safe operation

### Operational Success
- **Grid Interconnection**: Successful utility approval and energization
- **Power Quality**: All IEEE 519 harmonic limits met
- **Monitoring**: Complete data acquisition and remote monitoring
- **Maintenance**: Safe and efficient maintenance procedures

## Timeline and Milestones

### Phase 1: Conceptual Design (Weeks 1-3)
- System voltage and configuration determination
- Major equipment specification and selection
- Preliminary single-line diagram development
- Interconnection requirement identification

### Phase 2: Detailed Design (Weeks 4-7)
- Complete electrical calculations and analysis
- Protection system design and coordination
- Grounding system design and specifications
- Cable and conduit routing design

### Phase 3: Procurement and Review (Weeks 8-9)
- Equipment procurement package preparation
- Design review and approval process
- Utility interconnection application preparation
- Commissioning plan development

### Phase 4: Documentation and Handoff (Weeks 10-12)
- Final construction document preparation
- Operations and maintenance manual completion
- Contractor coordination and training
- Project handover and closeout

## Resource Requirements

### Personnel
- **Electrical Engineer**: 100% allocation (lead design engineer)
- **Protection Engineer**: 40% allocation (protection system specialist)
- **Commissioning Engineer**: 30% allocation (testing and commissioning)
- **CAD Technician**: 50% allocation (drawing production)

### Software and Tools
- **Design Software**: Electrical design and analysis programs
- **Protection Coordination**: Fault current and coordination analysis tools
- **Simulation Software**: Power system analysis and modeling
- **Documentation Tools**: Electrical drawing and specification software

### Budget Allocation
- **Engineering Design**: 40% of total budget
- **Equipment and Materials**: 45% of total budget
- **Testing and Commissioning**: 10% of total budget
- **Documentation**: 5% of total budget

## Communication Plan

### Internal Communications
- **Weekly Design Meetings**: Technical team coordination and issue resolution
- **Bi-Weekly Client Updates**: Design progress and key milestone reviews
- **Design Review Meetings**: Formal review of design deliverables
- **Change Control Process**: Formal process for design modifications

### External Communications
- **Utility Coordination**: Ongoing interconnection requirement discussions
- **Equipment Vendors**: Technical specification and delivery coordination
- **Regulatory Agencies**: Code compliance and approval coordination
- **Contractors**: Design intent and installation requirement communication

---

**Issue Number**: SOLAR-003
**Priority**: High
**Status**: Open
**Assignee**: TBD
**Estimated Hours**: 180
**Start Date**: TBD
**Due Date**: TBD

**Created**: 2026-04-18
**Last Updated**: 2026-04-18
**Contact**: Solar Installations Electrical Engineer