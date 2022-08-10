import 'package:flutter/material.dart';

class InfoWrapper extends StatelessWidget {
  final Function()? infoCallback;
  final bool shouldShow;
  final Widget? child;
  const InfoWrapper({super.key, this.child, this.infoCallback, required this.shouldShow});

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return const SizedBox();
    }

    return Stack(
      children: [
        child!,
        if (infoCallback != null && shouldShow)
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 4.0,
                      ),
                      child: IconButton(
                        splashRadius: 20,
                        padding: const EdgeInsets.only(),
                        onPressed: infoCallback!,
                        icon: Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
      ],
    );
  }
}
