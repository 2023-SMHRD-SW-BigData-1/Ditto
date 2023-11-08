import 'dart:typed_data';
import 'package:alfa/Controller/bar.dart';
import 'package:alfa/Controller/reslutTrigger.dart';
import 'package:alfa/get_pages.dart';
import 'package:alfa/provider/shared.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:alfa/view/widgets/main/Main_barChart.dart';
import 'package:alfa/view/widgets/main/Main_chart.dart';
import 'package:alfa/view/widgets/main/Main_input.dart';
import 'package:alfa/view/widgets/main/Main_result.dart';
import 'package:alfa/view/widgets/main/Main_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBody(),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> with TickerProviderStateMixin {
  final screenshotController = ScreenshotController();
  bool isLoading = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 20),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    Size screenSize = deviceData.size;
    final _bar = Provider.of<bar>(context);
    final resTrigger = Provider.of<resultTrigger>(context);
    return SafeArea(
        child: Stack(children: [
      Container(
        decoration: BoxDecoration(),
        width: screenSize.width,
        height: screenSize.height,
        child: Row(
          children: <Widget>[
            Main_sidebar(),
            Expanded(
                child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedOpacity(
                          // ignore: sort_child_properties_last
                          child: Tooltip(
                            message: 'Open sidebar',
                            waitDuration: Duration(milliseconds: 300),
                            child: IconButton(
                                constraints: BoxConstraints(),
                                onPressed: () {
                                  _bar.bar_open();
                                },
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                )),
                          ),
                          opacity: _bar.triger ? 1.0 : 0.0,
                          duration: _bar.triger
                              ? Duration(milliseconds: 500)
                              : Duration(milliseconds: 100),
                        ),
                        TextButton(
                            onPressed: () =>
                                Get.rootDelegate.toNamed(Routes.HOME),
                            child: Text(
                              'AL.F.A',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(62, 68, 102, 1),
                                fontSize: 40,
                              ),
                            )),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            Uint8List? screenshotBytes =
                                await screenshotController.capture();
                            if (screenshotBytes != null) {
                              try {
                                final pdfDocument = await buildPdf(
                                    screenshotBytes); // buildPdf 함수를 await로 호출
                                final pdfBytes = await pdfDocument
                                    .save(); // save 함수를 await로 호출

                                await Printing.layoutPdf(
                                    onLayout: (PdfPageFormat format) async =>
                                        pdfBytes); // 바이트를 직접 전달
                              } catch (e) {
                                print('PDF 생성 실패: $e');
                              }
                            } else {
                              print('스크린샷 캡쳐 실패');
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            'PDF',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.center,
                              elevation: 0,
                              backgroundColor: Colors.white.withOpacity(0),
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(10))),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Screenshot(
                              controller: screenshotController,
                              child: Column(
                                children: <Widget>[
                                  resTrigger.Trigger
                                      ? FutureBuilder(
                                          future: generateRowData(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<List<ReulstRowData>>
                                                  snapshot) {
                                            if (snapshot.hasData == false) {
                                              return AnimatedBuilder(
                                                animation: _controller,
                                                child: Container(
                                                  child: Image.asset(
                                                    'assets/image/Logo_icon.png',
                                                    width: 300,
                                                  ),
                                                ),
                                                builder: (BuildContext context,
                                                    Widget? child) {
                                                  return Transform.rotate(
                                                    angle: _controller.value *
                                                        2.0 *
                                                        3.1415926535897932,
                                                    child: child,
                                                  );
                                                },
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              List<ReulstRowData> myData =
                                                  snapshot.data!;
                                              return Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color.fromRGBO(
                                                            62, 68, 102, 1),
                                                        width: 3),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                width: 1500,
                                                height: 700,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 1400,
                                                      height: 350,
                                                      child:
                                                          resultTabel(myData),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Main_chart(),
                                                        SizedBox(
                                                          width: 50,
                                                        ),
                                                        SizedBox(
                                                          width: 550,
                                                          height: 300,
                                                          child:
                                                              Main_barChart(),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                        )
                                      : Column(
                                          children: [
                                            AnimatedBuilder(
                                              animation: _controller,
                                              child: Container(
                                                child: Image.asset(
                                                  'assets/image/Logo_icon.png',
                                                  width: 300,
                                                ),
                                              ),
                                              builder: (BuildContext context,
                                                  Widget? child) {
                                                return Transform.rotate(
                                                  angle: _controller.value *
                                                      2.0 *
                                                      3.1415926535897932,
                                                  child: child,
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Text(
                                              '이 결과 창의 예측치는 단순히 정답과 유사한 값을 제공하는 것이며, 이를 기업의 필요에 맞게 조정된 비율로 활용하시기를 권장합니다.\n기업의 요구사항에 따라 예측치를 조정함으로써 효과적인 의사결정과 전략 수립에 도움을 드릴 것이며,\n이러한 데이터를 최대한 활용하여 긍정적인 결과를 얻을 수 있을 것입니다.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  Main_input()
                ],
              ),
            ))
          ],
        ),
      ),
      if (isLoading)
        Positioned.fill(
          child: Container(
            color: Colors.black38, // 반투명 배경
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
    ]));
  }
}

Future<List<ReulstRowData>> generateRowData() async {
  // resultList() 함수로부터 결과를 가져옵니다.
  var results = await resultList(); // resultList 함수가 정의되어 있어야 합니다.
  // 결과 리스트의 각 항목에 대해 ReulstRowData 객체를 생성합니다.
  return results.map((result) => ReulstRowData(result: [result])).toList();
}

Future<Uint8List> loadImageBytes(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  return byteData.buffer.asUint8List();
}

Future<pw.Document> buildPdf(Uint8List imageBytes) async {
  final pdf = pw.Document();
  final logoBytes = await loadImageBytes('assets/image/Logo.png');
  var name = ''; // 로고 이미지 로드
  await DataManager.loadData('name').then((value) {
    name = value;
  });
  List date = [];
  await DataManager.loadArray('finalRulstKey').then((value) {
    date = value;
  });
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4.landscape,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Container(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(name),
                pw.Image(
                    width: 150,
                    pw.MemoryImage(logoBytes),
                    fit: pw.BoxFit.contain),
                pw.Text(date[0]),
                pw.SizedBox(height: 20),
                pw.Image(pw.MemoryImage(imageBytes),
                    fit: pw.BoxFit.contain), // 전달받은 이미지 사용
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [pw.Text('© 2023 Metamong. All rights reserved.')],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
  return pdf;
}
