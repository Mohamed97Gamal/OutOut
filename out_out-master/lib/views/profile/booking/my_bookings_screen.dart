import 'package:flutter/material.dart';
import 'package:out_out/views/event_booking/pages/my_bookings_event_page.dart';
import 'package:out_out/views/profile/booking/my_bookings_history_page.dart';
import 'package:out_out/views/venue_booking/pages/my_bookings_venue_page.dart';
import 'package:out_out/widgets/containers/custom_tab_view_scaffold.dart';
import 'package:out_out/widgets/title_text.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTabViewScaffold(
      searchFieldText: "Search Bookings",
      items: [
        MyBookingsVenuePage(),
        MyBookingsEventPage(),
        MyBookingsHistoryPage(),
      ],
      headerHeight: 100.0,
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HorizontallyPaddedTitleText("My Bookings"),
        ],
      ),
    );
  }
}
