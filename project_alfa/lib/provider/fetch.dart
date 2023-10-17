import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future fetch() async {
  var res = await http.get(Uri.parse('http://172.30.1.29:8889/'));
  return jsonDecode(res.body);
}
