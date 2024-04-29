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
  final Color? busyDayColor;
  final TextStyle? dayStyle;
  final TextStyle? selectedDateTextStyleEmpty;
  final TextStyle? selectedDateTextStyle;
  final TextStyle? monthStyle;
  final TextStyle? yearStyle;
  final TextStyle? okButtonStyle;
  final TextStyle? clearButtonStyle;
  final TextStyle? selectedDateValueStyle;
  final TextStyle? weekDayStyle;
  final TextStyle? closedDaysTextStyle;
  final double? tileBorderRadius;
  final Widget Function(Color color, bool isStart, bool isEnd)? busyPeriodIconBuilder;
  final bool Function(DateTime? start, DateTime? end)? actionButtonAvailable;

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
    this.busyDayColor,
    this.closedDaysTextStyle,
    this.busyPeriodIconBuilder,
    this.actionButtonAvailable,
  });
}

class PeriodExtra {
  final DateFormat? format;
  final Duration? allowedDifference;
  final String? daysBottomSheetTitle;
  final DatePickerCustomization customization;
  final Future<void> Function(
    BuildContext context, {
    required void Function(DateTime? start, DateTime? end, {bool clear}) onChanged,
    required DateTime? initStart,
    required DateTime? initEnd,
  })? customPickerFunction;

  PeriodExtra({
    this.customPickerFunction,
    this.daysBottomSheetTitle,
    this.format,
    this.allowedDifference,
    this.customization = const DatePickerCustomization(),
  });
}

class CalendarPeriodsConfig {
  final Color color;
  final DateTime startDate;
  final DateTime endDate;

  CalendarPeriodsConfig({required this.color, required this.startDate, required this.endDate});
}

class PeriodField extends Field {
  final PeriodExtra extra;
  final bool withDaysNum;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool useUtc;

  PeriodField({
    required super.fieldId,
    required this.extra,
    required super.label,
    this.minDate,
    this.maxDate,
    this.withDaysNum = false,
    this.useUtc = false,
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
    super.withBottomPadding = true,
  }) : super(fieldType: FieldTypes.DatePeriod);
}
