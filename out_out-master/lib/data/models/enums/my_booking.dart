class MyBooking {
  int value = 0;

  MyBooking._internal(this.value);

  static MyBooking recent = MyBooking._internal(0);
  static MyBooking history = MyBooking._internal(1);

  MyBooking.fromJson(dynamic data) {
    switch (data) {
      case 0:
        value = data;
        break;
      case 1:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode My Booking: $data');
    }
  }

  static dynamic encode(MyBooking data) {
    return data.value;
  }
}
