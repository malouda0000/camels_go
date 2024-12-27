part of 'purchase_services_bloc.dart';

abstract class PurchaseServicesState {}

class PurchaseServicesInitialState extends PurchaseServicesState {}

class PurchaseServicesLoadingState extends PurchaseServicesState {}

class PurchaseServicesLoadedState extends PurchaseServicesState {
  final List<ServiceModel> services;

  PurchaseServicesLoadedState({required this.services});
}

class RequestsLoadedState extends PurchaseServicesState {
  final List<RequestModel> requests;

  RequestsLoadedState({required this.requests});
}

class RequestSuccessState extends PurchaseServicesState {
  final String message;

  RequestSuccessState(this.message);
}

class PurchaseServicesErrorState extends PurchaseServicesState {
  final String message;

  PurchaseServicesErrorState(this.message);
}