import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:project_alfa/getPages.dart';
import 'package:http/http.dart' as http;
import 'package:project_alfa/provider/fetch.dart';
import 'package:project_alfa/provider/bar.dart';
import 'package:provider/provider.dart';

void main() {
  usePathUrlStrategy();
  runApp(MultiProvider(
    providers: [
      Provider<Future>(
        create: (context) => fetch(),
      ),
      ChangeNotifierProvider(
        create: (context) => bar(),
      )
    ],
    child: GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "AL.F.A",
      theme: ThemeData(
        fontFamily: "NotoSansKR",
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          splashColor: Colors.transparent,
          elevation: 0,
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
        )),
      ),
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
    ),
  ));
}
