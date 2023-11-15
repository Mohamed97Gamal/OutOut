class ExternalProvider {
  /// The underlying value of this enum member.
  int value = 0;

  ExternalProvider._internal(this.value);

  static ExternalProvider none = ExternalProvider._internal(0);
  static ExternalProvider facebook = ExternalProvider._internal(1);
  static ExternalProvider google = ExternalProvider._internal(2);
  static ExternalProvider apple = ExternalProvider._internal(3);

  ExternalProvider.fromJson(dynamic data) {
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
        throw ('Unknown enum value to decode: $data');
    }
  }

  static dynamic encode(ExternalProvider data) {
    return data.value;
  }
}
