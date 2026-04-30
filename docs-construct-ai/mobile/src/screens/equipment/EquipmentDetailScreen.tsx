import React from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  TouchableOpacity,
  Alert,
  Platform,
} from 'react-native';
import QRCode from 'react-qr-code';
import { useNavigation, useRoute } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../../store';
import { Equipment } from '../../services/database';
import { updateEquipment } from '../../store/slices/equipmentSlice';

const EquipmentDetailScreen: React.FC = () => {
  const [showQRCode, setShowQRCode] = React.useState(false);
  const navigation = useNavigation();
  const route = useRoute();
  const dispatch = useDispatch();
  const { equipmentId } = route.params as { equipmentId: string };

  const equipment = useSelector((state: RootState) =>
    state.equipment.equipment.find(eq => eq.id === equipmentId)
  );

  if (!equipment) {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.errorContainer}>
          <Text style={styles.errorText}>Equipment not found</Text>
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

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'active': return '#28a745';
      case 'maintenance': return '#ffc107';
      case 'decommissioned': return '#dc3545';
      default: return '#6c757d';
    }
  };

  const getHealthColor = (healthScore: number) => {
    if (healthScore >= 80) return '#28a745';
    if (healthScore >= 60) return '#ffc107';
    if (healthScore >= 40) return '#fd7e14';
    return '#dc3545';
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString() + ' at ' + date.toLocaleTimeString();
  };

  const handleStatusChange = (newStatus: 'active' | 'maintenance' | 'decommissioned') => {
    dispatch(updateEquipment({ id: equipmentId, status: newStatus }));
    Alert.alert('Success', `Equipment status updated to ${newStatus}`);
  };

  const calculateHealthScore = () => {
    // Simple health score calculation based on maintenance dates
    if (!equipment.lastMaintenanceDate || !equipment.nextMaintenanceDate) {
      return 75; // Default score if no maintenance data
    }

    const lastMaintenance = new Date(equipment.lastMaintenanceDate);
    const nextMaintenance = new Date(equipment.nextMaintenanceDate);
    const today = new Date();

    const totalInterval = nextMaintenance.getTime() - lastMaintenance.getTime();
    const timeSinceLast = today.getTime() - lastMaintenance.getTime();

    // Health score decreases as we approach next maintenance date
    const healthScore = Math.max(0, Math.min(100, 100 - (timeSinceLast / totalInterval) * 100));
    return Math.round(healthScore);
  };

  const healthScore = calculateHealthScore();

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
          <Text style={styles.title}>Equipment Details</Text>
          <View style={{ width: 24 }} />
        </View>

        <View style={styles.contentContainer}>
          {/* Equipment Name and Status */}
          <View style={styles.section}>
            <View style={styles.row}>
              <View style={styles.fullColumn}>
                <Text style={styles.equipmentName}>{equipment.name}</Text>
                <Text style={styles.equipmentCode}>{equipment.equipmentCode || 'No code'}</Text>
              </View>
              <View style={styles.halfColumn}>
                <Text style={styles.label}>Status</Text>
                <View style={[styles.statusBadge, { backgroundColor: getStatusColor(equipment.status) }]}>
                  <Text style={styles.statusText}>{equipment.status.toUpperCase()}</Text>
                </View>
              </View>
            </View>
          </View>

          {/* Health Score */}
          <View style={styles.section}>
            <Text style={styles.label}>Health Score</Text>
            <View style={styles.healthContainer}>
              <Text style={[styles.healthScore, { color: getHealthColor(healthScore) }]}>
                {healthScore}%
              </Text>
              <View style={styles.healthBarBackground}>
                <View 
                  style={[
                    styles.healthBarFill, 
                    { 
                      width: `${healthScore}%`,
                      backgroundColor: getHealthColor(healthScore)
                    }
                  ]} 
                />
              </View>
            </View>
          </View>

          {/* Equipment Type */}
          <View style={styles.section}>
            <View style={styles.row}>
              <View style={styles.halfColumn}>
                <Text style={styles.label}>Type</Text>
                <Text style={styles.value}>{equipment.type}</Text>
              </View>
              <View style={styles.halfColumn}>
                <Text style={styles.label}>Subtype</Text>
                <Text style={styles.value}>{equipment.subtype || 'N/A'}</Text>
              </View>
            </View>
          </View>

          {/* Specifications */}
          {equipment.specifications && (
            <View style={styles.section}>
              <Text style={styles.label}>Specifications</Text>
              <Text style={styles.description}>
                {typeof equipment.specifications === 'string' 
                  ? equipment.specifications 
                  : JSON.stringify(equipment.specifications, null, 2)}
              </Text>
            </View>
          )}

          {/* Manufacturer Details */}
          {(equipment.make || equipment.model || equipment.serialNumber) && (
            <View style={styles.section}>
              <Text style={styles.label}>Manufacturer Details</Text>
              {equipment.make && (
                <View style={styles.row}>
                  <View style={styles.halfColumn}>
                    <Text style={styles.label}>Make</Text>
                    <Text style={styles.value}>{equipment.make}</Text>
                  </View>
                  <View style={styles.halfColumn}>
                    <Text style={styles.label}>Model</Text>
                    <Text style={styles.value}>{equipment.model || 'N/A'}</Text>
                  </View>
                </View>
              )}
              {equipment.serialNumber && (
                <View style={styles.row}>
                  <View style={styles.fullColumn}>
                    <Text style={styles.label}>Serial Number</Text>
                    <Text style={styles.value}>{equipment.serialNumber}</Text>
                  </View>
                </View>
              )}
            </View>
          )}

          {/* Location and Department */}
          {(equipment.location || equipment.department) && (
            <View style={styles.section}>
              <Text style={styles.label}>Location & Department</Text>
              {equipment.location && (
                <View style={styles.row}>
                  <View style={styles.halfColumn}>
                    <Text style={styles.label}>Location</Text>
                    <Text style={styles.value}>{equipment.location}</Text>
                  </View>
                  <View style={styles.halfColumn}>
                    <Text style={styles.label}>Department</Text>
                    <Text style={styles.value}>{equipment.department || 'N/A'}</Text>
                  </View>
                </View>
              )}
            </View>
          )}

          {/* Maintenance Information */}
          {(equipment.lastMaintenanceDate || equipment.nextMaintenanceDate) && (
            <View style={styles.section}>
              <Text style={styles.label}>Maintenance Schedule</Text>
              {equipment.lastMaintenanceDate && (
                <View style={styles.row}>
                  <View style={styles.halfColumn}>
                    <Text style={styles.label}>Last Maintenance</Text>
                    <Text style={styles.value}>{formatDate(equipment.lastMaintenanceDate)}</Text>
                  </View>
                  <View style={styles.halfColumn}>
                    <Text style={styles.label}>Next Maintenance</Text>
                    <Text style={[styles.value, styles.dueDate]}>
                      {equipment.nextMaintenanceDate ? formatDate(equipment.nextMaintenanceDate) : 'N/A'}
                    </Text>
                  </View>
                </View>
              )}
              {equipment.maintenanceCycleDays && (
                <View style={styles.row}>
                  <View style={styles.fullColumn}>
                    <Text style={styles.label}>Maintenance Cycle</Text>
                    <Text style={styles.value}>{equipment.maintenanceCycleDays} days</Text>
                  </View>
                </View>
              )}
            </View>
          )}

          {/* Operating Hours */}
          {equipment.operatingHours !== undefined && (
            <View style={styles.section}>
              <Text style={styles.label}>Operating Hours</Text>
              <Text style={styles.value}>{equipment.operatingHours} hours</Text>
            </View>
          )}

          {/* Fuel and Lubricant */}
          {(equipment.fuelType || equipment.lubricantType) && (
            <View style={styles.section}>
              <Text style={styles.label}>Fuel & Lubricant</Text>
              <View style={styles.row}>
                <View style={styles.halfColumn}>
                  <Text style={styles.label}>Fuel Type</Text>
                  <Text style={styles.value}>{equipment.fuelType || 'N/A'}</Text>
                </View>
                <View style={styles.halfColumn}>
                  <Text style={styles.label}>Lubricant Type</Text>
                  <Text style={styles.value}>{equipment.lubricantType || 'N/A'}</Text>
                </View>
              </View>
            </View>
          )}

          {/* Metadata */}
          <View style={styles.section}>
            <Text style={styles.label}>Created At</Text>
            <Text style={styles.value}>{formatDate(equipment.createdAt || new Date().toISOString())}</Text>
          </View>

          <View style={styles.section}>
            <Text style={styles.label}>Last Updated</Text>
            <Text style={styles.value}>{formatDate(equipment.updatedAt || new Date().toISOString())}</Text>
          </View>

          {/* Sync Status */}
          <View style={styles.section}>
            <Text style={styles.label}>Sync Status</Text>
            <View style={[styles.syncBadge, { backgroundColor: equipment.synced ? '#28a745' : '#ffc107' }]}>
              <Text style={styles.syncText}>{equipment.synced ? 'Synced' : 'Pending Sync'}</Text>
            </View>
          </View>

          {/* Action Buttons */}
          <View style={styles.actionsContainer}>
            <TouchableOpacity 
              style={styles.actionButton}
              onPress={() => handleStatusChange('maintenance')}
            >
              <Ionicons name="construct" size={20} color="#fff" />
              <Text style={styles.actionButtonText}>Mark for Maintenance</Text>
            </TouchableOpacity>
            
            <TouchableOpacity 
              style={[styles.actionButton, styles.decommissionButton]}
              onPress={() => handleStatusChange('decommissioned')}
            >
              <Ionicons name="close-circle" size={20} color="#fff" />
              <Text style={styles.actionButtonText}>Decommission</Text>
            </TouchableOpacity>
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
    boxShadow: '0 2px 4px rgba(0, 0, 0, 0.1)',
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
  fullColumn: {
    flex: 1,
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
  equipmentName: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 4,
  },
  equipmentCode: {
    fontSize: 14,
    color: '#666',
    marginBottom: 8,
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
  healthContainer: {
    alignItems: 'center',
  },
  healthScore: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 8,
  },
  healthBarBackground: {
    width: '100%',
    height: 10,
    backgroundColor: '#e0e0e0',
    borderRadius: 5,
    overflow: 'hidden',
  },
  healthBarFill: {
    height: '100%',
    borderRadius: 5,
  },
  description: {
    fontSize: 16,
    color: '#333',
    lineHeight: 24,
  },
  dueDate: {
    color: '#dc3545',
    fontWeight: '600',
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
  actionsContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 20,
  },
  actionButton: {
    backgroundColor: '#007AFF',
    borderRadius: 8,
    paddingVertical: 12,
    paddingHorizontal: 16,
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
    marginHorizontal: 4,
  },
  decommissionButton: {
    backgroundColor: '#dc3545',
  },
  actionButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '600',
    marginLeft: 8,
  },
});

export default EquipmentDetailScreen;
