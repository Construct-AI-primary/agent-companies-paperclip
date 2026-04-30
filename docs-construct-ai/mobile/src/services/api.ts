import { SafetyIncident, SafetyHazard } from '../store/slices/safetySlice';
import { Equipment } from './database';

// Check if we're in a web environment
const isWeb = typeof window !== 'undefined' && window.document;

// Supabase Configuration
const supabaseUrl = process.env.EXPO_PUBLIC_SUPABASE_URL || '';
const supabaseAnonKey = process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY || '';

if (!supabaseUrl || !supabaseAnonKey) {
  console.warn('Supabase configuration missing. Please check your .env file.');
}

// Web-compatible API service
if (isWeb) {
  // Import web API module
  const webModule = require('./api.web');
  const apiService = webModule.apiService || webModule.default;
  export { apiService };
  export default apiService;
} else {
  // Native Supabase implementation for mobile
  const { createClient } = require('@supabase/supabase-js');
  
  class ApiService {
    private supabase: any;

    constructor() {
      this.supabase = createClient(supabaseUrl, supabaseAnonKey);
    }

    // Authentication methods
    async login(email: string, password: string): Promise<{ user: any }> {
      const { data, error } = await this.supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (error) throw error;
      return { user: data.user };
    }

    async register(userData: { email: string; password: string; name: string }): Promise<{ user: any }> {
      const { data, error } = await this.supabase.auth.signUp({
        email: userData.email,
        password: userData.password,
        options: {
          data: {
            name: userData.name,
          },
        },
      });

      if (error) throw error;
      return { user: data.user };
    }

    async logout(): Promise<void> {
      const { error } = await this.supabase.auth.signOut();
      if (error) throw error;
    }

    // Incident API methods
    async getIncidents(): Promise<SafetyIncident[]> {
      const { data, error } = await this.supabase
        .from('incidents')
        .select('*')
        .order('reportedAt', { ascending: false });

      if (error) throw error;
      return data || [];
    }

    async createIncident(incident: Omit<SafetyIncident, 'id' | 'synced' | 'reportedAt'>): Promise<SafetyIncident> {
      const { data, error } = await this.supabase
        .from('incidents')
        .insert([{
          ...incident,
          reportedAt: new Date().toISOString(),
          synced: true,
        }])
        .select()
        .single();

      if (error) throw error;
      return data;
    }

    async updateIncident(id: string, updates: Partial<SafetyIncident>): Promise<SafetyIncident> {
      const { data, error } = await this.supabase
        .from('incidents')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

      if (error) throw error;
      return data;
    }

    async deleteIncident(id: string): Promise<void> {
      const { error } = await this.supabase
        .from('incidents')
        .delete()
        .eq('id', id);

      if (error) throw error;
    }

    // Hazard API methods
    async getHazards(): Promise<SafetyHazard[]> {
      const { data, error } = await this.supabase
        .from('hazards')
        .select('*')
        .order('reportedAt', { ascending: false });

      if (error) throw error;
      return data || [];
    }

    async createHazard(hazard: Omit<SafetyHazard, 'id' | 'synced'>): Promise<SafetyHazard> {
      const { data, error } = await this.supabase
        .from('hazards')
        .insert([{
          ...hazard,
          reportedAt: new Date().toISOString(),
          synced: true,
        }])
        .select()
        .single();

      if (error) throw error;
      return data;
    }

    async updateHazard(id: string, updates: Partial<SafetyHazard>): Promise<SafetyHazard> {
      const { data, error } = await this.supabase
        .from('hazards')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

      if (error) throw error;
      return data;
    }

    async deleteHazard(id: string): Promise<void> {
      const { error } = await this.supabase
        .from('hazards')
        .delete()
        .eq('id', id);

      if (error) throw error;
    }

    // Equipment API methods
    async getEquipment(): Promise<Equipment[]> {
      const { data, error } = await this.supabase
        .from('equipment')
        .select('*')
        .order('name', { ascending: true });

      if (error) throw error;
      return data || [];
    }

    async createEquipment(equipment: Omit<Equipment, 'id' | 'synced' | 'createdAt' | 'updatedAt'>): Promise<Equipment> {
      const { data, error } = await this.supabase
        .from('equipment')
        .insert([{
          ...equipment,
          id: Math.random().toString(36).substr(2, 9),
          synced: true,
          createdAt: new Date().toISOString(),
          updatedAt: new Date().toISOString(),
        }])
        .select()
        .single();

      if (error) throw error;
      return data;
    }

    async updateEquipment(id: string, updates: Partial<Equipment>): Promise<Equipment> {
      const { data, error } = await this.supabase
        .from('equipment')
        .update({
          ...updates,
          updatedAt: new Date().toISOString(),
        })
        .eq('id', id)
        .select()
        .single();

      if (error) throw error;
      return data;
    }

    async deleteEquipment(id: string): Promise<void> {
      const { error } = await this.supabase
        .from('equipment')
        .delete()
        .eq('id', id);

      if (error) throw error;
    }

    // Sync methods
    async syncIncidents(incidents: SafetyIncident[]): Promise<{ synced: SafetyIncident[]; failed: string[] }> {
      const synced: SafetyIncident[] = [];
      const failed: string[] = [];

      for (const incident of incidents) {
        try {
          const { data, error } = await this.supabase
            .from('incidents')
            .upsert([incident])
            .select()
            .single();

          if (error) throw error;
          synced.push(data);
        } catch (error) {
          console.error('Failed to sync incident:', incident.id, error);
          failed.push(incident.id);
        }
      }

      return { synced, failed };
    }

    async syncHazards(hazards: SafetyHazard[]): Promise<{ synced: SafetyHazard[]; failed: string[] }> {
      const synced: SafetyHazard[] = [];
      const failed: string[] = [];

      for (const hazard of hazards) {
        try {
          const { data, error } = await this.supabase
            .from('hazards')
            .upsert([hazard])
            .select()
            .single();

          if (error) throw error;
          synced.push(data);
        } catch (error) {
          console.error('Failed to sync hazard:', hazard.id, error);
          failed.push(hazard.id);
        }
      }

      return { synced, failed };
    }

    async syncEquipment(equipment: Equipment[]): Promise<{ synced: Equipment[]; failed: string[] }> {
      const synced: Equipment[] = [];
      const failed: string[] = [];

      for (const item of equipment) {
        try {
          const { data, error } = await this.supabase
            .from('equipment')
            .upsert([item])
            .select()
            .single();

          if (error) throw error;
          synced.push(data);
        } catch (error) {
          console.error('Failed to sync equipment:', item.id, error);
          failed.push(item.id);
        }
      }

      return { synced, failed };
    }

    // File upload for photos
    async uploadPhoto(photoUri: string, incidentId?: string): Promise<{ url: string }> {
      const filename = `incident_${incidentId || 'temp'}_${Date.now()}.jpg`;

      // Convert photo URI to blob for Supabase storage
      const response = await fetch(photoUri);
      const blob = await response.blob();

      const { data, error } = await this.supabase.storage
        .from('incident-photos')
        .upload(filename, blob);

      if (error) throw error;

      // Get public URL
      const { data: { publicUrl } } = this.supabase.storage
        .from('incident-photos')
        .getPublicUrl(filename);

      return { url: publicUrl };
    }
  }

  // Export singleton instance
  const apiService = new ApiService();
  export { apiService };
  export default apiService;
}
