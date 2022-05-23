import 'package:flutter/cupertino.dart';

import '../model/dynamic_form_models.dart';

class ColorField extends Field {
  final Color Function(Color color)? modifier;

  ColorField({
    required String fieldId,
    this.modifier,
    required String label,
    String? labelId,
    bool? maskText,
    int? maxLength,
    String? inputType,
    List<Option>? options,
    String? confirmField,
    bool? strict,
    String? fieldName,
    int? versionId,
    List<DependsOnValue>? dependsOn,
    List<Field>? children,
    bool? isCapitalized,
    String? validationExpression,
    String? validationErrorMessage,
    CompareDate? compareDate,
    int? parentId,
    Color? initColor,
  }) : super(
          fieldName: fieldName,
          versionId: versionId,
          fieldId: fieldId,
          required: false,
          readOnly: false,
          label: label,
          labelId: labelId,
          maskText: maskText,
          maxLength: maxLength,
          inputType: inputType,
          options: options,
          isCapitalized: isCapitalized,
          fieldType: FieldTypes.Color,
          strict: strict,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: initColor == null ? null : CompositeValue(initColor.value.toString()),
          parentId: parentId,
          children: children,
          compareDate: compareDate,
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
        );
}
