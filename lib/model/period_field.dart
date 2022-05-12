import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../model/dynamic_form_models.dart';
import '../widget/field_widgets/date.dart';

class PeriodExtra {
  final String? secondLabel;
  final CupertinoDatePickerMode? type;
  final DateFormat? format;
  final PickType? pickType;
  final Duration? allowedDifference;

  PeriodExtra({this.pickType, this.secondLabel, this.type, this.format, this.allowedDifference});
}

class PeriodField extends Field {
  final PeriodExtra extra;

  PeriodField({
    required String fieldId,
    bool required = false,
    bool readOnly = false,
    required String label,
    String? labelId,
    bool? maskText,
    int? maxLength,
    String? inputType,
    List<Option>? options,
    String? confirmField,
    bool? strict,
    String? fieldName,
    int? versionId,
    CompositeValue? value,
    List<DependsOnValue>? dependsOn,
    List<Field>? children,
    bool? isCapitalized,
    String? validationExpression,
    String? validationErrorMessage,
    CompareDate? compareDate,
    int? parentId,
    required this.extra,
  }) : super(
          fieldName: fieldName,
          versionId: versionId,
          fieldId: fieldId,
          required: required,
          readOnly: readOnly,
          label: label,
          labelId: labelId,
          maskText: maskText,
          maxLength: maxLength,
          inputType: inputType,
          options: options,
          isCapitalized: isCapitalized,
          fieldType: FieldTypes.DatePeriod,
          strict: strict,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: value,
          parentId: parentId,
          children: children,
          compareDate: compareDate,
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
        );
}
