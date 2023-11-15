import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/universal_image.dart';

class DealNearYouCarouselItem extends StatelessWidget {
  final OfferWithVenueResponse offerWithVenueResponse;

  const DealNearYouCarouselItem({
    required this.offerWithVenueResponse,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation().navToVenueDetailsScreen(context, venueId: offerWithVenueResponse.venue.id);
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: UniversalImage.deals(offerWithVenueResponse.image),
          ),
          Positioned(
            top: 0.0,
            left: 8.0,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.white,
              child: UniversalImage.venue(
                offerWithVenueResponse.venue.logo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
