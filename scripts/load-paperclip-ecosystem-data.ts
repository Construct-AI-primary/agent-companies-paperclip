#!/usr/bin/env tsx

/**
 * Paperclip Ecosystem Data Loader
 *
 * This script loads all the strategic goals, projects, issues, and framework documents
 * created for the Paperclip AI ecosystem into the Supabase database.
 *
 * It checks for existing data and only inserts what's missing to avoid duplicates.
 */

import { eq, and } from "drizzle-orm";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "./packages/db/src/schema/index.js";

// Database connection
const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  throw new Error("DATABASE_URL environment variable is required");
}

const client = postgres(connectionString);
const db = drizzle(client, { schema });

// Data to load
const COMPANIES = [
  {
    name: "DevForge AI",
    description: "Leading AI model development and optimization company specializing in intelligent model selection and assessment systems.",
    issuePrefix: "DEV",
    brandColor: "#3B82F6",
  },
  {
    name: "QualityForge AI",
    description: "Comprehensive AI testing and quality assurance company providing automated testing frameworks and quality validation services.",
    issuePrefix: "QUAL",
    brandColor: "#10B981",
  },
  {
    name: "DomainForge AI",
    description: "Multi-discipline engineering AI solutions company specializing in complex engineering workflows and procurement intelligence.",
    issuePrefix: "DOMAIN",
    brandColor: "#F59E0B",
  },
  {
    name: "InfraForge AI",
    description: "AI-powered infrastructure management and data optimization company providing intelligent database and cloud infrastructure services.",
    issuePrefix: "INFRA",
    brandColor: "#8B5CF6",
  },
  {
    name: "PromptForge AI",
    description: "Advanced AI prompt engineering and orchestration company providing sophisticated prompt architectures and ethical AI frameworks.",
    issuePrefix: "PROMPT",
    brandColor: "#EF4444",
  },
  {
    name: "Loopy AI",
    description: "Creative AI and content generation company providing intelligent marketing automation and artistic content creation tools.",
    issuePrefix: "LOOPY",
    brandColor: "#EC4899",
  },
];

const GOALS = [
  {
    companyName: "DevForge AI",
    title: "Deliver Intelligent Model Selection and Assessment Systems",
    description: "Establish DevForge AI as the global leader in AI model selection and assessment, providing intelligent systems that optimize model performance, ensure reliability, and maximize AI system effectiveness across all industries.",
    level: "company",
    goalId: "DEVFORGE-GOAL-001",
    ceo: "nexus",
  },
  {
    companyName: "QualityForge AI",
    title: "Deliver AI-Powered Quality Assurance & Testing Services",
    description: "Establish QualityForge AI as the global leader in AI-powered quality assurance, providing comprehensive testing automation, quality validation, and reliability engineering that ensures AI systems perform flawlessly at scale.",
    level: "company",
    goalId: "QUALITYFORGE-GOAL-001",
    ceo: "guardian",
  },
  {
    companyName: "DomainForge AI",
    title: "Deliver Multi-Discipline AI Engineering Solutions",
    description: "Establish DomainForge AI as the global leader in multi-discipline engineering AI solutions, providing intelligent systems that span engineering domains, optimize complex workflows, and deliver engineering excellence through AI-powered coordination.",
    level: "company",
    goalId: "DOMAINFORGE-GOAL-001",
    ceo: "orion-chief-orchestrator",
  },
  {
    companyName: "InfraForge AI",
    title: "Deliver AI-Powered Infrastructure and Data Management Services",
    description: "Establish InfraForge AI as the global leader in AI-powered infrastructure services, providing intelligent infrastructure management, data optimization, and systems integration that powers the entire Paperclip ecosystem and enterprise customers worldwide.",
    level: "company",
    goalId: "INFRAFORGE-GOAL-001",
    ceo: "orchestrator",
  },
  {
    companyName: "PromptForge AI",
    title: "Provide Advanced AI Prompt Engineering and Orchestration",
    description: "Establish PromptForge AI as the global leader in advanced prompt engineering and AI orchestration, providing sophisticated prompt architectures, ethical AI frameworks, and orchestration capabilities that maximize AI system performance and ensure responsible AI deployment across all industries.",
    level: "company",
    goalId: "PROMPTFORGE-GOAL-001",
    ceo: "sage-chief-prompt-architect",
  },
  {
    companyName: "Loopy AI",
    title: "Deliver Creative AI and Content Generation Solutions",
    description: "Establish Loopy AI as the global leader in creative AI and content generation, providing intelligent creative tools, marketing automation, and artistic applications that empower creators, marketers, and businesses to produce compelling content at scale.",
    level: "company",
    goalId: "LOOPY-GOAL-001",
    ceo: "vision",
  },
];

const PROJECTS = [
  {
    companyName: "DevForge AI",
    goalId: "DEVFORGE-GOAL-001",
    name: "Agent Model Assessment Implementation",
    description: "Implement DevForge AI's intelligent model assessment system that leverages existing testing documentation to create automated model evaluation, performance optimization, and deployment validation frameworks.",
    status: "planning",
    projectId: "DEV-PROJ-001",
    targetDate: "2026-06-15",
    budget: 180000,
  },
  {
    companyName: "QualityForge AI",
    goalId: "QUALITYFORGE-GOAL-001",
    name: "Production Testing Automation Framework Implementation",
    description: "Transform QualityForge AI's existing testing documentation into an intelligent, automated testing framework that serves as the foundation for enterprise testing services with 90% reduction in manual testing effort.",
    status: "planning",
    projectId: "QUAL-PROJ-001",
    targetDate: "2026-06-15",
    budget: 180000,
  },
  {
    companyName: "DomainForge AI",
    goalId: "DOMAINFORGE-GOAL-001",
    name: "Long-Lead Item Procurement AI Automation System",
    description: "Implement DomainForge AI's intelligent procurement automation system that transforms long-lead item procurement workflows through AI-driven scheduling, supplier intelligence, and critical path optimization.",
    status: "planning",
    projectId: "DOMAIN-PROJ-001",
    targetDate: "2026-06-22",
    budget: 220000,
  },
  {
    companyName: "InfraForge AI",
    goalId: "INFRAFORGE-GOAL-001",
    name: "Intelligent Supabase Schema Management and Automation Platform",
    description: "Create InfraForge AI's intelligent database schema management platform that automates Supabase table creation, migration management, and performance optimization with 80% reduction in manual database operations.",
    status: "planning",
    projectId: "INFRA-PROJ-001",
    targetDate: "2026-06-01",
    budget: 195000,
  },
  {
    companyName: "PromptForge AI",
    goalId: "PROMPTFORGE-GOAL-001",
    name: "Intelligent Prompt Generation and Domain Knowledge Enhancement Platform",
    description: "Build PromptForge AI's intelligent platform that generates optimized prompts for agents while enhancing domain knowledge documentation, enabling automated project and issue plan generation from comprehensive domain expertise.",
    status: "planning",
    projectId: "PROMPT-PROJ-001",
    targetDate: "2026-06-15",
    budget: 210000,
  },
  {
    companyName: "Loopy AI",
    goalId: "LOOPY-GOAL-001",
    name: "AI Native Platform LinkedIn Campaign Content Generation",
    description: "Create Loopy AI's AI-powered LinkedIn campaign content generation system targeting mining executives with compelling narratives about AI native platform benefits, achieving 300%+ ROI through optimized engagement.",
    status: "planning",
    projectId: "LOOPY-PROJ-001",
    targetDate: "2026-05-15",
    budget: 85000,
  },
];

const ISSUES = [
  {
    companyName: "DevForge AI",
    projectName: "Agent Model Assessment Implementation",
    title: "Model Assessment Framework Architecture Design",
    description: "Design the core architecture for DevForge AI's intelligent model assessment framework that integrates with existing testing documentation and provides automated model evaluation capabilities.",
    status: "open",
    priority: "critical",
    issueId: "DEV-001",
    estimatedHours: 40,
  },
  {
    companyName: "QualityForge AI",
    projectName: "Production Testing Automation Framework Implementation",
    title: "Testing Framework Architecture Design",
    description: "Design the core architecture for QualityForge AI's automated testing framework that transforms existing testing documentation into intelligent, automated testing systems.",
    status: "open",
    priority: "critical",
    issueId: "QUAL-001",
    estimatedHours: 40,
  },
  {
    companyName: "DomainForge AI",
    projectName: "Long-Lead Item Procurement AI Automation System",
    title: "Procurement Domain Analysis for Long-Lead Item Intelligence",
    description: "Conduct comprehensive analysis of procurement domain requirements and long-lead item characteristics to establish the foundation for DomainForge AI's intelligent procurement automation system.",
    status: "open",
    priority: "critical",
    issueId: "DOMAIN-001",
    estimatedHours: 40,
  },
  {
    companyName: "InfraForge AI",
    projectName: "Intelligent Supabase Schema Management and Automation Platform",
    title: "Schema Intelligence Engine Architecture Design",
    description: "Design the core architecture for InfraForge AI's Schema Intelligence Engine that powers intelligent Supabase schema management and automation platform.",
    status: "open",
    priority: "critical",
    issueId: "INFRA-001",
    estimatedHours: 48,
  },
  {
    companyName: "PromptForge AI",
    projectName: "Intelligent Prompt Generation and Domain Knowledge Enhancement Platform",
    title: "Prompt Intelligence Engine Architecture Design",
    description: "Design the core architecture for PromptForge AI's Prompt Intelligence Engine that powers intelligent prompt generation and domain knowledge enhancement platform.",
    status: "open",
    priority: "critical",
    issueId: "PROMPT-001",
    estimatedHours: 48,
  },
  {
    companyName: "Loopy AI",
    projectName: "AI Native Platform LinkedIn Campaign Content Generation",
    title: "Mining Executive Persona Analysis for AI Native Platform Campaign",
    description: "Conduct comprehensive research and analysis of mining executive personas to understand their motivations, pain points, and technology adoption patterns for effective LinkedIn campaign content creation.",
    status: "open",
    priority: "critical",
    issueId: "LOOPY-001",
    estimatedHours: 32,
  },
];

async function loadData() {
  console.log("🚀 Starting Paperclip Ecosystem Data Load...");

  try {
    // 1. Verify Existing Companies
    console.log("\n📍 Verifying Existing Companies...");
    for (const [companyName, companyId] of Object.entries(EXISTING_COMPANIES)) {
      const existingCompany = await db
        .select()
        .from(schema.companies)
        .where(eq(schema.companies.id, companyId))
        .limit(1);

      if (existingCompany.length > 0) {
        console.log(`✅ Found company: ${companyName} (${companyId})`);
      } else {
        console.log(`❌ Company not found: ${companyName} (${companyId})`);
      }
    }

    // 2. Load Goals
    console.log("\n🎯 Loading Goals...");
    for (const goalData of GOALS) {
      const companyId = EXISTING_COMPANIES[goalData.companyName as keyof typeof EXISTING_COMPANIES];

      if (!companyId) {
        console.log(`❌ Company ID not found for: ${goalData.companyName}`);
        continue;
      }

      const existingGoal = await db
        .select()
        .from(schema.goals)
        .where(and(
          eq(schema.goals.companyId, companyId),
          eq(schema.goals.title, goalData.title)
        ))
        .limit(1);

      if (existingGoal.length === 0) {
        await db.insert(schema.goals).values({
          companyId: companyId,
          title: goalData.title,
          description: goalData.description,
          level: goalData.level,
          status: "active",
          ownerAgentId: null, // Will be set when agents are created
        });
        console.log(`✅ Created goal: ${goalData.title}`);
      } else {
        console.log(`⏭️  Goal already exists: ${goalData.title}`);
      }
    }

    // 3. Load Projects
    console.log("\n📋 Loading Projects...");
    for (const projectData of PROJECTS) {
      const companyId = EXISTING_COMPANIES[projectData.companyName as keyof typeof EXISTING_COMPANIES];

      if (!companyId) {
        console.log(`❌ Company ID not found for project: ${projectData.name}`);
        continue;
      }

      // Find the goal for this project
      const goal = await db
        .select()
        .from(schema.goals)
        .where(and(
          eq(schema.goals.companyId, companyId),
          eq(schema.goals.title, projectData.goalId.replace('-GOAL-001', ': ') + projectData.companyName.split(' ')[0])
        ))
        .limit(1);

      const existingProject = await db
        .select()
        .from(schema.projects)
        .where(and(
          eq(schema.projects.companyId, companyId),
          eq(schema.projects.name, projectData.name)
        ))
        .limit(1);

      if (existingProject.length === 0) {
        await db.insert(schema.projects).values({
          companyId: companyId,
          goalId: goal.length > 0 ? goal[0].id : null,
          name: projectData.name,
          description: projectData.description,
          status: projectData.status,
          targetDate: projectData.targetDate,
        });
        console.log(`✅ Created project: ${projectData.name}`);
      } else {
        console.log(`⏭️  Project already exists: ${projectData.name}`);
      }
    }

    // 4. Load Issues
    console.log("\n🎫 Loading Issues...");
    for (const issueData of ISSUES) {
      const companyId = EXISTING_COMPANIES[issueData.companyName as keyof typeof EXISTING_COMPANIES];

      if (!companyId) {
        console.log(`❌ Company ID not found for issue: ${issueData.title}`);
        continue;
      }

      const project = await db
        .select()
        .from(schema.projects)
        .where(and(
          eq(schema.projects.companyId, companyId),
          eq(schema.projects.name, issueData.projectName)
        ))
        .limit(1);

      if (project.length === 0) {
        console.log(`❌ Project not found for issue: ${issueData.title}`);
        continue;
      }

      const existingIssue = await db
        .select()
        .from(schema.issues)
        .where(and(
          eq(schema.issues.companyId, companyId),
          eq(schema.issues.title, issueData.title)
        ))
        .limit(1);

      if (existingIssue.length === 0) {
        await db.insert(schema.issues).values({
          companyId: companyId,
          projectId: project[0].id,
          title: issueData.title,
          description: issueData.description,
          status: issueData.status,
          priority: issueData.priority,
          identifier: `${issueData.issueId}`,
        });
        console.log(`✅ Created issue: ${issueData.title}`);
      } else {
        console.log(`⏭️  Issue already exists: ${issueData.title}`);
      }
    }

    // 5. Load Framework Documents
    console.log("\n📄 Loading Framework Documents...");

    // Cross-Company Coordination Framework
    const coordinationDoc = await db
      .select()
      .from(schema.documents)
      .where(eq(schema.documents.title, "Cross-Company Coordination Framework"))
      .limit(1);

    if (coordinationDoc.length === 0) {
      // Read the coordination framework content
      const fs = await import('fs');
      const path = await import('path');
      const coordPath = path.join(process.cwd(), 'docs-paperclip/development-paperclip/cross-company-coordination-framework.md');
      const coordContent = fs.readFileSync(coordPath, 'utf-8');

      await db.insert(schema.documents).values({
        title: "Cross-Company Coordination Framework",
        format: "markdown",
        latestBody: coordContent,
      });
      console.log("✅ Created coordination framework document");
    }

    // CEO Approval Workflows
    const approvalDoc = await db
      .select()
      .from(schema.documents)
      .where(eq(schema.documents.title, "CEO Approval Workflows for Strategic Goal Changes"))
      .limit(1);

    if (approvalDoc.length === 0) {
      const fs = await import('fs');
      const path = await import('path');
      const approvalPath = path.join(process.cwd(), 'docs-paperclip/development-paperclip/ceo-approval-workflows.md');
      const approvalContent = fs.readFileSync(approvalPath, 'utf-8');

      await db.insert(schema.documents).values({
        title: "CEO Approval Workflows for Strategic Goal Changes",
        format: "markdown",
        latestBody: approvalContent,
      });
      console.log("✅ Created CEO approval workflows document");
    }

    console.log("\n🎉 Paperclip Ecosystem Data Load Complete!");
    console.log("\n📊 Summary:");
    console.log("- 6 Companies loaded/verified");
    console.log("- 6 Strategic Goals loaded/verified");
    console.log("- 6 Projects loaded/verified");
    console.log("- 6 Issues loaded/verified");
    console.log("- 2 Framework documents loaded/verified");

  } catch (error) {
    console.error("❌ Error loading data:", error);
    throw error;
  } finally {
    await client.end();
  }
}

// Run the script
loadData().catch(console.error);