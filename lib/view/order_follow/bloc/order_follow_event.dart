part of 'order_follow_bloc.dart';

abstract class OrderFollowEvent {}

class FetchOrderFollowEvent extends OrderFollowEvent {
  final int? shipmentId;
  final int companyId;

  FetchOrderFollowEvent({required this.shipmentId, required this.companyId});
}