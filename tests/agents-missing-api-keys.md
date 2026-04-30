# Agents Missing API Keys

This document lists the 37 agents that are missing API key records in the `agent_api_keys` table. Agents are organized by company and sorted alphabetically by dashboard name.

## Summary
- **Total agents missing API keys**: 37
- **Companies affected**: 5
- **Status**: Ready for API key creation

---

## 🧠 LearningForge AI

**Company ID**: `2bda2da6-dfa7-4709-b5d1-ea865f14072a`

| Agent Name | Agent ID |
|------------|----------|
| Echo | `cd89b10d-1a52-4915-aeae-e5e99619d81b` |
| Jax | `167667b8-ec8e-4009-940a-c53cdd3c1a3b` |
| Maya | `b5db7f9c-8ebf-4c6d-88f4-1e6b2f62e3c5` |
| Nova | `ab9afd81-c143-49d5-9b54-726a57eb2de5` |
| Sage | `76db5ec5-abdd-4c7f-a559-4e5b7d535b8b` |

---

## 🤖 PaperclipForge AI

**Company ID**: `550e8400-e29b-41d4-a716-446655440013`

| Agent Name | Agent ID |
|------------|----------|
| Analyst | `f3961d26-c0d3-4a5a-b702-4338b8037b8a` |
| Architect | `6b637c40-994c-4a44-b50e-8a4498c90406` |
| Controller | `ec2526f7-f100-41c9-a1c5-34c904dedced` |
| Coordinator (Project) | `acf682b2-0ef2-41cb-8294-292542f04a1b` |
| Coordinator (User Experience) | `dbe4baaf-3f94-4752-b3a0-a98723f62da7` |
| Director | `d693b727-fe3a-4d8f-aebe-9176c102431e` |
| Generator | `0e9450dd-1c62-4348-9cff-fc607d56980b` |
| Hazard | `a1b2c3d4-e5f6-4a7b-8c9d-000000000011` |
| Importer | `d51459ef-ee9e-4d56-aca9-15581ccc7973` |
| Integrator (Data) | `0fcfacef-179d-4798-8c34-d2c6d41336fb` |
| Integrator (Knowledge) | `988ab775-13aa-442d-83aa-5e0cec4c8309` |
| Maestro | `b9c5cb97-16dd-4625-82ad-08ae02bda193` |
| Manager (API) | `98cb13e0-3ec0-4ce9-8fc0-d04ac6dd7416` |
| Manager (Dependency) | `3a113676-b0b8-4cb3-ba2b-571ec6973c22` |
| Manager (Resource) | `27a53a71-8386-4a6b-b061-8f62eb303811` |
| Modeler | `a6ebf225-1d1d-4846-9c10-4f9ade074ea5` |
| Monitor | `2a98cb88-fd3a-4e39-a394-8c1dae1052dc` |
| Riley | `550e8400-e29b-41d4-a716-446655440017` |
| Safety | `a1b2c3d4-e5f6-4a7b-8c9d-000000000009` |
| Specialist (Assignment) | `76b3731e-a0dc-422f-b6b4-d97cb80ab665` |
| Specialist (Progress) | `550e8400-e29b-41d4-a716-446655440018` |
| Strategy | `a1b2c3d4-e5f6-4a7b-8c9d-000000000001` |
| Strategist | `37b23ea3-bf8c-47a5-80b2-104a475c4988` |
| Tracker | `157a25d3-efe7-41af-9e8f-7505e3bdc5a7` |
| Vision | `a7b3c2c3-364e-44c9-944f-c11415866765` |
| Workflow | `e23b18c5-bb0c-44c2-8bea-1f39178e338f` |

---

## 🔧 DevForge AI

**Company ID**: `f97b30e8-b022-4350-b4b0-30d43e2ebcf4`

| Agent Name | Agent ID |
|------------|----------|
| SQL | `633d48cb-8f00-4549-854d-4673554c7a38` |
| Troubleshooter | `11fd6a80-ec43-4f51-aa7b-1c63cc8cbeee` |
| Voyager | `ecd9bba7-2e91-4ef9-b4f3-bd37a54b818f` |

---

## 🏗️ InfraForge AI

**Company ID**: `09f438a3-4041-46f2-b3cc-96fc9446e666`

| Agent Name | Agent ID |
|------------|----------|
| Nimbus | `660e8400-e29b-41d4-a716-446655440002` |

---

## 🔨 Construct AI

**Company ID**: `f02b83a8-e0db-4332-b507-22f85e71ebf5`

| Agent Name | Agent ID |
|------------|----------|
| Discipline | `a8f43691-e2fa-4ca5-be8a-3a83ddbd967f` |

---

## 📋 Next Steps

1. **Execute SQL**: Run `create_missing_api_keys.sql` to create the API key records
2. **Generate Keys**: Create secure API keys for each agent
3. **Update Records**: Replace placeholder values with actual API keys
4. **Test Authentication**: Verify agents can authenticate with their new keys

## 📊 SQL File Location

The corresponding SQL file is located at: `create_missing_api_keys.sql`

This file contains the INSERT statements to create all missing API key records with placeholder values that need to be replaced with actual secure API keys.