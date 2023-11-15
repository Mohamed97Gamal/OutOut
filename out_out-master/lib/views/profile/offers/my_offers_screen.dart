
import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/view_models/venue_deal/offer_filteration_request.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response.dart';
import 'package:out_out/views/common/tab_view_item.dart';
import 'package:out_out/views/profile/offers/pages/my_offers_page.dart';
import 'package:out_out/views/venue_deal/items/deal_card_item.dart';
import 'package:out_out/views/venue_deal/pages/all_deals_page.dart';
import 'package:out_out/views/venue_deal/pages/upcoming_offers_page.dart';
import 'package:out_out/views/venue_loyalty/pages/my_loyalty_history_page.dart';
import 'package:out_out/widgets/containers/custom_new_scaffold.dart';
import 'package:out_out/widgets/containers/custom_tab_view_scaffold.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:provider/provider.dart';

class MyOffersHistoryScreen extends StatelessWidget {

  MyOffersHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTabViewScaffold(
      items: [
        MyHistoryOffersPage(),
        // UpComingOffersPage(),
      ],
      headerHeight: 100.0,
      searchFieldText: "Search for Deals, Venues",
      header: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          children: [
            HorizontallyPaddedTitleText("My Offers History"),
          ],
        ),
      ),
     
    );
  }
}
