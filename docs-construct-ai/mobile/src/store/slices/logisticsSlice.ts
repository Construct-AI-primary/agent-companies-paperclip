import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit';

// Define the types for logistics data
export interface LogisticsLoad {
  id: string;
  reference: string;
  status: 'planning' | 'loading' | 'in_transit' | 'delivered' | 'delayed';
  origin: {
    name: string;
    lat: number;
    lng: number;
  };
  destination: {
    name: string;
    lat: number;
    lng: number;
  };
  items: LoadItem[];
  vehicle: {
    id: string;
    name: string;
    driver: string;
  };
  eta: string;
  actualArrival?: string;
  weight: number;
  value: number;
  createdAt: string;
  updatedAt: string;
}

export interface LoadItem {
  id: string;
  description: string;
  quantity: number;
  unitPrice: number;
  weight: number;
  damaged: boolean;
  damageDescription?: string;
  photos: string[];
}

export interface InspectionReport {
  id: string;
  loadId: string;
  inspectorId: string;
  inspectorName: string;
  inspectionType: 'pre_loading' | 'during_loading' | 'destination';
  location: {
    lat: number;
    lng: number;
    description: string;
  };
  items: InspectionItem[];
  aiAnalysis: AIAnalysisResult[];
  overallStatus: 'passed' | 'failed' | 'partial';
  recommendations: string[];
  createdAt: string;
  synced: boolean;
}

export interface InspectionItem {
  id: string;
  itemId: string;
  condition: 'excellent' | 'good' | 'fair' | 'poor' | 'damaged';
  description: string;
  aiConfidence: number;
  comments?: string;
  photos: string[];
}

export interface AIAnalysisResult {
  type: 'damage_detection' | 'counting' | 'classification' | 'anomaly_detection';
  confidence: number;
  findings: string[];
  recommendation: string;
  evidence: string[]; // URLs to photos/videos
}

export interface InsuranceClaim {
  id: string;
  loadId: string;
  inspectionId: string;
  claimType: 'damage' | 'overage' | 'shortage' | 'loss';
  description: string;
  estimatedValue: number;
  aiAssessment: {
    severity: 'low' | 'medium' | 'high' | 'critical';
    confidence: number;
    automatedReport: string;
  };
  status: 'draft' | 'submitted' | 'under_review' | 'approved' | 'rejected' | 'paid';
  documents: string[];
  createdAt: string;
}

// Define the state structure
interface LogisticsState {
  loads: LogisticsLoad[];
  inspections: InspectionReport[];
  claims: InsuranceClaim[];
  loading: boolean;
  error: string | null;
  syncStatus: 'idle' | 'syncing' | 'success' | 'error';
  activeLoad?: LogisticsLoad;
  aiInsights: {
    damageDetections: number;
    accuracy: number;
    processingSpeed: number;
    recommendations: string[];
  };
}

// Async thunks for API operations
export const createLogisticsLoad = createAsyncThunk(
  'logistics/createLoad',
  async (loadData: Omit<LogisticsLoad, 'id' | 'status' | 'createdAt' | 'updatedAt'>, { rejectWithValue }) => {
    try {
      // Integrate with backend API - for now return mock data
      const newLoad: LogisticsLoad = {
        ...loadData,
        id: `load_${Date.now()}`,
        status: 'planning',
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      };
      return newLoad;
    } catch (error) {
      return rejectWithValue('Failed to create logistics load');
    }
  }
);

export const createInspectionReport = createAsyncThunk(
  'logistics/createInspection',
  async (inspectionData: Omit<InspectionReport, 'id' | 'createdAt' | 'synced'>, { rejectWithValue }) => {
    try {
      const newInspection: InspectionReport = {
        ...inspectionData,
        id: `inspection_${Date.now()}`,
        createdAt: new Date().toISOString(),
        synced: false,
      };
      return newInspection;
    } catch (error) {
      return rejectWithValue('Failed to create inspection report');
    }
  }
);

// Create the slice
const logisticsSlice = createSlice({
  name: 'logistics',
  initialState: {
    loads: [],
    inspections: [],
    claims: [],
    loading: false,
    error: null,
    syncStatus: 'idle',
    aiInsights: {
      damageDetections: 0,
      accuracy: 96.0,
      processingSpeed: 2.1,
      recommendations: [],
    },
  } as LogisticsState,
  reducers: {
    clearError: (state) => {
      state.error = null;
    },
    setSyncStatus: (state, action: PayloadAction<'idle' | 'syncing' | 'success' | 'error'>) => {
      state.syncStatus = action.payload;
    },
    updateLoadStatus: (state, action: PayloadAction<{ loadId: string; status: LogisticsLoad['status'] }>) => {
      const load = state.loads.find(l => l.id === action.payload.loadId);
      if (load) {
        load.status = action.payload.status;
        load.updatedAt = new Date().toISOString();
      }
    },
    setActiveLoad: (state, action: PayloadAction<LogisticsLoad | undefined>) => {
      state.activeLoad = action.payload;
    },
    updateLoadItem: (state, action: PayloadAction<{ loadId: string; itemId: string; updates: Partial<LoadItem> }>) => {
      const load = state.loads.find(l => l.id === action.payload.loadId);
      if (load) {
        const item = load.items.find(i => i.id === action.payload.itemId);
        if (item) {
          Object.assign(item, action.payload.updates);
        }
      }
    },
    updateAIInsights: (state, action: PayloadAction<Partial<LogisticsState['aiInsights']>>) => {
      state.aiInsights = { ...state.aiInsights, ...action.payload };
    },
    addDamageDetection: (state) => {
      state.aiInsights.damageDetections += 1;
    },
  },
  extraReducers: (builder) => {
    builder
      // Create load
      .addCase(createLogisticsLoad.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(createLogisticsLoad.fulfilled, (state, action) => {
        state.loading = false;
        state.loads.push(action.payload);
      })
      .addCase(createLogisticsLoad.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      })

      // Create inspection
      .addCase(createInspectionReport.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(createInspectionReport.fulfilled, (state, action) => {
        state.loading = false;
        state.inspections.push(action.payload);
        // Update AI insights based on inspection results
        const aiResults = action.payload.aiAnalysis;
        state.aiInsights.damageDetections += aiResults.filter(r => r.type === 'damage_detection').length;
      })
      .addCase(createInspectionReport.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      });
  },
});

// Export actions
export const {
  clearError,
  setSyncStatus,
  updateLoadStatus,
  setActiveLoad,
  updateLoadItem,
  updateAIInsights,
  addDamageDetection,
} = logisticsSlice.actions;

// Export reducer
export default logisticsSlice.reducer;
