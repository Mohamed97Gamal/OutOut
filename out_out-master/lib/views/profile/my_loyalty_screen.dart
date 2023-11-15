import 'package:flutter/material.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/venue_loyalty/pages/my_loyalty_history_page.dart';
import 'package:out_out/views/venue_loyalty/pages/my_loyalty_recent_page.dart';
import 'package:out_out/widgets/containers/custom_tab_view_scaffold.dart';
import 'package:out_out/widgets/title_text.dart';

class MyLoyaltyScreen extends StatelessWidget {
  final Widget? header;
  final List<TabViewItem> items;

  const MyLoyaltyScreen({
    Key? key,
    this.header,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTabViewScaffold(
      searchFieldText: "Search Loyalty",
      items: [
        MyLoyaltyRecentPage(),
        MyLoyaltyHistoryPage(),
      ],
      headerHeight: 100.0,
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HorizontallyPaddedTitleText("My Loyalty"),
        ],
      ),
    );
  }
}
