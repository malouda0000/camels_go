import 'package:camels_go/core/helpers/dio_helper.dart';
import 'package:camels_go/view/store/model/product_history_model.dart';
import 'package:camels_go/view/store/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitialState()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(StoreLoadingState());
      try {
        final response = await DioHelper.getProducts(event.companyId);

        if (response.statusCode == 200) {
          final data = response.data['data'] as List;
          final products =
              data.map((product) => ProductModel.fromJson(product)).toList();
          emit(StoreLoadedState(products: products));
        } else {
          emit(StoreErrorState(response.data['message']));
        }
      } catch (e) {
        emit(StoreErrorState('Failed to fetch products'));
      }
    });

    on<FetchProductHistoryEvent>((event, emit) async {
      emit(StoreLoadingState());
      try {
        final response = await DioHelper.getProductHistory(22);

        print("here fetch product history ${response.data}");

        if (response.statusCode == 200) {
          final data = response.data['data'] as List;
          final history =
              data.map((item) => ProductHistoryModel.fromJson(item)).toList();
          emit(ProductHistoryLoadedState(history: history));
        } else {
          emit(StoreErrorState(response.data['message']));
        }
      } catch (e) {
        emit(StoreErrorState('Failed to fetch product history'));
      }
    });
  }
}