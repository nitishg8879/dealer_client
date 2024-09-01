import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:flutter/material.dart' show Locale, LocalizationsDelegate;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class L10n {
  static final all = [
    const Locale('en', "English"),
    const Locale('ar', "Arabic"),
    const Locale('hi', "Hindi"),
  ];

  // static String getFlagByCountryCode(String code) {
  //   return switch (code) {
  //     "ar" => AppAssets.arabic,
  //     "hi" => AppAssets.indonesia,
  //     _ => AppAssets.englishUs,
  //   };
  // }

  static List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    AppLocalizations.delegate,
  ];
}
