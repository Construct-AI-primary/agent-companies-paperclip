---
memory_layer: durable_knowledge
para_section: pages/codebase
gigabrain_tags: codebase, architecture, development-standards, coding-practices, system-design
openstinger_context: development-lifecycle, technical-standards, system-architecture
last_updated: 2026-03-21
code_references:
  - src/architecture/
  - src/standards/
  - src/development/
related_docs:
  - disciplines/01900_procurement/para-index.md
  - disciplines/02400_safety/para-index.md
  - para/projects/01900-procurement-system/README.md
---

# Codebase Architecture & Standards

## Overview
This directory contains comprehensive documentation covering the entire Construct AI codebase architecture, development standards, and operational procedures. This documentation serves as the central reference for all development activities and system understanding.

## Directory Structure

### Architecture Documentation
#### `architecture/` - System Architecture & Design Patterns
- `system-overview.md` - High-level system architecture
- `design-patterns.md` - Architectural patterns and principles
- `component-interaction.md` - Component interaction diagrams
- `scalability-design.md` - Scalability and performance architecture
- `security-architecture.md` - Security design principles

#### `api/` - API Specifications & Documentation
- `rest-api.md` - REST API specifications
- `graphql-api.md` - GraphQL API documentation
- `internal-apis.md` - Internal service APIs
- `api-versioning.md` - API versioning strategy
- `api-security.md` - API security measures

#### `database/` - Database Architecture & Schemas
- `schema-overview.md` - Database schema documentation
- `migrations/` - Database migration procedures
- `indexing-strategy.md` - Database indexing guidelines
- `backup-recovery.md` - Backup and recovery procedures
- `performance-tuning.md` - Database performance optimization

#### `infrastructure/` - Infrastructure as Code & Deployment
- `infrastructure-as-code.md` - IaC principles and tools
- `kubernetes/` - Kubernetes configurations
- `docker/` - Containerization standards
- `cloud-infrastructure.md` - Cloud infrastructure setup
- `networking.md` - Network architecture

### Development Standards
#### `coding-standards/` - Code Style & Standards
- `0000_AGENT_CODING_STANDARDS.md` - Agent-specific coding standards
- `0000_AGENT_DEVELOPMENT_STANDARDS.md` - Agent development practices
- `0000_CODE_STANDARDIZATION_MASTER_PLAN.md` - Code standardization framework
- `0000_FILE_NAMING_STANDARDS.md` - File and directory naming conventions
- `0000_PYTHON_MODULE_NAMING_STANDARDS.md` - Python-specific naming standards
- `README.md` - Coding standards overview and guidelines

#### `testing/` - Testing Strategies & Frameworks
- `testing-strategy.md` - Overall testing approach
- `unit-testing.md` - Unit testing guidelines
- `integration-testing.md` - Integration testing procedures
- `e2e-testing.md` - End-to-end testing frameworks
- `performance-testing.md` - Performance testing methodologies
- `test-automation.md` - Test automation strategies

#### `security/` - Security Guidelines & Practices
- `security-principles.md` - Core security principles
- `authentication.md` - Authentication mechanisms
- `authorization.md` - Authorization patterns
- `data-protection.md` - Data protection strategies
- `vulnerability-management.md` - Vulnerability assessment and remediation
- `compliance.md` - Regulatory compliance requirements

#### `performance/` - Performance Optimization Guidelines
- `performance-principles.md` - Performance optimization principles
- `caching-strategies.md` - Caching implementation guidelines
- `database-optimization.md` - Database performance tuning
- `frontend-optimization.md` - Frontend performance optimization
- `monitoring-alerting.md` - Performance monitoring and alerting

### Development Guides
#### `guides/` - Development & Operational Guides (11M)
- `api/` - API development and integration guides
- `debugging/` - Debugging and troubleshooting guides
- `developer/` - Developer workflow and best practices
- `styling/` - UI/UX styling and design guides
- `CHATBOT-MIGRATION-DEPLOYMENT-GUIDE.MD` - Migration procedures

#### `procedures/` - Operational Procedures (3.3M)
- `agent-development/` - Agent development and deployment procedures
- `ai-ml/` - AI/ML model training and management procedures
- `database-management/` - Database administration procedures
- `deployment-operations/` - Deployment and operations procedures
- `documentation/` - Documentation maintenance procedures

#### `workflows/` - Process Workflows (3.1M)
- `chatbot/` - Chatbot interaction workflows
- `contractor-safety/` - Safety management workflows
- `correspondence/` - Document correspondence workflows
- `general/` - General business process workflows
- `procurement/` - Procurement order workflows

#### `schema/` - Database & API Schemas (7.8M)
- `code/` - Code structure and organization schemas
- `data/` - Database schemas and data models
- `REORGANIZATION_MAPPING.md` - Schema reorganization documentation
- `0000_TEST_HTML_GENERATION_FIX.md` - Schema testing procedures

#### `reports/` - Development Reports (540K)
- `0000_COMPLETE_VALIDATION_REPORT.md` - System validation reports
- `0000_DOCUMENTATION_ANALYSIS_REPORT.md` - Documentation quality reports
- `0000_DOCUMENTATION_AUDIT_REPORT.md` - Audit and compliance reports
- `AGENT_DEPLOYMENT_COMPLETION_REPORT.md` - Deployment status reports

#### `development/` - Development Lifecycle Documentation
- `0000_AGENT_DEVELOPMENT_PROCEDURE.md` - Agent development procedures
- `0000_PROJECT_DEVELOPMENT_TODO_LIST.md` - Development task tracking
- `1300_00170_MODAL_DEVELOPMENT_GUIDE.md` - UI component development
- `1300_00180_MODAL_DEVELOPMENT_GUIDE.md` - Modal development guides

#### `commands/` - Command Line Tools & Scripts
- `brainstorm.md` - Brainstorming command documentation
- `execute-plan.md` - Plan execution command documentation
- `write-plan.md` - Plan writing command documentation

#### `agents/` - AI Agent Documentation & Frameworks (436 files)
- `code-reviewer.md` - Code review agent documentation
- Agent development frameworks and patterns
- AI agent integration procedures and guidelines
- Specialized agent implementations for different domains

#### `analysis/` - System Analysis & Research (39 files)
- `0000_ERROR_FIXES_SUMMARY.md` - Error analysis and fixes
- System performance analysis and optimization studies
- Build error analysis and troubleshooting procedures
- Research documents and technical investigations

#### `audits/` - Compliance & Quality Audits (36 files)
- `AGENT_SYSTEM_AUDIT_REPORT.md` - Agent system audit reports
- `0000_DOCUMENTATION_AUDIT_PROCEDURE.md` - Documentation audit procedures
- Security audit reports and compliance documentation
- Quality assurance audit frameworks and results

#### `testing/` - Testing Frameworks & Procedures
- Unit testing guidelines and frameworks
- Integration testing procedures and best practices
- End-to-end testing methodologies
- Performance testing and benchmarking procedures

#### `tools/` - Development Tools & Utilities
- Development tool configurations and setup
- Utility scripts and automation tools
- Build tools and deployment utilities
- Development environment configurations

#### `archive/` - Historical Documentation & Archives
- Legacy documentation and deprecated procedures
- Historical project documentation and decisions
- Archived workflows and processes
- Version history and change tracking

#### `backup/` - Backup Procedures & Recovery
- System backup procedures and schedules
- Disaster recovery plans and procedures
- Data restoration processes
- Business continuity documentation

#### `docs/` - General Documentation & References
- General reference materials and guides
- Cross-cutting documentation topics
- Knowledge base articles and FAQs
- General operational procedures

#### `examples/` - Code Examples & Templates
- Code implementation examples and patterns
- Template files and boilerplate code
- Sample configurations and setups
- Best practice demonstrations

#### `errors/` - Error Documentation & Troubleshooting
- Error codes and their meanings
- Troubleshooting guides and procedures
- Common issues and their solutions
- Error handling best practices

#### `mobile/` - Mobile Development Documentation
- Mobile application development guides
- Responsive design principles and patterns
- Mobile-specific testing procedures
- Cross-platform development frameworks

#### `other-apps/` - Additional Application Documentation
- Third-party application integrations
- Utility application documentation
- Supporting tool documentation
- External service integrations

### Integration Documentation
#### `integrations/` - Third-Party Integrations
- `external-apis.md` - External API integrations
- `payment-systems.md` - Payment processor integrations
- `communication-tools.md` - Communication platform integrations
- `cloud-services.md` - Cloud service integrations
- `legacy-systems.md` - Legacy system integrations

#### `deployment/` - Deployment Procedures & Environments
- `deployment-pipeline.md` - CI/CD pipeline documentation
- `environment-setup.md` - Environment configuration
- `blue-green-deployment.md` - Blue-green deployment strategy
- `rollback-procedures.md` - Rollback procedures
- `deployment-checklist.md` - Pre and post-deployment checklists

#### `monitoring/` - Monitoring & Observability
- `monitoring-stack.md` - Monitoring infrastructure
- `metrics-collection.md` - Metrics collection and storage
- `logging-strategy.md` - Logging standards and practices
- `alerting-rules.md` - Alerting configuration
- `dashboard-setup.md` - Monitoring dashboards

#### `maintenance/` - Maintenance Procedures & Schedules
- `maintenance-schedule.md` - Regular maintenance procedures
- `backup-strategies.md` - Backup procedures and schedules
- `patching-process.md` - Security patching procedures
- `dependency-updates.md` - Dependency management
- `cleanup-procedures.md` - System cleanup and optimization

## Usage Guidelines

### For New Developers
1. **Start with Architecture** - Read `architecture/system-overview.md`
2. **Review Coding Standards** - Study `coding-standards/` directory
3. **Understand Testing** - Review `testing/testing-strategy.md`
4. **Learn Deployment** - Read `deployment/deployment-pipeline.md`
5. **Know Security** - Study `security/security-principles.md`

### For Development Teams
1. **Architecture Reviews** - Reference `architecture/` for design decisions
2. **Code Reviews** - Use `coding-standards/` as review criteria
3. **Testing Requirements** - Follow `testing/` guidelines
4. **Security Compliance** - Adhere to `security/` requirements
5. **Performance Standards** - Meet `performance/` guidelines

### For DevOps Teams
1. **Infrastructure Management** - Use `infrastructure/` documentation
2. **Deployment Procedures** - Follow `deployment/` guidelines
3. **Monitoring Setup** - Configure using `monitoring/` standards
4. **Maintenance Tasks** - Execute `maintenance/` procedures

## Integration with Memory System

### PARA Knowledge Integration
- **Projects**: Active development work in `para/projects/`
- **Areas**: Ongoing responsibilities documented here
- **Resources**: Reference materials for development standards
- **Pages**: Direct access to architecture and standards

### Memory Layer Usage
- **Layer C (PARA)**: Architecture and standards as durable knowledge
- **Layer D (Daily)**: Reference during development activities
- **Layer E (Gigabrain)**: Automatic surfacing of relevant standards

## Quality Assurance

### Documentation Standards
- All documents include YAML frontmatter with metadata
- Cross-references to related documents
- Regular updates to reflect current practices
- Version control with meaningful commit messages

### Review Processes
- Architecture decisions require documentation review
- Standards updates require team approval
- Security-related changes require security review
- Performance changes require performance team review

## Maintenance & Updates

### Regular Updates
- **Weekly**: Review and update deployment procedures
- **Monthly**: Audit security practices and update if needed
- **Quarterly**: Review architecture documentation for accuracy
- **Annually**: Complete review of all standards and practices

### Version Control
- Major architecture changes require documentation updates
- Standards changes require version tagging
- Breaking changes require migration documentation
- Deprecations require clear communication

## Quick Reference

### Development Workflow
1. **Planning** → Check `architecture/` for design patterns
2. **Coding** → Follow `coding-standards/`
3. **Testing** → Use `testing/` guidelines
4. **Security** → Apply `security/` principles
5. **Performance** → Meet `performance/` standards
6. **Deployment** → Follow `deployment/` procedures

### Common Tasks
- **New Feature** → `architecture/design-patterns.md`
- **API Development** → `api/rest-api.md`
- **Database Changes** → `database/schema-overview.md`
- **Security Review** → `security/security-principles.md`
- **Performance Issue** → `performance/performance-principles.md`

---

*This codebase documentation provides the foundation for consistent, high-quality development across the Construct AI enterprise.*
EOF && echo "Codebase README created" && echo -e "\n=== Creating Key Architecture Documents ===" && cat > docs_construct_ai/codebase/architecture/system-overview.md << 'EOF'
# System Architecture Overview

## Executive Summary
Construct AI operates as a distributed, AI-driven enterprise system with integrated memory stacks, PARA knowledge management, and multi-disciplinary workflow orchestration. This document provides the architectural foundation for understanding the system's design principles and operational characteristics.

## Core Architectural Principles

### 1. Memory-First Design
- **Integrated Memory Stack**: All system components integrate with the 5-layer memory system
- **PARA Knowledge Management**: Projects, Areas, Resources, Archives methodology
- **Context Preservation**: Session continuity across distributed operations
- **Intelligent Recall**: Pattern recognition and automatic knowledge surfacing

### 2. Distributed Agent Architecture
- **OpenClaw Integration**: Distributed AI agents with memory synchronization
- **Autonomous Operation**: Self-directed agents with goal-oriented behavior
- **Collaborative Intelligence**: Multi-agent coordination and knowledge sharing
- **Scalable Orchestration**: Dynamic agent allocation based on workload

### 3. Discipline-Based Organization
- **Domain Expertise**: Specialized agents for each business discipline
- **Cross-Discipline Integration**: Unified workflows across organizational boundaries
- **Knowledge Federation**: Shared understanding across distributed teams
- **Compliance Assurance**: Built-in regulatory and quality controls

## System Components

### Memory Stack Integration
```
Layer A: Routing (AGENTS.md, MEMORY.md)
├── Navigation guides and access patterns
├── Memory layer usage instructions
└── Agent behavior guidelines

Layer B: Session Recovery (LCM)
├── Context preservation across sessions
├── Conversation continuity
└── State recovery mechanisms

Layer C: Durable Knowledge (PARA)
├── Projects: Active development initiatives
├── Areas: Ongoing operational responsibilities
├── Resources: Reference materials and tools
└── Pages: Discipline-specific knowledge areas

Layer D: Daily Operations (memory/YYYY-MM-DD.md)
├── Daily activity logging
├── Decision tracking
└── Operational context

Layer E: Automatic Recall (Gigabrain)
├── Intelligent context surfacing
├── Pattern recognition
└── Knowledge discovery
```

### Agent Framework
- **Specialized Agents**: Domain-specific AI agents (51 total across 7 categories)
- **Memory Integration**: Each agent maintains memory state and context
- **Collaborative Workflows**: Multi-agent coordination for complex tasks
- **Quality Assurance**: Built-in validation and error correction

### Knowledge Management
- **PARA Methodology**: Structured knowledge organization
- **Cross-References**: Inter-discipline relationship mapping
- **Version Control**: Git-based documentation versioning
- **Search Integration**: Intelligent knowledge discovery

## Data Flow Architecture

### Information Flow
1. **Input Processing**: External data and user requests
2. **Memory Integration**: Context retrieval from memory layers
3. **Agent Processing**: AI-driven analysis and decision making
4. **Knowledge Updates**: PARA system updates and cross-references
5. **Output Generation**: Structured responses and documentation updates

### Synchronization Patterns
- **Real-time Sync**: Immediate memory updates across distributed agents
- **Batch Processing**: Periodic PARA system reconciliation
- **Conflict Resolution**: Automated merging of concurrent updates
- **Backup Integration**: Redundant storage with recovery mechanisms

## Security Architecture

### Access Control
- **Role-Based Access**: Discipline-specific permissions
- **Memory Isolation**: Secure memory compartments per agent
- **Audit Trails**: Comprehensive logging of all operations
- **Encryption**: End-to-end encryption for sensitive data

### Compliance Integration
- **Regulatory Compliance**: Built-in compliance checking
- **Quality Assurance**: Automated quality validation
- **Risk Management**: Proactive risk identification and mitigation
- **Audit Integration**: Seamless audit trail generation

## Performance Characteristics

### Scalability
- **Horizontal Scaling**: Agent pool expansion based on demand
- **Memory Optimization**: Efficient memory usage and compression
- **Distributed Processing**: Load balancing across agent instances
- **Resource Management**: Dynamic resource allocation

### Reliability
- **Fault Tolerance**: Graceful degradation and recovery
- **Data Persistence**: Redundant storage with automatic failover
- **Monitoring Integration**: Real-time health monitoring and alerting
- **Backup Systems**: Comprehensive backup and recovery procedures

## Integration Points

### External Systems
- **OpenClaw Platform**: Distributed AI agent orchestration
- **DevForge AI**: Company-level documentation and strategy
- **Loopy AI**: AI research and development integration
- **Shared Resources**: Cross-company knowledge base

### Development Tools
- **Version Control**: Git-based repository management
- **CI/CD Pipeline**: Automated testing and deployment
- **Monitoring Stack**: Comprehensive system monitoring
- **Documentation System**: Integrated knowledge management

## Operational Characteristics

### Agent Behavior
- **Goal-Oriented**: Purpose-driven task execution
- **Context-Aware**: Memory-integrated decision making
- **Collaborative**: Multi-agent coordination and communication
- **Adaptive**: Learning from operational patterns

### Knowledge Evolution
- **Continuous Learning**: Pattern recognition and adaptation
- **Documentation Updates**: Automatic PARA system maintenance
- **Cross-Reference Updates**: Dynamic relationship mapping
- **Quality Improvement**: Self-improving knowledge accuracy

## Future Evolution

### Planned Enhancements
- **Advanced Memory**: OpenStinger cross-session pattern recognition
- **Enhanced Collaboration**: Improved multi-agent coordination
- **Extended Disciplines**: Additional domain expertise integration
- **Performance Optimization**: Advanced caching and optimization

### Architectural Flexibility
- **Modular Design**: Component-based architecture for easy extension
- **API-First**: Comprehensive API design for integration
- **Standards Compliance**: Industry standard adherence
- **Scalability Planning**: Designed for enterprise-scale operation

---

*This architecture provides the foundation for an intelligent, memory-integrated enterprise system capable of autonomous operation and continuous learning.*
EOF && cat > docs_construct_ai/codebase/coding-standards/README.md << 'EOF'
# Coding Standards & Guidelines

## Overview
This document outlines the coding standards and development practices for the Construct AI codebase. These standards ensure consistency, maintainability, and quality across all development activities.

## General Principles

### Code Quality
- **Readability First**: Code should be self-documenting and easy to understand
- **Maintainability**: Code should be easy to modify and extend
- **Performance**: Code should be efficient and scalable
- **Security**: Security considerations should be built into every component

### Development Practices
- **Test-Driven Development**: Write tests before implementation
- **Continuous Integration**: Automated testing and integration
- **Code Reviews**: All code changes require peer review
- **Documentation**: Code should be well-documented

## Language-Specific Standards

### TypeScript/JavaScript
#### File Organization
```typescript
// File structure
src/
├── components/     // React components
├── services/       // Business logic services
├── utils/         // Utility functions
├── types/         // TypeScript type definitions
├── hooks/         // Custom React hooks
└── constants/     // Application constants
```

#### Naming Conventions
- **Files**: `kebab-case.ts` (e.g., `user-service.ts`)
- **Classes**: `PascalCase` (e.g., `UserService`)
- **Functions/Methods**: `camelCase` (e.g., `getUserData`)
- **Constants**: `SCREAMING_SNAKE_CASE` (e.g., `API_BASE_URL`)
- **Interfaces**: `PascalCase` with `I` prefix (e.g., `IUser`)

#### Code Style
```typescript
// Interface definitions
interface IUser {
  id: string;
  name: string;
  email: string;
  createdAt: Date;
}

// Class implementation
class UserService {
  private readonly apiUrl: string;

  constructor(apiUrl: string) {
    this.apiUrl = apiUrl;
  }

  async getUser(id: string): Promise<IUser> {
    try {
      const response = await fetch(`${this.apiUrl}/users/${id}`);
      return await response.json();
    } catch (error) {
      console.error('Failed to fetch user:', error);
      throw error;
    }
  }
}

// React component
interface UserCardProps {
  user: IUser;
  onEdit: (user: IUser) => void;
}

const UserCard: React.FC<UserCardProps> = ({ user, onEdit }) => {
  return (
    <div className="user-card">
      <h3>{user.name}</h3>
      <p>{user.email}</p>
      <button onClick={() => onEdit(user)}>Edit</button>
    </div>
  );
};
```

### Python
#### File Organization
```python
# File structure
src/
├── models/         # Data models
├── services/       # Business logic
├── utils/          # Utilities
├── tests/          # Unit tests
├── migrations/     # Database migrations
└── config/         # Configuration files
```

#### Naming Conventions
- **Files**: `snake_case.py` (e.g., `user_service.py`)
- **Classes**: `PascalCase` (e.g., `UserService`)
- **Functions/Methods**: `snake_case` (e.g., `get_user_data`)
- **Constants**: `SCREAMING_SNAKE_CASE` (e.g., `API_BASE_URL`)
- **Variables**: `snake_case` (e.g., `user_data`)

#### Code Style
```python
# Type hints and imports
from typing import Optional, List
from dataclasses import dataclass
from datetime import datetime

@dataclass
class User:
    id: str
    name: str
    email: str
    created_at: datetime

class UserService:
    def __init__(self, api_url: str):
        self.api_url = api_url

    async def get_user(self, user_id: str) -> Optional[User]:
        """Fetch user by ID."""
        try:
            # Implementation here
            pass
        except Exception as e:
            logger.error(f"Failed to fetch user {user_id}: {e}")
            return None

    def validate_user_data(self, user_data: dict) -> List[str]:
        """Validate user data and return list of errors."""
        errors = []
        if not user_data.get('name'):
            errors.append('Name is required')
        if not user_data.get('email'):
            errors.append('Email is required')
        return errors
```

## Testing Standards

### Unit Testing
- **Coverage**: Minimum 80% code coverage
- **Isolation**: Tests should not depend on external systems
- **Naming**: `test_function_name` or `test_FunctionName`
- **Structure**: Arrange, Act, Assert pattern

### Integration Testing
- **Scope**: Test component interactions
- **Data**: Use realistic test data
- **Cleanup**: Ensure test data is properly cleaned up
- **Documentation**: Document test scenarios and expected outcomes

### End-to-End Testing
- **User Journeys**: Test complete user workflows
- **Performance**: Include performance benchmarks
- **Cross-browser**: Test across supported browsers
- **Mobile**: Include mobile device testing

## Documentation Standards

### Code Documentation
- **Functions**: Document purpose, parameters, return values, and exceptions
- **Classes**: Document responsibility and usage patterns
- **Modules**: Document module purpose and key components
- **APIs**: Document endpoints, parameters, and responses

### README Files
- **Purpose**: Explain what the component/module does
- **Usage**: Provide usage examples
- **Setup**: Include setup and configuration instructions
- **Contributing**: Document contribution guidelines

## Security Guidelines

### Input Validation
- **Sanitize**: All user inputs should be sanitized
- **Validate**: Input should be validated against expected formats
- **Escape**: Output should be properly escaped
- **Limits**: Implement reasonable input limits

### Authentication & Authorization
- **Secure Storage**: Never store sensitive data in plain text
- **Token Management**: Implement proper token expiration and refresh
- **Role-based Access**: Implement proper authorization checks
- **Audit Logging**: Log security-relevant events

### Data Protection
- **Encryption**: Encrypt sensitive data at rest and in transit
- **Access Control**: Implement proper data access controls
- **Retention**: Define data retention policies
- **Deletion**: Implement secure data deletion procedures

## Performance Guidelines

### Frontend Optimization
- **Bundle Splitting**: Split code into logical chunks
- **Lazy Loading**: Load components on demand
- **Image Optimization**: Optimize images for web delivery
- **Caching**: Implement appropriate caching strategies

### Backend Optimization
- **Database Queries**: Optimize database queries and indexing
- **Caching**: Implement caching for frequently accessed data
- **Async Processing**: Use async processing for long-running tasks
- **Resource Management**: Properly manage database connections and resources

### Monitoring
- **Metrics**: Implement comprehensive metrics collection
- **Logging**: Implement structured logging
- **Alerting**: Set up appropriate alerting thresholds
- **Profiling**: Regular performance profiling and optimization

## Git Workflow

### Branching Strategy
- **main**: Production-ready code
- **develop**: Integration branch for features
- **feature/**: Feature branches (e.g., `feature/user-authentication`)
- **bugfix/**: Bug fix branches (e.g., `bugfix/login-validation`)
- **hotfix/**: Emergency fixes for production

### Commit Messages
- **Format**: `type(scope): description`
- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
- **Description**: Clear, concise description of changes
- **Body**: Optional detailed explanation

### Pull Requests
- **Title**: Clear, descriptive title
- **Description**: Detailed description of changes
- **Testing**: Description of testing performed
- **Reviewers**: Appropriate team members for review
- **Labels**: Appropriate labels for categorization

## Code Review Guidelines

### Review Checklist
- [ ] Code follows established patterns and conventions
- [ ] Unit tests are included and passing
- [ ] Documentation is updated
- [ ] Security considerations are addressed
- [ ] Performance implications are considered
- [ ] Code is readable and maintainable

### Review Process
1. **Automated Checks**: Run linting, testing, and security scans
2. **Self-Review**: Author reviews their own code first
3. **Peer Review**: At least one team member reviews the code
4. **Approval**: Code must be approved before merging
5. **Merge**: Approved code is merged to the target branch

## Tooling & Automation

### Development Tools
- **EditorConfig**: Consistent editor settings
- **ESLint/Prettier**: Code linting and formatting
- **TypeScript**: Type checking and compilation
- **Jest**: Unit testing framework
- **Cypress**: End-to-end testing

### CI/CD Pipeline
- **Linting**: Automated code quality checks
- **Testing**: Automated test execution
- **Security**: Automated security scanning
- **Deployment**: Automated deployment to staging/production

---

*These standards ensure consistent, high-quality code across the Construct AI enterprise.*
EOF && echo "Key codebase documents created"