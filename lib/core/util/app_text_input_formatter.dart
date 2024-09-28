import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumbersOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Regular expression that allows only numbers
    final RegExp regExp = RegExp(r'^[0-9]*$');

    // If the new value matches the regular expression, return it; otherwise, return the old value
    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

class RupeeInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹ ');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any non-numeric characters
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Parse the numeric value and format it with commas and rupee symbol
    final int value = int.parse(newText);
    final String formattedValue = _formatter.format(value).replaceAll('.00', '');

    // Update the text field
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}

class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,##0', 'en_IN');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any non-numeric characters

    if (newValue.text.trim().isEmpty) {
      return newValue.copyWith(text: '');
    }
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Parse the numeric value and format it with commas
    final int value = int.parse(newText);
    final String formattedValue = _formatter.format(value);

    // Update the text field
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
