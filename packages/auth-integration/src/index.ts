/**
 * Unified Authentication & Authorization Module for Cross-Environment Integration
 * Provides single sign-on, role-based access control, and security management across all agents
 */

export interface AuthConfig {
  ssoEnabled: boolean;
  jwtIssuer: string;
  jwtAudience: string;
  tokenExpiration: number;
  refreshTokenExpiration: number;
  mfaRequired: boolean;
  auditLogging: boolean;
  sessionTimeout: number;
}

export interface UserIdentity {
  userId: string;
  username: string;
  email: string;
  roles: UserRole[];
  permissions: Permission[];
  attributes: Record<string, any>;
  lastLogin?: string;
  mfaEnabled: boolean;
  accountStatus: 'active' | 'inactive' | 'suspended' | 'locked';
}

export interface UserRole {
  roleId: string;
  roleName: string;
  description: string;
  permissions: Permission[];
  scope: 'global' | 'company' | 'project' | 'agent';
  scopeId?: string;
}

export interface Permission {
  permissionId: string;
  resource: string;
  action: 'create' | 'read' | 'update' | 'delete' | 'execute' | 'admin';
  conditions?: Record<string, any>;
}

export interface AuthToken {
  tokenId: string;
  userId: string;
  issuedAt: string;
  expiresAt: string;
  issuer: string;
  audience: string;
  scopes: string[];
  metadata: Record<string, any>;
}

export interface AuthSession {
  sessionId: string;
  userId: string;
  startTime: string;
  lastActivity: string;
  ipAddress: string;
  userAgent: string;
  status: 'active' | 'expired' | 'terminated';
  tokens: AuthToken[];
}

export interface AccessRequest {
  userId: string;
  resource: string;
  action: string;
  context: AccessContext;
  timestamp: string;
}

export interface AccessContext {
  environment: string;
  agent: string;
  project?: string;
  company?: string;
  ipAddress: string;
  sessionId: string;
}

export interface AccessDecision {
  granted: boolean;
  userId: string;
  resource: string;
  action: string;
  reason: string;
  conditions?: Record<string, any>;
  expiresAt?: string;
}

export interface AuditEvent {
  eventId: string;
  timestamp: string;
  userId: string;
  action: string;
  resource: string;
  result: 'success' | 'failure' | 'denied';
  details: Record<string, any>;
  ipAddress: string;
  sessionId: string;
}

export class AuthManager {
  private config: AuthConfig;
  private activeSessions: Map<string, AuthSession> = new Map();
  private userIdentities: Map<string, UserIdentity> = new Map();
  private auditEvents: AuditEvent[] = [];

  constructor(config: Partial<AuthConfig> = {}) {
    this.config = {
      ssoEnabled: true,
      jwtIssuer: 'construct-ai',
      jwtAudience: 'agents',
      tokenExpiration: 3600, // 1 hour
      refreshTokenExpiration: 86400, // 24 hours
      mfaRequired: false,
      auditLogging: true,
      sessionTimeout: 28800, // 8 hours
      ...config
    };
  }

  /**
   * Authenticate user with credentials
   */
  async authenticate(credentials: AuthCredentials): Promise<AuthResult> {
    try {
      // Validate credentials
      const user = await this.validateCredentials(credentials);

      if (!user) {
        await this.logAuditEvent({
          eventId: this.generateEventId(),
          timestamp: new Date().toISOString(),
          userId: credentials.username,
          action: 'authentication',
          resource: 'auth',
          result: 'failure',
          details: { reason: 'invalid_credentials' },
          ipAddress: credentials.ipAddress || 'unknown',
          sessionId: 'pre-auth'
        });

        return {
          success: false,
          error: 'Invalid credentials',
          requiresMfa: false
        };
      }

      // Check account status
      if (user.accountStatus !== 'active') {
        await this.logAuditEvent({
          eventId: this.generateEventId(),
          timestamp: new Date().toISOString(),
          userId: user.userId,
          action: 'authentication',
          resource: 'auth',
          result: 'denied',
          details: { reason: `account_${user.accountStatus}` },
          ipAddress: credentials.ipAddress || 'unknown',
          sessionId: 'pre-auth'
        });

        return {
          success: false,
          error: `Account is ${user.accountStatus}`,
          requiresMfa: false
        };
      }

      // Check if MFA is required
      const requiresMfa = this.config.mfaRequired || user.mfaEnabled;

      if (requiresMfa && !credentials.mfaCode) {
        return {
          success: false,
          error: 'MFA required',
          requiresMfa: true,
          userId: user.userId
        };
      }

      // Validate MFA if provided
      if (requiresMfa && credentials.mfaCode) {
        const mfaValid = await this.validateMfaCode(user.userId, credentials.mfaCode);
        if (!mfaValid) {
          await this.logAuditEvent({
            eventId: this.generateEventId(),
            timestamp: new Date().toISOString(),
            userId: user.userId,
            action: 'mfa_validation',
            resource: 'auth',
            result: 'failure',
            details: { reason: 'invalid_mfa_code' },
            ipAddress: credentials.ipAddress || 'unknown',
            sessionId: 'pre-auth'
          });

          return {
            success: false,
            error: 'Invalid MFA code',
            requiresMfa: true
          };
        }
      }

      // Create session
      const session = await this.createSession(user, credentials);

      // Generate tokens
      const tokens = await this.generateTokens(user, session);

      // Update user last login
      user.lastLogin = new Date().toISOString();
      this.userIdentities.set(user.userId, user);

      // Log successful authentication
      await this.logAuditEvent({
        eventId: this.generateEventId(),
        timestamp: new Date().toISOString(),
        userId: user.userId,
        action: 'authentication',
        resource: 'auth',
        result: 'success',
        details: { sessionId: session.sessionId },
        ipAddress: credentials.ipAddress || 'unknown',
        sessionId: session.sessionId
      });

      return {
        success: true,
        user: user,
        session: session,
        tokens: tokens,
        requiresMfa: false
      };

    } catch (error) {
      return {
        success: false,
        error: error.message,
        requiresMfa: false
      };
    }
  }

  /**
   * Authorize access to resource
   */
  async authorize(request: AccessRequest): Promise<AccessDecision> {
    try {
      // Get user identity
      const user = this.userIdentities.get(request.userId);
      if (!user) {
        return {
          granted: false,
          userId: request.userId,
          resource: request.resource,
          action: request.action,
          reason: 'User not found'
        };
      }

      // Check session validity
      const session = this.activeSessions.get(request.context.sessionId);
      if (!session || session.status !== 'active') {
        return {
          granted: false,
          userId: request.userId,
          resource: request.resource,
          action: request.action,
          reason: 'Invalid session'
        };
      }

      // Check session timeout
      const lastActivity = new Date(session.lastActivity);
      const now = new Date();
      const sessionAge = (now.getTime() - lastActivity.getTime()) / 1000;

      if (sessionAge > this.config.sessionTimeout) {
        session.status = 'expired';
        return {
          granted: false,
          userId: request.userId,
          resource: request.resource,
          action: request.action,
          reason: 'Session expired'
        };
      }

      // Update session activity
      session.lastActivity = now.toISOString();

      // Evaluate permissions
      const decision = await this.evaluatePermissions(user, request);

      // Log authorization decision
      await this.logAuditEvent({
        eventId: this.generateEventId(),
        timestamp: new Date().toISOString(),
        userId: request.userId,
        action: 'authorization',
        resource: request.resource,
        result: decision.granted ? 'success' : 'denied',
        details: {
          action: request.action,
          reason: decision.reason,
          context: request.context
        },
        ipAddress: request.context.ipAddress,
        sessionId: request.context.sessionId
      });

      return decision;

    } catch (error) {
      return {
        granted: false,
        userId: request.userId,
        resource: request.resource,
        action: request.action,
        reason: `Authorization error: ${error.message}`
      };
    }
  }

  /**
   * Validate JWT token
   */
  async validateToken(token: string): Promise<TokenValidationResult> {
    try {
      const decoded = await this.decodeAndVerifyToken(token);

      // Check token expiration
      const now = new Date();
      const expiresAt = new Date(decoded.expiresAt);

      if (now > expiresAt) {
        return {
          valid: false,
          error: 'Token expired',
          userId: decoded.userId
        };
      }

      // Check if user still exists and is active
      const user = this.userIdentities.get(decoded.userId);
      if (!user || user.accountStatus !== 'active') {
        return {
          valid: false,
          error: 'User account inactive',
          userId: decoded.userId
        };
      }

      // Check if session is still active
      const session = this.activeSessions.get(decoded.sessionId);
      if (!session || session.status !== 'active') {
        return {
          valid: false,
          error: 'Session inactive',
          userId: decoded.userId
        };
      }

      return {
        valid: true,
        userId: decoded.userId,
        sessionId: decoded.sessionId,
        scopes: decoded.scopes,
        expiresAt: decoded.expiresAt
      };

    } catch (error) {
      return {
        valid: false,
        error: `Token validation failed: ${error.message}`
      };
    }
  }

  /**
   * Refresh authentication tokens
   */
  async refreshTokens(refreshToken: string): Promise<TokenRefreshResult> {
    try {
      // Validate refresh token
      const refreshValidation = await this.validateRefreshToken(refreshToken);
      if (!refreshValidation.valid) {
        return {
          success: false,
          error: refreshValidation.error
        };
      }

      // Get user and session
      const user = this.userIdentities.get(refreshValidation.userId!);
      const session = this.activeSessions.get(refreshValidation.sessionId!);

      if (!user || !session) {
        return {
          success: false,
          error: 'User or session not found'
        };
      }

      // Generate new tokens
      const newTokens = await this.generateTokens(user, session);

      // Log token refresh
      await this.logAuditEvent({
        eventId: this.generateEventId(),
        timestamp: new Date().toISOString(),
        userId: user.userId,
        action: 'token_refresh',
        resource: 'auth',
        result: 'success',
        details: { sessionId: session.sessionId },
        ipAddress: session.ipAddress,
        sessionId: session.sessionId
      });

      return {
        success: true,
        tokens: newTokens
      };

    } catch (error) {
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Terminate user session
   */
  async terminateSession(sessionId: string): Promise<boolean> {
    const session = this.activeSessions.get(sessionId);
    if (!session) return false;

    session.status = 'terminated';

    // Log session termination
    await this.logAuditEvent({
      eventId: this.generateEventId(),
      timestamp: new Date().toISOString(),
      userId: session.userId,
      action: 'session_termination',
      resource: 'auth',
      result: 'success',
      details: { sessionId },
      ipAddress: session.ipAddress,
      sessionId
    });

    this.activeSessions.delete(sessionId);
    return true;
  }

  /**
   * Get authentication analytics
   */
  async getAuthAnalytics(timeRange?: { start: Date; end: Date }): Promise<AuthAnalytics> {
    let relevantEvents = this.auditEvents;

    if (timeRange) {
      relevantEvents = this.auditEvents.filter(event =>
        new Date(event.timestamp) >= timeRange.start &&
        new Date(event.timestamp) <= timeRange.end
      );
    }

    return {
      totalUsers: this.userIdentities.size,
      activeSessions: this.activeSessions.size,
      totalEvents: relevantEvents.length,
      authenticationSuccessRate: this.calculateAuthSuccessRate(relevantEvents),
      authorizationSuccessRate: this.calculateAuthzSuccessRate(relevantEvents),
      averageSessionDuration: this.calculateAverageSessionDuration(),
      failedLoginAttempts: this.countFailedLogins(relevantEvents),
      topDeniedResources: this.getTopDeniedResources(relevantEvents)
    };
  }

  // Private methods

  private async validateCredentials(credentials: AuthCredentials): Promise<UserIdentity | null> {
    // Validate username/password against user store
    // Implementation would check against actual user database
    for (const user of this.userIdentities.values()) {
      if (user.username === credentials.username) {
        // In real implementation, would verify password hash
        return user;
      }
    }
    return null;
  }

  private async validateMfaCode(userId: string, mfaCode: string): Promise<boolean> {
    // Validate MFA code
    // Implementation would check TOTP or similar
    return true; // Placeholder
  }

  private async createSession(user: UserIdentity, credentials: AuthCredentials): Promise<AuthSession> {
    const sessionId = this.generateSessionId();
    const now = new Date().toISOString();

    const session: AuthSession = {
      sessionId,
      userId: user.userId,
      startTime: now,
      lastActivity: now,
      ipAddress: credentials.ipAddress || 'unknown',
      userAgent: credentials.userAgent || 'unknown',
      status: 'active',
      tokens: []
    };

    this.activeSessions.set(sessionId, session);
    return session;
  }

  private async generateTokens(user: UserIdentity, session: AuthSession): Promise<TokenPair> {
    const now = new Date();
    const accessTokenExpiry = new Date(now.getTime() + this.config.tokenExpiration * 1000);
    const refreshTokenExpiry = new Date(now.getTime() + this.config.refreshTokenExpiration * 1000);

    const accessToken: AuthToken = {
      tokenId: this.generateTokenId(),
      userId: user.userId,
      issuedAt: now.toISOString(),
      expiresAt: accessTokenExpiry.toISOString(),
      issuer: this.config.jwtIssuer,
      audience: this.config.jwtAudience,
      scopes: this.getUserScopes(user),
      metadata: {
        sessionId: session.sessionId,
        type: 'access'
      }
    };

    const refreshToken: AuthToken = {
      tokenId: this.generateTokenId(),
      userId: user.userId,
      issuedAt: now.toISOString(),
      expiresAt: refreshTokenExpiry.toISOString(),
      issuer: this.config.jwtIssuer,
      audience: this.config.jwtAudience,
      scopes: ['refresh'],
      metadata: {
        sessionId: session.sessionId,
        type: 'refresh'
      }
    };

    session.tokens = [accessToken, refreshToken];

    return {
      accessToken: await this.signToken(accessToken),
      refreshToken: await this.signToken(refreshToken),
      expiresIn: this.config.tokenExpiration,
      refreshExpiresIn: this.config.refreshTokenExpiration
    };
  }

  private getUserScopes(user: UserIdentity): string[] {
    const scopes: string[] = [];

    // Add scopes based on roles and permissions
    for (const role of user.roles) {
      for (const permission of role.permissions) {
        scopes.push(`${permission.resource}:${permission.action}`);
      }
    }

    return [...new Set(scopes)]; // Remove duplicates
  }

  private async evaluatePermissions(user: UserIdentity, request: AccessRequest): Promise<AccessDecision> {
    // Check if user has required permission
    for (const role of user.roles) {
      for (const permission of role.permissions) {
        if (this.matchesPermission(permission, request)) {
          // Check scope
          if (this.checkScope(role, request.context)) {
            return {
              granted: true,
              userId: user.userId,
              resource: request.resource,
              action: request.action,
              reason: 'Permission granted',
              conditions: permission.conditions
            };
          }
        }
      }
    }

    return {
      granted: false,
      userId: user.userId,
      resource: request.resource,
      action: request.action,
      reason: 'Insufficient permissions'
    };
  }

  private matchesPermission(permission: Permission, request: AccessRequest): boolean {
    // Check if permission matches the requested resource and action
    return permission.resource === request.resource && permission.action === request.action;
  }

  private checkScope(role: UserRole, context: AccessContext): boolean {
    // Check if role scope matches the request context
    switch (role.scope) {
      case 'global':
        return true;
      case 'company':
        return role.scopeId === context.company;
      case 'project':
        return role.scopeId === context.project;
      case 'agent':
        return role.scopeId === context.agent;
      default:
        return false;
    }
  }

  private async decodeAndVerifyToken(token: string): Promise<any> {
    // Decode and verify JWT token
    // Implementation would use JWT library
    return {}; // Placeholder
  }

  private async validateRefreshToken(token: string): Promise<TokenValidationResult> {
    // Validate refresh token
    return await this.validateToken(token);
  }

  private async signToken(token: AuthToken): Promise<string> {
    // Sign JWT token
    // Implementation would use JWT library
    return `jwt_${token.tokenId}`; // Placeholder
  }

  private async logAuditEvent(event: AuditEvent): Promise<void> {
    if (this.config.auditLogging) {
      this.auditEvents.push(event);

      // Keep only recent audit events (last 30 days)
      const thirtyDaysAgo = new Date();
      thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
      this.auditEvents = this.auditEvents.filter(e => new Date(e.timestamp) > thirtyDaysAgo);
    }
  }

  private generateEventId(): string {
    return `audit_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  private generateSessionId(): string {
    return `session_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  private generateTokenId(): string {
    return `token_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  private calculateAuthSuccessRate(events: AuditEvent[]): number {
    const authEvents = events.filter(e => e.action === 'authentication');
    if (authEvents.length === 0) return 0;
    const successCount = authEvents.filter(e => e.result === 'success').length;
    return successCount / authEvents.length;
  }

  private calculateAuthzSuccessRate(events: AuditEvent[]): number {
    const authzEvents = events.filter(e => e.action === 'authorization');
    if (authzEvents.length === 0) return 0;
    const successCount = authzEvents.filter(e => e.result === 'success').length;
    return successCount / authzEvents.length;
  }

  private calculateAverageSessionDuration(): number {
    const completedSessions = Array.from(this.activeSessions.values())
      .filter(s => s.status === 'terminated' || s.status === 'expired');

    if (completedSessions.length === 0) return 0;

    const totalDuration = completedSessions.reduce((sum, session) => {
      const start = new Date(session.startTime);
      const end = new Date(session.lastActivity);
      return sum + (end.getTime() - start.getTime());
    }, 0);

    return totalDuration / completedSessions.length / 1000; // in seconds
  }

  private countFailedLogins(events: AuditEvent[]): number {
    return events.filter(e =>
      e.action === 'authentication' && e.result === 'failure'
    ).length;
  }

  private getTopDeniedResources(events: AuditEvent[]): any[] {
    const deniedEvents = events.filter(e => e.result === 'denied');
    const resourceCounts: Record<string, number> = {};

    deniedEvents.forEach(event => {
      resourceCounts[event.resource] = (resourceCounts[event.resource] || 0) + 1;
    });

    return Object.entries(resourceCounts)
      .sort(([,a], [,b]) => b - a)
      .slice(0, 10);
  }
}

// Additional interfaces

export interface AuthCredentials {
  username: string;
  password: string;
  mfaCode?: string;
  ipAddress?: string;
  userAgent?: string;
}

export interface AuthResult {
  success: boolean;
  user?: UserIdentity;
  session?: AuthSession;
  tokens?: TokenPair;
  error?: string;
  requiresMfa?: boolean;
  userId?: string;
}

export interface TokenPair {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
  refreshExpiresIn: number;
}

export interface TokenValidationResult {
  valid: boolean;
  userId?: string;
  sessionId?: string;
  scopes?: string[];
  expiresAt?: string;
  error?: string;
}

export interface TokenRefreshResult {
  success: boolean;
  tokens?: TokenPair;
  error?: string;
}

export interface AuthAnalytics {
  totalUsers: number;
  activeSessions: number;
  totalEvents: number;
  authenticationSuccessRate: number;
  authorizationSuccessRate: number;
  averageSessionDuration: number;
  failedLoginAttempts: number;
  topDeniedResources: any[];
}

// Export the main manager
export default AuthManager;