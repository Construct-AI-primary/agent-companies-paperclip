---
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, ai-agents, agent-framework, automation
openstinger_context: agent-development, ai-systems, automation-framework
last_updated: 2026-03-21
code_references:
  - src/agents/
  - src/ai/
related_docs:
  - codebase/architecture/system-overview.md
  - disciplines/01900_procurement/para-index.md
---
EOF && echo "Adding analysis header..." && cat > docs_construct_ai/codebase/analysis/_memory_header.md << 'EOF'
---
memory_layer: durable_knowledge
para_section: pages/codebase/analysis
gigabrain_tags: analysis, system-analysis, research, optimization
openstinger_context: system-analysis, performance-optimization, research
last_updated: 2026-03-21
related_docs:
  - codebase/architecture/system-overview.md
  - codebase/performance/
---
EOF && echo "Adding audits header..." && cat > docs_construct_ai/codebase/audits/_memory_header.md << 'EOF'
---
memory_layer: durable_knowledge
para_section: pages/codebase/audits
gigabrain_tags: audits, compliance, quality-assurance, security-audits
openstinger_context: compliance-auditing, quality-assurance, security-validation
last_updated: 2026-03-21
related_docs:
  - codebase/security/
  - codebase/testing/
---
EOF && echo "Headers created in directories"