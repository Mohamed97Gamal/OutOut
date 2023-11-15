import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/utils/dynamic_links_utils.dart';
import 'package:out_out/utils/share_utils.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/universal_image.dart';

class ShareVenueButton extends StatelessWidget {
  final String venueId;
  final String venueName;
  final String? venueDescription;
  final String? venueImageUrl;

  ShareVenueButton({
    required this.venueId,
    required this.venueName,
    required this.venueDescription,
    required this.venueImageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: IconButton(
        padding: const EdgeInsets.all(16.0),
        iconSize: 30.0,
        icon: UniversalImage(IconAssets.share),
        onPressed: () async {
          await showFutureProgressDialog(
            context: context,
            initFuture: () async {
              final link = await createDynamicLink(
                relativeUrl: "venues/$venueId",
                title: venueName,
                description: venueDescription,
                imageUrl: venueImageUrl,
                short: true,
              );
              await share(link);
            },
          );
        },
      ),
    );
  }
}
