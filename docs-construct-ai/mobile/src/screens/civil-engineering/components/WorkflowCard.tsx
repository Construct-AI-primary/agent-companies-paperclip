// Mobile WorkflowCard Component
// Individual card in the mobile 13-card civil engineering workflow system

import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Alert,
  Dimensions,
} from 'react-native';

const { width } = Dimensions.get('window');

interface WorkflowCardProps {
  card: any;
  onStatusChange: (cardId: string, status: string) => void;
  onAssign: (cardId: string) => void;
  onViewDetails: (cardId: string) => void;
  isAssignedToCurrentUser: boolean;
}

const WorkflowCard: React.FC<WorkflowCardProps> = ({
  card,
  onStatusChange,
  onAssign,
  onViewDetails,
  isAssignedToCurrentUser,
}) => {
  const [isExpanded, setIsExpanded] = useState(false);

  const getStatusColor = (status: string) => {
    const colors: { [key: string]: string } = {
      'locked': '#f3f4f6',
      'available': '#dbeafe',
      'in-progress': '#fef3c7',
      'review': '#e0e7ff',
      'approved': '#d1fae5',
      'rejected': '#fee2e2'
    };
    return colors[status] || colors.locked;
  };

  const getStatusBorderColor = (status: string) => {
    const colors: { [key: string]: string } = {
      'locked': '#d1d5db',
      'available': '#3b82f6',
      'in-progress': '#f59e0b',
      'review': '#6366f1',
      'approved': '#10b981',
      'rejected': '#ef4444'
    };
    return colors[status] || colors.locked;
  };

  const getStatusText = (status: string) => {
    const texts: { [key: string]: string } = {
      'locked': 'LOCKED',
      'available': 'AVAILABLE',
      'in-progress': 'IN PROGRESS',
      'review': 'REVIEW',
      'approved': 'APPROVED',
      'rejected': 'REJECTED'
    };
    return texts[status] || 'UNKNOWN';
  };

  const getPhaseColor = (phase: string) => {
    const colors: { [key: string]: string } = {
      'site-assessment': '#10b981',
      'conceptual-design': '#3b82f6',
      'preliminary-design': '#8b5cf6',
      'detailed-design': '#f59e0b',
      'procurement-support': '#ef4444'
    };
    return colors[phase] || '#6b7280';
  };

  const canChangeStatus = (currentStatus: string, newStatus: string) => {
    if (!isAssignedToCurrentUser && newStatus !== 'available') return false;

    const validTransitions: { [key: string]: string[] } = {
      'locked': [],
      'available': ['in-progress'],
      'in-progress': ['review'],
      'review': ['approved', 'rejected', 'in-progress'],
      'approved': [],
      'rejected': ['in-progress']
    };

    return validTransitions[currentStatus]?.includes(newStatus) || false;
  };

  const handleStatusChange = (newStatus: string) => {
    if (canChangeStatus(card.status, newStatus)) {
      onStatusChange(card.id, newStatus);
    } else {
      Alert.alert('Invalid Action', 'You cannot perform this status change.');
    }
  };

  const handleAssign = () => {
    onAssign(card.id);
  };

  const handleViewDetails = () => {
    onViewDetails(card.id);
  };

  return (
    <View style={[
      styles.card,
      {
        backgroundColor: getStatusColor(card.status),
        borderLeftColor: getStatusBorderColor(card.status),
      }
    ]}>
      {/* Header */}
      <View style={styles.header}>
        <View style={styles.headerLeft}>
          <Text style={[styles.statusText, { color: getStatusBorderColor(card.status) }]}>
            {getStatusText(card.status)}
          </Text>
          <View style={[styles.phaseBadge, { backgroundColor: getPhaseColor(card.phase) }]}>
            <Text style={styles.phaseText}>
              {card.phase.replace('-', ' ').toUpperCase()}
            </Text>
          </View>
        </View>

        <TouchableOpacity
          onPress={() => setIsExpanded(!isExpanded)}
          style={styles.expandButton}
        >
          <Text style={styles.expandButtonText}>
            {isExpanded ? '▼' : '▶'}
          </Text>
        </TouchableOpacity>
      </View>

      {/* Title and Description */}
      <View style={styles.content}>
        <Text style={styles.title}>{card.title}</Text>
        <Text style={styles.description}>{card.description}</Text>

        {/* Progress Bar */}
        <View style={styles.progressContainer}>
          <View style={styles.progressHeader}>
            <Text style={styles.progressLabel}>Progress</Text>
            <Text style={styles.progressValue}>{card.progress}%</Text>
          </View>
          <View style={styles.progressBar}>
            <View
              style={[styles.progressFill, { width: `${card.progress}%` }]}
            />
          </View>
        </View>

        {/* Assignment Info */}
        {card.assignee && (
          <View style={styles.assignmentContainer}>
            <Text style={styles.assignmentLabel}>Assigned to:</Text>
            <Text style={styles.assignmentValue}>{card.assignee}</Text>
            {isAssignedToCurrentUser && (
              <View style={styles.currentUserBadge}>
                <Text style={styles.currentUserText}>You</Text>
              </View>
            )}
          </View>
        )}

        {/* Tags */}
        {card.metadata.tags.length > 0 && (
          <View style={styles.tagsContainer}>
            {card.metadata.tags.map((tag: string, index: number) => (
              <View key={index} style={styles.tag}>
                <Text style={styles.tagText}>#{tag}</Text>
              </View>
            ))}
          </View>
        )}

        {/* Expanded Content */}
        {isExpanded && (
          <View style={styles.expandedContent}>
            {/* Dependencies */}
            {card.dependencies.length > 0 && (
              <View style={styles.section}>
                <Text style={styles.sectionTitle}>Dependencies:</Text>
                <View style={styles.dependenciesContainer}>
                  {card.dependencies.map((depId: string, index: number) => (
                    <Text key={index} style={styles.dependencyText}>
                      {depId.split('-').pop()}
                    </Text>
                  ))}
                </View>
              </View>
            )}

            {/* Quality Score */}
            {card.metadata.qualityScore !== undefined && (
              <View style={styles.section}>
                <Text style={styles.sectionTitle}>Quality Score:</Text>
                <View style={styles.qualityContainer}>
                  <View style={styles.qualityBar}>
                    <View
                      style={[styles.qualityFill, { width: `${card.metadata.qualityScore}%` }]}
                    />
                  </View>
                  <Text style={styles.qualityText}>
                    {card.metadata.qualityScore.toFixed(1)}%
                  </Text>
                </View>
              </View>
            )}

            {/* Review Comments */}
            {card.metadata.reviewComments && card.metadata.reviewComments.length > 0 && (
              <View style={styles.section}>
                <Text style={styles.sectionTitle}>Review Comments:</Text>
                {card.metadata.reviewComments.map((comment: string, index: number) => (
                  <Text key={index} style={styles.commentText}>
                    {comment}
                  </Text>
                ))}
              </View>
            )}

            {/* Attachments */}
            {card.metadata.attachments.length > 0 && (
              <View style={styles.section}>
                <Text style={styles.sectionTitle}>Attachments:</Text>
                {card.metadata.attachments.map((attachment: any, index: number) => (
                  <View key={index} style={styles.attachmentContainer}>
                    <Text style={styles.attachmentText}>ATTACHMENT</Text>
                    <Text style={styles.attachmentName}>{attachment.filename}</Text>
                    <Text style={styles.attachmentSize}>
                      ({(attachment.size / 1024 / 1024).toFixed(1)} MB)
                    </Text>
                  </View>
                ))}
              </View>
            )}

            {/* Timestamps */}
            <View style={styles.timestampsContainer}>
              <Text style={styles.timestampText}>
                Created: {card.createdAt.toLocaleDateString()}
              </Text>
              <Text style={styles.timestampText}>
                Updated: {card.updatedAt.toLocaleDateString()}
              </Text>
              {card.metadata.actualHours && (
                <Text style={styles.timestampText}>
                  Time Spent: {card.metadata.actualHours}h (est. {card.metadata.estimatedHours}h)
                </Text>
              )}
            </View>
          </View>
        )}

        {/* Action Buttons */}
        <View style={styles.actionsContainer}>
          <TouchableOpacity
            style={styles.actionButton}
            onPress={handleViewDetails}
          >
            <Text style={styles.actionButtonText}>View Details</Text>
          </TouchableOpacity>

          {card.status === 'locked' && (
            <View style={styles.lockedBadge}>
              <Text style={styles.lockedText}>Locked</Text>
            </View>
          )}

          {card.status === 'available' && !card.assignee && (
            <TouchableOpacity
              style={[styles.actionButton, styles.primaryButton]}
              onPress={handleAssign}
            >
              <Text style={[styles.actionButtonText, styles.primaryButtonText]}>
                Assign to Me
              </Text>
            </TouchableOpacity>
          )}

          {isAssignedToCurrentUser && card.status === 'in-progress' && (
            <TouchableOpacity
              style={[styles.actionButton, styles.secondaryButton]}
              onPress={() => handleStatusChange('review')}
            >
              <Text style={[styles.actionButtonText, styles.secondaryButtonText]}>
                Submit for Review
              </Text>
            </TouchableOpacity>
          )}

          {card.status === 'review' && (
            <View style={styles.reviewActions}>
              <TouchableOpacity
                style={[styles.actionButton, styles.approveButton]}
                onPress={() => handleStatusChange('approved')}
              >
                <Text style={[styles.actionButtonText, styles.approveButtonText]}>
                  Approve
                </Text>
              </TouchableOpacity>
              <TouchableOpacity
                style={[styles.actionButton, styles.rejectButton]}
                onPress={() => handleStatusChange('rejected')}
              >
                <Text style={[styles.actionButtonText, styles.rejectButtonText]}>
                  Reject
                </Text>
              </TouchableOpacity>
            </View>
          )}

          {card.status === 'rejected' && isAssignedToCurrentUser && (
            <TouchableOpacity
              style={[styles.actionButton, styles.retryButton]}
              onPress={() => handleStatusChange('in-progress')}
            >
              <Text style={[styles.actionButtonText, styles.retryButtonText]}>
                Resume Work
              </Text>
            </TouchableOpacity>
          )}
        </View>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  card: {
    borderLeftWidth: 4,
    borderRadius: 8,
    marginBottom: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 12,
  },
  headerLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
  },
  statusText: {
    fontSize: 12,
    fontWeight: 'bold',
    marginRight: 8,
  },
  phaseBadge: {
    paddingHorizontal: 8,
    paddingVertical: 2,
    borderRadius: 10,
  },
  phaseText: {
    fontSize: 10,
    color: 'white',
    fontWeight: 'bold',
  },
  expandButton: {
    padding: 4,
  },
  expandButtonText: {
    fontSize: 14,
    color: '#6b7280',
  },
  content: {
    padding: 12,
  },
  title: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#1f2937',
    marginBottom: 4,
  },
  description: {
    fontSize: 14,
    color: '#6b7280',
    marginBottom: 12,
    lineHeight: 20,
  },
  progressContainer: {
    marginBottom: 12,
  },
  progressHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 4,
  },
  progressLabel: {
    fontSize: 12,
    color: '#6b7280',
  },
  progressValue: {
    fontSize: 12,
    fontWeight: 'bold',
    color: '#374151',
  },
  progressBar: {
    height: 4,
    backgroundColor: 'rgba(255, 255, 255, 0.5)',
    borderRadius: 2,
  },
  progressFill: {
    height: 4,
    backgroundColor: '#10b981',
    borderRadius: 2,
  },
  assignmentContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  assignmentLabel: {
    fontSize: 12,
    color: '#6b7280',
    marginRight: 4,
  },
  assignmentValue: {
    fontSize: 12,
    fontWeight: 'bold',
    color: '#374151',
    marginRight: 8,
  },
  currentUserBadge: {
    backgroundColor: '#dbeafe',
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: 8,
  },
  currentUserText: {
    fontSize: 10,
    color: '#2563eb',
    fontWeight: 'bold',
  },
  tagsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginBottom: 12,
  },
  tag: {
    backgroundColor: 'rgba(255, 255, 255, 0.5)',
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: 8,
    marginRight: 4,
    marginBottom: 4,
  },
  tagText: {
    fontSize: 10,
    color: '#6b7280',
  },
  expandedContent: {
    borderTopWidth: 1,
    borderTopColor: 'rgba(0, 0, 0, 0.1)',
    paddingTop: 12,
    marginTop: 12,
  },
  section: {
    marginBottom: 12,
  },
  sectionTitle: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#374151',
    marginBottom: 4,
  },
  dependenciesContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
  dependencyText: {
    backgroundColor: 'rgba(255, 255, 255, 0.3)',
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: 6,
    fontSize: 12,
    color: '#6b7280',
    marginRight: 4,
    marginBottom: 4,
  },
  qualityContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  qualityBar: {
    flex: 1,
    height: 6,
    backgroundColor: 'rgba(255, 255, 255, 0.5)',
    borderRadius: 3,
    marginRight: 8,
  },
  qualityFill: {
    height: 6,
    backgroundColor: '#10b981',
    borderRadius: 3,
  },
  qualityText: {
    fontSize: 12,
    fontWeight: 'bold',
    color: '#374151',
  },
  commentText: {
    fontSize: 12,
    color: '#6b7280',
    backgroundColor: 'rgba(255, 255, 255, 0.3)',
    padding: 8,
    borderRadius: 6,
    marginBottom: 4,
  },
  attachmentContainer: {
    backgroundColor: 'rgba(255, 255, 255, 0.3)',
    padding: 8,
    borderRadius: 6,
    marginBottom: 4,
  },
  attachmentText: {
    fontSize: 12,
    fontWeight: 'bold',
    color: '#374151',
  },
  attachmentName: {
    fontSize: 12,
    color: '#6b7280',
    marginTop: 2,
  },
  attachmentSize: {
    fontSize: 10,
    color: '#9ca3af',
    marginTop: 2,
  },
  timestampsContainer: {
    marginTop: 8,
  },
  timestampText: {
    fontSize: 10,
    color: '#9ca3af',
    marginBottom: 2,
  },
  actionsContainer: {
    marginTop: 12,
  },
  actionButton: {
    backgroundColor: '#f3f4f6',
    paddingVertical: 8,
    paddingHorizontal: 12,
    borderRadius: 6,
    alignItems: 'center',
    marginRight: 8,
    marginBottom: 8,
  },
  actionButtonText: {
    fontSize: 12,
    fontWeight: 'bold',
    color: '#6b7280',
  },
  primaryButton: {
    backgroundColor: '#2563eb',
  },
  primaryButtonText: {
    color: 'white',
  },
  secondaryButton: {
    backgroundColor: '#7c3aed',
  },
  secondaryButtonText: {
    color: 'white',
  },
  approveButton: {
    backgroundColor: '#10b981',
  },
  approveButtonText: {
    color: 'white',
  },
  rejectButton: {
    backgroundColor: '#ef4444',
  },
  rejectButtonText: {
    color: 'white',
  },
  retryButton: {
    backgroundColor: '#f59e0b',
  },
  retryButtonText: {
    color: 'white',
  },
  lockedBadge: {
    backgroundColor: '#f3f4f6',
    paddingVertical: 8,
    paddingHorizontal: 12,
    borderRadius: 6,
    alignItems: 'center',
  },
  lockedText: {
    fontSize: 12,
    color: '#9ca3af',
    fontWeight: 'bold',
  },
  reviewActions: {
    flexDirection: 'row',
  },
});

export default WorkflowCard;