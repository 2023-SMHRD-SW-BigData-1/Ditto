import 'package:alfa/view/widgets/main/Main_result.dart';
import 'package:flutter/material.dart';

class resultData extends ChangeNotifier {
  late List<MainResult> _planets;

  List<MainResult> get planets => _planets;

  set planets(List<MainResult> value) {
    _planets = value;
    notifyListeners();
  }
}
