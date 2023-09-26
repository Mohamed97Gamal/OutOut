import 'package:cached_network_image/cached_network_image.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_progress_indicator.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  final String? url;

  FullImageScreen({this.url}) : assert((url ?? "").trim().isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return NotificationScaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: url ?? "",
          placeholder: (_, __) => const Center(child: AdaptiveProgressIndicator()),
        ),
      ),
    );
  }
}
