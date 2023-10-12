import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:project_alfa/UI/page/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AL.F.A",
      theme: ThemeData(
        fontFamily: "NotoSansKR",
      ),
      initialRoute: '/',
      routes: {'/': (context) => Home()},
    );
  }
}
