import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/product_filter_view.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  bool row = true;
  final products = <ProductModel>[
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: [
        'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'
      ],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
  ];
  void showFilterPopUp() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: 16.smoothRadius),
      ),
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return ProductFilterView(
          controller: ProductsFilterController(
            priceMinMax: const RangeValues(0, 100),
            priceMinMaxSelected: const RangeValues(0, 20),
            yearMinMax: const RangeValues(0, 100),
            kmMinMaxSelected: const RangeValues(0, 20),
            kmMinMax: const RangeValues(0, 100),
            yearMinMaxSelected: const RangeValues(0, 20),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Material(
              elevation: .8,
              color: AppColors.kGrey50,
              surfaceTintColor: AppColors.kGrey50,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    16.spaceW,
                    OutlinedButton(
                      onPressed: context.pop,
                      child: const CustomSvgIcon(
                        assetName: AppAssets.arrowLeft,
                        color: AppColors.kCardGrey400,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          row = !row;
                        });
                      },
                      child: const CustomSvgIcon(
                        assetName: AppAssets.search,
                        color: AppColors.kCardGrey400,
                        size: 20,
                      ),
                    ),
                    16.spaceW,
                    OutlinedButton(
                      onPressed: showFilterPopUp,
                      child: const CustomSvgIcon(
                        assetName: AppAssets.filter,
                        color: AppColors.kCardGrey400,
                        size: 20,
                      ),
                    ),
                    16.spaceW,
                    OutlinedButton(
                      onPressed: () {},
                      child: const CustomSvgIcon(
                        assetName: AppAssets.favFill,
                        color: AppColors.kRed,
                        size: 20,
                      ),
                    ),
                    16.spaceW,
                  ],
                ),
              ),
            ),
            Expanded(
                child: Visibility(
              visible: row,
              replacement: GridView.builder(
                shrinkWrap: true,
                // controller: scroController,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                itemBuilder: (context, index) {
                  return ProductView(product: products[index], row: false);
                },
                itemCount: products.length,
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
                        product: products[index],
                        row: true,
                      ),
                    );
                  }
                  return ProductView(product: products[index]);
                },
                separatorBuilder: (context, index) {
                  return 10.spaceH;
                },
                itemCount: products.length,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
