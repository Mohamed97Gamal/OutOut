import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/view_models/venue_deal/offer_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/utils/date_utils.dart';
import 'package:out_out/widgets/universal_image.dart';

class VenueDealCarouselItem extends StatelessWidget {
  final OfferResponse offerResponse;
  final Function onRedeem;
  final bool isUpcomingOffers;

  const VenueDealCarouselItem({
    required this.offerResponse,
    required this.onRedeem,
    required this.isUpcomingOffers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: Card(
        elevation: 2.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: InkWell(
          onTap: offerResponse.isApplicable
              ? () async {
                  bool redeemed = await Navigation().navToRedeemVenueDealScreen(
                      context,
                      offerResponse: offerResponse);
                  if (redeemed) {
                    onRedeem();
                  }
                }
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: offerResponse.isApplicable
                              ? UniversalImage(IconAssets.offer)
                              : UniversalImage(IconAssets.offer,
                                  color: Colors.grey),
                        ),
                        offerResponse.expiryDate.isToday()
                            ? Text(
                                "Expires Today",
                                style: Theme.of(context).textTheme.caption,
                              )
                            : Text(
                                offerResponse.expiryDate.isTomorrow()
                                    ? "Expires Tomorrow"
                                    : "Expires in ${offerResponse.expiryDate.difference(DateTime.now()).inDays + 1} days",
                                style: Theme.of(context).textTheme.caption,
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: offerResponse.isApplicable
                              ? size.width * .8
                              : size.width * .5,
                          child: Tooltip(
                            message: offerResponse.type.name,
                            child: Text(
                              offerResponse.type.name,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: offerResponse.isApplicable
                                      ? Colors.black
                                      : Colors.grey),
                            ),
                          ),
                        ),
                        if (!offerResponse.isApplicable && isUpcomingOffers)
                          offerResponse.nextAvailableDate != null &&
                                  offerResponse.nextAvailableDate!
                                      .isTodayWithMinutes()
                              ? Text(
                                  "Available Today",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              : Text(
                                  offerResponse.nextAvailableDate!.isTomorrow()
                                      ? "Available Tomorrow"
                                      : (offerResponse.nextAvailableDate!
                                                      .difference(
                                                          DateTime.now())
                                                      .inDays +
                                                  1) ==
                                              1
                                          ? offerResponse.nextAvailableDate!
                                                      .difference(
                                                          DateTime.now())
                                                      .inHours ==
                                                  0
                                              ? "Available in ${offerResponse.nextAvailableDate!.difference(DateTime.now()).inMinutes + 1} minutes"
                                              : "Available in ${offerResponse.nextAvailableDate!.difference(DateTime.now()).inHours} hours"
                                          : "Available in ${offerResponse.nextAvailableDate!.difference(DateTime.now()).inDays + 1} days",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  color: offerResponse.isApplicable
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 3.0),
                  child: Text(
                   !offerResponse.isApplicable
                        ? isUpcomingOffers
                            ? "Redeem"
                            : "Redeemed"
                        : "Redeem",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white, fontSize: 13.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
