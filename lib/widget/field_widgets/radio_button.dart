import 'package:flutter/material.dart';

import '../../model/dynamic_form_models.dart';

class RadioButton extends StatefulWidget {
  final Field field;
  final Function(CompositeValue) onChanged;
  final String title;
  final CompositeValue? initialValue;

  const RadioButton({
    Key? key,
    required this.field,
    required this.onChanged,
    required this.title,
    required this.initialValue,
  }) : super(key: key);

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  CompositeValue? value;

  @override
  void initState() {
    value = widget.initialValue ?? CompositeValue(widget.field.options?.first.value ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        Text(widget.title,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Theme.of(context).colorScheme.onBackground)),
        const SizedBox(
          height: 8,
        ),
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _getList())
      ],
    );
  }

  List<Widget> _getList() {
    List<Widget> _getButtons(Option option) {
      return [
        Expanded(
            child: ToggleButton(
          height: 40,
          textSelected: option.value!,
          selected: (value?.value == option.value),
          onChange: (changedValue) {
            if (changedValue != null && changedValue is bool && changedValue) {
              value = CompositeValue(option.value!);
              setState(() {});
              widget.onChanged(value!);
            }
            FocusScope.of(context).unfocus();
          },
        )),
        if (option != widget.field.options?.last)
          const SizedBox(
            width: 16,
          )
      ];
    }

    return [for (Option option in widget.field.options ?? []) ..._getButtons(option)];
  }
}

class ToggleButton extends StatelessWidget {
  final Function onChange;
  final String textSelected;
  final String? textUnselected;
  final bool selected;
  final double borderRadiusValue;
  final double height;
  final double padding;
  const ToggleButton(
      {Key? key,
      required this.textSelected,
      this.textUnselected,
      this.borderRadiusValue = 8.0,
      this.height = 48.0,
      this.padding = 16.0,
      required this.selected,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.button!.copyWith(fontSize: 16);
    var borderRadius = BorderRadius.circular(borderRadiusValue);
    Widget selectedWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        borderRadius: borderRadius,
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.background.withOpacity(0.2),
          highlightColor: Theme.of(context).colorScheme.background.withOpacity(0.2),
          borderRadius: borderRadius,
          onTap: () {
            onChange(false);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Center(
              child: Text(
                textSelected,
                textAlign: TextAlign.center,
                semanticsLabel: textSelected,
                textScaleFactor: 1.0,
                style: textStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
        ),
      ),
    );
    Widget notSelectedWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.background.withOpacity(0.2),
          highlightColor: Theme.of(context).colorScheme.background.withOpacity(0.2),
          borderRadius: borderRadius,
          onTap: () {
            onChange(true);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Center(
              child: Text(
                textUnselected ?? textSelected,
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                semanticsLabel: textUnselected ?? textSelected,
                style: textStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
        ),
      ),
    );

    return ToggleWidget(
        notSelectedWidet: notSelectedWidget, selectedWidget: selectedWidget, selected: selected);
  }
}

class ToggleWidget extends StatelessWidget {
  final Widget selectedWidget;
  final Widget notSelectedWidet;
  final bool selected;

  const ToggleWidget({
    Key? key,
    required this.selectedWidget,
    required this.notSelectedWidet,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        duration: const Duration(milliseconds: 200),
        crossFadeState: selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: selectedWidget,
        secondChild: notSelectedWidet);
  }
}
