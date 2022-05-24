import '../model/dynamic_form_models.dart';

class AutoCalculateField extends Field {
  final CompositeValue? Function(Map<String, CompositeValue>? values) calculate;

  AutoCalculateField({
    required String fieldId,
    required FieldTypes fieldType,
    required String label,
    required this.calculate,
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
    CompareDate? compareDate,
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
          compareDate: compareDate,
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
          onUpdated: onUpdated,
        );
}
