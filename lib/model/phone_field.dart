import '../model/dynamic_form_models.dart';

class PhoneField extends Field {
  final String initialPrefix;

  PhoneField({
    required super.fieldId,
    super.required = false,
    super.readOnly = false,
    required super.label,
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
    required this.initialPrefix,
    super.onUpdated,
    super.infoCallback,
    super.shouldShowInfo,
  }) : super(fieldType: FieldTypes.Phone);
}
