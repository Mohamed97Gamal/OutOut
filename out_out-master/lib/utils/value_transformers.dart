class ValueTransformers {
  static dynamic trim(String? value) {
    return value?.trim();
  }

  static dynamic trimToLowerCase(String? value) {
    return value?.trim().toLowerCase();
  }
}
