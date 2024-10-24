import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/fav_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FetchFavouriteProductsUseCase _fetchFavouriteProductsUseCase;
  FavouriteCubit(
    this._fetchFavouriteProductsUseCase,
  ) : super(FavouriteLoading());

  @override
  void emit(FavouriteState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> fetchFavouriteProducts() async {
    emit(FavouriteLoading());
    final resp = await _fetchFavouriteProductsUseCase.call(ids: getIt.get<AppLocalService>().currentUser?.favProduct ?? []);
    if (resp is DataSuccess) {
      print(resp.data?.length ?? "No Fav Data Bro");
      emit(FavouriteLoaded(resp.data ?? []));
      getIt.get<AppLocalService>().currentUser?.favProduct = resp.data?.map((e) => e.id!).toList() ?? <String>[];
      getIt.get<AppLocalService>().login(getIt.get<AppLocalService>().currentUser!);
    }

    if (resp is DataFailed) {
      emit(FavouriteError(resp.message ?? "Something wen't wrong."));
    }
  }
}
