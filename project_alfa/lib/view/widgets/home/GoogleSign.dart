import 'package:flutter/material.dart';

class GoogleSign extends StatelessWidget {
  const GoogleSign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 400.0,
      child: Column(
        children: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close))
        ],
      ),
    );
  }
}
