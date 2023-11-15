class EventFilter {
  /// The underlying value of this enum member.
  int value = 0;

  EventFilter._internal(this.value);

  static EventFilter all = EventFilter._internal(3);
  static EventFilter today = EventFilter._internal(0);
  static EventFilter nearYou = EventFilter._internal(1);
  static EventFilter featuredEvents = EventFilter._internal(2);

  String get name {
    switch (value) {
      case 0:
        return "Today";
      case 1:
        return "Near You";
      case 2:
        return "Featured Events";
      case 3:
        return "all";
      default:
        throw ('Unknown enum value to decode name');
    }
  }
  EventFilter.fromJson(dynamic data) {
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
        throw ('Unknown enum value to decode: $data');
    }
  }

  static dynamic encode(EventFilter data) {
    return data.value;
  }
}
