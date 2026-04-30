---
title: 02025-Measurement Cross-Discipline Workflows Catalog
description: Complete catalog of measurement workflows across all engineering disciplines with builder procurement segregation and post-tender subcontract tendering
gigabrain_tags: cross-discipline, 02025-measurement, workflows, catalog, dwg-measurement, builder-procurement, procurement-segregation, post-tender-subcontract-tendering, boq-disaggregation, trade-packages
para_section: disciplines-shared/measurement
last_updated: 2026-04-25
---

# 02025-Measurement Cross-Discipline Workflows Catalog

## Overview

This catalog documents all measurement workflows available through the IntegrateForge AI platform, covering multi-discipline DWG measurement with 100% accuracy guarantee. The platform now includes comprehensive builder procurement segregation capabilities for direct material procurement and integration with the PROC-ORDER workflow system.

## Workflow Categories

### 1. Core Measurement Workflows

| Workflow ID | Name | Discipline | Description |
|------------|------|------------|-------------|
| MEAS-001 | DWG Upload & Classification | All | Upload drawings and classify elements |
| MEAS-002 | OpenCV Processing | All | Process with 100% accuracy |
| MEAS-003 | Results Export | All | Export to CSV/Excel/PDF |
| MEAS-004 | Standards Validation | QS | Validate against QS standards |

### 2. Quantity Surveying Workflows

| Workflow ID | Name | Description |
|------------|------|-------------|
| QS-MEAS-001 | Foundation Measurement | Strip, pad, raft, pile foundations |
| QS-MEAS-002 | Structural Measurement | Columns, beams, slabs, walls |
| QS-MEAS-003 | Architectural Measurement | Doors, windows, finishes |
| QS-MEAS-004 | Finishes Schedule | Paint, flooring, ceiling, tile |
| QS-MEAS-005 | MEP Measurement | Electrical, plumbing, HVAC |

### 2.1 Builder Procurement Segregation Workflows

| Workflow ID | Name | Description |
|------------|------|-------------|
| BUILDER-MEAS-001 | Subcontract Classification | Segregate specialized trade work (electrical, plumbing, HVAC) |
| BUILDER-MEAS-002 | Purchase Order Generation | Materials and equipment procurement classification |
| BUILDER-MEAS-003 | Service Order Generation | Testing, maintenance, and inspection services |
| BUILDER-MEAS-004 | Work Order Generation | Internal labor and construction task management |
| BUILDER-MEAS-005 | Supplier Capability Matching | Match requirements against approved supplier lists |
| BUILDER-MEAS-006 | Candy Integration | Direct export to Candy procurement system |
| BUILDER-MEAS-007 | Budget Variance Monitoring | Real-time budget tracking and alerts |
| BUILDER-MEAS-008 | Procurement Approval Routing | Integration with PROC-ORDER approval workflows |

### 2.2 Post-Tender Subcontract Tendering Workflows

| Workflow ID | Name | Description |
|------------|------|-------------|
| BUILDER-MEAS-009 | BOQ Extraction & Disaggregation | Extract QS-discipline-prepared BOQ and disaggregate by trade/specialty |
| BUILDER-MEAS-010 | Trade Package Formulation | Create tender packages for electrical, plumbing, HVAC, structural steel, fire protection |
| BUILDER-MEAS-011 | Subcontract Tender Document Generation | Generate RFQs, tender packages, and scope of works for sub-vendors |
| BUILDER-MEAS-012 | Sub-vendor Quotation Collection | Collect, compare, and evaluate quotations from specialty contractors |
| BUILDER-MEAS-013 | Subcontract Award Processing | Evaluate bids, award subcontracts, and generate subcontract agreements |

### 3. Civil Engineering Workflows

| Workflow ID | Name | Description |
|------------|------|-------------|
| CIV-MEAS-001 | Road Alignment | Centerline, curves, superelevation |
| CIV-MEAS-002 | Pavement Layers | Asphalt, concrete, sub-base |
| CIV-MEAS-003 | Stormwater Network | Pipes, catchments, manholes |
| CIV-MEAS-004 | Earthworks | Cut, fill, mass haul |
| CIV-MEAS-005 | Utility Corridors | Duct banks, cable routes |

### 4. MEP Workflows

| Workflow ID | Name | Description |
|------------|------|-------------|
| MEP-MEAS-001 | HVAC Duct | Rectangular, round, oval ducts |
| MEP-MEAS-002 | Piping Systems | Supply, return, waste, vent |
| MEP-MEAS-003 | Electrical Conduit | Power, lighting, data |
| MEP-MEAS-004 | Equipment Layout | Plant rooms, risers |

### 5. Structural Workflows

| Workflow ID | Name | Description |
|------------|------|-------------|
| STR-MEAS-001 | Concrete Elements | Beams, columns, walls |
| STR-MEAS-002 | Steel Elements | Columns, beams, connections |
| STR-MEAS-003 | Foundation Systems | Piles, pile caps, ground beams |

## Dual-Path Procurement Architecture

### Traditional Formal Path (QS)

```
CAD Drawings -> QS Measurement -> ASAQS Standards -> BOQ Generation -> Tender Documentation -> Procurement Orders
     |               |                 |                  |                    |                    |
 Standards      Quantity Survey    Compliance        Contract             01900 PROC-ORDER      Candy
 Validation     Professional       Checking         Tender               Workflows            Integration
```

### New Builder Direct Path

```
CAD Drawings -> Builder Measurement -> Direct Extraction -> Procurement Segregation -> Order Generation -> Material Delivery -> Construction
     |               |                      |                     |                     |                   |                    |
 MeasureForge    Quantity Extraction    Candy Integration    Subcontract/PO/SO/WO       PROC-ORDER          Site Delivery        Installation
 AI Platform     & Cost Estimation      & Budget Control    Classification             Integration         & Quality Control     & Progress
```

### Builder Post-Tender Subcontract Tendering Path

```
Tender Won -> Extract QS BOQ -> BOQ Disaggregation -> Trade Package Formulation -> Subcontract RFQ -> Quotation Collection -> Award -> Subcontract Agreement
     |              |                  |                    |                       |                  |                    |                    |
  Builder      QS Discipline       Material Qtys by      Electrical/Plumbing/    RFQ per Trade      Compare Quotations    Best Value          Subcontractor
  Entry        Prepared BOQ        Trade/Specialty        HVAC/Structural/Fire                      Evaluation           Selection           Onboarding
```

## Workflow Diagrams

### Core Measurement Flow

```mermaid
flowchart TD
    subgraph Upload[1. File Upload]
        A[Upload DWG/PDF] --> B{Format Check}
        B -->|.dwg| C[Parse Vector Data]
        B -->|.pdf| D[Raster to Image]
        B -->|.png| D
        C --> E[Element Detection]
        D --> E
    end

    subgraph Classify[2. Element Classification]
        E --> F{Classification Engine}
        F -->|Foundation| G[Foundation Pool]
        F -->|Structural| H[Structural Pool]
        F -->|Architectural| I[Architectural Pool]
        F -->|MEP| J[MEP Pool]
        F -->|Civil| K[Civil Pool]
    end

    subgraph Process[3. OpenCV Processing]
        G --> L[OpenCV Engine]
        H --> L
        I --> L
        J --> L
        K --> L
        L --> M[100% Accuracy Validation]
        M -->|Pass| N[Measurement Results]
        M -->|Fail| O[Retry with Different Agent]
    end

    subgraph Output[4. Results Output]
        N --> P[Standards Validation]
        P --> Q[QS Schedule Format]
        Q --> R[Export: CSV/Excel/PDF]
    end
```

### QS Measurement Flow

```mermaid
flowchart TD
    subgraph Input[QS Input]
        A[Floor Plan DWG] --> B[Scale Calibration]
        B --> C[Element Classification]
    end

    subgraph Element[Element Processing]
        C --> D{Element Type}
        D -->|Foundation| E[Strip Measurement]
        D -->|Foundation| F[Pad Measurement]
        D -->|Slab| G[Area Calculation]
        D -->|Wall| H[Length x Height]
        D -->|Door| I[Opening Deduction]
        D -->|Window| J[Opening Deduction]
    end

    subgraph Standards[Standards Application]
        E --> K[SANS 1200 Rules]
        F --> K
        G --> K
        H --> K
        I --> K
        J --> K
        K --> L[Measurement Format]
    end

    subgraph Output[QS Output]
        L --> M[Bill of Quantities]
        M --> N[CostX Export]
        M --> O[Excel Export]
    end
```

### Builder Procurement Segregation Flow

```mermaid
flowchart TD
    subgraph Measure[Measurement Complete]
        A[CAD Measurements] --> B{Procurement Path Selection}
        B -->|QS Formal| C[BOQ Generation]
        B -->|Builder Direct| D[Procurement Segregation Engine]
    end

    subgraph Segregate[Segregation Engine]
        D --> E[Subcontract Classifier]
        D --> F[Purchase Order Classifier]
        D --> G[Service Order Classifier]
        D --> H[Work Order Classifier]
    end

    subgraph Match[Supplier Matching]
        E --> I[Approved Supplier Matching]
        F --> I
        G --> I
        H --> I
        I --> J[Supplier Capability Validation]
        J --> K[Compliance Scoring]
    end

    subgraph Order[PROC-ORDER Integration]
        K --> L[Pre-populated Order Templates]
        L --> M[PROC-ORDER Workflow]
        M --> N[Approval Routing]
        N --> O[Candy Procurement Export]
    end
```

### Post-Tender Subcontract Tendering Flow

```mermaid
flowchart TD
    subgraph Tender[Post-Tender Entry Point]
        A[Tender Won by Builder] --> B[Extract QS BOQ]
        B --> C[BOQ Disaggregation Engine]
    end

    subgraph Disaggregate[BOQ Disaggregation]
        C --> D[Trade/Specialty Identification]
        C --> E[Material Quantity Extraction]
        C --> F[Labour & Plant Allocation]
        D --> G[Electrical Package]
        D --> H[Plumbing Package]
        D --> I[HVAC Package]
        D --> J[Structural Steel Package]
        D --> K[Fire Protection Package]
        D --> L[Civil Works Package]
    end

    subgraph Formulate[Trade Package Formulation]
        E --> G
        E --> H
        E --> I
        E --> J
        E --> K
        E --> L
        F --> G
        F --> H
        F --> I
        F --> J
        F --> K
        F --> L
        G --> M[Tender Document Generation]
        H --> M
        I --> M
        J --> M
        K --> M
        L --> M
    end

    subgraph TenderDocs[Tender Documents]
        M --> N[RFQ Package per Trade]
        M --> O[Scope of Works]
        M --> P[Specification Documents]
        M --> Q[Drawings & Details]
        N --> R[Sub-vendor Invitation]
    end

    subgraph Collect[Quotation Collection]
        R --> S[Quotation Receipt]
        S --> T[Quotation Comparison Matrix]
        T --> U[Compliance Check]
        U --> V[Technical Evaluation]
        V --> W[Commercial Evaluation]
    end

    subgraph Award[Subcontract Award]
        W --> X[Best Value Recommendation]
        X --> Y[Client/Management Approval]
        Y --> Z[Subcontract Agreement Generation]
        Z --> AA[Award Notification]
        AA --> AB[Subcontractor Onboarding]
    end
```

### Civil Measurement Flow

```mermaid
flowchart TD
    subgraph Civil[Civil Engineering Input]
        A[Survey Data] --> B[Alignment Definition]
        A --> C[Cross-Sections]
        B --> D[Chainage Analysis]
        C --> E[Area Calculation]
    end

    subgraph Road[Road Design]
        D --> F[Horizontal Alignment]
        D --> G[Vertical Alignment]
        F --> H[Superelevation]
        H --> I[Pavement Areas]
    end

    subgraph SW[Stormwater]
        E --> J[Catchment Areas]
        J --> K[Pipe Network]
        K --> L[Invert Levels]
    end

    subgraph Earth[Earthworks]
        F --> M[Template Areas]
        M --> N[Cut Volume]
        M --> O[Fill Volume]
        N --> P[Mass Haul]
    end

    subgraph Output[Civil Output]
        I --> Q[Road Quantities]
        L --> R[Pipe Quantities]
        O --> S[Earthwork Summary]
        P --> S
    end
```

## Builder Procurement Segregation Workflows

### BUILDER-MEAS-001: Subcontract Classification

**Purpose**: Segregate specialized trade work for subcontractor procurement

**Classification Categories**:
- Electrical subcontracts (power distribution, lighting, backup systems)
- Plumbing subcontracts (water supply, drainage, fire suppression)
- HVAC subcontracts (ventilation, air conditioning, refrigeration)
- Fire protection subcontracts (sprinklers, alarms, suppression)
- Structural steel subcontracts (fabrication, erection, connections)

**Integration Points**:
- Approved subcontractor database
- Trade licensing verification
- Insurance and bonding validation
- Safety certification tracking

### BUILDER-MEAS-002: Purchase Order Generation

**Purpose**: Materials and equipment procurement classification

**Material Categories**:
- Structural materials (concrete, steel, masonry)
- Architectural finishes (flooring, ceiling, partition systems)
- MEP equipment (transformers, pumps, air handling units)
- Civil materials (aggregate, asphalt, piping)
- Specialty products (acoustic panels, special glazing)

**Integration Points**:
- Candy procurement system
- Supplier catalog integration
- Bulk pricing optimization
- Delivery scheduling coordination

### BUILDER-MEAS-003: Service Order Generation

**Purpose**: Testing, maintenance, and inspection services procurement

**Service Categories**:
- Testing services (concrete, soil, electrical, structural)
- Inspection services (building, fire, electrical, plumbing)
- Commissioning services (MEP systems, building envelope)
- Maintenance services (HVAC, electrical, plumbing)
- Consulting services (engineering, architecture, project management)

**Integration Points**:
- Service provider database
- Certification and licensing tracking
- Insurance verification
- Performance history analysis

### BUILDER-MEAS-004: Work Order Generation

**Purpose**: Internal labor and construction task management

**Work Order Categories**:
- Site preparation (demolition, excavation, grading)
- Concrete works (foundations, slabs, structures)
- Structural steel (erection, connection, fireproofing)
- Architectural finishes (painting, flooring, ceilings)
- General labor (site cleanup, material handling, helpers)

**Integration Points**:
- Internal labor tracking
- Productivity monitoring
- Equipment allocation
- Time and materials tracking

### BUILDER-MEAS-005: Supplier Capability Matching

**Purpose**: Match procurement requirements against approved supplier lists

**Matching Criteria**:
- Supplier specializations and trade categories
- Geographic coverage and delivery capability
- Quality certifications (ISO 9001, B-BBEE level)
- Financial stability and insurance coverage
- Performance history and references

**Compliance Scoring Algorithm**:
```
Compliance Score = 
  (ISO 9001 Certified ? 0.3 : 0) +
  (B-BBEE Level 1 ? 0.3 : B-BBEE Level 2 ? 0.25 : B-BBEE Level 3 ? 0.2 : B-BBEE Level 4 ? 0.15 : 0) +
  (Financial Stability A ? 0.2 : Financial Stability B ? 0.15 : 0)
```

**Integration Points**:
- PROC-ORDER supplier filtering (PROC-034)
- VFS supplier database integration
- Compliance verification automation

### BUILDER-MEAS-006: Candy Integration

**Purpose**: Direct export to Candy procurement system

**Integration Features**:
- Material classification mapping to Candy categories
- Quantity and specification export
- Supplier assignment and pricing
- Order tracking and delivery coordination
- Invoice matching and payment processing

**Data Flow**:
```
MeasureForge AI -> Material Schedules -> Candy API -> Purchase Orders -> Supplier -> Site Delivery
```

### BUILDER-MEAS-007: Budget Variance Monitoring

**Purpose**: Real-time budget tracking and alerts

**Monitoring Features**:
- Budget vs. actual expenditure tracking
- Variance threshold alerts (configurable)
- Trend analysis and forecasting
- Cost optimization recommendations
- Multi-project budget aggregation

**Alert Thresholds**:
- Warning: >80% of budget allocated
- Critical: >95% of budget allocated
- Exceeded: >100% of budget allocated

### BUILDER-MEAS-008: Procurement Approval Routing

**Purpose**: Integration with PROC-ORDER approval workflows

**Approval Matrix Integration**:
- Organization-specific approval routing
- Order value threshold determination
- Multi-level approval chains
- Parallel approval support
- Escalation rules for delays

**Integration Points**:
- 01300 Approval Matrix API (PROC-037)
- PROC-ORDER workflow orchestration
- Email notification triggers
- Approval status tracking

## Post-Tender Subcontract Tendering Workflows

### BUILDER-MEAS-009: BOQ Extraction & Disaggregation

**Purpose**: Extract the QS-discipline-prepared Bill of Quantities and disaggregate by trade/specialty for subcontract tendering

**Process Steps**:
1. Import QS-discipline BOQ from tender documentation
2. Parse BOQ line items by element classification
3. Identify trade/specialty assignments for each line item
4. Extract material quantities by trade category
5. Allocate labour and plant requirements per trade
6. Generate disaggregated trade schedules

**Trade Categories**:
- Electrical (power, lighting, data, fire alarm)
- Plumbing (water supply, drainage, fire suppression)
- HVAC (ventilation, air conditioning, refrigeration)
- Structural Steel (fabrication, erection, connections)
- Fire Protection (sprinklers, suppression systems)
- Civil Works (earthworks, stormwater, roads)

**Integration Points**:
- QS measurement system (QS-MEAS series workflows)
- BOQ import from CostX, Excel, or PDF
- Trade classification database
- Material schedule generation

### BUILDER-MEAS-010: Trade Package Formulation

**Purpose**: Create structured tender packages for each trade/specialty based on disaggregated BOQ data

**Package Components**:
- Scope of works per trade
- Material specifications and quantities
- Labour and plant schedule
- Programme and milestone requirements
- Technical specifications
- Drawings and detail references
- Preliminaries allocation

**Trade Package Types**:
- Electrical installation package
- Plumbing and drainage package
- HVAC installation package
- Structural steel package
- Fire protection package
- Civil works package
- Specialist packages (acoustic, specialist glazing)

**Integration Points**:
- BOQ disaggregation output (BUILDER-MEAS-009)
- Specification templates per trade
- Programme scheduling system
- Drawing management system

### BUILDER-MEAS-011: Subcontract Tender Document Generation

**Purpose**: Generate complete RFQ packages, tender documents, and scope of works for sub-vendor invitation

**Document Generation**:
- Request for Quotation (RFQ) per trade package
- Invitation to Tender (ITT) letters
- Scope of Works (SOW) documents
- Technical specifications
- Drawings and detail packages
- Preliminaries and general conditions
- Tender return instructions and deadline

**Document Templates**:
- CIDB-compliant tender documents
- FIDIC subcontract templates
- NEC4 subcontract templates
- Custom builder templates

**Integration Points**:
- Trade package formulation (BUILDER-MEAS-010)
- Document template library
- Email/portal invitation system
- Tender tracking system

### BUILDER-MEAS-012: Sub-vendor Quotation Collection

**Purpose**: Collect, compare, and evaluate subcontract quotations from invited specialty contractors

**Collection Process**:
1. Track tender submissions from sub-vendors
2. Receive and log quotations
3. Generate quotation comparison matrix
4. Validate compliance with tender requirements
5. Conduct technical evaluation
6. Conduct commercial evaluation
7. Generate evaluation report

**Comparison Matrix Fields**:
- Subcontractor name and registration
- Quoted price (R) and currency
- Validity period
- Programme commitment
- B-BBEE level
- CIDB grading
- Technical compliance score
- Commercial compliance score

**Evaluation Criteria**:
- Price competitiveness
- Technical capability
- Programme suitability
- B-BBEE contribution
- Safety record
- References and experience

**Integration Points**:
- Tender document generation (BUILDER-MEAS-011)
- Supplier database (VFS)
- Compliance verification system
- Evaluation scoring engine

### BUILDER-MEAS-013: Subcontract Award Processing

**Purpose**: Evaluate bids, recommend best-value subcontractor, obtain approval, and generate subcontract agreements

**Award Process**:
1. Compile best-value recommendation report
2. Submit for management/client approval
3. Issue award notification to successful subcontractor
4. Generate subcontract agreement
5. Process onboarding documentation
6. Issue subcontractor welcome pack

**Agreement Types**:
- Lump sum subcontract
- Schedule of rates subcontract
- Cost-plus subcontract
- Labour-only subcontract

**Compliance Requirements**:
- CIDB contractor registration verification
- Insurance certificate collection
- B-BBEE certificate verification
- Safety induction documentation
- Tax clearance certificate
- Payment guarantee/bonding

**Integration Points**:
- Quotation collection (BUILDER-MEAS-012)
- PROC-ORDER approval workflows
- Contract template library
- Subcontractor onboarding system
- Insurance verification system

## Agent Pool Architecture

### 2000+ Measurement Agents

```
+-------------------------------------------------------------------------------+
|                    Measurement Agent Pools                                     |
|                                                                               |
|  +---------------------------------------------------------------------+     |
|  | Foundation Pool (200+ agents)                                       |     |
|  |  - Strip Footing - Pad Footing - Raft Foundation                   |     |
|  |  - Pile Foundation - Pile Cap - Grade Beam                         |     |
|  +---------------------------------------------------------------------+     |
|                                                                               |
|  +---------------------------------------------------------------------+     |
|  | Structural Pool (300+ agents)                                       |     |
|  |  - Column - Beam - Slab - Wall - Core                              |     |
|  |  - Transfer Slab - Bracing - Connection                            |     |
|  +---------------------------------------------------------------------+     |
|                                                                               |
|  +---------------------------------------------------------------------+     |
|  | Architectural Pool (400+ agents)                                    |     |
|  |  - Door - Window - Curtain Wall - Partition                        |     |
|  |  - Ceiling - Flooring - Staircase - Railing                        |     |
|  +---------------------------------------------------------------------+     |
|                                                                               |
|  +---------------------------------------------------------------------+     |
|  | MEP Pool (500+ agents)                                              |     |
|  |  - HVAC Duct - Pipe - Conduit - Cable Tray                         |     |
|  |  - Equipment - Sprinkler - Fire Alarm - Data                       |     |
|  +---------------------------------------------------------------------+     |
|                                                                               |
|  +---------------------------------------------------------------------+     |
|  | Civil Pool (600+ agents)                                            |     |
|  |  - Road Alignment - Pavement - Stormwater - Earthworks             |     |
|  |  - Bridge - Tunnel - Retaining Wall - Utility                      |     |
|  +---------------------------------------------------------------------+     |
|                                                                               |
|  +---------------------------------------------------------------------+     |
|  | Builder Procurement Pool (35-40 agents)                             |     |
|  |  - Procurement Classifier Agent                                     |     |
|  |  - Subcontract Procurement Agent                                    |     |
|  |  - Materials Procurement Agent                                      |     |
|  |  - Service Procurement Agent                                        |     |
|  |  - Work Order Procurement Agent                                     |     |
|  |  - Supplier Matching Agent                                          |     |
|  |  - Candy Integration Agent                                          |     |
|  |  - Budget Monitoring Agent                                          |     |
|  |  - Approval Routing Agent                                           |     |
|  +---------------------------------------------------------------------+     |
+-------------------------------------------------------------------------------+
```

### Builder Procurement Agent Details

| Agent | Purpose | Input | Output |
|-------|---------|-------|--------|
| Procurement Classifier | Analyzes measurements and routes to appropriate procurement categories | CAD measurements, material classifications | Procurement type assignment (subcontract/PO/SO/WO) |
| Subcontract Agent | Handles specialized trade subcontracts | Trade requirements, specifications | Subcontract RFQ, supplier shortlist |
| Materials Agent | Manages purchase orders for materials | Material schedules, quantities | Purchase orders, delivery schedules |
| Service Agent | Coordinates testing and inspection services | Service requirements, timelines | Service orders, provider assignments |
| Work Order Agent | Manages internal labor and tasks | Task definitions, labor requirements | Work orders, resource allocation |
| Supplier Matching Agent | Matches requirements to approved suppliers | Requirements, capability criteria | Supplier matches, compliance scores |
| Candy Integration Agent | Direct export to Candy system | Material data, specifications | Candy orders, tracking numbers |
| Budget Monitoring Agent | Tracks budget and variances | Expenditure data, budgets | Alerts, variance reports |
| Approval Routing Agent | Manages PROC-ORDER approvals | Order data, approval matrix | Approval requests, status updates |

## Standards Mapping

### Quantity Surveying Standards

| Standard | Region | Element Coverage | Measurement Rules |
|----------|--------|-----------------|------------------|
| SANS 1200 | South Africa | Building | Prefixed works, method of measurement |
| CESMM4 | UK | Civil Engineering | Work sections, defined terms |
| NRM | UK | Building | Detailed, intermediate, elementary |
| FIDIC | International | All | Red Book, Yellow Book, Pink Book |
| UniFormat | USA | Building | Assembly-based |
| MasterFormat | USA | Building | CSI 6-digit codes |

### Procurement Standards

| Standard | Region | Application | Requirements |
|----------|--------|-------------|--------------|
| CIDB | South Africa | Construction procurement | Grading requirements, contractor registration |
| B-BBEE | South Africa | Supplier evaluation | Level certification, scorecard compliance |
| ISO 9001 | International | Quality management | Certified supplier verification |
| FIDIC | International | Contract procurement | Red Book, Yellow Book, Silver Book |
| NEC4 | UK | Construction contracts | Engineering and Construction Contract |

### Measurement Units

| Quantity | Unit | Standard |
|----------|------|----------|
| Length | m, km, mm | All |
| Area | m2, km2, ha | All |
| Volume | m3, km3 | All |
| Mass | kg, t | Structural, MEP |
| Count | nr, sum | All |
| Time | h, day, week | Temporary works |

## PROC-ORDER Integration Reference

### Gap Analysis Status (as of 2026-04-16)

| Category | Implementation | Status |
|----------|---------------|--------|
| Procurement Order Creation | 5-phase workflow | Implemented |
| Supplier Filtering | Hierarchical filtering | PROC-034 (In Progress) |
| Approval Matrix | Multi-level routing | PROC-037 (In Progress) |
| CDC/DDI Collection | Guinea compliance | PROC-036 (Planned) |
| Template Defaults | Complexity-based | PROC-035 (Planned) |
| VFS Backend | Supplier cards, compliance | PROC-038 (Planned) |
| Prompt Management | AI workflow prompts | PROC-039 (Planned) |
| Multi-Jurisdiction | CIDB, SARS, EU compliance | PROC-040 (Planned) |

### Integration Points

1. **Supplier Hierarchical Filter** (PROC-034)
   - Measurement system feeds material requirements
   - Procurement segregation routes to appropriate supplier categories
   - Compliance scoring integrated with builder-approved suppliers

2. **Approval Matrix Integration** (PROC-037)
   - Builder direct procurement uses simplified approval paths
   - Budget thresholds trigger appropriate approval levels
   - Integration with existing 01300 approval workflows

3. **Template-Based Defaults** (PROC-035)
   - Procurement type determines template selection
   - Builder templates vs. formal procurement templates
   - Complexity-based workflow assignment

## Related Documentation

- [Platform Structure](./DISCIPLINE-PLATFORM-STRUCTURE.md)
- [UI/UX Specification](../disciplines/02025-quantity-surveying/plans/ui-ux/)
- [OpenCV Architecture](../plans/system design/2026-04-20-opencv-measurement-architecture.md)
- [Builder Direct Procurement Integration](../companies/measureforge-ai/business/2026-04-22-builder-direct-procurement-integration.md)
- [PROC-ORDER Project](../disciplines/01900-procurement/projects/PROC-ORDER/project.md)
- [Workflow Gap Analysis](../disciplines/01900-procurement/projects/PROC-ORDER/01900_WORKFLOW_GAP_ANALYSIS.md)

---

**Document Version**: 1.2
**Last Updated**: 2026-04-25
**Workflow Count**: 35+ core workflows (including 8 builder procurement + 5 post-tender subcontract tendering workflows)
**Agent Pool**: 2000+ measurement agents + 35-40 builder procurement agents
**Accuracy Target**: 100% for all measurement and procurement classification workflows
