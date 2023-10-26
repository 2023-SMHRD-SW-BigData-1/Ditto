import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String _userId = '';

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
    notifyListeners();
  }
  
  String _result = '';

  String get result => _result;

  set result(String value) {
    _result = value;
    notifyListeners(); // 상태가 업데이트될 때 리스너에게 알립니다.
  }
}
