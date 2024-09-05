import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/product_filter_view.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        onback: context.pop,
        actions: [
          UnconstrainedBox(
            child: OutlinedButton(
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
          ),
          16.spaceW,
        ],
      ),
      body: Visibility(
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
      ),
    );
  }
}
