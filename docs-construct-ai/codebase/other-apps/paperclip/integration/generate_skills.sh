#!/bin/bash
# Gold Star Enterprise - Skill Generation Script
# Generates all 129 remaining skills for the 6-company OpenClaw AI enterprise

SKILLS_BASE="construct-ai-docs/skills"

# Function to create a skill
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
    
    cat > "$path/SKILL.md" << EOF
---
name: $name
description: >
  $description
---

# $(echo "$name" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g') - $company $role

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

echo "Generating DevForge AI Data Engineering Skills..."

create_skill "$SKILLS_BASE/devforge-ai/dataforge-devforge-data-transformation" \
    "dataforge-devforge-data-transformation" \
    "Use when data transformation, ETL pipeline development, data processing, or data integration is needed within DevForge AI. This agent handles data pipelines, transformation logic, and data integration systems." \
    "Dataforge handles data transformation for DevForge AI, providing ETL pipeline development, data processing, data integration, and data quality management." \
    "orion-devforge-orchestrator" "DevForge AI" "Data Transformation" \
    "devforge, data-transformation, etl, data-pipelines" \
    "orion-devforge-orchestrator, navigator-devforge-data-discovery, stream-devforge-data-streaming" \
    "Data transformation, ETL pipelines"

create_skill "$SKILLS_BASE/devforge-ai/navigator-devforge-data-discovery" \
    "navigator-devforge-data-discovery" \
    "Use when data discovery, data profiling, metadata management, or data cataloging is needed within DevForge AI. This agent handles data exploration, profiling, and catalog management." \
    "Navigator handles data discovery for DevForge AI, providing data profiling, metadata management, data cataloging, and data exploration capabilities." \
    "dataforge-devforge-data-transformation" "DevForge AI" "Data Discovery" \
    "devforge, data-discovery, data-profiling, metadata-management" \
    "dataforge-devforge-data-transformation, schema-devforge-data-schema-management" \
    "Data discovery, metadata management"

create_skill "$SKILLS_BASE/devforge-ai/pulse-devforge-realtime-monitoring" \
    "pulse-devforge-realtime-monitoring" \
    "Use when real-time monitoring, alerting, observability, or performance tracking is needed within DevForge AI. This agent handles system monitoring, alert management, and observability dashboards." \
    "Pulse handles real-time monitoring for DevForge AI, providing system observability, alert management, performance tracking, and monitoring dashboards." \
    "orion-devforge-orchestrator" "DevForge AI" "Real-time Monitoring" \
    "devforge, monitoring, observability, alerting" \
    "orion-devforge-orchestrator, sentinel-devforge-data-quality-monitoring" \
    "Real-time monitoring, observability"

create_skill "$SKILLS_BASE/devforge-ai/schema-devforge-data-schema-management" \
    "schema-devforge-data-schema-management" \
    "Use when data schema design, schema evolution, data modeling, or schema validation is needed within DevForge AI. This agent handles database schema management and data modeling." \
    "Schema handles data schema management for DevForge AI, providing schema design, evolution management, data modeling, and schema validation." \
    "dataforge-devforge-data-transformation" "DevForge AI" "Data Schema Management" \
    "devforge, schema-management, data-modeling, schema-validation" \
    "dataforge-devforge-data-transformation, navigator-devforge-data-discovery" \
    "Schema management, data modeling"

create_skill "$SKILLS_BASE/devforge-ai/sentinel-devforge-data-quality-monitoring" \
    "sentinel-devforge-data-quality-monitoring" \
    "Use when data quality monitoring, data validation, quality rules enforcement, or data profiling is needed within DevForge AI. This agent handles data quality checks and monitoring." \
    "Sentinel handles data quality monitoring for DevForge AI, providing data quality checks, validation rules, quality metrics, and data profiling." \
    "dataforge-devforge-data-transformation" "DevForge AI" "Data Quality Monitoring" \
    "devforge, data-quality, monitoring, validation" \
    "dataforge-devforge-data-transformation, pulse-devforge-realtime-monitoring" \
    "Data quality, monitoring"

create_skill "$SKILLS_BASE/devforge-ai/stream-devforge-data-streaming" \
    "stream-devforge-data-streaming" \
    "Use when data streaming, event processing, real-time data pipelines, or stream analytics is needed within DevForge AI. This agent handles streaming infrastructure and event processing." \
    "Stream handles data streaming for DevForge AI, providing event processing, real-time data pipelines, stream analytics, and streaming infrastructure management." \
    "dataforge-devforge-data-transformation" "DevForge AI" "Data Streaming" \
    "devforge, data-streaming, event-processing, real-time-pipelines" \
    "dataforge-devforge-data-transformation, pulse-devforge-realtime-monitoring" \
    "Data streaming, event processing"

create_skill "$SKILLS_BASE/devforge-ai/ledgerai-devforge-financial-data" \
    "ledgerai-devforge-financial-data" \
    "Use when financial data processing, financial analytics, cost data management, or financial reporting automation is needed within DevForge AI. This agent handles financial data systems." \
    "LedgerAI handles financial data for DevForge AI, providing financial data processing, cost analytics, financial reporting automation, and budget data management." \
    "ledger-devforge-financial-oversight" "DevForge AI" "Financial Data" \
    "devforge, financial-data, cost-analytics, financial-reporting" \
    "ledger-devforge-financial-oversight, insight-devforge-business-intelligence" \
    "Financial data, cost analytics"

echo "Generating DevForge AI Security Skills..."

create_skill "$SKILLS_BASE/devforge-ai/guardian-devforge-threat-protection" \
    "guardian-devforge-threat-protection" \
    "Use when threat detection, vulnerability management, security monitoring, or incident response is needed within DevForge AI. This agent handles security threat protection and response." \
    "Guardian handles threat protection for DevForge AI, providing threat detection, vulnerability management, security monitoring, and incident response coordination." \
    "orion-devforge-orchestrator" "DevForge AI" "Threat Protection" \
    "devforge, security, threat-detection, incident-response" \
    "orion-devforge-orchestrator, watchtower-devforge-security-oversight" \
    "Threat protection, security monitoring"

create_skill "$SKILLS_BASE/devforge-ai/gatekeeper-devforge-access-control" \
    "gatekeeper-devforge-access-control" \
    "Use when access control management, authentication systems, authorization policies, or identity management is needed within DevForge AI. This agent handles access control and identity." \
    "Gatekeeper handles access control for DevForge AI, providing authentication systems, authorization policies, identity management, and access governance." \
    "guardian-devforge-threat-protection" "DevForge AI" "Access Control" \
    "devforge, access-control, authentication, identity-management" \
    "guardian-devforge-threat-protection, auditor-devforge-security-compliance" \
    "Access control, authentication"

create_skill "$SKILLS_BASE/devforge-ai/auditor-devforge-security-compliance" \
    "auditor-devforge-security-compliance" \
    "Use when security auditing, compliance validation, security assessments, or regulatory compliance is needed within DevForge AI. This agent handles security audits and compliance." \
    "Auditor handles security compliance for DevForge AI, providing security auditing, compliance validation, security assessments, and regulatory compliance management." \
    "guardian-devforge-threat-protection" "DevForge AI" "Security Compliance" \
    "devforge, security-audit, compliance, regulatory-compliance" \
    "guardian-devforge-threat-protection, gatekeeper-devforge-access-control" \
    "Security auditing, compliance"

create_skill "$SKILLS_BASE/devforge-ai/sentinelx-devforge-advanced-monitoring" \
    "sentinelx-devforge-advanced-monitoring" \
    "Use when advanced security monitoring, threat intelligence, anomaly detection, or security analytics is needed within DevForge AI. This agent handles advanced security monitoring." \
    "SentinelX handles advanced monitoring for DevForge AI, providing threat intelligence, anomaly detection, security analytics, and advanced threat hunting." \
    "guardian-devforge-threat-protection" "DevForge AI" "Advanced Monitoring" \
    "devforge, advanced-monitoring, threat-intelligence, anomaly-detection" \
    "guardian-devforge-threat-protection, pulse-devforge-realtime-monitoring" \
    "Advanced monitoring, threat intelligence"

create_skill "$SKILLS_BASE/devforge-ai/watchtower-devforge-security-oversight" \
    "watchtower-devforge-security-oversight" \
    "Use when security oversight, security governance, security policy enforcement, or security program management is needed within DevForge AI. This agent handles security governance." \
    "Watchtower handles security oversight for DevForge AI, providing security governance, policy enforcement, security program management, and security strategy." \
    "guardian-devforge-threat-protection" "DevForge AI" "Security Oversight" \
    "devforge, security-governance, policy-enforcement, security-program" \
    "guardian-devforge-threat-protection, auditor-devforge-security-compliance" \
    "Security governance, oversight"

create_skill "$SKILLS_BASE/devforge-ai/archivist-devforge-knowledge-security" \
    "archivist-devforge-knowledge-security" \
    "Use when knowledge security, data classification, information protection, or secure knowledge management is needed within DevForge AI. This agent handles knowledge security." \
    "Archivist handles knowledge security for DevForge AI, providing data classification, information protection, secure knowledge management, and data retention policies." \
    "guardian-devforge-threat-protection" "DevForge AI" "Knowledge Security" \
    "devforge, knowledge-security, data-classification, information-protection" \
    "guardian-devforge-threat-protection, librarian-devforge-knowledge-management" \
    "Knowledge security, data classification"

echo "Generating DevForge AI Product Skills..."

create_skill "$SKILLS_BASE/devforge-ai/atlas-devforge-product-mapping" \
    "atlas-devforge-product-mapping" \
    "Use when product mapping, feature discovery, product analytics, or product portfolio management is needed within DevForge AI. This agent handles product mapping and discovery." \
    "Atlas handles product mapping for DevForge AI, providing feature discovery, product analytics, portfolio management, and product landscape mapping." \
    "orion-devforge-orchestrator" "DevForge AI" "Product Mapping" \
    "devforge, product-mapping, feature-discovery, product-analytics" \
    "orion-devforge-orchestrator, cartographer-devforge-product-roadmapping" \
    "Product mapping, analytics"

create_skill "$SKILLS_BASE/devforge-ai/brandforge-devforge-brand-development" \
    "brandforge-devforge-brand-development" \
    "Use when brand development, brand strategy, brand guidelines, or brand identity management is needed within DevForge AI. This agent handles brand development." \
    "BrandForge handles brand development for DevForge AI, providing brand strategy, brand guidelines, identity management, and brand consistency enforcement." \
    "orion-devforge-orchestrator" "DevForge AI" "Brand Development" \
    "devforge, brand-development, brand-strategy, brand-identity" \
    "orion-devforge-orchestrator, vision-loopy-ceo" \
    "Brand development, strategy"

create_skill "$SKILLS_BASE/devforge-ai/cartographer-devforge-product-roadmapping" \
    "cartographer-devforge-product-roadmapping" \
    "Use when product roadmapping, feature prioritization, release planning, or product strategy is needed within DevForge AI. This agent handles product roadmaps." \
    "Cartographer handles product roadmapping for DevForge AI, providing feature prioritization, release planning, product strategy, and roadmap visualization." \
    "atlas-devforge-product-mapping" "DevForge AI" "Product Roadmapping" \
    "devforge, product-roadmapping, feature-prioritization, release-planning" \
    "atlas-devforge-product-mapping, catalyst-devforge-product-innovation" \
    "Product roadmapping, strategy"

create_skill "$SKILLS_BASE/devforge-ai/catalyst-devforge-product-innovation" \
    "catalyst-devforge-product-innovation" \
    "Use when product innovation, feature ideation, innovation management, or product experimentation is needed within DevForge AI. This agent handles product innovation." \
    "Catalyst handles product innovation for DevForge AI, providing feature ideation, innovation management, product experimentation, and creative problem solving." \
    "cartographer-devforge-product-roadmapping" "DevForge AI" "Product Innovation" \
    "devforge, product-innovation, feature-ideation, experimentation" \
    "cartographer-devforge-product-roadmapping, catalystx-devforge-market-disruption" \
    "Product innovation, ideation"

create_skill "$SKILLS_BASE/devforge-ai/concierge-devforge-customer-experience" \
    "concierge-devforge-customer-experience" \
    "Use when customer experience design, user journey mapping, customer feedback analysis, or CX optimization is needed within DevForge AI. This agent handles customer experience." \
    "Concierge handles customer experience for DevForge AI, providing user journey mapping, feedback analysis, CX optimization, and customer satisfaction management." \
    "orion-devforge-orchestrator" "DevForge AI" "Customer Experience" \
    "devforge, customer-experience, user-journey, feedback-analysis" \
    "orion-devforge-orchestrator, vision-loopy-ceo" \
    "Customer experience, journey mapping"

create_skill "$SKILLS_BASE/devforge-ai/nova-devforge-product-launches" \
    "nova-devforge-product-launches" \
    "Use when product launch planning, go-to-market strategy, launch coordination, or release management is needed within DevForge AI. This agent handles product launches." \
    "Nova handles product launches for DevForge AI, providing go-to-market strategy, launch coordination, release management, and launch success measurement." \
    "cartographer-devforge-product-roadmapping" "DevForge AI" "Product Launches" \
    "devforge, product-launches, go-to-market, release-management" \
    "cartographer-devforge-product-roadmapping, storycraft-devforge-product-storytelling" \
    "Product launches, GTM strategy"

create_skill "$SKILLS_BASE/devforge-ai/storycraft-devforge-product-storytelling" \
    "storycraft-devforge-product-storytelling" \
    "Use when product storytelling, product messaging, narrative development, or product communication is needed within DevForge AI. This agent handles product narratives." \
    "Storycraft handles product storytelling for DevForge AI, providing product messaging, narrative development, product communication, and story-driven marketing." \
    "nova-devforge-product-launches" "DevForge AI" "Product Storytelling" \
    "devforge, product-storytelling, messaging, narrative-development" \
    "nova-devforge-product-launches, brandforge-devforge-brand-development" \
    "Product storytelling, messaging"

echo "Generating DevForge AI Growth Skills..."

create_skill "$SKILLS_BASE/devforge-ai/ambassador-devforge-brand-representation" \
    "ambassador-devforge-brand-representation" \
    "Use when brand representation, public relations, stakeholder communication, or brand advocacy is needed within DevForge AI. This agent handles brand representation." \
    "Ambassador handles brand representation for DevForge AI, providing public relations, stakeholder communication, brand advocacy, and external relationship management." \
    "orion-devforge-orchestrator" "DevForge AI" "Brand Representation" \
    "devforge, brand-representation, public-relations, stakeholder-communication" \
    "orion-devforge-orchestrator, brandforge-devforge-brand-development" \
    "Brand representation, PR"

create_skill "$SKILLS_BASE/devforge-ai/ally-devforge-partnership-management" \
    "ally-devforge-partnership-management" \
    "Use when partnership development, partner relationship management, strategic alliances, or partner program management is needed within DevForge AI. This agent handles partnerships." \
    "Ally handles partnership management for DevForge AI, providing partner development, relationship management, strategic alliances, and partner program coordination." \
    "orion-devforge-orchestrator" "DevForge AI" "Partnership Management" \
    "devforge, partnership-management, strategic-alliances, partner-programs" \
    "orion-devforge-orchestrator, dealmaker-devforge-sales-negotiation" \
    "Partnership management, alliances"

create_skill "$SKILLS_BASE/devforge-ai/amplifier-devforge-marketing-promotion" \
    "amplifier-devforge-marketing-promotion" \
    "Use when marketing promotion, campaign amplification, marketing automation, or promotional strategy is needed within DevForge AI. This agent handles marketing promotion." \
    "Amplifier handles marketing promotion for DevForge AI, providing campaign amplification, marketing automation, promotional strategy, and marketing channel optimization." \
    "orion-devforge-orchestrator" "DevForge AI" "Marketing Promotion" \
    "devforge, marketing-promotion, campaign-amplification, marketing-automation" \
    "orion-devforge-orchestrator, jordan-loopy-marketing-specialist" \
    "Marketing promotion, campaigns"

create_skill "$SKILLS_BASE/devforge-ai/catalystx-devforge-market-disruption" \
    "catalystx-devforge-market-disruption" \
    "Use when market disruption strategy, competitive disruption, market positioning, or disruptive innovation is needed within DevForge AI. This agent handles market disruption." \
    "CatalystX handles market disruption for DevForge AI, providing disruption strategy, competitive positioning, market innovation, and disruptive business model development." \
    "strategos-devforge-strategic-planning" "DevForge AI" "Market Disruption" \
    "devforge, market-disruption, competitive-strategy, disruptive-innovation" \
    "strategos-devforge-strategic-planning, catalyst-devforge-product-innovation" \
    "Market disruption, innovation"

create_skill "$SKILLS_BASE/devforge-ai/dealmaker-devforge-sales-negotiation" \
    "dealmaker-devforge-sales-negotiation" \
    "Use when sales negotiation, deal structuring, contract negotiation, or sales strategy is needed within DevForge AI. This agent handles sales and deal making." \
    "Dealmaker handles sales negotiation for DevForge AI, providing deal structuring, contract negotiation, sales strategy, and revenue optimization." \
    "orion-devforge-orchestrator" "DevForge AI" "Sales Negotiation" \
    "devforge, sales-negotiation, deal-structuring, sales-strategy" \
    "orion-devforge-orchestrator, ally-devforge-partnership-management" \
    "Sales negotiation, deals"

create_skill "$SKILLS_BASE/devforge-ai/merchant-devforge-commerce-operations" \
    "merchant-devforge-commerce-operations" \
    "Use when commerce operations, e-commerce management, transaction processing, or commerce platform management is needed within DevForge AI. This agent handles commerce operations." \
    "Merchant handles commerce operations for DevForge AI, providing e-commerce management, transaction processing, commerce platform optimization, and revenue operations." \
    "orion-devforge-orchestrator" "DevForge AI" "Commerce Operations" \
    "devforge, commerce-operations, e-commerce, transaction-processing" \
    "orion-devforge-orchestrator, dealmaker-devforge-sales-negotiation" \
    "Commerce operations, e-commerce"

create_skill "$SKILLS_BASE/devforge-ai/voyager-devforge-market-exploration" \
    "voyager-devforge-market-exploration" \
    "Use when market exploration, new market entry, market research, or market opportunity identification is needed within DevForge AI. This agent handles market exploration." \
    "Voyager handles market exploration for DevForge AI, providing new market entry analysis, market research, opportunity identification, and market expansion strategy." \
    "strategos-devforge-strategic-planning" "DevForge AI" "Market Exploration" \
    "devforge, market-exploration, market-research, new-market-entry" \
    "strategos-devforge-strategic-planning, analyst-devforge-market-analysis" \
    "Market exploration, research"

create_skill "$SKILLS_BASE/devforge-ai/analyst-devforge-market-analysis" \
    "analyst-devforge-market-analysis" \
    "Use when market analysis, competitive analysis, market sizing, or market trend analysis is needed within DevForge AI. This agent handles market analysis and intelligence." \
    "Analyst handles market analysis for DevForge AI, providing competitive analysis, market sizing, trend analysis, and market intelligence reporting." \
    "strategos-devforge-strategic-planning" "DevForge AI" "Market Analysis" \
    "devforge, market-analysis, competitive-analysis, market-intelligence" \
    "strategos-devforge-strategic-planning, insight-devforge-business-intelligence" \
    "Market analysis, intelligence"

echo "Generating DevForge AI Strategy Skills..."

create_skill "$SKILLS_BASE/devforge-ai/compass-devforge-direction-setting" \
    "compass-devforge-direction-setting" \
    "Use when strategic direction setting, objective alignment, goal cascading, or strategic planning support is needed within DevForge AI. This agent handles direction setting." \
    "Compass handles direction setting for DevForge AI, providing strategic alignment, objective cascading, goal tracking, and strategic planning support." \
    "council-devforge-strategic-decision-making" "DevForge AI" "Direction Setting" \
    "devforge, direction-setting, strategic-alignment, goal-cascading" \
    "council-devforge-strategic-decision-making, strategos-devforge-strategic-planning" \
    "Direction setting, alignment"

create_skill "$SKILLS_BASE/devforge-ai/librarian-devforge-knowledge-management" \
    "librarian-devforge-knowledge-management" \
    "Use when knowledge management, documentation strategy, information organization, or knowledge sharing is needed within DevForge AI. This agent handles knowledge management." \
    "Librarian handles knowledge management for DevForge AI, providing documentation strategy, information organization, knowledge sharing, and content governance." \
    "council-devforge-strategic-decision-making" "DevForge AI" "Knowledge Management" \
    "devforge, knowledge-management, documentation, information-organization" \
    "council-devforge-strategic-decision-making, archivist-devforge-knowledge-security" \
    "Knowledge management, documentation"

create_skill "$SKILLS_BASE/devforge-ai/mentor-devforge-team-development" \
    "mentor-devforge-team-development" \
    "Use when team development, skills training, performance coaching, or team capability building is needed within DevForge AI. This agent handles team development." \
    "Mentor handles team development for DevForge AI, providing skills training, performance coaching, capability building, and team growth programs." \
    "council-devforge-strategic-decision-making" "DevForge AI" "Team Development" \
    "devforge, team-development, skills-training, performance-coaching" \
    "council-devforge-strategic-decision-making, nexus-devforge-ceo" \
    "Team development, coaching"

create_skill "$SKILLS_BASE/devforge-ai/oracle-devforge-predictive-analytics" \
    "oracle-devforge-predictive-analytics" \
    "Use when predictive analytics, forecasting, trend prediction, or predictive modeling is needed within DevForge AI. This agent handles predictive analytics." \
    "Oracle handles predictive analytics for DevForge AI, providing forecasting, trend prediction, predictive modeling, and data-driven future insights." \
    "strategos-devforge-strategic-planning" "DevForge AI" "Predictive Analytics" \
    "devforge, predictive-analytics, forecasting, trend-prediction" \
    "strategos-devforge-strategic-planning, insight-devforge-business-intelligence" \
    "Predictive analytics, forecasting"

create_skill "$SKILLS_BASE/devforge-ai/pathfinder-devforge-opportunity-identification" \
    "pathfinder-devforge-opportunity-identification" \
    "Use when opportunity identification, strategic opportunity analysis, growth opportunity discovery, or opportunity evaluation is needed within DevForge AI. This agent handles opportunity identification." \
    "Pathfinder handles opportunity identification for DevForge AI, providing strategic opportunity analysis, growth discovery, opportunity evaluation, and opportunity prioritization." \
    "strategos-devforge-strategic-planning" "DevForge AI" "Opportunity Identification" \
    "devforge, opportunity-identification, growth-discovery, opportunity-evaluation" \
    "strategos-devforge-strategic-planning, voyager-devforge-market-exploration" \
    "Opportunity identification, growth"

echo "DevForge AI skills generation complete: 20 skills created"
echo "Total DevForge AI skills: 28 (including 8 previously created)"