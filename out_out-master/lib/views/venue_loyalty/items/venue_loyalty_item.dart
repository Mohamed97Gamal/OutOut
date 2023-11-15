import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/view_models/venue_loyalty/loyalty_summary_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/stars.dart';
import 'package:out_out/widgets/universal_image.dart';

class VenueLoyaltyItem extends StatelessWidget {
  final LoyaltySummaryResponse venueLoyaltySummaryResponse;
  final Function onRedeem;

  const VenueLoyaltyItem({
    required this.venueLoyaltySummaryResponse,
    required this.onRedeem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: InkWell(
        onTap: venueLoyaltySummaryResponse.isApplicable
            ? () async {
                bool redeemed = await Navigation().navToRedeemVenueLoyaltyScreen(
                  context,
                  loyaltyVenueId: venueLoyaltySummaryResponse.id,
                );
                if (redeemed) {
                  onRedeem();
                }
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UniversalImage(
                        IconAssets.loyalty,
                        color: venueLoyaltySummaryResponse.isApplicable ? Theme.of(context).primaryColor : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stars(
                            current: venueLoyaltySummaryResponse.starsCount,
                            max: venueLoyaltySummaryResponse.stars.value,
                            isEnabled: venueLoyaltySummaryResponse.isApplicable ? true : false,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            venueLoyaltySummaryResponse.type.name,
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0)),
                    color: venueLoyaltySummaryResponse.isApplicable ? Theme.of(context).primaryColor : Colors.grey,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    venueLoyaltySummaryResponse.canGet ? "Get it" : "Redeem",
                    style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white, fontSize: 15.0),
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
