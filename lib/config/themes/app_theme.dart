import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static String fontFamily = "Switzer";
  static TextTheme lightTextTheme() {
    return TextTheme(
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w300,
        fontSize: 10,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w300,
        fontSize: 14,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w700,
        fontSize: 26,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w700,
        fontSize: 32,
      ),
    );
  }

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.grey150,
    primaryColor: AppColors.primaryColor,
    fontFamily: fontFamily,
    menuTheme: MenuThemeData(
      style: MenuStyle(
        fixedSize: const WidgetStatePropertyAll(Size(double.infinity, 200)),
        surfaceTintColor: const WidgetStatePropertyAll<Color>(Colors.white),
        maximumSize: const WidgetStatePropertyAll<Size>(Size.infinite),
        backgroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
        elevation: const WidgetStatePropertyAll<double>(30),
        shadowColor: const WidgetStatePropertyAll<Color>(Color.fromRGBO(77, 45, 136, 0.15)),
        side: WidgetStatePropertyAll<BorderSide>(BorderSide(color: AppColors.grey300.withOpacity(0.2))),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.whiteColor,
      shadowColor: AppColors.grey200,
      elevation: 12,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.grey150,
      centerTitle: true,
      shadowColor: AppColors.primaryColor.withOpacity(0.4),
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        textStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.black900,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        fixedSize: const Size(double.maxFinite, 45),
        foregroundColor: AppColors.cardBlue,
        side: BorderSide(
          color: AppColors.cardBlue,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        backgroundColor: AppColors.cardBlue,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: 20.borderRadius),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        textStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.black900,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        fixedSize: const Size(double.maxFinite, 45),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    ),
    textTheme: lightTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      // contentPadding: 10,
      hintStyle: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.black900,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey400, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      // focusedBorder: OutlineInputBorder(
      //   borderSide: BorderSide(color: AppColors.primaryColor, width: AppSize.xs),
      //   borderRadius: BorderRadius.all(Radius.circular(8)),
      // ),
      // errorBorder: OutlineInputBorder(
      //   borderSide: BorderSide(color: AppColors.redColor, width: AppSize.xs),
      //   borderRadius: BorderRadius.all(Radius.circular(8)),
      // ),
      // focusedErrorBorder: OutlineInputBorder(
      //   borderSide: BorderSide(color: AppColors.primaryColor, width: AppSize.xs),
      //   borderRadius: BorderRadius.all(Radius.circular(8)),
      // ),
    ),
  );
}
