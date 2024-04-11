import 'package:flutter/material.dart';

import '../../model/dynamic_form_models.dart';

class CheckboxField extends StatefulWidget {
  final bool checkboxFirst;
  final Field field;
  final TextStyle? style;
  final Function(bool) onChanged;

  const CheckboxField({
    required this.field,
    required this.onChanged,
    this.checkboxFirst = false,
    Key? key,
    this.style,
  }) : super(key: key);

  @override
  State<CheckboxField> createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  bool value = false;

  @override
  void initState() {
    value = widget.field.value?.value.toBool() ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final result = [
      Expanded(
        child: Text(
          widget.field.label,
          style: widget.field.customTextStyle ??
              (widget.style ?? Theme.of(context).textTheme.labelLarge)?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 26,
          width: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Theme.of(context).colorScheme.secondary.withOpacity(value ? 1.0 : 0.1),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 1.5,
            ),
          ),
          child: Icon(
            Icons.check,
            size: 19,
            color: value ? Theme.of(context).colorScheme.onSecondary : Colors.transparent,
          ),
        ),
      )
    ];
    return InkWell(
      onTap: () {
        setState(() {
          value = !value;
        });
        widget.onChanged(value);
      },
      child: Row(
        children: widget.checkboxFirst ? result.reversed.toList() : result,
      ),
    );
  }
}

extension on String? {
  bool? toBool() {
    switch (this) {
      case 'true':
        return true;
      case 'false':
        return false;
      default:
        return null;
    }
  }
}
