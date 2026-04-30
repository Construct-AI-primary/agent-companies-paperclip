import * as Notifications from 'expo-notifications';
import * as Device from 'expo-device';
import Constants from 'expo-constants';
import { Platform } from 'react-native';
import { SafetyIncident, SafetyHazard } from '../store/slices/safetySlice';

export interface NotificationData {
  type: 'incident' | 'hazard' | 'maintenance' | 'compliance' | 'emergency';
  title: string;
  message: string;
  data?: any;
  priority?: 'low' | 'medium' | 'high' | 'critical';
}

export interface ScheduledNotification {
  id: string;
  type: string;
  scheduledTime: Date;
  data: NotificationData;
}

class NotificationService {
  private isInitialized: boolean = false;
  private scheduledNotifications: ScheduledNotification[] = [];

  constructor() {
    this.initializeNotifications();
  }

  private async initializeNotifications() {
    try {
      // Set notification handler
      Notifications.setNotificationHandler({
        handleNotification: async () => ({
          shouldShowAlert: true,
          shouldPlaySound: true,
          shouldSetBadge: true,
          shouldShowBanner: true,
          shouldShowList: true,
        }),
      });

      // Request permissions
      if (Device.isDevice) {
        const { status: existingStatus } = await Notifications.getPermissionsAsync();
        let finalStatus = existingStatus;

        if (existingStatus !== 'granted') {
          const { status } = await Notifications.requestPermissionsAsync();
          finalStatus = status;
        }

        if (finalStatus !== 'granted') {
          console.warn('Failed to get push notification permissions');
          return;
        }

        // Get Expo push token
        if (Platform.OS === 'android') {
          await Notifications.setNotificationChannelAsync('default', {
            name: 'Default',
            importance: Notifications.AndroidImportance.MAX,
            vibrationPattern: [0, 250, 250, 250],
            lightColor: '#FF231F7C',
          });
        }

        const token = await Notifications.getExpoPushTokenAsync();
        console.log('Expo push token:', token.data);
        this.isInitialized = true;
      }
    } catch (error) {
      console.error('Failed to initialize notifications:', error);
    }
  }

  // Send immediate notification
  async sendNotification(notificationData: NotificationData) {
    try {
      if (!this.isInitialized) {
        console.warn('Notifications not initialized');
        return;
      }

      const notificationId = await Notifications.scheduleNotificationAsync({
        content: {
          title: notificationData.title,
          body: notificationData.message,
          data: notificationData.data,
          sound: notificationData.priority === 'critical' ? 'default' : undefined,
        },
        trigger: null, // Send immediately
      });

      console.log('Notification sent:', notificationId);
      return notificationId;
    } catch (error) {
      console.error('Failed to send notification:', error);
      throw error;
    }
  }

  // Schedule future notification
  async scheduleNotification(notificationData: NotificationData, delayInSeconds: number) {
    try {
      if (!this.isInitialized) {
        console.warn('Notifications not initialized');
        return;
      }

      const notificationId = await Notifications.scheduleNotificationAsync({
        content: {
          title: notificationData.title,
          body: notificationData.message,
          data: notificationData.data,
        },
        trigger: {
          type: Notifications.SchedulableTriggerInputTypes.TIME_INTERVAL,
          seconds: delayInSeconds,
          repeats: false,
        },
      });

      // Track scheduled notification
      const scheduledNotification: ScheduledNotification = {
        id: notificationId,
        type: notificationData.type,
        scheduledTime: new Date(Date.now() + delayInSeconds * 1000),
        data: notificationData,
      };

      this.scheduledNotifications.push(scheduledNotification);
      console.log('Notification scheduled:', notificationId);
      return notificationId;
    } catch (error) {
      console.error('Failed to schedule notification:', error);
      throw error;
    }
  }

  // Cancel notification
  async cancelNotification(notificationId: string) {
    try {
      await Notifications.cancelScheduledNotificationAsync(notificationId);
      this.scheduledNotifications = this.scheduledNotifications.filter(
        n => n.id !== notificationId
      );
      console.log('Notification cancelled:', notificationId);
    } catch (error) {
      console.error('Failed to cancel notification:', error);
    }
  }

  // Cancel all notifications
  async cancelAllNotifications() {
    try {
      await Notifications.cancelAllScheduledNotificationsAsync();
      this.scheduledNotifications = [];
      console.log('All notifications cancelled');
    } catch (error) {
      console.error('Failed to cancel all notifications:', error);
    }
  }

  // Incident-specific notifications
  async notifyNewIncident(incident: SafetyIncident) {
    const notificationData: NotificationData = {
      type: 'incident',
      title: 'New Safety Incident',
      message: `${incident.incidentType}: ${incident.description.substring(0, 50)}...`,
      data: { incidentId: incident.id },
      priority: incident.severity === 'critical' ? 'critical' :
               incident.severity === 'high' ? 'high' : 'medium',
    };

    return await this.sendNotification(notificationData);
  }

  async notifyIncidentUpdate(incident: SafetyIncident, updateType: string) {
    const notificationData: NotificationData = {
      type: 'incident',
      title: 'Incident Update',
      message: `Incident ${incident.id} ${updateType}`,
      data: { incidentId: incident.id },
      priority: 'medium',
    };

    return await this.sendNotification(notificationData);
  }

  // Hazard notifications
  async notifyNewHazard(hazard: SafetyHazard) {
    const notificationData: NotificationData = {
      type: 'hazard',
      title: 'New Safety Hazard',
      message: `${hazard.hazardType}: ${hazard.description.substring(0, 50)}...`,
      data: { hazardId: hazard.id },
      priority: hazard.riskLevel === 'high' ? 'high' : 'medium',
    };

    return await this.sendNotification(notificationData);
  }

  // Maintenance notifications
  async notifyMaintenanceDue(equipmentId: string, task: string, priority: string) {
    const notificationData: NotificationData = {
      type: 'maintenance',
      title: 'Maintenance Due',
      message: `${task} required for equipment ${equipmentId}`,
      data: { equipmentId, task },
      priority: priority === 'immediate' ? 'critical' :
               priority === 'short_term' ? 'high' : 'medium',
    };

    return await this.sendNotification(notificationData);
  }

  async scheduleMaintenanceReminder(equipmentId: string, task: string, dueDate: Date) {
    const delayInSeconds = Math.max(0, Math.floor((dueDate.getTime() - Date.now()) / 1000));

    if (delayInSeconds <= 0) return;

    const notificationData: NotificationData = {
      type: 'maintenance',
      title: 'Upcoming Maintenance',
      message: `${task} due for equipment ${equipmentId}`,
      data: { equipmentId, task, dueDate: dueDate.toISOString() },
      priority: 'medium',
    };

    return await this.scheduleNotification(notificationData, delayInSeconds);
  }

  // Compliance notifications
  async notifyComplianceIssue(message: string, severity: string) {
    const notificationData: NotificationData = {
      type: 'compliance',
      title: 'Compliance Alert',
      message,
      data: { severity },
      priority: severity === 'critical' ? 'critical' : 'high',
    };

    return await this.sendNotification(notificationData);
  }

  // Emergency notifications
  async notifyEmergency(incident: SafetyIncident, emergencyProtocol: string) {
    const notificationData: NotificationData = {
      type: 'emergency',
      title: 'EMERGENCY ALERT',
      message: `Critical incident: ${incident.incidentType}. ${emergencyProtocol}`,
      data: {
        incidentId: incident.id,
        emergency: true,
        protocol: emergencyProtocol
      },
      priority: 'critical',
    };

    return await this.sendNotification(notificationData);
  }

  // Safety reminders
  async scheduleSafetyReminder(message: string, delayInSeconds: number) {
    const notificationData: NotificationData = {
      type: 'compliance',
      title: 'Safety Reminder',
      message,
      data: { reminder: true },
      priority: 'low',
    };

    return await this.scheduleNotification(notificationData, delayInSeconds);
  }

  // Daily safety briefing
  async scheduleDailyBriefing(time: string) {
    // Parse time (e.g., "09:00")
    const [hours, minutes] = time.split(':').map(Number);
    const now = new Date();
    const scheduledTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), hours, minutes);

    if (scheduledTime <= now) {
      scheduledTime.setDate(scheduledTime.getDate() + 1);
    }

    const delayInSeconds = Math.floor((scheduledTime.getTime() - now.getTime()) / 1000);

    const notificationData: NotificationData = {
      type: 'compliance',
      title: 'Daily Safety Briefing',
      message: 'Time for your daily safety check and incident review.',
      data: { dailyBriefing: true },
      priority: 'medium',
    };

    return await this.scheduleNotification(notificationData, delayInSeconds);
  }

  // Get notification status
  async getNotificationStatus() {
    try {
      const permissions = await Notifications.getPermissionsAsync();
      const scheduled = await Notifications.getAllScheduledNotificationsAsync();

      return {
        permissions: permissions.status,
        scheduledCount: scheduled.length,
        isInitialized: this.isInitialized,
        scheduledNotifications: this.scheduledNotifications,
      };
    } catch (error) {
      console.error('Failed to get notification status:', error);
      return {
        permissions: 'unknown',
        scheduledCount: 0,
        isInitialized: this.isInitialized,
        scheduledNotifications: [],
      };
    }
  }

  // Handle notification response
  async handleNotificationResponse(response: Notifications.NotificationResponse) {
    const { notification } = response;
    const { data } = notification.request.content;

    console.log('Notification tapped:', data);

    // Handle different notification types
    switch (data?.type) {
      case 'incident':
        // Navigate to incident detail
        console.log('Navigate to incident:', data.incidentId);
        break;
      case 'hazard':
        // Navigate to hazard detail
        console.log('Navigate to hazard:', data.hazardId);
        break;
      case 'maintenance':
        // Navigate to maintenance screen
        console.log('Navigate to maintenance:', data.equipmentId);
        break;
      case 'emergency':
        // Handle emergency protocol
        console.log('Emergency protocol:', data.protocol);
        break;
      default:
        console.log('Unknown notification type');
    }
  }

  // Cleanup
  async destroy() {
    try {
      await this.cancelAllNotifications();
      console.log('Notification service destroyed');
    } catch (error) {
      console.error('Failed to destroy notification service:', error);
    }
  }
}

// Export singleton instance
export const notificationService = new NotificationService();
export default notificationService;
