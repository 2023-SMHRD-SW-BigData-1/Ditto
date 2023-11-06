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
      ),
      VTableColumn(
        label: '용체화 1차 (℃/h)',
        width: 120,
        grow: 0.5,
        transformFunction: (row) {
          return row.result.gravity.toStringAsFixed(1) +
              "\t / \t" +
              row.result.gravity.toStringAsFixed(1);
        },
        alignment: Alignment.centerRight,
        validators: [ReulstRowData.validateGravity],
      ),
      VTableColumn(
        label: '냉각방법 1차',
        width: 120,
        grow: 0.5,
        alignment: Alignment.centerRight,
      ),
      VTableColumn(
        label: '용체화 2차 (℃/h)',
        width: 120,
        grow: 0.5,
        transformFunction: (row) {
          return row.result.moons.toString() +
              '\t / \t' +
              row.result.moons.toString();
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
        transformFunction: (row) => row.result.temp.toString(),
        alignment: Alignment.centerRight,
      ),
    ],
  );
}

const String loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
    'tempor incididunt ut labore et dolore magna aliqua.';

const List<MainResult> planets = <MainResult>[
  MainResult('Mercury', 3.7, 57.9, 88, 167, 0),
  MainResult('Venus', 8.9, 108.2, 224.7, 464, 0),
  MainResult('Earth', 9.8, 149.6, 365.2, 15, 1),
];

class MainResult {
  final String name;
  final String casting;
  final int sol1_time;
  final double sol1_deg;
  final String quench;
  final int sol2_time;
  final double sol2_deg;
  final int age_time;
  final double age_deg;

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
  final MainResult result;

  ReulstRowData({required this.result});

  static ValidationResult? validateGravity(ReulstRowData row) {
    if (row.result.gravity > 20.0) {
      return ValidationResult.error('too heavy!');
    }
    if (row.result.gravity > 10.0) {
      return ValidationResult.warning('pretty heavy');
    }
    return null;
  }

  @override
  String toString() => '$result';
}
