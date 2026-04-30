---
memory_layer: durable_knowledge
para_section: pages/disciplines
gigabrain_tags: disciplines, documentation
documentation
openstinger_context: discipline-knowledge
last_updated: 2026-03-30
related_docs:
  - disciplines/
---

flowchart TD
    %% User Interface States
    UI_START([👤 User Login])
    DASHBOARD([📊 Dashboard<br/>Phase Overview])

    %% Card System Architecture
    subgraph "🎴 Card Management System"
        CARD_CONTROLLER[🎯 Card Controller<br/>State Management]
        CARD_RENDERER[🎨 Card Renderer<br/>Dynamic UI Generation]
        CARD_NAVIGATOR[🧭 Navigation Handler<br/>Phase Transitions]
    end

    %% Specialist Agents
    subgraph "🤖 Specialist Agents"
        CAD_AGE[🖥️ CAD Model Viewer Agent<br/>• Retrieve 2D/3D Models<br/>• AutoCAD Civil 3D API<br/>• MicroStation CONNECT<br/>• Web CAD Viewers]
        GIS_AGENT[🗺️ GIS Alignment Editor Agent<br/>• Process Alignment Data<br/>• ArcGIS Server API<br/>• QGIS Processing<br/>• Google Earth Engine]
        ANALYSIS_AGENT[📊 Analysis Engine Agent<br/>• Mass Balance Calculations<br/>• Civil 3D Analysis API<br/>• STAAD.Pro Services<br/>• SAP2000 Engine]
        DOC_CONTROL_AGENT[📁 Document Control Agent<br/>• 00900 Doc Control System<br/>• Approval Workflows via 01300 Governance<br/>• Sign-off Tracking<br/>• Filing & Archiving]
    end

    %% Governance System Integration
    subgraph "🏛️ 01300 Governance System"
        GOV_APPROVAL_SYSTEM[📋 Document Approval System<br/>• Multi-Level Approval Workflows<br/>• Conditional Routing<br/>• Escalation Management<br/>• SOX/GDPR Compliance]
        GOV_WORKFLOW_BUILDER[🔧 Workflow Builder<br/>• Visual Approval Designer<br/>• Template Library<br/>• Testing Interface<br/>• Performance Analytics]
        GOV_COMPLIANCE_MONITOR[⚖️ Compliance Monitor<br/>• Audit Trails<br/>• Regulatory Reporting<br/>• Risk Assessment<br/>• Continuous Monitoring]
    end

    %% Individual Card States by Phase
    subgraph "📋 Phase 1 Cards"
        P1_CARD[📋 Project Brief Card<br/>• Upload Project Brief<br/>• OR Retrieve from 00900 Doc Control<br/>• Review Requirements<br/>• Set Objectives<br/>📥 Download Template<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
        P1_SITE_CARD[📍 Site Survey Card<br/>• Upload Survey Data<br/>• OR Retrieve from Survey Database<br/>• View Topographic Maps<br/>• Extract Coordinates<br/>📥 Download: Survey Report<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
        P1_GEO_CARD[🌍 Geotechnical Card<br/>• Link Geo Reports<br/>• OR Retrieve from Geo Database<br/>• View Soil Profiles<br/>• Foundation Analysis<br/>📥 Download: Geo Recommendations<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
    end

    subgraph "💡 Phase 2 Cards"
        P2_OPTIONS_CARD[⚖️ Design Options Card<br/>• Compare Alternatives<br/>• Weighted Criteria<br/>• Select Optimal Solution<br/>📥 Download: Options Analysis<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
        P2_LAYOUT_CARD[📐 Preliminary Layout Card<br/>• View 2D/3D Models via CAD Agent<br/>• OR Upload CAD Files Directly<br/>• Edit Alignments via GIS Agent<br/>• OR Upload GIS Data Directly<br/>• Mass Balance Calc via Analysis Agent<br/>• OR Upload Analysis Results<br/>📥 Download: Layout Drawings<br/>📤 Submit for Approval]
    end

    subgraph "📐 Phase 3 Cards"
        P3_CALC_CARD[🧮 Calculations Card<br/>• Run Analysis Models<br/>• View Results Tables<br/>• Generate Reports<br/>📥 Download: Calculation Package<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
        P3_DRAWING_CARD[📏 Preliminary Drawings Card<br/>• AutoCAD Integration<br/>• BIM Coordination<br/>• Clash Detection<br/>📥 Download: Drawing Set<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
    end

    subgraph "🔧 Phase 4 Cards"
        P4_FINAL_DRAWINGS[📐 Construction Drawings Card<br/>• Full Drawing Set<br/>• Detail Sheets<br/>• Revision Control<br/>📥 Download: Complete Drawings<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
        P4_SPECS_CARD[📋 Specifications Card<br/>• Technical Specs<br/>• Material Standards<br/>• Quality Requirements<br/>📥 Download: Spec Document<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
        P4_SCHEDULES[📊 Quantity Schedules Card<br/>• Bill of Quantities<br/>• Material Lists<br/>• Cost Breakdown<br/>📥 Download: BOQ Excel<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
    end

    subgraph "📋 Phase 5 Cards"
        P5_TENDER_CARD[📄 Tender Documents Card<br/>• IFT Package<br/>• Procurement Specs<br/>• Compliance Check<br/>📥 Download: Tender Package<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
        P5_CONSTRUCTION_CARD[🏗️ Construction Support Card<br/>• IFC Drawings<br/>• Site Instructions<br/>• Variation Approval<br/>📥 Download: Construction Docs<br/>📤 Submit for Approval → Sign-off → 00900 Doc Control]
    end

    %% Reference Document System
    subgraph "📚 Reference Document Retrieval"
        REF_CONTROLLER[🔍 Reference Controller<br/>Auto-Search & Link]
        TEMPLATE_MGMT[(📄 Template Management<br/>System - Unified)]
        GEO_DB[(🌍 Geotechnical<br/>Database)]
        SURVEY_DB[(📍 Survey<br/>Data Store)]
        SPEC_DB[(📋 Specifications<br/>Library)]
        COST_DB[(💰 Cost<br/>Database)]
        REG_DB[(⚖️ Regulatory<br/>Repository)]
    end

    %% User Interaction Flows
    UI_START --> DASHBOARD
    DASHBOARD --> CARD_CONTROLLER

    CARD_CONTROLLER --> CARD_RENDERER
    CARD_RENDERER --> CARD_NAVIGATOR

    %% Card Display Logic
    CARD_NAVIGATOR --> P1_CARD
    P1_CARD -->|Complete| P1_SITE_CARD
    P1_SITE_CARD -->|Complete| P1_GEO_CARD
    P1_GEO_CARD -->|Next Phase| P2_OPTIONS_CARD

    P2_OPTIONS_CARD -->|Complete| P2_LAYOUT_CARD
    P2_LAYOUT_CARD -->|Next Phase| P3_CALC_CARD

    P3_CALC_CARD -->|Complete| P3_DRAWING_CARD
    P3_DRAWING_CARD -->|Next Phase| P4_FINAL_DRAWINGS

    P4_FINAL_DRAWINGS -->|Complete| P4_SPECS_CARD
    P4_SPECS_CARD -->|Complete| P4_SCHEDULES
    P4_SCHEDULES -->|Next Phase| P5_TENDER_CARD

    P5_TENDER_CARD -->|Complete| P5_CONSTRUCTION_CARD
    P5_CONSTRUCTION_CARD -->|Complete| UI_COMPLETE([✅ Project Complete])

    %% Reference Document Integration
    P1_GEO_CARD -.->|Query| REF_CONTROLLER
    REF_CONTROLLER -.->|Retrieve| GEO_DB
    GEO_DB -.->|Return Data| P1_GEO_CARD

    P1_SITE_CARD -.->|Query| REF_CONTROLLER
    REF_CONTROLLER -.->|Retrieve| SURVEY_DB
    SURVEY_DB -.->|Return Data| P1_SITE_CARD

    P4_SPECS_CARD -.->|Query| REF_CONTROLLER
    REF_CONTROLLER -.->|Retrieve| SPEC_DB
    SPEC_DB -.->|Return Data| P4_SPECS_CARD

    P4_SCHEDULES -.->|Query| REF_CONTROLLER
    REF_CONTROLLER -.->|Retrieve| COST_DB
    COST_DB -.->|Return Data| P4_SCHEDULES

    P1_CARD -.->|Query| REF_CONTROLLER
    REF_CONTROLLER -.->|Retrieve| REG_DB
    REG_DB -.->|Return Data| P1_CARD

    %% Agent Connections - CAD Agent
    P2_LAYOUT_CARD -->|Request 2D/3D Model| CAD_AGENT
    CAD_AGENT -->|API Call| CAD_API([AutoCAD Civil 3D<br/>MicroStation])
    CAD_API -->|Raw Model Data| CAD_PROCESSOR[Data Processor<br/>Format & Serialize]
    CAD_PROCESSOR -->|Structured Model| P2_LAYOUT_CARD

    %% Agent Connections - GIS Agent
    P2_LAYOUT_CARD -->|Request Alignment| GIS_AGENT
    GIS_AGENT -->|API Call| GIS_API([ArcGIS Server<br/>QGIS Engine])
    GIS_API -->|Spatial Data| GIS_PROCESSOR[Alignment Optimizer<br/>Coordinate Processing]
    GIS_PROCESSOR -->|Optimized Alignment| P2_LAYOUT_CARD

    %% Agent Connections - Analysis Agent
    P2_LAYOUT_CARD -->|Request Mass Balance| ANALYSIS_AGENT
    P3_CALC_CARD -->|Request Calculations| ANALYSIS_AGENT
    ANALYSIS_AGENT -->|API Call| ANALYSIS_API([Civil 3D Analysis<br/>STAAD.Pro<br/>SAP2000])
    ANALYSIS_API -->|Raw Results| ANALYSIS_PROCESSOR[Results Processor<br/>Volume Calculations]
    ANALYSIS_PROCESSOR -->|Calculated Data| P2_LAYOUT_CARD
    ANALYSIS_PROCESSOR -->|Analysis Results| P3_CALC_CARD

    %% Agent Connections - Document Control Agent
    P1_CARD -->|Submit for Approval| DOC_CONTROL_AGENT
    P1_SITE_CARD -->|Submit for Approval| DOC_CONTROL_AGENT
    P1_GEO_CARD -->|Submit for Approval| DOC_CONTROL_AGENT
    P2_OPTIONS_CARD -->|Submit for Approval| DOC_CONTROL_AGENT
    P2_LAYOUT_CARD -->|Submit for Approval| DOC_CONTROL_AGENT
    P3_CALC_CARD -->|Submit for Approval| DOC_CONTROL_AGENT
    P3_DRAWING_CARD -->|Submit for Approval| DOC_CONTROL_AGENT
    P4_FINAL_DRAWINGS -->|Submit for Approval| DOC_CONTROL_AGENT
    P4_SPECS_CARD -->|Submit for Approval| DOC_CONTROL_AGENT
    P4_SCHEDULES -->|Submit for Approval| DOC_CONTROL_AGENT
    P5_TENDER_CARD -->|Submit for Approval| DOC_CONTROL_AGENT
    P5_CONSTRUCTION_CARD -->|Submit for Approval| DOC_CONTROL_AGENT

    DOC_CONTROL_AGENT -->|Route to| APPROVAL_QUEUE[📋 Approval Queue<br/>Manager Review]
    APPROVAL_QUEUE -->|Process via| GOV_APPROVAL_SYSTEM
    GOV_APPROVAL_SYSTEM -->|Configure Workflow| GOV_WORKFLOW_BUILDER
    GOV_APPROVAL_SYSTEM -->|Monitor Compliance| GOV_COMPLIANCE_MONITOR
    GOV_APPROVAL_SYSTEM -->|Approval Complete| APPROVAL_QUEUE
    APPROVAL_QUEUE -->|Sign-off| DOC_FILING[📁 Document Filing<br/>00900 System]
    DOC_FILING -->|Confirmation| DOC_CONTROL_AGENT

    %% Navigation Controls
    P1_CARD -.->|Previous| DASHBOARD
    P1_CARD -.->|Cancel| UI_CANCEL([❌ Cancel Project])
    P2_OPTIONS_CARD -.->|Previous| P1_GEO_CARD
    P2_OPTIONS_CARD -.->|Cancel| UI_CANCEL
    P3_CALC_CARD -.->|Previous| P2_LAYOUT_CARD
    P3_CALC_CARD -.->|Cancel| UI_CANCEL
    P4_FINAL_DRAWINGS -.->|Previous| P3_DRAWING_CARD
    P4_FINAL_DRAWINGS -.->|Cancel| UI_CANCEL
    P5_TENDER_CARD -.->|Previous| P4_SCHEDULES
    P5_TENDER_CARD -.->|Cancel| UI_CANCEL

    %% Download Button Positioning
    P1_CARD -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P1_DOWNLOAD([Download from Template System<br/>Civil Engineering Brief Template])
    P1_SITE_CARD -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P1_SITE_DOWNLOAD([Download from Template System<br/>Survey Report Template])
    P1_GEO_CARD -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P1_GEO_DOWNLOAD([Download from Template System<br/>Geotechnical Report Template])
    P2_OPTIONS_CARD -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P2_OPTIONS_DOWNLOAD([Download from Template System<br/>Options Analysis Template])
    P2_LAYOUT_CARD -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P2_LAYOUT_DOWNLOAD([Download from Template System<br/>Layout Drawings Template])
    P3_CALC_CARD -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P3_CALC_DOWNLOAD([Download from Template System<br/>Calculation Package Template])
    P3_DRAWING_CARD -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P3_DRAWING_DOWNLOAD([Download from Template System<br/>Preliminary Drawings Template])
    P4_FINAL_DRAWINGS -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P4_DRAWINGS_DOWNLOAD([Download from Template System<br/>Construction Drawings Template])
    P4_SPECS_CARD -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P4_SPECS_DOWNLOAD([Download from Template System<br/>Specifications Template])
    P4_SCHEDULES -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P4_SCHEDULES_DOWNLOAD([Download from Template System<br/>BOQ Excel Template])
    P5_TENDER_CARD -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P5_TENDER_DOWNLOAD([Download from Template System<br/>Tender Package Template])
    P5_CONSTRUCTION_CARD -.->|📥 Position: Card Footer<br/>Right-aligned<br/>Template Mgmt Integration| P5_CONSTRUCTION_DOWNLOAD([Download from Template System<br/>Construction Docs Template])

    %% User Options Display
    USER_OPTIONS{📋 User Action Options}
    USER_OPTIONS -->|Complete Task| CARD_NAVIGATOR
    USER_OPTIONS -->|Request Help| HELP_SYSTEM([💡 Help & Guidance])
    USER_OPTIONS -->|Save Progress| SAVE_STATE([💾 Auto-Save State])
    USER_OPTIONS -->|View References| REF_CONTROLLER

    %% Styling
    classDef ui_start fill:#e8f4fd,stroke:#1976d2,stroke-width:2px
    classDef dashboard fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    classDef card_system fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    classDef phase_cards fill:#e8f5e8,stroke:#388e3c,stroke-width:2px
    classDef agents fill:#e1f5fe,stroke:#0288d1,stroke-width:3px
    classDef agent_api fill:#b3e5fc,stroke:#0277bd,stroke-width:2px
    classDef agent_processor fill:#81d4fa,stroke:#01579b,stroke-width:2px
    classDef governance fill:#f3e5f5,stroke:#7b1fa2,stroke-width:3px
    classDef doc_control fill:#fff9c4,stroke:#f9a825,stroke-width:3px
    classDef approval fill:#ffe0b2,stroke:#ef6c00,stroke-width:2px
    classDef reference_system fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    classDef databases fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef downloads fill:#d4edda,stroke:#155724,stroke-width:2px
    classDef complete fill:#d4edda,stroke:#155724,stroke-width:3px
    classDef cancel fill:#f8d7da,stroke:#721c24,stroke-width:2px
    classDef user_options fill:#ffffff,stroke:#6c757d,stroke-width:2px

    class UI_START ui_start
    class DASHBOARD dashboard
    class CARD_CONTROLLER,CARD_RENDERER,CARD_NAVIGATOR card_system
    class P1_CARD,P1_SITE_CARD,P1_GEO_CARD,P2_OPTIONS_CARD,P2_LAYOUT_CARD,P3_CALC_CARD,P3_DRAWING_CARD,P4_FINAL_DRAWINGS,P4_SPECS_CARD,P4_SCHEDULES,P5_TENDER_CARD,P5_CONSTRUCTION_CARD phase_cards
    class CAD_AGENT,GIS_AGENT,ANALYSIS_AGENT,DOC_CONTROL_AGENT agents
    class CAD_API,GIS_API,ANALYSIS_API agent_api
    class CAD_PROCESSOR,GIS_PROCESSOR,ANALYSIS_PROCESSOR agent_processor
    class GOV_APPROVAL_SYSTEM,GOV_WORKFLOW_BUILDER,GOV_COMPLIANCE_MONITOR governance
    class APPROVAL_QUEUE,DOC_FILING doc_control
    class REF_CONTROLLER reference_system
    class GEO_DB,SURVEY_DB,SPEC_DB,COST_DB,REG_DB,TEMPLATE_MGMT databases
    class P1_DOWNLOAD,P1_SITE_DOWNLOAD,P1_GEO_DOWNLOAD,P2_OPTIONS_DOWNLOAD,P2_LAYOUT_DOWNLOAD,P3_CALC_DOWNLOAD,P3_DRAWING_DOWNLOAD,P4_DRAWINGS_DOWNLOAD,P4_SPECS_DOWNLOAD,P4_SCHEDULES_DOWNLOAD,P5_TENDER_DOWNLOAD,P5_CONSTRUCTION_DOWNLOAD downloads
    class UI_COMPLETE complete
    class UI_CANCEL cancel
    class USER_OPTIONS user_options
