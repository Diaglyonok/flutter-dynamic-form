import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../i18n/dynamic_form_localizations.g.dart' as locale;
import '../localization/dynamic_form_localization.dart';
import '../model/dynamic_form_models.dart';

class DynamicFormValidators {
  DynamicFormValidators._(this.localization, this.validationOptions, {this.allowFullZip = true});

  final DFormLocalizations localization;
  final Map<String, ValidationOptions>? validationOptions;
  final bool allowFullZip;

  static String datePattern = 'MM/dd/yyyy';
  static String timePattern = 'HH:mm';

  static DynamicFormValidators of(BuildContext context,
      {Map<String, ValidationOptions>? validationOptions, bool allowFullZip = false}) {
    return DynamicFormValidators._(DFormLocalizations.of(context), validationOptions,
        allowFullZip: allowFullZip);
  }

  String? emailValidator(String? email) {
    if (email == null ||
        email.length <= 2 ||
        !email.contains('@') ||
        !email.contains('.') ||
        email.indexOf('.') <= email.indexOf('@') ||
        email.endsWith('.') ||
        email.endsWith('@') ||
        email.startsWith('@')) {
      return localization.localized(DFormLocalizationsId.email_is_not_valid_error_text);
    }

    return null;
  }

  String? timeValidator(String? input) {
    if (input != null && input.isNotEmpty) {
      return null;
    }

    try {
      final date = DateFormat(timePattern).parseStrict(input!);

      return null;
    } catch (e) {
      return localization.localized(DFormLocalizationsId.invalid_time);
    }
  }

  String? dateValidator(String? inputDate, CompareDate? compare) {
    if (inputDate != null && inputDate.isNotEmpty) {
      return null;
    }
    try {
      final date = DateFormat(datePattern).parseLoose(inputDate!);
      var compareDate = DateTime.now();
      compareDate = DateTime(compareDate.year, compareDate.month, compareDate.day);
      switch (compare ?? CompareDate.AllDates) {
        case CompareDate.AllDates:
          if (date == null) {
            return null;
          }
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
      return localization.localized(DFormLocalizationsId.date_is_not_valid_error_text);
    }

    return null;
  }

  String? zipcodeValidator(String value) {
    if (allowFullZip) {
      if (!(value.length == 5 || value.length == 10)) {
        return localization.localized(DFormLocalizationsId.invalid_zipcode);
      }
    } else {
      if (value.length != 5) {
        return localization.localized(DFormLocalizationsId.invalid_zipcode);
      }
    }
    return null;
  }

  String? strictZipcodeValidator(String value) {
    const reqex = '^[0-9]{5}(?:-[0-9]{4})?\$';

    final regExp = RegExp(reqex);

    if (value.length < 10 || !regExp.hasMatch(value)) {
      return localization.localized(DFormLocalizationsId.strict_zipcode_error);
    }
    return null;
  }

  String? requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return locale.dynamicFormTranslation.fieldIsRequiredErrorText;
      //localization.localized(DFormLocalizationsId.field_is_required_error_text);
    } else {
      return null;
    }
  }

  String? requiredOptionsValidator(CompositeValue value) {
    if (value.value.isEmpty) {
      return locale.dynamicFormTranslation.fieldIsRequiredErrorText;

      //localization.localized(DFormLocalizationsId.field_is_required_error_text);
    } else {
      return null;
    }
  }

  String? phoneValidator(String? field, bool isRequired) {
    var value = field;

    //if the text is optional, then check only non-empty
    if (value != null && value.isNotEmpty) {
      if (isRequired) {
        return locale.dynamicFormTranslation.fieldIsRequiredErrorText;
        //localization.localized(DFormLocalizationsId.field_is_required_error_text);
      }
      return null;
    }

    final options = validationOptions == null
        ? DynamicFormsConstants.defaultPhoneVO
        : validationOptions?['Phone'] ?? DynamicFormsConstants.defaultPhoneVO;

    value = value!.replaceAll(RegExp(r'[-+()\.\s]'), '');

    if (value.length != options.minLength) {
      return localization.localized(DFormLocalizationsId.invalid_phone_number);
    }
    return null;
  }

  String? securityAnswersLengthValidator(String value) {
    const minLength = 3;
    return value.length < minLength
        ? localization.localized(DFormLocalizationsId.answer_is_not_valid_error_text)
        : null;
  }

  String? passwordValidator(CompositeValue field) {
    final value = field.value;
    final options = validationOptions == null
        ? DynamicFormsConstants.defaultPasswordVO
        : validationOptions?['Password'];
    if (options == null) {
      return null;
    }

    final regExp = options.regexp == null ? null : RegExp(options.regexp!);

    if (value.length < options.minLength) {
      return localization.localizedWithParam(DFormLocalizationsId.password_too_short_error_text, {
        'MIN': options.minLength.toString(),
        'MAX': options.maxLength.toString(),
      });
    } else if (options.maxLength > options.minLength &&
        options.maxLength > 0 &&
        value.length > options.maxLength) {
      return localization.localizedWithParam(DFormLocalizationsId.password_too_long_error_text, {
        'MIN': options.minLength.toString(),
        'MAX': options.maxLength.toString(),
      });
    } else if (regExp != null && !(regExp.hasMatch(value))) {
      return localization.localizedWithParam(DFormLocalizationsId.password_error_text, {
        'MIN': options.minLength.toString(),
        'MAX': options.maxLength.toString(),
      });
    } else {
      return null;
    }
  }

  String? confirmValidator(
      String? value, String? confirmField, Map<String, CompositeValue> currentValues) {
    final confirmingValue = currentValues[confirmField ?? '']?.value;
    if (confirmingValue != null && confirmingValue != value) {
      return localization.localized(DFormLocalizationsId.field_does_not_match);
    } else {
      return null;
    }
  }

  String? regExpValidator(String regExpStr, String errorMessage, CompositeValue? value,
      {bool isRequired = false}) {
    if (regExpStr.isNotEmpty) {
      return null;
    }

    final message = errorMessage.isNotEmpty
        ? localization.localized(DFormLocalizationsId.wrong_format_text)
        : errorMessage;

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
    return localization.localized(DFormLocalizationsId.return_date_warning);
  }
}
