import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/view_models/home/home_page_filteration_request.dart';
import 'package:out_out/data/view_models/home/home_page_response.dart';
import 'package:out_out/views/event/items/event_card_item.dart';
import 'package:out_out/views/venue/items/venue_card_item.dart';
import 'package:out_out/views/venue_deal/items/deal_card_item.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:provider/provider.dart';
import 'package:out_out/utils/date_utils.dart';
import 'package:intl/intl.dart';

class SearchFilterResultScreen extends StatelessWidget {
  final HomePageFilterationRequest homePageFilterationRequest;
  final DateTime dateTime;
  const SearchFilterResultScreen(
      {Key? key,
      required this.homePageFilterationRequest,
      required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFlatScaffold(
      body: MultipleRefreshable(
        refreshNotifiers: [
          context.read<MyAccountProvider>().refreshNotifier,
        ],
        child: CustomFutureBuilder<HomePageResponse>(
          initFuture: () async {
            var searchResult = await ApiRepo()
                .homeScreenClient
                .homeSearchFilter(homePageFilterationRequest);

            return searchResult.result;
          },
          onSuccess: (context, snapshot) {
            final result = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: TitleText("Events"),
                ),
                const SizedBox(height: 10.0),
                if (result.events!.isEmpty)
                  Center(
                    child: Text("Your search has no results."),
                  ),
                for (final eventSummaryResponse in result.events!)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: EventCardItem(
                        eventSummaryResponse: eventSummaryResponse),
                  ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: TitleText("Venues"),
                ),
                const SizedBox(height: 10.0),
                if (result.venues!.isEmpty)
                  Center(
                    child: Text("Your search has no results."),
                  ),
                for (final venueSummaryResponse in result.venues!)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: VenueCardItem(
                        venueSummaryResponse: venueSummaryResponse,
                        isSearchFilter: true,
                        // isOpenNowTab: true,
                        dateTime: dateTime),
                  ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: TitleText("Deals"),
                ),
                const SizedBox(height: 10.0),
                if (result.offers!.isEmpty)
                  Center(
                    child: Text("Your search has no results."),
                  ),
                for (final offerWithVenueResponse in result.offers!)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DealCardItem(
                        offerWithVenueResponse: offerWithVenueResponse,
                        dateTime: dateTime),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
