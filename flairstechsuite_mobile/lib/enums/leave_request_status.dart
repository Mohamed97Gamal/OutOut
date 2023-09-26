import 'dart:ui';

class LeaveRequestStatus {
  /// The underlying value of this enum member.
  int? value = 0;

  LeaveRequestStatus._internal(this.value);

  static LeaveRequestStatus inProgress = LeaveRequestStatus._internal(0);
  static LeaveRequestStatus approved = LeaveRequestStatus._internal(1);
  static LeaveRequestStatus rejected = LeaveRequestStatus._internal(2);
  static LeaveRequestStatus closed = LeaveRequestStatus._internal(3);
  static LeaveRequestStatus deleted = LeaveRequestStatus._internal(4);
  static LeaveRequestStatus archived = LeaveRequestStatus._internal(5);
  static LeaveRequestStatus failed = LeaveRequestStatus._internal(6);
  static LeaveRequestStatus dismissed = LeaveRequestStatus._internal(7);

  static final List<LeaveRequestStatus> availableValues = [
    inProgress,
    approved,
    rejected,
    closed,
    deleted,
    archived,
    failed,
    dismissed,
  ];

  String get name {
    switch (value) {
      case 0:
        return "In Progress";
      case 1:
        return "Approved";
      case 2:
        return "Rejected";
      case 3:
        return "Closed";
      case 4:
        return "Deleted";
      case 5:
        return "Archived";
      case 6:
        return "Failed";
      case 7:
        return "Dismissed";
      default:
        throw ('Unknown enum value to decode LeaveRequestStatus $value');
    }
  }

  Color get color {
    switch (value) {
      case 0:
        return Color(0xffFFD800);
      case 1:
        return Color(0xff73bfc7);
      case 2:
        return Color(0xffD03827);
      case 3:
        return Color(0xff605C5B);
      case 4:
        return Color(0xff7E0808);
      case 5:
        return Color(0xff2D1ADB);
      case 6:
        return Color(0xffB928C4);
      case 7:
        return Color(0xff000000);
      default:
        throw ('Unknown enum value to decode LeaveRequestStatus $value');
    }
  }

  LeaveRequestStatus.fromJson(dynamic data) {
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
      default:
        throw ('Unknown enum value to decode LeaveRequestStatus : $data');
    }
  }

  static dynamic encode(LeaveRequestStatus data) {
    return data.value;
  }
}
