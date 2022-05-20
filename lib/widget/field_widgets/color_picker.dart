import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_dynamic_form/model/dynamic_form_models.dart';

class ColorPicker extends StatefulWidget {
  final Field field;
  final Function(int) onChanged;
  const ColorPicker({Key? key, required this.field, required this.onChanged}) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MaterialButton(
        padding: const EdgeInsets.only(),
        child: Row(
          children: [
            Expanded(child: Text(widget.field.label)),
            CircleAvatar(
              backgroundColor: color,
              radius: 24,
            ),
            const SizedBox(
              width: 24,
            )
          ],
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => HueCustomRingPicker(
              pickerColor: color,
              portraitOnly: true,
              onColorChanged: (color) {
                setState(() {
                  this.color = color;
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class HueCustomRingPicker extends StatefulWidget {
  const HueCustomRingPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.portraitOnly = false,
    this.colorPickerHeight = 250.0,
    this.hueRingStrokeWidth = 20.0,
    this.enableAlpha = false,
    this.displayThumbColor = true,
    this.pickerAreaBorderRadius = const BorderRadius.all(Radius.zero),
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final bool portraitOnly;
  final double colorPickerHeight;
  final double hueRingStrokeWidth;
  final bool enableAlpha;
  final bool displayThumbColor;
  final BorderRadius pickerAreaBorderRadius;

  @override
  _HueCustomRingPickerState createState() => _HueCustomRingPickerState();
}

class _HueCustomRingPickerState extends State<HueCustomRingPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);

  @override
  void initState() {
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
    super.initState();
  }

  @override
  void didUpdateWidget(HueCustomRingPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  void onColorChanging(HSVColor color) {
    setState(() => currentHsvColor = HSVColor.fromAHSV(1.0, color.hue, 1.0, 1.0));
    widget.onColorChanged(currentHsvColor.toColor());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipOval(
          //borderRadius: widget.pickerAreaBorderRadius,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  SizedBox(
                    width: widget.colorPickerHeight,
                    height: widget.colorPickerHeight,
                    child: ColorPickerHueRing(
                      currentHsvColor,
                      onColorChanging,
                      displayThumbColor: widget.displayThumbColor,
                      strokeWidth: 28,
                    ),
                  ),
                  ColorIndicator(currentHsvColor),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
