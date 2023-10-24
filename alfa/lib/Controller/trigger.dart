import 'package:flutter/material.dart';

class trigger extends ChangeNotifier {
  bool _triger_on = true;

  bool get triger_on => _triger_on;

  triger_on_off() {
    _triger_on = !_triger_on;
    notifyListeners();
  }
}
