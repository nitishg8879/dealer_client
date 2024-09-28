import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/product_fetch_usecase.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductFetchUsecase _productFetchUseCase;
  ProductCubit(
    this._productFetchUseCase,
  ) : super(ProductLoading());

  Future<void> fetchProducts(ProductsFilterController req) async {
    emit(ProductLoading());
    if (kDebugMode) {
      await Future.delayed(Duration(seconds: 2));
    }
    final resp = await _productFetchUseCase.call(req: req);
    if (resp is DataSuccess) {
      emit(ProductLoaded(resp.data ?? []));
    }
    if (resp is DataFailed) {
      emit(ProductHasError(resp.message ?? "Something went wrong."));
    }
  }
}
