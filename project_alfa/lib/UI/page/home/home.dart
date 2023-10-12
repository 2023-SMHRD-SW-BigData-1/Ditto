import 'package:flutter/material.dart';
import 'package:project_alfa/UI/widgets/home/TopNavigationBar.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),
    );
  }
}

HomeBody() => SafeArea(
        child: Column(
      children: <Widget>[
        TopNavigationBar(),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[],
          ),
        ))
      ],
    ));
