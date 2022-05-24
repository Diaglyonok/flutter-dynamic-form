import 'package:flutter/material.dart';

import '../model/dynamic_form_models.dart';

class ScreenResultCompositeValue extends CompositeValue {
  final Map<String, dynamic>? jsonData;

  ScreenResultCompositeValue(String value, {this.jsonData, String? extra})
      : super(value, extra: extra);
}

class ScreenResultExtra {
  Future<ScreenResultCompositeValue?> Function(BuildContext context) getResult;

  ScreenResultExtra({required this.getResult});
}

class ScreenResultField extends Field {
  final ScreenResultExtra extra;
  final bool extraPrefix;

  ScreenResultField({
    required String fieldId,
    bool required = false,
    bool readOnly = false,
    required String label,
    this.extraPrefix = false,
    bool? maskText,
    int? maxLength,
    String? inputType,
    List<Option>? options,
    String? confirmField,
    ScreenResultCompositeValue? value,
    List<DependsOnValue>? dependsOn,
    bool? isCapitalized,
    String? validationExpression,
    String? validationErrorMessage,
    required this.extra,
    Function(CompositeValue?)? onUpdated,
  }) : super(
          fieldId: fieldId,
          required: required,
          readOnly: readOnly,
          label: label,
          maskText: maskText,
          maxLength: maxLength,
          inputType: inputType,
          options: options,
          isCapitalized: isCapitalized,
          fieldType: FieldTypes.ScreenResult,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: value,
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
          onUpdated: onUpdated,
        );
}
