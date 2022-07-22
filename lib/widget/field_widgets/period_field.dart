import 'package:dglk_flutter_dev_kit/bottom_sheet/src/bottom_sheet_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/widget/field_widgets/bottom_pick_button.dart';
import 'package:intl/intl.dart';

import '../../flutter_dynamic_form.dart';
import '../../logic/dynamic_form_validators.dart';
import '../../utils/masked_text_controller.dart';
import '../../widget/field_widgets/date.dart';

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
  int daysCount = 0;
  FixedExtentScrollController? scrollController = FixedExtentScrollController();

  @override
  void initState() {
    middleNode = FocusNode(debugLabel: widget.field.label);
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

  @override
  Widget build(BuildContext context) {
    final extra = widget.field.extra;

    return Row(
      children: [
        Expanded(
          child: DateFieldView(
            decoration: widget.decoration,
            field: widget.field,
            current: extra.pickType == PickType.FieldTap ? null : widget.current,
            next: extra.pickType == PickType.FieldTap ? null : middleNode,
            format: extra.format,
            style: widget.style,
            type: extra.type ?? CupertinoDatePickerMode.date,
            customLabel: widget.field.label,
            pickType: extra.pickType ?? PickType.SuffixGetter,
            scrollPadding: widget.scrollPadding,
            onChanged: (CompositeValue? value) {
              if (value == null) {
                widget.onChanged(null);
                return;
              }

              widget.onChanged(
                CompositeValue(widget.startController.text, extra: widget.endController.text),
              );
            },
            onDateTimeChanged: (DateTime dateTime) {
              final format = extra.format ?? DateFormat(DynamicFormValidators.datePattern);
              String value;
              try {
                value = format.format(dateTime);
              } catch (e) {
                return;
              }

              if (daysCount > 0) {
                final endDate = dateTime.add(Duration(days: daysCount));

                String endValue;
                try {
                  endValue = format.format(endDate);
                } catch (e) {
                  return;
                }

                updateValue(widget.endController, endValue);
                setState(() {});
              } else {
                final endDate = format.safeStrictParse(widget.endController.text);
                if (endDate != null) {
                  daysCount = endDate.difference(dateTime).inDays;
                  setState(() {});
                }
              }

              updateValue(widget.startController, value);

              widget.onChanged(
                  CompositeValue(widget.startController.text, extra: widget.endController.text));
            },
            validators: widget.startValidators,
            controller: widget.startController,
            endDate: widget.endDate,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: DateFieldView(
            decoration: widget.decoration,
            field: widget.field,
            current: extra.pickType == PickType.FieldTap ? null : middleNode,
            next: extra.pickType == PickType.FieldTap ? null : widget.next,
            style: widget.style,
            format: extra.format,
            type: extra.type ?? CupertinoDatePickerMode.date,
            customLabel: extra.secondLabel ?? widget.field.label,
            pickType: extra.pickType ?? PickType.SuffixGetter,
            scrollPadding: widget.scrollPadding,
            onChanged: extra.pickType == PickType.FieldTap
                ? null
                : (CompositeValue? value) {
                    if (value == null) {
                      widget.onChanged(null);
                      return;
                    }

                    widget.onChanged(
                      CompositeValue(widget.startController.text, extra: widget.endController.text),
                    );
                  },
            onDateTimeChanged: (DateTime dateTime) {
              final format = extra.format ?? DateFormat(DynamicFormValidators.datePattern);
              String value;
              try {
                value = format.format(dateTime);
              } catch (e) {
                return;
              }

              final startDate = format.safeStrictParse(widget.startController.text);

              if (startDate != null) {
                final diff = dateTime.difference(startDate).inDays;
                daysCount = diff;
                setState(() {});
              }

              updateValue(widget.endController, value);

              widget.onChanged(
                CompositeValue(widget.startController.text, extra: widget.endController.text),
              );
            },
            validators: widget.startValidators,
            controller: widget.endController,
            startDate: widget.startDate,
          ),
        ),
        if (widget.field.withDaysNum)
          BottomPickButton(
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
                              scrollController: FixedExtentScrollController(initialItem: daysCount),
                              onSelectedItemChanged: (index) {
                                daysCount = index + 1;
                                setState(() {});

                                if (widget.startController.text.isEmpty) {
                                  return;
                                }

                                final format =
                                    extra.format ?? DateFormat(DynamicFormValidators.datePattern);

                                final startDate =
                                    format.safeStrictParse(widget.startController.text);

                                if (startDate == null) {
                                  return;
                                }

                                final endDate = startDate.add(Duration(days: daysCount));

                                String value;
                                try {
                                  value = (extra.format ??
                                          DateFormat(DynamicFormValidators.datePattern))
                                      .format(endDate);
                                } catch (e) {
                                  return;
                                }

                                updateValue(widget.endController, value);
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
          )
      ],
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
