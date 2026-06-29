import 'package:flutter/material.dart';

import '../model/dynamic_form_models.dart';

class LockFeature {
  final Widget Function(
          BuildContext context, Widget Function(BuildContext context, bool isLocked) childBuilder)
      isLockedWrapperBuilder;
  final Widget Function(BuildContext context, Widget child) lockBuilder;
  final VoidCallback? onUnlock;

  LockFeature({
    required this.isLockedWrapperBuilder,
    required this.lockBuilder,
    this.onUnlock,
  });
}

class ColorField extends Field {
  final Color Function(Color color)? modifier;
  final LockFeature? lockFeature;
  final Color? overrideColor;

  ColorField({
    required super.fieldId,
    this.modifier,
    this.lockFeature,
    this.overrideColor,
    Color? initColor,
    required super.label,
    super.maskText,
    super.minLines,
    super.maxLength,
    super.customInputType,
    super.options,
    super.confirmField,
    super.dependsOn,
    super.capitalizeType,
    super.validationExpression,
    super.validationErrorMessage,
    super.onUpdated,
    super.infoCallback,
    super.shouldShowInfo,
    super.multiline,
    super.withBottomPadding = true,
    super.wrapper,
    super.customTextStyle,
  }) : super(
          required: false,
          readOnly: false,
          fieldType: FieldTypes.Color,
          value: initColor == null ? null : CompositeValue(initColor.value.toString()),
        );

  Color? get color {
    final intColor = int.tryParse(value?.value ?? '');
    final flatColor = intColor == null ? null : Color(intColor);

    return flatColor;
  }
}
