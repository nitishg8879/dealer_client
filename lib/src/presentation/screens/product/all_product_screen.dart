import 'dart:async';

import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/data_sources/app_fire_base_loc.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/home/home_cubit.dart';
import 'package:bike_client_dealer/src/presentation/cubit/product/product_cubit.dart';
import 'package:bike_client_dealer/src/presentation/screens/auth_popup_view.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/product_filter_view.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class AllProductScreen extends StatefulWidget {
  final CategoryModel? selectedCategory;
  final CompanyModel? selectedCompany;
  final List<String>? products;
  const AllProductScreen({
    super.key,
    this.selectedCategory,
    this.selectedCompany,
    this.products,
  });

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final productCubit = ProductCubit(getIt.get(), getIt.get());
  var productFilterController = ProductsFilterController(
    category: getIt.get<HomeCubit>().homeData?.category ?? [],
    company: getIt.get<HomeCubit>().homeData?.company ?? [],
    categoryCompanyBrands:
        getIt.get<HomeCubit>().homeData?.categoryCompnaymodel ?? [],
  );
  final scrollController = ScrollController();
  DocumentSnapshot? lastDocument;
  final scrollPhysics = const BouncingScrollPhysics();

  @override
  void initState() {
    super.initState();
    handlePreFilterDataAndFetch();
    addListnerInScrolling();
    // getIt.get<AppFireBaseLoc>().product.where('searchQueryOnName', arrayContains: "name").get().then((val) {
    //   print(val.docs.length);
    // });
  }

  @override
  void dispose() {
    productCubit.close();
    removeScrollingListner();
    scrollController.dispose();
    super.dispose();
  }

  void handlePreFilterDataAndFetch() {
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      if (widget.selectedCategory != null) {
        if (productFilterController.category
            .any((e) => widget.selectedCategory?.id == e.id)) {
          productFilterController.selectedCategory.add(productFilterController
              .category
              .firstWhere((e) => e.id == widget.selectedCategory?.id));
        }
      }

      if (widget.selectedCompany != null) {
        if (productFilterController.company
            .any((e) => widget.selectedCompany?.id == e.id)) {
          productFilterController.selectedCompany.add(productFilterController
              .company
              .firstWhere((e) => e.id == widget.selectedCompany?.id));
        }
      }
      if (widget.products != null && widget.products!.isNotEmpty) {
        productFilterController.products = List.from(widget.products!);
      }
      productCubit.fetchProducts(productFilterController, (ld) {
        if (!productFilterController.hasFilter) {
          lastDocument = ld;
        } else {
          productCubit.totalData = null;
          lastDocument = null;
        }
      });
    });
  }

  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      productCubit.fetchProducts(productFilterController, (ld) {
        if (!productFilterController.hasFilter) {
          lastDocument = ld;
        } else {
          productCubit.totalData = null;
          lastDocument = null;
        }
      });
    });
  }

  void addListnerInScrolling() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          productCubit.state is! ProductLoading) {
        productCubit.fetchMoreProducts(
          lastdoc: (ld) => lastDocument = ld,
          lastDocument: lastDocument,
          req: productFilterController,
        );
      }
    });
  }

  void removeScrollingListner() {
    scrollController.removeListener(() {});
  }

  void showFilterPopUp() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: 16.smoothRadius)),
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) => ProductFilterView(
        controller: productFilterController,
        homeCubit: getIt.get<HomeCubit>(),
        onReset: () {
          productFilterController.clear();
          fetchData();
          context.pop();
          productCubit.updateProductFilterUI();
        },
        onAppply: () {
          fetchData();
          context.pop();
          productCubit.updateProductFilterUI();
        },
      ),
    ).whenComplete(() {
      setState(() {});
      if (productFilterController.hasFilter) {
        removeScrollingListner();
      } else {
        addListnerInScrolling();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingActionBtn(),
      body: BlocBuilder<ProductCubit, ProductState>(
        bloc: productCubit,
        buildWhen: (previous, current) {
          return (current is ProductHasError ||
              current is ProductLoaded ||
              current is ProductLoading);
        },
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
                onreTry: fetchData,
                errorMsg: state.errorMsg,
              ),
            );
          }
          if (state is ProductLoaded) {
            if (productCubit.products.isEmpty) {
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
                physics: scrollPhysics,
                controller: scrollController,
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                itemBuilder: (context, index) {
                  return ProductView(
                      product: productCubit.products[index], row: false);
                },
                itemCount: productCubit.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1,
                ),
              ),
              child: ListView.separated(
                physics: scrollPhysics,
                controller: scrollController,
                padding: const EdgeInsets.only(left: 16, right: 16),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: ProductView(
                        product: productCubit.products[index],
                        row: true,
                      ),
                    );
                  }
                  return ProductView(product: productCubit.products[index]);
                },
                separatorBuilder: (context, index) {
                  return 10.spaceH;
                },
                itemCount: productCubit.products.length,
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

  BlocBuilder<ProductCubit, ProductState> _buildFloatingActionBtn() {
    return BlocBuilder<ProductCubit, ProductState>(
      bloc: productCubit,
      buildWhen: (previous, current) => current is ProductLazyLoading,
      builder: (context, state) {
        if (state is ProductLazyLoading) {
          if (state.isLoading) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(
                  width: 24,
                  height: 24,
                ),
                child: const FloatingActionButton(
                  onPressed: null,
                  backgroundColor: AppColors.kPurple60,
                  child: CircularProgressIndicator(
                    color: AppColors.kFoundatiionPurple800,
                    strokeWidth: 1.2,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  AppAppbar _buildAppbar(BuildContext context) {
    return AppAppbar(
      onback: context.pop,
      actions: [
        UnconstrainedBox(
          child: OutlinedButton(
            onPressed: () {
              showSearch(context: context, delegate: AllProductsSearch());
            },
            child: const CustomSvgIcon(
              assetName: AppAssets.search,
              color: AppColors.kCardGrey400,
              size: 20,
            ),
          ),
        ),
        16.spaceW,
        UnconstrainedBox(
          child: BlocBuilder<ProductCubit, ProductState>(
            bloc: productCubit,
            builder: (context, state) {
              return Badge(
                isLabelVisible: productFilterController.hasFilter,
                child: OutlinedButton(
                  onPressed: showFilterPopUp,
                  child: const CustomSvgIcon(
                    assetName: AppAssets.filter,
                    color: AppColors.kCardGrey400,
                    size: 20,
                  ),
                ),
              );
            },
          ),
        ),
        16.spaceW,
        UnconstrainedBox(
          child: OutlinedButton(
            onPressed: () {
              if (!getIt.get<AppLocalService>().isLoggedIn) {
                AuthPopupViewDialogShow.show(tap: () {
                  context.goNamed(Routes.favourite);
                });
              } else {
                context.goNamed(Routes.favourite);
              }
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
}

class AllProductsSearch extends SearchDelegate {
  Future<List<ProductModel>> searchProducts(String query) async {
    if (query.isEmpty) return [];
    List<ProductModel> results = [];
    try {
      QuerySnapshot snapshot = await getIt
          .get<AppFireBaseLoc>()
          .product
          .where('searchQueryOnName', arrayContains: query)
          .get();
      results = snapshot.docs
          .map((doc) =>
              ProductModel.fromJson(doc.data() as Map<String, dynamic>)
                ..id = doc.id)
          .toList();
    } catch (e) {
      print("Error fetching search results: $e");
    }

    return results;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
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
    return FutureBuilder<List<ProductModel>>(
      future: searchProducts(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products found.'));
        }

        final results = snapshot.data!;

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(results[index].name ?? '-'),
              onTap: () {
                context.pushNamed(Routes.productDetails, extra: results[index]);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: searchProducts(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No suggestions.'));
        }
        final suggestions = snapshot.data!;
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(suggestions[index].name ?? '-'),
              onTap: () {
                context.pushNamed(Routes.productDetails,
                    extra: suggestions[index]);
              },
            );
          },
        );
      },
    );
  }
}
