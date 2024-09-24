import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/config/themes/app_theme.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/model/category_model.dart';
import 'package:bike_client_dealer/src/data/model/home_analytics_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/home/home_cubit.dart';
import 'package:bike_client_dealer/src/presentation/screens/auth_popup_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/category_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  final homeBloc = getIt.get<HomeCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      homeBloc.fetchHomeAnalyticsData();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeBloc,
          builder: (context, state) {
            if (state is HomeHasError) {
              return ErrorView(
                onreTry: homeBloc.fetchHomeAnalyticsData,
                errorMsg: state.error,
              );
            }
            // if (state is HomeLoading || state is HomeLoaded) {}
            return Skeletonizer(
              enabled: state is HomeLoading,
              // enabled: true,
              enableSwitchAnimation: true,
              effect: const ShimmerEffect(baseColor: AppColors.kPurple60),
              child: _buildBody(context, state is HomeLoaded ? state.data : null),
            );
            // return SizedBox();
          },
        ),
      ),
    );
  }

  ListView _buildBody(BuildContext context, HomeAnalyticsDataModel? data) {
    return ListView(
      controller: scrollController,
      children: [
        16.spaceH,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              InkWell(
                borderRadius: 50.borderRadius2,
                onTap: () {
                  context.pushNamed(Routes.profile);
                },
                child: Ink(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: 50.borderRadius,
                    boxShadow: AppTheme.boxShadows,
                  ),
                  child: ClipRRect(
                    borderRadius: 50.borderRadius,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: getIt.get<AppLocalService>().currentUser?.profileUrl ?? '-',
                      width: 38,
                      height: 38,
                      errorWidget: (context, url, error) {
                        return const Icon(
                          Icons.person,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                child: const CustomSvgIcon(
                  assetName: AppAssets.notification,
                  color: AppColors.kCardGrey400,
                  size: 20,
                ),
              ),
              16.spaceW,
              OutlinedButton(
                onPressed: () {},
                child: const CustomSvgIcon(
                  assetName: AppAssets.search,
                  color: AppColors.kCardGrey400,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        16.spaceH,
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: context.height * .3,
            maxWidth: double.infinity,
          ),
          child: CarouselView(
            backgroundColor: AppColors.kPurple60,
            itemExtent: context.width * .9,
            shrinkExtent: 200,
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(36)),
            itemSnapping: true,
            elevation: 2,
            children: List.generate(
              data?.carsouel?.length ?? 0,
              (i) => CachedNetworkImage(
                imageUrl: data?.carsouel?[i].image ?? '-',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         "Category",
        //         style: context.textTheme.labelLarge,
        //       ),
        //       Row(
        //         children: [
        //           Text(
        //             "View All",
        //             style: context.textTheme.displaySmall?.copyWith(
        //               color: AppColors.kFoundatiionPurple800,
        //             ),
        //           ),
        //           4.spaceW,
        //           const Icon(
        //             Icons.arrow_forward_ios_rounded,
        //             size: 14,
        //             color: AppColors.kFoundatiionPurple800,
        //           )
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        // 8.spaceH,
        // SizedBox(
        //   height: 100,
        //   child: ListView.separated(
        //     itemCount: category.length,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.all(2.0),
        //         child: CategoryView(
        //           category: category[index],
        //         ),
        //       );
        //     },
        //     scrollDirection: Axis.horizontal,
        //     separatorBuilder: (BuildContext context, int index) {
        //       return 16.spaceW;
        //     },
        //   ),
        // ),

        Column(
          children: List.generate(
            data?.products?.length ?? 0,
            (i) => ProductCategoryGridView(
              homeProducts: data!.products![i],
              scrollController: scrollController,
            ),
          ),
        )
      ],
    );
  }
}

class ProductCategoryGridView extends StatelessWidget {
  final HomeProducts homeProducts;
  final ScrollController scrollController;
  const ProductCategoryGridView({super.key, required this.homeProducts, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          16.spaceH,
          Row(
            children: [
              Expanded(
                child: Text(
                  homeProducts.label ?? '-',
                  style: context.textTheme.labelLarge,
                ),
              ),
              InkWell(
                onTap: () {
                  // context.goNamed(Routes.allProduct);
                },
                borderRadius: 4.borderRadius2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Text(
                        "View All",
                        style: context.textTheme.displaySmall?.copyWith(
                          color: AppColors.kFoundatiionPurple800,
                        ),
                      ),
                      4.spaceW,
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: AppColors.kFoundatiionPurple800,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          8.spaceH,
          GridView.builder(
            shrinkWrap: true,
            controller: scrollController,
            itemBuilder: (context, index) {
              return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: getIt.get<AppFireBaseLoc>().product.doc(homeProducts.products?[index]).get(),
                builder: (context, snapshot) {
                  return Skeletonizer(
                    enabled: snapshot.connectionState == ConnectionState.waiting,
                    child: ProductView(
                      product: ProductModel.fromJson(snapshot.data?.data() ?? {}),
                      row: false,
                    ),
                  );
                },
              );
            },
            itemCount: homeProducts.products?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1,
            ),
          ),
          16.spaceH
        ],
      ),
    );
  }
}
