import { SafetyIncident, SafetyHazard } from '../store/slices/safetySlice';

// Check if we're in a web environment
const isWeb = typeof window !== 'undefined' && window.document;

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

// Web-compatible database implementation
if (isWeb) {
  // Import and re-export web database functions
  const webModule = require('./database.web');
  
  // Re-export all functions from web module
  export const initDatabase = webModule.initDatabase;
  export const saveEquipment = webModule.saveEquipment;
  export const getEquipment = webModule.getEquipment;
  export const getUnsyncedEquipment = webModule.getUnsyncedEquipment;
  export const updateEquipmentSyncStatus = webModule.updateEquipmentSyncStatus;
  export const saveIncident = webModule.saveIncident;
  export const getIncidents = webModule.getIncidents;
  export const saveHazard = webModule.saveHazard;
  export const getHazards = webModule.getHazards;
  export const updateIncidentSyncStatus = webModule.updateIncidentSyncStatus;
  export const updateHazardSyncStatus = webModule.updateHazardSyncStatus;
  export const getUnsyncedIncidents = webModule.getUnsyncedIncidents;
  export const getUnsyncedHazards = webModule.getUnsyncedHazards;
  export const getDatabaseStats = webModule.getDatabaseStats;
  
} else {
  // Native SQLite implementation for mobile
  const { openDatabaseSync } = require('expo-sqlite');
  
  interface SQLResultSet {
    insertId?: number;
    rowsAffected: number;
    rows: {
      length: number;
      item(index: number): any;
      _array: any[];
    };
  }

  interface SQLError {
    code: number;
    message: string;
  }

  interface SQLTransaction {
    executeSql: (
      sql: string,
      params?: any[],
      successCallback?: (transaction: SQLTransaction, resultSet: SQLResultSet) => void,
      errorCallback?: (transaction: SQLTransaction, error: SQLError) => void
    ) => void;
  }

  const db = openDatabaseSync('constructai_safety.db') as any; // Temporary workaround for type issues

  // Database initialization
  export const initDatabase = (): Promise<void> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          `CREATE TABLE IF NOT EXISTS incidents (
            id TEXT PRIMARY KEY,
            incidentType TEXT NOT NULL,
            description TEXT NOT NULL,
            severity TEXT NOT NULL,
            location TEXT,
            photos TEXT,
            status TEXT DEFAULT 'reported',
            synced INTEGER DEFAULT 0,
            reportedBy TEXT,
            reportedAt TEXT NOT NULL,
            immediateActions TEXT
          )`,
          [],
          () => console.log('Incidents table created'),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error creating incidents:', error);
            return false;
          }
        );

        tx.executeSql(
          `CREATE TABLE IF NOT EXISTS hazards (
            id TEXT PRIMARY KEY,
            hazardType TEXT NOT NULL,
            description TEXT NOT NULL,
            riskLevel TEXT NOT NULL,
            location TEXT,
            status TEXT DEFAULT 'active',
            synced INTEGER DEFAULT 0,
            reportedAt TEXT NOT NULL
          )`,
          [],
          () => console.log('Hazards table created'),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error creating hazards:', error);
            return false;
          }
        );

        tx.executeSql(
          `CREATE TABLE IF NOT EXISTS equipment (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            equipmentCode TEXT,
            type TEXT NOT NULL,
            subtype TEXT,
            specifications TEXT,
            make TEXT,
            model TEXT,
            serialNumber TEXT,
            yearOfManufacture INTEGER,
            status TEXT DEFAULT 'active',
            location TEXT,
            department TEXT,
            fuelType TEXT,
            lubricantType TEXT,
            usageFrequency TEXT,
            lastMaintenanceDate TEXT,
            nextMaintenanceDate TEXT,
            maintenanceCycleDays INTEGER,
            operatingHours INTEGER,
            active INTEGER DEFAULT 1,
            archived INTEGER DEFAULT 0,
            requiresMsd INTEGER DEFAULT 0,
            synced INTEGER DEFAULT 0,
            createdAt TEXT,
            updatedAt TEXT
          )`,
          [],
          () => console.log('Equipment table created'),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error creating equipment:', error);
            return false;
          }
        );
      }, 
      (error: SQLError) => reject(error),
      () => resolve()
      );
    });
  };

  export const saveEquipment = (equipment: Equipment): Promise<void> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          `INSERT OR REPLACE INTO equipment (
            id, name, equipmentCode, type, subtype, specifications, make, model, 
            serialNumber, yearOfManufacture, status, location, department, 
            fuelType, lubricantType, usageFrequency, lastMaintenanceDate, 
            nextMaintenanceDate, maintenanceCycleDays, operatingHours, 
            active, archived, requiresMsd, synced, createdAt, updatedAt
           ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
          [
            equipment.id,
            equipment.name,
            equipment.equipmentCode || null,
            equipment.type,
            equipment.subtype || null,
            JSON.stringify(equipment.specifications || null),
            equipment.make || null,
            equipment.model || null,
            equipment.serialNumber || null,
            equipment.yearOfManufacture || null,
            equipment.status,
            equipment.location || null,
            equipment.department || null,
            equipment.fuelType || null,
            equipment.lubricantType || null,
            equipment.usageFrequency || null,
            equipment.lastMaintenanceDate || null,
            equipment.nextMaintenanceDate || null,
            equipment.maintenanceCycleDays || null,
            equipment.operatingHours || null,
            equipment.active ? 1 : 0,
            equipment.archived ? 1 : 0,
            equipment.requiresMsd ? 1 : 0,
            equipment.synced ? 1 : 0,
            equipment.createdAt || new Date().toISOString(),
            equipment.updatedAt || new Date().toISOString()
          ],
          () => resolve(),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error saving equipment:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  export const getEquipment = (): Promise<Equipment[]> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          'SELECT * FROM equipment',
          [],
          (_: SQLTransaction, { rows }: SQLResultSet) => resolve(rows._array.map(parseEquipment)),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error getting equipment:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  export const getUnsyncedEquipment = (): Promise<Equipment[]> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          'SELECT * FROM equipment WHERE synced = 0',
          [],
          (_: SQLTransaction, { rows }: SQLResultSet) => resolve(rows._array.map(parseEquipment)),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error getting unsynced equipment:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  export const updateEquipmentSyncStatus = (id: string, synced: boolean): Promise<void> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          'UPDATE equipment SET synced = ? WHERE id = ?',
          [synced ? 1 : 0, id],
          () => resolve(),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error updating sync status:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  // Incident Operations
  export const saveIncident = (incident: SafetyIncident): Promise<void> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          `INSERT OR REPLACE INTO incidents (
            id, incidentType, description, severity, location, photos, status,
            synced, reportedBy, reportedAt, immediateActions
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
          [
            incident.id,
            incident.incidentType,
            incident.description,
            incident.severity,
            JSON.stringify(incident.location || null),
            JSON.stringify(incident.photos || []),
            incident.status,
            incident.synced ? 1 : 0,
            incident.reportedBy,
            incident.reportedAt,
            incident.immediateActions || null
          ],
          () => resolve(),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error saving incident:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  export const getIncidents = (): Promise<SafetyIncident[]> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          'SELECT * FROM incidents ORDER BY reportedAt DESC',
          [],
          (_: SQLTransaction, { rows }: SQLResultSet) => resolve(rows._array.map(parseIncident)),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error getting incidents:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  // Hazard Operations
  export const saveHazard = (hazard: SafetyHazard): Promise<void> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          `INSERT OR REPLACE INTO hazards (
            id, hazardType, description, riskLevel, location, status, synced, reportedAt
          ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
          [
            hazard.id,
            hazard.hazardType,
            hazard.description,
            hazard.riskLevel,
            JSON.stringify(hazard.location || null),
            hazard.status,
            hazard.synced ? 1 : 0,
            new Date().toISOString()
          ],
          () => resolve(),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error saving hazard:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  export const getHazards = (): Promise<SafetyHazard[]> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          'SELECT * FROM hazards ORDER BY reportedAt DESC',
          [],
          (_: SQLTransaction, { rows }: SQLResultSet) => resolve(rows._array.map(parseHazard)),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error getting hazards:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  export const updateHazardSyncStatus = (id: string, synced: boolean): Promise<void> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          'UPDATE hazards SET synced = ? WHERE id = ?',
          [synced ? 1 : 0, id],
          () => resolve(),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error updating hazard sync status:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };


  // Incident Sync Operations
  export const updateIncidentSyncStatus = (id: string, synced: boolean): Promise<void> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          'UPDATE incidents SET synced = ? WHERE id = ?',
          [synced ? 1 : 0, id],
          () => resolve(),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error updating incident sync status:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  export const getUnsyncedIncidents = (): Promise<SafetyIncident[]> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          'SELECT * FROM incidents WHERE synced = 0',
          [],
          (_: SQLTransaction, { rows }: SQLResultSet) => resolve(rows._array.map(parseIncident)),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error getting unsynced incidents:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  export const getUnsyncedHazards = (): Promise<SafetyHazard[]> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        tx.executeSql(
          'SELECT * FROM hazards WHERE synced = 0',
          [],
          (_: SQLTransaction, { rows }: SQLResultSet) => resolve(rows._array.map(parseHazard)),
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error getting unsynced hazards:', error);
            reject(error);
            return false;
          }
        );
      });
    });
  };

  // Database statistics
  export const getDatabaseStats = (): Promise<{
    incidentCount: number;
    syncedIncidents: number;
    hazardCount: number;
    syncedHazards: number;
  }> => {
    return new Promise((resolve, reject) => {
      db.transaction((tx: SQLTransaction) => {
        let incidentStats: { total: number; synced: number } | null = null;
        let hazardStats: { total: number; synced: number } | null = null;
        
        // Get total incidents and synced incidents
        tx.executeSql(
          'SELECT COUNT(*) as total, SUM(synced) as synced FROM incidents',
          [],
          (_: SQLTransaction, { rows }: SQLResultSet) => {
            incidentStats = rows._array[0] || { total: 0, synced: 0 };
            
            // Check if we have both results
            if (hazardStats && incidentStats) {
              resolve({
                incidentCount: incidentStats.total || 0,
                syncedIncidents: incidentStats.synced || 0,
                hazardCount: hazardStats.total || 0,
                syncedHazards: hazardStats.synced || 0,
              });
            }
          },
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error getting incident stats:', error);
            if (hazardStats) {
              reject(error);
            }
            return false;
          }
        );
        
        // Get total hazards and synced hazards
        tx.executeSql(
          'SELECT COUNT(*) as total, SUM(synced) as synced FROM hazards',
          [],
          (_: SQLTransaction, { rows }: SQLResultSet) => {
            hazardStats = rows._array[0] || { total: 0, synced: 0 };
            
            // Check if we have both results
            if (incidentStats) {
              resolve({
                incidentCount: incidentStats.total || 0,
                syncedIncidents: incidentStats.synced || 0,
                hazardCount: hazardStats.total || 0,
                syncedHazards: hazardStats.synced || 0,
              });
            }
          },
          (_: SQLTransaction, error: SQLError) => {
            console.error('Error getting hazard stats:', error);
            if (incidentStats) {
              reject(error);
            }
            return false;
          }
        );
      });
    });
  };

  // Helper functions
  const parseEquipment = (row: any): Equipment => ({
    ...row,
    active: row.active === 1,
    archived: row.archived === 1,
    requiresMsd: row.requiresMsd === 1,
    synced: row.synced === 1,
    specifications: row.specifications ? JSON.parse(row.specifications) : null
  });

  // Helper functions
  const parseHazard = (row: any): SafetyHazard => ({
    ...row,
    synced: row.synced === 1,
    location: row.location ? JSON.parse(row.location) : null
  });

  const parseIncident = (row: any): SafetyIncident => ({
    ...row,
    synced: row.synced === 1,
    location: row.location ? JSON.parse(row.location) : null,
    photos: row.photos ? JSON.parse(row.photos) : []
  });
}
