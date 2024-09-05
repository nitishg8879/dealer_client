import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/system_chrome.dart';

class AppAppbar extends AppBar {
  final Function()? onback;
  AppAppbar({
    super.key,
    this.onback,
    super.actions,
    super.elevation,
  });
  @override
  Widget? get title => UnconstrainedBox(
        child: OutlinedButton(
          onPressed: onback,
          child: const CustomSvgIcon(
            assetName: AppAssets.arrowLeft,
            color: AppColors.kCardGrey400,
            size: 20,
          ),
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
        // systemNavigationBarDividerColor: AppColors.kBlack900,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
}
