import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:alfa/server/dio.dart';

class Main_listview extends StatefulWidget {
  const Main_listview({super.key});

  @override
  State<Main_listview> createState() => _Main_listviewState();
}

class _Main_listviewState extends State<Main_listview> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      load();
    });
  }

  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('report');
    if (jsonData != null) {
      List<dynamic> loadedData = json.decode(jsonData);
      List<Map<String, dynamic>> listData =
          loadedData.cast<Map<String, dynamic>>();
      setState(() {
        data = listData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return SizedBox(
      height: 775,
      child: OverflowBox(
        minWidth: 200,
        maxWidth: 300,
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final element = data[index];
            return Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(62, 68, 102, 1),
                    elevation: 0),
                onPressed: () {
                  server.report1(element['researchDate'].toString());
                },
                child: ListTile(
                  title: Text(
                    element['researchDate']
                        .toString(), // 가정하여 'date' 키를 사용했습니다.
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
