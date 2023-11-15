import 'package:flutter/material.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/widgets/containers/common/custom_bottom_navigation_bar.dart';
import 'package:out_out/widgets/containers/common/tab_history_item_header.dart';

class CustomHistoryTabsScaffold extends StatefulWidget {
  final List<TabViewItem> items;
  final double headerBodyOverlapHeight;

  final Widget? header;
  final double bodyRadius;

  final bool showBackButton;
  final bool showChangeLocation;
  final Function()? onFilterPressed;
  final String? searchFieldText;

  const CustomHistoryTabsScaffold({
    Key? key,
    this.header,
    required this.items,
    this.headerBodyOverlapHeight = 0.0,
    this.bodyRadius = 25.0,
    this.showBackButton = true,
    this.showChangeLocation = true,
    this.searchFieldText,
    this.onFilterPressed,
  }) : super(key: key);

  @override
  _CustomHistoryTabsScaffoldState createState() => _CustomHistoryTabsScaffoldState();
}

class _CustomHistoryTabsScaffoldState extends State<CustomHistoryTabsScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            top: 0.0,
            child: Stack(
              children: [
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  left: 0.0,
                  bottom: 0.0,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.bodyRadius),
                        topRight: Radius.circular(widget.bodyRadius),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (var item in widget.items)
                              TabHistoryItemHeader(
                                isSelected: _selectedIndex,
                                index: widget.items.indexOf(item),
                                item: item,
                                onPressed: () {
                                  setState(() => _selectedIndex = widget.items.indexOf(item));
                                },
                              ),
                          ],
                        ),
                        Positioned.fill(
                          top: 52.0,
                          child: Card(
                            elevation: 2.0,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(widget.bodyRadius),
                                topRight: Radius.circular(widget.bodyRadius),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              key: ValueKey(_selectedIndex.hashCode),
                              children: [
                                Expanded(
                                  child: widget.items[_selectedIndex],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            left: 0.0,
            bottom: 0.0,
            child: CustomBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}
