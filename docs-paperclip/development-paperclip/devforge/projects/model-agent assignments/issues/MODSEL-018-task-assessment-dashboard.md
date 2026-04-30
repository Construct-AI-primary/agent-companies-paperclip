---
title: Task Assessment Dashboard Implementation
issue_id: MODSEL-018
status: open
priority: high
assignee: interface-devforge
company: devforge-ai
team: engineering
created_date: 2026-04-08
due_date: 2026-06-04
estimated_hours: 48
actual_hours: 0
---

# MODSEL-018: Task Assessment Dashboard Implementation

## Issue Summary

Implement comprehensive task assessment dashboard that provides real-time complexity scoring, visual indicators, model recommendations, and cost predictions during task creation and assignment. This dashboard integrates with the task assessment engine and provides intuitive feedback to board operators.

## Background

The procedure document defines detailed UI requirements for task assessment dashboards (lines 631-660). This issue implements the board operator interface for task complexity assessment and model selection guidance.

## Requirements

### Real-time Assessment Features

#### Complexity Scoring Display
- **Live Complexity Meter**: Color-coded visual indicator (1-10 scale) showing task complexity
- **Score Breakdown**: Detailed breakdown by code complexity, domain expertise, integration points, and workflow steps
- **Assessment Confidence**: Display confidence level of automated assessment
- **Historical Comparison**: Comparison with similar previously assessed tasks

#### Visual Indicators and Feedback
- **Color-coded Complexity**: Green (1-3), Yellow (4-6), Red (7-10) complexity levels
- **Progress Indicators**: Loading states during assessment processing
- **Error States**: Clear error messages for assessment failures
- **Success Confirmations**: Visual confirmation of successful assessments

#### Model Recommendations Panel
- **Recommended Models List**: Top recommended models with reasoning
- **Cost Estimates**: Estimated cost ranges for each recommendation
- **Performance Metrics**: Expected latency and quality scores
- **Compatibility Indicators**: Visual indicators for model-task compatibility

### Dashboard Components

#### Task Creation Integration
**Location**: Enhanced `ui/src/pages/IssueDetail.tsx`

**Components**:
- **AssessmentPanel**: Side panel showing live assessment results
- **ComplexityMeter**: Circular progress indicator with color coding
- **RecommendationCard**: Card-based display of model recommendations
- **CostProjectionChart**: Visual cost comparison across recommendations

#### Assessment Schema

```typescript
interface TaskAssessmentUI {
  complexityScore: number;
  scoreBreakdown: {
    codeComplexity: number;
    domainExpertise: number;
    integrationPoints: number;
    workflowSteps: number;
  };
  recommendedModels: ModelRecommendation[];
  costEstimates: CostEstimate[];
  assessmentMetadata: {
    assessedBy: 'auto' | 'manual';
    confidence: number;
    lastUpdated: Date;
  };
}
```

### Interactive Features

#### Manual Assessment Override
- **Assessment Editor**: Allow manual adjustment of complexity scores
- **Reason Tracking**: Record reasons for manual overrides
- **Audit Trail**: Complete history of assessment changes
- **Validation**: Ensure manual assessments meet system constraints

#### Model Selection Controls
- **Model Override**: Manual selection of specific models with justification
- **Group Filtering**: Filter recommendations by model groups
- **Cost Filtering**: Filter by budget constraints
- **Preference Settings**: Save operator preferences for future tasks

### API Integration

#### Assessment Endpoints
```typescript
POST   /api/companies/{companyId}/model-assessment    // Assess task complexity
GET    /api/companies/{companyId}/model-recommendations // Get model recommendations
POST   /api/tasks/{taskId}/assessment/override       // Manual assessment override
GET    /api/tasks/{taskId}/assessment/history        // Assessment change history
```

#### Real-time Updates
- **WebSocket Streaming**: Live assessment updates during task editing
- **Cost Recalculation**: Automatic cost updates as task details change
- **Recommendation Refresh**: Dynamic recommendation updates based on changes

## Acceptance Criteria

- [ ] Complete task assessment dashboard implemented
- [ ] Real-time complexity scoring working
- [ ] Visual indicators and color coding functional
- [ ] Model recommendations panel operational
- [ ] Cost projections accurate and up-to-date
- [ ] Manual override capabilities working
- [ ] API integration complete and tested
- [ ] Responsive design for all screen sizes
- [ ] Performance optimized for large task lists

## Dependencies

- MODSEL-004: Task Complexity Assessment Engine (for assessment logic)
- MODSEL-010: Recommendation Engine (for model suggestions)

## Testing

- Unit tests for dashboard components and assessment display
- Integration tests for API endpoints and real-time updates
- End-to-end tests for complete task creation workflows
- Performance tests for dashboard responsiveness
- User experience testing for intuitiveness and clarity

## Related Issues

- MODSEL-004: Task Complexity Assessment Engine
- MODSEL-017: Agent Configuration Interface
- MODSEL-019: Model Performance Dashboard

## Notes

This issue implements the task assessment dashboard defined in the procedure document (lines 631-660). The dashboard provides comprehensive task assessment capabilities with intuitive visual feedback and intelligent model recommendations.