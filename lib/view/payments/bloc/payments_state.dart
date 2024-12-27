part of 'payments_bloc.dart';

abstract class PaymentsState {}

class PaymentsInitialState extends PaymentsState {}

class PaymentsLoadingState extends PaymentsState {}

class PaymentsLoadedState extends PaymentsState {
  final List<PaymentModel> payments;
  final double totalDueAmount;

  PaymentsLoadedState({required this.payments, required this.totalDueAmount});
}

class PaymentsErrorState extends PaymentsState {
  final String message;

  PaymentsErrorState(this.message);
}

class PaymentsDayChangedState extends PaymentsState {
  final DateTime selectedDate;

  PaymentsDayChangedState({required this.selectedDate});
}