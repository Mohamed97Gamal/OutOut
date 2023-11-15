import 'package:flutter/material.dart';
import 'package:out_out/widgets/containers/common/custom_appbar.dart';
import 'package:out_out/widgets/containers/common/custom_bottom_navigation_bar.dart';
import 'package:out_out/widgets/containers/common/custom_search_field.dart';

class CustomNewScaffold extends StatelessWidget {
  final double headerHeight;
  final double headerBodyOverlapHeight;

  final Widget? header;
  final Widget? body;
  final List<Widget>? slivers;
  final EdgeInsets bodyPadding;
  final double bodyRadius;
  final String? searchFieldText;
  final bool showBackButton;
  final bool showChangeLocation;
  final Function()? onFilterPressed;

  const CustomNewScaffold({
    Key? key,
    required this.headerHeight,
    this.headerBodyOverlapHeight = 0.0,
    this.header,
    this.body,
    this.slivers,
    this.bodyPadding = EdgeInsets.zero,
    this.bodyRadius = 40.0,
    this.showBackButton = true,
    this.showChangeLocation = true,
    this.onFilterPressed,
    this.searchFieldText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showChangeLocation: showChangeLocation,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                 SizedBox(
                  height: headerHeight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (searchFieldText != null)
                          CustomSearchField(
                            searchFieldText: searchFieldText!,
                            onFilterPressed: onFilterPressed,
                          ),
                        if (header != null) Expanded(child: header!),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: headerHeight - headerBodyOverlapHeight,
                  right: 0.0,
                  left: 0.0,
                  bottom: 0.0,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(bodyRadius),
                        topRight: Radius.circular(bodyRadius),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              if (body != null)
                                Padding(
                                  padding: bodyPadding,
                                  child: body!,
                                ),
                            ],
                          ),
                        ),
                        if (slivers != null) ...slivers!,
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
