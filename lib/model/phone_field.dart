import 'package:flutter/cupertino.dart';

import '../model/dynamic_form_models.dart';

class PhoneBottomViewCustomizations {
  final TextStyle? hintStyle;

  const PhoneBottomViewCustomizations({this.hintStyle});
}

class PhoneField extends Field {
  final String initialPrefix;
  final PhoneBottomViewCustomizations customizations;

  PhoneField({
    required super.fieldId,
    super.required = false,
    super.readOnly = false,
    required super.label,
    super.customValidator,
    super.minLines,
    super.maskText,
    super.maxLength,
    super.inputType,
    super.options,
    super.confirmField,
    CompositeValue? value,
    super.dependsOn,
    super.isCapitalized,
    super.validationExpression,
    super.validationErrorMessage,
    required this.initialPrefix,
    super.onUpdated,
    super.infoCallback,
    super.shouldShowInfo,
    super.multiline,
    this.customizations = const PhoneBottomViewCustomizations(),
  }) : super(
          fieldType: FieldTypes.Phone,
          value: value ?? CompositeValue('', extra: initialPrefix),
        );
}
