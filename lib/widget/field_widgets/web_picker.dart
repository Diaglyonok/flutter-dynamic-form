import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WebPicker extends StatefulWidget {
  final double itemExtent;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double pickerHeight;
  final int initialItem;
  final ValueChanged<int>? onSelectedItemChanged;

  const WebPicker({
    Key? key,
    required this.itemExtent,
    required this.itemBuilder,
    required this.itemCount,
    required this.pickerHeight,
    this.initialItem = 0,
    this.onSelectedItemChanged,
  }) : super(key: key);

  @override
  State<WebPicker> createState() => _WebPickerState();
}

class _WebPickerState extends State<WebPicker> {
  late ScrollController _controller;
  late int _selectedItem;
  late double _pickerHeight;
  late double _itemExtent;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialItem;
    _pickerHeight = widget.pickerHeight;
    _itemExtent = widget.itemExtent;
    _controller = ScrollController(
      initialScrollOffset: _selectedItem * _itemExtent,
    );
    _controller.addListener(_handleScroll);
  }

  void _handleScroll() {
    final currentIndex = (_controller.offset / _itemExtent).round().clamp(0, widget.itemCount - 1);
    if (currentIndex != _selectedItem) {
      setState(() => _selectedItem = currentIndex);
      widget.onSelectedItemChanged?.call(currentIndex);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleScroll);
    _controller.dispose();
    super.dispose();
  }

  void _snapToNearestItem() {
    final nearestIndex = (_controller.offset / _itemExtent).round().clamp(0, widget.itemCount - 1);
    final targetOffset = nearestIndex * _itemExtent;
    _controller.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction == ScrollDirection.idle) {
          _snapToNearestItem();
        }
        return false;
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onPanUpdate: (details) {
              _controller.jumpTo(
                _controller.offset - details.delta.dy,
              );
              _snapToNearestItem();
            },
            child: ListView.builder(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.itemCount + 2, // +2 empty items
              itemBuilder: (context, index) {
                if (index == 0 || index == widget.itemCount + 1) {
                  return SizedBox(height: (_pickerHeight / 2) - (_itemExtent / 2));
                }
                final realIndex = index - 1;
                final isSelected = realIndex == _selectedItem;
                return SizedBox(
                  height: _itemExtent,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: isSelected
                          ? Theme.of(context).textTheme.titleLarge!
                          : Theme.of(context).textTheme.bodyLarge!,
                      child: widget.itemBuilder(context, realIndex),
                    ),
                  ),
                );
              },
            ),
          ),
          IgnorePointer(
            child: Container(
              height: _itemExtent,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.grey.withOpacity(0.5)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
