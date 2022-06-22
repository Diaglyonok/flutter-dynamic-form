import 'package:dglk_flutter_dev_kit/bottom_sheet/src/bottom_sheet_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../flutter_dynamic_form.dart';
import '../../i18n/dynamic_form_localizations.g.dart' as locale;
import '../../logic/dynamic_form_validators.dart';
import 'text_field.dart';

const String DATE_LEAVING = 'date_date_leaving';
const String DATE_RETURNING = 'date_date_returning';

class DateFieldView extends StatelessWidget {
  final Field field;
  final FocusNode? current;
  final FocusNode? next;
  final double? scrollPadding;
  final CupertinoDatePickerMode type;
  final String? customLabel;
  final Function(CompositeValue?)? onChanged;
  final void Function(DateTime) onDateTimeChanged;
  final String? Function(String?)? validators;
  final TextEditingController controller;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateFormat? format;
  final TextStyle? style;
  final PickType pickType;
  final InputDecoration? decoration;

  const DateFieldView({
    Key? key,
    required this.field,
    this.current,
    this.next,
    this.scrollPadding,
    this.type = CupertinoDatePickerMode.date,
    this.customLabel,
    required this.onChanged,
    required this.onDateTimeChanged,
    this.validators,
    required this.controller,
    this.decoration,
    this.startDate,
    this.endDate,
    this.format,
    this.style,
    this.pickType = PickType.SuffixGetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    var minimumDate = startDate ?? DateTime(1700, 1, 1);
    DateTime? maximumDate = endDate;

    switch (field is! DateField
        ? CompareDate.AllDates
        : (field as DateField).compareDate ?? CompareDate.AllDates) {
      case CompareDate.AllDates:
        break;
      case CompareDate.FutureOnly:
        if (startDate == null) {
          break;
        }
        minimumDate = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
        break;
      case CompareDate.PastOnly:
        maximumDate ??= DateTime(now.year, now.month, now.day).add(const Duration(days: -1));
        break;
      case CompareDate.FutureAndTodayOnly:
        if (startDate == null) {
          break;
        }
        minimumDate = DateTime(now.year, now.month, now.day);
        break;
      case CompareDate.PastAndTodayOnly:
        maximumDate ??= DateTime(now.year, now.month, now.day);
        break;
    }

    DateTime _getCurrentDate() {
      DateTime? result;
      try {
        result =
            (format ?? DateFormat(DynamicFormValidators.datePattern)).parseStrict(controller.text);
      } catch (e) {
        if (format != null) {
          return format!.parseStrict(format!.format(DateTime.now()));
        }
        return DateTime.now();
      }
      if (maximumDate != null && (result.isAfter(maximumDate) || result.isBefore(minimumDate))) {
        return maximumDate;
      }
      return result;
    }

    DateTime _getCurrentTime() {
      try {
        return (format ?? DateFormat(DynamicFormValidators.timePattern))
            .parseStrict(controller.text);
      } catch (e) {
        return DateTime.now();
      }
    }

    _onPressed() {
      Navigator.of(context, rootNavigator: true).push(
        BottomSheetRoute(
          child: SizedBox(
            height: 320,
            child: Column(
              children: [
                Material(
                  child: Text(
                    type == CupertinoDatePickerMode.date ||
                            type == CupertinoDatePickerMode.dateAndTime
                        ? locale.dynamicFormTranslation.selectDate
                        : locale.dynamicFormTranslation.selectTime,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
                Expanded(
                  child: type == CupertinoDatePickerMode.date ||
                          type == CupertinoDatePickerMode.dateAndTime
                      ? CupertinoDatePicker(
                          mode: type,
                          minimumDate: minimumDate,
                          maximumDate: maximumDate,
                          initialDateTime: !minimumDate.isAfter(_getCurrentDate())
                              ? maximumDate == null || maximumDate.isAfter(_getCurrentDate())
                                  ? _getCurrentDate()
                                  : maximumDate
                              : minimumDate,
                          onDateTimeChanged: onDateTimeChanged,
                        )
                      : CupertinoDatePicker(
                          mode: type,
                          onDateTimeChanged: onDateTimeChanged,
                          initialDateTime: _getCurrentTime(),
                        ),
                )
              ],
            ),
          ),
        ),
      );
    }

    ///todo: extract as sepate widget with onSave implementation
    return GestureDetector(
      onTap: pickType != PickType.FieldTap ? null : _onPressed,
      child: AbsorbPointer(
        absorbing: pickType == PickType.FieldTap,
        child: DynamicTextField(
          decoration: decoration,
          context: context,
          field: field,
          label: customLabel ?? field.label,
          next: next,
          style: style,
          scrollPadding: scrollPadding,
          hintText: pickType == PickType.FieldTap
              ? null
              : type == CupertinoDatePickerMode.date || type == CupertinoDatePickerMode.dateAndTime
                  ? (format?.pattern ?? DynamicFormValidators.datePattern).toUpperCase()
                  : DynamicFormValidators.timePattern.toUpperCase(),
          current: current,
          required: field.required,
          inputType: TextInputType.datetime,
          controller: controller,
          onChanged: field.readOnly ? null : onChanged,
          validators: field.readOnly ? null : validators,
          maskText: field.maskText,
          suffixIcon: pickType != PickType.SuffixGetter
              ? null
              : IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(
                    type == CupertinoDatePickerMode.date
                        ? Icons.calendar_month
                        : Icons.access_time_rounded,
                    color: Colors.black.withOpacity(0.32),
                  ),
                  onPressed: _onPressed,
                ),
        ),
      ),
    );
  }
}
