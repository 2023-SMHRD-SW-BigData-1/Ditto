import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    cardColor: Colors.white,
    fontFamily: "NotoSansKR",
    splashColor: Colors.transparent,
    highlightColor: const Color.fromARGB(0, 255, 255, 255),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      splashColor: Colors.transparent,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
      ),
    ),
  );
}
