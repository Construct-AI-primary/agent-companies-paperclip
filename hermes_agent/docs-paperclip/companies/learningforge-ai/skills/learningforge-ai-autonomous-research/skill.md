---
name: learningforge-ai-autonomous-research
description: >
  Use when executing autonomous research tasks on construction domain topics, literature review,
  hypothesis generation, or research report generation is needed. This skill specializes in
  self-improving research using AutoResearch methodology from Karpathy's repo.
---

# Learning Forge AI - Autonomous Research Skill

## Overview
Executes autonomous research tasks on construction domain topics using structured methodology inspired by Karpathy's AutoResearch. Capable of continuous self-improvement loops, skill gap analysis, and content enhancement.

## When to Use
- When research on construction domain topics is needed
- When literature review and synthesis is required
- When hypothesis generation and testing is needed
- When research report generation is required
- When skill gap analysis and enhancement is needed
- **Don't use when:** Domain-specific legal research is needed (use learningforge-ai-legal-research), or safety research is needed (use learningforge-ai-safety-research)

## Core Procedures

### Autonomous Research Workflow
1. **Topic Definition** - Define research scope and objectives
2. **Literature Review** - Scan academic and technical sources
3. **Data Gathering** - Collect relevant information from web sources
4. **Hypothesis Generation** - Develop research hypotheses
5. **Testing & Refinement** - Test hypotheses and refine conclusions
6. **Report Generation** - Generate structured research reports

### Integration with AutoResearch
1. **Skill Gap Analysis** - Identify gaps in current knowledge
2. **Literature Scanning** - Review academic publications
3. **Content Enhancement** - Generate improved content based on findings
4. **Continuous Improvement** - Loop and refine research outputs

## Research Scope
- **Literature Review:** Academic databases, technical papers, construction journals
- **Web Research:** Industry blogs, vendor publications, regulatory sites
- **Hypothesis Testing:** Data analysis, pattern recognition, validation
- **Report Generation:** Structured outputs, executive summaries, detailed findings

### Cross-Company Research Integration
- **learningforge-ai-legal-research:** Coordinate legal research findings
- **learningforge-ai-safety-research:** Integrate safety research outputs
- **learningforge-ai-literature-analysis:** Leverage academic literature skills
- **knowledgeforge-ai:** Access domain knowledge base

## Agent Assignment
**Primary Agent:** learningforge-ai-hermes-research
**Company:** Learning Forge AI
**Role:** General Autonomous Research Specialist
**Reports To:** learningforge-ai-research-compliance-division-lead
**Related Skills:** learningforge-ai-legal-research, learningforge-ai-safety-research, learningforge-ai-literature-analysis

## Output Structure
Writes research outputs to `/workspace/research/` with structured format:
- Executive summary
- Key findings
- Supporting evidence
- Recommendations
- Next steps

## Last Updated
2026-04-11
