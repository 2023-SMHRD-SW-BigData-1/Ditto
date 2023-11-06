import 'package:alfa/Controller/bar.dart';
import 'package:alfa/Controller/trigger.dart';
import 'package:alfa/Model/Input_data.dart';
import 'package:alfa/Model/fetch.dart';
import 'package:alfa/Model/resultData.dart';
import 'package:alfa/build_app_theme.dart';
import 'package:alfa/get_pages.dart';
import 'package:alfa/provider/scrollPosition%20.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  setPathUrlStrategy();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC1e9kIvssbuNWk1EV4XOvVBETFppinkOY",
      appId: 'test2-75a63',
      messagingSenderId: "186697788898",
      projectId: 'test2-75a63',
      storageBucket: 'test2-75a63.appspot.com',
      authDomain: 'test2-75a63.firebaseapp.com',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        ),
        ChangeNotifierProvider(
          create: (context) => scrollPosition(),
        ),
        ChangeNotifierProvider(
          create: (context) => resultData(),
        )
      ],
      child: GetMaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "AL.F.A",
        theme: buildAppTheme(),
        defaultTransition: Transition.fade,
        getPages: AppPages.pages,
      ),
    );
  }
}
