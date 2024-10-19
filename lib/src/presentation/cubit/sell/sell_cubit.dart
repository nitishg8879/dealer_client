import 'package:bike_client_dealer/config/routes/app_routes.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/model/product_sell_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/sell/sell_form_view.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:go_router/go_router.dart';

part 'sell_state.dart';

class SellCubit extends Cubit<SellState> {
  SellCubit() : super(SellLoading());
  bool isFormSaving = false;

  Future<void> fetchSellProducts() async {
    try {
      emit(SellLoading());
      final resp = await getIt
          .get<AppFireBaseLoc>()
          .productBuy
          .orderBy(
            'creationDate',
            descending: true,
          )
          .get()
          .catchError((error) => throw error);
      emit(SellLoaded(resp.docs.map((e) => ProductSellModel.fromJson(e.data())..id = e.id).toList()));
    } catch (e) {
      emit(SellError(e.toString()));
    }
  }

  void openSellForm(BuildContext context, {ProductSellModel? data}) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: 16.smoothRadius)),
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) => SellFormView(
        sellCubit: this,
        data: data,
      ),
    ).then((val) {
      if (val != null && val is bool && val) {
        fetchSellProducts();
      }
    });
  }

  Future<void> addOrUpdateSellProduct({
    required ProductSellModel sellProduct,
    required List<PlatformFile> localFile,
    required List<String> deleteFile,
  }) async {
    if (isFormSaving) return;
    try {
      isFormSaving = true;
      sellProduct.images ??= [];
      emit(SellUploading(''));
      //? Setting query Name
      sellProduct.searchqueryonname = HelperFun.setSearchParameters(sellProduct.name ?? '');
      //? Deleting File
      if (deleteFile.isNotEmpty) {
        for (var element in deleteFile) {
          getIt.get<AppFireBaseLoc>().sellStorage.child(HelperFun.extractFileName(element)).delete();
          sellProduct.images?.remove(element);
        }
      }
      if (localFile.isNotEmpty) {
        int filesCount = localFile.length;
        emit(SellUploading('Pending $filesCount'));
        for (var element in localFile) {
          final url = await HelperFun.uploadFile(
            getIt.get<AppFireBaseLoc>().sellStorage,
            element,
            (val) {
              emit(SellUploading('Pending $filesCount $val%'));
            },
          );
          if (url != null) {
            sellProduct.images?.add(url);
          }
          filesCount--;
        }
        emit(SellUploading('Creating'));
      }
      if (sellProduct.id == null) {
        await getIt.get<AppFireBaseLoc>().productBuy.add(sellProduct.toJson());
      } else {
        await getIt.get<AppFireBaseLoc>().productBuy.doc(sellProduct.id).update(sellProduct.toJson(isUpdate: true));
      }
      emit(SellUploading(null));
      AppRoutes.rootNavigatorKey.currentContext!.pop(true);
    } catch (e) {
      HelperFun.showErrorSnack(e.toString());
    } finally {
      isFormSaving = false;
    }
  }
}
