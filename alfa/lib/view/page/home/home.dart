import 'package:alfa/Model/User.dart';
import 'package:alfa/provider/scrollPosition%20.dart';
import 'package:alfa/view/widgets/home/Footer.dart';
import 'package:alfa/view/widgets/home/Home_first.dart';
import 'package:alfa/view/widgets/home/Home_second.dart';
import 'package:alfa/view/widgets/home/Home_third.dart';
import 'package:alfa/view/widgets/home/TopNavigationBar.dart';
import 'package:alfa/view/widgets/home/login/Login_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userId = '';
  ScrollController _controller = ScrollController();
  double _scrollPosition = 0.0;
  double _previousPosition = 0.0;

  @override
  void initState() {
    super.initState();

    // 스크롤 이벤트를 감지하고 스크롤 위치를 업데이트합니다.
    _controller.addListener(() {
      setState(() {
        _scrollPosition = _controller.offset;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        loadUserId();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    final userId = Provider.of<User>(context);
    // userId.userId = this.userId;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: <Widget>[
                  Home_first(),
                  Home_second(position: _scrollPosition),
                  Home_third(),
                  Footer()
                ],
              ),
            ),
            TopNavigationBar(),
            userId.userId == '' ? NavBarItem('Log in') : hovering(),
          ],
        ),
      ),
    );
  }
}
