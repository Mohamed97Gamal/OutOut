import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

enum LocationStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  approved,
  @JsonValue(2)
  rejected
}

extension LocationStatusProps on LocationStatus? {
  Color? get color {
    switch (this) {
      case LocationStatus.pending:
        return Color(0xffffc400);
      case LocationStatus.approved:
        return Color(0xff73bfc7);
      case LocationStatus.rejected:
        return Color(0xffd13827);
      default:
        return null;
    }
  }

  String? get name {
    switch (this) {
      case LocationStatus.pending:
        return "Pending";
      case LocationStatus.approved:
        return "Approved";
      case LocationStatus.rejected:
        return "Rejected";
      default:
        return null;
    }
  }
}
