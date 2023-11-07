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
    startsSorted: true,
    tableDescription: '${items.length} items',
    columns: [
      VTableColumn(
        label: '조성',
        width: 150,
        grow: 2,
        transformFunction: (row) {
          return row.result.first.name.toString();
        },
      ),
      VTableColumn(
        label: 'Casting',
        width: 120,
        grow: 0.5,
        alignment: Alignment.centerRight,
        transformFunction: (row) {
          return row.result.first.casting.toString();
        },
      ),
      VTableColumn(
        label: '용체화 1차 (℃/h)',
        width: 120,
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
        width: 120,
        grow: 0.5,
        alignment: Alignment.centerRight,
        transformFunction: (row) => row.result.first.quench,
      ),
      VTableColumn(
        label: '용체화 2차 (℃/h)',
        width: 120,
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
        width: 120,
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
      return MainResult(item[1], item[2], item[3], item[4], item[5], item[6],
          item[7], item[8], item[9], item[10]);
    }));
  } else {
    throw Exception('Data is not in the expected format or is incomplete.');
  }
}

class MainResult {
  final String name;
  final String casting;
  final int sol1_time;
  final int sol1_deg;
  final String quench;
  final int sol2_time;
  final int sol2_deg;
  final String quench2;
  final int age_time;
  final int age_deg;

  const MainResult(
    this.name,
    this.casting,
    this.sol1_time,
    this.sol1_deg,
    this.quench,
    this.sol2_time,
    this.sol2_deg,
    this.quench2,
    this.age_time,
    this.age_deg,
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
