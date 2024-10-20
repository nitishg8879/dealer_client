import 'package:bike_client_dealer/config/routes/app_pages.dart';
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

  void showFavSearch() {
    if (favBloc.state is FavouriteLoaded) {
      showSearch(
        context: context,
        delegate: SearchFavouriteDelegate((favBloc.state as FavouriteLoaded).products),
      );
    }
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
              onPressed: showFavSearch,
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
                if (state.products.isEmpty) {
                  return const Center(
                    child: Text("No favourite found."),
                  );
                }
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

class SearchFavouriteDelegate extends SearchDelegate {
  List<ProductModel> items;
  SearchFavouriteDelegate(this.items);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var list = items.where((e) => e.name?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();
    if (list.isEmpty) {
      return const Center(
        child: Text("No Data"),
      );
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            context.pushNamed(Routes.productDetails, extra: list[index]);
          },
          title: Text(list[index].name ?? '-'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var list = items.where((e) => e.name?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();
    if (list.isEmpty) {
      return const Center(
        child: Text("No Data"),
      );
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            context.pushNamed(Routes.productDetails, extra: list[index]);
          },
          title: Text(list[index].name ?? '-'),
        );
      },
    );
  }
}
