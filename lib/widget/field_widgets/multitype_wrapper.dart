import 'package:flutter/material.dart';

import '../../model/multitype_field.dart';
import '../field_widgets/bottom_pick_button.dart';

class MultitypeFieldWrapper extends StatefulWidget {
  final MultitypeField? field;
  final Widget child;
  final Function(String extra)? onExtraChanged;
  final TextStyle style;
  const MultitypeFieldWrapper({
    Key? key,
    this.field,
    required this.child,
    this.onExtraChanged,
    required this.style,
  }) : super(key: key);

  @override
  State<MultitypeFieldWrapper> createState() => MultitypeFieldWrapperState();
}

class MultitypeFieldWrapperState extends State<MultitypeFieldWrapper> {
  String? current;

  @override
  void initState() {
    current = widget.field?.value?.extra ?? widget.field?.types.first;
    super.initState();
  }

  void updateExtra(String extra) {
    current = extra;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.field == null) {
      return widget.child;
    }

    return Row(
      children: [
        Expanded(
          child: widget.child,
        ),
        BottomPickButton(
          text: widget.field!.translations != null ? widget.field!.translations![current!]! : current!,
          style: widget.style.copyWith(fontSize: 18),
          rightArrow: true,
          child: MultitypeBottomView(
            items: widget.field!.types,
            current: current,
            translations: widget.field!.translations,
            onChanged: (code) {
              current = code;
              setState(() {});
              widget.onExtraChanged?.call(code);
            },
          ),
        ),
      ],
    );
  }
}

class MultitypeBottomView extends StatefulWidget {
  final Function(String extra) onChanged;
  final List<String> items;
  final Map<String, String>? translations;
  final String? current;

  const MultitypeBottomView({
    Key? key,
    required this.onChanged,
    required this.items,
    this.current,
    this.translations,
  }) : super(key: key);

  @override
  State<MultitypeBottomView> createState() => _MultitypeBottomViewState();
}

class _MultitypeBottomViewState extends State<MultitypeBottomView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        constraints: const BoxConstraints(maxHeight: 420),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < widget.items.length; i++)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            height: 48,
                            onPressed: () {
                              widget.onChanged(widget.items[i]);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                width: 240,
                                height: 32,
                                decoration: widget.items[i] == widget.current
                                    ? BoxDecoration(
                                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                                        ),
                                      )
                                    : null,
                                child: Center(
                                  child: Text(
                                    widget.translations != null
                                        ? widget.translations![widget.items[i]]!
                                        : widget.items[i],
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: Theme.of(context).colorScheme.onBackground,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (i != widget.items.length - 1)
                      Container(
                        width: 240,
                        height: 0.5,
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                      ),
                  ],
                ),
              const SizedBox(height: 48)
            ],
          ),
        ),
      ),
    );
  }
}
