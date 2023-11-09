import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:alfa/provider/shared.dart';

class Main_bchart2 extends StatefulWidget {
  const Main_bchart2({super.key});

  @override
  State<Main_bchart2> createState() => Main_bchartState();
}

class Main_bchartState extends State<Main_bchart2> {
  late TooltipBehavior _tooltipBehavior;

  Future<List<ChartData>> loadArr() async {
    var data = await DataManager.loadArray('finalResultKey');
    print(data);
    // final List<ChartData> chartData;
    List<ChartData> chartData = <ChartData>[
      ChartData('용체화1차 (℃/h)', data[0][4], data[0][5]),
      ChartData('용체화2차 (℃/h)', data[0][7], data[0][8]),
      ChartData('시효경화처리 (℃/h)', data[0][10], data[0][11])
    ];

    return await chartData;
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
        future: loadArr(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return Text('');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final chartData = snapshot.data;
            return SizedBox(
              width: 500,
              height: 300,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0.7,
                title: ChartTitle(text: ''),
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                    maximum: 600,
                    minimum: 0,
                    interval: 50,
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0)),
                series: <ColumnSeries>[
                  ColumnSeries<ChartData, String>(
                    /// To apply the column width here.
                    dataSource: chartData!,
                    width: 0.8,

                    /// To apply the spacing betweeen to two columns here.
                    spacing: 0.2,
                    color: Color.fromRGBO(182, 24, 24, 1),
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    name: '온도',
                    dataLabelMapper: (ChartData data, _) =>
                        '온도 : ' + data.y.toString(),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                  ),
                  ColumnSeries<ChartData, String>(
                    dataSource: chartData,
                    width: 0.8,
                    spacing: 0.2,
                    color: Color.fromRGBO(62, 68, 102, 1),
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.z,
                    name: '시간',
                    dataLabelMapper: (ChartData data, _) =>
                        '시간 : ' + data.z.toString(),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                  ),
                ],
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
              ),
            );
          }
        });
  }
}

class ChartData {
  ChartData(this.x, this.y, this.z);

  final dynamic x;
  final double y;
  final double z;
}

class MainResult {
  final String name;

  const MainResult(this.name);

  @override
  String toString() => name;
}
