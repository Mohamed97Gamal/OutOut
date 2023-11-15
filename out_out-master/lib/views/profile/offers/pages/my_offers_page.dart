import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/view_models/venue_deal/history_offer_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_filteration_request.dart';
import 'package:out_out/data/view_models/venue_deal/offer_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_response_page_operation_result.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/profile/offers/widgets/my_offers_card_item.dart';
import 'package:out_out/views/venue_deal/items/deal_card_item.dart';
import 'package:out_out/widgets/loading/custom_paged_list_view.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';
import 'package:out_out/widgets/loading/refreshable.dart';

import 'package:provider/provider.dart';

class MyHistoryOffersPage extends TabViewItem {
  const MyHistoryOffersPage({Key? key})
      : super(title: "Offers Usage History", key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleRefreshable(
      refreshNotifiers: [
        context.read<SearchProvider>().refreshNotifier,
        context.read<MyAccountProvider>().refreshNotifier,
      ],
      child: CustomPagedListView<HistoryOfferResponse>(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 100.0),
        initPageFuture: (pageKey) async {
          final request = new OfferFilterationRequest()
            ..searchQuery = context.read<SearchProvider>().text
            ..sortBy = 0;
          var dealsResult = await ApiRepo()
              .offerClient
              .getAllUpcomingOffers(request, pageKey, 7);

          return dealsResult.result.toPagedList();
        },
        itemBuilder: (context, item, index) {
          return OfferCardItem(
            offerResponse: item,
            dateTime: DateTime.now(),
          );
        },
      ),
    );
  }
}
