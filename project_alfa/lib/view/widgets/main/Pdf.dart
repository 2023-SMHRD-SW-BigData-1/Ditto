import 'package:flutter/material.dart';

Widget PDF_btn() {
  return ElevatedButton(
    onPressed: () {},
    child: Text(
      'PDF',
      style: TextStyle(color: Colors.black),
    ),
    style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10))),
  );
}
