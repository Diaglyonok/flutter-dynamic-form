import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/widget/field_widgets/color_picker.dart';
import 'package:intl/intl.dart';

import '../flutter_dynamic_form.dart';
import '../i18n/dynamic_form_localizations.g.dart' as locale;
import '../logic/dynamic_form_validators.dart';
import '../utils/form_utils.dart';
import '../utils/masked_text_controller.dart';
import '../widget/field_widgets/checkbox_field.dart';
import '../widget/field_widgets/radio_button.dart';
import '../widget/field_widgets/string_result_field.dart';
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

  const DynamicForm({
    Key? key,
    this.title,
    this.validationOptions,
    this.scrollController,
    this.physics,
    this.submitBtn,
    required this.fields,
    this.commonStyle,
    this.hint,
    this.allowPinnedButton = false,
    this.titlePadding,
    this.allowFullZip = false,
    this.useBaseLocale = false,
  }) : super(key: key);
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
  final additionalNodes = <String, FocusNode>{};

  @override
  void initState() {
    super.initState();
    validators = DynamicFormValidators(
      widget.validationOptions,
      allowFullZip: _allowFullZip,
    );
    _allowFullZip = widget.allowFullZip ?? false;
    _initFieldData();
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
                padding: const EdgeInsets.only(top: 16.0, bottom: 20),
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
                                child: _generateField(field, current, next, ctxt));
                    }
                  } else {
                    return (index == itemsCount - 1 && widget.submitBtn != null)
                        ? _pinButton
                            ? Container(height: 40)
                            : (widget.submitBtn ?? Container())
                        : FieldWrapper(
                            key: ValueKey<String>(field!.fieldId),
                            child: _generateField(field, current, next, ctxt),
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

  void _initFieldData() {
    for (var field in widget.fields) {
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
          final controller = MaskedTextController(mask: '00/00/0000');
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
          controllers[field.fieldId]!.selection =
              TextSelection.collapsed(offset: field.value?.value.length ?? 0);
          break;

        case FieldTypes.RadioOptions:
          values[field.fieldId] = field.value ?? CompositeValue(field.options?.first.value ?? '');
          break;

        case FieldTypes.Number:
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

          additionalNodes[field.fieldId] = FocusNode(debugLabel: field.label);
          break;
      }

      nodes.add(FocusNode(debugLabel: field.label));
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
    if (autoUpdateValue != null && (values[field.fieldId] == null)) {
      values[field.fieldId] = autoUpdateValue.copyWith(autoUpdated: true);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        controllers[field.fieldId]?.text = autoUpdateValue.value;
      });
    } else if (autoUpdateValue == null && (values[field.fieldId]?.autoUpdated ?? false)) {
      values.remove(field.fieldId);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
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

  _commonOnChanged(CompositeValue? value, String fieldId) {
    if (value == null) {
      values.remove(fieldId);
    } else {
      values[fieldId] = value;
    }

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

  Widget _generateDatePeriod(
    BuildContext context,
    PeriodField field,
    FocusNode? current,
    FocusNode? next,
  ) {
    final extra = field.extra;

    final startController = controllers[field.fieldId + '_start'];
    final endController = controllers[field.fieldId + '_end'];

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
    return Row(
      children: [
        Expanded(
          child: DateField(
            field: field,
            current: current,
            next: additionalNodes[field.fieldId],
            format: extra.format,
            style: style,
            type: extra.type ?? CupertinoDatePickerMode.date,
            customLabel: field.label,
            pickType: extra.pickType ?? PickType.SuffixGetter,
            scrollPadding: _pinButton ? 100 : null,
            onChanged: (CompositeValue? value) {
              if (value == null) {
                values.remove(field.fieldId);
                return;
              }
              values[field.fieldId] =
                  CompositeValue(startController?.text ?? value.value, extra: endController?.text);
              setState(() {});
            },
            onDateTimeChanged: (DateTime dateTime) {
              String value;
              try {
                value = (extra.format ?? DateFormat(DynamicFormValidators.datePattern))
                    .format(dateTime);
              } catch (e) {
                return;
              }

              if (startController is MaskedTextController) {
                startController.updateText(value);
                startController.selection = TextSelection.collapsed(offset: value.length);
              } else {
                startController!.text = value;
              }
              values[field.fieldId] =
                  CompositeValue(startController!.text, extra: endController?.text);
              setState(() {});
            },
            validators: _commonTextValidators(field, additionals: [
              //(String? value) => validators?.dateValidator(value, field.compareDate),
            ]),
            controller: startController!,
            endDate: endDate,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: DateField(
            field: field,
            current: additionalNodes[field.fieldId],
            next: next,
            style: style,
            format: extra.format,
            type: extra.type ?? CupertinoDatePickerMode.date,
            customLabel: extra.secondLabel ?? field.label,
            pickType: extra.pickType ?? PickType.SuffixGetter,
            scrollPadding: _pinButton ? 100 : null,
            onChanged: extra.pickType == PickType.FieldTap
                ? null
                : (CompositeValue? value) {
                    if (value == null) {
                      values.remove(field.fieldId);
                      return;
                    }
                    values[field.fieldId] = CompositeValue(startController.text,
                        extra: endController?.text ?? value.value);
                    setState(() {});
                  },
            onDateTimeChanged: (DateTime dateTime) {
              String value;
              try {
                value = (extra.format ?? DateFormat(DynamicFormValidators.datePattern))
                    .format(dateTime);
              } catch (e) {
                return;
              }

              if (endController is MaskedTextController) {
                endController.updateText(value);
                endController.selection = TextSelection.collapsed(offset: value.length);
              } else {
                endController!.text = value;
              }
              values[field.fieldId] =
                  CompositeValue(startController.text, extra: endController?.text);
              setState(() {});
            },
            validators: _commonTextValidators(field, additionals: [
              //(String? value) => validators?.dateValidator(value, field.compareDate),
              //TODO: add validator for data not earlier
            ]),
            controller: endController!,
            startDate: startDate,
          ),
        ),
      ],
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
      current: current,
      next: next,
      style: widget.commonStyle,
      onChanged: (ScreenResultCompositeValue value) {
        values[field.fieldId] = value;
        setState(() {});
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
    return DateField(
      field: field,
      current: current,
      next: next,
      style: widget.commonStyle,
      scrollPadding: _pinButton ? 100 : null,
      onChanged: (CompositeValue? value) {
        if (value == null) {
          values.remove(field.fieldId);
          return;
        }
        values[field.fieldId] = value;
        setState(() {});
      },
      onDateTimeChanged: (DateTime dateTime) {
        String value;
        try {
          value = DateFormat(DynamicFormValidators.datePattern).format(dateTime);
        } catch (e) {
          return;
        }

        if (controller is MaskedTextController) {
          controller.updateText(value);
          controller.selection = TextSelection.collapsed(offset: value.length);
        } else {
          controller!.text = value;
        }
        values[field.fieldId] = CompositeValue(controller!.text);
        setState(() {});
      },
      validators: _commonTextValidators(field, additionals: [
        (String? value) => validators?.dateValidator(value, field.compareDate),
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
    return DynamicTextField(
      label: field.label,
      context: context,
      field: field,
      current: current,
      next: next,
      style: widget.commonStyle,
      maskText: true,
      scrollPadding: _pinButton ? 100 : null,
      onChanged: (value) => _commonOnChanged(value, field.fieldId),
      controller: controllers[field.fieldId]!,
      validators: _commonTextValidators(field, additionals: [
        (String? value) => validators?.dateValidator(value, field.compareDate),
        (String? value) => validators?.passwordValidator(CompositeValue(value ?? '')),
      ]),
    );
  }

  Widget _generateNameField(
    BuildContext context,
    Field field,
    FocusNode? current,
    FocusNode? next,
  ) {
    return DynamicTextField(
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
      onChanged: (value) => _commonOnChanged(value, field.fieldId),
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
      onChanged: (value) => _commonOnChanged(value, field.fieldId),
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
      onChanged: (value) => _commonOnChanged(value, field.fieldId),
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
        onChanged: (value) => _commonOnChanged(value, field.fieldId),
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
    return PhoneFieldWrapper(
      field: field is PhoneField ? field : null,
      style: style,
      onExtraChanged: (extra) {
        final result = values[field.fieldId];
        values[field.fieldId] = CompositeValue(result?.value ?? '', extra: extra);
        setState(() {});
      },
      child: DynamicTextField(
        context: context,
        field: field,
        label: field.label,
        next: next,
        current: current,
        scrollPadding: _pinButton ? 100 : null,
        style: style,
        required: field.required,
        inputType: TextInputType.phone,
        validators: _commonTextValidators(field, additionals: [
          (value) => validators?.phoneValidator(controllers[field.fieldId]?.text ?? value),
        ]),
        onChanged: (value) => _commonOnChanged(value, field.fieldId),
        controller: controllers[field.fieldId]!,
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
        values[field.fieldId] = value;
        setState(() {});
      },
    );
  }

  Widget _generateNumberField(
      BuildContext context, Field field, FocusNode? current, FocusNode? next) {
    return DynamicTextField(
      context: context,
      label: field.label,
      field: field,
      required: field.required,
      style: widget.commonStyle,
      next: next,
      current: current,
      scrollPadding: _pinButton ? 100 : null,
      inputType: TextInputType.number,
      validators: _commonTextValidators(field),
      onChanged: (value) => _commonOnChanged(value, field.fieldId),
      controller: controllers[field.fieldId]!,
    );
  }

  _generateTimeField(BuildContext context, Field field, FocusNode? current, FocusNode? next) {
    final controller = controllers[field.fieldId];
    return DateField(
      field: field,
      current: current,
      next: next,
      type: CupertinoDatePickerMode.time,
      scrollPadding: _pinButton ? 100 : null,
      onChanged: (CompositeValue? value) {
        if (value == null) {
          values.remove(field.fieldId);
          return;
        }
        values[field.fieldId] = value;
        setState(() {});
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
        values[field.fieldId] = CompositeValue(controller!.text);
        setState(() {});
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
          final parsedColor = Color(color);
        });
  }
}
