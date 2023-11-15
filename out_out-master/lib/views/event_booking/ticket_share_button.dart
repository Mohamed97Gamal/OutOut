import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/event/single_event_occurrence_response.dart';
import 'package:out_out/data/view_models/event_booking/share_ticket_request.dart';
import 'package:out_out/utils/dynamic_links_utils.dart';
import 'package:out_out/utils/share_utils.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_error_dialog.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/src/provider.dart';

class TicketShareButton extends StatelessWidget {
  final SingleEventOccurrenceResponse singleEventOccurrenceResponse;
  final int ticketNumber;

  const TicketShareButton({
    Key? key,
    required this.singleEventOccurrenceResponse,
    required this.ticketNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAccountProvider = context.watch<MyAccountProvider>();
    return Material(
      shape: CircleBorder(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: IconButton(
        padding: const EdgeInsets.all(16.0),
        iconSize: 30.0,
        icon: UniversalImage(
          IconAssets.share,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () async {
          var result = await showFutureProgressDialog<BooleanOperationResult>(
            context: context,
            initFuture: () async {
              final request = new ShareTicketRequest()
                ..ticketId = singleEventOccurrenceResponse.booking!.tickets[ticketNumber].id
                ..ticketSecret = singleEventOccurrenceResponse.booking!.tickets[ticketNumber].secret;

              return await ApiRepo().eventClient.isTicketShareable(request);
            },
          );
          if (result != null && result.status) {
            await showFutureProgressDialog(
              context: context,
              initFuture: () async {
                final link = await createDynamicLink(
                  relativeUrl: singleEventOccurrenceResponse.booking!.tickets[ticketNumber].qrCodeRelativeUrl(myAccountProvider.applicationUserResponse.id),
                  title: singleEventOccurrenceResponse.name,
                  description: "Redeem Your Ticket On OutOut",
                  imageUrl: singleEventOccurrenceResponse.image,
                  short: true,
                );
                await share(link);
              },
            );
          } else {
            await showAdaptiveErrorDialog(
              context: context,
              title: "Error",
              content: result?.errorMessage ?? "Unknown Error",
            );
          }
        },
      ),
    );
  }
}
