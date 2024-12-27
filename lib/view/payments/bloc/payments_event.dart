part of 'payments_bloc.dart';

abstract class PaymentsEvent {}

class FetchPaymentsEvent extends PaymentsEvent {
  final int companyId;
  final int page;
  final int pageSize;
  final String? date;

  FetchPaymentsEvent({
    required this.companyId,
    this.page = 1,
    this.pageSize = 10,
    this.date,
  });
}

class PaymentsDayChangedEvent extends PaymentsEvent {
  final DateTime selectedDate;

  PaymentsDayChangedEvent({required this.selectedDate});
}