import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/stars.dart';
import 'package:out_out/widgets/universal_image.dart';

class MyLoyaltyCardItem extends StatelessWidget {
  final LoyaltyResponse loyaltyResponse;
  final Function onRedeem;
  final bool isnotHistory;

  const MyLoyaltyCardItem({
    Key? key,
    required this.loyaltyResponse,
    required this.onRedeem,
    this.isnotHistory = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: InkWell(
        onTap: isnotHistory
            ? () async {
                await Navigation().navToVenueDetailsScreen(
                  context,
                  venueId: loyaltyResponse.venue.id!,
                );
              }
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: UniversalImage.venue(loyaltyResponse.venue.logo),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            loyaltyResponse.venue.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: 100.0,
                            child: Stars(
                              isEnabled: isnotHistory,
                              current: loyaltyResponse.starsCount,
                              max: loyaltyResponse.stars.value,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      loyaltyResponse.type.name,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: loyaltyResponse.isApplicable && isnotHistory
                            ? () async {
                                bool redeemed = await Navigation().navToRedeemVenueLoyaltyScreen(
                                  context,
                                  loyaltyVenueId: loyaltyResponse.id,
                                );
                                if (redeemed) {
                                  onRedeem();
                                }
                              }
                            : null,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0)),
                            color: loyaltyResponse.isApplicable && isnotHistory
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
                          child: isnotHistory
                              ? Text(
                                  loyaltyResponse.canGet ? "Get it" : "Redeem",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.white, fontSize: 15.0),
                                )
                              : Text(
                                  "Redeemed",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.white, fontSize: 15.0),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
