import 'package:flutter/material.dart';

class Manager with ChangeNotifier {
  bool _myTeam = false;
  bool get getMyTeam => _myTeam;

  set setMyTeam(bool myTeam) {
    _myTeam = myTeam;
    notifyListeners();
  }
}
