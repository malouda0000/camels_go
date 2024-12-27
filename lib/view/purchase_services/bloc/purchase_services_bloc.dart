import 'package:camels_go/core/helpers/dio_helper.dart';
import 'package:camels_go/view/purchase_services/model/request_model.dart';
import 'package:camels_go/view/purchase_services/model/service_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'purchase_services_event.dart';
part 'purchase_services_state.dart';

class PurchaseServicesBloc extends Bloc<PurchaseServicesEvent, PurchaseServicesState> {
  int totalPages = 0;
  List<RequestModel> allRequests = [];

  PurchaseServicesBloc() : super(PurchaseServicesInitialState()) {
    on<FetchServicesEvent>((event, emit) async {
      emit(PurchaseServicesLoadingState());
      try {
        final response = await DioHelper.getServices();

        if (response.statusCode == 200) {
          final data = response.data['data']['data'] as List;
          final services = data.map((item) => ServiceModel.fromJson(item)).toList();
          emit(PurchaseServicesLoadedState(services: services));
        } else {
          emit(PurchaseServicesErrorState(response.data['message']));
        }
      } catch (e) {
        emit(PurchaseServicesErrorState('Failed to fetch services'));
      }
    });

    on<MakeRequestEvent>((event, emit) async {
      emit(PurchaseServicesLoadingState());
      try {
        final response = await DioHelper.makeRequest(
          companyId: event.companyId,
          serviceId: event.serviceId,
        );

        if (response.statusCode == 200) {
          emit(RequestSuccessState(response.data['message']));
        } else {
          emit(PurchaseServicesErrorState(response.data['message']));
        }
      } catch (e) {
        emit(PurchaseServicesErrorState('Failed to make request'));
      }
    });

    on<FetchRequestsEvent>((event, emit) async {
      emit(PurchaseServicesLoadingState());
      try {
        final response = await DioHelper.getRequests(
          companyId: event.companyId,
          page: event.page,
          pageSize: event.pageSize,
        );

        if (response.statusCode == 200) {
          final data = response.data['data']['data'] as List;
          final requests = data.map((item) => RequestModel.fromJson(item)).toList();
          totalPages = response.data['data']['meta']['last_page'];

          if (event.page == 1) {
            allRequests = requests;
          } else {
            allRequests.addAll(requests);
          }

          emit(RequestsLoadedState(requests: allRequests));
        } else {
          emit(PurchaseServicesErrorState(response.data['message']));
        }
      } catch (e) {
        emit(PurchaseServicesErrorState('Failed to fetch requests'));
      }
    });
  }
}