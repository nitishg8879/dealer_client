import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/data/model/product_sell_model.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SellProductCard extends StatelessWidget {
  final ProductSellModel model;
  final void Function() onTap;
  const SellProductCard({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(15),
        decoration: ShapeDecoration(
          color: AppColors.kWhite,
          shape: SmoothRectangleBorder(
            borderRadius: 22.smoothBorderRadius,
            side: const BorderSide(
              color: Color(0xffE0E8F2),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: ShapeDecoration(
                color: AppColors.blueColor.withOpacity(.3),
                shape: SmoothRectangleBorder(
                  borderRadius: 12.smoothBorderRadius,
                  side: const BorderSide(
                    color: Color(0xffE0E8F2),
                  ),
                ),
              ),
              child: icon,
            ),
            10.spaceW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name ?? '-',
                    style: context.textTheme.headlineSmall,
                  ),
                  3.spaceH,
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: model.status?.color.withOpacity(.3),
                      borderRadius: 4.borderRadius,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        model.status?.name ?? '-',
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: model.status?.color,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  3.spaceH,
                  Text(
                    model.note ?? '',
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  model.price.to2DecimalINR,
                  style: context.textTheme.headlineSmall,
                ),
                5.spaceH,
                Text(
                  model.creationDate == null ? '-' : DateFormat('dd MMM yyyy\nhh:mm a').format(model.creationDate!.toDate()),
                  textAlign: TextAlign.end,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get icon => switch (model.status) {
        ProductSellStatus.InReview => const Icon(Icons.access_time_filled_outlined),
        ProductSellStatus.Approve => const Icon(Icons.check),
        ProductSellStatus.Reject => const Icon(Icons.cancel),
        null => throw UnimplementedError(),
      };
}
