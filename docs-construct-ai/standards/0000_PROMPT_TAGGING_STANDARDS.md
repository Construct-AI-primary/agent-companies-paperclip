---
memory_layer: durable_knowledge
para_section: pages/standards
gigabrain_tags: standards, documentation
documentation
openstinger_context: standards-compliance
last_updated: 2026-03-30
related_docs:
  - docs/standards/
---

# Prompt Tagging Standards for Construct AI

This document outlines the standardized prompt tagging system for scalable prompt management across the ConstructAI platform.

## Hierarchical Tagging Pattern

### **Pattern Structure: `domain:function:variant`**

```
domain:function:variant
```

### **Examples:**
- `correspondence:agent:segregated` - All segregated correspondence agents
- `correspondence:analysis:document` - Document analysis functions
- `agent:order:01` - First agent in workflow sequence

## Implementation Details

### **Current Implementation:**
- **Correspondence Agents**: 7 segregated prompts with `correspondence:agent:segregated` + specific function tags
- **Filtering**: Easy wildcard filtering (e.g., `correspondence:*`, `agent:order:*`)
- **Scalability**: Hierarchical structure supports unlimited prompt expansion

### **Tagging Rules:**
- **Domain**: Represents the high-level category (correspondence, procurement, governance, etc.)
- **Function**: Describes the specific functionality or purpose
- **Variant**: Identifies variations or specific implementations

### **Usage Examples:**
- `safety:risk:assessment` - Safety risk assessment prompts
- `procurement:supplier:evaluation` - Supplier evaluation prompts
- `governance:compliance:audit` - Compliance audit prompts

## 📋 **CROSS-REFERENCE: File Structure & Implementation**

### **Correspondence Agent Implementation Map**

| **Prompt Key** | **Agent Code File** | **Prompt MD File** | **Primary Tag** |
|---|---|---|---|
| `agent_correspondence_01_document_analysis` | `correspondence-01-document-analysis-agent.js` | `contract_correspondence_analysis.md` | `correspondence:analysis:document` |
| `agent_correspondence_02_identifier_extraction` | `correspondence-02-information-extraction-agent.js` | `contract_identifier_extraction.md` | `correspondence:extraction:identifier` |
| `agent_correspondence_03_document_retrieval` | `correspondence-03-document-retrieval-agent.js` | `document_retrieval_agent.md` | `correspondence:retrieval:document` |
| `agent_correspondence_04_domain_specialist` | `correspondence-04-domain-specialist-agent.js` | `domain_specialist_agent.md` | `correspondence:specialist:domain` |
| `agent_correspondence_05_contract_management` | `correspondence-05-contract-management-agent.js` | `contract_management_agent.md` | `correspondence:management:contract` |
| `agent_correspondence_06_human_review` | `correspondence-06-human-review-agent.js` | `human_review_agent.md` | `correspondence:review:human` |
| `agent_correspondence_07_professional_formatting` | `correspondence-07-professional-formatting-agent.js` | `professional_formatting_agent.md` | `correspondence:formatting:professional` |

### **File Location Reference**

```
📦 docs/dev-prompts/00435-contracts-post-award/correspondence-workflow/
├── 📄 contract_correspondence_analysis.md     ← correspondence:analysis:document
├── 📄 contract_identifier_extraction.md       ← correspondence:extraction:identifier
├── 📄 document_retrieval_agent.md             ← correspondence:retrieval:document
├── 📄 domain_specialist_agent.md              ← correspondence:specialist:domain
├── 📄 contract_management_agent.md            ← correspondence:management:contract
├── 📄 human_review_agent.md                   ← correspondence:review:human
├── 📄 professional_formatting_agent.md        ← correspondence:formatting:professional
└── 📁 specialists/
    ├── 📄 civil.md                           ← specialist:discipline:civil
    ├── 📄 structural.md                      ← specialist:discipline:structural
    └── 📄 ... (16 more specialist disciplines)
```

### **Tagging Hierarchy Examples**

#### **Wildcard Filtering Examples:**
- `correspondence:*` → All correspondence-related prompts (7 agents + specialists)
- `correspondence:agent:*` → All correspondence agent prompts (7 agents)
- `correspondence:analysis:*` → Document analysis prompts
- `specialist:discipline:*` → All discipline specialist prompts (17 specialists)

#### **Tag Inheritance:**
- **Parent Tag**: `correspondence:agent:segregated` (applied to all 7 agents)
- **Function Tags**: `correspondence:analysis:document`, `correspondence:extraction:identifier`, etc.
- **Specialist Tags**: `specialist:discipline:{name}` for each engineering discipline

### **Maintenance Guidelines**

#### **When Adding New Tags:**
1. **Check Hierarchy**: Ensure new tags fit the `domain:function:variant` pattern
2. **Update Documentation**: Add new tags to this standards document
3. **Validate Usage**: Ensure tags are consistently applied across related prompts
4. **Update Filters**: Modify any filtering logic to accommodate new tag patterns

#### **Tag Consistency Validation:**
```javascript
// Example validation function
function validateTagConsistency(promptKey, tag) {
  const [domain, func, variant] = tag.split(':');

  // Correspondence agents should have 'correspondence' domain
  if (promptKey.startsWith('agent_correspondence_') && domain !== 'correspondence') {
    return false;
  }

  // Specialists should have 'specialist' domain
  if (promptKey.startsWith('specialist_') && domain !== 'specialist') {
    return false;
  }

  return true;
}
```

## Related Documentation

- Complete implementation details in `docs/pages-disciplines/1300_02050_PROMPT_MANAGEMENT_SYSTEM.md`
- Usage examples in `docs/pages-disciplines/1300_02050_MASTER_GUIDE.md`
- LangGraph integration in `docs/pages-disciplines/1300_02052_LANGCHAIN_LANGGRAPH_SYSTEM.md`
- **Cross-reference guide** in `docs/standards/0000_AGENT_CODING_STANDARDS.md`
