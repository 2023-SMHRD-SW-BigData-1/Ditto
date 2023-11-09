import 'package:alfa/Controller/reslutTrigger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      loadData();
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

  Future<List<Map<String, dynamic>>> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('report');
    if (jsonData != null) {
      List<dynamic> loadedData = json.decode(jsonData);
      return loadedData.cast<Map<String, dynamic>>();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final resTrigger = Provider.of<resultTrigger>(context);
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return Text('');
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // 에러 발생시
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> data = snapshot.data ?? [];
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
                        elevation: 0,
                      ),
                      onPressed: () async {
                        await server
                            .report1(element['researchDate'].toString());
                        resTrigger.Trigger = true;
                      },
                      child: ListTile(
                        title: Text(
                          element['researchDate'].toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}
