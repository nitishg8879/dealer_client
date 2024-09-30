import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/domain/use_cases/product/fav_usecase.dart';
import 'package:bike_client_dealer/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:bike_client_dealer/src/presentation/screens/auth_popup_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductFav extends StatefulWidget {
  final String id;
  final Color addedFavColor, notAddedFavColor;
  final double size;
  const ProductFav({
    super.key,
    required this.id,
    this.size = 24,
    this.addedFavColor = AppColors.kRed,
    this.notAddedFavColor = AppColors.kRed,
  });

  @override
  State<ProductFav> createState() => _ProductFavState();
}

class _ProductFavState extends State<ProductFav> {
  bool get isFav {
    return getIt.get<AppLocalService>().isLoggedIn && (getIt.get<AppLocalService>().currentUser?.favProduct?.contains(widget.id) ?? false);
  }

  bool isLoading = false;

  Future<void> addToFavourite() async {
    if (isLoading) return;
    if (!getIt.get<AppLocalService>().isLoggedIn) {
      AuthPopupViewDialogShow.show(tap: addToFavourite);
    } else {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 2));
      final state = await getIt.get<AddToFavouriteUseCase>().call(id: widget.id);
      if (state is DataSuccess) {
        await updateUser(true);
      }
      if (state is DataFailed) {
        HelperFun.showErrorSnack(state.message ?? "Something went wrong.");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> removeFavourite() async {
    if (isLoading) return;

    if (!getIt.get<AppLocalService>().isLoggedIn) {
      AuthPopupViewDialogShow.show(tap: removeFavourite);
    } else {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 2));
      final state = await getIt.get<RemoveFromFavouriteUsecase>().call(id: widget.id);
      if (state is DataSuccess) {
        await updateUser(false);
      }
      if (state is DataFailed) {
        HelperFun.showErrorSnack(state.message ?? "Something went wrong.");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateUser(bool isAdd) async {
    if (isAdd) {
      getIt.get<AppLocalService>().currentUser?.favProduct?.add(widget.id);
      getIt.get<AppLocalService>().currentUser?.favProduct = List.from(getIt.get<AppLocalService>().currentUser?.favProduct?.toSet().toList() ?? []);
    } else {
      getIt.get<AppLocalService>().currentUser?.favProduct?.remove(widget.id);
      getIt.get<AppLocalService>().currentUser?.favProduct = List.from(getIt.get<AppLocalService>().currentUser?.favProduct?.toSet().toList() ?? []);
    }
    await getIt.get<AppLocalService>().login(getIt.get<AppLocalService>().currentUser!);
    getIt.get<AuthCubit>().updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: getIt.get<AuthCubit>(),
      builder: (context, state) {
        if (isLoading) {
          return SizedBox(
            width: widget.size / 1.2,
            height: widget.size / 1.2,
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: isFav ? widget.addedFavColor : widget.notAddedFavColor,
            ),
          );
        }
        return IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.expand(width: widget.size, height: widget.size),
          onPressed: isFav ? removeFavourite : addToFavourite,
          icon: Skeleton.ignore(
            child: CustomSvgIcon(
              assetName: isFav ? AppAssets.favFill : AppAssets.fav,
              color: isFav ? widget.addedFavColor : widget.notAddedFavColor,
            ),
          ),
        );
      },
    );
  }
}
