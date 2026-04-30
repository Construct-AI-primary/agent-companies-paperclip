---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# RegionCountrySelector Component Usage Procedure

**Version:** 1.0 - Production Ready
**Date:** 2026-02-27
**Status:** ✅ Active
**Applies to:** Procurement Modal (01900), Logistics Modal (01700), and other geographic selection modals

## Executive Summary

This procedure provides comprehensive guidance for using the `RegionCountrySelector` component across multiple modals in the Construct AI system. The component provides consistent geographic selection functionality with numbered button interfaces that match the existing procurement workflow patterns.

## Table of Contents

1. [Component Overview](#component-overview)
2. [Interactive Selection Elements in 01900 Procurement](#interactive-selection-elements-in-01900-procurement)
3. [Component API Reference](#component-api-reference)
4. [Usage Examples](#usage-examples)
5. [Integration Guidelines](#integration-guidelines)
6. [Customization Options](#customization-options)
7. [Best Practices](#best-practices)
8. [Troubleshooting](#troubleshooting)

---

## Component Overview

### Purpose
The `RegionCountrySelector` component provides reusable geographic selection functionality for procurement, logistics, and other modals requiring destination selection. It maintains UI consistency with existing numbered button patterns while supporting flexible data configuration.

### Key Features
- **Reusable**: Single component for multiple modals
- **Consistent UI**: Matches existing group/category/item selection patterns
- **Flexible Data**: Built-in defaults + custom data support
- **Accessible**: Keyboard navigation and screen reader support
- **Responsive**: Mobile and desktop optimized
- **Type-Safe**: Comprehensive prop validation

### File Location
```
client/src/pages/01900-procurement/components/modals/components/RegionCountrySelector.jsx
```

---

## Interactive Selection Elements in 01900 Procurement

The 01900 procurement modal uses several types of interactive selection elements, all following the same numbered button pattern but with different CSS classes and layouts:

### 1. Group Selection Buttons
**CSS Class:** `group-selection-buttons` → `group-select-btn`  
**Purpose:** Select top-level procurement groups (Energy, Equipment, etc.)  
**Layout:** Grid layout with blue numbered badges  
**Interaction:** Single selection, triggers category loading

**Visual Structure:**
```
[1] Energy and Fluid - Fuel, lubricants, energy products
[2] Industrial Equipment - Manufacturing and industrial machinery
[3] Industrial Supplies and Consumables - Lubricants, consumables, industrial supplies
...
```

### 2. Category Selection Buttons
**CSS Class:** `category-selection-buttons` → `category-select-btn`  
**Purpose:** Select specific categories within chosen groups  
**Layout:** Grid layout with blue numbered badges  
**Interaction:** Single selection, triggers item loading

**Visual Structure:**
```
[1] Small Bulldozer - 80-100 HP models
[2] Medium Bulldozer - 160-200 HP models
[3] Large Bulldozer - 200+ HP models
...
```

### 3. Item Selection Buttons
**CSS Class:** `item-selection-buttons` → `item-select-btn`  
**Purpose:** Select specific items within chosen categories  
**Layout:** Grid layout with blue numbered badges  
**Interaction:** Multiple selection allowed (comma-separated)

**Visual Structure:**
```
[1] D3 Small Bulldozer - Caterpillar, 80-100 HP
[2] D6 Medium Bulldozer - Komatsu, 160-200 HP
[3] D9 Heavy Bulldozer - Caterpillar, 350-450 HP
...
💡 Select one or more items (comma-separated for multiple: e.g., "1,3,5")
```

### 4. Region Selection Buttons
**CSS Class:** `group-selection-buttons` → `group-select-btn` (reused)  
**Purpose:** Select destination regions for procurement delivery  
**Layout:** Grid layout with blue numbered badges  
**Interaction:** Single selection, triggers country loading

**Visual Structure:**
```
[1] Africa - Nigeria, South Africa, Kenya, Egypt
[2] Europe - Germany, France, UK, Netherlands
[3] Asia - China, India, Japan, Singapore
...
```

### 5. Country Selection Buttons
**CSS Class:** `category-selection-buttons` → `category-select-btn` (reused)  
**Purpose:** Select specific destination countries within regions  
**Layout:** Grid layout with blue numbered badges  
**Interaction:** Single selection, advances workflow

**Visual Structure:**
```
[1] South Africa - Johannesburg, Cape Town
[2] Nigeria - Lagos, Abuja
[3] Kenya - Nairobi, Mombasa
...
```

### Common Button Structure
All selection buttons share the same HTML structure:

```html
<button class="[type]-select-btn">
  <span class="[type]-number">1</span>
  <span class="[type]-text-container">
    <span class="[type]-name">Item Name</span>
    <span class="[type]-description">Description text</span>
  </span>
</button>
```

### Selection States
- **Default**: Light gray background with blue borders
- **Hover**: Light blue background with darker borders
- **Selected**: Blue background with white text
- **Disabled**: Reduced opacity with not-allowed cursor

---

## Component API Reference

### Props

| Prop | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| `currentStep` | `string` | ✅ | - | Either `"region"` or `"country"` |
| `selectedRegion` | `string` | ✅ (for country step) | `null` | Currently selected region ID |
| `selectedCountry` | `string` | ❌ | `null` | Currently selected country name |
| `onRegionSelect` | `function` | ✅ | - | Callback: `(regionId, regionName) => void` |
| `onCountrySelect` | `function` | ✅ | - | Callback: `(countryId, countryName) => void` |
| `disabled` | `boolean` | ❌ | `false` | Disable all interactions |
| `customRegions` | `array` | ❌ | `null` | Custom regions array |
| `customCountries` | `array` | ❌ | `null` | Custom countries array |

### Custom Data Format

#### Regions Array
```javascript
const customRegions = [
  {
    id: 1,
    name: "Africa",
    description: "Nigeria, South Africa, Kenya, Egypt"
  },
  {
    id: 2,
    name: "Europe",
    description: "Germany, France, UK, Netherlands"
  }
  // ... more regions
];
```

#### Countries Array (by Region)
```javascript
const customCountries = {
  1: [ // Africa
    {
      id: 1,
      name: "South Africa",
      description: "Johannesburg, Cape Town"
    },
    {
      id: 2,
      name: "Nigeria",
      description: "Lagos, Abuja"
    }
  ],
  2: [ // Europe
    {
      id: 8,
      name: "Germany",
      description: "Berlin, Munich"
    }
  ]
  // ... more regions
};
```

---

## Usage Examples

### Basic Region Selection (Procurement Modal)

```jsx
import RegionCountrySelector from './RegionCountrySelector.jsx';

function ProcurementModal({ selectedRegion, onRegionSelect, isProcessing }) {
  return (
    <div className="procurement-modal">
      {/* Other modal content */}

      <RegionCountrySelector
        currentStep="region"
        selectedRegion={selectedRegion}
        onRegionSelect={onRegionSelect}
        disabled={isProcessing}
      />
    </div>
  );
}
```

### Country Selection with Custom Data (Logistics Modal)

```jsx
const logisticsRegions = [
  { id: 1, name: "EMEA", description: "Europe, Middle East, Africa" },
  { id: 2, name: "APAC", description: "Asia Pacific" },
  { id: 3, name: "AMERICAS", description: "North & South America" }
];

const logisticsCountries = {
  1: [ // EMEA
    { id: 1, name: "Germany", description: "Major manufacturing hub" },
    { id: 2, name: "UAE", description: "Major trading hub" }
  ]
};

function LogisticsModal({ selectedRegion, selectedCountry, onCountrySelect }) {
  return (
    <RegionCountrySelector
      currentStep="country"
      selectedRegion={selectedRegion}
      selectedCountry={selectedCountry}
      onCountrySelect={onCountrySelect}
      customRegions={logisticsRegions}
      customCountries={logisticsCountries}
    />
  );
}
```

### Integration with Chat Interface

```jsx
function AgentChatInterface({ messages, selectedRegion, selectedCountry, onRegionSelect, onCountrySelect }) {
  const renderMessageContent = (content, role) => {
    if (role !== 'agent') return content;

    // Region selection
    if (content.includes('Where will these items be delivered?')) {
      return (
        <RegionCountrySelector
          currentStep="region"
          selectedRegion={selectedRegion}
          onRegionSelect={onRegionSelect}
          disabled={isProcessing}
        />
      );
    }

    // Country selection
    if (content.includes('Now please select the specific destination country')) {
      return (
        <RegionCountrySelector
          currentStep="country"
          selectedRegion={selectedRegion}
          selectedCountry={selectedCountry}
          onCountrySelect={onCountrySelect}
          disabled={isProcessing}
        />
      );
    }

    return content;
  };

  return (
    <div className="chat-messages">
      {messages.map(msg => (
        <div key={msg.id} className="message">
          {renderMessageContent(msg.content, msg.role)}
        </div>
      ))}
    </div>
  );
}
```

---

## Integration Guidelines

### 1. Import Statement
```javascript
import RegionCountrySelector from '../components/RegionCountrySelector.jsx';
```

### 2. State Management
```javascript
const [selectedRegion, setSelectedRegion] = useState(null);
const [selectedCountry, setSelectedCountry] = useState(null);
const [currentStep, setCurrentStep] = useState('region');

const handleRegionSelect = (regionId, regionName) => {
  setSelectedRegion(regionId);
  setCurrentStep('country');
  // Additional logic (API calls, validation, etc.)
};

const handleCountrySelect = (countryId, countryName) => {
  setSelectedCountry(countryName);
  setCurrentStep('complete');
  // Advance workflow
};
```

### 3. CSS Dependencies
The component requires the existing CSS classes from:
```
client/src/pages/01900-procurement/components/modals/components/css/01900-agent-chat-interface.css
```

Ensure these classes are available:
- `.interactive-message`
- `.message-text`
- `.group-selection-buttons`, `.group-select-btn`
- `.category-selection-buttons`, `.category-select-btn`
- `.group-number`, `.category-number`
- `.group-name`, `.category-name`
- `.group-description`, `.category-description`

### 4. Message Detection Patterns
Use these content patterns to detect when to show the component:

```javascript
const REGION_PATTERNS = [
  'Where will these items be delivered?',
  'destination region',
  'select your destination region'
];

const COUNTRY_PATTERNS = [
  'Now please select the specific destination country',
  'Perfect! You\'ve selected',
  'select the specific country'
];

const shouldShowRegionSelector = REGION_PATTERNS.some(pattern =>
  content.toLowerCase().includes(pattern.toLowerCase())
);

const shouldShowCountrySelector = COUNTRY_PATTERNS.some(pattern =>
  content.toLowerCase().includes(pattern.toLowerCase())
);
```

---

## Customization Options

### Custom Regions/Countries
Override the built-in geographic data:

```javascript
const tradeRegions = [
  { id: 1, name: "BRICS", description: "Brazil, Russia, India, China, South Africa" },
  { id: 2, name: "G7", description: "USA, UK, Germany, France, Italy, Canada, Japan" }
];

const tradeCountries = {
  1: [ // BRICS
    { id: 1, name: "Brazil", description: "São Paulo, Rio" },
    { id: 2, name: "Russia", description: "Moscow, St. Petersburg" },
    // ... etc
  ]
};
```

### Styling Customization
Override CSS variables for theming:

```css
/* Custom theme colors */
:root {
  --selector-primary-color: #007bff;
  --selector-hover-color: #e9ecef;
  --selector-selected-bg: #007bff;
  --selector-selected-text: white;
  --selector-disabled-opacity: 0.6;
}
```

### Accessibility Customization
Add custom ARIA labels:

```jsx
<RegionCountrySelector
  aria-label="Select destination region"
  role="radiogroup"
  // ... other props
/>
```

---

## Best Practices

### 1. State Management
- Always maintain `selectedRegion` and `selectedCountry` in parent component state
- Use meaningful variable names that indicate the selection context
- Reset selections when starting new workflows

### 2. Error Handling
```javascript
const handleRegionSelect = (regionId, regionName) => {
  try {
    // Validate selection
    if (!regionId || !regionName) {
      throw new Error('Invalid region selection');
    }

    // Update state
    setSelectedRegion(regionId);

    // Log selection for analytics
    console.log(`Region selected: ${regionName} (${regionId})`);

    // Advance workflow
    setCurrentStep('country');

  } catch (error) {
    console.error('Region selection error:', error);
    // Show user-friendly error message
    setErrorMessage('Please select a valid region');
  }
};
```

### 3. Performance Optimization
- Use `React.memo()` if component re-renders frequently
- Avoid inline functions in render
- Debounce rapid selections if necessary

```javascript
const MemoizedRegionCountrySelector = React.memo(RegionCountrySelector);
```

### 4. Mobile Responsiveness
- Component automatically adapts to screen size
- Test on various devices and orientations
- Ensure touch targets are at least 44px

### 5. Internationalization
- Component supports custom region/country names
- Use translation keys for built-in data
- Support RTL languages with proper CSS

---

## Troubleshooting

### Common Issues

#### Component Not Rendering
**Symptoms:** Region/country selector doesn't appear  
**Causes:**
- Missing `currentStep` prop
- Incorrect `selectedRegion` for country step
- CSS classes not loaded

**Solutions:**
```javascript
// Ensure required props
<RegionCountrySelector
  currentStep="region"  // Required
  selectedRegion={selectedRegion}
  onRegionSelect={handleRegionSelect}
  disabled={false}
/>
```

#### Selection Not Working
**Symptoms:** Clicking buttons doesn't trigger callbacks  
**Causes:**
- `disabled={true}` prop set
- Callback functions not bound correctly
- Event handlers not properly attached

**Debug:**
```javascript
const handleRegionSelect = (regionId, regionName) => {
  console.log('Region selected:', regionId, regionName); // Add debug logging
  setSelectedRegion(regionId);
};
```

#### Styling Issues
**Symptoms:** Buttons look wrong or don't match design  
**Causes:**
- Missing CSS file import
- CSS specificity conflicts
- Theme overrides interfering

**Check:**
```javascript
// Ensure CSS is imported
import './css/01900-agent-chat-interface.css';
```

#### Data Loading Issues
**Symptoms:** Custom regions/countries not showing  
**Causes:**
- Incorrect data format
- Props passed after component mount
- State updates not triggering re-render

**Fix:**
```javascript
// Use useEffect to update when custom data changes
useEffect(() => {
  // Force re-render or update component
}, [customRegions, customCountries]);
```

### Performance Issues
**Symptoms:** Component slow to render with many options  
**Solutions:**
- Limit number of regions/countries displayed
- Use virtualization for large lists
- Implement search/filter functionality

### Accessibility Issues
**Symptoms:** Screen readers not announcing selections  
**Fixes:**
- Add proper ARIA labels
- Ensure keyboard navigation works
- Test with screen reader software

---

## Testing Checklist

### Functional Tests
- [ ] Region selection triggers correct callback
- [ ] Country selection only shows after region selected
- [ ] Custom data overrides work correctly
- [ ] Disabled state prevents interactions
- [ ] Multiple selections work (if applicable)

### UI/UX Tests
- [ ] Buttons match existing design patterns
- [ ] Hover states work correctly
- [ ] Selected states are visually clear
- [ ] Responsive design works on mobile
- [ ] Loading states show properly

### Accessibility Tests
- [ ] Keyboard navigation works
- [ ] Screen readers announce selections
- [ ] Color contrast meets WCAG standards
- [ ] Focus indicators are visible

### Integration Tests
- [ ] Works in procurement modal
- [ ] Works in logistics modal
- [ ] Chat interface integration works
- [ ] State management works across re-renders

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-02-27 | Initial production release with full API and documentation |

---

## Support

For issues or questions regarding the RegionCountrySelector component:

1. Check this procedure document first
2. Review the component source code comments
3. Test with the provided examples
4. Contact the UI/UX team for design-related issues
5. Contact the frontend development team for technical issues

---

**Document Author:** AI Assistant  
**Review Date:** 2026-02-27  
**Next Review:** 2026-08-27  
**Document ID:** PROC-REGION-COUNTRY-001