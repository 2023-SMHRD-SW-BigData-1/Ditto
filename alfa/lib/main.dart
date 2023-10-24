import 'package:alfa/Controller/bar.dart';
import 'package:alfa/Controller/trigger.dart';
import 'package:alfa/Model/Input_data.dart';
import 'package:alfa/Model/fetch.dart';
import 'package:alfa/getPages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

// ignore: unused_import
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      Provider<Future>(
        create: (context) => fetch(),
      ),
      ChangeNotifierProvider(
        create: (context) => bar(),
      ),
      ChangeNotifierProvider(
        create: (context) => trigger(),
      ),
      ChangeNotifierProvider(
        create: (context) => Input_data(),
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