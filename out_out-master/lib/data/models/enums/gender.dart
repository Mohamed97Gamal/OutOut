import 'dart:collection';

class Gender {
  /// The underlying value of this enum member.
  int value = 0;

  Gender._internal(this.value);

  static Gender female = Gender._internal(0);
  static Gender male = Gender._internal(1);
  static Gender unspecified = Gender._internal(2);

  static final UnmodifiableListView<Gender> availableOptions = new UnmodifiableListView(
    [
      male,
      female,
      unspecified,
    ],
  );

  String get name {
    switch (value) {
      case 0:
        return "Female";
      case 1:
        return "Male";
      case 2:
        return "Prefer to not specify";
      default:
        throw ('Unknown enum value to decode name');
    }
  }

  Gender.fromJson(dynamic data) {
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
        throw ('Unknown enum value to decode Gender: $data');
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is Gender) {
      return other.value == value;
    }
    return false;
  }

  dynamic toJson() {
    return value;
  }

  static dynamic encode(Gender data) {
    return data.value;
  }
}
