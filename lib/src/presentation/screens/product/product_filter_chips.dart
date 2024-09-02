import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:flutter/material.dart';

class ProductFilterChips extends StatelessWidget {
  final String label;
  const ProductFilterChips({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: 8.borderRadius2,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.kFoundationPurple50,
          borderRadius: 8.borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              Text(
                label,
                style: context.textTheme.displaySmall,
              ),
              5.spaceW,
              const Icon(
                Icons.close,
                color: AppColors.kRed,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}
