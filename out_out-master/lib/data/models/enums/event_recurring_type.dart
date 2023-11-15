class EventRecurringType {
  int value = 0;

  EventRecurringType._internal(this.value);

  static EventRecurringType number0_ = EventRecurringType._internal(0);
  static EventRecurringType number1_ = EventRecurringType._internal(1);

  EventRecurringType.fromJson(dynamic data) {
    switch (data) {
      case 0:
        value = data;
        break;
      case 1:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode: $data');
    }
  }

  static dynamic encode(EventRecurringType data) {
    return data.value;
  }
}
