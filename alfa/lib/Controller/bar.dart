import 'package:flutter/material.dart';

class bar extends ChangeNotifier {
  double _bar_width = 0;

  double get bar_width => _bar_width;

  bool _triger = true;

  bool get triger => _triger;

  bar_open<double, bool>() {
    _bar_width = 300;
    _triger = false;
    notifyListeners();
  }

  bar_close<double, bool>() {
    _bar_width = 0;
    _triger = true;
    notifyListeners();
  }
}
