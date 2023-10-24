import 'package:alfa/view/widgets/home/Footer.dart';
import 'package:alfa/view/widgets/home/Home_first.dart';
import 'package:alfa/view/widgets/home/Home_second.dart';
import 'package:alfa/view/widgets/home/TopNavigationBar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    Size screenSize = deviceData.size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: SafeArea(
            child: Column(
          children: <Widget>[
            TopNavigationBar(),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[Home_first(), Home_second(), Footer()],
              ),
            )),
          ],
        )),
      ),
    );
  }
}
