class EmployeeLeavesType {
  /// The underlying value of this enum member.
  int value = 0;

  EmployeeLeavesType._internal(this.value);

  static EmployeeLeavesType leaves = EmployeeLeavesType._internal(0);
  static EmployeeLeavesType noShow = EmployeeLeavesType._internal(1);
  static EmployeeLeavesType all = EmployeeLeavesType._internal(2);

  static final List<EmployeeLeavesType> availableValues = [
    leaves,
    noShow,
    all,
  ];

  String get name {
    switch (value) {
      case 0:
        return "Leaves";
      case 1:
        return "No Show";
      case 2:
        return "No Show";

      default:
        throw ('Unknown enum value to decode ItemStatusEnum $value');
    }
  }

  EmployeeLeavesType.fromJson(dynamic data) {
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

  static dynamic encode(EmployeeLeavesType data) {
    return data.value;
  }
}
