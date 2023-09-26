import 'package:flutter/foundation.dart';

T? tryCast<T>(dynamic obj) {
  if (obj == null) return null;
  return (obj is T) ? obj : null;
}

String? nullIfEmpty(String? value, {bool trimmed = true}) {
  if (value == null) return null;
  final _value = trimmed == true ? value.trim() : value;
  if (_value.isEmpty) return null;
  return _value;
}

void printIfDebug(Object object) {
  if (kReleaseMode) return;
  print(object);
}
