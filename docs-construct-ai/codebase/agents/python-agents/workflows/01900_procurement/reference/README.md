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
# Reference Documentation

This directory contains all reference materials, API documentation, templates, and standards for the procurement workflow system.

## 📁 Contents

### [documentation/](./documentation/)
**Reference and Standards Documentation**
- **PRACTICAL_PROMPT_USAGE_GUIDE.md** - Practical prompt usage guidelines
- **PROMPT_SEQUENCE_SOLUTION_SUMMARY.md** - Prompt sequencing solutions
- **PROMPT_VISUALIZATION_IMPLEMENTATION_GUIDE.md** - Visualization implementation
- **PROMPT_VISUALIZATION_UI_INTEGRATION.md** - UI integration guidelines
- **STANDARDS_COMPLIANCE_REPORT.md** - Standards compliance documentation
- **USAGE_SUMMARY.md** - Usage documentation and best practices

### [documents/](../documents/)
**Template Documents and Specifications**
- **0003_sow_document.md** - Statement of Work template
- **0004_appendix_a_specifications.md** - Appendix A: Product specifications
- **0005_appendix_b_safety.md** - Appendix B: Safety requirements
- **0006_appendix_c_delivery.md** - Appendix C: Delivery schedule
- **0007_appendix_d_training.md** - Appendix D: Training materials
- **0008_appendix_e_logistics.md** - Appendix E: Logistics specifications
- **0009_appendix_f_packing.md** - Appendix F: Packing and marking

## 📋 API Reference

### Session Management API

#### Start Session
```http
POST /api/procurement/sessions
Content-Type: application/json

{
  "user_id": "user-uuid",
  "session_type": "procurement"
}
```

**Response:**
```json
{
  "sessionId": "session-uuid",
  "status": "active",
  "created_at": "2026-02-26T16:00:00Z"
}
```

#### Send Message
```http
POST /api/procurement/messages
Content-Type: application/json

{
  "session_id": "session-uuid",
  "message": "I need to purchase industrial equipment"
}
```

**Response:**
```json
{
  "message_id": "message-uuid",
  "response": "What type of industrial equipment do you need?",
  "session_state": "chatting"
}
```

#### Extract Data
```http
POST /api/procurement/extract
Content-Type: application/json

{
  "session_id": "session-uuid"
}
```

**Response:**
```json
{
  "extracted_data": {
    "procurement_type": "equipment",
    "estimated_value": 50000,
    "items": [...]
  },
  "validation_status": "pending"
}
```

### Agent API

#### Invoke Specialist Agent
```http
POST /api/agent-development-tasks
Content-Type: application/json

{
  "scope": "01900",
  "taskType": "specialist_template_analysis",
  "developmentMode": true,
  "extracted_data": {...},
  "context": {...}
}
```

**Response:**
```json
{
  "agent_id": "agent-uuid",
  "status": "completed",
  "result": {...},
  "processing_time": 800
}
```

## 📄 Template Reference

### Document Templates

#### Statement of Work (SOW)
- **Purpose**: Main procurement contract document
- **Structure**: Executive summary, scope, deliverables, timeline, compliance
- **Usage**: Generated automatically from extracted requirements

#### Appendix A: Product Specifications
- **Purpose**: Detailed technical specifications
- **Structure**: Tabular format with specifications, quantities, requirements
- **Usage**: Auto-generated from product requirements

#### Appendix B: Safety Data Sheets (SDS)
- **Purpose**: Safety and compliance documentation
- **Structure**: Regulatory requirements, safety protocols, compliance standards
- **Usage**: Generated based on product types and destination country

### Template Variables

#### Common Variables
- `{{procurement_type}}` - Type of procurement (equipment, services, etc.)
- `{{estimated_value}}` - Estimated order value
- `{{destination_country}}` - Delivery destination
- `{{timeline}}` - Project timeline
- `{{requirements}}` - Specific requirements

#### Dynamic Content
- **Compliance Requirements**: Based on destination country regulations
- **Technical Specifications**: Based on product categories
- **Safety Standards**: Based on product types and usage

## 🏗️ Standards and Compliance

### Data Standards

#### Field Naming Conventions
- **Snake Case**: Database fields (`procurement_type`, `estimated_value`)
- **Camel Case**: JavaScript variables (`procurementType`, `estimatedValue`)
- **Pascal Case**: Component names (`ProcurementInputAgentModal`)

#### Data Types
- **UUID**: Primary keys and unique identifiers
- **JSONB**: Complex data structures and metadata
- **DECIMAL**: Financial values with precision
- **TIMESTAMP**: Date and time values

### Security Standards

#### Input Validation
- **Sanitization**: All user inputs sanitized
- **Validation**: Field-level and business rule validation
- **Escaping**: HTML content properly escaped

#### Authentication
- **Session Management**: Secure session handling
- **User Permissions**: Role-based access control
- **API Security**: Authentication for all endpoints

### Performance Standards

#### Response Times
- **Agent Processing**: 600-900ms per agent
- **API Responses**: <200ms for simple operations
- **Page Load**: <3 seconds for initial load

#### Scalability
- **Concurrent Users**: Support for 100+ concurrent sessions
- **Database Performance**: Optimized queries with proper indexing
- **Memory Management**: Efficient session data handling

## 🔧 Configuration Reference

### Environment Variables

#### Database Configuration
```bash
DATABASE_URL=postgresql://user:password@host:port/database
DB_POOL_MIN=2
DB_POOL_MAX=10
```

#### API Configuration
```bash
API_BASE_URL=http://localhost:3000
AGENT_API_URL=http://localhost:3001
SESSION_TIMEOUT=3600
```

#### Security Configuration
```bash
JWT_SECRET=your-secret-key
CORS_ORIGIN=http://localhost:3060
RATE_LIMIT_REQUESTS=100
RATE_LIMIT_WINDOW=900000
```

### Database Schema

#### Core Tables
- **procurement_agent_sessions**: Session management
- **procurement_orders**: Order information
- **procurement_documents**: Generated documents
- **procurement_categories**: Product categories and groups

#### Indexes
- **Session Indexes**: Fast session lookup and management
- **Order Indexes**: Efficient order querying and filtering
- **Document Indexes**: Quick document retrieval and search

## 📊 Metrics and Monitoring

### Key Performance Indicators (KPIs)

#### User Experience Metrics
- **Session Success Rate**: Percentage of completed workflows
- **Agent Response Time**: Average time for agent processing
- **User Satisfaction**: Feedback and rating metrics

#### System Performance Metrics
- **API Response Time**: Average response time for API calls
- **Database Query Time**: Average time for database operations
- **Memory Usage**: System memory consumption patterns

#### Business Metrics
- **Order Completion Rate**: Percentage of orders successfully created
- **Document Generation Time**: Time to generate complete document packages
- **Approval Workflow Efficiency**: Time through approval processes

### Monitoring Tools

#### Application Monitoring
- **Error Tracking**: Real-time error monitoring and alerting
- **Performance Monitoring**: Response time and throughput tracking
- **User Analytics**: User behavior and workflow analysis

#### Infrastructure Monitoring
- **Server Health**: CPU, memory, and disk usage monitoring
- **Database Performance**: Query performance and connection monitoring
- **Network Monitoring**: API endpoint availability and response times

## 🔗 Related Documentation

- **[Architecture Documentation](../architecture/)** - System design and architecture
- **[Implementation Documentation](../implementation/)** - Technical implementation guides
- **[Main Documentation](../README.md)** - System overview and user guide
- **[Implementation Guide](../IMPLEMENTATION_GUIDE.md)** - Comprehensive technical reference

---

*This reference documentation provides comprehensive technical specifications, API references, and standards for the procurement workflow system.*