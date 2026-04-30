import React, { useEffect, useState, useRef } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useNavigation, useRoute } from '@react-navigation/native';
import { aiService } from '../services/aiService';

const MainNavigation: React.FC = () => {
  const navigation = useNavigation();
  const route = useRoute();
  const [languageTrigger, setLanguageTrigger] = useState(0);
  const unsubscribeRef = useRef<(() => void) | null>(null);

  useEffect(() => {
    // Listen for language changes with proper cleanup
    const unsubscribe = aiService.onLanguageChange(() => {
      console.log('Language changed, forcing navigation re-render');
      setLanguageTrigger(prev => prev + 1);
    });

    unsubscribeRef.current = unsubscribe;

    // Force initial render to ensure translation is applied
    console.log('Initial language:', aiService.getLanguage());
    setLanguageTrigger(prev => prev + 1);

    return () => {
      if (unsubscribeRef.current) {
        unsubscribeRef.current();
        unsubscribeRef.current = null;
      }
    };
  }, []);

  // Use languageTrigger in render to cause re-render on language changes
  const renderTrigger = languageTrigger;

const navigationItems = [
    {
      name: 'StockDashboard',
      titleKey: 'stock',
      icon: 'cube',
      color: '#00BFFF', // Bright sky blue - much more vibrant
    },
    {
      name: 'SafetyDashboard',
      titleKey: 'safety',
      icon: 'shield',
      color: '#32CD32', // Bright lime green - much more vibrant
    },
    {
      name: 'EquipmentDashboard',
      titleKey: 'equipment',
      icon: 'construct',
      color: '#FF8C00', // Bright dark orange - much more vibrant
    },
    {
      name: 'LogisticsDashboard',
      titleKey: 'logistics',
      icon: 'bus',
      color: '#FFD700', // Bright gold yellow - much more vibrant
    },
    {
      name: 'InspectionStart',
      titleKey: 'inspection',
      icon: 'eye',
      color: '#FF69B4', // Hot pink - vibrant and distinct
    },
    {
      name: 'AISettings',
      titleKey: 'aiSettings',
      icon: 'settings',
      color: '#FF6347', // Tomato red - vibrant AI settings color
    },
  ];

  const isActive = (screenName: string) => {
    // Show all icons in their colors - no gray inactive state
    return true;
  };

  return (
    <View style={styles.container}>
      <View style={styles.navigationBar}>
        {navigationItems.map((item) => (
          <TouchableOpacity
            key={item.name}
            style={styles.navItem}
            onPress={() => navigation.navigate(item.name as never)}
          >
            <Ionicons
              name={item.icon as any}
              size={24}
              color={isActive(item.name) ? item.color : '#666'}
            />
            <Text
              style={[
                styles.navText,
                { color: isActive(item.name) ? item.color : '#666' },
              ]}
            >
              {aiService.getText(item.titleKey)}
            </Text>
          </TouchableOpacity>
        ))}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#f8f9fa',
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
    paddingBottom: 8,
  },
  navigationBar: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
    height: 60,
    paddingHorizontal: 16,
  },
  navItem: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 8,
  },
  navText: {
    fontSize: 12,
    fontWeight: '600',
    marginTop: 4,
  },
});

export default MainNavigation;
