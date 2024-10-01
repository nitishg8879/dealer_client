import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/fetch_product_by_id_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  FetchProductByIdUsecase _fetchProductByIdUsecase;
  ProductDetailsCubit(this._fetchProductByIdUsecase)
      : super(ProductDetailsLoading());

  Future<void> fetchProduct(String? id, ProductModel? product) async {
    if (kDebugMode) {
      await Future.delayed(Duration(seconds: 2));
    }
    if (product != null) {
      emit(ProductDetailsLoaded(product));
      emit(ProductDetailsImagePosition(1, (product.images?.length ?? 1)));
    } else {
      final resp = await _fetchProductByIdUsecase.call(id: id);
      if (resp is DataSuccess) {
        emit(ProductDetailsImagePosition(1, (resp.data?.images?.length ?? 1)));
        emit(ProductDetailsLoaded(resp.data!));
      }
      if (resp is DataFailed) {
        emit(ProductDetailsHasError(resp.message ?? "Something went wrong"));
      }
    }
  }

  @override
  void emit(ProductDetailsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
