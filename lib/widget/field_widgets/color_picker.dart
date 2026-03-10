import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/model/dynamic_form_models.dart';
import 'package:flutter_dynamic_form/widget/external/color_picker/color_picker.dart';

import '../../model/color_field.dart';

class ColorPicker extends StatefulWidget {
  final Field field;
  final Function(Color) onChanged;
  const ColorPicker({Key? key, required this.field, required this.onChanged}) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  ValueNotifier<Color> color = ValueNotifier(Colors.white);
  Color? overrideColor;

  @override
  void initState() {
    final field = widget.field;
    if (field is ColorField && field.value != null && int.tryParse(field.value!.value) != null) {
      color.value = Color(int.tryParse(widget.field.value!.value)!);
    }

    overrideColor = field is ColorField ? field.overrideColor : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MaterialButton(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          children: [
            Expanded(
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
                        child: Text(
                      widget.field.label,
                      style: widget.field.customTextStyle,
                    )))),
            const SizedBox(
              width: 24,
            ),
            ValueListenableBuilder<Color>(
                valueListenable: color,
                builder: (context, value, child) {
                  return CircleAvatar(
                    backgroundColor: overrideColor ??
                        (widget.field is ColorField && (widget.field as ColorField).modifier != null
                            ? (widget.field as ColorField).modifier!.call(value)
                            : value),
                    radius: 24,
                  );
                }),
            const SizedBox(
              width: 12,
            )
          ],
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                  maxHeight: 400,
                ),
                child: CircleColorPickerDialog(
                  lockFeature:
                      widget.field is ColorField ? (widget.field as ColorField).lockFeature : null,
                  initialColor: color.value,
                  onChanged: (color) {
                    overrideColor = null;

                    final resultColor =
                        widget.field is ColorField && (widget.field as ColorField).modifier != null
                            ? (widget.field as ColorField).modifier!.call(color)
                            : color;

                    this.color.value = resultColor;

                    widget.onChanged(resultColor);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CircleColorPickerDialog extends StatefulWidget {
  final Function(Color) onChanged;

  final Color initialColor;
  final LockFeature? lockFeature;
  const CircleColorPickerDialog({
    super.key,
    required this.onChanged,
    required this.initialColor,
    this.lockFeature,
  });

  @override
  State<CircleColorPickerDialog> createState() => _CircleColorPickerDialogState();
}

class _CircleColorPickerDialogState extends State<CircleColorPickerDialog> {
  late final controller = CircleColorPickerController(
    initialColor: HSLColor.fromColor(widget.initialColor).toColor(),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: CircleColorPicker(
              lockFeature: widget.lockFeature,
              controller: controller,
              onChanged: widget.onChanged,
              strokeWidth: 16,
              thumbSize: 36,
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.close, color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
