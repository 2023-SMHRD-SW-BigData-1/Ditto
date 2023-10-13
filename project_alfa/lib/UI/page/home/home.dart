import 'package:flutter/material.dart';
import 'package:project_alfa/UI/widgets/home/Footer.dart';
import 'package:project_alfa/UI/widgets/home/Home_first.dart';
import 'package:project_alfa/UI/widgets/home/TopNavigationBar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            children: <Widget>[Home_first(), Second(), Footer()],
          ),
        ))
      ],
    ));

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 900,
      color: Colors.red,
    );
  }
}
