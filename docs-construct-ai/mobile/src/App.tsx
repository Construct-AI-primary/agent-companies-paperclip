import React, { useEffect } from 'react';
import { Provider, useDispatch } from 'react-redux';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';

import store, { AppDispatch } from './store';
import { initDatabase } from './services/database';
import { loadIncidentsFromDB, loadHazardsFromDB } from './store/slices/safetySlice';
import SafetyDashboard from './screens/safety/SafetyDashboardScreen';
import IncidentReportScreen from './screens/safety/IncidentReportScreen';
import IncidentDetailScreen from './screens/safety/IncidentDetailScreen';
import HazardReportScreen from './screens/safety/HazardReportScreen';
import SafetySettingsScreen from './screens/settings/SafetySettingsScreen';
import AISettingsScreen from './screens/safety/AISettingsScreen';
import AIDocumentTools from './components/AIDocumentTools';
import StockDashboardScreen from './screens/stock/StockDashboardScreen';
import EquipmentDashboardScreen from './screens/equipment/EquipmentDashboardScreen';
import EquipmentDetailScreen from './screens/equipment/EquipmentDetailScreen';
import EquipmentRegistrationForm from './screens/equipment/EquipmentRegistrationForm';
import MainDashboardScreen from './screens/MainDashboardScreen';
import LogisticsDashboardScreen from './screens/logistics/LogisticsDashboardScreen';
import AIInspectionScreen from './screens/logistics/AIInspectionScreen';

// New enhanced screens from mobile app enhancement plan
import CustomsClearanceScreen from './screens/logistics/CustomsClearanceScreen';
import PurchaseOrderScreen from './screens/procurement/PurchaseOrderScreen';
import IncidentManagementScreen from './screens/safety/IncidentManagementScreen';

// Initialize i18n service
import { initializeI18nService } from './services/i18n';

const Stack = createStackNavigator();

function AppContent() {
  const dispatch = useDispatch<AppDispatch>();

  useEffect(() => {
    const initializeApp = async () => {
      try {
        // Initialize i18n system first
        await initializeI18nService();

        // Initialize database
        await initDatabase();

        // Load data from database
        dispatch(loadIncidentsFromDB());
        dispatch(loadHazardsFromDB());

        // Initialize AI language settings
        await initializeAILanguage();
      } catch (error) {
        console.error('Failed to initialize app:', error);
      }
    };

    const initializeAILanguage = async () => {
      try {
        const { AsyncStorage } = require('@react-native-async-storage/async-storage');
        const { aiService } = require('./services/aiService');

        // Check if user has selected a language before
        const savedLanguage = await AsyncStorage.getItem('ai_language');

        if (!savedLanguage) {
          // First time user - detect device language
          const deviceLanguage = getDeviceLanguage();
          await AsyncStorage.setItem('ai_language', deviceLanguage);
          aiService.setLanguage(deviceLanguage);
          console.log(`Set AI language to device default: ${deviceLanguage}`);
        } else {
          // Use user's saved preference
          aiService.setLanguage(savedLanguage);
          console.log(`Using saved AI language: ${savedLanguage}`);
        }
      } catch (error) {
        console.error('Failed to initialize AI language:', error);
      }
    };

    const getDeviceLanguage = () => {
      try {
        // Try to get device language (this is a simplified approach)
        // In real implementation, you'd use react-native-localization or similar
        const languageCode = 'en'; // Default fallback

        // You could expand this to detect more languages based on device settings
        // For now, return 'en' as safe default for first-time users
        return languageCode;
      } catch (error) {
        console.error('Failed to detect device language:', error);
        return 'en';
      }
    };

    initializeApp();
  }, [dispatch]);

  return (
    <NavigationContainer>
      <Stack.Navigator
        initialRouteName="MainDashboard"
        screenOptions={{
          headerStyle: {
            backgroundColor: '#007AFF',
          },
          headerTintColor: '#fff',
          headerTitleStyle: {
            fontWeight: 'bold',
          },
        }}
      >
        <Stack.Screen
          name="MainDashboard"
          component={MainDashboardScreen}
          options={{ title: 'ConstructAI Platform' }}
        />
        <Stack.Screen
          name="StockDashboard"
          component={StockDashboardScreen}
          options={{ title: 'ConstructAI Stock Management' }}
        />
        <Stack.Screen
          name="SafetyDashboard"
          component={SafetyDashboard}
          options={{ title: 'ConstructAI Safety' }}
        />
        <Stack.Screen
          name="IncidentReport"
          component={IncidentReportScreen}
          options={{ title: 'Report Incident' }}
        />
        <Stack.Screen
          name="IncidentDetail"
          component={IncidentDetailScreen}
          options={{ title: 'Incident Details' }}
        />
        <Stack.Screen
          name="HazardReport"
          component={HazardReportScreen}
          options={{ title: 'Report Hazard' }}
        />
        <Stack.Screen
          name="SafetySettings"
          component={SafetySettingsScreen}
          options={{ title: 'Settings' }}
        />
        <Stack.Screen
          name="AIDocumentTools"
          component={AIDocumentTools}
          options={{ title: 'AI Document Tools' }}
        />
        <Stack.Screen
          name="AISettings"
          component={AISettingsScreen}
          options={{ title: 'AI Settings' }}
        />
        <Stack.Screen
          name="EquipmentDashboard"
          component={EquipmentDashboardScreen}
          options={{ title: 'Equipment Dashboard' }}
        />
        <Stack.Screen
          name="EquipmentDetail"
          component={EquipmentDetailScreen}
          options={{ title: 'Equipment Details' }}
        />
        <Stack.Screen
          name="EquipmentRegistration"
          component={EquipmentRegistrationForm}
          options={{ title: 'Register Equipment' }}
        />
        <Stack.Screen
          name="LogisticsDashboard"
          component={LogisticsDashboardScreen}
          options={{ title: 'Logistics Dashboard' }}
        />
        <Stack.Screen
          name="InspectionStart"
          component={AIInspectionScreen}
          options={{ title: '🔍 AI Inspection Management' }}
        />

        {/* Enhanced screens from mobile app enhancement plan */}
        <Stack.Screen
          name="CustomsClearance"
          component={CustomsClearanceScreen}
          options={{ title: '📋 Customs Clearance' }}
        />
        <Stack.Screen
          name="PurchaseOrders"
          component={PurchaseOrderScreen}
          options={{ title: '🛒 Purchase Orders' }}
        />
        <Stack.Screen
          name="IncidentManagement"
          component={IncidentManagementScreen}
          options={{ title: '🚨 Incident Management' }}
        />
      </Stack.Navigator>
      <StatusBar style="auto" />
    </NavigationContainer>
  );
}

export default function App() {
  return (
    <Provider store={store}>
      <SafeAreaProvider>
        <AppContent />
      </SafeAreaProvider>
    </Provider>
  );
}