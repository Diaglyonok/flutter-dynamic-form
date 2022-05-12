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
    String? labelId,
    bool? maskText,
    int? maxLength,
    String? inputType,
    List<Option>? options,
    String? confirmField,
    bool? strict,
    String? fieldName,
    int? versionId,
    ScreenResultCompositeValue? value,
    List<DependsOnValue>? dependsOn,
    List<Field>? children,
    bool? isCapitalized,
    String? validationExpression,
    String? validationErrorMessage,
    CompareDate? compareDate,
    int? parentId,
    required this.extra,
  }) : super(
          fieldName: fieldName,
          versionId: versionId,
          fieldId: fieldId,
          required: required,
          readOnly: readOnly,
          label: label,
          labelId: labelId,
          maskText: maskText,
          maxLength: maxLength,
          inputType: inputType,
          options: options,
          isCapitalized: isCapitalized,
          fieldType: FieldTypes.ScreenResult,
          strict: strict,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: value,
          parentId: parentId,
          children: children,
          compareDate: compareDate,
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
        );
}
