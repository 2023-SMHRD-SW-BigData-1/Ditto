import 'package:flutter/material.dart';

class resultTrigger extends ChangeNotifier {
  bool _Trigger = false;

  bool get Trigger => _Trigger;

  set Trigger(bool value) {
    _Trigger = value;
    notifyListeners();
  }
}
