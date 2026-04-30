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
# Prompt Visualization UI Integration

## Solution Overview

You're absolutely right - the command-line approach is cumbersome. The testing dashboard at `http://localhost:3060/#/testing-dashboard` is the perfect place to implement prompt visualization functionality. Here's my analysis and recommendations:

## Current Testing Dashboard Analysis

### ✅ **Strengths**
- **Comprehensive UI**: Well-structured React component with clean CSS
- **Real-time Streaming**: Already supports SSE (Server-Sent Events) for live test execution
- **Modal System**: Has a modal component for detailed views
- **Workflow Integration**: Already loads test metadata from API
- **No Bootstrap**: Uses custom CSS (matches your preference)

### ⚠️ **Current Limitations**
- **No Prompt Tracking**: Currently only tracks test results, not prompt sequences
- **Limited Debug Info**: Shows routing steps but not actual prompt content
- **No Stage Filtering**: Can't filter by specific workflow stages

## 🎯 **Recommended Implementation**

### **1. Add New Tab: "Prompt Analysis"**

Add a new tab to the existing dashboard navigation:

```javascript
// In the tabs section, add:
{['overview', 'agents', 'suites', 'results', 'coverage', 'history', 'prompts'].map(tab => (
  <button key={tab} className={`td-tab ${activeTab === tab ? 'td-tab-active' : ''}`} onClick={() => setActiveTab(tab)}>
    {tab.charAt(0).toUpperCase() + tab.slice(1)}
  </button>
))}
```

### **2. Create Prompt Visualization Component**

Create a new component that integrates with the existing PromptVisualizationAgent:

```javascript
// New component for prompt analysis tab
const PromptAnalysisTab = () => {
  const [promptData, setPromptData] = useState([]);
  const [selectedStage, setSelectedStage] = useState('all');
  const [selectedAgent, setSelectedAgent] = useState('all');
  const [timeRange, setTimeRange] = useState('last_hour');
  
  // Load prompt data from API
  const loadPromptData = async () => {
    const response = await fetch('/api/prompt-visualization/data');
    const data = await response.json();
    setPromptData(data.prompts || []);
  };
  
  // Filter prompts by stage/agent
  const filteredPrompts = promptData.filter(prompt => {
    const stageMatch = selectedStage === 'all' || prompt.stage === selectedStage;
    const agentMatch = selectedAgent === 'all' || prompt.agent_name === selectedAgent;
    return stageMatch && agentMatch;
  });
  
  return (
    <div className="td-card">
      <div className="td-card-header">
        <h3 className="td-card-title">Prompt Sequence Analysis</h3>
        <div style={{ display: 'flex', gap: 12 }}>
          <select className="td-form-select" value={selectedStage} onChange={(e) => setSelectedStage(e.target.value)}>
            <option value="all">All Stages</option>
            <option value="initial_chat">Initial Chat</option>
            <option value="sow_generation">SOW Generation</option>
            <option value="appendix_compilation">Appendix Compilation</option>
            <option value="template_analysis">Template Analysis</option>
            <option value="requirements_extraction">Requirements Extraction</option>
            <option value="compliance_validation">Compliance Validation</option>
            <option value="final_review">Final Review</option>
          </select>
          <select className="td-form-select" value={selectedAgent} onChange={(e) => setSelectedAgent(e.target.value)}>
            <option value="all">All Agents</option>
            <option value="procurement_coordinator">Procurement Coordinator</option>
            <option value="sow_generator_agent">SOW Generator</option>
            <option value="appendix_compiler_agent">Appendix Compiler</option>
            <option value="template_analysis_agent">Template Analysis</option>
            <option value="requirements_extraction_agent">Requirements Extraction</option>
            <option value="compliance_validator_agent">Compliance Validator</option>
            <option value="final_review_agent">Final Review</option>
          </select>
        </div>
      </div>
      <div className="td-card-body">
        {/* Prompt sequence visualization */}
        <div className="td-grid-2">
          <div>
            <h4>Prompt Sequence</h4>
            {filteredPrompts.map((prompt, idx) => (
              <div key={prompt.id} className="td-card" style={{ marginBottom: 16 }}>
                <div className="td-card-header" style={{ padding: '8px 16px' }}>
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <span className="td-badge td-badge-info">{prompt.stage}</span>
                    <span className="td-badge td-badge-neutral">{prompt.agent_name}</span>
                    <span style={{ fontSize: 12, color: '#6b7280' }}>{prompt.elapsed_seconds}s</span>
                  </div>
                </div>
                <div className="td-card-body" style={{ padding: 16 }}>
                  <div style={{ fontFamily: 'monospace', fontSize: 13, lineHeight: 1.6, background: '#f3f4f6', padding: 12, borderRadius: 6 }}>
                    {prompt.prompt_content}
                  </div>
                  {prompt.context && (
                    <div style={{ marginTop: 12 }}>
                      <strong style={{ fontSize: 12 }}>Context:</strong>
                      <pre style={{ fontSize: 11, background: '#f9fafb', padding: 8, borderRadius: 4, marginTop: 4 }}>
                        {JSON.stringify(prompt.context, null, 2)}
                      </pre>
                    </div>
                  )}
                </div>
              </div>
            ))}
          </div>
          <div>
            <h4>Stage Breakdown</h4>
            {/* Visualization charts/stats */}
            <div className="td-stats-row">
              {['initial_chat', 'sow_generation', 'appendix_compilation', 'template_analysis'].map(stage => {
                const count = promptData.filter(p => p.stage === stage).length;
                return (
                  <div key={stage} className="td-stat-card">
                    <div className="td-stat-value">{count}</div>
                    <div className="td-stat-label">{stage.replace('_', ' ').toUpperCase()}</div>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
```

### **3. Add API Endpoint**

Create a new API endpoint to serve prompt data:

```javascript
// In your API routes
app.get('/api/prompt-visualization/data', (req, res) => {
  // Load prompt data from the PromptVisualizationAgent
  const promptAgent = new PromptVisualizationAgent();
  const promptData = promptAgent.get_prompt_sequence();
  
  res.json({
    success: true,
    prompts: promptData,
    total: promptData.length,
    stages: [...new Set(promptData.map(p => p.stage))],
    agents: [...new Set(promptData.map(p => p.agent_name))]
  });
});

// Export endpoint
app.get('/api/prompt-visualization/export', (req, res) => {
  const promptAgent = new PromptVisualizationAgent();
  const filename = promptAgent.export_prompt_data(`prompts_${Date.now()}.json`);
  
  res.json({
    success: true,
    filename: filename,
    message: 'Prompt data exported successfully'
  });
});
```

### **4. Integrate with Existing Test Modal**

Enhance the existing test modal to show prompt content during execution:

```javascript
// In the modal component, add prompt display
{liveEvents.filter(e => e.type === 'prompt-logged').map((event, idx) => (
  <div key={idx} className="td-card" style={{ marginBottom: 16 }}>
    <div className="td-card-header" style={{ padding: '8px 16px' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <span className="td-badge td-badge-info">{event.stage}</span>
        <span className="td-badge td-badge-neutral">{event.agent_name}</span>
      </div>
    </div>
    <div className="td-card-body" style={{ padding: 16 }}>
      <div style={{ fontFamily: 'monospace', fontSize: 13, lineHeight: 1.6, background: '#f3f4f6', padding: 12, borderRadius: 6 }}>
        {event.prompt_content}
      </div>
    </div>
  </div>
))}
```

## 🚀 **Implementation Benefits**

### **✅ User-Friendly**
- **No Commands**: Everything accessible through the UI
- **Visual Interface**: Clear, organized display of prompt sequences
- **Filtering**: Easy filtering by stage and agent
- **Real-time**: Live prompt capture during test execution

### **✅ Integrated**
- **Existing Infrastructure**: Leverages current testing dashboard
- **Consistent Styling**: Uses existing CSS and component patterns
- **API Integration**: Works with existing API structure
- **Modal Enhancement**: Enhances current test execution modal

### **✅ Practical**
- **Stage Filtering**: See only SOW prompts, initial chat prompts, etc.
- **Agent Filtering**: Focus on specific agent outputs
- **Export Capability**: Download prompt data for analysis
- **Historical View**: Review past prompt sequences

## 📋 **Implementation Steps**

1. **Add New Tab**: Add "prompts" tab to navigation
2. **Create Component**: Build PromptAnalysisTab component
3. **API Endpoint**: Create `/api/prompt-visualization/data` endpoint
4. **Enhance Modal**: Add prompt display to existing test modal
5. **Styling**: Use existing CSS patterns for consistency
6. **Testing**: Verify integration with existing workflow

## 🎯 **Usage Examples**

### **See SOW Prompts Only**
1. Navigate to Testing Dashboard
2. Click "Prompts" tab
3. Select "SOW Generation" from stage dropdown
4. View all SOW generation prompts with full content

### **Compare Initial Chat vs SOW Prompts**
1. In Prompts tab, select "Initial Chat" stage
2. Review initial chat prompts
3. Switch to "SOW Generation" stage
4. Compare prompt content and structure

### **Real-time Prompt Monitoring**
1. Run a test from the dashboard
2. Open test execution modal
3. Watch prompts appear in real-time as they're generated
4. See the complete sequence from start to finish

## 🎉 **Conclusion**

This integration transforms the prompt visualization from a complex command-line tool into a practical, user-friendly feature within your existing testing dashboard. Users can easily:

- **See all prompts** in a clear, organized interface
- **Filter by stage** (SOW, initial chat, appendix, etc.)
- **Filter by agent** (specific agent outputs)
- **Monitor in real-time** during test execution
- **Export data** for external analysis

The solution leverages your existing infrastructure and provides exactly what you requested: a practical way to see prompts for specific stages without complex command usage.