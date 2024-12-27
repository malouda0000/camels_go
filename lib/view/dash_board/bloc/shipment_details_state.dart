part of 'shipment_details_bloc.dart';


abstract class ShipmentDetailsState {}

class ShipmentDetailsInitialState extends ShipmentDetailsState {}

class ShipmentDetailsLoadingState extends ShipmentDetailsState {}

class ShipmentDetailsLoadedState extends ShipmentDetailsState {
  final ShipmentDetailsModel shipmentDetails;
  final CustomerDetailsModel customerDetails;

  ShipmentDetailsLoadedState({required this.shipmentDetails, required this.customerDetails});
}

class ShipmentDetailsErrorState extends ShipmentDetailsState {
  final String message;

  ShipmentDetailsErrorState(this.message);
}