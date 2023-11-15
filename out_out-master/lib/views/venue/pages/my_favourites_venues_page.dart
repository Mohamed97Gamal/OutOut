import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/view_models/venue/favorite_venue_filteration_request.dart';
import 'package:out_out/data/view_models/venue/venue_summary_response.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/venue/items/my_favorite_venue_card_item.dart';
import 'package:out_out/widgets/loading/custom_paged_list_view.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:provider/provider.dart';

class MyFavoritesVenuesPage extends TabViewItem {
  final RefreshNotifier refreshNotifier = RefreshNotifier();

  MyFavoritesVenuesPage({
    Key? key,
  }) : super(title: "Venues", key: key);

  @override
  Widget build(BuildContext context) {
    return MultipleRefreshable(
      refreshNotifiers: [
        context.read<SearchProvider>().refreshNotifier,
        context.read<MyAccountProvider>().favoriteVenuesRefreshNotifier,
        refreshNotifier,
      ],
      child: CustomPagedListView<VenueSummaryResponse>(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 100.0),
        initPageFuture: (pageKey) async {
          final request = new FavoriteVenueFilterationRequest()..searchQuery = context.read<SearchProvider>().text;
          var venuesResult = await ApiRepo().customersClient.getFavoriteVenues(request, pageKey, 7);
          return venuesResult.result.toPagedList();
        },
        itemBuilder: (context, item, index) {
          return MyFavoriteVenueCardItem(
            venueSummaryResponse: item,
            onFavoriteChanged: (value) => refreshNotifier.refresh(),
          );
        },
      ),
    );
  }
}
