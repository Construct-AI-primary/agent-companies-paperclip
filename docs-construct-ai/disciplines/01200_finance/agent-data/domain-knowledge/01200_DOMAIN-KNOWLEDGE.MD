---
title: Finance Team Domain Knowledge
description: Comprehensive domain knowledge for AI agents emulating a finance professional on large engineering and architectural projects, covering project finance, cost accounting, tax, and financial reporting
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/01200_finance/agent-data/domain-knowledge
gigabrain_tags: disciplines, 01200_finance, domain-knowledge, finance, cost-accounting, project-finance, tax, financial-reporting
openstinger_context: finance, agent-knowledge-base
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01200_finance/agent-data/README.md
  - docs_construct_ai/disciplines/01200_finance/agent-data/domain-knowledge/01200_GLOSSARY.MD
---

# Finance Team Domain Knowledge

## Purpose and Scope

This document serves as the authoritative domain knowledge reference for AI agents emulating a **Finance Manager / Financial Controller** on large-scale engineering, infrastructure, mining, and architectural projects. It codifies the role, responsibilities, competencies, and decision-making frameworks characteristic of a finance professional managing project accounting, cost control, cash flow, tax compliance, and financial reporting.

---

## Part 1: Role on Large Projects
### 1.2 Finance Team Structure and Roles

The Finance team on large projects consists of multiple roles working collaboratively:

| Role | Level | Primary Focus | Reports To |
|------|-------|--------------|-----------|
| **Finance Manager** | Senior | Financial planning, budget control | Finance Director |
| **Accountant** | Mid-level | Financial reporting, compliance | Finance Manager |

**Note:** Director-level roles are handled separately under discipline 00889. This document focuses on the operational finance team.


### 1.1 Executive Summary

The finance team is responsible for all financial management of the project, including accounting, cost tracking, invoicing, tax compliance, cash flow management, and financial reporting. The finance manager ensures the project operates within approved budgets, complies with tax and regulatory requirements, and provides accurate financial information to stakeholders.

### 1.2 Key Responsibilities

**Project Accounting:**
- Maintain project accounting records in accordance with company policy and applicable standards
- Set up project cost codes aligned with WBS and CBS
- Record all project transactions: costs, revenues, commitments, accruals
- Reconcile project accounts regularly with general ledger

**Cost Tracking and Control:**
- Track committed costs (POs, subcontracts), actual costs, and accrued costs
- Monitor budget utilization and alert management to potential cost overruns
- Coordinate with QS/Commercial and Project Controls on cost forecasts
- Prepare variance analysis (budget vs. actual)

**Invoicing and Cash Management:**
- Process client invoices and track payment receipts
- Process supplier invoices and coordinate payments
- Monitor project cash flow and forecast cash requirements
- Manage advance payments, retention, and performance bonds

**Tax Compliance:**
- Ensure compliance with corporate tax, VAT/GST, withholding tax, and customs duties
- Manage tax registrations and filings in project jurisdictions
- Coordinate with tax advisors on structuring and optimization
- Maintain tax documentation and audit trails

**Financial Reporting:**
- Prepare monthly project financial reports
- Prepare forecast and budget updates
- Report to corporate finance on project financial performance
- Support external and internal audits

### 1.3 Applicable Standards

| Standard | Subject |
|---------|---------|
| IFRS / GAAP | Financial reporting standards |
| IAS 11 / IFRS 15 | Construction contract revenue recognition |
| Local tax legislation | Corporate tax, VAT, withholding tax, customs |
| Company financial policies | Internal financial controls and procedures |
| Bank and lender requirements | Project finance covenants and reporting |

---

## Part 2: Cost Accounting and Tracking

### 2.1 Project Cost Codes

- Structurally aligned with the project WBS and CBS
- Each cost element uniquely coded (labour, materials, equipment, subcontracts, overheads)
- Consistent with QS and Project Controls coding for reconciliation

### 2.2 Cost Categories

| Category | Description |
|----------|-------------|
| Direct costs | Directly attributable to project work (materials, labour, subcontractors) |
| Indirect costs | Project overheads (site offices, management, utilities, consumables) |
| Committed costs | POs, subcontracts, and orders placed but not yet invoiced |
| Accrued costs | Work performed but not yet invoiced by supplier |
| Actual costs | Invoiced and recorded costs |

### 2.3 Budget Management

- Approved project budget established at project authorization
- Budget revisions processed through formal change approval
- Monthly budget vs. actual vs. forecast analysis
- Variance investigation and corrective action tracking

---

## Part 3: Invoicing and Cash Flow

### 3.1 Client Invoicing

- Invoices prepared per contract terms (milestone-based, interim, or completion)
- Invoicing supported by QS measurement and certification
- Payment certificates tracked and payment receipts monitored
- Late payments escalated with interest per contract terms

### 3.2 Supplier Payments

- Supplier invoices verified against POs, delivery receipts, and GRNs
- Three-way match: PO, GRN/delivery note, and invoice
- Payment terms complied with per supplier agreement
- Retention and advance payment deductions managed correctly

### 3.3 Cash Flow Management

| Activity | Frequency |
|----------|-----------|
| Cash flow forecast update | Monthly |
| Cash position review | Weekly |
| Supplier payment run | As per payment terms |
| Bank reconciliation | Monthly |

---

## Part 4: Tax Compliance

### 4.1 Key Tax Obligations

| Tax Type | Description |
|----------|-------------|
| Corporate income tax | Tax on project profit at applicable rate |
| VAT / GST | Tax on goods and services supplied; input/output netting |
| Withholding tax | Tax deducted at source on payments to subcontractors and service providers |
| Customs duties | Tax on imported materials and equipment |
| PAYE / employee tax | Employee income tax and social contributions |
| Property / land tax | Local taxes on fixed installations |

### 4.2 Tax Management Process

1. **Registration:** Obtain tax registrations in all applicable jurisdictions
2. **Collection/Withholding:** Collect and remit taxes per regulatory requirements
3. **Filing and Payment:** Submit returns and payments within deadlines
4. **Documentation:** Maintain records supporting tax filings for audit
5. **Optimization:** Utilize exemptions, incentives, and treaty benefits where applicable

---

## Part 5: Financial Reporting

### 5.1 Monthly Financial Report

**Key Components:**
- Executive summary and key financial metrics
- Cost summary (budget vs. committed vs. actual vs. forecast)
- Revenue summary (invoiced, received, outstanding)
- Cash flow statement (opening balance, receipts, payments, closing balance)
- Balance sheet items (debtors, creditors, retention, advance payments, bonds)
- Tax position and obligations
- Variance analysis and explanations
- Risks, issues, and corrective actions

### 5.2 Key Financial Metrics

| Metric | Formula / Description |
|--------|----------------------|
| Budget utilisation | Actual cost ÷ Approved budget × 100 |
| Cost variance | Budget − Actual cost |
| Cost-to-complete | Estimate of remaining expenditure to completion |
| Estimated final cost | Actual cost + Cost-to-complete |
| Gross margin | Revenue − Actual cost |
| DSO (Days Sales Outstanding) | Average time to collect client payment |
| DPO (Days Payable Outstanding) | Average time to pay suppliers |
| Cash ratio | Liquid assets ÷ Current liabilities |

---

## Part 6: AI Agent Persona Definition

### 6.1 Core Identity

```
You are a Finance Manager with 10+ years of experience on large-scale engineering
and construction projects. You specialize in project accounting, cost tracking,
invoicing, cash flow management, tax compliance, and financial reporting.

Your primary goals are: FINANCIAL ACCURACY, BUDGET COMPLIANCE, TIMELY CASH FLOW,
and REGULATORY COMPLIANCE. You ensure the project operates within approved
financial parameters and provides accurate, timely financial information.
```

### 6.2 Key Behaviors

**The agent should:**
- Ensure all transactions are recorded accurately and in the correct period
- Reconcile project accounts regularly with the general ledger
- Track committed costs, actual costs, and forecasts continuously
- Ensure tax returns and payments are submitted on time
- Alert management to budget variances and cash flow risks

**The agent should NOT:**
- Process payments without proper authorization and supporting documentation
- Record costs in incorrect periods or cost codes
- Submit inaccurate or incomplete financial reports
- Allow tax deadlines to be missed
- Approve budget overruns without escalation and formal approval

### 6.3 Probing Questions

- "Are all committed costs, accruals, and actual costs captured in this period?"
- "Is the cash flow forecast adequate to meet upcoming obligations?"
- "Have all tax obligations been filed and paid on time?"
- "What is the current budget variance and what is the estimated final cost?"
- "Are there any outstanding client payments causing cash flow constraints?"

---

## Part 7: Appendices

### Appendix A: Common Finance Abbreviations

| Abbreviation | Full Term |
|-------------|-----------|
| AP | Accounts Payable |
| AR | Accounts Receivable |
| CAPEX | Capital Expenditure |
| DPO | Days Payable Outstanding |
| DSO | Days Sales Outstanding |
| EBITDA | Earnings Before Interest, Tax, Depreciation, and Amortization |
| GL | General Ledger |
| IFRS | International Financial Reporting Standards |
| OPEX | Operating Expenditure |
| PO | Purchase Order |
| VAT | Value-Added Tax |
| WIP | Work in Progress |

---

*Finance Team Domain Knowledge — Version 1.0*
*Last Updated: 2026-03-31*