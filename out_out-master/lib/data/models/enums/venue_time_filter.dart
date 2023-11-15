class VenueTimeFilter {
  /// The underlying value of this enum member.
  int value = 0;

  VenueTimeFilter._internal(this.value);

  static VenueTimeFilter all = VenueTimeFilter._internal(0);
  static VenueTimeFilter open_now = VenueTimeFilter._internal(1);
  static VenueTimeFilter deals_now = VenueTimeFilter._internal(2);
  static VenueTimeFilter near_you = VenueTimeFilter._internal(3);
  String get name {
    switch (value) {
      case 0:
        return "number0_";
      case 1:
        return "number1_";
      case 2:
        return "number2_";
      case 2:
        return "number3_";
      default:
        throw ('Unknown enum value to decode name');
    }
  }

  VenueTimeFilter.fromJson(dynamic data) {
    switch (data) {
      case 0:
        value = data;
        break;
      case 1:
        value = data;
        break;
      case 2:
        value = data;
        break;
      case 3:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode Venue Time Filter: $data');
    }
  }

  static dynamic encode(VenueTimeFilter data) {
    return data.value;
  }
}
