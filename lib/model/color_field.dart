import 'package:flutter/cupertino.dart';

import '../model/dynamic_form_models.dart';

class ColorField extends Field {
  final Color Function(Color color)? modifier;

  ColorField({
    required super.fieldId,
    this.modifier,
    required super.label,
    super.maskText,
    super.minLines,
    super.maxLength,
    super.inputType,
    super.options,
    super.confirmField,
    super.dependsOn,
    super.isCapitalized,
    super.validationExpression,
    super.validationErrorMessage,
    Color? initColor,
    super.onUpdated,
    super.infoCallback,
    super.shouldShowInfo,
    super.multiline,
    super.withBottomPadding = true,
  }) : super(
          required: false,
          readOnly: false,
          fieldType: FieldTypes.Color,
          value: initColor == null ? null : CompositeValue(initColor.value.toString()),
        );
}
