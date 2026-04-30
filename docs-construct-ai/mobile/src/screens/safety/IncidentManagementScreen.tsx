/**
 * Incident Management Screen
 * Implements AI-powered incident classification with multi-language support
 * Following Phase 2 of mobile enhancement implementation plan
 */

import React, { useState, useEffect } from 'react';
import {
  View,
  ScrollView,
  StyleSheet,
  Alert,
} from 'react-native';
import { Text, Card, Button, TextInput, Chip, FAB, SegmentedButtons } from 'react-native-paper';
import { useTranslation } from '../../services/i18n';
import { aiService, AIRequest, DeviceContext } from '../../services/aiService';
import * as Location from 'expo-location';
import * as Haptics from 'expo-haptics';

interface SafetyIncident {
  id: string;
  title: string;
  description: string;
  severity: 'low' | 'medium' | 'high' | 'critical';
  category: 'equipment' | 'environmental' | 'human' | 'process' | 'other';
  status: 'reported' | 'investigating' | 'resolved';
  location: {
    latitude: number;
    longitude: number;
    timestamp: string;
  };
  aiClassification?: {
    confidence: number;
    suggestedSeverity: string;
    suggestedCategory: string;
    responseTime: string;
    requiresReport: boolean;
  };
  createdAt: string;
  language: string;
  iotSensors?: {
    deviceId: string;
    sensorType: string;
    reading: number;
    threshold: number;
    triggered: boolean;
  }[];
}

const IncidentManagementScreen: React.FC = () => {
  const { t, changeLanguage, currentLanguage } = useTranslation();
  const [incidents, setIncidents] = useState<SafetyIncident[]>([]);
  const [currentIncident, setCurrentIncident] = useState<Partial<SafetyIncident>>({
    severity: 'medium',
    category: 'other',
    status: 'reported'
  });
  const [isProcessing, setIsProcessing] = useState(false);
  const [location, setLocation] = useState<Location.LocationObject | null>(null);
  const [hasLocationPermission, setHasLocationPermission] = useState(false);
  const [selectedLanguage, setSelectedLanguage] = useState(currentLanguage);

  useEffect(() => {
    requestLocationPermission();
    loadExistingIncidents();
    // Simulate IoT sensor monitoring
    startIotMonitoring();
  }, []);

  const requestLocationPermission = async () => {
    try {
      const { status } = await Location.requestForegroundPermissionsAsync();
      setHasLocationPermission(status === 'granted');

      if (status === 'granted') {
        const location = await Location.getCurrentPositionAsync({});
        setLocation(location);
      }
    } catch (error) {
      console.error('Location permission error:', error);
    }
  };

  const loadExistingIncidents = async () => {
    // Load from local storage or API
    // Implementation would load existing incidents
  };

  const startIotMonitoring = () => {
    // Simulate IoT sensor data - in real implementation would connect to actual sensors
    const mockSensors = [
      { deviceId: 'sensor_001', sensorType: 'gas_detector', reading: 15, threshold: 10 },
      { deviceId: 'sensor_002', sensorType: 'temperature', reading: 85, threshold: 80 },
      { deviceId: 'sensor_003', sensorType: 'vibration', reading: 2.1, threshold: 2.0 }
    ];

    // Check for threshold breaches
    const triggeredSensors = mockSensors.filter(sensor => sensor.reading > sensor.threshold);

    if (triggeredSensors.length > 0) {
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Warning);
      Alert.alert(
        'IoT Alert',
        `${triggeredSensors.length} sensor(s) have exceeded thresholds. Auto-generating incident report.`
      );

      // Auto-generate incident from IoT data
      generateIotIncident(triggeredSensors);
    }
  };

  const generateIotIncident = async (triggeredSensors: any[]) => {
    const iotIncident: Partial<SafetyIncident> = {
      title: 'IoT Sensor Alert - Automatic Report',
      description: `Automated incident report triggered by ${triggeredSensors.length} sensor(s):\n\n` +
        triggeredSensors.map(sensor =>
          `${sensor.sensorType}: ${sensor.reading} (threshold: ${sensor.threshold})`
        ).join('\n'),
      severity: 'high',
      category: 'equipment',
      iotSensors: triggeredSensors
    };

    setCurrentIncident(iotIncident);
  };

  const classifyIncidentWithAI = async () => {
    if (!currentIncident.title || !currentIncident.description) {
      Alert.alert('Error', 'Please provide incident title and description');
      return;
    }

    setIsProcessing(true);

    try {
      const aiRequest: AIRequest = {
        type: 'incident-classification',
        parameters: {
          priority: 'high',
          content: JSON.stringify({
            title: currentIncident.title,
            description: currentIncident.description,
            language: selectedLanguage
          })
        }
      };

      const deviceContext: DeviceContext = {
        connectivity: 'online',
        availableStorage: 1000000000,
        availableRAM: 2000000000,
        batteryLevel: 80,
        platform: 'ios'
      };

      const result = await aiService.processRequest(aiRequest, deviceContext);

      // Apply AI classification
      setCurrentIncident(prev => ({
        ...prev,
        aiClassification: {
          confidence: result.data.confidence || 0.85,
          suggestedSeverity: result.data.severity || 'medium',
          suggestedCategory: result.data.category || 'other',
          responseTime: result.data.responseTime || '4 hours',
          requiresReport: result.data.requiresReport || false
        },
        severity: result.data.severity || prev.severity,
        category: result.data.category || prev.category
      }));

      Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
      Alert.alert('AI Classification Complete', `Incident classified with ${result.data.confidence * 100}% confidence`);

    } catch (error) {
      console.error('AI classification error:', error);
      Alert.alert('Error', 'Failed to classify incident with AI');
    } finally {
      setIsProcessing(false);
    }
  };

  const submitIncident = async () => {
    if (!currentIncident.title || !currentIncident.description) {
      Alert.alert('Error', 'Please provide incident title and description');
      return;
    }

    if (!hasLocationPermission || !location) {
      Alert.alert('Error', 'GPS location required for incident reporting');
      return;
    }

    const incident: SafetyIncident = {
      id: Date.now().toString(),
      title: currentIncident.title,
      description: currentIncident.description,
      severity: currentIncident.severity || 'medium',
      category: currentIncident.category || 'other',
      status: 'reported',
      location: {
        latitude: location.coords.latitude,
        longitude: location.coords.longitude,
        timestamp: new Date().toISOString()
      },
      aiClassification: currentIncident.aiClassification,
      createdAt: new Date().toISOString(),
      language: selectedLanguage,
      iotSensors: currentIncident.iotSensors
    };

    setIncidents(prev => [...prev, incident]);

    // Reset form
    setCurrentIncident({
      severity: 'medium',
      category: 'other',
      status: 'reported'
    });

    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    Alert.alert('Success', 'Incident reported successfully with GPS verification');
  };

  const updateIncidentStatus = (incidentId: string, newStatus: string) => {
    setIncidents(prev => prev.map(incident =>
      incident.id === incidentId
        ? { ...incident, status: newStatus as any }
        : incident
    ));
  };

  const changeIncidentLanguage = async (languageCode: string) => {
    setSelectedLanguage(languageCode);
    await changeLanguage(languageCode);
  };

  const severityColors = {
    low: '#4CAF50',
    medium: '#FF9800',
    high: '#F44336',
    critical: '#9C27B0'
  };

  const categoryLabels = {
    equipment: 'Equipment',
    environmental: 'Environmental',
    human: 'Human Factor',
    process: 'Process',
    other: 'Other'
  };

  return (
    <View style={styles.container}>
      <ScrollView style={styles.scrollContainer}>
        <View style={styles.header}>
          <Text variant="headlineMedium" style={styles.title}>
            Incident Management
          </Text>
          <Text variant="bodyMedium" style={styles.subtitle}>
            AI-powered classification with multi-language support
          </Text>
        </View>

        {/* Language Selection */}
        <Card style={styles.languageCard}>
          <Card.Title title="Report Language" />
          <Card.Content>
            <SegmentedButtons
              value={selectedLanguage}
              onValueChange={changeIncidentLanguage}
              buttons={[
                { value: 'en', label: 'EN' },
                { value: 'es', label: 'ES' },
                { value: 'pt', label: 'PT' },
                { value: 'fr', label: 'FR' },
                { value: 'ar', label: 'AR' },
                { value: 'de', label: 'DE' },
                { value: 'zu', label: 'ZU' },
                { value: 'xh', label: 'XH' },
                { value: 'sw', label: 'SW' }
              ]}
            />
          </Card.Content>
        </Card>

        {/* GPS Status */}
        <Card style={styles.gpsCard}>
          <Card.Content>
            <View style={styles.gpsStatus}>
              <Text variant="titleSmall">GPS Status:</Text>
              <Chip
                mode="outlined"
                selectedColor={hasLocationPermission ? '#4CAF50' : '#F44336'}
              >
                {hasLocationPermission ? 'Active' : 'Disabled'}
              </Chip>
            </View>
            {location && (
              <Text variant="bodySmall" style={styles.locationText}>
                Location: {location.coords.latitude.toFixed(6)}, {location.coords.longitude.toFixed(6)}
              </Text>
            )}
          </Card.Content>
        </Card>

        {/* Incident Form */}
        <Card style={styles.formCard}>
          <Card.Title title="Report New Incident" />
          <Card.Content>
            <TextInput
              label="Incident Title"
              value={currentIncident.title || ''}
              onChangeText={(text) => setCurrentIncident(prev => ({ ...prev, title: text }))}
              style={styles.input}
            />

            <TextInput
              label="Description"
              value={currentIncident.description || ''}
              onChangeText={(text) => setCurrentIncident(prev => ({ ...prev, description: text }))}
              multiline
              numberOfLines={4}
              style={styles.input}
            />

            {/* Severity Selection */}
            <View style={styles.severitySection}>
              <Text variant="titleSmall" style={styles.sectionTitle}>Severity</Text>
              <View style={styles.severityButtons}>
                {(['low', 'medium', 'high', 'critical'] as const).map((severity) => (
                  <Chip
                    key={severity}
                    mode={currentIncident.severity === severity ? 'flat' : 'outlined'}
                    onPress={() => setCurrentIncident(prev => ({ ...prev, severity }))}
                    style={{ backgroundColor: currentIncident.severity === severity ? severityColors[severity] : undefined }}
                    textStyle={{ color: currentIncident.severity === severity ? '#FFFFFF' : severityColors[severity] }}
                  >
                    {severity.toUpperCase()}
                  </Chip>
                ))}
              </View>
            </View>

            {/* Category Selection */}
            <View style={styles.categorySection}>
              <Text variant="titleSmall" style={styles.sectionTitle}>Category</Text>
              <View style={styles.categoryButtons}>
                {(Object.keys(categoryLabels) as Array<keyof typeof categoryLabels>).map((category) => (
                  <Chip
                    key={category}
                    mode={currentIncident.category === category ? 'flat' : 'outlined'}
                    onPress={() => setCurrentIncident(prev => ({ ...prev, category }))}
                  >
                    {categoryLabels[category]}
                  </Chip>
                ))}
              </View>
            </View>

            {/* IoT Sensors Display */}
            {currentIncident.iotSensors && currentIncident.iotSensors.length > 0 && (
              <View style={styles.iotSection}>
                <Text variant="titleSmall" style={styles.sectionTitle}>IoT Sensor Data</Text>
                {currentIncident.iotSensors.map((sensor, index) => (
                  <Card key={index} style={[styles.sensorCard, sensor.triggered && styles.triggeredSensor]}>
                    <Card.Content>
                      <Text variant="bodySmall">{sensor.sensorType}: {sensor.reading} (threshold: {sensor.threshold})</Text>
                      {sensor.triggered && <Text variant="bodySmall" style={styles.triggeredText}>TRIGGERED</Text>}
                    </Card.Content>
                  </Card>
                ))}
              </View>
            )}
          </Card.Content>
        </Card>

        {/* AI Classification */}
        <View style={styles.aiSection}>
          <Button
            mode="outlined"
            onPress={classifyIncidentWithAI}
            disabled={isProcessing || !currentIncident.title || !currentIncident.description}
            loading={isProcessing}
            icon="brain"
            style={styles.aiButton}
          >
            {isProcessing ? 'Analyzing...' : 'AI Classification'}
          </Button>

          {currentIncident.aiClassification && (
            <Card style={styles.aiResultCard}>
              <Card.Content>
                <Text variant="titleSmall" style={styles.aiTitle}>AI Analysis Result</Text>
                <Text variant="bodySmall">
                  Confidence: {(currentIncident.aiClassification.confidence * 100).toFixed(1)}%
                </Text>
                <Text variant="bodySmall">
                  Suggested Response Time: {currentIncident.aiClassification.responseTime}
                </Text>
                <Text variant="bodySmall">
                  Requires Report: {currentIncident.aiClassification.requiresReport ? 'Yes' : 'No'}
                </Text>
              </Card.Content>
            </Card>
          )}
        </View>

        {/* Submit Button */}
        <View style={styles.buttonContainer}>
          <Button
            mode="contained"
            onPress={submitIncident}
            disabled={!currentIncident.title || !currentIncident.description || !hasLocationPermission}
            style={styles.submitButton}
          >
            Submit Incident Report
          </Button>
        </View>

        {/* Incidents List */}
        <View style={styles.incidentsSection}>
          <Text variant="titleMedium" style={styles.sectionTitle}>
            Reported Incidents
          </Text>

          {incidents.length === 0 ? (
            <Card style={styles.emptyCard}>
              <Card.Content>
                <Text variant="bodyMedium" style={styles.emptyText}>
                  No incidents reported yet
                </Text>
              </Card.Content>
            </Card>
          ) : (
            incidents.map((incident) => (
              <Card key={incident.id} style={styles.incidentCard}>
                <Card.Content>
                  <View style={styles.incidentHeader}>
                    <Text variant="titleSmall">{incident.title}</Text>
                    <View style={styles.statusContainer}>
                      <Chip
                        mode="outlined"
                        selectedColor={severityColors[incident.severity]}
                        style={{ backgroundColor: severityColors[incident.severity] }}
                        textStyle={{ color: '#FFFFFF' }}
                      >
                        {incident.severity.toUpperCase()}
                      </Chip>
                      <Chip mode="outlined">
                        {incident.status}
                      </Chip>
                    </View>
                  </View>

                  <Text variant="bodySmall" style={styles.description}>
                    {incident.description.substring(0, 100)}...
                  </Text>

                  <Text variant="bodySmall">
                    Category: {categoryLabels[incident.category]}
                  </Text>

                  <Text variant="bodySmall" style={styles.locationText}>
                    Location: {incident.location.latitude.toFixed(4)}, {incident.location.longitude.toFixed(4)}
                  </Text>

                  <Text variant="bodySmall" style={styles.timestamp}>
                    Reported: {new Date(incident.createdAt).toLocaleString()}
                  </Text>

                  {incident.aiClassification && (
                    <Text variant="bodySmall" style={styles.aiText}>
                      AI Confidence: {(incident.aiClassification.confidence * 100).toFixed(1)}%
                    </Text>
                  )}

                  {incident.status === 'reported' && (
                    <View style={styles.actionButtons}>
                      <Button
                        mode="outlined"
                        onPress={() => updateIncidentStatus(incident.id, 'investigating')}
                        style={styles.actionButton}
                      >
                        Start Investigation
                      </Button>
                      <Button
                        mode="outlined"
                        onPress={() => updateIncidentStatus(incident.id, 'resolved')}
                        style={styles.actionButton}
                      >
                        Mark Resolved
                      </Button>
                    </View>
                  )}
                </Card.Content>
              </Card>
            ))
          )}
        </View>
      </ScrollView>

      {/* Emergency FAB */}
      <FAB
        icon="alert"
        onPress={() => generateIotIncident([])}
        style={styles.emergencyFab}
        color="#FFFFFF"
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  scrollContainer: {
    flex: 1,
    padding: 16,
  },
  header: {
    marginBottom: 20,
  },
  title: {
    fontWeight: 'bold',
    color: '#1976D2',
  },
  subtitle: {
    color: '#666',
    marginTop: 4,
  },
  languageCard: {
    marginBottom: 16,
    backgroundColor: '#E3F2FD',
  },
  gpsCard: {
    marginBottom: 16,
    backgroundColor: '#FFF3E0',
  },
  gpsStatus: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  locationText: {
    color: '#666',
  },
  formCard: {
    marginBottom: 16,
  },
  input: {
    marginBottom: 12,
  },
  severitySection: {
    marginTop: 16,
  },
  sectionTitle: {
    fontWeight: 'bold',
    marginBottom: 12,
    color: '#1976D2',
  },
  severityButtons: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  categorySection: {
    marginTop: 16,
  },
  categoryButtons: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  iotSection: {
    marginTop: 16,
  },
  sensorCard: {
    marginBottom: 8,
  },
  triggeredSensor: {
    backgroundColor: '#FFEBEE',
    borderColor: '#F44336',
  },
  triggeredText: {
    color: '#F44336',
    fontWeight: 'bold',
  },
  aiSection: {
    marginBottom: 16,
  },
  aiButton: {
    marginBottom: 12,
  },
  aiResultCard: {
    backgroundColor: '#F3E5F5',
  },
  aiTitle: {
    fontWeight: 'bold',
    color: '#7B1FA2',
  },
  buttonContainer: {
    marginBottom: 24,
  },
  submitButton: {
    paddingVertical: 8,
  },
  incidentsSection: {
    marginTop: 8,
  },
  emptyCard: {
    backgroundColor: '#FAFAFA',
  },
  emptyText: {
    textAlign: 'center',
    color: '#666',
  },
  incidentCard: {
    marginBottom: 8,
  },
  incidentHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 8,
  },
  statusContainer: {
    flexDirection: 'row',
    gap: 8,
    flexWrap: 'wrap',
  },
  description: {
    marginBottom: 8,
    color: '#666',
  },
  timestamp: {
    color: '#666',
    marginTop: 4,
  },
  aiText: {
    color: '#7B1FA2',
    fontWeight: 'bold',
    marginTop: 4,
  },
  actionButtons: {
    flexDirection: 'row',
    gap: 8,
    marginTop: 12,
  },
  actionButton: {
    flex: 1,
  },
  emergencyFab: {
    position: 'absolute',
    margin: 16,
    right: 0,
    bottom: 80,
    backgroundColor: '#F44336',
  },
});

export default IncidentManagementScreen;