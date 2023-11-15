import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/models/enums/my_booking.dart';
import 'package:out_out/data/view_models/event_booking/single_event_booking_ticket_summary_response.dart';
import 'package:out_out/data/view_models/venue_booking/my_booking_filteration_request.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/profile/my_shared_tickets/items/my_shared_ticket_card_item.dart';
import 'package:out_out/widgets/loading/custom_paged_list_view.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:provider/provider.dart';

class MyRecentSharedTicketsPage extends TabViewItem {
  final RefreshNotifier refreshNotifier = RefreshNotifier();

  MyRecentSharedTicketsPage({
    Key? key,
  }) : super(title: "Recent", key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleRefreshable(
      refreshNotifiers: [
        context.read<SearchProvider>().refreshNotifier,
        context.read<MyAccountProvider>().favoriteVenuesRefreshNotifier,
        refreshNotifier,
      ],
      child: CustomPagedListView<SingleEventBookingTicketSummaryResponse>(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 100.0),
        initPageFuture: (pageKey) async {
          final request = new MyBookingFilterationRequest()
            ..searchQuery = context.read<SearchProvider>().text
            ..myBooking = MyBooking.recent;
          var venuesResult = await ApiRepo().customersClient.getMyEventSharedTickets(request, pageKey, 7);
          return venuesResult.result.toPagedList();
        },
        itemBuilder: (context, item, index) {
          return MySharedTicketCardItem(singleEventBookingTicketSummaryResponse: item);
        },
      ),
    );
  }
}
