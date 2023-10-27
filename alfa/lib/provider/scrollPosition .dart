import 'package:flutter/material.dart';

class scrollPosition extends ChangeNotifier {
  double _position = 0;

  double get position => _position;

  set position(double value) {
    _position = value;
    notifyListeners();
  }
}
