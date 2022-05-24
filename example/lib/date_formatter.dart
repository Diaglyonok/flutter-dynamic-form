import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  static DateFormat byLocale(BuildContext context, {short = false}) {
    final String? deviceLocale = WidgetsBinding.instance?.window.locale.toLanguageTag();
    final locale = deviceLocale == null ? const Locale('en') : Locale(deviceLocale);

    if (locale.languageCode.startsWith('ru')) {
      return DateFormat('dd.MM' + (short ? '' : '.yyyy'));
    }

    //locale.languageCode == 'en'
    return DateFormat('MM/dd' + (short ? '' : '/yyyy'));
  }
}

extension DateFormatExt on DateFormat {
  DateTime? safeStrictParse(String? inp) {
    try {
      return parseStrict(inp!);
    } catch (e) {
      return null;
    }
  }

  String? safeFormat(DateTime? dateTime) {
    try {
      return format(dateTime!);
    } catch (e) {
      return null;
    }
  }
}
