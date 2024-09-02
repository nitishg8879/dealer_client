import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ProductFilterChips extends StatelessWidget {
  final String label;
  const ProductFilterChips({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.kFoundationPurple50,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          children: [
            Text(label),
          ],
        ),
      ),
    );
  }
}
