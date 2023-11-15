import 'dart:io';

import 'package:flutter/material.dart';
import 'package:out_out/views/common/tab_item_header.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/widgets/containers/common/custom_appbar.dart';
import 'package:out_out/widgets/containers/common/custom_bottom_navigation_bar.dart';
import 'package:out_out/widgets/containers/common/custom_search_field.dart';

class CustomTabViewScaffold extends StatefulWidget {
  final List<TabViewItem> items;
  final double headerHeight;
  final double headerBodyOverlapHeight;

  final Widget? header;
  final double bodyRadius;

  final bool showBackButton;
  final bool showChangeLocation;
  final Function()? onFilterPressed;
  final String? searchFieldText;

  const CustomTabViewScaffold({
    Key? key,
    this.header,
    required this.items,
    this.headerHeight = 220.0,
    this.headerBodyOverlapHeight = 0.0,
    this.bodyRadius = 25.0,
    this.showBackButton = true,
    this.showChangeLocation = true,
    this.searchFieldText,
    this.onFilterPressed,
  }) : super(key: key);

  @override
  _CustomTabViewScaffoldState createState() => _CustomTabViewScaffoldState();
}

class _CustomTabViewScaffoldState extends State<CustomTabViewScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showChangeLocation: widget.showChangeLocation,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            top: 0.0,
            child: Stack(
              children: [
                SizedBox(
                  height: widget.headerHeight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (widget.searchFieldText != null)
                          CustomSearchField(
                            searchFieldText: widget.searchFieldText!,
                            onFilterPressed: widget.onFilterPressed,
                          ),
                        if (widget.header != null) Expanded(child: widget.header!),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: widget.headerHeight - widget.headerBodyOverlapHeight,
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
                        Container(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.only(top: 2.0, bottom: widget.bodyRadius + 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (var item in widget.items)
                                TabItemHeader(
                                  isSelected: _selectedIndex,
                                  index: widget.items.indexOf(item),
                                  item: item,
                                  onPressed: () {
                                    setState(() => _selectedIndex = widget.items.indexOf(item));
                                  },
                                ),
                            ],
                          ),
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
