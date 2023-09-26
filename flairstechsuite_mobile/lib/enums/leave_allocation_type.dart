class LeaveAllocationType {
  /// The underlying value of this enum member.
  int value = 0;

  LeaveAllocationType._internal(this.value);

  static LeaveAllocationType notSpecified = LeaveAllocationType._internal(0);
  static LeaveAllocationType paidAllocation = LeaveAllocationType._internal(1);
  static LeaveAllocationType addedBalance = LeaveAllocationType._internal(2);
  static final List<LeaveAllocationType> availableValues = [
    notSpecified,
    paidAllocation,
    addedBalance,
  ];

  String get name {
    switch (value) {
      case 0:
        return "Not Specified";
      case 1:
        return "Paid Allocation";
      case 2:
        return "Added Balance";
      default:
        throw ('Unknown enum value to decode ItemStatusEnum $value');
    }
  }

  LeaveAllocationType.fromJson(dynamic data) {
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
      default:
        throw ('Unknown enum value to decode ItemStatusEnum : $data');
    }
  }

  static dynamic encode(LeaveAllocationType data) {
    return data.value;
  }
}
