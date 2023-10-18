import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_alfa/view/widgets/home/Footer.dart';
import 'package:project_alfa/view/widgets/home/Home_first.dart';
import 'package:project_alfa/view/widgets/home/Home_second.dart';
import 'package:project_alfa/view/widgets/home/TopNavigationBar.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
