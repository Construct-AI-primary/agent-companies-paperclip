import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';

export type EquipmentStackParamList = {
  EquipmentDashboard: undefined;
  EquipmentDetail: { equipmentId: string };
  EquipmentRegistration: undefined;
  MaintenanceSchedule: undefined;
  MaintenanceReschedule: { maintenance: any };
  EquipmentAnalytics: undefined;
  AlertsCenter: undefined;
  EquipmentList: undefined;
  EquipmentEdit: { equipmentId: string };
  MaintenanceHistory: { equipmentId: string };
  AIInsights: undefined;
};

export type EquipmentDashboardNavigationProp = StackNavigationProp<EquipmentStackParamList, 'EquipmentDashboard'>;
export type EquipmentDetailNavigationProp = StackNavigationProp<EquipmentStackParamList, 'EquipmentDetail'>;
export type EquipmentRegistrationNavigationProp = StackNavigationProp<EquipmentStackParamList, 'EquipmentRegistration'>;

export type EquipmentDetailRouteProp = RouteProp<EquipmentStackParamList, 'EquipmentDetail'>;
export type MaintenanceRescheduleRouteProp = RouteProp<EquipmentStackParamList, 'MaintenanceReschedule'>;
export type EquipmentEditRouteProp = RouteProp<EquipmentStackParamList, 'EquipmentEdit'>;
export type MaintenanceHistoryRouteProp = RouteProp<EquipmentStackParamList, 'MaintenanceHistory'>;
