import 'package:flutter/widgets.dart';

class FieldWrapper extends StatefulWidget {
  final bool withBottomPadding;
  final Widget? child;

  const FieldWrapper({Key? key, required this.child, this.withBottomPadding = true}) : super(key: key);

  @override
  _FieldWrapperState createState() => _FieldWrapperState();
}

class _FieldWrapperState extends State<FieldWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.child == null) {
      return const SizedBox();
    }
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, widget.withBottomPadding ? 16 : 0),
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
