import 'dart:ui';

import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Main_sidebar extends StatefulWidget {
  Main_sidebar({
    super.key,
    required this.bar_width,
    required this.triger,
  });

  double bar_width;
  int triger;

  @override
  State<Main_sidebar> createState() => _Main_sidebarState();
}

class _Main_sidebarState extends State<Main_sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.bar_width,
      decoration: BoxDecoration(
          color: Color.fromARGB(82, 158, 158, 158).withOpacity(0.15),
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
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.bar_width = 0;
                    });
                  },
                  icon: Icon(
                    Icons.menu,
                  ))
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
