import 'package:flutter/material.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/event_booking/pages/my_bookings_event_history_page.dart';
import 'package:out_out/views/venue_booking/pages/my_bookings_venue_history_page.dart';
import 'package:out_out/widgets/containers/custom_history_tabs_scaffold.dart';

class MyBookingsHistoryPage extends TabViewItem {
  const MyBookingsHistoryPage({
    Key? key,
  }) : super(title: "History", key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHistoryTabsScaffold(
      items: [
        MyBookingsVenueHistoryPage(),
        MyBookingsEventHistoryPage(),
      ],
    );
  }
}
