import 'package:alfa/view/widgets/home/join/Form_join.dart';
import 'package:flutter/material.dart';

class User_join extends StatelessWidget {
  const User_join({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    Size screenSize = deviceData.size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: SafeArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/image/Logo_text.png',
                  width: 200,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Form_join(),
                  height: 800,
                  width: 800,
                ),
              ],
            ),
            SizedBox(
              width: 50,
            ),
            Expanded(
              child: OverflowBox(
                minWidth: 1020,
                child: Image.asset(
                  'assets/image/macro-1452987_1920.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
