import React, { useState, useRef, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  Alert,
  Dimensions,
  ActivityIndicator,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import { Camera, CameraView } from 'expo-camera';
import * as ImagePicker from 'expo-image-picker';
import * as Location from 'expo-location';

interface DetectionResult {
  type: 'damage' | 'counting' | 'classification' | 'anomaly';
  confidence: number;
  severity: 'low' | 'medium' | 'high' | 'critical';
  description: string;
  coordinates?: { x: number; y: number; width: number; height: number };
  recommendations: string[];
}

const { width, height } = Dimensions.get('window');

const AIInspectionScreen: React.FC = () => {
  const navigation = useNavigation();
  const cameraRef = useRef<CameraView | null>(null);

  const [hasPermission, setHasPermission] = useState<boolean | null>(true); // Initially assume permission is granted, will check when needed
  const [isAnalyzing, setIsAnalyzing] = useState(false);
  const [cameraType, setCameraType] = useState<'back' | 'front'>('back');
  const [detectionMode, setDetectionMode] = useState<'damage' | 'counting' | 'anomaly' | 'classification'>('damage');
  const [detectionResults, setDetectionResults] = useState<DetectionResult[]>([]);
  const [currentLocation, setCurrentLocation] = useState<{lat: number, lng: number} | null>(null);
  const [sessionStarted, setSessionStarted] = useState(false);
  const [permissionsChecked, setPermissionsChecked] = useState(false);
  const [sessionStartTime] = useState(new Date());

  const startSession = () => {
    setSessionStarted(true);
    setDetectionResults([]);
  };

  const endSession = () => {
    setSessionStarted(false);
    Alert.alert(
      'Session Complete',
      `Inspection session ended after ${Math.floor((new Date().getTime() - sessionStartTime.getTime()) / 60000)} minutes`,
      [
        {
          text: 'Review Results',
          onPress: () => {
            // For now, just show an alert since InspectionResults screen doesn't exist
            Alert.alert('Results', `Found ${detectionResults.length} results to review`);
          },
        },
        {
          text: 'Generate Report',
          onPress: () => generateReport(),
        },
        { text: 'Close', style: 'cancel' },
      ]
    );
  };

  const takePhoto = async () => {
    if (!cameraRef.current) return;

    setIsAnalyzing(true);
    try {
      const photo = await cameraRef.current.takePictureAsync({
        quality: 0.8,
        base64: false,
        exif: true,
      });

      await simulateAIAnalysis(photo.uri);
    } catch (error) {
      Alert.alert('Error', 'Failed to capture photo');
    } finally {
      setIsAnalyzing(false);
    }
  };

  const pickImageFromLibrary = async () => {
    const { status } = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (status !== 'granted') {
      Alert.alert('Permission Denied', 'Media library access is required');
      return;
    }

    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: false,
      quality: 0.8,
      exif: true,
    });

    if (!result.canceled && result.assets[0]) {
      setIsAnalyzing(true);
      await simulateAIAnalysis(result.assets[0].uri);
      setIsAnalyzing(false);
    }
  };

  const simulateAIAnalysis = async (imageUri: string) => {
    // Simulate AI analysis processing time
    await new Promise(resolve => setTimeout(resolve, 2000));

    const mockResults: DetectionResult[] = [];

    // Generate different types of detection results based on mode
    if (detectionMode === 'damage') {
      if (Math.random() > 0.6) {
        mockResults.push({
          type: 'damage',
          confidence: Math.random() * 0.3 + 0.7, // 70-100%
          severity: Math.random() > 0.7 ? 'high' : Math.random() > 0.4 ? 'medium' : 'low',
          description: Math.random() > 0.5 ? 'Surface scratches detected' : 'Corner dent identified',
          recommendations: ['Log damage report', 'Inspect structural integrity', 'Document for insurance'],
        });
      } else {
        mockResults.push({
          type: 'damage',
          confidence: 0.95,
          severity: 'low',
          description: 'No visible damage detected',
          recommendations: ['Surface condition is good', 'Continue regular inspections'],
        });
      }
    } else if (detectionMode === 'counting') {
      const countedItems = Math.floor(Math.random() * 50) + 10;
      const expectedItems = Math.floor(countedItems * (0.9 + Math.random() * 0.2)); // 90-110% of counted

      mockResults.push({
        type: 'counting',
        confidence: 0.88,
        severity: Math.abs(countedItems - expectedItems) > 5 ? 'high' : 'low',
        description: `Counted ${countedItems} items (expected ~${expectedItems})`,
        recommendations: Math.abs(countedItems - expectedItems) > 5
          ? ['Verify item count manually', 'Check loading procedures', 'Report discrepancy to supervisor']
          : ['Count verified successfully', 'Continue with loading process'],
      });
    } else if (detectionMode === 'anomaly') {
      if (Math.random() > 0.7) {
        mockResults.push({
          type: 'anomaly',
          confidence: Math.random() * 0.2 + 0.8, // 80-100%
          severity: 'medium',
          description: Math.random() > 0.5 ? 'Unusual loading pattern detected' : 'Equipment positioning anomaly',
          recommendations: ['Review loading procedure', 'Verify equipment calibration', 'Conduct manual inspection'],
        });
      } else {
        mockResults.push({
          type: 'anomaly',
          confidence: 0.92,
          severity: 'low',
          description: 'No anomalies detected in loading process',
          recommendations: ['Loading process within normal parameters', 'Continue current procedures'],
        });
      }
    } else if (detectionMode === 'classification') {
      const classifications = [
        'Standard shipping containers',
        'Hazardous materials packaging',
        'Fragile item containers',
        'Bulk cargo pallets',
        'Over-size cargo units'
      ];

      mockResults.push({
        type: 'classification',
        confidence: 0.94,
        severity: 'low',
        description: `Classified as: ${classifications[Math.floor(Math.random() * classifications.length)]}`,
        recommendations: ['Classification verified', 'Apply appropriate handling procedures'],
      });
    }

    setDetectionResults(prev => [...prev, ...mockResults]);

    // Haptic feedback
    // Vibration.vibrate(200);
  };

  const generateReport = () => {
    const reportSummary = {
      sessionDuration: Math.floor((new Date().getTime() - sessionStartTime.getTime()) / 60000),
      totalAnalyses: detectionResults.length,
      criticalIssues: detectionResults.filter(r => r.severity === 'critical').length,
      highIssues: detectionResults.filter(r => r.severity === 'high').length,
      recommendations: detectionResults.flatMap(r => r.recommendations),
      timestamp: new Date().toISOString(),
      location: currentLocation,
    };

    Alert.alert(
      'Report Generated',
      `Inspection report created with ${reportSummary.totalAnalyses} AI analyses and ${reportSummary.criticalIssues + reportSummary.highIssues} issues detected.`,
      [
        {
          text: 'View Report',
          onPress: () => {
            // For now, just show an alert since InspectionReport screen doesn't exist
            Alert.alert('Report Summary', `Report generated with ${reportSummary.totalAnalyses} analyses and ${reportSummary.criticalIssues + reportSummary.highIssues} issues detected.`);
          },
        },
        { text: 'Share', style: 'cancel' },
      ]
    );
  };

  const clearResults = () => {
    setDetectionResults([]);
  };

  if (hasPermission === null) {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color="#007AFF" />
          <Text style={styles.loadingText}>Requesting permissions...</Text>
        </View>
      </SafeAreaView>
    );
  }

  if (hasPermission === false) {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.errorContainer}>
          <Ionicons name="eye-off" size={64} color="#dc3545" />
          <Text style={styles.errorTitle}>Camera Permission Required</Text>
          <Text style={styles.errorText}>
            This app needs camera and location permissions to perform AI-powered inspections.
          </Text>
          <TouchableOpacity
            style={styles.retryButton}
            onPress={() => navigation.goBack()}
          >
            <Text style={styles.retryButtonText}>Go Back</Text>
          </TouchableOpacity>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <TouchableOpacity
          style={styles.backButton}
          onPress={() => navigation.goBack()}
        >
          <Ionicons name="arrow-back" size={24} color="#007AFF" />
        </TouchableOpacity>
        <Text style={styles.title}>AI Inspection</Text>
        <View style={{ width: 24 }} />
      </View>

      {!sessionStarted ? (
        // Pre-session setup
        <View style={styles.setupContainer}>
          <Text style={styles.setupTitle}>Start AI Inspection Session</Text>

          <View style={styles.modeSelection}>
            <Text style={styles.modeTitle}>Detection Mode:</Text>
            {[
              { key: 'damage', label: 'Damage Detection', icon: 'construct' },
              { key: 'counting', label: 'Item Counting', icon: 'calculator' },
              { key: 'anomaly', label: 'Anomaly Detection', icon: 'warning' },
              { key: 'classification', label: 'Load Classification', icon: 'pricetag' },
            ].map(({ key, label, icon }) => (
              <TouchableOpacity
                key={key}
                style={[
                  styles.modeButton,
                  detectionMode === key && styles.modeButtonActive,
                ]}
                onPress={() => setDetectionMode(key as any)}
              >
                <Ionicons name={icon as any} size={24} color={detectionMode === key ? '#fff' : '#007AFF'} />
                <Text style={[
                  styles.modeButtonText,
                  detectionMode === key && styles.modeButtonTextActive,
                ]}>
                  {label}
                </Text>
              </TouchableOpacity>
            ))}
          </View>

          <TouchableOpacity
            style={styles.startButton}
            onPress={startSession}
          >
            <Ionicons name="play" size={24} color="#fff" />
            <Text style={styles.startButtonText}>Start Session</Text>
          </TouchableOpacity>
        </View>
      ) : (
        // Active inspection session
        <View style={styles.inspectionContainer}>
          {/* Camera View */}
          <View style={styles.cameraContainer}>
            <CameraView
              ref={cameraRef}
              style={styles.camera}
              facing={cameraType}
            >
              {isAnalyzing && (
                <View style={styles.analysisOverlay}>
                  <ActivityIndicator size="large" color="#fff" />
                  <Text style={styles.analysisText}>AI Analyzing...</Text>
                </View>
              )}

              {/* Detection mode indicator */}
              <View style={styles.modeIndicator}>
                <Text style={styles.modeIndicatorText}>
                  {detectionMode.replace('_', ' ').toUpperCase()}
                </Text>
              </View>
            </CameraView>

            {/* Camera Controls */}
            <View style={styles.cameraControls}>
              <TouchableOpacity
                style={styles.cameraButton}
                onPress={pickImageFromLibrary}
              >
                <Ionicons name="images" size={24} color="#007AFF" />
                <Text style={styles.cameraButtonText}>Library</Text>
              </TouchableOpacity>

              <TouchableOpacity
                style={styles.captureButton}
                onPress={takePhoto}
                disabled={isAnalyzing}
              >
                <View style={styles.captureButtonInner}>
                  <Ionicons name="camera" size={32} color="#fff" />
                </View>
              </TouchableOpacity>

              <TouchableOpacity
                style={styles.cameraButton}
                onPress={() => setCameraType(cameraType === 'back' ? 'front' : 'back')}
              >
                <Ionicons name="camera-reverse" size={24} color="#007AFF" />
                <Text style={styles.cameraButtonText}>Flip</Text>
              </TouchableOpacity>
            </View>
          </View>

          {/* Results Display */}
          {detectionResults.length > 0 && (
            <ScrollView style={styles.resultsContainer}>
              <View style={styles.resultsHeader}>
                <Text style={styles.resultsTitle}>
                  AI Analysis Results ({detectionResults.length})
                </Text>
                <TouchableOpacity style={styles.clearButton} onPress={clearResults}>
                  <Ionicons name="trash" size={20} color="#dc3545" />
                </TouchableOpacity>
              </View>

              {detectionResults.slice(-3).map((result, index) => (
                <View key={index} style={styles.resultCard}>
                  <View style={styles.resultHeader}>
                    <View style={styles.resultTypeContainer}>
                      <Ionicons
                        name={result.type === 'damage' ? 'construct' :
                              result.type === 'counting' ? 'calculator' :
                              result.type === 'anomaly' ? 'warning' : 'pricetag'}
                        size={20}
                        color={result.severity === 'critical' ? '#dc3545' :
                               result.severity === 'high' ? '#fd7e14' :
                               result.severity === 'medium' ? '#ffc107' : '#28a745'}
                      />
                      <Text style={styles.resultType}>
                        {result.type.replace('_', ' ').toUpperCase()}
                      </Text>
                    </View>
                    <Text style={styles.confidenceText}>
                      {Math.round(result.confidence * 100)}%
                    </Text>
                  </View>

                  <Text style={styles.resultDescription}>{result.description}</Text>

                  {result.recommendations && result.recommendations.length > 0 && (
                    <View style={styles.recommendationsContainer}>
                      <Text style={styles.recommendationsTitle}>Recommendations:</Text>
                      {result.recommendations.slice(0, 2).map((rec, recIndex) => (
                        <Text key={recIndex} style={styles.recommendationText}>
                          • {rec}
                        </Text>
                      ))}
                    </View>
                  )}
                </View>
              ))}
            </ScrollView>
          )}

          {/* Session Controls */}
          <View style={styles.sessionControls}>
            <TouchableOpacity
              style={styles.sessionButton}
              onPress={generateReport}
            >
              <Ionicons name="document" size={20} color="#007AFF" />
              <Text style={styles.sessionButtonText}>Generate Report</Text>
            </TouchableOpacity>

            <TouchableOpacity
              style={[styles.sessionButton, styles.endSessionButton]}
              onPress={endSession}
            >
              <Ionicons name="stop" size={20} color="#dc3545" />
              <Text style={styles.endSessionButtonText}>End Session</Text>
            </TouchableOpacity>
          </View>
        </View>
      )}
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    marginTop: 16,
    fontSize: 16,
    color: '#666',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 32,
  },
  errorTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginTop: 16,
    marginBottom: 8,
  },
  errorText: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: 24,
  },
  retryButton: {
    backgroundColor: '#fff',
    paddingHorizontal: 32,
    paddingVertical: 12,
    borderRadius: 8,
    borderWidth: 2,
    borderColor: '#007AFF',
  },
  retryButtonText: {
    color: '#000',
    fontSize: 16,
    fontWeight: '600',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 16,
    backgroundColor: '#fff',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  backButton: {
    padding: 8,
    borderRadius: 8,
    backgroundColor: '#f0f0f0',
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
  },
  setupContainer: {
    flex: 1,
    padding: 16,
  },
  setupTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 24,
    textAlign: 'center',
  },
  modeSelection: {
    marginBottom: 32,
  },
  modeTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#333',
    marginBottom: 16,
  },
  modeButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    marginBottom: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2,
    borderWidth: 2,
    borderColor: '#ddd',
  },
  modeButtonActive: {
    backgroundColor: '#fff',
    borderColor: '#007AFF',
  },
  modeButtonText: {
    fontSize: 16,
    marginLeft: 12,
    color: '#007AFF',
    fontWeight: '600',
  },
  modeButtonTextActive: {
    color: '#000',
  },
  startButton: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    elevation: 5,
    borderWidth: 2,
    borderColor: '#28a745',
  },
  startButtonText: {
    color: '#000',
    fontSize: 18,
    fontWeight: 'bold',
    marginLeft: 8,
  },
  inspectionContainer: {
    flex: 1,
  },
  cameraContainer: {
    flex: 1,
  },
  camera: {
    flex: 1,
  },
  analysisOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(0, 0, 0, 0.7)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  analysisText: {
    color: '#fff',
    fontSize: 16,
    marginTop: 8,
    fontWeight: '600',
  },
  modeIndicator: {
    position: 'absolute',
    top: 16,
    right: 16,
    backgroundColor: 'rgba(0, 0, 0, 0.7)',
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 6,
  },
  modeIndicatorText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: 'bold',
  },
  cameraControls: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
    backgroundColor: '#fff',
    padding: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: -2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 5,
  },
  cameraButton: {
    alignItems: 'center',
  },
  cameraButtonText: {
    fontSize: 12,
    color: '#666',
    marginTop: 4,
  },
  captureButton: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 8,
  },
  captureButtonInner: {
    width: 72,
    height: 72,
    borderRadius: 36,
    backgroundColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 3,
    borderColor: '#fff',
  },
  resultsContainer: {
    maxHeight: height * 0.4,
    backgroundColor: '#fff',
    borderTopLeftRadius: 16,
    borderTopRightRadius: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: -2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 5,
  },
  resultsHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  resultsTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  clearButton: {
    padding: 8,
  },
  resultCard: {
    backgroundColor: '#f8f9fa',
    margin: 16,
    marginTop: 8,
    borderRadius: 8,
    padding: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#007AFF',
  },
  resultHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  resultTypeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  resultType: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#333',
    marginLeft: 8,
  },
  confidenceText: {
    fontSize: 12,
    color: '#666',
    fontWeight: '600',
  },
  resultDescription: {
    fontSize: 14,
    color: '#333',
    marginBottom: 8,
  },
  recommendationsContainer: {
    backgroundColor: '#fff',
    borderRadius: 6,
    padding: 8,
  },
  recommendationsTitle: {
    fontSize: 12,
    fontWeight: 'bold',
    color: '#666',
    marginBottom: 4,
  },
  recommendationText: {
    fontSize: 12,
    color: '#666',
    lineHeight: 16,
  },
  sessionControls: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    backgroundColor: '#fff',
    padding: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: -2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 5,
  },
  sessionButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    borderRadius: 8,
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderWidth: 2,
    borderColor: '#007AFF',
  },
  sessionButtonText: {
    color: '#000',
    fontWeight: '600',
    marginLeft: 8,
  },
  endSessionButton: {
    backgroundColor: '#fff',
    borderWidth: 2,
    borderColor: '#dc3545',
  },
  endSessionButtonText: {
    color: '#000',
    fontWeight: '600',
    marginLeft: 8,
  },
});

export default AIInspectionScreen;
