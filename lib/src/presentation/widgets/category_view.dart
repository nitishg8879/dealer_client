import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  final String image, name;
  const CategoryView({
    super.key,
    required this.image,
    required this.name,
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
              child: CachedNetworkImage(
                imageUrl: image,
                errorWidget: (context, url, error) {
                  return const Center(child: Icon(Icons.error));
                },
              ),
            ),
          ),
        ),
        4.spaceH,
        Text(
          name,
          style: context.textTheme.displayMedium?.copyWith(
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
