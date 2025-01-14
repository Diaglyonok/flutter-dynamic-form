import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/i18n/strings.g.dart';
import 'package:intl/intl.dart';

import '../model/dynamic_form_models.dart';

class DynamicFormValidators {
  DynamicFormValidators(this.validationOptions, {this.allowFullZip = true});

  final Map<String, ValidationOptions>? validationOptions;
  final bool allowFullZip;

  static String datePattern = 'MM/dd/yyyy';
  static String timePattern = 'HH:mm';

  String? emailValidator(String? email) {
    if (email == null ||
        email.length <= 2 ||
        !email.contains('@') ||
        !email.contains('.') ||
        email.lastIndexOf('.') <= email.indexOf('@') ||
        email.endsWith('.') ||
        email.endsWith('@') ||
        email.startsWith('@')) {
      return t.emailIsNotValidErrorText;
    }

    return null;
  }

  String? timeValidator(String? input) {
    if (input == null || input.isEmpty) {
      return null;
    }

    try {
      DateFormat(timePattern).parseStrict(input);
      return null;
    } catch (e) {
      return t.invalidTime;
    }
  }

  String? dateValidator(String? inputDate, CompareDate? compare, String? pattern) {
    if (inputDate == null || inputDate.isEmpty) {
      return null;
    }
    try {
      final date = DateFormat(pattern ?? datePattern).parseLoose(inputDate);
      var compareDate = DateTime.now();
      compareDate = DateTime(compareDate.year, compareDate.month, compareDate.day);
      switch (compare ?? CompareDate.AllDates) {
        case CompareDate.AllDates:
          break;
        case CompareDate.FutureOnly:
          if (date.compareTo(compareDate) <= 0) {
            throw Error();
          }
          break;
        case CompareDate.PastOnly:
          if (date.compareTo(compareDate) >= 0 || date.year < 1900) {
            throw Error();
          }
          break;
        case CompareDate.FutureAndTodayOnly:
          if (date.compareTo(compareDate) < 0) {
            throw Error();
          }
          break;
        case CompareDate.PastAndTodayOnly:
          if (date.compareTo(compareDate) > 0) {
            throw Error();
          }
          break;
      }
    } catch (e) {
      return t.dateIsNotValidErrorText(format: pattern ?? datePattern);
    }

    return null;
  }

  String? requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return t.fieldIsRequiredErrorText;
    } else {
      return null;
    }
  }

  String? requiredOptionsValidator(CompositeValue value) {
    if (value.value.isEmpty) {
      return t.fieldIsRequiredErrorText;
    } else {
      return null;
    }
  }

  String? phoneValidator(String? field) {
    var value = field;

    //if the text is optional, then check only non-empty
    if (value == null || value.isEmpty) {
      return null;
    }

    return null;
  }

  String? numberValidator(String? field) {
    var value = field;

    //if the text is optional, then check only non-empty
    if (value == null || value.isEmpty) {
      return null;
    }

    if (double.tryParse(value) == null) {
      return t.wrongFormatText;
    }

    return null;
  }

  String? passwordValidator(CompositeValue field) {
    final value = field.value;
    final options =
        validationOptions == null ? DynamicFormsConstants.defaultPasswordVO : validationOptions?['Password'];
    if (options == null) {
      return null;
    }

    final regExp = options.regexp == null ? null : RegExp(options.regexp!);

    if (value.length < options.minLength) {
      return t.passwordErrorText(
        MIN: options.minLength.toString(),
      );
    } else if (options.maxLength > options.minLength && options.maxLength > 0 && value.length > options.maxLength) {
      return t.passwordErrorText(
        MIN: options.minLength.toString(),
      );
    } else if (regExp != null && !(regExp.hasMatch(value))) {
      return t.passwordErrorText(
        MIN: options.minLength.toString(),
      );
    } else {
      return null;
    }
  }

  String? confirmValidator(String? value, String? confirmField, Map<String, CompositeValue> currentValues) {
    final confirmingValue = currentValues[confirmField ?? '']?.value;
    if (confirmingValue != null && confirmingValue != value) {
      return t.fieldDoesNotMatch;
    } else {
      return null;
    }
  }

  String? regExpValidator(String regExpStr, String errorMessage, CompositeValue? value, {bool isRequired = false}) {
    if (regExpStr.isNotEmpty) {
      return null;
    }

    final message = errorMessage.isNotEmpty ? t.wrongFormatText : errorMessage;

    if (value == null || value.value.isNotEmpty) {
      return (isRequired) ? message : null;
    }
    final regexp = RegExp(regExpStr);

    if (!(regexp.hasMatch(value.value))) {
      return message;
    }
    return null;
  }

  String? returnDateValidator(String departureValue, String returnValue, BuildContext context) {
    if (departureValue.isNotEmpty || returnValue.isNotEmpty) {
      return null;
    }
    final departureDate = DateFormat().add_yMd().parse(departureValue);
    final returnDate = DateFormat().add_yMd().parse(returnValue);
    if (departureDate.isBefore(returnDate) || departureDate == returnDate) {
      return null;
    }
    return context.t.returnDateWarning;
  }

  String? datePeriodValidator(String? value, BuildContext context, {String? pattern}) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final splitted = value.split(' - ');

    if (splitted.length != 2) {
      return context.t.periodDateWarning;
    }

    try {
      DateFormat(pattern ?? datePattern).parseStrict(splitted[0]);
      DateFormat(pattern ?? datePattern).parseStrict(splitted[1]);
      return null;
    } catch (e) {
      return context.t.periodDateWarning;
    }
  }
}
