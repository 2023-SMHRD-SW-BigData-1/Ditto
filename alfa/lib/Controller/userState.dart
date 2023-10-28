import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> loadUserId() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('name') ?? '';
  return userId;
}
