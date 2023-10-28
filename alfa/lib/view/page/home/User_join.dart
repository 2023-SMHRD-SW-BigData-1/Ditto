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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/image/Logo_text.png',
                  width: 200,
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: Form_join(),
                  height: 800,
                  width: 800,
                ),
              ],
            ),
            SizedBox(
              width: 50,
            ),
          ],
        )),
      ),
    );
  }
}
