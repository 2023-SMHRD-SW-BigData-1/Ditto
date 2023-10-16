import 'package:flutter/material.dart';
import 'package:project_alfa/view/widgets/main/Main_sidebar.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBody(),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Row(
        children: <Widget>[
          Main_sidebar(),
          Expanded(
              child: Container(
            color: Color.fromARGB(82, 158, 158, 158).withOpacity(0.15),
            child: Column(
              children: <Widget>[],
            ),
          ))
        ],
      ),
    ));
    ;
  }
}
