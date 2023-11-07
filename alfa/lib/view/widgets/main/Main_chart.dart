import 'package:alfa/view/widgets/main/Main_result.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:alfa/provider/shared.dart';

class Main_chart extends StatefulWidget {
  const Main_chart({super.key});

  @override
  State<Main_chart> createState() => _Main_chartState();
}

class _Main_chartState extends State<Main_chart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true, animationDuration: Duration.millisecondsPerSecond);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<double> extractNumbersInsideParentheses(String text) {
    //   List<double> numbers = [];
    //   RegExp regex = RegExp(r'\d+\.\d+');
    //   Iterable<Match> matches = regex.allMatches(text);

    //   for (Match match in matches) {
    //     String matchText = match.group(0)!;
    //     try {
    //       double number = double.parse(matchText);
    //       numbers.add(number);
    //       print('check : $numbers');
    //     } catch (e) {
    //       // 파싱 에러가 발생하면 무시
    //     }
    //   }

    //   return numbers;
    // }

    // Future<List<MainResult>> resultList() async {
    //   var data = await DataManager.loadArray('finalResultKey');

    //   // if (data is List) {
    //   // 데이터를 MainResult 객체로 변환합니다.
    //   return List<MainResult>.from(data.map((item) {
    //     void ext() {
    //       List<double> numbers = extractNumbersInsideParentheses(item[1]);

    //       print(numbers);

    //       // for (double number in numbers) {
    //       //   print('check : $number');
    //       // }
    //     }

    //     ext();

    //     return MainResult(item[1]);
    //   }));
    //   // } else {
    //   //   throw Exception('Data is not in the expected format or is incomplete.');
    //   // }
    // }

    final List<ChartData> chartData = [
      ChartData('Al', 93.12, "55%", Color.fromRGBO(67, 79, 149, 1)),
      ChartData('Cu', 4.5, "31%", Color.fromRGBO(182, 24, 24, 1)),
      ChartData('Si', 1.0, "7.7%", Color.fromRGBO(228, 0, 124, 1)),
      ChartData('Mg', 0.0, "3.7%", Color.fromRGBO(255, 189, 57, 1)),
    ];
    return SizedBox(
        width: 500,
        height: 500,
        child: SfCircularChart(
            tooltipBehavior: _tooltipBehavior,
            legend: Legend(isVisible: true),
            series: <CircularSeries>[
              // Renders doughnut chart
              DoughnutSeries<ChartData, String>(
                  dataSource: chartData,
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x as String,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelMapper: (ChartData data, _) => data.y.toString(),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                  ))
            ]));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.text, [this.color]);
  final String x;
  final double y;
  final String text;
  final Color? color;
}

class MainResult {
  final String name;

  const MainResult(this.name);

  @override
  String toString() => name;
}
