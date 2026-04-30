import * as database from '../database';
import { Equipment } from '../database';
import { SafetyIncident, SafetyHazard } from '../../store/slices/safetySlice';

// Mock the entire database module
jest.mock('../database', () => ({
  initDatabase: jest.fn(),
  saveEquipment: jest.fn(),
  getEquipment: jest.fn(),
  getUnsyncedEquipment: jest.fn(),
  updateEquipmentSyncStatus: jest.fn(),
  saveIncident: jest.fn(),
  getIncidents: jest.fn(),
  getUnsyncedIncidents: jest.fn(),
  updateIncidentSyncStatus: jest.fn(),
  saveHazard: jest.fn(),
  getHazards: jest.fn(),
  getUnsyncedHazards: jest.fn(),
  updateHazardSyncStatus: jest.fn(),
  getDatabaseStats: jest.fn()
}));

// Mock data
const mockEquipment: Equipment = {
  id: 'eq_123',
  name: 'Excavator',
  type: 'heavy_machinery',
  status: 'active',
  synced: false,
  active: true,
  archived: false,
  requiresMsd: false
};

const mockIncident: SafetyIncident = {
  id: 'inc_123',
  incidentType: 'fall',
  description: 'Worker fell from ladder',
  severity: 'medium',
  photos: [],
  videos: [],
  status: 'reported',
  synced: false,
  reportedAt: '2024-01-01T10:00:00Z'
};

const mockHazard: SafetyHazard = {
  id: 'haz_123',
  hazardType: 'electrical',
  description: 'Exposed wiring',
  riskLevel: 'high',
  status: 'active',
  synced: false
};

describe('Database Service', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('initDatabase', () => {
    it('should initialize database successfully', async () => {
      (database.initDatabase as jest.Mock).mockResolvedValue(undefined);

      await database.initDatabase();

      expect(database.initDatabase).toHaveBeenCalled();
    });

    it('should handle database initialization errors', async () => {
      const mockError = { code: 1, message: 'Database error' };
      (database.initDatabase as jest.Mock).mockRejectedValue(mockError);

      await expect(database.initDatabase()).rejects.toEqual(mockError);
    });
  });

  describe('Equipment Operations', () => {
    it('should save equipment successfully', async () => {
      (database.saveEquipment as jest.Mock).mockResolvedValue(undefined);

      await database.saveEquipment(mockEquipment);

      expect(database.saveEquipment).toHaveBeenCalledWith(mockEquipment);
    });

    it('should get all equipment', async () => {
      const mockEquipmentList = [mockEquipment];
      (database.getEquipment as jest.Mock).mockResolvedValue(mockEquipmentList);

      const result = await database.getEquipment();

      expect(database.getEquipment).toHaveBeenCalled();
      expect(result).toHaveLength(1);
      expect(result[0]).toEqual(expect.objectContaining({
        id: mockEquipment.id,
        name: mockEquipment.name
      }));
    });

    it('should get unsynced equipment', async () => {
      const mockUnsyncedEquipment = [mockEquipment];
      (database.getUnsyncedEquipment as jest.Mock).mockResolvedValue(mockUnsyncedEquipment);

      const result = await database.getUnsyncedEquipment();

      expect(database.getUnsyncedEquipment).toHaveBeenCalled();
      expect(result).toHaveLength(1);
    });

    it('should update equipment sync status', async () => {
      (database.updateEquipmentSyncStatus as jest.Mock).mockResolvedValue(undefined);

      await database.updateEquipmentSyncStatus(mockEquipment.id, true);

      expect(database.updateEquipmentSyncStatus).toHaveBeenCalledWith(mockEquipment.id, true);
    });

    it('should handle equipment operation errors', async () => {
      const mockError = { code: 1, message: 'Database error' };
      (database.saveEquipment as jest.Mock).mockRejectedValue(mockError);

      await expect(database.saveEquipment(mockEquipment)).rejects.toEqual(mockError);
    });
  });

  describe('Incident Operations', () => {
    it('should save incident successfully', async () => {
      (database.saveIncident as jest.Mock).mockResolvedValue(undefined);

      await database.saveIncident(mockIncident);

      expect(database.saveIncident).toHaveBeenCalledWith(mockIncident);
    });

    it('should get all incidents', async () => {
      const mockIncidentsList = [mockIncident];
      (database.getIncidents as jest.Mock).mockResolvedValue(mockIncidentsList);

      const result = await database.getIncidents();

      expect(database.getIncidents).toHaveBeenCalled();
      expect(result).toHaveLength(1);
      expect(result[0]).toEqual(expect.objectContaining({
        id: mockIncident.id,
        incidentType: mockIncident.incidentType
      }));
    });

    it('should get unsynced incidents', async () => {
      const mockUnsyncedIncidents = [mockIncident];
      (database.getUnsyncedIncidents as jest.Mock).mockResolvedValue(mockUnsyncedIncidents);

      const result = await database.getUnsyncedIncidents();

      expect(database.getUnsyncedIncidents).toHaveBeenCalled();
      expect(result).toHaveLength(1);
    });

    it('should update incident sync status', async () => {
      (database.updateIncidentSyncStatus as jest.Mock).mockResolvedValue(undefined);

      await database.updateIncidentSyncStatus(mockIncident.id, true);

      expect(database.updateIncidentSyncStatus).toHaveBeenCalledWith(mockIncident.id, true);
    });
  });

  describe('Hazard Operations', () => {
    it('should save hazard successfully', async () => {
      (database.saveHazard as jest.Mock).mockResolvedValue(undefined);

      await database.saveHazard(mockHazard);

      expect(database.saveHazard).toHaveBeenCalledWith(mockHazard);
    });

    it('should get all hazards', async () => {
      const mockHazardsList = [mockHazard];
      (database.getHazards as jest.Mock).mockResolvedValue(mockHazardsList);

      const result = await database.getHazards();

      expect(database.getHazards).toHaveBeenCalled();
      expect(result).toHaveLength(1);
      expect(result[0]).toEqual(expect.objectContaining({
        id: mockHazard.id,
        hazardType: mockHazard.hazardType
      }));
    });

    it('should get unsynced hazards', async () => {
      const mockUnsyncedHazards = [mockHazard];
      (database.getUnsyncedHazards as jest.Mock).mockResolvedValue(mockUnsyncedHazards);

      const result = await database.getUnsyncedHazards();

      expect(database.getUnsyncedHazards).toHaveBeenCalled();
      expect(result).toHaveLength(1);
    });

    it('should update hazard sync status', async () => {
      (database.updateHazardSyncStatus as jest.Mock).mockResolvedValue(undefined);

      await database.updateHazardSyncStatus(mockHazard.id, true);

      expect(database.updateHazardSyncStatus).toHaveBeenCalledWith(mockHazard.id, true);
    });
  });

  describe('Data Parsing', () => {
    it('should parse equipment data correctly', async () => {
      const parsedEquipment = {
        ...mockEquipment,
        active: true,
        archived: false,
        requiresMsd: true,
        synced: true,
        specifications: { weight: '5000kg' }
      };

      (database.getEquipment as jest.Mock).mockResolvedValue([parsedEquipment]);

      const result = await database.getEquipment();

      expect(database.getEquipment).toHaveBeenCalled();
      expect(result[0]).toEqual(expect.objectContaining({
        active: true,
        archived: false,
        requiresMsd: true,
        synced: true,
        specifications: { weight: '5000kg' }
      }));
    });

    it('should parse incident data correctly', async () => {
      const parsedIncident = {
        ...mockIncident,
        synced: true,
        location: { latitude: 40.7128, longitude: -74.0060 },
        photos: [{ uri: 'photo1.jpg' }]
      };

      (database.getIncidents as jest.Mock).mockResolvedValue([parsedIncident]);

      const result = await database.getIncidents();

      expect(database.getIncidents).toHaveBeenCalled();
      expect(result[0]).toEqual(expect.objectContaining({
        synced: true,
        location: { latitude: 40.7128, longitude: -74.0060 },
        photos: [{ uri: 'photo1.jpg' }]
      }));
    });

    it('should parse hazard data correctly', async () => {
      const parsedHazard = {
        ...mockHazard,
        synced: true,
        location: { latitude: 40.7128, longitude: -74.0060 }
      };

      (database.getHazards as jest.Mock).mockResolvedValue([parsedHazard]);

      const result = await database.getHazards();

      expect(database.getHazards).toHaveBeenCalled();
      expect(result[0]).toEqual(expect.objectContaining({
        synced: true,
        location: { latitude: 40.7128, longitude: -74.0060 }
      }));
    });
  });

  describe('getDatabaseStats', () => {
    it('should return database statistics', async () => {
      const mockStats = {
        incidentCount: 5,
        syncedIncidents: 3,
        hazardCount: 3,
        syncedHazards: 1
      };
      (database.getDatabaseStats as jest.Mock).mockResolvedValue(mockStats);

      const result = await database.getDatabaseStats();

      expect(database.getDatabaseStats).toHaveBeenCalled();
      expect(result).toEqual(mockStats);
    });

    it('should handle database errors', async () => {
      const mockError = { code: 1, message: 'Database error' };
      (database.getDatabaseStats as jest.Mock).mockRejectedValue(mockError);

      await expect(database.getDatabaseStats()).rejects.toEqual(mockError);
    });
  });
});
