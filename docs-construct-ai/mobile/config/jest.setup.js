// jest.setup.js
// Define React Native globals
global.__DEV__ = true;
global.__fbBatchedBridgeConfig = {};

// Import React Native Testing Library extensions
import '@testing-library/jest-native/extend-expect';

// Mock React Native modules that aren't available in Jest
jest.mock('react-native-reanimated', () => {
  const Reanimated = require('react-native-reanimated/mock');
  
  // The mock for `call` immediately calls the callback which is incorrect
  // So we override it with a no-op
  Reanimated.default.call = () => {};
  
  return Reanimated;
});

// Mock react-native-gesture-handler
jest.mock('react-native-gesture-handler', () => {
  return {
    ScrollView: 'View',
    State: {},
    PanGestureHandler: 'View',
    BaseButton: 'View',
    Directions: {},
  };
});

// Mock React Native core modules completely
jest.mock('react-native', () => {
  const React = require('react');
  
  // Create proper React components that work with React Native Testing Library
  const View = React.forwardRef(({ children, ...props }, ref) => 
    React.createElement('View', { ...props, ref }, children)
  );
  View.displayName = 'View';
  
  const Text = React.forwardRef(({ children, ...props }, ref) => 
    React.createElement('Text', { ...props, ref }, children)
  );
  Text.displayName = 'Text';
  
  const TouchableOpacity = React.forwardRef(({ children, onPress, ...props }, ref) => 
    React.createElement('TouchableOpacity', { ...props, ref, onPress }, children)
  );
  TouchableOpacity.displayName = 'TouchableOpacity';
  
  const ScrollView = React.forwardRef(({ children, ...props }, ref) => 
    React.createElement('ScrollView', { ...props, ref }, children)
  );
  ScrollView.displayName = 'ScrollView';
  
  const TextInput = React.forwardRef(({ onChange, onChangeText, placeholder, value, ...props }, ref) => {
    const handleChange = (event) => {
      if (onChange) onChange(event);
      if (onChangeText) onChangeText(event.nativeEvent.text);
    };
    return React.createElement('TextInput', { 
      ...props, 
      placeholder, 
      ref, 
      onChange: handleChange,
      onKeyPress: props.onKeyPress,
      value: value
    });
  });
  TextInput.displayName = 'TextInput';
  
  const SafeAreaView = React.forwardRef(({ children, ...props }, ref) => 
    React.createElement('SafeAreaView', { ...props, ref }, children)
  );
  SafeAreaView.displayName = 'SafeAreaView';
  
  return {
    Platform: {
      OS: 'ios',
      select: jest.fn((obj) => obj.ios),
    },
    StyleSheet: {
      create: jest.fn((styles) => styles),
      flatten: jest.fn((styles) => styles),
    },
    View,
    Text,
    TouchableOpacity,
    ScrollView,
    TextInput,
    SafeAreaView,
    Alert: {
      alert: jest.fn(),
    },
    AccessibilityInfo: {
      isScreenReaderEnabled: jest.fn(() => Promise.resolve(false)),
      addEventListener: jest.fn(),
      removeEventListener: jest.fn(),
    },
    Dimensions: {
      get: jest.fn().mockReturnValue({ width: 375, height: 667 }),
    },
  };
});

// Mock expo modules
jest.mock('expo-constants', () => {
  return {
    default: {
      expoConfig: {
        extra: {
          // Add any extra config values your app uses
        },
      },
    },
  };
});

// Mock AsyncStorage
jest.mock('@react-native-async-storage/async-storage', () =>
  require('@react-native-async-storage/async-storage/jest/async-storage-mock')
);

// Mock Expo modules that might be used in components
jest.mock('expo-linking', () => {
  return {
    createURL: jest.fn(),
    addEventListener: jest.fn(),
  };
});

// Mock navigation
jest.mock('@react-navigation/native', () => {
  return {
    useNavigation: jest.fn(() => ({
      navigate: jest.fn(),
      dispatch: jest.fn(),
      goBack: jest.fn(),
    })),
    useRoute: jest.fn(() => ({
      params: {},
    })),
  };
});

// Mock database module to avoid SQLite issues in tests
// But allow the actual database tests to use the real implementation
jest.mock('./src/services/database', () => {
  // Check if we're running database tests
  if (expect.getState().testPath && expect.getState().testPath.includes('database.test')) {
    // For database tests, use the actual implementation
    return jest.requireActual('./src/services/database');
  }
  
  // For other tests, use mocks
  return {
    initDatabase: jest.fn(() => Promise.resolve()),
    saveEquipment: jest.fn(() => Promise.resolve()),
    getEquipment: jest.fn(() => Promise.resolve([])),
    getUnsyncedEquipment: jest.fn(() => Promise.resolve([])),
    updateEquipmentSyncStatus: jest.fn(() => Promise.resolve()),
    saveIncident: jest.fn(() => Promise.resolve()),
    getIncidents: jest.fn(() => Promise.resolve([])),
    saveHazard: jest.fn(() => Promise.resolve()),
    getHazards: jest.fn(() => Promise.resolve([])),
    updateHazardSyncStatus: jest.fn(() => Promise.resolve()),
    updateIncidentSyncStatus: jest.fn(() => Promise.resolve()),
    getUnsyncedIncidents: jest.fn(() => Promise.resolve([])),
    getUnsyncedHazards: jest.fn(() => Promise.resolve([])),
    getDatabaseStats: jest.fn(() => Promise.resolve({
      incidentCount: 0,
      syncedIncidents: 0,
      hazardCount: 0,
      syncedHazards: 0,
    })),
  };
});

// Mock API service to avoid Supabase configuration issues in tests
jest.mock('./src/services/api', () => {
  return {
    default: {
      equipment: {
        create: jest.fn(() => Promise.resolve({ data: {}, error: null })),
        getAll: jest.fn(() => Promise.resolve({ data: [], error: null })),
        update: jest.fn(() => Promise.resolve({ data: {}, error: null })),
        delete: jest.fn(() => Promise.resolve({ data: {}, error: null })),
      },
    },
  };
});

// Mock Expo SQLite
jest.mock('expo-sqlite', () => {
  return {
    openDatabase: jest.fn(),
  };
});

// Mock React Native Picker
jest.mock('@react-native-picker/picker', () => {
  const React = require('react');
  
  class Picker extends React.Component {
    static Item = class Item extends React.Component {
      render() {
        // Render a simple component for testing purposes
        return React.createElement('PickerItem', this.props);
      }
    };
    
    render() {
      // Render a simple component for testing purposes
      return React.createElement('Picker', this.props);
    }
  }
  
  // Add the select method to the Picker class
  Picker.select = jest.fn();
  
  return {
    Picker,
  };
});

// Mock global.fetch for testing API calls
global.fetch = jest.fn();

// Mock console.error and console.warn to reduce noise in tests
console.error = jest.fn();
console.warn = jest.fn();
