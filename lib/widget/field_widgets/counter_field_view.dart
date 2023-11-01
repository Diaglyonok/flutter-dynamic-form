import 'package:dglk_bottom_sheet_route/dglk_bottom_sheet_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../flutter_dynamic_form.dart';
import 'text_field.dart';

class CounterFieldView extends StatelessWidget {
  final Field field;
  final FocusNode? current;
  final FocusNode? next;
  final double? scrollPadding;
  final String? customLabel;
  final Function(CompositeValue?)? onChanged;
  final String? Function(String?)? validators;
  final TextEditingController controller;
  final DateFormat? format;
  final TextStyle? style;
  final InputDecoration? decoration;

  const CounterFieldView({
    Key? key,
    required this.field,
    this.current,
    this.next,
    this.scrollPadding,
    this.customLabel,
    required this.onChanged,
    this.validators,
    required this.controller,
    this.decoration,
    this.format,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onPressed() {
      Navigator.of(context, rootNavigator: true).push(
        BottomSheetRoute(
          builder: (context) => SizedBox(
            height: 240,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoPicker.builder(
                    itemExtent: 32,
                    childCount: 9007199254740991,
                    scrollController: FixedExtentScrollController(initialItem: int.tryParse(controller.text) ?? 0),
                    onSelectedItemChanged: (index) {
                      controller.text = index.toString();
                      onChanged?.call(CompositeValue(index.toString()));
                    },
                    itemBuilder: (context, index) {
                      return Center(
                          child: Text(
                        index.toString(),
                        style: style?.copyWith(
                          fontSize: 18,
                        ),
                      ));
                    },
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
      onTap: _onPressed,
      child: AbsorbPointer(
        absorbing: true,
        child: DynamicTextField(
          decoration: decoration,
          multiline: field.multiline,
          context: context,
          field: field,
          label: customLabel ?? field.label,
          next: next,
          style: style,
          scrollPadding: scrollPadding,
          hintText: null,
          current: current,
          required: field.required,
          inputType: TextInputType.datetime,
          controller: controller,
          onChanged: field.readOnly ? null : onChanged,
          validators: field.readOnly ? null : validators,
          maskText: field.maskText,
        ),
      ),
    );
  }
}
