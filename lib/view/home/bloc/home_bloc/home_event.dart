part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchVendorCompaniesEvent extends HomeEvent {
  final int page;
  final int pageSize;

  const FetchVendorCompaniesEvent({this.page = 1, this.pageSize = 5});

  // @override
  // List<Object?> get props => [page, pageSize];
}

class FetchCurrentCompanyEvent extends HomeEvent {
  final int companyId;

  const FetchCurrentCompanyEvent(this.companyId);

  // @override
  // List<Object?> get props => [companyId];
}
