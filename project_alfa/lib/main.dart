import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'package:project_alfa/Controller/triger.dart';
import 'package:project_alfa/getPages.dart';
import 'package:project_alfa/Model/fetch.dart';
import 'package:project_alfa/Controller/bar.dart';
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
        create: (context) => triger(),
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
