// lib/bloc/vendor_bloc.dart

import 'package:camels_go/view/home/bloc/vendro_bloc/bloc/vendor_services.dart';
import 'package:camels_go/view/home/model/meta_data_model.dart';
import 'package:camels_go/view/home/model/vendor_companys_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'vendor_event.dart';
import 'vendor_state.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final VendorService vendorService;

  VendorBloc(this.vendorService) : super(VendorInitialState()) {
    on<FetchVendorCompaniesEvent>(_onFetchVendorCompanies);
    on<FetchCurrentCompanyEvent>(_onFetchCurrentCompany);
  }

  Future<void> _onFetchVendorCompanies(
      FetchVendorCompaniesEvent event, Emitter<VendorState> emit) async {
    emit(VendorLoadingState());
    try {
      final response = await vendorService.getVendorCompanies(
          page: event.page, pageSize: event.pageSize);

      final List<VendorCompany> companies = (response['data']['data'] as List)
          .map((company) => VendorCompany.fromJson(company))
          .toList();

      final MetaDataModel metaDataModel =
          MetaDataModel.fromJson(response['data']['meta']);

      emit(VendorCompaniesLoadedState(
          companies: companies, metaDataModel: metaDataModel));
    } catch (e) {
      emit(VendorErrorState(e.toString()));
    }
  }

  Future<void> _onFetchCurrentCompany(
      FetchCurrentCompanyEvent event, Emitter<VendorState> emit) async {
    emit(VendorLoadingState());
    try {
      final response = await vendorService.getCurrentCompany(event.companyId);

      final VendorCompany company = VendorCompany.fromJson(response['data']);

      emit(VendorCompanyLoaded(company: company));
    } catch (e) {
      emit(VendorErrorState(e.toString()));
    }
  }
}
