import 'package:intl/intl.dart';

class DateUtils {
  static final DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  static final DateFormat dateUtcFormat =
      DateFormat("yyyy-MM-ddT22:00:00.000'Z'");
  static final DateFormat dateFormatDayMonth = DateFormat("dd MMM");
  static String durationToText(Duration duration) {
    return "${duration.inHours.toString().padLeft(2, "0")}" +
        ":" +
        "${(duration.inMinutes % 60).toString().padLeft(2, "0")}";
  }
}
