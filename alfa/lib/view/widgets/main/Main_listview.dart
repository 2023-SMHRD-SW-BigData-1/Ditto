import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Main_listview extends StatefulWidget {
  const Main_listview({super.key});

  @override
  State<Main_listview> createState() => _Main_listviewState();
}

class _Main_listviewState extends State<Main_listview> {
  List<Map<String, dynamic>> data = [];
  late List<Element> sortedElements;
  late Future<List<dynamic>> pay;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      load();
    });
    sortedElements = _elements..sort((a, b) => b.date.compareTo(a.date));
  }

  Future load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData =
        prefs.getString('payInfo')!; // 'myDataKey'는 데이터를 식별하는 키입니다.
    print(jsonData);
    if (jsonData != null) {
      List<Map<String, dynamic>> loadedData =
          (json.decode(jsonData) as List).cast<Map<String, dynamic>>();
      setState(() {
        data = loadedData;
      });
      print('jsonData');
      print(data);
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 775,
      child: OverflowBox(
        minWidth: 200,
        maxWidth: 300,
        child: ListView.builder(
            itemCount: sortedElements.length,
            itemBuilder: (context, index) {
              final element = sortedElements[index];
              return Column(children: [_getItem(context, element)]);
            }),
      ),
    );
  }
}

class Element {
  DateTime date;
  Element(this.date);
}

List<Element> _elements = <Element>[
  Element(DateTime(2020, 6, 23, 18)),
  Element(DateTime(2020, 6, 23, 9)),
];

Widget _getItem(BuildContext ctx, Element element) {
  return Container(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(62, 68, 102, 1), elevation: 0),
      onPressed: () {
        // 이전기록 눌렀을때 함수
      },
      child: ListTile(
        title: Text(
          element.date.toString(),
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    ),
  );
}
