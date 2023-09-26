final RegExp mobileRegExp = RegExp(r"""^[0123456789]+$""");

String? mobileValidator(String mobile) {
  if (mobileRegExp.hasMatch(mobile) && (mobile?.length ?? 0) >= 9 && (mobile?.length ?? 0) <= 14) {
    return null;
  }
  return "Mobile must be numeric & length between (9 - 14).";
}

String? requiredFieldValidator(String s) {
  if (s != null) {
    if (s.isNotEmpty) {
      return null;
    }
  }
  return "This field is required.";
}

final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

bool verifyEmail(String email) {
  return emailRegExp.hasMatch(email);
}

String? emailValidator(String email) {
  if (verifyEmail(email)) {
    return null;
  }
  return "Your email is not valid.";
}

final RegExp passwordRegExp = RegExp("(?=.{8,16})(?=.*[!@#\$%\^&\*])(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])");

bool verifyPassword(String password) {
  return passwordRegExp.hasMatch(password);
}

String? passwordValidator(String password) {
  if (verifyPassword(password)) {
    return null;
  }
  return "Your password must be 8-16 characters including at least 1 lowercase, 1 uppercase, 1 digit and 1 symbol.";
}

final RegExp linkRegExp = RegExp(
  r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$",
  caseSensitive: false,
);

bool verifyLink(String link) {
  return linkRegExp.hasMatch(link);
}

String? linkValidator(String link) {
  if (verifyLink(link)) {
    return null;
  }
  return "Please enter a valid link.";
}

String? rangeValidatorString(String value, int start, int end) {
  final v = int.tryParse(value);
  if (v == null) {
    return "Invalid number";
  }
  final inRange = v >= start && v <= end;
  if (!inRange) {
    return "Please enter number between $start and $end";
  }
  return null;
}

String? rangeValidator(int value, int start, int end) {
  if (value == null) {
    return "Invalid number";
  }
  final inRange = value >= start && value <= end;
  if (!inRange) {
    return "Please enter number between $start and $end";
  }
  return null;
}

final RegExp loginPasswordRegExp = RegExp("(?=.{8,})");
//final RegExp loginPasswordRegExp = RegExp("(?=.{8,16})(?=.*[0-9])(?=.*[a-z])"); // old
//final RegExp loginPasswordRegExp = RegExp("(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[_\W]).{8,}"); // Hunter

String? loginPasswordValidator(String password) {
  if (loginPasswordRegExp.hasMatch(password)) {
    return null;
  }
  return "Your password must be at least 8 characters long.";
}

final RegExp nameRegExp = RegExp(r"^[a-zA-Z ]+$");

String? nameValidator(String name) {
  if (name.startsWith(" ")) {
    return "Name can't start with space(s).";
  }
  if (name.length <= 7 || name.length >= 50) {
    return "length must be between (7-50).";
  }
  if (!nameRegExp.hasMatch(name)) {
    return "Name must be alphabet only.";
  }
  return null;
}

 String? isNotNullNorEmpty(String? value, String fieldName) {
  value = value;
  if (value == null) {
    return "${fieldName ?? "This field"} is required.";
  }
  if (value.isEmpty) {
    return "${fieldName ?? "This field"} is required.";
  }
  return null;
}
