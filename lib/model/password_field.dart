import 'package:flutter/material.dart';

import '../model/dynamic_form_models.dart';

class PasswordField extends Field {
  final Widget? Function(BuildContext context, PasswordField field)? forgotPasswordBuilder;
  final bool disableFormatting;

  PasswordField({
    required String fieldId,
    bool required = false,
    bool readOnly = false,
    this.disableFormatting = false,
    required String label,
    this.forgotPasswordBuilder,
    bool? maskText,
    int? maxLength,
    String? inputType,
    List<Option>? options,
    String? confirmField,
    CompositeValue? value,
    List<DependsOnValue>? dependsOn,
    bool? isCapitalized,
    String? validationExpression,
    String? validationErrorMessage,
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
          onUpdated: onUpdated,
          isCapitalized: isCapitalized,
          fieldType: FieldTypes.Password,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: value,
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
        );
}
