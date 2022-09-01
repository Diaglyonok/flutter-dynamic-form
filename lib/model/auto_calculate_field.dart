import '../model/dynamic_form_models.dart';

class AutoCalculateField extends Field {
  final CompositeValue? Function(Map<String, CompositeValue>? values) calculate;

  AutoCalculateField({
    required super.fieldId,
    required super.fieldType,
    required super.label,
    required this.calculate,
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
  });
}
