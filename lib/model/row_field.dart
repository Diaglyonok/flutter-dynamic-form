import '../flutter_dynamic_form.dart';

class RowField extends Field {
  final List<Field> fields;

  RowField({
    required super.fieldId,
    required this.fields,
    super.required = false,
    super.readOnly = false,
    super.maskText,
    super.minLines,
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
    super.infoCallback,
    super.multiline,
  }) : super(fieldType: FieldTypes.RowField, label: '');
}
