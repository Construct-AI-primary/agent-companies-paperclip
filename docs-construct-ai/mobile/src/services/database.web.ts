// Web-compatible database service using localStorage instead of SQLite
import { SafetyIncident, SafetyHazard } from '../store/slices/safetySlice';

// Equipment interface based on Supabase schema
export interface Equipment {
  id: string;
  name: string;
  equipmentCode?: string;
  type: string;
  subtype?: string;
  specifications?: any;
  make?: string;
  model?: string;
  serialNumber?: string;
  yearOfManufacture?: number;
  status: 'active' | 'maintenance' | 'decommissioned';
  location?: string;
  department?: string;
  fuelType?: string;
  lubricantType?: string;
  usageFrequency?: string;
  lastMaintenanceDate?: string;
  nextMaintenanceDate?: string;
  maintenanceCycleDays?: number;
  operatingHours?: number;
  healthScore?: number;
  lastPrediction?: 'healthy' | 'needs_maintenance' | 'critical';
  lastPredictionDate?: string;
  active: boolean;
  archived?: boolean;
  requiresMsd?: boolean;
  synced: boolean;
  createdAt?: string;
  updatedAt?: string;
}

// Web-compatible database using localStorage
const STORAGE_KEYS = {
  INCIDENTS: 'constructai_incidents',
  HAZARDS: 'constructai_hazards',
  EQUIPMENT: 'constructai_equipment',
  DB_INITIALIZED: 'constructai_db_initialized'
};

// Mock database for web compatibility
export const initDatabase = async (): Promise<void> => {
  try {
    // Check if database is already initialized
    if (localStorage.getItem(STORAGE_KEYS.DB_INITIALIZED)) {
      console.log('Web database already initialized');
      return;
    }

    // Initialize storage with empty arrays if not exists
    if (!localStorage.getItem(STORAGE_KEYS.INCIDENTS)) {
      localStorage.setItem(STORAGE_KEYS.INCIDENTS, JSON.stringify([]));
    }
    if (!localStorage.getItem(STORAGE_KEYS.HAZARDS)) {
      localStorage.setItem(STORAGE_KEYS.HAZARDS, JSON.stringify([]));
    }
    if (!localStorage.getItem(STORAGE_KEYS.EQUIPMENT)) {
      localStorage.setItem(STORAGE_KEYS.EQUIPMENT, JSON.stringify([]));
    }

    // Mark as initialized
    localStorage.setItem(STORAGE_KEYS.DB_INITIALIZED, 'true');
    console.log('Web database initialized successfully');
  } catch (error) {
    console.error('Error initializing web database:', error);
    throw error;
  }
};

// Helper function to get data from localStorage
const getData = <T>(key: string): T[] => {
  try {
    const data = localStorage.getItem(key);
    return data ? JSON.parse(data) : [];
  } catch (error) {
    console.error(`Error reading ${key}:`, error);
    return [];
  }
};

// Helper function to save data to localStorage
const saveData = (key: string, data: any[]): void => {
  try {
    localStorage.setItem(key, JSON.stringify(data));
  } catch (error) {
    console.error(`Error saving ${key}:`, error);
    throw error;
  }
};

// Equipment Operations
export const saveEquipment = async (equipment: Equipment): Promise<void> => {
  try {
    const equipmentList = getData<Equipment>(STORAGE_KEYS.EQUIPMENT);
    const existingIndex = equipmentList.findIndex(eq => eq.id === equipment.id);
    
    if (existingIndex >= 0) {
      equipmentList[existingIndex] = equipment;
    } else {
      equipmentList.push(equipment);
    }
    
    saveData(STORAGE_KEYS.EQUIPMENT, equipmentList);
    console.log('Equipment saved to web storage:', equipment.name);
  } catch (error) {
    console.error('Error saving equipment:', error);
    throw error;
  }
};

export const getEquipment = async (): Promise<Equipment[]> => {
  try {
    const equipment = getData<Equipment>(STORAGE_KEYS.EQUIPMENT);
    console.log('Retrieved equipment from web storage:', equipment.length);
    return equipment;
  } catch (error) {
    console.error('Error getting equipment:', error);
    return [];
  }
};

export const getUnsyncedEquipment = async (): Promise<Equipment[]> => {
  try {
    const equipment = getData<Equipment>(STORAGE_KEYS.EQUIPMENT);
    return equipment.filter(eq => !eq.synced);
  } catch (error) {
    console.error('Error getting unsynced equipment:', error);
    return [];
  }
};

export const updateEquipmentSyncStatus = async (id: string, synced: boolean): Promise<void> => {
  try {
    const equipment = getData<Equipment>(STORAGE_KEYS.EQUIPMENT);
    const item = equipment.find(eq => eq.id === id);
    if (item) {
      item.synced = synced;
      saveData(STORAGE_KEYS.EQUIPMENT, equipment);
    }
  } catch (error) {
    console.error('Error updating equipment sync status:', error);
    throw error;
  }
};

// Incident Operations
export const saveIncident = async (incident: SafetyIncident): Promise<void> => {
  try {
    const incidents = getData<SafetyIncident>(STORAGE_KEYS.INCIDENTS);
    const existingIndex = incidents.findIndex(inc => inc.id === incident.id);
    
    if (existingIndex >= 0) {
      incidents[existingIndex] = incident;
    } else {
      incidents.push(incident);
    }
    
    saveData(STORAGE_KEYS.INCIDENTS, incidents);
    console.log('Incident saved to web storage:', incident.id);
  } catch (error) {
    console.error('Error saving incident:', error);
    throw error;
  }
};

export const getIncidents = async (): Promise<SafetyIncident[]> => {
  try {
    const incidents = getData<SafetyIncident>(STORAGE_KEYS.INCIDENTS);
    console.log('Retrieved incidents from web storage:', incidents.length);
    return incidents.sort((a, b) => new Date(b.reportedAt).getTime() - new Date(a.reportedAt).getTime());
  } catch (error) {
    console.error('Error getting incidents:', error);
    return [];
  }
};

// Hazard Operations
export const saveHazard = async (hazard: SafetyHazard): Promise<void> => {
  try {
    const hazards = getData<SafetyHazard>(STORAGE_KEYS.HAZARDS);
    const existingIndex = hazards.findIndex(haz => haz.id === hazard.id);
    
    if (existingIndex >= 0) {
      hazards[existingIndex] = hazard;
    } else {
      hazards.push(hazard);
    }
    
    saveData(STORAGE_KEYS.HAZARDS, hazards);
    console.log('Hazard saved to web storage:', hazard.id);
  } catch (error) {
    console.error('Error saving hazard:', error);
    throw error;
  }
};

export const getHazards = async (): Promise<SafetyHazard[]> => {
  try {
    const hazards = getData<SafetyHazard>(STORAGE_KEYS.HAZARDS);
    console.log('Retrieved hazards from web storage:', hazards.length);
    return hazards;
  } catch (error) {
    console.error('Error getting hazards:', error);
    return [];
  }
};

// Sync Operations
export const updateIncidentSyncStatus = async (id: string, synced: boolean): Promise<void> => {
  try {
    const incidents = getData<SafetyIncident>(STORAGE_KEYS.INCIDENTS);
    const item = incidents.find(inc => inc.id === id);
    if (item) {
      item.synced = synced;
      saveData(STORAGE_KEYS.INCIDENTS, incidents);
    }
  } catch (error) {
    console.error('Error updating incident sync status:', error);
    throw error;
  }
};

export const updateHazardSyncStatus = async (id: string, synced: boolean): Promise<void> => {
  try {
    const hazards = getData<SafetyHazard>(STORAGE_KEYS.HAZARDS);
    const item = hazards.find(haz => haz.id === id);
    if (item) {
      item.synced = synced;
      saveData(STORAGE_KEYS.HAZARDS, hazards);
    }
  } catch (error) {
    console.error('Error updating hazard sync status:', error);
    throw error;
  }
};

export const getUnsyncedIncidents = async (): Promise<SafetyIncident[]> => {
  try {
    const incidents = getData<SafetyIncident>(STORAGE_KEYS.INCIDENTS);
    return incidents.filter(inc => !inc.synced);
  } catch (error) {
    console.error('Error getting unsynced incidents:', error);
    return [];
  }
};

export const getUnsyncedHazards = async (): Promise<SafetyHazard[]> => {
  try {
    const hazards = getData<SafetyHazard>(STORAGE_KEYS.HAZARDS);
    return hazards.filter(haz => !haz.synced);
  } catch (error) {
    console.error('Error getting unsynced hazards:', error);
    return [];
  }
};

// Database Statistics
export const getDatabaseStats = async (): Promise<{
  incidentCount: number;
  syncedIncidents: number;
  hazardCount: number;
  syncedHazards: number;
}> => {
  try {
    const incidents = getData<SafetyIncident>(STORAGE_KEYS.INCIDENTS);
    const hazards = getData<SafetyHazard>(STORAGE_KEYS.HAZARDS);
    
    return {
      incidentCount: incidents.length,
      syncedIncidents: incidents.filter(inc => inc.synced).length,
      hazardCount: hazards.length,
      syncedHazards: hazards.filter(haz => haz.synced).length,
    };
  } catch (error) {
    console.error('Error getting database stats:', error);
    return {
      incidentCount: 0,
      syncedIncidents: 0,
      hazardCount: 0,
      syncedHazards: 0,
    };
  }
};
