---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# 0000_PROCEDURES_GUIDE.md - Procedures Guide - Construct AI System Documentation

## Document Usage Guide

**🎯 This Document's Role**: Navigation index and procedure selection guide. **Use this FIRST** when encountering any issue to identify which specific procedure applies to your situation.

**📚 Related Documents in Debugging Ecosystem:**
- **`DEBUGGING_GUIDE.md`** → Go here for hands-on technical debugging steps and immediate solutions
- **`SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`** → Use for systematic investigation methodology and enterprise logging standards
- **`ERROR_TRACKING_ALL.md`** → Reference for historical error patterns and proven solutions

---

## File Naming Conventions

### **Standard Procedure File Naming**

All procedure files in this directory follow a consistent naming convention to ensure easy identification and categorization:

```
0000_[CATEGORY]_[PROCEDURE_NAME]_PROCEDURE.md
```

### **Component Breakdown**

| Component | Format | Description | Examples |
|-----------|--------|-------------|----------|
| **Prefix** | `0000_` | 4-digit number for consistent sorting | `0000_`, `0001_`, `01300_` |
| **Category** | `UPPERCASE` | Functional category | `ROLES`, `TESTING`, `WORKFLOW`, `SQL` |
| **Procedure Name** | `UPPERCASE` | Specific procedure identifier | `USER`, `MIGRATION`, `IMPLEMENTATION` |
| **Suffix** | `_PROCEDURE.md` | Standard file extension | All files end with this |

### **Category Examples**

| Category | Purpose | File Examples |
|----------|---------|---------------|
| **ROLES** | User and agent role management | `0000_ROLES_USER_PROCEDURE.md`, `0000_ROLES_AGENT_PROCEDURE.md` |
| **TESTING** | Testing protocols and procedures | `0000_TESTING_WORKFLOW_PROCEDURE.md`, `0000_TESTING_MIGRATION_PROCEDURE.md` |
| **WORKFLOW** | Workflow implementation and management | `0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md`, `0000_WORKFLOW_HITL_PROCEDURE.md` |
| **SQL** | Database operations and execution | `0000_SQL_EXECUTION_PROCEDURE.md` |
| **UI/UX** | User interface components | `0000_PAGE_IMPLEMENTATION_PROCEDURE.md` |
| **SYSTEM** | System maintenance and troubleshooting | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |

### **Special Cases**

- **Legacy Files**: Some older files may use different numbering (e.g., `01300_`, `0500_`) but follow the same category naming pattern
- **Enhanced Procedures**: Files with "ENHANCED" in the name have been merged into their base procedures
- **Template Files**: Files ending in "TEMPLATE" are reusable frameworks, not specific implementations

### **Naming Guidelines**

1. **Consistency**: All new procedure files must follow this naming convention
2. **Categorization**: Choose the most appropriate category from the examples above
3. **Clarity**: Procedure names should clearly indicate their purpose
4. **Sorting**: Numeric prefixes ensure logical file ordering
5. **Uniqueness**: Each file must have a unique combination of category and procedure name

---

**🔗 Cross-References to Major Procedure Clusters:**

**Security & Access Control Procedures:**
- → `0000_API_KEY_SECURITY_MIGRATION_PROCEDURE.md` → Secure API key storage and authentication
- → `0000_ROLES_DEPARTMENT_USER_IMPLEMENTATION_PROCEDURE.md` → Department-specific access control
- → `0000_ROLES_AGENT_IMPLEMENTATION_PROCEDURE.md` → AI agent security and confinement
- → `0000_ROLES_USER_IMPLEMENTATION_PROCEDURE.md` → User role and permission management

**Workflow & AI Procedures:**
- → `0000_QWEN_FINETUNING_PROCEDURE.md` → QWEN fine-tuning procedure for construction/real estate applications
- → `0000_WORKFLOW_TEMPLATE_FIELD_ATTRIBUTE_IMPLEMENTATION_PROCEDURE.md` → AI field configuration and validation
- → `0000_WORKFLOW_HITL_PROCEDURE.md` → Human-in-the-loop workflow management
- → `0000_WORKFLOW_TASK_PROCEDURE.md` → Task execution and workflow states
- → `0000_WORKFLOW_OPTIMIZATION_GUIDE.md` → Performance optimization and monitoring
- → `0000_WORKFLOW_DOCUMENTATION_PROCEDURE.md` → Workflow documentation standards
- → `0000_TESTING_WORKFLOW_PROCEDURE.md` → Complete end-to-end workflow testing framework
- → `0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md` → Complete workflow implementation framework with developer tools

**UI/UX Implementation Procedures:**
- → `0000_ACCORDION_SECTION_PROCEDURE.md` → Accordion section management and standards
- → `0000_ELEMENT_STYLING_REFERENCE_PROCEDURE.md` → UI component styling and consistency
- → `0000_DROPDOWN_IMPLEMENTATION_PROCEDURE.md` → Dropdown component implementation
- → `0000_PAGE_IMPLEMENTATION_PROCEDURE.md` → Unified standard for implementing new pages
- → `0000_CHATBOT_COMPREHENSIVE_PROCEDURE.md` → Chatbot interface and functionality

**System Maintenance Procedures:**
- → `0000_SQL_EXECUTION_PROCEDURE.md` → Database operations and migrations
- → `0500_VECTOR_DATA_ISOLATION_PROCEDURE.md` → Vector data management
- → `0000_QUICK_START_GUIDE.md` → System setup and initialization
- → `0000_I18N_TRANSLATION_FILE_ORGANIZATION_PROCEDURE.md` → I18N translation file organization
- → `0000_MERMAID_DIAGRAM_CREATION_PROCEDURE.md` → Mermaid diagram creation standards
- → `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` → System troubleshooting framework
- → `0000_TESTING_MIGRATION_PROCEDURE.md` → Migration testing procedures

**Navigation & Reference Aids:**
- → `docs/0000_MASTER_DATABASE_SCHEMA.md` → Complete database schema reference
- → `docs/0000_DOCUMENTATION_GUIDE.md` → Documentation standards and procedures
- → `AGENTS.md` → AI agent development guidelines

## Overview

This guide provides a comprehensive index of all troubleshooting and operational procedures for the Construct AI system. Each procedure is cross-referenced with related procedures, system components, and functional areas to provide clear navigation and understanding of system capabilities.

**📂 Organizational Structure**: Procedures are organized into specialized subfolders based on their usage patterns and target audience:
- **`docs/procedures/agent-development/`** - Procedures for agents developing and managing other agents (accessible to agent systems)
- **`docs/procedures/monitoring-testing/`** - Procedures for agents monitoring system health and performing testing (accessible to agent systems)
- **`docs/procedures/human-workflows/`** - General procedures designed for human workflow guidance and operational tasks
- **`docs/agents/procedures/`** - Agent-specific development and management procedures
  - **Agent Procedures Guide** → `docs/agents/procedures/0000_AGENT_PROCEDURES_GUIDE.md` ← **Use this for agent-specific tasks**
- **`docs/pages-disciplines/`** - Page-specific procedures and guides

**🔧 Direct Supabase CRUD Operations:** For Supabase CRUD operations (Create, Read, Update, Delete), we write directly to the database tables and edit records, rather than using abstracted layers. This approach provides direct control and immediate updates to the database. For example, we directly manipulate the prompts table for AI prompt management.

**🤖 Agent Access Guidelines:** Agent systems can access procedures based on their functional roles:
- **Agents developing other agents** can access the `agent-development/` folder
- **Agents monitoring/testing the app** can access the `monitoring-testing/` folder
- **All agents** can access `human-workflows/` for reference but it's primarily designed for human use

## Procedure Organization

### **By System Component**

#### **Agent Development & AI Systems**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| [`0000_GOVERNANCE_FRAMEWORK`](docs/agents/procedures/0000_GOVERNANCE_FRAMEWORK_PROCEDURE.md) | AI Governance Framework | Comprehensive 11-Agent Governance Swarm for AIUC-1, ISO 42001, ISO 27701, EU AI Act, and NIS2 compliance | ✅ ACTIVE | All agent development procedures |
| [`02100_AGENT_DEVELOPMENT`](02100_AGENT_DEVELOPMENT_PROCEDURE.md) | Agent Development Procedure | Comprehensive agent development lifecycle from natural language specification through production deployment | ✅ ACTIVE | [`0000_AGENT_TYPE_SELECTION_PROCEDURE.md`](0000_AGENT_TYPE_SELECTION_PROCEDURE.md), [`0000_WORKFLOW_OPTIMIZATION_GUIDE.md`](0000_WORKFLOW_OPTIMIZATION_GUIDE.md) |
| [`0000_CORRESPONDENCE_AGENT_SIMULATION`](0000_CORRESPONDENCE_AGENT_SIMULATION_PROCEDURE.md) | Correspondence Agent Simulation Procedure | Testing frameworks and simulation procedures for correspondence agent development and validation | ✅ ACTIVE | [`02100_AGENT_DEVELOPMENT_PROCEDURE.md`](02100_AGENT_DEVELOPMENT_PROCEDURE.md), [`0000_WORKFLOW_HITL_PROCEDURE.md`](0000_WORKFLOW_HITL_PROCEDURE.md) |
| [`0000_AGENT_SERVICE_SETUP`](0000_AGENT_SERVICE_SETUP_PROCEDURE.md) | Agent Service Setup Procedure | Complete setup and configuration of agent communication services for web application connectivity | ✅ ACTIVE | [`0000_CORRESPONDENCE_AGENT_SIMULATION_PROCEDURE.md`](0000_CORRESPONDENCE_AGENT_SIMULATION_PROCEDURE.md), [`0000_GITHUB_ACTIONS_WORKFLOW_FIXES_PROCEDURE.md`](0000_GITHUB_ACTIONS_WORKFLOW_FIXES_PROCEDURE.md) |
| [`0000_GITHUB_ACTIONS_WORKFLOW_FIXES`](0000_GITHUB_ACTIONS_WORKFLOW_FIXES_PROCEDURE.md) | GitHub Actions Workflow Fixes Procedure | Resolution of GitHub Actions matrix strategy failures and continuous learning pipeline fixes | ✅ ACTIVE | [`0000_AGENT_SERVICE_SETUP_PROCEDURE.md`](0000_AGENT_SERVICE_SETUP_PROCEDURE.md), [`0000_QWEN_FINETUNING_PROCEDURE.md`](0000_QWEN_FINETUNING_PROCEDURE.md) |
| [`0000_AGENT_TYPE_SELECTION`](0000_AGENT_TYPE_SELECTION_PROCEDURE.md) | Agent Type Selection Procedure | Framework for selecting between Deep Agents, Swarm Agents, and JavaScript Agents based on requirements | ✅ ACTIVE | [`02100_AGENT_DEVELOPMENT_PROCEDURE.md`](02100_AGENT_DEVELOPMENT_PROCEDURE.md), [`0000_QWEN_FINETUNING_PROCEDURE.md`](0000_QWEN_FINETUNING_PROCEDURE.md) |
| [`0000_QWEN_FINETUNING`](0000_QWEN_FINETUNING_PROCEDURE.md) | QWEN Fine-Tuning Procedure | Advanced ML fine-tuning for Deep Agents using QWEN models and LoRA adapters | ✅ ACTIVE | [`0000_AGENT_TYPE_SELECTION_PROCEDURE.md`](0000_AGENT_TYPE_SELECTION_PROCEDURE.md), [`02100_AGENT_DEVELOPMENT_PROCEDURE.md`](02100_AGENT_DEVELOPMENT_PROCEDURE.md) |
| [`0000_WORKFLOW_AGENT_CENTRIC_PAGE_IMPLEMENTATION`](0000_WORKFLOW_AGENT_CENTRIC_PAGE_IMPLEMENTATION_PROCEDURE.md) | Agent-Centric Workflow Page Implementation Procedure | Complete framework for implementing sophisticated AI-powered workflow pages with 24+ agent prompts, enterprise integrations, and advanced testing frameworks | ✅ ACTIVE | [`0000_PAGE_IMPLEMENTATION_PROCEDURE.md`](0000_PAGE_IMPLEMENTATION_PROCEDURE.md), [`0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md`](0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md), [`0000_PROMPT_MANAGEMENT_PROCEDURE.md`](0000_PROMPT_MANAGEMENT_PROCEDURE.md) |
| [`0000_WORKFLOW_ACCURACY_ENHANCEMENT_IMPLEMENTATION`](0000_WORKFLOW_ACCURACY_ENHANCEMENT_IMPLEMENTATION.md) | Workflow Accuracy Enhancement Implementation | Enhanced workflow accuracy through systematic validation and error reduction | ✅ ACTIVE | [`0000_WORKFLOW_IMPLEMENTATION_PROCEDURE.md`](0000_WORKFLOW_IMPLEMENTATION_PROCEDURE.md), [`0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`](0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md) |
| [`0000_DEEP_AGENT_MESSAGING_OBSERVABILITY`](agent-development/0000_DEEP_AGENT_MESSAGING_OBSERVABILITY_PROCEDURE.md) | Deep Agent Messaging & Observability Procedure | Supabase-backed inter-agent messaging, workflow checkpointing, health monitoring, token/cost metrics, and agent identity persistence for the Python deep-agents framework. Covers the 5 Supabase tables, `MessagingMixin`, and wiring into priority agents (00435, 01900, contractor_vetting). | ✅ ACTIVE | [`0000_AGENT_TYPE_SELECTION_PROCEDURE.md`](0000_AGENT_TYPE_SELECTION_PROCEDURE.md), [`0000_AGENT_SERVICE_SETUP_PROCEDURE.md`](0000_AGENT_SERVICE_SETUP_PROCEDURE.md), [`0000_SQL_EXECUTION_PROCEDURE.md`](0000_SQL_EXECUTION_PROCEDURE.md) |
| [`0000_DATA_PIPELINE_OPERATIONS`](0000_DATA_PIPELINE_OPERATIONS_PROCEDURE.md) | Data Pipeline Operations Procedure | Operational runbooks for managing unified data pipeline transforming simulation and HITL data into training datasets | ✅ ACTIVE | [`0000_QWEN_FINETUNING_PROCEDURE.md`](0000_QWEN_FINETUNING_PROCEDURE.md), [`0000_AI_TRAINING_EXPANSION_PROCEDURE.md`](0000_AI_TRAINING_EXPANSION_PROCEDURE.md) |
| [`0000_MODEL_PERFORMANCE_MONITORING`](0000_MODEL_PERFORMANCE_MONITORING_PROCEDURE.md) | Model Performance Monitoring Procedure | Comprehensive monitoring framework for AI model performance with A/B testing, drift detection, and automated alerting | ✅ ACTIVE | [`0000_QWEN_FINETUNING_PROCEDURE.md`](0000_QWEN_FINETUNING_PROCEDURE.md), [`0000_AI_TRAINING_EXPANSION_PROCEDURE.md`](0000_AI_TRAINING_EXPANSION_PROCEDURE.md) |
| [`0000_ADVANCED_TESTING_INTEGRATION`](0000_ADVANCED_TESTING_INTEGRATION_PROCEDURE.md) | Advanced Testing Integration Procedure | Comprehensive testing integration achieving 95%+ automation coverage across all AI agent workflows | ✅ ACTIVE | [`0000_TESTING_WORKFLOW_PROCEDURE.md`](0000_TESTING_WORKFLOW_PROCEDURE.md), [`0000_AGENT_SIMULATION_PROCEDURE.md`](0000_AGENT_SIMULATION_PROCEDURE.md) |

#### **Template Generation System**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| [`1300_02700`](1300_02700.md) | Template Generation Timeout Troubleshooting | Diagnose and resolve template generation failures, timeouts, and workflow inconsistencies | ✅ ACTIVE | [`0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE`](0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md) |
| [`1300_HTML_TEMPLATE`](1300_HTML_TEMPLATE.md) | HTML Template Generation Procedure | Generate HTML files from markdown documentation with proper formatting, alignment, and cross-discipline compatibility | ✅ ACTIVE | [`1300_02700`](1300_02700.md), [`0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE`](0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md) |

#### **Error Tracking & Monitoring**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `1300_00000` | Error Tracking All | Comprehensive error tracking across all system components | ✅ ACTIVE | `0900_ERROR_TRACKING_SDK_USAGE_GUIDE.md` |
| `0900_ERROR_TRACKING` | SDK Usage Guide | Error tracking SDK implementation and usage patterns | ✅ ACTIVE | `1300_00000_ERROR_TRACKING_ALL.md` |

#### **Security & Access Control**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_API_KEY_SECURITY` | API Key Security Migration Procedure | Migration from insecure localStorage to secure server-side encrypted database storage for API keys | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`, `0700_LANGCHAIN_SETTINGS_UI.md` |
| `0000_PRIVACY` | Privacy Procedure | Comprehensive privacy procedures for ZA (POPIA), GN (Guinea), and SA (Saudi Arabia) compliance including data subject rights, consent management, and audit logging | ✅ ACTIVE | `docs/procedures/0000_PRIVACY_PROCEDURE.md`, `docs/pages-disciplines/1300_02050_MASTER_GUIDE_PRIVACY_.md` |
| `01300_USER_ROLES` | User Roles Implementation Procedure | Complete implementation of user_roles table with RBAC, policies, and authentication integration | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `01300_DEPARTMENT_USER_ROLES` | Department User Roles Implementation Procedure | Comprehensive department-specific role and permission implementation with RLS policies, schema validation, and security best practices | ✅ ACTIVE | `01300_USER_ROLES_IMPLEMENTATION_PROCEDURE.md`, `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_AGENT_ROLES` | Agent Roles Implementation Procedure | Complete implementation of agent_roles table with discipline confinement, access restrictions, and audit logging | ✅ ACTIVE | `01300_USER_ROLES_IMPLEMENTATION_PROCEDURE.md` |
| `0000_VECTOR_ISOLATION_SECURITY` | Vector Isolation Security Policy | Comprehensive security measures for vector data isolation, access controls, and enterprise-grade protection | ✅ ACTIVE | `0000_TABLE_VECTOR_STORE_POPULATION.md`, `0500_VECTOR_DATA_ISOLATION_PROCEDURE.md` |

#### **Debugging & Development**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_DEBUGGING` | Comprehensive Debugging Guide | Complete debugging procedures including script loading, modal debugging, server management, and troubleshooting techniques | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_PERFORMANCE_MONITORING` | Performance Monitoring Procedure | Comprehensive framework for implementing performance monitoring across all system components with real-time dashboards and predictive analytics | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |

#### **Database & System Operations**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `docs/schema/README` | Database Schema Documentation Guide | Comprehensive guide for database schema management, extraction methods, and documentation standards for PostgreSQL and SQLite schemas | ✅ ACTIVE | `extract_schema.sql`, `extract-schema-openapi.js`, `update_schema.sh` |
| `extract_schema.sql` | Database Schema Extraction Functions | PostgreSQL functions for automated schema extraction generating complete PostgreSQL and SQLite schema files with indexes, constraints, and RLS policies | ✅ ACTIVE | `docs/schema/README.md`, `update_schema.sh`, `run-extraction.sh` |
| `extract-schema-openapi.js` | OpenAPI Schema Extraction Procedure | Node.js script using Supabase OpenAPI specification for comprehensive schema extraction with RLS policies, foreign keys, indexes, and script usage analysis | ✅ ACTIVE | `docs/schema/README.md`, `openapi-spec.json`, `current-full-schema.md` |
| `update_schema.sh` | Automated Schema Update Script | Complete workflow script for updating both PostgreSQL and SQLite schema files with backup creation, validation, and cross-platform compatibility | ✅ ACTIVE | `extract_schema.sql`, `docs/schema/README.md`, `current-full-schema.sql` |
| `0000_SQL_EXECUTION` | SQL Execution Procedure | Automated SQL file execution using multiple methods (pg, Supabase RPC, psql) for schema changes, migrations, and data operations | ✅ ACTIVE | `apply_schema_fix.cjs`, `execute_rls_fix.js`, `run-migration.js` |
| `0000_JAVASCRIPT_DATA_POPULATION` | JavaScript Data Population Procedure | Supabase API-based data population scripts with RLS handling, rate limiting, error recovery, and organization scoping | ✅ ACTIVE | `populate-discipline-sections.js`, `create-template-variations.js`, `0000_SQL_EXECUTION_PROCEDURE.md` |
| `0000_TABLE_VECTOR_STORE_POPULATION` | Table Vector Store Population Procedure | Comprehensive methodology for populating vector stores using structured table data from database with security isolation and embedding generation | ✅ ACTIVE | `0000_VECTOR_ISOLATION_SECURITY_PROCEDURE.md`, `0500_VECTOR_DATA_ISOLATION_PROCEDURE.md` |

#### **AI & Prompt Management**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_PROMPT_MANAGEMENT` | Prompt Management Procedure | Comprehensive framework for AI prompt lifecycle management including creation, validation, versioning, deployment, and monitoring across all agent systems | ✅ ACTIVE | `docs/pages-agents/shared-agent-architecture.md`, `0000_WORKFLOW_DOCUMENTATION_PROCEDURE.md` |

#### **UI Component Implementation**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_ACCORDION_SECTION_PROCEDURE` | Accordion Section Management Procedure | Comprehensive guidelines for adding, editing, and maintaining accordion sections across all configuration layers | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`, `docs/standards/0003_UI_ACCORDION_STANDARDS.md` |
| `0000_PAGE_IMPLEMENTATION` | Page Implementation Procedure | Unified standard for implementing new pages with Template A compliance, background policies, and accordion integration | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`, `1300_00000_PAGE_IMPLEMENTATIONS.md` |
| `0000_DROPDOWN` | Dropdown Implementation Procedure | Standardized dropdown component implementation with discipline selection, validation, and error handling | ✅ ACTIVE | `0910_DROPDOWN_MANAGEMENT.md`, `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_ELEMENT_STYLING_REFERENCE_PROCEDURE` | Element Styling Reference Procedure | Systematic procedure for matching element properties between components to ensure consistent UI styling | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_MODAL_DESIGN_PROCEDURE` | Modal Design Procedure | Dual modal architecture documentation covering class-based (legacy) and React functional (modern) modal implementations with integration guidelines | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_PROCUREMENT_CATEGORIES_SQL_GUIDE` | Procurement Categories SQL Guide | Comprehensive SQL guide for the procurement_categories table including schema, data import strategies, query examples, and troubleshooting | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |

#### **Chatbot & AI Interface Procedures**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_CHATBOT_MASTER` | Chatbot Master Procedure | Complete chatbot implementation and management procedure covering planning, testing, maintenance, and enterprise security controls | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_HIERARCHICAL_AI_CONFIG` | Hierarchical AI Configuration System | Enterprise-grade AI management with page-discipline-global configuration hierarchy for optimal model selection | ✅ ACTIVE | `0000_API_KEY_SECURITY_MIGRATION_PROCEDURE.md`, `0000_CHATBOT_COMPREHENSIVE_PROCEDURE.md` |

#### **System Setup & Initialization**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_DOCUMENTATION_AUDIT` | Automated Documentation Audit Procedure | Comprehensive procedure for automated documentation quality assurance and continuous monitoring | ✅ ACTIVE | `docs/0000_DOCUMENTATION_MASTER_GUIDE.md`, `docs/standards/0002_FILE_NAMING_STANDARDS.md` |
| `0000_QUICK_START_GUIDE` | Quick Start Guide | System setup and initialization procedures for new installations and deployments | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |

#### **Template Creation & Discipline Management**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `01300_DISCIPLINE` | Discipline Copy Logging Procedure | Comprehensive logging and validation for template creation discipline selection flows | ✅ ACTIVE | `0000_DROPDOWN_IMPLEMENTATION_PROCEDURE.md`, `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_JAVASCRIPT_DATA_POPULATION` | JavaScript Data Population Procedure | Supabase API-based data population scripts with RLS handling, rate limiting, error recovery, and organization scoping | ✅ ACTIVE | `populate-discipline-sections.js`, `create-template-variations.js`, `0000_SQL_EXECUTION_PROCEDURE.md` |

#### **Testing & Quality Assurance**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_TESTING_WORKFLOW` | Testing Workflow Procedure | Complete end-to-end workflow testing framework with automated validation and quality assurance | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`, `0000_WORKFLOW_IMPLEMENTATION_PROCEDURE.md` |
| `0000_TESTING_MIGRATION` | Testing Migration Procedure | Migration testing procedures with data integrity verification and rollback capabilities | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`, `0000_SQL_EXECUTION_PROCEDURE.md` |
| `0000_JEST_CONFIGURATION` | Jest Configuration Procedure | Complete Jest testing framework setup with ES modules, environment variables, and real database testing | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`, `0000_AGENT_SERVICE_SETUP_PROCEDURE.md` |
| `0000_AGENT_SERVICE_TESTING` | Agent Service Testing Procedure | Comprehensive testing framework for agent communication, discovery, and monitoring systems | ✅ ACTIVE | `02201_AGENT_SERVICE_SETUP_PROCEDURE.md`, `0000_JEST_CONFIGURATION_PROCEDURE.md` |
| `0000_REAL_DATA_TESTING` | Real Data Testing Procedure | Testing framework using actual database connections instead of mocks with environment variable management | ✅ ACTIVE | `0000_JEST_CONFIGURATION_PROCEDURE.md`, `0000_SQL_EXECUTION_PROCEDURE.md` |
| `0000_CODE_FORMATTING` | Code Formatting Procedure | Automated code formatting and quality assurance using Prettier with VS Code integration | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_BROWSER_CONSOLE_CODE` | Browser Console Code Procedure | Browser console debugging and code execution procedures for frontend troubleshooting | ✅ ACTIVE | `0000_DEBUGGING_GUIDE.md`, `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |

#### **Specialized Procedures**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_SPECIALIST_ANALYSIS_IMPROVEMENT` | Specialist Analysis Improvement Procedure | Enhanced specialist analysis capabilities with improved accuracy and performance | ✅ ACTIVE | `0000_WORKFLOW_OPTIMIZATION_GUIDE.md`, `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_DISCIPLINE_EXTRACTION_PROMPTS_DATABASE` | Discipline Extraction Prompts Database Procedure | Database procedures for managing discipline-specific extraction prompts and templates | ✅ ACTIVE | `0000_PROMPT_MANAGEMENT_PROCEDURE.md`, `0000_SQL_EXECUTION_PROCEDURE.md` |
| `0000_WORKFLOW_TEMPLATE_FIELD_ATTRIBUTE_IMPLEMENTATION` | Workflow Template Field Attribute Implementation Procedure | AI field configuration and validation for workflow templates | ✅ ACTIVE | `0000_WORKFLOW_IMPLEMENTATION_PROCEDURE.md`, `0000_QWEN_FINETUNING_PROCEDURE.md` |
| `0000_WORKFLOW_DOCUMENTATION` | Workflow Documentation Procedure | Comprehensive framework for documenting complex workflows with component architecture and state management | ✅ ACTIVE | `0000_WORKFLOW_IMPLEMENTATION_PROCEDURE.md`, `docs/0000_DOCUMENTATION_GUIDE.md` |
| `0000_SHORTCUTS` | Shortcuts Procedure | Keyboard shortcuts and productivity enhancements for system navigation | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_ENGINEERING_DRAWINGS_STORAGE` | Engineering Drawings Storage Procedure | Secure storage and management procedures for engineering drawings and technical documents | ✅ ACTIVE | `0000_VECTOR_ISOLATION_SECURITY_PROCEDURE.md`, `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_NEW_PAGE_IMPLEMENTATION_WORKFLOW` | New Page Implementation Workflow Procedure | Complete workflow for implementing new pages with component integration and testing | ✅ ACTIVE | `0000_PAGE_IMPLEMENTATION_PROCEDURE.md`, `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_LANEXTRACT_INTEGRATION` | LangExtract Integration Procedure | Integration procedures for LangExtract language processing services | ✅ ACTIVE | `0000_QWEN_FINETUNING_PROCEDURE.md`, `0000_WORKFLOW_HITL_PROCEDURE.md` |
| `0000_SYSTEM_WIDE_ACCURACY_ENHANCEMENT_ADOPTION` | System Wide Accuracy Enhancement Adoption Procedure | Enterprise-wide adoption procedures for accuracy enhancement frameworks | ✅ ACTIVE | `0000_WORKFLOW_OPTIMIZATION_GUIDE.md`, `0000_PERFORMANCE_MONITORING_PROCEDURE.md` |

#### **Additional System Procedures**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_ACCORDION_SECTION_PROCEDURE` | Accordion Section Management Procedure | Comprehensive guidelines for adding, editing, and maintaining accordion sections across all configuration layers | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`, `docs/standards/0003_UI_ACCORDION_STANDARDS.md` |
| `0000_DOCUMENTATION_AUDIT` | Automated Documentation Audit Procedure | Comprehensive procedure for automated documentation quality assurance and continuous monitoring | ✅ ACTIVE | `docs/0000_DOCUMENTATION_MASTER_GUIDE.md`, `docs/standards/0002_FILE_NAMING_STANDARDS.md` |
| `0000_HIERARCHICAL_AI_CONFIG` | Hierarchical AI Configuration System | Enterprise-grade AI management with page-discipline-global configuration hierarchy for optimal model selection | ✅ ACTIVE | `0000_API_KEY_SECURITY_MIGRATION_PROCEDURE.md`, `0000_CHATBOT_COMPREHENSIVE_PROCEDURE.md` |
| `0000_I18N_TRANSLATION_FILE_ORGANIZATION` | I18N Translation File Organization Procedure | Translation file management and organization for internationalization | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_MERMAID_DIAGRAM_CREATION` | Mermaid Diagram Creation Procedure | Diagram creation and documentation using Mermaid syntax | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_NEW_PAGE_IMPLEMENTATION_WORKFLOW` | New Page Implementation Workflow Procedure | Complete workflow for implementing new pages with component integration and testing | ✅ ACTIVE | `0000_PAGE_IMPLEMENTATION_PROCEDURE.md`, `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_PRIVACY` | Privacy Procedure | Comprehensive privacy procedures for ZA (POPIA), GN (Guinea), and SA (Saudi Arabia) compliance | ✅ ACTIVE | `docs/procedures/0000_PRIVACY_PROCEDURE.md`, `docs/pages-disciplines/1300_02050_MASTER_GUIDE_PRIVACY_.md` |
| `0000_SHORTCUTS` | Shortcuts Procedure | Keyboard shortcuts and productivity enhancements for system navigation | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_VECTOR_ISOLATION_SECURITY` | Vector Isolation Security Policy | Comprehensive security measures for vector data isolation, access controls, and enterprise-grade protection | ✅ ACTIVE | `0000_TABLE_VECTOR_STORE_POPULATION.md`, `0500_VECTOR_DATA_ISOLATION_PROCEDURE.md` |

#### **Workflow Documentation Framework**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_WORKFLOW` | Workflow Documentation Procedure | Comprehensive framework for documenting complex workflows with component architecture, state management patterns, and technical implementation standards | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`, `docs/0000_DOCUMENTATION_GUIDE.md` |
| `0002_WORKFLOW_AGENT_CENTRIC_PAGE_IMPLEMENTATION` | Agent-Centric Workflow Page Implementation Procedure | Complete framework for implementing sophisticated AI-powered workflow pages with 24+ agent prompts, enterprise integrations, and advanced testing frameworks | ✅ ACTIVE | `0000_PAGE_IMPLEMENTATION_PROCEDURE.md`, `0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md`, `0000_PROMPT_MANAGEMENT_PROCEDURE.md` |

#### **System Troubleshooting Framework**
| Procedure ID | Title | Purpose | Status | Related Procedures |
|-------------|-------|---------|--------|-------------------|
| `0000_SYSTEM` | System Troubleshooting Procedure Template | Generic template for creating troubleshooting procedures | ✅ TEMPLATE | All specific procedures |
| `0000_ELEMENT_STYLING_REFERENCE_PROCEDURE` | Element Styling Matching Procedure | Systematic procedure for matching element properties between components to ensure consistent UI styling | ✅ ACTIVE | `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` |
| `0000_DATABASE_DEPENDENCY_AUDIT_PROCEDURE` | Database Dependency Audit Procedure | Comprehensive audit framework to identify and eliminate mock/fallback data that should be sourced from database tables instead | ✅ ACTIVE | Procurement order creation fixes, system |

### **By Functional Area**

#### **AI & Template Processing**
- **Template Generation**: Creating forms and templates using AI
- **HSSE Questionnaires**: Specialized health, safety, security, environment forms
- **Custom Templates**: User-defined template creation
- **Progress Tracking**: Real-time generation status and polling

#### **Error Handling & Recovery**
- **Timeout Management**: Handling long-running AI operations
- **Error Classification**: Distinguishing between different error types
- **Recovery Procedures**: Automatic and manual error recovery
- **Logging Standards**: Structured logging for troubleshooting

#### **System Monitoring**
- **Performance Metrics**: Response times, throughput, resource usage
- **Error Rates**: Success/failure ratios and alerting thresholds
- **Health Checks**: System component availability and status
- **Log Analysis**: Automated log parsing and pattern recognition

## Detailed Procedure Descriptions

### **1300_02700 - Template Generation Timeout Troubleshooting**

**Functional Coverage:**
- AI-powered template generation workflows
- Frontend/backend timeout handling
- Progress reporting and user feedback
- Error classification and messaging
- Job polling and status management

**Key Features:**
- ✅ **FIX 27**: Frontend timeout resolution (60s timeouts)
- ✅ **FIX 30**: Output format consistency (HTML vs JSON)
- ✅ **FIX 31**: Error message improvements
- ✅ **FIX 32**: Module resolution fixes
- ✅ **FIX 33**: Validation enhancements
- ✅ **FIX 34**: Polling loop fixes
- ✅ **FIX 35**: Workflow design consistency

**System Impact:**
- **High**: Core template generation functionality
- **Users Affected**: All users creating templates
- **Business Critical**: Yes - primary system feature

**Related Components:**
- `AITemplateModal.jsx` - Frontend interface
- `template-routes.js` - API endpoints
- `template-generation-service.js` - Core logic
- OpenAI API - External AI service

### **1300_HTML_TEMPLATE - HTML Template Generation Procedure**

**Functional Coverage:**
- Markdown to HTML conversion across all disciplines
- Corporate styling and branding application
- Checkbox alignment and interactive element processing
- Table formatting and responsive design
- Accessibility compliance (WCAG 2.1 AA)
- Cross-browser compatibility testing
- Quality assurance and validation

**Key Features:**
- ✅ **Markdown Processing**: Support for complex markdown structures
- ✅ **CSS Framework Integration**: Bootstrap/Tailwind compatibility
- ✅ **Checkbox Alignment**: Consistent positioning across all browsers
- ✅ **Table Responsiveness**: Mobile-friendly table handling
- ✅ **Accessibility Validation**: Automated WCAG compliance checking
- ✅ **Performance Optimization**: CSS/JS minification and optimization scripts
- ✅ **Quality Metrics**: Lighthouse scoring and validation reports

**System Impact:**
- **Medium-High**: Core documentation publishing functionality
- **Users Affected**: All disciplines using technical specifications
- **Business Critical**: Yes - external stakeholder documentation

**Related Components:**
- `1300_HTML_TEMPLATE_GENERATION_PROCEDURE.md` - Core procedure document
- Pandoc/Node.js processing tools - HTML conversion engines
- Corporate CSS templates - Styling frameworks
- HTML validation services - W3C compliance checking
- Accessibility audit tools - WCAG compliance validation

### **1300_00000 - Error Tracking All**

**Functional Coverage:**
- Comprehensive error collection across all components
- Error categorization and prioritization
- Historical error analysis and trending
- Integration with monitoring systems

**Key Features:**
- Centralized error aggregation
- Real-time error alerting
- Error pattern recognition
- Performance impact assessment

**System Impact:**
- **Medium-High**: System observability and debugging
- **Users Affected**: Developers and system administrators
- **Business Critical**: Yes - operational visibility

### **0900_ERROR_TRACKING - SDK Usage Guide**

**Functional Coverage:**
- Error tracking SDK implementation
- Client-side error capture
- Server-side error logging
- Integration patterns and best practices

**Key Features:**
- SDK installation and configuration
- Error context enrichment
- Privacy and compliance considerations
- Performance optimization

**System Impact:**
- **Medium**: Development tooling and standards
- **Users Affected**: Development team
- **Business Critical**: No - development support

### **docs/schema/README - Database Schema Documentation Guide**

**Functional Coverage:**
- Comprehensive database schema documentation and management guide
- Multiple schema extraction methodologies (SQL-based, OpenAPI-based, automated)
- Schema file organization and version control standards
- Cross-environment compatibility (PostgreSQL production, SQLite development)
- Automated schema updates and maintenance procedures

**Key Features:**
- ✅ **Schema File Management**: Organization of PostgreSQL and SQLite schema files with clear versioning
- ✅ **Extraction Methods**: Multiple approaches including direct SQL, OpenAPI specification, and automated scripts
- ✅ **Documentation Standards**: Comprehensive schema documentation with RLS policies, relationships, and constraints
- ✅ **Environment Compatibility**: Support for both production PostgreSQL and development SQLite schemas
- ✅ **Automated Updates**: macOS launch agent for automatic schema extraction on system login
- ✅ **Quality Assurance**: Schema validation, backup procedures, and maintenance workflows
- ✅ **Developer Tools**: Clear procedures for schema updates, migrations, and version control

**System Impact:**
- **Critical**: Core database schema management and documentation infrastructure
- **Users Affected**: All developers, database administrators, and system architects
- **Business Critical**: Yes - provides authoritative source of truth for database structure

**Related Components:**
- `docs/schema/current-full-schema.sql` - Primary PostgreSQL schema file
- `docs/schema/current-full-schema_sqlite.sql` - Development SQLite schema file
- `docs/schema/current-full-schema.md` - Comprehensive schema documentation
- `extract-schema-openapi.js` - OpenAPI-based extraction script
- `extract_schema.sql` - SQL-based extraction functions
- `update_schema.sh` - Automated update script

### **extract_schema.sql - Database Schema Extraction Functions**

**Functional Coverage:**
- PostgreSQL database functions for comprehensive schema extraction
- Automated generation of complete schema definitions with all metadata
- Support for indexes, constraints, RLS policies, and triggers
- Cross-platform schema generation (PostgreSQL and SQLite compatible)
- Integration with automated build and deployment pipelines

**Key Features:**
- ✅ **Complete Schema Extraction**: Full database structure including tables, columns, relationships, and constraints
- ✅ **Metadata Preservation**: Indexes, foreign keys, check constraints, and default values
- ✅ **RLS Policy Extraction**: Row Level Security policies and access control rules
- ✅ **Cross-Platform Generation**: Automatic conversion between PostgreSQL and SQLite syntax
- ✅ **Trigger Support**: Database triggers and automated maintenance procedures
- ✅ **Function Library**: Reusable PostgreSQL functions for schema operations
- ✅ **Error Handling**: Robust error recovery and validation procedures

**System Impact:**
- **High**: Foundation for all database schema operations and documentation
- **Users Affected**: Database administrators, DevOps engineers, and developers
- **Business Critical**: Yes - enables schema management and migration operations

**Related Components:**
- `docs/schema/current-full-schema.sql` - Generated PostgreSQL schema file
- `docs/schema/current-full-schema_sqlite.sql` - Generated SQLite schema file
- `update_schema.sh` - Automated execution script
- `run-extraction.sh` - Alternative execution method
- Database connection and authentication systems

### **extract-schema-openapi.js - OpenAPI Schema Extraction Procedure**

**Functional Coverage:**
- Node.js-based schema extraction using Supabase OpenAPI specification
- Comprehensive metadata extraction including RLS policies, foreign keys, and indexes
- Script usage analysis to identify which codebase files reference each table
- Automated markdown documentation generation with cross-references
- macOS launch agent integration for automatic daily schema updates

**Key Features:**
- ✅ **OpenAPI Integration**: Direct extraction from Supabase REST API specification
- ✅ **Comprehensive Metadata**: RLS policies, foreign keys, indexes, constraints, and reverse relationships
- ✅ **Script Analysis**: Automated identification of which JavaScript files use each database table
- ✅ **Documentation Generation**: Complete markdown documentation with table relationships and usage tracking
- ✅ **Automated Execution**: macOS launch agent runs extraction automatically on system login
- ✅ **Quality Validation**: Schema validation and error handling with detailed logging
- ✅ **Cross-Platform Support**: Environment variable configuration for different deployment targets

**System Impact:**
- **High**: Advanced schema extraction and documentation with usage analytics
- **Users Affected**: Developers, architects, and database engineers requiring detailed schema insights
- **Business Critical**: Yes - provides current schema state and usage intelligence

**Related Components:**
- `docs/schema/current-full-schema.md` - Generated comprehensive documentation
- `docs/schema/openapi-spec.json` - Raw OpenAPI specification backup
- `~/Library/LaunchAgents/com.constructai.schema-extraction.plist` - macOS automation agent
- Supabase REST API and authentication systems
- Node.js runtime and npm package ecosystem

### **update_schema.sh - Automated Schema Update Script**

**Functional Coverage:**
- Complete automated workflow for updating PostgreSQL and SQLite schema files
- Backup creation, validation, and error recovery procedures
- Cross-platform compatibility with environment detection
- Integration with existing schema extraction functions and scripts
- Production-ready error handling and rollback capabilities

**Key Features:**
- ✅ **Automated Workflow**: Complete schema update pipeline from extraction to validation
- ✅ **Backup Integration**: Automatic backup creation before schema modifications
- ✅ **Multi-Platform Support**: PostgreSQL and SQLite schema generation with syntax conversion
- ✅ **Error Recovery**: Comprehensive error handling with rollback procedures
- ✅ **Environment Detection**: Automatic adaptation to different database environments
- ✅ **Validation Pipeline**: Schema file validation and integrity checking
- ✅ **Logging and Monitoring**: Detailed execution logs and status reporting

**System Impact:**
- **Medium-High**: Automated schema maintenance and update procedures
- **Users Affected**: DevOps engineers, database administrators, and development teams
- **Business Critical**: Yes - ensures schema files remain current and accurate

**Related Components:**
- `extract_schema.sql` - Core extraction functions
- `docs/schema/current-full-schema.sql` - Target PostgreSQL schema file
- `docs/schema/current-full-schema_sqlite.sql` - Target SQLite schema file
- `run-extraction.sh` - Alternative execution method
- Database connection and authentication systems

### **0000_SQL_EXECUTION - SQL Execution Procedure**

**Functional Coverage:**
- Automated SQL file execution using multiple methods (Direct PostgreSQL, Supabase RPC, command line psql)
- Schema changes, database migrations, and data operations
- Environment variable configuration and security best practices
- Error handling and rollback procedures for database operations
- CI/CD integration for automated deployments

**Key Features:**
- ✅ **Multiple Execution Methods**: Direct pg, Supabase RPC, REST API, and psql command line
- ✅ **Environment Detection**: Automatic fallback when credentials unavailable
- ✅ **Comprehensive Error Handling**: Detailed error reporting and debugging
- ✅ **Security Best Practices**: SSL connections, credential management, access control
- ✅ **Batch Processing**: Execute multiple SQL files in sequence
- ✅ **CI/CD Integration**: GitHub Actions and automated deployment support
- ✅ **Rollback Support**: Error recovery and transaction management

**System Impact:**
- **High**: Core database operations and schema management
- **Users Affected**: Developers, DevOps engineers, database administrators
- **Business Critical**: Yes - enables all database operations and deployments

**Related Components:**
- `execute_sql_programmatically.cjs` - Main execution script
- `apply_schema_fix.cjs` - Direct PostgreSQL example
- `execute_rls_fix.js` - Supabase RPC example
- `run-migration.js` - Manual execution example
- `SQL_EXECUTION_GUIDE.md` - Comprehensive documentation

### **0000_SYSTEM - Troubleshooting Template**

**Functional Coverage:**
- Generic troubleshooting procedure framework
- Standardized diagnostic approaches
- Logging methodologies and best practices
- Root cause analysis techniques

**Key Features:**
- 5-Why analysis framework
- Advanced log analysis techniques
- Automated diagnostic scripts
- Crisis management procedures

**System Impact:**
- **Low**: Documentation and process framework
- **Users Affected**: Technical support and development
- **Business Critical**: No - procedural guidance

### **01300_USER_ROLES - User Roles Implementation Procedure**

**Functional Coverage:**
- Complete user_roles table implementation with RBAC
- Row Level Security (RLS) policy configuration
- JWT token integration with role claims
- Permission-based access control middleware
- Role management and assignment workflows
- Audit logging and security monitoring

**Key Features:**
- ✅ **Database Schema**: user_roles table with proper indexing and constraints
- ✅ **RLS Policies**: Comprehensive security policies for data access control
- ✅ **Authentication Integration**: JWT claims and role-based middleware
- ✅ **Permission System**: Granular permission checking and validation
- ✅ **Role Management**: Administrative interfaces for role assignment
- ✅ **Audit & Monitoring**: Complete audit trails and security monitoring
- ✅ **Testing Suite**: Unit, integration, and security testing

**System Impact:**
- **Critical**: Core security and access control infrastructure
- **Users Affected**: All system users (role-based access)
- **Business Critical**: Yes - fundamental security requirement

**Related Components:**
- `user_roles` table - Core role storage
- `auth.users` - Supabase authentication integration
- `RLSSecurityDashboard.jsx` - Administrative interface
- `roleManagement.js` - API endpoints
- `auth.js` middleware - Authentication middleware
- `accessControl.js` middleware - Permission checking

### **01300_DEPARTMENT_USER_ROLES - Department User Roles Implementation Procedure**

**Functional Coverage:**
- Comprehensive department-specific role and permission implementation
- Schema validation and compatibility checking
- Row Level Security (RLS) policy configuration for department tables
- Table creation and migration with proper security enforcement
- Audit logging and implementation verification
- Common pitfalls resolution and best practices documentation

**Key Features:**
- ✅ **Schema Validation**: Pre-implementation database schema verification
- ✅ **Table Creation**: Safe table creation before RLS policy application
- ✅ **RLS Implementation**: Department-specific Row Level Security policies
- ✅ **Role Definitions**: JSONB permission storage with proper validation
- ✅ **Migration Safety**: Comprehensive rollback procedures and testing
- ✅ **Audit Trail**: Complete implementation tracking and monitoring
- ✅ **Error Prevention**: Common pitfalls documentation and solutions
- ✅ **Verification**: Multi-stage testing and validation strategies

**System Impact:**
- **Critical**: Department security and access control implementation framework
- **Users Affected**: All department implementations (preventing security gaps)
- **Business Critical**: Yes - ensures no department has unsecure data access

**Related Components:**
- `role_definitions` table - Global role storage with JSONB permissions
- `user_roles` table - User role assignments with department context
- `audit_log` table - Implementation tracking and historical records
- Department-specific tables (various) - Tables requiring RLS protection
- `01300_DEPARTMENT_USER_ROLES_IMPLEMENTATION_PROCEDURE.md` - Core procedure document

### **0000_API_KEY_SECURITY - API Key Security Migration Procedure**

**Functional Coverage:**
- Migration from insecure localStorage to secure server-side encrypted database storage
- Implementation of encrypted API key storage with Row Level Security (RLS)
- JWT token-based authentication for API key access
- Comprehensive audit logging and security monitoring
- Client-side service migration and fallback mechanisms
- Database table creation and security policy implementation

**Key Features:**
- ✅ **Database Security**: Encrypted API key storage with RLS policies
- ✅ **Server-Side Encryption**: AES encryption before database storage
- ✅ **Authentication**: JWT token-based access control
- ✅ **Audit Trail**: Complete logging of API key access and operations
- ✅ **Client Migration**: Seamless transition from localStorage to secure APIs
- ✅ **Fallback Mechanisms**: Graceful degradation for offline functionality
- ✅ **Testing Suite**: Comprehensive security and functionality testing

**System Impact:**
- **Critical**: Core security infrastructure for all AI service integrations
- **Users Affected**: All users configuring AI services (OpenAI, Anthropic, etc.)
- **Business Critical**: Yes - prevents API key exposure and unauthorized access

**Related Components:**
- `user_langchain_settings` table - Secure encrypted API key storage
- `langchain-settings-routes.js` - Server-side API endpoints
- `langchainSettingsService.js` - Client-side service with secure API communication
- `LangChainSettings.jsx` - UI component for AI configuration
- Database RLS policies - Row-level security enforcement

### **0000_AGENT_ROLES - Agent Roles Implementation Procedure**

**Functional Coverage:**
- Complete agent_roles table implementation with discipline confinement
- Row Level Security (RLS) policy configuration for agent access control
- Runtime permission validation and operation auditing
- Agent framework integration with discipline validation
- Administrative interfaces for agent role management
- Comprehensive audit logging and security monitoring

**Key Features:**
- ✅ **Database Schema**: agent_roles table with discipline confinement and audit logging
- ✅ **RLS Policies**: Comprehensive security policies for agent data access control
- ✅ **Agent Framework**: Base AgentBase class with runtime discipline validation
- ✅ **Permission System**: Granular permission checking and operation validation
- ✅ **Audit Logging**: Complete audit trails for all agent operations
- ✅ **Administrative Interface**: Agent role management and assignment tools
- ✅ **Testing Suite**: Unit, integration, and security testing for agent confinement

**System Impact:**
- **Critical**: Core security and access control for AI agents
- **Users Affected**: All system users (agent operations impact all functionality)
- **Business Critical**: Yes - prevents unauthorized cross-discipline data access

**Related Components:**
- `agent_roles` table - Core agent role storage
- `agent_operations_audit` table - Agent operation audit logging
- `AgentBase.js` - Base agent class with discipline validation
- `AgentPermissionService.js` - Server-side permission validation
- `AgentRolesManagement.jsx` - Administrative interface
- `agent-audit-routes.js` - Audit logging API endpoints

### **0000_DROPDOWN - Dropdown Implementation Procedure**

**Functional Coverage:**
- Standardized dropdown component implementation for modal dialogs
- Discipline selection with data fetching and validation
- Error handling and user feedback mechanisms
- Form integration and state management
- Performance monitoring and alerting for dropdown operations

**Key Features:**
- ✅ **Phase-Based Implementation**: Step-by-step checklist for consistent dropdown addition
- ✅ **Standardized Patterns**: Controlled dropdowns with state lifting and validation
- ✅ **Error Handling**: Comprehensive error recovery and retry mechanisms
- ✅ **Testing Procedures**: Unit and integration testing patterns
- ✅ **Production Monitoring**: Dropdown-specific performance tracking and alerting
- ✅ **Historical Resolutions**: Real-world examples from template management modals
- ✅ **Verification Checklists**: Multi-phase verification for quality assurance

**System Impact:**
- **Medium**: UI component implementation standardization
- **Users Affected**: All users interacting with modal forms (template creation, governance)
- **Business Critical**: Yes - affects core user workflows for template and form management

**Related Components:**
- `DisciplineDropdown` component - Core dropdown implementation
- Template management modals - Primary usage contexts
- Form validation system - Integration requirements
- Dropdown management system - Centralized data handling
- Performance monitoring - Dropdown-specific metrics tracking

### **0000_WORKFLOW - Workflow Documentation Procedure**

**Functional Coverage:**
- Comprehensive framework for documenting complex workflows with component architecture
- Standard workflow component categorization (frontend, backend, integration components)
- State management patterns and communication protocols
- Multi-step workflow design with error handling and recovery
- Technical implementation standards and cross-referencing

**Key Features:**
- ✅ **Component Architecture**: Frontend (React), backend (Node.js), integration components categorization
- ✅ **State Management**: Standard React state patterns, workflow controllers, progress tracking
- ✅ **Communication Patterns**: Parent-child props, service layer abstraction, API contracts
- ✅ **Documentation Standards**: 13 required sections with technical implementation details
- ✅ **Quality Assurance**: Completeness checklists, technical accuracy validation, maintenance procedures
- ✅ **Cross-References**: Integration with system troubleshooting and documentation guide

**System Impact:**
- **High**: Core documentation framework for all workflow implementations
- **Users Affected**: All developers documenting workflows, system architects, QA teams
- **Business Critical**: Yes - ensures comprehensive workflow documentation and maintainability

**Related Components:**
- `docs/0000_DOCUMENTATION_GUIDE.md` - General documentation standards and architecture
- `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` - Enterprise logging and error handling standards
- `docs/pages-disciplines/1300_01300_WORKFLOW_FIELD_ATTRIBUTES_CONFIGURATION.md` - Example implementation
- React component library - Frontend component patterns
- Express.js API framework - Backend service patterns
- Supabase/PostgreSQL - Database integration patterns

### **0000_CHATBOT_IMPLEMENTATION - Chatbot Implementation Procedure**

**Functional Coverage:**
- Complete framework for implementing chatbot interfaces with AI service integration
- User interaction patterns and conversation management
- Message handling and response generation
- Integration with external AI services and internal APIs
- Error handling and fallback mechanisms

**Key Features:**
- ✅ **AI Service Integration**: Support for multiple AI providers and models
- ✅ **Conversation Management**: Context-aware dialogue handling and state management
- ✅ **User Interface**: Responsive chat interface with typing indicators and message history
- ✅ **Error Recovery**: Graceful degradation and user feedback for service failures
- ✅ **Security**: Input sanitization and rate limiting for API protection
- ✅ **Analytics**: Usage tracking and performance monitoring

**System Impact:**
- **Medium-High**: Core user interaction and AI service integration
- **Users Affected**: All users requiring AI assistance and automated responses
- **Business Critical**: Yes - primary AI interaction interface

**Related Components:**
- `chatbotService.js` - Core chatbot service implementation
- `ChatbotModal.jsx` - Frontend chat interface component
- `chatbot-routes.js` - Backend API endpoints
- External AI services - OpenAI, Anthropic, etc.

### **0000_CHATBOT_COMPREHENSIVE - Chatbot Comprehensive Procedure**

**Functional Coverage:**
- Comprehensive chatbot system implementation including conversation management
- Context awareness and multi-turn dialogues
- Advanced features like file uploads, code execution, and workflow integration
- Performance optimization and scalability considerations
- Comprehensive testing and quality assurance

**Key Features:**
- ✅ **Multi-turn Dialogues**: Complex conversation flows with context retention
- ✅ **Advanced Features**: File processing, code execution, and external integrations
- ✅ **Scalability**: Load balancing and performance optimization for high-volume usage
- ✅ **Quality Assurance**: Comprehensive testing suites and user acceptance testing
- ✅ **Monitoring**: Real-time performance metrics and usage analytics
- ✅ **Security**: Advanced security measures and compliance requirements

**System Impact:**
- **High**: Advanced AI interaction and automation capabilities
- **Users Affected**: Power users and enterprise customers requiring complex AI interactions
- **Business Critical**: Yes - advanced AI functionality and enterprise features

**Related Components:**
- `0000_CHATBOT_IMPLEMENTATION_PROCEDURE.md` - Base implementation framework
- Advanced chatbot components - File upload, code execution modules
- Enterprise integration APIs - External system connections
- Performance monitoring tools - Load testing and optimization

### **0000_DEBUGGING_GUIDE - Comprehensive Debugging Guide**

**Functional Coverage:**
- Complete debugging procedures for all system components
- Script loading debugging and module resolution
- Modal debugging and state management issues
- Server management and API debugging
- Browser console analysis and network inspection

**Key Features:**
- ✅ **Script Loading**: Module resolution and dependency debugging
- ✅ **Modal Debugging**: Component lifecycle and state management issues
- ✅ **Server Debugging**: API endpoints and database query analysis
- ✅ **Browser Tools**: Console logging and network inspection techniques
- ✅ **Performance**: Memory leaks and rendering performance issues
- ✅ **Cross-browser**: Compatibility testing and vendor-specific issues

**System Impact:**
- **Medium-High**: Development productivity and issue resolution
- **Users Affected**: Development team and system administrators
- **Business Critical**: Yes - enables rapid issue diagnosis and resolution

**Related Components:**
- Browser developer tools - Chrome DevTools, Firefox Developer Edition
- Server logs - Application and system logging
- Database query analyzers - Performance monitoring tools
- Testing frameworks - Unit and integration test suites

### **0000_I18N_TRANSLATION_FILE_ORGANIZATION - I18N Translation File Organization Procedure**

**Functional Coverage:**
- Translation file management and organization for internationalization
- Key naming conventions and file structure standardization
- Translation workflow and collaboration processes
- Quality assurance and validation procedures
- Integration with build processes and deployment

**Key Features:**
- ✅ **File Organization**: Hierarchical structure for translation files by language and module
- ✅ **Key Standards**: Consistent naming conventions and categorization
- ✅ **Workflow Integration**: Translation management and version control
- ✅ **Quality Control**: Validation scripts and automated testing
- ✅ **Build Integration**: Automatic translation file processing and optimization
- ✅ **Fallback Handling**: Graceful degradation for missing translations

**System Impact:**
- **Medium**: Internationalization and localization support
- **Users Affected**: Global users and translation teams
- **Business Critical**: Yes - enables international market expansion

**Related Components:**
- Translation management systems - External translation services integration
- Build tools - Webpack plugins for translation processing
- Validation scripts - Automated translation quality checks
- Fallback mechanisms - Default language handling

### **0000_MERMAID_DIAGRAM_CREATION - Mermaid Diagram Creation Procedure**

**Functional Coverage:**
- Diagram creation and documentation using Mermaid syntax
- Flowcharts, sequence diagrams, and architectural visualizations
- Integration with documentation and technical specifications
- Automated diagram generation and maintenance

**Key Features:**
- ✅ **Syntax Standards**: Consistent Mermaid syntax and formatting
- ✅ **Diagram Types**: Support for flowcharts, sequence, Gantt, and state diagrams
- ✅ **Documentation Integration**: Automated inclusion in technical documentation
- ✅ **Version Control**: Diagram versioning and change tracking
- ✅ **Quality Assurance**: Validation and rendering verification
- ✅ **Maintenance**: Automated updates and regeneration procedures

**System Impact:**
- **Low-Medium**: Technical documentation and visualization
- **Users Affected**: Technical writers and architects
- **Business Critical**: No - documentation enhancement

**Related Components:**
- Mermaid.js library - Diagram rendering engine
- Documentation build tools - Automated diagram generation
- Version control systems - Diagram change tracking
- Quality validation tools - Syntax checking and rendering verification

### **0000_QUICK_START_GUIDE - Quick Start Guide**

**Functional Coverage:**
- System setup and initialization procedures for new installations
- Environment configuration and dependency installation
- Basic system verification and health checks
- Initial user setup and configuration
- Troubleshooting common setup issues

**Key Features:**
- ✅ **Environment Setup**: Automated environment detection and configuration
- ✅ **Dependency Management**: Comprehensive dependency installation and verification
- ✅ **System Verification**: Automated health checks and validation
- ✅ **User Onboarding**: Initial user setup and permission configuration
- ✅ **Troubleshooting**: Common setup issues and resolution procedures
- ✅ **Documentation**: Step-by-step setup instructions and checklists

**System Impact:**
- **High**: New installation success and developer onboarding
- **Users Affected**: New team members and system administrators
- **Business Critical**: Yes - enables new deployments and team expansion

**Related Components:**
- Setup scripts - Automated installation and configuration
- Environment templates - Standardized development environments
- Health check endpoints - System verification APIs
- Documentation tools - Setup guides and troubleshooting resources

### **0000_TABLE_POLICIES_SECURITY - Table Policies Security Procedure**

**Functional Coverage:**
- Database table security implementation with Row Level Security (RLS) policies
- Security policy design and implementation patterns
- Audit logging and security monitoring for database operations
- Performance optimization for secure queries
- Compliance and regulatory requirements

**Key Features:**
- ✅ **RLS Implementation**: Comprehensive Row Level Security policy patterns
- ✅ **Security Design**: Threat modeling and access control design
- ✅ **Audit Logging**: Complete audit trails for security events
- ✅ **Performance Optimization**: Efficient secure query execution
- ✅ **Compliance**: Regulatory requirement implementation and verification
- ✅ **Monitoring**: Real-time security monitoring and alerting

**System Impact:**
- **Critical**: Core database security and data protection
- **Users Affected**: All system users (data security affects everyone)
- **Business Critical**: Yes - fundamental data security requirement

**Related Components:**
- Database RLS policies - Row-level security enforcement
- Audit logging tables - Security event tracking
- Security monitoring tools - Real-time threat detection
- Compliance frameworks - Regulatory requirement validation

### **0000_WORKFLOW_HITL - Workflow HITL Procedure**

**Functional Coverage:**
- Human-in-the-loop workflow management and implementation
- Human oversight and intervention in automated workflows
- Quality control and approval processes
- Escalation procedures and human-AI collaboration
- Performance monitoring and improvement tracking

**Key Features:**
- ✅ **Human Oversight**: Configurable human intervention points in workflows
- ✅ **Quality Control**: Human validation and approval mechanisms
- ✅ **Escalation**: Automated escalation to human operators for complex cases
- ✅ **Collaboration**: Seamless human-AI interaction and handoff procedures
- ✅ **Monitoring**: HITL performance tracking and improvement analytics
- ✅ **Training**: Human operator training and certification procedures

**System Impact:**
- **High**: Critical decision-making and quality assurance
- **Users Affected**: Human operators and supervisors in HITL workflows
- **Business Critical**: Yes - ensures quality and compliance in critical processes

**Related Components:**
- HITL workflow engines - Human intervention orchestration
- Quality control dashboards - Human oversight interfaces
- Escalation systems - Automated human notification and routing
- Training platforms - Operator certification and continuous learning

### **0000_WORKFLOW_TASK - Workflow Task Procedure**

**Functional Coverage:**
- Task execution and workflow state management
- Task lifecycle management from creation to completion
- State transitions and status tracking
- Error handling and retry mechanisms
- Performance monitoring and optimization

**Key Features:**
- ✅ **Task Lifecycle**: Complete task state management and transitions
- ✅ **Execution Engine**: Robust task execution with error recovery
- ✅ **Status Tracking**: Real-time task progress and status monitoring
- ✅ **Retry Logic**: Configurable retry policies and backoff strategies
- ✅ **Performance**: Task execution metrics and bottleneck identification
- ✅ **Scalability**: Distributed task processing and load balancing

**System Impact:**
- **High**: Core workflow execution and task management
- **Users Affected**: All users executing workflow tasks
- **Business Critical**: Yes - fundamental workflow functionality

**Related Components:**
- Task execution engines - Core workflow processing
- State management systems - Task status and progress tracking
- Retry mechanisms - Error recovery and fault tolerance
- Monitoring dashboards - Task performance and health metrics

### **0001_WORKFLOW_IMPLEMENTATION - Complete Workflow Implementation Procedure**

**Functional Coverage:**
- Complete workflow implementation framework from design to deployment
- Component integration and system architecture
- Testing, validation, and performance optimization
- Documentation and maintenance procedures
- Continuous improvement and monitoring

**Key Features:**
- ✅ **Full Lifecycle**: End-to-end workflow implementation process
- ✅ **Architecture Design**: Scalable and maintainable system design
- ✅ **Integration**: Seamless component integration and data flow
- ✅ **Quality Assurance**: Comprehensive testing and validation procedures
- ✅ **Performance**: Optimization for scalability and efficiency
- ✅ **Maintenance**: Ongoing monitoring and improvement processes

**System Impact:**
- **Critical**: Complete workflow system implementation capability
- **Users Affected**: Development teams and system architects
- **Business Critical**: Yes - enables all workflow-based functionality

**Related Components:**
- Workflow engines - Core execution platforms
- Integration frameworks - Component communication and data exchange
- Testing suites - Comprehensive validation and quality assurance
- Monitoring systems - Performance tracking and alerting

### **0500_VECTOR_DATA_ISOLATION - Vector Data Isolation Procedure**

**Functional Coverage:**
- Vector data management and isolation procedures
- Data partitioning and access control for vector databases
- Performance optimization for vector operations
- Security and privacy considerations for vector data
- Backup and recovery procedures

**Key Features:**
- ✅ **Data Isolation**: Secure vector data partitioning and access control
- ✅ **Performance**: Optimized vector operations and indexing
- ✅ **Security**: Encryption and access control for sensitive vector data
- ✅ **Scalability**: Distributed vector processing and load balancing
- ✅ **Backup/Recovery**: Comprehensive backup and disaster recovery procedures
- ✅ **Monitoring**: Vector database health and performance monitoring

**System Impact:**
- **Medium-High**: AI and machine learning data management
- **Users Affected**: AI/ML teams and data scientists
- **Business Critical**: Yes - supports AI functionality and data science operations

**Related Components:**
- Vector databases - Pinecone, Weaviate, or similar systems
- Data isolation frameworks - Secure data partitioning tools
- Performance monitoring - Vector operation analytics
- Backup systems - Vector data backup and recovery solutions

### **MIGRATION_TESTING_PROTOCOL - Migration Testing Protocol**

**Functional Coverage:**
- Comprehensive testing procedures for system migrations
- Data integrity verification and validation
- Performance testing and optimization
- Rollback procedures and contingency planning
- Stakeholder communication and sign-off processes

**Key Features:**
- ✅ **Data Validation**: Comprehensive data integrity and consistency checks
- ✅ **Performance Testing**: Migration performance benchmarking and optimization
- ✅ **Rollback Procedures**: Safe rollback mechanisms and data recovery
- ✅ **Testing Environments**: Staging and production testing procedures
- ✅ **Stakeholder Management**: Communication and sign-off processes
- ✅ **Documentation**: Complete migration testing documentation and reporting

**System Impact:**
- **High**: Migration success and system stability
- **Users Affected**: Migration teams and system stakeholders
- **Business Critical**: Yes - ensures successful system migrations and upgrades

**Related Components:**
- Testing frameworks - Automated migration testing tools
- Data validation scripts - Integrity and consistency checking
- Performance monitoring - Migration performance analytics
- Rollback systems - Safe migration reversal capabilities

### **01300_DISCIPLINE - Discipline Copy Logging Procedure**

**Functional Coverage:**
- Template creation discipline selection and validation flows
- Systematic logging at each step of discipline data processing
- Modal-to-parent component state synchronization
- Database insertion validation and constraint enforcement
- Comprehensive error tracking and performance monitoring

**Key Features:**
- ✅ **Comprehensive Logging**: Step-by-step logging throughout discipline selection workflow
- ✅ **State Synchronization**: Proper validation of modal-to-parent state lifting
- ✅ **Database Validation**: Server-side validation ensuring discipline_id and discipline_name are populated
- ✅ **Error Tracking**: Detailed logging for troubleshooting discipline copy failures
- ✅ **Verification Checklists**: Step-by-step implementation and testing procedures
- ✅ **Production Monitoring**: Performance tracking and alerting for discipline operations

**System Impact:**
- **High**: Core template creation functionality
- **Users Affected**: All users creating governance document templates
- **Business Critical**: Yes - prevents template creation failures and data integrity issues

**Related Components:**
- `governance_document_templates` table - Template storage with discipline fields
- `BulkDisciplineCopyModal.jsx` - Discipline selection interface
- `01300-template-management-page.js` - Parent template management component
- `FormCreationModals.jsx` - Modal form management system
- Database constraint validation - Discipline field enforcement

## Procedure Relationships & Dependencies

### **Execution Order for Template Generation Issues**

```
1. Symptom Identification
   ↓
2. 1300_02700 - Check for timeout/workflow issues
   ↓
3. 1300_00000 - Analyze error patterns if needed
   ↓
4. 0000_SYSTEM - Use framework for complex issues
```

### **Cross-Procedure Dependencies**

| Primary Procedure | Depends On | Used By |
|------------------|------------|---------|
| `1300_02700` | `0000_SYSTEM` (framework) | `1300_00000` (error analysis) |
| `1300_HTML_TEMPLATE` | `0000_SYSTEM` (framework), `1300_02700` (template generation) | Documentation publishing, all disciplines |
| `1300_00000` | `0900_ERROR_TRACKING` (SDK) | `1300_02700` (error patterns) |
| `0000_API_KEY_SECURITY` | `0000_SYSTEM` (framework), `0700_LANGCHAIN_SETTINGS_UI.md` (UI component) | All AI service integrations, security monitoring |
| `01300_USER_ROLES` | `0000_SYSTEM` (framework) | Security dashboard, role management |
| `01300_DEPARTMENT_USER_ROLES` | `01300_USER_ROLES` (RBAC foundation), `0000_SYSTEM` (framework) | All department implementations, security procedures |
| `0000_AGENT_ROLES` | `01300_USER_ROLES` (RBAC framework) | Agent operations, security monitoring |
| `0000_SQL_EXECUTION` | None | Database operations, schema changes, migrations |
| `0000_DROPDOWN` | `0000_SYSTEM` (framework), `0910_DROPDOWN_MANAGEMENT.md` (system) | Template management modals, form creation |
| `0000_WORKFLOW` | `0000_SYSTEM` (framework), `docs/0000_DOCUMENTATION_GUIDE.md` (standards) | All workflow implementations, documentation teams |
| `0000_CHATBOT_IMPLEMENTATION` | `0000_SYSTEM` (framework) | Chatbot interface implementations |
| `0000_CHATBOT_COMPREHENSIVE` | `0000_CHATBOT_IMPLEMENTATION` (base framework), `0000_SYSTEM` (framework) | Advanced chatbot features, enterprise integrations |
| `0000_DEBUGGING_GUIDE` | `0000_SYSTEM` (framework) | Development debugging, system troubleshooting |
| `0000_I18N_TRANSLATION_FILE_ORGANIZATION` | None | Internationalization setup, translation management |
| `0000_MERMAID_DIAGRAM_CREATION` | None | Technical documentation, diagram generation |
| `0000_QUICK_START_GUIDE` | None | New installations, system setup |
| `0000_TABLE_POLICIES_SECURITY` | None | Database security, RLS implementation |
| `0000_WORKFLOW_HITL` | `0000_SYSTEM` (framework) | Quality control workflows, human oversight |
| `0000_WORKFLOW_TASK` | `0000_SYSTEM` (framework) | Task management systems, workflow execution |
| `0001_WORKFLOW_IMPLEMENTATION` | `0000_WORKFLOW` (documentation), `0000_SYSTEM` (framework) | Complete workflow system development |
| `0500_VECTOR_DATA_ISOLATION` | None | AI/ML data management, vector databases |
| `MIGRATION_TESTING_PROTOCOL` | None | System migrations, deployment testing |
| `01300_DISCIPLINE` | `0000_DROPDOWN` (discipline flows), `0000_SYSTEM` (framework) | Template creation, governance workflows |
| `0900_ERROR_TRACKING` | None | All procedures (logging) |
| `0000_SYSTEM` | None | All specific procedures (template) |

## System Health Monitoring

### **Key Performance Indicators**

#### **Template Generation Health**
```javascript
const templateHealthMetrics = {
  generationSuccessRate: '>95%',     // Target success rate
  averageGenerationTime: '<45s',     // Target completion time
  timeoutRate: '<5%',               // Acceptable timeout rate
  errorRecoveryRate: '>90%'         // Successful error recovery
};
```

#### **Error Tracking Health**
```javascript
const errorHealthMetrics = {
  errorCaptureRate: '>99%',          // Errors successfully captured
  falsePositiveRate: '<1%',          // Alert accuracy
  meanTimeToDetection: '<5min',      // Error detection speed
  alertResponseTime: '<15min'       // Team response time
};
```

### **System Status Dashboard**

#### **🟢 FULLY OPERATIONAL** (Current Status)
- ✅ Template Generation: All fixes implemented and tested
- ✅ Error Tracking: Comprehensive coverage active
- ✅ User Roles & Security: RBAC implementation complete and documented
- ✅ Monitoring: Real-time health checks operational
- ✅ Documentation: All procedures current and accessible

#### **🟡 MONITORING REQUIRED**
- Template generation success rates
- Error rates and patterns
- System performance metrics
- User feedback and issue reports

#### **🔴 IMMEDIATE ATTENTION REQUIRED**
- Template generation success rate < 90%
- Critical error rate > 10%
- System downtime > 5 minutes
- User-impacting issues unresolved > 1 hour

## Procedure Maintenance & Updates

### **Update Frequency**
- **Daily**: Monitor system health metrics
- **Weekly**: Review error patterns and trends
- **Monthly**: Update procedures based on new issues
- **Quarterly**: Comprehensive procedure audit

### **Version Control**
- All procedures follow semantic versioning
- Major version changes require team review
- Change history maintained in each procedure
- Cross-references updated automatically

### **Quality Assurance**
- All procedures tested against real scenarios
- Peer review required for significant changes
- User acceptance testing for critical procedures
- Automated validation of procedure accuracy

## Quick Reference Guide

### **Symptom → Procedure Mapping**

| Symptom | Primary Procedure | Secondary Check |
|---------|------------------|------------------|
| Template generation fails | `1300_02700` | `1300_00000` |
| "Internal Server Error" | `1300_02700` (timeout) | `1300_00000` |
| Template stuck at 33% | `1300_02700` (progress) | `0000_SYSTEM` |
| High error rates | `1300_00000` | `0900_ERROR_TRACKING` |
| New error patterns | `1300_00000` | `0000_SYSTEM` |
| Performance issues | `0000_SYSTEM` | `1300_02700` |

### **Emergency Contacts**

| Issue Severity | Contact | Response Time |
|----------------|---------|---------------|
| **Critical** (system down) | DevOps Lead | < 15 minutes |
| **High** (major feature broken) | Engineering Manager | < 30 minutes |
| **Medium** (degraded performance) | Senior Developer | < 2 hours |
| **Low** (minor issues) | Development Team | < 4 hours |

### **Escalation Path**
1. **Individual Developer**: Initial investigation and fix attempts
2. **Team Lead**: Code review and additional resources
3. **Engineering Manager**: Cross-team coordination if needed
4. **DevOps Lead**: Infrastructure or deployment issues
5. **Executive Team**: Business-critical system outages

---

## Document Information

- **Document ID**: `README_PROCEDURES_GUIDE`
- **Version**: 1.0
- **Created**: 2025-12-11
- **Last Updated**: 2025-12-11
- **Author**: AI Assistant (Construct AI)
- **Review Cycle**: Monthly
- **Related Documents**:
  - `docs/0000_DOCUMENTATION_GUIDE.md`
  - `docs/error-tracking/1300_00000_ERROR_TRACKING_ALL.md`
  - `docs/procedures/0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md`

---

**Navigation**: Use this guide to quickly identify which procedure addresses your specific issue or system component. All procedures follow the standardized troubleshooting framework for consistency and effectiveness.