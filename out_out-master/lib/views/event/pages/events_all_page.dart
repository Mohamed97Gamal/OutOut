import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/models/enums/event_filter.dart';
import 'package:out_out/data/view_models/event/event_filteration_request.dart';
import 'package:out_out/data/view_models/event/event_summary_response.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/event/items/event_card_item.dart';
import 'package:out_out/widgets/loading/custom_paged_list_view.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:provider/provider.dart';

class EventsAllPage extends TabViewItem {
  final List<String> filterCategoriesIds;

  const EventsAllPage({
    required this.filterCategoriesIds,
    Key? key,
  }) : super(title: "All", key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleRefreshable(
      refreshNotifiers: [
        context.read<SearchProvider>().refreshNotifier,
        context.read<MyAccountProvider>().refreshNotifier,
        context.read<RefreshNotifier>(),
      ],
      child: CustomPagedListView<EventSummaryResponse>(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 100.0),
        initPageFuture: (pageKey) async {
          final request = new EventFilterationRequest()
            ..searchQuery = context.read<SearchProvider>().text
            ..eventFilter = EventFilter.all
            ..categoriesIds = filterCategoriesIds;
          var eventsResult = await ApiRepo().eventClient.getEvents(request, pageKey, 7);
          return eventsResult.result.toPagedList();
        },
        itemBuilder: (context, item, index) {
          return EventCardItem(eventSummaryResponse: item);
        },
      ),
    );
  }
}
