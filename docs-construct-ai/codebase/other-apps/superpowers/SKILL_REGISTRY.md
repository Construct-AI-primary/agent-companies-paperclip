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

# Superpowers Skill Registry

**Central registry for all available Superpowers skills in the Construct AI platform**

---

## 📋 Overview

This document serves as the authoritative registry for all Superpowers skills available to agent teams. Skills are organized by category and provide standardized interfaces for common coding and development workflows.

---

## 🎯 Skill Categories

### 1. Coding Skills (`coding`)
Skills for code generation, modification, and implementation.

### 2. Testing Skills (`testing`)
Skills for test creation, execution, and validation.

### 3. Review Skills (`review`)
Skills for code review, quality assessment, and feedback.

### 4. Planning Skills (`planning`)
Skills for architecture planning, task decomposition, and design.

### 5. Domain Skills (`domain`)
Specialized skills for specific domain requirements.

---

## 📚 Available Skills

### Coding Skills

#### `superpowers.run_coding_workflow`
- **Description**: Execute full brainstorm → plan → build → test workflow
- **Category**: `coding`
- **Version**: 1.0.0
- **Input Schema**:
  ```json
  {
    "task": "string",
    "context": {
      "files": ["string"],
      "spec": "string",
      "supabase_schema": "string"
    }
  }
  ```
- **Output Schema**:
  ```json
  {
    "plan": "string",
    "code": "string",
    "tests": "string",
    "review_feedback": "string"
  }
  ```
- **Usage**: Primary skill for end-to-end code generation workflows
- **Dependencies**: None

---

### Planning Skills

#### `superpowers.plan_component`
- **Description**: Plan component architecture and implementation
- **Category**: `planning`
- **Version**: 1.0.0
- **Input Schema**:
  ```json
  {
    "component_name": "string",
    "requirements": {
      "features": ["string"],
      "constraints": ["string"]
    }
  }
  ```
- **Output Schema**:
  ```json
  {
    "architecture": "string",
    "implementation_steps": ["string"],
    "dependencies": ["string"]
  }
  ```
- **Usage**: Used for planning complex component implementations
- **Dependencies**: None

---

### Testing Skills

#### `superpowers.tdd_check`
- **Description**: Run test-driven development checks
- **Category**: `testing`
- **Version**: 1.0.0
- **Input Schema**:
  ```json
  {
    "code": "string",
    "test_cases": [
      {
        "name": "string",
        "input": "object",
        "expected": "object"
      }
    ]
  }
  ```
- **Output Schema**:
  ```json
  {
    "test_results": {
      "passed": ["string"],
      "failed": ["string"]
    },
    "coverage": 0.0,
    "passed": true
  }
  ```
- **Usage**: Validates code against test cases using TDD methodology
- **Dependencies**: None

---

### Review Skills

#### `superpowers.review_code`
- **Description**: Review code for quality and best practices
- **Category**: `review`
- **Version**: 1.0.0
- **Input Schema**:
  ```json
  {
    "code": "string",
    "context": {
      "language": "string",
      "framework": "string",
      "style_guide": "string"
    }
  }
  ```
- **Output Schema**:
  ```json
  {
    "feedback": "string",
    "suggestions": [
      {
        "line": 0,
        "issue": "string",
        "suggestion": "string"
      }
    ],
    "score": 0.0
  }
  ```
- **Usage**: Provides automated code review with actionable feedback
- **Dependencies**: None

---

## 🔧 Skill Integration

### For OpenClaw Agents

To use a Superpowers skill in your OpenClaw agent:

1. **Import the skill wrapper**:
   ```javascript
   const { superpowers } = require('@construct-ai/superpowers-client');
   ```

2. **Call the skill**:
   ```javascript
   const result = await superpowers.run('superpowers.run_coding_workflow', {
     task: 'Create a React modal with 9 cards',
     context: {
       files: ['Modal.jsx'],
       spec: 'UI specification...',
       supabase_schema: 'schema definition...'
     }
   });
   ```

3. **Handle the response**:
   ```javascript
   if (result.success) {
     // Use result.data.plan, result.data.code, etc.
   } else {
     // Handle error in result.error
   }
   ```

### For Paperclip Integration

Skills are automatically available to agents based on their role configuration in Paperclip. The skill registry in Supabase tracks which skills are available to which agent types.

---

## 📊 Skill Usage Tracking

All skill executions are logged in the `skill_usage_logs` table for:
- Performance monitoring
- Error tracking
- Usage analytics
- Optimization insights

---

## 🔄 Adding New Skills

To add a new skill to the registry:

1. **Define the skill** in `database/superpowers_schema_extensions.sql`
2. **Update this registry** with skill documentation
3. **Implement the skill** in the Superpowers service
4. **Test the skill** with sample inputs
5. **Deploy** and verify in production

---

## 📝 Skill Versioning

Skills follow semantic versioning:
- **Major**: Breaking changes to input/output schema
- **Minor**: New features, backward compatible
- **Patch**: Bug fixes, no schema changes

---

## 🆘 Support

For skill-related questions:
- Check this registry first
- Review skill-specific documentation
- Contact the Superpowers team
- Create an issue for new skill requests

---

**Last Updated**: 2026-03-30
**Maintainer**: Construct AI Superpowers Team
**Version**: 1.0