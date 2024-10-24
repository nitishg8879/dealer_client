import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_fav.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductView extends StatelessWidget {
  final ProductModel product;
  final bool row;
  final bool fromChatPin;
  final void Function()? onTap;
  final void Function()? onChatPinCLose;
  final bool fromChatReadyOnly;
  const ProductView({
    super.key,
    required this.product,
    this.onTap,
    this.row = true,
    this.fromChatPin = false,
    this.onChatPinCLose,
    this.fromChatReadyOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (onTap == null) {
          context.push(Routes.productDetails, extra: product);
        } else {
          onTap!();
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(row ? 10 : 0.0),
          child: row ? rowWise(context) : columnWise(context),
        ),
      ),
    );
  }

  Widget columnWise(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.spaceH,
        Expanded(
          child: ClipRRect(
            borderRadius: 10.borderRadius,
            child: Visibility(
              visible: product.images != null,
              replacement: const SizedBox(
                width: double.infinity,
                height: 93,
              ),
              child: CachedNetworkImage(
                imageUrl: product.images != null && (product.images?.isNotEmpty ?? false) ? product.images!.first : '',
                width: double.infinity,
                height: 93,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return const Center(child: Icon(Icons.error));
                },
              ),
            ),
          ),
        ),
        6.spaceH,
        Row(
          children: [
            Expanded(
              child: Text(
                product.name ?? '-',
                style: context.textTheme.displaySmall,
                maxLines: 1,
              ),
            ),
            ProductFav(
              id: product.id ?? '',
              addedFavColor: AppColors.kBlack900,
              notAddedFavColor: AppColors.kBlack900,
              size: 14,
            )
          ],
        ),
        6.spaceH,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //? Model
            Row(
              children: [
                Skeleton.ignore(
                  child: CustomSvgIcon(
                    assetName: AppAssets.calender,
                    color: AppColors.kFoundationPurple700.withOpacity(.8),
                    size: 14,
                  ),
                ),
                3.spaceW,
                Text(
                  product.bikeBuyDate?.toDate().mmyy ?? '-',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: AppColors.kBlack900.withOpacity(.8),
                  ),
                ),
              ],
            ),
            //? Owners
            Row(
              children: [
                Skeleton.ignore(
                  child: CustomSvgIcon(
                    assetName: AppAssets.users,
                    color: AppColors.kFoundationPurple700.withOpacity(.8),
                    size: 14,
                  ),
                ),
                3.spaceW,
                Text(
                  "${product.owners ?? '-'}",
                  style: context.textTheme.titleSmall?.copyWith(
                    color: AppColors.kBlack900.withOpacity(.8),
                  ),
                ),
              ],
            ),
            // //? KM Driven
            Row(
              children: [
                Skeleton.ignore(
                  child: CustomSvgIcon(
                    assetName: AppAssets.distance,
                    color: AppColors.kFoundationPurple700.withOpacity(.8),
                    size: 14,
                  ),
                ),
                3.spaceW,
                Text(
                  product.kmDriven.readableNumber,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: AppColors.kBlack900.withOpacity(.8),
                  ),
                ),
              ],
            ),
          ],
        ),
        6.spaceH,
        Row(
          children: [
            Expanded(
              child: Text(
                product.price.toINR,
                style: context.textTheme.displaySmall,
              ),
            ),
            if (product.sold ?? false) ...[
              Skeleton.ignore(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.kRed,
                    borderRadius: 6.smoothBorderRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Text(
                      "Sold",
                      style: context.textTheme.displaySmall?.copyWith(
                        color: AppColors.kWhite,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              )
            ] else if (product.bikeBooked ?? false) ...[
              Skeleton.ignore(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.kGreen600,
                    borderRadius: 6.smoothBorderRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Text(
                      "Booked",
                      style: context.textTheme.displaySmall?.copyWith(
                        color: AppColors.kWhite,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              // 4.spaceW,
            ],
          ],
        ),
        6.spaceH,
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
            child: CachedNetworkImage(
              width: 100,
              height: 93,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return const Center(child: Icon(Icons.error));
              },
              imageUrl: product.images != null && (product.images?.isNotEmpty ?? false) ? product.images!.first : '',
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
                product.name ?? '   -    ',
                style: context.textTheme.labelSmall,
              ),
              6.spaceH,
              Text(
                "${product.bikeBuyDate?.toDate().dhhmma} | ${product.kmDriven} Km | ${product.owners}",
                style: context.textTheme.displayMedium?.copyWith(
                  fontSize: 12,
                  color: AppColors.kCardGrey400,
                ),
              ),
              6.spaceH,
              Row(
                children: [
                  // const CustomSvgIcon(
                  //   assetName: AppAssets.location,
                  //   size: 16,
                  // ),
                  ProductFav(
                    id: product.id ?? '',
                    addedFavColor: AppColors.kBlack900,
                    notAddedFavColor: AppColors.kBlack900,
                    size: 16,
                  ),
                  5.spaceW,
                  Text(
                    product.company ?? '',
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
