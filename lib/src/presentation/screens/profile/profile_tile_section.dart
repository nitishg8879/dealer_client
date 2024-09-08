import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileTileSelection extends StatelessWidget {
  final String title;
  final List<ProfileTileTileModel> items;
  const ProfileTileSelection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: 16.borderRadius2,
      ),
      color: AppColors.kWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.spaceH,
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          12.spaceH,
          ...items.map(
            (e) {
              return InkWell(
                onTap: () {
                  if (e.onTap != null) {
                    e.onTap!();
                  } else {
                    context.pushNamed(e.routePath);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      16.spaceW,
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.kGrey100,
                          borderRadius: 24.borderRadius,
                        ),
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: UnconstrainedBox(
                            child: Icon(
                              e.icon,
                              size: 16,
                              color: AppColors.kBlack900,
                            ),
                          ),
                        ),
                      ),
                      12.spaceW,
                      Expanded(
                        child: Text(
                          e.titile,
                          style: context.textTheme.displaySmall,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                      16.spaceW,
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class ProfileTileTileModel {
  final IconData icon;
  final String titile;
  final String routePath;
  final void Function()? onTap;

  ProfileTileTileModel({
    required this.icon,
    required this.titile,
    required this.routePath,
    this.onTap,
  });
}
