import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppSizedBox on num {
  SizedBox get spaceW => SizedBox(width: toDouble());
  SizedBox get spaceH => SizedBox(height: toDouble());

  BorderRadiusGeometry get borderRadius => BorderRadius.circular(toDouble());
  BorderRadius get borderRadius2 => BorderRadius.circular(toDouble());
  SmoothBorderRadius get smoothBorderRadius => SmoothBorderRadius.all(
        SmoothRadius(cornerRadius: toDouble(), cornerSmoothing: 1),
      );
  SmoothRadius get smoothRadius => SmoothRadius(cornerRadius: toDouble(), cornerSmoothing: 1);
}

extension AppDeviceSize on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  TextTheme get textTheme => Theme.of(this).textTheme;
  // AppLocalizations get appLocalizations => AppLocalizations.of(this)!;
}

extension AppDateFormat on DateTime {
  String get dhhmma => DateFormat('d, hh:mm a').format(this);

  String get monthYear => DateFormat('MMMM  yyyy').format(this);
  String get dayWeekdayYear => DateFormat('d EEEE yyyy').format(this);
  String get appweekday => DateFormat('EEE').format(this);
  String get appDay => DateFormat('dd').format(this);
}
