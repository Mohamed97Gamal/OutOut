class LeaveRequestType {
  /// The underlying value of this enum member.
  int? value = 0;

  LeaveRequestType._internal(this.value);

  static LeaveRequestType annualLeave = LeaveRequestType._internal(0);
  static LeaveRequestType sickLeave = LeaveRequestType._internal(1);
  static LeaveRequestType emergencyLeave = LeaveRequestType._internal(2);
  static LeaveRequestType allocation = LeaveRequestType._internal(3);
  static LeaveRequestType militaryLeave = LeaveRequestType._internal(4);
  static LeaveRequestType maternityLeave = LeaveRequestType._internal(5);
  static LeaveRequestType bereavementLeave = LeaveRequestType._internal(6);
  static LeaveRequestType balanceManagement = LeaveRequestType._internal(7);
  static LeaveRequestType noShow = LeaveRequestType._internal(8);
  static LeaveRequestType halfDayLeave = LeaveRequestType._internal(9);
  static LeaveRequestType other = LeaveRequestType._internal(10);


  static final List<LeaveRequestType> availableValues = [
    annualLeave,
    sickLeave,
    emergencyLeave,
    halfDayLeave,
    allocation,
    militaryLeave,
    maternityLeave,
    bereavementLeave,
    balanceManagement,
    noShow,
    other,
  ];

  String get name {
    switch (value) {
      case 0:
        return "Annual Leave";
      case 1:
        return "Sick Leave";
      case 2:
        return "Emergency Leave";
      case 3:
        return "Allocation";
      case 4:
        return "Military Leave";
      case 5:
        return "Maternity Leave";
      case 6:
        return "Bereavement Leave";
      case 7:
        return "Balance Management";
      case 8:
        return "No Show";
      case 9:
        return "Half Day Leave";
      case 10:
        return "Other";
      default:
        throw ('Unknown enum value to decode ItemStatusEnum $value');
    }
  }

  LeaveRequestType.fromJson(dynamic data) {
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
      default:
        throw ('Unknown enum value to decode ItemStatusEnum : $data');
    }
  }

  static dynamic encode(LeaveRequestType data) {
    return data.value;
  }
}
