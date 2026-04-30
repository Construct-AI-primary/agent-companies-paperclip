---
title: AI-Native Civil Engineering Workflow Diagrams
author: Construct AI Memory System Team
date: 2026-03-31
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs/diagrams
gigabrain_tags: disciplines, 00850_civil-engineering, ai-native-diagrams, multi-agent-orchestration, document-generation-pipeline, dwg-processing-pipeline, bim-intelligence, automation-spectrum
openstinger_context: ai-native-diagrams, workflow-visualization, agent-architecture
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/prompts/00850_AI-NATIVE-CIVIL-ENGINEERING-PROMPT.md
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/workflow_docs/main/0000_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
---

# AI-Native Civil Engineering Workflow Diagrams

## Overview

This file contains Mermaid diagrams for all AI-native civil engineering workflows referenced in the remediation plan and main workflow document.

---

## Diagram 1: Multi-Agent Orchestration

Agent coordination sequence from site data through NCR/RFI.

```mermaid
flowchart TD
    %% Entry Point
    SITE_DATA([📦 Site Data Received])
    
    %% Phase 1: Assessment
    subgraph "Phase 1: Site Assessment"
        SITE_DATA --> ORCH[🎯 Orchestrator Agent]
        ORCH --> SITE_ASSESS[🔍 Site Assessment Agent]
        SITE_ASSESS -->|Structured JSON: Feasibility Result| FOUNDATION[🏗️ Foundation Design Agent]
    end
    
    %% Phase 2: Design
    subgraph "Phase 2: Design"
        FOUNDATION -->|Structured JSON: Foundation Recommendation| DRAIN[💧 Drainage Agent]
        DRAIN -->|Structured JSON: Drainage Design| BIM[🔧 BIM Clash Agent]
        BIM -->|No Clashes Detected| QTO[📊 Quantity Take-Off Agent]
        BIM -->|Clashes Detected| RESOLVE[🔄 Clash Resolution Coordinator]
        RESOLVE -->|Revised Design| BIM
    end
    
    %% Phase 3: Documentation
    subgraph "Phase 3: Documentation Generation"
        QTO -->|Structured JSON: BOQ Data| NCR_RFI[📝 NCR/RFI Drafting Agent]
        QTO -->|Structured JSON: BOQ Data| DOC_GEN[📋 Document Generation Agent]
        NCR_RFI -->|Structured JSON: Draft NCR/RFI| SPEC_CHECK[✅ Spec Compliance Agent]
        DOC_GEN -->|Structured JSON: Draft Documents| QUALITY[🔍 Quality Validation Agent]
    end
    
    %% Phase 4: Review and Output
    subgraph "Phase 4: Human Review"
        SPEC_CHECK -->|Validated| HUMAN_REVIEW[👤 Human Review Gate]
        QUALITY -->|Validated| HUMAN_REVIEW
        HUMAN_REVIEW -->|Approved| OUTPUT([📤 Output: Approved Documents])
        HUMAN_REVIEW -->|Rejected| REVISION[🔄 Revision Required]
        REVISION --> DOC_GEN
    end
    
    %% Orchestration Layer
    subgraph "Orchestration Layer"
        ORCHESTRATE{🎯 Error Handler}
    end
    
    SITE_ASSESS -->|Agent Error| ORCHESTRATE
    FOUNDATION -->|Agent Error| ORCHESTRATE
    DRAIN -->|Agent Error| ORCHESTRATE
    ORCHESTRATE -->|Escalate| HUMAN_ESCALATION[👤 Human Escalation]
    ORCHESTRATE -->|Retry| RETRY[🔄 Agent Retry]
    RETRY --> ORCH
    
    %% Audit Trail
    subgraph "Audit Trail"
        AUDIT[(📊 Audit Log)]
    end
    
    ORCH -.-> AUDIT
    SITE_ASSESS -.-> AUDIT
    FOUNDATION -.-> AUDIT
    DRAIN -.-> AUDIT
    BIM -.-> AUDIT
    QTO -.-> AUDIT
    NCR_RFI -.-> AUDIT
    DOC_GEN -.-> AUDIT
    SPEC_CHECK -.-> AUDIT
    QUALITY -.-> AUDIT
    HUMAN_REVIEW -.-> AUDIT
    
    %% Styling
    classDef phase1 fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef phase2 fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    classDef phase3 fill:#e8f5e8,stroke:#388e3c,stroke-width:2px
    classDef phase4 fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    classDef audit fill:#f5f5f5,stroke:#9e9e9e,stroke-width:1px,stroke-dasharray: 5 5
    classDef orchestrate fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    
    class SITE_ASSESS,FOUNDATION phase1
    class DRAIN,BIM,RESOLVE phase2
    class QTO,NCR_RFI,DOC_GEN,SPEC_CHECK,QUALITY phase3
    class HUMAN_REVIEW,OUTPUT,REVISION phase4
    class AUDIT audit
    class ORCHESTRATE,ORCH,RETRY,HUMAN_ESCALATION orchestrate
```

---

## Diagram 2: Document Generation Pipeline

Pipeline from input data collection through output.

```mermaid
flowchart TD
    %% Stage 1: Input Collection
    INPUTS([📥 Input Data Collection])
    BIM_IN[BIM Models]
    SURVEY_IN[Survey Data]
    CALC_IN[Calculation Results]
    SITE_IN[Site Data]
    
    INPUTS --> BIM_IN
    INPUTS --> SURVEY_IN
    INPUTS --> CALC_IN
    INPUTS --> SITE_IN
    
    %% Stage 2: Validation
    VALIDATION{🔍 Structured Data Validation}
    BIM_IN --> VALIDATION
    SURVEY_IN --> VALIDATION
    CALC_IN --> VALIDATION
    SITE_IN --> VALIDATION
    
    SCHEMA[Schema Check]
    UNITS[Units Check]
    RANGES[Ranges Check]
    COMPLETE[Completeness Check]
    
    VALIDATION --> SCHEMA
    VALIDATION --> UNITS
    VALIDATION --> RANGES
    VALIDATION --> COMPLETE
    
    VALIDATION -->|Failed| FAIL_ACTION[❌ Reject: Flag for Data Collection]
    VALIDATION -->|Passed| TEMPLATE{📋 Template Selection}
    
    %% Stage 3: Template Selection
    TEMPLATE -->|Phase 1: Pre-Design| T1[Feasibility Report Template]
    TEMPLATE -->|Phase 2: Design| T2[Calculation Summary Template]
    TEMPLATE -->|Phase 3: Construction| T3[Method Statement Template]
    TEMPLATE -->|Phase 4: Strategic| T4[Tender Document Template]
    
    %% Stage 4: Data Injection
    subgraph "Data Injection"
        T1 --> INJECT[(⚙️ Data Injection Engine)]
        T2 --> INJECT
        T3 --> INJECT
        T4 --> INJECT
        
        PLACEHOLDER[📝 Template Placeholders]
        SOURCE[📦 Mapped Data Sources]
        PROVENANCE[🏷️ Provenance Tags]
        CONDITIONAL[🔄 Conditional Logic]
        
        INJECT --> PLACEHOLDER
        INJECT --> SOURCE
        INJECT --> PROVENANCE
        INJECT --> CONDITIONAL
    end
    
    %% Stage 5: Quality Validation
    subgraph "Quality Validation"
        INJECT --> QUALITY{🔍 Quality Check}
        COMPLETENESS[Completeness Check]
        ACCURACY[Accuracy Check]
        CODE_COMP[Code Compliance Check]
        CONDITIONAL_LOGIC[Conditional Logic Check]
        
        QUALITY --> COMPLETENESS
        QUALITY --> ACCURACY
        QUALITY --> CODE_COMP
        QUALITY --> CONDITIONAL_LOGIC
        
        QUALITY -->|Failed| FAIL_DOC[❌ Reject: Flag for Revision]
        QUALITY -->|Passed| DRAFT[📝 Draft Document]
    end
    
    %% Stage 6: Human Review
    DRAFT --> HUMAN_REVIEW{👤 Human Review}
    HUMAN_REVIEW -->|Design/Regulatory| REQUIRED[Review Required]
    HUMAN_REVIEW -->|Routine| OPTIONAL[Review Optional]
    
    REQUIRED --> APPROVAL{✅ Approval Decision}
    OPTIONAL --> APPROVAL
    
    APPROVAL -->|Approved| FINAL[📄 Final Document]
    APPROVAL -->|Rejected| REVISE[🔄 Revision Required]
    REVISE --> DRAFT
    
    %% Stage 7: Output
    FINAL --> OUTPUT{📤 Output Generation}
    OUTPUT --> PDF[PDF]
    OUTPUT --> DOCX[DOCX]
    OUTPUT --> JSON[Structured JSON]
    OUTPUT --> EXCEL[Excel]
    
    %% Audit Trail
    subgraph "Version Control & Audit"
        VERSION[📝 Version Control]
        AUDIT[(📊 Audit Log)]
    end
    
    FINAL -.-> VERSION
    APPROVAL -.-> AUDIT
    DRAFT -.-> AUDIT
    INJECT -.-> AUDIT
    
    %% Styling
    classDef input fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef validation fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    classDef template fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    classDef inject fill:#e8f5e8,stroke:#388e3c,stroke-width:2px
    classDef quality fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    classDef human fill:#ffffff,stroke:#6c757d,stroke-width:2px
    classDef output fill:#d4edda,stroke:#155724,stroke-width:2px
    classDef fail fill:#f8d7da,stroke:#721c24,stroke-width:2px
    classDef audit fill:#f5f5f5,stroke:#9e9e9e,stroke-width:1px,stroke-dasharray: 5 5
    
    class BIM_IN,SURVEY_IN,CALC_IN,SITE_IN input
    class VALIDATION,SCHEMA,UNITS,RANGES validation
    class T1,T2,T3,T4 template
    class INJECT,PLACEHOLDER,SOURCE,PROVENANCE inject
    class QUALITY,COMPLETENESS,ACCURACY,CODE_COMP quality
    class HUMAN_REVIEW,APPROVAL,REQUIRED,OPTIONAL human
    class FINAL,PDF,DOCX,JSON,EXCEL output
    class FAIL_ACTION,FAIL_DOC,REVISE fail
    class VERSION,AUDIT audit
```

---

## Diagram 3: DWG Processing Pipeline Architecture

Formal DWG pipeline: RAW → PREPROCESSING → EXTRACTION → VALIDATION → STRUCTURED DATA.

```mermaid
flowchart TD
    %% Entry
    RAW_DWG([📁 Raw DWG Input])
    
    %% Preprocessing
    subgraph "Preprocessing"
        RAW_DWG --> AUDIT{🔍 AUDIT}
        AUDIT -->|Corruption Found| REPAIR[🔧 Repair Database Errors]
        AUDIT -->|Clean| PURGE{🗑️ PURGE}
        REPAIR --> PURGE
        
        PURGE -->|Unused Found| CLEAN[🧹 Remove Unused Items]
        CLEAN --> OVERKILL{✂️ OVERKILL}
        PURGE -->|Clean| OVERKILL
        
        OVERKILL -->|Duplicates Found| MERGE[🔄 Merge Duplicates]
        OVERKILL -->|Clean| PREPROCESS_DONE[✅ Preprocessing Complete]
        MERGE --> PREPROCESS_DONE
    end
    
    %% Extraction
    subgraph "Extraction"
        PREPROCESS_DONE --> CLASSIFY{📋 Drawing Type Classification}
        
        CLASSIFY -->|Structural GA| EXT_STRUCT[🏗️ Structural GA Schema]
        CLASSIFY -->|Civil GA| EXT_CIVIL[🛤️ Civil GA Schema]
        CLASSIFY -->|Reinforcement| EXT_REINF[🔩 Reinforcement Schema]
        CLASSIFY -->|Drainage| EXT_DRAIN[💧 Drainage Schema]
        CLASSIFY -->|P&ID| EXT_PID[📐 P&ID Schema]
        CLASSIFY -->|Other| EXT_OTHER[🔮 Generic Schema]
        
        EXT_STRUCT --> EXTRACT[(⚙️ Feature Extraction)]
        EXT_CIVIL --> EXTRACT
        EXT_REINF --> EXTRACT
        EXT_DRAIN --> EXTRACT
        EXT_PID --> EXTRACT
        EXT_OTHER --> EXTRACT
    end
    
    %% Schema Validation
    subgraph "Schema Validation"
        EXTRACT --> SCHEMA{🔍 Schema Validation}
        
        UNITS[Units Check]
        RANGES[Ranges Check]
        TOPOLOGY[Topology Check]
        CONSISTENCY[Consistency Check]
        
        SCHEMA --> UNITS
        SCHEMA --> RANGES
        SCHEMA --> TOPOLOGY
        SCHEMA --> CONSISTENCY
        
        ALL_PASS{All Checks Pass?}
        UNITS --> ALL_PASS
        RANGES --> ALL_PASS
        TOPOLOGY --> ALL_PASS
        CONSISTENCY --> ALL_PASS
        
        ALL_PASS -->|Yes| STRUCTURED_JSON[✅ Structured JSON Output]
        ALL_PASS -->|No| REJECT{❌ Validation Failed}
    end
    
    %% Human Verification
    subgraph "Human Verification"
        STRUCTURED_JSON --> CAD_REVIEW{👤 CAD Coordinator Review}
        
        CAD_REVIEW -->|Approved| AI_READY([🤖 AI-Ready Structured Data])
        CAD_REVIEW -->|Needs Fix| FIX_REQUIRED[🔧 Mark for CAD Fix]
        REJECT --> FIX_REQUIRED
        FIX_REQUIRED --> CAD_HUMAN[👤 Human CAD Fix]
        CAD_HUMAN --> EXTRACT
    end
    
    %% Provenance
    subgraph "Provenance Tags"
        STRUCTURED_JSON -.-> PROV[🏷️ Source Drawing]
        STRUCTURED_JSON -.-> PROV2[🏷️ Revision Number]
        STRUCTURED_JSON -.-> PROV3[🏷️ Entity ID]
        STRUCTURED_JSON -.-> PROV4[🏷️ Extraction Timestamp]
        
        PROV --- PROV2 --- PROV3 --- PROV4
    end
    
    %% Guard Rails
    subgraph "Guard Rails"
        GR1[1. No Fabrication: LLM cannot create geometry]
        GR2[2. Provenance Required: All values tagged]
        GR3[3. Unknown Flag: Missing data = unknown]
        GR4[4. Validation Gate: Failed check → no AI]
        GR5[5. Human Verification: Before commercial use]
    end
    
    AI_READY -.-> GR1
    AI_READY -.-> GR2
    AI_READY -.-> GR3
    AI_READY -.-> GR4
    AI_READY -.-> GR5
    
    %% Styling
    classDef input fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef preprocess fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    classDef extract fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    classDef validation fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    classDef human fill:#ffffff,stroke:#6c757d,stroke-width:2px
    classDef output fill:#d4edda,stroke:#155724,stroke-width:2px
    classDef fail fill:#f8d7da,stroke:#721c24,stroke-width:2px
    classDef prove fill:#f5f5f5,stroke:#9e9e9e,stroke-width:1px,stroke-dasharray: 5 5
    classDef guard fill:#e8f5e8,stroke:#2e7d32,stroke-width:1px
    
    class RAW_DWG input
    class AUDIT,PURGE,OVERKILL,REPAIR,CLEAN,MERGE,PREPROCESS_DONE preprocess
    class CLASSIFY,EXT_STRUCT,EXT_CIVIL,EXT_REINF,EXT_DRAIN,EXT_PID,EXT_OTHER,EXTRACT extract
    class SCHEMA,UNITS,RANGES,TOPOLOGY,CONSISTENCY validation
    class CAD_REVIEW,CAD_HUMAN human
    class STRUCTURED_JSON,AI_READY output
    class REJECT,FIX_REQUIRED fail
    class PROV,PROV2,PROV3,PROV4 prove
    class GR1,GR2,GR3,GR4,GR5 guard
```

---

## Diagram 4: BIM Intelligence Workflow

IFC model processing through clash detection, quantity extraction, and model health checking.

```mermaid
flowchart TD
    %% Entry
    IFC_MODEL([📦 IFC/Revit Model Input])
    
    %% IFC Processing
    subgraph "IFC Processing"
        IFC_MODEL --> IFC_PROC[(🔧 IFC Processor)]
        IFC_PROC --> PARSE[📋 Element Parsing]
        IFC_PROC --> CLASSIFY[🏷️ Classification Mapping]
        IFC_PROC --> PROPS[📊 Property Extraction]
        
        PARSE --> IF_JSON[(Structured IFC JSON)]
        CLASSIFY --> IF_JSON
        PROPS --> IF_JSON
    end
    
    %% Parallel Analysis Streams
    subgraph "Analysis Stream 1: Clash Detection"
        IF_JSON --> CLASH{⚔️ Clash Detection Engine}
        CLASH --> SCAN[🔍 Scan Model for Clashes]
        SCAN --> CLASSIFY_CLASH[🏷️ Classify Severity]
        CLASSIFY_CLASH --> RESOLVE[💡 Suggest Resolution]
        RESOLVE --> CLASH_REPORT([📋 Clash Report])
    end
    
    subgraph "Analysis Stream 2: Quantity Extraction"
        IF_JSON --> QTO{📊 Quantity Extraction Engine}
        QTO --> PARSE_ELEM[📋 Parse Elements by Type]
        PARSE_ELEM --> CALC[🧮 Calculate Quantities]
        CALC --> CONFIDENCE[📈 Confidence Scoring]
        CONFIDENCE --> BOQ_REPORT([📊 BOQ Report])
    end
    
    subgraph "Analysis Stream 3: Design Change Propagation"
        IF_JSON --> CHANGE{🔄 Design Change Detector}
        CHANGE --> COMPARE[📊 Compare with Previous Version]
        COMPARE --> IDENTIFY[🔍 Identify Changed Elements]
        IDENTIFY --> DEPENDENCIES[🔗 Analyze Dependencies]
        DEPENDENCIES --> IMPACT[📋 Document Impact Assessment]
        IMPACT --> CHANGE_REPORT([📄 Change Impact Report])
    end
    
    subgraph "Analysis Stream 4: Model Health Checking"
        IF_JSON --> HEALTH{🔍 Model Health Checker}
        HEALTH --> MISSING[🔎 Check Missing Properties]
        HEALTH --> WRONG_CLASS[🔎 Check Incorrect Classifications]
        HEALTH --> ORPHANS[🔎 Check Orphaned Elements]
        
        MISSING --> SCORE[📊 Health Score Calculation]
        WRONG_CLASS --> SCORE
        ORPHANS --> SCORE
        SCORE --> HEALTH_REPORT([📋 Model Health Report])
    end
    
    %% Integration with Document Generation
    subgraph "Document Generation Integration"
        CLASH_REPORT --> DOC_GEN[📋 Document Generation Pipeline]
        BOQ_REPORT --> DOC_GEN
        CHANGE_REPORT --> DOC_GEN
        HEALTH_REPORT --> DOC_GEN
        
        DOC_GEN --> OUTPUT[📤 Generated Reports]
    end
    
    %% Human Review Gates
    subgraph "Human Review Gates"
        CLASH_REPORT --> HUMAN_CLASH{👤 Coordinator Review}
        BOQ_REPORT --> HUMAN_QTO{👤 QS Review}
        CHANGE_REPORT --> HUMAN_CHANGE{👤 Engineer Review}
        HEALTH_REPORT --> HUMAN_HEALTH{👤 BIM Manager Review}
    end
    
    %% Styling
    classDef input fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef ifc fill:#e8f5e8,stroke:#388e3c,stroke-width:2px
    classDef clash fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    classDef qto fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    classDef change fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    classDef health fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef doc fill:#d4edda,stroke:#155724,stroke-width:2px
    classDef human fill:#ffffff,stroke:#6c757d,stroke-width:2px
    
    class IFC_MODEL input
    class IFC_PROC,PARSE,CLASSIFY,PROPS,IF_JSON ifc
    class CLASH,SCAN,CLASSIFY_CLASH,RESOLVE,CLASH_REPORT clash
    class QTO,PARSE_ELEM,CALC,CONFIDENCE,BOQ_REPORT qto
    class CHANGE,COMPARE,IDENTIFY,DEPENDENCIES,IMPACT,CHANGE_REPORT change
    class HEALTH,MISSING,WRONG_CLASS,ORPHANS,SCORE,HEALTH_REPORT health
    class DOC_GEN,OUTPUT doc
    class HUMAN_CLASH,HUMAN_QTO,HUMAN_CHANGE,HUMAN_HEALTH human
```

---

## Diagram 5: Automation Spectrum

Visual representation of tasks by automation level.

```mermaid
flowchart LR
    subgraph "FULLY AUTOMATABLE"
        FA1[📝 RFI Draft]
        FA2[📋 NCR Generation]
        FA3[📊 Quantity Take-Off<br/>structured data]
        FA4[📜 Method Statement Draft]
        FA5[📋 ITP Generation]
        FA6[🔧 BIM Clash Report]
        FA7[🔗 Cross-Reference Check]
        FA8[📊 Daily/Weekly Reports]
        FA9[📖 Code Query Response]
    end
    
    subgraph "AI-AUGMENTED"
        AA1[📐 Preliminary Structural Sizing]
        AA2[💧 Drainage Pipe Sizing]
        AA3[🏔️ Foundation Recommendation]
        AA4[📦 Earthworks Volumes]
        AA5[📅 Schedule Impact Analysis]
        AA6[💰 Cost Estimation]
        AA7[📍 Site Feasibility]
        AA8[📋 Tender Documentation]
    end
    
    subgraph "HUMAN-LED"
        HL1[✅ Final Design Approval]
        HL2[🏔️ Geotechnical Interpretation]
        HL3[🔨 Construction Method Selection]
        HL4[📜 Regulatory Submissions]
        HL5[🏗️ Structural/GEO Safety Decisions]
        HL6[⚖️ Expert Witness Testimony]
        HL7[📝 Variation Orders<br/>structural impact]
    end
    
    %% Gateways between levels
    FA3 -.->|QS Verification| AA4
    AA1 -.->|Engineer Review| HL1
    AA3 -.->|Specialist Validation| HL2
    AA8 -.->|Engineer Approval| HL4
    
    %% Styling
    classDef green fill:#e8f5e8,stroke:#388e3c,stroke-width:2px
    classDef amber fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    classDef red fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    
    class FA1,FA2,FA3,FA4,FA5,FA6,FA7,FA8,FA9 green
    class AA1,AA2,AA3,AA4,AA5,AA6,AA7,AA8 amber
    class HL1,HL2,HL3,HL4,HL5,HL6,HL7 red
```

---

## References

- **AI-Native Prompt**: `00850_AI-NATIVE-CIVIL-ENGINEERING-PROMPT.md`
- **Domain Knowledge**: `00850_DOMAIN-KNOWLEDGE.MD` Part 6B
- **Main Workflow**: `0000_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD`
- **Implementation Phases**: `0000_AI-NATIVE-IMPLEMENTATION_PHASES.MD`