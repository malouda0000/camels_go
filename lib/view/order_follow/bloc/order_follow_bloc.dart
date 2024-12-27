import 'package:camels_go/core/helpers/dio_helper.dart';
import 'package:camels_go/view/order_follow/model/shipment_tracking_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_follow_event.dart';
part 'order_follow_state.dart';

class OrderFollowBloc extends Bloc<OrderFollowEvent, OrderFollowState> {
  OrderFollowBloc() : super(OrderFollowInitialState()) {
    on<FetchOrderFollowEvent>((event, emit) async {
      emit(OrderFollowLoadingState());
      try {
        final response = await DioHelper.getShipmentTracking(
            shipmentId: event.shipmentId, companyId: event.companyId);

        print("here from get tarccking order follow${event.shipmentId} ${response.data}");

        if (response.statusCode == 200) {
          final data = response.data;
          final track = ShipmentTrackingResponse.fromJson(data);

          emit(OrderFollowLoadedState(shipmentTrackingResponse: track));
        } else {
          emit(OrderFollowErrorState(response.data['message']));
        }
      } catch (e) {
        print("here from error order follow $e");
        emit(OrderFollowErrorState('Failed to fetch shipment tracking'));
      }
    });
  }
}
