// Mock the database service
jest.mock('../../services/database', () => ({
  getUnsyncedIncidents: jest.fn(),
  getUnsyncedHazards: jest.fn(),
  getUnsyncedEquipment: jest.fn(),
  getIncidents: jest.fn(),
  getHazards: jest.fn(),
  getEquipment: jest.fn(),
  updateIncidentSyncStatus: jest.fn(),
  updateHazardSyncStatus: jest.fn(),
  updateEquipmentSyncStatus: jest.fn(),
  getDatabaseStats: jest.fn(),
}));

// Mock the API service
jest.mock('../../services/api', () => ({
  apiService: {
    getIncidents: jest.fn(),
    syncIncidents: jest.fn(),
    syncHazards: jest.fn(),
    syncEquipment: jest.fn(),
  },
}));

import { syncService } from '../syncService';
import * as database from '../database';
import { apiService } from '../api';
import { SafetyIncident, SafetyHazard } from '../../store/slices/safetySlice';
import { Equipment } from '../database';

// Mock data
const mockIncidents: SafetyIncident[] = [
  {
    id: 'incident-1',
    incidentType: 'fall',
    description: 'Worker fell from ladder',
    severity: 'medium',
    photos: [],
    videos: [],
    status: 'reported',
    synced: false,
    reportedAt: '2023-01-01T10:00:00Z',
  },
];

const mockHazards: SafetyHazard[] = [
  {
    id: 'hazard-1',
    hazardType: 'electrical',
    description: 'Exposed wiring',
    riskLevel: 'high',
    status: 'active',
    synced: false,
  },
];

const mockEquipment: Equipment[] = [
  {
    id: 'equipment-1',
    name: 'Excavator',
    type: 'heavy_machinery',
    status: 'active',
    synced: false,
    active: true,
    archived: false,
    requiresMsd: false,
  },
];

describe('SyncService', () => {
  beforeEach(() => {
    jest.clearAllMocks();
    // Reset the syncInProgress flag before each test
    syncService['syncInProgress'] = false;
  });

  describe('checkConnectivity', () => {
    it('should return true when API is reachable', async () => {
      (apiService.getIncidents as jest.Mock).mockResolvedValue([]);

      const result = await syncService.checkConnectivity();

      expect(result).toBe(true);
      expect(syncService['isOnline']).toBe(true);
    });

    it('should return false when API is not reachable', async () => {
      (apiService.getIncidents as jest.Mock).mockRejectedValue(new Error('Network error'));

      const result = await syncService.checkConnectivity();

      expect(result).toBe(false);
      expect(syncService['isOnline']).toBe(false);
    });
  });

  describe('syncAllData', () => {
    it('should throw error when sync is already in progress', async () => {
      // Set sync in progress
      syncService['syncInProgress'] = true;

      await expect(syncService.syncAllData()).rejects.toThrow('Sync already in progress');
    });

    it('should throw error when no internet connection', async () => {
      (apiService.getIncidents as jest.Mock).mockRejectedValue(new Error('Network error'));

      await expect(syncService.syncAllData()).rejects.toThrow('No internet connection');
    });

    it('should sync all data successfully when online', async () => {
      // Mock online status
      (apiService.getIncidents as jest.Mock).mockResolvedValue([]);
      
      // Mock unsynced data
      (database.getUnsyncedIncidents as jest.Mock).mockResolvedValue(mockIncidents);
      (database.getUnsyncedHazards as jest.Mock).mockResolvedValue(mockHazards);
      (database.getUnsyncedEquipment as jest.Mock).mockResolvedValue(mockEquipment);
      
      // Mock sync results
      (apiService.syncIncidents as jest.Mock).mockResolvedValue({
        synced: mockIncidents,
        failed: [],
      });
      (apiService.syncHazards as jest.Mock).mockResolvedValue({
        synced: mockHazards,
        failed: [],
      });
      (apiService.syncEquipment as jest.Mock).mockResolvedValue({
        synced: mockEquipment,
        failed: [],
      });
      
      // Mock update sync status
      (database.updateIncidentSyncStatus as jest.Mock).mockResolvedValue(undefined);
      (database.updateHazardSyncStatus as jest.Mock).mockResolvedValue(undefined);
      (database.updateEquipmentSyncStatus as jest.Mock).mockResolvedValue(undefined);

      const result = await syncService.syncAllData();

      expect(result).toEqual({
        incidentsSynced: 1,
        hazardsSynced: 1,
        equipmentSynced: 1,
        errors: [],
      });
      
      // Verify sync status updates were called
      expect(database.updateIncidentSyncStatus).toHaveBeenCalledWith('incident-1', true);
      expect(database.updateHazardSyncStatus).toHaveBeenCalledWith('hazard-1', true);
      expect(database.updateEquipmentSyncStatus).toHaveBeenCalledWith('equipment-1', true);
    });

    it('should handle partial sync failures', async () => {
      // Mock online status
      (apiService.getIncidents as jest.Mock).mockResolvedValue([]);
      
      // Mock unsynced data
      (database.getUnsyncedIncidents as jest.Mock).mockResolvedValue(mockIncidents);
      (database.getUnsyncedHazards as jest.Mock).mockResolvedValue(mockHazards);
      (database.getUnsyncedEquipment as jest.Mock).mockResolvedValue(mockEquipment);
      
      // Mock sync results with failures
      (apiService.syncIncidents as jest.Mock).mockResolvedValue({
        synced: [],
        failed: ['incident-1'],
      });
      (apiService.syncHazards as jest.Mock).mockResolvedValue({
        synced: mockHazards,
        failed: [],
      });
      (apiService.syncEquipment as jest.Mock).mockResolvedValue({
        synced: [],
        failed: ['equipment-1'],
      });

      const result = await syncService.syncAllData();

      expect(result.incidentsSynced).toBe(0);
      expect(result.hazardsSynced).toBe(1);
      expect(result.equipmentSynced).toBe(0);
      expect(result.errors).toHaveLength(2);
      expect(result.errors).toContain('Failed to sync 1 incidents');
      expect(result.errors).toContain('Failed to sync 1 equipment items');
    });

    it('should handle API errors gracefully', async () => {
      // Mock online status
      (apiService.getIncidents as jest.Mock).mockResolvedValue([]);
      
      // Mock unsynced data
      (database.getUnsyncedIncidents as jest.Mock).mockResolvedValue(mockIncidents);
      (database.getUnsyncedHazards as jest.Mock).mockResolvedValue(mockHazards);
      (database.getUnsyncedEquipment as jest.Mock).mockResolvedValue(mockEquipment);
      
      // Mock API errors
      (apiService.syncIncidents as jest.Mock).mockRejectedValue(new Error('API error'));
      (apiService.syncHazards as jest.Mock).mockRejectedValue(new Error('API error'));
      (apiService.syncEquipment as jest.Mock).mockRejectedValue(new Error('API error'));

      const result = await syncService.syncAllData();

      expect(result.incidentsSynced).toBe(0);
      expect(result.hazardsSynced).toBe(0);
      expect(result.equipmentSynced).toBe(0);
      expect(result.errors).toHaveLength(3);
    });

    it('should reset syncInProgress flag after completion', async () => {
      // Mock online status
      (apiService.getIncidents as jest.Mock).mockResolvedValue([]);
      
      // Mock empty unsynced data
      (database.getUnsyncedIncidents as jest.Mock).mockResolvedValue([]);
      (database.getUnsyncedHazards as jest.Mock).mockResolvedValue([]);
      (database.getUnsyncedEquipment as jest.Mock).mockResolvedValue([]);

      await syncService.syncAllData();

      expect(syncService['syncInProgress']).toBe(false);
    });
  });

  describe('syncIncident', () => {
    it('should sync a specific incident successfully', async () => {
      (database.getIncidents as jest.Mock).mockResolvedValue(mockIncidents);
      (apiService.syncIncidents as jest.Mock).mockResolvedValue({
        synced: mockIncidents,
        failed: [],
      });
      (database.updateIncidentSyncStatus as jest.Mock).mockResolvedValue(undefined);

      const result = await syncService.syncIncident('incident-1');

      expect(result).toBe(true);
      expect(database.updateIncidentSyncStatus).toHaveBeenCalledWith('incident-1', true);
    });

    it('should return false when incident not found', async () => {
      (database.getIncidents as jest.Mock).mockResolvedValue([]);

      const result = await syncService.syncIncident('non-existent');

      expect(result).toBe(false);
    });

    it('should return false when sync fails', async () => {
      (database.getIncidents as jest.Mock).mockResolvedValue(mockIncidents);
      (apiService.syncIncidents as jest.Mock).mockResolvedValue({
        synced: [],
        failed: ['incident-1'],
      });

      const result = await syncService.syncIncident('incident-1');

      expect(result).toBe(false);
    });

    it('should handle API errors gracefully', async () => {
      (database.getIncidents as jest.Mock).mockResolvedValue(mockIncidents);
      (apiService.syncIncidents as jest.Mock).mockRejectedValue(new Error('API error'));

      const result = await syncService.syncIncident('incident-1');

      expect(result).toBe(false);
    });
  });

  describe('syncHazard', () => {
    it('should sync a specific hazard successfully', async () => {
      (database.getHazards as jest.Mock).mockResolvedValue(mockHazards);
      (apiService.syncHazards as jest.Mock).mockResolvedValue({
        synced: mockHazards,
        failed: [],
      });
      (database.updateHazardSyncStatus as jest.Mock).mockResolvedValue(undefined);

      const result = await syncService.syncHazard('hazard-1');

      expect(result).toBe(true);
      expect(database.updateHazardSyncStatus).toHaveBeenCalledWith('hazard-1', true);
    });

    it('should return false when hazard not found', async () => {
      (database.getHazards as jest.Mock).mockResolvedValue([]);

      const result = await syncService.syncHazard('non-existent');

      expect(result).toBe(false);
    });

    it('should return false when sync fails', async () => {
      (database.getHazards as jest.Mock).mockResolvedValue(mockHazards);
      (apiService.syncHazards as jest.Mock).mockResolvedValue({
        synced: [],
        failed: ['hazard-1'],
      });

      const result = await syncService.syncHazard('hazard-1');

      expect(result).toBe(false);
    });

    it('should handle API errors gracefully', async () => {
      (database.getHazards as jest.Mock).mockResolvedValue(mockHazards);
      (apiService.syncHazards as jest.Mock).mockRejectedValue(new Error('API error'));

      const result = await syncService.syncHazard('hazard-1');

      expect(result).toBe(false);
    });
  });

  describe('syncEquipment', () => {
    it('should sync a specific equipment successfully', async () => {
      (database.getEquipment as jest.Mock).mockResolvedValue(mockEquipment);
      (apiService.syncEquipment as jest.Mock).mockResolvedValue({
        synced: mockEquipment,
        failed: [],
      });
      (database.updateEquipmentSyncStatus as jest.Mock).mockResolvedValue(undefined);

      const result = await syncService.syncEquipment('equipment-1');

      expect(result).toBe(true);
      expect(database.updateEquipmentSyncStatus).toHaveBeenCalledWith('equipment-1', true);
    });

    it('should return false when equipment not found', async () => {
      (database.getEquipment as jest.Mock).mockResolvedValue([]);

      const result = await syncService.syncEquipment('non-existent');

      expect(result).toBe(false);
    });

    it('should return false when sync fails', async () => {
      (database.getEquipment as jest.Mock).mockResolvedValue(mockEquipment);
      (apiService.syncEquipment as jest.Mock).mockResolvedValue({
        synced: [],
        failed: ['equipment-1'],
      });

      const result = await syncService.syncEquipment('equipment-1');

      expect(result).toBe(false);
    });

    it('should handle API errors gracefully', async () => {
      (database.getEquipment as jest.Mock).mockResolvedValue(mockEquipment);
      (apiService.syncEquipment as jest.Mock).mockRejectedValue(new Error('API error'));

      const result = await syncService.syncEquipment('equipment-1');

      expect(result).toBe(false);
    });
  });

  describe('getSyncStats', () => {
    it('should return sync statistics', async () => {
      const mockStats = {
        incidentCount: 10,
        syncedIncidents: 8,
        hazardCount: 5,
        syncedHazards: 3,
      };
      
      const mockEquipmentWithSync = [
        { ...mockEquipment[0], synced: true },
        { ...mockEquipment[0], id: 'equipment-2', synced: false },
      ];

      (database.getDatabaseStats as jest.Mock).mockResolvedValue(mockStats);
      (apiService.getIncidents as jest.Mock).mockResolvedValue([]);
      (database.getEquipment as jest.Mock).mockResolvedValue(mockEquipmentWithSync);

      const result = await syncService.getSyncStats();

      expect(result).toEqual({
        totalIncidents: 10,
        syncedIncidents: 8,
        totalHazards: 5,
        syncedHazards: 3,
        totalEquipment: 2,
        syncedEquipment: 1,
        isOnline: true,
      });
    });

    it('should handle offline status', async () => {
      (apiService.getIncidents as jest.Mock).mockRejectedValue(new Error('Network error'));

      const result = await syncService.getSyncStats();

      expect(result.isOnline).toBe(false);
    });
  });
});
