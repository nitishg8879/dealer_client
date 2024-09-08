import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductView extends StatelessWidget {
  final ProductModel product;
  final bool row;
  final bool fromChatPin;
  final void Function()? onChatPinCLose;
  final bool fromChatReadyOnly;
  const ProductView({
    super.key,
    required this.product,
    this.row = true,
    this.fromChatPin = false,
    this.onChatPinCLose,
    this.fromChatReadyOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    print(fromChatPin);
    return OutlinedButton(
      onPressed: () {
        context.push(Routes.productDetails, extra: product);
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(row ? 10 : 4.0),
          child: row ? rowWise(context) : columnWise(context),
        ),
      ),
    );
  }

  Widget columnWise(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: 10.borderRadius,
          child: Image.network(
            product.images!.first,
            width: double.infinity,
            height: 93,
            fit: BoxFit.cover,
          ),
        ),
        8.spaceH,
        Row(
          children: [
            Expanded(
              child: Text(
                product.name ?? '-',
                style: context.textTheme.displaySmall,
                maxLines: 1,
              ),
            ),
            InkWell(
              onTap: () {},
              child: const CustomSvgIcon(
                assetName: AppAssets.fav,
                size: 14,
              ),
            )
          ],
        ),
        8.spaceH,
        Text(
          "${product.year} | ${product.kmDriven} Km | ${product.ownerType}",
          style: context.textTheme.displayMedium?.copyWith(
            fontSize: 12,
            color: AppColors.kCardGrey400,
          ),
          maxLines: 1,
        ),
        6.spaceH,
        Text(
          product.price.toINR,
          style: context.textTheme.displaySmall,
        ),
      ],
    );
  }

  Widget rowWise(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: 10.borderRadius,
            child: Image.network(
              product.images!.first,
              width: 100,
              height: 93,
              fit: BoxFit.cover,
            ),
          ),
        ),
        10.spaceW,
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.name ?? '-',
                style: context.textTheme.labelSmall,
              ),
              6.spaceH,
              Text(
                "${product.year}  |  ${product.kmDriven} Km  |  ${product.ownerType}",
                style: context.textTheme.displayMedium?.copyWith(
                  fontSize: 12,
                  color: AppColors.kCardGrey400,
                ),
              ),
              6.spaceH,
              Row(
                children: [
                  const CustomSvgIcon(
                    assetName: AppAssets.location,
                    size: 16,
                  ),
                  5.spaceW,
                  Text(
                    product.branch ?? '',
                    style: context.textTheme.displayMedium?.copyWith(
                      fontSize: 12,
                      color: AppColors.kCardGrey400,
                    ),
                  )
                ],
              ),
              6.spaceH,
              Text(
                product.price.toINR,
                style: context.textTheme.labelSmall,
              ),
            ],
          ),
        ),
        10.spaceW,
        if (!fromChatReadyOnly)
          InkWell(
            onTap: () {
              if (onChatPinCLose != null) {
                onChatPinCLose!();
              }
            },
            child: fromChatPin
                ? const Icon(
                    Icons.close,
                    color: AppColors.black,
                  )
                : const CustomSvgIcon(
                    assetName: AppAssets.fav,
                  ),
          )
      ],
    );
  }
}
