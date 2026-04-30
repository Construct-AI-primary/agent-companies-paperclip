---
memory_layer: durable_knowledge
para_section: pages/codebase/mobile
gigabrain_tags: mobile, codebase, cross-platform
documentation
openstinger_context: mobile-development, responsive-design
last_updated: 2026-03-21
related_docs:
  - codebase/mobile/
  - disciplines/
---
# Supabase Backend Integration Setup

This document outlines the Supabase backend integration implemented for the Construct AI Safety Incident Reporting app.

## Overview

The app now supports:
- ✅ Offline-first architecture with SQLite database
- ✅ Automatic sync with Supabase when online
- ✅ Supabase authentication (email/password)
- ✅ Real-time database with PostgreSQL
- ✅ File storage for incident photos
- ✅ Row Level Security (RLS) policies
- ✅ Comprehensive error handling

## API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration

### Incidents
- `GET /api/incidents` - Get all incidents
- `POST /api/incidents` - Create new incident
- `PUT /api/incidents/:id` - Update incident
- `DELETE /api/incidents/:id` - Delete incident
- `POST /api/sync/incidents` - Bulk sync incidents

### Hazards
- `GET /api/hazards` - Get all hazards
- `POST /api/hazards` - Create new hazard
- `PUT /api/hazards/:id` - Update hazard
- `DELETE /api/hazards/:id` - Delete hazard
- `POST /api/sync/hazards` - Bulk sync hazards

### File Upload
- `POST /api/upload/photo` - Upload incident photos

## Supabase Setup

### 1. Create Supabase Project

1. Go to [supabase.com](https://supabase.com) and create an account
2. Create a new project
3. Wait for the project to be set up (this may take a few minutes)

### 2. Environment Configuration

Update your `.env` file with your Supabase credentials:

```env
# Supabase Configuration
EXPO_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=your-anon-key

# Development settings
EXPO_PUBLIC_ENV=development
```

You can find these values in your Supabase project dashboard under Settings > API.

### 3. Database Schema

Run these SQL commands in your Supabase SQL Editor to create the required tables:

```sql
-- Create incidents table
CREATE TABLE incidents (
  id TEXT PRIMARY KEY,
  incidentType TEXT NOT NULL,
  description TEXT NOT NULL,
  severity TEXT NOT NULL,
  location JSONB,
  photos JSONB DEFAULT '[]'::jsonb,
  status TEXT DEFAULT 'reported',
  synced BOOLEAN DEFAULT true,
  reportedBy TEXT,
  reportedAt TIMESTAMPTZ NOT NULL,
  immediateActions TEXT
);

-- Create hazards table
CREATE TABLE hazards (
  id TEXT PRIMARY KEY,
  hazardType TEXT NOT NULL,
  description TEXT NOT NULL,
  riskLevel TEXT NOT NULL,
  location JSONB,
  status TEXT DEFAULT 'active',
  synced BOOLEAN DEFAULT true,
  reportedAt TIMESTAMPTZ NOT NULL
);

-- Create sync_log table (optional, for tracking)
CREATE TABLE sync_log (
  id SERIAL PRIMARY KEY,
  operation TEXT NOT NULL,
  recordId TEXT NOT NULL,
  recordType TEXT NOT NULL,
  timestamp TIMESTAMPTZ DEFAULT NOW(),
  success BOOLEAN DEFAULT false,
  error TEXT
);

-- Enable Row Level Security
ALTER TABLE incidents ENABLE ROW LEVEL SECURITY;
ALTER TABLE hazards ENABLE ROW LEVEL SECURITY;

-- Create policies for authenticated users
CREATE POLICY "Users can view all incidents" ON incidents
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Users can insert incidents" ON incidents
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Users can update incidents" ON incidents
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Users can view all hazards" ON hazards
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Users can insert hazards" ON hazards
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Users can update hazards" ON hazards
  FOR UPDATE USING (auth.role() = 'authenticated');
```

### 4. Storage Setup

1. Go to Storage in your Supabase dashboard
2. Create a new bucket called `incident-photos`
3. Set it to public (or configure RLS policies for private access)
4. Update the bucket policy to allow authenticated users to upload files

### 5. Authentication Setup

Supabase Auth is already configured by default. You can:
- Enable email/password authentication (already enabled)
- Configure additional providers (Google, GitHub, etc.)
- Set up email templates in Authentication > Email Templates

## Testing the Supabase Integration

1. **Update your .env file** with your actual Supabase credentials

2. **Test the connection**:
   ```javascript
   import { apiService } from './src/services/api';

   // Test Supabase connection
   apiService.getIncidents().then(incidents => {
     console.log('Supabase connected:', incidents);
   }).catch(error => {
     console.error('Connection failed:', error);
   });
   ```

3. **Test authentication**:
   ```javascript
   // Test user registration
   apiService.register({
     email: 'test@example.com',
     password: 'password123',
     name: 'Test User'
   }).then(user => {
     console.log('User registered:', user);
   });

   // Test login
   apiService.login('test@example.com', 'password123').then(user => {
     console.log('User logged in:', user);
   });
   ```

4. **Test sync functionality**:
   ```javascript
   import { syncService } from './src/services/syncService';

   // Sync all data
   syncService.syncAllData().then(result => {
     console.log('Sync result:', result);
   });
   ```

5. **Test file upload**:
   ```javascript
   // Upload a photo
   apiService.uploadPhoto('file://path/to/photo.jpg', 'incident-123')
     .then(result => {
       console.log('Photo uploaded:', result.url);
     });
   ```

## Redux Integration

The app uses Redux Toolkit for state management. New actions available:

- `syncIncidents()` - Sync unsynced incidents
- `syncHazards()` - Sync unsynced hazards
- `loadIncidentsFromAPI()` - Load incidents from API
- `loadHazardsFromAPI()` - Load hazards from API

## Error Handling

The integration includes comprehensive error handling:
- Network connectivity checks
- Automatic retry mechanisms
- Offline data persistence
- User-friendly error messages

## Security Considerations

- JWT tokens for authentication
- Secure file upload handling
- Input validation on both client and server
- HTTPS in production

## Next Steps

1. Implement the actual backend server
2. Set up cloud database (MongoDB, PostgreSQL)
3. Configure file storage (AWS S3, Cloudinary)
4. Add push notifications
5. Implement real-time sync
6. Add data encryption for sensitive information

## Troubleshooting

**Common Issues:**

1. **API Connection Failed**
   - Check if backend server is running
   - Verify API URL in .env file
   - Check network connectivity

2. **Authentication Errors**
   - Ensure JWT token is valid
   - Check token expiration
   - Verify user credentials

3. **Sync Issues**
   - Check database sync flags
   - Verify API endpoints
   - Check for network timeouts

For more help, check the console logs and network tab in your browser's developer tools.
