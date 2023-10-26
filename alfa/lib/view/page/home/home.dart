import 'package:alfa/Model/User.dart';
import 'package:alfa/view/widgets/home/Footer.dart';
import 'package:alfa/view/widgets/home/Home_first.dart';
import 'package:alfa/view/widgets/home/Home_second.dart';
import 'package:alfa/view/widgets/home/TopNavigationBar.dart';
import 'package:alfa/view/widgets/home/login/Login_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userId = '';

  @override
  void initState() {
    super.initState();
    loadUserId(); // 앱이 시작할 때 세션 데이터를 불러옵니다.
  }

  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('name') ?? '';
    });
  }

  void clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // 모든 SharedPreferences 데이터 삭제
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
                children: <Widget>[Home_first(), Home_second(), Footer()],
              ),
            )),
            TopNavigationBar(),
            _userId.userId == '' ? NavBarItem('Log in') : hovering(),
          ],
        )),
      ),
    );
  }
}
