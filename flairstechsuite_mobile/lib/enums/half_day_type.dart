class HalfDayType {
  /// The underlying value of this enum member.
  int? value = 0;

  HalfDayType._internal(this.value);

  static HalfDayType firstHalfDay = HalfDayType._internal(0);
  static HalfDayType secondHalfDay = HalfDayType._internal(1);

  static final List<HalfDayType> availableValues = [
    firstHalfDay,
    secondHalfDay,
  ];

  String get name {
    switch (value) {
      case 0:
        return "First Half-day";
      case 1:
        return "Second Half-day";

      default:
        throw ('Unknown enum value to decode ItemStatusEnum $value');
    }
  }

  HalfDayType.fromJson(dynamic data) {
    switch (data) {
      case 0:
        value = data;
        break;
      case 1:
        value = data;
        break;

      default:
        throw ('Unknown enum value to decode ItemStatusEnum : $data');
    }
  }

  static dynamic encode(HalfDayType data) {
    return data.value;
  }
}
