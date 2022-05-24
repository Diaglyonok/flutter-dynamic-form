import 'package:flutter/cupertino.dart';

import '../model/dynamic_form_models.dart';

class ColorField extends Field {
  final Color Function(Color color)? modifier;

  ColorField({
    required String fieldId,
    this.modifier,
    required String label,
    bool? maskText,
    int? maxLength,
    String? inputType,
    List<Option>? options,
    String? confirmField,
    List<DependsOnValue>? dependsOn,
    bool? isCapitalized,
    String? validationExpression,
    String? validationErrorMessage,
    Color? initColor,
    Function(CompositeValue?)? onUpdated,
  }) : super(
          fieldId: fieldId,
          required: false,
          readOnly: false,
          label: label,
          maskText: maskText,
          maxLength: maxLength,
          onUpdated: onUpdated,
          inputType: inputType,
          options: options,
          isCapitalized: isCapitalized,
          fieldType: FieldTypes.Color,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: initColor == null ? null : CompositeValue(initColor.value.toString()),
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
        );
}
