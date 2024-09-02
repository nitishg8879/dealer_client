import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/config/themes/app_theme.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/product_filter_chips.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final products = <ProductModel>[
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
    ProductModel(
      images: ['https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize'],
      kmDriven: 2000,
      name: "KTM 200 Duke",
      ownerType: "1st Owner",
      price: 75000,
      year: 2023,
      branch: "Andheri,Mumbai",
    ),
  ];
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
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {},
                      child: const CustomSvgIcon(
                        assetName: AppAssets.search,
                        color: AppColors.kCardGrey400,
                      ),
                    ),
                    16.spaceW,
                    OutlinedButton(
                      onPressed: () {},
                      child: const CustomSvgIcon(
                        assetName: AppAssets.filter,
                        color: AppColors.kCardGrey400,
                      ),
                    ),
                    16.spaceW,
                    // 16.spaceW,
                    // Expanded(
                    //   child: Material(
                    //     child: SingleChildScrollView(
                    //       scrollDirection: Axis.horizontal,
                    //       child: Row(
                    //         children: List.generate(
                    //           10,
                    //           (index) => Padding(
                    //             padding: const EdgeInsets.only(right: 8.0),
                    //             child: ProductFilterChips(label: "Test $index"),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            // 12.spaceH,
            Expanded(
                child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                if (index == 0) return Padding(padding: const EdgeInsets.only(top: 12), child: ProductView(product: products[index]));
                return ProductView(product: products[index]);
              },
              separatorBuilder: (context, index) {
                return 10.spaceH;
              },
              itemCount: products.length,
            )),
          ],
        ),
      ),
    );
  }
}
