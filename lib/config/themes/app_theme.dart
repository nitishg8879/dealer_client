import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static String fontFamily = "Inter";
  static TextTheme get lightTextTheme {
    return TextTheme(
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w300,
        fontSize: 10,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w300,
        fontSize: 14,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w700,
        fontSize: 26,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w700,
        fontSize: 32,
      ),
    );
  }

  static List<BoxShadow> get boxShadows => [
        BoxShadow(
          color: Colors.grey.shade400,
          spreadRadius: 1,
          blurRadius: 15,
          offset: const Offset(5, 5),
        ),
        const BoxShadow(
          color: Colors.white,
          offset: Offset(-5, -5),
          blurRadius: 15,
          spreadRadius: 1,
        ),
      ];

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kGrey50,
    useMaterial3: false,
    primaryColor: AppColors.kPrimaryColor,
    fontFamily: fontFamily,
    menuTheme: MenuThemeData(
      style: MenuStyle(
        fixedSize: const WidgetStatePropertyAll(Size(double.infinity, 200)),
        surfaceTintColor: const WidgetStatePropertyAll<Color>(Colors.white),
        maximumSize: const WidgetStatePropertyAll<Size>(Size.infinite),
        backgroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
        elevation: const WidgetStatePropertyAll<double>(30),
        shadowColor: const WidgetStatePropertyAll<Color>(Color.fromRGBO(77, 45, 136, 0.15)),
        side: WidgetStatePropertyAll<BorderSide>(BorderSide(color: AppColors.kGrey300.withOpacity(0.2))),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      ),
    ),
    cardTheme: const CardTheme(
      color: AppColors.kWhite,
      shadowColor: AppColors.kGrey200,
      elevation: 12,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kGrey100,
      centerTitle: true,
      shadowColor: AppColors.kPrimaryColor.withOpacity(0.4),
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        textStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.kBlack900,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        padding: const EdgeInsets.all(6),
        overlayColor: AppColors.kFoundationPurple300,
        visualDensity: VisualDensity.compact,
        minimumSize: const Size(48, 48),
        side: const BorderSide(
          color: AppColors.kFoundationPurple100,
        ),
        backgroundColor: AppColors.kFoundationBlue50,
        shape: const SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.all(
            SmoothRadius(cornerRadius: 14, cornerSmoothing: 1),
          ),
          side: BorderSide(
            color: AppColors.kFoundationPurple100,
          ),
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
          color: AppColors.kWhite,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        backgroundColor: AppColors.blueColor,
        foregroundColor: AppColors.kWhite,
        shape: RoundedRectangleBorder(borderRadius: 20.borderRadius),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        textStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.kBlack900,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        fixedSize: const Size(double.maxFinite, 45),
        backgroundColor: AppColors.kPrimaryColor,
        foregroundColor: AppColors.kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    ),
    textTheme: lightTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      // contentPadding: 10,
      hintStyle: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        color: AppColors.kBlack900,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.kGrey300, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );
}
