import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/models/enums/my_booking.dart';
import 'package:out_out/data/view_models/event_booking/event_booking_summary_response.dart';
import 'package:out_out/data/view_models/venue_booking/my_booking_filteration_request.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/event_booking/items/my_bookings_event_item.dart';
import 'package:out_out/widgets/loading/custom_paged_list_view.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:provider/provider.dart';

class MyBookingsEventPage extends TabViewItem {
  const MyBookingsEventPage({
    Key? key,
  }) : super(title: "Events", key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleRefreshable(
      refreshNotifiers: [
        context.read<SearchProvider>().refreshNotifier,
        context.read<MyAccountProvider>().eventBookingsRefreshNotifier,
      ],
      child: CustomPagedListView<EventBookingSummaryResponse>(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 100.0),
        initPageFuture: (pageKey) async {
          final request = new MyBookingFilterationRequest()
            ..searchQuery = context.read<SearchProvider>().text
            ..myBooking = MyBooking.recent;

          var bookingsResult = await ApiRepo().customersClient.getMyEventsBookings(pageKey, 7, request);
          return bookingsResult.result.toPagedList();
        },
        itemBuilder: (context, item, index) {
          return MyBookingsEventCardItem(eventBookingSummaryResponse: item);
        },
      ),
    );
  }
}
