import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/data/model/category_model.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  final CategoryModel category;
  const CategoryView({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {},
          child: SizedBox(
            width: 80,
            height: 73,
            child: ClipRRect(
              borderRadius: 16.borderRadius,
              child: Image.network(
                category.url ?? '-',
              ),
            ),
          ),
        ),
        4.spaceH,
        Text(
          category.name ?? '-',
          style: context.textTheme.displayMedium?.copyWith(
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
