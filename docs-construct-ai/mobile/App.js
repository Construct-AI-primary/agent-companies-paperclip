import React from 'react';
import { Provider } from 'react-redux';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';

import store from './src/store';
import SafetyDashboard from './src/screens/safety/SafetyDashboardScreen';
import IncidentReportScreen from './src/screens/safety/IncidentReportScreen';
import HazardReportScreen from './src/screens/safety/HazardReportScreen';
import SafetySettingsScreen from './src/screens/settings/SafetySettingsScreen';

const Stack = createStackNavigator();

function App() {
  return (
    <Provider store={store}>
      <SafeAreaProvider>
        <NavigationContainer>
          <Stack.Navigator
            initialRouteName="SafetyDashboard"
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
              name="HazardReport"
              component={HazardReportScreen}
              options={{ title: 'Report Hazard' }}
            />
            <Stack.Screen
              name="SafetySettings"
              component={SafetySettingsScreen}
              options={{ title: 'Settings' }}
            />
          </Stack.Navigator>
          <StatusBar style="auto" />
        </NavigationContainer>
      </SafeAreaProvider>
    </Provider>
  );
}

export default App;
