import { apiService } from './api';
import * as database from './database';
import { SafetyIncident, SafetyHazard } from '../store/slices/safetySlice';
import { Equipment } from './database';

class SyncService {
  private isOnline: boolean = true;
  private syncInProgress: boolean = false;

  // Check network connectivity (simplified)
  async checkConnectivity(): Promise<boolean> {
    try {
      // Simple connectivity check - ping the API
      await apiService.getIncidents();
      this.isOnline = true;
      return true;
    } catch (error) {
      this.isOnline = false;
      return false;
    }
  }

  // Sync all unsynced data
  async syncAllData(): Promise<{
    incidentsSynced: number;
    hazardsSynced: number;
    equipmentSynced: number;
    errors: string[];
  }> {
    if (this.syncInProgress) {
      throw new Error('Sync already in progress');
    }

    this.syncInProgress = true;
    const errors: string[] = [];

    try {
      // Check connectivity first
      const isConnected = await this.checkConnectivity();
      if (!isConnected) {
        throw new Error('No internet connection');
      }

      let incidentsSynced = 0;
      let hazardsSynced = 0;
      let equipmentSynced = 0;

      // Sync incidents
      try {
        const unsyncedIncidents = await database.getUnsyncedIncidents();
        if (unsyncedIncidents.length > 0) {
          const result = await apiService.syncIncidents(unsyncedIncidents);
          incidentsSynced = result.synced.length;

          // Update local sync status
          for (const incident of result.synced) {
            await database.updateIncidentSyncStatus(incident.id, true);
          }

          if (result.failed.length > 0) {
            errors.push(`Failed to sync ${result.failed.length} incidents`);
          }
        }
      } catch (error) {
        errors.push(`Incident sync error: ${error}`);
      }

      // Sync hazards
      try {
        const unsyncedHazards = await database.getUnsyncedHazards();
        if (unsyncedHazards.length > 0) {
          const result = await apiService.syncHazards(unsyncedHazards);
          hazardsSynced = result.synced.length;

          // Update local sync status
          for (const hazard of result.synced) {
            await database.updateHazardSyncStatus(hazard.id, true);
          }

          if (result.failed.length > 0) {
            errors.push(`Failed to sync ${result.failed.length} hazards`);
          }
        }
      } catch (error) {
        errors.push(`Hazard sync error: ${error}`);
      }

      // Sync equipment
      try {
        const unsyncedEquipment = await database.getUnsyncedEquipment();
        if (unsyncedEquipment.length > 0) {
          const result = await apiService.syncEquipment(unsyncedEquipment);
          equipmentSynced = result.synced.length;

          // Update local sync status
          for (const item of result.synced) {
            await database.updateEquipmentSyncStatus(item.id, true);
          }

          if (result.failed.length > 0) {
            errors.push(`Failed to sync ${result.failed.length} equipment items`);
          }
        }
      } catch (error) {
        errors.push(`Equipment sync error: ${error}`);
      }

      return {
        incidentsSynced,
        hazardsSynced,
        equipmentSynced,
        errors,
      };
    } finally {
      this.syncInProgress = false;
    }
  }

  // Sync specific incident
  async syncIncident(incidentId: string): Promise<boolean> {
    try {
      const incidents = await database.getIncidents();
      const incident = incidents.find(inc => inc.id === incidentId);

      if (!incident) {
        throw new Error('Incident not found');
      }

      const result = await apiService.syncIncidents([incident]);

      if (result.synced.length > 0) {
        await database.updateIncidentSyncStatus(incidentId, true);
        return true;
      }

      return false;
    } catch (error) {
      console.error('Failed to sync incident:', error);
      return false;
    }
  }

  // Sync specific hazard
  async syncHazard(hazardId: string): Promise<boolean> {
    try {
      const hazards = await database.getHazards();
      const hazard = hazards.find(haz => haz.id === hazardId);

      if (!hazard) {
        throw new Error('Hazard not found');
      }

      const result = await apiService.syncHazards([hazard]);

      if (result.synced.length > 0) {
        await database.updateHazardSyncStatus(hazardId, true);
        return true;
      }

      return false;
    } catch (error) {
      console.error('Failed to sync hazard:', error);
      return false;
    }
  }

  // Sync specific equipment
  async syncEquipment(equipmentId: string): Promise<boolean> {
    try {
      const equipment = await database.getEquipment();
      const item = equipment.find(eq => eq.id === equipmentId);

      if (!item) {
        throw new Error('Equipment not found');
      }

      const result = await apiService.syncEquipment([item]);

      if (result.synced.length > 0) {
        await database.updateEquipmentSyncStatus(equipmentId, true);
        return true;
      }

      return false;
    } catch (error) {
      console.error('Failed to sync equipment:', error);
      return false;
    }
  }

  // Get sync statistics
  async getSyncStats(): Promise<{
    totalIncidents: number;
    syncedIncidents: number;
    totalHazards: number;
    syncedHazards: number;
    totalEquipment: number;
    syncedEquipment: number;
    isOnline: boolean;
  }> {
    const stats = await database.getDatabaseStats();
    const isOnline = await this.checkConnectivity();

    // Get equipment stats
    const equipment = await database.getEquipment();
    const syncedEquipment = equipment.filter(eq => eq.synced).length;

    return {
      totalIncidents: stats.incidentCount,
      syncedIncidents: stats.syncedIncidents,
      totalHazards: stats.hazardCount,
      syncedHazards: stats.syncedHazards,
      totalEquipment: equipment.length,
      syncedEquipment,
      isOnline,
    };
  }

  // Supabase handles authentication automatically
  // No need for manual token management
}

// Export singleton instance
export const syncService = new SyncService();
export default syncService;
