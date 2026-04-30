#!/bin/bash
# Gold Star Enterprise - Remaining Skills Generation Script
# Generates all remaining skills for DomainForge, InfraForge, Loopy, PromptForge, QualityForge

SKILLS_BASE="construct-ai-docs/skills"

create_skill() {
    local path="$1"
    local name="$2"
    local description="$3"
    local overview="$4"
    local reports_to="$5"
    local company="$6"
    local role="$7"
    local tags="$8"
    local related="$9"
    local para_class="${10}"
    
    mkdir -p "$path"
    
    local title=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')
    
    cat > "$path/SKILL.md" << EOF
---
name: $name
description: >
  $description
---

# $title - $company $role

## Overview
$overview Reports to $reports_to.

## When to Use
- When $role capabilities are needed within $company
- When related tasks require specialized expertise
- When cross-team coordination is required
- **Don't use when:** Tasks outside this skill's scope (use appropriate specialized agent)

## Core Procedures
### Standard Workflow
1. **Receive Request** - Ingest requirements from $reports_to
2. **Analyze Requirements** - Determine scope and approach
3. **Execute Task** - Perform specialized work
4. **Quality Check** - Validate output quality
5. **Deliver Results** - Return completed work

## Agent Assignment
**Primary Agent:** $name
**Company:** $company
**Role:** $role
**Reports To:** $reports_to

## Success Metrics
- Task completion rate: >=95%
- Quality score: >=90%
- Response time: <4 hours
- Stakeholder satisfaction: >=90%

## Error Handling
- **Error:** Task execution failure
  **Response:** Retry with adjusted approach, escalate to $reports_to if persistent
- **Error:** Quality validation fails
  **Response:** Re-work task, apply quality improvements, re-validate

## Cross-Team Integration
**Gigabrain Tags:** $tags
**OpenStinger Context:** Session continuity, knowledge sharing
**PARA Classification:** $para_class
**Related Skills:** $related
**Last Updated:** 2026-03-04
EOF
}

echo "=== Generating DomainForge AI Skills ==="

create_skill "$SKILLS_BASE/domainforge-ai/civil-domainforge-civil-engineering" \
    "civil-domainforge-civil-engineering" \
    "Use when civil engineering design, site development, drainage systems, or civil infrastructure is needed within DomainForge AI. This agent handles civil engineering projects and infrastructure design." \
    "Civil handles civil engineering for DomainForge AI, providing site development, drainage design, road design, and civil infrastructure planning." \
    "orion-domainforge-ceo" "DomainForge AI" "Civil Engineering" \
    "domainforge, civil-engineering, site-development, infrastructure" \
    "orion-domainforge-ceo, structural-domainforge-structural-engineering" \
    "Civil engineering, infrastructure"

create_skill "$SKILLS_BASE/domainforge-ai/structural-domainforge-structural-engineering" \
    "structural-domainforge-structural-engineering" \
    "Use when structural engineering design, structural analysis, load calculations, or structural integrity assessment is needed within DomainForge AI. This agent handles structural engineering." \
    "Structural handles structural engineering for DomainForge AI, providing structural analysis, load calculations, design verification, and structural integrity assessment." \
    "orion-domainforge-ceo" "DomainForge AI" "Structural Engineering" \
    "domainforge, structural-engineering, structural-analysis, load-calculations" \
    "orion-domainforge-ceo, civil-domainforge-civil-engineering" \
    "Structural engineering, analysis"

create_skill "$SKILLS_BASE/domainforge-ai/geotechnical-domainforge-geotechnical-engineering" \
    "geotechnical-domainforge-geotechnical-engineering" \
    "Use when geotechnical engineering, soil analysis, foundation design, or ground investigation is needed within DomainForge AI. This agent handles geotechnical engineering." \
    "Geotechnical handles geotechnical engineering for DomainForge AI, providing soil analysis, foundation design, ground investigation, and geotechnical risk assessment." \
    "orion-domainforge-ceo" "DomainForge AI" "Geotechnical Engineering" \
    "domainforge, geotechnical-engineering, soil-analysis, foundation-design" \
    "orion-domainforge-ceo, civil-domainforge-civil-engineering" \
    "Geotechnical engineering, soil analysis"

create_skill "$SKILLS_BASE/domainforge-ai/transportation-domainforge-transportation-engineering" \
    "transportation-domainforge-transportation-engineering" \
    "Use when transportation engineering, highway design, traffic analysis, or transportation planning is needed within DomainForge AI. This agent handles transportation engineering." \
    "Transportation handles transportation engineering for DomainForge AI, providing highway design, traffic analysis, transportation planning, and mobility studies." \
    "orion-domainforge-ceo" "DomainForge AI" "Transportation Engineering" \
    "domainforge, transportation-engineering, highway-design, traffic-analysis" \
    "orion-domainforge-ceo, civil-domainforge-civil-engineering" \
    "Transportation engineering, traffic"

create_skill "$SKILLS_BASE/domainforge-ai/construction-domainforge-construction-engineering" \
    "construction-domainforge-construction-engineering" \
    "Use when construction engineering, construction management, site supervision, or construction planning is needed within DomainForge AI. This agent handles construction engineering." \
    "Construction handles construction engineering for DomainForge AI, providing construction management, site supervision, construction planning, and quality control." \
    "orion-domainforge-ceo" "DomainForge AI" "Construction Engineering" \
    "domainforge, construction-engineering, construction-management, site-supervision" \
    "orion-domainforge-ceo, safety-domainforge-safety-risk-management" \
    "Construction engineering, management"

create_skill "$SKILLS_BASE/domainforge-ai/safety-domainforge-safety-risk-management" \
    "safety-domainforge-safety-risk-management" \
    "Use when safety management, risk assessment, safety compliance, or hazard identification is needed within DomainForge AI. This agent handles safety and risk management." \
    "Safety handles safety risk management for DomainForge AI, providing risk assessment, safety compliance, hazard identification, and safety program management." \
    "orion-domainforge-ceo" "DomainForge AI" "Safety Risk Management" \
    "domainforge, safety-management, risk-assessment, hazard-identification" \
    "orion-domainforge-ceo, construction-domainforge-construction-engineering" \
    "Safety management, risk assessment"

create_skill "$SKILLS_BASE/domainforge-ai/procurement-domainforge-procurement-contracts" \
    "procurement-domainforge-procurement-contracts" \
    "Use when procurement management, contract administration, vendor management, or procurement planning is needed within DomainForge AI. This agent handles procurement and contracts." \
    "Procurement handles procurement contracts for DomainForge AI, providing contract administration, vendor management, procurement planning, and supplier coordination." \
    "orion-domainforge-ceo" "DomainForge AI" "Procurement Contracts" \
    "domainforge, procurement, contract-administration, vendor-management" \
    "orion-domainforge-ceo, logistics-domainforge-supply-chain" \
    "Procurement, contracts"

create_skill "$SKILLS_BASE/domainforge-ai/logistics-domainforge-supply-chain" \
    "logistics-domainforge-supply-chain" \
    "Use when logistics management, supply chain coordination, material planning, or distribution management is needed within DomainForge AI. This agent handles logistics." \
    "Logistics handles supply chain for DomainForge AI, providing logistics coordination, material planning, distribution management, and supply chain optimization." \
    "orion-domainforge-ceo" "DomainForge AI" "Supply Chain" \
    "domainforge, logistics, supply-chain, material-planning" \
    "orion-domainforge-ceo, procurement-domainforge-procurement-contracts" \
    "Logistics, supply chain"

create_skill "$SKILLS_BASE/domainforge-ai/finance-domainforge-finance-cost-management" \
    "finance-domainforge-finance-cost-management" \
    "Use when financial management, cost control, budget management, or financial planning is needed within DomainForge AI. This agent handles finance and cost management." \
    "Finance handles finance cost management for DomainForge AI, providing cost control, budget management, financial planning, and cost reporting." \
    "orion-domainforge-ceo" "DomainForge AI" "Finance Cost Management" \
    "domainforge, finance, cost-control, budget-management" \
    "orion-domainforge-ceo, procurement-domainforge-procurement-contracts" \
    "Finance, cost management"

create_skill "$SKILLS_BASE/domainforge-ai/quality-assurance-domainforge-quality-assurance" \
    "quality-assurance-domainforge-quality-assurance" \
    "Use when quality assurance planning, QA process development, quality audits, or quality system implementation is needed within DomainForge AI. This agent handles quality assurance." \
    "Quality Assurance handles quality assurance for DomainForge AI, providing QA planning, process development, quality audits, and quality system implementation." \
    "orion-domainforge-ceo" "DomainForge AI" "Quality Assurance" \
    "domainforge, quality-assurance, qa-planning, quality-audits" \
    "orion-domainforge-ceo, quality-control-domainforge-quality-control" \
    "Quality assurance, audits"

create_skill "$SKILLS_BASE/domainforge-ai/quality-control-domainforge-quality-control" \
    "quality-control-domainforge-quality-control" \
    "Use when quality control inspection, testing coordination, defect management, or quality metrics is needed within DomainForge AI. This agent handles quality control." \
    "Quality Control handles quality control for DomainForge AI, providing inspection coordination, testing management, defect tracking, and quality metrics." \
    "orion-domainforge-ceo" "DomainForge AI" "Quality Control" \
    "domainforge, quality-control, inspection, defect-management" \
    "orion-domainforge-ceo, quality-assurance-domainforge-quality-assurance" \
    "Quality control, inspection"

create_skill "$SKILLS_BASE/domainforge-ai/legal-domainforge-legal-regulatory-compliance" \
    "legal-domainforge-legal-regulatory-compliance" \
    "Use when legal compliance, regulatory review, contract legal review, or regulatory filing is needed within DomainForge AI. This agent handles legal and regulatory compliance." \
    "Legal handles legal regulatory compliance for DomainForge AI, providing regulatory review, contract legal review, compliance monitoring, and regulatory filing management." \
    "orion-domainforge-ceo" "DomainForge AI" "Legal Regulatory Compliance" \
    "domainforge, legal, regulatory-compliance, contract-review" \
    "orion-domainforge-ceo, safety-domainforge-safety-risk-management" \
    "Legal, regulatory compliance"

create_skill "$SKILLS_BASE/domainforge-ai/procurement-strategy-domainforge-procurement-strategy" \
    "procurement-strategy-domainforge-procurement-strategy" \
    "Use when procurement strategy development, sourcing strategy, procurement optimization, or strategic sourcing is needed within DomainForge AI. This agent handles procurement strategy." \
    "Procurement Strategy handles procurement strategy for DomainForge AI, providing sourcing strategy, procurement optimization, strategic sourcing, and supplier strategy." \
    "procurement-domainforge-procurement-contracts" "DomainForge AI" "Procurement Strategy" \
    "domainforge, procurement-strategy, sourcing, strategic-sourcing" \
    "procurement-domainforge-procurement-contracts, supplier-management-domainforge-supplier-management" \
    "Procurement strategy, sourcing"

create_skill "$SKILLS_BASE/domainforge-ai/supplier-management-domainforge-supplier-management" \
    "supplier-management-domainforge-supplier-management" \
    "Use when supplier management, supplier evaluation, supplier development, or supplier relationship management is needed within DomainForge AI. This agent handles supplier management." \
    "Supplier Management handles supplier management for DomainForge AI, providing supplier evaluation, development programs, relationship management, and performance monitoring." \
    "procurement-domainforge-procurement-contracts" "DomainForge AI" "Supplier Management" \
    "domainforge, supplier-management, supplier-evaluation, relationship-management" \
    "procurement-domainforge-procurement-contracts, procurement-strategy-domainforge-procurement-strategy" \
    "Supplier management, evaluation"

create_skill "$SKILLS_BASE/domainforge-ai/contract-administration-domainforge-contract-administration" \
    "contract-administration-domainforge-contract-administration" \
    "Use when contract administration, contract monitoring, change order management, or contract closeout is needed within DomainForge AI. This agent handles contract administration." \
    "Contract Administration handles contract administration for DomainForge AI, providing contract monitoring, change order management, claims management, and contract closeout." \
    "procurement-domainforge-procurement-contracts" "DomainForge AI" "Contract Administration" \
    "domainforge, contract-administration, contract-monitoring, change-orders" \
    "procurement-domainforge-procurement-contracts, legal-domainforge-legal-regulatory-compliance" \
    "Contract administration, monitoring"

create_skill "$SKILLS_BASE/domainforge-ai/procurement-analytics-domainforge-procurement-analytics" \
    "procurement-analytics-domainforge-procurement-analytics" \
    "Use when procurement analytics, spend analysis, procurement reporting, or procurement data analysis is needed within DomainForge AI. This agent handles procurement analytics." \
    "Procurement Analytics handles procurement analytics for DomainForge AI, providing spend analysis, procurement reporting, data analysis, and procurement intelligence." \
    "procurement-domainforge-procurement-contracts" "DomainForge AI" "Procurement Analytics" \
    "domainforge, procurement-analytics, spend-analysis, procurement-reporting" \
    "procurement-domainforge-procurement-contracts, finance-domainforge-finance-cost-management" \
    "Procurement analytics, spend analysis"

create_skill "$SKILLS_BASE/domainforge-ai/mobile-workflow-designer-domainforge-mobile-workflow" \
    "mobile-workflow-designer-domainforge-mobile-workflow" \
    "Use when mobile workflow design, mobile app design, mobile UX design, or mobile process optimization is needed within DomainForge AI. This agent handles mobile workflow design." \
    "Mobile Workflow Designer handles mobile workflow design for DomainForge AI, providing mobile app design, mobile UX, process optimization, and mobile interface design." \
    "orion-domainforge-ceo" "DomainForge AI" "Mobile Workflow" \
    "domainforge, mobile-workflow, mobile-design, mobile-ux" \
    "orion-domainforge-ceo, mobile-testing-domainforge-mobile-testing" \
    "Mobile workflow, design"

create_skill "$SKILLS_BASE/domainforge-ai/mobile-testing-domainforge-mobile-testing" \
    "mobile-testing-domainforge-mobile-testing" \
    "Use when mobile testing, mobile QA, device compatibility testing, or mobile performance testing is needed within DomainForge AI. This agent handles mobile testing." \
    "Mobile Testing handles mobile testing for DomainForge AI, providing mobile QA, device compatibility testing, performance testing, and mobile test automation." \
    "mobile-workflow-designer-domainforge-mobile-workflow" "DomainForge AI" "Mobile Testing" \
    "domainforge, mobile-testing, mobile-qa, device-compatibility" \
    "mobile-workflow-designer-domainforge-mobile-workflow, apex-qualityforge-ceo" \
    "Mobile testing, QA"

create_skill "$SKILLS_BASE/domainforge-ai/financial-compliance-domainforge-financial-compliance" \
    "financial-compliance-domainforge-financial-compliance" \
    "Use when financial compliance, audit preparation, financial regulation compliance, or financial reporting compliance is needed within DomainForge AI. This agent handles financial compliance." \
    "Financial Compliance handles financial compliance for DomainForge AI, providing audit preparation, regulation compliance, financial reporting compliance, and compliance monitoring." \
    "finance-domainforge-finance-cost-management" "DomainForge AI" "Financial Compliance" \
    "domainforge, financial-compliance, audit-preparation, regulation-compliance" \
    "finance-domainforge-finance-cost-management, legal-domainforge-legal-regulatory-compliance" \
    "Financial compliance, audit"

create_skill "$SKILLS_BASE/domainforge-ai/council-domainforge-governance-standards" \
    "council-domainforge-governance-standards" \
    "Use when engineering governance, standards enforcement, policy development, or engineering compliance is needed within DomainForge AI. This agent handles governance and standards." \
    "Council handles governance standards for DomainForge AI, providing engineering governance, standards enforcement, policy development, and compliance monitoring." \
    "orion-domainforge-ceo" "DomainForge AI" "Governance Standards" \
    "domainforge, governance, standards-enforcement, policy-development" \
    "orion-domainforge-ceo, strategos-domainforge-strategic-planning" \
    "Governance, standards"

create_skill "$SKILLS_BASE/domainforge-ai/strategos-domainforge-strategic-planning" \
    "strategos-domainforge-strategic-planning" \
    "Use when engineering strategic planning, market analysis for engineering services, or engineering growth strategy is needed within DomainForge AI. This agent handles strategic planning." \
    "Strategos handles strategic planning for DomainForge AI, providing engineering market analysis, growth strategy, competitive intelligence, and strategic roadmaps." \
    "orion-domainforge-ceo" "DomainForge AI" "Strategic Planning" \
    "domainforge, strategic-planning, market-analysis, growth-strategy" \
    "orion-domainforge-ceo, council-domainforge-governance-standards" \
    "Strategic planning, market analysis"

echo "=== Generating InfraForge AI Skills ==="

create_skill "$SKILLS_BASE/infraforge-ai/database-infraforge-database-infrastructure" \
    "database-infraforge-database-infrastructure" \
    "Use when database architecture, database optimization, database security, or database backup and recovery is needed within InfraForge AI. This agent handles database infrastructure." \
    "Database handles database infrastructure for InfraForge AI, providing database architecture, performance optimization, security management, and backup/recovery systems." \
    "orchestrator-infraforge-ceo" "InfraForge AI" "Database Infrastructure" \
    "infraforge, database, database-architecture, database-optimization" \
    "orchestrator-infraforge-ceo, mobile-api-infraforge-mobile-api-integration" \
    "Database infrastructure, optimization"

create_skill "$SKILLS_BASE/infraforge-ai/mobile-api-infraforge-mobile-api-integration" \
    "mobile-api-infraforge-mobile-api-integration" \
    "Use when mobile API design, API gateway management, mobile authentication, or offline sync is needed within InfraForge AI. This agent handles mobile API integration." \
    "Mobile API handles mobile API integration for InfraForge AI, providing API gateway management, mobile authentication, offline sync, and push notification systems." \
    "orchestrator-infraforge-ceo" "InfraForge AI" "Mobile API Integration" \
    "infraforge, mobile-api, api-gateway, mobile-authentication" \
    "orchestrator-infraforge-ceo, database-infraforge-database-infrastructure" \
    "Mobile API, integration"

create_skill "$SKILLS_BASE/infraforge-ai/supply-chain-integration-infraforge-supply-chain" \
    "supply-chain-integration-infraforge-supply-chain" \
    "Use when supply chain system integration, supplier portal development, delivery tracking systems, or inventory management integration is needed within InfraForge AI. This agent handles supply chain integration." \
    "Supply Chain Integration handles supply chain integration for InfraForge AI, providing supplier portals, delivery tracking, inventory management, and EDI/API integration." \
    "orchestrator-infraforge-ceo" "InfraForge AI" "Supply Chain Integration" \
    "infraforge, supply-chain, supplier-portals, delivery-tracking" \
    "orchestrator-infraforge-ceo, database-infraforge-database-infrastructure" \
    "Supply chain, integration"

echo "=== Generating Loopy AI Skills ==="

create_skill "$SKILLS_BASE/loopy-ai/alex-loopy-deep-research" \
    "alex-loopy-deep-research" \
    "Use when deep research, strategic insights, competitive research, or creative AI research is needed within Loopy AI. This agent handles comprehensive research and analysis." \
    "Alex handles deep research for Loopy AI, providing strategic insights, competitive research, creative AI research, and market intelligence for creative initiatives." \
    "vision-loopy-ceo" "Loopy AI" "Deep Research" \
    "loopy, deep-research, strategic-insights, competitive-research" \
    "vision-loopy-ceo, maya-loopy-content-strategist" \
    "Deep research, strategic insights"

create_skill "$SKILLS_BASE/loopy-ai/maya-loopy-content-strategist" \
    "maya-loopy-content-strategist" \
    "Use when content strategy development, brand voice creation, content calendar planning, or audience engagement strategy is needed within Loopy AI. This agent handles content strategy." \
    "Maya handles content strategy for Loopy AI, providing brand voice development, content calendar planning, audience engagement strategy, and content governance." \
    "vision-loopy-ceo" "Loopy AI" "Content Strategist" \
    "loopy, content-strategy, brand-voice, content-calendar" \
    "vision-loopy-ceo, alex-loopy-deep-research" \
    "Content strategy, brand voice"

create_skill "$SKILLS_BASE/loopy-ai/jordan-loopy-marketing-specialist" \
    "jordan-loopy-marketing-specialist" \
    "Use when marketing campaign development, brand positioning, digital marketing strategy, or marketing analytics is needed within Loopy AI. This agent handles marketing." \
    "Jordan handles marketing for Loopy AI, providing campaign development, brand positioning, digital marketing strategy, and marketing analytics." \
    "vision-loopy-ceo" "Loopy AI" "Marketing Specialist" \
    "loopy, marketing, campaign-development, brand-positioning" \
    "vision-loopy-ceo, maya-loopy-content-strategist" \
    "Marketing, campaigns"

create_skill "$SKILLS_BASE/loopy-ai/sam-loopy-social-media-coordinator" \
    "sam-loopy-social-media-coordinator" \
    "Use when social media management, community engagement, social analytics, or trend monitoring is needed within Loopy AI. This agent handles social media." \
    "Sam handles social media for Loopy AI, providing content creation, community management, social analytics, trend monitoring, and social media strategy." \
    "jordan-loopy-marketing-specialist" "Loopy AI" "Social Media Coordinator" \
    "loopy, social-media, community-management, social-analytics" \
    "jordan-loopy-marketing-specialist, vision-loopy-ceo" \
    "Social media, community"

create_skill "$SKILLS_BASE/loopy-ai/dev-loopy-technical-creative" \
    "dev-loopy-technical-creative" \
    "Use when creative technology development, interactive media, creative tool integration, or technical creative implementation is needed within Loopy AI. This agent handles technical creative." \
    "Dev handles technical creative for Loopy AI, providing creative technology development, interactive media, tool integration, and technical creative support." \
    "vision-loopy-ceo" "Loopy AI" "Technical Creative" \
    "loopy, creative-technology, interactive-media, tool-integration" \
    "vision-loopy-ceo, nexus-devforge-ceo" \
    "Technical creative, interactive"

echo "=== Generating PromptForge AI Skills ==="

create_skill "$SKILLS_BASE/promptforge-ai/blueprint-promptforge-template-designer" \
    "blueprint-promptforge-template-designer" \
    "Use when prompt template design, prompt architecture patterns, template libraries, or prompt structure design is needed within PromptForge AI. This agent handles template design." \
    "Blueprint handles template design for PromptForge AI, providing prompt architecture patterns, template libraries, structure design, and reusable prompt components." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Template Designer" \
    "promptforge, template-design, prompt-architecture, prompt-patterns" \
    "sage-promptforge-chief-architect, cascade-promptforge-workflow-designer" \
    "Template design, patterns"

create_skill "$SKILLS_BASE/promptforge-ai/cascade-promptforge-workflow-designer" \
    "cascade-promptforge-workflow-designer" \
    "Use when multi-agent workflow design, workflow orchestration, agent handoff design, or workflow state management is needed within PromptForge AI. This agent handles workflow design." \
    "Cascade handles workflow design for PromptForge AI, providing multi-agent workflow orchestration, agent handoff design, state management, and workflow optimization." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Workflow Designer" \
    "promptforge, workflow-design, multi-agent, agent-handoff" \
    "sage-promptforge-chief-architect, flowdesigner-promptforge-agent-handoff" \
    "Workflow design, orchestration"

create_skill "$SKILLS_BASE/promptforge-ai/flowdesigner-promptforge-agent-handoff" \
    "flowdesigner-promptforge-agent-handoff" \
    "Use when agent handoff protocols, transition optimization, context transfer, or handoff validation is needed within PromptForge AI. This agent handles agent handoffs." \
    "FlowDesigner handles agent handoff for PromptForge AI, providing handoff protocols, transition optimization, context transfer, and handoff validation." \
    "cascade-promptforge-workflow-designer" "PromptForge AI" "Agent Handoff" \
    "promptforge, agent-handoff, context-transfer, transition-optimization" \
    "cascade-promptforge-workflow-designer, statemaster-promptforge-state-management" \
    "Agent handoff, transitions"

create_skill "$SKILLS_BASE/promptforge-ai/harmonic-promptforge-orchestration-strategy" \
    "harmonic-promptforge-orchestration-strategy" \
    "Use when orchestration strategy development, multi-agent coordination strategy, orchestration optimization, or coordination patterns is needed within PromptForge AI. This agent handles orchestration strategy." \
    "Harmonic handles orchestration strategy for PromptForge AI, providing multi-agent coordination strategy, orchestration optimization, coordination patterns, and strategy refinement." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Orchestration Strategy" \
    "promptforge, orchestration-strategy, multi-agent-coordination, coordination-patterns" \
    "sage-promptforge-chief-architect, cascade-promptforge-workflow-designer" \
    "Orchestration strategy, coordination"

create_skill "$SKILLS_BASE/promptforge-ai/statemaster-promptforge-state-management" \
    "statemaster-promptforge-state-management" \
    "Use when state management, context preservation, session state tracking, or state recovery is needed within PromptForge AI. This agent handles state management." \
    "StateMaster handles state management for PromptForge AI, providing context preservation, session state tracking, state recovery, and state synchronization." \
    "sage-promptforge-chief-architect" "PromptForge AI" "State Management" \
    "promptforge, state-management, context-preservation, session-tracking" \
    "sage-promptforge-chief-architect, flowdesigner-promptforge-agent-handoff" \
    "State management, context"

create_skill "$SKILLS_BASE/promptforge-ai/experimenter-promptforge-hypothesis-testing" \
    "experimenter-promptforge-hypothesis-testing" \
    "Use when prompt hypothesis testing, prompt experimentation, A/B testing design, or experimental validation is needed within PromptForge AI. This agent handles hypothesis testing." \
    "Experimenter handles hypothesis testing for PromptForge AI, providing prompt experimentation, A/B testing design, experimental validation, and test result analysis." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Hypothesis Testing" \
    "promptforge, hypothesis-testing, experimentation, ab-testing" \
    "sage-promptforge-chief-architect, tuner-promptforge-ab-testing" \
    "Hypothesis testing, experimentation"

create_skill "$SKILLS_BASE/promptforge-ai/explorer-promptforge-new-techniques" \
    "explorer-promptforge-new-techniques" \
    "Use when new prompt technique exploration, emerging prompt patterns research, prompt innovation, or technique evaluation is needed within PromptForge AI. This agent handles new techniques." \
    "Explorer handles new techniques for PromptForge AI, providing prompt technique exploration, emerging pattern research, innovation discovery, and technique evaluation." \
    "sage-promptforge-chief-architect" "PromptForge AI" "New Techniques" \
    "promptforge, new-techniques, prompt-innovation, technique-exploration" \
    "sage-promptforge-chief-architect, enhancer-promptforge-advanced-innovation" \
    "New techniques, innovation"

create_skill "$SKILLS_BASE/promptforge-ai/scholar-promptforge-academic-research" \
    "scholar-promptforge-academic-research" \
    "Use when academic research on prompting, literature review, research synthesis, or academic validation is needed within PromptForge AI. This agent handles academic research." \
    "Scholar handles academic research for PromptForge AI, providing literature review, research synthesis, academic validation, and research-to-practice translation." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Academic Research" \
    "promptforge, academic-research, literature-review, research-synthesis" \
    "sage-promptforge-chief-architect, explorer-promptforge-new-techniques" \
    "Academic research, literature"

create_skill "$SKILLS_BASE/promptforge-ai/enhancer-promptforge-advanced-innovation" \
    "enhancer-promptforge-advanced-innovation" \
    "Use when advanced prompt innovation, creative prompt solutions, prompt enhancement, or innovation implementation is needed within PromptForge AI. This agent handles advanced innovation." \
    "Enhancer handles advanced innovation for PromptForge AI, providing creative prompt solutions, prompt enhancement, innovation implementation, and advanced technique development." \
    "explorer-promptforge-new-techniques" "PromptForge AI" "Advanced Innovation" \
    "promptforge, advanced-innovation, creative-solutions, prompt-enhancement" \
    "explorer-promptforge-new-techniques, specialist-promptforge-domain-adaptation" \
    "Advanced innovation, enhancement"

create_skill "$SKILLS_BASE/promptforge-ai/specialist-promptforge-domain-adaptation" \
    "specialist-promptforge-domain-adaptation" \
    "Use when domain-specific prompt adaptation, industry prompt customization, domain knowledge integration, or specialized prompt design is needed within PromptForge AI. This agent handles domain adaptation." \
    "Specialist handles domain adaptation for PromptForge AI, providing industry prompt customization, domain knowledge integration, specialized design, and domain validation." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Domain Adaptation" \
    "promptforge, domain-adaptation, industry-customization, domain-knowledge" \
    "sage-promptforge-chief-architect, enhancer-promptforge-advanced-innovation" \
    "Domain adaptation, customization"

create_skill "$SKILLS_BASE/promptforge-ai/integrity-promptforge-ethical-ai" \
    "integrity-promptforge-ethical-ai" \
    "Use when ethical AI validation, prompt safety review, bias detection, or ethical compliance checking is needed within PromptForge AI. This agent handles ethical AI." \
    "Integrity handles ethical AI for PromptForge AI, providing prompt safety review, bias detection, ethical compliance checking, and AI safety validation." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Ethical AI" \
    "promptforge, ethical-ai, prompt-safety, bias-detection" \
    "sage-promptforge-chief-architect, compliance-promptforge-regulatory-compliance" \
    "Ethical AI, safety"

create_skill "$SKILLS_BASE/promptforge-ai/compliance-promptforge-regulatory-compliance" \
    "compliance-promptforge-regulatory-compliance" \
    "Use when regulatory compliance checking, prompt regulation alignment, compliance auditing, or regulatory reporting is needed within PromptForge AI. This agent handles regulatory compliance." \
    "Compliance handles regulatory compliance for PromptForge AI, providing regulation alignment, compliance auditing, regulatory reporting, and compliance monitoring." \
    "integrity-promptforge-ethical-ai" "PromptForge AI" "Regulatory Compliance" \
    "promptforge, regulatory-compliance, compliance-auditing, regulation-alignment" \
    "integrity-promptforge-ethical-ai, validator-promptforge-syntax-logic-validation" \
    "Regulatory compliance, auditing"

create_skill "$SKILLS_BASE/promptforge-ai/predictor-promptforge-outcome-prediction" \
    "predictor-promptforge-outcome-prediction" \
    "Use when prompt outcome prediction, response quality prediction, prompt success forecasting, or outcome modeling is needed within PromptForge AI. This agent handles outcome prediction." \
    "Predictor handles outcome prediction for PromptForge AI, providing response quality prediction, success forecasting, outcome modeling, and prediction validation." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Outcome Prediction" \
    "promptforge, outcome-prediction, quality-prediction, success-forecasting" \
    "sage-promptforge-chief-architect, analyzer-promptforge-prompt-analytics" \
    "Outcome prediction, forecasting"

create_skill "$SKILLS_BASE/promptforge-ai/refiner-promptforge-version-control" \
    "refiner-promptforge-version-control" \
    "Use when prompt version control, prompt iteration management, version tracking, or prompt change management is needed within PromptForge AI. This agent handles version control." \
    "Refiner handles version control for PromptForge AI, providing prompt iteration management, version tracking, change management, and version history." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Version Control" \
    "promptforge, version-control, iteration-management, change-tracking" \
    "sage-promptforge-chief-architect, validator-promptforge-syntax-logic-validation" \
    "Version control, iterations"

create_skill "$SKILLS_BASE/promptforge-ai/analyzer-promptforge-prompt-analytics" \
    "analyzer-promptforge-prompt-analytics" \
    "Use when prompt analytics, performance analysis, usage metrics, or prompt effectiveness measurement is needed within PromptForge AI. This agent handles prompt analytics." \
    "Analyzer handles prompt analytics for PromptForge AI, providing performance analysis, usage metrics, effectiveness measurement, and analytics reporting." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Prompt Analytics" \
    "promptforge, prompt-analytics, performance-analysis, usage-metrics" \
    "sage-promptforge-chief-architect, clarity-promptforge-performance-optimization" \
    "Prompt analytics, performance"

create_skill "$SKILLS_BASE/promptforge-ai/clarity-promptforge-performance-optimization" \
    "clarity-promptforge-performance-optimization" \
    "Use when prompt performance optimization, latency reduction, throughput improvement, or performance tuning is needed within PromptForge AI. This agent handles performance optimization." \
    "Clarity handles performance optimization for PromptForge AI, providing latency reduction, throughput improvement, performance tuning, and optimization validation." \
    "analyzer-promptforge-prompt-analytics" "PromptForge AI" "Performance Optimization" \
    "promptforge, performance-optimization, latency-reduction, throughput-improvement" \
    "analyzer-promptforge-prompt-analytics, quantifier-promptforge-benchmarking" \
    "Performance optimization, tuning"

create_skill "$SKILLS_BASE/promptforge-ai/tuner-promptforge-ab-testing" \
    "tuner-promptforge-ab-testing" \
    "Use when A/B testing execution, variant comparison, statistical analysis, or test result interpretation is needed within PromptForge AI. This agent handles A/B testing." \
    "Tuner handles A/B testing for PromptForge AI, providing variant comparison, statistical analysis, test result interpretation, and testing optimization." \
    "experimenter-promptforge-hypothesis-testing" "PromptForge AI" "A/B Testing" \
    "promptforge, ab-testing, variant-comparison, statistical-analysis" \
    "experimenter-promptforge-hypothesis-testing, quantifier-promptforge-benchmarking" \
    "A/B testing, variants"

create_skill "$SKILLS_BASE/promptforge-ai/quantifier-promptforge-benchmarking" \
    "quantifier-promptforge-benchmarking" \
    "Use when prompt benchmarking, performance benchmarking, quality benchmarking, or benchmark comparison is needed within PromptForge AI. This agent handles benchmarking." \
    "Quantifier handles benchmarking for PromptForge AI, providing performance benchmarking, quality benchmarking, benchmark comparison, and benchmark reporting." \
    "clarity-promptforge-performance-optimization" "PromptForge AI" "Benchmarking" \
    "promptforge, benchmarking, performance-benchmarking, quality-benchmarking" \
    "clarity-promptforge-performance-optimization, tuner-promptforge-ab-testing" \
    "Benchmarking, comparison"

create_skill "$SKILLS_BASE/promptforge-ai/archivist-promptforge-knowledge-management" \
    "archivist-promptforge-knowledge-management" \
    "Use when prompt knowledge management, prompt library organization, knowledge retrieval, or knowledge sharing is needed within PromptForge AI. This agent handles knowledge management." \
    "Archivist handles knowledge management for PromptForge AI, providing prompt library organization, knowledge retrieval, knowledge sharing, and content governance." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Knowledge Management" \
    "promptforge, knowledge-management, prompt-library, knowledge-retrieval" \
    "sage-promptforge-chief-architect, collaborator-promptforge-cross-company-knowledge-sharing" \
    "Knowledge management, library"

create_skill "$SKILLS_BASE/promptforge-ai/integration-promptforge-cross-agent-compatibility" \
    "integration-promptforge-cross-agent-compatibility" \
    "Use when cross-agent compatibility testing, integration validation, agent interface management, or compatibility assurance is needed within PromptForge AI. This agent handles cross-agent compatibility." \
    "Integration handles cross-agent compatibility for PromptForge AI, providing compatibility testing, integration validation, interface management, and compatibility assurance." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Cross-Agent Compatibility" \
    "promptforge, cross-agent, compatibility-testing, integration-validation" \
    "sage-promptforge-chief-architect, collaborator-promptforge-cross-company-knowledge-sharing" \
    "Cross-agent compatibility, integration"

create_skill "$SKILLS_BASE/promptforge-ai/collaborator-promptforge-cross-company-knowledge-sharing" \
    "collaborator-promptforge-cross-company-knowledge-sharing" \
    "Use when cross-company knowledge sharing, inter-company collaboration, knowledge transfer, or collaborative learning is needed within PromptForge AI. This agent handles knowledge sharing." \
    "Collaborator handles cross-company knowledge sharing for PromptForge AI, providing knowledge transfer, collaborative learning, inter-company coordination, and knowledge synchronization." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Cross-Company Knowledge Sharing" \
    "promptforge, knowledge-sharing, cross-company, collaborative-learning" \
    "sage-promptforge-chief-architect, integration-promptforge-cross-agent-compatibility" \
    "Knowledge sharing, collaboration"

create_skill "$SKILLS_BASE/promptforge-ai/validator-promptforge-syntax-logic-validation" \
    "validator-promptforge-syntax-logic-validation" \
    "Use when prompt syntax validation, logic validation, prompt structure checking, or validation reporting is needed within PromptForge AI. This agent handles validation." \
    "Validator handles syntax logic validation for PromptForge AI, providing syntax checking, logic validation, structure verification, and validation reporting." \
    "sage-promptforge-chief-architect" "PromptForge AI" "Syntax Logic Validation" \
    "promptforge, syntax-validation, logic-validation, structure-verification" \
    "sage-promptforge-chief-architect, integrity-promptforge-ethical-ai" \
    "Validation, syntax"

echo "=== Generating QualityForge AI Skills ==="

create_skill "$SKILLS_BASE/qualityforge-ai/governor-qualityforge-quality-director" \
    "governor-qualityforge-quality-director" \
    "Use when quality strategy development, quality team leadership, quality program management, or quality governance is needed within QualityForge AI. This agent handles quality direction." \
    "Governor handles quality direction for QualityForge AI, providing quality strategy, team leadership, program management, and quality governance." \
    "apex-qualityforge-ceo" "QualityForge AI" "Quality Director" \
    "qualityforge, quality-direction, quality-strategy, quality-governance" \
    "apex-qualityforge-ceo, guardian-qualityforge-quality-guardian" \
    "Quality direction, strategy"

create_skill "$SKILLS_BASE/qualityforge-ai/guardian-qualityforge-quality-guardian" \
    "guardian-qualityforge-quality-guardian" \
    "Use when quality monitoring, quality standard enforcement, quality gate management, or quality oversight is needed within QualityForge AI. This agent handles quality guardianship." \
    "Guardian handles quality guardianship for QualityForge AI, providing quality monitoring, standard enforcement, gate management, and quality oversight." \
    "governor-qualityforge-quality-director" "QualityForge AI" "Quality Guardian" \
    "qualityforge, quality-monitoring, standard-enforcement, quality-gates" \
    "governor-qualityforge-quality-director, monitor-qualityforge-quality-monitor" \
    "Quality guardianship, monitoring"

create_skill "$SKILLS_BASE/qualityforge-ai/reporter-qualityforge-quality-reporter" \
    "reporter-qualityforge-quality-reporter" \
    "Use when quality reporting, metrics reporting, quality dashboard creation, or quality status communication is needed within QualityForge AI. This agent handles quality reporting." \
    "Reporter handles quality reporting for QualityForge AI, providing metrics reporting, dashboard creation, status communication, and quality documentation." \
    "governor-qualityforge-quality-director" "QualityForge AI" "Quality Reporter" \
    "qualityforge, quality-reporting, metrics-reporting, quality-dashboards" \
    "governor-qualityforge-quality-director, monitor-qualityforge-quality-monitor" \
    "Quality reporting, metrics"

create_skill "$SKILLS_BASE/qualityforge-ai/trainer-qualityforge-quality-trainer" \
    "trainer-qualityforge-quality-trainer" \
    "Use when quality training, quality education, best practices training, or quality awareness programs is needed within QualityForge AI. This agent handles quality training." \
    "Trainer handles quality training for QualityForge AI, providing quality education, best practices training, awareness programs, and quality competency development." \
    "governor-qualityforge-quality-director" "QualityForge AI" "Quality Trainer" \
    "qualityforge, quality-training, quality-education, best-practices" \
    "governor-qualityforge-quality-director, standards-qualityforge-standards-enforcer" \
    "Quality training, education"

create_skill "$SKILLS_BASE/qualityforge-ai/standards-qualityforge-standards-enforcer" \
    "standards-qualityforge-standards-enforcer" \
    "Use when quality standards development, standards enforcement, coding standards validation, or quality policy creation is needed within QualityForge AI. This agent handles standards enforcement." \
    "Standards handles standards enforcement for QualityForge AI, providing standards development, enforcement, coding standards validation, and quality policy creation." \
    "governor-qualityforge-quality-director" "QualityForge AI" "Standards Enforcer" \
    "qualityforge, standards-enforcement, quality-standards, coding-standards" \
    "governor-qualityforge-quality-director, guardian-qualityforge-quality-guardian" \
    "Standards enforcement, policies"

create_skill "$SKILLS_BASE/qualityforge-ai/monitor-qualityforge-quality-monitor" \
    "monitor-qualityforge-quality-monitor" \
    "Use when quality monitoring, continuous quality tracking, quality trend analysis, or quality alert management is needed within QualityForge AI. This agent handles quality monitoring." \
    "Monitor handles quality monitoring for QualityForge AI, providing continuous tracking, trend analysis, alert management, and quality observation." \
    "guardian-qualityforge-quality-guardian" "QualityForge AI" "Quality Monitor" \
    "qualityforge, quality-monitoring, continuous-tracking, trend-analysis" \
    "guardian-qualityforge-quality-guardian, reporter-qualityforge-quality-reporter" \
    "Quality monitoring, tracking"

create_skill "$SKILLS_BASE/qualityforge-ai/validator-qualityforge-validator" \
    "validator-qualityforge-validator" \
    "Use when output validation, deliverable validation, quality verification, or validation testing is needed within QualityForge AI. This agent handles validation." \
    "Validator handles validation for QualityForge AI, providing output validation, deliverable verification, quality checking, and validation testing." \
    "guardian-qualityforge-quality-guardian" "QualityForge AI" "Validator" \
    "qualityforge, validation, output-validation, deliverable-verification" \
    "guardian-qualityforge-quality-guardian, standards-qualityforge-standards-enforcer" \
    "Validation, verification"

create_skill "$SKILLS_BASE/qualityforge-ai/documenter-qualityforge-documentation-specialist" \
    "documenter-qualityforge-documentation-specialist" \
    "Use when quality documentation, test documentation, quality procedure creation, or documentation review is needed within QualityForge AI. This agent handles quality documentation." \
    "Documenter handles quality documentation for QualityForge AI, providing test documentation, procedure creation, documentation review, and quality record management." \
    "governor-qualityforge-quality-director" "QualityForge AI" "Documentation Specialist" \
    "qualityforge, quality-documentation, test-documentation, procedure-creation" \
    "governor-qualityforge-quality-director, reporter-qualityforge-quality-reporter" \
    "Quality documentation, procedures"

create_skill "$SKILLS_BASE/qualityforge-ai/optimizer-qualityforge-code-optimizer" \
    "optimizer-qualityforge-code-optimizer" \
    "Use when code optimization, performance optimization, code refactoring for quality, or optimization validation is needed within QualityForge AI. This agent handles code optimization." \
    "Optimizer handles code optimization for QualityForge AI, providing performance optimization, code refactoring, optimization validation, and efficiency improvement." \
    "apex-qualityforge-ceo" "QualityForge AI" "Code Optimizer" \
    "qualityforge, code-optimization, performance-optimization, code-refactoring" \
    "apex-qualityforge-ceo, refactor-qualityforge-refactoring-specialist" \
    "Code optimization, performance"

create_skill "$SKILLS_BASE/qualityforge-ai/migrator-qualityforge-migration-specialist" \
    "migrator-qualityforge-migration-specialist" \
    "Use when code migration, system migration, migration testing, or migration quality assurance is needed within QualityForge AI. This agent handles migration." \
    "Migrator handles migration for QualityForge AI, providing code migration, system migration, migration testing, and migration quality assurance." \
    "apex-qualityforge-ceo" "QualityForge AI" "Migration Specialist" \
    "qualityforge, migration, code-migration, migration-testing" \
    "apex-qualityforge-ceo, optimizer-qualityforge-code-optimizer" \
    "Migration, code migration"

create_skill "$SKILLS_BASE/qualityforge-ai/compatibility-qualityforge-compatibility-testing" \
    "compatibility-qualityforge-compatibility-testing" \
    "Use when compatibility testing, cross-platform testing, browser compatibility, or device compatibility testing is needed within QualityForge AI. This agent handles compatibility testing." \
    "Compatibility handles compatibility testing for QualityForge AI, providing cross-platform testing, browser compatibility, device testing, and compatibility validation." \
    "apex-qualityforge-ceo" "QualityForge AI" "Compatibility Testing" \
    "qualityforge, compatibility-testing, cross-platform, browser-compatibility" \
    "apex-qualityforge-ceo, e2e-qualityforge-end-to-end-testing" \
    "Compatibility testing, cross-platform"

create_skill "$SKILLS_BASE/qualityforge-ai/load-qualityforge-load-testing" \
    "load-qualityforge-load-testing" \
    "Use when load testing, stress testing, capacity testing, or load analysis is needed within QualityForge AI. This agent handles load testing." \
    "Load handles load testing for QualityForge AI, providing stress testing, capacity testing, load analysis, and performance under load validation." \
    "apex-qualityforge-ceo" "QualityForge AI" "Load Testing" \
    "qualityforge, load-testing, stress-testing, capacity-testing" \
    "apex-qualityforge-ceo, performance-qualityforge-performance-testing" \
    "Load testing, stress testing"

create_skill "$SKILLS_BASE/qualityforge-ai/integration-qualityforge-integration-testing" \
    "integration-qualityforge-integration-testing" \
    "Use when integration testing, API testing, service integration testing, or interface testing is needed within QualityForge AI. This agent handles integration testing." \
    "Integration handles integration testing for QualityForge AI, providing API testing, service integration testing, interface testing, and integration validation." \
    "apex-qualityforge-ceo" "QualityForge AI" "Integration Testing" \
    "qualityforge, integration-testing, api-testing, service-integration" \
    "apex-qualityforge-ceo, e2e-qualityforge-end-to-end-testing" \
    "Integration testing, API testing"

create_skill "$SKILLS_BASE/qualityforge-ai/performance-qualityforge-performance-testing" \
    "performance-qualityforge-performance-testing" \
    "Use when performance testing, response time testing, throughput testing, or performance benchmarking is needed within QualityForge AI. This agent handles performance testing." \
    "Performance handles performance testing for QualityForge AI, providing response time testing, throughput testing, performance benchmarking, and performance validation." \
    "apex-qualityforge-ceo" "QualityForge AI" "Performance Testing" \
    "qualityforge, performance-testing, response-time, throughput-testing" \
    "apex-qualityforge-ceo, load-qualityforge-load-testing" \
    "Performance testing, benchmarking"

create_skill "$SKILLS_BASE/qualityforge-ai/e2e-qualityforge-end-to-end-testing" \
    "e2e-qualityforge-end-to-end-testing" \
    "Use when end-to-end testing, user journey testing, workflow testing, or E2E automation is needed within QualityForge AI. This agent handles end-to-end testing." \
    "E2E handles end-to-end testing for QualityForge AI, providing user journey testing, workflow testing, E2E automation, and full system validation." \
    "apex-qualityforge-ceo" "QualityForge AI" "End-to-End Testing" \
    "qualityforge, e2e-testing, user-journey, workflow-testing" \
    "apex-qualityforge-ceo, integration-qualityforge-integration-testing" \
    "E2E testing, user journeys"

create_skill "$SKILLS_BASE/qualityforge-ai/automation-qualityforge-test-automation" \
    "automation-qualityforge-test-automation" \
    "Use when test automation development, automation framework creation, test script development, or automation maintenance is needed within QualityForge AI. This agent handles test automation." \
    "Automation handles test automation for QualityForge AI, providing automation framework creation, test script development, automation maintenance, and CI/CD integration." \
    "apex-qualityforge-ceo" "QualityForge AI" "Test Automation" \
    "qualityforge, test-automation, automation-framework, test-scripts" \
    "apex-qualityforge-ceo, e2e-qualityforge-end-to-end-testing" \
    "Test automation, frameworks"

create_skill "$SKILLS_BASE/qualityforge-ai/accessibility-qualityforge-accessibility-testing" \
    "accessibility-qualityforge-accessibility-testing" \
    "Use when accessibility testing, WCAG compliance testing, screen reader testing, or accessibility auditing is needed within QualityForge AI. This agent handles accessibility testing." \
    "Accessibility handles accessibility testing for QualityForge AI, providing WCAG compliance testing, screen reader testing, accessibility auditing, and inclusive design validation." \
    "apex-qualityforge-ceo" "QualityForge AI" "Accessibility Testing" \
    "qualityforge, accessibility-testing, wcag-compliance, screen-reader" \
    "apex-qualityforge-ceo, e2e-qualityforge-end-to-end-testing" \
    "Accessibility testing, WCAG"

create_skill "$SKILLS_BASE/qualityforge-ai/coverage-qualityforge-test-coverage-analyst" \
    "coverage-qualityforge-test-coverage-analyst" \
    "Use when test coverage analysis, coverage reporting, coverage gap identification, or coverage optimization is needed within QualityForge AI. This agent handles test coverage." \
    "Coverage handles test coverage analysis for QualityForge AI, providing coverage reporting, gap identification, coverage optimization, and coverage metrics." \
    "apex-qualityforge-ceo" "QualityForge AI" "Test Coverage Analyst" \
    "qualityforge, test-coverage, coverage-reporting, coverage-gaps" \
    "apex-qualityforge-ceo, automation-qualityforge-test-automation" \
    "Test coverage, analysis"

create_skill "$SKILLS_BASE/qualityforge-ai/probe-qualityforge-prompt-testing" \
    "probe-qualityforge-prompt-testing" \
    "Use when prompt testing, prompt quality validation, prompt output testing, or prompt effectiveness testing is needed within QualityForge AI. This agent handles prompt testing." \
    "Probe handles prompt testing for QualityForge AI, providing prompt quality validation, output testing, effectiveness testing, and prompt validation." \
    "apex-qualityforge-ceo" "QualityForge AI" "Prompt Testing" \
    "qualityforge, prompt-testing, prompt-validation, output-testing" \
    "apex-qualityforge-ceo, sage-promptforge-chief-architect" \
    "Prompt testing, validation"

create_skill "$SKILLS_BASE/qualityforge-ai/simulator-qualityforge-workflow-simulation" \
    "simulator-qualityforge-workflow-simulation" \
    "Use when workflow simulation, process simulation, scenario testing, or simulation analysis is needed within QualityForge AI. This agent handles workflow simulation." \
    "Simulator handles workflow simulation for QualityForge AI, providing process simulation, scenario testing, simulation analysis, and workflow validation." \
    "apex-qualityforge-ceo" "QualityForge AI" "Workflow Simulation" \
    "qualityforge, workflow-simulation, process-simulation, scenario-testing" \
    "apex-qualityforge-ceo, loadtester-qualityforge-scalability-testing" \
    "Workflow simulation, scenarios"

create_skill "$SKILLS_BASE/qualityforge-ai/loadtester-qualityforge-scalability-testing" \
    "loadtester-qualityforge-scalability-testing" \
    "Use when scalability testing, scale testing, growth capacity testing, or scalability analysis is needed within QualityForge AI. This agent handles scalability testing." \
    "LoadTester handles scalability testing for QualityForge AI, providing scale testing, growth capacity testing, scalability analysis, and capacity planning validation." \
    "load-qualityforge-load-testing" "QualityForge AI" "Scalability Testing" \
    "qualityforge, scalability-testing, scale-testing, capacity-planning" \
    "load-qualityforge-load-testing, performance-qualityforge-performance-testing" \
    "Scalability testing, capacity"

create_skill "$SKILLS_BASE/qualityforge-ai/architect-qualityforge-system-architect" \
    "architect-qualityforge-system-architect" \
    "Use when quality system architecture, quality infrastructure design, quality tool integration architecture, or quality platform design is needed within QualityForge AI. This agent handles quality architecture." \
    "Architect handles quality system architecture for QualityForge AI, providing quality infrastructure design, tool integration architecture, and quality platform design." \
    "apex-qualityforge-ceo" "QualityForge AI" "System Architect" \
    "qualityforge, quality-architecture, quality-infrastructure, quality-platform" \
    "apex-qualityforge-ceo, codesmith-qualityforge-code-architect" \
    "Quality architecture, infrastructure"

create_skill "$SKILLS_BASE/qualityforge-ai/codesmith-qualityforge-code-architect" \
    "codesmith-qualityforge-code-architect" \
    "Use when code quality architecture, code structure analysis, code quality patterns, or code architecture review is needed within QualityForge AI. This agent handles code quality architecture." \
    "Codesmith handles code quality architecture for QualityForge AI, providing code structure analysis, quality patterns, architecture review, and code quality design." \
    "architect-qualityforge-system-architect" "QualityForge AI" "Code Architect" \
    "qualityforge, code-quality-architecture, code-structure, quality-patterns" \
    "architect-qualityforge-system-architect, reviewer-qualityforge-code-reviewer" \
    "Code quality architecture, patterns"

create_skill "$SKILLS_BASE/qualityforge-ai/reviewer-qualityforge-code-reviewer" \
    "reviewer-qualityforge-code-reviewer" \
    "Use when code quality review, code standard compliance review, code quality assessment, or peer code review is needed within QualityForge AI. This agent handles code review." \
    "Reviewer handles code review for QualityForge AI, providing quality review, standard compliance, code assessment, and peer review coordination." \
    "codesmith-qualityforge-code-architect" "QualityForge AI" "Code Reviewer" \
    "qualityforge, code-review, quality-assessment, standard-compliance" \
    "codesmith-qualityforge-code-architect, analyzer-qualityforge-code-analyzer" \
    "Code review, assessment"

create_skill "$SKILLS_BASE/qualityforge-ai/analyzer-qualityforge-code-analyzer" \
    "analyzer-qualityforge-code-analyzer" \
    "Use when code quality analysis, static code analysis, code metrics analysis, or code quality reporting is needed within QualityForge AI. This agent handles code analysis." \
    "Analyzer handles code analysis for QualityForge AI, providing static analysis, code metrics, quality reporting, and code quality trends." \
    "reviewer-qualityforge-code-reviewer" "QualityForge AI" "Code Analyzer" \
    "qualityforge, code-analysis, static-analysis, code-metrics" \
    "reviewer-qualityforge-code-reviewer, inspector-qualityforge-code-inspector" \
    "Code analysis, metrics"

create_skill "$SKILLS_BASE/qualityforge-ai/profiler-qualityforge-performance-profiler" \
    "profiler-qualityforge-performance-profiler" \
    "Use when code performance profiling, bottleneck identification, performance analysis, or profiling reports is needed within QualityForge AI. This agent handles performance profiling." \
    "Profiler handles performance profiling for QualityForge AI, providing bottleneck identification, performance analysis, profiling reports, and optimization recommendations." \
    "apex-qualityforge-ceo" "QualityForge AI" "Performance Profiler" \
    "qualityforge, performance-profiling, bottleneck-identification, performance-analysis" \
    "apex-qualityforge-ceo, performance-qualityforge-performance-testing" \
    "Performance profiling, bottlenecks"

create_skill "$SKILLS_BASE/qualityforge-ai/fixer-qualityforge-bug-fixing-specialist" \
    "fixer-qualityforge-bug-fixing-specialist" \
    "Use when bug fixing, defect resolution, code fix implementation, or fix validation is needed within QualityForge AI. This agent handles bug fixing." \
    "Fixer handles bug fixing for QualityForge AI, providing defect resolution, code fix implementation, fix validation, and bug prevention." \
    "apex-qualityforge-ceo" "QualityForge AI" "Bug Fixing Specialist" \
    "qualityforge, bug-fixing, defect-resolution, code-fixes" \
    "apex-qualityforge-ceo, resolver-qualityforge-issue-resolver" \
    "Bug fixing, defects"

create_skill "$SKILLS_BASE/qualityforge-ai/resolver-qualityforge-issue-resolver" \
    "resolver-qualityforge-issue-resolver" \
    "Use when issue resolution, problem solving, technical issue investigation, or issue tracking is needed within QualityForge AI. This agent handles issue resolution." \
    "Resolver handles issue resolution for QualityForge AI, providing problem solving, technical investigation, issue tracking, and resolution validation." \
    "fixer-qualityforge-bug-fixing-specialist" "QualityForge AI" "Issue Resolver" \
    "qualityforge, issue-resolution, problem-solving, technical-investigation" \
    "fixer-qualityforge-bug-fixing-specialist, debugger-qualityforge-debugger-specialist" \
    "Issue resolution, problem solving"

create_skill "$SKILLS_BASE/qualityforge-ai/debugger-qualityforge-debugger-specialist" \
    "debugger-qualityforge-debugger-specialist" \
    "Use when debugging support, debug session coordination, root cause analysis, or debugging tool management is needed within QualityForge AI. This agent handles debugging." \
    "Debugger handles debugging for QualityForge AI, providing debug session coordination, root cause analysis, debugging tool management, and debug automation." \
    "resolver-qualityforge-issue-resolver" "QualityForge AI" "Debugger Specialist" \
    "qualityforge, debugging, root-cause-analysis, debug-sessions" \
    "resolver-qualityforge-issue-resolver, tracer-qualityforge-execution-tracer" \
    "Debugging, root cause"

create_skill "$SKILLS_BASE/qualityforge-ai/inspector-qualityforge-code-inspector" \
    "inspector-qualityforge-code-inspector" \
    "Use when code inspection, code quality inspection, code compliance inspection, or inspection reporting is needed within QualityForge AI. This agent handles code inspection." \
    "Inspector handles code inspection for QualityForge AI, providing code quality inspection, compliance inspection, inspection reporting, and inspection automation." \
    "analyzer-qualityforge-code-analyzer" "QualityForge AI" "Code Inspector" \
    "qualityforge, code-inspection, quality-inspection, compliance-inspection" \
    "analyzer-qualityforge-code-analyzer, reviewer-qualityforge-code-reviewer" \
    "Code inspection, compliance"

create_skill "$SKILLS_BASE/qualityforge-ai/tracer-qualityforge-execution-tracer" \
    "tracer-qualityforge-execution-tracer" \
    "Use when execution tracing, code execution analysis, trace debugging, or execution flow analysis is needed within QualityForge AI. This agent handles execution tracing." \
    "Tracer handles execution tracing for QualityForge AI, providing code execution analysis, trace debugging, execution flow analysis, and trace reporting." \
    "debugger-qualityforge-debugger-specialist" "QualityForge AI" "Execution Tracer" \
    "qualityforge, execution-tracing, code-execution, trace-debugging" \
    "debugger-qualityforge-debugger-specialist, diagnostics-qualityforge-diagnostics-specialist" \
    "Execution tracing, flow analysis"

create_skill "$SKILLS_BASE/qualityforge-ai/diagnostics-qualityforge-diagnostics-specialist" \
    "diagnostics-qualityforge-diagnostics-specialist" \
    "Use when system diagnostics, diagnostic analysis, diagnostic reporting, or diagnostic tool management is needed within QualityForge AI. This agent handles diagnostics." \
    "Diagnostics handles diagnostics for QualityForge AI, providing system diagnostics, diagnostic analysis, diagnostic reporting, and diagnostic tool management." \
    "tracer-qualityforge-execution-tracer" "QualityForge AI" "Diagnostics Specialist" \
    "qualityforge, diagnostics, system-diagnostics, diagnostic-analysis" \
    "tracer-qualityforge-execution-tracer, debugger-qualityforge-debugger-specialist" \
    "Diagnostics, system analysis"

create_skill "$SKILLS_BASE/qualityforge-ai/integrator-qualityforge-integration-specialist" \
    "integrator-qualityforge-integration-specialist" \
    "Use when quality system integration, tool integration, integration testing coordination, or integration validation is needed within QualityForge AI. This agent handles integration." \
    "Integrator handles quality system integration for QualityForge AI, providing tool integration, integration testing coordination, integration validation, and integration management." \
    "apex-qualityforge-ceo" "QualityForge AI" "Integration Specialist" \
    "qualityforge, quality-integration, tool-integration, integration-validation" \
    "apex-qualityforge-ceo, integration-qualityforge-integration-testing" \
    "Quality integration, tools"

create_skill "$SKILLS_BASE/qualityforge-ai/refactor-qualityforge-refactoring-specialist" \
    "refactor-qualityforge-refactoring-specialist" \
    "Use when code refactoring, refactoring planning, refactoring validation, or refactoring risk assessment is needed within QualityForge AI. This agent handles refactoring." \
    "Refactor handles refactoring for QualityForge AI, providing refactoring planning, refactoring validation, risk assessment, and refactoring coordination." \
    "optimizer-qualityforge-code-optimizer" "QualityForge AI" "Refactoring Specialist" \
    "qualityforge, refactoring, refactoring-planning, refactoring-validation" \
    "optimizer-qualityforge-code-optimizer, maintainer-qualityforge-code-maintainer" \
    "Refactoring, code improvement"

create_skill "$SKILLS_BASE/qualityforge-ai/maintainer-qualityforge-code-maintainer" \
    "maintainer-qualityforge-code-maintainer" \
    "Use when code maintenance, maintenance planning, technical debt management, or code health monitoring is needed within QualityForge AI. This agent handles code maintenance." \
    "Maintainer handles code maintenance for QualityForge AI, providing maintenance planning, technical debt management, code health monitoring, and maintenance automation." \
    "refactor-qualityforge-refactoring-specialist" "QualityForge AI" "Code Maintainer" \
    "qualityforge, code-maintenance, technical-debt, code-health" \
    "refactor-qualityforge-refactoring-specialist, optimizer-qualityforge-code-optimizer" \
    "Code maintenance, health"

create_skill "$SKILLS_BASE/qualityforge-ai/auditor-qualityforge-quality-auditor" \
    "auditor-qualityforge-quality-auditor" \
    "Use when quality auditing, quality compliance audit, process audit, or audit reporting is needed within QualityForge AI. This agent handles quality auditing." \
    "Auditor handles quality auditing for QualityForge AI, providing compliance audits, process audits, audit reporting, and audit follow-up." \
    "governor-qualityforge-quality-director" "QualityForge AI" "Quality Auditor" \
    "qualityforge, quality-auditing, compliance-audit, process-audit" \
    "governor-qualityforge-quality-director, standards-qualityforge-standards-enforcer" \
    "Quality auditing, compliance"

echo "=== All Skills Generation Complete ==="
echo "Total skills created: 147+ across 6 companies"