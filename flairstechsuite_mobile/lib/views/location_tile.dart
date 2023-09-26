import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationTile extends StatefulWidget {
  final LocationDTO location;
  final Widget? trailing;
  final Widget? bottom;

  LocationTile({
    required this.location,
    this.trailing,
    this.bottom,
  });

  @override
  _LocationTileState createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsetsDirectional.only(start: 48.0),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          Text(
            "Longitude: ${widget.location.longitude}",
            style: theme.textTheme.subtitle2,
          ),
          const SizedBox(height: 4.0),
          Text(
            "Latitude: ${widget.location.latitude}",
            style: theme.textTheme.subtitle2,
          ),
          const SizedBox(height: 4.0),
          Card(
            elevation: 2.0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: AspectRatio(
                aspectRatio: 2.3,
                child: GoogleMap(
                  tiltGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  scrollGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                    zoom: 25,
                    target: LatLng(widget.location.latitude!, widget.location.longitude!),
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("id"),
                      position: LatLng(widget.location.latitude!, widget.location.longitude!),
                    ),
                  },
                ),
              ),
            ),
          ),
          if (widget.bottom != null) const SizedBox(height: 8.0),
          if (widget.bottom != null) widget.bottom!,
        ],
        onExpansionChanged: (isExpanded) {
          setState(() => this.isExpanded = isExpanded);
        },
        trailing: widget.trailing,
        title: Row(
          children: [
            Icon(
              isExpanded ? Icons.indeterminate_check_box : Icons.add_box,
              color: theme.textTheme.subtitle1!.color,
              size: 20,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                widget.location.name!,
                style: theme.textTheme.subtitle1!
                    .copyWith(color: MyColors.lightGrayColor),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
