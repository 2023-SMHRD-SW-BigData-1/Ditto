import 'package:alfa/Model/User.dart';
import 'package:alfa/view/widgets/home/login/Login.dart';
import 'package:flutter/material.dart';
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
          style: TextStyle(color: Colors.black, fontSize: 14),
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
        top: 16,
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
                  Text(_userId.userId),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              AnimatedContainer(
                height: _hover ? 100 : 0,
                width: 100,
                duration: Duration(milliseconds: 100),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(66, 255, 255, 255),
                    border: Border.all(
                        width: 3,
                        color: _hover ? Colors.black : Colors.transparent)),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextButton(onPressed: () {}, child: mintext('회원정보')),
                      TextButton(onPressed: () {}, child: mintext('결제내역')),
                      Container(
                        width: double.infinity,
                        height: 3,
                        color: Colors.black,
                      ),
                      TextButton(
                          onPressed: () {
                            clearAllData();
                            html.window.location.reload();
                          },
                          child: mintext('Log out'))
                    ],
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
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
  );
}
