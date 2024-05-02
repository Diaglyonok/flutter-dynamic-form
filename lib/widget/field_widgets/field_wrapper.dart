import 'package:flutter/widgets.dart';
import 'package:flutter_dynamic_form/model/dynamic_form_models.dart';

class FieldWrapper extends StatefulWidget {
  final bool withBottomPadding;
  final Widget? child;
  final Field field;

  const FieldWrapper({
    Key? key,
    required this.child,
    this.withBottomPadding = true,
    required this.field,
  }) : super(key: key);

  @override
  _FieldWrapperState createState() => _FieldWrapperState();
}

class _FieldWrapperState extends State<FieldWrapper> with AutomaticKeepAliveClientMixin {
  Widget Function({required Widget child, required BuildContext context}) get customWrapper =>
      widget.field.wrapper ??
      ({required child, required context}) {
        return child;
      };

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.child == null) {
      return const SizedBox();
    }

    return customWrapper(
      context: context,
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, widget.withBottomPadding ? 16 : 0),
        child: widget.child,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
