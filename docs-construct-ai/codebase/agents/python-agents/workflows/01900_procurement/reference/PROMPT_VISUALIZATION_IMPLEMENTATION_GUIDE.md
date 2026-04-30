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
# Prompt Visualization Implementation Guide

## Overview

This document provides a comprehensive guide to the prompt visualization system implementation for ConstructAI. The system provides a user-friendly UI for monitoring, analyzing, and exporting prompt sequences from workflow executions.

## 🎯 **Implementation Summary**

### **Components Created**

1. **Prompt Visualization Agent** (`0016_agent_prompt_visualization.js`)
   - Core agent that tracks and logs all prompts during workflow execution
   - Provides methods for data export, filtering, and analysis
   - Integrates with existing workflow system

2. **UI Component** (`02050-prompt-visualization.js`)
   - React component for the testing dashboard
   - Features workflow filtering, stage filtering, agent filtering, and search
   - Real-time prompt display with timeline visualization
   - Export capabilities

3. **API Endpoints** (`api/prompt-visualization.js`)
   - RESTful API for prompt data access
   - Export functionality
   - Statistics and filtering endpoints

4. **Dashboard Integration** (`02050-testing-dashboard.js`)
   - New "Prompts" tab in the testing dashboard
   - Seamless integration with existing UI

## 🚀 **Quick Start**

### **1. Access the Prompt Visualization**

Navigate to the testing dashboard:
```
http://localhost:3060/#/testing-dashboard
```

Click on the **"Prompts"** tab to access prompt visualization.

### **2. View All Prompts**

The interface displays:
- **Statistics**: Total prompts, stages, agents, workflows
- **Stage Breakdown**: Visual representation of prompt distribution
- **Timeline**: Chronological view of all prompts with full content
- **Filters**: Workflow, stage, agent, and search filters

### **3. Filter Prompts**

Use the filter controls to focus on specific areas:
- **Workflow Filter**: Select specific workflows (procurement, logistics, engineering, etc.)
- **Stage Filter**: Filter by workflow stages (initial_chat, sow_generation, etc.)
- **Agent Filter**: Focus on specific agents (procurement_coordinator, etc.)
- **Search**: Search prompt content or context

### **4. Export Data**

Click the **"Export"** button to download prompt data as JSON for external analysis.

## 📊 **Features**

### **Workflow Filtering**
- **Multiple Workflow Selection**: Select multiple workflows to view combined prompt data
- **Workflow Chips**: Visual chips showing selected workflows with selection state
- **Dynamic Workflow Detection**: Automatically detects workflows from prompt data

### **Stage Filtering**
- **Stage Selection**: Filter by specific workflow stages
- **Stage Statistics**: Visual breakdown of prompts by stage
- **Stage Timeline**: Timeline view organized by stages

### **Agent Filtering**
- **Agent Selection**: Focus on specific agent outputs
- **Agent Statistics**: Track prompt distribution across agents
- **Agent Timeline**: See prompts organized by agent

### **Search Functionality**
- **Content Search**: Search within prompt content
- **Context Search**: Search within prompt context data
- **Real-time Filtering**: Instant results as you type

### **Timeline Visualization**
- **Chronological Display**: Prompts shown in execution order
- **Stage Indicators**: Visual indicators for different workflow stages
- **Agent Badges**: Clear identification of which agent generated each prompt
- **Timing Information**: Execution timing for each prompt

### **Export Capabilities**
- **JSON Export**: Complete prompt data export
- **Filter-based Export**: Export only filtered data
- **Timestamped Files**: Automatic timestamping of export files

## 🔧 **Technical Architecture**

### **Data Flow**

```
Workflow Execution → PromptVisualizationAgent → API Endpoints → UI Component
```

1. **Prompt Collection**: Agent intercepts and logs all prompts during workflow execution
2. **Data Storage**: Prompts stored in memory with metadata (stage, agent, workflow, timing)
3. **API Access**: RESTful endpoints provide access to prompt data
4. **UI Display**: React component renders prompts with filtering and visualization

### **Data Structure**

Each prompt record contains:
```javascript
{
  id: string,           // Unique identifier
  stage: string,        // Workflow stage (initial_chat, sow_generation, etc.)
  agent_name: string,   // Agent that generated the prompt
  prompt_content: string, // Full prompt text
  context: object,      // Associated context data
  elapsed_seconds: number, // Execution timing
  timestamp: string,    // ISO timestamp
  workflow: string,     // Workflow identifier
  tokens_used: number   // Token usage (if available)
}
```

### **Integration Points**

- **Workflow System**: Integrates with existing workflow execution
- **Testing Dashboard**: Adds new tab to existing dashboard
- **Agent System**: Works with all existing agents
- **API System**: Standard RESTful endpoints

## 🎨 **UI Features**

### **Responsive Design**
- **Desktop**: Full feature set with side-by-side layout
- **Tablet**: Optimized layout for medium screens
- **Mobile**: Touch-friendly interface with stacked layout

### **Visual Design**
- **Clean Interface**: Minimal, professional design
- **Color Coding**: Stage-specific colors for easy identification
- **Typography**: Monospace font for prompt content
- **Icons**: Intuitive icons for different actions

### **User Experience**
- **Real-time Updates**: Live prompt capture during execution
- **Loading States**: Clear feedback during data loading
- **Error Handling**: Graceful error handling with fallback data
- **Empty States**: Helpful messages when no data is available

## 📈 **Usage Examples**

### **Example 1: SOW Generation Analysis**

1. Navigate to Prompts tab
2. Select "SOW Generation" stage filter
3. View all SOW-related prompts
4. Analyze prompt content and context
5. Export for detailed analysis

### **Example 2: Agent Performance Review**

1. Select specific agent (e.g., "sow_generator_agent")
2. Review all prompts from that agent
3. Analyze prompt patterns and quality
4. Identify areas for improvement

### **Example 3: Multi-Workflow Comparison**

1. Select multiple workflows (procurement, logistics)
2. Compare prompt patterns across workflows
3. Identify common patterns and differences
4. Export combined data for analysis

### **Example 4: Real-time Monitoring**

1. Start a workflow execution
2. Open Prompts tab in another browser tab
3. Watch prompts appear in real-time
4. Monitor execution progress and timing

## 🔍 **Advanced Features**

### **Search Capabilities**
- **Full-text Search**: Search across all prompt content
- **Context Search**: Search within structured context data
- **Case-insensitive**: User-friendly search behavior
- **Real-time Results**: Instant filtering as you type

### **Statistics and Analytics**
- **Stage Distribution**: Visual breakdown of prompt distribution
- **Agent Activity**: Track agent usage patterns
- **Workflow Analysis**: Understand workflow execution patterns
- **Timing Analysis**: Monitor execution performance

### **Export and Integration**
- **JSON Format**: Standard format for external tools
- **Filter-based Export**: Export only relevant data
- **Timestamped Files**: Automatic file naming with timestamps
- **Complete Metadata**: Export includes all prompt metadata

## 🛠 **Development Notes**

### **File Locations**

```
deep-agents/
├── deep_agents/agents/pages/01900_procurement/agents/
│   └── 0016_agent_prompt_visualization.js    # Core agent implementation
├── client/src/pages/02050-testing-dashboard/
│   ├── 02050-prompt-visualization.js         # UI component
│   ├── 02050-testing-dashboard.js            # Dashboard integration
│   └── api/prompt-visualization.js           # API endpoints
└── PROMPT_VISUALIZATION_IMPLEMENTATION_GUIDE.md  # This documentation
```

### **Dependencies**

- **React**: UI component framework
- **Node.js**: Backend API server
- **Express**: Web server framework
- **Standard CSS**: No external CSS frameworks

### **Browser Support**

- **Modern Browsers**: Chrome, Firefox, Safari, Edge
- **Mobile Browsers**: iOS Safari, Android Chrome
- **No IE Support**: Focused on modern browser capabilities

## 🚀 **Future Enhancements**

### **Planned Features**

1. **Prompt Analytics Dashboard**
   - Advanced analytics and visualization
   - Performance metrics
   - Usage patterns

2. **Prompt Quality Scoring**
   - Automated quality assessment
   - Pattern recognition
   - Improvement suggestions

3. **Integration with External Tools**
   - IDE integration
   - Development workflow integration
   - CI/CD pipeline integration

4. **Advanced Filtering**
   - Complex query support
   - Saved filter presets
   - Custom filter combinations

### **Performance Optimizations**

1. **Data Pagination**
   - Handle large prompt datasets
   - Virtualized rendering for long lists
   - Lazy loading for better performance

2. **Caching Strategies**
   - Client-side caching
   - Server-side caching
   - Smart cache invalidation

3. **Real-time Updates**
   - WebSocket integration for live updates
   - Background data synchronization
   - Offline capability

## 📋 **Maintenance**

### **Monitoring**

- **Performance Monitoring**: Track UI performance
- **Error Tracking**: Monitor API errors and failures
- **Usage Analytics**: Understand feature usage patterns

### **Updates**

- **Regular Testing**: Ensure compatibility with workflow changes
- **Performance Review**: Monitor and optimize performance
- **Feature Enhancement**: Add new features based on user feedback

### **Documentation**

- **API Documentation**: Keep API docs up to date
- **User Guides**: Create detailed user documentation
- **Developer Guides**: Technical documentation for developers

## 🎉 **Conclusion**

The prompt visualization system provides a comprehensive solution for monitoring and analyzing prompt sequences in ConstructAI workflows. With its user-friendly interface, powerful filtering capabilities, and robust export functionality, it enables users to gain deep insights into workflow execution and prompt patterns.

The system is designed to be:
- **User-friendly**: No complex commands or technical knowledge required
- **Comprehensive**: Covers all workflows and provides detailed analysis
- **Flexible**: Supports various filtering and export options
- **Scalable**: Can handle large datasets and multiple workflows
- **Integrated**: Seamlessly integrates with existing dashboard

This implementation successfully addresses the original requirement for a practical way to see prompts for specific stages without complex command usage, providing a user-friendly interface that leverages the existing testing dashboard infrastructure.