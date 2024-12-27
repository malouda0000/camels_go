part of 'order_follow_bloc.dart';

abstract class OrderFollowState {}

class OrderFollowInitialState extends OrderFollowState {}

class OrderFollowLoadingState extends OrderFollowState {}

class OrderFollowLoadedState extends OrderFollowState {
  final ShipmentTrackingResponse shipmentTrackingResponse;

  OrderFollowLoadedState({required this.shipmentTrackingResponse});
}

class OrderFollowErrorState extends OrderFollowState {
  final String message;

  OrderFollowErrorState(this.message);
}