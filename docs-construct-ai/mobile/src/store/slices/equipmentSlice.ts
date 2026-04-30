import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit';
import { RootState } from '../index';
import * as database from '../../services/database';
import { apiService } from '../../services/api';
import { Equipment } from '../../services/database';

// Define the state structure
interface EquipmentState {
  equipment: Equipment[];
  loading: boolean;
  error: string | null;
  syncStatus: 'idle' | 'syncing' | 'success' | 'error';
  aiInsights: {
    totalEquipment: number;
    avgHealthScore: number;
    criticalEquipment: number;
    upcomingMaintenance: number;
    costSavings: number;
    predictionsAccuracy: number;
    optimizationOpportunities: number;
  };
  maintenanceTasks: any[];
  alerts: any[];
}

// Initial state
const initialState: EquipmentState = {
  equipment: [],
  loading: false,
  error: null,
  syncStatus: 'idle',
  aiInsights: {
    totalEquipment: 0,
    avgHealthScore: 0,
    criticalEquipment: 0,
    upcomingMaintenance: 0,
    costSavings: 0,
    predictionsAccuracy: 0,
    optimizationOpportunities: 0,
  },
  maintenanceTasks: [],
  alerts: [],
};

// Async thunks for database operations
export const loadEquipmentFromDB = createAsyncThunk<
  Equipment[],
  void,
  { state: RootState }
>(
  'equipment/loadEquipmentFromDB',
  async (_, { rejectWithValue }) => {
    try {
      const equipment = await database.getEquipment();
      return equipment;
    } catch (error) {
      return rejectWithValue('Failed to load equipment from database');
    }
  }
);

// Async thunk for adding equipment
export const addEquipment = createAsyncThunk<
  Equipment,
  Omit<Equipment, 'id' | 'synced' | 'createdAt' | 'updatedAt'> & { synced?: boolean },
  { state: RootState }
>(
  'equipment/addEquipment',
  async (equipmentData, { rejectWithValue }) => {
    try {
      const newEquipment: Equipment = {
        ...equipmentData,
        id: `equipment_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
        synced: false,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      };

      // Save to database first (offline-first approach)
      await database.saveEquipment(newEquipment);

      // Try to sync with API if online
      try {
        const syncedEquipment = await apiService.createEquipment(equipmentData);
        // Update local database with synced status
        await database.updateEquipmentSyncStatus(newEquipment.id, true);
        return { ...newEquipment, synced: true };
      } catch (apiError) {
        // API call failed, but we still have the equipment saved locally
        console.warn('Failed to sync equipment with API:', apiError);
        return newEquipment;
      }
    } catch (error) {
      return rejectWithValue('Failed to add equipment');
    }
  }
);

// Sync operations
export const syncEquipment = createAsyncThunk<
  { syncedCount: number; failedCount: number },
  void,
  { state: RootState }
>(
  'equipment/syncEquipment',
  async (_, { rejectWithValue }) => {
    try {
      // Get unsynced equipment from local database
      const unsyncedEquipment = await database.getUnsyncedEquipment();

      if (unsyncedEquipment.length === 0) {
        return { syncedCount: 0, failedCount: 0 };
      }

      // Sync with API
      const result = await apiService.syncEquipment(unsyncedEquipment);

      // Update sync status for successfully synced equipment
      for (const item of result.synced) {
        await database.updateEquipmentSyncStatus(item.id, true);
      }

      return {
        syncedCount: result.synced.length,
        failedCount: result.failed.length,
      };
    } catch (error) {
      return rejectWithValue('Failed to sync equipment');
    }
  }
);

// Load data from API (for when user is online)
export const loadEquipmentFromAPI = createAsyncThunk<
  Equipment[],
  void,
  { state: RootState }
>(
  'equipment/loadEquipmentFromAPI',
  async (_, { rejectWithValue }) => {
    try {
      const equipment = await apiService.getEquipment();
      return equipment;
    } catch (error) {
      return rejectWithValue('Failed to load equipment from API');
    }
  }
);

// Create the slice
const equipmentSlice = createSlice({
  name: 'equipment',
  initialState,
  reducers: {
    clearError: (state) => {
      state.error = null;
    },
    setSyncStatus: (state, action: PayloadAction<'idle' | 'syncing' | 'success' | 'error'>) => {
      state.syncStatus = action.payload;
    },
    updateEquipment: (state, action: PayloadAction<Partial<Equipment> & { id: string }>) => {
      const index = state.equipment.findIndex(item => item.id === action.payload.id);
      if (index !== -1) {
        state.equipment[index] = { ...state.equipment[index], ...action.payload };
      }
    },
    updateAIInsights: (state, action: PayloadAction<Partial<EquipmentState['aiInsights']>>) => {
      state.aiInsights = { ...state.aiInsights, ...action.payload };
    },
    generateAIPrediction: (state, action: PayloadAction<{ equipmentId: string }>) => {
      // Simulate AI prediction generation
      const randomHealthScore = Math.floor(Math.random() * 30) + 70; // 70-100
      const randomPrediction = Math.random() > 0.7 ? 'needs_maintenance' : 'healthy';
      
      // Update equipment with prediction
      const equipmentIndex = state.equipment.findIndex(item => item.id === action.payload.equipmentId);
      if (equipmentIndex !== -1) {
        state.equipment[equipmentIndex] = {
          ...state.equipment[equipmentIndex],
          healthScore: randomHealthScore,
          lastPrediction: randomPrediction,
          lastPredictionDate: new Date().toISOString(),
        };
      }
      
      // Update AI insights
      state.aiInsights.predictionsAccuracy = Math.floor(Math.random() * 20) + 80; // 80-100%
      state.aiInsights.optimizationOpportunities += Math.floor(Math.random() * 3);
    },
    completeMaintenanceTask: (state, action: PayloadAction<{ taskId: string }>) => {
      // Remove completed task from maintenance tasks
      state.maintenanceTasks = state.maintenanceTasks.filter(
        task => task.id !== action.payload.taskId
      );
      
      // Update AI insights
      state.aiInsights.upcomingMaintenance = Math.max(0, state.aiInsights.upcomingMaintenance - 1);
      state.aiInsights.costSavings += Math.floor(Math.random() * 1000) + 500;
    },
  },
  extraReducers: (builder) => {
    builder
      // Load equipment from DB
      .addCase(loadEquipmentFromDB.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(loadEquipmentFromDB.fulfilled, (state, action) => {
        state.loading = false;
        state.equipment = action.payload;
      })
      .addCase(loadEquipmentFromDB.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      })
      // Add equipment
      .addCase(addEquipment.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(addEquipment.fulfilled, (state, action) => {
        state.loading = false;
        state.equipment.unshift(action.payload);
      })
      .addCase(addEquipment.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      })
      // Sync equipment
      .addCase(syncEquipment.pending, (state) => {
        state.syncStatus = 'syncing';
        state.error = null;
      })
      .addCase(syncEquipment.fulfilled, (state, action) => {
        state.syncStatus = 'success';
        // Update synced status in local state
        state.equipment = state.equipment.map(item =>
          item.synced ? item : { ...item, synced: true }
        );
      })
      .addCase(syncEquipment.rejected, (state, action) => {
        state.syncStatus = 'error';
        state.error = action.payload as string;
      })
      // Load equipment from API
      .addCase(loadEquipmentFromAPI.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(loadEquipmentFromAPI.fulfilled, (state, action) => {
        state.loading = false;
        state.equipment = action.payload;
      })
      .addCase(loadEquipmentFromAPI.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      });
  },
});

// Export actions
export const { clearError, setSyncStatus, updateEquipment, updateAIInsights, completeMaintenanceTask, generateAIPrediction } = equipmentSlice.actions;

// Export reducer
export default equipmentSlice.reducer;
