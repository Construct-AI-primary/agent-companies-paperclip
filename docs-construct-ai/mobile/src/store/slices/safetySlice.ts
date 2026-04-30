import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit';
import { RootState } from '../index';
import * as database from '../../services/database';
import { apiService } from '../../services/api';

// Define the types for our safety data
export interface SafetyIncident {
  id: string;
  incidentType: string;
  description: string;
  severity: 'low' | 'medium' | 'high' | 'critical';
  location?: {
    latitude: number;
    longitude: number;
    accuracy?: number;
  };
  photos: Array<{
    uri: string;
    timestamp: string;
    location?: any;
  }>;
  videos: Array<{
    uri: string;
    timestamp: string;
    duration?: number;
    location?: any;
    thumbnail?: string;
  }>;
  status: 'reported' | 'investigating' | 'resolved' | 'closed';
  synced: boolean;
  reportedBy?: string;
  reportedAt: string;
  immediateActions?: string;
}

export interface SafetyHazard {
  id: string;
  hazardType: string;
  description: string;
  riskLevel: 'low' | 'medium' | 'high';
  location?: {
    latitude: number;
    longitude: number;
  };
  status: 'active' | 'mitigated' | 'closed';
  synced: boolean;
}

// Define the state structure
interface SafetyState {
  incidents: SafetyIncident[];
  hazards: SafetyHazard[];
  loading: boolean;
  error: string | null;
  syncStatus: 'idle' | 'syncing' | 'success' | 'error';
}

// Initial state
const initialState: SafetyState = {
  incidents: [],
  hazards: [],
  loading: false,
  error: null,
  syncStatus: 'idle',
};

// Async thunks for database operations
export const loadIncidentsFromDB = createAsyncThunk<
  SafetyIncident[],
  void,
  { state: RootState }
>(
  'safety/loadIncidentsFromDB',
  async (_, { rejectWithValue }) => {
    try {
      const incidents = await database.getIncidents();
      return incidents;
    } catch (error) {
      return rejectWithValue('Failed to load incidents from database');
    }
  }
);

export const loadHazardsFromDB = createAsyncThunk<
  SafetyHazard[],
  void,
  { state: RootState }
>(
  'safety/loadHazardsFromDB',
  async (_, { rejectWithValue }) => {
    try {
      const hazards = await database.getHazards();
      return hazards;
    } catch (error) {
      return rejectWithValue('Failed to load hazards from database');
    }
  }
);

// Async thunks for API operations
export const addIncident = createAsyncThunk<
  SafetyIncident,
  Omit<SafetyIncident, 'id' | 'synced' | 'reportedAt'>,
  { state: RootState }
>(
  'safety/addIncident',
  async (incidentData, { rejectWithValue }) => {
    try {
      const newIncident: SafetyIncident = {
        ...incidentData,
        id: `incident_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
        synced: false,
        reportedAt: new Date().toISOString(),
      };

      // Save to database first (offline-first approach)
      await database.saveIncident(newIncident);

      // Try to sync with API if online
      try {
        const syncedIncident = await apiService.createIncident({
          ...incidentData,
          reportedBy: incidentData.reportedBy,
        });
        // Update local database with synced status
        await database.updateIncidentSyncStatus(newIncident.id, true);
        return { ...newIncident, synced: true };
      } catch (apiError) {
        // API call failed, but we still have the incident saved locally
        console.warn('Failed to sync incident with API:', apiError);
        return newIncident;
      }
    } catch (error) {
      return rejectWithValue('Failed to add incident');
    }
  }
);

// Sync operations
export const syncIncidents = createAsyncThunk<
  { syncedCount: number; failedCount: number },
  void,
  { state: RootState }
>(
  'safety/syncIncidents',
  async (_, { rejectWithValue }) => {
    try {
      // Get unsynced incidents from local database
      const unsyncedIncidents = await database.getUnsyncedIncidents();

      if (unsyncedIncidents.length === 0) {
        return { syncedCount: 0, failedCount: 0 };
      }

      // Sync with API
      const result = await apiService.syncIncidents(unsyncedIncidents);

      // Update sync status for successfully synced incidents
      for (const incident of result.synced) {
        await database.updateIncidentSyncStatus(incident.id, true);
      }

      return {
        syncedCount: result.synced.length,
        failedCount: result.failed.length,
      };
    } catch (error) {
      return rejectWithValue('Failed to sync incidents');
    }
  }
);

export const syncHazards = createAsyncThunk<
  { syncedCount: number; failedCount: number },
  void,
  { state: RootState }
>(
  'safety/syncHazards',
  async (_, { rejectWithValue }) => {
    try {
      // Get unsynced hazards from local database
      const unsyncedHazards = await database.getUnsyncedHazards();

      if (unsyncedHazards.length === 0) {
        return { syncedCount: 0, failedCount: 0 };
      }

      // Sync with API
      const result = await apiService.syncHazards(unsyncedHazards);

      // Update sync status for successfully synced hazards
      for (const hazard of result.synced) {
        await database.updateHazardSyncStatus(hazard.id, true);
      }

      return {
        syncedCount: result.synced.length,
        failedCount: result.failed.length,
      };
    } catch (error) {
      return rejectWithValue('Failed to sync hazards');
    }
  }
);

// Load data from API (for when user is online)
export const loadIncidentsFromAPI = createAsyncThunk<
  SafetyIncident[],
  void,
  { state: RootState }
>(
  'safety/loadIncidentsFromAPI',
  async (_, { rejectWithValue }) => {
    try {
      const incidents = await apiService.getIncidents();
      return incidents;
    } catch (error) {
      return rejectWithValue('Failed to load incidents from API');
    }
  }
);

export const loadHazardsFromAPI = createAsyncThunk<
  SafetyHazard[],
  void,
  { state: RootState }
>(
  'safety/loadHazardsFromAPI',
  async (_, { rejectWithValue }) => {
    try {
      const hazards = await apiService.getHazards();
      return hazards;
    } catch (error) {
      return rejectWithValue('Failed to load hazards from API');
    }
  }
);

// Create the slice
const safetySlice = createSlice({
  name: 'safety',
  initialState,
  reducers: {
    clearError: (state) => {
      state.error = null;
    },
    setSyncStatus: (state, action: PayloadAction<'idle' | 'syncing' | 'success' | 'error'>) => {
      state.syncStatus = action.payload;
    },
    updateIncident: (state, action: PayloadAction<Partial<SafetyIncident> & { id: string }>) => {
      const index = state.incidents.findIndex(incident => incident.id === action.payload.id);
      if (index !== -1) {
        state.incidents[index] = { ...state.incidents[index], ...action.payload };
      }
    },
    addHazard: (state, action: PayloadAction<SafetyHazard>) => {
      state.hazards.push(action.payload);
    },
  },
  extraReducers: (builder) => {
    builder
      // Load incidents from DB
      .addCase(loadIncidentsFromDB.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(loadIncidentsFromDB.fulfilled, (state, action) => {
        state.loading = false;
        state.incidents = action.payload;
      })
      .addCase(loadIncidentsFromDB.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      })
      // Load hazards from DB
      .addCase(loadHazardsFromDB.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(loadHazardsFromDB.fulfilled, (state, action) => {
        state.loading = false;
        state.hazards = action.payload;
      })
      .addCase(loadHazardsFromDB.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      })
      // Add incident
      .addCase(addIncident.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(addIncident.fulfilled, (state, action) => {
        state.loading = false;
        state.incidents.unshift(action.payload);
      })
      .addCase(addIncident.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      })
      // Sync incidents
      .addCase(syncIncidents.pending, (state) => {
        state.syncStatus = 'syncing';
        state.error = null;
      })
      .addCase(syncIncidents.fulfilled, (state, action) => {
        state.syncStatus = 'success';
        // Update synced status in local state
        state.incidents = state.incidents.map(incident =>
          incident.synced ? incident : { ...incident, synced: true }
        );
      })
      .addCase(syncIncidents.rejected, (state, action) => {
        state.syncStatus = 'error';
        state.error = action.payload as string;
      })
      // Sync hazards
      .addCase(syncHazards.pending, (state) => {
        state.syncStatus = 'syncing';
        state.error = null;
      })
      .addCase(syncHazards.fulfilled, (state, action) => {
        state.syncStatus = 'success';
        // Update synced status in local state
        state.hazards = state.hazards.map(hazard =>
          hazard.synced ? hazard : { ...hazard, synced: true }
        );
      })
      .addCase(syncHazards.rejected, (state, action) => {
        state.syncStatus = 'error';
        state.error = action.payload as string;
      })
      // Load incidents from API
      .addCase(loadIncidentsFromAPI.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(loadIncidentsFromAPI.fulfilled, (state, action) => {
        state.loading = false;
        state.incidents = action.payload;
      })
      .addCase(loadIncidentsFromAPI.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      })
      // Load hazards from API
      .addCase(loadHazardsFromAPI.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(loadHazardsFromAPI.fulfilled, (state, action) => {
        state.loading = false;
        state.hazards = action.payload;
      })
      .addCase(loadHazardsFromAPI.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      });
  },
});

// Export actions
export const { clearError, setSyncStatus, updateIncident, addHazard } = safetySlice.actions;

// Export reducer
export default safetySlice.reducer;
