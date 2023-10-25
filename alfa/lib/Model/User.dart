import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String _userId = '';

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
    notifyListeners();
  }
}
