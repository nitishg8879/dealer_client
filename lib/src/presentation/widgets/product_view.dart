import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  final ProductModel product;
  const ProductView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: SizedBox(
        width: double.infinity,
        height: 113,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
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
                    // 10.spaceH,
                    Text(
                      "${product.year}  |  ${product.kmDriven} Km  |  ${product.ownerType}",
                      style: context.textTheme.displayMedium?.copyWith(
                        fontSize: 12,
                        color: AppColors.kCardGrey400,
                      ),
                    ),
                    // 10.spaceH,
                    Row(
                      children: [
                        CustomSvgIcon(
                          assetName: AppAssets.location,
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
                    Text(
                      product.price.toINR,
                      style: context.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              10.spaceW,
              CustomSvgIcon(
                assetName: AppAssets.fav,
              )
            ],
          ),
        ),
      ),
    );
  }
}
