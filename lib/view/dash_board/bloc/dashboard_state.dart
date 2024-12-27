part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardInitialState extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardLoadedState extends DashboardState {
  final double deliveredPercentage;
  final double canceledPercentage;
  final double delayedPercentage;
  final List<StatusListModel> statusList;
  final List<EmirateModel> emirateList;

  DashboardLoadedState({
    required this.deliveredPercentage,
    required this.canceledPercentage,
    required this.delayedPercentage,
    required this.statusList,
    required this.emirateList,
  });
}

class ShipmentLoadingState extends DashboardState {}

class ShipmentLoadedState extends DashboardState {
  final List<ShipmentModel> shipments;

  ShipmentLoadedState({required this.shipments});
}

class DashboardErrorState extends DashboardState {
  final String message;

  DashboardErrorState(this.message);
} 