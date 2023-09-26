import 'package:flutter/cupertino.dart';

class Failure {
  bool status;
  dynamic message;
  Failure({required this.status, this.message = "Bad Request"});
}
