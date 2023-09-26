import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flutter/material.dart';

class StaticGoogleMaps extends StatelessWidget {
  final double latitude;
  final double longitude;
  final double zoom;
  final int width;
  final int height;

  const StaticGoogleMaps({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.zoom,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://maps.googleapis.com/maps/api/staticmap?"
      "center=$latitude%2C$longitude&zoom=$zoom&size=${width}x$height&key=${ResourcesUtils.androidGoogleMapsApiKey}",
      width: width.toDouble(),
      height: height.toDouble(),
    );
  }
}
