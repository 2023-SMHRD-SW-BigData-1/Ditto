import 'package:flutter/material.dart';
import 'package:vtable/vtable.dart';

Widget resultTabel(List<SampleRowData> items) {
  return createTable(items);
}

VTable<SampleRowData> createTable(items) {
  return VTable<SampleRowData>(
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
          return row.planet.gravity.toStringAsFixed(1) +
              "\t / \t" +
              row.planet.gravity.toStringAsFixed(1);
        },
        alignment: Alignment.centerRight,
        validators: [SampleRowData.validateGravity],
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
          return row.planet.moons.toString() +
              '\t / \t' +
              row.planet.moons.toString();
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
        transformFunction: (row) => row.planet.temp.toString(),
        alignment: Alignment.centerRight,
      ),
    ],
  );
}

const String loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
    'tempor incididunt ut labore et dolore magna aliqua.';

const List<Planet> planets = <Planet>[
  Planet('Mercury', 3.7, 57.9, 88, 167, 0),
  Planet('Venus', 8.9, 108.2, 224.7, 464, 0),
  Planet('Earth', 9.8, 149.6, 365.2, 15, 1),
];

class Planet {
  final String name;
  final double gravity;
  final double orbit;
  final double period;
  final int temp;
  final int moons;

  const Planet(
    this.name,
    this.gravity,
    this.orbit,
    this.period,
    this.temp,
    this.moons,
  );

  @override
  String toString() => name;
}

class SampleRowData {
  final Planet planet;

  SampleRowData({required this.planet});

  static ValidationResult? validateGravity(SampleRowData row) {
    if (row.planet.gravity > 20.0) {
      return ValidationResult.error('too heavy!');
    }
    if (row.planet.gravity > 10.0) {
      return ValidationResult.warning('pretty heavy');
    }
    return null;
  }

  @override
  String toString() => '$planet';
}
