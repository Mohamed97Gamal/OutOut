class ReminderType {
  int value = 0;

  ReminderType._internal(this.value);

  static ReminderType twentyFourHoursBefore = ReminderType._internal(1);
  static ReminderType sixHoursBefore = ReminderType._internal(2);

  String get name {
    switch (value) {
      case 1:
        return " in 24 Hours";
      case 2:
        return "in 6 hours";
      default:
        throw ('Unknown enum value to decode name');
    }
  }

  static final List<ReminderType> availableOptions = [
    ReminderType.twentyFourHoursBefore,
    ReminderType.sixHoursBefore,
  ];

  int get inHours {
    switch (value) {
      case 1:
        return 24;
      case 2:
        return 6;
      default:
        throw ('Unknown enum value to decode in hours');
    }
  }

  ReminderType.fromJson(dynamic data) {
    switch (data) {
      case 1:
        value = data;
        break;
      case 2:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode Reminder Type: $data');
    }
  }

  static List<ReminderType> listFromJson(List<dynamic>? json) {
    return json == null
        ? new List<ReminderType>.empty()
        : json.map((value) => new ReminderType.fromJson(value)).toList();
  }

  static dynamic encode(ReminderType data) {
    return data.value;
  }

  @override
  bool operator ==(Object other) {
    print("equal is getting called");
    if (other is ReminderType) {
      return this.value == other.value;
    }
    return false;
  }
}
