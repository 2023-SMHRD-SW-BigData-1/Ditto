import 'package:alfa/view/page/Main.dart';
import 'package:alfa/view/page/home/Home.dart';
import 'package:alfa/view/page/home/User_history.dart';
import 'package:alfa/view/page/home/User_join.dart';
import 'package:get/get.dart';

abstract class Routes {
  static const HOME = '/';
  static const MAIN = '/main';
  static const LOGIN = '/login';
  static const JOIN = '/join';
  static const JOINDB = '/join/create';
  static const HISTORY = '/history';
}

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => Home()),
    GetPage(name: Routes.MAIN, page: () => Main()),
    GetPage(name: Routes.LOGIN, page: () => Home()),
    GetPage(name: Routes.JOIN, page: () => User_join()),
    GetPage(name: Routes.JOINDB, page: () => User_join()),
    GetPage(name: Routes.HISTORY, page: () => User_history()),
  ];
}
