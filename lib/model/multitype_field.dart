import '../model/dynamic_form_models.dart';

class MultitypeField extends Field {
  final List<String> types;
  final Map<String, String>? translations;

  MultitypeField({
    required super.fieldId,
    required super.label,
    required super.fieldType,
    required this.types,
    this.translations,
    super.getFormatters,
    super.required = false,
    super.readOnly = false,
    super.customValidator,
    super.minLines,
    super.infoCallback,
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
    super.shouldShowInfo,
    super.multiline,
  });
}
