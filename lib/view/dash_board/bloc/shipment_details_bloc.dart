import 'package:camels_go/core/helpers/dio_helper.dart';
import 'package:camels_go/view/dash_board/model/shipment_details_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shipment_details_event.dart';
part 'shipment_details_state.dart';

class ShipmentDetailsBloc
    extends Bloc<ShipmentDetailsEvent, ShipmentDetailsState> {
  ShipmentDetailsBloc() : super(ShipmentDetailsInitialState()) {
    on<FetchShipmentDetailsEvent>((event, emit) async {
      emit(ShipmentDetailsLoadingState());

      print("here shipment details event ${event.shipmentId}");

      try {
        final response = await DioHelper.getShipmentDetails(event.shipmentId);

        print(
            "here shipment details response:${response.data['data']}");

        if (response.statusCode == 200) {
          final data = response.data['data']['shipment_details'];

          final shipmentDetails = ShipmentDetailsModel.fromJson(data);
          final customerDetails = CustomerDetailsModel.fromJson(response.data['data']['customer_details']);
          emit(ShipmentDetailsLoadedState(shipmentDetails: shipmentDetails, customerDetails: customerDetails));
        } else {
          emit(ShipmentDetailsErrorState(response.data['message']));
        }
      } catch (e) {
        print("here shipment details error: ${e}");
        emit(ShipmentDetailsErrorState('Failed to fetch shipment details'));
      }
    });
  }
}
