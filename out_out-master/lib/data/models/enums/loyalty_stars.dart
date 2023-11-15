class LoyaltyStars {
  int value = 0;

  LoyaltyStars._internal(this.value);

  static LoyaltyStars number5_ = LoyaltyStars._internal(5);
  static LoyaltyStars number10_ = LoyaltyStars._internal(10);

  LoyaltyStars.fromJson(dynamic data) {
    switch (data) {
      case 5:
        value = data;
        break;
      case 10:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode Loyalty Stars: $data');
    }
  }

  static dynamic encode(LoyaltyStars data) {
    return data.value;
  }
}
