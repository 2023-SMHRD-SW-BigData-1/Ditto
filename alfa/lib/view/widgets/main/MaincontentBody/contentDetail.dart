// import 'dart:typed_data';

// import 'package:alfa/view/widgets/main/Main_result.dart';
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class contentDetail extends StatefulWidget {
//   const contentDetail({Key? key});

//   @override
//   State<contentDetail> createState() => _contentDetailState();
// }

// class _contentDetailState extends State<contentDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Center(
//             child: Container(
//                 margin: EdgeInsets.all(30),
//                 padding: EdgeInsets.all(50),
//                 width: 1500,
//                 height: 700,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         color: Color.fromRGBO(62, 68, 102, 1), width: 2),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: resultTabel(generateRowData(planets.length))),
//           )
//         ],
//       ),
//     );
//   }
// }

// List<SampleRowData> generateRowData(int rows) {
//   return List.generate(rows, (index) {
//     return SampleRowData(
//       planet: planets[index],
//     );
//   });
// }

// pw.Document buildPdf(Uint8List imageBytes) {
//   final pdf = pw.Document();
//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.a4.landscape,
//       build: (pw.Context context) {
//         return pw.Center(
//             child: pw.Container(
//                 child: pw.Column(children: [
//           pw.Image(
//               pw.MemoryImage(
//                 imageBytes,
//               ),
//               fit: pw.BoxFit.contain),
//         ])));
//       },
//     ),
//   );
//   return pdf;
// }
