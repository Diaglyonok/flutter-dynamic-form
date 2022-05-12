import 'package:flutter/material.dart';

import '../../model/dynamic_form_models.dart';

class CheckboxField extends FormField<bool> {
  CheckboxField({
    Key? key,
    required Field field,
    FormFieldValidator<bool>? validator,
    FormFieldSetter<bool>? onSaved,
  }) : super(
          key: key,
          initialValue: field.value?.value.toBool(),
          builder: (FormFieldState<bool> state) => _CheckboxWidget(field, state),
          validator: validator,
          onSaved: onSaved,
        );
}

class _CheckboxWidget extends StatelessWidget {
  final Field field;
  final FormFieldState<bool> state;

  const _CheckboxWidget(this.field, this.state);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tile = CheckboxListTile(
      value: state.value ?? false,
      dense: true,
      title: Text(
        field.label,
        style: theme.textTheme.subtitle1!.copyWith(fontSize: 14),
      ),
      onChanged: state.didChange,
    );
    if (state.hasError) {
      return Theme(
        data: ThemeData(unselectedWidgetColor: theme.errorColor),
        child: tile,
      );
    }
    return tile;
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
