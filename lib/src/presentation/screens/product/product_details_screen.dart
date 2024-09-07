import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:figma_squircle/figma_squircle.dart';
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
      return const Scaffold(
        body: Text("No Product Details found"),
      );
    }
    return Scaffold(
      appBar: AppAppbar(
        onback: context.pop,
        elevation: 2,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        color: AppColors.kWhite,
        // elevation: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.push(Routes.chats),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kBlack900,
                    shape: const SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius.all(
                        SmoothRadius(
                          cornerRadius: 12,
                          cornerSmoothing: 1,
                        ),
                      ),
                      side: BorderSide(
                        color: AppColors.kFoundationPurple100,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomSvgIcon(
                        assetName: AppAssets.chat,
                        color: AppColors.kWhite,
                        size: 20,
                      ),
                      8.spaceW,
                      const Text("Negotaiate"),
                    ],
                  ),
                ),
              ),
              16.spaceW,
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius.all(
                        SmoothRadius(
                          cornerRadius: 12,
                          cornerSmoothing: 1,
                        ),
                      ),
                      side: BorderSide(
                        color: AppColors.kFoundationPurple100,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomSvgIcon(
                        assetName: AppAssets.wallet,
                        color: AppColors.kWhite,
                        size: 20,
                      ),
                      8.spaceW,
                      Text("Book at ${100.toINR}"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
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
                    top: 8,
                    right: 8,
                    child: DecoratedBox(
                      decoration: const ShapeDecoration(
                        color: AppColors.kBlack900,
                        shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius.all(
                            SmoothRadius(cornerRadius: 8, cornerSmoothing: 1),
                          ),
                          side: BorderSide(
                            color: AppColors.kFoundationPurple100,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            body(),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.spaceH,
          Row(
            children: [
              Expanded(
                child: Text(
                  "X Pulse  200",
                  style: context.textTheme.headlineSmall,
                ),
              ),
              const CustomSvgIcon(
                assetName: AppAssets.favFill,
                color: AppColors.kRed,
              )
            ],
          ),
          4.spaceH,
          Text(
            75000.toINR,
            style: context.textTheme.headlineSmall,
          ),
          4.spaceH,
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mauris, scelerisque eu mauris id, pretium pulvinar sapien.",
            style: context.textTheme.titleMedium,
          ),
          32.spaceH,
          Material(
            shape: SmoothRectangleBorder(
              borderRadius: 12.smoothBorderRadius,
              borderAlign: BorderAlign.inside,
            ),
            color: AppColors.kWhite,
            shadowColor: AppColors.kFoundationPurple100,
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Details",
                    style: context.textTheme.labelMedium,
                  ),
                  16.spaceH,
                  titleSubtitle("KM Driven", "1,000", assetName: AppAssets.distance),
                  titleSubtitle("Model", "2014", assetName: AppAssets.calender),
                  titleSubtitle("Insaurance Validity", "2 Sep 2024", assetName: AppAssets.calender),
                  titleSubtitle("Valid Till", "2 Sep 2036", assetName: AppAssets.calenderTill),
                  titleSubtitle("Number Plate", "MH-04 2626", assetName: AppAssets.distance),
                  titleSubtitle("Tyre Condition", "Good", assetName: AppAssets.distance),
                  titleSubtitle("Fine", "Yes (${3345.toINR})", assetName: AppAssets.fine),
                  titleSubtitle("Owners", "3", wantDivider: false, assetName: AppAssets.users),
                ],
              ),
            ),
          ),
          32.spaceH,
          Material(
            shape: SmoothRectangleBorder(
              borderRadius: 12.smoothBorderRadius,
              borderAlign: BorderAlign.inside,
            ),
            color: AppColors.kWhite,
            shadowColor: AppColors.kFoundationPurple100,
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Default Details",
                    style: context.textTheme.labelMedium,
                  ),
                  16.spaceH,
                  titleSubtitle("Wheel", "2", assetName: AppAssets.wheel),
                  titleSubtitle("Engine cc", "124", assetName: AppAssets.wheel),
                  titleSubtitle("Launch date", "2 Sep 2024", assetName: AppAssets.calender),
                  titleSubtitle("On Road Price", "1,75,000", assetName: AppAssets.wheel),
                  titleSubtitle("Company", "Honda", assetName: AppAssets.company),
                  titleSubtitle("Mileage", "30-40km", wantDivider: false, assetName: AppAssets.mileage),
                ],
              ),
            ),
          ),
          100.spaceH,
        ],
      ),
    );
  }

  Widget titleSubtitle(
    String label,
    String value, {
    bool wantDivider = true,
    String? assetName,
  }) {
    return Column(
      children: [
        4.spaceH,
        Row(
          children: [
            if (assetName != null) ...[
              // 4.spaceW,
              CustomSvgIcon(
                assetName: assetName,
                color: AppColors.kFoundationPurple700.withOpacity(.8),
                size: 18,
              ),
              16.spaceW,
            ],
            Expanded(
              child: Text(
                label,
                style: context.textTheme.displaySmall,
              ),
            ),
            Text(
              value,
              style: context.textTheme.titleSmall?.copyWith(
                color: AppColors.kBlack900.withOpacity(.8),
              ),
            ),
          ],
        ),
        4.spaceH,
        if (wantDivider)
          const Divider(
            color: AppColors.kFoundationPurple100,
          )
      ],
    );
  }
}
