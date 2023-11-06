import 'package:alfa/Provider/shared.dart';
import 'package:flutter/material.dart';
import 'package:vtable/vtable.dart';

Widget resultTabel(List<SampleRowData> items) {
  return createTable(items);
}

// var al_name1 = '';
VTable<SampleRowData> createTable(items) {
  DataManager.loadData('al_name1').then((value) {
    var al_name1 = value;
  });
  DataManager.loadData('al_casting1').then((value) {
    var al_casting1 = value;
  });

  return VTable<SampleRowData>(
    items: items,
    startsSorted: true,
    tableDescription: '${items.length} items',
    columns: [
      VTableColumn(
        label: '조성',
        width: 120,
        grow: 1,
      ),
      VTableColumn(
        label: '용체화 1차 (℃/h)',
        width: 120,
        grow: 1,
        transformFunction: (row) {
          return row.planet.gravity.toStringAsFixed(1) +
              "\t / \t" +
              row.planet.gravity.toStringAsFixed(1);
        },
        alignment: Alignment.centerRight,
        validators: [SampleRowData.validateGravity],
      ),
      VTableColumn(
        label: '용체화 2차 (℃/h)',
        width: 120,
        grow: 1,
        transformFunction: (row) {
          return row.planet.moons.toString() +
              '\t / \t' +
              row.planet.moons.toString();
        },
        alignment: Alignment.centerRight,
      ),
      VTableColumn(
        label: '시효경과처리',
        width: 120,
        grow: 1,
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
  Planet('Moon', 1.6, 0.384, 27.3, -20, 0),
  Planet('Mars', 3.7, 228, 687, -65, 2),
  Planet('Jupiter', 23.1, 778.5, 4331, -110, 92),
  Planet('Saturn', 9, 1432, 10747, -140, 83),
  Planet('Uranus', 8.7, 2867, 30589, -195, 27),
  Planet('Neptune', 11, 4515, 59800, -200, 14),
  Planet('Pluto', 0.7, 5906.4, 90560, -225, 5),
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
