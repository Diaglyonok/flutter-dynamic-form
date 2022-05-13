// ignore_for_file: constant_identifier_names

const Map<String, FieldTypes> INPUT_TO_TYPE_MAP = {
  'date': FieldTypes.Date,
  'text': FieldTypes.Text,
  'number': FieldTypes.Number,
};

class DynamicFormsConstants {
  static String defaultSpecSymbols = '~!@#\$%^&*()';
  static String loginUserInputRegex = '[\\[\\]0-9a-zA-Z`"\'/!?@^_#%&\$*+-.,:;(){}|<>=~]';
  static String passwordRegexpWithSpecialSymbols =
      '^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z!~@#\$%^&*()]{8,32}';

  static ValidationOptions defaultPasswordVO = ValidationOptions(
      minLength: 8, maxLength: 32, regexp: '^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{8,32}');
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
}

class Field {
  final String fieldId;
  final bool required;
  final bool readOnly;
  final FieldTypes? _fieldType;
  final String label;
  final String? labelId;
  final bool? maskText;
  final int? maxLength;
  final String? inputType; // can be 'Text', 'Number' or 'Date'
  final List<Option>? options;
  final String? confirmField;
  final bool? strict;
  final String? fieldName;
  final int? versionId;
  final CompositeValue? value;
  final List<DependsOnValue>? dependsOn;
  final List<Field>? children;
  final bool? isCapitalized;
  final String? validationExpression;
  final String? validationErrorMessage;
  final CompareDate? compareDate;
  final int? parentId;

  Field({
    this.fieldName,
    this.versionId,
    required this.fieldId,
    this.required = false,
    this.readOnly = false,
    required this.label,
    this.labelId,
    this.maskText,
    this.maxLength,
    this.inputType,
    this.options,
    this.isCapitalized,
    FieldTypes? fieldType,
    this.strict,
    this.confirmField,
    this.dependsOn,
    this.value,
    this.parentId,
    this.children,
    this.compareDate,
    this.validationExpression,
    this.validationErrorMessage,
  }) : _fieldType = fieldType;

  FieldTypes get fieldType => _fieldType ?? INPUT_TO_TYPE_MAP[inputType?.toLowerCase() ?? '']!;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Field && fieldId == other.fieldId && value?.value == other.value?.value;

  Field withValue(CompositeValue value, {bool acceptNull = false}) {
    if (!acceptNull) {
      if (value.value == null) {
        return this;
      }
    }

    return Field(
      fieldId: fieldId,
      required: required,
      readOnly: readOnly,
      label: label,
      labelId: labelId,
      maskText: maskText,
      maxLength: maxLength,
      inputType: inputType,
      confirmField: confirmField,
      strict: strict,
      fieldName: fieldName,
      isCapitalized: isCapitalized,
      fieldType: fieldType,
      versionId: versionId,
      options: options,
      compareDate: compareDate,
      dependsOn: dependsOn,
      parentId: parentId,
      children: children,
      validationExpression: validationExpression,
      validationErrorMessage: validationErrorMessage,
      value: value,
    );
  }

  Field copyWith({int? parentId, List<Field>? children, String? newLabel}) {
    return Field(
      fieldId: fieldId,
      required: required,
      readOnly: readOnly,
      label: newLabel ?? label,
      labelId: labelId,
      maskText: maskText,
      maxLength: maxLength,
      inputType: inputType,
      confirmField: confirmField,
      strict: strict,
      fieldName: fieldName,
      fieldType: fieldType,
      compareDate: compareDate,
      isCapitalized: isCapitalized,
      versionId: versionId,
      options: options,
      dependsOn: dependsOn,
      value: value,
      validationExpression: validationExpression,
      validationErrorMessage: validationErrorMessage,
      parentId: parentId ?? parentId,
      children: children ?? children,
    );
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
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

class DependsOnValue {
  final String? fieldId;
  final String? conditionValue;

  DependsOnValue({this.fieldId, this.conditionValue});

  factory DependsOnValue.fromJson(Map<String, dynamic> json) {
    return DependsOnValue(fieldId: json['fieldId'], conditionValue: json['value']);
  }
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
