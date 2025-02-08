import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/i18n/strings.g.dart';
import 'package:flutter_dynamic_form/model/dynamic_form_models.dart';
import 'package:flutter_dynamic_form/model/link_field.dart';
import 'package:flutter_dynamic_form/widget/field_widgets/text_field.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ListLinksFieldView extends StatefulWidget {
  final List<LinkField> initialList;
  final Widget? customAddButton;
  final FocusNode? current;
  final FocusNode? next;
  final TextStyle? commonStyle;
  final InputDecoration? decoration;

  final double? scrollPadding;
  final bool required;

  final void Function(CompositeValue? value)? onChanged;
  final String? Function(String?)? Function(Field field, {List<String? Function(String?)>? additionals})?
      validatorsFunc;

  final TextEditingController controller;

  const ListLinksFieldView({
    super.key,
    required this.initialList,
    required this.current,
    required this.next,
    required this.controller,
    this.customAddButton,
    this.commonStyle,
    this.decoration,
    this.scrollPadding,
    this.onChanged,
    this.validatorsFunc,
    this.required = false,
  });

  @override
  State<ListLinksFieldView> createState() => _ListLinksFieldViewState();
}

class _LinkViewParams {
  final LinkField field;
  final FocusNode? node;
  final TextEditingController controller;

  const _LinkViewParams({
    required this.field,
    required this.node,
    required this.controller,
  });
}

class _ListLinksFieldViewState extends State<ListLinksFieldView> {
  late final List<_LinkViewParams> fields = [];

  @override
  void initState() {
    for (int i = 0; i < widget.initialList.length; i++) {
      fields.add(
        _LinkViewParams(
          controller: TextEditingController(text: widget.initialList[i].value?.value ?? ''),
          field: widget.initialList[i],
          node: i == 0 ? widget.current : FocusNode(),
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        fields.length,
        (index) {
          final field = fields[index];

          return LinkView(
            field: field.field,
            current: field.node,
            next: index + 1 == fields.length ? widget.next : fields[index + 1].node,
            controller: field.controller,
            commonStyle: widget.commonStyle,
            decoration: widget.decoration,
            scrollPadding: widget.scrollPadding,
            onChanged: (value) {
              final list = fields.map((e) => e == field ? (value?.value ?? '') : e.controller.text).toList();

              widget.controller.text = list.toString();
              widget.onChanged?.call(CompositeValue(widget.controller.text, extra: jsonEncode(list)));
            },
            validatorsFunc: widget.validatorsFunc?.call(field.field),
          );
        },
      )..add(Padding(
          padding: const EdgeInsets.only(top: 8),
          child: widget.customAddButton ??
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        final nextIndex = fields.length + 1;
                        final newItem = _LinkViewParams(
                          controller: TextEditingController(),
                          field: LinkField(
                            required: widget.required,
                            fieldId: 'internal_$nextIndex',
                            label: '${context.t.link} $nextIndex',
                            customTextStyle: widget.commonStyle,
                          ),
                          node: FocusNode(),
                        );

                        fields.add(newItem);
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        child: Center(
                          child: Text(context.t.addLink),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        )),
    );
  }
}

class LinkView extends StatelessWidget {
  final LinkField field;

  final FocusNode? current;
  final FocusNode? next;
  final TextStyle? commonStyle;
  final InputDecoration? decoration;

  final double? scrollPadding;

  final TextEditingController controller;

  final void Function(CompositeValue? value)? onChanged;
  final String? Function(String?)? validatorsFunc;

  const LinkView({
    super.key,
    required this.field,
    this.current,
    this.next,
    this.commonStyle,
    this.decoration,
    this.scrollPadding,
    required this.controller,
    this.onChanged,
    this.validatorsFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: DynamicTextField(
              decoration: decoration,
              multiline: field.multiline,
              context: context,
              label: field.label,
              field: field,
              capitalizeType: TextCapitalization.none,
              style: commonStyle,
              next: next,
              current: current,
              inputType: TextInputType.url,
              scrollPadding: scrollPadding,
              required: field.required,
              validators: validatorsFunc,
              onChanged: onChanged,
              controller: controller,
              suffixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(0.0),
                      child: field.customCloseIcon ??
                          Icon(
                            Icons.close,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      onPressed: () {
                        controller.clear();
                        onChanged?.call(CompositeValue(''));
                      },
                    ),
                  ),
                ],
              )),
        ),
        if (controller.text.isNotEmpty)
          SizedBox(
            width: 40,
            height: 40,
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(),
              child: Center(
                child: field.customOpenIcon ??
                    Icon(
                      Icons.open_in_new,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              onPressed: () async {
                String link = controller.text;

                if (!link.startsWith('http')) {
                  link = 'https://$link';
                }

                if (!(await canLaunchUrlString(link))) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.t.wrongLinkSnack)));
                  return;
                }

                await launchUrlString(link);
              },
            ),
          )
      ],
    );
  }
}
