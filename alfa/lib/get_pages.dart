import 'package:alfa/view/page/Main.dart';
import 'package:alfa/view/page/home/Home.dart';
import 'package:alfa/view/page/home/User_info.dart';
import 'package:alfa/view/page/home/User_join.dart';
import 'package:get/get.dart';
import 'Provider/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Routes {
  static const HOME = '/';
  static const MAIN = '/main';
  static const LOGIN = '/login';
  static const JOIN = '/join';
  static const INFO = '/info';
}

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => Home()),
    GetPage(name: Routes.MAIN, page: () => Main()),
    GetPage(name: Routes.LOGIN, page: () => Home()),
    GetPage(name: Routes.JOIN, page: () => User_join()),
    GetPage(name: Routes.INFO, page: () => User_info()),
  ];
}