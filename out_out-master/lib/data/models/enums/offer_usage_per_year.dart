class OfferUsagePerYear {
  /// The underlying value of this enum member.
  int value = 3;

  OfferUsagePerYear._internal(this.value);

  static OfferUsagePerYear three_times = OfferUsagePerYear._internal(3);
  static OfferUsagePerYear five_times = OfferUsagePerYear._internal(5);

  OfferUsagePerYear.fromJson(dynamic data) {
    switch (data) {
      case 3:
        value = data;
        break;
      case 5:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode OfferUsagePerYear: $data');
    }
  }

  static dynamic encode(OfferUsagePerYear data) {
    return data.value;
  }
}
