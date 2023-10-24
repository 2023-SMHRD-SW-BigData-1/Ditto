import 'package:alfa/getPages.dart';
import 'package:alfa/view/widgets/home/login/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  String userId = '';

  @override
  void initState() {
    super.initState();
    loadUserId(); // 앱이 시작할 때 세션 데이터를 불러옵니다.
  }

  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 63.0,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: const Color.fromRGBO(179, 179, 179, 80)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/image/Logo.png',
            width: 200,
            height: 200,
          ),
          Text(userId),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              userId == ''
                  ? NavBarItem('Log in')
                  : TextButton(
                      onPressed: () {
                        clearAllData();
                      },
                      child: Text('Log out')),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => Get.rootDelegate.toNamed(Routes.MAIN),
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
              SizedBox(
                width: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String title;
  const NavBarItem(this.title);

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
    );
  }
}

Future<void> clearAllData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
