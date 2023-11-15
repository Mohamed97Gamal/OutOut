class VenueBookingStatus {
  int value = 0;

  VenueBookingStatus._internal(this.value);

  static VenueBookingStatus pending = VenueBookingStatus._internal(0);
  static VenueBookingStatus approved = VenueBookingStatus._internal(1);
  static VenueBookingStatus rejected = VenueBookingStatus._internal(2);
  static VenueBookingStatus cancelled = VenueBookingStatus._internal(3);

  @override
  bool operator ==(Object other) {
    if (other is VenueBookingStatus) {
      return other.value == value;
    }
    return false;
  }

  String get name {
    switch (value) {
      case 0:
        return "Pending";
      case 1:
        return "Approved";
      case 2:
        return "Rejected";
      case 3:
        return "Cancelled";
      default:
        throw ('Unknown enum value to decode name');
    }
  }

  VenueBookingStatus.fromJson(dynamic data) {
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
        throw ('Unknown enum value to decode Venue Booking Status: $data');
    }
  }

  static dynamic encode(VenueBookingStatus data) {
    return data.value;
  }
}
