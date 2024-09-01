import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/config/themes/app_theme.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/core/util/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/cubit/home/home_cubit.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final homeBloc = HomeCubit(ProductFetchUsecases(getIt()));
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      // getIt<HomeCubit>().getAllPost();
    });
  }

  String dummyImage =
      "https://images.unsplash.com/photo-1691493261970-1b4afc2391be?q=80&w=2831&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            12.spaceH,
            Row(
              children: [
                Ink(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: 50.borderRadius,
                    boxShadow: AppTheme.boxShadows,
                  ),
                  child: ClipRRect(
                    borderRadius: 50.borderRadius,
                    child: Image.network(
                      dummyImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Spacer(),
                Ink(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: 50.borderRadius,
                    border: Border.all(
                      color: AppColors.kGrey300,
                    ),
                    boxShadow: AppTheme.boxShadows,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: const CustomSvgIcon(
                      assetName: AppAssets.notification,
                      color: AppColors.kBlack900,
                    ),
                  ),
                ),
                16.spaceW,
                Ink(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: 50.borderRadius,
                    border: Border.all(
                      color: AppColors.kGrey300,
                    ),
                    boxShadow: AppTheme.boxShadows,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: const CustomSvgIcon(
                      assetName: AppAssets.search,
                      color: AppColors.kBlack900,
                    ),
                  ),
                ),
              ],
            ),
            16.spaceH,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  10,
                  (index) => Container(
                    height: 200,
                    width: context.width - 64,
                    decoration: BoxDecoration(
                      boxShadow: AppTheme.boxShadows,
                    ),
                    margin: const EdgeInsets.only(right: 16),
                    child: ClipRRect(
                      borderRadius: 16.borderRadius,
                      child: Image.network(
                        dummyImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            32.spaceH,
            Text(
              "Categories",
              style: context.textTheme.displayLarge,
            ),
            8.spaceH,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  10,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      height: 64,
                      width: 64,
                      child: Material(
                        shape: const SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius.all(
                            SmoothRadius(cornerRadius: 12, cornerSmoothing: 1),
                          ),
                          // side: BorderSide(
                          //   color: AppColors.kRed,
                          // ),
                        ),
                        child: ClipRRect(
                          borderRadius: 16.borderRadius,
                          child: Image.network(
                            "https://thumbs.dreamstime.com/b/web-183281772.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return SizedBox();
    return Scaffold(
      body: BlocBuilder(
        bloc: getIt<HomeCubit>(),
        builder: (context, state) {
          return switch (state) {
            HomeLoading _ => const Center(
                child: CircularProgressIndicator(),
              ),
            HomeLoaded _ => _buildProductList(state),
            HomeHasError _ => const Center(
                child: Text('Error happen!!'),
              ),
            _ => const Center(
                child: Text('Something went wrong'),
              )
          };
        },
      ),
    );
  }

  Widget _buildProductList(HomeLoaded state) {
    if (state.products.isEmpty) {
      return const Center(
        child: Text("No Data"),
      );
    } else {
      return ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(state.products[index].name ?? "-"),
            subtitle: Image.network(state.products[index].images!.first),
          );
        },
      );
    }
  }
}
