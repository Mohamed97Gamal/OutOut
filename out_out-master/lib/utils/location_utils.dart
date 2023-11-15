import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:out_out/widgets/popups/adaptive_alert_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator_android/geolocator_android.dart';

// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<LatLng?> getCurrentLocation(
  BuildContext context, {
  LocationAccuracy locationAccuracy = LocationAccuracy.high,
  Function? onServiceDisabled,
  Function? onPermissonDenied,
  Function? onPermissonPermenantlyDenied,
}) async {
  try {
    bool serviceEnabled;
    LocationPermission permission;
    bool isAndroid = Platform.isAndroid;

    // Test if location services are enabled.
   
    serviceEnabled = isAndroid
        ? await Permission.locationWhenInUse.serviceStatus.isEnabled
        : await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      if (onServiceDisabled != null) {
        onServiceDisabled();
        return null;
      }
      await showAdaptiveAlertDialog(
        context: context,
        icon: Icon(Icons.error),
        title: "Location",
        content: "Location services are disabled.",
      );
      return null;
    }

    permission = isAndroid
        ? await GeolocatorAndroid().checkPermission()
        : await Geolocator.checkPermission();
        
    if (permission == LocationPermission.denied) {
      permission = isAndroid
          ? await GeolocatorAndroid().requestPermission()
          : await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        if (onPermissonDenied != null) {
          onPermissonDenied();
          return null;
        }
        await showAdaptiveAlertDialog(
          context: context,
          icon: Icon(Icons.error),
          title: "Location",
          content: "Location permissions are denied.",
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      if (onPermissonPermenantlyDenied != null) {
        onPermissonPermenantlyDenied();
        return null;
      }
      await showAdaptiveAlertDialog(
        context: context,
        icon: Icon(Icons.error),
        title: "Location",
        content:
            "Location permissions are permanently denied, we cannot request permissions.",
      );
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
     Position position = isAndroid
        ? await GeolocatorAndroid().getCurrentPosition(
            locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high,
          ))
        : await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(position.latitude, position.longitude);
  } catch (e) {
    if (onServiceDisabled != null) {
      onServiceDisabled();
      return null;
    }
    await showAdaptiveAlertDialog(
      context: context,
      icon: Icon(Icons.error),
      title: "Location",
      content: "Location services are disabled.",
    );
    return null;
  }
}
