part of 'shipment_details_bloc.dart';

abstract class ShipmentDetailsEvent {}

class FetchShipmentDetailsEvent extends ShipmentDetailsEvent {
  final int shipmentId;

  FetchShipmentDetailsEvent({required this.shipmentId});
}