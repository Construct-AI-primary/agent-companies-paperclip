---
title: AI-Native Desktop Integration — Civil Engineering Workflow
author: Construct AI Memory System Team
date: 2026-03-31
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs/desktop_specs
gigabrain_tags: disciplines, 00850_civil-engineering, ai-native, desktop-integration, agent-coordination, dwg-processing, document-generation, bim-intelligence, multi-agent-orchestration
openstinger_context: ai-native-desktop-integration, agent-architecture, desktop-workflow
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/prompts/00850_AI-NATIVE-CIVIL-ENGINEERING-PROMPT.md
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_GLOSSARY.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/workflow_docs/main/0000_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
---

# AI-Native Desktop Integration — Civil Engineering Workflow

## Overview

This document defines the AI-native desktop integration architecture for the Civil Engineering workflow card system. It covers agent coordination, document generation pipeline integration, DWG processing workflow, quality gates, structured data injection, agent state detection, and multi-agent orchestration on the desktop platform.

---

## 1. AI Agent Coordination Architecture

### Desktop Agent Hub Architecture
The desktop workflow system coordinates AI agents through a central Agent Hub that sits between the UI card system and individual AI agent services.

```
┌─────────────────────────────────────────────────────┐
│                   Desktop UI Layer                  │
│  Workflow Dashboard → Card View → Agent Assignment   │
├─────────────────────────────────────────────────────┤
│                   Agent Hub (API)                   │
│  • Task Routing  • State Management  • Validation   │
│  • Progress Tracking  • Error Handling  • Audit     │
├──────┬──────┬──────┬──────┬──────┬──────┬──────┤
│ Site │ Geo- │ Struct│ Drain│ BIM  │ NCR/ │ Spec │
│Assess│ tech │ Anal  │ Agent│Agent │ RFI  │Compli│
│ Agent│ Agent│ Agent │      │      │ Agent│ Agent│
└──────┴──────┴──────┴──────┴──────┴──────┴──────┘
```

### Agent State Detection
- **Capability Detection**: Desktop UI queries agent registry to determine available agents and their capabilities
- **Health Monitoring**: Continuous agent health checking with automatic failover to human workflow when agents unavailable
- **Conditional UI Visibility**: "Document Generator" and AI-assisted UI elements only visible when relevant agents are healthy and capable
- **Progress Indicators**: Real-time agent execution status shown in card UI (queued, processing, completed, failed)
- **Escalation Display**: When agent fails or cannot process, clear escalation UI shows human intervention options

### Agent Assignment Workflow
1. Card opened → Agent Hub queries required agent capabilities for card type
2. Agent Hub checks agent availability and capacity
3. Assignment displayed in card header with status indicator
4. Agent processes structured input data from card
5. Results returned to card with structured output
6. Human review UI displayed for agent output
7. Approval or revision submitted back through Agent Hub

---

## 2. Document Generation Pipeline Integration

### Template Engine Integration
The desktop UI integrates with the document generation pipeline at three levels:

**Level 1: Template Selection UI**
- Card displays available document templates based on current phase and project context
- Template metadata shown: type, phase, required inputs, estimated generation time
- User selects template or AI recommends based on card context

**Level 2: Structured Data Mapping**
- Template placeholders displayed with mapped data sources
- Each placeholder shows: data source (BIM element, survey point, test result), value status (available/pending), provenance reference
- Missing data identified with option to flag for collection or use placeholder value

**Level 3: Document Generation and Review**
- Generation progress shown in real-time
- Generated document preview with structured data highlighting
- Missing or low-confidence data highlighted in document
- Human review interface with approve/revise options
- Version control with change diff display

### Desktop Card to Document Type Mapping
| Card | AI-Generated Documents | Template Sources |
|------|----------------------|------------------|
| Project Brief | Concept Design Brief, Design Basis | Phase 1 templates |
| Site Survey | Site Assessment Report, Feasibility Report | Phase 1 templates |
| Geotechnical | Foundation Recommendation Report | Phase 1 templates |
| Design Options | Options Analysis Matrix | Phase 2 templates |
| Preliminary Layout | Preliminary Design Report | Phase 2 templates |
| Engineering Calculations | Calculation Summary Documents | Phase 3 templates |
| Preliminary Drawings | Preliminary Drawing Sets | Phase 3 templates |
| Construction Drawings | Construction Drawing Sets | Phase 4 templates |
| Technical Specifications | Technical Specification Documents | Phase 4 templates |
| Quantity Schedules | Bills of Quantities | Phase 4 templates |
| Inspection & Test Plans | ITP Documents | Phase 4 templates |
| Tender Documents | Tender Package Documents | Phase 4 templates |
| Construction Support | RFIs, NCRs, Progress Reports | Phase 3/5 templates |

---

## 3. DWG Processing Workflow

### Desktop DWG Upload Pipeline
Each card that requires drawing input follows this workflow:

1. **Upload**: User uploads DWG through card interface
2. **Preprocessing Queue**: DWG enters preprocessing queue (AUDIT → PURGE → OVERKILL)
3. **Extraction**: Extraction schema applied based on drawing type classification
4. **Validation**: Extracted data validated against schema rules
5. **Results Display**: Extracted data displayed in structured format for review
6. **Human Verification**: CAD coordinator reviews and approves extracted data
7. **Downstream Use**: Verified data available for AI document generation and analysis

### Card-Specific DWG Processing
| Card | Drawing Types | Extraction Schema |
|------|--------------|-------------------|
| Site Survey | Topographic surveys, boundary surveys | Survey point extraction, contour extraction |
| Geotechnical | Borehole location plans, geological maps | Coordinate extraction, cross-section data |
| Design Options | Site constraints plans, zoning plans | Boundary extraction, constraint extraction |
| Preliminary Layout | Concept layouts, alignment plans | Alignment extraction, zone extraction |
| Preliminary Drawings | Preliminary design drawings | Element extraction, dimension extraction |
| Construction Drawings | Construction drawings, shop drawings | Full element extraction, detail extraction |
| Quantity Schedules | Construction drawings, BIM models | Quantity extraction per BOQ item |

### Quality Gates for DWG Processing
- **Pre-Gate**: Upload validation (file type, size, corruption check)
- **Processing Gate**: Preprocessing complete (AUDIT/PURGE/OVERKILL)
- **Extraction Gate**: Schema validation pass rate > 90%
- **Verification Gate**: Human coordinator review and approval
- **Usage Gate**: Provenance tags attached before data used downstream

---

## 4. Structured Data Injection Architecture

### Data Source Registry
The desktop system maintains a registry of structured data sources:

| Source Type | Data Format | Processing Path | Confidence |
|-------------|------------|-----------------|------------|
| BIM/IFC Models | IFC 4.x, IFC JSON | IFC processor → JSON → structured data | High |
| CAD Exports | DWG (processed), DXF (processed) | DWG pipeline → extraction schema | Medium-High |
| Survey Data | GeoJSON, CSV with CRS | Survey point schema validation | High |
| Lab Test Results | Structured JSON | Test result schema validation | High |
| Material Test Results | Structured JSON | Material test schema validation | High |
| Cost Databases | Structured JSON | Cost schema validation | Medium |
| Code/Standards Database | Vector DB, structured clauses | Code query schema | High |

### Injection Pipeline
1. **Data Query**: Card requests structured data from Agent Hub
2. **Source Resolution**: Agent Hub resolves data sources based on card context
3. **Data Validation**: Data validated against expected schema
4. **Injection**: Validated data injected into document templates
5. **Provenance Tagging**: Each injected value tagged with source reference
6. **Display**: Generated data values displayed with provenance indicators

### Provenance Display in Desktop UI
- Every AI-generated value shows a provenance indicator (clickable)
- Click reveals: source system, source element/ID, extraction date, confidence level
- Low-confidence values highlighted with warning icon
- Missing values shown as "unknown — requires input" with data collection prompt

---

## 5. Multi-Agent Orchestration on Desktop

### Orchestration Flow
```
Card Action → Agent Hub → Orchestrator → Agent Chain → Results → Card Display

Agent Chain:
  1. Data Collection Agent — gathers structured data from sources
  2. Analysis Agent — processes data through calculation/analysis engines
  3. Document Generation Agent — generates structured document from results
  4. Quality Validation Agent — validates document completeness and accuracy
  5. Human Review Interface — displays results for review and approval
```

### Inter-Card Coordination
- Cards share structured data through central data repository
- When one card completes, dependent cards notified of available data
- Agent Hub manages data dependencies between cards
- Revision propagation: when source data changes, affected cards notified
- Conflict detection: conflicting data from multiple cards identified and flagged

### Quality Checkpoints Between Agent Handoffs
- **Schema Validation**: Each agent input/output validated against schema
- **Range Checking**: Numeric values checked against expected ranges
- **Completeness Check**: Required fields present before passing to next agent
- **Consistency Check**: Data consistent across related documents
- **Provenance Check**: All geometry-derived values carry provenance tags

---

## 6. Desktop Implementation Architecture

### Component Structure
```
DesktopUI/
├── AgentHub/
│   ├── AgentRegistry.jsx          # Available agents and capabilities
│   ├── AgentOrchestrator.jsx       # Multi-agent workflow coordination
│   ├── AgentHealth.jsx            # Real-time agent health monitoring
│   └── AgentEscalation.jsx        # Human intervention when agents fail
├── DocumentEngine/
│   ├── TemplateSelector.jsx       # Document template selection
│   ├── DataMapper.jsx             # Structured data to template mapping
│   ├── DocumentPreview.jsx        # Generated document preview
│   └── RevisionControl.jsx        # Document versioning and diff
├── DWGProcessor/
│   ├── DWGUploader.jsx            # DWG upload with validation
│   ├── ProcessingStatus.jsx       # Real-time DWG pipeline status
│   ├── ExtractionReview.jsx       # Extracted data review interface
│   └── CoordinateDisplay.jsx      # Coordinate reference system display
└── DataRegistry/
    ├── SourceViewer.jsx           # Structured data source browser
    ├── ProvenanceTracker.jsx      # Data provenance timeline
    ├── QualityDashboard.jsx       # Data quality metrics
    └── ConflictResolver.jsx       # Data conflict resolution
```

### API Integration Points
```javascript
// Agent Hub
POST /api/agents/assign           — Assign agent to card task
GET  /api/agents/status           — Check agent availability and health
POST /api/agents/execute          — Execute agent with structured input
GET  /api/agents/result           — Retrieve structured agent output
POST /api/agents/escalate         — Escalate to human when agent fails

// Document Generation
GET  /api/templates/available     — List available templates for card type
POST /api/documents/generate      — Generate document from structured data
GET  /api/documents/preview       — Get document preview with provenance
POST /api/documents/approve       — Approve document for downstream use

// DWG Processing
POST /api/dwg/upload              — Upload DWG for processing
GET  /api/dwg/status              — Check DWG processing status
GET  /api/dwg/extraction          — Get extracted structured data
POST /api/dwg/verify              — Human verification of extraction

// Data Registry
GET  /api/sources/list            — List available structured data sources
GET  /api/sources/query           — Query structured data source
GET  /api/provenance/trace        — Trace data provenance
POST /api/provenance/log          — Log data usage for audit trail
```

---

## References

- **AI-Native Prompt**: `00850_AI-NATIVE-CIVIL-ENGINEERING-PROMPT.md`
- **Domain Knowledge**: `00850_DOMAIN-KNOWLEDGE.MD` Part 6B
- **Glossary**: `00850_GLOSSARY.MD`
- **Main Workflow**: `0000_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD`
- **Implementation Phases**: `0000_AI-NATIVE-IMPLEMENTATION_PHASES.MD`