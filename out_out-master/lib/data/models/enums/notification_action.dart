class NotificationAction {
  int value = 0;

  NotificationAction._internal(this.value);

  static NotificationAction notSpecified = NotificationAction._internal(0);
  static NotificationAction venueBookingReminder =
      NotificationAction._internal(1);
  static NotificationAction eventBookingReminder =
      NotificationAction._internal(2);
  static NotificationAction newVenueInYourArea =
      NotificationAction._internal(3);
  static NotificationAction newEvent = NotificationAction._internal(4);
  static NotificationAction newOffer = NotificationAction._internal(5);
  static NotificationAction notUsingAppInAWhile =
      NotificationAction._internal(6);
  static NotificationAction venueBookingConfirmation =
      NotificationAction._internal(7);
  static NotificationAction venueBookingRejection =
      NotificationAction._internal(8);
  static NotificationAction ticketTransfer = NotificationAction._internal(9);
  static NotificationAction eventBookingRejection =
      NotificationAction._internal(10);
  static NotificationAction deactivateLoyalty =
      NotificationAction._internal(11);
  static NotificationAction deactivateDeal = NotificationAction._internal(12);
  static NotificationAction deactivateVenue = NotificationAction._internal(13);

  String get name {
    switch (value) {
      case 0:
        return "NotSpecified";
      case 1:
        return "VenueBookingReminder";
      case 2:
        return "EventBookingReminder";
      case 3:
        return "newVenueInYourArea";
      case 4:
        return "NewEvent";
      case 5:
        return "NewOffer";
      case 6:
        return "NotUsingAppInAWhile";
      case 7:
        return "VenueBookingConfirmation";
      case 8:
        return "VenueBookingRejection";
      case 9:
        return "TicketTransfer";
      case 10:
        return "EventBookingRejection";
      case 11:
        return "DeactivateLoyalty";
      case 12:
        return "DeactivateDeal";
      case 13:
        return "DeactivateVenue";
      default:
        throw ('Unknown enum value to decode name');
    }
  }

  NotificationAction.fromJson(dynamic data) {
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
      case 7:
        value = data;
        break;
      case 8:
        value = data;
        break;
      case 9:
        value = data;
        break;
      case 10:
        value = data;
        break;
      case 11:
        value = data;
        break;
      case 12:
        value = data;
        break;
      case 13:
        value = data;
        break;
      default:
        value = 0;
        break;
    }
  }

  static dynamic encode(NotificationAction data) {
    return data.value;
  }
}
