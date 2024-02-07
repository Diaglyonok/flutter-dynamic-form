import 'package:dglk_bottom_sheet_route/dglk_bottom_sheet_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/i18n/strings.g.dart';
import 'package:flutter_dynamic_form/widget/field_widgets/bottom_pick_button.dart';
import 'package:flutter_dynamic_form/widget/field_widgets/string_result_field.dart';
import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:paged_vertical_calendar/utils/date_utils.dart';
import 'package:slang/builder/utils/string_extensions.dart';

import '../../flutter_dynamic_form.dart';
import '../../logic/dynamic_form_validators.dart';
import '../../utils/masked_text_controller.dart';

class PeriodFieldView extends StatefulWidget {
  final PeriodField field;
  final FocusNode? current;
  final FocusNode? next;
  final TextEditingController controller;

  final DateTime? startDate;
  final DateTime? endDate;
  final TextStyle? style;
  final InputDecoration? decoration;
  final double? scrollPadding;
  final String? Function(String?)? validators;

  final Function(CompositeValue? value) onChanged;

  const PeriodFieldView({
    Key? key,
    required this.field,
    this.current,
    this.next,
    //required this.endController,
    required this.controller,
    this.startDate,
    this.endDate,
    this.style,
    required this.onChanged,
    this.decoration,
    this.scrollPadding,
    this.validators,
  }) : super(key: key);

  @override
  State<PeriodFieldView> createState() => _PeriodFieldViewState();
}

class _PeriodFieldViewState extends State<PeriodFieldView> {
  late FocusNode middleNode;
  int? daysCount;
  FixedExtentScrollController? scrollController = FixedExtentScrollController();

  late ScreenResultField first;
  //late ScreenResultField second;

  DateTime? start;
  DateTime? end;

  @override
  void initState() {
    final format = widget.field.extra.format;

    if (format != null) {
      final start = format.safeStrictParse(widget.field.value?.value);
      final end = format.safeStrictParse(widget.field.value?.extra);
      int newDaysCount = 0;
      if (start != null && end != null) {
        newDaysCount = end.difference(start).inDays;
        this.start = start;
        this.end = end;
      }
      daysCount = widget.field.withDaysNum && start != null && end != null ? newDaysCount : null;
    }

    middleNode = FocusNode(debugLabel: widget.field.label);
    initResultFields();
    super.initState();
  }

  updateValue(TextEditingController controller, String value) {
    if (controller is MaskedTextController) {
      controller.updateText(value);
      controller.selection = TextSelection.collapsed(offset: value.length);
    } else {
      controller.text = value;
    }
  }

  initResultFields() {
    first = ScreenResultField(
      fieldId: widget.field.fieldId,
      label: widget.field.label,
      extra: ScreenResultExtra(
        getResult: (context) async {
          await _updatePeriod();
          final extra = widget.field.extra;
          final format = extra.format ?? DateFormat(DynamicFormValidators.datePattern);

          final startValue = start == null ? null : format.format(start!);
          final endValue = end == null ? null : format.format(end!);

          return ScreenResultCompositeValue(startValue == null ? '' : '$startValue - ${endValue ?? ''}', jsonData: {
            'start': startValue,
            'end': endValue,
          });
        },
      ),
      //extraPrefix: ,
      required: widget.field.required,
      readOnly: widget.field.readOnly,
      minLines: widget.field.minLines,
      customValidator: widget.field.customValidator,
      maskText: widget.field.maskText,
      maxLength: widget.field.maxLength,
      inputType: widget.field.inputType,
      options: widget.field.options,
      confirmField: widget.field.confirmField,
      value: widget.field.value,
      dependsOn: widget.field.dependsOn,
      isCapitalized: widget.field.isCapitalized,
      validationExpression: widget.field.validationExpression,
      validationErrorMessage: widget.field.validationErrorMessage,
      onUpdated: widget.field.onUpdated,
      infoCallback: widget.field.infoCallback,
      shouldShowInfo: widget.field.shouldShowInfo,
      multiline: widget.field.multiline,
    );
  }

  @override
  Widget build(BuildContext context) {
    final extra = widget.field.extra;

    return Row(
      children: [
        Expanded(
          child: StringResultView(
            decoration: widget.decoration,
            field: first,
            // current: extra.pickType == PickType.FieldTap ? null : widget.current,
            // next: extra.pickType == PickType.FieldTap ? null : middleNode,
            style: widget.style,
            onChanged: (CompositeValue? value) {
              if (value == null) {
                widget.onChanged(null);
                return;
              }

              if (value is! ScreenResultCompositeValue) {
                return;
              }

              widget.onChanged(
                CompositeValue(value.jsonData?['start'] ?? '', extra: value.jsonData?['end'] ?? ''),
              );
            },

            validators: widget.validators,
            controller: widget.controller,
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: daysCount == null || !widget.field.withDaysNum
                ? const SizedBox(
                    width: 0,
                  )
                : BottomPickButton(
                    text: daysCount.toString(),
                    style: widget.style?.copyWith(fontSize: 18),
                    rightArrow: true,
                    customOnTap: () {
                      Navigator.of(context).push(
                        BottomSheetRoute(
                          builder: (context) => SizedBox(
                            height: 260,
                            child: Column(
                              children: [
                                if (extra.daysBottomSheetTitle != null)
                                  Text(
                                    extra.daysBottomSheetTitle!,
                                    style: widget.style,
                                  ),
                                Expanded(
                                  child: CupertinoPicker.builder(
                                      itemExtent: 32,
                                      childCount: widget.field.maxDate != null && start != null
                                          ? start!.difference(widget.field.maxDate!).inDays.abs()
                                          : 364,
                                      scrollController: FixedExtentScrollController(initialItem: daysCount! - 1),
                                      onSelectedItemChanged: (index) {
                                        daysCount = index + 1;
                                        setState(() {});

                                        if (widget.controller.text.isEmpty) {
                                          return;
                                        }

                                        final format = extra.format ?? DateFormat(DynamicFormValidators.datePattern);

                                        //final startDate = format.safeStrictParse(widget.startController.text);

                                        if (start == null) {
                                          return;
                                        }

                                        final endDate = start!.add(Duration(days: daysCount!));

                                        String value;
                                        try {
                                          value = (extra.format ?? DateFormat(DynamicFormValidators.datePattern))
                                              .format(endDate);
                                        } catch (e) {
                                          return;
                                        }

                                        end = endDate;

                                        updateValue(widget.controller, '${format.format(start!)} - $value');

                                        widget.onChanged(CompositeValue(
                                          format.format(start!),
                                          extra: value,
                                        ));
                                      },
                                      itemBuilder: (context, index) {
                                        return Center(
                                            child: Text(
                                          (index + 1).toString(),
                                          style: widget.style?.copyWith(
                                            fontSize: 18,
                                          ),
                                        ));
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(),
                  ),
          ),
        )
      ],
    );
  }

  Future<void> _updatePeriod() async {
    final extra = widget.field.extra;

    void _onChanged(DateTime? start, DateTime? end, {bool clear = false}) {
      if (clear) {
        this.start = null;
        this.end = null;
        updateValue(widget.controller, '');
        //updateValue(widget.startController, '');

        daysCount = null;
        return;
      }

      if (start == null) {
        return;
      }

      final format = extra.format ?? DateFormat(DynamicFormValidators.datePattern);
      String startValue;
      try {
        startValue = format.format(start);
      } catch (e) {
        return;
      }

      String? endValue;
      try {
        endValue = end != null ? format.format(end) : null;
      } catch (e) {
        return;
      }

      this.start = start;
      this.end = end;

      daysCount = end?.difference(start).inDays ?? 0;

      //updateValue(widget.endController, endValue ?? '');
      updateValue(widget.controller, '$startValue - ${endValue ?? ''}');
      setState(() {});

      widget.onChanged(CompositeValue(startValue, extra: endValue));
    }

    if (extra.customPickerFunction != null) {
      await extra.customPickerFunction!(context, onChanged: _onChanged, initStart: start, initEnd: end);
    } else {
      await Navigator.of(context).push(
        BottomSheetRoute(
          titleBoxHeight: 20,
          builder: (context) => CalendarPage(
            minDate: widget.field.minDate,
            maxDate: widget.field.maxDate,
            locale: (extra.format ??
                    DateFormat(
                        DynamicFormValidators.datePattern, TranslationProvider.of(context).flutterLocale.toString()))
                .locale,
            customization: extra.customization,
            onDatesChanged: _onChanged,
            initStart: start, //NOT SAFE
            initEnd: end,
          ),
        ),
      );
    }
  }
}

extension _DateFormatExt on DateFormat {
  DateTime? safeStrictParse(String? inp) {
    try {
      return parseStrict(inp!);
    } catch (e) {
      return null;
    }
  }

  String? safeFormat(DateTime? dateTime) {
    try {
      return format(dateTime!);
    } catch (e) {
      return null;
    }
  }
}

class CalendarPage extends StatefulWidget {
  final DateTime? initStart;
  final DateTime? initEnd;

  final DateTime? minDate;
  final DateTime? maxDate;

  final List<CalendarPeriodsConfig>? closedPeriods;

  final DatePickerCustomization customization;
  final String locale;

  final void Function(DateTime? initStart, DateTime? initEnd, {bool clear})? onDatesChanged;

  const CalendarPage({
    super.key,
    required this.initStart,
    required this.initEnd,
    required this.customization,
    this.closedPeriods,
    this.onDatesChanged,
    required this.locale,
    this.minDate,
    this.maxDate,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

enum _Selectable {
  first,
  second,
}

class _CalendarPageState extends State<CalendarPage> {
  _Selectable? selectedManually;
  DateTime? startDate;
  DateTime? endDate;

  bool get hasChanges {
    return startDate != widget.initStart || endDate != widget.initEnd;
  }

  DatePickerCustomization get custom => widget.customization;

  @override
  void initState() {
    startDate = widget.initStart;
    endDate = widget.initEnd;
    super.initState();
  }

  _getInitialDate() {
    final min = widget.minDate;
    final max = widget.maxDate;
    if (min == null && max == null) {
      return endDate;
    }

    if (endDate != null &&
        (min == null || endDate!.isAtSameMomentAs(min) || endDate!.isAfter(min)) &&
        (max == null || endDate!.isAtSameMomentAs(max) || endDate!.isBefore(max))) {
      return endDate!;
    }

    return calculateMiddleDate(widget.minDate, widget.maxDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final startDateValue = startDate == null ? null : DateFormat.yMMMd(widget.locale).format(startDate!);
    final endDateValue = endDate == null ? null : DateFormat.yMMMd(widget.locale).format(endDate!);

    final clearDisabled = startDate == null && endDate == null;
    return Column(
      children: [
        SizedBox(
          height: 32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 8,
              ),
              MaterialButton(
                onPressed: clearDisabled
                    ? null
                    : () {
                        selectedManually = null;
                        startDate = null;
                        endDate = null;
                        setState(() {});
                      },
                child: Text(
                  custom.clearButtonText ?? context.t.clear,
                  textAlign: TextAlign.left,
                  style: custom.clearButtonStyle ??
                      Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.error.withOpacity(clearDisabled ? 0.4 : 1.0),
                          ),
                ),
              ),
              const Spacer(),
              MaterialButton(
                onPressed: () {
                  final a = startDate != null;
                  final b = endDate != null;

                  if (a == b) {
                    widget.onDatesChanged?.call(startDate, endDate, clear: !a && !b);
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  custom.okButtonText ?? context.t.done,
                  textAlign: TextAlign.right,
                  style: custom.okButtonStyle ??
                      Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 28, right: 28),
          child: SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: _buildDate(
                    onTap: () {
                      selectedManually = _Selectable.first;
                      setState(() {});
                    },
                    name: custom.startDateText ?? context.t.startDate,
                    value: startDateValue,
                    isSelected: selectedManually == _Selectable.first ||
                        selectedManually == null && (startDateValue == null || endDateValue != null),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildDate(
                    onTap: () {
                      selectedManually = _Selectable.second;
                      setState(() {});
                    },
                    name: custom.endDateText ?? context.t.endDate,
                    value: endDateValue,
                    isSelected: selectedManually == _Selectable.second ||
                        selectedManually == null && (startDateValue != null && endDateValue == null),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: PagedVerticalCalendar(
            minDate: widget.minDate?.subtract(const Duration(days: 1)),
            maxDate: widget.maxDate?.add(const Duration(days: 1)),
            initialDate: _getInitialDate(),
            listPadding: const EdgeInsets.all(8.0),
            addAutomaticKeepAlives: true,
            invisibleMonthsThreshold: 3,
            monthBuilder: (context, month, year) {
              return Column(
                key: ValueKey(month.toString() + year.toString()),
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            DateFormat.MMMM(widget.locale).format(DateTime(year, month)).capitalize(),
                            style: custom.monthStyle ?? Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Text(
                          year.toString(),
                          style: custom.yearStyle ??
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// add a row showing the weekdays
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        context.t.weeksShort.length,
                        (index) => weekText(context.t.weeksShort[index]),
                      ),
                    ),
                  ),
                ],
              );
            },
            dayBuilder: (context, date) {
              var textTheme = custom.dayStyle ?? theme.textTheme.bodyLarge;
              final isInRange = startDate != null &&
                  endDate != null &&
                  date.isBefore(endDate!) &&
                  date.isAfter(startDate!) &&
                  !date.isSameDay(endDate!) &&
                  !date.isSameDay(startDate!);
              final isTile =
                  startDate != null && date.isSameDay(startDate!) || endDate != null && date.isSameDay(endDate!);

              final isDisabled = widget.minDate != null && date.isBefore(widget.minDate!) ||
                  widget.maxDate != null && date.isAfter(widget.maxDate!);

              textTheme = textTheme?.copyWith(
                color: isDisabled
                    ? theme.colorScheme.onBackground.withOpacity(0.3)
                    : isTile
                        ? (custom.onAccentColor ?? theme.colorScheme.onSecondary)
                        : null,
              );

              final isToday = date.isSameDay(DateTime.now());

              bool isInPeriodsRange = false;
              bool isPeriodsRangeStart = false;
              bool isPeriodsRangeEnd = false;
              Color? periodColor;

              if (widget.closedPeriods != null) {
                // closed periods:

                for (final config in widget.closedPeriods!) {
                  isInPeriodsRange = date.isBefore(config.endDate) &&
                      date.isAfter(config.startDate) &&
                      !date.isSameDay(config.endDate) &&
                      !date.isSameDay(config.startDate);

                  if (!isPeriodsRangeStart) {
                    isPeriodsRangeStart = date.isSameDay(config.startDate);
                  }

                  if (!isPeriodsRangeEnd) {
                    isPeriodsRangeEnd = date.isSameDay(config.endDate);
                  }

                  if (isInPeriodsRange || isPeriodsRangeStart || isPeriodsRangeEnd) {
                    periodColor = config.color;

                    final style = (custom.closedDaysTextStyle ?? textTheme);

                    if (isPeriodsRangeStart && isPeriodsRangeEnd || isInPeriodsRange) {
                      textTheme = style?.copyWith(
                        color: style.color?.withOpacity(0.45),
                      );
                    }

                    if (isPeriodsRangeStart && !isPeriodsRangeEnd || isPeriodsRangeEnd && !isPeriodsRangeStart) {
                      continue;
                    }

                    break;
                  }
                }
              }

              _dayColor() {
                if (isInRange) {
                  return custom.transparentAccentColor ?? theme.colorScheme.secondary.withOpacity(0.1);
                }

                if (isTile) {
                  return custom.accentColor ?? theme.colorScheme.secondary;
                }

                if (periodColor != null) {
                  return custom.busyDayColor ?? theme.colorScheme.onBackground.withOpacity(0.04);
                }

                return null;
              }

              return Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: isToday
                          ? Border.all(
                              color: custom.accentColor ?? Theme.of(context).colorScheme.secondary,
                            )
                          : null,
                      borderRadius: isTile || isToday
                          ? BorderRadius.circular(custom.tileBorderRadius ?? 8)
                          : isPeriodsRangeStart
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(custom.tileBorderRadius ?? 8),
                                  bottomLeft: Radius.circular(custom.tileBorderRadius ?? 8),
                                )
                              : isPeriodsRangeEnd
                                  ? BorderRadius.only(
                                      topRight: Radius.circular(custom.tileBorderRadius ?? 8),
                                      bottomRight: Radius.circular(custom.tileBorderRadius ?? 8),
                                    )
                                  : null,
                      color: _dayColor(),
                    ),
                    child: Center(child: Text(date.day.toString(), style: textTheme)),
                  ),
                  if (periodColor != null)
                    custom.busyPeriodIconBuilder?.call(periodColor, isPeriodsRangeStart, isPeriodsRangeEnd) ??
                        Positioned(
                          right: 8,
                          top: 8,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: periodColor,
                          ),
                        ),
                ],
              );
            },
            onDayPressed: (date) {
              final isDisabled = widget.minDate != null && date.isBefore(widget.minDate!) ||
                  widget.maxDate != null && date.isAfter(widget.maxDate!);

              if (isDisabled) {
                return;
              }

              if (widget.closedPeriods != null) {
                // closed periods:

                bool isPeriodsRangeStart = false;
                bool isPeriodsRangeEnd = false;

                for (final config in widget.closedPeriods!) {
                  final isInPeriodsRange = date.isBefore(config.endDate) &&
                      date.isAfter(config.startDate) &&
                      !date.isSameDay(config.endDate) &&
                      !date.isSameDay(config.startDate);

                  if (isInPeriodsRange) {
                    return;
                  }

                  if (!isPeriodsRangeStart) {
                    isPeriodsRangeStart = date.isSameDay(config.startDate);
                  }

                  if (!isPeriodsRangeEnd) {
                    isPeriodsRangeEnd = date.isSameDay(config.endDate);
                  }

                  if (isInPeriodsRange || isPeriodsRangeStart || isPeriodsRangeEnd) {
                    if (isPeriodsRangeStart && isPeriodsRangeEnd || isInPeriodsRange) {
                      return;
                    }

                    if (isPeriodsRangeStart && !isPeriodsRangeEnd || isPeriodsRangeEnd && !isPeriodsRangeStart) {
                      continue;
                    }
                  }
                }
              }

              if (selectedManually == _Selectable.second &&
                  startDate != null &&
                  (date.isAfter(endDate!) || date.isSameDay(endDate!))) {
                endDate = date;
              } else if (endDate == null && startDate != null && date.isBefore(startDate!)) {
                endDate = startDate;
                startDate = date;
              } else if (startDate == null ||
                  date.isBefore(startDate!) ||
                  startDate != null && endDate != null ||
                  startDate != null && date.isSameDay(startDate!)) {
                startDate = date;
                endDate = null;
              } else {
                // if (endDate == null)
                endDate ??= date;
              }

              selectedManually = null;

              setState(() {});
              return;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDate({
    required String name,
    VoidCallback? onTap,
    bool isSelected = false,
    String? value,
  }) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: isSelected
                        ? (custom.accentColor ?? Theme.of(context).colorScheme.secondary)
                        : Colors.transparent,
                    width: 2))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: value != null
                  ? (custom.selectedDateTextStyle ?? Theme.of(context).textTheme.bodyLarge)
                  : (custom.selectedDateTextStyleEmpty ?? Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 2),
            if (value != null)
              Text(value, style: custom.selectedDateValueStyle ?? Theme.of(context).textTheme.titleMedium),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }

  Widget weekText(String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        style: custom.weekDayStyle ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.5),
                ),
      ),
    );
  }
}

extension IterableExtension<T> on Iterable<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

DateTime? calculateMiddleDate(DateTime? date1, DateTime? date2) {
  if (date1 == null && date2 == null) {
    return null; //today displayed
  }
  if (date1 == null) {
    final now = DateTime.now();
    if (now.isBefore(date2!)) {
      return null; //today displayed
    } else {
      return date2;
    }
  }

  if (date2 == null) {
    final now = DateTime.now();
    if (now.isAfter(date1)) {
      return null; //today displayed
    } else {
      return date1;
    }
  }

  Duration difference = date2.difference(date1);
  Duration middleDuration = difference ~/ 2; // ~/ - оператор целочисленного деления
  DateTime middleDate = date1.add(middleDuration).removeTime();

  return middleDate;
}
