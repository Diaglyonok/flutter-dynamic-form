import 'package:flutter/material.dart';

import '../model/dynamic_form_models.dart';

class LinkField extends Field {
  final Widget? customCloseIcon;
  final Widget? customOpenIcon;

  LinkField({
    this.customCloseIcon,
    this.customOpenIcon,
    required super.fieldId,
    super.required = false,
    super.readOnly = false,
    required super.label,
    super.customValidator,
    super.customTextStyle,
    super.minLines,
    super.maskText,
    super.maxLength,
    super.inputType,
    super.options,
    super.confirmField,
    super.value,
    super.dependsOn,
    super.capitalizeType,
    super.validationExpression,
    super.validationErrorMessage,
    super.onUpdated,
    super.infoCallback,
    super.shouldShowInfo,
    super.multiline,
    super.withBottomPadding = true,
    super.wrapper,
    super.onEdittingComplete,
  }) : super(
          fieldType: FieldTypes.Link,
        );
}
