import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/type_picker_text_field.dart';
import '../field_widgets/text_field.dart';

class MultitypeFieldView extends StatefulWidget {
  final String label;
  final MultitypeField field;
  final String? Function(String?)? validators;
  final TextEditingController controller;
  final dynamic Function(String)? onChanged;
  final BuildContext context;
  final String? hintText;
  final Widget? suffixIcon;
  final FocusNode? current;
  final FocusNode? next;
  final bool required;
  final bool capitalize;
  final TextStyle? style;
  final bool multiline;
  final bool autosize;
  final double? scrollPadding;
  final TextInputType? inputType;
  final List<TextInputFormatter>? formatters;
  final Function? onTapHandler;
  final bool? maskText;

  const MultitypeFieldView({
    Key? key,
    required this.label,
    required this.field,
    required this.validators,
    required this.controller,
    this.onChanged,
    required this.context,
    this.hintText,
    this.suffixIcon,
    this.current,
    this.next,
    this.required = false,
    this.capitalize = false,
    this.style,
    this.multiline = false,
    this.autosize = false,
    this.scrollPadding,
    this.inputType,
    this.formatters,
    this.onTapHandler,
    this.maskText,
  }) : super(key: key);

  @override
  State<MultitypeFieldView> createState() => _MultitypeFieldViewState();
}

class _MultitypeFieldViewState extends State<MultitypeFieldView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DynamicTextField(
            context: context,
            label: widget.label,
            field: widget.field,
            validators: widget.validators,
            controller: widget.controller,
            onChanged: widget.onChanged,
            hintText: widget.hintText,
            suffixIcon: widget.suffixIcon,
            current: widget.current,
            next: widget.next,
            required: widget.required,
            capitalize: widget.capitalize,
            style: widget.style,
            multiline: widget.multiline,
            autosize: widget.autosize,
            scrollPadding: widget.scrollPadding,
            inputType: widget.inputType,
            formatters: widget.formatters,
            onTapHandler: widget.onTapHandler,
            maskText: widget.maskText,
          ),
        ),
      ],
    );
  }
}
