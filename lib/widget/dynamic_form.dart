import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dynamic_form/model/password_field.dart';
import 'package:flutter_dynamic_form/model/row_field.dart';
import 'package:flutter_dynamic_form/utils/replacement_formatter.dart';
import 'package:flutter_dynamic_form/widget/field_widgets/color_picker.dart';
import 'package:flutter_dynamic_form/widget/field_widgets/period_field_view.dart';
import 'package:intl/intl.dart';

import '../flutter_dynamic_form.dart';
import '../i18n/dynamic_form_localizations.g.dart' as locale;
import '../logic/dynamic_form_validators.dart';
import '../utils/form_utils.dart';
import '../utils/masked_text_controller.dart';
import '../widget/field_widgets/checkbox_field.dart';
import '../widget/field_widgets/radio_button.dart';
import '../widget/field_widgets/string_result_field.dart';
import 'field_widgets/counter_field_view.dart';
import 'field_widgets/date.dart';
import 'field_widgets/field_wrapper.dart';
import 'field_widgets/phone_field_wrapper.dart';
import 'field_widgets/text_field.dart';

///Counted by screen height divided by [maxFieldsForPinnedButton]
const averageFieldHeight = 135.0;

///How many fields shown on a screen.
const maxFieldsForPinnedButton = 5;

class DynamicForm extends StatefulWidget {
  final bool useBaseLocale;
  final String? title;
  final Widget? submitBtn;
  final Widget? hint;
  final EdgeInsets? titlePadding;
  final ScrollPhysics? physics;
  final List<Field> fields;
  final TextStyle? commonStyle;
  final Map<String, ValidationOptions>? validationOptions;
  final bool? allowFullZip;
  final ScrollController? scrollController;
  final bool allowPinnedButton;
  final EdgeInsets? listPadding;
  final InputDecoration? decoration;

  const DynamicForm({
    super.key,
    this.title,
    this.validationOptions,
    this.scrollController,
    this.physics,
    this.listPadding,
    this.submitBtn,
    required this.fields,
    this.commonStyle,
    this.hint,
    this.allowPinnedButton = false,
    this.titlePadding,
    this.allowFullZip = false,
    this.useBaseLocale = false,
    this.decoration,
  });
  @override
  DynamicFormState createState() => DynamicFormState();
}

class DynamicFormState extends State<DynamicForm> {
  static final List<FieldTypes> NOT_TEXT_TYPES = [
    FieldTypes.Label,
    FieldTypes.CheckBox,
    FieldTypes.RadioOptions,
    FieldTypes.Color,
  ];

  Map<String, CompositeValue> values = {};
  //Map<String, String> errors = {};
  final formKey = GlobalKey<FormState>(debugLabel: 'form_key');

  DynamicFormValidators? validators;
  bool _allowFullZip = false;
  bool _pinButton = false;

  final Map<String, TextEditingController> controllers = {};
  final List<FocusNode> nodes = [];
  final Map<String, FocusNode> additionalNodes = {};

  @override
  void initState() {
    super.initState();
    validators = DynamicFormValidators(
      widget.validationOptions,
      allowFullZip: _allowFullZip,
    );
    _allowFullZip = widget.allowFullZip ?? false;
    _initFieldData(widget.fields);
  }

  @override
  void dispose() {
    controllers.forEach((key, value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.useBaseLocale) {
      locale.LocaleSettings.useDeviceLocale();
    }

    if (widget.fields.length < MediaQuery.of(context).size.height / averageFieldHeight) {
      _pinButton = widget.allowPinnedButton;
    }

    final itemsCount =
        widget.fields.length + (widget.title != null ? 2 : 0) + (widget.submitBtn != null ? 1 : 0);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: _pinButtonWrapper(
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView.builder(
                physics: widget.physics ?? const BouncingScrollPhysics(),
                controller: widget.scrollController,
                addRepaintBoundaries: false,
                padding: widget.listPadding ?? const EdgeInsets.only(top: 16.0, bottom: 20),
                shrinkWrap: widget.title == null,
                itemCount: itemsCount,
                itemBuilder: (BuildContext ctxt, int index) {
                  FocusNode? current;
                  FocusNode? next;

                  final shift = (widget.title != null ? 2 : 0);
                  final field = index >= shift && index < (nodes.length + shift)
                      ? widget.fields[index - shift]
                      : null;

                  if (field != null &&
                      !NOT_TEXT_TYPES.contains(field.fieldType) &&
                      DynamicFormUtils.checkShouldShow(field: field, values: values)) {
                    current = nodes[index - shift];

                    if (index < (nodes.length + shift - 1)) {
                      var k = 1;
                      Field? nextField = widget.fields[index - shift + k];
                      while (nextField != null && nextField.fieldType == FieldTypes.Label ||
                          !DynamicFormUtils.checkShouldShow(field: nextField!, values: values)) {
                        k++;
                        if (index + k < (nodes.length + shift - 1)) {
                          nextField = widget.fields[index - shift + k];
                          if (NOT_TEXT_TYPES.contains(nextField.fieldType)) {
                            nextField = null;
                          }
                        } else {
                          nextField = null;
                          break;
                        }
                      }

                      if (nextField != null) {
                        next = nodes[index - shift + k];
                        //print("next for ${field.label} is ${index - shift + k}, f = ${widget.fields[index - shift + k].label}");
                      }
                    }
                  }

                  if (widget.title != null) {
                    switch (index) {
                      case 0:
                        final titleView = Padding(
                            padding: widget.titlePadding ??
                                const EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Text(
                              widget.title!,
                              textScaleFactor: 1.0,
                              style: Theme.of(ctxt).textTheme.headline3,
                            ));
                        return widget.hint == null
                            ? titleView
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  titleView,
                                  if (widget.hint != null) widget.hint!,
                                ],
                              );
                      case 1:
                        return const SizedBox(
                          height: 32,
                        );
                      default:
                        return (index == itemsCount - 1 && widget.submitBtn != null)
                            ? _pinButton
                                ? Container(height: 40)
                                : (widget.submitBtn ?? Container())
                            : FieldWrapper(
                                key: ValueKey<String>(field!.fieldId),
                                child: AbsorbPointer(
                                    absorbing: field.readOnly,
                                    child: _generateField(field, current, next, ctxt)));
                    }
                  } else {
                    return (index == itemsCount - 1 && widget.submitBtn != null)
                        ? _pinButton
                            ? Container(height: 40)
                            : (widget.submitBtn ?? Container())
                        : FieldWrapper(
                            key: ValueKey<String>(field!.fieldId),
                            child: AbsorbPointer(
                                absorbing: field.readOnly,
                                child: _generateField(field, current, next, ctxt)),
                          );
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget _pinButtonWrapper(Widget child) {
    if (!_pinButton) {
      return child;
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          child,
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: (widget.submitBtn ?? Container()),
          ),
        ],
      ),
    );
  }

  List<Field>? getFilledFields() {
    if (formKey.currentState?.validate() ?? false) {
      final result = <Field>[];

      for (var field in widget.fields) {
        final newValue = values[field.fieldId];
        result.add(field.withValue(newValue ?? field.value!));
      }
      return result;
    } else {
      return null;
    }
  }

  Map<String, CompositeValue>? getValues({bool withValidate = true}) {
    if (!withValidate || (formKey.currentState?.validate() ?? false)) {
      return values.map((key, value) => MapEntry(key, value));
    } else {
      return null;
    }
  }

  void _initFieldData(List<Field> fields, {Function(Field field)? generateNodesCallback}) {
    for (var field in fields) {
      switch (field.fieldType) {
        case FieldTypes.Label:
        case FieldTypes.Color:
        case FieldTypes.CheckBox:
          break;
        case FieldTypes.Text:
        case FieldTypes.PlainText:
        case FieldTypes.Password:
        case FieldTypes.Name:
        case FieldTypes.ScreenResult:
        case FieldTypes.Email:
          controllers[field.fieldId] = TextEditingController(text: field.value?.value);
          break;
        case FieldTypes.Date:
          final controller = MaskedTextController(
              mask: (field is DateField && field.format != null
                      ? field.format!
                      : DateFormat(DynamicFormValidators.datePattern))
                  .pattern!
                  .replaceAll('d', '0')
                  .replaceAll('M', '0')
                  .replaceAll('y', '0'));
          controller.updateText(field.value?.value ?? '');
          controllers[field.fieldId] = controller;
          break;
        case FieldTypes.Time:
          final controller = MaskedTextController(mask: '00:00');
          controller.updateText(field.value?.value ?? '');
          controllers[field.fieldId] = controller;
          break;
        case FieldTypes.Phone:
          controllers[field.fieldId] = MaskedTextController(mask: '(000) 000-0000')
            ..updateText(field.value?.value ?? '');
          try {
            controllers[field.fieldId]!.selection =
                TextSelection.collapsed(offset: field.value?.value.length ?? 0);
          } catch (e) {
            //ignore
          }

          controllers[field.fieldId + '_simple'] = TextEditingController(text: field.value?.value);
          break;

        case FieldTypes.RadioOptions:
          values[field.fieldId] = field.value ?? CompositeValue(field.options?.first.value ?? '');
          break;

        case FieldTypes.Number:
        case FieldTypes.Counter:
          controllers[field.fieldId] = TextEditingController(text: field.value?.value);
          break;
        case FieldTypes.DatePeriod:
          field as PeriodField;
          final extra = field.extra;
          final controllerStart = extra.pickType == PickType.FieldTap
              ? TextEditingController(text: field.value?.value)
              : (MaskedTextController(mask: '00/00/0000')..updateText(field.value?.value ?? ''));
          controllers[field.fieldId + '_start'] = controllerStart;
          final controllerEnd = extra.pickType == PickType.FieldTap
              ? TextEditingController(text: field.value?.extra)
              : (MaskedTextController(mask: '00/00/0000')..updateText(field.value?.extra ?? ''));
          controllers[field.fieldId + '_end'] = controllerEnd;
          break;

        case FieldTypes.RowField:
          field as RowField;
          _initFieldData(
            field.fields,
            generateNodesCallback: (field) {
              additionalNodes[field.fieldId] = FocusNode(debugLabel: field.label);
            },
          );
          break;
      }

      if (generateNodesCallback == null) {
        nodes.add(FocusNode(debugLabel: field.label));
      } else {
        generateNodesCallback.call(field);
      }
      if (field.value != null) {
        values[field.fieldId] = field.value!;
      }
    }
  }

  Widget? _generateField(
    Field field,
    FocusNode? current,
    FocusNode? next,
    BuildContext context,
  ) {
    if (!DynamicFormUtils.checkShouldShow(field: field, values: values)) {
      return null;
    }

    final autoUpdateValue = DynamicFormUtils.getAutoUpdateValue(field: field, values: values);
    if (autoUpdateValue != null &&
        (values[field.fieldId] == null || (values[field.fieldId]?.autoUpdated ?? false))) {
      values[field.fieldId] = autoUpdateValue.copyWith(autoUpdated: true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controllers[field.fieldId]?.text = autoUpdateValue.value;
      });
    } else if (autoUpdateValue == null && (values[field.fieldId]?.autoUpdated ?? false)) {
      values.remove(field.fieldId);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controllers[field.fieldId]?.text = '';
      });
    }

    if (field.fieldType == null) {
      return _getDefaultField(field, current, next, context);
    }

    switch (field.fieldType) {
      case FieldTypes.Color:
        return _generateColorPickcer(context, field, current, next);
      case FieldTypes.RadioOptions:
        return _generateRadioField(context, field, current, next);
      case FieldTypes.Label:
        return _generateLabelField(context, field, current, next);
      case FieldTypes.Text:
        return _generateSimpleTextField(context, field, current, next);
      case FieldTypes.Phone:
        return _generatePhoneField(context, field, current, next);
      case FieldTypes.Password:
        return _generatePasswordField(context, field, current, next);
      case FieldTypes.Name:
        return _generateNameField(context, field, current, next);
      case FieldTypes.Email:
        return _generateEmailField(context, field, current, next);
      case FieldTypes.Date:
        return _generateDateField(context, field, current, next);
      case FieldTypes.CheckBox:
        return _generateCheckboxField(context, field, current, next);
      case FieldTypes.PlainText:
        return _generatePlainTextField(context, field, current, next);
      case FieldTypes.Number:
        return _generateNumberField(context, field, current, next);
      case FieldTypes.Time:
        return _generateTimeField(context, field, current, next);
      case FieldTypes.DatePeriod:
        return _generateDatePeriod(context, field as PeriodField, current, next);
      case FieldTypes.ScreenResult:
        return _generateScreenResultField(context, field as ScreenResultField, current, next);
      case FieldTypes.RowField:
        return _generateRowField(context, field as RowField, current, next);
      case FieldTypes.Counter:
        return _generateCounter(context, field, current, next);
    }
    return null;
  }

  String? Function(String?)? _commonTextValidators(
    Field field, {
    List<String? Function(String?)>? additionals,
  }) =>
      DynamicFormUtils.getMultivalidator<String?>([
        if (field.required && !field.readOnly) validators?.requiredValidator,
        (String? value) => validators?.confirmValidator(value, field.confirmField ?? '', values),
        if (field.validationExpression != null && field.validationErrorMessage != null)
          (String? value) => validators?.regExpValidator(
                field.validationExpression!,
                field.validationErrorMessage!,
                value == null ? null : CompositeValue(value),
                isRequired: field.required,
              ),
        if (additionals != null) ...additionals
      ]);

  Widget _getDefaultField(
    Field field,
    FocusNode? current,
    FocusNode? next,
    BuildContext context,
  ) {
    switch (field.inputType?.toLowerCase()) {
      case 'number':
        return _generateNumberField(context, field, current, next);
      case 'date':
        return _generateDateField(context, field, current, next);
      case 'text':
      default:
        return _generateSimpleTextField(context, field, current, next);
    }
  }

  _commonOnChanged(CompositeValue? value, Field field) {
    if (value == null) {
      values.remove(field.fieldId);
    } else {
      values[field.fieldId] = value;
    }

    field.onUpdated?.call(value);
    setState(() {});
  }

  ///
  ///
  ///
  ///
  ///
  ///
  //// GENERATORS ////
  ///
  ///
  ///
  ///
  ///
  ///

  Widget _generateCounter(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    final controller = controllers[field.fieldId];
    return CounterFieldView(
      onChanged: (value) => _commonOnChanged(value, field),
      decoration: widget.decoration,
      field: field,
      format: field is DateField ? field.format : null,
      style: widget.commonStyle,
      scrollPadding: _pinButton ? 100 : null,
      validators: _commonTextValidators(field),
      controller: controller!,
    );
  }

  Widget _generateRowField(
    BuildContext context,
    RowField field,
    FocusNode? current,
    FocusNode? next,
  ) {
    final widgetList = <Widget>[];

    for (int i = 0; i < field.fields.length; i++) {
      final e = field.fields[i];
      FocusNode? currNext;
      if (i < field.fields.length - 1) {
        currNext = additionalNodes[field.fields[i + 1].fieldId];
      }
      final fieldWidget = _generateField(
          e, i == 0 ? current : additionalNodes[e.fieldId], currNext ?? next, context);
      widgetList.add(fieldWidget == null
          ? Container()
          : Expanded(
              child: fieldWidget,
            ));

      if (i != field.fields.length - 1) {
        widgetList.add(const SizedBox(
          width: 16,
        ));
      }
    }
    return Row(
      children: widgetList,
    );
  }

  Widget _generateDatePeriod(
    BuildContext context,
    PeriodField field,
    FocusNode? current,
    FocusNode? next,
  ) {
    final extra = field.extra;

    final startController = controllers[field.fieldId + '_start'] ?? TextEditingController();
    final endController = controllers[field.fieldId + '_end'] ?? TextEditingController();

    DateTime? startDate;
    DateTime? endDate;

    if (values[field.fieldId] != null) {
      try {
        startDate = (extra.format ?? DateFormat(DynamicFormValidators.datePattern))
            .parseStrict(values[field.fieldId]!.value);
        if (field.extra.allowedDifference != null) {
          startDate = startDate.subtract(field.extra.allowedDifference!);
        }
      } catch (e) {
        log(e.toString());
        //ignore
      }

      try {
        endDate = (extra.format ?? DateFormat(DynamicFormValidators.datePattern))
            .parseStrict(values[field.fieldId]!.extra!);
        if (field.extra.allowedDifference != null) {
          endDate = endDate.add(field.extra.allowedDifference!);
        }
      } catch (e) {
        log(e.toString());
        //ignore
      }
    }

    final style = widget.commonStyle ??
        Theme.of(context).textTheme.headline6!.copyWith(
            height: 1.1,
            fontSize: 16,
            color: field.readOnly
                ? Theme.of(context).colorScheme.onBackground.withOpacity(0.44)
                : Theme.of(context).colorScheme.onBackground);

    return PeriodFieldView(
      field: field,
      current: current,
      next: next,
      endController: endController,
      startController: startController,
      startDate: startDate,
      endDate: endDate,
      style: style,
      decoration: widget.decoration,
      scrollPadding: _pinButton ? 100 : null,
      startValidators: _commonTextValidators(field, additionals: [
        //(String? value) => validators?.dateValidator(value, field.compareDate),
      ]),
      endValidators: _commonTextValidators(field, additionals: [
        //(String? value) => validators?.dateValidator(value, field.compareDate),
        //TODO: add validator for data not earlier
      ]),
      onChanged: (value) => _commonOnChanged(value, field),
    );
  }

  Widget _generateLabelField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    final style = Theme.of(context).textTheme.subtitle1!;
    return SizedBox(
        height: 20,
        child: Text(
          field.label.toUpperCase(),
          style: style.copyWith(color: style.color!.withOpacity(0.32)),
        ));
  }

  Widget _generateScreenResultField(
    BuildContext context,
    ScreenResultField field,
    FocusNode? current,
    FocusNode? next,
  ) {
    final controller = controllers[field.fieldId];

    return StringResultView(
      decoration: widget.decoration,
      current: current,
      next: next,
      style: widget.commonStyle,
      onChanged: (ScreenResultCompositeValue value) {
        _commonOnChanged(value, field);
      },
      controller: controller!,
      field: field,
      validators: _commonTextValidators(field),
    );
  }

  Widget _generateDateField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    final controller = controllers[field.fieldId];
    return DateFieldView(
      decoration: widget.decoration,
      field: field,
      format: field is DateField ? field.format : null,
      current: current,
      next: next,
      style: widget.commonStyle,
      scrollPadding: _pinButton ? 100 : null,
      onChanged: (CompositeValue? value) {
        _commonOnChanged(value, field);
      },
      startDate: field is DateField ? field.startDateBounds : null,
      endDate: field is DateField ? field.endDateBounds : null,
      onDateTimeChanged: (DateTime dateTime) {
        String value;
        try {
          value = (field is DateField && field.format != null
                  ? field.format!
                  : DateFormat(DynamicFormValidators.datePattern))
              .format(dateTime);
        } catch (e) {
          return;
        }

        if (controller is MaskedTextController) {
          controller.updateText(value);
          controller.selection = TextSelection.collapsed(offset: value.length);
        } else {
          controller!.text = value;
        }

        _commonOnChanged(CompositeValue(controller!.text), field);
      },
      validators: _commonTextValidators(field, additionals: [
        (String? value) => validators?.dateValidator(
            value,
            field is! DateField ? null : field.compareDate,
            (field is DateField && field.format != null
                    ? field.format!
                    : DateFormat(DynamicFormValidators.datePattern))
                .pattern),
      ]),
      controller: controller!,
    );
  }

  Widget _generatePasswordField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    return Column(
      children: [
        DynamicTextField(
          decoration: widget.decoration,
          label: field.label,
          context: context,
          field: field,
          current: current,
          required: field.required,
          next: next,
          style: widget.commonStyle,
          maskText: true,
          scrollPadding: _pinButton ? 100 : null,
          onChanged: (value) => _commonOnChanged(value, field),
          controller: controllers[field.fieldId]!,
          validators: _commonTextValidators(field, additionals: [
            if (field is! PasswordField || !field.disableFormatting)
              (String? value) => validators?.passwordValidator(CompositeValue(value ?? '')),
          ]),
        ),
        if (field is PasswordField && field.forgotPasswordBuilder != null)
          field.forgotPasswordBuilder!(context, field) ?? Container()
      ],
    );
  }

  Widget _generateNameField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    return DynamicTextField(
      decoration: widget.decoration,
      context: context,
      label: field.label,
      field: field,
      capitalize: true,
      style: widget.commonStyle,
      next: next,
      current: current,
      scrollPadding: _pinButton ? 100 : null,
      required: field.required,
      validators: _commonTextValidators(field),
      onChanged: (value) => _commonOnChanged(value, field),
      controller: controllers[field.fieldId]!,
    );
  }

  // Widget _generateAttachmentField(
  //   BuildContext context,
  //   Field field,
  //   FocusNode? current,
  //   FocusNode? next,
  // ) {
  //   return fieldGenerator.generateAttachmentField(
  //     context: context,
  //     label: field.label,
  //     field: field,
  //     successText: DFormLocalizations.of(context).localized(DFormLocalizationsId.attachment_added),
  //     onAttached: (String filePath) {
  //       values[field.fieldId] = CompositeValue(filePath);
  //     },
  //     errors: errors,
  //   );
  // }

  Widget _generateCheckboxField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    return CheckboxField(
      field: field,
      onSaved: (value) {
        values[field.fieldId] = CompositeValue(value.toString());
      },
      validator: field.required
          ? (bool? value) {
              value ??= false;
              if (!value) {
                return locale.dynamicFormTranslation.fieldIsRequiredErrorText;
              }
              return null;
            }
          : null,
    );
  }

  Widget _generatePlainTextField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    return DynamicTextField(
      decoration: widget.decoration,
      context: context,
      label: field.label,
      field: field,
      required: field.required,
      style: widget.commonStyle,
      next: next,
      current: current,
      scrollPadding: _pinButton ? 100 : null,
      inputType: TextInputType.text,
      multiline: true,
      validators: _commonTextValidators(field),
      onChanged: (value) => _commonOnChanged(value, field),
      controller: controllers[field.fieldId]!,
    );
  }

  Widget _generateSimpleTextField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    return DynamicTextField(
      decoration: widget.decoration,
      context: context,
      label: field.label,
      field: field,
      required: field.required,
      style: widget.commonStyle,
      next: next,
      current: current,
      scrollPadding: _pinButton ? 100 : null,
      inputType: TextInputType.text,
      validators: _commonTextValidators(field),
      onChanged: (value) => _commonOnChanged(value, field),
      controller: controllers[field.fieldId]!,
    );
  }

  Widget _generateEmailField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    return DynamicTextField(
        decoration: widget.decoration,
        context: context,
        label: field.label,
        field: field,
        next: next,
        scrollPadding: _pinButton ? 100 : null,
        style: widget.commonStyle,
        current: current,
        required: field.required,
        inputType: TextInputType.emailAddress,
        validators: _commonTextValidators(field, additionals: [
          (String? email) => validators?.emailValidator(email),
        ]),
        onChanged: (value) => _commonOnChanged(value, field),
        controller: controllers[field.fieldId]!,
        maskText: field.maskText);
  }

  Widget _generatePhoneField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    final style = widget.commonStyle ??
        Theme.of(context).textTheme.headline6!.copyWith(
            height: 1.1,
            color: field.readOnly
                ? Theme.of(context).colorScheme.onBackground.withOpacity(0.44)
                : Theme.of(context).colorScheme.onBackground);

    final extra = values[field.fieldId]?.extra;

    return PhoneFieldWrapper(
      field: field is PhoneField ? field : null,
      style: style,
      onExtraChanged: (extra) {
        final result = values[field.fieldId];

        if (result?.extra == '+' && extra != '+') {
          controllers[field.fieldId]!.clear();
        } else if (result?.extra != '+' && extra == '+') {
          controllers[field.fieldId + '_simple']!.clear();
        }

        _commonOnChanged(CompositeValue(result?.value ?? '', extra: extra), field);
      },
      child: DynamicTextField(
        decoration: widget.decoration,
        context: context,
        field: field,
        label: field.label,
        next: next,
        current: current,
        scrollPadding: _pinButton ? 100 : null,
        style: style,
        required: field.required,
        inputType: TextInputType.phone,
        validators: _commonTextValidators(
          field,
          additionals: [
            if (extra != '+')
              (value) => validators?.phoneValidator(controllers[field.fieldId]?.text ?? value),
          ],
        ),
        onChanged: (value) {
          final result = values[field.fieldId];

          _commonOnChanged(CompositeValue(value!.value, extra: result?.extra), field);
        },
        controller:
            extra == '+' ? controllers[field.fieldId + '_simple']! : controllers[field.fieldId]!,
        maskText: field.maskText,
      ),
    );
  }

  Widget _generateRadioField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    return RadioButton(
      key: ValueKey<String>(field.fieldId),
      field: field,
      title: field.label,
      initialValue: values[field.fieldId],
      onChanged: (value) {
        _commonOnChanged(value, field);
      },
    );
  }

  Widget _generateNumberField(
      BuildContext context, Field field, FocusNode? current, FocusNode? next) {
    return DynamicTextField(
      decoration: widget.decoration,
      context: context,
      label: field.label,
      field: field,
      required: field.required,
      style: widget.commonStyle,
      next: next,
      current: current,
      scrollPadding: _pinButton ? 100 : null,
      inputType: const TextInputType.numberWithOptions(decimal: true),
      formatters: [
        ReplacementFormatter(toReplace: ',', replaceBy: '.'),
        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
      ],
      validators: _commonTextValidators(
        field,
        additionals: [
          if (validators != null) validators!.numberValidator,
        ],
      ),
      onChanged: (value) => _commonOnChanged(value, field),
      controller: controllers[field.fieldId]!,
    );
  }

  _generateTimeField(BuildContext context, Field field, FocusNode? current, FocusNode? next) {
    final controller = controllers[field.fieldId];
    return DateFieldView(
      decoration: widget.decoration,
      field: field,
      current: current,
      next: next,
      type: CupertinoDatePickerMode.time,
      scrollPadding: _pinButton ? 100 : null,
      onChanged: (CompositeValue? value) {
        _commonOnChanged(value, field);
      },
      onDateTimeChanged: (DateTime dateTime) {
        String value;
        try {
          value = DateFormat(DynamicFormValidators.timePattern).format(dateTime);
        } catch (e) {
          return;
        }

        if (controller is MaskedTextController) {
          controller.updateText(value);
          controller.selection = TextSelection.collapsed(offset: value.length);
        } else {
          controller!.text = value;
        }
        _commonOnChanged(CompositeValue(controller!.text), field);
      },
      validators: _commonTextValidators(field, additionals: [
        (String? value) => validators?.timeValidator(value),
      ]),
      controller: controller!,
    );
  }

  Widget? _generateColorPickcer(
      BuildContext context, Field field, FocusNode? current, FocusNode? next) {
    return ColorPicker(
        field: field,
        onChanged: (color) {
          _commonOnChanged(CompositeValue(color.toString()), field);
        });
  }
}
