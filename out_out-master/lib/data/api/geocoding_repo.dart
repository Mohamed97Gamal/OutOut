import 'dart:io';

import 'package:geocoding/geocoding.dart';

const availableIsoCountryCode = "ae";

class GeoCodingRepo {
  static final GeoCodingRepo _singleton = GeoCodingRepo._internal();

  factory GeoCodingRepo() => _singleton;

  GeoCodingRepo._internal();

  Future<String?> getAddressName(double lat, double long) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
      final placeMark = placeMarks.firstWhere((address) {
        if (address.isoCountryCode == null) return false;
        final isoCountryCode = address.isoCountryCode!.toLowerCase();
        if (availableIsoCountryCode != isoCountryCode) return false;
        if (Platform.isIOS) {
          bool validsubLocality = address.subLocality?.isNotEmpty ?? false;
          if (!validsubLocality) return false;
        } else {
          bool validStreet = address.street?.isNotEmpty ?? false;
          if (!validStreet) return false;
        }

        return true;
      });

      if (Platform.isIOS) {
        if (placeMark.subLocality == null ||
            placeMark.subLocality!.isEmpty ||
            placeMark.street == null ||
            placeMark.street!.isEmpty) {
          return "${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}";
        } else
          return "${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.country}";
      } else {
        if (placeMark.subAdministrativeArea == null ||
            placeMark.subAdministrativeArea!.isEmpty) {
          return "${placeMark.street}";
        } else
          return "${placeMark.street}, ${placeMark.subAdministrativeArea}";
      }
    } catch (ex) {
      return null;
    }
  }
}
