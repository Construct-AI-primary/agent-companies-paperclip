/**
 * IoT Service Unit Tests
 *
 * Tests the IoT service functionality including sensor monitoring,
 * safety threshold detection, IoT device management, environmental monitoring,
 * and equipment sensor data processing.
 */

import { iotService, SensorData, SafetyThreshold, IoTDevice, EnvironmentalData, EquipmentSensor } from '../iotService';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { DeviceMotion, Accelerometer, Gyroscope, Magnetometer, Barometer } from 'expo-sensors';

// Mock external dependencies
jest.mock('@react-native-async-storage/async-storage');
jest.mock('expo-sensors');

describe('IoTService', () => {
  const mockAsyncStorage = AsyncStorage as jest.Mocked<typeof AsyncStorage>;
  const mockDeviceMotion = DeviceMotion as jest.Mocked<typeof DeviceMotion>;
  const mockAccelerometer = Accelerometer as jest.Mocked<typeof Accelerometer>;
  const mockGyroscope = Gyroscope as jest.Mocked<typeof Gyroscope>;
  const mockMagnetometer = Magnetometer as jest.Mocked<typeof Magnetometer>;
  const mockBarometer = Barometer as jest.Mocked<typeof Barometer>;

  // Mock sensor data
  const mockSensorData: SensorData = {
    timestamp: new Date(),
    accelerometer: { x: 1.2, y: 0.8, z: 9.8 },
    gyroscope: { x: 0.1, y: 0.2, z: 0.05 },
    magnetometer: { x: 15.2, y: -8.7, z: 23.1 },
    barometer: { pressure: 1013.25, relativeAltitude: 45.2 },
    deviceMotion: {
      acceleration: { x: 1.2, y: 0.8, z: 9.8 },
      accelerationIncludingGravity: { x: 1.2, y: 0.8, z: 9.8 },
      rotation: { alpha: 90, beta: 0, gamma: 0 },
      rotationRate: { alpha: 0.1, beta: 0.2, gamma: 0.05 },
      orientation: 1,
    },
    pedometer: { steps: 150, distance: 120 },
  };

  const mockIoTDevice: Omit<IoTDevice, 'lastSeen'> = {
    id: 'device-001',
    name: 'Safety Wearable Alpha',
    type: 'wearable',
    sensors: ['accelerometer', 'gyroscope', 'heart_rate'],
    location: { latitude: -26.2041, longitude: 28.0473 },
    status: 'online',
    batteryLevel: 85,
    firmwareVersion: '1.2.3',
  };

  const mockEnvironmentalData: EnvironmentalData = {
    temperature: 28.5,
    humidity: 65,
    airQuality: 45,
    noiseLevel: 70,
    lightLevel: 800,
    timestamp: new Date(),
    location: { latitude: -26.2041, longitude: 28.0473 },
  };

  const mockEquipmentSensor: EquipmentSensor = {
    equipmentId: 'excavator-001',
    sensorType: 'vibration',
    value: 2.8,
    unit: 'mm/s',
    threshold: { warning: 2.5, critical: 3.5 },
    timestamp: new Date(),
    status: 'warning',
  };

  beforeEach(() => {
    jest.clearAllMocks();

    // Setup default mocks
    mockAsyncStorage.getItem.mockResolvedValue(null);
    mockAsyncStorage.setItem.mockResolvedValue(undefined);
    mockAsyncStorage.multiRemove.mockResolvedValue(undefined);
    mockAsyncStorage.getAllKeys.mockResolvedValue([]);

    // Mock sensor subscriptions
    const mockSubscription = { remove: jest.fn() };
    mockAccelerometer.addListener.mockReturnValue(mockSubscription as any);
    mockGyroscope.addListener.mockReturnValue(mockSubscription as any);
    mockMagnetometer.addListener.mockReturnValue(mockSubscription as any);
    mockBarometer.addListener.mockReturnValue(mockSubscription as any);
    mockDeviceMotion.addListener.mockReturnValue(mockSubscription as any);

    // Mock sensor update intervals
    mockAccelerometer.setUpdateInterval.mockResolvedValue(undefined);
    mockGyroscope.setUpdateInterval.mockResolvedValue(undefined);
    mockMagnetometer.setUpdateInterval.mockResolvedValue(undefined);
    mockBarometer.setUpdateInterval.mockResolvedValue(undefined);
    mockDeviceMotion.setUpdateInterval.mockResolvedValue(undefined);
  });

  describe('Initialization', () => {
    it('should initialize with default safety thresholds', () => {
      const thresholds = iotService.getSafetyThresholds();

      expect(thresholds).toHaveLength(3);
      expect(thresholds[0]).toMatchObject({
        sensor: 'accelerometer',
        threshold: 15,
        operator: '>',
        severity: 'high',
        description: 'Sudden impact detected',
      });
    });

    it('should load stored data on initialization', async () => {
      const storedThresholds = [
        {
          sensor: 'accelerometer',
          threshold: 20,
          operator: '>' as const,
          severity: 'critical' as const,
          description: 'Custom threshold',
          action: 'Custom action',
        },
      ];

      mockAsyncStorage.getItem.mockImplementation((key) => {
        if (key === 'safety_thresholds') return Promise.resolve(JSON.stringify(storedThresholds));
        if (key === 'iot_devices') return Promise.resolve(JSON.stringify([]));
        return Promise.resolve(null);
      });

      // Reinitialize service to trigger data loading
      const newService = new (iotService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(mockAsyncStorage.getItem).toHaveBeenCalledWith('safety_thresholds');
      expect(mockAsyncStorage.getItem).toHaveBeenCalledWith('iot_devices');
    });

    it('should handle initialization errors gracefully', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      mockAsyncStorage.getItem.mockRejectedValue(new Error('Storage error'));

      const newService = new (iotService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to load stored IoT data:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Sensor Monitoring', () => {
    it('should start sensor monitoring successfully', async () => {
      const result = await iotService.startSensorMonitoring(1000);

      expect(result).toBe(true);
      expect(mockAccelerometer.addListener).toHaveBeenCalled();
      expect(mockGyroscope.addListener).toHaveBeenCalled();
      expect(mockMagnetometer.addListener).toHaveBeenCalled();
      expect(mockBarometer.addListener).toHaveBeenCalled();
      expect(mockDeviceMotion.addListener).toHaveBeenCalled();

      expect(mockAccelerometer.setUpdateInterval).toHaveBeenCalledWith(1000);
      expect(mockGyroscope.setUpdateInterval).toHaveBeenCalledWith(1000);
      expect(mockMagnetometer.setUpdateInterval).toHaveBeenCalledWith(1000);
      expect(mockBarometer.setUpdateInterval).toHaveBeenCalledWith(1000);
      expect(mockDeviceMotion.setUpdateInterval).toHaveBeenCalledWith(1000);
    });

    it('should stop sensor monitoring', async () => {
      // Start monitoring first
      await iotService.startSensorMonitoring();

      // Stop monitoring
      await iotService.stopSensorMonitoring();

      // Verify subscriptions were removed
      const mockSubscription = mockAccelerometer.addListener.mock.results[0].value;
      expect(mockSubscription.remove).toHaveBeenCalled();
    });

    it('should handle sensor monitoring errors', async () => {
      mockAccelerometer.setUpdateInterval.mockRejectedValue(new Error('Sensor error'));

      const result = await iotService.startSensorMonitoring();

      expect(result).toBe(false);
    });

    it('should prevent duplicate monitoring sessions', async () => {
      // Start first session
      await iotService.startSensorMonitoring();

      // Try to start second session
      await iotService.startSensorMonitoring();

      // Should have cleaned up first session
      const mockSubscription = mockAccelerometer.addListener.mock.results[0].value;
      expect(mockSubscription.remove).toHaveBeenCalled();
    });
  });

  describe('Sensor Data Processing', () => {
    it('should process and store sensor data', () => {
      // Access private method through type assertion
      const service = iotService as any;
      service.handleSensorData(mockSensorData);

      const sensorHistory = iotService.getSensorDataHistory(1);
      expect(sensorHistory).toHaveLength(1);
      expect(sensorHistory[0]).toMatchObject({
        accelerometer: mockSensorData.accelerometer,
        gyroscope: mockSensorData.gyroscope,
      });
    });

    it('should limit stored sensor data to prevent memory issues', () => {
      const service = iotService as any;

      // Add more than 1000 data points
      for (let i = 0; i < 1100; i++) {
        service.handleSensorData({
          ...mockSensorData,
          timestamp: new Date(Date.now() + i * 1000),
        });
      }

      const sensorHistory = iotService.getSensorDataHistory(100); // Get all data
      expect(sensorHistory.length).toBeLessThanOrEqual(1000);
    });

    it('should store sensor data in AsyncStorage', () => {
      const service = iotService as any;
      service.handleSensorData(mockSensorData);

      expect(mockAsyncStorage.setItem).toHaveBeenCalled();
      expect(mockAsyncStorage.setItem).toHaveBeenCalledWith(
        expect.stringContaining('sensor_data_'),
        expect.any(String)
      );
    });

    it('should clean up old sensor data from storage', async () => {
      const oldKeys = ['sensor_data_1234567890', 'sensor_data_1234567891'];
      const newKeys = ['sensor_data_' + Date.now()];

      mockAsyncStorage.getAllKeys.mockResolvedValue([...oldKeys, ...newKeys]);

      const service = iotService as any;
      service.handleSensorData(mockSensorData);

      // Wait for cleanup
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(mockAsyncStorage.multiRemove).toHaveBeenCalledWith(oldKeys);
    });
  });

  describe('Safety Threshold Monitoring', () => {
    it('should trigger safety alert when threshold exceeded', () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const service = iotService as any;

      // High acceleration data that exceeds threshold
      const highAccelData: SensorData = {
        timestamp: new Date(),
        accelerometer: { x: 20, y: 0, z: 0 }, // Total acceleration > 15
      };

      service.handleSensorData(highAccelData);

      expect(consoleSpy).toHaveBeenCalledWith(
        expect.stringContaining('Safety alert triggered')
      );

      consoleSpy.mockRestore();
    });

    it('should check different sensor types for thresholds', () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const service = iotService as any;

      // High gyroscope data
      const highGyroData: SensorData = {
        timestamp: new Date(),
        gyroscope: { x: 15, y: 0, z: 0 }, // Total rotation > 10
      };

      service.handleSensorData(highGyroData);

      expect(consoleSpy).toHaveBeenCalledWith(
        expect.stringContaining('Safety alert triggered')
      );

      consoleSpy.mockRestore();
    });

    it('should support different threshold operators', () => {
      const customThresholds: SafetyThreshold[] = [
        {
          sensor: 'barometer',
          threshold: 1000,
          operator: '<',
          severity: 'low',
          description: 'Low pressure test',
          action: 'Test action',
        },
      ];

      const service = iotService as any;
      service.safetyThresholds = customThresholds;

      const lowPressureData: SensorData = {
        timestamp: new Date(),
        barometer: { pressure: 950 }, // Below threshold
      };

      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();
      service.handleSensorData(lowPressureData);

      expect(consoleSpy).toHaveBeenCalledWith(
        expect.stringContaining('Safety alert triggered')
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Fall Detection', () => {
    it('should detect free fall conditions', () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const service = iotService as any;

      const freeFallData: SensorData = {
        timestamp: new Date(),
        accelerometer: { x: 0.5, y: 0.5, z: 0.5 }, // Low acceleration = free fall
        deviceMotion: {
          acceleration: { x: 0.5, y: 0.5, z: 0.5 },
          accelerationIncludingGravity: { x: 0.5, y: 0.5, z: 0.5 },
          rotation: { alpha: 0, beta: 0, gamma: 0 },
          rotationRate: { alpha: 0, beta: 0, gamma: 0 },
          orientation: 1,
        },
      };

      service.handleSensorData(freeFallData);

      expect(consoleSpy).toHaveBeenCalledWith(
        expect.stringContaining('Free fall detected')
      );

      consoleSpy.mockRestore();
    });

    it('should detect high impact conditions', () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const service = iotService as any;

      const highImpactData: SensorData = {
        timestamp: new Date(),
        accelerometer: { x: 30, y: 0, z: 0 }, // High acceleration = impact
        deviceMotion: {
          acceleration: { x: 30, y: 0, z: 0 },
          accelerationIncludingGravity: { x: 30, y: 0, z: 0 },
          rotation: { alpha: 0, beta: 0, gamma: 0 },
          rotationRate: { alpha: 0, beta: 0, gamma: 0 },
          orientation: 1,
        },
      };

      service.handleSensorData(highImpactData);

      expect(consoleSpy).toHaveBeenCalledWith(
        expect.stringContaining('High impact detected')
      );

      consoleSpy.mockRestore();
    });
  });

  describe('IoT Device Management', () => {
    it('should register new IoT device', async () => {
      const device = await iotService.registerIoTDevice(mockIoTDevice);

      expect(device).toMatchObject({
        ...mockIoTDevice,
        lastSeen: expect.any(Date),
      });

      expect(mockAsyncStorage.setItem).toHaveBeenCalledWith(
        'iot_devices',
        expect.any(String)
      );
    });

    it('should update IoT device status', async () => {
      // Register device first
      await iotService.registerIoTDevice(mockIoTDevice);

      // Update device
      await iotService.updateIoTDevice('device-001', {
        status: 'maintenance',
        batteryLevel: 90,
      });

      const devices = iotService.getIoTDevices();
      const updatedDevice = devices.find(d => d.id === 'device-001');

      expect(updatedDevice?.status).toBe('maintenance');
      expect(updatedDevice?.batteryLevel).toBe(90);
      expect(updatedDevice?.lastSeen).toEqual(expect.any(Date));
    });

    it('should return list of IoT devices', async () => {
      await iotService.registerIoTDevice(mockIoTDevice);

      const devices = iotService.getIoTDevices();

      expect(devices).toHaveLength(1);
      expect(devices[0]).toMatchObject(mockIoTDevice);
    });
  });

  describe('Environmental Data Processing', () => {
    it('should receive and store environmental data', async () => {
      await iotService.receiveEnvironmentalData(mockEnvironmentalData);

      const environmentalHistory = iotService.getEnvironmentalDataHistory(1);
      expect(environmentalHistory).toHaveLength(1);
      expect(environmentalHistory[0]).toEqual(mockEnvironmentalData);
    });

    it('should limit stored environmental data', async () => {
      // Add more than 100 data points
      for (let i = 0; i < 110; i++) {
        await iotService.receiveEnvironmentalData({
          ...mockEnvironmentalData,
          timestamp: new Date(Date.now() + i * 1000),
        });
      }

      const environmentalHistory = iotService.getEnvironmentalDataHistory(100);
      expect(environmentalHistory.length).toBeLessThanOrEqual(100);
    });

    it('should analyze environmental conditions', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      // Extreme temperature
      await iotService.receiveEnvironmentalData({
        ...mockEnvironmentalData,
        temperature: 40, // Very hot
      });

      expect(consoleSpy).toHaveBeenCalledWith(
        expect.stringContaining('Extreme temperature detected')
      );

      // Poor air quality
      await iotService.receiveEnvironmentalData({
        ...mockEnvironmentalData,
        airQuality: 200, // Poor quality
      });

      expect(consoleSpy).toHaveBeenCalledWith(
        expect.stringContaining('Poor air quality detected')
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Equipment Sensor Monitoring', () => {
    it('should receive and store equipment sensor data', async () => {
      await iotService.receiveEquipmentSensorData(mockEquipmentSensor);

      const equipmentData = iotService.getEquipmentSensorData('excavator-001', 1);
      expect(equipmentData).toHaveLength(1);
      expect(equipmentData[0]).toEqual(mockEquipmentSensor);
    });

    it('should limit stored equipment sensor data per device', async () => {
      // Add more than 500 data points for same equipment
      for (let i = 0; i < 510; i++) {
        await iotService.receiveEquipmentSensorData({
          ...mockEquipmentSensor,
          timestamp: new Date(Date.now() + i * 1000),
        });
      }

      const equipmentData = iotService.getEquipmentSensorData('excavator-001', 100);
      expect(equipmentData.length).toBeLessThanOrEqual(500);
    });

    it('should analyze equipment condition', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      // Critical condition
      await iotService.receiveEquipmentSensorData({
        ...mockEquipmentSensor,
        value: 4.0, // Above critical threshold
      });

      expect(consoleSpy).toHaveBeenCalledWith(
        expect.stringContaining('Critical equipment condition')
      );

      consoleSpy.mockRestore();
    });

    it('should filter equipment sensor data by time range', async () => {
      const oldTimestamp = new Date(Date.now() - 25 * 60 * 60 * 1000); // 25 hours ago
      const recentTimestamp = new Date(Date.now() - 1 * 60 * 60 * 1000); // 1 hour ago

      // Add old data
      await iotService.receiveEquipmentSensorData({
        ...mockEquipmentSensor,
        timestamp: oldTimestamp,
      });

      // Add recent data
      await iotService.receiveEquipmentSensorData({
        ...mockEquipmentSensor,
        timestamp: recentTimestamp,
      });

      const recentData = iotService.getEquipmentSensorData('excavator-001', 2); // Last 2 hours
      expect(recentData).toHaveLength(1);
      expect(recentData[0].timestamp).toEqual(recentTimestamp);
    });
  });

  describe('Safety Insights Generation', () => {
    it('should generate safety insights from sensor data', () => {
      // Add some sensor data
      const service = iotService as any;
      service.handleSensorData(mockSensorData);

      const insights = iotService.generateSafetyInsights();

      expect(insights).toHaveProperty('fallRisk');
      expect(insights).toHaveProperty('environmentalRisk');
      expect(insights).toHaveProperty('equipmentRisk');
      expect(insights).toHaveProperty('recommendations');
      expect(Array.isArray(insights.recommendations)).toBe(true);
    });

    it('should analyze fall risk based on sensor data', () => {
      const service = iotService as any;

      // Add high acceleration data (high risk)
      for (let i = 0; i < 20; i++) {
        service.handleSensorData({
          timestamp: new Date(),
          accelerometer: { x: 20, y: 0, z: 0 }, // High acceleration
        });
      }

      const insights = iotService.generateSafetyInsights();
      expect(insights.fallRisk).toBe('high');
    });

    it('should analyze environmental risk', async () => {
      // Add extreme environmental conditions
      await iotService.receiveEnvironmentalData({
        ...mockEnvironmentalData,
        temperature: 40,
        airQuality: 200,
      });

      const insights = iotService.generateSafetyInsights();
      expect(insights.environmentalRisk).toBe('high');
    });

    it('should analyze equipment risk', async () => {
      // Add critical equipment sensor data
      await iotService.receiveEquipmentSensorData({
        ...mockEquipmentSensor,
        value: 4.0, // Above critical threshold
      });

      const insights = iotService.generateSafetyInsights();
      expect(insights.equipmentRisk).toBe('high');
    });

    it('should generate appropriate recommendations', () => {
      const service = iotService as any;

      // Simulate high fall risk
      for (let i = 0; i < 20; i++) {
        service.handleSensorData({
          timestamp: new Date(),
          accelerometer: { x: 20, y: 0, z: 0 },
        });
      }

      const insights = iotService.generateSafetyInsights();
      expect(insights.recommendations).toContain(
        'Implement additional fall prevention measures'
      );
    });
  });

  describe('Data Export', () => {
    it('should export sensor data in JSON format', async () => {
      const service = iotService as any;
      service.handleSensorData(mockSensorData);

      const exportedData = await iotService.exportSensorData('json');

      expect(typeof exportedData).toBe('string');

      const parsedData = JSON.parse(exportedData);
      expect(parsedData).toHaveProperty('sensorData');
      expect(parsedData).toHaveProperty('environmentalData');
      expect(parsedData).toHaveProperty('equipmentSensors');
      expect(parsedData).toHaveProperty('iotDevices');
      expect(parsedData).toHaveProperty('exportedAt');
    });

    it('should export sensor data in CSV format', async () => {
      const service = iotService as any;
      service.handleSensorData(mockSensorData);

      const exportedData = await iotService.exportSensorData('csv');

      expect(typeof exportedData).toBe('string');
      expect(exportedData).toContain('timestamp,sensor,value,unit');
    });

    it('should handle empty data export', async () => {
      const exportedData = await iotService.exportSensorData('json');

      const parsedData = JSON.parse(exportedData);
      expect(parsedData.sensorData).toEqual([]);
      expect(parsedData.environmentalData).toEqual([]);
      expect(parsedData.equipmentSensors).toEqual([]);
      expect(parsedData.iotDevices).toEqual([]);
    });
  });

  describe('Monitoring Status', () => {
    it('should return correct monitoring status when active', async () => {
      await iotService.startSensorMonitoring();

      const status = iotService.getMonitoringStatus();

      expect(status.isMonitoring).toBe(true);
      expect(status.activeSensors).toContain('accelerometer');
      expect(status.activeSensors).toContain('gyroscope');
      expect(status.dataPoints).toBeGreaterThanOrEqual(0);
    });

    it('should return correct monitoring status when inactive', () => {
      const status = iotService.getMonitoringStatus();

      expect(status.isMonitoring).toBe(false);
      expect(status.activeSensors).toEqual([]);
      expect(status.dataPoints).toBe(0);
      expect(status.lastUpdate).toBeNull();
    });

    it('should track data points and last update', async () => {
      await iotService.startSensorMonitoring();

      const service = iotService as any;
      service.handleSensorData(mockSensorData);

      const status = iotService.getMonitoringStatus();

      expect(status.dataPoints).toBeGreaterThan(0);
      expect(status.lastUpdate).toEqual(mockSensorData.timestamp);
    });
  });

  describe('Safety Threshold Management', () => {
    it('should update safety threshold', async () => {
      const originalThresholds = iotService.getSafetyThresholds();
      const originalThreshold = originalThresholds[0].threshold;

      await iotService.updateSafetyThreshold('Sudden impact detected', {
        threshold: 20,
      });

      const updatedThresholds = iotService.getSafetyThresholds();
      expect(updatedThresholds[0].threshold).toBe(20);

      expect(mockAsyncStorage.setItem).toHaveBeenCalledWith(
        'safety_thresholds',
        expect.any(String)
      );
    });

    it('should handle invalid threshold updates', async () => {
      const originalThresholds = iotService.getSafetyThresholds();

      await iotService.updateSafetyThreshold('nonexistent', {
        threshold: 20,
      });

      const updatedThresholds = iotService.getSafetyThresholds();
      expect(updatedThresholds).toEqual(originalThresholds);
    });
  });

  describe('Service Lifecycle', () => {
    it('should destroy service properly', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      await iotService.startSensorMonitoring();
      await iotService.destroy();

      expect(consoleSpy).toHaveBeenCalledWith('IoT sensor monitoring stopped');
      expect(consoleSpy).toHaveBeenCalledWith('IoT service destroyed');

      consoleSpy.mockRestore();
    });

    it('should clean up all data on destroy', async () => {
      const service = iotService as any;

      // Add some data
      service.handleSensorData(mockSensorData);
      await iotService.receiveEnvironmentalData(mockEnvironmentalData);
      await iotService.receiveEquipmentSensorData(mockEquipmentSensor);

      await iotService.destroy();

      expect(service.sensorData).toEqual([]);
      expect(service.environmentalData).toEqual([]);
      expect(service.equipmentSensors).toEqual([]);
    });
  });

  describe('Error Handling', () => {
    it('should handle AsyncStorage errors gracefully', async () => {
      mockAsyncStorage.setItem.mockRejectedValue(new Error('Storage full'));

      await iotService.registerIoTDevice(mockIoTDevice);

      // Should still work despite storage error
      const devices = iotService.getIoTDevices();
      expect(devices).toHaveLength(1);
    });

    it('should handle sensor subscription errors', async () => {
      mockAccelerometer.addListener.mockImplementation(() => {
        throw new Error('Sensor not available');
      });

      const result = await iotService.startSensorMonitoring();

      expect(result).toBe(false);
    });

    it('should handle invalid sensor data', () => {
      const service = iotService as any;

      const invalidData: SensorData = {
        timestamp: new Date(),
        // Missing required accelerometer data
      };

      // Should not crash
      expect(() => service.handleSensorData(invalidData)).not.toThrow();
    });
  });

  describe('Performance and Memory Management', () => {
    it('should handle large volumes of sensor data efficiently', () => {
      const service = iotService as any;

      const startTime = Date.now();

      // Process 1000 sensor readings
      for (let i = 0; i < 1000; i++) {
        service.handleSensorData({
          ...mockSensorData,
          timestamp: new Date(Date.now() + i),
        });
      }

      const endTime = Date.now();
      const processingTime = endTime - startTime;

      expect(processingTime).toBeLessThan(2000); // Should process within 2 seconds
      expect(service.sensorData.length).toBeLessThanOrEqual(1000);
    });

    it('should efficiently filter historical data', () => {
      const service = iotService as any;

      // Add data spanning multiple hours
      for (let i = 0; i < 100; i++) {
        service.handleSensorData({
          ...mockSensorData,
          timestamp: new Date(Date.now() - i * 60 * 60 * 1000), // Each hour apart
        });
      }

      const startTime = Date.now();

      const recentData = iotService.getSensorDataHistory(2); // Last 2 hours

      const endTime = Date.now();
      const queryTime = endTime - startTime;

      expect(queryTime).toBeLessThan(100); // Should query quickly
      expect(recentData.length).toBeLessThanOrEqual(2);
    });

    it('should manage memory usage with data cleanup', async () => {
      const service = iotService as any;

      // Simulate old data cleanup
      const oldKeys = [];
      for (let i = 0; i < 100; i++) {
        oldKeys.push(`sensor_data_${Date.now() - 25 * 60 * 60 * 1000 - i}`);
      }

      mockAsyncStorage.getAllKeys.mockResolvedValue(oldKeys);

      service.handleSensorData(mockSensorData);

      // Wait for cleanup
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(mockAsyncStorage.multiRemove).toHaveBeenCalledWith(oldKeys);
    });
  });
});
