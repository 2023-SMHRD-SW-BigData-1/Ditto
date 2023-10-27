import 'package:alfa/Controller/bar.dart';
import 'package:alfa/view/widgets/main/Main_input.dart';
import 'package:alfa/view/widgets/main/Main_result.dart';
import 'package:alfa/view/widgets/main/Main_sidebar.dart';
import 'package:alfa/view/widgets/main/PDF/PDF_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  const MainBody({Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 20),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    Size screenSize = deviceData.size;
    final _bar = Provider.of<bar>(context);
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(),
      width: screenSize.width,
      height: screenSize.height,
      child: Row(
        children: <Widget>[
          Main_sidebar(),
          Expanded(
              child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedOpacity(
                        // ignore: sort_child_properties_last
                        child: Tooltip(
                          message: 'Open sidebar',
                          waitDuration: Duration(milliseconds: 300),
                          child: IconButton(
                              constraints: BoxConstraints(),
                              onPressed: () {
                                _bar.bar_open();
                              },
                              icon: Icon(
                                Icons.menu,
                                color: Colors.black,
                              )),
                        ),
                        opacity: _bar.triger ? 1.0 : 0.0,
                        duration: _bar.triger
                            ? Duration(milliseconds: 500)
                            : Duration(milliseconds: 100),
                      ),
                      Container(
                        width: 400,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 74,
                            ),
                            Image.asset(
                              'assets/image/Logo_text.png',
                              width: 300,
                            ),
                          ],
                        ),
                      ),
                      PDF_btn(),
                    ],
                  ),
                ),
                Expanded(
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Center(
                  //       child: Container(
                  //           margin: EdgeInsets.all(30),
                  //           padding: EdgeInsets.all(50),
                  //           width: 1500,
                  //           height: 700,
                  //           decoration: BoxDecoration(
                  //               border: Border.all(
                  //                   color: Color.fromRGBO(62, 68, 102, 1),
                  //                   width: 2),
                  //               borderRadius: BorderRadius.circular(10)),
                  //           child:
                  //               resultTabel(generateRowData(planets.length))),
                  //     )
                  //   ],
                  // ),
                  child: AnimatedBuilder(
                    animation: _controller,
                    child: Container(
                      child: Image.asset(
                        'assets/image/Logo_icon.png',
                        width: 300,
                      ),
                    ),
                    builder: (BuildContext context, Widget? child) {
                      return Transform.rotate(
                        angle: _controller.value * 2.0 * 3.1415926535897932,
                        child: child,
                      );
                    },
                  ),
                ),
                Main_input()
              ],
            ),
          ))
        ],
      ),
    ));
  }
}

List<SampleRowData> generateRowData(int rows) {
  return List.generate(rows, (index) {
    return SampleRowData(
      planet: planets[index],
    );
  });
}
