import 'package:flutter/material.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/widgets/containers/common/custom_appbar.dart';
import 'package:out_out/widgets/containers/common/custom_bottom_navigation_bar.dart';
import 'package:out_out/widgets/containers/common/custom_search_field.dart';
import 'package:provider/provider.dart';

class CustomFlatScaffold extends StatelessWidget {
  final Widget? title;
  final Widget? body;
  final List<Widget>? slivers;
  final bool showChangeLocation;
  final bool showBackButton;
  final Function()? onFilterPressed;
  final String? searchFieldText;
  final bool withBottomPadding;
  final Function(String)? onSearchFieldSubmitted;

  CustomFlatScaffold({
    this.title,
    this.body,
    this.slivers,
    this.showChangeLocation = true,
    this.showBackButton = true,
    this.onFilterPressed,
    this.searchFieldText,
    this.withBottomPadding = true,
    this.onSearchFieldSubmitted,
  }) : assert(title == null || !showChangeLocation);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showChangeLocation: showChangeLocation,
        title: title,
        showBackButton: showBackButton,
      ),
      body: Stack(
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      const SizedBox(height: 2.0),
                      if (searchFieldText != null)
                        CustomSearchField(
                          onSearchFieldSubmitted: onSearchFieldSubmitted,
                          searchFieldText: searchFieldText!,
                          onFilterPressed: onFilterPressed,
                        ),
                      if (body != null) body!,
                      //if (context.read<BottomNavigationBarProvider>().show) const SizedBox(height: 100.0),
                    ],
                  ),
                ),
                if (slivers != null) ...slivers!,
                if (context.read<BottomNavigationBarProvider>().show && withBottomPadding)
                  SliverPadding(padding: const EdgeInsets.only(bottom: 150.0)),
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
