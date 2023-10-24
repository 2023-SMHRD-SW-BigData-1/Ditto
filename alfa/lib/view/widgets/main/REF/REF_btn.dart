import 'package:flutter/material.dart';

Widget REF_btn() {
  return ElevatedButton(
    onPressed: () {},
    child: Text(
      'REF',
      style: TextStyle(color: Colors.black),
    ),
    style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10))),
  );
}
