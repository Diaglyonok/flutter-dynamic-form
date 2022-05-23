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
    CompareDate? compareDate,
    Color? initColor,
  }) : super(
          fieldId: fieldId,
          required: false,
          readOnly: false,
          label: label,
          maskText: maskText,
          maxLength: maxLength,
          inputType: inputType,
          options: options,
          isCapitalized: isCapitalized,
          fieldType: FieldTypes.Color,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: initColor == null ? null : CompositeValue(initColor.value.toString()),
          compareDate: compareDate,
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
        );
}
