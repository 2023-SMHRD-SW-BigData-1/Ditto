import 'package:alfa/view/page/Main.dart';
import 'package:alfa/view/page/home/home.dart';
import 'package:get/get.dart';

abstract class Routes {
  static const HOME = '/';
  static const MAIN = '/main';
  static const LOGIN = '/login';
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => Home(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => Main(),
    ),
    GetPage(name: Routes.LOGIN, page: () => Home()),
  ];
}
