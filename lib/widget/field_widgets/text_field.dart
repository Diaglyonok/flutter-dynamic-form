import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/auto_calculate_field.dart';
import '../../model/dynamic_form_models.dart';
import '../../model/multitype_field.dart';
import 'info_wrapper.dart';
import 'multitype_wrapper.dart';

class DynamicTextField extends StatefulWidget {
  final String label;
  final Field field;
  final String? Function(String?)? validators;
  final TextEditingController controller;
  final dynamic Function(CompositeValue?)? onChanged;
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
  final InputDecoration? decoration;

  const DynamicTextField({
    Key? key,
    required this.label,
    required this.field,
    required this.validators,
    required this.controller,
    this.decoration,
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

  static InputDecoration defaultDecoration(BuildContext context) => InputDecoration(
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 0.4)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 0.4)),
        labelStyle: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
        hintStyle: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2)),
        counterStyle: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontSize: 12, color: Theme.of(context).colorScheme.onBackground),
        errorStyle: Theme.of(context).textTheme.caption!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1),
        ),
      );

  @override
  State<DynamicTextField> createState() => _DynamicTextFieldState();
}

class _DynamicTextFieldState extends State<DynamicTextField> {
  String? currentExtra;

  CompositeValue? currentValue;

  void Function()? listener;
  @override
  void initState() {
    currentExtra =
        widget.field is MultitypeField ? (widget.field as MultitypeField).types.first : null;

    currentValue = widget.field.value;

    listener = () {
      setState(() {});
    };
    widget.current?.addListener(listener!);
    super.initState();
  }

  @override
  void dispose() {
    if (listener != null) {
      widget.current?.removeListener(listener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextInputType? inputType;
    if (widget.inputType == null || (widget.field.readOnly)) {
      inputType = TextInputType.text;
    }
    final style = widget.style?.copyWith(
            color: widget.field.readOnly
                ? widget.style?.color?.withOpacity(0.44)
                : widget.style?.color) ??
        Theme.of(context).textTheme.headline6!.copyWith(
            height: 1.1,
            color: widget.field.readOnly
                ? Theme.of(context).colorScheme.onBackground.withOpacity(0.44)
                : Theme.of(context).colorScheme.onBackground);
    final caption = (widget.label) + (widget.required ? ' *' : '');

    final decoration = (widget.decoration ?? DynamicTextField.defaultDecoration(context));
    final suffixIcon = widget.suffixIcon ??
        (widget.field is AutoCalculateField && !widget.field.readOnly
            ? IconButton(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.restart_alt,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  widget.onChanged?.call(null);
                },
              )
            : null);
    return MultitypeFieldWrapper(
      style: style,
      field: widget.field.readOnly
          ? null
          : widget.field is MultitypeField
              ? (widget.field as MultitypeField)
              : null,
      onExtraChanged: (extra) {
        currentExtra = extra;
        currentValue = CompositeValue(widget.controller.text, extra: extra);
        widget.onChanged?.call(
          currentValue,
        );
      },
      child: InfoWrapper(
        shouldShow: widget.field.shouldShowInfo?.call(currentValue) ?? true,
        infoCallback: widget.field.infoCallback,
        child: TextFormField(
          focusNode: widget.current,
          key: ValueKey<String>(widget.field.fieldId),
          enabled: !widget.field.readOnly,
          autocorrect: false,
          controller: widget.controller,
          keyboardType: inputType ?? widget.inputType,
          textInputAction: widget.next == null ? TextInputAction.done : TextInputAction.next,
          validator: widget.field.readOnly ? null : widget.validators,
          onChanged: widget.field.readOnly
              ? null
              : (value) {
                  currentValue = CompositeValue(value, extra: currentExtra);
                  widget.onChanged?.call(currentValue);
                },
          scrollPadding: widget.scrollPadding != null
              ? EdgeInsets.only(bottom: widget.scrollPadding!)
              : const EdgeInsets.all(20),
          onFieldSubmitted: (widget.field.readOnly)
              ? null
              : (term) {
                  widget.current?.unfocus();
                  if (widget.next != null) FocusScope.of(context).requestFocus(widget.next);
                },
          inputFormatters: widget.formatters,
          cursorColor: Theme.of(context).colorScheme.secondary,
          textCapitalization: widget.capitalize || (widget.field.isCapitalized ?? false)
              ? TextCapitalization.words
              : TextCapitalization.none,
          style: style,
          obscureText: widget.maskText ?? false,
          cursorWidth: 1.0,
          minLines: widget.field.minLines,
          maxLines: (widget.multiline || widget.field.minLines != null ? null : 1),
          maxLength: widget.field.maxLength,
          decoration: decoration.copyWith(
            suffixIcon: widget.current == null || !widget.current!.hasFocus || suffixIcon == null
                ? null
                : suffixIcon,
            counterStyle: widget.field.maxLength != null ? decoration.counterStyle : null,
            hintText: widget.hintText,
            labelText: caption,
          ),
        ),
      ),
    );
  }
}
