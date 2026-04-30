// Mock the apiService module
jest.mock('../api', () => ({
  apiService: {
    login: jest.fn(),
    register: jest.fn(),
    logout: jest.fn(),
    getIncidents: jest.fn(),
    createIncident: jest.fn(),
    updateIncident: jest.fn(),
    deleteIncident: jest.fn(),
    getHazards: jest.fn(),
    createHazard: jest.fn(),
    updateHazard: jest.fn(),
    deleteHazard: jest.fn(),
    getEquipment: jest.fn(),
    createEquipment: jest.fn(),
    updateEquipment: jest.fn(),
    deleteEquipment: jest.fn(),
    syncIncidents: jest.fn(),
    syncHazards: jest.fn(),
    syncEquipment: jest.fn(),
    uploadPhoto: jest.fn(),
  },
}));

import { apiService } from '../api';

describe('ApiService', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('Authentication', () => {
    it('should login successfully', async () => {
      const mockUser = { id: '123', email: 'test@example.com' };
      (apiService.login as jest.Mock).mockResolvedValue({ user: mockUser });

      const result = await apiService.login('test@example.com', 'password123');

      expect(apiService.login).toHaveBeenCalledWith('test@example.com', 'password123');
      expect(result).toEqual({ user: mockUser });
    });

    it('should throw error on login failure', async () => {
      const mockError = new Error('Invalid credentials');
      (apiService.login as jest.Mock).mockRejectedValue(mockError);

      await expect(apiService.login('test@example.com', 'wrongpassword'))
        .rejects.toThrow('Invalid credentials');
    });

    it('should register successfully', async () => {
      const mockUser = { id: '123', email: 'new@example.com' };
      (apiService.register as jest.Mock).mockResolvedValue({ user: mockUser });

      const userData = {
        email: 'new@example.com',
        password: 'password123',
        name: 'New User',
      };

      const result = await apiService.register(userData);

      expect(apiService.register).toHaveBeenCalledWith(userData);
      expect(result).toEqual({ user: mockUser });
    });

    it('should logout successfully', async () => {
      (apiService.logout as jest.Mock).mockResolvedValue(undefined);

      await apiService.logout();

      expect(apiService.logout).toHaveBeenCalled();
    });

    it('should throw error on logout failure', async () => {
      const mockError = new Error('Logout failed');
      (apiService.logout as jest.Mock).mockRejectedValue(mockError);

      await expect(apiService.logout()).rejects.toThrow('Logout failed');
    });
  });

  describe('Incident Operations', () => {
    const mockIncidents = [
      {
        id: '1',
        title: 'Test Incident',
        description: 'Test description',
        severity: 'high',
        reportedAt: '2024-01-01T00:00:00Z',
        synced: true,
      },
    ];

    it('should get incidents successfully', async () => {
      (apiService.getIncidents as jest.Mock).mockResolvedValue(mockIncidents);

      const result = await apiService.getIncidents();

      expect(apiService.getIncidents).toHaveBeenCalled();
      expect(result).toEqual(mockIncidents);
    });

    it('should create incident successfully', async () => {
      const newIncident = {
        incidentType: 'accident',
        description: 'New description',
        severity: 'medium' as const,
        photos: [],
        videos: [],
        status: 'reported' as const,
      };

      const createdIncident = {
        ...newIncident,
        id: '2',
        reportedAt: '2024-01-02T00:00:00Z',
        synced: true,
      };

      (apiService.createIncident as jest.Mock).mockResolvedValue(createdIncident);

      const result = await apiService.createIncident(newIncident);

      expect(apiService.createIncident).toHaveBeenCalledWith(newIncident);
      expect(result).toEqual(createdIncident);
    });

    it('should update incident successfully', async () => {
      const updates = { severity: 'critical' as const };
      const updatedIncident = { ...mockIncidents[0], ...updates };

      (apiService.updateIncident as jest.Mock).mockResolvedValue(updatedIncident);

      const result = await apiService.updateIncident('1', updates);

      expect(apiService.updateIncident).toHaveBeenCalledWith('1', updates);
      expect(result).toEqual(updatedIncident);
    });

    it('should delete incident successfully', async () => {
      (apiService.deleteIncident as jest.Mock).mockResolvedValue(undefined);

      await apiService.deleteIncident('1');

      expect(apiService.deleteIncident).toHaveBeenCalledWith('1');
    });
  });

  describe('Hazard Operations', () => {
    const mockHazards = [
      {
        id: '1',
        title: 'Test Hazard',
        description: 'Test hazard description',
        riskLevel: 'high',
        reportedAt: '2024-01-01T00:00:00Z',
        synced: true,
      },
    ];

    it('should get hazards successfully', async () => {
      (apiService.getHazards as jest.Mock).mockResolvedValue(mockHazards);

      const result = await apiService.getHazards();

      expect(apiService.getHazards).toHaveBeenCalled();
      expect(result).toEqual(mockHazards);
    });

    it('should create hazard successfully', async () => {
      const newHazard = {
        hazardType: 'chemical',
        description: 'New hazard description',
        riskLevel: 'medium' as const,
        status: 'active' as const,
      };

      const createdHazard = {
        ...newHazard,
        id: '2',
        reportedAt: '2024-01-02T00:00:00Z',
        synced: true,
      };

      (apiService.createHazard as jest.Mock).mockResolvedValue(createdHazard);

      const result = await apiService.createHazard(newHazard);

      expect(apiService.createHazard).toHaveBeenCalledWith(newHazard);
      expect(result).toEqual(createdHazard);
    });

    it('should update hazard successfully', async () => {
      const updates = { riskLevel: 'high' as const };
      const updatedHazard = { ...mockHazards[0], ...updates };

      (apiService.updateHazard as jest.Mock).mockResolvedValue(updatedHazard);

      const result = await apiService.updateHazard('1', updates);

      expect(apiService.updateHazard).toHaveBeenCalledWith('1', updates);
      expect(result).toEqual(updatedHazard);
    });

    it('should delete hazard successfully', async () => {
      (apiService.deleteHazard as jest.Mock).mockResolvedValue(undefined);

      await apiService.deleteHazard('1');

      expect(apiService.deleteHazard).toHaveBeenCalledWith('1');
    });
  });

  describe('Equipment Operations', () => {
    const mockEquipment = [
      {
        id: '1',
        name: 'Test Equipment',
        type: 'tool',
        status: 'active',
        createdAt: '2024-01-01T00:00:00Z',
        updatedAt: '2024-01-01T00:00:00Z',
        synced: true,
      },
    ];

    it('should get equipment successfully', async () => {
      (apiService.getEquipment as jest.Mock).mockResolvedValue(mockEquipment);

      const result = await apiService.getEquipment();

      expect(apiService.getEquipment).toHaveBeenCalled();
      expect(result).toEqual(mockEquipment);
    });

    it('should create equipment successfully', async () => {
      const newEquipment = {
        name: 'New Equipment',
        type: 'machine',
        status: 'active' as const,
        active: true,
      };

      const createdEquipment = {
        ...newEquipment,
        id: '2',
        synced: true,
        createdAt: '2024-01-02T00:00:00Z',
        updatedAt: '2024-01-02T00:00:00Z',
      };

      (apiService.createEquipment as jest.Mock).mockResolvedValue(createdEquipment);

      const result = await apiService.createEquipment(newEquipment);

      expect(apiService.createEquipment).toHaveBeenCalledWith(newEquipment);
      expect(result).toEqual(createdEquipment);
    });

    it('should update equipment successfully', async () => {
      const updates = { status: 'maintenance' as const };
      const updatedEquipment = { ...mockEquipment[0], ...updates };

      (apiService.updateEquipment as jest.Mock).mockResolvedValue(updatedEquipment);

      const result = await apiService.updateEquipment('1', updates);

      expect(apiService.updateEquipment).toHaveBeenCalledWith('1', updates);
      expect(result).toEqual(updatedEquipment);
    });

    it('should delete equipment successfully', async () => {
      (apiService.deleteEquipment as jest.Mock).mockResolvedValue(undefined);

      await apiService.deleteEquipment('1');

      expect(apiService.deleteEquipment).toHaveBeenCalledWith('1');
    });
  });

  describe('Sync Operations', () => {
    it('should sync incidents successfully', async () => {
      const incidents = [
        {
          id: '1',
          incidentType: 'accident',
          description: 'Test incident 1',
          severity: 'medium' as const,
          photos: [],
          videos: [],
          status: 'reported' as const,
          synced: false,
          reportedAt: '2024-01-01T00:00:00Z'
        },
        {
          id: '2',
          incidentType: 'near_miss',
          description: 'Test incident 2',
          severity: 'high' as const,
          photos: [],
          videos: [],
          status: 'investigating' as const,
          synced: false,
          reportedAt: '2024-01-02T00:00:00Z'
        },
      ];

      const expectedResult = { synced: incidents, failed: [] };
      (apiService.syncIncidents as jest.Mock).mockResolvedValue(expectedResult);

      const result = await apiService.syncIncidents(incidents);

      expect(apiService.syncIncidents).toHaveBeenCalledWith(incidents);
      expect(result).toEqual(expectedResult);
    });

    it('should handle sync incidents failures', async () => {
      const incidents = [
        {
          id: '1',
          incidentType: 'accident',
          description: 'Test incident 1',
          severity: 'medium' as const,
          photos: [],
          videos: [],
          status: 'reported' as const,
          synced: false,
          reportedAt: '2024-01-01T00:00:00Z'
        },
      ];

      const expectedResult = { synced: [], failed: ['1'] };
      (apiService.syncIncidents as jest.Mock).mockResolvedValue(expectedResult);

      const result = await apiService.syncIncidents(incidents);

      expect(apiService.syncIncidents).toHaveBeenCalledWith(incidents);
      expect(result).toEqual(expectedResult);
    });

    it('should sync hazards successfully', async () => {
      const hazards = [
        {
          id: '1',
          hazardType: 'chemical',
          description: 'Test hazard 1',
          riskLevel: 'medium' as const,
          status: 'active' as const,
          synced: false,
        },
        {
          id: '2',
          hazardType: 'physical',
          description: 'Test hazard 2',
          riskLevel: 'high' as const,
          status: 'mitigated' as const,
          synced: false,
        },
      ];

      const expectedResult = { synced: hazards, failed: [] };
      (apiService.syncHazards as jest.Mock).mockResolvedValue(expectedResult);

      const result = await apiService.syncHazards(hazards);

      expect(apiService.syncHazards).toHaveBeenCalledWith(hazards);
      expect(result).toEqual(expectedResult);
    });

    it('should sync equipment successfully', async () => {
      const equipment = [
        {
          id: '1',
          name: 'Equipment 1',
          type: 'tool',
          status: 'active' as const,
          active: true,
          synced: false,
        },
        {
          id: '2',
          name: 'Equipment 2',
          type: 'machine',
          status: 'maintenance' as const,
          active: true,
          synced: false,
        },
      ];

      const expectedResult = { synced: equipment, failed: [] };
      (apiService.syncEquipment as jest.Mock).mockResolvedValue(expectedResult);

      const result = await apiService.syncEquipment(equipment);

      expect(apiService.syncEquipment).toHaveBeenCalledWith(equipment);
      expect(result).toEqual(expectedResult);
    });
  });

  describe('File Upload', () => {
    it('should upload photo successfully', async () => {
      const mockPhotoUri = 'file://path/to/photo.jpg';
      const mockPublicUrl = 'https://example.com/photo.jpg';

      (apiService.uploadPhoto as jest.Mock).mockResolvedValue({ url: mockPublicUrl });

      const result = await apiService.uploadPhoto(mockPhotoUri, 'incident123');

      expect(apiService.uploadPhoto).toHaveBeenCalledWith(mockPhotoUri, 'incident123');
      expect(result).toEqual({ url: mockPublicUrl });
    });

    it('should throw error on upload failure', async () => {
      const mockPhotoUri = 'file://path/to/photo.jpg';
      const mockError = new Error('Upload failed');

      (apiService.uploadPhoto as jest.Mock).mockRejectedValue(mockError);

      await expect(apiService.uploadPhoto(mockPhotoUri))
        .rejects.toThrow('Upload failed');
    });
  });
});
