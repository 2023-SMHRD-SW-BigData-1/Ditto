import 'package:flutter/material.dart';

class Main_listview extends StatefulWidget {
  const Main_listview({super.key});

  @override
  State<Main_listview> createState() => _Main_listviewState();
}

class _Main_listviewState extends State<Main_listview> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: 10, // 예시
      itemBuilder: (context, index) {
        return Container();
      },
    ));
  }
}


// list 만들어주세요