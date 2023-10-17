import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class bar extends ChangeNotifier {
  double _bar_width = 300;

  double get bar_width => _bar_width;

  bool _triger = false;

  bool get triger => _triger;

  bar_open() {
    _bar_width = 300;
    _triger = false;
    notifyListeners();
  }

  bar_close() {
    _bar_width = 0;
    _triger = true;
    notifyListeners();
  }
}
