import 'package:flutter/material.dart';

import '../../model/screen_result_field.dart';
import 'text_field.dart';

class StringResultView extends StatefulWidget {
  final ScreenResultField field;
  final String? Function(String?)? validators;
  final TextEditingController controller;
  final void Function(ScreenResultCompositeValue)? onChanged;
  final FocusNode? current;
  final FocusNode? next;
  final TextStyle? style;
  final InputDecoration? decoration;

  const StringResultView({
    Key? key,
    required this.field,
    required this.controller,
    required this.onChanged,
    this.decoration,
    this.current,
    this.next,
    this.style,
    this.validators,
  }) : super(key: key);

  @override
  State<StringResultView> createState() => _StringResultViewState();
}

class _StringResultViewState extends State<StringResultView> {
  String? prefix;

  @override
  void initState() {
    prefix = widget.field.value is! ScreenResultCompositeValue
        ? null
        : (widget.field.value as ScreenResultCompositeValue).extra;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await widget.field.extra.getResult(context);
        if (result != null) {
          widget.controller.text = result.value;
          prefix = result.extra;
          setState(() {});

          widget.onChanged?.call(result);
        }
      },
      child: AbsorbPointer(
        child: DynamicTextField(
          decoration: widget.decoration,
          current: widget.current,
          style: widget.style,
          next: widget.next,
          label: widget.field.label,
          required: widget.field.required,
          suffixIcon: !widget.field.extraPrefix || prefix == null
              ? null
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        prefix!,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    //const SizedBox(height: 6),
                  ],
                ),
          field: widget.field,
          validators: widget.validators,
          controller: widget.controller,
          context: context,
        ),
      ),
    );
  }
}
