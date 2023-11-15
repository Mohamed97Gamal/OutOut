import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/data/view_models/event/search_filteration_request.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/event/items/my_favourite_event_card_item.dart';
import 'package:out_out/widgets/loading/custom_paged_list_view.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:provider/provider.dart';

class MyFavouritesEventsPage extends TabViewItem {
  final RefreshNotifier refreshNotifier = RefreshNotifier();

  MyFavouritesEventsPage({
    Key? key,
  }) : super(title: "Events", key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleRefreshable(
      refreshNotifiers: [
        context.read<SearchProvider>().refreshNotifier,
        context.read<MyAccountProvider>().favoriteEventsRefreshNotifier,
        refreshNotifier,
      ],
      child: CustomPagedListView<EventSummaryResponse>(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 100.0),
        initPageFuture: (pageKey) async {
          final request = new SearchFilterationRequest()..searchQuery = context.read<SearchProvider>().text;
          var venuesResult = await ApiRepo().customersClient.getFavoriteEvents(request, pageKey, 7);
          return venuesResult.result.toPagedList();
        },
        itemBuilder: (context, item, index) {
          return MyFavouriteEventCardItem(
            onFavoriteChanged: (value) => refreshNotifier.refresh(),
            eventSummaryResponse: item,
          );
        },
      ),
    );
  }
}
