import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
