
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';

class ClientProfileMood {
  /// The underlying value of this enum member.
  int? value;

  static final List<ClientProfileMood> availableOptions = List.unmodifiable(
    [
      good,
      moderate,
      bad,
    ],
  );

  ClientProfileMood._internal(this.value);

  static ClientProfileMood moderate = ClientProfileMood._internal(0);
  static ClientProfileMood good = ClientProfileMood._internal(1);
  static ClientProfileMood bad = ClientProfileMood._internal(-1);

  ClientProfileMood.fromJson(dynamic data) {
    switch (data) {
      case 0:
        value = data;
        break;
      case 1:
        value = data;
        break;
      case -1:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode: $data');
    }
  }

  String get asset {
    if (value == -1) {
      return ResourcesUtils.faceBad;
    } else if (value == 0) {
      return ResourcesUtils.faceModerate;
    } else if (value == 1) {
      return ResourcesUtils.faceGood;
    }
    return ResourcesUtils.faceNone;
  }

  static dynamic encode(ClientProfileMood data) {
    return data.value;
  }

  @override
  int get hashCode {
    return value.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (other is ClientProfileMood) {
      return other.value == value;
    }
    return false;
  }
}
