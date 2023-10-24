import 'package:flutter/material.dart';

class Input_data extends ChangeNotifier {
  late double _yield;
  late double _tensile;
  late double _hardness;
  late double _elongation;

  double get yield => _yield;
  double get tensile => _tensile;
  double get hardness => _hardness;
  double get elongation => _elongation;

  set yield(double value) {
    _yield = value;
    notifyListeners();
  }

  set tensile(double value) {
    _tensile = value;
    notifyListeners();
  }

  set hardness(double value) {
    _hardness = value;
    notifyListeners();
  }

  set elongation(double value) {
    _elongation = value;
    notifyListeners();
  }
}
