import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/models/enums/venue_time_filter.dart';
import 'package:out_out/data/view_models/venue/venue_filteration_request.dart';
import 'package:out_out/data/view_models/venue/venue_summary_response.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/venue/items/venue_card_item.dart';
import 'package:out_out/widgets/loading/custom_paged_list_view.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class VenuesOpenNowPage extends TabViewItem {
  final List<String> filterCategoriesIds;

  VenuesOpenNowPage({
    required this.filterCategoriesIds,
    Key? key,
  }) : super(title: "Open Now", key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleRefreshable(
      refreshNotifiers: [
        context.read<SearchProvider>().refreshNotifier,
        context.read<MyAccountProvider>().refreshNotifier,
        context.read<RefreshNotifier>(),
      ],
      child: CustomPagedListView<VenueSummaryResponse>(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 100.0),
        initPageFuture: (pageKey) async {
          final request = new VenueFilterationRequest()
            ..searchQuery = context.read<SearchProvider>().text
            ..timeFilter = VenueTimeFilter.open_now
            ..typesIds = []
            ..categoriesIds = filterCategoriesIds;
          var venuesResult =
              await ApiRepo().venueClient.getVenues(request, pageKey, 7);

          return venuesResult.result.toPagedList();
        },
        itemBuilder: (context, item, index) {
          return VenueCardItem(
            venueSummaryResponse: item,
            isOpenNowTab: true,
            // isSearchFilter: true,
            dateTime: DateTime.now(),
          );
        },
      ),
    );
  }
}
