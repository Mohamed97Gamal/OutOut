import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/models/enums/loyalty_time_filter.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_filteration_request.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_response.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/venue_loyalty/items/my_loyalty_card_item.dart';
import 'package:out_out/widgets/loading/custom_paged_list_view.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:provider/provider.dart';

class MyLoyaltyHistoryPage extends TabViewItem {
  final RefreshNotifier refreshNotifier = RefreshNotifier();

  MyLoyaltyHistoryPage({
    Key? key,
  }) : super(title: "History", key: key);

  Widget build(BuildContext context) {
    return MultipleRefreshable(
      refreshNotifiers: [
        context.read<SearchProvider>().refreshNotifier,
        refreshNotifier,
      ],
      child: CustomPagedListView<LoyaltyResponse>(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 100.0),
        initPageFuture: (pageKey) async {
          final request = new LoyaltyFilterationRequest()
            ..searchQuery = context.read<SearchProvider>().text
            ..timeFilter = LoyaltyTimeFilter.history;
          var recentResult = await ApiRepo().customersClient.getMyLoyalty(request, pageKey, 7);
          return recentResult.result.toPagedList();
        },
        itemBuilder: (context, item, index) {
          return MyLoyaltyCardItem(
            isnotHistory: false,
            loyaltyResponse: item,
            onRedeem: () => refreshNotifier.refresh(),
          );
        },
      ),
    );
  }
}
