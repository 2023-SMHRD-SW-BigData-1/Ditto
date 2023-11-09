import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryContent extends StatefulWidget {
  const HistoryContent({super.key});

  @override
  State<HistoryContent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HistoryContent> {
  List<Map<String, dynamic>> data = [];
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
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 700,
        child: PaginatedDataTable(
          rowsPerPage: 10,
          columns: <DataColumn>[
            DataColumn(
                label: Text('거래일자',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
            DataColumn(
                label: Text('결제금액',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
          ],
          source: CustomDataTableSource(data),
        ));
  }
}

class CustomDataTableSource extends DataTableSource {
  final List<dynamic> _data;

  CustomDataTableSource(this._data);

  @override
  DataRow getRow(int index) {
    if (index >= _data.length) {
      return DataRow.byIndex(index: index, cells: const [
        DataCell(Text('')),
        DataCell(Text('')),
      ]);
    }
    final item = _data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(item['pay_date']?.toString() ?? 'N/A')),
        DataCell(Text(item['pay_price']?.toString() ?? 'N/A')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}

Widget TitleText(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  );
}
