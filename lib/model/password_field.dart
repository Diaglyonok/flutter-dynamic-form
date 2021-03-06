import 'package:flutter/material.dart';

import '../model/dynamic_form_models.dart';

class PasswordField extends Field {
  final Widget? Function(BuildContext context, PasswordField field)? forgotPasswordBuilder;
  final bool disableFormatting;

  PasswordField({
    required super.fieldId,
    required super.label,
    this.disableFormatting = false,
    this.forgotPasswordBuilder,
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
  }) : super(fieldType: FieldTypes.Password);
}
