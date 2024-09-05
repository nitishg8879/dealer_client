import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel? product;
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return Scaffold(
        body: Text("No Product Details found"),
      );
    }
    return Scaffold(
      appBar: AppAppbar(
        onback: context.pop,
        elevation: 0,
        actions: [
          UnconstrainedBox(
            child: OutlinedButton(
              onPressed: () {},
              child: const CustomSvgIcon(
                assetName: AppAssets.share,
                color: AppColors.kCardGrey400,
                size: 20,
              ),
            ),
          ),
          16.spaceW,
        ],
      ),
      body: ListView(
        controller: scrollController,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Container(
            // padding: const EdgeInsets.all(4),
            color: AppColors.kWhite,
            height: 300,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  children: widget.product?.images
                          ?.map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Image.network(
                                e,
                                width: context.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          .toList() ??
                      [],
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: 12.borderRadius,
                      color: AppColors.kBlack900,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      child: Text(
                        "1 / 2",
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
