import 'package:flutter/material.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/widgets/containers/common/adaptive_back_button.dart';
import 'package:out_out/widgets/containers/common/change_location.dart';
import 'package:out_out/widgets/containers/common/corners.dart';
import 'package:out_out/widgets/containers/common/custom_bottom_navigation_bar.dart';
import 'package:out_out/widgets/containers/common/custom_search_field.dart';
import 'package:provider/provider.dart';

class CustomScaffold extends StatelessWidget {
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
final bool showArrowBG;
  const CustomScaffold({
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
    this.showArrowBG = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (showChangeLocation)
            Positioned(
              top: -65.0,
              right: -60.0,
              child: RightCornerCut(),
            ),
          if (!showChangeLocation)
            Positioned(
              top: -65.0,
              left: -60.0,
              child: LeftCornerCut(),
            ),
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
                        if (header != null) Expanded(child: header!),
                        if (searchFieldText != null)
                          CustomSearchField(
                            searchFieldText: searchFieldText!,
                            onFilterPressed: onFilterPressed,
                          ),
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
                        if (context.read<BottomNavigationBarProvider>().show)
                          SliverPadding(padding: const EdgeInsets.only(bottom: 100.0)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 32.0,
            right: 0.0,
            left: 8.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                (showBackButton && Navigator.canPop(context))
                    ? AdaptiveBackButton(
                        showArrowBG: showArrowBG,
                      )
                    : const SizedBox(width: 16.0),
                if (showChangeLocation)
                  Expanded(
                    child: ChangeLocation(padding: EdgeInsets.zero),
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
