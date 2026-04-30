/**
 * Purchase Order Screen
 * Implements voice-to-text order creation and GPS-tagged approvals
 * Following Phase 1B of mobile enhancement implementation plan
 */

import React, { useState, useEffect } from 'react';
import {
  View,
  ScrollView,
  StyleSheet,
  Alert,
  Vibration,
} from 'react-native';
import { Text, Card, Button, TextInput, Chip, FAB } from 'react-native-paper';
import Voice from '@react-native-voice/voice';
import { useTranslation } from '../../services/i18n';
import { aiService, AIRequest, DeviceContext } from '../../services/aiService';
import * as Location from 'expo-location';
import * as Haptics from 'expo-haptics';

interface PurchaseOrder {
  id: string;
  supplierId: string;
  supplierName: string;
  items: PurchaseOrderItem[];
  status: 'draft' | 'pending_approval' | 'approved' | 'ordered';
  totalAmount: number;
  createdAt: string;
  approvedAt?: string;
  approvalLocation?: {
    latitude: number;
    longitude: number;
    timestamp: string;
  };
  voiceNotes?: string;
}

interface PurchaseOrderItem {
  id: string;
  description: string;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
}

const PurchaseOrderScreen: React.FC = () => {
  const { t } = useTranslation();
  const [orders, setOrders] = useState<PurchaseOrder[]>([]);
  const [currentOrder, setCurrentOrder] = useState<Partial<PurchaseOrder>>({
    items: [],
    status: 'draft'
  });
  const [currentItem, setCurrentItem] = useState<Partial<PurchaseOrderItem>>({});
  const [isListening, setIsListening] = useState(false);
  const [voiceText, setVoiceText] = useState('');
  const [location, setLocation] = useState<Location.LocationObject | null>(null);
  const [hasLocationPermission, setHasLocationPermission] = useState(false);

  useEffect(() => {
    setupVoiceRecognition();
    requestLocationPermission();
    loadExistingOrders();

    return () => {
      Voice.destroy().then(Voice.removeAllListeners);
    };
  }, []);

  const setupVoiceRecognition = () => {
    Voice.onSpeechStart = () => {
      setIsListening(true);
      Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    };

    Voice.onSpeechEnd = () => {
      setIsListening(false);
      Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    };

    Voice.onSpeechResults = (event) => {
      const text = event.value?.[0] || '';
      setVoiceText(text);
      processVoiceCommand(text);
    };

    Voice.onSpeechError = (event) => {
      console.error('Voice recognition error:', event.error);
      Alert.alert('Voice Error', 'Failed to recognize speech. Please try again.');
      setIsListening(false);
    };
  };

  const requestLocationPermission = async () => {
    try {
      const { status } = await Location.requestForegroundPermissionsAsync();
      setHasLocationPermission(status === 'granted');

      if (status === 'granted') {
        const location = await Location.getCurrentPositionAsync({});
        setLocation(location);
      }
    } catch (error) {
      console.error('Location permission error:', error);
    }
  };

  const loadExistingOrders = async () => {
    // Load from local storage or API
    // Implementation would load existing purchase orders
  };

  const startVoiceRecognition = async () => {
    try {
      await Voice.start('en-US'); // Default to English, could be configurable
    } catch (error) {
      console.error('Voice start error:', error);
      Alert.alert('Voice Error', 'Failed to start voice recognition');
    }
  };

  const stopVoiceRecognition = async () => {
    try {
      await Voice.stop();
    } catch (error) {
      console.error('Voice stop error:', error);
    }
  };

  const processVoiceCommand = async (text: string) => {
    console.log('Processing voice command:', text);

    // Simple voice command processing - could be enhanced with AI
    const lowerText = text.toLowerCase();

    // Extract item information from voice
    if (lowerText.includes('add item') || lowerText.includes('order')) {
      // Parse voice command for item details
      const aiRequest: AIRequest = {
        type: 'procurement-analysis',
        parameters: {
          priority: 'normal',
          content: text,
          context: { action: 'parse_order_item' }
        }
      };

      const deviceContext: DeviceContext = {
        connectivity: 'online',
        availableStorage: 1000000000,
        availableRAM: 2000000000,
        batteryLevel: 80,
        platform: 'ios'
      };

      try {
        const result = await aiService.processRequest(aiRequest, deviceContext);

        if (result.data?.item) {
          const item: PurchaseOrderItem = {
            id: Date.now().toString(),
            description: result.data.item.description || text,
            quantity: result.data.item.quantity || 1,
            unitPrice: result.data.item.unitPrice || 0,
            totalPrice: (result.data.item.quantity || 1) * (result.data.item.unitPrice || 0)
          };

          setCurrentOrder(prev => ({
            ...prev,
            items: [...(prev.items || []), item]
          }));

          setVoiceText('');
          Alert.alert('Success', 'Item added to order via voice command');
        }
      } catch (error) {
        console.error('Voice processing error:', error);
      }
    }
  };

  const addItemManually = () => {
    if (!currentItem.description || !currentItem.quantity || !currentItem.unitPrice) {
      Alert.alert('Error', 'Please fill in all item details');
      return;
    }

    const item: PurchaseOrderItem = {
      id: Date.now().toString(),
      description: currentItem.description,
      quantity: currentItem.quantity,
      unitPrice: currentItem.unitPrice,
      totalPrice: currentItem.quantity * currentItem.unitPrice
    };

    setCurrentOrder(prev => ({
      ...prev,
      items: [...(prev.items || []), item]
    }));

    setCurrentItem({});
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
  };

  const submitOrder = async () => {
    if (!currentOrder.supplierName || !currentOrder.items?.length) {
      Alert.alert('Error', 'Please add supplier and at least one item');
      return;
    }

    const totalAmount = currentOrder.items.reduce((sum, item) => sum + item.totalPrice, 0);

    const order: PurchaseOrder = {
      id: Date.now().toString(),
      supplierId: 'supplier_' + Date.now(),
      supplierName: currentOrder.supplierName,
      items: currentOrder.items,
      status: 'pending_approval',
      totalAmount,
      createdAt: new Date().toISOString(),
      voiceNotes: voiceText || undefined
    };

    setOrders(prev => [...prev, order]);

    // Reset form
    setCurrentOrder({ items: [], status: 'draft' });
    setVoiceText('');

    Alert.alert('Success', 'Purchase order created successfully');
  };

  const approveOrder = async (orderId: string) => {
    if (!hasLocationPermission || !location) {
      Alert.alert('Error', 'GPS location required for approval');
      return;
    }

    const approvalLocation = {
      latitude: location.coords.latitude,
      longitude: location.coords.longitude,
      timestamp: new Date().toISOString()
    };

    setOrders(prev => prev.map(order =>
      order.id === orderId
        ? {
            ...order,
            status: 'approved',
            approvedAt: new Date().toISOString(),
            approvalLocation
          }
        : order
    ));

    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    Alert.alert('Success', 'Order approved with GPS verification');
  };

  const calculateTotal = () => {
    return currentOrder.items?.reduce((sum, item) => sum + item.totalPrice, 0) || 0;
  };

  return (
    <View style={styles.container}>
      <ScrollView style={styles.scrollContainer}>
        <View style={styles.header}>
          <Text variant="headlineMedium" style={styles.title}>
            Purchase Orders
          </Text>
          <Text variant="bodyMedium" style={styles.subtitle}>
            Voice-powered order creation with GPS approvals
          </Text>
        </View>

        {/* Voice Input Section */}
        <Card style={styles.voiceCard}>
          <Card.Title title="Voice Commands" />
          <Card.Content>
            <View style={styles.voiceControls}>
              <Button
                mode={isListening ? "contained" : "outlined"}
                onPress={isListening ? stopVoiceRecognition : startVoiceRecognition}
                icon={isListening ? "microphone-off" : "microphone"}
                style={styles.voiceButton}
              >
                {isListening ? 'Listening...' : 'Start Voice'}
              </Button>

              <TextInput
                label="Voice Input / Notes"
                value={voiceText}
                onChangeText={setVoiceText}
                multiline
                numberOfLines={2}
                style={styles.voiceInput}
                placeholder="Say 'Add 10 steel beams at $50 each' or add manual notes..."
              />
            </View>
          </Card.Content>
        </Card>

        {/* Order Form */}
        <Card style={styles.formCard}>
          <Card.Title title="New Purchase Order" />
          <Card.Content>
            <TextInput
              label="Supplier Name"
              value={currentOrder.supplierName || ''}
              onChangeText={(text) => setCurrentOrder(prev => ({ ...prev, supplierName: text }))}
              style={styles.input}
            />

            {/* Add Item Section */}
            <View style={styles.itemSection}>
              <Text variant="titleSmall" style={styles.sectionTitle}>Add Item</Text>

              <TextInput
                label="Description"
                value={currentItem.description || ''}
                onChangeText={(text) => setCurrentItem(prev => ({ ...prev, description: text }))}
                style={styles.input}
              />

              <View style={styles.itemRow}>
                <TextInput
                  label="Quantity"
                  value={currentItem.quantity?.toString() || ''}
                  onChangeText={(text) => setCurrentItem(prev => ({
                    ...prev,
                    quantity: parseFloat(text) || 0
                  }))}
                  keyboardType="numeric"
                  style={[styles.input, styles.halfInput]}
                />

                <TextInput
                  label="Unit Price"
                  value={currentItem.unitPrice?.toString() || ''}
                  onChangeText={(text) => setCurrentItem(prev => ({
                    ...prev,
                    unitPrice: parseFloat(text) || 0
                  }))}
                  keyboardType="numeric"
                  style={[styles.input, styles.halfInput]}
                />
              </View>

              <Button
                mode="outlined"
                onPress={addItemManually}
                style={styles.addItemButton}
              >
                Add Item
              </Button>
            </View>

            {/* Items List */}
            {currentOrder.items && currentOrder.items.length > 0 && (
              <View style={styles.itemsList}>
                <Text variant="titleSmall" style={styles.sectionTitle}>Items</Text>
                {currentOrder.items.map((item, index) => (
                  <Card key={item.id} style={styles.itemCard}>
                    <Card.Content>
                      <Text variant="bodyMedium">{item.description}</Text>
                      <Text variant="bodySmall">
                        Qty: {item.quantity} × ${item.unitPrice.toFixed(2)} = ${item.totalPrice.toFixed(2)}
                      </Text>
                    </Card.Content>
                  </Card>
                ))}

                <View style={styles.totalSection}>
                  <Text variant="titleSmall">Total: ${calculateTotal().toFixed(2)}</Text>
                </View>
              </View>
            )}
          </Card.Content>
        </Card>

        {/* Submit Button */}
        <View style={styles.buttonContainer}>
          <Button
            mode="contained"
            onPress={submitOrder}
            disabled={!currentOrder.supplierName || !currentOrder.items?.length}
            style={styles.submitButton}
          >
            Submit Order
          </Button>
        </View>

        {/* Orders List */}
        <View style={styles.ordersSection}>
          <Text variant="titleMedium" style={styles.sectionTitle}>
            Purchase Orders
          </Text>

          {orders.length === 0 ? (
            <Card style={styles.emptyCard}>
              <Card.Content>
                <Text variant="bodyMedium" style={styles.emptyText}>
                  No orders created yet
                </Text>
              </Card.Content>
            </Card>
          ) : (
            orders.map((order) => (
              <Card key={order.id} style={styles.orderCard}>
                <Card.Content>
                  <View style={styles.orderHeader}>
                    <Text variant="titleSmall">{order.supplierName}</Text>
                    <Chip
                      mode="outlined"
                      selectedColor={
                        order.status === 'approved' ? '#4CAF50' :
                        order.status === 'pending_approval' ? '#FF9800' : '#2196F3'
                      }
                    >
                      {order.status.replace('_', ' ')}
                    </Chip>
                  </View>

                  <Text variant="bodySmall">
                    Items: {order.items.length} | Total: ${order.totalAmount.toFixed(2)}
                  </Text>

                  <Text variant="bodySmall" style={styles.timestamp}>
                    Created: {new Date(order.createdAt).toLocaleString()}
                  </Text>

                  {order.approvalLocation && (
                    <Text variant="bodySmall" style={styles.gpsText}>
                      Approved at: {order.approvalLocation.latitude.toFixed(4)}, {order.approvalLocation.longitude.toFixed(4)}
                    </Text>
                  )}

                  {order.status === 'pending_approval' && (
                    <Button
                      mode="outlined"
                      onPress={() => approveOrder(order.id)}
                      style={styles.approveButton}
                      disabled={!hasLocationPermission}
                    >
                      Approve with GPS
                    </Button>
                  )}
                </Card.Content>
              </Card>
            ))
          )}
        </View>
      </ScrollView>

      {/* Floating Voice Button */}
      <FAB
        icon={isListening ? "microphone-off" : "microphone"}
        onPress={isListening ? stopVoiceRecognition : startVoiceRecognition}
        style={[styles.fab, isListening && styles.fabListening]}
        color={isListening ? '#F44336' : '#FFFFFF'}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  scrollContainer: {
    flex: 1,
    padding: 16,
  },
  header: {
    marginBottom: 20,
  },
  title: {
    fontWeight: 'bold',
    color: '#1976D2',
  },
  subtitle: {
    color: '#666',
    marginTop: 4,
  },
  voiceCard: {
    marginBottom: 16,
    backgroundColor: '#FFF3E0',
  },
  voiceControls: {
    gap: 12,
  },
  voiceButton: {
    marginBottom: 8,
  },
  voiceInput: {
    marginTop: 8,
  },
  formCard: {
    marginBottom: 16,
  },
  input: {
    marginBottom: 12,
  },
  itemSection: {
    marginTop: 16,
    paddingTop: 16,
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
  },
  sectionTitle: {
    fontWeight: 'bold',
    marginBottom: 12,
    color: '#1976D2',
  },
  itemRow: {
    flexDirection: 'row',
    gap: 8,
  },
  halfInput: {
    flex: 1,
  },
  addItemButton: {
    marginTop: 8,
  },
  itemsList: {
    marginTop: 16,
  },
  itemCard: {
    marginBottom: 8,
    backgroundColor: '#F5F5F5',
  },
  totalSection: {
    marginTop: 12,
    paddingTop: 8,
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
    alignItems: 'flex-end',
  },
  buttonContainer: {
    marginBottom: 24,
  },
  submitButton: {
    paddingVertical: 8,
  },
  ordersSection: {
    marginTop: 8,
  },
  emptyCard: {
    backgroundColor: '#FAFAFA',
  },
  emptyText: {
    textAlign: 'center',
    color: '#666',
  },
  orderCard: {
    marginBottom: 8,
  },
  orderHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  timestamp: {
    color: '#666',
    marginTop: 4,
  },
  gpsText: {
    color: '#4CAF50',
    fontWeight: 'bold',
    marginTop: 4,
  },
  approveButton: {
    marginTop: 8,
  },
  fab: {
    position: 'absolute',
    margin: 16,
    right: 0,
    bottom: 0,
    backgroundColor: '#1976D2',
  },
  fabListening: {
    backgroundColor: '#F44336',
  },
});

export default PurchaseOrderScreen;