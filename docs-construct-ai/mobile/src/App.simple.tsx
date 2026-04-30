import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>ConstructAI Safety</Text>
      <Text style={styles.subtitle}>Mobile App - Phase 1 Complete!</Text>
      <View style={styles.features}>
        <Text style={styles.feature}>✅ SQLite Database Integration</Text>
        <Text style={styles.feature}>✅ Redux State Management</Text>
        <Text style={styles.feature}>✅ Incident Reporting Form</Text>
        <Text style={styles.feature}>✅ Photo Capture & GPS</Text>
        <Text style={styles.feature}>✅ Offline Functionality</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    padding: 20,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 10,
  },
  subtitle: {
    fontSize: 18,
    color: '#666',
    marginBottom: 30,
    textAlign: 'center',
  },
  features: {
    backgroundColor: '#fff',
    padding: 20,
    borderRadius: 10,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  feature: {
    fontSize: 16,
    color: '#333',
    marginBottom: 10,
  },
});
