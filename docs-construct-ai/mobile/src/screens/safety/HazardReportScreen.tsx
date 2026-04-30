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
import * as Location from 'expo-location';
import * as ImagePicker from 'expo-image-picker';
import { aiService } from '../../services/aiService';
import * as MediaLibrary from 'expo-media-library';
import SafetyChatbot from '../../components/SafetyChatbot';

interface Photo {
  uri: string;
  timestamp: string;
  location?: {
    latitude: number;
    longitude: number;
  };
}

interface Video {
  uri: string;
  timestamp: string;
  duration: number;
  location?: {
    latitude: number;
    longitude: number;
  };
  thumbnail?: string;
}

const HazardReportScreen: React.FC = () => {
  const navigation = useNavigation();

  const [formData, setFormData] = useState({
    hazardType: '',
    description: '',
    riskLevel: 'medium' as 'low' | 'medium' | 'high' | 'critical',
    mitigationPlan: '',
    locationDescription: '',
  });

  const [location, setLocation] = useState<{
    latitude: number;
    longitude: number;
    accuracy?: number;
  } | null>(null);

  const [photos, setPhotos] = useState<Photo[]>([]);
  const [videos, setVideos] = useState<Video[]>([]);
  const [loading, setLoading] = useState(false);

  const getCurrentLocation = async () => {
    try {
      const { status } = await Location.requestForegroundPermissionsAsync();
      if (status !== 'granted') {
        Alert.alert('Permission Denied', 'Location permission is required to get current location');
        return;
      }

      const locationResult = await Location.getCurrentPositionAsync({
        accuracy: Location.Accuracy.High,
      });

      const newLocation = {
        latitude: locationResult.coords.latitude,
        longitude: locationResult.coords.longitude,
        accuracy: locationResult.coords.accuracy || undefined,
      } as typeof location;

      setLocation(newLocation);
      Alert.alert('Success', 'Location captured successfully');
    } catch (error) {
      Alert.alert('Error', 'Unable to get current location');
    }
  };

  const takePhoto = async () => {
    try {
      const { status } = await ImagePicker.requestCameraPermissionsAsync();
      if (status !== 'granted') {
        Alert.alert('Permission Denied', 'Camera permission is required to take photos');
        return;
      }

      console.log('Camera permission granted, launching camera...');

      const result = await ImagePicker.launchCameraAsync({
        mediaTypes: ImagePicker.MediaTypeOptions.Images,
        allowsEditing: false,
        aspect: [4, 3],
        quality: 0.8,
        exif: true,
      });

      console.log('Camera result:', result);

      if (!result.canceled && result.assets && result.assets[0]) {
        const photo = {
          uri: result.assets[0].uri,
          timestamp: new Date().toISOString(),
          location: location || undefined,
        };

        setPhotos(prev => [...prev, photo]);
        console.log('Photo captured:', photo.uri);
      } else {
        console.log('Photo capture cancelled or no assets');
      }
    } catch (error) {
      console.error('Error taking photo:', error);
      Alert.alert('Error', 'Unable to take photo. Please try again.');
    }
  };

  const chooseFromGallery = async () => {
    try {
      const { status } = await ImagePicker.requestMediaLibraryPermissionsAsync();
      if (status !== 'granted') {
        Alert.alert('Permission Denied', 'Media library permission is required to select photos from gallery');
        return;
      }

      console.log('Gallery permission granted, launching image picker...');

      const result = await ImagePicker.launchImageLibraryAsync({
        mediaTypes: ImagePicker.MediaTypeOptions.Images,
        allowsEditing: false,
        aspect: [4, 3],
        quality: 0.8,
        exif: true,
        selectionLimit: 0, // Allow multiple selection
      });

      console.log('Gallery result:', result);

      if (!result.canceled && result.assets && result.assets.length > 0) {
        const newPhotos = result.assets.map((asset) => ({
          uri: asset.uri,
          timestamp: new Date().toISOString(),
          location: location || undefined,
        }));

        setPhotos(prev => [...prev, ...newPhotos]);
        console.log(`Added ${newPhotos.length} photos from gallery`);
      } else {
        console.log('Gallery selection cancelled or no assets');
      }
    } catch (error) {
      console.error('Error selecting from gallery:', error);
      Alert.alert('Error', 'Unable to select photos from gallery. Please try again.');
    }
  };

  const submitHazard = async () => {
    if (!formData.hazardType || !formData.description) {
      Alert.alert('Validation Error', 'Please fill in all required fields');
      return;
    }

    setLoading(true);
    try {
      // Here you would integrate with your backend API or local storage
      console.log('Hazard data:', { ...formData, location, photos, videos });

      Alert.alert(
        'Success',
        'Hazard reported successfully',
        [
          {
            text: 'OK',
            onPress: () => navigation.goBack(),
          },
        ]
      );
    } catch (error) {
      Alert.alert('Error', 'Failed to submit hazard report');
    } finally {
      setLoading(false);
    }
  };

  const recordVideo = async () => {
    try {
      const { status } = await ImagePicker.requestCameraPermissionsAsync();
      if (status !== 'granted') {
        Alert.alert('Permission Denied', 'Camera permission is required to record videos');
        return;
      }

      console.log('Camera permission granted, launching video camera...');

      const result = await ImagePicker.launchCameraAsync({
        mediaTypes: ImagePicker.MediaTypeOptions.Videos,
        allowsEditing: true,
        quality: 0.8,
        videoMaxDuration: 60, // 1 minute max
      });

      console.log('Video capture result:', result);

      if (!result.canceled && result.assets && result.assets[0]) {
        const video: Video = {
          uri: result.assets[0].uri,
          timestamp: new Date().toISOString(),
          duration: 0, // We'll need to compute this from the video metadata
          location: location || undefined,
        };

        setVideos(prev => [...prev, video]);
        console.log('Video recorded:', video.uri);
      } else {
        console.log('Video recording cancelled or no assets');
      }
    } catch (error) {
      console.error('Error recording video:', error);
      Alert.alert('Error', 'Unable to record video. Please try again.');
    }
  };

  const selectFromGallery = async () => {
    try {
      const { status } = await ImagePicker.requestMediaLibraryPermissionsAsync();
      if (status !== 'granted') {
        Alert.alert('Permission Denied', 'Media library permission is required to select videos from gallery');
        return;
      }

      console.log('Gallery permission granted, launching video picker...');

      const result = await ImagePicker.launchImageLibraryAsync({
        mediaTypes: ImagePicker.MediaTypeOptions.Videos,
        allowsEditing: true,
        aspect: [16, 9],
        quality: 0.8,
        videoMaxDuration: 300, // 5 minutes max for selection
      });

      console.log('Video gallery result:', result);

      if (!result.canceled && result.assets && result.assets.length > 0) {
        const newVideos = result.assets.map((asset) => ({
          uri: asset.uri,
          timestamp: new Date().toISOString(),
          duration: asset.duration || 0,
          location: location || undefined,
        }));

        setVideos(prev => [...prev, ...newVideos]);
        console.log(`Added ${newVideos.length} videos from gallery`);
      } else {
        console.log('Gallery selection cancelled or no assets');
      }
    } catch (error) {
      console.error('Error selecting videos from gallery:', error);
      Alert.alert('Error', 'Unable to select videos from gallery. Please try again.');
    }
  };

  const removePhoto = (index: number) => {
    setPhotos(prev => prev.filter((_, i) => i !== index));
  };

  const removeVideo = (index: number) => {
    setVideos(prev => prev.filter((_, i) => i !== index));
  };

  const analyzePhoto = async (photoUri: string, index: number) => {
    try {
      console.log('Analyzing photo:', photoUri);
      setLoading(true);

      // AI classification for hazard type and risk assessment
      const classification = await aiService.classifyIncident(formData.description || 'General hazard photo analysis');

      // Update form data with AI insights
      setFormData(prev => ({
        ...prev,
        hazardType: prev.hazardType || classification.category.replace(/_/g, ' '),
        riskLevel: classification.severity,
        description: prev.description + `\n\nAI Analysis: ${classification.keywords.join(', ')}`
      }));

      Alert.alert(
        'Photo Analyzed',
        `AI classified as: ${classification.category}\nConfidence: ${(classification.confidence * 100).toFixed(1)}%`
      );
    } catch (error) {
      console.error('Photo analysis failed:', error);
      Alert.alert('Error', 'Failed to analyze photo');
    } finally {
      setLoading(false);
    }
  };

  const analyzeVideo = async (videoUri: string, index: number) => {
    try {
      console.log('Analyzing video:', videoUri);
      setLoading(true);

      // Analyze video for safety hazards
      const analysis = await aiService.analyzeVideo(videoUri);

      // Update form data with AI insights - map 'critical' to 'high' for hazard reports
      const levelToSet = analysis.riskLevel === 'critical' ? 'high' : analysis.riskLevel;
      setFormData(prev => ({
        ...prev,
        riskLevel: levelToSet as 'low' | 'medium' | 'high',
        description: prev.description + `\n\nAI Video Analysis: ${analysis.hazards.join(', ')}\nRecommendations: ${analysis.recommendations.join(', ')}`,
        mitigationPlan: prev.mitigationPlan + `\n\nAI Mitigation Suggestions: ${analysis.recommendations.join(', ')}`
      }));

      Alert.alert(
        'Video Analyzed',
        `Hazards detected: ${analysis.hazards.length}\nRisk Level: ${analysis.riskLevel.toUpperCase()}\nConfidence: ${(analysis.confidence * 100).toFixed(1)}%`
      );
    } catch (error) {
      console.error('Video analysis failed:', error);
      Alert.alert('Error', 'Failed to analyze video');
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
          <Text style={styles.title}>Report Hazard</Text>
          <View style={{ width: 24 }} />
        </View>

        <View style={styles.formContainer}>
          {/* Hazard Type */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>
              Hazard Type <Text style={styles.required}>*</Text>
            </Text>
            <View style={styles.pickerContainer}>
              <Picker
                selectedValue={formData.hazardType}
                onValueChange={(value) => setFormData(prev => ({ ...prev, hazardType: value }))}
                style={styles.picker}
              >
                <Picker.Item label="Select hazard type" value="" />
                <Picker.Item label="Slip/Trip Hazard" value="slip_trip" />
                <Picker.Item label="Chemical Spill" value="chemical_spill" />
                <Picker.Item label="Equipment Issue" value="equipment_issue" />
                <Picker.Item label="Electrical Hazard" value="electrical" />
                <Picker.Item label="Fire Safety" value="fire_safety" />
                <Picker.Item label="Confined Space" value="confined_space" />
                <Picker.Item label="Working at Heights" value="working_heights" />
                <Picker.Item label="Moving Machinery" value="moving_machinery" />
                <Picker.Item label="Noise Hazard" value="noise" />
                <Picker.Item label="Other" value="other" />
              </Picker>
            </View>
          </View>

          {/* Description */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>
              Description <Text style={styles.required}>*</Text>
            </Text>
            <TextInput
              style={styles.textArea}
              placeholder="Describe the hazard in detail..."
              value={formData.description}
              onChangeText={(text) => setFormData(prev => ({ ...prev, description: text }))}
              multiline
              numberOfLines={4}
              textAlignVertical="top"
            />
          </View>

          {/* Risk Level */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Risk Level</Text>
            <View style={styles.riskContainer}>
              {[
                { key: 'low', label: 'Low', color: '#28a745', icon: '🟢' },
                { key: 'medium', label: 'Medium', color: '#ffc107', icon: '🟡' },
                { key: 'high', label: 'High', color: '#dc3545', icon: '🔴' },
              ].map(({ key, label, color, icon }) => (
                <TouchableOpacity
                  key={key}
                  style={[
                    styles.riskButton,
                    formData.riskLevel === key && { ...styles.riskButtonActive, backgroundColor: '#fff', borderColor: color },
                  ]}
                  onPress={() => setFormData(prev => ({ ...prev, riskLevel: key as any }))}
                >
                  <Text style={styles.riskIcon}>{icon}</Text>
                  <Text style={[
                    styles.riskText,
                    formData.riskLevel === key && { color: '#000' },
                  ]}>
                    {label}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>

          {/* Location Description */}
          <View style={styles.formGroup}>
            <View style={styles.locationHeader}>
              <Text style={styles.label}>Location Description</Text>
              <TouchableOpacity style={styles.locationButton} onPress={getCurrentLocation}>
                <Ionicons name="location" size={20} color="#007AFF" />
                <Text style={styles.locationButtonText}>
                  {location ? 'GPS Set' : 'Get GPS'}
                </Text>
              </TouchableOpacity>
            </View>
            <TextInput
              style={styles.textInput}
              placeholder="Describe where the hazard is located..."
              value={formData.locationDescription}
              onChangeText={(text) => setFormData(prev => ({ ...prev, locationDescription: text }))}
              multiline
              numberOfLines={2}
              textAlignVertical="top"
            />
            {location && (
              <Text style={styles.locationText}>
                📍 Lat: {location.latitude.toFixed(6)}, Lng: {location.longitude.toFixed(6)}
                {location.accuracy && `\nAccuracy: ±${Math.round(location.accuracy)}m`}
              </Text>
            )}
          </View>

          {/* Mitigation Plan */}
          <View style={styles.formGroup}>
            <Text style={styles.label}>Mitigation Plan</Text>
            <TextInput
              style={styles.textArea}
              placeholder="What steps should be taken to address this hazard?"
              value={formData.mitigationPlan}
              onChangeText={(text) => setFormData(prev => ({ ...prev, mitigationPlan: text }))}
              multiline
              numberOfLines={3}
              textAlignVertical="top"
            />
          </View>

          {/* Photos */}
          <View style={styles.formGroup}>
            <View style={styles.photoHeader}>
              <Text style={styles.label}>Evidence Photos ({photos.length})</Text>
              <View style={styles.buttonGroup}>
                <TouchableOpacity style={styles.photoButton} onPress={takePhoto}>
                  <Ionicons name="camera" size={20} color="#007AFF" />
                  <Text style={styles.photoButtonText}>Camera</Text>
                </TouchableOpacity>
                <TouchableOpacity style={styles.photoButtonSecondary} onPress={chooseFromGallery}>
                  <Ionicons name="images" size={20} color="#28a745" />
                  <Text style={styles.photoButtonTextSecondary}>Gallery</Text>
                </TouchableOpacity>
              </View>
            </View>

            {photos.length > 0 && (
              <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.photosContainer}>
                {photos.map((photo, index) => (
                  <View key={index} style={styles.photoWrapper}>
                    <TouchableOpacity
                      style={styles.removeButton}
                      onPress={() => removePhoto(index)}
                    >
                      <Ionicons name="close-circle" size={24} color="#dc3545" />
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.photo}>
                      <Ionicons name="image" size={40} color="#666" />
                    </TouchableOpacity>
                    <Text style={styles.photoTimestamp}>
                      {new Date(photo.timestamp).toLocaleTimeString()}
                    </Text>
                    <TouchableOpacity
                      style={styles.analyzeButton}
                      onPress={() => analyzePhoto(photo.uri, index)}
                      disabled={loading}
                    >
                      <Ionicons name="bulb" size={16} color="#fff" />
                      <Text style={styles.analyzeButtonText}>Analyze</Text>
                    </TouchableOpacity>
                  </View>
                ))}
              </ScrollView>
            )}
          </View>

          {/* Videos */}
          <View style={styles.formGroup}>
            <View style={styles.photoHeader}>
              <Text style={styles.label}>Evidence Videos ({videos.length})</Text>
              <View style={styles.buttonGroup}>
                <TouchableOpacity style={styles.photoButton} onPress={recordVideo}>
                  <Ionicons name="videocam" size={20} color="#007AFF" />
                  <Text style={styles.photoButtonText}>Camera</Text>
                </TouchableOpacity>
                <TouchableOpacity style={styles.photoButtonSecondary} onPress={selectFromGallery}>
                  <Ionicons name="images" size={20} color="#28a745" />
                  <Text style={styles.photoButtonTextSecondary}>Gallery</Text>
                </TouchableOpacity>
              </View>
            </View>

            {videos.length > 0 && (
              <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.photosContainer}>
                {videos.map((video, index) => (
                  <View key={index} style={styles.photoWrapper}>
                    <TouchableOpacity
                      style={styles.removeButton}
                      onPress={() => removeVideo(index)}
                    >
                      <Ionicons name="close-circle" size={24} color="#dc3545" />
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.photo}>
                      <Ionicons name="videocam" size={40} color="#666" />
                    </TouchableOpacity>
                    <Text style={styles.photoTimestamp}>
                      {new Date(video.timestamp).toLocaleTimeString()}
                    </Text>
                    <TouchableOpacity
                      style={styles.analyzeButton}
                      onPress={() => analyzeVideo(video.uri, index)}
                      disabled={loading}
                    >
                      <Ionicons name="bulb" size={16} color="#fff" />
                      <Text style={styles.analyzeButtonText}>Analyze</Text>
                    </TouchableOpacity>
                  </View>
                ))}
              </ScrollView>
            )}
          </View>

          {/* Submit Information */}
          <View style={styles.infoContainer}>
            <View style={styles.infoItem}>
              <Ionicons name="time" size={20} color="#007AFF" />
              <Text style={styles.infoText}>Assigned to: Safety Officer</Text>
            </View>
            <View style={styles.infoItem}>
              <Ionicons name="flag" size={20} color="#007AFF" />
              <Text style={styles.infoText}>Priority: {formData.riskLevel.toUpperCase()}</Text>
            </View>
            <View style={styles.infoItem}>
              <Ionicons name="notifications" size={20} color="#007AFF" />
              <Text style={styles.infoText}>Notifications enabled</Text>
            </View>
          </View>
        </View>

        {/* Submit Button */}
        <TouchableOpacity
          style={[styles.submitButton, loading && styles.submitButtonDisabled]}
          onPress={submitHazard}
          disabled={loading}
        >
          <Text style={styles.submitButtonText}>
            {loading ? 'Submitting...' : 'Report Hazard'}
          </Text>
        </TouchableOpacity>
      </ScrollView>

      {/* AI Safety Chatbot */}
      <SafetyChatbot
        context="hazard"
        onNavigate={(action) => {
          switch (action) {
            case 'get-location':
              getCurrentLocation();
              break;
            case 'take-photo':
              takePhoto();
              break;
            case 'record-video':
              recordVideo();
              break;
            case 'show-hazard-help':
              Alert.alert('Hazard Help', 'Fill in the hazard type and description. Add mitigation steps and assess the risk level. Evidence photos/videos help with assessment.');
              break;
            default:
              console.log('Chatbot action:', action);
          }
        }}
      />
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
  pickerContainer: {
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    backgroundColor: '#f9f9f9',
  },
  picker: {
    height: 50,
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
  textInput: {
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    padding: 12,
    fontSize: 16,
    backgroundColor: '#f9f9f9',
    textAlignVertical: 'top',
    marginTop: 8,
    minHeight: 50,
  },
  riskContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  riskButton: {
    flex: 1,
    padding: 12,
    marginHorizontal: 2,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#ddd',
    backgroundColor: '#fff',
    alignItems: 'center',
  },
  riskButtonActive: {
    borderWidth: 2,
  },
  riskIcon: {
    fontSize: 16,
    marginBottom: 4,
  },
  riskText: {
    fontSize: 14,
    fontWeight: '600',
    color: '#000',
  },
  riskTextActive: {
    color: '#000',
  },
  locationHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  locationButton: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 8,
    borderRadius: 8,
    backgroundColor: '#fff',
    borderWidth: 1,
    borderColor: '#007AFF',
  },
  locationButtonText: {
    fontSize: 14,
    color: '#000',
    marginLeft: 4,
    fontWeight: '600',
  },
  locationText: {
    fontSize: 12,
    color: '#666',
    fontFamily: Platform.OS === 'ios' ? 'Courier' : 'monospace',
    padding: 8,
    backgroundColor: '#f0f0f0',
    borderRadius: 4,
    marginTop: 8,
  },
  photoHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  photoButton: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 8,
    borderRadius: 8,
    backgroundColor: '#fff',
    borderWidth: 1,
    borderColor: '#007AFF',
  },
  photoButtonText: {
    fontSize: 14,
    color: '#000',
    marginLeft: 4,
    fontWeight: '600',
  },
  photosContainer: {
    marginTop: 8,
  },
  photoWrapper: {
    marginRight: 12,
    alignItems: 'center',
  },
  photo: {
    width: 80,
    height: 80,
    borderRadius: 8,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: '#ddd',
  },
  removeButton: {
    position: 'absolute',
    top: -8,
    right: -8,
    backgroundColor: '#fff',
    borderRadius: 12,
    zIndex: 1,
  },
  photoTimestamp: {
    fontSize: 10,
    color: '#666',
    marginTop: 4,
    textAlign: 'center',
  },
  infoContainer: {
    backgroundColor: '#f8f9fa',
    borderRadius: 8,
    padding: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#007AFF',
  },
  infoItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 4,
  },
  infoText: {
    fontSize: 14,
    color: '#666',
    marginLeft: 8,
    flex: 1,
  },
  submitButton: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    elevation: 5,
    borderWidth: 1,
    borderColor: '#dc3545',
  },
  submitButtonDisabled: {
    backgroundColor: '#ccc',
    borderColor: '#666',
  },
  submitButtonText: {
    color: '#000',
    fontSize: 18,
    fontWeight: 'bold',
  },
  analyzeButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#007AFF',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
    marginTop: 6,
    position: 'absolute',
    bottom: -28,
    left: 0,
    right: 0,
  },
  analyzeButtonText: {
    color: '#fff',
    fontSize: 10,
    fontWeight: '600',
    marginLeft: 2,
  },
  buttonGroup: {
    flexDirection: 'row',
    gap: 8,
  },
  photoButtonSecondary: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 8,
    borderRadius: 8,
    backgroundColor: '#fff',
    borderWidth: 1,
    borderColor: '#28a745',
  },
  photoButtonTextSecondary: {
    color: '#000',
    fontSize: 14,
    marginLeft: 4,
    fontWeight: '600',
  },
});

export default HazardReportScreen;
