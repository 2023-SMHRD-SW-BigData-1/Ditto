import 'package:alfa/Controller/bar.dart';
import 'package:alfa/Controller/trigger.dart';
import 'package:alfa/Model/Input_data.dart';
import 'package:alfa/Model/User.dart';
import 'package:alfa/Model/fetch.dart';
import 'package:alfa/build_app_theme.dart';
import 'package:alfa/get_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
          create: (context) => User(),
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
