---
title: Civil Engineering Modal Implementation Guide
author: Construct AI Memory System Team
date: 2026-03-28
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, modal-implementation, technical-guide, agent-integration, document-control, approval-workflow, code-examples
openstinger_context: modal-implementation, workflow-integration, agent-coordination, document-management, approval-system
last_updated: 2026-03-28
related_docs:
  - disciplines/00850_civil-engineering/workflow_docs/00850_CIVIL_ENGINEERING_MODAL_REDESIGN_SPECIFICATION.md
  - disciplines/00850_civil-engineering/workflow_docs/00850_0_CIVIL_ENGINEERING_DESIGN_WORKFLOW.MD
  - superpowers/docs_qualityforge_ai/agents/coding/architect/persona.md
  - superpowers/docs_loopy_ai/README.md
---

# 00850 Civil Engineering Modal Implementation Guide

**Status:** Implementation Ready
**Priority:** Critical
**Audience:** Development Team

## Executive Summary

This implementation guide provides the complete technical specifications and code examples for transforming the Civil Engineering modal from a non-functional overlay into a professional, fully-integrated workflow system. The guide covers all aspects of the implementation including component architecture, agent integration, document control, and approval workflows.

## Current Issues Addressed

### Functional Problems
- **Non-Functional Buttons**: All 13 workflow cards now have working button handlers
- **Missing State Management**: Complete workflow state management with persistence
- **No Agent Integration**: Full multi-agent coordination system
- **Broken Document Flow**: Seamless 00900 document control integration
- **Missing Approvals**: Complete multi-level approval workflow

### Design Problems
- **Amateurish Appearance**: Professional Civil Engineering theme implementation
- **Poor User Experience**: Intuitive card interactions and feedback
- **Accessibility Issues**: Full WCAG 2.1 AA compliance
- **Mobile Experience**: Responsive design for all screen sizes

## Implementation Architecture

### Component Hierarchy
```
client/src/components/modals/CivilEngineeringModal/
├── CivilEngineeringModal.jsx          # Main container with state management
├── components/
│   ├── WorkflowCard.jsx              # Individual card component
│   ├── ModalHeader.jsx              # Header with filters and controls
│   ├── ProgressDashboard.jsx        # 13/13 completion tracking
│   ├── AgentStatusPanel.jsx         # Real-time agent updates
│   └── ApprovalQueue.jsx            # Pending approvals display
├── hooks/
│   ├── useWorkflowState.js          # Complete state management
│   ├── useAgentCoordination.js      # Multi-agent integration
│   ├── useDocumentControl.js        # 00900 system integration
│   └── useApprovalWorkflow.js       # Sign-off system
├── services/
│   ├── workflowEngine.js            # Card dependencies & logic
│   ├── agentRouter.js               # Task distribution system
│   ├── documentService.js           # 00900 API client
│   └── approvalService.js           # Sign-off orchestration
├── styles/
│   ├── modal.css                    # Professional styling
│   ├── cards.css                    # Card-specific styles
│   ├── animations.css               # Smooth transitions
│   ├── responsive.css               # Mobile/desktop variants
│   └── themes.css                   # Civil Engineering theme
└── utils/
    ├── constants.js                 # Workflow configuration
    ├── validators.js                # Input validation
    └── formatters.js                # Data presentation
```

## Phase 1: Core Infrastructure Implementation

### 1.1 Enhanced Modal Component

**File**: `client/src/components/modals/CivilEngineeringModal/CivilEngineeringModal.jsx`

```javascript
import React, { useState, useMemo } from 'react';
import { useWorkflowState } from './hooks/useWorkflowState';
import { useAgentCoordination } from './hooks/useAgentCoordination';
import { useApprovalWorkflow } from './hooks/useApprovalWorkflow';
import { useDocumentControl } from './hooks/useDocumentControl';
import ModalHeader from './components/ModalHeader';
import WorkflowGrid from './components/WorkflowGrid';
import ModalFooter from './components/ModalFooter';

const CivilEngineeringModal = ({ isOpen, onClose, projectId }) => {
  // Filter state for the 13 cards
  const [activeFilters, setActiveFilters] = useState({
    phase: 'all',      // all, site-assessment, conceptual-design, preliminary-design, detailed-design, procurement-support
    status: 'all',     // all, available, in-progress, review, approved, locked, rejected
    search: ''         // Text search across card titles
  });

  // Custom hooks for full functionality
  const workflowState = useWorkflowState(projectId);
  const { coordinateAgents } = useAgentCoordination();
  const { submitForApproval } = useApprovalWorkflow();
  const { loadDocument, downloadTemplates } = useDocumentControl();

  // Filter cards based on active filters
  const filteredCards = useMemo(() => {
    return workflowState.cards.filter(card => {
      const phaseMatch = activeFilters.phase === 'all' || card.phase === activeFilters.phase;
      const statusMatch = activeFilters.status === 'all' || card.status === activeFilters.status;
      const searchMatch = !activeFilters.search ||
        card.title.toLowerCase().includes(activeFilters.search.toLowerCase());

      return phaseMatch && statusMatch && searchMatch;
    });
  }, [workflowState.cards, activeFilters]);

  // Handle all card button actions
  const handleCardAction = async (cardId, action, params = {}) => {
    const card = workflowState.cards.find(c => c.id === cardId);
    if (!card) return;

    try {
      workflowState.setLoading(true);

      switch (action) {
        case 'assign':
          // Assign user or AI agent to card
          await coordinateAgents('assign', {
            cardId,
            agentType: determineAgentType(card.type),
            userId: params.userId
          });
          await workflowState.updateCardStatus(cardId, 'in-progress');
          break;

        case 'complete':
          // Submit for approval and move to review
          await submitForApproval(cardId, card.outputs);
          await workflowState.updateCardStatus(cardId, 'review');
          break;

        case 'view':
          // Load and display card details
          const details = await loadDocument(card.documentRefs);
          openCardDetailModal(card, details);
          break;

        case 'download':
          // Download templates and resources
          await downloadTemplates(card.templates);
          break;

        case 'approve':
          // Handle approval actions (for approvers)
          await handleApproval(cardId, params.decision, params.comments);
          break;

        default:
          console.warn(`Unknown action: ${action}`);
      }

      // Show success feedback
      showNotification(`${action} completed successfully`, 'success');

    } catch (error) {
      console.error(`Failed to ${action} card:`, error);
      showNotification(`Failed to ${action} card: ${error.message}`, 'error');
      workflowState.setError(error.message);
    } finally {
      workflowState.setLoading(false);
    }
  };

  // Calculate progress for header display
  const progress = useMemo(() => {
    const total = workflowState.cards.length;
    const completed = workflowState.cards.filter(c => c.status === 'approved').length;
    return {
      current: completed,
      total,
      percentage: total > 0 ? (completed / total) * 100 : 0
    };
  }, [workflowState.cards]);

  // Quick actions for modal footer
  const handleQuickAction = async (action) => {
    try {
      switch (action) {
        case 'save':
          await workflowState.saveToVFS();
          showNotification('Workflow saved successfully', 'success');
          break;
        case 'reset':
          if (confirm('Are you sure you want to reset the workflow? This will lose all progress.')) {
            await workflowState.resetWorkflow();
            showNotification('Workflow reset successfully', 'info');
          }
          break;
        case 'export':
          const data = await workflowState.exportWorkflow();
          downloadFile(data, `civil-engineering-workflow-${projectId}.json`);
          showNotification('Workflow exported successfully', 'success');
          break;
      }
    } catch (error) {
      showNotification(`Failed to ${action}: ${error.message}`, 'error');
    }
  };

  if (!isOpen) return null;

  return (
    <Modal
      isOpen={isOpen}
      onClose={onClose}
      className="civil-engineering-modal"
      size="large"
    >
      <ModalHeader
        title="Civil Engineering Workflow System"
        subtitle="13-Card Professional Workflow Management"
        filters={activeFilters}
        onFilterChange={setActiveFilters}
        progress={progress}
        onClose={onClose}
      />

      <ModalContent>
        {workflowState.error && (
          <ErrorBanner
            message={workflowState.error}
            onDismiss={() => workflowState.clearError()}
          />
        )}

        {workflowState.isLoading && <LoadingSpinner />}

        <WorkflowGrid
          cards={filteredCards}
          onCardAction={handleCardAction}
          workflowState={workflowState}
        />
      </ModalContent>

      <ModalFooter>
        <QuickActions
          onSave={() => handleQuickAction('save')}
          onReset={() => handleQuickAction('reset')}
          onExport={() => handleQuickAction('export')}
          onHelp={() => openHelpModal()}
        />
      </ModalFooter>
    </Modal>
  );
};

export default CivilEngineeringModal;
```

### 1.2 Workflow Engine Service

**File**: `client/src/components/modals/CivilEngineeringModal/services/workflowEngine.js`

```javascript
export class WorkflowEngine {
  constructor(projectId) {
    this.projectId = projectId;
    this.cardDefinitions = this.getCardDefinitions();
    this.dependencyGraph = this.buildDependencyGraph();
  }

  // Define all 13 workflow cards with their properties
  getCardDefinitions() {
    return [
      // Phase 1: Site Assessment (4 cards)
      {
        id: `${this.projectId}-project-brief`,
        type: 'project-brief',
        title: 'Project Brief',
        phase: 'site-assessment',
        dependencies: [],
        inputs: ['Client Requirements', 'Scope Documents'],
        outputs: ['Approved Brief'],
        agent: 'Content Analysis Agent',
        approver: 'Project Manager',
        templates: ['civil-engineering-brief-template'],
        estimatedHours: 8
      },
      {
        id: `${this.projectId}-site-survey`,
        type: 'site-survey',
        title: 'Site Survey',
        phase: 'site-assessment',
        dependencies: [`${this.projectId}-project-brief`],
        inputs: ['Topographic Data', 'Utility Maps'],
        outputs: ['Survey Report'],
        agent: 'GIS Processing Agent',
        approver: 'Technical Lead',
        templates: ['survey-report-template'],
        estimatedHours: 16
      },
      {
        id: `${this.projectId}-geotechnical`,
        type: 'geotechnical',
        title: 'Geotechnical Analysis',
        phase: 'site-assessment',
        dependencies: [`${this.projectId}-site-survey`],
        inputs: ['Soil Reports', 'Borehole Data'],
        outputs: ['Foundation Recommendations'],
        agent: 'Analysis Agent',
        approver: 'Geotech Engineer',
        templates: ['geotechnical-report-template'],
        estimatedHours: 24
      },
      {
        id: `${this.projectId}-environmental`,
        type: 'environmental',
        title: 'Environmental Assessment',
        phase: 'site-assessment',
        dependencies: [`${this.projectId}-site-survey`],
        inputs: ['EIA Reports', 'Permits'],
        outputs: ['Environmental Constraints'],
        agent: 'Compliance Agent',
        approver: 'Env Specialist',
        templates: ['environmental-assessment-template'],
        estimatedHours: 12
      },

      // Phase 2: Conceptual Design (2 cards)
      {
        id: `${this.projectId}-design-options`,
        type: 'design-options',
        title: 'Design Options Analysis',
        phase: 'conceptual-design',
        dependencies: [`${this.projectId}-geotechnical`, `${this.projectId}-environmental`],
        inputs: ['Site Constraints', 'Client Preferences', 'Budget Parameters'],
        outputs: ['Options Matrix'],
        agent: 'Options Analysis Agent',
        approver: 'Design Team',
        templates: ['design-options-template'],
        estimatedHours: 20
      },
      {
        id: `${this.projectId}-preliminary-layout`,
        type: 'preliminary-layout',
        title: 'Preliminary Layout',
        phase: 'conceptual-design',
        dependencies: [`${this.projectId}-design-options`],
        inputs: ['Selected Option', 'Alignment Data', 'Mass Balance Req'],
        outputs: ['Layout Drawings'],
        agents: ['CAD Agent', 'GIS Agent', 'Analysis Agent'],
        approver: 'Senior Engineer',
        templates: ['layout-drawings-template'],
        estimatedHours: 32
      },

      // Phase 3: Preliminary Design (2 cards)
      {
        id: `${this.projectId}-calculations`,
        type: 'calculations',
        title: 'Engineering Calculations',
        phase: 'preliminary-design',
        dependencies: [`${this.projectId}-preliminary-layout`],
        inputs: ['Layout Drawings', 'Load Requirements', 'Material Properties'],
        outputs: ['Calculation Package'],
        agents: ['Structural Analysis Agent', 'Hydraulic Analysis Agent', 'Geotech Analysis Agent'],
        approver: 'Technical Lead',
        templates: ['calculation-package-template'],
        estimatedHours: 40
      },
      {
        id: `${this.projectId}-preliminary-drawings`,
        type: 'preliminary-drawings',
        title: 'Preliminary Drawings',
        phase: 'preliminary-design',
        dependencies: [`${this.projectId}-calculations`],
        inputs: ['Calculation Results', 'Standards & Codes', 'Coordination Req'],
        outputs: ['Drawing Set'],
        agents: ['CAD Agent', 'BIM Agent', 'Clash Detection Agent'],
        approver: 'Drawing Office',
        templates: ['preliminary-drawings-template'],
        estimatedHours: 48
      },

      // Phase 4: Detailed Design (4 cards)
      {
        id: `${this.projectId}-construction-drawings`,
        type: 'construction-drawings',
        title: 'Construction Drawings',
        phase: 'detailed-design',
        dependencies: [`${this.projectId}-preliminary-drawings`],
        inputs: ['Preliminary Drawings', 'Construction Details', 'Revision Control'],
        outputs: ['Full Drawing Set'],
        agents: ['CAD Agent', 'Standards Agent', 'Quality Agent'],
        approver: 'Chief Engineer',
        templates: ['construction-drawings-template'],
        estimatedHours: 80
      },
      {
        id: `${this.projectId}-specifications`,
        type: 'specifications',
        title: 'Technical Specifications',
        phase: 'detailed-design',
        dependencies: [`${this.projectId}-calculations`],
        inputs: ['Material Standards', 'Quality Requirements', 'Regulatory Specs'],
        outputs: ['Spec Document'],
        agents: ['Content Agent', 'Compliance Agent', 'Standards Agent'],
        approver: 'Technical Lead',
        templates: ['specifications-template'],
        estimatedHours: 32
      },
      {
        id: `${this.projectId}-quantity-schedules`,
        type: 'quantity-schedules',
        title: 'Quantity Schedules',
        phase: 'detailed-design',
        dependencies: [`${this.projectId}-construction-drawings`],
        inputs: ['Construction Drawings', 'Material Take-offs', 'Unit Rates'],
        outputs: ['BOQ Excel'],
        agents: ['Quantity Agent', 'Cost Agent', 'Validation Agent'],
        approver: 'Quantity Surveyor',
        templates: ['boq-template'],
        estimatedHours: 24
      },
      {
        id: `${this.projectId}-inspection-plans`,
        type: 'inspection-plans',
        title: 'Inspection & Test Plans',
        phase: 'detailed-design',
        dependencies: [`${this.projectId}-specifications`],
        inputs: ['Specifications', 'Quality Standards', 'Regulatory Requirements'],
        outputs: ['ITP Document'],
        agents: ['Quality Agent', 'Compliance Agent', 'Documentation Agent'],
        approver: 'QA Manager',
        templates: ['itp-template'],
        estimatedHours: 16
      },

      // Phase 5: Procurement & Construction (2 cards)
      {
        id: `${this.projectId}-tender-documents`,
        type: 'tender-documents',
        title: 'Tender Documents',
        phase: 'procurement-support',
        dependencies: [
          `${this.projectId}-construction-drawings`,
          `${this.projectId}-specifications`,
          `${this.projectId}-quantity-schedules`,
          `${this.projectId}-inspection-plans`
        ],
        inputs: ['All Phase 4 Outputs', 'Procurement Requirements', 'Compliance Matrices'],
        outputs: ['Tender Package'],
        agents: ['Documentation Agent', 'Compliance Agent', 'Quality Agent'],
        approver: 'Procurement Lead',
        templates: ['tender-package-template'],
        estimatedHours: 24
      },
      {
        id: `${this.projectId}-construction-support`,
        type: 'construction-support',
        title: 'Construction Support',
        phase: 'procurement-support',
        dependencies: [`${this.projectId}-tender-documents`],
        inputs: ['Tender Package', 'Construction Queries', 'Variation Requests'],
        outputs: ['Construction Docs'],
        agents: ['Support Agent', 'Variation Agent', 'Documentation Agent'],
        approver: 'Project Director',
        templates: ['construction-docs-template'],
        estimatedHours: 160
      }
    ];
  }

  // Build dependency graph for workflow validation
  buildDependencyGraph() {
    const graph = new Map();

    this.cardDefinitions.forEach(card => {
      graph.set(card.id, {
        dependencies: card.dependencies,
        dependents: []
      });
    });

    // Build reverse dependencies
    this.cardDefinitions.forEach(card => {
      card.dependencies.forEach(depId => {
        if (graph.has(depId)) {
          graph.get(depId).dependents.push(card.id);
        }
      });
    });

    return graph;
  }

  // Calculate initial card status based on dependencies
  calculateInitialStatus(card) {
    if (card.dependencies.length === 0) {
      return 'available'; // No dependencies = available
    }

    // Check if all dependencies are completed (for loading existing workflows)
    // This would be enhanced with actual workflow state loading
    return 'locked';
  }

  // Validate state transitions
  canTransition(card, newStatus) {
    const currentStatus = card.status;
    const allowedTransitions = {
      'locked': ['available'],
      'available': ['in-progress', 'locked'],
      'in-progress': ['review', 'available'],
      'review': ['approved', 'rejected', 'in-progress'],
      'approved': ['completed'],
      'rejected': ['in-progress'],
      'completed': []
    };

    return allowedTransitions[currentStatus]?.includes(newStatus) || false;
  }

  // Update card and cascade effects to dependent cards
  updateCard(cardId, updates) {
    const card = this.getCardById(cardId);
    const updatedCard = { ...card, ...updates, updatedAt: new Date() };

    // Validate status transition
    if (updates.status && !this.canTransition(card, updates.status)) {
      throw new Error(`Invalid status transition: ${card.status} -> ${updates.status}`);
    }

    // Update timestamps
    if (updates.status === 'in-progress' && !card.startedAt) {
      updatedCard.startedAt = new Date();
    }
    if (updates.status === 'completed' && !card.completedAt) {
      updatedCard.completedAt = new Date();
    }

    // Cascade to dependent cards
    this.updateDependentCards(cardId, updates);

    return updatedCard;
  }

  // Handle dependency chain updates
  updateDependentCards(cardId, updates) {
    const dependents = this.dependencyGraph.get(cardId)?.dependents || [];

    dependents.forEach(depId => {
      const depCard = this.getCardById(depId);

      if (updates.status === 'completed') {
        // Check if all dependencies are now complete
        const allDepsComplete = depCard.dependencies.every(depId => {
          const dep = this.getCardById(depId);
          return dep.status === 'completed';
        });

        if (allDepsComplete && depCard.status === 'locked') {
          // Unlock dependent card
          this.updateCard(depId, { status: 'available' });
        }
      }
    });
  }

  // Get card by ID
  getCardById(cardId) {
    return this.cardDefinitions.find(card => card.id === cardId);
  }

  // Get all cards for a phase
  getCardsByPhase(phase) {
    return this.cardDefinitions.filter(card => card.phase === phase);
  }

  // Validate entire workflow state
  validateWorkflowState(cards) {
    const errors = [];

    cards.forEach(card => {
      // Check dependency satisfaction
      const unsatisfiedDeps = card.dependencies.filter(depId => {
        const depCard = cards.find(c => c.id === depId);
        return !depCard || depCard.status !== 'completed';
      });

      if (unsatisfiedDeps.length > 0 && card.status !== 'locked') {
        errors.push(`${card.title} has unsatisfied dependencies: ${unsatisfiedDeps.join(', ')}`);
      }

      // Check status validity
      if (!['locked', 'available', 'in-progress', 'review', 'approved', 'rejected', 'completed'].includes(card.status)) {
        errors.push(`${card.title} has invalid status: ${card.status}`);
      }
    });

    return errors;
  }
}
```

## Phase 2: Agent Integration Implementation

### 2.1 Agent Coordination Hook

**File**: `client/src/components/modals/CivilEngineeringModal/hooks/useAgentCoordination.js`

```javascript
import { useState, useCallback } from 'react';
import { agentRouter } from '../services/agentRouter';

export const useAgentCoordination = () => {
  const [activeAgents, setActiveAgents] = useState(new Map());
  const [agentHistory, setAgentHistory] = useState([]);

  // Determine appropriate agent type based on card type and action
  const determineAgentType = useCallback((cardType, action) => {
    const agentMappings = {
      // Site Assessment Agents
      'project-brief': 'content',
      'site-survey': 'gis',
      'geotechnical': 'analysis',
      'environmental': 'compliance',

      // Conceptual Design Agents
      'design-options': 'analysis',
      'preliminary-layout': ['cad', 'gis', 'analysis'], // Multiple agents

      // Preliminary Design Agents
      'calculations': ['structural', 'hydraulic', 'geotechnical'],
      'preliminary-drawings': ['cad', 'bim', 'clash-detection'],

      // Detailed Design Agents
      'construction-drawings': ['cad', 'standards', 'quality'],
      'specifications': ['content', 'compliance', 'standards'],
      'quantity-schedules': ['quantity', 'cost', 'validation'],
      'inspection-plans': ['quality', 'compliance', 'documentation'],

      // Procurement Agents
      'tender-documents': ['documentation', 'compliance', 'quality'],
      'construction-support': ['support', 'variation', 'documentation']
    };

    return agentMappings[cardType] || 'content'; // Default fallback
  }, []);

  // Coordinate agent execution
  const coordinateAgents = useCallback(async (action, params) => {
    try {
      const { cardId, cardType, userId } = params;
      const agentTypes = determineAgentType(cardType, action);

      // Handle multiple agents for complex tasks
      const agentTypeArray = Array.isArray(agentTypes) ? agentTypes : [agentTypes];

      const results = await Promise.all(
        agentTypeArray.map(async (agentType) => {
          // Update active agents tracking
          setActiveAgents(prev => new Map(prev).set(`${cardId}-${agentType}`, {
            status: 'running',
            startTime: new Date(),
            agentType,
            cardId
          }));

          try {
            // Route to appropriate agent
            const result = await agentRouter.execute({
              agentType,
              action,
              params: { ...params, agentType }
            });

            // Update agent status
            setActiveAgents(prev => {
              const updated = new Map(prev);
              updated.set(`${cardId}-${agentType}`, {
                status: 'completed',
                endTime: new Date(),
                result,
                agentType,
                cardId
              });
              return updated;
            });

            // Record in history
            setAgentHistory(prev => [...prev, {
              timestamp: new Date(),
              agentType,
              action,
              cardId,
              result: 'success',
              details: result
            }]);

            return result;

          } catch (error) {
            // Update agent status on failure
            setActiveAgents(prev => {
              const updated = new Map(prev);
              updated.set(`${cardId}-${agentType}`, {
                status: 'failed',
                endTime: new Date(),
                error: error.message,
                agentType,
                cardId
              });
              return updated;
            });

            // Record failure in history
            setAgentHistory(prev => [...prev, {
              timestamp: new Date(),
              agentType,
              action,
              cardId,
              result: 'failed',
              error: error.message
            }]);

            throw error;
          }
        })
      );

      return results;

    } catch (error) {
      console.error('Agent coordination failed:', error);
      throw error;
    }
  }, [determineAgentType]);

  // Get agent status for a specific card
  const getCardAgentStatus = useCallback((cardId) => {
    const cardAgents = Array.from(activeAgents.entries())
      .filter(([key]) => key.startsWith(`${cardId}-`))
      .map(([key, status]) => ({ key, ...status }));

    return cardAgents;
  }, [activeAgents]);

  // Cancel agent execution
  const cancelAgent = useCallback(async (agentKey) => {
    const agentStatus = activeAgents.get(agentKey);
    if (!agentStatus || agentStatus.status !== 'running') return;

    try {
      await agentRouter.cancel(agentKey);

      setActiveAgents(prev => {
        const updated = new Map(prev);
        updated.set(agentKey, {
          ...agentStatus,
          status: 'cancelled',
          endTime: new Date()
        });
        return updated;
      });

    } catch (error) {
      console.error('Failed to cancel agent:', error);
    }
  }, [activeAgents]);

  return {
    coordinateAgents,
    activeAgents,
    agentHistory,
    getCardAgentStatus,
    cancelAgent
  };
};
```

### 2.2 Agent Router Service

**File**: `client/src/components/modals/CivilEngineeringModal/services/agentRouter.js`

```javascript
// Agent Router - Routes tasks to appropriate AI agents
class AgentRouter {
  constructor() {
    this.agentEndpoints = {
      // Content & Documentation Agents
      content: '/api/agents/content',
      documentation: '/api/agents/documentation',

      // Analysis Agents
      analysis: '/api/agents/analysis',
      structural: '/api/agents/structural-analysis',
      hydraulic: '/api/agents/hydraulic-analysis',
      geotechnical: '/api/agents/geotechnical-analysis',

      // CAD & Design Agents
      cad: '/api/agents/cad',
      bim: '/api/agents/bim',
      clash: '/api/agents/clash-detection',

      // GIS & Spatial Agents
      gis: '/api/agents/gis',

      // Quality & Compliance Agents
      quality: '/api/agents/quality',
      compliance: '/api/agents/compliance',
      standards: '/api/agents/standards',

      // Quantity & Cost Agents
      quantity: '/api/agents/quantity',
      cost: '/api/agents/cost',
      validation: '/api/agents/validation',

      // Support Agents
      support: '/api/agents/support',
      variation: '/api/agents/variation'
    };

    this.activeTasks = new Map();
  }

  // Execute agent task
  async execute({ agentType, action, params }) {
    const endpoint = this.agentEndpoints[agentType];
    if (!endpoint) {
      throw new Error(`Unknown agent type: ${agentType}`);
    }

    const taskId = `${agentType}-${Date.now()}-${Math.random()}`;
    this.activeTasks.set(taskId, { agentType, action, params, startTime: new Date() });

    try {
      const response = await fetch(endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.getAuthToken()}`
        },
        body: JSON.stringify({
          action,
          params,
          taskId,
          projectId: params.projectId,
          userId: params.userId
        })
      });

      if (!response.ok) {
        throw new Error(`Agent request failed: ${response.statusText}`);
      }

      const result = await response.json();

      // Clean up completed task
      this.activeTasks.delete(taskId);

      return result;

    } catch (error) {
      // Clean up failed task
      this.activeTasks.delete(taskId);
      throw error;
    }
  }

  // Cancel running agent task
  async cancel(taskId) {
    const task = this.activeTasks.get(taskId);
    if (!task) return;

    try {
      const endpoint = `${this.agentEndpoints[task.agentType]}/cancel`;
      await fetch(endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.getAuthToken()}`
        },
        body: JSON.stringify({ taskId })
      });
    } finally {
      this.activeTasks.delete(taskId);
    }
  }

  // Get authentication token
  getAuthToken() {
    // Implementation would integrate with actual auth system
    return localStorage.getItem('authToken') || 'demo-token';
  }

  // Get active tasks for monitoring
  getActiveTasks() {
    return Array.from(this.activeTasks.values());
  }

  // Get task status
  getTaskStatus(taskId) {
    return this.activeTasks.get(taskId) || null;
  }
}

export const agentRouter = new AgentRouter();
```

## Phase 3: Document Control Integration

### 3.1 Document Control Hook

**File**: `client/src/components/modals/CivilEngineeringModal/hooks/useDocumentControl.js`

```javascript
import { useState, useCallback } from 'react';

const DOC_CONTROL_BASE_URL = '/api/document-control';

export const useDocumentControl = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  // Load documents from 00900 system
  const loadDocument = useCallback(async (documentRefs) => {
    if (!documentRefs || documentRefs.length === 0) {
      return null;
    }

    setLoading(true);
    setError(null);

    try {
      const response = await fetch(`${DOC_CONTROL_BASE_URL}/load`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        },
        body: JSON.stringify({
          documentRefs,
          includeMetadata: true,
          includeVersions: true
        })
      });

      if (!response.ok) {
        throw new Error(`Failed to load documents: ${response.statusText}`);
      }

      const documents = await response.json();
      return documents;

    } catch (err) {
      setError(`Document loading failed: ${err.message}`);
      throw err;
    } finally {
      setLoading(false);
    }
  }, []);

  // Save document to 00900 system
  const saveDocument = useCallback(async (documentData, metadata = {}) => {
    setLoading(true);
    setError(null);

    try {
      const response = await fetch(`${DOC_CONTROL_BASE_URL}/save`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        },
        body: JSON.stringify({
          documentData,
          metadata: {
            ...metadata,
            uploadedBy: 'civil-engineering-workflow',
            timestamp: new Date().toISOString(),
            workflowId: metadata.workflowId
          }
        })
      });

      if (!response.ok) {
        throw new Error(`Failed to save document: ${response.statusText}`);
      }

      const result = await response.json();
      return result.documentRef;

    } catch (err) {
      setError(`Document saving failed: ${err.message}`);
      throw err;
    } finally {
      setLoading(false);
    }
  }, []);

  // Download templates
  const downloadTemplates = useCallback(async (templateIds) => {
    if (!templateIds || templateIds.length === 0) return;

    try {
      for (const templateId of templateIds) {
        const response = await fetch(`${DOC_CONTROL_BASE_URL}/templates/${templateId}/download`, {
          headers: {
            'Authorization': `Bearer ${localStorage.getItem('authToken')}`
          }
        });

        if (!response.ok) {
          throw new Error(`Failed to download template ${templateId}`);
        }

        const blob = await response.blob();
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `${templateId}.docx`;
        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
        document.body.removeChild(a);
      }
    } catch (err) {
      setError(`Template download failed: ${err.message}`);
      throw err;
    }
  }, []);

  // Search documents
  const searchDocuments = useCallback(async (query, filters = {}) => {
    setLoading(true);
    setError(null);

    try {
      const response = await fetch(`${DOC_CONTROL_BASE_URL}/search`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        },
        body: JSON.stringify({
          query,
          filters: {
            ...filters,
            discipline: 'civil-engineering'
          }
        })
      });

      if (!response.ok) {
        throw new Error(`Document search failed: ${response.statusText}`);
      }

      const results = await response.json();
      return results;

    } catch (err) {
      setError(`Document search failed: ${err.message}`);
      throw err;
    } finally {
      setLoading(false);
    }
  }, []);

  return {
    loadDocument,
    saveDocument,
    downloadTemplates,
    searchDocuments,
    loading,
    error
  };
};
```

## Phase 4: Approval Workflow Implementation

### 4.1 Approval Workflow Hook

**File**: `client/src/components/modals/CivilEngineeringModal/hooks/useApprovalWorkflow.js`

```javascript
import { useState, useCallback } from 'react';

const APPROVAL_BASE_URL = '/api/approvals';

export const useApprovalWorkflow = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  // Approval hierarchy by card type
  const getApproverForCard = useCallback((cardType) => {
    const approvers = {
      'project-brief': 'project-manager',
      'site-survey': 'technical-lead',
      'geotechnical': 'geotechnical-engineer',
      'environmental': 'environmental-specialist',
      'design-options': 'design-team',
      'preliminary-layout': 'senior-engineer',
      'calculations': 'technical-lead',
      'preliminary-drawings': 'drawing-office',
      'construction-drawings': 'chief-engineer',
      'specifications': 'technical-lead',
      'quantity-schedules': 'quantity-surveyor',
      'inspection-plans': 'qa-manager',
      'tender-documents': 'procurement-lead',
      'construction-support': 'project-director'
    };

    return approvers[cardType] || 'project-manager';
  }, []);

  // Submit work for approval
  const submitForApproval = useCallback(async (cardId, outputs) => {
    setLoading(true);
    setError(null);

    try {
      const card = await getCardDetails(cardId);
      const approver = getApproverForCard(card.type);

      const response = await fetch(`${APPROVAL_BASE_URL}/submit`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        },
        body: JSON.stringify({
          cardId,
          cardType: card.type,
          outputs,
          approver,
          submittedBy: getCurrentUserId(),
          submittedAt: new Date().toISOString(),
          projectId: card.projectId,
          documentRefs: card.documentRefs
        })
      });

      if (!response.ok) {
        throw new Error(`Approval submission failed: ${response.statusText}`);
      }

      const result = await response.json();

      // Notify approver
      await notifyApprover(approver, {
        cardId,
        cardTitle: card.title,
        projectId: card.projectId,
        approvalUrl: `/approvals/${result.approvalId}`
      });

      return result;

    } catch (err) {
      setError(`Approval submission failed: ${err.message}`);
      throw err;
    } finally {
      setLoading(false);
    }
  }, [getApproverForCard]);

  // Handle approval decision
  const handleApproval = useCallback(async (approvalId, decision, comments = '') => {
    setLoading(true);
    setError(null);

    try {
      const response = await fetch(`${APPROVAL_BASE_URL}/${approvalId}/decide`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        },
        body: JSON.stringify({
          decision, // 'approved' or 'rejected'
          comments,
          decidedBy: getCurrentUserId(),
          decidedAt: new Date().toISOString()
        })
      });

      if (!response.ok) {
        throw new Error(`Approval decision failed: ${response.statusText}`);
      }

      const result = await response.json();

      // Update workflow state based on decision
      if (decision === 'approved') {
        await updateCardStatus(result.cardId, 'approved');
      } else {
        await updateCardStatus(result.cardId, 'rejected');
        // Notify submitter of rejection
        await notifyRejection(result.submittedBy, {
          cardId: result.cardId,
          comments,
          resubmissionUrl: `/workflow/${result.projectId}/card/${result.cardId}`
        });
      }

      return result;

    } catch (err) {
      setError(`Approval decision failed: ${err.message}`);
      throw err;
    } finally {
      setLoading(false);
    }
  }, []);

  // Get pending approvals for current user
  const getPendingApprovals = useCallback(async () => {
    setLoading(true);
    setError(null);

    try {
      const response = await fetch(`${APPROVAL_BASE_URL}/pending`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
      });

      if (!response.ok) {
        throw new Error(`Failed to load approvals: ${response.statusText}`);
      }

      const approvals = await response.json();
      return approvals;

    } catch (err) {
      setError(`Failed to load approvals: ${err.message}`);
      throw err;
    } finally {
      setLoading(false);
    }
  }, []);

  return {
    submitForApproval,
    handleApproval,
    getPendingApprovals,
    loading,
    error
  };
};

// Helper functions (would be in separate utils)
const getCardDetails = async (cardId) => {
  // Implementation would fetch card details from workflow state
  return mockCardDetails[cardId] || {};
};

const getCurrentUserId = () => {
  return localStorage.getItem('userId') || 'current-user';
};

const notifyApprover = async (approverId, notificationData) => {
  // Implementation would send notification
  console.log('Notifying approver:', approverId, notificationData);
};

const notifyRejection = async (submitterId, rejectionData) => {
  // Implementation would send rejection notification
  console.log('Notifying submitter of rejection:', submitterId, rejectionData);
};

const updateCardStatus = async (cardId, status) => {
  // Implementation would update workflow state
  console.log('Updating card status:', cardId, status);
};
```

## Implementation Timeline & Success Metrics

### Phase 1: Core Infrastructure (Week 1)
- [ ] Implement enhanced modal component with full state management
- [ ] Build workflow engine with dependency tracking
- [ ] Create card filtering and progress tracking
- [ ] Add error handling and loading states

### Phase 2: Agent Integration (Week 2)
- [ ] Implement agent coordination system
- [ ] Build agent router service
- [ ] Add agent status tracking and history
- [ ] Integrate with external agent APIs

### Phase 3: Document Control (Week 3)
- [ ] Implement 00900 document control integration
- [ ] Add document loading and saving
- [ ] Build template download system
- [ ] Add document search and linking

### Phase 4: Approval System (Week 4)
- [ ] Build multi-level approval workflow
- [ ] Implement approval routing and notifications
- [ ] Add approval status tracking
- [ ] Create approval decision handling

### Success Metrics
- **Functionality**: All 13 cards fully operational with working buttons
- **Agent Integration**: Seamless coordination with AI agents
- **Document Flow**: Complete 00900 integration with version control
- **Approval Process**: Multi-level sign-off with proper notifications
- **User Experience**: Professional interface with smooth interactions
- **Performance**: Sub-500ms load times and 60fps animations
- **Accessibility**: Full WCAG 2.1 AA compliance

## Conclusion

This implementation guide provides the complete technical specification for transforming the Civil Engineering modal from a non-functional overlay into a professional, fully-integrated workflow system. The implementation covers all aspects of the modal redesign including component architecture, agent integration, document control, and approval workflows.

The result will be a production-ready modal that provides a seamless user experience for managing complex civil engineering workflows with full AI agent support, document management, and professional approval processes.

---

**Next Steps**:
1. Begin Phase 1 implementation
2. Set up development environment
3. Create component scaffolding
4. Implement core functionality testing

**Estimated Timeline**: 4 weeks to production-ready system
**Risk Level**: Medium (requires coordination with multiple external systems)
**Dependencies**: 00900 Document Control API, Agent Framework APIs, Approval System APIs