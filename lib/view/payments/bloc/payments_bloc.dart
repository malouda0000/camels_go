import 'package:camels_go/core/helpers/dio_helper.dart';
import 'package:camels_go/view/payments/model/payment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  int totalPages = 0;
  List<PaymentModel> allPayments = [];

  PaymentsBloc() : super(PaymentsInitialState()) {
    on<FetchPaymentsEvent>((event, emit) async {
      emit(PaymentsLoadingState());
      // try {
      //   final response = await DioHelper.getPayments(
      //     companyId: event.companyId,
      //     page: event.page,
      //     pageSize: event.pageSize,
      //     date: event.date,
      //   );
      //   if (response.statusCode == 200) {
      //     // print("response from get payments${response.data['total_due_amount']} ${response.data['total_due_amount'].runtimeType} ${response.data}");
      //     final data = response.data['data']['data'] as List;
      //     final totalDueAmount = response.data['total_due_amount'];
      //     final payments =
      //         data.map((item) => PaymentModel.fromJson(item)).toList();
      //     totalPages = response.data['data']['meta']['last_page'];

      //     if (event.page == 1) {
      //       allPayments = payments;
      //     } else {
      //       allPayments.addAll(payments);
      //     }

      //     emit(PaymentsLoadedState(
      //       payments: allPayments,
      //       totalDueAmount: totalDueAmount,
      //     ));
      //   } else {
      //     emit(PaymentsErrorState(response.data['message']));
      //   }
      // } catch (e) {
      //   emit(PaymentsErrorState('Failed to fetch payments'));
      // }


      try {
        final response = await DioHelper.getPayments(
          // companyId: event.companyId,
          // page: event.page,
          // pageSize: event.pageSize,
          // date: event.date,
        );
        if (response.statusCode == 200) {
          // print("response from get payments${response.data['total_due_amount']} ${response.data['total_due_amount'].runtimeType} ${response.data}");
          final data = response.data['data']['data'] as List;
          final totalDueAmount = response.data['total_due_amount'];
          final payments =
              data.map((item) => PaymentModel.fromJson(item)).toList();
          totalPages = response.data['data']['meta']['last_page'];

          if (event.page == 1) {
            allPayments = payments;
          } else {
            allPayments.addAll(payments);
          }

          emit(PaymentsLoadedState(
            payments: allPayments,
            totalDueAmount: totalDueAmount,
          ));
        } else {
          emit(PaymentsErrorState(response.data['message']));
        }
      } catch (e) {
        emit(PaymentsErrorState('Failed to fetch payments'));
      }


    });

    on<PaymentsDayChangedEvent>((event, emit) {
      emit(PaymentsDayChangedState(selectedDate: event.selectedDate));
    });
  }
}
