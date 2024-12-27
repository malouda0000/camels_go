import 'package:camels_go/core/helpers/dio_helper.dart';
import 'package:camels_go/view/dash_board/model/emirate_model.dart';
import 'package:camels_go/view/dash_board/model/shipment_model.dart';
import 'package:camels_go/view/dash_board/model/status_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitialState()) {
    on<LoadDashboardEvent>((event, emit) async {
      emit(DashboardLoadingState());
      await Future.delayed(Duration(seconds: 2));
      emit(DashboardLoadedState(
        deliveredPercentage: 0.0,
        canceledPercentage: 0.0,
        delayedPercentage: 0.0,
        statusList: [],
        emirateList: [],
      ));
    });

    on<FetchShipmentSummaryEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        final shipmentSummaryResponse = await DioHelper.getShipmentSummary(
          companyId: event.companyId,
          date: event.date,
        );

        print('here shipment summary response: ${shipmentSummaryResponse.data}');

        final statusListResponse = await DioHelper.getStatusList();
        final emirateListResponse = await DioHelper.getEmirateList();

        List<StatusListModel> statusList = [];
        List<EmirateModel> emirateList = [];
        double deliveredPercentage = 0.0,
            canceledPercentage = 0.0,
            delayedPercentage = 0.0;

        print('here status list response: ${statusListResponse.data}'); 

        if (statusListResponse.statusCode == 200) {
          final data = statusListResponse.data['data'] as List;
          statusList =
              data.map((status) => StatusListModel.fromJson(status)).toList();
        } else {
          emit(DashboardErrorState(statusListResponse.data['message']));
        }

        print('here emirate list response: ${emirateListResponse.data}');

        if (emirateListResponse.statusCode == 200) {
          final data = emirateListResponse.data['data'] as List;
          emirateList =
              data.map((emirate) => EmirateModel.fromJson(emirate)).toList();
        } else {
          emit(DashboardErrorState(emirateListResponse.data['message']));
        }

        print('here shipment summary response: ${shipmentSummaryResponse.data}');

        if (shipmentSummaryResponse.statusCode == 200) {
          final data = shipmentSummaryResponse.data;
          deliveredPercentage = double.parse(data['delivered_percentage']);
          canceledPercentage = double.parse(data['canceled_percentage']);
          delayedPercentage = double.parse(data['delayed_percentage']);
        } else {
          emit(DashboardErrorState(shipmentSummaryResponse.data['message']));
        }

        print('here before emit dashboard loaded state');

        emit(DashboardLoadedState(
          deliveredPercentage: deliveredPercentage,
          canceledPercentage: canceledPercentage,
          delayedPercentage: delayedPercentage,
          statusList: statusList,
          emirateList: emirateList,
        ));
      } catch (e) {
        emit(DashboardErrorState('Failed to fetch data'));
      }
    });

    //   on<FetchShipmentsEvent>((event, emit) async {
    //     emit(ShipmentLoadingState());
    //     try {
    //       final response = await DioHelper.getShipments(
    //         companyId: event.companyId,
    //         page: event.page,
    //         pageSize: event.pageSize,
    //         date: event.date,
    //         statusId: event.statusId,
    //         emirateId: event.emirateId,
    //       );

    //       print("here shipments: ${response.data}");

    //       if (response.statusCode == 200) {
    //         final data = response.data['data']['data'] as List;
    //         final shipments =
    //             data.map((shipment) => ShipmentModel.fromJson(shipment)).toList();
    //         emit(ShipmentLoadedState(
    //           shipments: shipments,
    //         ));
    //         print('here after emit in get shipment list');
    //       } else {
    //         emit(DashboardErrorState(response.data['message']));
    //       }
    //     } catch (e) {
    //       emit(DashboardErrorState('Failed to fetch shipments'));
    //     }
    //   });
    // }
  }
}

class ShipmentBloc extends Bloc<DashboardEvent, DashboardState> {
  int totalPages = 0;
  int? selectedStatus;

  ShipmentBloc() : super(DashboardInitialState()) {
    on<LoadDashboardEvent>((event, emit) async {
      emit(ShipmentLoadingState());
      await Future.delayed(Duration(seconds: 2));
      emit(ShipmentLoadedState(
        shipments: [],
      ));
    });

    on<FetchShipmentsEvent>((event, emit) async {
      emit(ShipmentLoadingState());
      try {
        selectedStatus = event.statusId;

        print('here selected status: $selectedStatus ${event.emirateId} ${event.fromDate} ${event.toDate}');

        final response = await DioHelper.getShipments(
          companyId: event.companyId,
          page: event.page,
          pageSize: event.pageSize,
          fromDate: event.fromDate,
          toDate: event.toDate,
          statusId: event.statusId,
          emirateId: event.emirateId,
        );

        print("here shipments: ${response.data}");

        if (response.statusCode == 200) {
          final data = response.data['data']['data'] as List;
          final shipments =
              data.map((shipment) => ShipmentModel.fromJson(shipment)).toList();
          totalPages = response.data['data']['meta']['last_page'];

          emit(ShipmentLoadedState(
            shipments: shipments,
          ));
          print('here after emit in get shipment list');
        } else {
          emit(DashboardErrorState(response.data['message']));
        }
      } catch (e) {
        emit(DashboardErrorState('Failed to fetch shipments'));
      }
    });

    
    on<SearchShipmentsEvent>((event, emit) async {
      emit(ShipmentLoadingState());
      try {
        final response = await DioHelper.searchShipments(
          companyId: event.companyId,
          search: event.search,
          page: event.page,
          pageSize: event.pageSize,
        );

        if (response.statusCode == 200) {
          final data = response.data['data']['data'] as List;
          final shipments =
              data.map((shipment) => ShipmentModel.fromJson(shipment)).toList();
          totalPages = response.data['data']['meta']['last_page'];

          emit(ShipmentLoadedState(shipments: shipments));
        } else {
          emit(DashboardErrorState(response.data['message']));
        }
      } catch (e) {
        emit(DashboardErrorState('Failed to search shipments'));
      }
    });

    on<ChangeStatusEvent>((event, emit) {
      print('here status id: ${event.statusId}');
      // selectedStatus = event.statusId;
      add(FetchShipmentsEvent(
        companyId: event.companyId,
        page: 1,
        statusId: event.statusId,
      ));
    });
  }
}
