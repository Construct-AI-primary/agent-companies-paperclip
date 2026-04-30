import React from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  TouchableOpacity,
  Image,
  Alert,
  Platform,
} from 'react-native';
import { useNavigation, useRoute } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import { useSelector } from 'react-redux';
import { RootState } from '../../store';
import { SafetyIncident } from '../../store/slices/safetySlice';

const IncidentDetailScreen: React.FC = () => {
  const navigation = useNavigation();
  const route = useRoute();
  const { incidentId } = route.params as { incidentId: string };

  const incident = useSelector((state: RootState) =>
    state.safety.incidents.find(inc => inc.id === incidentId)
  );

  if (!incident) {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.errorContainer}>
          <Text style={styles.errorText}>Incident not found</Text>
          <TouchableOpacity
            style={styles.backButton}
            onPress={() => navigation.goBack()}
          >
            <Text style={styles.backButtonText}>Go Back</Text>
          </TouchableOpacity>
        </View>
      </SafeAreaView>
    );
  }

  const getSeverityColor = (severity: string) => {
    switch (severity) {
      case 'low': return '#28a745';
      case 'medium': return '#ffc107';
      case 'high': return '#fd7e14';
      case 'critical': return '#dc3545';
      default: return '#6c757d';
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'reported': return '#007AFF';
      case 'investigating': return '#ffc107';
      case 'resolved': return '#28a745';
      case 'closed': return '#6c757d';
      default: return '#6c757d';
    }
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString() + ' at ' + date.toLocaleTimeString();
  };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.scrollContainer}>
        <View style={styles.header}>
          <TouchableOpacity
            style={styles.backButton}
            onPress={() => navigation.goBack()}
          >
            <Ionicons name="arrow-back" size={24} color="#007AFF" />
          </TouchableOpacity>
          <Text style={styles.title}>Incident Details</Text>
          <View style={{ width: 24 }} />
        </View>

        <View style={styles.contentContainer}>
          {/* Incident Type and Status */}
          <View style={styles.section}>
            <View style={styles.row}>
              <View style={styles.halfColumn}>
                <Text style={styles.label}>Type</Text>
                <Text style={styles.value}>{incident.incidentType.replace('_', ' ').toUpperCase()}</Text>
              </View>
              <View style={styles.halfColumn}>
                <Text style={styles.label}>Status</Text>
                <View style={[styles.statusBadge, { backgroundColor: getStatusColor(incident.status) }]}>
                  <Text style={styles.statusText}>{incident.status.toUpperCase()}</Text>
                </View>
              </View>
            </View>
          </View>

          {/* Severity */}
          <View style={styles.section}>
            <Text style={styles.label}>Severity</Text>
            <View style={[styles.severityBadge, { backgroundColor: getSeverityColor(incident.severity) }]}>
              <Text style={styles.severityText}>{incident.severity.toUpperCase()}</Text>
            </View>
          </View>

          {/* Description */}
          <View style={styles.section}>
            <Text style={styles.label}>Description</Text>
            <Text style={styles.description}>{incident.description}</Text>
          </View>

          {/* Immediate Actions */}
          {incident.immediateActions && (
            <View style={styles.section}>
              <Text style={styles.label}>Immediate Actions Taken</Text>
              <Text style={styles.description}>{incident.immediateActions}</Text>
            </View>
          )}

          {/* Location */}
          {incident.location && (
            <View style={styles.section}>
              <Text style={styles.label}>Location</Text>
              <View style={styles.locationContainer}>
                <Ionicons name="location" size={20} color="#007AFF" />
                <Text style={styles.locationText}>
                  {incident.location.latitude.toFixed(6)}, {incident.location.longitude.toFixed(6)}
                </Text>
              </View>
              {incident.location.accuracy && (
                <Text style={styles.accuracyText}>
                  Accuracy: ±{Math.round(incident.location.accuracy)}m
                </Text>
              )}
            </View>
          )}

          {/* Photos */}
          {incident.photos && incident.photos.length > 0 && (
            <View style={styles.section}>
              <Text style={styles.label}>Evidence Photos ({incident.photos.length})</Text>
              <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.photosContainer}>
                {incident.photos.map((photo, index) => (
                  <View key={index} style={styles.photoWrapper}>
                    <TouchableOpacity
                      style={styles.photoTouchable}
                      onPress={() => {
                        // Could implement full-screen photo view here
                        Alert.alert('Photo', `Taken at ${new Date(photo.timestamp).toLocaleString()}`);
                      }}
                    >
                      <Image
                        source={{ uri: photo.uri }}
                        style={styles.photo}
                        resizeMode="cover"
                      />
                    </TouchableOpacity>
                    <Text style={styles.photoTimestamp}>
                      {new Date(photo.timestamp).toLocaleTimeString()}
                    </Text>
                    {photo.location && (
                      <Text style={styles.photoLocation}>
                        📍 {photo.location.latitude.toFixed(4)}, {photo.location.longitude.toFixed(4)}
                      </Text>
                    )}
                  </View>
                ))}
              </ScrollView>
            </View>
          )}

          {/* Metadata */}
          <View style={styles.section}>
            <Text style={styles.label}>Reported By</Text>
            <Text style={styles.value}>{incident.reportedBy || 'Unknown'}</Text>
          </View>

          <View style={styles.section}>
            <Text style={styles.label}>Reported At</Text>
            <Text style={styles.value}>{formatDate(incident.reportedAt)}</Text>
          </View>

          {/* Sync Status */}
          <View style={styles.section}>
            <Text style={styles.label}>Sync Status</Text>
            <View style={[styles.syncBadge, { backgroundColor: incident.synced ? '#28a745' : '#ffc107' }]}>
              <Text style={styles.syncText}>{incident.synced ? 'Synced' : 'Pending Sync'}</Text>
            </View>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  scrollContainer: {
    padding: 16,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 24,
    paddingTop: 16,
  },
  backButton: {
    padding: 8,
    borderRadius: 8,
    backgroundColor: '#fff',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
    flex: 1,
    textAlign: 'center',
  },
  contentContainer: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  section: {
    marginBottom: 20,
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  halfColumn: {
    flex: 1,
    marginHorizontal: 4,
  },
  label: {
    fontSize: 14,
    fontWeight: '600',
    color: '#666',
    marginBottom: 4,
  },
  value: {
    fontSize: 16,
    color: '#333',
    fontWeight: '500',
  },
  statusBadge: {
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
    alignSelf: 'flex-start',
  },
  statusText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: 'bold',
  },
  severityBadge: {
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 16,
    alignSelf: 'flex-start',
  },
  severityText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: 'bold',
  },
  description: {
    fontSize: 16,
    color: '#333',
    lineHeight: 24,
  },
  locationContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 4,
  },
  locationText: {
    fontSize: 14,
    color: '#007AFF',
    marginLeft: 8,
    fontFamily: Platform.OS === 'ios' ? 'Courier' : 'monospace',
  },
  accuracyText: {
    fontSize: 12,
    color: '#666',
    marginLeft: 28,
  },
  photosContainer: {
    marginTop: 8,
  },
  photoWrapper: {
    marginRight: 12,
    alignItems: 'center',
  },
  photoTouchable: {
    borderRadius: 8,
    overflow: 'hidden',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  photo: {
    width: 120,
    height: 120,
    borderRadius: 8,
  },
  photoTimestamp: {
    fontSize: 10,
    color: '#666',
    marginTop: 4,
    textAlign: 'center',
  },
  photoLocation: {
    fontSize: 8,
    color: '#999',
    marginTop: 2,
    textAlign: 'center',
  },
  syncBadge: {
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
    alignSelf: 'flex-start',
  },
  syncText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: 'bold',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  errorText: {
    fontSize: 18,
    color: '#666',
    marginBottom: 20,
  },
  backButtonText: {
    color: '#007AFF',
    fontSize: 16,
    fontWeight: '600',
  },
});

export default IncidentDetailScreen;
