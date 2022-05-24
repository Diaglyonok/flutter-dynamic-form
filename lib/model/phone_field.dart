import '../model/dynamic_form_models.dart';

class PhoneField extends Field {
  final String initialPrefix;

  PhoneField({
    required String fieldId,
    bool required = false,
    bool readOnly = false,
    required String label,
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
    required this.initialPrefix,
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
          fieldType: FieldTypes.Phone,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: value ?? CompositeValue('', extra: initialPrefix),
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
          onUpdated: onUpdated,
        );
}
