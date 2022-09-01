import 'package:intl/intl.dart';

import '../model/dynamic_form_models.dart';

enum PickType { SuffixGetter, FieldTap }

class DateField extends Field {
  final DateFormat? format;
  final DateTime? startDateBounds;
  final DateTime? endDateBounds;
  final CompareDate? compareDate;

  DateField({
    required super.fieldId,
    required super.label,
    this.startDateBounds,
    this.endDateBounds,
    this.compareDate,
    this.format,
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
  }) : super(
          fieldType: FieldTypes.Date,
        );
}
