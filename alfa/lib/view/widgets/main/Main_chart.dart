import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:alfa/provider/shared.dart';
import 'package:tuple/tuple.dart';

class Main_chart extends StatefulWidget {
  const Main_chart({super.key});

  @override
  State<Main_chart> createState() => _Main_chartState();
}

class _Main_chartState extends State<Main_chart> {
  late TooltipBehavior _tooltipBehavior;

  Future<List<ChartData>> fetchChartData() async {
    Tuple2<List<double>, List<String>> result = await parseData();
    List<double> numbers = result.item1; // 숫자 리스트
    List<String> elements = result.item2; // 요소 이름 리스트

    double sum = numbers.reduce((value, element) => value + element);
    double num1 = sum - 100;
    double num2 = 100 - num1;
    numbers[0] = num2;

    final List<ChartData> chartData = [];
    for (int i = 0; i < numbers.length; i++) {
      chartData.add(ChartData(elements[i], numbers[i]));
    }

    return chartData;
  }

  Tuple2<List<double>, List<String>> parse(String text) {
    List<double> numbers = [100];
    List<String> elements = ['Al'];
    RegExp regex = RegExp(r'(\d+\.\d+)\s+([A-Za-z]+)');
    List<Match> matches = regex.allMatches(text).toList();

    for (Match match in matches) {
      numbers.add(double.parse(match.group(1)!));
      elements.add(match.group(2)!);
    }

    return Tuple2(numbers, elements);
  }

  Future<Tuple2<List<double>, List<String>>> parseData() async {
    var data = await DataManager.loadArray('finalResultKey');
    print('data? : ${data[0]}');

    Tuple2<List<double>, List<String>> result = parse(data[0][2]);
    return result;
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true, animationDuration: Duration.millisecondsPerSecond);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChartData>>(
      future: fetchChartData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 로딩 중 표시
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final chartData = snapshot.data;
          return SizedBox(
            width: 500,
            height: 500,
            child: SfCircularChart(
              tooltipBehavior: _tooltipBehavior,
              legend: Legend(isVisible: true),
              series: <CircularSeries>[
                DoughnutSeries<ChartData, String>(
                  dataSource: chartData,
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelMapper: (ChartData data, _) => data.y.toString(),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

class MainResult {
  final String name;

  const MainResult(this.name);

  @override
  String toString() => name;
}
