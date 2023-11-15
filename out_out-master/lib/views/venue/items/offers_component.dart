import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/venue_deal/offer_response.dart';
import 'package:out_out/views/venue_deal/items/venue_deal_carousel_item.dart';
import 'package:out_out/widgets/custom_carousel.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/title_text.dart';

class OffersComponent extends StatelessWidget {
  final List<OfferResponse> offers;
  final RefreshNotifier refreshNotifier;
  final String titleText;
  final String emptyOffersText;
  final bool isUpcomingOffers;
  const OffersComponent(
      {Key? key,
      required this.offers,
      required this.refreshNotifier,
      required this.titleText,
      this.isUpcomingOffers = false,
      required this.emptyOffersText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HorizontallyPaddedTitleText(titleText),
        const SizedBox(height: 8.0),
        offers.isEmpty
            ? Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    emptyOffersText,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : CustomCarousel(
                aspectRatio: 2.5,
                withCards: false,
                showIndicator: false,
                items: [
                  for (final offerResponse in offers)
                    VenueDealCarouselItem(
                      isUpcomingOffers: isUpcomingOffers,
                      offerResponse: offerResponse,
                      onRedeem: () => refreshNotifier.refresh(),
                    ),
                ],
              ),
      ],
    );
  }
}
