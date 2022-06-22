import 'package:flutter/services.dart';

class ReplacementFormatter extends TextInputFormatter {
  ReplacementFormatter({
    required this.toReplace,
    required this.replaceBy,
  });

  final String toReplace;
  final String replaceBy;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.replaceAll(toReplace, replaceBy));
  }
}
