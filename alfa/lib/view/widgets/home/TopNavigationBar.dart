import 'dart:ui';
import 'package:alfa/Controller/userState.dart';
import 'package:alfa/get_pages.dart';
import 'package:alfa/view/widgets/home/login/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
            height: 63.0,
            decoration: BoxDecoration(
              color: const Color.fromARGB(87, 255, 255, 255),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  child: IconButton(
                    hoverColor: Colors.transparent,
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.HOME);
                    },
                    icon: Image.asset(
                      'assets/image/Logo.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (loadUserId() == '') {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Login(),
                            );
                          });
                    } else {
                      Get.rootDelegate.toNamed(Routes.MAIN);
                    }
                  },
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color.fromRGBO(182, 24, 24, 1),
                      padding: EdgeInsets.fromLTRB(35, 14, 35, 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
