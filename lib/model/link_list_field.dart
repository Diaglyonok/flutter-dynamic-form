import 'package:flutter/cupertino.dart';
import 'package:flutter_dynamic_form/model/dynamic_form_models.dart';
import 'package:flutter_dynamic_form/model/link_field.dart';

class LinksListField extends Field {
  final List<LinkField> initialFields;
  final Widget? addButton;

  LinksListField({
    required this.initialFields,
    required super.fieldId,
    this.addButton,
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
    super.value,
    super.dependsOn,
    super.isCapitalized,
    super.validationExpression,
    super.validationErrorMessage,
    super.onUpdated,
    super.infoCallback,
    super.shouldShowInfo,
    super.multiline,
    super.withBottomPadding = true,
    super.wrapper,
    super.onEdittingComplete,
  }) : super(
          fieldType: FieldTypes.LinksList,
        );
}
