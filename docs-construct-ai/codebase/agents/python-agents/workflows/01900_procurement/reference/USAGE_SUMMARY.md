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
# Usage Summary: How to See Prompts for Specific Stages

## Quick Answer to Your Question

**Yes, you can use the PromptVisualizationAgent to see prompts for specific stages like SOW generation!** Here's exactly how:

## 🎯 **Three Ways to Use the Agent**

### **Method 1: Run the Demo Scripts (Easiest)**
```bash
# See ALL prompts in sequence
cd /Users/_General/Feb-23-1/deep-agents
python demo_prompt_sequence.py

# See ONLY SOW prompts
python demo_sow_prompts.py
```

### **Method 2: Use with Your Existing Context**
```python
# If you have /Users/_General/Feb-23-1/deep-agents/docs/workflows/01900_procurement as context
from tests.integration.test_prompt_visualization import PromptVisualizationAgent

# Create agent
prompt_agent = PromptVisualizationAgent()

# Run your workflow (agent captures prompts automatically)
# ... your workflow execution ...

# Get SOW prompts specifically
sow_prompts = prompt_agent.get_stage_prompts("sow_generation")
for prompt in sow_prompts:
    print(f"Agent: {prompt['agent_name']}")
    print(f"Content: {prompt['prompt_content']}")
```

### **Method 3: Integrate into Your Code**
```python
from tests.integration.test_prompt_visualization import PromptVisualizationAgent

# Create agent BEFORE starting your workflow
prompt_agent = PromptVisualizationAgent()

# During workflow, log prompts as they happen
prompt_agent.log_prompt(
    stage="sow_generation",
    agent_name="sow_generator_agent",
    prompt_content="Your SOW prompt here...",
    context={"requirements": "data"}
)

# After workflow, see all SOW prompts
sow_prompts = prompt_agent.get_stage_prompts("sow_generation")
```

## 📋 **Stage Names for Filtering**

Use these exact stage names to filter prompts:

- `"initial_chat"` - Initial procurement request analysis
- `"template_analysis"` - Template compatibility assessment  
- `"requirements_extraction"` - Requirement extraction
- `"sow_generation"` - Statement of Work generation ⭐ **Your focus**
- `"compliance_validation"` - Compliance checking
- `"appendix_compilation"` - Appendix generation
- `"final_review"` - Final package review

## 🎮 **Agent Names for Filtering**

Use these agent names to see prompts from specific agents:

- `"procurement_coordinator"` - Initial chat agent
- `"template_analysis_agent"` - Template analysis
- `"requirements_extraction_agent"` - Requirements extraction
- `"sow_generator_agent"` - SOW generation ⭐ **Your focus**
- `"compliance_validator_agent"` - Compliance validation
- `"appendix_compiler_agent"` - Appendix compilation
- `"final_review_agent"` - Final review

## 🚀 **Quick Commands**

### **See SOW Prompts Only**
```python
sow_prompts = prompt_agent.get_stage_prompts("sow_generation")
```

### **See Initial Chat Prompts**
```python
initial_prompts = prompt_agent.get_stage_prompts("initial_chat")
```

### **See Appendix Compilation Prompts**
```python
appendix_prompts = prompt_agent.get_stage_prompts("appendix_compilation")
```

### **See All Prompts from SOW Agent**
```python
sow_agent_prompts = prompt_agent.get_agent_prompts("sow_generator_agent")
```

### **Generate Complete Report**
```python
report = prompt_agent.generate_prompt_report()
print(report)
```

## 📊 **What You'll See**

When you run the SOW demonstration, you get:

```
📄 SOW PROMPT #1
----------------------------------------
Agent: sow_generator_agent
Time: 0.00s
Content Length: 822 characters

📝 PROMPT CONTENT:
[Full SOW generation prompt content]

📊 CONTEXT:
[Associated metadata and parameters]
```

## 🎯 **Your Specific Use Case**

**To see SOW prompts when you have the procurement workflow context:**

1. **Run the demo script** (easiest):
   ```bash
   python demo_sow_prompts.py
   ```

2. **Or integrate into your workflow**:
   ```python
   from tests.integration.test_prompt_visualization import PromptVisualizationAgent
   
   prompt_agent = PromptVisualizationAgent()
   # ... run your workflow ...
   sow_prompts = prompt_agent.get_stage_prompts("sow_generation")
   ```

3. **Or use the agent directly**:
   ```python
   # After capturing workflow prompts
   sow_prompts = prompt_agent.get_stage_prompts("sow_generation")
   for prompt in sow_prompts:
       print(prompt['prompt_content'])
   ```

## 📁 **Files Created**

- `tests/integration/test_prompt_visualization.py` - Complete test suite
- `demo_prompt_sequence.py` - Shows all prompts in sequence
- `demo_sow_prompts.py` - Shows ONLY SOW prompts (what you wanted!)
- `PRACTICAL_PROMPT_USAGE_GUIDE.md` - Detailed usage instructions
- `PROMPT_SEQUENCE_SOLUTION_SUMMARY.md` - Solution overview

## 🎉 **Ready to Use!**

The solution is complete and ready. You can:
- Run the demo scripts to see how it works
- Integrate the agent into your existing workflow
- Use the filtering functions to see prompts from specific stages or agents
- Export data for external analysis

**The key insight**: Create the PromptVisualizationAgent BEFORE your workflow, let it capture prompts during execution, then use `get_stage_prompts("sow_generation")` to see only the SOW prompts you're interested in!