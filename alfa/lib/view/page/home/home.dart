import 'package:alfa/Model/User.dart';
import 'package:alfa/view/widgets/home/Footer.dart';
import 'package:alfa/view/widgets/home/Home_first.dart';
import 'package:alfa/view/widgets/home/Home_second.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserId();
    });
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
              child: Column(
                children: <Widget>[Home_first(), Home_second(), Footer()],
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
