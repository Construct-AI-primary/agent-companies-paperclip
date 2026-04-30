import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit';

// Define the types for stock management data
export interface StockItem {
  id: string;
  sku: string;
  name: string;
  description: string;
  category: string;
  quantity: number;
  minStockLevel: number;
  maxStockLevel: number;
  unitCost: number;
  supplierId: string;
  location: StockLocation;
  expiryDate?: string;
  barcode?: string;
  imageUrl?: string;
  aiClassification: AIClassification;
  lastUpdated: string;
  createdAt: string;
}

export interface StockLocation {
  warehouseId: string;
  warehouseName: string;
  aisle: string;
  shelf: string;
  bin: string;
  latitude?: number;
  longitude?: number;
}

export interface AIClassification {
  confidence: number;
  category: string;
  subcategory: string;
  tags: string[];
  expiryRisk: 'low' | 'medium' | 'high' | 'critical';
  demandTrend: 'increasing' | 'stable' | 'decreasing';
  reorderUrgency: 'low' | 'medium' | 'high' | 'critical';
  anomalies: string[];
}

export interface StockMovement {
  id: string;
  itemId: string;
  type: 'in' | 'out' | 'transfer' | 'adjustment';
  quantity: number;
  reason: string;
  locationFrom?: StockLocation;
  locationTo?: StockLocation;
  userId: string;
  timestamp: string;
  aiValidated: boolean;
  aiConfidence: number;
}

export interface StockAlert {
  id: string;
  itemId: string;
  type: 'low_stock' | 'out_of_stock' | 'expiry_soon' | 'overstock' | 'anomaly';
  severity: 'low' | 'medium' | 'high' | 'critical';
  message: string;
  aiRecommendation: string;
  createdAt: string;
  acknowledged: boolean;
  acknowledgedBy?: string;
  acknowledgedAt?: string;
}

// Define the state structure
interface StockState {
  items: StockItem[];
  movements: StockMovement[];
  alerts: StockAlert[];
  locations: StockLocation[];
  loading: boolean;
  error: string | null;
  syncStatus: 'idle' | 'syncing' | 'success' | 'error';

  // AI Analytics
  aiInsights: {
    totalItemsTracked: number;
    accuracyRate: number;
    detectionsToday: number;
    alertsResolved: number;
    stockOptimization: {
      overstockValue: number;
      stockoutPrevention: number;
      expiryPrevention: number;
    };
    predictions: AIPrediction[];
  };

  // Scan and Add modes
  scanMode: 'barcode' | 'image' | 'manual';
  currentScanLocation?: StockLocation;
}

export interface AIPrediction {
  itemId: string;
  type: 'demand' | 'expiry' | 'maintenance' | 'supplier_issue';
  confidence: number;
  prediction: string;
  actionable: boolean;
  dueDate?: string;
}

// Async thunks for API operations
export const scanStockItem = createAsyncThunk(
  'stock/scanItem',
  async ({ imageUri, barcode }: { imageUri?: string, barcode?: string }, { rejectWithValue }) => {
    try {
      // Simulate AI processing
      const processingTime = Math.random() * 2 + 1; // 1-3 seconds
      await new Promise(resolve => setTimeout(resolve, processingTime * 1000));

      const aiResult = {
        detectedItems: [
          {
            sku: 'CONST-MATER-001',
            name: 'Steel Reinforcement Bars',
            confidence: 0.94,
            quantity: 50,
            location: { aisle: 'A', shelf: '03', bin: '12' },
            category: 'Construction Materials',
            expiryRisk: 'low' as const,
            demandTrend: 'increasing' as const,
          }
        ],
        undetectedConfidence: 0.87,
        processingTime: processingTime,
        anomalies: ['irregular_stacking', 'dust_accumulation'],
        recommendations: [
          'Recommend restacking for better organization',
          'Schedule cleaning next maintenance cycle',
          'Consider dividing stock across multiple bins for faster access'
        ],
      };

      return aiResult;
    } catch (error) {
      return rejectWithValue('AI scan failed');
    }
  }
);

export const addStockItem = createAsyncThunk(
  'stock/addItem',
  async (itemData: Omit<StockItem, 'id' | 'createdAt' | 'lastUpdated'>, { rejectWithValue }) => {
    try {
      const newItem: StockItem = {
        ...itemData,
        id: `stock_${Date.now()}`,
        createdAt: new Date().toISOString(),
        lastUpdated: new Date().toISOString(),
      };
      return newItem;
    } catch (error) {
      return rejectWithValue('Failed to add stock item');
    }
  }
);

export const generateStockReport = createAsyncThunk(
  'stock/generateReport',
  async ({ type }: { type: 'inventory' | 'movements' | 'forecast' }) => {
    // Simulate report generation
    await new Promise(resolve => setTimeout(resolve, 2000));

    return {
      reportType: type,
      generatedAt: new Date().toISOString(),
      data: {
        totalValue: 125000,
        itemsCount: 1200,
        lowStockItems: 23,
        expiringSoon: 8,
        aiOptimizations: [
          'Reorganize storage layout to reduce retrieval time by 18%',
          'Implement just-in-time ordering for 15 high-demand items',
          'Schedule preventive maintenance for 5 temperature-sensitive items',
        ],
      },
    };
  }
);

// Create the slice
const stockSlice = createSlice({
  name: 'stock',
  initialState: {
    items: [],
    movements: [],
    alerts: [],
    locations: [],
    loading: false,
    error: null,
    syncStatus: 'idle',
    scanMode: 'image' as const,

    aiInsights: {
      totalItemsTracked: 0,
      accuracyRate: 95.2,
      detectionsToday: 0,
      alertsResolved: 0,
      stockOptimization: {
        overstockValue: 0,
        stockoutPrevention: 0,
        expiryPrevention: 0,
      },
      predictions: [],
    },
  } as StockState,
  reducers: {
    clearError: (state) => {
      state.error = null;
    },
    setSyncStatus: (state, action: PayloadAction<'idle' | 'syncing' | 'success' | 'error'>) => {
      state.syncStatus = action.payload;
    },
    setScanMode: (state, action: PayloadAction<'barcode' | 'image' | 'manual'>) => {
      state.scanMode = action.payload;
    },
    setCurrentScanLocation: (state, action: PayloadAction<StockLocation | undefined>) => {
      state.currentScanLocation = action.payload;
    },
    updateStockQuantity: (state, action: PayloadAction<{ itemId: string; quantity: number; reason: string }>) => {
      const item = state.items.find(i => i.id === action.payload.itemId);
      if (item) {
        const oldQuantity = item.quantity;
        item.quantity = action.payload.quantity;
        item.lastUpdated = new Date().toISOString();

        // Add movement record
        state.movements.unshift({
          id: `movement_${Date.now()}`,
          itemId: action.payload.itemId,
          type: action.payload.quantity > oldQuantity ? 'in' : 'out',
          quantity: Math.abs(action.payload.quantity - oldQuantity),
          reason: action.payload.reason,
          timestamp: new Date().toISOString(),
          userId: 'current_user',
          aiValidated: false,
          aiConfidence: 0,
        });
      }
    },

    // AI-related reducers
    updateAIInsights: (state, action: PayloadAction<Partial<StockState['aiInsights']>>) => {
      state.aiInsights = { ...state.aiInsights, ...action.payload };
    },
    addAIDetection: (state) => {
      state.aiInsights.detectionsToday += 1;
    },
    addStockAlert: (state, action: PayloadAction<Omit<StockAlert, 'id' | 'createdAt' | 'acknowledged'>>) => {
      state.alerts.unshift({
        ...action.payload,
        id: `alert_${Date.now()}`,
        createdAt: new Date().toISOString(),
        acknowledged: false,
      });
    },
    acknowledgeAlert: (state, action: PayloadAction<string>) => {
      const alert = state.alerts.find(a => a.id === action.payload);
      if (alert) {
        alert.acknowledged = true;
        alert.acknowledgedAt = new Date().toISOString();
        alert.acknowledgedBy = 'current_user';
      }
    },
  },
  extraReducers: (builder) => {
    builder
      // Scan item
      .addCase(scanStockItem.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(scanStockItem.fulfilled, (state, action) => {
        state.loading = false;
        state.aiInsights.detectionsToday += action.payload.detectedItems.length;
        // Add detected items to stock
        action.payload.detectedItems.forEach((item: any) => {
          const existingItem = state.items.find(i => i.sku === item.sku);
          if (existingItem) {
            existingItem.quantity = item.quantity;
            existingItem.lastUpdated = new Date().toISOString();
          } else {
            // Create new item
            const newItem: StockItem = {
              ...item,
              id: `stock_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
              lastUpdated: new Date().toISOString(),
              createdAt: new Date().toISOString(),
              minStockLevel: 10,
              maxStockLevel: 200,
              unitCost: 0,
              supplierId: '',
              location: item.location,
            };
            state.items.push(newItem);
          }
        });

        // Generate alerts for any anomalies
        if (action.payload.anomalies.length > 0) {
          action.payload.anomalies.forEach((anomaly: string) => {
            state.alerts.unshift({
              id: `alert_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
              itemId: '',
              type: 'anomaly',
              severity: 'medium',
              message: `AI detected ${anomaly.replace('_', ' ')}`,
              aiRecommendation: action.payload.recommendations.find((rec: string) => rec.includes(anomaly.split('_')[0])) || 'Review stock organization',
              createdAt: new Date().toISOString(),
              acknowledged: false,
            });
          });
        }
      })
      .addCase(scanStockItem.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      })

      // Add item
      .addCase(addStockItem.fulfilled, (state, action) => {
        state.items.push(action.payload);
        state.aiInsights.totalItemsTracked += 1;
      })

      .addCase(addStockItem.rejected, (state, action) => {
        state.error = action.payload as string;
      })

      // Generate report
      .addCase(generateStockReport.fulfilled, (state, action) => {
        // Report generated successfully - could add to reports array
        console.log('Report generated:', action.payload);
      });
  },
});

// Export actions
export const {
  clearError,
  setSyncStatus,
  setScanMode,
  setCurrentScanLocation,
  updateStockQuantity,
  updateAIInsights,
  addAIDetection,
  addStockAlert,
  acknowledgeAlert,
} = stockSlice.actions;

// Export reducer
export default stockSlice.reducer;
