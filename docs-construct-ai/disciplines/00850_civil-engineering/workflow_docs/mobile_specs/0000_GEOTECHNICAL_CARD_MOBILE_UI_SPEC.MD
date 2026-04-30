---
title: Geotechnical Card Mobile Modal Specification
author: Construct AI Memory System Team
date: 2026-03-29
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, mobile-cards, geotechnical, analysis-agent, borehole-data, field-testing
openstinger_context: mobile-card-specification, soil-testing, foundation-analysis, offline-geotech
last_updated: 2026-03-29
---

# 00850_0_GEOTECHNICAL_CARD_MOBILE_UI_SPEC.md - Geotechnical Card Mobile Modal Specification

## Mobile Card Overview
- **Card Type**: Geotechnical (Phase 1, Card 3) - Mobile Optimized
- **Mobile Features**: Borehole data capture, soil testing integration, foundation analysis, offline geotechnical database
- **Agent Assignment**: Analysis Agent (Mobile Optimized)
- **Key Mobile Capabilities**: GPS borehole logging, photo documentation, voice field notes, offline soil classification

## Mobile Modal Structure

### Mobile Header (Field Context)
```
┌─────────────────────────────────────────┐
│ 🌍 GEOTECHNICAL CARD                   │
│ Phase 1 of 5 • 🔄 In Progress          │
│ Agent: Analysis                        │
│ 📍 GPS: ±3m • 🏗️ Foundation Analysis   │
└─────────────────────────────────────────┘
```

### Main Content Area (Mobile Viewport)

#### Section 1: Borehole Data Capture
```
┌─ Borehole Logging ──────────────────────┐
│                                        │
│ 📍 Borehole Location:                  │
│ BH-001: [-26.2041, 28.0473]           │
│ Elevation: 1452m AHD                  │
│                                        │
│ 🏗️ Drilling Details:                  │
│ Method: Rotary • Diameter: 150mm      │
│ Depth: 12.5m • Date: 2026-03-29      │
│                                        │
│ 🌱 Soil Profile:                       │
│ 0-3m: Sandy SILT (SP)                 │
│ 3-8m: Clayey SAND (SC)                │
│ 8-12.5m: Weathered ROCK               │
│                                        │
│ 📷 Borehole Photos: [8 captured]      │
│ 🖼️ View • 📷 Add Photo                │
│                                        │
│ 🎤 Field Notes: [3 recordings]        │
│ "Water table at 2.5m depth"           │
└───────────────────────────────────────┘
```

#### Section 2: Foundation Recommendations (Mobile Optimized)
```
┌─ Foundation Analysis ───────────────────┐
│                                        │
│ 🏗️ Recommended Foundation:             │
│ Bored Piles - Ø600mm                   │
│                                        │
│ 📊 Key Parameters:                     │
│ Bearing Capacity: 180 kPa             │
│ Settlement: <25mm                     │
│ Safety Factor: 2.5                    │
│                                        │
│ ⚠️ Critical Considerations:            │
│ • Groundwater at 2.5m                │
│ • Corrosion protection required      │
│ • Seismic zone - ductility check     │
│                                        │
│ 📋 Recommendations:                   │
│ Conduct pile load testing             │
│ Monitor groundwater levels            │
│ Consider soil improvement            │
└───────────────────────────────────────┘
```

### Mobile Footer Actions (Geotechnical Optimized)
```
┌─────────────────────────────────────────────────┐
│ 📍 New Borehole    🏗️ Foundation    📊 Analysis │
│ ✅ Complete        📥 Export        🔄 Sync      │
└─────────────────────────────────────────────────┘
```

## Mobile-Specific Features

### Borehole Data Capture
- **GPS Integration**: Automatic borehole location capture
- **Photo Logging**: Geo-tagged borehole photos with depth markers
- **Voice Notes**: Field observations and soil descriptions
- **Offline Storage**: Local database of borehole records
- **Sync Management**: Background upload of geotechnical data

### Foundation Analysis Tools
- **Mobile Calculations**: Bearing capacity and settlement analysis
- **Foundation Selection**: Touch-based foundation type selection
- **Parameter Input**: Simplified input for soil properties
- **Recommendation Engine**: AI-assisted foundation recommendations

### Field Testing Integration
- **SPT Integration**: Standard penetration test data capture
- **Lab Test Linking**: Connection to laboratory testing results
- **Sample Tracking**: Borehole sample location and testing status
- **Quality Assurance**: Field testing procedure validation

## Mobile Performance & Offline Capabilities
- **Offline Database**: Complete geotechnical database access
- **Fast Synchronization**: Prioritized upload of critical foundation data
- **Battery Optimization**: Extended field operation for borehole logging
- **Data Compression**: Efficient storage of borehole photos and logs

## Mobile Success Metrics
- **Data Capture Speed**: 60% faster borehole logging vs traditional methods
- **Foundation Accuracy**: >95% alignment with desktop analysis
- **Offline Capability**: Full foundation analysis without network
- **User Adoption**: >85% geotechnical engineers using mobile tools