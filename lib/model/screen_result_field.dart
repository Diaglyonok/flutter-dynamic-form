import 'package:flutter/material.dart';

import '../model/dynamic_form_models.dart';

class ScreenResultCompositeValue extends CompositeValue {
  final Map<String, dynamic>? jsonData;

  ScreenResultCompositeValue(String value, {this.jsonData, String? extra})
      : super(value, extra: extra);
}

class ScreenResultExtra {
  Future<ScreenResultCompositeValue?> Function(BuildContext context) getResult;
  final bool isMultiline;
  ScreenResultExtra({
    required this.getResult,
    this.isMultiline = false,
  });
}

class ScreenResultField extends Field {
  final ScreenResultExtra extra;
  final bool extraPrefix;

  ScreenResultField({
    required super.fieldId,
    required super.label,
    required this.extra,
    this.extraPrefix = false,
    super.required = false,
    super.readOnly = false,
    super.maskText,
    super.maxLength,
    super.inputType,
    super.options,
    super.confirmField,
    super.value,
    super.dependsOn,
    super.isCapitalized,
    super.validationExpression,
    super.validationErrorMessage,
    super.onUpdated,
    super.infoCallback,
    super.shouldShowInfo,
    super.multiline,
  }) : super(fieldType: FieldTypes.ScreenResult);
}
