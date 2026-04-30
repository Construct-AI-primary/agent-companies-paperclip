import { DeviceMotion } from 'expo-sensors';
import { Accelerometer } from 'expo-sensors';
import { Gyroscope } from 'expo-sensors';
import { Magnetometer } from 'expo-sensors';
import { Barometer } from 'expo-sensors';
import { Pedometer } from 'expo-sensors';
import AsyncStorage from '@react-native-async-storage/async-storage';

export interface SensorData {
  timestamp: Date;
  accelerometer?: {
    x: number;
    y: number;
    z: number;
  };
  gyroscope?: {
    x: number;
    y: number;
    z: number;
  };
  magnetometer?: {
    x: number;
    y: number;
    z: number;
  };
  barometer?: {
    pressure: number;
    relativeAltitude?: number;
  };
  deviceMotion?: {
    acceleration: { x: number; y: number; z: number } | null;
    accelerationIncludingGravity: { x: number; y: number; z: number } | null;
    rotation: { alpha: number; beta: number; gamma: number } | null;
    rotationRate: { alpha: number; beta: number; gamma: number } | null;
    orientation: number;
  };
  pedometer?: {
    steps: number;
    distance: number;
  };
}

export interface SafetyThreshold {
  sensor: keyof SensorData;
  threshold: number;
  operator: '>' | '<' | '>=' | '<=' | '==' | '!=';
  severity: 'low' | 'medium' | 'high' | 'critical';
  description: string;
  action: string;
}

export interface IoTDevice {
  id: string;
  name: string;
  type: 'wearable' | 'environmental' | 'equipment' | 'gateway';
  sensors: string[];
  location?: {
    latitude: number;
    longitude: number;
  };
  status: 'online' | 'offline' | 'maintenance';
  lastSeen: Date;
  batteryLevel?: number;
  firmwareVersion?: string;
}

export interface EnvironmentalData {
  temperature: number;
  humidity: number;
  airQuality: number;
  noiseLevel: number;
  lightLevel: number;
  timestamp: Date;
  location?: {
    latitude: number;
    longitude: number;
  };
}

export interface EquipmentSensor {
  equipmentId: string;
  sensorType: 'vibration' | 'temperature' | 'pressure' | 'current' | 'voltage';
  value: number;
  unit: string;
  threshold: {
    warning: number;
    critical: number;
  };
  timestamp: Date;
  status: 'normal' | 'warning' | 'critical';
}

class IoTService {
  private isMonitoring: boolean = false;
  private sensorSubscriptions: any[] = [];
  private sensorData: SensorData[] = [];
  private safetyThresholds: SafetyThreshold[] = [];
  private iotDevices: IoTDevice[] = [];
  private environmentalData: EnvironmentalData[] = [];
  private equipmentSensors: EquipmentSensor[] = [];

  constructor() {
    this.initializeSafetyThresholds();
    this.loadStoredData();
  }

  private initializeSafetyThresholds() {
    this.safetyThresholds = [
      {
        sensor: 'accelerometer',
        threshold: 15, // m/s²
        operator: '>',
        severity: 'high',
        description: 'Sudden impact detected',
        action: 'Check for fall or collision'
      },
      {
        sensor: 'gyroscope',
        threshold: 10, // rad/s
        operator: '>',
        severity: 'medium',
        description: 'Rapid rotation detected',
        action: 'Monitor for dizziness or disorientation'
      },
      {
        sensor: 'barometer',
        threshold: 1013.25, // hPa - standard pressure
        operator: '<',
        severity: 'low',
        description: 'Low air pressure detected',
        action: 'Check for altitude sickness risk'
      }
    ];
  }

  private async loadStoredData() {
    try {
      const storedThresholds = await AsyncStorage.getItem('safety_thresholds');
      if (storedThresholds) {
        this.safetyThresholds = JSON.parse(storedThresholds);
      }

      const storedDevices = await AsyncStorage.getItem('iot_devices');
      if (storedDevices) {
        this.iotDevices = JSON.parse(storedDevices);
      }
    } catch (error) {
      console.error('Failed to load stored IoT data:', error);
    }
  }

  private async saveStoredData() {
    try {
      await AsyncStorage.setItem('safety_thresholds', JSON.stringify(this.safetyThresholds));
      await AsyncStorage.setItem('iot_devices', JSON.stringify(this.iotDevices));
    } catch (error) {
      console.error('Failed to save IoT data:', error);
    }
  }

  // Start comprehensive sensor monitoring
  async startSensorMonitoring(updateInterval: number = 1000) {
    try {
      if (this.isMonitoring) {
        await this.stopSensorMonitoring();
      }

      // Start accelerometer monitoring
      const accelSubscription = Accelerometer.addListener((data) => {
        this.handleSensorData({
          timestamp: new Date(),
          accelerometer: data
        });
      });
      await Accelerometer.setUpdateInterval(updateInterval);
      this.sensorSubscriptions.push(accelSubscription);

      // Start gyroscope monitoring
      const gyroSubscription = Gyroscope.addListener((data) => {
        this.handleSensorData({
          timestamp: new Date(),
          gyroscope: data
        });
      });
      await Gyroscope.setUpdateInterval(updateInterval);
      this.sensorSubscriptions.push(gyroSubscription);

      // Start magnetometer monitoring
      const magnetSubscription = Magnetometer.addListener((data) => {
        this.handleSensorData({
          timestamp: new Date(),
          magnetometer: data
        });
      });
      await Magnetometer.setUpdateInterval(updateInterval);
      this.sensorSubscriptions.push(magnetSubscription);

      // Start barometer monitoring
      const barometerSubscription = Barometer.addListener((data) => {
        this.handleSensorData({
          timestamp: new Date(),
          barometer: data
        });
      });
      await Barometer.setUpdateInterval(updateInterval);
      this.sensorSubscriptions.push(barometerSubscription);

      // Start device motion monitoring
      const motionSubscription = DeviceMotion.addListener((data) => {
        this.handleSensorData({
          timestamp: new Date(),
          deviceMotion: data
        });
      });
      await DeviceMotion.setUpdateInterval(updateInterval);
      this.sensorSubscriptions.push(motionSubscription);

      this.isMonitoring = true;
      console.log('IoT sensor monitoring started');

      return true;
    } catch (error) {
      console.error('Failed to start sensor monitoring:', error);
      return false;
    }
  }

  // Stop sensor monitoring
  async stopSensorMonitoring() {
    try {
      this.sensorSubscriptions.forEach(subscription => {
        subscription?.remove();
      });
      this.sensorSubscriptions = [];
      this.isMonitoring = false;
      console.log('IoT sensor monitoring stopped');
    } catch (error) {
      console.error('Failed to stop sensor monitoring:', error);
    }
  }

  // Handle incoming sensor data
  private handleSensorData(data: SensorData) {
    // Store sensor data
    this.sensorData.push(data);

    // Keep only last 1000 readings
    if (this.sensorData.length > 1000) {
      this.sensorData = this.sensorData.slice(-1000);
    }

    // Check safety thresholds
    this.checkSafetyThresholds(data);

    // Analyze patterns for fall detection
    this.analyzeFallDetection(data);

    // Store in local database for offline analysis
    this.storeSensorData(data);
  }

  // Check safety thresholds
  private checkSafetyThresholds(data: SensorData) {
    for (const threshold of this.safetyThresholds) {
      const sensorValue = this.getSensorValue(data, threshold.sensor);
      if (sensorValue !== null && this.checkThreshold(sensorValue, threshold)) {
        this.triggerSafetyAlert(threshold, sensorValue);
      }
    }
  }

  private getSensorValue(data: SensorData, sensor: keyof SensorData): number | null {
    switch (sensor) {
      case 'accelerometer':
        if (data.accelerometer) {
          return Math.sqrt(
            data.accelerometer.x ** 2 +
            data.accelerometer.y ** 2 +
            data.accelerometer.z ** 2
          );
        }
        break;
      case 'gyroscope':
        if (data.gyroscope) {
          return Math.sqrt(
            data.gyroscope.x ** 2 +
            data.gyroscope.y ** 2 +
            data.gyroscope.z ** 2
          );
        }
        break;
      case 'barometer':
        return data.barometer?.pressure || null;
    }
    return null;
  }

  private checkThreshold(value: number, threshold: SafetyThreshold): boolean {
    switch (threshold.operator) {
      case '>': return value > threshold.threshold;
      case '<': return value < threshold.threshold;
      case '>=': return value >= threshold.threshold;
      case '<=': return value <= threshold.threshold;
      case '==': return value === threshold.threshold;
      case '!=': return value !== threshold.threshold;
      default: return false;
    }
  }

  private triggerSafetyAlert(threshold: SafetyThreshold, value: number) {
    console.log(`Safety alert triggered: ${threshold.description} (Value: ${value})`);

    // Here you would integrate with the notification service
    // notificationService.notifyEmergency(incident, threshold.action);
  }

  // Fall detection algorithm
  private analyzeFallDetection(data: SensorData) {
    if (!data.accelerometer || !data.deviceMotion) return;

    const accel = data.accelerometer;
    const motion = data.deviceMotion;

    // Simple fall detection based on acceleration patterns
    const totalAccel = Math.sqrt(accel.x ** 2 + accel.y ** 2 + accel.z ** 2);

    // Check for free fall (low acceleration)
    if (totalAccel < 2) {
      console.log('Free fall detected - potential fall risk');
      // Trigger fall prevention alert
    }

    // Check for impact (high acceleration)
    if (totalAccel > 25) {
      console.log('High impact detected - possible fall or collision');
      // Trigger impact alert
    }
  }

  // Store sensor data locally
  private async storeSensorData(data: SensorData) {
    try {
      // Store in AsyncStorage for offline analysis
      const key = `sensor_data_${Date.now()}`;
      await AsyncStorage.setItem(key, JSON.stringify(data));

      // Clean up old data (keep last 24 hours)
      const oneDayAgo = Date.now() - 24 * 60 * 60 * 1000;
      const keys = await AsyncStorage.getAllKeys();
      const oldKeys = keys.filter(k =>
        k.startsWith('sensor_data_') &&
        parseInt(k.split('_')[2]) < oneDayAgo
      );

      await AsyncStorage.multiRemove(oldKeys);
    } catch (error) {
      console.error('Failed to store sensor data:', error);
    }
  }

  // Register IoT device
  async registerIoTDevice(device: Omit<IoTDevice, 'lastSeen'>) {
    const newDevice: IoTDevice = {
      ...device,
      lastSeen: new Date()
    };

    this.iotDevices.push(newDevice);
    await this.saveStoredData();

    console.log('IoT device registered:', device.name);
    return newDevice;
  }

  // Update IoT device status
  async updateIoTDevice(deviceId: string, updates: Partial<IoTDevice>) {
    const deviceIndex = this.iotDevices.findIndex(d => d.id === deviceId);
    if (deviceIndex !== -1) {
      this.iotDevices[deviceIndex] = {
        ...this.iotDevices[deviceIndex],
        ...updates,
        lastSeen: new Date()
      };
      await this.saveStoredData();
    }
  }

  // Receive environmental data from IoT devices
  async receiveEnvironmentalData(data: EnvironmentalData) {
    this.environmentalData.push(data);

    // Keep only last 100 readings
    if (this.environmentalData.length > 100) {
      this.environmentalData = this.environmentalData.slice(-100);
    }

    // Analyze environmental conditions
    this.analyzeEnvironmentalConditions(data);

    console.log('Environmental data received:', data);
  }

  // Analyze environmental conditions for safety
  private analyzeEnvironmentalConditions(data: EnvironmentalData) {
    // Check temperature extremes
    if (data.temperature > 35 || data.temperature < 0) {
      console.log('Extreme temperature detected - heat/cold stress risk');
    }

    // Check air quality
    if (data.airQuality > 150) {
      console.log('Poor air quality detected - respiratory risk');
    }

    // Check noise levels
    if (data.noiseLevel > 85) {
      console.log('High noise level detected - hearing protection required');
    }
  }

  // Receive equipment sensor data
  async receiveEquipmentSensorData(sensorData: EquipmentSensor) {
    this.equipmentSensors.push(sensorData);

    // Keep only last 500 readings per equipment
    const equipmentSensors = this.equipmentSensors.filter(s => s.equipmentId === sensorData.equipmentId);
    if (equipmentSensors.length > 500) {
      this.equipmentSensors = this.equipmentSensors.filter(s => s.equipmentId !== sensorData.equipmentId);
      this.equipmentSensors.push(...equipmentSensors.slice(-500));
    }

    // Analyze equipment condition
    this.analyzeEquipmentCondition(sensorData);

    console.log('Equipment sensor data received:', sensorData);
  }

  // Analyze equipment condition
  private analyzeEquipmentCondition(sensorData: EquipmentSensor) {
    if (sensorData.value >= sensorData.threshold.critical) {
      console.log(`Critical equipment condition: ${sensorData.equipmentId} - ${sensorData.sensorType}`);
      // Trigger maintenance alert
    } else if (sensorData.value >= sensorData.threshold.warning) {
      console.log(`Warning equipment condition: ${sensorData.equipmentId} - ${sensorData.sensorType}`);
      // Trigger maintenance reminder
    }
  }

  // Get sensor data history
  getSensorDataHistory(hours: number = 24): SensorData[] {
    const cutoffTime = Date.now() - (hours * 60 * 60 * 1000);
    return this.sensorData.filter(data => data.timestamp.getTime() > cutoffTime);
  }

  // Get environmental data history
  getEnvironmentalDataHistory(hours: number = 24): EnvironmentalData[] {
    const cutoffTime = Date.now() - (hours * 60 * 60 * 1000);
    return this.environmentalData.filter(data => data.timestamp.getTime() > cutoffTime);
  }

  // Get equipment sensor data
  getEquipmentSensorData(equipmentId: string, hours: number = 24): EquipmentSensor[] {
    const cutoffTime = Date.now() - (hours * 60 * 60 * 1000);
    return this.equipmentSensors.filter(sensor =>
      sensor.equipmentId === equipmentId &&
      sensor.timestamp.getTime() > cutoffTime
    );
  }

  // Get IoT devices
  getIoTDevices(): IoTDevice[] {
    return this.iotDevices;
  }

  // Get safety thresholds
  getSafetyThresholds(): SafetyThreshold[] {
    return this.safetyThresholds;
  }

  // Update safety threshold
  async updateSafetyThreshold(thresholdId: string, updates: Partial<SafetyThreshold>) {
    const index = this.safetyThresholds.findIndex(t => t === this.safetyThresholds.find(t => t.description === thresholdId));
    if (index !== -1) {
      this.safetyThresholds[index] = { ...this.safetyThresholds[index], ...updates };
      await this.saveStoredData();
    }
  }

  // Generate safety insights from sensor data
  generateSafetyInsights(): {
    fallRisk: 'low' | 'medium' | 'high';
    environmentalRisk: 'low' | 'medium' | 'high';
    equipmentRisk: 'low' | 'medium' | 'high';
    recommendations: string[];
  } {
    const recentSensorData = this.getSensorDataHistory(1); // Last hour
    const recentEnvironmentalData = this.getEnvironmentalDataHistory(1);
    const recentEquipmentData = this.equipmentSensors.slice(-50); // Last 50 readings

    // Analyze fall risk
    const fallRisk = this.analyzeFallRisk(recentSensorData);

    // Analyze environmental risk
    const environmentalRisk = this.analyzeEnvironmentalRisk(recentEnvironmentalData);

    // Analyze equipment risk
    const equipmentRisk = this.analyzeEquipmentRisk(recentEquipmentData);

    // Generate recommendations
    const recommendations = this.generateRecommendations(fallRisk, environmentalRisk, equipmentRisk);

    return {
      fallRisk,
      environmentalRisk,
      equipmentRisk,
      recommendations
    };
  }

  private analyzeFallRisk(sensorData: SensorData[]): 'low' | 'medium' | 'high' {
    if (sensorData.length === 0) return 'low';

    const highAccelCount = sensorData.filter(data =>
      data.accelerometer &&
      Math.sqrt(data.accelerometer.x ** 2 + data.accelerometer.y ** 2 + data.accelerometer.z ** 2) > 15
    ).length;

    const riskRatio = highAccelCount / sensorData.length;

    if (riskRatio > 0.1) return 'high';
    if (riskRatio > 0.05) return 'medium';
    return 'low';
  }

  private analyzeEnvironmentalRisk(envData: EnvironmentalData[]): 'low' | 'medium' | 'high' {
    if (envData.length === 0) return 'low';

    const extremeConditions = envData.filter(data =>
      data.temperature > 35 || data.temperature < 0 ||
      data.airQuality > 150 ||
      data.noiseLevel > 85
    ).length;

    const riskRatio = extremeConditions / envData.length;

    if (riskRatio > 0.3) return 'high';
    if (riskRatio > 0.1) return 'medium';
    return 'low';
  }

  private analyzeEquipmentRisk(equipmentData: EquipmentSensor[]): 'low' | 'medium' | 'high' {
    if (equipmentData.length === 0) return 'low';

    const criticalConditions = equipmentData.filter(data =>
      data.value >= data.threshold.critical
    ).length;

    const warningConditions = equipmentData.filter(data =>
      data.value >= data.threshold.warning
    ).length;

    if (criticalConditions > 0) return 'high';
    if (warningConditions > equipmentData.length * 0.2) return 'medium';
    return 'low';
  }

  private generateRecommendations(
    fallRisk: string,
    environmentalRisk: string,
    equipmentRisk: string
  ): string[] {
    const recommendations: string[] = [];

    if (fallRisk === 'high') {
      recommendations.push('Implement additional fall prevention measures');
      recommendations.push('Review and improve walking surfaces');
    }

    if (environmentalRisk === 'high') {
      recommendations.push('Monitor environmental conditions closely');
      recommendations.push('Provide appropriate PPE for extreme conditions');
    }

    if (equipmentRisk === 'high') {
      recommendations.push('Schedule immediate equipment maintenance');
      recommendations.push('Implement equipment monitoring protocols');
    }

    if (recommendations.length === 0) {
      recommendations.push('Continue current safety protocols');
    }

    return recommendations;
  }

  // Export sensor data
  async exportSensorData(format: 'json' | 'csv' = 'json'): Promise<string> {
    const data = {
      sensorData: this.sensorData,
      environmentalData: this.environmentalData,
      equipmentSensors: this.equipmentSensors,
      iotDevices: this.iotDevices,
      exportedAt: new Date().toISOString()
    };

    if (format === 'csv') {
      // Convert to CSV format
      return this.convertToCSV(data);
    }

    return JSON.stringify(data, null, 2);
  }

  private convertToCSV(data: any): string {
    // Simple CSV conversion for sensor data
    const headers = ['timestamp', 'sensor', 'value', 'unit'];
    const rows: string[] = [];

    // Add sensor data rows
    data.sensorData.forEach((item: SensorData) => {
      if (item.accelerometer) {
        rows.push(`${item.timestamp.toISOString()},accelerometer,${JSON.stringify(item.accelerometer)},m/s²`);
      }
      if (item.gyroscope) {
        rows.push(`${item.timestamp.toISOString()},gyroscope,${JSON.stringify(item.gyroscope)},rad/s`);
      }
      if (item.barometer) {
        rows.push(`${item.timestamp.toISOString()},barometer,${item.barometer.pressure},hPa`);
      }
    });

    return [headers.join(','), ...rows].join('\n');
  }

  // Get monitoring status
  getMonitoringStatus(): {
    isMonitoring: boolean;
    activeSensors: string[];
    dataPoints: number;
    lastUpdate: Date | null;
  } {
    const activeSensors: string[] = [];

    if (this.sensorSubscriptions.length > 0) {
      activeSensors.push('accelerometer', 'gyroscope', 'magnetometer', 'barometer', 'deviceMotion');
    }

    const lastUpdate = this.sensorData.length > 0 ?
      this.sensorData[this.sensorData.length - 1].timestamp : null;

    return {
      isMonitoring: this.isMonitoring,
      activeSensors,
      dataPoints: this.sensorData.length,
      lastUpdate
    };
  }

  // Cleanup
  async destroy() {
    await this.stopSensorMonitoring();
    this.sensorData = [];
    this.environmentalData = [];
    this.equipmentSensors = [];
    console.log('IoT service destroyed');
  }
}

// Export singleton instance
export const iotService = new IoTService();
export default iotService;
