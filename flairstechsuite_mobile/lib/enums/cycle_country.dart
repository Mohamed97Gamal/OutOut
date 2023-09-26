
class CycleCountry {
  /// The underlying value of this enum member.
  int? value = 0;

  CycleCountry._internal(this.value);

  static CycleCountry egypt = CycleCountry._internal(0);
  static CycleCountry canada = CycleCountry._internal(1);
  static CycleCountry poland = CycleCountry._internal(2);
  static CycleCountry usa = CycleCountry._internal(3);

  static final List<CycleCountry> availableValues = [
    egypt,
    canada,
    poland,
    usa,
  ];

  String get name {
    switch (value) {
      case 0:
        return "Egypt";
      case 1:
        return "Canada";
      case 2:
        return "Poland";
      case 3:
        return "USA";
      default:
        throw ('Unknown enum value to decode CycleCountry $value');
    }
  }

  CycleCountry.fromJson(dynamic data) {
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
        throw ('Unknown enum value to decode CycleCountry : $data');
    }
  }

  static dynamic encode(CycleCountry data) {
    return data.value;
  }
}