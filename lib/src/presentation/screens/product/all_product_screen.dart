import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/config/themes/app_theme.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/product_filter_chips.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              16.spaceH,
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            10,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ProductFilterChips(label: "Test $index"),
                                )),
                      ),
                    ),
                  ),
                  16.spaceH,
                  Ink(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: 50.borderRadius,
                      border: Border.all(
                        color: AppColors.kborderColor,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: CustomSvgIcon(
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
                        color: AppColors.kborderColor,
                      ),
                      // boxShadow: AppTheme.boxShadows,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: CustomSvgIcon(
                        assetName: AppAssets.search,
                        color: AppColors.kBlack900,
                      ),
                    ),
                  ),
                ],
              ),
              16.spaceH,
              Expanded(child: Column()),
            ],
          ),
        ),
      ),
    );
  }
}
