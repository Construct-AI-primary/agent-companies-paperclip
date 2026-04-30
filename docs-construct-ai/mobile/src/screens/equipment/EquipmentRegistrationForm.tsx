import React, { useState } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  Alert,
  Platform,
} from 'react-native';
import { Picker } from '@react-native-picker/picker';
import { useNavigation } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import { useDispatch } from 'react-redux';
import { addEquipment } from '../../store/slices/equipmentSlice';

const EquipmentRegistrationForm: React.FC = () => {
  const navigation = useNavigation();
  const dispatch = useDispatch();

  const [formData, setFormData] = useState({
    name: '',
    equipmentCode: '',
    type: '',
    subtype: '',
    specifications: '',
    make: '',
    model: '',
    serialNumber: '',
    yearOfManufacture: '',
    status: 'active' as 'active' | 'maintenance' | 'decommissioned',
    location: '',
    department: '',
    fuelType: '',
    lubricantType: '',
    usageFrequency: '',
    lastMaintenanceDate: '',
    nextMaintenanceDate: '',
    maintenanceCycleDays: '',
    operatingHours: '',
    requiresMsd: false,
  });

  const [loading, setLoading] = useState(false);

  const equipmentTypes = [
    { label: 'Select Equipment Type', value: '' },
    { label: 'Excavator', value: 'excavator' },
    { label: 'Crane', value: 'crane' },
    { label: 'Loader', value: 'loader' },
    { label: 'Dump Truck', value: 'dump_truck' },
    { label: 'Forklift', value: 'forklift' },
    { label: 'Generator', value: 'generator' },
    { label: 'Compressor', value: 'compressor' },
    { label: 'Welding Machine', value: 'welding_machine' },
    { label: 'Power Tools', value: 'power_tools' },
    { label: 'Safety Equipment', value: 'safety_equipment' },
    { label: 'Other', value: 'other' },
  ];

  const fuelTypes = [
    { label: 'Select Fuel Type', value: '' },
    { label: 'Diesel', value: 'diesel' },
    { label: 'Gasoline', value: 'gasoline' },
    { label: 'Electric', value: 'electric' },
    { label: 'Hybrid', value: 'hybrid' },
    { label: 'Natural Gas', value: 'natural_gas' },
    { label: 'Other', value: 'other' },
  ];

  const lubricantTypes = [
    { label: 'Select Lubricant Type', value: '' },
    { label: 'Engine Oil', value: 'engine_oil' },
    { label: 'Hydraulic Oil', value: 'hydraulic_oil' },
    { label: 'Grease', value: 'grease' },
    { label: 'Transmission Fluid', value: 'transmission_fluid' },
    { label: 'Coolant', value: 'coolant' },
    { label: 'Other', value: 'other' },
  ];

  const usageFrequencies = [
    { label: 'Select Usage Frequency', value: '' },
    { label: 'Daily', value: 'daily' },
    { label: 'Weekly', value: 'weekly' },
    { label: 'Monthly', value: 'monthly' },
    { label: 'As Needed', value: 'as_needed' },
    { label: 'Seasonal', value: 'seasonal' },
  ];

  const submitEquipment = async () => {
    if (!formData.name || !formData.type) {
      Alert.alert('Validation Error', 'Please fill in all required fields');
      return;
    }

    setLoading(true);
    try {
      await dispatch(addEquipment({
        ...formData,
        yearOfManufacture: formData.yearOfManufacture ? parseInt(formData.yearOfManufacture, 10) : undefined,
        maintenanceCycleDays: formData.maintenanceCycleDays ? parseInt(formData.maintenanceCycleDays, 10) : undefined,
        operatingHours: formData.operatingHours ? parseInt(formData.operatingHours, 10) : undefined,
        active: true,
        archived: false,
      }) as any);

      Alert.alert(
        'Success',
        'Equipment registered successfully',
        [
          {
            text: 'OK',
            onPress: () => navigation.goBack(),
          },
        ]
      );
    } catch (error) {
      Alert.alert('Error', 'Failed to register equipment');
    } finally {
      setLoading(false);
    }
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
          <Text style={styles.title}>Register New Equipment</Text>
          <View style={{ width: 24 }} />
        </View>

        <View style={styles.formContainer}>
          {/* Equipment Name */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>
              Equipment Name <Text style={styles.required}>*</Text>
            </Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter equipment name..."
              value={formData.name}
              onChangeText={(text) => setFormData(prev => ({ ...prev, name: text }))}
            />
          </View>

          {/* Equipment Code */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Equipment Code</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter equipment code..."
              value={formData.equipmentCode}
              onChangeText={(text) => setFormData(prev => ({ ...prev, equipmentCode: text }))}
            />
          </View>

          {/* Equipment Type */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>
              Equipment Type <Text style={styles.required}>*</Text>
            </Text>
            <View style={styles.pickerContainer}>
              <Picker
                selectedValue={formData.type}
                onValueChange={(value) => setFormData(prev => ({ ...prev, type: value }))}
                style={styles.picker}
              >
                {equipmentTypes.map((item) => (
                  <Picker.Item key={item.value} label={item.label} value={item.value} />
                ))}
              </Picker>
            </View>
          </View>

          {/* Subtype */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Subtype</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter equipment subtype..."
              value={formData.subtype}
              onChangeText={(text) => setFormData(prev => ({ ...prev, subtype: text }))}
            />
          </View>

          {/* Specifications */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Specifications</Text>
            <TextInput
              style={styles.textArea}
              placeholder="Enter equipment specifications..."
              value={formData.specifications}
              onChangeText={(text) => setFormData(prev => ({ ...prev, specifications: text }))}
              multiline
              numberOfLines={3}
              textAlignVertical="top"
            />
          </View>

          {/* Manufacturer Details */}
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>Manufacturer Details</Text>
          </View>

          {/* Make */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Make</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter manufacturer name..."
              value={formData.make}
              onChangeText={(text) => setFormData(prev => ({ ...prev, make: text }))}
            />
          </View>

          {/* Model */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Model</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter model number..."
              value={formData.model}
              onChangeText={(text) => setFormData(prev => ({ ...prev, model: text }))}
            />
          </View>

          {/* Serial Number */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Serial Number</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter serial number..."
              value={formData.serialNumber}
              onChangeText={(text) => setFormData(prev => ({ ...prev, serialNumber: text }))}
            />
          </View>

          {/* Year of Manufacture */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Year of Manufacture</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter year of manufacture..."
              value={formData.yearOfManufacture}
              onChangeText={(text) => setFormData(prev => ({ ...prev, yearOfManufacture: text }))}
              keyboardType="numeric"
            />
          </View>

          {/* Location and Department */}
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>Location & Department</Text>
          </View>

          {/* Location */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Location</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter location..."
              value={formData.location}
              onChangeText={(text) => setFormData(prev => ({ ...prev, location: text }))}
            />
          </View>

          {/* Department */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Department</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter department..."
              value={formData.department}
              onChangeText={(text) => setFormData(prev => ({ ...prev, department: text }))}
            />
          </View>

          {/* Fuel and Lubricant */}
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>Fuel & Lubricant</Text>
          </View>

          {/* Fuel Type */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Fuel Type</Text>
            <View style={styles.pickerContainer}>
              <Picker
                selectedValue={formData.fuelType}
                onValueChange={(value) => setFormData(prev => ({ ...prev, fuelType: value }))}
                style={styles.picker}
              >
                {fuelTypes.map((item) => (
                  <Picker.Item key={item.value} label={item.label} value={item.value} />
                ))}
              </Picker>
            </View>
          </View>

          {/* Lubricant Type */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Lubricant Type</Text>
            <View style={styles.pickerContainer}>
              <Picker
                selectedValue={formData.lubricantType}
                onValueChange={(value) => setFormData(prev => ({ ...prev, lubricantType: value }))}
                style={styles.picker}
              >
                {lubricantTypes.map((item) => (
                  <Picker.Item key={item.value} label={item.label} value={item.value} />
                ))}
              </Picker>
            </View>
          </View>

          {/* Usage Information */}
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>Usage Information</Text>
          </View>

          {/* Usage Frequency */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Usage Frequency</Text>
            <View style={styles.pickerContainer}>
              <Picker
                selectedValue={formData.usageFrequency}
                onValueChange={(value) => setFormData(prev => ({ ...prev, usageFrequency: value }))}
                style={styles.picker}
              >
                {usageFrequencies.map((item) => (
                  <Picker.Item key={item.value} label={item.label} value={item.value} />
                ))}
              </Picker>
            </View>
          </View>

          {/* Operating Hours */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Operating Hours</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter total operating hours..."
              value={formData.operatingHours}
              onChangeText={(text) => setFormData(prev => ({ ...prev, operatingHours: text }))}
              keyboardType="numeric"
            />
          </View>

          {/* Maintenance Information */}
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>Maintenance Information</Text>
          </View>

          {/* Last Maintenance Date */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Last Maintenance Date</Text>
            <TextInput
              style={styles.textInput}
              placeholder="YYYY-MM-DD"
              value={formData.lastMaintenanceDate}
              onChangeText={(text) => setFormData(prev => ({ ...prev, lastMaintenanceDate: text }))}
            />
          </View>

          {/* Next Maintenance Date */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Next Maintenance Date</Text>
            <TextInput
              style={styles.textInput}
              placeholder="YYYY-MM-DD"
              value={formData.nextMaintenanceDate}
              onChangeText={(text) => setFormData(prev => ({ ...prev, nextMaintenanceDate: text }))}
            />
          </View>

          {/* Maintenance Cycle Days */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Maintenance Cycle (Days)</Text>
            <TextInput
              style={styles.textInput}
              placeholder="Enter maintenance cycle in days..."
              value={formData.maintenanceCycleDays}
              onChangeText={(text) => setFormData(prev => ({ ...prev, maintenanceCycleDays: text }))}
              keyboardType="numeric"
            />
          </View>

          {/* MSRB Requirement */}
          <View style={styles.formGroup}>
            <View style={styles.checkboxContainer}>
              <TouchableOpacity
                style={styles.checkbox}
                onPress={() => setFormData(prev => ({ ...prev, requiresMsd: !prev.requiresMsd }))}
              >
                <Ionicons
                  name={formData.requiresMsd ? "checkbox" : "square-outline"}
                  size={24}
                  color={formData.requiresMsd ? "#007AFF" : "#666"}
                />
              </TouchableOpacity>
              <Text style={styles.checkboxLabel}>
                Requires MSD (Material Safety Data) documentation
              </Text>
            </View>
          </View>
        </View>

        {/* Submit Button */}
        <TouchableOpacity
          style={[styles.submitButton, loading && styles.submitButtonDisabled]}
          onPress={submitEquipment}
          disabled={loading}
        >
          <Text style={styles.submitButtonText}>
            {loading ? 'Registering...' : 'Register Equipment'}
          </Text>
        </TouchableOpacity>
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
  formContainer: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
    marginBottom: 24,
  },
  formGroup: {
    marginBottom: 20,
  },
  label: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 8,
  },
  required: {
    color: '#dc3545',
  },
  textInput: {
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    padding: 12,
    fontSize: 16,
    backgroundColor: '#f9f9f9',
    minHeight: 50,
  },
  textArea: {
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    padding: 12,
    fontSize: 16,
    backgroundColor: '#f9f9f9',
    textAlignVertical: 'top',
    minHeight: 80,
  },
  pickerContainer: {
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    backgroundColor: '#f9f9f9',
  },
  picker: {
    height: 50,
  },
  sectionHeader: {
    marginBottom: 12,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#007AFF',
    paddingVertical: 8,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  checkboxContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 10,
  },
  checkbox: {
    marginRight: 10,
  },
  checkboxLabel: {
    fontSize: 16,
    color: '#333',
    flex: 1,
  },
  submitButton: {
    backgroundColor: '#28a745',
    borderRadius: 12,
    padding: 16,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    elevation: 5,
    marginBottom: 16,
  },
  submitButtonDisabled: {
    backgroundColor: '#ccc',
  },
  submitButtonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
  },
});

export default EquipmentRegistrationForm;
