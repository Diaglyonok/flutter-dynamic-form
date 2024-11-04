import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

const double _kSelectionHandleRadius = 6;
const double _kSelectionHandleOverlap = 1.5;

class _CupertinoTextSelectionHandlePainter extends CustomPainter {
  const _CupertinoTextSelectionHandlePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const double halfStrokeWidth = 1.0;
    final Paint paint = Paint()..color = color;
    final Rect circle = Rect.fromCircle(
      center: const Offset(_kSelectionHandleRadius, _kSelectionHandleRadius),
      radius: _kSelectionHandleRadius,
    );
    final Rect line = Rect.fromPoints(
      const Offset(
        _kSelectionHandleRadius - halfStrokeWidth,
        2 * _kSelectionHandleRadius - _kSelectionHandleOverlap,
      ),
      Offset(_kSelectionHandleRadius + halfStrokeWidth, size.height),
    );
    final Path path = Path()
      ..addOval(circle)
      // Draw line so it slightly overlaps the circle.
      ..addRect(line);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CupertinoTextSelectionHandlePainter oldPainter) => color != oldPainter.color;
}

class ColoredCupertinoControlls extends CupertinoTextSelectionControls {
  final Color color;

  ColoredCupertinoControlls(this.color);

  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type, double textLineHeight, [VoidCallback? onTap]) {
    // iOS selection handles do not respond to taps.
    final Size desiredSize;
    final Widget handle;

    final Widget customPaint = CustomPaint(
      painter: _CupertinoTextSelectionHandlePainter(color),
    );

    // [buildHandle]'s widget is positioned at the selection cursor's bottom
    // baseline. We transform the handle such that the SizedBox is superimposed
    // on top of the text selection endpoints.
    switch (type) {
      case TextSelectionHandleType.left:
        desiredSize = getHandleSize(textLineHeight);
        handle = SizedBox.fromSize(
          size: desiredSize,
          child: customPaint,
        );
        return handle;
      case TextSelectionHandleType.right:
        desiredSize = getHandleSize(textLineHeight);
        handle = SizedBox.fromSize(
          size: desiredSize,
          child: customPaint,
        );
        return Transform(
          transform: Matrix4.identity()
            ..translate(desiredSize.width / 2, desiredSize.height / 2)
            ..rotateZ(math.pi)
            ..translate(-desiredSize.width / 2, -desiredSize.height / 2),
          child: handle,
        );
      // iOS should draw an invisible box so the handle can still receive gestures
      // on collapsed selections.
      case TextSelectionHandleType.collapsed:
        return SizedBox.fromSize(size: getHandleSize(textLineHeight));
    }
  }
}

TextSelectionControls getControls(BuildContext context) => Platform.isIOS
    ? ColoredCupertinoControlls(Theme.of(context).colorScheme.secondary)
    : MaterialTextSelectionControls();
