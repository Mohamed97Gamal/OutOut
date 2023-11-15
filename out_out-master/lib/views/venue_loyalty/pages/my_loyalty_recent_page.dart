import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
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

class MyLoyaltyRecentPage extends TabViewItem {
  final RefreshNotifier refreshNotifier = RefreshNotifier();

  MyLoyaltyRecentPage({
    Key? key,
  }) : super(title: "Recent", key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleRefreshable(
      refreshNotifiers: [
        context.read<SearchProvider>().refreshNotifier,
        context.read<MyAccountProvider>().venueLoyaltyRefreshNotifier,
        refreshNotifier,
      ],
      child: CustomPagedListView<LoyaltyResponse>(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 100.0),
        initPageFuture: (pageKey) async {
          final request = new LoyaltyFilterationRequest()
            ..searchQuery = context.read<SearchProvider>().text
            ..timeFilter = LoyaltyTimeFilter.recent;
          var recentResult = await ApiRepo().customersClient.getMyLoyalty(request, pageKey, 7);
          return recentResult.result.toPagedList();
        },
        itemBuilder: (context, item, index) {
          return MyLoyaltyCardItem(
            loyaltyResponse: item,
            onRedeem: () => refreshNotifier.refresh(),
          );
        },
      ),
    );
  }
}
