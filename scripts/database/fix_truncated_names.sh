#!/bin/bash
# Fix truncated human names

declare -A fixes=(
  ["docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ContractAdministratio/AGENTS.md"]="Contract Administration"
  ["docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ContractAdministration/AGENTS.md"]="Contract Administration"
  ["docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ConstructionEngineeri/AGENTS.md"]="Construction Engineering"
  ["docs-paperclip/companies/domainforge-ai/agents/domainforge-ai-ConstructionEngineering/AGENTS.md"]="Construction Engineering"
  ["docs-paperclip/companies/infraforge-ai/agents/infraforge-ai-NimbusSupabaseSpecialist/AGENTS.md"]="Nimbus Supabase"
  ["docs-paperclip/companies/measureforge-ai/agents/specialists/procurement/measureforge-ai-ContractTenderSpecialist/AGENTS.md"]="Contract Tender"
  ["docs-paperclip/companies/measureforge-ai/agents/specialists/standards/measureforge-ai-SansStandardsSpecialist/AGENTS.md"]="Sans Standards"
  ["docs-paperclip/companies/measureforge-ai/agents/specialists/standards/measureforge-ai-AsaqsStandardsSpecialist/AGENTS.md"]="Asaqs Standards"
  ["docs-paperclip/companies/measureforge-ai/agents/validators/measureforge-ai-VisualOverlaySpecialist/AGENTS.md"]="Visual Overlay"
  ["docs-paperclip/companies/measureforge-ai/agents/validators/measureforge-ai-ElectricalQaSpecialist/AGENTS.md"]="Electrical QA"
  ["docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-Reporting-Specialist/AGENTS.md"]="Reporting Specialist"
  ["docs-paperclip/companies/contentforge-ai/agents/contentforge-ai-Conversion-Specialist/AGENTS.md"]="Conversion Specialist"
)

for file in "${!fixes[@]}"; do
  if [ -f "$file" ]; then
    name="${fixes[$file]}"
    sed -i.bak "s/^human_name:.*/human_name: $name/" "$file"
    echo "Fixed: $file -> $name"
    rm -f "${file}.bak"
  else
    echo "Missing: $file"
  fi
done
