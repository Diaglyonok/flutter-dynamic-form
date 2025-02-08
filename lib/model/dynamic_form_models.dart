// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DynamicFormsConstants {
  static String defaultSpecSymbols = '~!@#\$%^&*()';
  static String loginUserInputRegex = '[\\[\\]0-9a-zA-Z`"\'/!?@^_#%&\$*+-.,:;(){}|<>=~]';
  static String passwordRegexpWithSpecialSymbols = '^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z!~@#\$%^&*()]{8,32}';

  static ValidationOptions defaultPasswordVO =
      ValidationOptions(minLength: 8, maxLength: 32, regexp: r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');
  static ValidationOptions defaultPhoneVO = ValidationOptions(maxLength: 10, minLength: 10);
}

class ValidationOptions {
  int minLength;
  int maxLength;
  String? regexp;
  ValidationOptions({required this.maxLength, required this.minLength, this.regexp});
}

enum CompareDate {
  AllDates,
  FutureOnly,
  PastOnly,
  FutureAndTodayOnly,
  PastAndTodayOnly,
}

const Map<String, CompareDate> COMPARE_DATE_EQUALITY_MAP = {
  'AllDates': CompareDate.AllDates,
  'FutureOnly': CompareDate.FutureOnly,
  'PastOnly': CompareDate.PastOnly,
  'FutureAndTodayOnly': CompareDate.FutureAndTodayOnly,
  'PastAndTodayOnly': CompareDate.PastAndTodayOnly,
};

enum FieldTypes {
  RadioOptions,
  Label,
  Text,
  PlainText,
  Phone,
  Password,
  Name,
  CheckBox,
  Email,
  Date,
  Time,
  Number,
  DatePeriod,
  ScreenResult,
  Color,
  RowField,
  Counter,
  Link,
  LinksList,
}

class Field {
  final String fieldId;
  final bool required;
  final bool readOnly;
  final int? minLines;
  final void Function()? onEdittingComplete;

  final FieldTypes fieldType;
  final String label;

  final bool? maskText;
  final int? maxLength;
  final String? inputType; // can be 'Text', 'Number' or 'Date'
  final List<Option>? options;
  final String? confirmField;

  final List<TextInputFormatter>? Function(BuildContext context)? getFormatters;
  final Widget Function(BuildContext context)? suffixIconBuilder;
  final CompositeValue? value;
  final List<DependsOn>? dependsOn;
  final TextCapitalization? capitalizeType;
  final bool multiline;
  final String? validationExpression;
  final String? validationErrorMessage;
  final String? Function(String? value)? customValidator;
  final TextStyle? customTextStyle;

  final Function(CompositeValue?)? onUpdated;
  final Function()? infoCallback;
  final bool Function(CompositeValue?)? shouldShowInfo;
  final Widget Function({required BuildContext context, required Widget child})? wrapper;

  final bool withBottomPadding;

  Field({
    required this.fieldId,
    required this.fieldType,
    required this.label,
    this.customTextStyle,
    this.getFormatters,
    this.minLines,
    this.infoCallback,
    this.shouldShowInfo,
    this.onUpdated,
    this.required = false,
    this.readOnly = false,
    this.multiline = false,
    this.wrapper,
    this.suffixIconBuilder,
    this.customValidator,
    this.maskText,
    this.maxLength,
    this.inputType,
    this.options,
    this.capitalizeType,
    this.confirmField,
    this.dependsOn,
    this.value,
    this.validationExpression,
    this.validationErrorMessage,
    this.withBottomPadding = true,
    this.onEdittingComplete,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Field && fieldId == other.fieldId && value?.value == other.value?.value;

  Field withValue(CompositeValue value) {
    return Field(
      customTextStyle: customTextStyle,
      fieldId: fieldId,
      required: required,
      readOnly: readOnly,
      minLines: minLines,
      label: label,
      suffixIconBuilder: suffixIconBuilder,
      maskText: maskText,
      infoCallback: infoCallback,
      shouldShowInfo: shouldShowInfo,
      maxLength: maxLength,
      inputType: inputType,
      confirmField: confirmField,
      capitalizeType: capitalizeType,
      fieldType: fieldType,
      options: options,
      dependsOn: dependsOn,
      validationExpression: validationExpression,
      validationErrorMessage: validationErrorMessage,
      value: value,
      getFormatters: getFormatters,
      wrapper: wrapper,
      multiline: multiline,
    );
  }

  Field copyWith({int? parentId, List<Field>? children, String? newLabel}) {
    return Field(
      customTextStyle: customTextStyle,
      fieldId: fieldId,
      required: required,
      infoCallback: infoCallback,
      readOnly: readOnly,
      label: newLabel ?? label,
      maskText: maskText,
      suffixIconBuilder: suffixIconBuilder,
      shouldShowInfo: shouldShowInfo,
      maxLength: maxLength,
      inputType: inputType,
      confirmField: confirmField,
      fieldType: fieldType,
      capitalizeType: capitalizeType,
      options: options,
      dependsOn: dependsOn,
      value: value,
      validationExpression: validationExpression,
      validationErrorMessage: validationErrorMessage,
      multiline: multiline,
      getFormatters: getFormatters,
    );
  }
}

class Option {
  final String? id;
  final String? value;
  Option({this.id, this.value});
}

class CompositeValue {
  String? extra;
  String value;
  bool autoUpdated;
  CompositeValue(this.value, {this.extra, this.autoUpdated = false});

  @override
  String toString() {
    return '$value:$extra';
  }

  CompositeValue copyWith({
    String? value,
    String? extra,
    bool? autoUpdated,
  }) {
    return CompositeValue(
      value ?? this.value,
      extra: extra ?? this.extra,
      autoUpdated: autoUpdated ?? false,
    );
  }
}

abstract class DependsOn {
  final String? fieldId;

  DependsOn({
    this.fieldId,
  });

  bool Function(String value, String? extra) get condition;
}

class DependsOnValue extends DependsOn {
  final String? conditionValue;
  final String? conditionExtra;

  DependsOnValue({
    super.fieldId,
    this.conditionValue,
    this.conditionExtra,
  });

  @override
  bool Function(String value, String? extra) get condition => (String value, String? extra) {
        return value == conditionValue || extra == conditionExtra && conditionExtra != null;
      };
}

class DependsOnNonEmpty extends DependsOn {
  DependsOnNonEmpty({
    super.fieldId,
  });

  @override
  bool Function(String value, String? extra) get condition => (String value, String? extra) {
        return (value.isNotEmpty);
      };
}

class KeyValue {
  final String? id;
  final CompositeValue? value;

  KeyValue({this.id, this.value});

  @override
  String toString() {
    return '$id:${value?.value} [${value?.extra}]';
  }
}

class ValidationError {
  String? field;
  String? error;

  ValidationError({this.field, this.error});
}

// class ValidationErrorsList {
//   List<ValidationError>? errorsList;
// }

// extension FieldsFiller on List<Field> {
//   List<Field> fill(Map<String, CompositeValue> values) {
//     for (var i = 0; i < length; i++) {
//       this[i] = this[i]?.withValue(
//         values[this[i]?.fieldId ?? ''],
//       );
//     }
//     return this;
//   }

//   Map<String, CompositeValue> getValues() {
//     final values = <String, CompositeValue>{};
//     this?.forEach((element) {
//       values[element?.fieldId] = element?.value;
//     });
//     return values;
//   }

//   void clearValues() {
//     for (var i = 0; i < length; i++) {
//       this[i] = this[i].withValue(null, acceptNull: true);
//     }
//   }
// }
