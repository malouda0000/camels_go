// lib/bloc/vendor_event.dart

import 'package:equatable/equatable.dart';

abstract class VendorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchVendorCompaniesEvent extends VendorEvent {
  final int page;
  final int pageSize;

  FetchVendorCompaniesEvent({this.page = 1, this.pageSize = 5});

  @override
  List<Object?> get props => [page, pageSize];
}

class FetchCurrentCompanyEvent extends VendorEvent {
  final int companyId;

  FetchCurrentCompanyEvent(this.companyId);

  @override
  List<Object?> get props => [companyId];
}
