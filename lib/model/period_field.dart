import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../flutter_dynamic_form.dart';

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
  final CalendarDatePicker2Config? config;

  PeriodField({
    required super.fieldId,
    required this.extra,
    required super.label,
    this.config,
    this.withDaysNum = false,
    super.minLines,
    super.required = false,
    super.readOnly = false,
    super.customValidator,
    super.maskText,
    super.maxLength,
    super.inputType,
    super.options,
    super.confirmField,
    super.value,
    super.dependsOn,
    super.isCapitalized,
    super.validationExpression,
    super.validationErrorMessage,
    super.onUpdated,
    super.infoCallback,
    super.shouldShowInfo,
    super.multiline,
  }) : super(fieldType: FieldTypes.DatePeriod);
}
