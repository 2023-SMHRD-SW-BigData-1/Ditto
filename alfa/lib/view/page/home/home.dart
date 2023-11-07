import 'package:alfa/Controller/userState.dart';
import 'package:alfa/view/widgets/home/Home_main/Footer.dart';
import 'package:alfa/view/widgets/home/Home_main/Home_%20fourth.dart';
import 'package:alfa/view/widgets/home/Home_main/Home_first.dart';
import 'package:alfa/view/widgets/home/Home_main/Home_second.dart';
import 'package:alfa/view/widgets/home/Home_main/Home_third.dart';
import 'package:alfa/view/widgets/home/Home_main/TopNavigationBar.dart';

import 'package:alfa/view/widgets/home/login/Login_btn.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _controller = ScrollController();
  double _scrollPosition = 0.0;
  @override
  void initState() {
    super.initState();

    // 스크롤 이벤트를 감지하고 스크롤 위치를 업데이트합니다.
    _controller.addListener(() {
      setState(() {
        _scrollPosition = _controller.offset;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    Size screenSize = deviceData.size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: <Widget>[
                  Home_first(screenSize: screenSize),
                  Home_second(
                      position: _scrollPosition, screenSize: screenSize),
                  Home_third(position: _scrollPosition, screenSize: screenSize),
                  Home_fourth(
                      position: _scrollPosition, screenSize: screenSize),
                  Footer()
                ],
              ),
            ),
            TopNavigationBar(),

            FutureBuilder<String>(
              future: loadUserId(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasError) {
                  // 에러가 발생한 경우
                  return Text('Error: ${snapshot.error}');
                } else {
                  // 데이터가 정상적으로 로드된 경우
                  return snapshot.data == ''
                      ? NavBarItem('Log in')
                      : hovering(
                          userId: snapshot.data.toString(),
                        ); // 데이터가 null인 경우 빈 문자열을 사용합니다.
                }
              },
            ),

            // loadUserId() == '' ? NavBarItem('Log in') : hovering(),
          ],
        ),
      ),
    );
  }
}
