import 'dart:ui';

import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:project_alfa/provider/bar.dart';
import 'package:project_alfa/view/page/Main.dart';
import 'package:provider/provider.dart';

class Main_sidebar extends StatefulWidget {
  Main_sidebar({super.key});

  @override
  State<Main_sidebar> createState() => _Main_sidebarState();
}

class _Main_sidebarState extends State<Main_sidebar> {
  @override
  Widget build(BuildContext context) {
    final _bar = Provider.of<bar>(context);
    return Container(
      width: _bar.bar_width,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 106, 96, 96).withOpacity(0.15),
          border: Border(right: BorderSide(color: Colors.black))),
      child: Column(children: [
        Container(
          height: 50,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Create a new folder',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white.withOpacity(0),
                    padding: EdgeInsets.fromLTRB(10, 10, 40, 10),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10))),
              ),
              Tooltip(
                message: 'Close',
                waitDuration: Duration(milliseconds: 300),
                child: IconButton(
                  onPressed: () {
                    _bar.bar_close();
                  },
                  icon: Icon(
                    Icons.menu,
                  ),
                ),
              )
            ],
          ),
        ),
        Sized_bar(),
        Expanded(
            child: SingleChildScrollView(
          child: Column(),
        )),
        Sized_bar(),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: 150,
          width: 280,
          decoration: BoxDecoration(
              color: Colors.grey[600], borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: 5,
        )
      ]),
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
            color: Colors.grey[600], borderRadius: BorderRadius.circular(10)),
      ),
      SizedBox(
        height: 15,
      ),
    ],
  );
}