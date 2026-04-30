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
# Procurement Workflow Documentation

## Overview

This documentation covers the complete procurement workflow implemented in the 01900 Procurement Modal. The workflow is a comprehensive conversational AI-powered system that guides users through procurement order creation, from initial requirements gathering to final Scope of Work (SOW) generation.

## 📁 Documentation Structure

### 🏗️ [Architecture](./architecture/)
Understanding the system design and components
- **Agent workflows** - Complete 7-agent streaming workflow
- **Data flow** - Data processing and flow architecture
- **Interface design** - User interface architecture and components
- **Implementation architecture** - Technical implementation details

### ⚙️ [Implementation](./implementation/)
Setup, configuration, and deployment guides
- **Technical implementation** - Complete implementation guide
- **Testing procedures** - Comprehensive testing strategies
- **Development environment** - Setup and configuration
- **Deployment guides** - Production deployment procedures

### 📋 [Reference](./reference/)
API documentation, schemas, and templates
- **API references** - Complete API documentation
- **Template specifications** - Document templates and variables
- **Standards and compliance** - Security and performance standards
- **Configuration reference** - Environment variables and settings

### 🧪 [Testing](./testing/)
Testing procedures and scenarios
- **Testing strategy** - Comprehensive testing approach
- **Test scenarios** - Edge cases and error conditions
- **Quality assurance** - Code quality and performance testing
- **Security testing** - Vulnerability and security testing

### 📄 [Documents](./documents/)
Template documents and specifications
- **SOW templates** - Statement of Work templates
- **Appendix templates** - A-F appendix specifications
- **Document structures** - Standard document formats

## Architecture

### Core Components
- **ProcurementInputAgentModal.js** - Main modal component with 9 tabs
- **useProcurementAgentSession** - React hook managing AI agent sessions
- **7-Agent Streaming Workflow** - Sequential AI agent processing
- **Governance Field Attributes** - Field-level validation and behavior control
- **Checkpoint System** - Session recovery and state persistence

### Workflow States
1. **CHAT** - Conversational data extraction
2. **PREVIEW** - Data validation and specialist agent processing
3. **DRAFT** - Order preview before submission
4. **HANDOFF** - Order creation and conditional SOW generation
5. **SOW** - Scope of Work document display (only if required by procurement category)
6. **Appendix A-F** - Supporting documentation tabs

## Data Flow

### Input Sources
- **User Chat Input** - Natural language requirements with GROUP selection from database
- **Tabular Data** - Product specifications via paste
- **Form Fields** - Structured data entry
- **Database Tables** - Groups and categories from procurement_categories table
- **API Responses** - Backend validation and processing

### Processing Pipeline
1. **Group Selection** - Load groups from procurement_categories table
2. **Category Selection** - Hierarchical selection within chosen group
3. **Data Extraction** - AI parsing using table-based prompts from procurement_document_prompts
4. **Validation** - Field-level and business rule validation
5. **Specialist Agents** - 7-agent streaming workflow
6. **Order Creation** - Database record generation
7. **Document Compilation** - SOW and appendix generation

### Output Documents
- **SOW (Scope of Work)** - Main procurement contract
- **Appendix A** - Product specifications table
- **Appendix B** - Safety Data Sheets (SDS)
- **Appendix C** - Delivery schedule
- **Appendix D** - Training materials
- **Appendix E** - Logistics documentation
- **Appendix F** - Packing and marking specifications

## Agent Integration

### 7-Agent Streaming Workflow
1. **Template Analysis Agent** (800ms) - Analyzes available templates
2. **Requirements Extraction Agent** (700ms) - Extracts requirements from conversation
3. **Compliance Validation Agent** (900ms) - Validates regulatory compliance
4. **Field Population Agent** (800ms) - Populates form fields
5. **Quality Assurance Agent** (600ms) - QA checks and validation
6. **Final Review Agent** (850ms) - Final document review
7. **Assignment Agent** (650ms) - Task assignment and workflow completion

### HITL Gates
- **Gate 1** (Stage 3) - Compliance validation checkpoint
- **Gate 2** (Stage 6) - Final review checkpoint

## Key Features

### Intelligent SOW Generation
- Context-aware content based on procurement type
- Dynamic compliance requirements by destination country
- Technical specifications integration
- Financial and timeline data incorporation

### Advanced Validation
- Real-time field validation
- Cross-field dependency checking
- Business rule enforcement
- Governance attribute compliance

### Session Management
- Automatic checkpoint saving
- Session recovery on reload
- State persistence across tabs
- Error recovery and debugging

## Quick Start

### For New Developers
1. **Architecture Overview**: [architecture/README.md](./architecture/README.md)
2. **Implementation Guide**: [IMPLEMENTATION_GUIDE.md](./IMPLEMENTATION_GUIDE.md)
3. **API Reference**: [reference/README.md](./reference/README.md)

### For Users
1. **User Guide**: [comprehensive workflow docs](../../workflows/01900_PROCUREMENT_COMPREHENSIVE_WORKFLOW/01900_PROCUREMENT_WORKFLOW_USER_GUIDE.md)
2. **Interface Guide**: [architecture/interface/0001_chat_interface.md](./architecture/interface/0001_chat_interface.md)

### For Maintainers
1. **Maintenance Guide**: [comprehensive workflow docs](../../workflows/01900_PROCUREMENT_COMPREHENSIVE_WORKFLOW/01900_PROCUREMENT_WORKFLOW_MAINTENANCE.md)
2. **Troubleshooting**: [comprehensive workflow docs](../../workflows/01900_PROCUREMENT_COMPREHENSIVE_WORKFLOW/01900_PROCUREMENT_WORKFLOW_TROUBLESHOOTING.md)

## Usage

1. **Start** - Open procurement modal from agents page
2. **Chat** - Describe procurement requirements conversationally
3. **Preview** - Review extracted data and run specialist agents
4. **Submit** - Create order and auto-traverse to SOW
5. **Review** - Examine complete SOW and appendices
6. **Export** - Generate final documents for procurement process

## Dependencies

- React 16.8+ (hooks)
- Custom modal system
- AI agent backend APIs
- Database schema (procurement tables)
- Governance field attributes system
- Checkpoint/session management system

## 📋 Navigation

### By Role
- **Developers**: [Architecture](./architecture/) → [Implementation](./implementation/) → [Reference](./reference/)
- **Users**: [Interface Guide](./architecture/interface/0001_chat_interface.md) → [User Guide](../../workflows/01900_PROCUREMENT_COMPREHENSIVE_WORKFLOW/01900_PROCUREMENT_WORKFLOW_USER_GUIDE.md)
- **Maintainers**: [Maintenance](../../workflows/01900_PROCUREMENT_COMPREHENSIVE_WORKFLOW/01900_PROCUREMENT_WORKFLOW_MAINTENANCE.md) → [Troubleshooting](../../workflows/01900_PROCUREMENT_COMPREHENSIVE_WORKFLOW/01900_PROCUREMENT_WORKFLOW_TROUBLESHOOTING.md)

### By Task
- **Setup**: [Implementation](./implementation/) → [Environment Setup](./implementation/README.md#development-environment-setup)
- **Development**: [Architecture](./architecture/) → [Components](./architecture/README.md#core-components)
- **Testing**: [Testing](./testing/) → [Test Procedures](./testing/README.md#testing-procedures)
- **Deployment**: [Implementation](./implementation/) → [Deployment](./implementation/README.md#deployment)

## 🎯 Documentation Status

### ✅ Current and Active
- All files in `deep-agents/docs/workflows/01900_procurement/`
- Comprehensive workflow documentation in `docs/workflows/01900_PROCUREMENT_COMPREHENSIVE_WORKFLOW/`

### 🔄 Recently Updated
- **DOCUMENTATION_INVENTORY.md** - Complete inventory analysis (2026-02-26)
- **IMPLEMENTATION_GUIDE.md** - Consolidated technical guide (2026-02-26)
- **INDEX.md** - Master navigation guide (2026-02-26)

### 📦 Archived (Historical Reference)
- Files in `docs/workflows/01900_PROCUREMENT_COMPREHENSIVE_WORKFLOW/archive/`
- See [archive README](../../workflows/01900_PROCUREMENT_COMPREHENSIVE_WORKFLOW/archive/README.md) for details

## 🔗 Related Documentation

- **[Master Index](./INDEX.md)** - Complete navigation and organization
- **[Implementation Guide](./IMPLEMENTATION_GUIDE.md)** - Consolidated technical reference
- **[Documentation Inventory](./DOCUMENTATION_INVENTORY.md)** - Complete file inventory
- **[Comprehensive Workflow](../../workflows/01900_PROCUREMENT_COMPREHENSIVE_WORKFLOW/)** - Extended workflow documentation

---

*This documentation provides comprehensive guidance for understanding, developing, and maintaining the procurement workflow system.*
