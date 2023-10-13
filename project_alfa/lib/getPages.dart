import 'package:get/get.dart';
import 'package:project_alfa/view/page/home/home.dart';
import 'package:project_alfa/view/page/Main.dart';

abstract class Routes {
  static const HOME = '/';
  static const MAIN = '/main';
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
    )
  ];
}