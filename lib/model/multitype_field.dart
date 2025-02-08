import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/widget/field_widgets/multitype_wrapper.dart';

import '../model/dynamic_form_models.dart';

class MultitypeField extends Field {
  final List<String> types;
  final Map<String, String>? translations;

  final GlobalKey<MultitypeFieldWrapperState> keyField = GlobalKey<MultitypeFieldWrapperState>();

  MultitypeField({
    required super.fieldId,
    required super.label,
    required super.fieldType,
    required this.types,
    this.translations,
    super.suffixIconBuilder,
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
    super.capitalizeType,
    super.validationExpression,
    super.validationErrorMessage,
    super.onUpdated,
    super.shouldShowInfo,
    super.multiline,
    super.withBottomPadding = true,
    super.wrapper,
    super.onEdittingComplete,
  });
}
