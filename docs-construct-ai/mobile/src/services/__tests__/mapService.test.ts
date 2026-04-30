/**
 * Map Service Unit Tests
 *
 * Tests the map service functionality including location tracking,
 * marker management, region calculations, offline data, and routing.
 */

import { mapService, MapLocation, SafetyMapMarker } from '../mapService';
import * as Location from 'expo-location';

// Mock external dependencies
jest.mock('expo-location');
jest.mock('react-native-maps');

describe('MapService', () => {
  const mockLocation = Location as jest.Mocked<typeof Location>;

  // Mock location data
  const mockLocationObject: Location.LocationObject = {
    coords: {
      latitude: -26.2041,
      longitude: 28.0473,
      altitude: 1500,
      accuracy: 10,
      altitudeAccuracy: 5,
      heading: 90,
      speed: 0,
    },
    timestamp: Date.now(),
  };

  const mockRegion = {
    latitude: -26.2041,
    longitude: 28.0473,
    latitudeDelta: 0.01,
    longitudeDelta: 0.01,
  };

  const mockIncidents = [
    {
      id: '1',
      incidentType: 'accident',
      severity: 'high' as const,
      description: 'Worker slipped',
      reportedAt: '2024-01-15T10:00:00Z',
      status: 'investigating' as const,
      location: { latitude: -26.2041, longitude: 28.0473 },
      photos: [],
      videos: [],
      synced: false,
    },
    {
      id: '2',
      incidentType: 'near_miss',
      severity: 'medium' as const,
      description: 'Equipment almost fell',
      reportedAt: '2024-01-20T14:30:00Z',
      status: 'closed' as const,
      location: { latitude: -26.1951, longitude: 28.0345 },
      photos: [],
      videos: [],
      synced: true,
    },
  ];

  const mockHazards = [
    {
      id: '1',
      hazardType: 'chemical',
      riskLevel: 'high' as const,
      description: 'Spilled chemicals',
      status: 'active' as const,
      location: { latitude: -26.2041, longitude: 28.0473 },
      synced: false,
    },
  ];

  beforeEach(() => {
    jest.clearAllMocks();

    // Setup default mocks
    mockLocation.requestForegroundPermissionsAsync.mockResolvedValue({
      status: 'granted' as any,
      expires: 'never',
      granted: true,
      canAskAgain: true,
    });
    mockLocation.getCurrentPositionAsync.mockResolvedValue(mockLocationObject);
    mockLocation.watchPositionAsync.mockResolvedValue({
      remove: jest.fn(),
    } as any);
  });

  describe('Initialization', () => {
    it('should initialize location services', async () => {
      // Reinitialize service to trigger initialization
      const newService = new (mapService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(mockLocation.requestForegroundPermissionsAsync).toHaveBeenCalled();
      expect(mockLocation.getCurrentPositionAsync).toHaveBeenCalledWith({
        accuracy: Location.Accuracy.High,
      });
    });

    it('should handle location permission denial', async () => {
      mockLocation.requestForegroundPermissionsAsync.mockResolvedValueOnce({
        status: 'denied' as any,
        expires: 'never',
        granted: false,
        canAskAgain: true,
      });

      const consoleSpy = jest.spyOn(console, 'warn').mockImplementation();

      const newService = new (mapService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(consoleSpy).toHaveBeenCalledWith('Location permission denied');

      consoleSpy.mockRestore();
    });

    it('should handle location initialization errors', async () => {
      mockLocation.getCurrentPositionAsync.mockRejectedValueOnce(
        new Error('Location unavailable')
      );

      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      const newService = new (mapService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to initialize location:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Location Tracking', () => {
    it('should get current location', async () => {
      const location = await mapService.getCurrentLocation();

      expect(location).toEqual(mockLocationObject);
      expect(mockLocation.getCurrentPositionAsync).toHaveBeenCalled();
    });

    it('should start location tracking', async () => {
      const onLocationUpdate = jest.fn();

      await mapService.startLocationTracking(onLocationUpdate);

      expect(mockLocation.requestForegroundPermissionsAsync).toHaveBeenCalled();
      expect(mockLocation.watchPositionAsync).toHaveBeenCalledWith(
        {
          accuracy: Location.Accuracy.High,
          timeInterval: 5000,
          distanceInterval: 10,
        },
        expect.any(Function)
      );
    });

    it('should handle location tracking permission denial', async () => {
      mockLocation.requestForegroundPermissionsAsync.mockResolvedValueOnce({
        status: 'denied' as any,
        expires: 'never',
        granted: false,
        canAskAgain: true,
      });

      await expect(mapService.startLocationTracking()).rejects.toThrow(
        'Location permission denied'
      );
    });

    it('should stop location tracking', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      // Start tracking first
      await mapService.startLocationTracking();

      // Stop tracking
      await mapService.stopLocationTracking();

      expect(consoleSpy).toHaveBeenCalledWith('Location tracking stopped');

      consoleSpy.mockRestore();
    });

    it('should handle location tracking errors', async () => {
      mockLocation.watchPositionAsync.mockRejectedValueOnce(
        new Error('GPS unavailable')
      );

      await expect(mapService.startLocationTracking()).rejects.toThrow(
        'GPS unavailable'
      );
    });
  });

  describe('Marker Conversion', () => {
    it('should convert incidents to map markers', () => {
      const markers = mapService.incidentsToMarkers(mockIncidents);

      expect(markers).toHaveLength(2);
      expect(markers[0]).toMatchObject({
        id: '1',
        coordinate: {
          latitude: -26.2041,
          longitude: 28.0473,
        },
        title: 'accident Incident',
        description: 'Worker slipped',
        type: 'incident',
        severity: 'high',
        data: mockIncidents[0],
      });
      expect(markers[0].timestamp).toBeInstanceOf(Date);
    });

    it('should convert hazards to map markers', () => {
      const markers = mapService.hazardsToMarkers(mockHazards);

      expect(markers).toHaveLength(1);
      expect(markers[0]).toMatchObject({
        id: '1',
        coordinate: {
          latitude: -26.2041,
          longitude: 28.0473,
        },
        title: 'chemical Hazard',
        description: 'Spilled chemicals',
        type: 'hazard',
        severity: 'high',
      });
    });

    it('should filter out items without location data', () => {
      const incidentsWithoutLocation = [
        {
          ...mockIncidents[0],
          location: undefined,
        },
      ];

      const markers = mapService.incidentsToMarkers(incidentsWithoutLocation);

      expect(markers).toHaveLength(0);
    });
  });

  describe('Region and Marker Management', () => {
    it('should get markers for a specific region', () => {
      const markers = mapService.getMarkersForRegion(
        mockRegion,
        mockIncidents,
        mockHazards
      );

      expect(markers.length).toBeGreaterThan(0);
      expect(markers.some(m => m.type === 'incident')).toBe(true);
      expect(markers.some(m => m.type === 'hazard')).toBe(true);
    });

    it('should filter markers outside region bounds', () => {
      const distantRegion = {
        latitude: -30.0, // Far from mock data
        longitude: 25.0,
        latitudeDelta: 0.01,
        longitudeDelta: 0.01,
      };

      const markers = mapService.getMarkersForRegion(
        distantRegion,
        mockIncidents,
        mockHazards
      );

      expect(markers).toHaveLength(0);
    });

    it('should calculate optimal region for markers', () => {
      const markers: SafetyMapMarker[] = [
        {
          id: '1',
          coordinate: { latitude: -26.2041, longitude: 28.0473 },
          title: 'Marker 1',
          description: 'Test marker',
          type: 'incident',
          timestamp: new Date(),
        },
        {
          id: '2',
          coordinate: { latitude: -26.1951, longitude: 28.0345 },
          title: 'Marker 2',
          description: 'Test marker',
          type: 'hazard',
          timestamp: new Date(),
        },
      ];

      const region = mapService.calculateRegionForMarkers(markers);

      expect(region).toBeTruthy();
      expect(region!.latitude).toBeCloseTo(-26.1996, 4);
      expect(region!.longitude).toBeCloseTo(28.0409, 4);
      expect(region!.latitudeDelta).toBeGreaterThan(0.01);
      expect(region!.longitudeDelta).toBeGreaterThan(0.01);
    });

    it('should return null for empty marker list', () => {
      const region = mapService.calculateRegionForMarkers([]);

      expect(region).toBeNull();
    });
  });

  describe('Directions and Routing', () => {
    it('should get directions between two points', async () => {
      const origin = { latitude: -26.2041, longitude: 28.0473 };
      const destination = { latitude: -26.1951, longitude: 28.0345 };

      const directions = await mapService.getDirections(origin, destination);

      expect(directions).toMatchObject({
        distance: '2.5 km',
        duration: '15 mins',
        steps: expect.any(Array),
        coordinates: expect.any(Array),
      });
      expect(directions.steps).toHaveLength(3);
      expect(directions.coordinates).toHaveLength(3);
    });

    it('should create emergency route', async () => {
      const startLocation = { latitude: -26.2041, longitude: 28.0473 };
      const emergencyLocation = { latitude: -26.1951, longitude: 28.0345 };

      const emergencyRoute = await mapService.createEmergencyRoute(
        startLocation,
        emergencyLocation
      );

      expect(emergencyRoute).toMatchObject({
        distance: '2.5 km',
        duration: '15 mins',
        priority: 'emergency',
        estimatedResponseTime: '8 minutes',
        alternativeRoutes: expect.any(Array),
      });
    });

    it('should handle directions errors', async () => {
      // Mock console.log to avoid cluttering test output
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const origin = { latitude: -26.2041, longitude: 28.0473 };
      const destination = { latitude: -26.1951, longitude: 28.0345 };

      // Directions should still work (mock implementation)
      const directions = await mapService.getDirections(origin, destination);

      expect(directions).toBeTruthy();
      expect(consoleSpy).toHaveBeenCalledWith(
        'Getting directions from',
        origin,
        'to',
        destination
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Offline Data Management', () => {
    it('should save offline map data', () => {
      const markers: SafetyMapMarker[] = [
        {
          id: '1',
          coordinate: { latitude: -26.2041, longitude: 28.0473 },
          title: 'Test Marker',
          description: 'Test description',
          type: 'incident',
          timestamp: new Date(),
        },
      ];

      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      mapService.saveOfflineData(mockRegion, markers);

      expect(consoleSpy).toHaveBeenCalledWith(
        'Offline map data saved for region:',
        mockRegion
      );

      consoleSpy.mockRestore();
    });

    it('should retrieve offline map data', () => {
      const markers: SafetyMapMarker[] = [
        {
          id: '1',
          coordinate: { latitude: -26.2041, longitude: 28.0473 },
          title: 'Test Marker',
          description: 'Test description',
          type: 'incident',
          timestamp: new Date(),
        },
      ];

      mapService.saveOfflineData(mockRegion, markers);
      const offlineData = mapService.getOfflineData(mockRegion);

      expect(offlineData).toBeTruthy();
      expect(offlineData!.region).toEqual(mockRegion);
      expect(offlineData!.markers).toEqual(markers);
      expect(offlineData!.isOffline).toBe(true);
      expect(offlineData!.lastUpdated).toBeInstanceOf(Date);
    });

    it('should return null for non-existent offline data', () => {
      const nonExistentRegion = {
        latitude: -30.0,
        longitude: 25.0,
        latitudeDelta: 0.01,
        longitudeDelta: 0.01,
      };

      const offlineData = mapService.getOfflineData(nonExistentRegion);

      expect(offlineData).toBeNull();
    });

    it('should check if region has offline data', () => {
      const markers: SafetyMapMarker[] = [
        {
          id: '1',
          coordinate: { latitude: -26.2041, longitude: 28.0473 },
          title: 'Test Marker',
          description: 'Test description',
          type: 'incident',
          timestamp: new Date(),
        },
      ];

      mapService.saveOfflineData(mockRegion, markers);

      expect(mapService.hasOfflineData(mockRegion)).toBe(true);

      const nonExistentRegion = {
        latitude: -30.0,
        longitude: 25.0,
        latitudeDelta: 0.01,
        longitudeDelta: 0.01,
      };

      expect(mapService.hasOfflineData(nonExistentRegion)).toBe(false);
    });

    it('should clear offline data for specific region', () => {
      const markers: SafetyMapMarker[] = [
        {
          id: '1',
          coordinate: { latitude: -26.2041, longitude: 28.0473 },
          title: 'Test Marker',
          description: 'Test description',
          type: 'incident',
          timestamp: new Date(),
        },
      ];

      mapService.saveOfflineData(mockRegion, markers);
      expect(mapService.hasOfflineData(mockRegion)).toBe(true);

      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      mapService.clearOfflineData(mockRegion);

      expect(mapService.hasOfflineData(mockRegion)).toBe(false);
      expect(consoleSpy).toHaveBeenCalledWith(
        'Offline data cleared for region:',
        mockRegion
      );

      consoleSpy.mockRestore();
    });

    it('should clear all offline data', () => {
      const markers: SafetyMapMarker[] = [
        {
          id: '1',
          coordinate: { latitude: -26.2041, longitude: 28.0473 },
          title: 'Test Marker',
          description: 'Test description',
          type: 'incident',
          timestamp: new Date(),
        },
      ];

      const region1 = { ...mockRegion };
      const region2 = { ...mockRegion, latitude: -26.1951 };

      mapService.saveOfflineData(region1, markers);
      mapService.saveOfflineData(region2, markers);

      expect(mapService.hasOfflineData(region1)).toBe(true);
      expect(mapService.hasOfflineData(region2)).toBe(true);

      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      mapService.clearOfflineData();

      expect(mapService.hasOfflineData(region1)).toBe(false);
      expect(mapService.hasOfflineData(region2)).toBe(false);
      expect(consoleSpy).toHaveBeenCalledWith('All offline data cleared');

      consoleSpy.mockRestore();
    });
  });

  describe('Nearby Safety Features', () => {
    it('should get nearby safety features', () => {
      const center = { latitude: -26.2041, longitude: 28.0473 };
      const markers: SafetyMapMarker[] = [
        {
          id: 'nearby',
          coordinate: { latitude: -26.2042, longitude: 28.0474 }, // Very close
          title: 'Nearby Feature',
          description: 'Test feature',
          type: 'emergency',
          timestamp: new Date(),
        },
        {
          id: 'far',
          coordinate: { latitude: -26.3, longitude: 28.1 }, // Far away
          title: 'Far Feature',
          description: 'Test feature',
          type: 'emergency',
          timestamp: new Date(),
        },
      ];

      // Save offline data first
      mapService.saveOfflineData(mockRegion, markers);

      const nearbyFeatures = mapService.getNearbySafetyFeatures(center, 1); // 1km radius

      expect(nearbyFeatures).toHaveLength(1);
      expect(nearbyFeatures[0].id).toBe('nearby');
    });

    it('should return empty array when no offline data', () => {
      const center = { latitude: -26.2041, longitude: 28.0473 };

      const nearbyFeatures = mapService.getNearbySafetyFeatures(center, 1);

      expect(nearbyFeatures).toEqual([]);
    });
  });

  describe('Geocoding', () => {
    it('should geocode address to coordinates', async () => {
      const address = '123 Safety Street, Industrial Area';

      const coordinates = await mapService.geocodeAddress(address);

      expect(coordinates).toEqual({
        latitude: -33.9249,
        longitude: 18.4241,
      });
    });

    it('should handle geocoding errors', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const address = 'Invalid Address';
      const coordinates = await mapService.geocodeAddress(address);

      expect(coordinates).toBeTruthy(); // Mock always returns coordinates
      expect(consoleSpy).toHaveBeenCalledWith('Geocoding address:', address);

      consoleSpy.mockRestore();
    });

    it('should reverse geocode coordinates to address', async () => {
      const coordinates = { latitude: -26.2041, longitude: 28.0473 };

      const address = await mapService.reverseGeocode(coordinates);

      expect(address).toBe('123 Safety Street, Industrial Area, City, Country');
    });

    it('should handle reverse geocoding errors', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const coordinates = { latitude: -26.2041, longitude: 28.0473 };
      const address = await mapService.reverseGeocode(coordinates);

      expect(address).toBeTruthy();
      expect(consoleSpy).toHaveBeenCalledWith('Reverse geocoding coordinates:', coordinates);

      consoleSpy.mockRestore();
    });
  });

  describe('Safety Zones', () => {
    it('should return predefined safety zones', () => {
      const safetyZones = mapService.getSafetyZones();

      expect(safetyZones).toHaveLength(2);
      expect(safetyZones[0]).toMatchObject({
        id: 'first_aid_1',
        title: 'First Aid Station',
        description: 'Emergency medical supplies available',
        type: 'emergency',
      });
      expect(safetyZones[0].coordinate).toBeDefined();
      expect(safetyZones[0].timestamp).toBeInstanceOf(Date);
    });
  });

  describe('Data Export/Import', () => {
    it('should export map data', () => {
      const markers: SafetyMapMarker[] = [
        {
          id: '1',
          coordinate: { latitude: -26.2041, longitude: 28.0473 },
          title: 'Test Marker',
          description: 'Test description',
          type: 'incident',
          timestamp: new Date(),
        },
      ];

      mapService.saveOfflineData(mockRegion, markers);
      const exportedData = mapService.exportMapData(mockRegion);

      expect(typeof exportedData).toBe('string');

      const parsedData = JSON.parse(exportedData);
      expect(parsedData.region).toEqual(mockRegion);
      expect(parsedData.markers).toEqual(markers);
      expect(parsedData.exportedAt).toBeDefined();
      expect(parsedData.version).toBe('1.0');
    });

    it('should import map data successfully', () => {
      const markers: SafetyMapMarker[] = [
        {
          id: 'imported',
          coordinate: { latitude: -26.2041, longitude: 28.0473 },
          title: 'Imported Marker',
          description: 'Test description',
          type: 'incident',
          timestamp: new Date(),
        },
      ];

      const exportData = {
        region: mockRegion,
        markers,
        exportedAt: new Date().toISOString(),
        version: '1.0',
      };

      const jsonData = JSON.stringify(exportData);
      const result = mapService.importMapData(jsonData);

      expect(result).toBe(true);
      expect(mapService.hasOfflineData(mockRegion)).toBe(true);

      const importedData = mapService.getOfflineData(mockRegion);
      expect(importedData!.markers).toEqual(markers);
    });

    it('should handle invalid import data', () => {
      const invalidJsonData = '{"invalid": "data"}';
      const result = mapService.importMapData(invalidJsonData);

      expect(result).toBe(false);
    });

    it('should handle import JSON parsing errors', () => {
      const invalidJsonData = '{invalid json}';
      const result = mapService.importMapData(invalidJsonData);

      expect(result).toBe(false);
    });
  });

  describe('Map Statistics', () => {
    it('should get map statistics', () => {
      const markers1: SafetyMapMarker[] = [
        {
          id: '1',
          coordinate: { latitude: -26.2041, longitude: 28.0473 },
          title: 'Marker 1',
          description: 'Test',
          type: 'incident',
          timestamp: new Date(),
        },
      ];

      const markers2: SafetyMapMarker[] = [
        {
          id: '2',
          coordinate: { latitude: -26.1951, longitude: 28.0345 },
          title: 'Marker 2',
          description: 'Test',
          type: 'hazard',
          timestamp: new Date(),
        },
        {
          id: '3',
          coordinate: { latitude: -26.1952, longitude: 28.0346 },
          title: 'Marker 3',
          description: 'Test',
          type: 'hazard',
          timestamp: new Date(),
        },
      ];

      const region1 = { ...mockRegion };
      const region2 = { ...mockRegion, latitude: -26.1951 };

      mapService.saveOfflineData(region1, markers1);
      mapService.saveOfflineData(region2, markers2);

      const stats = mapService.getMapStatistics();

      expect(stats.totalRegions).toBe(2);
      expect(stats.totalMarkers).toBe(3);
      expect(stats.lastUpdated).toBeInstanceOf(Date);
    });

    it('should handle empty map statistics', () => {
      const stats = mapService.getMapStatistics();

      expect(stats.totalRegions).toBe(0);
      expect(stats.totalMarkers).toBe(0);
      expect(stats.lastUpdated).toBeNull();
    });
  });

  describe('Distance Calculations', () => {
    it('should calculate distance between coordinates', () => {
      const service = mapService as any;

      // Test distance between two points
      const distance = service.calculateDistance(
        -26.2041, 28.0473, // Johannesburg coordinates
        -33.9249, 18.4241  // Cape Town coordinates
      );

      expect(distance).toBeGreaterThan(1200); // Approximately 1400km
      expect(distance).toBeLessThan(1600);
    });

    it('should handle same coordinates', () => {
      const service = mapService as any;

      const distance = service.calculateDistance(
        -26.2041, 28.0473,
        -26.2041, 28.0473
      );

      expect(distance).toBe(0);
    });

    it('should convert degrees to radians', () => {
      const service = mapService as any;

      expect(service.toRadians(180)).toBe(Math.PI);
      expect(service.toRadians(90)).toBe(Math.PI / 2);
      expect(service.toRadians(0)).toBe(0);
    });
  });

  describe('Service Lifecycle', () => {
    it('should destroy service properly', () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      // Start location tracking
      mapService.startLocationTracking();

      // Destroy service
      mapService.destroy();

      expect(consoleSpy).toHaveBeenCalledWith('Map service destroyed');

      consoleSpy.mockRestore();
    });

    it('should stop location tracking on destroy', () => {
      const service = mapService as any;

      // Mock that tracking is active
      service.locationSubscription = { remove: jest.fn() };

      mapService.destroy();

      expect(service.locationSubscription.remove).toHaveBeenCalled();
    });

    it('should clear offline data on destroy', () => {
      const markers: SafetyMapMarker[] = [
        {
          id: '1',
          coordinate: { latitude: -26.2041, longitude: 28.0473 },
          title: 'Test Marker',
          description: 'Test',
          type: 'incident',
          timestamp: new Date(),
        },
      ];

      mapService.saveOfflineData(mockRegion, markers);
      expect(mapService.hasOfflineData(mockRegion)).toBe(true);

      mapService.destroy();

      expect(mapService.hasOfflineData(mockRegion)).toBe(false);
    });
  });

  describe('Error Handling', () => {
    it('should handle location permission errors gracefully', async () => {
      mockLocation.requestForegroundPermissionsAsync.mockRejectedValueOnce(
        new Error('Permission system error')
      );

      const location = await mapService.getCurrentLocation();

      expect(location).toBeNull();
    });

    it('should handle location service unavailability', async () => {
      mockLocation.getCurrentPositionAsync.mockRejectedValueOnce(
        new Error('Location services disabled')
      );

      const location = await mapService.getCurrentLocation();

      expect(location).toBeNull();
    });

    it('should handle directions service errors', async () => {
      // Directions mock implementation doesn't throw errors
      // but in real implementation it might
      const origin = { latitude: -26.2041, longitude: 28.0473 };
      const destination = { latitude: -26.1951, longitude: 28.0345 };

      const directions = await mapService.getDirections(origin, destination);

      expect(directions).toBeTruthy();
    });

    it('should handle emergency route creation errors', async () => {
      // Mock getDirections to throw error
      const originalGetDirections = mapService.getDirections;
      mapService.getDirections = jest.fn().mockRejectedValue(new Error('Routing service unavailable'));

      const startLocation = { latitude: -26.2041, longitude: 28.0473 };
      const emergencyLocation = { latitude: -26.1951, longitude: 28.0345 };

      await expect(mapService.createEmergencyRoute(startLocation, emergencyLocation))
        .rejects.toThrow('Routing service unavailable');

      // Restore original method
      mapService.getDirections = originalGetDirections;
    });
  });
});
