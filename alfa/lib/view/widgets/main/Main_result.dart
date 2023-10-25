import 'package:flutter/material.dart';
import 'package:editable/editable.dart';

class Main_result extends StatefulWidget {
  const Main_result({super.key});

  @override
  State<Main_result> createState() => _Main_resultState();
}

class _Main_resultState extends State<Main_result> {
  final _editableKey = GlobalKey<EditableState>();

  @override
  Widget build(BuildContext context) {
    List cols = [
      {"title": 'Name', 'widthFactor': 0.2, 'key': 'name'},
      {"title": 'Date', 'widthFactor': 0.1, 'key': 'date'},
      {"title": 'Month', 'widthFactor': 0.1, 'key': 'month'},
      {"title": 'Status', 'key': 'status'},
    ];
    List rows = [
      {
        "name": 'James Joe',
        "date": '23/09/2020',
        "month": 'June',
        "status": 'completed'
      },
      {
        "date": '12/4/2020',
        "month": 'March',
        "name": 'Daniel Paul',
        "status": 'new'
      },
    ];
    return Editable(
      key: _editableKey, //Assign Key to Widget
      columns: cols,
      rows: rows,
      borderColor: Colors.blueGrey,
    );
  }
}

Widget titleText(String Title) {
  return Text(
    Title,
    style: TextStyle(fontSize: 18),
  );
}
