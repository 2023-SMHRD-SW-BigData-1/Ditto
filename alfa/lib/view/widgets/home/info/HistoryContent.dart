import 'package:flutter/material.dart';

class HistoryContent extends StatefulWidget {
  const HistoryContent({super.key});

  @override
  State<HistoryContent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HistoryContent> {
  var tableRow = TableRow();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 700,
        child: PaginatedDataTable(
            rowsPerPage: 10,
            columns: <DataColumn>[
              DataColumn(label: TitleText('거래일자')),
              DataColumn(label: TitleText('결제금액')),
            ],
            source: tableRow));
  }
}

class TableRow extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('Cell $index')),
      DataCell(Text('Cell $index')),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => true;

  @override
  // TODO: implement rowCount
  int get rowCount => 10;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

Widget TitleText(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  );
}
