import 'package:alfa/provider/shared.dart';
import 'package:flutter/material.dart';
import 'package:vtable/vtable.dart';
import 'package:alfa/provider/shared.dart';

Widget resultTabel(List<ReulstRowData> items) {
  return createTable(items);
}

VTable<ReulstRowData> createTable(items) {
  return VTable<ReulstRowData>(
    items: items,
    startsSorted: false,
    tableDescription: '${items.length} items',
    columns: [
      VTableColumn(
        label: '정확도',
        width: 30,
        grow: 1,
        transformFunction: (row) {
          return row.result.first.percentage.toString() + '%';
        },
      ),
      VTableColumn(
        label: '조성',
        width: 150,
        grow: 3,
        transformFunction: (row) {
          return row.result.first.name.toString();
        },
      ),
      VTableColumn(
        label: 'Casting',
        width: 50,
        grow: 0.5,
        alignment: Alignment.centerRight,
        transformFunction: (row) {
          return row.result.first.casting.toString();
        },
      ),
      VTableColumn(
        label: '용체화 1차 (℃/h)',
        width: 110,
        grow: 0.5,
        transformFunction: (row) {
          return row.result.first.sol1_deg.toString() +
              "\t / \t" +
              row.result.first.sol1_time.toString();
        },
        alignment: Alignment.centerRight,
      ),
      VTableColumn(
        label: '냉각방법 1차',
        width: 80,
        grow: 0.5,
        alignment: Alignment.centerRight,
        transformFunction: (row) => row.result.first.quench,
      ),
      VTableColumn(
        label: '용체화 2차 (℃/h)',
        width: 110,
        grow: 0.5,
        transformFunction: (row) {
          return row.result.first.sol2_deg.toString() +
              '\t / \t' +
              row.result.first.sol2_time.toString();
        },
        alignment: Alignment.centerRight,
      ),
      VTableColumn(
        label: '냉각방법 2차',
        width: 80,
        grow: 0.5,
        transformFunction: (row) {
          return row.result.first.quench2.toString();
        },
        alignment: Alignment.centerRight,
      ),
      VTableColumn(
        label: '시효경과처리 (℃/h)',
        width: 120,
        grow: 0.5,
        transformFunction: (row) {
          return row.result.first.age_deg.toString() +
              '\t / \t' +
              row.result.first.age_time.toString();
        },
        alignment: Alignment.centerRight,
      ),
    ],
    rowHeight: 60,
  );
}

const String loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
    'tempor incididunt ut labore et dolore magna aliqua.';

Future<List<MainResult>> resultList() async {
  var data = await DataManager.loadArray('finalResultKey');

  if (data is List) {
    // 데이터를 MainResult 객체로 변환합니다.
    return List<MainResult>.from(data.map((item) {
      return MainResult(item[0], item[2], item[3], item[4], item[5], item[6],
          item[7], item[8], item[9], item[10], item[11]);
    }));
  } else {
    throw Exception('Data is not in the expected format or is incomplete.');
  }
}

class MainResult {
  final int percentage;
  final String name;
  final String casting;
  final int sol1_deg;
  final int sol1_time;
  final String quench;
  final int sol2_deg;
  final int sol2_time;
  final String quench2;
  final int age_deg;
  final int age_time;

  const MainResult(
    this.percentage,
    this.name,
    this.casting,
    this.sol1_deg,
    this.sol1_time,
    this.quench,
    this.sol2_deg,
    this.sol2_time,
    this.quench2,
    this.age_deg,
    this.age_time,
  );

  @override
  String toString() => name;
}

class ReulstRowData {
  final List<MainResult> result;
  ReulstRowData({required this.result});
  @override
  String toString() => '$result';
}
