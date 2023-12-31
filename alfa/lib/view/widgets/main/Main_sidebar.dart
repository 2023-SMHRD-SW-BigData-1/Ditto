import 'dart:ui';
import 'package:alfa/Controller/bar.dart';
import 'package:alfa/Controller/reslutTrigger.dart';
import 'package:alfa/provider/shared.dart';
import 'package:alfa/view/widgets/main/Main_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Main_sidebar extends StatefulWidget {
  Main_sidebar({super.key});

  @override
  State<Main_sidebar> createState() => _Main_sidebarState();
}

class _Main_sidebarState extends State<Main_sidebar> {
  @override
  Widget build(BuildContext context) {
    final _bar = Provider.of<bar>(context, listen: false);
    final resTrigger = Provider.of<resultTrigger>(context);

    return RepaintBoundary(
      child: GestureDetector(
        child: AnimatedBuilder(
          animation: _bar,
          builder: (context, child) {
            return AnimatedContainer(
              width: _bar.bar_width,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(62, 68, 102, 1),
                  border: Border(
                      right: BorderSide(
                          color: Color.fromRGBO(179, 179, 179, 80)))),
              child: Column(children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              resTrigger.Trigger = false;
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Create a new file',
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.white.withOpacity(0),
                                padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        AnimatedOpacity(
                          child: Tooltip(
                            message: 'Close sidebar',
                            waitDuration: Duration(milliseconds: 300),
                            child: IconButton(
                              hoverColor: Colors.transparent,
                              color: Colors.white,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                _bar.bar_close();
                              },
                              icon: Icon(
                                Icons.menu_open_outlined,
                              ),
                            ),
                          ),
                          opacity: _bar.triger ? 0.0 : 1.0,
                          duration: _bar.triger
                              ? Duration(milliseconds: 100)
                              : Duration(milliseconds: 600),
                        )
                      ],
                    ),
                  ),
                ),
                Sized_bar(),
                Main_listview(),
                Sized_bar(),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 60,
                  width: 280,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(54, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        FutureBuilder(
                            future: DataManager.loadData('type'),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                // 에러가 발생한 경우
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Icon(
                                  Icons.person_outline,
                                  color: snapshot.data.toString() == '0'
                                      ? Colors.white
                                      : Color.fromRGBO(250, 250, 210, 1),
                                  size: 40,
                                );
                              }
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        FutureBuilder(
                            future: DataManager.loadData('id'),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasError) {
                                // 에러가 발생한 경우
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                );
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}

Widget Sized_bar() {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 15,
      ),
      Container(
        width: 200.0,
        height: 3.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
      ),
      SizedBox(
        height: 15,
      ),
    ],
  );
}
