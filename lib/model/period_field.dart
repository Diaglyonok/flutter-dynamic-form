import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../model/dynamic_form_models.dart';
import 'date_constants.dart';

class PeriodExtra {
  final String? secondLabel;
  final CupertinoDatePickerMode? type;
  final DateFormat? format;
  final PickType? pickType;
  final Duration? allowedDifference;
  final String? daysBottomSheetTitle;

  PeriodExtra({
    this.daysBottomSheetTitle,
    this.pickType,
    this.secondLabel,
    this.type,
    this.format,
    this.allowedDifference,
  });
}

class PeriodField extends Field {
  final PeriodExtra extra;
  final bool withDaysNum;

  PeriodField({
    required String fieldId,
    bool required = false,
    bool readOnly = false,
    required String label,
    this.withDaysNum = false,
    bool? maskText,
    int? maxLength,
    String? inputType,
    List<Option>? options,
    String? confirmField,
    CompositeValue? value,
    List<DependsOnValue>? dependsOn,
    bool? isCapitalized,
    String? validationExpression,
    String? validationErrorMessage,
    required this.extra,
    Function(CompositeValue?)? onUpdated,
  }) : super(
          fieldId: fieldId,
          required: required,
          readOnly: readOnly,
          label: label,
          maskText: maskText,
          maxLength: maxLength,
          inputType: inputType,
          options: options,
          isCapitalized: isCapitalized,
          fieldType: FieldTypes.DatePeriod,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: value,
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
          onUpdated: onUpdated,
        );
}
