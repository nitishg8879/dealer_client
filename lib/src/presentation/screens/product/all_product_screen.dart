import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/presentation/cubit/home/home_cubit.dart';
import 'package:bike_client_dealer/src/presentation/cubit/product/product_cubit.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/product_filter_view.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final productCubit = getIt.get<ProductCubit>();
  var productFilterController = ProductsFilterController(
    priceMinMaxSelected: const RangeValues(0, 0),
    kmMinMaxSelected: const RangeValues(0, 0),
    gridViewtype: true,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      productCubit.fetchProducts(productFilterController);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: BlocBuilder<ProductCubit, ProductState>(
        bloc: productCubit,
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(
              child: Lottie.asset(
                AppAssets.searching,
                repeat: true,
                animate: true,
                height: 100,
              ),
            );
          }
          if (state is ProductHasError) {
            return Center(
              child: ErrorView(
                onreTry: () => productCubit.fetchProducts(productFilterController),
                errorMsg: state.errorMsg,
              ),
            );
          }
          if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return Center(
                child: Lottie.asset(
                  AppAssets.noData,
                  repeat: false,
                  height: 250,
                  animate: true,
                ),
              );
            }
            return Visibility(
              visible: !productFilterController.gridViewtype,
              replacement: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                itemBuilder: (context, index) {
                  return ProductView(product: state.products[index], row: false);
                },
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1,
                ),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: ProductView(
                        product: state.products[index],
                        row: true,
                      ),
                    );
                  }
                  return ProductView(product: state.products[index]);
                },
                separatorBuilder: (context, index) {
                  return 10.spaceH;
                },
                itemCount: state.products.length,
              ),
            );
          }
          return const Center(
            child: Text("Wrong Sate."),
          );
        },
      ),
    );
  }

  AppAppbar _buildAppbar(BuildContext context) {
    return AppAppbar(
      onback: context.pop,
      actions: [
        UnconstrainedBox(
          child: OutlinedButton(
            onPressed: () {},
            child: const CustomSvgIcon(
              assetName: AppAssets.search,
              color: AppColors.kCardGrey400,
              size: 20,
            ),
          ),
        ),
        16.spaceW,
        UnconstrainedBox(
          child: OutlinedButton(
            onPressed: showFilterPopUp,
            child: const CustomSvgIcon(
              assetName: AppAssets.filter,
              color: AppColors.kCardGrey400,
              size: 20,
            ),
          ),
        ),
        16.spaceW,
        UnconstrainedBox(
          child: OutlinedButton(
            onPressed: () {
              context.goNamed(Routes.favourite);
            },
            child: const CustomSvgIcon(
              assetName: AppAssets.favFill,
              color: AppColors.kRed,
              size: 20,
            ),
          ),
        ),
        16.spaceW,
      ],
    );
  }

  void showFilterPopUp() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: 16.smoothRadius)),
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) => ProductFilterView(
        controller: productFilterController,
        homeCubit: getIt.get<HomeCubit>(),
      ),
    ).whenComplete(() => setState(() {}));
  }
}
