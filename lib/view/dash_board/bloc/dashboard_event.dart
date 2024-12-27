part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class LoadDashboardEvent extends DashboardEvent {}

class FetchShipmentSummaryEvent extends DashboardEvent {
  final int companyId;
  final String? date;

  FetchShipmentSummaryEvent({required this.companyId, this.date});
}

class FetchStatusListEvent extends DashboardEvent {}

class FetchEmirateListEvent extends DashboardEvent {}

class FetchShipmentsEvent extends DashboardEvent {
  final int companyId;
  final int page;
  final int pageSize;
  final String? fromDate;
  final String? toDate;
  final int? statusId;
  final List<int>? emirateId;

  FetchShipmentsEvent({
    required this.companyId,
    this.page = 1,
    this.pageSize = 5,
    this.fromDate,
    this.toDate,
    this.statusId,
    this.emirateId,
  });
}

class ChangeStatusEvent extends DashboardEvent {
  final int statusId;
  final int companyId;
  final String date;

  ChangeStatusEvent(
      {required this.statusId, required this.companyId, required this.date});
}

class SearchShipmentsEvent extends DashboardEvent {
  final int companyId;
  final String search;
  final int page;
  final int pageSize;

  SearchShipmentsEvent({
    required this.companyId,
    required this.search,
    this.page = 1,
    this.pageSize = 5,
  });
}
