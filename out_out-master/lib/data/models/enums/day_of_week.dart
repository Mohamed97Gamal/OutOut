class DayOfWeek {
  /// The underlying value of this enum member.
  int value = 0;

  DayOfWeek._internal(this.value);

  static DayOfWeek sunday = DayOfWeek._internal(0);
  static DayOfWeek monday = DayOfWeek._internal(1);
  static DayOfWeek tuesday = DayOfWeek._internal(2);
  static DayOfWeek wednesday = DayOfWeek._internal(3);
  static DayOfWeek thursday = DayOfWeek._internal(4);
  static DayOfWeek friday = DayOfWeek._internal(5);
  static DayOfWeek saturday = DayOfWeek._internal(6);

  bool equalWeekDay(int weekday) {
    if (weekday == 7) {
      return value == 0;
    }
    return value == weekday;
  }

  DayOfWeek.fromJson(dynamic data) {
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
      case 4:
        value = data;
        break;
      case 5:
        value = data;
        break;
      case 6:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode day of week: $data');
    }
  }

  String get name {
    switch (value) {
      case 0:
        return "Sunday";
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      default:
        throw ('Unknown enum value to decode name');
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is DayOfWeek) {
      return other.value == this.value;
    } else if (other is int) {
      return other == this.value;
    }
    return false;
  }

  static final List<DayOfWeek> availableOptions = [
    DayOfWeek.sunday,
    DayOfWeek.monday,
    DayOfWeek.tuesday,
    DayOfWeek.wednesday,
    DayOfWeek.thursday,
    DayOfWeek.friday,
    DayOfWeek.saturday,
  ];

  static List<DayOfWeek> listFromJson(List<dynamic>? json) {
    return json == null ? new List<DayOfWeek>.empty() : json.map((value) => new DayOfWeek.fromJson(value)).toList();
  }

  static dynamic encode(DayOfWeek data) {
    return data.value;
  }
}
