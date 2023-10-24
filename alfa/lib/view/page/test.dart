// import 'package:flutter/material.dart';
// import 'package:project_alfa/provider/bar.dart';
// import 'package:project_alfa/view/widgets/main/Main_sidebar.dart';
// import 'package:project_alfa/view/widgets/main/PDF/Pdf.dart';
// import 'package:provider/provider.dart';

// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   State<Test> createState() => _MainState();
// }

// class _MainState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MainBody(),
//     );
//   }
// }

// class MainBody extends StatefulWidget {
//   const MainBody({
//     super.key,
//   });

//   @override
//   State<MainBody> createState() => _MainBodyState();
// }

// class _MainBodyState extends State<MainBody> {
//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData deviceData = MediaQuery.of(context);
//     Size screenSize = deviceData.size;
//     final _bar = Provider.of<bar>(context);
//     return SafeArea(
//         child: Container(
//       width: screenSize.width,
//       height: screenSize.height,
//       child: Row(
//         children: <Widget>[
//           Main_sidebar(),
//           Expanded(
//               child: Container(
//             color: Color.fromARGB(82, 158, 158, 158).withOpacity(0.15),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
//                   height: 50,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       AnimatedOpacity(
//                         // ignore: sort_child_properties_last
//                         child: Tooltip(
//                           message: 'Open',
//                           waitDuration: Duration(milliseconds: 300),
//                           child: IconButton(
//                               constraints: BoxConstraints(),
//                               onPressed: () {
//                                 _bar.bar_open();
//                               },
//                               icon: Icon(
//                                 Icons.menu,
//                               )),
//                         ),
//                         opacity: _bar.triger ? 1.0 : 0.0,
//                         duration: _bar.triger
//                             ? Duration(milliseconds: 500)
//                             : Duration(milliseconds: 100),
//                       ),
//                       Container(
//                         child: Row(
//                           children: [
//                             PDF_btn(),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             ElevatedButton(
//                               onPressed: () {},
//                               child: Text(
//                                 'REF',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                   elevation: 0,
//                                   backgroundColor: Colors.white.withOpacity(0),
//                                   padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
//                                   shape: RoundedRectangleBorder(
//                                       side: BorderSide(color: Colors.black),
//                                       borderRadius: BorderRadius.circular(10))),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ))
//         ],
//       ),
//     ));
//   }
// }
