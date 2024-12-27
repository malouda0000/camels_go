// lib/bloc/vendor_state.dart

import 'package:camels_go/view/home/model/meta_data_model.dart';
import 'package:camels_go/view/home/model/vendor_companys_model.dart';
import 'package:equatable/equatable.dart';


abstract class VendorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VendorInitialState extends VendorState {}

class VendorLoadingState extends VendorState {}

class VendorCompaniesLoadedState extends VendorState {
  final List<VendorCompany> companies;
  final MetaDataModel metaDataModel;

  VendorCompaniesLoadedState({required this.companies, required this.metaDataModel});

  @override
  List<Object?> get props => [companies, metaDataModel];
}

class VendorCompanyLoaded extends VendorState {
  final VendorCompany company;

  VendorCompanyLoaded({required this.company});

  @override
  List<Object?> get props => [company];
}

class VendorErrorState extends VendorState {
  final String message;

  VendorErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
