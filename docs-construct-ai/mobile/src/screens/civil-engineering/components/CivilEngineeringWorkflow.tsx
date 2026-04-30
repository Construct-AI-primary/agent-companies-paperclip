// Civil Engineering Workflow Mobile Component
// Mobile-optimized 13-card workflow system for React Native

import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  StyleSheet,
  Alert,
  Dimensions,
} from 'react-native';
import WorkflowCard from './WorkflowCard';

const { width, height } = Dimensions.get('window');

interface CivilEngineeringWorkflowProps {
  onClose: () => void;
}

const CivilEngineeringWorkflow: React.FC<CivilEngineeringWorkflowProps> = ({ onClose }) => {
  const [cards, setCards] = useState<any[]>([]);
  const [selectedPhase, setSelectedPhase] = useState('all');
  const [selectedStatus, setSelectedStatus] = useState('all');

  // Initialize workflow cards (simplified version)
  useEffect(() => {
    const workflowCards = [
      // Phase 1: Site Assessment
      {
        id: 'proj-001-project-brief',
        type: 'project-brief',
        title: 'Project Brief',
        description: 'Define project objectives, scope, and initial requirements',
        phase: 'site-assessment',
        status: 'available',
        progress: 0,
        dependencies: [],
        assignee: null,
        metadata: {
          estimatedHours: 8,
          attachments: [],
          tags: ['foundation', 'requirements', 'scope'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 'proj-001-site-survey',
        type: 'site-survey',
        title: 'Site Survey',
        description: 'Conduct topographic survey and site analysis',
        phase: 'site-assessment',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-project-brief'],
        assignee: null,
        metadata: {
          estimatedHours: 16,
          attachments: [],
          tags: ['survey', 'topography', 'field-work'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 'proj-001-geotechnical',
        type: 'geotechnical',
        title: 'Geotechnical Analysis',
        description: 'Soil investigation and foundation recommendations',
        phase: 'site-assessment',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-site-survey'],
        assignee: null,
        metadata: {
          estimatedHours: 24,
          attachments: [],
          tags: ['geotechnical', 'soil', 'foundation'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 'proj-001-environmental-constraints',
        type: 'environmental-constraints',
        title: 'Environmental Constraints',
        description: 'Environmental impact assessment and regulatory requirements',
        phase: 'site-assessment',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-site-survey'],
        assignee: null,
        metadata: {
          estimatedHours: 12,
          attachments: [],
          tags: ['environmental', 'regulatory', 'compliance'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },

      // Phase 2: Conceptual Design
      {
        id: 'proj-001-design-options',
        type: 'design-options',
        title: 'Design Options Analysis',
        description: 'Evaluate multiple design alternatives and select optimal solution',
        phase: 'conceptual-design',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-geotechnical', 'proj-001-environmental-constraints'],
        assignee: null,
        metadata: {
          estimatedHours: 20,
          attachments: [],
          tags: ['design', 'options', 'analysis'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 'proj-001-preliminary-layout',
        type: 'preliminary-layout',
        title: 'Preliminary Layout',
        description: 'Create initial design layout with mass balance and alignments',
        phase: 'conceptual-design',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-design-options'],
        assignee: null,
        metadata: {
          estimatedHours: 32,
          attachments: [],
          tags: ['layout', 'preliminary', 'alignment'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },

      // Phase 3: Preliminary Design
      {
        id: 'proj-001-calculations',
        type: 'calculations',
        title: 'Engineering Calculations',
        description: 'Perform hydraulic, structural, and earthwork calculations',
        phase: 'preliminary-design',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-preliminary-layout'],
        assignee: null,
        metadata: {
          estimatedHours: 40,
          attachments: [],
          tags: ['calculations', 'hydraulic', 'structural'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 'proj-001-preliminary-drawings',
        type: 'preliminary-drawings',
        title: 'Preliminary Drawings',
        description: 'Create preliminary construction drawings and details',
        phase: 'preliminary-design',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-calculations'],
        assignee: null,
        metadata: {
          estimatedHours: 48,
          attachments: [],
          tags: ['drawings', 'preliminary', 'construction'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },

      // Phase 4: Detailed Design
      {
        id: 'proj-001-construction-drawings',
        type: 'construction-drawings',
        title: 'Construction Drawings',
        description: 'Produce final construction drawings and specifications',
        phase: 'detailed-design',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-preliminary-drawings'],
        assignee: null,
        metadata: {
          estimatedHours: 80,
          attachments: [],
          tags: ['drawings', 'construction', 'final'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 'proj-001-specifications',
        type: 'specifications',
        title: 'Technical Specifications',
        description: 'Develop detailed technical specifications and requirements',
        phase: 'detailed-design',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-calculations'],
        assignee: null,
        metadata: {
          estimatedHours: 32,
          attachments: [],
          tags: ['specifications', 'technical', 'requirements'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 'proj-001-quantity-schedules',
        type: 'quantity-schedules',
        title: 'Quantity Schedules',
        description: 'Prepare bill of quantities and material schedules',
        phase: 'detailed-design',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-construction-drawings'],
        assignee: null,
        metadata: {
          estimatedHours: 24,
          attachments: [],
          tags: ['quantities', 'bill-of-quantities', 'materials'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 'proj-001-inspection-plans',
        type: 'inspection-plans',
        title: 'Inspection & Test Plans',
        description: 'Develop quality control and inspection procedures',
        phase: 'detailed-design',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-specifications'],
        assignee: null,
        metadata: {
          estimatedHours: 16,
          attachments: [],
          tags: ['inspection', 'quality-control', 'testing'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },

      // Phase 5: Procurement Support
      {
        id: 'proj-001-tender-documents',
        type: 'tender-documents',
        title: 'Tender Documents',
        description: 'Prepare complete tender package for procurement',
        phase: 'procurement-support',
        status: 'locked',
        progress: 0,
        dependencies: [
          'proj-001-construction-drawings',
          'proj-001-specifications',
          'proj-001-quantity-schedules',
          'proj-001-inspection-plans'
        ],
        assignee: null,
        metadata: {
          estimatedHours: 24,
          attachments: [],
          tags: ['tender', 'procurement', 'bidding'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 'proj-001-construction-support',
        type: 'construction-support',
        title: 'Construction Support',
        description: 'Provide engineering support during construction phase',
        phase: 'procurement-support',
        status: 'locked',
        progress: 0,
        dependencies: ['proj-001-tender-documents'],
        assignee: null,
        metadata: {
          estimatedHours: 160,
          attachments: [],
          tags: ['construction', 'support', 'supervision'],
        },
        createdAt: new Date(),
        updatedAt: new Date()
      }
    ];

    setCards(workflowCards);
  }, []);

  const phases = [
    'all',
    'site-assessment',
    'conceptual-design',
    'preliminary-design',
    'detailed-design',
    'procurement-support'
  ];

  const statuses = [
    'all',
    'available',
    'in-progress',
    'review',
    'approved',
    'locked',
    'rejected'
  ];

  const getPhaseDisplayName = (phase: string) => {
    if (phase === 'all') return 'All Phases';

    const names: { [key: string]: string } = {
      'site-assessment': 'Site Assessment',
      'conceptual-design': 'Conceptual Design',
      'preliminary-design': 'Preliminary Design',
      'detailed-design': 'Detailed Design',
      'procurement-support': 'Procurement Support'
    };

    return names[phase] || phase;
  };

  const getStatusDisplayName = (status: string) => {
    if (status === 'all') return 'All Statuses';

    const names: { [key: string]: string } = {
      'locked': 'Locked',
      'available': 'Available',
      'in-progress': 'In Progress',
      'review': 'Under Review',
      'approved': 'Approved',
      'rejected': 'Rejected'
    };

    return names[status] || status;
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

  // Filter cards based on selected filters
  const filteredCards = cards.filter(card => {
    const phaseMatch = selectedPhase === 'all' || card.phase === selectedPhase;
    const statusMatch = selectedStatus === 'all' || card.status === selectedStatus;
    return phaseMatch && statusMatch;
  });

  // Group cards by phase for display
  const cardsByPhase: { [key: string]: any[] } = {};
  phases.forEach(phase => {
    if (phase !== 'all') {
      cardsByPhase[phase] = filteredCards.filter(card => card.phase === phase);
    }
  });

  const handleStatusChange = (cardId: string, status: string) => {
    setCards(prevCards =>
      prevCards.map(card =>
        card.id === cardId
          ? { ...card, status, updatedAt: new Date() }
          : card
      )
    );
  };

  const handleAssign = (cardId: string) => {
    setCards(prevCards =>
      prevCards.map(card =>
        card.id === cardId
          ? { ...card, assignee: 'current-user', status: 'in-progress', updatedAt: new Date() }
          : card
      )
    );
  };

  const handleViewDetails = (cardId: string) => {
    const card = cards.find(c => c.id === cardId);
    if (card) {
      Alert.alert(
        card.title,
        card.description,
        [{ text: 'OK' }]
      );
    }
  };

  // Calculate progress summary
  const progress = {
    totalCards: cards.length,
    completedCards: cards.filter(c => c.status === 'approved').length,
    inProgressCards: cards.filter(c => c.status === 'in-progress').length,
    blockedCards: cards.filter(c => c.status === 'locked').length,
    overallProgress: cards.length > 0
      ? (cards.filter(c => c.status === 'approved').length / cards.length) * 100
      : 0
  };

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <View style={styles.headerTop}>
          <TouchableOpacity onPress={onClose} style={styles.closeButton}>
            <Text style={styles.closeButtonText}>✕</Text>
          </TouchableOpacity>
          <Text style={styles.title}>Civil Engineering Workflow</Text>
          <View style={{ width: 40 }} />
        </View>

        {/* Progress Overview */}
        <View style={styles.progressContainer}>
          <Text style={styles.progressTitle}>Project Progress</Text>
          <View style={styles.progressStats}>
            <View style={styles.statItem}>
              <Text style={[styles.statNumber, { color: '#2563eb' }]}>{progress.totalCards}</Text>
              <Text style={styles.statLabel}>Total</Text>
            </View>
            <View style={styles.statItem}>
              <Text style={[styles.statNumber, { color: '#10b981' }]}>{progress.completedCards}</Text>
              <Text style={styles.statLabel}>Completed</Text>
            </View>
            <View style={styles.statItem}>
              <Text style={[styles.statNumber, { color: '#f59e0b' }]}>{progress.inProgressCards}</Text>
              <Text style={styles.statLabel}>In Progress</Text>
            </View>
            <View style={styles.statItem}>
              <Text style={[styles.statNumber, { color: '#6b7280' }]}>{progress.blockedCards}</Text>
              <Text style={styles.statLabel}>Blocked</Text>
            </View>
          </View>
          <View style={styles.progressBar}>
            <View
              style={[styles.progressFill, { width: `${progress.overallProgress}%` }]}
            />
          </View>
          <Text style={styles.progressText}>
            {progress.overallProgress.toFixed(1)}% Complete
          </Text>
        </View>
      </View>

      {/* Filters */}
      <View style={styles.filters}>
        <View style={styles.filterRow}>
          <View style={styles.filterGroup}>
            <Text style={styles.filterLabel}>Phase:</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false}>
              {phases.map(phase => (
                <TouchableOpacity
                  key={phase}
                  style={[
                    styles.filterButton,
                    selectedPhase === phase && styles.activeFilterButton
                  ]}
                  onPress={() => setSelectedPhase(phase)}
                >
                  <Text style={[
                    styles.filterButtonText,
                    selectedPhase === phase && styles.activeFilterButtonText
                  ]}>
                    {getPhaseDisplayName(phase)}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>
        </View>

        <View style={styles.filterRow}>
          <View style={styles.filterGroup}>
            <Text style={styles.filterLabel}>Status:</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false}>
              {statuses.map(status => (
                <TouchableOpacity
                  key={status}
                  style={[
                    styles.filterButton,
                    selectedStatus === status && styles.activeFilterButton
                  ]}
                  onPress={() => setSelectedStatus(status)}
                >
                  <Text style={[
                    styles.filterButtonText,
                    selectedStatus === status && styles.activeFilterButtonText
                  ]}>
                    {getStatusDisplayName(status)}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>
        </View>
      </View>

      {/* Cards */}
      <ScrollView style={styles.cardsContainer} showsVerticalScrollIndicator={false}>
        {selectedPhase === 'all' ? (
          // Show all phases
          phases.filter(p => p !== 'all').map(phase => {
            const phaseCards = cardsByPhase[phase];
            if (!phaseCards || phaseCards.length === 0) return null;

            return (
              <View key={phase} style={styles.phaseSection}>
                <View style={[styles.phaseHeader, { backgroundColor: getPhaseColor(phase) }]}>
                  <Text style={styles.phaseTitle}>{getPhaseDisplayName(phase)}</Text>
                </View>
                {phaseCards.map(card => (
                  <WorkflowCard
                    key={card.id}
                    card={card}
                    onStatusChange={handleStatusChange}
                    onAssign={handleAssign}
                    onViewDetails={handleViewDetails}
                    isAssignedToCurrentUser={card.assignee === 'current-user'}
                  />
                ))}
              </View>
            );
          })
        ) : (
          // Show single phase
          <View style={styles.phaseSection}>
            <View style={[styles.phaseHeader, { backgroundColor: getPhaseColor(selectedPhase) }]}>
              <Text style={styles.phaseTitle}>{getPhaseDisplayName(selectedPhase)}</Text>
            </View>
            {filteredCards.map(card => (
              <WorkflowCard
                key={card.id}
                card={card}
                onStatusChange={handleStatusChange}
                onAssign={handleAssign}
                onViewDetails={handleViewDetails}
                isAssignedToCurrentUser={card.assignee === 'current-user'}
              />
            ))}
          </View>
        )}

        {/* Empty State */}
        {filteredCards.length === 0 && (
          <View style={styles.emptyState}>
            <Text style={styles.emptyStateText}>NO CARDS</Text>
            <Text style={styles.emptyStateSubtext}>
              No cards match your current filters
            </Text>
          </View>
        )}
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    backgroundColor: '#2563eb',
    paddingTop: 50,
    paddingBottom: 20,
  },
  headerTop: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    marginBottom: 16,
  },
  closeButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    alignItems: 'center',
    justifyContent: 'center',
  },
  closeButtonText: {
    fontSize: 18,
    color: 'white',
    fontWeight: 'bold',
  },
  title: {
    fontSize: 18,
    fontWeight: 'bold',
    color: 'white',
    textAlign: 'center',
  },
  progressContainer: {
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    marginHorizontal: 16,
    padding: 16,
    borderRadius: 8,
  },
  progressTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: 'white',
    marginBottom: 12,
  },
  progressStats: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 12,
  },
  statItem: {
    alignItems: 'center',
  },
  statNumber: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  statLabel: {
    fontSize: 12,
    color: 'rgba(255, 255, 255, 0.8)',
    marginTop: 2,
  },
  progressBar: {
    height: 6,
    backgroundColor: 'rgba(255, 255, 255, 0.3)',
    borderRadius: 3,
    marginBottom: 8,
  },
  progressFill: {
    height: 6,
    backgroundColor: '#10b981',
    borderRadius: 3,
  },
  progressText: {
    fontSize: 12,
    color: 'rgba(255, 255, 255, 0.8)',
    textAlign: 'center',
  },
  filters: {
    backgroundColor: 'white',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e5e7eb',
  },
  filterRow: {
    marginBottom: 12,
  },
  filterGroup: {
    marginBottom: 8,
  },
  filterLabel: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#374151',
    marginBottom: 8,
  },
  filterButton: {
    backgroundColor: '#f3f4f6',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 16,
    marginRight: 8,
  },
  activeFilterButton: {
    backgroundColor: '#2563eb',
  },
  filterButtonText: {
    fontSize: 12,
    color: '#6b7280',
  },
  activeFilterButtonText: {
    color: 'white',
  },
  cardsContainer: {
    flex: 1,
    padding: 16,
  },
  phaseSection: {
    marginBottom: 24,
  },
  phaseHeader: {
    padding: 12,
    borderRadius: 8,
    marginBottom: 12,
  },
  phaseTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: 'white',
    textAlign: 'center',
  },
  emptyState: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 60,
  },
  emptyStateText: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#9ca3af',
    marginBottom: 8,
  },
  emptyStateSubtext: {
    fontSize: 14,
    color: '#6b7280',
    textAlign: 'center',
  },
});

export default CivilEngineeringWorkflow;