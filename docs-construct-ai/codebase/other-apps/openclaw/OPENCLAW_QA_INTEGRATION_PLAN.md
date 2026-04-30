---
memory_layer: durable_knowledge
para_section: pages/codebase/other-apps
gigabrain_tags: other-apps, codebase, integrations
documentation
openstinger_context: other-apps-practices
last_updated: 2026-03-21
related_docs:
  - codebase/other-apps/
  - disciplines/
---
# OpenClaw QA Integration Plan

## Executive Summary

This document provides a comprehensive plan for integrating OpenClaw with the Construct AI agent ecosystem for QA testing, with a focus on safe agent copying for UI/UX testing from a separate device.

---

## 🎯 PRIORITY PAGES FOR QA TESTING

### **HIGH PRIORITY: Pages 00435, 01700, 01900, and 02400**

Based on project requirements, the following four discipline pages have been designated as **highest priority** for QA testing integration:

#### **Page 00435: Contracts Post-Award**
**Description**: Contract management and administration after contract award

**Key Components**:
- Contract setup and configuration modals
- Working contractor details management
- Cloud document management (UpsertCloudModal)
- File management (UpsertFileModal)
- PDF/Image handling (UpsertPdfImageModal)
- Unstructured data processing (UpsertUnstructuredModal)
- URL document management (UpsertUrlModal)
- Correspondence reply system (CorrespondenceReplyModal)
- Meeting minutes management (MeetingMinutesModal)
- Minutes compilation (MinutesCompileModal)
- Correspondence input (CorrespondenceInputModal)
- Correspondence approval workflow (CorrespondenceApprovalModal)
- Enhanced HITL modal (EnhancedHITLModal)

**Specialized Agents**:
- Contractual correspondence reply agent
- Drawings analysis agent
- Orchestration integration testing
- Document analysis agent
- Document retrieval agent
- Domain specialist agent
- File processing agent

**Forms & Features**:
- Multi-stage correspondence workflow
- Drawing analysis orchestration
- Document vector management
- Contract state management

#### **Page 02400: Safety (HSE)**
**Description**: Health, Safety & Environment management including contractor vetting, inspections, and compliance

**Key Components**:
- Contractor vetting system (02400-contractor-vetting)
- Form completion system (02400-form-completion)
- Inspections management (02400-inspections)
- Safety document templates
- HSSE supplier evaluation
- Risk assessment modals
- Safety correspondence reply
- Image analysis for safety
- Video analysis for safety
- Workspace management
- Document upload services

**Specialized Agents**:
- Contractor vetting agent
- Safety image analysis agent
- Video analysis agent

**Forms Available**:
- Hazard Reporting Form
- HSSE Supplier/Contractor Evaluation Form
- Incident Investigation Form
- PPE Request Form
- Safety Inspection Report Form
- Safety Training Registration Form

**Integration Points**:
- Cross-page integration with 01850 (Other Parties/Contractor Vetting)
- External party evaluation system
- Safety performance metrics and KPIs
- Safety trends analysis

#### **Page 01900: Procurement**
**Description**: 19-stage SOW (Scope of Work) generation workflow for procurement orders

**Key Components**:
- Multi-stage SOW generation workflow
- Group and category selection
- Item specification input
- Destination country selection
- Value and requirements input
- Procurement type selection
- Timeline selection
- Order confirmation
- UI tab validation (SOW, Appendices A-F)
- Document generation and download

**Specialized Agents**:
- SOW generation agent
- Procurement workflow orchestrator
- Document compilation agent
- Appendix validation agents (A-F)

**Workflow Stages**:
1. Group Selection
2. Category Selection
3. Item Specification
4. Destination Country
5. Value Input
6. Requirements Input
7. Procurement Type
8. Timeline Selection
9. Order Confirmation
10-19. SOW Generation & Validation

**Integration Points**:
- Document generation system
- Supplier database integration
- Country-specific requirements
- Compliance validation

#### **Page 01700: Logistics**
**Description**: 5-stage logistics lifecycle for shipment management

**Key Components**:
- Shipment type selection
- Origin/destination specification
- Cargo type classification
- Carrier and vessel selection
- Container specifications
- Customs broker selection
- Insurance requirements
- Emergency contacts
- UI tab validation (Dashboard, CDC, Documents, Tracking, Compliance)
- Document generation and download

**Specialized Agents**:
- Logistics workflow agent
- CDC documentation agent
- Tracking integration agent
- Compliance validation agent

**Workflow Stages**:
1. Shipment Type Selection
2. Origin/Destination Specification
3. Cargo Classification
4. Carrier/Vessel Selection
5. Container Specifications
6. Customs Broker Selection
7. Insurance Requirements
8. Emergency Contacts
9. Document Generation
10. Tracking Setup

**Integration Points**:
- Carrier APIs
- Customs systems
- Insurance providers
- Tracking platforms
- CDC documentation system

---

### **Priority Testing Requirements for All 4 Priority Pages**

#### **Immediate Testing Focus**
1. **Modal System Testing**
   - All modal open/close functionality
   - Form validation within modals
   - Data persistence across modal interactions
   - Modal stacking and z-index management

2. **Document Management Testing**
   - Cloud document upload/management
   - File upload and processing
   - PDF/Image handling
   - URL document ingestion
   - Vector data management

3. **Agent Workflow Testing**
   - Contractual correspondence reply workflow
   - Drawing analysis orchestration
   - Contractor vetting process
   - Safety image/video analysis

4. **Form Completion Testing**
   - All safety forms (6 forms)
   - Form validation and submission
   - Data persistence
   - Form state management

5. **Cross-Page Integration Testing**
   - 00435 ↔ 01850 integration (Contractor management)
   - 02400 ↔ 01850 integration (Safety vetting)
   - Document sharing between pages
   - State synchronization

#### **QA Test Scenarios for Priority Pages**

**Page 00435 Test Scenarios**:
```yaml
- scenario: "Contract Setup Workflow"
  steps:
    - Navigate to 00435 page
    - Open ContractSetupModal
    - Fill contract details
    - Save and verify state
    - Close and reopen modal
    - Verify data persistence

- scenario: "Correspondence Reply System"
  steps:
    - Open CorrespondenceReplyModal
    - Select correspondence type
    - Enter reply content
    - Attach documents
    - Submit and verify
    - Check approval workflow

- scenario: "Drawing Analysis Orchestration"
  steps:
    - Open DrawingsAnalysisModal
    - Upload drawing files
    - Trigger analysis agents
    - Monitor orchestration progress
    - Review analysis results
    - Export findings
```

**Page 02400 Test Scenarios**:
```yaml
- scenario: "Contractor Vetting Process"
  steps:
    - Navigate to 02400 contractor vetting
    - Search for contractor
    - Open HSSEEvaluationModal
    - Complete evaluation form
    - Upload supporting documents
    - Submit evaluation
    - Verify status update

- scenario: "Safety Form Completion"
  steps:
    - Navigate to 02400 form completion
    - Select form type (Hazard/Incident/PPE/Training)
    - Fill required fields
    - Attach evidence
    - Submit form
    - Verify form stored correctly

- scenario: "Safety Image Analysis"
  steps:
    - Open SafetyImageAnalysisModal
    - Upload safety images
    - Trigger image analysis agent
    - Review analysis results
    - Generate safety report
    - Export findings
```

---

## Current Agent Inventory for QA

### 1. UI Integration Testing Agent (Primary QA Agent)
**Location**: `deep-agents/deep_agents/agents/shared/ui_integration_testing_agent.py`

**Capabilities**:
- ✅ Browser automation with Playwright (Chrome, Firefox, Safari)
- ✅ Complete workflow testing (01900 Procurement, 01700 Logistics)
- ✅ UI tab validation and navigation testing
- ✅ Document download validation
- ✅ Performance monitoring and metrics
- ✅ Screenshot capture on failures
- ✅ Cross-workflow integration testing
- ✅ Automated test report generation

**Supported Workflows**:
- 01900 Procurement Order Creation (19-stage SOW workflow)
- 01700 Logistics Document Generator (5-stage logistics lifecycle)
- **00435 Contracts Post-Award** (Priority)
- **02400 Safety/HSE** (Priority)

### 2. Testing Dashboard Integration Agent
**Location**: `deep-agents/deep_agents/agents/shared/ai_it_specialists/a_0230_testing_dashboard_integration.py`

**Capabilities**:
- ✅ Test discovery and metadata extraction
- ✅ SSE streaming for real-time test results
- ✅ Error classification (syntax, import, type, reserved_word, assertion)
- ✅ Automated source code modification with backup
- ✅ Human approval workflow for production changes
- ✅ Test history tracking and pattern analysis

### 3. Document Compilation Tester Agent
**Location**: `deep-agents/deep_agents/agents/shared/ai_it_specialists/a_0220_document_compilation_tester.py`

**Capabilities**:
- ✅ SOW document validation
- ✅ Appendix A-F completeness testing
- ✅ Import/Export documentation verification
- ✅ CDC documentation validation for Guinea orders
- ✅ Document package completeness scoring

### 4. Discipline IT Specialists (47 Agents)
**Location**: `deep-agents/deep_agents/agents/shared/discipline_it_specialists/`

**Coverage**: All 47 discipline pages with dedicated IT specialists

---

## Safe Agent Copying Strategy

### Option 1: Git Worktree Approach (Recommended)
Create a separate worktree for QA testing to isolate changes:

```bash
# Create a QA-specific worktree
git worktree add ../construct_ai_qa qa-testing-branch

# Copy only agent files to QA worktree
cp -r deep-agents/deep_agents/agents/shared ../construct_ai_qa/deep-agents/deep_agents/
cp -r deep-agents/deep_agents/agents/pages/01900_procurement ../construct_ai_qa/deep-agents/deep_agents/agents/pages/
cp -r deep-agents/deep_agents/agents/pages/01700_logistics ../construct_ai_qa/deep-agents/deep_agents/agents/pages/
cp -r deep-agents/deep_agents/agents/pages/00435_contracts_post_award ../construct_ai_qa/deep-agents/deep_agents/agents/pages/
cp -r deep-agents/deep_agents/agents/pages/02400_safety ../construct_ai_qa/deep-agents/deep_agents/agents/pages/
```

**Benefits**:
- ✅ Isolated testing environment
- ✅ No risk to production code
- ✅ Easy to sync changes back
- ✅ Version controlled

### Option 2: Docker Container Approach
Create a Docker container with agent code for portable testing:

```dockerfile
# Dockerfile.qa
FROM python:3.9-slim

WORKDIR /app

# Copy agent code
COPY deep-agents/ /app/deep-agents/
COPY requirements.txt /app/

# Install dependencies
RUN pip install -r requirements.txt
RUN playwright install chromium

# Copy test configuration
COPY qa_config.json /app/

CMD ["python", "-m", "deep_agents.agents.shared.ui_integration_testing_agent"]
```

**Benefits**:
- ✅ Complete isolation
- ✅ Portable across devices
- ✅ Consistent environment
- ✅ Easy to distribute

### Option 3: Agent Export/Import Package
Create a self-contained agent package:

```bash
# Create QA agent package
mkdir -p qa_agents_package/{agents,config,tests,scripts}

# Copy essential agents
cp deep-agents/deep_agents/agents/shared/ui_integration_testing_agent.py qa_agents_package/agents/
cp deep-agents/deep_agents/agents/shared/ai_it_specialists/*.py qa_agents_package/agents/

# Create configuration
cat > qa_agents_package/config/qa_config.json << 'EOF'
{
  "base_url": "http://localhost:3000",
  "browser": "chromium",
  "headless": false,
  "workflows_to_test": ["01900_procurement", "01700_logistics", "00435_contracts_post_award", "02400_safety"],
  "priority_pages": ["00435", "01700", "01900", "02400"],
  "downloads_enabled": true,
  "screenshots": {
    "on_failure": true,
    "directory": "./qa_screenshots"
  }
}
EOF

# Create run script
cat > qa_agents_package/scripts/run_qa_tests.sh << 'EOF'
#!/bin/bash
cd "$(dirname "$..")"
python -m agents.ui_integration_testing_agent
EOF
```

---

## OpenClaw Integration Architecture

### 1. Agent Registration with OpenClaw

Create an OpenClaw configuration file for agent discovery:

```json
{
  "openclaw": {
    "version": "1.0.0",
    "agents": {
      "ui_integration_testing": {
        "path": "deep-agents/deep_agents/agents/shared/ui_integration_testing_agent.py",
        "type": "qa_testing",
        "capabilities": ["browser_automation", "ui_testing", "workflow_validation"],
        "workflows": ["01900_procurement", "01700_logistics", "00435_contracts_post_award", "02400_safety"],
        "priority": "high",
        "priority_pages": ["00435", "01700", "01900", "02400"]
      },
      "testing_dashboard_integration": {
        "path": "deep-agents/deep_agents/agents/shared/ai_it_specialists/a_0230_testing_dashboard_integration.py",
        "type": "test_management",
        "capabilities": ["test_discovery", "result_streaming", "error_classification"],
        "priority": "medium"
      },
      "document_compilation_tester": {
        "path": "deep-agents/deep_agents/agents/shared/ai_it_specialists/a_0220_document_compilation_tester.py",
        "type": "document_validation",
        "capabilities": ["sow_validation", "appendix_testing", "compliance_checking"],
        "priority": "medium"
      }
    },
    "testing": {
      "parallel_execution": false,
      "max_retries": 3,
      "timeout_seconds": 300,
      "report_format": ["json", "markdown"],
      "screenshot_on_failure": true,
      "priority_pages": ["00435", "01700", "01900", "02400"]
    }
  }
}
```

### 2. OpenClaw Agent Wrapper

Create a wrapper for OpenClaw compatibility:

```python
# openclaw_qa_agent.py
"""
OpenClaw-compatible wrapper for Construct AI QA agents
"""

import asyncio
import json
from typing import Dict, Any, List
from deep_agents.agents.shared.ui_integration_testing_agent import UIIntegrationTestingAgent

class OpenClawQAAgent:
    """OpenClaw-compatible QA agent wrapper"""
    
    def __init__(self, config_path: str = "openclaw_config.json"):
        with open(config_path, 'r') as f:
            self.config = json.load(f)
        
        self.agents = {
            "ui_testing": UIIntegrationTestingAgent(
                self.config["openclaw"]["agents"]["ui_integration_testing"]
            )
        }
        
        # Priority pages for focused testing
        self.priority_pages = self.config["openclaw"]["testing"].get("priority_pages", ["00435", "01700", "01900", "02400"])
    
    async def execute_qa_task(self, task: Dict[str, Any]) -> Dict[str, Any]:
        """
        Execute QA task via OpenClaw interface
        
        Args:
            task: {
                "type": "ui_integration_test",
                "workflows": ["01900_procurement"],
                "priority_pages": ["00435", "01700", "01900", "02400"],
                "scenarios": [...],
                "config": {...}
            }
        
        Returns:
            Test results in OpenClaw format
        """
        task_type = task.get("type", "ui_integration_test")
        
        if task_type == "ui_integration_test":
            return await self._execute_ui_tests(task)
        elif task_type == "document_validation":
            return await self._execute_document_validation(task)
        elif task_type == "priority_pages_test":
            return await self._execute_priority_pages_test(task)
        else:
            raise ValueError(f"Unsupported task type: {task_type}")
    
    async def _execute_ui_tests(self, task: Dict[str, Any]) -> Dict[str, Any]:
        """Execute UI integration tests"""
        agent = self.agents["ui_testing"]
        
        test_config = {
            "workflows": task.get("workflows", ["01900_procurement", "01700_logistics"]),
            "scenarios": task.get("scenarios", []),
            "generate_reports": True
        }
        
        async with agent:
            results = await agent.execute_ui_tests(test_config)
            
            # Format for OpenClaw
            return {
                "status": "completed",
                "agent": "ui_integration_testing",
                "results": results,
                "artifacts": {
                    "report": "ui_integration_test_report.json",
                    "summary": "ui_integration_test_summary.md",
                    "screenshots": "./ui_test_screenshots/"
                }
            }
    
    async def _execute_priority_pages_test(self, task: Dict[str, Any]) -> Dict[str, Any]:
        """Execute tests specifically for priority pages 00435 and 02400"""
        agent = self.agents["ui_testing"]
        
        priority_pages = task.get("priority_pages", self.priority_pages)
        
        test_config = {
            "workflows": [f"{page}_workflow" for page in priority_pages],
            "scenarios": task.get("scenarios", []),
            "generate_reports": True,
            "focus": "priority_pages"
        }
        
        async with agent:
            results = await agent.execute_ui_tests(test_config)
            
            return {
                "status": "completed",
                "agent": "ui_integration_testing",
                "focus": "priority_pages_00435_02400",
                "results": results,
                "artifacts": {
                    "report": "priority_pages_test_report.json",
                    "summary": "priority_pages_test_summary.md",
                    "screenshots": "./priority_pages_screenshots/"
                }
            }
    
    def get_capabilities(self) -> Dict[str, Any]:
        """Return agent capabilities for OpenClaw discovery"""
        return {
            "agent_name": "construct_ai_qa",
            "version": "1.0.0",
            "capabilities": [
                "ui_integration_testing",
                "workflow_validation",
                "document_validation",
                "performance_monitoring",
                "screenshot_capture",
                "priority_pages_testing"
            ],
            "supported_workflows": [
                "01900_procurement",
                "01700_logistics",
                "00435_contracts_post_award",
                "02400_safety"
            ],
            "priority_pages": self.priority_pages,
            "test_types": [
                "end_to_end",
                "ui_navigation",
                "document_generation",
                "cross_workflow",
                "priority_pages_test"
            ]
        }

# OpenClaw entry point
async def openclaw_entry(task: Dict[str, Any]) -> Dict[str, Any]:
    """OpenClaw entry point for QA tasks"""
    agent = OpenClawQAAgent()
    return await agent.execute_qa_task(task)
```

---

## Recommended QA Workflow

### Phase 1: Environment Setup
1. **Create QA Branch**
   ```bash
   git checkout -b qa-testing-branch
   ```

2. **Install Dependencies**
   ```bash
   pip install playwright
   playwright install chromium
   ```

3. **Configure Test Environment**
   ```bash
   cp .env.example .env.qa
   # Edit .env.qa with QA-specific settings
   ```

### Phase 2: Agent Copying (Safe Approach)
1. **Export Agent Package**
   ```bash
   python scripts/export_qa_agents.py --output ./qa_package/
   ```

2. **Transfer to Test Device**
   ```bash
   scp -r ./qa_package/ user@test-device:/path/to/qa/
   ```

3. **Import on Test Device**
   ```bash
   cd /path/to/qa/
   python scripts/import_qa_agents.py
   ```

### Phase 3: OpenClaw Integration
1. **Register Agents with OpenClaw**
   ```bash
   openclaw register-agent --config openclaw_config.json
   ```

2. **Verify Agent Discovery**
   ```bash
   openclaw list-agents --type qa_testing
   ```

3. **Execute Test Suite**
   ```bash
   openclaw run-task --agent ui_integration_testing --config test_config.json
   ```

### Phase 4: Test Execution (Priority Pages First)
1. **Run Priority Pages Tests**
   ```python
   from openclaw_qa_agent import OpenClawQAAgent
   
   agent = OpenClawQAAgent()
   
   # Test priority pages 00435, 01700, 01900, and 02400
   results = await agent.execute_qa_task({
       "type": "priority_pages_test",
       "priority_pages": ["00435", "01700", "01900", "02400"],
       "config": {
           "headless": False,
           "slow_mo": 1000,
           "screenshots_on_failure": True
       }
   })
   ```

2. **Run Full Test Suite**
   ```python
   results = await agent.execute_qa_task({
       "type": "ui_integration_test",
       "workflows": ["01900_procurement", "01700_logistics", "00435_contracts_post_award", "02400_safety"],
       "config": {
           "headless": False,
           "slow_mo": 1000,
           "screenshots_on_failure": True
       }
   })
   ```

3. **Review Results**
   - Check `priority_pages_test_report.json` for priority page results
   - Check `ui_integration_test_report.json` for full test results
   - Review summaries for human-readable reports
   - Examine screenshots in `./priority_pages_screenshots/` and `./ui_test_screenshots/`

---

## Agents Most Suitable for QA Tasks

### High Priority (Immediate Use)
1. **UI Integration Testing Agent** - Primary QA agent for browser automation
2. **Testing Dashboard Integration Agent** - Test management and reporting
3. **Document Compilation Tester Agent** - Document validation

### Medium Priority (Extended Testing)
4. **Data Quality Validator Agent** - Data validation testing
5. **Performance Monitor Agent** - Performance testing
6. **Compliance Checker Agent** - Compliance validation

### Low Priority (Specialized Testing)
7. **47 Discipline IT Specialists** - Discipline-specific testing
8. **Session Recovery Agent** - Session persistence testing

---

## Safety Considerations

### 1. Data Isolation
- ✅ Use separate database for QA testing
- ✅ Mock external API calls
- ✅ Use test data only (no production data)

### 2. Network Isolation
- ✅ Run on isolated network segment
- ✅ Block external API calls in test mode
- ✅ Use local mock services

### 3. Code Isolation
- ✅ Never run QA agents against production
- ✅ Use feature flags for test mode
- ✅ Implement circuit breakers

### 4. Access Control
- ✅ Separate credentials for QA environment
- ✅ Read-only access to production data (if needed)
- ✅ Audit logging for all QA activities

---

## Implementation Checklist

### Immediate Actions (Week 1) - PRIORITY PAGES FOCUS
- [ ] Create QA branch and worktree
- [ ] Export UI Integration Testing Agent
- [ ] Set up test environment configuration
- [ ] Create OpenClaw wrapper with priority pages support
- [ ] Test agent copying process
- [ ] **Create test scenarios for Page 00435 (Contracts Post-Award)**
- [ ] **Create test scenarios for Page 02400 (Safety/HSE)**
- [ ] **Validate modal systems on both priority pages**
- [ ] **Test document management workflows on 00435**
- [ ] **Test form completion systems on 02400**

### Short-term Actions (Week 2-3)
- [ ] Integrate with OpenClaw
- [ ] Create automated test suite for priority pages
- [ ] Set up CI/CD pipeline for QA
- [ ] Document testing procedures
- [ ] **Test cross-page integration (00435 ↔ 01850, 02400 ↔ 01850)**
- [ ] **Validate agent workflows on priority pages**

### Long-term Actions (Month 1-2)
- [ ] Expand to all 47 discipline specialists
- [ ] Implement parallel test execution
- [ ] Add visual regression testing
- [ ] Create performance benchmarking

---

## Expected Outcomes

### Immediate Benefits
- ✅ Safe testing environment isolated from production
- ✅ Automated UI/UX testing capabilities
- ✅ Comprehensive test reporting
- ✅ Screenshot capture for debugging
- ✅ **Focused testing on priority pages 00435 and 02400**

### Long-term Benefits
- ✅ Reduced manual testing effort
- ✅ Faster feedback loops
- ✅ Improved code quality
- ✅ Better compliance validation
- ✅ **Comprehensive coverage of critical contract and safety workflows**

---

## Support and Maintenance

### Monitoring
- Track test execution times
- Monitor failure rates
- Review screenshot captures
- Analyze performance metrics

### Updates
- Keep Playwright updated
- Update UI selectors as needed
- Add new test scenarios
- Expand workflow coverage

### Troubleshooting
- Check browser compatibility
- Verify network connectivity
- Review application logs
- Examine test artifacts

---

**Created**: March 12, 2026
**Updated**: March 13, 2026 - Added Priority Pages 00435 and 02400
**Version**: 1.1.0
**Status**: Ready for Implementation