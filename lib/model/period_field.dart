import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../flutter_dynamic_form.dart';

class DatePickerCustomization {
  final String? okButtonText;
  final String? clearButtonText;
  final String? startDateText;
  final String? endDateText;
  final Color? accentColor;
  final Color? transparentAccentColor;
  final Color? onAccentColor;
  final TextStyle? dayStyle;
  final TextStyle? selectedDateTextStyleEmpty;
  final TextStyle? selectedDateTextStyle;
  final TextStyle? monthStyle;
  final TextStyle? yearStyle;
  final TextStyle? okButtonStyle;
  final TextStyle? clearButtonStyle;
  final TextStyle? selectedDateValueStyle;
  final TextStyle? weekDayStyle;
  final double? tileBorderRadius;

  const DatePickerCustomization({
    this.okButtonText,
    this.clearButtonText,
    this.startDateText,
    this.endDateText,
    this.accentColor,
    this.onAccentColor,
    this.transparentAccentColor,
    this.dayStyle,
    this.selectedDateTextStyleEmpty,
    this.selectedDateTextStyle,
    this.monthStyle,
    this.yearStyle,
    this.okButtonStyle,
    this.clearButtonStyle,
    this.selectedDateValueStyle,
    this.weekDayStyle,
    this.tileBorderRadius,
  });
}

class PeriodExtra {
  final DateFormat? format;
  final Duration? allowedDifference;
  final String? daysBottomSheetTitle;
  final DatePickerCustomization customization;

  PeriodExtra({
    this.daysBottomSheetTitle,
    this.format,
    this.allowedDifference,
    this.customization = const DatePickerCustomization(),
  });
}

class PeriodField extends Field {
  final PeriodExtra extra;
  final bool withDaysNum;
  final DateTime? minDate;
  final DateTime? maxDate;

  PeriodField({
    required super.fieldId,
    required this.extra,
    required super.label,
    this.minDate,
    this.maxDate,
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
