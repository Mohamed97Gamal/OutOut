import 'package:flairstechsuite_mobile/utils/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _kPickerItemHeight = 32.0;
const double _kPickerSheetHeight = 216.0;

class AdaptivePicker<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T> onChanged;
  final T value;
  final String? decorationLabelText;
  final bool withUnderline;
  final bool isDense;

  const AdaptivePicker({
    required this.items,
    required this.onChanged,
    required this.value,
    this.withUnderline = false,
    this.isDense = true,
    this.decorationLabelText,
  });

  @override
  _AdaptivePickerState<T> createState() => _AdaptivePickerState<T>();
}

class _AdaptivePickerState<T> extends State<AdaptivePicker<T?>> {
  FixedExtentScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(
      initialItem: widget.items.indexWhere((i) => i.value == widget.value),
    );
  }

  @override
  void didUpdateWidget(AdaptivePicker<T?> oldWidget) {
    super.didUpdateWidget(oldWidget);
    scrollController = FixedExtentScrollController(
      initialItem: widget.items.indexWhere((i) => i.value == widget.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dropDown = DropdownButton<T?>(
      isExpanded: true,
      isDense: widget.isDense,
      underline: widget.withUnderline ? null : Container(),
      value: widget.value,
      items: widget.items,
      onChanged: widget.onChanged,
    );
    if (isCupertinoTheme) {
      return InkWell(
        onTap: () async {
          showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return _buildBottomPicker(
                CupertinoPicker(
                  scrollController: scrollController,
                  itemExtent: _kPickerItemHeight,
                  backgroundColor: CupertinoColors.white,
                  onSelectedItemChanged: (index) {
                    widget.onChanged(widget.items[index].value);
                  },
                  children: <Widget>[
                    for (final item in widget.items) item.child,
                  ],
                ),
              );
            },
          );
        },
        child: AbsorbPointer(
          child: widget.decorationLabelText != null
              ? InputDecorator(
                  decoration: InputDecoration(
                    labelText: widget.decorationLabelText,
                  ),
                  child: dropDown,
                )
              : dropDown,
        ),
      );
    }
    if (widget.decorationLabelText != null) {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: widget.decorationLabelText,
        ),
        child: dropDown,
      );
    }
    return dropDown;
  }
}

Widget _buildBottomPicker(Widget picker) {
  return Container(
    height: _kPickerSheetHeight,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        // Blocks taps from propagating to the modal sheet and popping.
        onTap: () {},
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    ),
  );
}
