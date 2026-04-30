import * as Location from 'expo-location';
import MapView, { Marker, Region } from 'react-native-maps';
import { SafetyIncident, SafetyHazard } from '../store/slices/safetySlice';

export interface MapLocation {
  latitude: number;
  longitude: number;
  latitudeDelta: number;
  longitudeDelta: number;
}

export interface SafetyMapMarker {
  id: string;
  coordinate: {
    latitude: number;
    longitude: number;
  };
  title: string;
  description: string;
  type: 'incident' | 'hazard' | 'equipment' | 'emergency';
  severity?: 'low' | 'medium' | 'high' | 'critical';
  timestamp: Date;
  data?: any;
}

export interface OfflineMapData {
  region: Region;
  markers: SafetyMapMarker[];
  lastUpdated: Date;
  isOffline: boolean;
}

class MapService {
  private currentLocation: Location.LocationObject | null = null;
  private locationSubscription: Location.LocationSubscription | null = null;
  private offlineData: Map<Region, OfflineMapData> = new Map();

  constructor() {
    this.initializeLocation();
  }

  private async initializeLocation() {
    try {
      const { status } = await Location.requestForegroundPermissionsAsync();
      if (status !== 'granted') {
        console.warn('Location permission denied');
        return;
      }

      // Get initial location
      const location = await Location.getCurrentPositionAsync({
        accuracy: Location.Accuracy.High,
      });
      this.currentLocation = location;
    } catch (error) {
      console.error('Failed to initialize location:', error);
    }
  }

  // Get current location
  async getCurrentLocation(): Promise<Location.LocationObject | null> {
    try {
      if (!this.currentLocation) {
        await this.initializeLocation();
      }
      return this.currentLocation;
    } catch (error) {
      console.error('Failed to get current location:', error);
      return null;
    }
  }

  // Start location tracking
  async startLocationTracking(onLocationUpdate?: (location: Location.LocationObject) => void) {
    try {
      const { status } = await Location.requestForegroundPermissionsAsync();
      if (status !== 'granted') {
        throw new Error('Location permission denied');
      }

      this.locationSubscription = await Location.watchPositionAsync(
        {
          accuracy: Location.Accuracy.High,
          timeInterval: 5000, // Update every 5 seconds
          distanceInterval: 10, // Update every 10 meters
        },
        (location) => {
          this.currentLocation = location;
          onLocationUpdate?.(location);
        }
      );

      console.log('Location tracking started');
    } catch (error) {
      console.error('Failed to start location tracking:', error);
      throw error;
    }
  }

  // Stop location tracking
  async stopLocationTracking() {
    try {
      if (this.locationSubscription) {
        this.locationSubscription.remove();
        this.locationSubscription = null;
        console.log('Location tracking stopped');
      }
    } catch (error) {
      console.error('Failed to stop location tracking:', error);
    }
  }

  // Convert incidents to map markers
  incidentsToMarkers(incidents: SafetyIncident[]): SafetyMapMarker[] {
    return incidents
      .filter(incident => incident.location)
      .map(incident => ({
        id: incident.id,
        coordinate: {
          latitude: incident.location!.latitude,
          longitude: incident.location!.longitude,
        },
        title: `${incident.incidentType} Incident`,
        description: incident.description,
        type: 'incident' as const,
        severity: incident.severity,
        timestamp: new Date(incident.reportedAt),
        data: incident,
      }));
  }

  // Convert hazards to map markers
  hazardsToMarkers(hazards: SafetyHazard[]): SafetyMapMarker[] {
    return hazards
      .filter(hazard => hazard.location)
      .map(hazard => ({
        id: hazard.id,
        coordinate: {
          latitude: hazard.location!.latitude,
          longitude: hazard.location!.longitude,
        },
        title: `${hazard.hazardType} Hazard`,
        description: hazard.description,
        type: 'hazard' as const,
        severity: hazard.riskLevel as 'low' | 'medium' | 'high' | 'critical',
        timestamp: new Date(),
        data: hazard,
      }));
  }

  // Get markers for a region
  getMarkersForRegion(
    region: Region,
    incidents: SafetyIncident[],
    hazards: SafetyHazard[]
  ): SafetyMapMarker[] {
    const incidentMarkers = this.incidentsToMarkers(incidents);
    const hazardMarkers = this.hazardsToMarkers(hazards);

    // Filter markers within the region bounds
    const allMarkers = [...incidentMarkers, ...hazardMarkers];
    return allMarkers.filter(marker => {
      const { latitude, longitude } = marker.coordinate;
      return (
        latitude >= region.latitude - region.latitudeDelta / 2 &&
        latitude <= region.latitude + region.latitudeDelta / 2 &&
        longitude >= region.longitude - region.longitudeDelta / 2 &&
        longitude <= region.longitude + region.longitudeDelta / 2
      );
    });
  }

  // Calculate optimal map region for markers
  calculateRegionForMarkers(markers: SafetyMapMarker[]): Region | null {
    if (markers.length === 0) return null;

    let minLat = markers[0].coordinate.latitude;
    let maxLat = markers[0].coordinate.latitude;
    let minLng = markers[0].coordinate.longitude;
    let maxLng = markers[0].coordinate.longitude;

    markers.forEach(marker => {
      const { latitude, longitude } = marker.coordinate;
      minLat = Math.min(minLat, latitude);
      maxLat = Math.max(maxLat, latitude);
      minLng = Math.min(minLng, longitude);
      maxLng = Math.max(maxLng, longitude);
    });

    const latitude = (minLat + maxLat) / 2;
    const longitude = (minLng + maxLng) / 2;
    const latitudeDelta = Math.max(maxLat - minLat + 0.01, 0.01);
    const longitudeDelta = Math.max(maxLng - minLng + 0.01, 0.01);

    return {
      latitude,
      longitude,
      latitudeDelta: latitudeDelta * 1.2, // Add 20% padding
      longitudeDelta: longitudeDelta * 1.2,
    };
  }

  // Get directions between two points
  async getDirections(
    origin: { latitude: number; longitude: number },
    destination: { latitude: number; longitude: number }
  ): Promise<any> {
    try {
      // This would integrate with a mapping service like Google Maps or Mapbox
      // For now, return mock directions
      console.log('Getting directions from', origin, 'to', destination);

      return {
        distance: '2.5 km',
        duration: '15 mins',
        steps: [
          'Head north on Main St',
          'Turn right onto Safety Ave',
          'Destination on the left'
        ],
        coordinates: [
          origin,
          { latitude: (origin.latitude + destination.latitude) / 2, longitude: (origin.longitude + destination.longitude) / 2 },
          destination
        ]
      };
    } catch (error) {
      console.error('Failed to get directions:', error);
      throw error;
    }
  }

  // Save offline map data
  saveOfflineData(region: Region, markers: SafetyMapMarker[]) {
    const offlineData: OfflineMapData = {
      region,
      markers,
      lastUpdated: new Date(),
      isOffline: true,
    };

    this.offlineData.set(region, offlineData);
    console.log('Offline map data saved for region:', region);
  }

  // Get offline map data
  getOfflineData(region: Region): OfflineMapData | null {
    return this.offlineData.get(region) || null;
  }

  // Check if region has offline data
  hasOfflineData(region: Region): boolean {
    return this.offlineData.has(region);
  }

  // Clear offline data
  clearOfflineData(region?: Region) {
    if (region) {
      this.offlineData.delete(region);
      console.log('Offline data cleared for region:', region);
    } else {
      this.offlineData.clear();
      console.log('All offline data cleared');
    }
  }

  // Get nearby safety features
  getNearbySafetyFeatures(
    center: { latitude: number; longitude: number },
    radiusKm: number = 1
  ): SafetyMapMarker[] {
    const allMarkers: SafetyMapMarker[] = [];

    // Collect all markers from offline data
    this.offlineData.forEach(data => {
      allMarkers.push(...data.markers);
    });

    // Filter by distance
    return allMarkers.filter(marker => {
      const distance = this.calculateDistance(
        center.latitude,
        center.longitude,
        marker.coordinate.latitude,
        marker.coordinate.longitude
      );
      return distance <= radiusKm;
    });
  }

  // Calculate distance between two coordinates (Haversine formula)
  private calculateDistance(
    lat1: number,
    lon1: number,
    lat2: number,
    lon2: number
  ): number {
    const R = 6371; // Earth's radius in kilometers
    const dLat = this.toRadians(lat2 - lat1);
    const dLon = this.toRadians(lon2 - lon1);

    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(this.toRadians(lat1)) * Math.cos(this.toRadians(lat2)) *
      Math.sin(dLon / 2) * Math.sin(dLon / 2);

    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }

  private toRadians(degrees: number): number {
    return degrees * (Math.PI / 180);
  }

  // Geocode address to coordinates
  async geocodeAddress(address: string): Promise<{ latitude: number; longitude: number } | null> {
    try {
      // This would integrate with a geocoding service
      console.log('Geocoding address:', address);

      // Mock geocoding result
      return {
        latitude: -33.9249,
        longitude: 18.4241, // Cape Town coordinates as example
      };
    } catch (error) {
      console.error('Failed to geocode address:', error);
      return null;
    }
  }

  // Reverse geocode coordinates to address
  async reverseGeocode(coordinates: { latitude: number; longitude: number }): Promise<string | null> {
    try {
      // This would integrate with a reverse geocoding service
      console.log('Reverse geocoding coordinates:', coordinates);

      // Mock reverse geocoding result
      return '123 Safety Street, Industrial Area, City, Country';
    } catch (error) {
      console.error('Failed to reverse geocode:', error);
      return null;
    }
  }

  // Create emergency route
  async createEmergencyRoute(
    startLocation: { latitude: number; longitude: number },
    emergencyLocation: { latitude: number; longitude: number }
  ): Promise<any> {
    try {
      console.log('Creating emergency route...');

      const directions = await this.getDirections(startLocation, emergencyLocation);

      return {
        ...directions,
        priority: 'emergency',
        estimatedResponseTime: '8 minutes',
        alternativeRoutes: [
          {
            distance: '3.2 km',
            duration: '18 mins',
            reason: 'Heavy traffic'
          }
        ]
      };
    } catch (error) {
      console.error('Failed to create emergency route:', error);
      throw error;
    }
  }

  // Get safety zones
  getSafetyZones(): SafetyMapMarker[] {
    // Return predefined safety zones (first aid stations, emergency exits, etc.)
    return [
      {
        id: 'first_aid_1',
        coordinate: { latitude: -33.9249, longitude: 18.4241 },
        title: 'First Aid Station',
        description: 'Emergency medical supplies available',
        type: 'emergency',
        timestamp: new Date(),
      },
      {
        id: 'emergency_exit_1',
        coordinate: { latitude: -33.9250, longitude: 18.4242 },
        title: 'Emergency Exit',
        description: 'Primary evacuation route',
        type: 'emergency',
        timestamp: new Date(),
      }
    ];
  }

  // Export map data
  exportMapData(region: Region): string {
    const markers = this.getOfflineData(region)?.markers || [];
    const exportData = {
      region,
      markers,
      exportedAt: new Date().toISOString(),
      version: '1.0'
    };

    return JSON.stringify(exportData, null, 2);
  }

  // Import map data
  importMapData(jsonData: string): boolean {
    try {
      const data = JSON.parse(jsonData);
      if (data.region && data.markers) {
        this.saveOfflineData(data.region, data.markers);
        return true;
      }
      return false;
    } catch (error) {
      console.error('Failed to import map data:', error);
      return false;
    }
  }

  // Get map statistics
  getMapStatistics(): {
    totalRegions: number;
    totalMarkers: number;
    lastUpdated: Date | null;
  } {
    let totalMarkers = 0;
    let lastUpdated: Date | null = null;

    this.offlineData.forEach(data => {
      totalMarkers += data.markers.length;
      if (!lastUpdated || data.lastUpdated > lastUpdated) {
        lastUpdated = data.lastUpdated;
      }
    });

    return {
      totalRegions: this.offlineData.size,
      totalMarkers,
      lastUpdated,
    };
  }

  // Cleanup
  destroy() {
    this.stopLocationTracking();
    this.offlineData.clear();
    console.log('Map service destroyed');
  }
}

// Export singleton instance
export const mapService = new MapService();
export default mapService;
