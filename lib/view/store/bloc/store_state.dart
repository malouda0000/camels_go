part of 'store_bloc.dart';

abstract class StoreState {}

class StoreInitialState extends StoreState {}

class StoreLoadingState extends StoreState {}

class StoreLoadedState extends StoreState {
  final List<ProductModel> products;

  StoreLoadedState({required this.products});
}

class ProductHistoryLoadedState extends StoreState {
  final List<ProductHistoryModel> history;

  ProductHistoryLoadedState({required this.history});
}

class StoreErrorState extends StoreState {
  final String message;

  StoreErrorState(this.message);
}

class StoreDayChangedState extends StoreState {
  final DateTime selectedDate;
  StoreDayChangedState(this.selectedDate);
}

class StoreCalendarOpenedState extends StoreState {}