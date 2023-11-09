import 'package:alfa/provider/shared.dart';
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

  // void load() {
  //   pay = DataManager.loadArray2('payInfo');
  //   print('pay');
  //   print(pay);
  //   List<Map<String, dynamic>> yap = pay[1];
  // }

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
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Shared Preferences Example'),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text('Loaded Data:'),
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: data.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return ListTile(
  //                   title: Text('Date: ${data[index]['pay_date']}'),
  //                   subtitle: Text('Price: ${data[index]['pay_price']}'),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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

              bool showDateHeader = true;
              if (index > 0) {
                final previousElement = sortedElements[index - 1];
                if (previousElement.date.year == element.date.year &&
                    previousElement.date.month == element.date.month &&
                    previousElement.date.day == element.date.day) {
                  showDateHeader = false;
                }
              }

              return Column(
                children: [
                  if (showDateHeader) _getGroupSeparator(element),
                  _getItem(context, element)
                ],
              );
            }),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return SizedBox(
  //     height: 775,
  //     child: OverflowBox(
  //       minWidth: 200,
  //       maxWidth: 300,
  //       child: ListView.builder(
  //           itemCount: sortedElements.length,
  //           itemBuilder: (context, index) {
  //             final element = sortedElements[index];

  //             bool showDateHeader = true;
  //             if (index > 0) {
  //               final previousElement = sortedElements[index - 1];
  //               if (previousElement.date.year == element.date.year &&
  //                   previousElement.date.month == element.date.month &&
  //                   previousElement.date.day == element.date.day) {
  //                 showDateHeader = false;
  //               }
  //             }

  //             return Column(
  //               children: [
  //                 if (showDateHeader) _getGroupSeparator(element),
  //                 _getItem(context, element)
  //               ],
  //             );
  //           }),
  //     ),
  //   );
  // }
}

class Element {
  DateTime date;
  String name;
  IconData icon;

  Element(this.date, this.name, this.icon);
}

List<Element> _elements = <Element>[
  Element(DateTime(2020, 6, 23, 18), 'Got to gym', Icons.fitness_center),
  Element(DateTime(2020, 6, 23, 9), 'Work', Icons.work),
];

Widget _getGroupSeparator(Element element) {
  return SizedBox(
    child: Container(
      width: double.infinity,
      color: Color.fromRGBO(62, 68, 102, 1),
      child: Text(
        '${element.date.month}. ${element.date.day}',
        style: TextStyle(color: Color.fromRGBO(142, 142, 160, 1)),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _getItem(BuildContext ctx, Element element) {
  return Container(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(62, 68, 102, 1), elevation: 0),
      onPressed: () {},
      child: ListTile(
        title: Text(
          element.name,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    ),
  );
}
