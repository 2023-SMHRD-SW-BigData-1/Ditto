import 'package:alfa/Controller/userState.dart';
import 'package:alfa/view/widgets/home/Footer.dart';
import 'package:alfa/view/widgets/home/Home_%20fourth.dart';
import 'package:alfa/view/widgets/home/Home_first.dart';
import 'package:alfa/view/widgets/home/Home_second.dart';
import 'package:alfa/view/widgets/home/Home_third.dart';
import 'package:alfa/view/widgets/home/TopNavigationBar.dart';
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
                  Home_third(position: _scrollPosition),
                  Home_fourth(position: _scrollPosition),
                  Footer()
                ],
              ),
            ),
            TopNavigationBar(),

            FutureBuilder<String>(
              future: loadUserId(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 데이터가 로드 중인 경우
                  return CircularProgressIndicator(); // 로딩 중 인디케이터 또는 다른 로딩 UI를 표시할 수 있습니다.
                } else if (snapshot.hasError) {
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
