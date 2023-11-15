import 'package:flutter/material.dart';
import 'package:out_out/views/profile/my_shared_tickets/pages/my_history_shared_tickets_page.dart';
import 'package:out_out/views/profile/my_shared_tickets/pages/my_recent_shared_tickets_page.dart';
import 'package:out_out/widgets/containers/custom_tab_view_scaffold.dart';
import 'package:out_out/widgets/title_text.dart';

class MyEventSharedTicketsScreen extends StatelessWidget {
  const MyEventSharedTicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTabViewScaffold(
      searchFieldText: "Search for Tickets",
      headerHeight: 100.0,
      items: [
        MyRecentSharedTicketsPage(),
        MyHistorySharedTicketsPage(),
      ],
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HorizontallyPaddedTitleText("My Shared Tickets"),
        ],
      ),
    );
  }
}
