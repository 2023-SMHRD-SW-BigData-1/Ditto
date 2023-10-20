import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_alfa/getPages.dart';

Future loading() async {
  return Get.rootDelegate.toNamed(Routes.HOME);
}
