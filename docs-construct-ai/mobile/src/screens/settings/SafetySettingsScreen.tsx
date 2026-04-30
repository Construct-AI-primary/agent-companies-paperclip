import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
} from 'react-native';
import { StatusBar } from 'expo-status-bar';
import { useSelector } from 'react-redux';
import { RootState } from '../../store';

export default function SafetySettingsScreen() {
  const safetyState = useSelector((state: RootState) => state.safety);

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Safety Settings</Text>
        <Text style={styles.subtitle}>Configure safety monitoring preferences</Text>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Current Status</Text>

        <View style={styles.statsContainer}>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{safetyState.incidents.length}</Text>
            <Text style={styles.statLabel}>Active Incidents</Text>
          </View>

          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{safetyState.hazards.length}</Text>
            <Text style={styles.statLabel}>Active Hazards</Text>
          </View>

          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{safetyState.syncStatus === 'syncing' ? 'YES' : 'NO'}</Text>
            <Text style={styles.statLabel}>Sync Status</Text>
          </View>
        </View>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Notification Settings</Text>
        <View style={styles.settingsList}>
          <Text style={styles.settingText}>
            🔴 Critical Incident Alerts: Enabled
          </Text>
          <Text style={styles.settingText}>
            🟡 Hazard Detection: Enabled
          </Text>
          <Text style={styles.settingText}>
            ✅ Safety Inspection Reminders: Enabled
          </Text>
        </View>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>System Information</Text>
        <View style={styles.settingsList}>
          <Text style={styles.settingText}>
            📊 AI Analytics Engine: Active
          </Text>
          <Text style={styles.settingText}>
            💾 Offline Data Sync: Ready
          </Text>
          <Text style={styles.settingText}>
            📱 Mobile App Version: 1.0.0
          </Text>
        </View>
      </View>

      <StatusBar style="light" />
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    backgroundColor: '#007AFF',
    padding: 20,
    alignItems: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: 'white',
    marginBottom: 5,
  },
  subtitle: {
    fontSize: 14,
    color: '#e6f2ff',
    textAlign: 'center',
  },
  section: {
    backgroundColor: 'white',
    margin: 15,
    borderRadius: 10,
    padding: 15,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 1,
    },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#333',
    marginBottom: 15,
  },
  statsContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  statCard: {
    flex: 1,
    alignItems: 'center',
    backgroundColor: '#f8f9fa',
    borderRadius: 8,
    padding: 10,
    marginHorizontal: 5,
  },
  statNumber: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#007AFF',
  },
  statLabel: {
    fontSize: 12,
    color: '#666',
    textAlign: 'center',
    marginTop: 2,
  },
  settingsList: {
    gap: 10,
  },
  settingText: {
    fontSize: 16,
    color: '#333',
    paddingVertical: 5,
  },
});
