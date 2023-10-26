import 'dart:ui';

import 'package:alfa/Model/User.dart';
import 'package:alfa/get_pages.dart';
import 'package:alfa/view/widgets/home/login/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;

class NavBarItem extends StatelessWidget {
  final String title;
  const NavBarItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 240,
      top: 16,
      child: TextButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Login(),
                );
              });
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}

class hovering extends StatefulWidget {
  const hovering({Key? key});

  @override
  State<hovering> createState() => _hoveringState();
}

bool _hover = false;

Future<void> clearAllData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

class _hoveringState extends State<hovering> {
  @override
  Widget build(BuildContext context) {
    final _userId = Provider.of<User>(context);
    return Positioned(
        right: 240,
        top: 20,
        child: MouseRegion(
          onHover: (event) {
            setState(() {
              _hover = true;
            });
          },
          onExit: (event) {
            setState(() {
              _hover = false;
            });
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    _userId.userId + "님 안녕하세요",
                    style: TextStyle(fontSize: 14),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AnimatedContainer(
                    height: _hover ? 60 : 0,
                    width: 100,
                    duration: Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(66, 255, 255, 255),
                        border: Border.all(
                            color: _hover
                                ? const Color.fromRGBO(179, 179, 179, 80)
                                : Colors.transparent)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextButton(
                              onPressed: () =>
                                  Get.rootDelegate.toNamed(Routes.INFO),
                              child: mintext('회원정보')),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: const Color.fromRGBO(179, 179, 179, 80),
                          ),
                          TextButton(
                              onPressed: () {
                                clearAllData();
                                Get.rootDelegate.toNamed(Routes.HOME);
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 300), () {
                                  html.window.location.reload();
                                });
                              },
                              child: mintext('Log out'))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

Widget mintext(String title) {
  return Text(
    title,
    style: TextStyle(color: Colors.black),
  );
}
