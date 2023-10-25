import 'package:alfa/Model/User.dart';
import 'package:alfa/view/widgets/home/Footer.dart';
import 'package:alfa/view/widgets/home/TopNavigationBar.dart';
import 'package:alfa/view/widgets/home/history/HistoryContent.dart';
import 'package:alfa/view/widgets/home/login/Login_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User_history extends StatefulWidget {
  const User_history({super.key});

  @override
  State<User_history> createState() => _User_historyState();
}

class _User_historyState extends State<User_history> {
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
    MediaQueryData deviceData = MediaQuery.of(context);
    Size screenSize = deviceData.size;
    final _userId = Provider.of<User>(context);
    _userId.userId = userId;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[HistoryContent(), Footer()],
                ),
              )),
              TopNavigationBar(),
              _userId.userId == '' ? NavBarItem('Log in') : hovering(),
            ],
          ),
        ),
      ),
    );
  }
}
