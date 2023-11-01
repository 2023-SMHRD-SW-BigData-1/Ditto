import 'package:alfa/Controller/userState.dart';
import 'package:alfa/view/widgets/home/Home_main/Footer.dart';
import 'package:alfa/view/widgets/home/Home_main/TopNavigationBar.dart';
import 'package:alfa/view/widgets/home/info/HistoryContent.dart';
import 'package:alfa/view/widgets/home/info/InfoContent.dart';
import 'package:alfa/view/widgets/home/login/Login_btn.dart';
import 'package:flutter/material.dart';

class User_info extends StatefulWidget {
  const User_info({super.key});

  @override
  State<User_info> createState() => _User_infoState();
}

class _User_infoState extends State<User_info> {
  @override
  void initState() {
    super.initState();
    // 앱이 시작할 때 세션 데이터를 불러옵니다.
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    Size screenSize = deviceData.size;
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
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 1000,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 160,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TitleText('회원정보 확인/수정'),
                                SizedBox(height: 50),
                                Container(
                                    width: 700,
                                    height: 600,
                                    child: InfoContent()),
                              ],
                            ),
                            SizedBox(width: 100),
                            Container(
                              width: 2,
                              height: 700,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(179, 179, 179, 80)),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TitleText('결제 내역 확인'),
                                SizedBox(height: 50),
                                HistoryContent()
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Footer()
                  ],
                ),
              )),
              TopNavigationBar(),
              FutureBuilder<String>(
                future: loadUserId(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return snapshot.data == ''
                        ? NavBarItem('Log in')
                        : hovering(
                            userId: snapshot.data.toString(),
                          );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget TitleText(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
  );
}
