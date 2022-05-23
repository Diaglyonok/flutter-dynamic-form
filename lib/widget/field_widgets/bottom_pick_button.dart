import 'package:dglk_flutter_dev_kit/bottom_sheet/src/bottom_sheet_route.dart';
import 'package:flutter/material.dart';

class BottomPickButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Widget child;
  final bool rightArrow;
  final Function()? customOnTap;

  const BottomPickButton({
    Key? key,
    required this.text,
    this.style,
    required this.child,
    this.customOnTap,
    this.rightArrow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        right: !rightArrow ? 8.0 : 0.0,
        left: !rightArrow ? 0.0 : 8.0,
      ),
      child: Container(
        constraints: const BoxConstraints(minWidth: 64),
        child: InkWell(
          // elevation: 0,
          // color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
          // padding: const EdgeInsets.only(),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: !rightArrow ? 4.0 : 10.0),
                if (!rightArrow)
                  Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: !rightArrow ? 8.0 : 4.0),
                  child: Center(
                    child: Text(
                      text,
                      style: style,
                    ),
                  ),
                ),
                if (rightArrow)
                  Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              ],
            ),
          ),
          onTap: customOnTap ??
              () {
                Navigator.of(context).push(
                  BottomSheetRoute(child: child),
                );
              },
        ),
      ),
    );
  }
}
