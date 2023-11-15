import 'package:flutter/material.dart';
import 'package:out_out/assets/image_assets.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/view_models/event_booking/ticket_response.dart';
import 'package:out_out/utils/dynamic_links_utils.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ImageDialog extends StatelessWidget {
  final String image;

  const ImageDialog(this.image);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: QrImageView(
        data: image,
        version: QrVersions.auto,
        gapless: true,
      ),
    );
  }
}

class TicketImageView extends StatelessWidget {
  final TicketResponse ticketResponse;
  final void Function()? onPressed;
  final bool isQrClickable;

  const TicketImageView({
    Key? key,
    required this.ticketResponse,
    required this.onPressed,
    this.isQrClickable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAccountProvider = context.watch<MyAccountProvider>();
    return InkWell(
      onTap: isQrClickable ? null : onPressed,
      child: CustomFutureBuilder<String>(
        initFuture: () async {
          final link = await createLink(
            relativeUrl: ticketResponse.qrCodeRelativeUrl(myAccountProvider.applicationUserResponse.id),
          );
          return link;
        },
        onLoading: (context) {
          return Image.asset(
            ImageAssets.qrImage,
            height: 130,
            width: 140,
          );
        },
        onSuccess: (context, snapshot) {
          final data = snapshot.data;
          if (data != null) {
            return GestureDetector(
              onTap: isQrClickable ? () async => await showDialog(
                  context: context, builder: (_) => ImageDialog(data)) : null,
              child: QrImageView(
                data: data,
                version: QrVersions.auto,
                size: 150.0,
                gapless: true,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
