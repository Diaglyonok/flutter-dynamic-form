// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

enum DFormLocalizationsId {
  field_is_required_error_text,
  email_is_empty_error_text,
  email_is_not_valid_error_text,
  date_is_not_valid_error_text,
  answer_is_not_valid_error_text,
  password_too_short_error_text,
  password_too_long_error_text,
  password_error_text,
  passwords_are_not_equal_error_text,
  userid_too_short_error_text,
  userid_too_long_error_text,
  submit_button_caption,
  reset_via_email_button_caption,
  email_sent,
  email_sent_hint,
  back_to_sign_in,
  update_button_caption,
  add_button_caption,
  add_attachment,
  close,
  you_re_ready_to_go,
  field_does_not_match,
  strict_zipcode_error,
  invalid_zipcode,
  amount_is_zero,
  attachment_added,
  invalid_phone_number,
  at_least_8_chars,
  one_spec_char,
  one_number,
  one_lowercase_letter,
  one_uppercase_letter,
  main_password_hint,
  wrong_format_text,
  weak,
  strong,
  return_date_warning,
  select_date,
  select_time,
  invalid_time,
}

class DFormLocalizations {
  DFormLocalizations(this.locale);
  final Locale locale;

  static DFormLocalizations of(BuildContext context) {
    return Localizations.of(context, DFormLocalizations);
  }

  static final Map<String, Map<DFormLocalizationsId, String>> _localizedValues = {
    'en': {
      DFormLocalizationsId.submit_button_caption: 'Submit',
      DFormLocalizationsId.reset_via_email_button_caption: 'Reset via Email',
      DFormLocalizationsId.email_sent: 'Email sent!',
      DFormLocalizationsId.email_sent_hint:
          'Instructions have been sent to the email associated with your username.',
      DFormLocalizationsId.back_to_sign_in: 'Back to Sign In',
      DFormLocalizationsId.update_button_caption: 'Update',
      DFormLocalizationsId.password_error_text:
          'Your password must be between %MIN% and %MAX% characters and contain at least one number and one letter',
      DFormLocalizationsId.password_too_short_error_text:
          'Your password must be between %MIN% and %MAX% characters and contain at least one number and one letter',
      DFormLocalizationsId.password_too_long_error_text:
          'Your password must be between %MIN% and %MAX% characters and contain at least one number and one letter',
      DFormLocalizationsId.userid_too_short_error_text:
          'Login length should be greater than %MIN% characters',
      DFormLocalizationsId.userid_too_long_error_text:
          'Login length should be shorter than %MAX% characters',
      DFormLocalizationsId.invalid_phone_number: 'Phone number is not valid',
      DFormLocalizationsId.invalid_time: 'Time is not valid',
      DFormLocalizationsId.email_is_empty_error_text: 'Enter email address',
      DFormLocalizationsId.email_is_not_valid_error_text: 'Email is not valid',
      DFormLocalizationsId.date_is_not_valid_error_text: 'Please enter a valid date (mm/dd/yyyy)',
      DFormLocalizationsId.answer_is_not_valid_error_text:
          'Answers must contain at least 3 characters',
      DFormLocalizationsId.field_is_required_error_text: 'This field is required',
      DFormLocalizationsId.wrong_format_text: 'Something wrong with the format',
      DFormLocalizationsId.passwords_are_not_equal_error_text: 'Passwords do not match',
      DFormLocalizationsId.close: 'Close',
      DFormLocalizationsId.you_re_ready_to_go:
          'You’re ready to go! Please login using the credentials you just setup.',
      DFormLocalizationsId.add_button_caption: 'Add',
      DFormLocalizationsId.add_attachment: 'Add attachment',
      DFormLocalizationsId.field_does_not_match: 'The value entered does not match',
      DFormLocalizationsId.strict_zipcode_error: 'Zip code requires the 4-digit extension',
      DFormLocalizationsId.invalid_zipcode: 'Zip code: invalid format',
      DFormLocalizationsId.amount_is_zero: 'Amount must be greater than \$0.00',
      DFormLocalizationsId.attachment_added: 'ATTACHMENT ADDED',
      DFormLocalizationsId.at_least_8_chars: 'At least 8 characters',
      DFormLocalizationsId.one_spec_char: 'One special character ',
      DFormLocalizationsId.one_number: 'One number',
      DFormLocalizationsId.one_lowercase_letter: 'One lowercase letter',
      DFormLocalizationsId.one_uppercase_letter: 'One uppercase letter',
      DFormLocalizationsId.main_password_hint:
          'Password must be between 8 and 32 characters long. They must contain four of the five criteria:',
      DFormLocalizationsId.return_date_warning: "Can't be earlier than departure date",
      DFormLocalizationsId.weak: 'WEAK',
      DFormLocalizationsId.strong: 'STRONG',
      DFormLocalizationsId.select_date: 'Select date',
      DFormLocalizationsId.select_time: 'Select time',
    },
  };

  String? localized(DFormLocalizationsId id) {
    final locString = (_localizedValues[locale.languageCode] ?? _localizedValues['en']!)[id];
    return locString;
  }

  String? localizedWithParam(DFormLocalizationsId id, Map<String, String> params) {
    var result = localized(id);
    params.forEach((key, value) => result = result?.replaceAll('%$key%', value));
    return result;
  }
}

class DFormLocalizationsDelegate extends LocalizationsDelegate<DFormLocalizations> {
  const DFormLocalizationsDelegate(this.supportedLocales);
  final List<Locale> supportedLocales;

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<DFormLocalizations> load(Locale locale) {
    return SynchronousFuture<DFormLocalizations>(DFormLocalizations(locale));
  }

  @override
  bool shouldReload(DFormLocalizationsDelegate old) => false;
}
