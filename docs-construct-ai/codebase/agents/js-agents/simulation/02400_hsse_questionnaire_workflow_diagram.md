---
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, codebase, ai-automation
documentation
openstinger_context: agent-development, ai-systems
last_updated: 2026-03-21
related_docs:
  - codebase/agents/
  - disciplines/
---
# HSSE Questionnaire Workflow Diagram

## Overview
This Mermaid diagram illustrates the contractor vetting workflow using the HSSE Management and Culture Questionnaire, showing how specialists create questionnaire sections, merge them into a comprehensive document, send to contractors for completion, and segregate responses back to discipline specialists for evaluation.

```mermaid
flowchart TD
    %% Start trigger
    A[Contractor Vetting Required] --> B[HSSE Questionnaire Creation]

    %% Specialist section creation - parallel processes
    B --> C1[Safety Specialist<br/>Creates HSE Management<br/>& Culture Section]
    B --> C2[HSE Policy Specialist<br/>Creates Policy &<br/>Documentation Section]
    B --> C3[Training Specialist<br/>Creates Training &<br/>Competency Section]
    B --> C4[Environmental Specialist<br/>Creates Environmental<br/>Management Section]
    B --> C5[Security Specialist<br/>Creates Security<br/>Measures Section]
    B --> C6[Incident Specialist<br/>Creates Incident Reporting<br/>& Investigation Section]
    B --> C7[Compliance Specialist<br/>Creates Compliance &<br/>Auditing Section]

    %% Document merging system
    C1 --> D[Document Ordering<br/>Management System]
    C2 --> D
    C3 --> D
    C4 --> D
    C5 --> D
    C6 --> D
    C7 --> D

    %% Questionnaire assembly
    D --> E[Merge Sections into<br/>Comprehensive HSSE<br/>Questionnaire<br/>65 Questions/13 Sections]

    %% Contractor delivery
    E --> F[Send Questionnaire<br/>to Contractor<br/>with Completion<br/>Deadline]

    %% Contractor completion
    F --> G[Contractor Fills Out<br/>Questionnaire<br/>+ File Attachments]

    %% Response segregation
    G --> H[Return Completed<br/>Questionnaire]

    %% Discipline segregation - parallel analysis
    H --> I1[Safety Specialist<br/>Evaluates HSE<br/>Management Responses<br/>Score: 1-5 scale]
    H --> I2[HSE Policy Specialist<br/>Evaluates Policy<br/>Responses<br/>Score: 1-5 scale]
    H --> I3[Training Specialist<br/>Evaluates Training<br/>Responses<br/>Score: 1-5 scale]
    H --> I4[Environmental Specialist<br/>Evaluates Environmental<br/>Responses<br/>Score: 1-5 scale]
    H --> I5[Security Specialist<br/>Evaluates Security<br/>Responses<br/>Score: 1-5 scale]
    H --> I6[Incident Specialist<br/>Evaluates Incident<br/>Responses<br/>Score: 1-5 scale]
    H --> I7[Compliance Specialist<br/>Evaluates Compliance<br/>Responses<br/>Score: 1-5 scale]

    %% Qualification assessment
    I1 --> J[Aggregate All<br/>Discipline Scores<br/>Total Score: 65 max]
    I2 --> J
    I3 --> J
    I4 --> J
    I5 --> J
    I6 --> J
    I7 --> J

    %% Final qualification decision
    J --> K{Score Assessment}
    K -->|50-65| L1[Approved<br/>Excellent HSSE Management]
    K -->|35-49| L2[Conditional Approval<br/>Requires Improvements]
    K -->|20-34| L3[Rejected<br/>Major Improvements Needed]
    K -->|<20| L4[Rejected<br/>Significant Issues]

    %% Learning and tasks
    L1 --> M[HITL Tasks Created<br/>For Monitoring]
    L2 --> M
    L3 --> N[Corrective Action<br/>HITL Tasks]
    L4 --> N

    M --> O[Data Stored in<br/>continual_learning_data]
    N --> O

    %% 02400 Vetting Simulation Integration
    B --> P[Vetting Workflow Simulator<br/>02400-vetting-workflow.json]
    E --> P
    G --> P
    J --> P

    P --> Q[Simulation Results<br/>Critical Qualification<br/>85.7% Success Rate]

    %% Styling
    classDef specialistClass fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    classDef systemClass fill:#f3e5f5,stroke:#4a148c,stroke-width:2px
    classDef contractorClass fill:#fff3e0,stroke:#e65100,stroke-width:2px
    classDef assessmentClass fill:#e8f5e8,stroke:#1b5e20,stroke-width:2px
    classDef simulationClass fill:#fce4ec,stroke:#880e4f,stroke-width:2px

    class C1,C2,C3,C4,C5,C6,C7 specialistClass
    class D systemClass
    class G contractorClass
    class I1,I2,I3,I4,I5,I6,I7,K specialistClass
    class P,Q simulationClass
```

## Process Description

### 1. Questionnaire Creation Phase
- **Parallel Specialist Input**: 7 HSSE discipline specialists each create their domain-specific sections
- **Document Assembly**: Sections merged into comprehensive 65-question questionnaire via Document Ordering Management System

### 2. Contractor Engagement Phase
- **Questionnaire Delivery**: Complete questionnaire sent to contractor with completion deadline
- **Response Collection**: Contractor provides detailed responses and supporting documentation

### 3. Discipline Evaluation Phase
- **Response Segregation**: Completed questionnaire responses automatically routed to relevant discipline specialists
- **Specialist Assessment**: Each specialist scores their section (1-5 scale) with qualitative evaluation and recommendations

### 4. Qualification Decision Phase
- **Score Aggregation**: Individual discipline scores totaled (65 points maximum)
- **Qualification Logic**:
  - 50-65: Approved (Excellent HSSE Management)
  - 35-49: Conditional Approval (Requires Improvements)
  - 20-34: Rejected (Major Improvements Needed)
  - <20: Rejected (Significant Compliance Issues)

### 5. Learning & Improvement Phase
- **HITL Tasks**: Automated task creation for monitoring, corrective actions, or improvement plans
- **Data Storage**: Assessment data stored in `continual_learning_data` table for model training

### 6. Simulation Integration
- **Parallel Execution**: 02400 Contractor Vetting Workflow Simulator runs parallel assessment
- **Verification**: Simulation validates qualification logic and agent performance (achieved 85.7% success rate in testing)

## Key Features

- **Specialized Domain Expertise**: Each discipline maintains independent evaluation authority
- **Parallel Processing**: Specialists work simultaneously for efficiency
- **Structured Scoring**: Standardized 1-5 scoring with qualitative feedback
- **HITL Integration**: Human oversight for complex evaluations and improvements
- **Learning Loop**: Continuous improvement through data collection and model training
- **Simulation Validation**: 02400 workflow simulator ensures process reliability

## Integration Points

- **Database Tables**: `contractor_vetting`, `contractor_evaluations`, `tasks`, `continual_learning_data`
- **UI Access**: Contractor Vetting button → Safety page → Inspections section
- **Document Management**: Integrated file upload and version control
- **Task Management**: Automated stakeholder notifications and HITL assignments