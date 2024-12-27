part of 'purchase_services_bloc.dart';

abstract class PurchaseServicesEvent {}

class FetchServicesEvent extends PurchaseServicesEvent {}

class MakeRequestEvent extends PurchaseServicesEvent {
  final int companyId;
  final int serviceId;

  MakeRequestEvent({required this.companyId, required this.serviceId});
}

class FetchRequestsEvent extends PurchaseServicesEvent {
  final int companyId;
  final int page;
  final int pageSize;

  FetchRequestsEvent({
    required this.companyId,
    this.page = 1,
    this.pageSize = 10,
  });
}