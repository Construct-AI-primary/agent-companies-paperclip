/**
 * Notification Service Unit Tests
 *
 * Tests the notification service functionality including push notifications,
 * scheduling, incident alerts, maintenance reminders, and emergency notifications.
 */

import { notificationService, NotificationData, ScheduledNotification } from '../notificationService';
import * as Notifications from 'expo-notifications';
import * as Device from 'expo-device';
import Constants from 'expo-constants';
import { Platform } from 'react-native';

// Mock external dependencies
jest.mock('expo-notifications');
jest.mock('expo-device');
jest.mock('expo-constants');
jest.mock('react-native', () => ({
  Platform: {
    OS: 'ios',
  },
}));

describe('NotificationService', () => {
  const mockNotifications = Notifications as jest.Mocked<typeof Notifications>;
  const mockDevice = Device as jest.Mocked<typeof Device>;
  const mockConstants = Constants as jest.Mocked<typeof Constants>;

  // Mock notification data
  const mockNotificationData: NotificationData = {
    type: 'incident',
    title: 'Test Notification',
    message: 'This is a test notification',
    data: { testId: '123' },
    priority: 'high',
  };

  const mockIncident = {
    id: 'incident-001',
    incidentType: 'accident',
    severity: 'high' as const,
    description: 'Worker slipped on wet floor',
    reportedAt: '2024-01-15T10:00:00Z',
    status: 'investigating' as const,
    location: { latitude: -26.2041, longitude: 28.0473 },
    photos: [],
    videos: [],
    synced: false,
  };

  const mockHazard = {
    id: 'hazard-001',
    hazardType: 'chemical',
    riskLevel: 'high' as const,
    description: 'Spilled hazardous chemicals',
    status: 'active' as const,
    location: { latitude: -26.2041, longitude: 28.0473 },
    synced: false,
  };

  beforeEach(() => {
    jest.clearAllMocks();

    // Setup default mocks
    Object.defineProperty(mockDevice, 'isDevice', { value: true, writable: true });
    mockNotifications.getPermissionsAsync.mockResolvedValue({
      status: 'granted' as any,
      granted: true,
      canAskAgain: true,
      expires: 'never',
    });
    mockNotifications.requestPermissionsAsync.mockResolvedValue({
      status: 'granted' as any,
      granted: true,
      canAskAgain: true,
      expires: 'never',
    });
    mockNotifications.scheduleNotificationAsync.mockResolvedValue('notification-id-123');
    mockNotifications.cancelScheduledNotificationAsync.mockResolvedValue(undefined);
    mockNotifications.cancelAllScheduledNotificationsAsync.mockResolvedValue(undefined);
    mockNotifications.getAllScheduledNotificationsAsync.mockResolvedValue([]);
    mockNotifications.getExpoPushTokenAsync.mockResolvedValue({
      type: 'expo' as any,
      data: 'ExponentPushToken[xxxxxxxxxxxxxxxxxxxxxx]',
    });
    mockNotifications.setNotificationChannelAsync.mockResolvedValue(null as any);
    mockNotifications.setNotificationHandler.mockImplementation(() => {});
  });

  describe('Initialization', () => {
    it('should initialize notifications on device', async () => {
      // Reinitialize service to trigger initialization
      const newService = new (notificationService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(mockNotifications.setNotificationHandler).toHaveBeenCalled();
      expect(mockNotifications.getPermissionsAsync).toHaveBeenCalled();
      expect(mockNotifications.getExpoPushTokenAsync).toHaveBeenCalled();
    });

    it('should handle permission denial', async () => {
      mockNotifications.getPermissionsAsync.mockResolvedValueOnce({
        status: 'denied' as any,
        granted: false,
        canAskAgain: true,
        expires: 'never',
      });

      const consoleSpy = jest.spyOn(console, 'warn').mockImplementation();

      const newService = new (notificationService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(consoleSpy).toHaveBeenCalledWith('Failed to get push notification permissions');

      consoleSpy.mockRestore();
    });

    it('should request permissions when not granted', async () => {
      mockNotifications.getPermissionsAsync.mockResolvedValueOnce({
        status: 'denied' as any,
        granted: false,
        canAskAgain: true,
        expires: 'never',
      });

      const newService = new (notificationService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(mockNotifications.requestPermissionsAsync).toHaveBeenCalled();
    });

    it('should set up Android notification channel', async () => {
      // Mock Android platform
      const originalOS = Platform.OS;
      (Platform as any).OS = 'android';

      const newService = new (notificationService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(mockNotifications.setNotificationChannelAsync).toHaveBeenCalledWith('default', {
        name: 'Default',
        importance: Notifications.AndroidImportance.MAX,
        vibrationPattern: [0, 250, 250, 250],
        lightColor: '#FF231F7C',
      });

      // Restore original platform
      (Platform as any).OS = originalOS;
    });

    it('should handle initialization errors', async () => {
      mockNotifications.getPermissionsAsync.mockRejectedValueOnce(
        new Error('Permission system error')
      );

      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      const newService = new (notificationService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to initialize notifications:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });

    it('should skip initialization on simulator', async () => {
      mockDevice.isDevice = false;

      const newService = new (notificationService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(mockNotifications.getPermissionsAsync).not.toHaveBeenCalled();
    });
  });

  describe('Sending Notifications', () => {
    it('should send immediate notification', async () => {
      const notificationId = await notificationService.sendNotification(mockNotificationData);

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: {
          title: mockNotificationData.title,
          body: mockNotificationData.message,
          data: mockNotificationData.data,
          sound: 'default', // Critical priority gets sound
        },
        trigger: null,
      });
    });

    it('should handle non-critical priority notifications', async () => {
      const lowPriorityData = { ...mockNotificationData, priority: 'low' as const };

      await notificationService.sendNotification(lowPriorityData);

      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: expect.objectContaining({
          sound: undefined, // Non-critical doesn't get sound
        }),
        trigger: null,
      });
    });

    it('should warn when notifications not initialized', async () => {
      const service = notificationService as any;
      service.isInitialized = false;

      const consoleSpy = jest.spyOn(console, 'warn').mockImplementation();

      await notificationService.sendNotification(mockNotificationData);

      expect(consoleSpy).toHaveBeenCalledWith('Notifications not initialized');

      consoleSpy.mockRestore();
    });

    it('should handle notification sending errors', async () => {
      mockNotifications.scheduleNotificationAsync.mockRejectedValueOnce(
        new Error('Notification failed')
      );

      await expect(notificationService.sendNotification(mockNotificationData))
        .rejects.toThrow('Notification failed');
    });
  });

  describe('Scheduling Notifications', () => {
    it('should schedule future notification', async () => {
      const delayInSeconds = 3600; // 1 hour

      const notificationId = await notificationService.scheduleNotification(
        mockNotificationData,
        delayInSeconds
      );

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: {
          title: mockNotificationData.title,
          body: mockNotificationData.message,
          data: mockNotificationData.data,
        },
        trigger: {
          type: Notifications.SchedulableTriggerInputTypes.TIME_INTERVAL,
          seconds: delayInSeconds,
          repeats: false,
        },
      });
    });

    it('should track scheduled notifications', async () => {
      await notificationService.scheduleNotification(mockNotificationData, 3600);

      const service = notificationService as any;
      expect(service.scheduledNotifications).toHaveLength(1);
      expect(service.scheduledNotifications[0]).toMatchObject({
        id: 'notification-id-123',
        type: mockNotificationData.type,
        data: mockNotificationData,
      });
      expect(service.scheduledNotifications[0].scheduledTime).toBeInstanceOf(Date);
    });

    it('should warn when scheduling notifications not initialized', async () => {
      const service = notificationService as any;
      service.isInitialized = false;

      const consoleSpy = jest.spyOn(console, 'warn').mockImplementation();

      await notificationService.scheduleNotification(mockNotificationData, 3600);

      expect(consoleSpy).toHaveBeenCalledWith('Notifications not initialized');

      consoleSpy.mockRestore();
    });
  });

  describe('Canceling Notifications', () => {
    it('should cancel specific notification', async () => {
      const notificationId = 'test-notification-id';

      await notificationService.cancelNotification(notificationId);

      expect(mockNotifications.cancelScheduledNotificationAsync).toHaveBeenCalledWith(notificationId);
    });

    it('should remove from scheduled notifications list', async () => {
      const service = notificationService as any;

      // Add a scheduled notification
      service.scheduledNotifications = [
        { id: 'test-id', type: 'test', scheduledTime: new Date(), data: mockNotificationData },
      ];

      await notificationService.cancelNotification('test-id');

      expect(service.scheduledNotifications).toHaveLength(0);
    });

    it('should cancel all notifications', async () => {
      const service = notificationService as any;

      // Add multiple scheduled notifications
      service.scheduledNotifications = [
        { id: 'id1', type: 'test', scheduledTime: new Date(), data: mockNotificationData },
        { id: 'id2', type: 'test', scheduledTime: new Date(), data: mockNotificationData },
      ];

      await notificationService.cancelAllNotifications();

      expect(mockNotifications.cancelAllScheduledNotificationsAsync).toHaveBeenCalled();
      expect(service.scheduledNotifications).toEqual([]);
    });

    it('should handle cancellation errors gracefully', async () => {
      mockNotifications.cancelScheduledNotificationAsync.mockRejectedValueOnce(
        new Error('Cancellation failed')
      );

      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      await notificationService.cancelNotification('test-id');

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to cancel notification:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Incident Notifications', () => {
    it('should send new incident notification', async () => {
      const notificationId = await notificationService.notifyNewIncident(mockIncident);

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: expect.objectContaining({
          title: 'New Safety Incident',
          body: expect.stringContaining('accident'),
          data: { incidentId: mockIncident.id },
        }),
        trigger: null,
      });
    });

    it('should set correct priority for incident severity', async () => {
      const criticalIncident = { ...mockIncident, severity: 'critical' as const };
      const highIncident = { ...mockIncident, severity: 'high' as const };
      const mediumIncident = { ...mockIncident, severity: 'medium' as const };

      await notificationService.notifyNewIncident(criticalIncident);
      await notificationService.notifyNewIncident(highIncident);
      await notificationService.notifyNewIncident(mediumIncident);

      const calls = mockNotifications.scheduleNotificationAsync.mock.calls;

      // Critical should have sound
      expect(calls[0][0].content.sound).toBe('default');
      // High should have sound
      expect(calls[1][0].content.sound).toBe('default');
      // Medium should not have sound
      expect(calls[2][0].content.sound).toBeUndefined();
    });

    it('should truncate long incident descriptions', async () => {
      const longDescription = 'A'.repeat(100);
      const longIncident = { ...mockIncident, description: longDescription };

      await notificationService.notifyNewIncident(longIncident);

      const call = mockNotifications.scheduleNotificationAsync.mock.calls[0][0];
      expect(call.content.body.length).toBeLessThan(60); // Should be truncated
      expect(call.content.body).toContain('...');
    });

    it('should send incident update notification', async () => {
      const notificationId = await notificationService.notifyIncidentUpdate(
        mockIncident,
        'status changed to resolved'
      );

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: expect.objectContaining({
          title: 'Incident Update',
          body: `Incident ${mockIncident.id} status changed to resolved`,
          data: { incidentId: mockIncident.id },
        }),
        trigger: null,
      });
    });
  });

  describe('Hazard Notifications', () => {
    it('should send new hazard notification', async () => {
      const notificationId = await notificationService.notifyNewHazard(mockHazard);

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: expect.objectContaining({
          title: 'New Safety Hazard',
          body: expect.stringContaining('chemical'),
          data: { hazardId: mockHazard.id },
        }),
        trigger: null,
      });
    });

    it('should set correct priority for hazard risk level', async () => {
      const highRiskHazard = { ...mockHazard, riskLevel: 'high' as const };
      const mediumRiskHazard = { ...mockHazard, riskLevel: 'medium' as const };

      await notificationService.notifyNewHazard(highRiskHazard);
      await notificationService.notifyNewHazard(mediumRiskHazard);

      const calls = mockNotifications.scheduleNotificationAsync.mock.calls;

      // High risk should have sound
      expect(calls[0][0].content.sound).toBe('default');
      // Medium risk should not have sound
      expect(calls[1][0].content.sound).toBeUndefined();
    });
  });

  describe('Maintenance Notifications', () => {
    it('should send maintenance due notification', async () => {
      const notificationId = await notificationService.notifyMaintenanceDue(
        'equipment-001',
        'Oil change',
        'immediate'
      );

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: expect.objectContaining({
          title: 'Maintenance Due',
          body: 'Oil change required for equipment equipment-001',
          data: { equipmentId: 'equipment-001', task: 'Oil change' },
          sound: 'default', // Immediate priority
        }),
        trigger: null,
      });
    });

    it('should schedule maintenance reminder', async () => {
      const futureDate = new Date(Date.now() + 24 * 60 * 60 * 1000); // Tomorrow

      const notificationId = await notificationService.scheduleMaintenanceReminder(
        'equipment-001',
        'Oil change',
        futureDate
      );

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: expect.objectContaining({
          title: 'Upcoming Maintenance',
          body: 'Oil change due for equipment equipment-001',
          data: {
            equipmentId: 'equipment-001',
            task: 'Oil change',
            dueDate: futureDate.toISOString(),
          },
        }),
        trigger: expect.objectContaining({
          type: Notifications.SchedulableTriggerInputTypes.TIME_INTERVAL,
          seconds: expect.any(Number),
          repeats: false,
        }),
      });
    });

    it('should not schedule past due maintenance', async () => {
      const pastDate = new Date(Date.now() - 24 * 60 * 60 * 1000); // Yesterday

      const notificationId = await notificationService.scheduleMaintenanceReminder(
        'equipment-001',
        'Oil change',
        pastDate
      );

      expect(notificationId).toBeUndefined();
      expect(mockNotifications.scheduleNotificationAsync).not.toHaveBeenCalled();
    });
  });

  describe('Compliance and Emergency Notifications', () => {
    it('should send compliance issue notification', async () => {
      const notificationId = await notificationService.notifyComplianceIssue(
        'PPE not worn properly',
        'critical'
      );

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: expect.objectContaining({
          title: 'Compliance Alert',
          body: 'PPE not worn properly',
          data: { severity: 'critical' },
          sound: 'default', // Critical severity
        }),
        trigger: null,
      });
    });

    it('should send emergency notification', async () => {
      const notificationId = await notificationService.notifyEmergency(
        mockIncident,
        'Activate emergency response protocol'
      );

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: expect.objectContaining({
          title: 'EMERGENCY ALERT',
          body: expect.stringContaining('EMERGENCY ALERT'),
          data: {
            incidentId: mockIncident.id,
            emergency: true,
            protocol: 'Activate emergency response protocol',
          },
          sound: 'default', // Critical priority
        }),
        trigger: null,
      });
    });
  });

  describe('Safety Reminders', () => {
    it('should schedule safety reminder', async () => {
      const message = 'Remember to conduct safety checks';
      const delayInSeconds = 1800; // 30 minutes

      const notificationId = await notificationService.scheduleSafetyReminder(
        message,
        delayInSeconds
      );

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: expect.objectContaining({
          title: 'Safety Reminder',
          body: message,
          data: { reminder: true },
          sound: undefined, // Low priority
        }),
        trigger: expect.objectContaining({
          type: Notifications.SchedulableTriggerInputTypes.TIME_INTERVAL,
          seconds: delayInSeconds,
          repeats: false,
        }),
      });
    });

    it('should schedule daily briefing', async () => {
      const time = '09:00';

      const notificationId = await notificationService.scheduleDailyBriefing(time);

      expect(notificationId).toBe('notification-id-123');
      expect(mockNotifications.scheduleNotificationAsync).toHaveBeenCalledWith({
        content: expect.objectContaining({
          title: 'Daily Safety Briefing',
          body: 'Time for your daily safety check and incident review.',
          data: { dailyBriefing: true },
        }),
        trigger: expect.objectContaining({
          type: Notifications.SchedulableTriggerInputTypes.TIME_INTERVAL,
          seconds: expect.any(Number),
          repeats: false,
        }),
      });
    });

    it('should schedule next day briefing if time has passed', async () => {
      const pastTime = '01:00'; // 1 AM - likely past current time

      await notificationService.scheduleDailyBriefing(pastTime);

      const trigger = mockNotifications.scheduleNotificationAsync.mock.calls[0][0].trigger;
      expect(trigger.seconds).toBeGreaterThan(24 * 60 * 60); // Should be scheduled for next day
    });
  });

  describe('Notification Status', () => {
    it('should get notification status', async () => {
      const mockScheduled = [
        {
          identifier: 'scheduled-1',
          content: { title: 'Test', body: 'Test' },
          trigger: { type: 'timeInterval' as any, seconds: 3600 },
        },
      ];

      mockNotifications.getAllScheduledNotificationsAsync.mockResolvedValue(mockScheduled);

      const status = await notificationService.getNotificationStatus();

      expect(status).toMatchObject({
        permissions: 'granted',
        scheduledCount: 1,
        isInitialized: true,
        scheduledNotifications: expect.any(Array),
      });
    });

    it('should handle status retrieval errors', async () => {
      mockNotifications.getPermissionsAsync.mockRejectedValueOnce(
        new Error('Permission error')
      );

      const status = await notificationService.getNotificationStatus();

      expect(status).toMatchObject({
        permissions: 'unknown',
        scheduledCount: 0,
        isInitialized: true,
        scheduledNotifications: [],
      });
    });
  });

  describe('Notification Response Handling', () => {
    it('should handle incident notification response', async () => {
      const mockResponse = {
        notification: {
          request: {
            content: {
              data: {
                type: 'incident',
                incidentId: 'incident-123',
              },
            },
          },
        },
      } as Notifications.NotificationResponse;

      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      await notificationService.handleNotificationResponse(mockResponse);

      expect(consoleSpy).toHaveBeenCalledWith('Notification tapped:', {
        type: 'incident',
        incidentId: 'incident-123',
      });
      expect(consoleSpy).toHaveBeenCalledWith('Navigate to incident:', 'incident-123');

      consoleSpy.mockRestore();
    });

    it('should handle hazard notification response', async () => {
      const mockResponse = {
        notification: {
          request: {
            content: {
              data: {
                type: 'hazard',
                hazardId: 'hazard-123',
              },
            },
          },
        },
      } as Notifications.NotificationResponse;

      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      await notificationService.handleNotificationResponse(mockResponse);

      expect(consoleSpy).toHaveBeenCalledWith('Navigate to hazard:', 'hazard-123');

      consoleSpy.mockRestore();
    });

    it('should handle maintenance notification response', async () => {
      const mockResponse = {
        notification: {
          request: {
            content: {
              data: {
                type: 'maintenance',
                equipmentId: 'equipment-123',
              },
            },
          },
        },
      } as Notifications.NotificationResponse;

      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      await notificationService.handleNotificationResponse(mockResponse);

      expect(consoleSpy).toHaveBeenCalledWith('Navigate to maintenance:', 'equipment-123');

      consoleSpy.mockRestore();
    });

    it('should handle emergency notification response', async () => {
      const mockResponse = {
        notification: {
          request: {
            content: {
              data: {
                type: 'emergency',
                protocol: 'Evacuation protocol activated',
              },
            },
          },
        },
      } as Notifications.NotificationResponse;

      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      await notificationService.handleNotificationResponse(mockResponse);

      expect(consoleSpy).toHaveBeenCalledWith('Emergency protocol:', 'Evacuation protocol activated');

      consoleSpy.mockRestore();
    });

    it('should handle unknown notification type', async () => {
      const mockResponse = {
        notification: {
          request: {
            content: {
              data: {
                type: 'unknown',
              },
            },
          },
        },
      } as Notifications.NotificationResponse;

      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      await notificationService.handleNotificationResponse(mockResponse);

      expect(consoleSpy).toHaveBeenCalledWith('Unknown notification type');

      consoleSpy.mockRestore();
    });
  });

  describe('Service Lifecycle', () => {
    it('should destroy service properly', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      await notificationService.destroy();

      expect(mockNotifications.cancelAllScheduledNotificationsAsync).toHaveBeenCalled();
      expect(consoleSpy).toHaveBeenCalledWith('Notification service destroyed');

      consoleSpy.mockRestore();
    });

    it('should handle destroy errors gracefully', async () => {
      mockNotifications.cancelAllScheduledNotificationsAsync.mockRejectedValueOnce(
        new Error('Destroy failed')
      );

      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      await notificationService.destroy();

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to destroy notification service:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Error Handling', () => {
    it('should handle notification scheduling errors', async () => {
      mockNotifications.scheduleNotificationAsync.mockRejectedValueOnce(
        new Error('Scheduling failed')
      );

      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      await notificationService.sendNotification(mockNotificationData);

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to send notification:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });

    it('should handle notification cancellation errors', async () => {
      mockNotifications.cancelScheduledNotificationAsync.mockRejectedValueOnce(
        new Error('Cancellation failed')
      );

      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      await notificationService.cancelNotification('test-id');

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to cancel notification:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });

    it('should handle permission request errors', async () => {
      mockNotifications.requestPermissionsAsync.mockRejectedValueOnce(
        new Error('Permission request failed')
      );

      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      const newService = new (notificationService.constructor as any)();

      // Wait for async initialization
      await new Promise(resolve => setTimeout(resolve, 10));

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to initialize notifications:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });
});
