import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:project_alfa/view/widgets/main/Main_sidebar.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

double bar_width = 300;
int triger = 0;
bool open = false;

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBody(),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({
    super.key,
  });

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  @override
  Widget build(BuildContext context) {
    print(triger);
    print(bar_width);
    return SafeArea(
        child: Container(
      child: Row(
        children: <Widget>[
          Main_sidebar(bar_width: bar_width, triger: triger),
          Expanded(
              child: Container(
            color: Color.fromARGB(82, 158, 158, 158).withOpacity(0.15),
            child: Column(
              children: <Widget>[
                Visibility(
                  child: IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.menu,
                      )),
                )
              ],
            ),
          ))
        ],
      ),
    ));
    ;
  }
}
