import 'package:alfa/provider/shared.dart';
import 'package:flutter/material.dart';
import 'package:vtable/vtable.dart';

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
        width: 120,
        grow: 2,
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
          return row.result.first.sol2_deg +
              '\t / \t' +
              row.result.first.sol2_time;
        },
        alignment: Alignment.centerRight,
      ),
      VTableColumn(
        label: '냉각방법 2차',
        width: 120,
        grow: 0.5,
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

// const List<MainResult> heatTr = <MainResult> [
//   MainResult(DataManager.loadData('id'), casting, sol1_time, sol1_deg, quench, sol2_time, sol2_deg, age_time, age_deg),
// ];

Future<List<MainResult>> resultList() async {
  var data = await Future.wait([
    DataManager.loadData('al_name1'),
    DataManager.loadData('al_casting1'),
    DataManager.loadData('al_sol1_time1'),
    DataManager.loadData('al_sol1_deg1'),
    DataManager.loadData('al_quench1'),
    DataManager.loadData('al_sol2_time1'),
    DataManager.loadData('al_sol2_deg1'),
    DataManager.loadData('al_age_time1'),
    DataManager.loadData('al_age_dig1'),
  ]);

  return [
    MainResult(
      data[0],
      data[1],
      data[2],
      data[3],
      data[4],
      data[5],
      data[6],
      data[7],
      data[8],
    )
  ];
}

class MainResult {
  final String name;
  final String casting;
  final String sol1_time;
  final String sol1_deg;
  final String quench;
  final String sol2_time;
  final String sol2_deg;
  final String age_time;
  final String age_deg;

  const MainResult(
    this.name,
    this.casting,
    this.sol1_time,
    this.sol1_deg,
    this.quench,
    this.sol2_time,
    this.sol2_deg,
    this.age_time,
    this.age_deg,
  );

  @override
  String toString() => name;
}

class ReulstRowData {
  final List<MainResult> result;

  ReulstRowData({required this.result});

  // static ValidationResult? validateGravity(ReulstRowData row) {
  //   if (row.result.gravity > 20.0) {
  //     return ValidationResult.error('too heavy!');
  //   }
  //   if (row.result.gravity > 10.0) {
  //     return ValidationResult.warning('pretty heavy');
  //   }
  //   return null;
  // }

  @override
  String toString() => '$result';
}
