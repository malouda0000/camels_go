part of 'store_bloc.dart';

abstract class StoreEvent {}

class FetchProductsEvent extends StoreEvent {
  final int companyId;

  FetchProductsEvent({required this.companyId});
}

class FetchProductHistoryEvent extends StoreEvent {
  final int productId;

  FetchProductHistoryEvent({required this.productId});
}

class ChangeDayEvent extends StoreEvent {
  final DateTime selectedDate;
  ChangeDayEvent(this.selectedDate);
}

class OpenCalendarEvent extends StoreEvent {}