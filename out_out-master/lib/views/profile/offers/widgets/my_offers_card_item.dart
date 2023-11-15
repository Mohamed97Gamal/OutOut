import 'package:flutter/material.dart';
import 'package:out_out/data/view_models/venue_deal/history_offer_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_with_venue_response.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/views/venue/items/venue_card_item.dart';
import 'package:out_out/widgets/universal_image.dart';

class OfferCardItem extends StatelessWidget {
  final HistoryOfferResponse offerResponse;
  final DateTime dateTime;
  const OfferCardItem({
    Key? key,
    required this.offerResponse,
    required this.dateTime,
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
      child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: UniversalImage.venue(offerResponse.image),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              offerResponse.type.name,
                          maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                            ),
                          ),
                          ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        offerResponse.venue.name,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                      ),
                        const SizedBox(height: 10.0),
                         Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(10.0)),
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 3.0),
                      child: Text(
                      offerResponse.count == 1
                      ? "Redeemed ${offerResponse.count} Time"
                            : "Redeemed ${offerResponse.count} Times",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                  // offerResponse.count == 1
                  //     ? Text("Redeemed ${offerResponse.count} Time")
                  //     : Text("Redeemed ${offerResponse.count} Times"),

                  // const SizedBox(height: 8.0),
                ],
              ),
              ),
            ),
          ],
        ),
      
    );
  }
}
