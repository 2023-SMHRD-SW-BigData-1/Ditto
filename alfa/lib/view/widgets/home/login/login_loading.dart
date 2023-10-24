import 'package:alfa/getPages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future loading() async {
  return Get.rootDelegate.toNamed(Routes.HOME);
}
