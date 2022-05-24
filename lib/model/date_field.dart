import 'package:intl/intl.dart';

import '../model/dynamic_form_models.dart';

class DateField extends Field {
  final DateFormat? format;

  DateField({
    required String fieldId,
    bool required = false,
    bool readOnly = false,
    required String label,
    this.format,
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
          onUpdated: onUpdated,
          isCapitalized: isCapitalized,
          fieldType: FieldTypes.Date,
          confirmField: confirmField,
          dependsOn: dependsOn,
          value: value,
          compareDate: compareDate,
          validationExpression: validationExpression,
          validationErrorMessage: validationErrorMessage,
        );
}
