import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final favBloc = FavouriteCubit(getIt.get());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      favBloc.fetchFavouriteProducts();
    });
  }

  @override
  void dispose() {
    favBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        onback: context.pop,
        pageName: "Favourite",
        actions: [
          UnconstrainedBox(
            child: OutlinedButton(
              onPressed: () {
                // setState(() {
                //   row = !row;
                // });
              },
              child: const CustomSvgIcon(
                assetName: AppAssets.search,
                color: AppColors.kCardGrey400,
                size: 20,
              ),
            ),
          ),
          16.spaceW,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<FavouriteCubit, FavouriteState>(
          bloc: favBloc,
          builder: (context, state) => Skeletonizer(
            enabled: state is FavouriteLoading,
            child: Builder(builder: (context) {
              if (state is FavouriteLoading) {
                return GridView.builder(
                  itemBuilder: (context, index) => ProductView(
                    product: ProductModel.fromJson({}),
                    row: false,
                  ),
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 1,
                  ),
                );
              } else if (state is FavouriteError) {
                return ErrorView(onreTry: favBloc.fetchFavouriteProducts, errorMsg: state.error);
              } else if (state is FavouriteLoaded) {
                return GridView.builder(
                  itemBuilder: (context, index) => ProductView(product: state.products[index], row: false),
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 1,
                  ),
                );
              } else {
                return const Center(child: Text("W.S contact to developer"));
              }
            }),
          ),
        ),
      ),
    );
  }
}
