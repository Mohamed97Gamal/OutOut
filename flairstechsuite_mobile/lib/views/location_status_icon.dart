import 'package:flairstechsuite_mobile/enums/location_status.dart';
import 'package:flutter/material.dart';

class LocationStatusIcon extends StatelessWidget {
  final LocationStatus? status;
  final bool colored;

  LocationStatusIcon(
    this.status, {
    this.colored = true,
  }) : assert(colored != null && status != null);

  @override
  Widget build(BuildContext context) {
    final color = colored ? status.color : Colors.black;
    IconData? iconData;
    switch (status) {
      case LocationStatus.pending:
        iconData = Icons.remove;
        break;
      case LocationStatus.approved:
        iconData = Icons.check;
        break;
      case LocationStatus.rejected:
        iconData = Icons.close;
        break;
    }
    return CircleAvatar(
      radius: 10.0,
      backgroundColor: color,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(iconData, color: Colors.white, size: 14),
      ),
    );
  }
}
