import 'package:flutter/material.dart';

class triger extends ChangeNotifier {
  bool _triger_on = true;

  bool get triger_on => _triger_on;

  triger_on_off() {
    _triger_on = !_triger_on;
    notifyListeners();
  }
}
