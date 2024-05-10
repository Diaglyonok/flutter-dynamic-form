import 'package:flutter/material.dart';

import '../model/dynamic_form_models.dart';

class PasswordField extends Field {
  final Widget? Function(BuildContext context, PasswordField field)? forgotPasswordBuilder;
  final bool disableValidation;

  PasswordField({
    required super.fieldId,
    required super.label,
    this.disableValidation = false,
    this.forgotPasswordBuilder,
    super.required = false,
    super.readOnly = false,
    super.customValidator,
    super.maskText,
    super.maxLength,
    super.minLines,
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
    super.withBottomPadding = true,
    super.wrapper,
  }) : super(fieldType: FieldTypes.Password);
}
