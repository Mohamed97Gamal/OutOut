import 'package:flutter/foundation.dart';

void printIfDebug(Object object) {
  if (kReleaseMode) return;
  print(object);
}

String firstNotNullOrEmpty(String? first, String second) {
  if (first == null || first.isEmpty) {
    return second;
  }
  return first;
}
