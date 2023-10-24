import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Color.fromRGBO(62, 68, 102, 1),
      ),
      child: Text(
        "Footer",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
