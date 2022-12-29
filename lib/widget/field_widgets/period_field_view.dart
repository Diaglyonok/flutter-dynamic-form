import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dglk_flutter_dev_kit/bottom_sheet/src/bottom_sheet_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/widget/field_widgets/bottom_pick_button.dart';
import 'package:flutter_dynamic_form/widget/field_widgets/string_result_field.dart';
import 'package:intl/intl.dart';

import '../../flutter_dynamic_form.dart';
import '../../i18n/dynamic_form_localizations.g.dart' as locale;
import '../../logic/dynamic_form_validators.dart';
import '../../utils/masked_text_controller.dart';

class PeriodFieldView extends StatefulWidget {
  final PeriodField field;
  final FocusNode? current;
  final FocusNode? next;
  final TextEditingController endController;
  final TextEditingController startController;

  final DateTime? startDate;
  final DateTime? endDate;
  final TextStyle? style;
  final InputDecoration? decoration;
  final double? scrollPadding;
  final String? Function(String?)? startValidators;
  final String? Function(String?)? endValidators;

  final Function(CompositeValue? value) onChanged;

  const PeriodFieldView({
    Key? key,
    required this.field,
    this.current,
    this.next,
    required this.endController,
    required this.startController,
    this.startDate,
    this.endDate,
    this.style,
    required this.onChanged,
    this.decoration,
    this.scrollPadding,
    this.startValidators,
    this.endValidators,
  }) : super(key: key);

  @override
  State<PeriodFieldView> createState() => _PeriodFieldViewState();
}

class _PeriodFieldViewState extends State<PeriodFieldView> {
  late FocusNode middleNode;
  int? daysCount;
  FixedExtentScrollController? scrollController = FixedExtentScrollController();

  late ScreenResultField first;
  late ScreenResultField second;

  @override
  void initState() {
    final format = widget.field.extra.format;

    if (format != null) {
      final start = format.safeStrictParse(widget.field.value?.value);
      final end = format.safeStrictParse(widget.field.value?.extra);
      int newDaysCount = 0;
      if (start != null && end != null) {
        newDaysCount = end.difference(start).inDays;
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
      fieldId: widget.field.fieldId + '_start',
      label: widget.field.label,
      extra: ScreenResultExtra(
        getResult: (context) async {
          await _updatePeriod();
          return ScreenResultCompositeValue(widget.startController.text);
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

    second = ScreenResultField(
      fieldId: widget.field.fieldId + '_end',
      label: widget.field.extra.secondLabel ?? widget.field.label,
      extra: ScreenResultExtra(
        getResult: (context) async {
          await _updatePeriod();
          return ScreenResultCompositeValue(widget.endController.text);
        },
      ),
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

              widget.onChanged(
                CompositeValue(widget.startController.text, extra: widget.endController.text),
              );
            },

            validators: widget.startValidators,
            controller: widget.startController,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: StringResultView(
            decoration: widget.decoration,
            field: second,
            // current: extra.pickType == PickType.FieldTap ? null : widget.current,
            // next: extra.pickType == PickType.FieldTap ? null : middleNode,
            style: widget.style,
            onChanged: (CompositeValue? value) {
              if (value == null) {
                widget.onChanged(null);
                return;
              }

              widget.onChanged(
                CompositeValue(widget.startController.text, extra: widget.endController.text),
              );
            },
            validators: widget.endValidators,
            controller: widget.endController,
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
                            child: Material(
                          type: MaterialType.transparency,
                          child: SizedBox(
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
                                      childCount: 364,
                                      scrollController:
                                          FixedExtentScrollController(initialItem: daysCount! - 1),
                                      onSelectedItemChanged: (index) {
                                        daysCount = index + 1;
                                        setState(() {});

                                        if (widget.startController.text.isEmpty) {
                                          return;
                                        }

                                        final format = extra.format ??
                                            DateFormat(DynamicFormValidators.datePattern);

                                        final startDate =
                                            format.safeStrictParse(widget.startController.text);

                                        if (startDate == null) {
                                          return;
                                        }

                                        final endDate = startDate.add(Duration(days: daysCount!));

                                        String value;
                                        try {
                                          value = (extra.format ??
                                                  DateFormat(DynamicFormValidators.datePattern))
                                              .format(endDate);
                                        } catch (e) {
                                          return;
                                        }

                                        updateValue(widget.endController, value);

                                        widget.onChanged(CompositeValue(widget.startController.text,
                                            extra: widget.endController.text));
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
                        )),
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
    final format = extra.format ?? DateFormat(DynamicFormValidators.datePattern);

    await Navigator.of(context).push(
      BottomSheetRoute(
        child: DatePeriodPicker(
          customConfig: widget.field.config,
          onChanged: (start, end, {clear = false}) {
            if (clear) {
              updateValue(widget.endController, '');
              updateValue(widget.startController, '');
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
              return null;
            }

            String? endValue;
            try {
              endValue = end != null ? format.format(end) : null;
            } catch (e) {
              return null;
            }

            daysCount = end?.difference(start).inDays ?? 0;

            updateValue(widget.endController, endValue ?? '');
            updateValue(widget.startController, startValue);
            setState(() {});

            widget.onChanged(
                CompositeValue(widget.startController.text, extra: widget.endController.text));
          },
          initialStartDate: format.safeStrictParse(widget.startController.text),
          initialEndDate: format.safeStrictParse(widget.endController.text),
        ),
      ),
    );
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

class DatePeriodPicker extends StatefulWidget {
  final CalendarDatePicker2Config? customConfig;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime? start, DateTime? end, {bool clear}) onChanged;

  const DatePeriodPicker({
    Key? key,
    required this.initialStartDate,
    required this.initialEndDate,
    required this.onChanged,
    this.customConfig,
  }) : super(key: key);

  @override
  State<DatePeriodPicker> createState() => _DatePeriodPickerState();
}

class _DatePeriodPickerState extends State<DatePeriodPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Column(
        children: [
          Material(
            type: MaterialType.transparency,
            child: SizedBox(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: 80,
                    child: MaterialButton(
                      onPressed: () {
                        widget.onChanged(null, null, clear: true);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        locale.dynamicFormTranslation.clear,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.button!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      locale.dynamicFormTranslation.selectPeriod,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        locale.dynamicFormTranslation.done,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Material(
              type: MaterialType.transparency,
              child: CalendarDatePicker2(
                onValueChanged: (dates) {
                  final endDate = dates.length > 1 &&
                          dates[1] != null &&
                          dates[0] != null &&
                          DateTime(dates[1]!.year, dates[1]!.month, dates[1]!.day) !=
                              DateTime(dates[0]!.year, dates[0]!.month, dates[0]!.day)
                      ? dates[1]
                      : null;
                  widget.onChanged(dates[0], endDate, clear: false);
                },
                config: (widget.customConfig ??
                        CalendarDatePicker2Config(
                          selectedYearTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                          selectedDayHighlightColor: Theme.of(context).colorScheme.tertiary,
                          selectedDayTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                          calendarType: CalendarDatePicker2Type.range,
                        ))
                    .copyWith(
                  calendarType: CalendarDatePicker2Type.range,
                ),
                initialValue: [widget.initialStartDate, widget.initialEndDate],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
