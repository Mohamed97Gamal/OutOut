import 'package:cached_network_image/cached_network_image.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:flutter/material.dart';

class AnnouncementNetworkImage extends StatelessWidget {
  final String? url;
  const AnnouncementNetworkImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (_, __) => const Center(child: AdaptiveProgressIndicator()),
      errorWidget: (context, _, __) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.error),
                  const SizedBox(height: 4.0),
                  Text("Something went wrong", textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        );
      },
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      imageUrl: url!,
    );
  }
}
