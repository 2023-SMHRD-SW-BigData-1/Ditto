import 'package:flutter/material.dart';

class Input_data extends ChangeNotifier {
  late double _yiel;
  late double _tensile;
  late double _hardness;
  late double _elongation;

  double get yiel => _yiel;
  double get tensile => _tensile;
  double get hardness => _hardness;
  double get elongation => _elongation;

  set yiel(double value) {
    _yiel = value;
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
