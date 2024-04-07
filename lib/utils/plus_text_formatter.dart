import 'package:flutter/services.dart';

class PlusTextFormatter extends TextInputFormatter {
  PlusTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith('+')) {
      return newValue;
    }

    return newValue.copyWith(
        text: '+' + newValue.text, selection: TextSelection.collapsed(offset: newValue.text.length + 1));
  }
}
