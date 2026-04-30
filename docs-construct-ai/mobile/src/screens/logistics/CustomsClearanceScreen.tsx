/**
 * Customs Clearance Screen
 * Implements AI-powered customs document generation with GPS tagging
 * Following Phase 1A of mobile enhancement implementation plan
 */

import React, { useState, useEffect } from 'react';
import {
  View,
  ScrollView,
  StyleSheet,
  Alert,
  ActivityIndicator,
} from 'react-native';
import { Text, Card, Button, TextInput, Chip } from 'react-native-paper';
import { useTranslation } from '../../services/i18n';
import { aiService, AIRequest, DeviceContext } from '../../services/aiService';
import * as Location from 'expo-location';

interface CustomsDocument {
  id: string;
  type: 'commercial_invoice' | 'certificate_origin' | 'packing_list' | 'customs_declaration';
  status: 'draft' | 'processing' | 'completed' | 'error';
  data: any;
  gpsLocation?: {
    latitude: number;
    longitude: number;
    timestamp: string;
  };
}

const CustomsClearanceScreen: React.FC = () => {
  const { t } = useTranslation();
  const [documents, setDocuments] = useState<CustomsDocument[]>([]);
  const [currentDocument, setCurrentDocument] = useState<Partial<CustomsDocument>>({
    type: 'commercial_invoice',
    status: 'draft'
  });
  const [isProcessing, setIsProcessing] = useState(false);
  const [location, setLocation] = useState<Location.LocationObject | null>(null);
  const [hasLocationPermission, setHasLocationPermission] = useState(false);

  useEffect(() => {
    requestLocationPermission();
    loadExistingDocuments();
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
      Alert.alert(t('location.gpsRequired'), t('location.gpsRequired'));
    }
  };

  const loadExistingDocuments = async () => {
    // Load from local storage or API
    // Implementation would load existing customs documents
  };

  const generateDocument = async () => {
    if (!currentDocument.type) {
      Alert.alert('Error', 'Please select document type');
      return;
    }

    setIsProcessing(true);

    try {
      // GPS tagging
      let gpsData = null;
      if (hasLocationPermission && location) {
        gpsData = {
          latitude: location.coords.latitude,
          longitude: location.coords.longitude,
          timestamp: new Date().toISOString()
        };
      }

      const aiRequest: AIRequest = {
        type: 'customs-clearance',
        parameters: {
          priority: 'high',
          content: JSON.stringify({
            documentType: currentDocument.type,
            location: gpsData,
            context: currentDocument.data || {}
          })
        }
      };

      const deviceContext: DeviceContext = {
        connectivity: 'online', // Would be determined from network status
        availableStorage: 1000000000, // 1GB - would be checked
        availableRAM: 2000000000, // 2GB - would be checked
        batteryLevel: 80, // Would be checked
        platform: 'ios' // Would be detected
      };

      const result = await aiService.processRequest(aiRequest, deviceContext);

      const newDocument: CustomsDocument = {
        id: Date.now().toString(),
        type: currentDocument.type,
        status: 'completed',
        data: result.data,
        gpsLocation: gpsData
      };

      setDocuments(prev => [...prev, newDocument]);
      Alert.alert('Success', 'Customs document generated successfully');

      // Reset form
      setCurrentDocument({ type: 'commercial_invoice', status: 'draft' });

    } catch (error) {
      console.error('Document generation error:', error);
      Alert.alert('Error', 'Failed to generate customs document');
    } finally {
      setIsProcessing(false);
    }
  };

  const documentTypes = [
    { key: 'commercial_invoice', label: 'Commercial Invoice' },
    { key: 'certificate_origin', label: 'Certificate of Origin' },
    { key: 'packing_list', label: 'Packing List' },
    { key: 'customs_declaration', label: 'Customs Declaration' }
  ];

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text variant="headlineMedium" style={styles.title}>
          Customs Clearance
        </Text>
        <Text variant="bodyMedium" style={styles.subtitle}>
          AI-powered document generation with GPS verification
        </Text>
      </View>

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

      {/* Document Type Selection */}
      <Card style={styles.formCard}>
        <Card.Title title="Document Type" />
        <Card.Content>
          <View style={styles.documentTypeContainer}>
            {documentTypes.map((docType) => (
              <Chip
                key={docType.key}
                mode={currentDocument.type === docType.key ? 'flat' : 'outlined'}
                onPress={() => setCurrentDocument(prev => ({ ...prev, type: docType.key }))}
                style={styles.documentTypeChip}
              >
                {docType.label}
              </Chip>
            ))}
          </View>
        </Card.Content>
      </Card>

      {/* Generate Button */}
      <View style={styles.buttonContainer}>
        <Button
          mode="contained"
          onPress={generateDocument}
          disabled={isProcessing || !currentDocument.type}
          loading={isProcessing}
          style={styles.generateButton}
        >
          {isProcessing ? 'Generating...' : 'Generate Document'}
        </Button>
      </View>

      {/* Generated Documents List */}
      <View style={styles.documentsSection}>
        <Text variant="titleMedium" style={styles.sectionTitle}>
          Generated Documents
        </Text>

        {documents.length === 0 ? (
          <Card style={styles.emptyCard}>
            <Card.Content>
              <Text variant="bodyMedium" style={styles.emptyText}>
                No documents generated yet
              </Text>
            </Card.Content>
          </Card>
        ) : (
          documents.map((doc) => (
            <Card key={doc.id} style={styles.documentCard}>
              <Card.Content>
                <View style={styles.documentHeader}>
                  <Text variant="titleSmall">{doc.type.replace('_', ' ').toUpperCase()}</Text>
                  <Chip
                    mode="outlined"
                    selectedColor={doc.status === 'completed' ? '#4CAF50' : '#FF9800'}
                  >
                    {doc.status}
                  </Chip>
                </View>

                {doc.gpsLocation && (
                  <Text variant="bodySmall" style={styles.gpsText}>
                    GPS Tagged: {doc.gpsLocation.latitude.toFixed(4)}, {doc.gpsLocation.longitude.toFixed(4)}
                  </Text>
                )}

                <Text variant="bodySmall" style={styles.timestamp}>
                  Generated: {new Date(parseInt(doc.id)).toLocaleString()}
                </Text>
              </Card.Content>
            </Card>
          ))
        )}
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
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
  gpsCard: {
    marginBottom: 16,
    backgroundColor: '#E3F2FD',
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
  documentTypeContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  documentTypeChip: {
    marginBottom: 4,
  },
  buttonContainer: {
    marginBottom: 24,
  },
  generateButton: {
    paddingVertical: 8,
  },
  documentsSection: {
    marginTop: 8,
  },
  sectionTitle: {
    fontWeight: 'bold',
    marginBottom: 12,
    color: '#1976D2',
  },
  emptyCard: {
    backgroundColor: '#FAFAFA',
  },
  emptyText: {
    textAlign: 'center',
    color: '#666',
  },
  documentCard: {
    marginBottom: 8,
  },
  documentHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  gpsText: {
    color: '#4CAF50',
    fontWeight: 'bold',
  },
  timestamp: {
    color: '#666',
    marginTop: 4,
  },
});

export default CustomsClearanceScreen;