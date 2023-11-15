class LoyaltyTimeFilter {
  int value = 0;

  LoyaltyTimeFilter._internal(this.value);

  static LoyaltyTimeFilter recent = LoyaltyTimeFilter._internal(0);
  static LoyaltyTimeFilter history = LoyaltyTimeFilter._internal(1);

  LoyaltyTimeFilter.fromJson(dynamic data) {
    switch (data) {
      case 0:
        value = data;
        break;
      case 1:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode Loyalty Time Filter: $data');
    }
  }

  static dynamic encode(LoyaltyTimeFilter data) {
    return data.value;
  }
}
