import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/product_fetch_usecase.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/product_total_count_usecase.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductFetchUsecase _productFetchUseCase;
  ProductTotalCountUsecase _productTotalCountUsecase;
  ProductCubit(
    this._productFetchUseCase,
    this._productTotalCountUsecase,
  ) : super(ProductLoading());

  int? totalData;
  List<ProductModel> products = [];

  @override
  void emit(ProductState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> fetchProducts(
    ProductsFilterController req,
    void Function(DocumentSnapshot<Object?>) lastdoc,
  ) async {
    emit(ProductLoading());
    totalData ??= await _productCount(req: req);
    final resp = await _productFetchUseCase.call(
      req: req,
      lastdoc: lastdoc,
    );
    if (resp is DataSuccess) {
      products = resp.data ?? [];
      emit(ProductLoaded());
    }
    if (resp is DataFailed) {
      emit(ProductHasError(resp.message ?? "Something went wrong."));
    }
  }

  Future<void> fetchMoreProducts({
    required void Function(DocumentSnapshot<Object?>) lastdoc,
    required DocumentSnapshot? lastDocument,
    required ProductsFilterController req,
  }) async {
    if (req.hasFilter || totalData == products.length || (state is ProductLazyLoading && (state as ProductLazyLoading).isLoading)) {
      return;
    }
    try {
      emit(ProductLazyLoading(true));
      final data = await _productFetchUseCase.call(
        req: req,
        lastdocument: lastDocument,
        lastdoc: lastdoc,
      );
      products.addAll(data.data ?? []);
      products.toSet().toList();
      emit(ProductLoaded());
      print("Current List Count:${products.length}     Total Row:$totalData");
    } catch (e) {
      print(e.toString());
    } finally {
      emit(ProductLazyLoading(false));
    }
  }

  Future<int> _productCount({
    ProductsFilterController? req,
  }) async {
    final resp = await _productTotalCountUsecase.call(req: req);
    return resp.data ?? 0;
  }

  void updateProductFilterUI() {
    emit(ProductHasFilter());
  }
}
