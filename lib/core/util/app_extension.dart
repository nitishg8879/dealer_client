import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

extension currencyApp on num? {
  String get toINR => this == null ? '₹ 0' : NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0).format(this);
  String get to2DecimalINR => this == null ? '₹ 0' : NumberFormat.currency(locale: 'en_IN', symbol: '₹ ', decimalDigits: 2).format(this ?? 0);

  String get to2DecimalWithoutInr => this == null ? '0' : NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 2).format(this ?? 0);
  String get readableNumber => this == null ? '0' : NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 0).format(this ?? 0);
}

extension AppDeviceSize on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom != 0;
  // AppLocalizations get appLocalizations => AppLocalizations.of(this)!;
}

extension AppDateFormat on DateTime {
  String get dhhmma => DateFormat('d, hh:mm a').format(this);
  String get hhmma => DateFormat('hh:mm a').format(this);
  String get ddMMYYYYHHMMSS => DateFormat('dd/MM/yyyy HH:mm:ss a').format(this);

  String get monthYear => DateFormat('MMMM  yyyy').format(this);
  String get dayWeekdayYear => DateFormat('d EEEE yyyy').format(this);
  String get appweekday => DateFormat('EEE').format(this);
  String get appDay => DateFormat('dd').format(this);
}
