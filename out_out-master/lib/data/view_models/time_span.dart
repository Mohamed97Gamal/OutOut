class TimeSpan {
  late int hours;
  late int minutes;

  TimeSpan(String value) {
    final split = value.split(":");
    if (split.length != 2) {
      throw 'Invalid time span';
    }

    hours = int.parse(split[0]);
    minutes = int.parse(split[1]);
  }

  get inMinutes {
    int hours = this.hours;
    int minutes = this.minutes;
    hours %= 24;
    minutes %= 60;
    return (hours * 60) + minutes;
  }

  @override
  String toString() {
    final hours = this.hours;
    final minutes = this.minutes;
    if (hours == 0) {
      return "12:${minutes.toString().padLeft(2, '0')} AM";
    }
    if (hours > 24) {
      return "${(hours - 24)}:${minutes.toString().padLeft(2, '0')} AM";
    }
    if (hours == 12) {
      return "12:${minutes.toString().padLeft(2, '0')} PM";
    }
    if (hours > 12) {
      return "${(hours - 12)}:${minutes.toString().padLeft(2, '0')} PM";
    }
    return "${hours}:${minutes.toString().padLeft(2, '0')} AM";
  }

  String encode() {
    return "$hours:$minutes";
  }
}
