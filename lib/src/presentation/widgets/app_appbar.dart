import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/system_chrome.dart';

class AppAppbar extends AppBar {
  final Function()? onback;
  final String? pageName;
  AppAppbar({
    super.key,
    this.onback,
    super.actions,
    super.leading,
    super.flexibleSpace,
    super.elevation,
    this.pageName,
  });
  @override
  Widget? get title => UnconstrainedBox(
        child: Row(
          children: [
            OutlinedButton(
              onPressed: onback,
              child: const CustomSvgIcon(
                assetName: AppAssets.arrowLeft,
                color: AppColors.kCardGrey400,
                size: 20,
              ),
            ),
            if (pageName != null) ...[
              16.spaceW,
              Text(pageName!),
            ]
          ],
        ),
      );
  @override
  Color? get backgroundColor => AppColors.kGrey50;

  @override
  bool? get centerTitle => false;

  @override
  double? get elevation => super.elevation ?? 1;

  @override
  bool get automaticallyImplyLeading => false;

  @override
  SystemUiOverlayStyle? get systemOverlayStyle => const SystemUiOverlayStyle(
        statusBarColor: AppColors.kGrey50,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarColor: AppColors.kGrey50,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
}
