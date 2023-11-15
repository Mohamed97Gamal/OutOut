class TypeFor {
  /// The underlying value of this enum member.
  int value = 0;

  TypeFor._internal(this.value);

  static TypeFor venue = TypeFor._internal(0);
  static TypeFor event = TypeFor._internal(1);

  TypeFor.fromJson(dynamic data) {
    switch (data) {
      case 0:
        value = data;
        break;
      case 1:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode Type for: $data');
    }
  }

  static dynamic encode(TypeFor data) {
    return data.value;
  }
}
