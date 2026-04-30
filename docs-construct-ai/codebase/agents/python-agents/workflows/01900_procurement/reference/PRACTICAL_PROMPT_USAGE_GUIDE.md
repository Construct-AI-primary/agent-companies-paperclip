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
# Practical Prompt Usage Guide

## How to Use the PromptVisualizationAgent in Real Scenarios

This guide shows exactly when and how to use the PromptVisualizationAgent to see prompts for specific parts of the workflow like SOW generation.

## 🎯 **When to Use the PromptVisualizationAgent**

### **Scenario 1: Development & Testing**
**When**: You're developing or testing the procurement workflow
**How**: Run the agent alongside your workflow to capture all prompts
**Example**: 
```bash
# Run during development
python demo_prompt_sequence.py
```

### **Scenario 2: Debugging Specific Stages**
**When**: You want to see prompts for a specific stage (like SOW generation)
**How**: Filter prompts by stage after capture
**Example**:
```python
# Get only SOW generation prompts
sow_prompts = prompt_agent.get_stage_prompts("sow_generation")
for prompt in sow_prompts:
    print(f"Agent: {prompt['agent_name']}")
    print(f"Content: {prompt['prompt_content']}")
```

### **Scenario 3: Workflow Analysis**
**When**: You want to analyze the complete prompt sequence
**How**: Generate comprehensive reports
**Example**:
```python
# Generate full report
report = prompt_agent.generate_prompt_report()
print(report)
```

## 🚀 **Practical Usage Examples**

### **Example 1: See SOW Generation Prompts Only**

```python
from tests.integration.test_prompt_visualization import PromptVisualizationAgent

# Create agent and capture workflow
prompt_agent = PromptVisualizationAgent()

# Simulate workflow (or run actual workflow)
# ... workflow execution ...

# Get ONLY SOW generation prompts
sow_prompts = prompt_agent.get_stage_prompts("sow_generation")

print("=== SOW GENERATION PROMPTS ===")
for i, prompt in enumerate(sow_prompts, 1):
    print(f"\n{i}. Agent: {prompt['agent_name']}")
    print(f"   Time: {prompt['elapsed_seconds']:.2f}s")
    print(f"   Content:")
    print(f"   {prompt['prompt_content']}")
    print("-" * 60)
```

### **Example 2: Compare Initial Chat vs SOW Prompts**

```python
from tests.integration.test_prompt_visualization import PromptVisualizationAgent

prompt_agent = PromptVisualizationAgent()

# ... capture workflow ...

# Get different stage prompts
initial_chat_prompts = prompt_agent.get_stage_prompts("initial_chat")
sow_prompts = prompt_agent.get_stage_prompts("sow_generation")

print("=== INITIAL CHAT PROMPTS ===")
for prompt in initial_chat_prompts:
    print(f"Content: {prompt['prompt_content'][:200]}...")

print("\n=== SOW GENERATION PROMPTS ===")
for prompt in sow_prompts:
    print(f"Content: {prompt['prompt_content'][:200]}...")
```

### **Example 3: Real-time Prompt Monitoring**

```python
from tests.integration.test_prompt_visualization import PromptVisualizationAgent

# Create agent
prompt_agent = PromptVisualizationAgent()

# During actual workflow execution, log prompts as they happen
def monitor_workflow():
    # Step 1: Initial analysis
    initial_prompt = "Analyze this procurement request..."
    prompt_agent.log_prompt(
        stage="initial_chat",
        agent_name="procurement_coordinator", 
        prompt_content=initial_prompt,
        context={"procurement_id": "PROC-123"}
    )
    
    # Step 2: SOW generation
    sow_prompt = "Generate SOW based on requirements..."
    prompt_agent.log_prompt(
        stage="sow_generation",
        agent_name="sow_generator_agent",
        prompt_content=sow_prompt,
        context={"requirements": "extracted_data"}
    )
    
    # Generate report showing sequence
    report = prompt_agent.generate_prompt_report()
    print(report)

monitor_workflow()
```

## 🎮 **Using with Cline (Your Current Setup)**

### **Option 1: Run as Standalone Script**
```bash
# Navigate to the directory
cd /Users/_General/Feb-23-1/deep-agents

# Run the demonstration
python demo_prompt_sequence.py
```

### **Option 2: Use as Reference for Specific Stages**
```python
# Import the agent
from tests.integration.test_prompt_visualization import PromptVisualizationAgent

# Create agent
prompt_agent = PromptVisualizationAgent()

# If you have the /Users/_General/Feb-23-1/deep-agents/docs/workflows/01900_procurement as context,
# you can use the agent to capture prompts from that workflow

# Example: Capture SOW prompts from procurement workflow
sow_prompts = [
    {
        "stage": "sow_generation",
        "agent_name": "sow_generator_agent",
        "prompt_content": """
        Generate Statement of Work based on extracted requirements:
        
        Equipment Specifications:
        - Excavator: 150HP engine, 20000kg operating weight
        - Safety Equipment: 5 units for site safety
        
        Performance Criteria:
        - Engine power must meet 150HP specification
        - Equipment must pass ISO 9001 quality standards
        - Safety equipment must comply with ISO 45001
        
        Delivery Requirements:
        - All equipment must be delivered to Site A
        - Delivery date: April 1, 2026
        - Installation and testing included
        
        Quality Assurance:
        - Pre-delivery inspection required
        - Performance testing mandatory
        - Documentation package required
        
        Create comprehensive SOW document.
        """,
        "context": {"requirements": "structured_data"}
    }
]

# Log the SOW prompt
for prompt_data in sow_prompts:
    prompt_agent.log_prompt(**prompt_data)

# Get SOW-specific report
sow_sequence = prompt_agent.get_stage_prompts("sow_generation")
print("=== SOW GENERATION PROMPTS ===")
for prompt in sow_sequence:
    print(f"Agent: {prompt['agent_name']}")
    print(f"Content: {prompt['prompt_content']}")
    print("-" * 80)
```

### **Option 3: Integrate with Existing Workflow**
```python
# If you're running the actual procurement workflow
from tests.integration.test_prompt_visualization import PromptVisualizationAgent

# Create agent BEFORE starting workflow
prompt_agent = PromptVisualizationAgent()

# Run your workflow (the agent will capture prompts)
# python run_procurement_workflow.py

# After workflow completes, analyze specific stages
print("=== SOW PROMPTS FROM WORKFLOW ===")
sow_prompts = prompt_agent.get_stage_prompts("sow_generation")
for prompt in sow_prompts:
    print(f"Time: {prompt['elapsed_seconds']:.2f}s")
    print(f"Content: {prompt['prompt_content']}")
    print("-" * 60)
```

## 📊 **Quick Reference: Common Use Cases**

### **"I want to see SOW prompts"**
```python
sow_prompts = prompt_agent.get_stage_prompts("sow_generation")
```

### **"I want to see initial chat prompts"**
```python
initial_prompts = prompt_agent.get_stage_prompts("initial_chat")
```

### **"I want to see appendix compilation prompts"**
```python
appendix_prompts = prompt_agent.get_stage_prompts("appendix_compilation")
```

### **"I want to see all prompts in sequence"**
```python
sequence = prompt_agent.get_prompt_sequence()
```

### **"I want to see prompts from a specific agent"**
```python
agent_prompts = prompt_agent.get_agent_prompts("sow_generator_agent")
```

## 🎯 **Best Practices**

1. **Start Early**: Create the PromptVisualizationAgent BEFORE running your workflow
2. **Log Continuously**: Log prompts as they're generated during workflow execution
3. **Use Filters**: After capture, use stage/agent filters to focus on specific areas
4. **Export Data**: Use `export_prompt_data()` to save for later analysis
5. **Generate Reports**: Use `generate_prompt_report()` for comprehensive analysis

## 🚀 **Next Steps**

1. **Try the Demo**: Run `python demo_prompt_sequence.py` to see it in action
2. **Run Tests**: Run `pytest tests/integration/test_prompt_visualization.py -v` to see all functionality
3. **Integrate**: Add the agent to your existing workflow to capture real prompts
4. **Analyze**: Use the filtering and reporting features to focus on specific stages

The PromptVisualizationAgent gives you complete visibility into your workflow prompts - you decide when to capture them and which ones to analyze!