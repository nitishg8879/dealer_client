import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/entities/product_filter_req.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product_fetch_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  ProductFetchUsecases _productFetchUsecases;
  HomeCubit(this._productFetchUsecases) : super(HomeLoading());

  void getAllPost() {
    _productFetchUsecases.call(params: ProductFilterReq()).then((products) {
      emit(HomeLoaded(products));
    });
  }
}
