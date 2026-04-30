// Web-compatible API service that works without Supabase
import { SafetyIncident, SafetyHazard } from '../store/slices/safetySlice';
import { Equipment } from './database';

// Mock API service for web development
class ApiService {
  constructor() {
    console.log('Using web-compatible mock API service');
  }

  // Authentication methods - mock implementation
  async login(email: string, password: string): Promise<{ user: any }> {
    console.log('Mock login:', email);
    return { 
      user: { 
        id: 'mock-user-1', 
        email: email,
        name: 'Demo User'
      } 
    };
  }

  async register(userData: { email: string; password: string; name: string }): Promise<{ user: any }> {
    console.log('Mock register:', userData.email);
    return { 
      user: { 
        id: 'mock-user-1', 
        email: userData.email,
        name: userData.name
      } 
    };
  }

  async logout(): Promise<void> {
    console.log('Mock logout');
  }

  // Incident API methods - return mock data
  async getIncidents(): Promise<SafetyIncident[]> {
    console.log('Mock getIncidents');
    return [
      {
        id: 'mock-incident-1',
        incidentType: 'equipment_failure',
        description: 'Mock equipment failure for web demo',
        severity: 'medium',
        location: { latitude: 0, longitude: 0 },
        photos: [],
        videos: [],
        status: 'reported',
        synced: true,
        reportedBy: 'demo-user',
        reportedAt: new Date().toISOString(),
        immediateActions: 'Safety protocols followed'
      }
    ];
  }

  async createIncident(incident: Omit<SafetyIncident, 'id' | 'synced' | 'reportedAt'>): Promise<SafetyIncident> {
    console.log('Mock createIncident');
    return {
      ...incident,
      id: 'mock-incident-' + Date.now(),
      reportedAt: new Date().toISOString(),
      synced: true,
    };
  }

  async updateIncident(id: string, updates: Partial<SafetyIncident>): Promise<SafetyIncident> {
    console.log('Mock updateIncident:', id);
    return { id, ...updates } as SafetyIncident;
  }

  async deleteIncident(id: string): Promise<void> {
    console.log('Mock deleteIncident:', id);
  }

  // Hazard API methods
  async getHazards(): Promise<SafetyHazard[]> {
    console.log('Mock getHazards');
    return [
      {
        id: 'mock-hazard-1',
        hazardType: 'electrical',
        description: 'Mock electrical hazard for web demo',
        riskLevel: 'high',
        location: { latitude: 0, longitude: 0 },
        status: 'active',
        synced: true
      }
    ];
  }

  async createHazard(hazard: Omit<SafetyHazard, 'id' | 'synced'>): Promise<SafetyHazard> {
    console.log('Mock createHazard');
    return {
      ...hazard,
      id: 'mock-hazard-' + Date.now(),
      synced: true,
    };
  }

  async updateHazard(id: string, updates: Partial<SafetyHazard>): Promise<SafetyHazard> {
    console.log('Mock updateHazard:', id);
    return { id, ...updates } as SafetyHazard;
  }

  async deleteHazard(id: string): Promise<void> {
    console.log('Mock deleteHazard:', id);
  }

  // Equipment API methods
  async getEquipment(): Promise<Equipment[]> {
    console.log('Mock getEquipment');
    return [
      {
        id: 'mock-equipment-1',
        name: 'Demo Excavator',
        type: 'excavator',
        status: 'active',
        active: true,
        synced: true,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      }
    ];
  }

  async createEquipment(equipment: Omit<Equipment, 'id' | 'synced' | 'createdAt' | 'updatedAt'>): Promise<Equipment> {
    console.log('Mock createEquipment');
    return {
      ...equipment,
      id: 'mock-equipment-' + Date.now(),
      synced: true,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
  }

  async updateEquipment(id: string, updates: Partial<Equipment>): Promise<Equipment> {
    console.log('Mock updateEquipment:', id);
    return { 
      id, 
      ...updates,
      updatedAt: new Date().toISOString()
    } as Equipment;
  }

  async deleteEquipment(id: string): Promise<void> {
    console.log('Mock deleteEquipment:', id);
  }

  // Sync methods - just mark as synced
  async syncIncidents(incidents: SafetyIncident[]): Promise<{ synced: SafetyIncident[]; failed: string[] }> {
    console.log('Mock syncIncidents:', incidents.length);
    return { synced: incidents, failed: [] };
  }

  async syncHazards(hazards: SafetyHazard[]): Promise<{ synced: SafetyHazard[]; failed: string[] }> {
    console.log('Mock syncHazards:', hazards.length);
    return { synced: hazards, failed: [] };
  }

  async syncEquipment(equipment: Equipment[]): Promise<{ synced: Equipment[]; failed: string[] }> {
    console.log('Mock syncEquipment:', equipment.length);
    return { synced: equipment, failed: [] };
  }

  // File upload - mock implementation
  async uploadPhoto(photoUri: string, incidentId?: string): Promise<{ url: string }> {
    console.log('Mock uploadPhoto:', photoUri);
    return { url: 'mock-photo-url-' + Date.now() + '.jpg' };
  }
}

// Export singleton instance
export const apiService = new ApiService();
export default apiService;
