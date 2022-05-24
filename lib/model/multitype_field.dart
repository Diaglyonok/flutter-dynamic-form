import '../model/dynamic_form_models.dart';

class MultitypeField extends Field {
  final List<String> types;
  final Map<String, String>? translations;

  MultitypeField({
    required String fieldId,
    required String label,
    required FieldTypes fieldType,
    required this.types,
    this.translations,
    bool required = false,
    bool readOnly = false,
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
          isCapitalized: isCapitalized,
          fieldType: fieldType,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: value,
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
          onUpdated: onUpdated,
        );
}
